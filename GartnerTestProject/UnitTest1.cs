using Microsoft.VisualStudio.TestPlatform.TestHost;
using GartnerCodingQuestion;

namespace GartnerTestProject
{
	[TestClass]
	public class UnitTest1
	{
		[TestMethod]
	
		public void Main_InvalidInputFormat_ShouldDisplayErrorMessage()
		{
			// Arrange
			string input = "impo capterra capterra.yaml";
			string expectedOutput = "Enter the provider and file path (e.g., capterra feed-products/capterra.yaml):\r\nInvalid input format. Input must start with 'import'.";

			// Act
			using (StringWriter sw = new StringWriter())
			{
				Console.SetOut(sw);
				Console.SetIn(new StringReader(input));
                GartnerCodingQuestion.Program.Main(null);
				string output = sw.GetStringBuilder().ToString().Trim();

				// Assert
				Assert.AreEqual(expectedOutput, output);
			}
		}

		[TestMethod]

		public void Main_InvalidExtension_ShouldDisplayErrorMessage()
		{
			// Arrange
			string input = "import capterra capterra.csv";
			string expectedOutput = "Enter the provider and file path (e.g., capterra feed-products/capterra.yaml):\r\nInvalid file extension. Only YAML (.yaml) and JSON (.json) files are supported.";

			// Act
			using (StringWriter sw = new StringWriter())
			{
				Console.SetOut(sw);
				Console.SetIn(new StringReader(input));
				GartnerCodingQuestion.Program.Main(null);
				string output = sw.GetStringBuilder().ToString().Trim();

				// Assert
				Assert.AreEqual(expectedOutput, output);
			}
		}
	}
}