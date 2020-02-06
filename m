Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567FCC352A3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 23:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E41218AC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 23:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgBFXo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 18:44:26 -0500
Received: from [65.157.77.67] ([65.157.77.67]:58179 "HELO ubuntu.localdomain"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with SMTP
        id S1726502AbgBFXo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 18:44:26 -0500
Received: by ubuntu.localdomain (Postfix, from userid 1000)
        id 7F8AA464DC7; Thu,  6 Feb 2020 16:44:23 -0700 (MST)
From:   Mike Jones <michael-a1.jones@analog.com>
To:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux@roeck-us.net, jdelvare@suse.com, robh+dt@kernel.org,
        corbet@lwn.net, Mike Jones <michael-a1.jones@analog.com>
Subject: [PATCH 1/2] hwmon: (pmbus/ltc2978): add support for more parts.
Date:   Thu,  6 Feb 2020 16:44:13 -0700
Message-Id: <1581032654-4330-1-git-send-email-michael-a1.jones@analog.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LTC2972, LTC2979, LTC3884, LTC3889, LTC7880, LTM4664, LTM4677,
LTM4678, LTM4680, LTM4700.

Signed-off-by: Mike Jones <michael-a1.jones@analog.com>
---
 Documentation/hwmon/ltc2978.rst | 164 +++++++++++++++++++++++++++++++---------
 drivers/hwmon/pmbus/Kconfig     |  11 +--
 drivers/hwmon/pmbus/ltc2978.c   |  92 ++++++++++++++++++++--
 3 files changed, 220 insertions(+), 47 deletions(-)

diff --git a/Documentation/hwmon/ltc2978.rst b/Documentation/hwmon/ltc2978.rst
index 42fd841..58838d4 100644
--- a/Documentation/hwmon/ltc2978.rst
+++ b/Documentation/hwmon/ltc2978.rst
@@ -3,6 +3,14 @@ Kernel driver ltc2978
 
 Supported chips:
 
+  * Linear Technology LTC2972
+
+    Prefix: 'ltc2972'
+
+    Addresses scanned: -
+
+    Datasheet: https://www.analog.com/en/products/ltc2972.html
+
   * Linear Technology LTC2974
 
     Prefix: 'ltc2974'
@@ -37,6 +45,14 @@ Supported chips:
 
 	       https://www.analog.com/en/products/ltc2978a
 
+  * Linear Technology LTC2979
+
+    Prefix: 'ltc2979'
+
+    Addresses scanned: -
+
+    Datasheet: https://www.analog.com/en/products/ltc2979
+
   * Linear Technology LTC2980
 
     Prefix: 'ltc2980'
@@ -69,6 +85,14 @@ Supported chips:
 
     Datasheet: https://www.analog.com/en/products/ltc3883
 
+  * Linear Technology LTC3884
+
+    Prefix: 'ltc3884'
+
+    Addresses scanned: -
+
+    Datasheet: https://www.analog.com/en/products/ltc3884
+
   * Linear Technology LTC3886
 
     Prefix: 'ltc3886'
@@ -85,6 +109,22 @@ Supported chips:
 
     Datasheet: https://www.analog.com/en/products/ltc3887
 
+  * Linear Technology LTC3889
+
+    Prefix: 'ltc3889'
+
+    Addresses scanned: -
+
+    Datasheet: https://www.analog.com/en/products/ltc3889
+
+  * Linear Technology LTC7880
+
+    Prefix: 'ltc7880'
+
+    Addresses scanned: -
+
+    Datasheet: https://www.analog.com/en/products/ltc7880
+
   * Linear Technology LTM2987
 
     Prefix: 'ltm2987'
@@ -93,7 +133,15 @@ Supported chips:
 
     Datasheet: https://www.analog.com/en/products/ltm2987
 
-  * Linear Technology LTM4675
+  * Linear Technology LTM4644
+
+    Prefix: 'ltm4644'
+
+    Addresses scanned: -
+
+    Datasheet: https://www.analog.com/en/products/ltm4644
+
+   * Linear Technology LTM4675
 
     Prefix: 'ltm4675'
 
@@ -109,6 +157,30 @@ Supported chips:
 
     Datasheet: https://www.analog.com/en/products/ltm4676
 
+  * Linear Technology LTM4677
+
+    Prefix: 'ltm4677'
+
+    Addresses scanned: -
+
+    Datasheet: https://www.analog.com/en/products/ltm4677
+
+  * Linear Technology LTM4678
+
+    Prefix: 'ltm4678'
+
+    Addresses scanned: -
+
+    Datasheet: https://www.analog.com/en/products/ltm4678
+
+  * Analog Devices LTM4680
+
+    Prefix: 'ltm4680'
+
+    Addresses scanned: -
+
+    Datasheet: http://www.analog.com/ltm4680
+
   * Analog Devices LTM4686
 
     Prefix: 'ltm4686'
@@ -117,6 +189,15 @@ Supported chips:
 
     Datasheet: http://www.analog.com/ltm4686
 
+  * Analog Devices LTM4700
+
+    Prefix: 'ltm4700'
+
+    Addresses scanned: -
+
+    Datasheet: http://www.analog.com/ltm4700
+
+
 
 Author: Guenter Roeck <linux@roeck-us.net>
 
@@ -166,13 +247,13 @@ in1_min			Minimum input voltage.
 
 in1_max			Maximum input voltage.
 
-			LTC2974, LTC2975, LTC2977, LTC2980, LTC2978, and
-			LTM2987 only.
+			LTC2974, LTC2975, LTC2977, LTC2980, LTC2978,
+      LTC2979 and LTM2987 only.
 
 in1_lcrit		Critical minimum input voltage.
 
-			LTC2974, LTC2975, LTC2977, LTC2980, LTC2978, and
-			LTM2987 only.
+			LTC2972, LTC2974, LTC2975, LTC2977, LTC2980, LTC2978,
+      LTC2979 and LTM2987 only.
 
 in1_crit		Critical maximum input voltage.
 
@@ -180,17 +261,17 @@ in1_min_alarm		Input voltage low alarm.
 
 in1_max_alarm		Input voltage high alarm.
 
-			LTC2974, LTC2975, LTC2977, LTC2980, LTC2978, and
-			LTM2987 only.
+			LTC2972, LTC2974, LTC2975, LTC2977, LTC2980, LTC2978,
+      LTC2979 and LTM2987 only.
 in1_lcrit_alarm		Input voltage critical low alarm.
 
-			LTC2974, LTC2975, LTC2977, LTC2980, LTC2978, and
-			LTM2987 only.
+			LTC2972, LTC2974, LTC2975, LTC2977, LTC2980, LTC2978,
+      LTC2979 and LTM2987 only.
 in1_crit_alarm		Input voltage critical high alarm.
 
 in1_lowest		Lowest input voltage.
 
-			LTC2974, LTC2975, LTC2977, LTC2980, LTC2978, and
+			LTC2972, LTC2974, LTC2975, LTC2977, LTC2980, LTC2978, and
 			LTM2987 only.
 in1_highest		Highest input voltage.
 
@@ -198,11 +279,13 @@ in1_reset_history	Reset input voltage history.
 
 in[N]_label		"vout[1-8]".
 
+      - LTC2972: N=2-3
 			- LTC2974, LTC2975: N=2-5
-			- LTC2977, LTC2980, LTM2987: N=2-9
+			- LTC2977, LTC2979, LTC2980, LTM2987: N=2-9
 			- LTC2978: N=2-9
-			- LTC3880, LTC3882, LTC23886 LTC3887, LTM4675, LTM4676:
-			  N=2-3
+			- LTC3880, LTC3882, LTC3884, LTC23886 LTC3887, LTC3889,
+        LTC7880, LTM4644, LTM4675, LTM4676, LTM4677, LTM4678,
+        LTM4680, LTM4700: N=2-3
 			- LTC3883: N=2
 
 in[N]_input		Measured output voltage.
@@ -226,7 +309,7 @@ in[N]_crit_alarm	Output voltage critical high alarm.
 in[N]_lowest		Lowest output voltage.
 
 
-			LTC2974, LTC2975,and LTC2978 only.
+			LTC2972, LTC2974, LTC2975,and LTC2978 only.
 
 in[N]_highest		Highest output voltage.
 
@@ -234,20 +317,24 @@ in[N]_reset_history	Reset output voltage history.
 
 temp[N]_input		Measured temperature.
 
+      - On LTC2972, temp[1-2] report external temperatures,
+        and temp 3 reports the chip temperature.
 			- On LTC2974 and LTC2975, temp[1-4] report external
 			  temperatures, and temp5 reports the chip temperature.
-			- On LTC2977, LTC2980, LTC2978, and LTM2987, only one
-			  temperature measurement is supported and reports
-			  the chip temperature.
-			- On LTC3880, LTC3882, LTC3887, LTM4675, and LTM4676,
-			  temp1 and temp2 report external temperatures, and
-			  temp3 reports the chip temperature.
+			- On LTC2977, LTC2979, LTC2980, LTC2978, and LTM2987,
+        only one temperature measurement is supported and
+        reports the chip temperature.
+			- On LTC3880, LTC3882, LTC3886, LTC3887, LTC3889,
+        LTM4664, LTM4675, LTM4676, LTM4677, LTM4678, LTM4680,
+        and LTM4700, temp1 and temp2 report external
+        temperatures, and temp3 reports the chip temperature.
 			- On LTC3883, temp1 reports an external temperature,
 			  and temp2 reports the chip temperature.
 
 temp[N]_min		Mimimum temperature.
 
-			LTC2974, LCT2977, LTM2980, LTC2978, and LTM2987 only.
+			LTC2972, LTC2974, LCT2977, LTM2980, LTC2978,
+      LTC2979, and LTM2987 only.
 
 temp[N]_max		Maximum temperature.
 
@@ -257,8 +344,8 @@ temp[N]_crit		Critical high temperature.
 
 temp[N]_min_alarm	Temperature low alarm.
 
-			LTC2974, LTC2975, LTC2977, LTM2980, LTC2978, and
-			LTM2987 only.
+			LTC2972, LTC2974, LTC2975, LTC2977, LTM2980, LTC2978,
+      LTC2979, and LTM2987 only.
 
 temp[N]_max_alarm	Temperature high alarm.
 
@@ -269,8 +356,8 @@ temp[N]_crit_alarm	Temperature critical high alarm.
 
 temp[N]_lowest		Lowest measured temperature.
 
-			- LTC2974, LTC2975, LTC2977, LTM2980, LTC2978, and
-			  LTM2987 only.
+			- LTC2972, LTC2974, LTC2975, LTC2977, LTM2980, LTC2978,
+        LTC2979, and LTM2987 only.
 			- Not supported for chip temperature sensor on LTC2974
 			  and LTC2975.
 
@@ -290,19 +377,22 @@ power1_input		Measured input power.
 
 power[N]_label		"pout[1-4]".
 
+      - LTC2972: N=1-2
 			- LTC2974, LTC2975: N=1-4
-			- LTC2977, LTC2980, LTM2987: Not supported
+			- LTC2977, LTC2979, LTC2980, LTM2987: Not supported
 			- LTC2978: Not supported
-			- LTC3880, LTC3882, LTC3886, LTC3887, LTM4675, LTM4676:
-			  N=1-2
+			- LTC3880, LTC3882, LTC3884, LTC3886, LTC3887, LTC3889,
+        LTM4664, LTM4675, LTM4676, LTM4677, LTM4678, LTM4680,
+        LTM4700: N=1-2
 			- LTC3883: N=2
 
 power[N]_input		Measured output power.
 
 curr1_label		"iin".
 
-			LTC3880, LTC3883, LTC3886, LTC3887, LTM4675,
-			and LTM4676 only.
+			LTC3880, LTC3883, LTC3884, LTC3886, LTC3887, LTC3889,
+      LTM4644, LTM4675, LTM4676, LTM4677, LTM4678, LTM4680,
+      and LTM4700 only.
 
 curr1_input		Measured input current.
 
@@ -320,11 +410,13 @@ curr1_reset_history	Reset input current history.
 
 curr[N]_label		"iout[1-4]".
 
+      - LTC2972: N-1-2
 			- LTC2974, LTC2975: N=1-4
-			- LTC2977, LTC2980, LTM2987: not supported
+			- LTC2977, LTC2979, LTC2980, LTM2987: not supported
 			- LTC2978: not supported
-			- LTC3880, LTC3882, LTC3886, LTC3887, LTM4675, LTM4676:
-			  N=2-3
+			- LTC3880, LTC3882, LTC3884, LTC3886, LTC3887, LTC3889,
+        LTM4664, LTM4675, LTM4676, LTM4677, LTM4678, LTM4680,
+        LTM4700: N=2-3
 			- LTC3883: N=2
 
 curr[N]_input		Measured output current.
@@ -335,7 +427,7 @@ curr[N]_crit		Critical high output current.
 
 curr[N]_lcrit		Critical low output current.
 
-			LTC2974 and LTC2975 only.
+			LTC2972, LTC2974 and LTC2975 only.
 
 curr[N]_max_alarm	Output current high alarm.
 
@@ -343,11 +435,11 @@ curr[N]_crit_alarm	Output current critical high alarm.
 
 curr[N]_lcrit_alarm	Output current critical low alarm.
 
-			LTC2974 and LTC2975 only.
+			LTC2972, LTC2974 and LTC2975 only.
 
 curr[N]_lowest		Lowest output current.
 
-			LTC2974 and LTC2975 only.
+			LTC2972, LTC2974 and LTC2975 only.
 
 curr[N]_highest		Highest output current.
 
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 5985997..92f26f3 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -113,8 +113,8 @@ config SENSORS_LTC2978
 	tristate "Linear Technologies LTC2978 and compatibles"
 	help
 	  If you say yes here you get hardware monitoring support for Linear
-	  Technology LTC2974, LTC2975, LTC2977, LTC2978, LTC2980, LTC3880,
-	  LTC3883, LTC3886, LTC3887, LTCM2987, LTM4675, and LTM4676.
+	  Technology LTC2972, LTC2974, LTC2975, LTC2977, LTC2978, LTC2979,
+	  LTC2980, and LTM2987.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called ltc2978.
@@ -123,9 +123,10 @@ config SENSORS_LTC2978_REGULATOR
 	bool "Regulator support for LTC2978 and compatibles"
 	depends on SENSORS_LTC2978 && REGULATOR
 	help
-	  If you say yes here you get regulator support for Linear
-	  Technology LTC2974, LTC2977, LTC2978, LTC3880, LTC3883, LTM4676
-	  and LTM4686.
+	  If you say yes here you get regulator support for Linear Technology
+	  LTC3880, LTC3883, LTC3884, LTC3886, LTC3887, LTC3889, LTC7880, 
+	  LTM4644, LTM4675, LTM4676, LTM4677, LTM4678, LTM4680, LTM4686, 
+	  and LTM4700.
 
 config SENSORS_LTC3815
 	tristate "Linear Technologies LTC3815"
diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
index a91ed01..8f619d0 100644
--- a/drivers/hwmon/pmbus/ltc2978.c
+++ b/drivers/hwmon/pmbus/ltc2978.c
@@ -19,8 +19,10 @@
 #include <linux/regulator/driver.h>
 #include "pmbus.h"
 
-enum chips { ltc2974, ltc2975, ltc2977, ltc2978, ltc2980, ltc3880, ltc3882,
-	ltc3883, ltc3886, ltc3887, ltm2987, ltm4675, ltm4676, ltm4686 };
+enum chips { ltc2972, ltc2974, ltc2975, ltc2977, ltc2978, ltc2979, ltc2980, /* Managers */
+	ltc3880, ltc3882, ltc3883, ltc3884, ltc3886, ltc3887, ltc3889, ltc7880, /* Controllers */
+	ltm2987, ltm4664, ltm4675, ltm4676, ltm4677, ltm4678, ltm4680, ltm4686, ltm4700 /* Modules */
+};
 
 /* Common for all chips */
 #define LTC2978_MFR_VOUT_PEAK		0xdd
@@ -43,9 +45,10 @@ enum chips { ltc2974, ltc2975, ltc2977, ltc2978, ltc2980, ltc3880, ltc3882,
 #define LTC3880_MFR_CLEAR_PEAKS		0xe3
 #define LTC3880_MFR_TEMPERATURE2_PEAK	0xf4
 
-/* LTC3883 and LTC3886 only */
+/* LTC3883, LTC3884, LTC3886, LTC3889 and LTC7880 only */
 #define LTC3883_MFR_IIN_PEAK		0xe1
 
+
 /* LTC2975 only */
 #define LTC2975_MFR_IIN_PEAK		0xc4
 #define LTC2975_MFR_IIN_MIN		0xc5
@@ -54,27 +57,41 @@ enum chips { ltc2974, ltc2975, ltc2977, ltc2978, ltc2980, ltc3880, ltc3882,
 
 #define LTC2978_ID_MASK			0xfff0
 
+#define LTC2972_ID			0x0310
 #define LTC2974_ID			0x0210
 #define LTC2975_ID			0x0220
 #define LTC2977_ID			0x0130
 #define LTC2978_ID_REV1			0x0110	/* Early revision */
 #define LTC2978_ID_REV2			0x0120
+#define LTC2979_ID_A			0x8060
+#define LTC2979_ID_B			0x8070
 #define LTC2980_ID_A			0x8030	/* A/B for two die IDs */
 #define LTC2980_ID_B			0x8040
 #define LTC3880_ID			0x4020
 #define LTC3882_ID			0x4200
 #define LTC3882_ID_D1			0x4240	/* Dash 1 */
 #define LTC3883_ID			0x4300
+#define LTC3884_ID			0x4C00
 #define LTC3886_ID			0x4600
 #define LTC3887_ID			0x4700
 #define LTM2987_ID_A			0x8010	/* A/B for two die IDs */
 #define LTM2987_ID_B			0x8020
+#define LTC3889_ID			0x4900
+#define LTC7880_ID			0x49E0
+#define LTM4664_ID			0x4120
 #define LTM4675_ID			0x47a0
 #define LTM4676_ID_REV1			0x4400
 #define LTM4676_ID_REV2			0x4480
 #define LTM4676A_ID			0x47e0
+#define LTM4677_ID_REV1			0x47B0
+#define LTM4677_ID_REV2			0x47D0
+#define LTM4678_ID_REV1			0x4100
+#define LTM4678_ID_REV2			0x4110
+#define LTM4680_ID			0x4140
 #define LTM4686_ID			0x4770
+#define LTM4700_ID			0x4130
 
+#define LTC2972_NUM_PAGES		2
 #define LTC2974_NUM_PAGES		4
 #define LTC2978_NUM_PAGES		8
 #define LTC3880_NUM_PAGES		2
@@ -492,20 +509,30 @@ static int ltc2978_write_word_data(struct i2c_client *client, int page,
 }
 
 static const struct i2c_device_id ltc2978_id[] = {
+	{"ltc2972", ltc2972},
 	{"ltc2974", ltc2974},
 	{"ltc2975", ltc2975},
 	{"ltc2977", ltc2977},
 	{"ltc2978", ltc2978},
+	{"ltc2979", ltc2979},
 	{"ltc2980", ltc2980},
 	{"ltc3880", ltc3880},
 	{"ltc3882", ltc3882},
 	{"ltc3883", ltc3883},
+	{"ltc3884", ltc3884},
 	{"ltc3886", ltc3886},
 	{"ltc3887", ltc3887},
+	{"ltc3889", ltc3889},
+	{"ltc7880", ltc7880},
 	{"ltm2987", ltm2987},
+	{"ltm4664", ltm4664},
 	{"ltm4675", ltm4675},
 	{"ltm4676", ltm4676},
+	{"ltm4677", ltm4677},
+	{"ltm4678", ltm4678},
+	{"ltm4680", ltm4680},
 	{"ltm4686", ltm4686},
+	{"ltm4700", ltm4700},
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, ltc2978_id);
@@ -555,7 +582,9 @@ static int ltc2978_get_id(struct i2c_client *client)
 
 	chip_id &= LTC2978_ID_MASK;
 
-	if (chip_id == LTC2974_ID)
+	if (chip_id == LTC2972_ID)
+		return ltc2972;
+	else if (chip_id == LTC2974_ID)
 		return ltc2974;
 	else if (chip_id == LTC2975_ID)
 		return ltc2975;
@@ -563,6 +592,8 @@ static int ltc2978_get_id(struct i2c_client *client)
 		return ltc2977;
 	else if (chip_id == LTC2978_ID_REV1 || chip_id == LTC2978_ID_REV2)
 		return ltc2978;
+	else if (chip_id == LTC2979_ID_A || chip_id == LTC2979_ID_B)
+		return ltc2979;
 	else if (chip_id == LTC2980_ID_A || chip_id == LTC2980_ID_B)
 		return ltc2980;
 	else if (chip_id == LTC3880_ID)
@@ -571,19 +602,34 @@ static int ltc2978_get_id(struct i2c_client *client)
 		return ltc3882;
 	else if (chip_id == LTC3883_ID)
 		return ltc3883;
+	else if (chip_id == LTC3884_ID)
+		return ltc3884;
 	else if (chip_id == LTC3886_ID)
 		return ltc3886;
 	else if (chip_id == LTC3887_ID)
 		return ltc3887;
+	else if (chip_id == LTC3889_ID)
+		return ltc3889;
+	else if (chip_id == LTC7880_ID)
+		return ltc7880;
 	else if (chip_id == LTM2987_ID_A || chip_id == LTM2987_ID_B)
 		return ltm2987;
+	else if (chip_id == LTM4664_ID)
+		return ltm4664;
 	else if (chip_id == LTM4675_ID)
 		return ltm4675;
-	else if (chip_id == LTM4676_ID_REV1 || chip_id == LTM4676_ID_REV2 ||
-		 chip_id == LTM4676A_ID)
+	else if (chip_id == LTM4676_ID_REV1 || chip_id == LTM4676_ID_REV2 || chip_id == LTM4676A_ID)
 		return ltm4676;
+	else if (chip_id == LTM4677_ID_REV1 || chip_id == LTM4677_ID_REV2)
+		return ltm4677;
+	else if (chip_id == LTM4678_ID_REV1 || chip_id == LTM4678_ID_REV2)
+		return ltm4678;
+	else if (chip_id == LTM4680_ID)
+		return ltm4680;
 	else if (chip_id == LTM4686_ID)
 		return ltm4686;
+	else if (chip_id == LTM4700_ID)
+		return ltm4700;
 
 	dev_err(&client->dev, "Unsupported chip ID 0x%x\n", chip_id);
 	return -ENODEV;
@@ -637,6 +683,19 @@ static int ltc2978_probe(struct i2c_client *client,
 	data->temp2_max = 0x7c00;
 
 	switch (data->id) {
+	case ltc2972:
+		info->read_word_data = ltc2975_read_word_data;
+		info->pages = LTC2972_NUM_PAGES;
+		info->func[0] = PMBUS_HAVE_IIN | PMBUS_HAVE_PIN
+		  | PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
+		  | PMBUS_HAVE_TEMP2;
+		for (i = 0; i < info->pages; i++) {
+			info->func[i] |= PMBUS_HAVE_VOUT
+			  | PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_POUT
+			  | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
+			  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT;
+		}
+		break;	
 	case ltc2974:
 		info->read_word_data = ltc2974_read_word_data;
 		info->pages = LTC2974_NUM_PAGES;
@@ -662,8 +721,10 @@ static int ltc2978_probe(struct i2c_client *client,
 			  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT;
 		}
 		break;
+
 	case ltc2977:
 	case ltc2978:
+	case ltc2979:
 	case ltc2980:
 	case ltm2987:
 		info->read_word_data = ltc2978_read_word_data;
@@ -680,6 +741,7 @@ static int ltc2978_probe(struct i2c_client *client,
 	case ltc3887:
 	case ltm4675:
 	case ltm4676:
+	case ltm4677:
 	case ltm4686:
 		data->features |= FEAT_CLEAR_PEAKS | FEAT_NEEDS_POLLING;
 		info->read_word_data = ltc3880_read_word_data;
@@ -721,7 +783,14 @@ static int ltc2978_probe(struct i2c_client *client,
 		  | PMBUS_HAVE_PIN | PMBUS_HAVE_POUT | PMBUS_HAVE_TEMP
 		  | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_STATUS_TEMP;
 		break;
+	case ltc3884:
 	case ltc3886:
+	case ltc3889:
+	case ltc7880:
+	case ltm4664:
+	case ltm4678:
+	case ltm4680:
+	case ltm4700:
 		data->features |= FEAT_CLEAR_PEAKS | FEAT_NEEDS_POLLING;
 		info->read_word_data = ltc3883_read_word_data;
 		info->pages = LTC3880_NUM_PAGES;
@@ -752,22 +821,33 @@ static int ltc2978_probe(struct i2c_client *client,
 	return pmbus_do_probe(client, id, info);
 }
 
+
 #ifdef CONFIG_OF
 static const struct of_device_id ltc2978_of_match[] = {
+	{ .compatible = "lltc,ltc2972" },
 	{ .compatible = "lltc,ltc2974" },
 	{ .compatible = "lltc,ltc2975" },
 	{ .compatible = "lltc,ltc2977" },
 	{ .compatible = "lltc,ltc2978" },
+	{ .compatible = "lltc,ltc2979" },
 	{ .compatible = "lltc,ltc2980" },
 	{ .compatible = "lltc,ltc3880" },
 	{ .compatible = "lltc,ltc3882" },
 	{ .compatible = "lltc,ltc3883" },
+	{ .compatible = "lltc,ltc3884" },
 	{ .compatible = "lltc,ltc3886" },
 	{ .compatible = "lltc,ltc3887" },
+	{ .compatible = "lltc,ltc3889" },
+	{ .compatible = "lltc,ltc7880" },
 	{ .compatible = "lltc,ltm2987" },
+	{ .compatible = "lltc,ltm4664" },
 	{ .compatible = "lltc,ltm4675" },
 	{ .compatible = "lltc,ltm4676" },
+	{ .compatible = "lltc,ltm4677" },
+	{ .compatible = "lltc,ltm4678" },
+	{ .compatible = "lltc,ltm4680" },
 	{ .compatible = "lltc,ltm4686" },
+	{ .compatible = "lltc,ltm4700" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ltc2978_of_match);
-- 
2.7.4

