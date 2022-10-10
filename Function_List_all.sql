# 1. MySQL Math Functions ####################################################################################

/*
Name			Description

ABS()			: Returns the absolute value of a number
CEIL()			: Returns the smallest integer value greater than or equal to the input number (n).
FLOOR()			: Returns the largest integer value not greater than the argument
MOD()			: Returns the remainder of a number divided by another
ROUND()			: Rounds a number to a specified number of decimal places.
TRUNCATE()		: Truncates a number to a specified number of decimal places
ACOS(n)			: Returns the arc cosine of n or null if n is not in the range -1 and 1.
ASIN(n)			: Returns the arcsine of n which is the value whose sine is n. It returns null if n is not in the range -1 to 1.
ATAN()			: Returns the arctangent of n.
COS(n)			: Returns the cosine of n, where n is in radians
COT(n)			: Returns the cotangent of n.
CRC32()			: Computes a cyclic redundancy check value and returns a 32-bit unsigned value
DEGREES(n)		: Converts radians to degrees of the argument n
EXP(n)			: Raises to the power of e raised to the power of n
LN(n)			: Returns the natural logarithm of n
LOG(n)			: Returns the natural logarithm of the first argument
LOG10()			: Returns the base-10 logarithm of the argument
LOG2()			: Returns the base-2 logarithm of the argument
PI()			: Returns the value of PI
POW()			: Returns the argument raised to the specified power
POWER()			: Returns the argument raised to the specified power
RADIANS()		: Returns argument converted to radians
RAND()			: Returns a random floating-point value
SIGN(n)			: Returns the sign of n that can be -1, 0, or 1 depending on whether n is negative, zero, or positive.
SIN(n)			: Returns the sine of n
SQRT(n)			: Returns the square root of n
TAN(n)			: Returns the tangent of n
ATAN2(n,m), 	: ATAN(m,n)	Returns the arctangent of the two variables n and m
CONV(n,from_base,to_base)	: Converts a number between different number bases
*/

# 2. MySQL String Functions ####################################################################################

/*
Name			Description
CONCAT			: Concatenate two or more strings into a single string
INSTR			: Return the position of the first occurrence of a substring in a string
LENGTH			: Get the length of a string in bytes and in characters
LEFT			: Get a specified number of leftmost characters from a string
LOWER			: Convert a string to lowercase
LTRIM			: Remove all leading spaces from a string
REPLACE			: Search and replace a substring in a string
RIGHT			: Get a specified number of rightmost characters from a string
RTRIM			: Remove all trailing spaces from a string
SUBSTRING		: Extract a substring starting from a position with a specific length.
SUBSTRING_INDEX	: Return a substring from a string before a specified number of occurrences of a delimiter
TRIM			: Remove unwanted characters from a string.
FIND_IN_SET		: Find a string within a comma-separated list of strings
FORMAT			: Format a number with a specific locale, rounded to the number of decimals
UPPER			: Convert a string to uppercase
*/

# 3. MySQL Date Functions ####################################################################################

/*

Function	  	Description
CURDATE			: Returns the current date.
DATEDIFF		: Calculates the number of days between two DATE values.
DAY				: Gets the day of the month of a specified date.
DATE_ADD		: Adds a time value to date value.
DATE_SUB		: Subtracts a time value from a date value.
DATE_FORMAT		: Formats a date value based on a specified date format.
DAYNAME			: Gets the name of a weekday for a specified date.
DAYOFWEEK		: Returns the weekday index for a date.
EXTRACT			: Extracts a part of a date.
LAST_DAY		: Returns the last day of the month of a specified date
NOW				: Returns the current date and time at which the statement executed.
MONTH			: Returns an integer that represents a month of a specified date.
STR_TO_DATE		: Converts a string into a date and time value based on a specified format.
SYSDATE			: Returns the current date.
TIMEDIFF		: Calculates the difference between two TIME or DATETIME values.
TIMESTAMPDIFF	: Calculates the difference between two DATE or DATETIME values.
WEEK			: Returns a week number of a date.
WEEKDAY			: Returns a weekday index for a date.
YEAR			: Return the year for a specified date
*/

# 4. MySQL Aggregate Functions ####################################################################################

/*
Agg function	Description
AVG()			: Return the average of non-NULL values.
BIT_AND()		: Return bitwise AND.
BIT_OR()		: Return bitwise OR.
BIT_XOR()		: Return bitwise XOR.
COUNT()			: Return the number of rows in a group, including rows with NULL values.
GROUP_CONCAT()	: Return a concatenated string.
MAX()			: Return the highest value (maximum) in a set of non-NULL values.
MIN()			: Return the lowest value (minimum) in a set of non-NULL values.
STDEV()			: Return the population standard deviation.
STDDEV_POP()	: Return the population standard deviation.
STDDEV_SAMP()	: Return the sample standard deviation.
SUM()			: Return the summation of all non-NULL values a set.
VAR_POP()		: Return the population standard variance.
VARP_SAM()		: Return the sample variance.
VARIANCE()		: Return the population standard variance.
JSON_ARRAYAGG()	: Return result set as a single JSON array.
JSON_OBJECTAGG(): Return result set as a single JSON object.
*/

# 5. MySQL Window Function list #############################################################

/*
Name	    	Description

CUME_DIST		: Calculates the cumulative distribution of a value in a set of values.
DENSE_RANK		: Assigns a rank to every row within its partition based on the ORDER BY clause. It assigns the same rank to the rows with equal values. If two or more rows have the same rank, then there will be no gaps in the sequence of ranked values.
FIRST_VALUE		: Returns the value of the specified expression with respect to the first row in the window frame.
LAG	Returns 	: the value of the Nth row before the current row in a partition. It returns NULL if no preceding row exists.
LAST_VALUE		: Returns the value of the specified expression with respect to the last row in the window frame.
LEAD			: Returns the value of the Nth row after the current row in a partition. It returns NULL if no subsequent row exists.
NTH_VALUE		: Returns value of argument from Nth row of the window frame
NTILE			: Distributes the rows for each window partition into a specified number of ranked groups.
PERCENT_RANK	: Calculates the percentile rank of a row in a partition or result set
RANK			: Similar to the DENSE_RANK() function except that there are gaps in the sequence of ranked values when two or more rows have the same rank.
ROW_NUMBER		: Assigns a sequential integer to every row within its partition

*/
