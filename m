Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75C2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7394820758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJWBTAiA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgHQKte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 06:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbgHQKtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 06:49:08 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A751C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 03:49:08 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id f9so7500287pju.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 03:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HzaGVTzkl/79+Ieu6iH0dJq2r2GXeGojhLV9D3n4ofQ=;
        b=aJWBTAiA9QK09R8LRqaLcruQIYVLRlMo8qtOC9ZHfQCANzK0iSUN+3H/vp8SXAb8EB
         jXet9URp3y8NthwzFsBJ9iMEPSSEwTT7HNESCbVUcPfjR3ShI2EXUi3alm0UNElrJEEr
         Lglu8u2CDy6or/2crHnpSfuqE3CKfjYoMJHysvJVqym4uUtfuKwUQ7MPPHUs7H82TqyV
         bGkvrv3ScF1iVbGPgv4m3DM61j9DM7arAcW4h8KrJFaKIgG4OriCHKQGlrmKuy5cn0Vw
         EayU/42Eah3ahdzMrzX2LBGQxdNrv3OvJi2fSvNcrXf9780+i20L4x9lMK9fdXA5ALSe
         L5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HzaGVTzkl/79+Ieu6iH0dJq2r2GXeGojhLV9D3n4ofQ=;
        b=bJXG7Hi4a3lz5Pn9uPHTUlBN6pltbd4t9fkyn0WVgBCeHoPZE1398mjHy0tiIHwCQY
         dlcSP4SDQJUUfc2ToOfIelqLJOS2+z+7GFlZJ4MPgxEa7XszSnDC8cXs7Kq1nrtzQJyN
         ymO8rliOakc5ewQ1B7k35dDtqGt5q9yXNZ4NqsHo08QFBCdPzM8X0Bql/CW88pylVTXm
         cv//+KlIyM9pzNUO6QDUfN3j182q4i7uKAPMd0A/dyZakML9bxW3KZyKEAjI/XMRQrjb
         sXYVAPUQ178YPB1jxKkRL8TxiqHTcRYypp8aUrMUPyOz3JptBYYLWf73HueS1rCizWKm
         capA==
X-Gm-Message-State: AOAM531isluQETwqX/uW808VIMZZF+lgrDpcbjbPCI8PHaGQ7wQPQBYI
        tk0GpgAMm1m0x6MRUt3rdW9oqFLaezo=
X-Google-Smtp-Source: ABdhPJwjZQtmN/gH07b1Q3kPH/Bv+XmyI7xNMuX8UuISZD6amGicDQIjCzmM9YECmDa81FhMBU16gQ==
X-Received: by 2002:a17:90a:3549:: with SMTP id q67mr11890758pjb.56.1597661346999;
        Mon, 17 Aug 2020 03:49:06 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:577:c217:67e6:a40c:a3bf:1945])
        by smtp.gmail.com with ESMTPSA id k12sm16976528pjp.38.2020.08.17.03.49.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Aug 2020 03:49:06 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH v4 9/9] mfd: mt6360: Merge different sub-devices I2C read/write
Date:   Mon, 17 Aug 2020 18:47:57 +0800
Message-Id: <1597661277-27862-10-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597661277-27862-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1597661277-27862-1-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Remove unuse register definition.
Merge different sub-devices I2C read/write functions into one Regmap,
because PMIC and LDO part need CRC bits for access protection.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 drivers/mfd/Kconfig        |   1 +
 drivers/mfd/mt6360-core.c  | 260 +++++++++++++++++++++++++++++++++++++++------
 include/linux/mfd/mt6360.h | 240 -----------------------------------------
 3 files changed, 226 insertions(+), 275 deletions(-)
 delete mode 100644 include/linux/mfd/mt6360.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index a37d7d1..0684ddc 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -913,6 +913,7 @@ config MFD_MT6360
 	select MFD_CORE
 	select REGMAP_I2C
 	select REGMAP_IRQ
+	select CRC8
 	depends on I2C
 	help
 	  Say Y here to enable MT6360 PMU/PMIC/LDO functional support.
diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index 677c974..e995220 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -14,7 +14,53 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
-#include <linux/mfd/mt6360.h>
+enum {
+	MT6360_SLAVE_TCPC = 0,
+	MT6360_SLAVE_PMIC,
+	MT6360_SLAVE_LDO,
+	MT6360_SLAVE_PMU,
+	MT6360_SLAVE_MAX,
+};
+
+struct mt6360_ddata {
+	struct i2c_client *i2c[MT6360_SLAVE_MAX];
+	struct device *dev;
+	struct regmap *regmap;
+	struct regmap_irq_chip_data *irq_data;
+	unsigned int chip_rev;
+	u8 crc8_tbl[CRC8_TABLE_SIZE];
+};
+
+#define MT6360_TCPC_SLAVEID		0x4E
+#define MT6360_PMIC_SLAVEID		0x1A
+#define MT6360_LDO_SLAVEID		0x64
+#define MT6360_PMU_SLAVEID		0x34
+
+#define MT6360_REG_TCPCSTART		0x00
+#define MT6360_REG_TCPCEND		0xFF
+#define MT6360_REG_PMICSTART		0x100
+#define MT6360_REG_PMICEND		0x13B
+#define MT6360_REG_LDOSTART		0x200
+#define MT6360_REG_LDOEND		0x21C
+#define MT6360_REG_PMUSTART		0x300
+#define MT6360_PMU_DEV_INFO		0x300
+#define MT6360_PMU_CHG_IRQ1		0x3D0
+#define MT6360_PMU_CHG_MASK1		0x3F0
+#define MT6360_REG_PMUEND		0x3FF
+
+#define MT6360_PMU_IRQ_REGNUM		16
+
+#define CHIP_VEN_MASK			0xF0
+#define CHIP_VEN_MT6360			0x50
+#define CHIP_REV_MASK			0x0F
+
+#define MT6360_ADDRESS_MASK		0x3F
+#define MT6360_DATA_SIZE_1_BYTE		0x00
+#define MT6360_DATA_SIZE_2_BYTES	0x40
+#define MT6360_DATA_SIZE_3_BYTES	0x80
+#define MT6360_DATA_SIZE_4_BYTES	0xC0
+
+#define MT6360_CRC8_POLYNOMIAL		0x7
 
 /* reg 0 -> 0 ~ 7 */
 #define MT6360_CHG_TREG_EVT		4
@@ -220,12 +266,6 @@ static const struct regmap_irq_chip mt6360_irq_chip = {
 	.use_ack = true,
 };
 
-static const struct regmap_config mt6360_pmu_regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-	.max_register = MT6360_PMU_MAXREG,
-};
-
 static const struct resource mt6360_adc_resources[] = {
 	DEFINE_RES_IRQ_NAMED(MT6360_ADC_DONEI, "adc_donei"),
 };
@@ -303,7 +343,7 @@ static int mt6360_check_vendor_info(struct mt6360_ddata *ddata)
 		return ret;
 
 	if ((info & CHIP_VEN_MASK) != CHIP_VEN_MT6360) {
-		dev_err(&client->dev, "Device not supported\n");
+		dev_err(ddata->dev, "Device not supported\n");
 		return -ENODEV;
 	}
 
@@ -312,11 +352,163 @@ static int mt6360_check_vendor_info(struct mt6360_ddata *ddata)
 	return 0;
 }
 
-static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
-	MT6360_PMU_SLAVEID,
+static const u16 mt6360_slave_addrs[MT6360_SLAVE_MAX] = {
+	MT6360_TCPC_SLAVEID,
 	MT6360_PMIC_SLAVEID,
 	MT6360_LDO_SLAVEID,
-	MT6360_TCPC_SLAVEID,
+	MT6360_PMU_SLAVEID,
+};
+
+static int mt6360_xlate_pmicldo_addr(u8 *addr, int rw_size)
+{
+	/* Address is already in encoded [5:0] */
+	*addr &= MT6360_ADDRESS_MASK;
+
+	switch (rw_size) {
+	case 1:
+		*addr |= MT6360_DATA_SIZE_1_BYTE;
+		break;
+	case 2:
+		*addr |= MT6360_DATA_SIZE_2_BYTES;
+		break;
+	case 3:
+		*addr |= MT6360_DATA_SIZE_3_BYTES;
+		break;
+	case 4:
+		*addr |= MT6360_DATA_SIZE_4_BYTES;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mt6360_regmap_read(void *context, const void *reg, size_t reg_size,
+			      void *val, size_t val_size)
+{
+	struct mt6360_ddata *ddata = context;
+	u8 bank = *(u8 *)reg, reg_addr = *(u8 *)(reg + 1);
+	struct i2c_client *i2c = ddata->i2c[bank];
+	bool crc_needed = false;
+	u8 *buf;
+	/* first two is i2c_addr + reg_addr , last is crc8 */
+	int alloc_size = 2 + val_size + 1, read_size = val_size;
+	u8 crc;
+	int ret;
+
+	if (bank == MT6360_SLAVE_PMIC || bank == MT6360_SLAVE_LDO) {
+		crc_needed = true;
+		ret = mt6360_xlate_pmicldo_addr(&reg_addr, val_size);
+		if (ret < 0)
+			return ret;
+		read_size += 1;
+	}
+
+	buf = kzalloc(alloc_size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	/* 7 bit slave addr + read bit */
+	buf[0] = ((i2c->addr & 0x7f) << 1) + 1;
+	buf[1] = reg_addr;
+
+	ret = i2c_smbus_read_i2c_block_data(i2c, reg_addr, read_size, buf + 2);
+
+	if (ret == read_size) {
+		memcpy(val, buf + 2, val_size);
+		if (crc_needed) {
+			crc = crc8(ddata->crc8_tbl, buf, val_size + 2, 0);
+			if (crc != buf[val_size + 2])
+				ret = -EIO;
+		}
+	}
+
+	kfree(buf);
+
+	if (ret < 0)
+		return ret;
+	else if (ret != read_size)
+		return -EIO;
+
+	return 0;
+}
+
+static int mt6360_regmap_write(void *context, const void *val, size_t val_size)
+{
+	struct mt6360_ddata *ddata = context;
+	u8 bank = *(u8 *)val, reg_addr = *(u8 *)(val + 1);
+	struct i2c_client *i2c = ddata->i2c[bank];
+	bool crc_needed = false;
+	u8 *buf;
+	/* first two is i2c_addr + reg_addr , last crc8 + dummy */
+	int alloc_size = 2 + val_size + 2, write_size = val_size - 2;
+	int ret;
+
+	if (bank == MT6360_SLAVE_PMIC || bank == MT6360_SLAVE_LDO) {
+		crc_needed = true;
+		ret = mt6360_xlate_pmicldo_addr(&reg_addr, val_size - 2);
+		if (ret < 0)
+			return ret;
+	}
+
+	buf = kzalloc(alloc_size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	/* 7 bit slave addr + write bit */
+	buf[0] = ((i2c->addr & 0x7f) << 1);
+	buf[1] = reg_addr;
+	/* val need to minus regaddr 16bit */
+	memcpy(buf + 2, val + 2, write_size);
+
+	if (crc_needed) {
+		buf[val_size] = crc8(ddata->crc8_tbl, buf, val_size, 0);
+		write_size += 2;
+	}
+
+	ret = i2c_smbus_write_i2c_block_data(i2c, reg_addr, write_size, buf + 2);
+
+	kfree(buf);
+
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static const struct regmap_bus mt6360_regmap_bus = {
+	.read		= mt6360_regmap_read,
+	.write		= mt6360_regmap_write,
+
+	/* due to pmic and ldo crc access size limit */
+	.max_raw_read	= 4,
+	.max_raw_write	= 4,
+};
+
+static bool mt6360_is_readwrite_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MT6360_REG_TCPCSTART ... MT6360_REG_TCPCEND:
+		fallthrough;
+	case MT6360_REG_PMICSTART ... MT6360_REG_PMICEND:
+		fallthrough;
+	case MT6360_REG_LDOSTART ... MT6360_REG_LDOEND:
+		fallthrough;
+	case MT6360_REG_PMUSTART ... MT6360_REG_PMUEND:
+		return true;
+	}
+
+	return false;
+}
+
+static const struct regmap_config mt6360_regmap_config = {
+	.reg_bits		= 16,
+	.val_bits		= 8,
+	.reg_format_endian	= REGMAP_ENDIAN_BIG,
+	.max_register		= MT6360_REG_PMUEND,
+	.writeable_reg		= mt6360_is_readwrite_reg,
+	.readable_reg		= mt6360_is_readwrite_reg,
 };
 
 static int mt6360_probe(struct i2c_client *client)
@@ -329,9 +521,23 @@ static int mt6360_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	ddata->dev = &client->dev;
-	i2c_set_clientdata(client, ddata);
 
-	ddata->regmap = devm_regmap_init_i2c(client, &mt6360_pmu_regmap_config);
+	for (i = 0; i < MT6360_SLAVE_MAX - 1; i++) {
+		ddata->i2c[i] = devm_i2c_new_dummy_device(&client->dev,
+							  client->adapter,
+							  mt6360_slave_addrs[i]);
+		if (IS_ERR(ddata->i2c[i])) {
+			dev_err(&client->dev,
+				"Failed to get new dummy I2C device for address 0x%x",
+				mt6360_slave_addrs[i]);
+			return PTR_ERR(ddata->i2c[i]);
+		}
+	}
+	ddata->i2c[MT6360_SLAVE_MAX - 1] = client;
+
+	crc8_populate_msb(ddata->crc8_tbl, MT6360_CRC8_POLYNOMIAL);
+	ddata->regmap = __devm_regmap_init(ddata->dev, &mt6360_regmap_bus, ddata,
+					   &mt6360_regmap_config, NULL, NULL);
 	if (IS_ERR(ddata->regmap)) {
 		dev_err(&client->dev, "Failed to register regmap\n");
 		return PTR_ERR(ddata->regmap);
@@ -341,34 +547,18 @@ static int mt6360_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	ret = devm_regmap_add_irq_chip(&client->dev, ddata->regmap, client->irq,
-				       0, 0, &mt6360_irq_chip,
-				       &ddata->irq_data);
+	ret = devm_regmap_add_irq_chip(&client->dev, ddata->regmap, client->irq, 0, 0,
+				       &mt6360_irq_chip, &ddata->irq_data);
 	if (ret) {
 		dev_err(&client->dev, "Failed to add Regmap IRQ Chip\n");
 		return ret;
 	}
 
-	ddata->i2c[0] = client;
-	for (i = 1; i < MT6360_SLAVE_MAX; i++) {
-		ddata->i2c[i] = devm_i2c_new_dummy_device(&client->dev,
-							client->adapter,
-							mt6360_slave_addr[i]);
-		if (IS_ERR(ddata->i2c[i])) {
-			dev_err(&client->dev,
-				"Failed to get new dummy I2C device for address 0x%x",
-				mt6360_slave_addr[i]);
-			return PTR_ERR(ddata->i2c[i]);
-		}
-		i2c_set_clientdata(ddata->i2c[i], ddata);
-	}
-
-	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO,
-				   mt6360_devs, ARRAY_SIZE(mt6360_devs), NULL,
-				   0, regmap_irq_get_domain(ddata->irq_data));
+	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO, mt6360_devs,
+				   ARRAY_SIZE(mt6360_devs), NULL, 0,
+				   regmap_irq_get_domain(ddata->irq_data));
 	if (ret) {
-		dev_err(&client->dev,
-			"Failed to register subordinate devices\n");
+		dev_err(&client->dev, "Failed to register subordinate devices\n");
 		return ret;
 	}
 
diff --git a/include/linux/mfd/mt6360.h b/include/linux/mfd/mt6360.h
deleted file mode 100644
index da0fb5c..0000000
--- a/include/linux/mfd/mt6360.h
+++ /dev/null
@@ -1,240 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2020 MediaTek Inc.
- */
-
-#ifndef __MT6360_H__
-#define __MT6360_H__
-
-#include <linux/regmap.h>
-
-enum {
-	MT6360_SLAVE_PMU = 0,
-	MT6360_SLAVE_PMIC,
-	MT6360_SLAVE_LDO,
-	MT6360_SLAVE_TCPC,
-	MT6360_SLAVE_MAX,
-};
-
-#define MT6360_PMU_SLAVEID	0x34
-#define MT6360_PMIC_SLAVEID	0x1A
-#define MT6360_LDO_SLAVEID	0x64
-#define MT6360_TCPC_SLAVEID	0x4E
-
-struct mt6360_data {
-	struct i2c_client *i2c[MT6360_SLAVE_MAX];
-	struct device *dev;
-	struct regmap *regmap;
-	struct regmap_irq_chip_data *irq_data;
-	unsigned int chip_rev;
-};
-
-/* PMU register defininition */
-#define MT6360_PMU_DEV_INFO			0x00
-#define MT6360_PMU_CORE_CTRL1			0x01
-#define MT6360_PMU_RST1				0x02
-#define MT6360_PMU_CRCEN			0x03
-#define MT6360_PMU_RST_PAS_CODE1		0x04
-#define MT6360_PMU_RST_PAS_CODE2		0x05
-#define MT6360_PMU_CORE_CTRL2			0x06
-#define MT6360_PMU_TM_PAS_CODE1			0x07
-#define MT6360_PMU_TM_PAS_CODE2			0x08
-#define MT6360_PMU_TM_PAS_CODE3			0x09
-#define MT6360_PMU_TM_PAS_CODE4			0x0A
-#define MT6360_PMU_IRQ_IND			0x0B
-#define MT6360_PMU_IRQ_MASK			0x0C
-#define MT6360_PMU_IRQ_SET			0x0D
-#define MT6360_PMU_SHDN_CTRL			0x0E
-#define MT6360_PMU_TM_INF			0x0F
-#define MT6360_PMU_I2C_CTRL			0x10
-#define MT6360_PMU_CHG_CTRL1			0x11
-#define MT6360_PMU_CHG_CTRL2			0x12
-#define MT6360_PMU_CHG_CTRL3			0x13
-#define MT6360_PMU_CHG_CTRL4			0x14
-#define MT6360_PMU_CHG_CTRL5			0x15
-#define MT6360_PMU_CHG_CTRL6			0x16
-#define MT6360_PMU_CHG_CTRL7			0x17
-#define MT6360_PMU_CHG_CTRL8			0x18
-#define MT6360_PMU_CHG_CTRL9			0x19
-#define MT6360_PMU_CHG_CTRL10			0x1A
-#define MT6360_PMU_CHG_CTRL11			0x1B
-#define MT6360_PMU_CHG_CTRL12			0x1C
-#define MT6360_PMU_CHG_CTRL13			0x1D
-#define MT6360_PMU_CHG_CTRL14			0x1E
-#define MT6360_PMU_CHG_CTRL15			0x1F
-#define MT6360_PMU_CHG_CTRL16			0x20
-#define MT6360_PMU_CHG_AICC_RESULT		0x21
-#define MT6360_PMU_DEVICE_TYPE			0x22
-#define MT6360_PMU_QC_CONTROL1			0x23
-#define MT6360_PMU_QC_CONTROL2			0x24
-#define MT6360_PMU_QC30_CONTROL1		0x25
-#define MT6360_PMU_QC30_CONTROL2		0x26
-#define MT6360_PMU_USB_STATUS1			0x27
-#define MT6360_PMU_QC_STATUS1			0x28
-#define MT6360_PMU_QC_STATUS2			0x29
-#define MT6360_PMU_CHG_PUMP			0x2A
-#define MT6360_PMU_CHG_CTRL17			0x2B
-#define MT6360_PMU_CHG_CTRL18			0x2C
-#define MT6360_PMU_CHRDET_CTRL1			0x2D
-#define MT6360_PMU_CHRDET_CTRL2			0x2E
-#define MT6360_PMU_DPDN_CTRL			0x2F
-#define MT6360_PMU_CHG_HIDDEN_CTRL1		0x30
-#define MT6360_PMU_CHG_HIDDEN_CTRL2		0x31
-#define MT6360_PMU_CHG_HIDDEN_CTRL3		0x32
-#define MT6360_PMU_CHG_HIDDEN_CTRL4		0x33
-#define MT6360_PMU_CHG_HIDDEN_CTRL5		0x34
-#define MT6360_PMU_CHG_HIDDEN_CTRL6		0x35
-#define MT6360_PMU_CHG_HIDDEN_CTRL7		0x36
-#define MT6360_PMU_CHG_HIDDEN_CTRL8		0x37
-#define MT6360_PMU_CHG_HIDDEN_CTRL9		0x38
-#define MT6360_PMU_CHG_HIDDEN_CTRL10		0x39
-#define MT6360_PMU_CHG_HIDDEN_CTRL11		0x3A
-#define MT6360_PMU_CHG_HIDDEN_CTRL12		0x3B
-#define MT6360_PMU_CHG_HIDDEN_CTRL13		0x3C
-#define MT6360_PMU_CHG_HIDDEN_CTRL14		0x3D
-#define MT6360_PMU_CHG_HIDDEN_CTRL15		0x3E
-#define MT6360_PMU_CHG_HIDDEN_CTRL16		0x3F
-#define MT6360_PMU_CHG_HIDDEN_CTRL17		0x40
-#define MT6360_PMU_CHG_HIDDEN_CTRL18		0x41
-#define MT6360_PMU_CHG_HIDDEN_CTRL19		0x42
-#define MT6360_PMU_CHG_HIDDEN_CTRL20		0x43
-#define MT6360_PMU_CHG_HIDDEN_CTRL21		0x44
-#define MT6360_PMU_CHG_HIDDEN_CTRL22		0x45
-#define MT6360_PMU_CHG_HIDDEN_CTRL23		0x46
-#define MT6360_PMU_CHG_HIDDEN_CTRL24		0x47
-#define MT6360_PMU_CHG_HIDDEN_CTRL25		0x48
-#define MT6360_PMU_BC12_CTRL			0x49
-#define MT6360_PMU_CHG_STAT			0x4A
-#define MT6360_PMU_RESV1			0x4B
-#define MT6360_PMU_TYPEC_OTP_TH_SEL_CODEH	0x4E
-#define MT6360_PMU_TYPEC_OTP_TH_SEL_CODEL	0x4F
-#define MT6360_PMU_TYPEC_OTP_HYST_TH		0x50
-#define MT6360_PMU_TYPEC_OTP_CTRL		0x51
-#define MT6360_PMU_ADC_BAT_DATA_H		0x52
-#define MT6360_PMU_ADC_BAT_DATA_L		0x53
-#define MT6360_PMU_IMID_BACKBST_ON		0x54
-#define MT6360_PMU_IMID_BACKBST_OFF		0x55
-#define MT6360_PMU_ADC_CONFIG			0x56
-#define MT6360_PMU_ADC_EN2			0x57
-#define MT6360_PMU_ADC_IDLE_T			0x58
-#define MT6360_PMU_ADC_RPT_1			0x5A
-#define MT6360_PMU_ADC_RPT_2			0x5B
-#define MT6360_PMU_ADC_RPT_3			0x5C
-#define MT6360_PMU_ADC_RPT_ORG1			0x5D
-#define MT6360_PMU_ADC_RPT_ORG2			0x5E
-#define MT6360_PMU_BAT_OVP_TH_SEL_CODEH		0x5F
-#define MT6360_PMU_BAT_OVP_TH_SEL_CODEL		0x60
-#define MT6360_PMU_CHG_CTRL19			0x61
-#define MT6360_PMU_VDDASUPPLY			0x62
-#define MT6360_PMU_BC12_MANUAL			0x63
-#define MT6360_PMU_CHGDET_FUNC			0x64
-#define MT6360_PMU_FOD_CTRL			0x65
-#define MT6360_PMU_CHG_CTRL20			0x66
-#define MT6360_PMU_CHG_HIDDEN_CTRL26		0x67
-#define MT6360_PMU_CHG_HIDDEN_CTRL27		0x68
-#define MT6360_PMU_RESV2			0x69
-#define MT6360_PMU_USBID_CTRL1			0x6D
-#define MT6360_PMU_USBID_CTRL2			0x6E
-#define MT6360_PMU_USBID_CTRL3			0x6F
-#define MT6360_PMU_FLED_CFG			0x70
-#define MT6360_PMU_RESV3			0x71
-#define MT6360_PMU_FLED1_CTRL			0x72
-#define MT6360_PMU_FLED_STRB_CTRL		0x73
-#define MT6360_PMU_FLED1_STRB_CTRL2		0x74
-#define MT6360_PMU_FLED1_TOR_CTRL		0x75
-#define MT6360_PMU_FLED2_CTRL			0x76
-#define MT6360_PMU_RESV4			0x77
-#define MT6360_PMU_FLED2_STRB_CTRL2		0x78
-#define MT6360_PMU_FLED2_TOR_CTRL		0x79
-#define MT6360_PMU_FLED_VMIDTRK_CTRL1		0x7A
-#define MT6360_PMU_FLED_VMID_RTM		0x7B
-#define MT6360_PMU_FLED_VMIDTRK_CTRL2		0x7C
-#define MT6360_PMU_FLED_PWSEL			0x7D
-#define MT6360_PMU_FLED_EN			0x7E
-#define MT6360_PMU_FLED_Hidden1			0x7F
-#define MT6360_PMU_RGB_EN			0x80
-#define MT6360_PMU_RGB1_ISNK			0x81
-#define MT6360_PMU_RGB2_ISNK			0x82
-#define MT6360_PMU_RGB3_ISNK			0x83
-#define MT6360_PMU_RGB_ML_ISNK			0x84
-#define MT6360_PMU_RGB1_DIM			0x85
-#define MT6360_PMU_RGB2_DIM			0x86
-#define MT6360_PMU_RGB3_DIM			0x87
-#define MT6360_PMU_RESV5			0x88
-#define MT6360_PMU_RGB12_Freq			0x89
-#define MT6360_PMU_RGB34_Freq			0x8A
-#define MT6360_PMU_RGB1_Tr			0x8B
-#define MT6360_PMU_RGB1_Tf			0x8C
-#define MT6360_PMU_RGB1_TON_TOFF		0x8D
-#define MT6360_PMU_RGB2_Tr			0x8E
-#define MT6360_PMU_RGB2_Tf			0x8F
-#define MT6360_PMU_RGB2_TON_TOFF		0x90
-#define MT6360_PMU_RGB3_Tr			0x91
-#define MT6360_PMU_RGB3_Tf			0x92
-#define MT6360_PMU_RGB3_TON_TOFF		0x93
-#define MT6360_PMU_RGB_Hidden_CTRL1		0x94
-#define MT6360_PMU_RGB_Hidden_CTRL2		0x95
-#define MT6360_PMU_RESV6			0x97
-#define MT6360_PMU_SPARE1			0x9A
-#define MT6360_PMU_SPARE2			0xA0
-#define MT6360_PMU_SPARE3			0xB0
-#define MT6360_PMU_SPARE4			0xC0
-#define MT6360_PMU_CHG_IRQ1			0xD0
-#define MT6360_PMU_CHG_IRQ2			0xD1
-#define MT6360_PMU_CHG_IRQ3			0xD2
-#define MT6360_PMU_CHG_IRQ4			0xD3
-#define MT6360_PMU_CHG_IRQ5			0xD4
-#define MT6360_PMU_CHG_IRQ6			0xD5
-#define MT6360_PMU_QC_IRQ			0xD6
-#define MT6360_PMU_FOD_IRQ			0xD7
-#define MT6360_PMU_BASE_IRQ			0xD8
-#define MT6360_PMU_FLED_IRQ1			0xD9
-#define MT6360_PMU_FLED_IRQ2			0xDA
-#define MT6360_PMU_RGB_IRQ			0xDB
-#define MT6360_PMU_BUCK1_IRQ			0xDC
-#define MT6360_PMU_BUCK2_IRQ			0xDD
-#define MT6360_PMU_LDO_IRQ1			0xDE
-#define MT6360_PMU_LDO_IRQ2			0xDF
-#define MT6360_PMU_CHG_STAT1			0xE0
-#define MT6360_PMU_CHG_STAT2			0xE1
-#define MT6360_PMU_CHG_STAT3			0xE2
-#define MT6360_PMU_CHG_STAT4			0xE3
-#define MT6360_PMU_CHG_STAT5			0xE4
-#define MT6360_PMU_CHG_STAT6			0xE5
-#define MT6360_PMU_QC_STAT			0xE6
-#define MT6360_PMU_FOD_STAT			0xE7
-#define MT6360_PMU_BASE_STAT			0xE8
-#define MT6360_PMU_FLED_STAT1			0xE9
-#define MT6360_PMU_FLED_STAT2			0xEA
-#define MT6360_PMU_RGB_STAT			0xEB
-#define MT6360_PMU_BUCK1_STAT			0xEC
-#define MT6360_PMU_BUCK2_STAT			0xED
-#define MT6360_PMU_LDO_STAT1			0xEE
-#define MT6360_PMU_LDO_STAT2			0xEF
-#define MT6360_PMU_CHG_MASK1			0xF0
-#define MT6360_PMU_CHG_MASK2			0xF1
-#define MT6360_PMU_CHG_MASK3			0xF2
-#define MT6360_PMU_CHG_MASK4			0xF3
-#define MT6360_PMU_CHG_MASK5			0xF4
-#define MT6360_PMU_CHG_MASK6			0xF5
-#define MT6360_PMU_QC_MASK			0xF6
-#define MT6360_PMU_FOD_MASK			0xF7
-#define MT6360_PMU_BASE_MASK			0xF8
-#define MT6360_PMU_FLED_MASK1			0xF9
-#define MT6360_PMU_FLED_MASK2			0xFA
-#define MT6360_PMU_FAULTB_MASK			0xFB
-#define MT6360_PMU_BUCK1_MASK			0xFC
-#define MT6360_PMU_BUCK2_MASK			0xFD
-#define MT6360_PMU_LDO_MASK1			0xFE
-#define MT6360_PMU_LDO_MASK2			0xFF
-#define MT6360_PMU_MAXREG			MT6360_PMU_LDO_MASK2
-
-/* MT6360_PMU_IRQ_SET */
-#define MT6360_PMU_IRQ_REGNUM	16
-#define MT6360_IRQ_RETRIG	BIT(2)
-
-#define CHIP_VEN_MASK				0xF0
-#define CHIP_VEN_MT6360				0x50
-#define CHIP_REV_MASK				0x0F
-
-#endif /* __MT6360_H__ */
-- 
2.7.4

