/**
 * 텍스트 파일을 가져와서 중복라인을 제거하고 
 * 2차원 배열에 들어있는 목록들을 하나하나 replace 한다. 
 * @author khpark
 *
 */
class FileRefine {

	static main(args) {
		
		//String filename = "C:/Users/khpark/TEST/test.txt";
		String filename = args[0];
		
		BufferedReader reader = new BufferedReader(new FileReader(filename));
		Set<String> lines = new HashSet<String>(10000); // maybe should be bigger
		String line;
		while ((line = reader.readLine()) != null) {
			lines.add(line);
		}
		reader.close();
		
		List<String> al = new ArrayList<>();
		al.addAll(lines);
		
		Collections.sort(al);
		
		BufferedWriter writer = new BufferedWriter(new FileWriter(args[1]));
		for (String unique : al) {
			
			if(unique.indexOf(".properties") > 0){
				continue
			}
			if(unique.indexOf("ha-jdbc-mycluster") > 0){
				continue
			}
			unique = unique.replace(".java", ".class");
			unique = unique.replace("/si/pipc/pipc/trunk/src/main/java/", "WEB-INF/classes/");
			unique = unique.replace("/si/pipc/pipc/trunk/src/main/resources/", "WEB-INF/classes/");
			unique = unique.replace("/si/pipc/pipc/trunk/src/main/webapp/", "");
			
			writer.write(unique);
			writer.newLine();
		}
		writer.close();
		
	}

}
