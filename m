Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB04C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1582B24672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="oiW4ZIcn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbgANLVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 06:21:22 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:12736 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725820AbgANLVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 06:21:19 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00EBCFkY005929;
        Tue, 14 Jan 2020 06:20:30 -0500
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2057.outbound.protection.outlook.com [104.47.45.57])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xfc59f442-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jan 2020 06:20:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQsAeUZ/W7JbDxrkZQdtBvI5szDsnNevzmJgwiuScA3LGza0+UmjFPWDXzhZwkRXC+zVdI4jm5tf2AGDIIu0IOzGHHTPlgV41j92HCqfoSaffmeZ+7Eqn037f2xdRBXdS+tUJZZRs4ouXT4f5JqWQ8yE2p4tIAPYGy+3iuEKzcUPfnnEF5pYJLmABVcwLKRG+CEWlGG58dMDIpfGTwRvhYo3rE9Y9INgnH93yCt1Jnu5vRgaFafv5JspTvtpV4oye7wV0X+cf1Yw0fwtLjd9eO6UfC1r7PeNIjLmlUf66ywhqGm8AhrE+CBnDxtcXuZQ0OGRze+cxisQTsQ+pYjkSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUcN2UxNerb51F6IvC9P9/Dl6M6Ol7a7VFFlAAXlFoc=;
 b=iewjdlU435+VNgDX5R8eeqPKZIIM/Tvp9c3rjhxA/xDs9Ri3XOMQWZRyFg8g+9EOegI06jw26snxDX/tQdGwkKD/tolgdHcgbVrPR4lRwKQaWgmMysxTsqvioQPW6oMC4apuexpbp9KBk5A8p48KY3ojiuWdIqMonjVIvqwL0fr3U8DYFeE3GlILWCfOvcFaocNMsky/djJHhBrzv05KFaqjokKvJcoqxa3vvtpHhlnkm06HV77D+pVryrH87XENvUqGSfUB2S3AO1HZjsPrcn5QY0ysxx/WFuPqIKQVhCyZ3ffprF4lu8WeSWM3H00P98cAkpYawnI+X54/r59U6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUcN2UxNerb51F6IvC9P9/Dl6M6Ol7a7VFFlAAXlFoc=;
 b=oiW4ZIcnKGQmxF+jgoEnbEhTTy4dk/mwuUVeU+aTBE84iyYiFRZ6F5CuxXADkltyPkFU8KdxmEc3dKqOD4hboJ/C/Zu2MJTt6m0CpSrnL7qPOefi95X6cZJSONVZAwDADAItr2qX93t7maZrEBGIjP3ukrBgMlYsijoIjugFeCg=
Received: from CH2PR03CA0024.namprd03.prod.outlook.com (2603:10b6:610:59::34)
 by BYAPR03MB3847.namprd03.prod.outlook.com (2603:10b6:a03:6d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.11; Tue, 14 Jan
 2020 11:20:27 +0000
Received: from BL2NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by CH2PR03CA0024.outlook.office365.com
 (2603:10b6:610:59::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10 via Frontend
 Transport; Tue, 14 Jan 2020 11:20:27 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT034.mail.protection.outlook.com (10.152.77.161) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2623.9
 via Frontend Transport; Tue, 14 Jan 2020 11:20:27 +0000
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id 00EBKEGH018133
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 14 Jan 2020 03:20:15 -0800
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 14 Jan
 2020 03:20:25 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 14 Jan 2020 06:20:24 -0500
Received: from ben-Latitude-E6540.ad.analog.com ([10.48.65.231])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 00EBKJnK022085;
        Tue, 14 Jan 2020 06:20:20 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <linux-hwmon@vger.kernel.org>
CC:     <Michael.Hennerich@analog.com>, <linux-kernel@vger.kernel.org>,
        <jdelvare@suse.com>, <linux@roeck-us.net>, <mark.rutland@arm.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v4 1/3] hwmon: (adm1177) Add ADM1177 Hot Swap Controller and Digital Power Monitor driver
Date:   Tue, 14 Jan 2020 13:21:57 +0200
Message-ID: <20200114112159.25998-1-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(199004)(189003)(70586007)(1076003)(6916009)(5660300002)(44832011)(70206006)(246002)(6666004)(356004)(7636002)(2616005)(4326008)(966005)(426003)(336012)(2906002)(8936002)(36756003)(26005)(186003)(7696005)(86362001)(478600001)(8676002)(107886003)(54906003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3847;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3687ed94-51de-42fc-8346-08d798e3c1f9
X-MS-TrafficTypeDiagnostic: BYAPR03MB3847:
X-Microsoft-Antispam-PRVS: <BYAPR03MB384764C0930AE93CBBC30BE7F0340@BYAPR03MB3847.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 028256169F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cHkNji0xeGR17n5zKcB23/s4SCuxuINa3wVEehbNH3QcqaQPX+A6fgtsYNI6nr/o6LgS/kLnLDTJfYMLSDwUYmTKKD3SJO8pNig7h6kvHOJrbjRVaml2+0hk5f0fpHdLl1YmBLEfFacMVTe/HAsNBePDQ5A68Z16R9CPCwVl4/Cjo5y1Iuh2osdLl5f1ud6X+PpP+F7Rc1WMBXU3meRSWvvHYeeSdBzLmODDSDT3vPlsXAWxpX24Rrqkl3FWX6U9Pcwg4YA8KpZkO+0S/vtI4QM4NKQ5Dwj5KWt8XYbeKuIaRvxRb9hfnS4a3HgsMkmfjOO2ieJoDYxhz3lEOVyxGHqhAvabPB/Fzw1EcByFIKbo5/qCgt6rKMS38s0BcQEcrItI9bt4JEXcYWGag4QXU/30w0P2fDoFbP3A8pun0/9/Ja+Oy0jgyWMYaX8mxRus9JG0tTUhx25gHlhSk0X58DQHzuzGcQPgDVEsNc2ZIGU=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 11:20:27.5077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3687ed94-51de-42fc-8346-08d798e3c1f9
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3847
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_03:2020-01-13,2020-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001140100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADM1177 is a Hot Swap Controller and Digital Power Monitor with
Soft Start Pin.

Datasheet:
Link: https://www.analog.com/media/en/technical-documentation/data-sheets/ADM1177.pdf

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Changes in v4:
-reverse condition in adm1177_write_alert_thr fixed

 Documentation/hwmon/adm1177.rst |  36 ++++
 Documentation/hwmon/index.rst   |   1 +
 drivers/hwmon/Kconfig           |  10 ++
 drivers/hwmon/Makefile          |   1 +
 drivers/hwmon/adm1177.c         | 288 ++++++++++++++++++++++++++++++++
 5 files changed, 336 insertions(+)
 create mode 100644 Documentation/hwmon/adm1177.rst
 create mode 100644 drivers/hwmon/adm1177.c

diff --git a/Documentation/hwmon/adm1177.rst b/Documentation/hwmon/adm1177.rst
new file mode 100644
index 000000000000..c81e0b4abd28
--- /dev/null
+++ b/Documentation/hwmon/adm1177.rst
@@ -0,0 +1,36 @@
+Kernel driver adm1177
+=====================
+
+Supported chips:
+  * Analog Devices ADM1177
+    Prefix: 'adm1177'
+    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADM1177.pdf
+
+Author: Beniamin Bia <beniamin.bia@analog.com>
+
+
+Description
+-----------
+
+This driver supports hardware monitoring for Analog Devices ADM1177
+Hot-Swap Controller and Digital Power Monitors with Soft Start Pin.
+
+
+Usage Notes
+-----------
+
+This driver does not auto-detect devices. You will have to instantiate the
+devices explicitly. Please see Documentation/i2c/instantiating-devices for
+details.
+
+
+Sysfs entries
+-------------
+
+The following attributes are supported. Current maxim attribute
+is read-write, all other attributes are read-only.
+
+in0_input		Measured voltage in microvolts.
+
+curr1_input		Measured current in microamperes.
+curr1_max_alarm		Overcurrent alarm in microamperes.
diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 682ef4dda89c..cc7000593a73 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -29,6 +29,7 @@ Hardware Monitoring Kernel Drivers
    adm1025
    adm1026
    adm1031
+   adm1177
    adm1275
    adm9240
    ads7828
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 7ea61648ad16..47ac20aee06f 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -164,6 +164,16 @@ config SENSORS_ADM1031
 	  This driver can also be built as a module. If so, the module
 	  will be called adm1031.
 
+config SENSORS_ADM1177
+	tristate "Analog Devices ADM1177 and compatibles"
+	depends on I2C
+	help
+	  If you say yes here you get support for Analog Devices ADM1177
+	  sensor chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called adm1177.
+
 config SENSORS_ADM9240
 	tristate "Analog Devices ADM9240 and compatibles"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index f0f514f9cf24..613f50987965 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_SENSORS_ADM1025)	+= adm1025.o
 obj-$(CONFIG_SENSORS_ADM1026)	+= adm1026.o
 obj-$(CONFIG_SENSORS_ADM1029)	+= adm1029.o
 obj-$(CONFIG_SENSORS_ADM1031)	+= adm1031.o
+obj-$(CONFIG_SENSORS_ADM1177)	+= adm1177.o
 obj-$(CONFIG_SENSORS_ADM9240)	+= adm9240.o
 obj-$(CONFIG_SENSORS_ADS7828)	+= ads7828.o
 obj-$(CONFIG_SENSORS_ADS7871)	+= ads7871.o
diff --git a/drivers/hwmon/adm1177.c b/drivers/hwmon/adm1177.c
new file mode 100644
index 000000000000..d314223a404a
--- /dev/null
+++ b/drivers/hwmon/adm1177.c
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ADM1177 Hot Swap Controller and Digital Power Monitor with Soft Start Pin
+ *
+ * Copyright 2015-2019 Analog Devices Inc.
+ */
+
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/hwmon.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+
+/*  Command Byte Operations */
+#define ADM1177_CMD_V_CONT	BIT(0)
+#define ADM1177_CMD_I_CONT	BIT(2)
+#define ADM1177_CMD_VRANGE	BIT(4)
+
+/* Extended Register */
+#define ADM1177_REG_ALERT_TH	2
+
+#define ADM1177_BITS		12
+
+/**
+ * struct adm1177_state - driver instance specific data
+ * @client		pointer to i2c client
+ * @reg			regulator info for the the power supply of the device
+ * @r_sense_uohm	current sense resistor value
+ * @alert_threshold_ua	current limit for shutdown
+ * @vrange_high		internal voltage divider
+ */
+struct adm1177_state {
+	struct i2c_client	*client;
+	struct regulator	*reg;
+	u32			r_sense_uohm;
+	u32			alert_threshold_ua;
+	bool			vrange_high;
+};
+
+static int adm1177_read_raw(struct adm1177_state *st, u8 num, u8 *data)
+{
+	return i2c_master_recv(st->client, data, num);
+}
+
+static int adm1177_write_cmd(struct adm1177_state *st, u8 cmd)
+{
+	return i2c_smbus_write_byte(st->client, cmd);
+}
+
+static int adm1177_write_alert_thr(struct adm1177_state *st,
+				   u32 alert_threshold_ua)
+{
+	u64 val;
+	int ret;
+
+	val = 0xFFULL * alert_threshold_ua * st->r_sense_uohm;
+	val = div_u64(val, 105840000U);
+	val = div_u64(val, 1000U);
+	if (val > 0xFF)
+		val = 0xFF;
+
+	ret = i2c_smbus_write_byte_data(st->client, ADM1177_REG_ALERT_TH,
+					val);
+	if (ret)
+		return ret;
+
+	st->alert_threshold_ua = alert_threshold_ua;
+	return 0;
+}
+
+static int adm1177_read(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int channel, long *val)
+{
+	struct adm1177_state *st = dev_get_drvdata(dev);
+	u8 data[3];
+	long dummy;
+	int ret;
+
+	switch (type) {
+	case hwmon_curr:
+		switch (attr) {
+		case hwmon_curr_input:
+			ret = adm1177_read_raw(st, 3, data);
+			if (ret < 0)
+				return ret;
+			dummy = (data[1] << 4) | (data[2] & 0xF);
+			/*
+			 * convert to milliamperes
+			 * ((105.84mV / 4096) x raw) / senseResistor(ohm)
+			 */
+			*val = div_u64((105840000ull * dummy),
+				       4096 * st->r_sense_uohm);
+			return 0;
+		case hwmon_curr_max_alarm:
+			*val = st->alert_threshold_ua;
+			return 0;
+		default:
+			return -EOPNOTSUPP;
+		}
+	case hwmon_in:
+		ret = adm1177_read_raw(st, 3, data);
+		if (ret < 0)
+			return ret;
+		dummy = (data[0] << 4) | (data[2] >> 4);
+		/*
+		 * convert to millivolts based on resistor devision
+		 * (V_fullscale / 4096) * raw
+		 */
+		if (st->vrange_high)
+			dummy *= 26350;
+		else
+			dummy *= 6650;
+
+		*val = DIV_ROUND_CLOSEST(dummy, 4096);
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int adm1177_write(struct device *dev, enum hwmon_sensor_types type,
+			 u32 attr, int channel, long val)
+{
+	struct adm1177_state *st = dev_get_drvdata(dev);
+
+	switch (type) {
+	case hwmon_curr:
+		switch (attr) {
+		case hwmon_curr_max_alarm:
+			adm1177_write_alert_thr(st, val);
+			return 0;
+		default:
+			return -EOPNOTSUPP;
+		}
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t adm1177_is_visible(const void *data,
+				  enum hwmon_sensor_types type,
+				  u32 attr, int channel)
+{
+	const struct adm1177_state *st = data;
+
+	switch (type) {
+	case hwmon_in:
+		switch (attr) {
+		case hwmon_in_input:
+			return 0444;
+		}
+		break;
+	case hwmon_curr:
+		switch (attr) {
+		case hwmon_curr_input:
+			if (st->r_sense_uohm)
+				return 0444;
+			return 0;
+		case hwmon_curr_max_alarm:
+			if (st->r_sense_uohm)
+				return 0644;
+			return 0;
+		}
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static const struct hwmon_channel_info *adm1177_info[] = {
+	HWMON_CHANNEL_INFO(curr,
+			   HWMON_C_INPUT | HWMON_C_MAX_ALARM),
+	HWMON_CHANNEL_INFO(in,
+			   HWMON_I_INPUT),
+	NULL
+};
+
+static const struct hwmon_ops adm1177_hwmon_ops = {
+	.is_visible = adm1177_is_visible,
+	.read = adm1177_read,
+	.write = adm1177_write,
+};
+
+static const struct hwmon_chip_info adm1177_chip_info = {
+	.ops = &adm1177_hwmon_ops,
+	.info = adm1177_info,
+};
+
+static void adm1177_remove(void *data)
+{
+	struct adm1177_state *st = data;
+
+	regulator_disable(st->reg);
+}
+
+static int adm1177_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct device *hwmon_dev;
+	struct adm1177_state *st;
+	u32 alert_threshold_ua;
+	int ret;
+
+	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	st->client = client;
+
+	st->reg = devm_regulator_get_optional(&client->dev, "vref");
+	if (IS_ERR(st->reg)) {
+		if (PTR_ERR(st->reg) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		st->reg = NULL;
+	} else {
+		ret = regulator_enable(st->reg);
+		if (ret)
+			return ret;
+		ret = devm_add_action_or_reset(&client->dev, adm1177_remove,
+					       st);
+		if (ret)
+			return ret;
+	}
+
+	if (device_property_read_u32(dev, "shunt-resistor-micro-ohms",
+				     &st->r_sense_uohm))
+		st->r_sense_uohm = 0;
+	if (device_property_read_u32(dev, "adi,shutdown-threshold-microamp",
+				     &alert_threshold_ua)) {
+		if (st->r_sense_uohm)
+			/*
+			 * set maximum default value from datasheet based on
+			 * shunt-resistor
+			 */
+			alert_threshold_ua = div_u64(105840000000,
+						     st->r_sense_uohm);
+		else
+			alert_threshold_ua = 0;
+	}
+	st->vrange_high = device_property_read_bool(dev,
+						    "adi,vrange-high-enable");
+	if (alert_threshold_ua && st->r_sense_uohm)
+		adm1177_write_alert_thr(st, alert_threshold_ua);
+
+	ret = adm1177_write_cmd(st, ADM1177_CMD_V_CONT |
+				    ADM1177_CMD_I_CONT |
+				    (st->vrange_high ? 0 : ADM1177_CMD_VRANGE));
+	if (ret)
+		return ret;
+
+	hwmon_dev =
+		devm_hwmon_device_register_with_info(dev, client->name, st,
+						     &adm1177_chip_info, NULL);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static const struct i2c_device_id adm1177_id[] = {
+	{"adm1177", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, adm1177_id);
+
+static const struct of_device_id adm1177_dt_ids[] = {
+	{ .compatible = "adi,adm1177" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, adm1177_dt_ids);
+
+static struct i2c_driver adm1177_driver = {
+	.class = I2C_CLASS_HWMON,
+	.driver = {
+		.name = "adm1177",
+		.of_match_table = adm1177_dt_ids,
+	},
+	.probe = adm1177_probe,
+	.id_table = adm1177_id,
+};
+module_i2c_driver(adm1177_driver);
+
+MODULE_AUTHOR("Beniamin Bia <beniamin.bia@analog.com>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADM1177 ADC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

