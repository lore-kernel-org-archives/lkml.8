Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA057C18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 14:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADCE21D7E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 14:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgCIOP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 10:15:27 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:40638 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726233AbgCIOP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 10:15:27 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 029EF06t002506;
        Mon, 9 Mar 2020 10:15:04 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ym6bcdr1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Mar 2020 10:15:04 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 029EF3MG006148
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 9 Mar 2020 10:15:03 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 9 Mar 2020 10:15:02 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 9 Mar 2020 10:15:02 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 9 Mar 2020 10:15:02 -0400
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 029EEpDT008094;
        Mon, 9 Mar 2020 10:14:59 -0400
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linux@roeck-us.net>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH 1/2] hwmon: pmbus: adm1266: add initial support
Date:   Mon, 9 Mar 2020 16:14:21 +0200
Message-ID: <20200309141422.10999-2-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309141422.10999-1-alexandru.tachici@analog.com>
References: <20200309141422.10999-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-09_05:2020-03-09,2020-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003090098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial pmbus probing driver for the adm1266 Cascadable
Super Sequencer with Margin Control and Fault Recording.
Driver is currently using the pmbus_core, creating sysfs
files under hwmon for inputs: vh1->vh4 and vp1->vp13.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 Documentation/hwmon/adm1266   |  34 ++++++++
 drivers/hwmon/pmbus/Kconfig   |  10 +++
 drivers/hwmon/pmbus/Makefile  |   1 +
 drivers/hwmon/pmbus/adm1266.c | 146 ++++++++++++++++++++++++++++++++++
 4 files changed, 191 insertions(+)
 create mode 100644 Documentation/hwmon/adm1266
 create mode 100644 drivers/hwmon/pmbus/adm1266.c

diff --git a/Documentation/hwmon/adm1266 b/Documentation/hwmon/adm1266
new file mode 100644
index 000000000000..64651b5086a7
--- /dev/null
+++ b/Documentation/hwmon/adm1266
@@ -0,0 +1,34 @@
+Kernel driver adm1266
+=====================
+
+Supported chips:
+  * Analog Devices ADM1266
+    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADM1266.pdf
+
+Author: Alexandru Tachici <alexandru.tachici@analog.com>
+
+
+Description
+-----------
+
+This driver supports hardware monitoring for Analog Devices ADM1266 sequencer.
+
+ADM1266 is a sequencer that feature voltage readback from 17 channels via an
+integrated 12 bit SAR ADC, accessed using a PMBus interface.
+
+The driver is a client driver to the core PMBus driver. Please see
+Documentation/hwmon/pmbus for details on PMBus client drivers.
+
+
+Sysfs entries
+-------------
+
+The following attributes are supported. Limits are read-write, history reset
+attributes are write-only, all other attributes are read-only.
+
+inX_label		"voutx"
+inX_input		Measured voltage.
+inX_min			Minimum Voltage.
+inX_max			Maximum voltage.
+inX_min_alarm		Voltage low alarm.
+inX_max_alarm		Voltage high alarm.
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index a9ea06204767..153e64febe98 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -26,6 +26,16 @@ config SENSORS_PMBUS
 	  This driver can also be built as a module. If so, the module will
 	  be called pmbus.
 
+config SENSORS_ADM1266
+	tristate "Analog Devices ADM1266"
+	default n
+	help
+	  If you say yes here you get hardware monitoring support for Analog
+	  Devices ADM1266.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called adm1266.
+
 config SENSORS_ADM1275
 	tristate "Analog Devices ADM1275 and compatibles"
 	help
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 5feb45806123..ed38f6d6f845 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_PMBUS)		+= pmbus_core.o
 obj-$(CONFIG_SENSORS_PMBUS)	+= pmbus.o
+obj-$(CONFIG_SENSORS_ADM1266)	+= adm1266.o
 obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
 obj-$(CONFIG_SENSORS_BEL_PFE)	+= bel-pfe.o
 obj-$(CONFIG_SENSORS_IBM_CFFPS)	+= ibm-cffps.o
diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
new file mode 100644
index 000000000000..3aa8262f9bd6
--- /dev/null
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ADM1266 - Cascadable Super Sequencer with Margin
+ * Control and Fault Recording
+ *
+ * Copyright 2020 Analog Devices Inc.
+ */
+
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/fwnode.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#include "pmbus.h"
+
+enum chips { adm1266 };
+
+struct adm1266_data {
+	enum chips id;
+	struct pmbus_driver_info info;
+};
+
+static int adm1266_block_wr(struct i2c_client *client, u8 cmd, u8 wr_len,
+			    u8 *data_w, u8 *data_r)
+{
+	union i2c_smbus_data smbus_data;
+	int ret;
+
+	smbus_data.block[0] = wr_len;
+	memcpy(smbus_data.block + 1, data_w, wr_len);
+	ret = i2c_smbus_xfer(client->adapter, client->addr,
+			     client->flags, I2C_SMBUS_READ, cmd,
+			     I2C_SMBUS_BLOCK_PROC_CALL, &smbus_data);
+	if (ret < 0)
+		return ret;
+
+	memcpy(data_r, &smbus_data.block[1], smbus_data.block[0]);
+
+	return 0;
+}
+
+static int adm1266_config(struct pmbus_driver_info *info)
+{
+	u32 funcs;
+	int i;
+
+	info->pages = 17;
+	info->format[PSC_VOLTAGE_OUT] = linear;
+
+	funcs = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
+	for (i = 0; i < info->pages; i++)
+		info->func[i] = funcs;
+
+	return 0;
+}
+
+static const struct i2c_device_id adm1266_id[] = {
+	{ "adm1266", adm1266 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, adm1266_id);
+
+static int adm1266_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	u8 block_buffer[I2C_SMBUS_BLOCK_MAX + 1];
+	u8 wr_buffer[I2C_SMBUS_BLOCK_MAX + 1];
+	const struct i2c_device_id *mid;
+	struct adm1266_data *data;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_READ_BYTE_DATA
+				     | I2C_FUNC_SMBUS_BLOCK_DATA))
+		return -ENODEV;
+
+	wr_buffer[0] = 32;
+	ret = adm1266_block_wr(client, PMBUS_MFR_ID, 1, wr_buffer,
+			       block_buffer);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to read Manufacturer ID\n");
+		return ret;
+	}
+
+	if (strncmp(block_buffer, "Analog Devices, Inc", 19)) {
+		dev_err(&client->dev, "Unsupported Manufacturer ID\n");
+		return -ENODEV;
+	}
+
+	wr_buffer[0] = 32;
+	ret = adm1266_block_wr(client, PMBUS_MFR_MODEL, 1, wr_buffer,
+			       block_buffer);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to read Manufacturer Model\n");
+		return ret;
+	}
+
+	for (mid = adm1266_id; mid->name[0]; mid++) {
+		if (!strncasecmp(mid->name, block_buffer, strlen(mid->name)))
+			break;
+	}
+	if (!mid->name[0]) {
+		dev_err(&client->dev, "Unsupported device\n");
+		return -ENODEV;
+	}
+
+	data = devm_kzalloc(&client->dev, sizeof(struct adm1266_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	data->id = mid->driver_data;
+
+	ret = adm1266_config(&data->info);
+	if (ret < 0) {
+		dev_err(&client->dev, "Could not configure device.");
+		return ret;
+	}
+
+	return pmbus_do_probe(client, id, &data->info);
+}
+
+static const struct of_device_id adm1266_of_match[] = {
+	{ .compatible = "adi,adm1266" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, adm1266_of_match);
+
+static struct i2c_driver adm1266_driver = {
+	.driver = {
+		   .name = "adm1266",
+		   .of_match_table = adm1266_of_match,
+		  },
+	.probe = adm1266_probe,
+	.remove = pmbus_do_remove,
+	.id_table = adm1266_id,
+};
+
+module_i2c_driver(adm1266_driver);
+
+MODULE_AUTHOR("Alexandru Tachici <alexandru.tachici@analog.com>");
+MODULE_DESCRIPTION("PMBus driver for Analog Devices ADM1266");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

