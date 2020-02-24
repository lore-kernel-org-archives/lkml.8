Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C726C11D3D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C7620732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0gSEhJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgBXX1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:27:08 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38879 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbgBXX1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:27:06 -0500
Received: by mail-wm1-f67.google.com with SMTP id a9so1184936wmj.3;
        Mon, 24 Feb 2020 15:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DciDFBtm2KODVam6qaaL1QMin/0mjJzkuCv9v0Jic/o=;
        b=V0gSEhJbqi1RFQeEGhXRYzvOcqu0nm4PVbi7BsS56ZCKl7zChjfNLBt2+Uij350EWI
         eD8feBt/awN5SE/QEi2ewZI2m6nqiXqpcrvpS1lJWD5EIq8XS8ezEprNQUVVOE5gafOd
         KvpBMVyFn/F9+0iLm20o1yBYrCBW6EfawbaIj9Ow8A0kAEtFgYiZO+xjQ/qo672TjcKo
         LAbH24KKO0+WHBjo2diOzgKOKoRHvWNt+dzhV+IHcA7/ZJO/1eKyCOk/PUEmPPXjafIo
         r/YNA8ZKT4nqqT+9x6UCcx+q6rDWL5e58VlavzONl+rmqpMY/wEGx7hRZLv2gv8zxwNz
         YlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DciDFBtm2KODVam6qaaL1QMin/0mjJzkuCv9v0Jic/o=;
        b=YYSZpM0MibnCqg8jcn9Lh+luxcdvGAfELP1RoqHblbeqO12H+BoP/Ma1iZN/+n6Bvv
         Eg2Sv0axlr8d5EOKeZQthIPJrevpZlmzqAB7tOd2pvcX0azNi0cwPQEd50wgR4QutYb3
         s5Sd36WW0cTdUVvFjU33G/VTgmx3MD8TcbgX+8wpoIbI9/HP7bmoxMXR0mwdIjX2+dAC
         jQ6jyLn6uGD16VZwzzRDLFqq3fFWOYz/6QxFVab5C58gIc7qQ6RjKtHjom8Rs+QNWsqj
         vMjnpNYFAjpp/UqrPq+IqHnV3ekLTdIQkp8HLMD3HKSUYUghc52ibK0tXVPSrZtB/THl
         zBCA==
X-Gm-Message-State: APjAAAVnqalLqpzSBC9By1Qp9ctoggJMeTz3zL5At327VyAKVomwUnDG
        kTJvTfyDn0dbRBRsLB/WqVM=
X-Google-Smtp-Source: APXvYqwSdmb3/b4hBOdmeVP2G1h5ARxbbqQdao65qirurmkLhyshwQlUrps4i4/Ly6xvQ80aAJtgnQ==
X-Received: by 2002:a7b:ca49:: with SMTP id m9mr1397173wml.50.1582586823845;
        Mon, 24 Feb 2020 15:27:03 -0800 (PST)
Received: from buildbot.home (217-149-167-12.nat.highway.telekom.at. [217.149.167.12])
        by smtp.googlemail.com with ESMTPSA id g25sm1971099wmh.3.2020.02.24.15.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 15:27:03 -0800 (PST)
From:   Franz Forstmayr <forstmayr.franz@gmail.com>
To:     forstmayr.franz@gmail.com
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 3/3] hwmon: (ina2xx) Add support for ina260
Date:   Tue, 25 Feb 2020 00:26:47 +0100
Message-Id: <20200224232647.29213-3-forstmayr.franz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200224232647.29213-1-forstmayr.franz@gmail.com>
References: <20200224232647.29213-1-forstmayr.franz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support for INA260 power monitor with integrated shunt.
Registers are different from other INA2xx devices, that's why a small
translation table is used.

Signed-off-by: Franz Forstmayr <forstmayr.franz@gmail.com>
---
 drivers/hwmon/Kconfig  |   5 +-
 drivers/hwmon/ina2xx.c | 144 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 125 insertions(+), 24 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 05a30832c6ba..2916a60dd9b1 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1683,11 +1683,12 @@ config SENSORS_INA2XX
 	select REGMAP_I2C
 	help
 	  If you say yes here you get support for INA219, INA220, INA226,
-	  INA230, and INA231 power monitor chips.
+	  INA230, INA231 and INA260 power monitor chips.
 
 	  The INA2xx driver is configured for the default configuration of
 	  the part as described in the datasheet.
-	  Default value for Rshunt is 10 mOhms.
+	  Default value for Rshunt is 10 mOhms, except for INA260 which has
+	  an 2 mOhm integrated shunt.
 	  This driver can also be built as a module. If so, the module
 	  will be called ina2xx.
 
diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index e9e78c0b7212..bc5bb936bac5 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -18,6 +18,11 @@
  * Bi-directional Current/Power Monitor with I2C Interface
  * Datasheet: http://www.ti.com/product/ina230
  *
+ * INA260:
+ * Bi-directional Current/Power Monitor with I2C Interface and integrated
+ * shunt.
+ * Datasheet: http://www.ti.com/product/ina260
+ *
  * Copyright (C) 2012 Lothar Felten <lothar.felten@gmail.com>
  * Thanks to Jan Volkering
  */
@@ -50,8 +55,14 @@
 /* INA226 register definitions */
 #define INA226_MASK_ENABLE		0x06
 #define INA226_ALERT_LIMIT		0x07
+#define INA226_MANUFACTURER_ID		0xFE
 #define INA226_DIE_ID			0xFF
 
+/* INA260 register definitions */
+#define INA260_CURRENT			0x01
+#define INA260_BUS_VOLTAGE		0x02
+#define INA260_POWER			0x03
+
 /* register count */
 #define INA219_REGISTERS		6
 #define INA226_REGISTERS		8
@@ -61,12 +72,14 @@
 /* settings - depend on use case */
 #define INA219_CONFIG_DEFAULT		0x399F	/* PGA=8 */
 #define INA226_CONFIG_DEFAULT		0x4527	/* averages=16 */
+#define INA260_CONFIG_DEFAULT		0x6127  /* averages=16 */
 
 /* worst case is 68.10 ms (~14.6Hz, ina219) */
 #define INA2XX_CONVERSION_RATE		15
 #define INA2XX_MAX_DELAY		69 /* worst case delay in ms */
 
 #define INA2XX_RSHUNT_DEFAULT		10000
+#define INA260_RSHUNT_DEFAULT           2000
 
 /* bit mask for reading the averaging setting in the configuration register */
 #define INA226_AVG_RD_MASK		0x0E00
@@ -74,8 +87,8 @@
 #define INA226_READ_AVG(reg)		(((reg) & INA226_AVG_RD_MASK) >> 9)
 #define INA226_SHIFT_AVG(val)		((val) << 9)
 
-/* common attrs, ina226 attrs and NULL */
-#define INA2XX_MAX_ATTRIBUTE_GROUPS	3
+/* common attrs, shunt/bus voltage attrs, ina226 attrs and NULL */
+#define INA2XX_MAX_ATTRIBUTE_GROUPS	4
 
 /*
  * Both bus voltage and shunt voltage conversion times for ina226 are set
@@ -88,7 +101,15 @@ static struct regmap_config ina2xx_regmap_config = {
 	.val_bits = 16,
 };
 
-enum ina2xx_ids { ina219, ina226 };
+enum ina2xx_ids { ina219, ina226, ina260 };
+
+/* Translate the ina2xx addresses to ina260 addresses */
+const int ina260_translation[] = { 0,
+	0,
+	INA260_BUS_VOLTAGE,
+	INA260_POWER,
+	INA260_CURRENT };
+
 
 struct ina2xx_config {
 	u16 config_default;
@@ -108,6 +129,7 @@ struct ina2xx_data {
 	long power_lsb_uW;
 	struct mutex config_lock;
 	struct regmap *regmap;
+	enum ina2xx_ids chip;
 
 	const struct attribute_group *groups[INA2XX_MAX_ATTRIBUTE_GROUPS];
 };
@@ -131,6 +153,15 @@ static const struct ina2xx_config ina2xx_config[] = {
 		.bus_voltage_lsb = 1250,
 		.power_lsb_factor = 25,
 	},
+	[ina260] = {
+		.config_default = INA260_CONFIG_DEFAULT,
+		.calibration_value = 0,
+		.registers = INA226_REGISTERS,
+		.shunt_div = 0,
+		.bus_voltage_shift = 0,
+		.bus_voltage_lsb = 1250,
+		.power_lsb_factor = 10,
+	},
 };
 
 /*
@@ -190,7 +221,11 @@ static int ina2xx_init(struct ina2xx_data *data)
 	if (ret < 0)
 		return ret;
 
-	return ina2xx_calibrate(data);
+	/* ina260 has no calibration register */
+	if (data->chip != ina260)
+		return ina2xx_calibrate(data);
+	else
+		return 0;
 }
 
 static int ina2xx_read_reg(struct device *dev, int reg, unsigned int *regval)
@@ -215,8 +250,9 @@ static int ina2xx_read_reg(struct device *dev, int reg, unsigned int *regval)
 		 * register and reinitialize if needed.
 		 * We do that extra read of the calibration register if there
 		 * is some hint of a chip reset.
+		 * INA260 has an integrated shunt, thus no calibration register
 		 */
-		if (*regval == 0) {
+		if (*regval == 0 && data->chip != ina260) {
 			unsigned int cal;
 
 			ret = regmap_read(data->regmap, INA2XX_CALIBRATION,
@@ -287,20 +323,60 @@ static int ina2xx_get_value(struct ina2xx_data *data, u8 reg,
 	return val;
 }
 
+static int ina260_get_value(struct ina2xx_data *data, u8 reg,
+	unsigned int regval)
+{
+	int val;
+
+	switch (reg) {
+	case INA260_BUS_VOLTAGE:
+		val = (regval >> data->config->bus_voltage_shift)
+			* data->config->bus_voltage_lsb;
+		val = DIV_ROUND_CLOSEST(val, 1000);
+		break;
+	case INA260_POWER:
+		val = regval * data->power_lsb_uW;
+		break;
+	case INA260_CURRENT:
+		/* signed register, result in mA */
+		val = (s16)regval * data->current_lsb_uA;
+		val = DIV_ROUND_CLOSEST(val, 1000);
+		break;
+	default:
+		/* programmer goofed */
+		WARN_ON_ONCE(1);
+		val = 0;
+		break;
+	}
+	return val;
+}
+
 static ssize_t ina2xx_value_show(struct device *dev,
 				 struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct ina2xx_data *data = dev_get_drvdata(dev);
 	unsigned int regval;
+	int err;
+
+	if (data->chip == ina260) {
+		err = ina2xx_read_reg(dev,
+			ina260_translation[attr->index], &regval);
+
+		if (err < 0)
+			return err;
 
-	int err = ina2xx_read_reg(dev, attr->index, &regval);
+		return snprintf(buf, PAGE_SIZE, "%d\n", ina260_get_value(data,
+			ina260_translation[attr->index], regval));
+	} else {
+		err = ina2xx_read_reg(dev, attr->index, &regval);
 
-	if (err < 0)
-		return err;
+		if (err < 0)
+			return err;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-			ina2xx_get_value(data, attr->index, regval));
+		return snprintf(buf, PAGE_SIZE, "%d\n", ina2xx_get_value(data,
+			attr->index, regval));
+	}
 }
 
 /*
@@ -409,11 +485,19 @@ static SENSOR_DEVICE_ATTR_RW(shunt_resistor, ina2xx_shunt, INA2XX_CALIBRATION);
 static SENSOR_DEVICE_ATTR_RW(update_interval, ina226_interval, 0);
 
 /* pointers to created device attributes */
-static struct attribute *ina2xx_attrs[] = {
-	&sensor_dev_attr_in0_input.dev_attr.attr,
+static struct attribute *ina2xx_common_attrs[] = {
 	&sensor_dev_attr_in1_input.dev_attr.attr,
 	&sensor_dev_attr_curr1_input.dev_attr.attr,
 	&sensor_dev_attr_power1_input.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ina2xx_common_group = {
+	.attrs = ina2xx_common_attrs,
+};
+
+static struct attribute *ina2xx_attrs[] = {
+	&sensor_dev_attr_in0_input.dev_attr.attr,
 	&sensor_dev_attr_shunt_resistor.dev_attr.attr,
 	NULL,
 };
@@ -451,19 +535,28 @@ static int ina2xx_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	/* set the device type */
+	data->chip = chip;
 	data->config = &ina2xx_config[chip];
 	mutex_init(&data->config_lock);
 
-	if (of_property_read_u32(dev->of_node, "shunt-resistor", &val) < 0) {
-		struct ina2xx_platform_data *pdata = dev_get_platdata(dev);
+	if (chip != ina260) {
+		if (of_property_read_u32(dev->of_node,
+			"shunt-resistor", &val) < 0) {
 
-		if (pdata)
-			val = pdata->shunt_uohms;
-		else
-			val = INA2XX_RSHUNT_DEFAULT;
-	}
+			struct ina2xx_platform_data *pdata = dev_get_platdata(dev);
 
-	ina2xx_set_shunt(data, val);
+			if (pdata)
+				val = pdata->shunt_uohms;
+			else
+				val = INA2XX_RSHUNT_DEFAULT;
+		}
+		ina2xx_set_shunt(data, val);
+	} else {
+		data->rshunt = INA260_RSHUNT_DEFAULT;
+		/* ina260 has same LSB value for current and voltage */
+		data->current_lsb_uA = data->config->bus_voltage_lsb;
+		data->power_lsb_uW = data->config->power_lsb_factor;
+	}
 
 	ina2xx_regmap_config.max_register = data->config->registers;
 
@@ -479,9 +572,11 @@ static int ina2xx_probe(struct i2c_client *client,
 		return -ENODEV;
 	}
 
-	data->groups[group++] = &ina2xx_group;
-	if (chip == ina226)
+	data->groups[group++] = &ina2xx_common_group;
+	if (chip == ina226 || chip == ina260)
 		data->groups[group++] = &ina226_group;
+	if (chip != ina260)
+		data->groups[group++] = &ina2xx_group;
 
 	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
 							   data, data->groups);
@@ -500,6 +595,7 @@ static const struct i2c_device_id ina2xx_id[] = {
 	{ "ina226", ina226 },
 	{ "ina230", ina226 },
 	{ "ina231", ina226 },
+	{ "ina260", ina260 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ina2xx_id);
@@ -525,6 +621,10 @@ static const struct of_device_id __maybe_unused ina2xx_of_match[] = {
 		.compatible = "ti,ina231",
 		.data = (void *)ina226
 	},
+	{
+		.compatible = "ti,ina260",
+		.data = (void *)ina260
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ina2xx_of_match);
-- 
2.17.1

