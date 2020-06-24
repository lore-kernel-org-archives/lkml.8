Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84160C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 582162078A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404116AbgFXPQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:16:18 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:6890 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404520AbgFXPQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:16:08 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05OEvpHr023509;
        Wed, 24 Jun 2020 11:15:48 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 31uuqvjesk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Jun 2020 11:15:48 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 05OFFlDi044785
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 24 Jun 2020 11:15:47 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 24 Jun
 2020 11:15:46 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 24 Jun 2020 11:15:46 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 05OFFdRs023607;
        Wed, 24 Jun 2020 11:15:43 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <linux@roeck-us.net>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v5 3/7] hwmon: pmbus: adm1266: Add support for GPIOs
Date:   Wed, 24 Jun 2020 18:17:32 +0300
Message-ID: <20200624151736.95785-4-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624151736.95785-1-alexandru.tachici@analog.com>
References: <20200624151736.95785-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-24_08:2020-06-24,2020-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 cotscore=-2147483648 priorityscore=1501 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Adm1266 exposes 9 GPIOs and 16 PDIOs which are currently read-only. They
are controlled by the internal sequencing engine.

This patch makes adm1266 driver expose GPIOs and PDIOs to user-space
using GPIO provider kernel api.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/hwmon/pmbus/adm1266.c | 233 +++++++++++++++++++++++++++++++++-
 1 file changed, 232 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index 381d89a8569f..76bf2c78e737 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -6,8 +6,12 @@
  * Copyright 2020 Analog Devices Inc.
  */
 
+#include <linux/bitfield.h>
 #include <linux/crc8.h>
+#include <linux/debugfs.h>
+#include <linux/gpio/driver.h>
 #include <linux/i2c.h>
+#include <linux/i2c-smbus.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -15,10 +19,35 @@
 
 #include "pmbus.h"
 
+#define ADM1266_PDIO_CONFIG	0xD4
+#define ADM1266_GPIO_CONFIG	0xE1
+#define ADM1266_PDIO_STATUS	0xE9
+#define ADM1266_GPIO_STATUS	0xEA
+
+/* ADM1266 GPIO defines */
+#define ADM1266_GPIO_NR			9
+#define ADM1266_GPIO_FUNCTIONS(x)	FIELD_GET(BIT(0), x)
+#define ADM1266_GPIO_INPUT_EN(x)	FIELD_GET(BIT(2), x)
+#define ADM1266_GPIO_OUTPUT_EN(x)	FIELD_GET(BIT(3), x)
+#define ADM1266_GPIO_OPEN_DRAIN(x)	FIELD_GET(BIT(4), x)
+
+/* ADM1266 PDIO defines */
+#define ADM1266_PDIO_NR			16
+#define ADM1266_PDIO_PIN_CFG(x)		FIELD_GET(GENMASK(15, 13), x)
+#define ADM1266_PDIO_GLITCH_FILT(x)	FIELD_GET(GENMASK(12, 9), x)
+#define ADM1266_PDIO_OUT_CFG(x)		FIELD_GET(GENMASK(2, 0), x)
+
 #define ADM1266_PMBUS_BLOCK_MAX		255
 
 DECLARE_CRC8_TABLE(pmbus_crc_table);
 
+struct adm1266_data {
+	struct pmbus_driver_info info;
+	struct gpio_chip gc;
+	const char *gpio_names[ADM1266_GPIO_NR + ADM1266_PDIO_NR];
+	struct i2c_client *client;
+};
+
 /* Different from Block Read as it sends data and waits for the slave to
  * return a value dependent on that data. The protocol is simply a Write Block
  * followed by a Read Block without the Read-Block command field and the
@@ -91,18 +120,220 @@ int pmbus_block_xfer(struct i2c_client *client, u8 cmd, u8 w_len,
 	return ret;
 }
 
+#ifdef CONFIG_GPIOLIB
+static const unsigned int adm1266_gpio_mapping[ADM1266_GPIO_NR][2] = {
+	{1, 0},
+	{2, 1},
+	{3, 2},
+	{4, 8},
+	{5, 9},
+	{6, 10},
+	{7, 11},
+	{8, 6},
+	{9, 7},
+};
+
+static const char *adm1266_names[ADM1266_GPIO_NR + ADM1266_PDIO_NR] = {
+	"GPIO1", "GPIO2", "GPIO3", "GPIO4", "GPIO5", "GPIO6", "GPIO7", "GPIO8",
+	"GPIO9", "PDIO1", "PDIO2", "PDIO3", "PDIO4", "PDIO5", "PDIO6",
+	"PDIO7", "PDIO8", "PDIO9", "PDIO10", "PDIO11", "PDIO12", "PDIO13",
+	"PDIO14", "PDIO15", "PDIO16",
+};
+
+static int adm1266_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct adm1266_data *data = gpiochip_get_data(chip);
+	u8 read_buf[I2C_SMBUS_BLOCK_MAX + 1];
+	unsigned long pins_status;
+	unsigned int pmbus_cmd;
+	int ret;
+
+	if (offset < ADM1266_GPIO_NR)
+		pmbus_cmd = ADM1266_GPIO_STATUS;
+	else
+		pmbus_cmd = ADM1266_PDIO_STATUS;
+
+	ret = i2c_smbus_read_block_data(data->client, pmbus_cmd,
+					read_buf);
+	if (ret < 0)
+		return ret;
+
+	pins_status = read_buf[0] + (read_buf[1] << 8);
+	if (offset < ADM1266_GPIO_NR)
+		return test_bit(adm1266_gpio_mapping[offset][1], &pins_status);
+
+	return test_bit(offset - ADM1266_GPIO_NR, &pins_status);
+}
+
+static int adm1266_gpio_get_multiple(struct gpio_chip *chip,
+				     unsigned long *mask,
+				     unsigned long *bits)
+{
+	struct adm1266_data *data = gpiochip_get_data(chip);
+	u8 read_buf[ADM1266_PMBUS_BLOCK_MAX + 1];
+	unsigned long status;
+	unsigned int gpio_nr;
+	int ret;
+
+	ret = i2c_smbus_read_block_data(data->client, ADM1266_GPIO_STATUS,
+					read_buf);
+	if (ret < 0)
+		return ret;
+
+	status = read_buf[0] + (read_buf[1] << 8);
+
+	*bits = 0;
+	for_each_set_bit(gpio_nr, mask, ADM1266_GPIO_NR) {
+		if (test_bit(adm1266_gpio_mapping[gpio_nr][1], &status))
+			set_bit(gpio_nr, bits);
+	}
+
+	ret = i2c_smbus_read_block_data(data->client, ADM1266_PDIO_STATUS,
+					read_buf);
+	if (ret < 0)
+		return ret;
+
+	status = read_buf[0] + (read_buf[1] << 8);
+
+	*bits = 0;
+	for_each_set_bit_from(gpio_nr, mask,
+			      ADM1266_GPIO_NR + ADM1266_PDIO_STATUS) {
+		if (test_bit(gpio_nr - ADM1266_GPIO_NR, &status))
+			set_bit(gpio_nr, bits);
+	}
+
+	return 0;
+}
+
+static void adm1266_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
+{
+	struct adm1266_data *data = gpiochip_get_data(chip);
+	u8 read_buf[ADM1266_PMBUS_BLOCK_MAX + 1];
+	unsigned long gpio_config;
+	unsigned long pdio_config;
+	unsigned long pin_cfg;
+	u8 write_cmd;
+	int ret;
+	int i;
+
+	for (i = 0; i < ADM1266_GPIO_NR; i++) {
+		write_cmd = adm1266_gpio_mapping[i][1];
+		ret = pmbus_block_xfer(data->client, ADM1266_GPIO_CONFIG, 1,
+				       &write_cmd, read_buf);
+		if (ret != 2)
+			return;
+
+		gpio_config = read_buf[0];
+		seq_puts(s, adm1266_names[i]);
+
+		seq_puts(s, " ( ");
+		if (!ADM1266_GPIO_FUNCTIONS(gpio_config)) {
+			seq_puts(s, "high-Z )\n");
+			continue;
+		}
+		if (ADM1266_GPIO_INPUT_EN(gpio_config))
+			seq_puts(s, "input ");
+		if (ADM1266_GPIO_OUTPUT_EN(gpio_config))
+			seq_puts(s, "output ");
+		if (ADM1266_GPIO_OPEN_DRAIN(gpio_config))
+			seq_puts(s, "open-drain )\n");
+		else
+			seq_puts(s, "push-pull )\n");
+	}
+
+	write_cmd = 0xFF;
+	ret = pmbus_block_xfer(data->client, ADM1266_PDIO_CONFIG, 1, &write_cmd,
+			       read_buf);
+	if (ret != 32)
+		return;
+
+	for (i = 0; i < ADM1266_PDIO_NR; i++) {
+		seq_puts(s, adm1266_names[ADM1266_GPIO_NR + i]);
+
+		pdio_config = read_buf[2 * i];
+		pdio_config += (read_buf[2 * i + 1] << 8);
+		pin_cfg = ADM1266_PDIO_PIN_CFG(pdio_config);
+
+		seq_puts(s, " ( ");
+		if (!pin_cfg || pin_cfg > 5) {
+			seq_puts(s, "high-Z )\n");
+			continue;
+		}
+
+		if (pin_cfg & BIT(0))
+			seq_puts(s, "output ");
+
+		if (pin_cfg & BIT(1))
+			seq_puts(s, "input ");
+
+		seq_puts(s, ")\n");
+	}
+}
+
+static int adm1266_config_gpio(struct adm1266_data *data)
+{
+	const char *name = dev_name(&data->client->dev);
+	char *gpio_name;
+	int ret;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(data->gpio_names); i++) {
+		gpio_name = devm_kasprintf(&data->client->dev, GFP_KERNEL,
+					   "adm1266-%x-%s", data->client->addr,
+					   adm1266_names[i]);
+		if (!gpio_name)
+			return -ENOMEM;
+
+		data->gpio_names[i] = gpio_name;
+	}
+
+	data->gc.label = name;
+	data->gc.parent = &data->client->dev;
+	data->gc.owner = THIS_MODULE;
+	data->gc.base = -1;
+	data->gc.names = data->gpio_names;
+	data->gc.ngpio = ARRAY_SIZE(data->gpio_names);
+	data->gc.get = adm1266_gpio_get;
+	data->gc.get_multiple = adm1266_gpio_get_multiple;
+	data->gc.dbg_show = adm1266_gpio_dbg_show;
+
+	ret = devm_gpiochip_add_data(&data->client->dev, &data->gc, data);
+	if (ret)
+		dev_err(&data->client->dev, "GPIO registering failed (%d)\n",
+			ret);
+
+	return ret;
+}
+#else
+static int adm1266_config_gpio(struct adm1266_data *data)
+{
+	return 0;
+}
+#endif
+
 static int adm1266_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct pmbus_driver_info *info;
+	struct adm1266_data *data;
 	u32 funcs;
+	int ret;
 	int i;
 
-	info = devm_kzalloc(&client->dev, sizeof(struct pmbus_driver_info),
+	data = devm_kzalloc(&client->dev, sizeof(struct adm1266_data),
 			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->client = client;
+
+	ret = adm1266_config_gpio(data);
+	if (ret < 0)
+		return ret;
 
 	crc8_populate_msb(pmbus_crc_table, 0x7);
 
+	info = &data->info;
 	info->pages = 17;
 	info->format[PSC_VOLTAGE_OUT] = linear;
 	funcs = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
-- 
2.20.1

