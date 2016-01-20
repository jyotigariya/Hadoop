
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

import org.apache.pig.EvalFunc;
import org.apache.pig.backend.executionengine.ExecException;
import org.apache.pig.data.Tuple;
import org.apache.pig.data.TupleFactory;

public class TimeZoneConverterUDF extends EvalFunc<String> {

	public String exec(Tuple input) throws ExecException {

		String timeValue = (String) input.get(0);
		String format = (String) input.get(1);
		String sourceTimeZone = (String) input.get(2);
		String targetTimeZone = (String) input.get(3);

		if (timeValue == null || timeValue.equals("")) {
			return timeValue;
		} else {

			SimpleDateFormat sdf = new SimpleDateFormat(format, Locale.ENGLISH);
			sdf.setTimeZone(TimeZone.getTimeZone(sourceTimeZone));

			Date parseDate;
			String formatOutputTime = null;
			try {
				parseDate = sdf.parse(timeValue);
				sdf.setTimeZone(TimeZone.getTimeZone(targetTimeZone));

				formatOutputTime = sdf.format(parseDate);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			return formatOutputTime;

		}

	}

	public static void main(String ar[]) throws Exception {

		test("201505010110", "yyyyMMddHHmm", "GMT", "PST");
		test("201505010110", "yyyyMMddHHmm", "GMT", "MST");
		test("201505010110", "yyyyMMddHHmm", "GMT", "CST");

	}

	public static String test(String arg1, String arg2, String arg3, String arg4) throws Exception {
		TupleFactory tf = TupleFactory.getInstance();
		Tuple newTuple = tf.newTuple(4);

		newTuple.set(0, arg1);
		newTuple.set(1, arg2);
		newTuple.set(2, arg3);
		newTuple.set(3, arg4);

		TimeZoneConverterUDF tz = new TimeZoneConverterUDF();

		System.out.println(tz.exec(newTuple));

		return null;

	}

}
