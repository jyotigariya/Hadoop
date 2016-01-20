import java.net.URI;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileStatus;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.FileUtil;
import org.apache.hadoop.fs.Path;

public class FileSystemCat {
	public static void main(String[] args) throws Exception {
		String uri = args[0];
		Configuration conf = new Configuration();
		FileSystem fs = FileSystem.get(conf);

		try {

			FileStatus[] listStatus = fs.listStatus(new Path(uri));
			
			Path[] listedPaths = FileUtil.stat2Paths(listStatus);
			for (Path p : listedPaths) {
				System.out.println("f =" + p);
			}

		} finally {
			// IOUtils.closeStream(in);
		}
	}
}