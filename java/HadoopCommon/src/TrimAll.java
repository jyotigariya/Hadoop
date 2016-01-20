
import org.apache.pig.EvalFunc;
import org.apache.pig.backend.executionengine.ExecException;
import org.apache.pig.data.Tuple;

public class TrimAll extends EvalFunc<Tuple> {

	public Tuple exec(Tuple input) throws ExecException {
		if (input != null) {

			iterateTupleAndTrim(input);
		}

		return input;
	}

	public void iterateTupleAndTrim(Tuple inputTuple) throws ExecException {
		for (int index = 0; index < inputTuple.size(); index++) {
			Object object = inputTuple.get(index);
			if (object != null && object instanceof String) {
				inputTuple.set(index, ((String) object).trim());
			}

		}

	}

}
