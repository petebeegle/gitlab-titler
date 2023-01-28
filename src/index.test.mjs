import { handler } from "./index.mjs";

describe("lambda", () => {
	it("returns", async () => {
		const result = await handler();
		expect(result).toEqual({ statusCode: 200, body: "Hello, world!" });
	});
});
