Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E32C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109D920637
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgCCKpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:45:55 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.1]:58831 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728656AbgCCKpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:45:54 -0500
Received: from [100.113.1.168] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-central-1.aws.symcld.net id 80/B0-28499-E553E5E5; Tue, 03 Mar 2020 10:45:50 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRWlGSWpSXmKPExsVy8IPnUd1Y07g
  4g+MrTSzufz3KaHF51xw2ByaPO9f2sHl83iQXwBTFmpmXlF+RwJqxZql+wQ7/ihcT7rA2MPa6
  dDFycQgJrGOUeHzlAmMXIyeQUyHxt2caM4jNK5ApsfrfAzYQm1PAXeLB7lNsEDVuEofe/GEHs
  dkELCQmn4CoYRFQkVjSdQCsV1ggSuLP7ulANgeHCFD83BtzEJNZIELizymo6YISJ2c+YQGxmQ
  UkJA6+eMEMMd1A4vSCRpYJjLyzkJTNQlK2gJFpFaNlUlFmekZJbmJmjq6hgYGuoaGxrqGukYG
  JXmKVbqJeaqlucmpeSVEiUFYvsbxYr7gyNzknRS8vtWQTIzDYUgoZz+xg3LX8vd4hRkkOJiVR
  3kyhuDghvqT8lMqMxOKM+KLSnNTiQ4wyHBxKErxzjIFygkWp6akVaZk5wMCHSUtw8CiJ8KaDp
  HmLCxJzizPTIVKnGHU5dh6dt4hZiCUvPy9VSpx3nglQkQBIUUZpHtwIWBReYpSVEuZlZGBgEO
  IpSC3KzSxBlX/FKM7BqCTMOx9kCk9mXgncpldARzABHdHzPBrkiJJEhJRUA1PnnstBaY9vri/
  Lbxfw2fT65Dozv+OPlUTuM0/fwWkd+0fJJWjNd8P7ezjY4mxdFn7JF2GYYPYvMvn2pgbD2ntn
  kuZMqVPaw9/3anOe0fbzlg1rzwq9W5DlLlw/oXX/vJTwFhVd22sCE6adWcP3jJvVybl4ZsJKP
  iV/j98ztf2nL9eVlfXbdO3+eu8JdzZNLbLduV9tos2Bhq2PHKKOPL+/VF/OWnHyJOnXk5gVSt
  S6ddm+G543r6itzej8YRu1ozXDa77pujOtVndOL+hxuqXO7Xxjvc+173HnVPeukXMMNtnb1j/
  9bJjDlBPxGgU+G2Ns7O6+0pzlKbc+v7hJ8tEfeeN23899KUvuBi788E2JpTgj0VCLuag4EQAC
  G5LLPQMAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-3.tower-233.messagelabs.com!1583232349!325232!2
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19393 invoked from network); 3 Mar 2020 10:45:49 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-3.tower-233.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 3 Mar 2020 10:45:49 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.468.0; Tue, 3 Mar 2020 10:45:49 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 5E4973FBE5; Tue,  3 Mar 2020 10:45:49 +0000 (GMT)
Message-ID: <4a30d41286c84ebf349ac1933f911e9022fca50f.1583231441.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1583231441.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1583231441.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Tue, 3 Mar 2020 10:45:49 +0000
Subject: [PATCH v2 1/2] mfd: da9063: Fix revision handling to correctly select
 reg tables
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation performs checking in the i2c_probe()
function of the variant_code but does this immediately after the
containing struct has been initialised as all zero. This means the
check for variant code will always default to using the BB tables
and will never select AD. The variant code is subsequently set
by device_init() and later used by the RTC so really it's a little
fortunate this mismatch works.

This update adds raw I2C read access functionality to read the chip
and variant/revision information (common to all revisions) so that
it can subsequently correctly choose the proper regmap tables for
real initialisation.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 drivers/mfd/da9063-core.c            |  31 -------
 drivers/mfd/da9063-i2c.c             | 162 +++++++++++++++++++++++++++++++----
 include/linux/mfd/da9063/registers.h |  15 ++--
 3 files changed, 155 insertions(+), 53 deletions(-)

diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
index b125f90d..a353d52 100644
--- a/drivers/mfd/da9063-core.c
+++ b/drivers/mfd/da9063-core.c
@@ -160,7 +160,6 @@ static int da9063_clear_fault_log(struct da9063 *da9063)
 
 int da9063_device_init(struct da9063 *da9063, unsigned int irq)
 {
-	int model, variant_id, variant_code;
 	int ret;
 
 	ret = da9063_clear_fault_log(da9063);
@@ -171,36 +170,6 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
 	da9063->irq_base = -1;
 	da9063->chip_irq = irq;
 
-	ret = regmap_read(da9063->regmap, DA9063_REG_CHIP_ID, &model);
-	if (ret < 0) {
-		dev_err(da9063->dev, "Cannot read chip model id.\n");
-		return -EIO;
-	}
-	if (model != PMIC_CHIP_ID_DA9063) {
-		dev_err(da9063->dev, "Invalid chip model id: 0x%02x\n", model);
-		return -ENODEV;
-	}
-
-	ret = regmap_read(da9063->regmap, DA9063_REG_CHIP_VARIANT, &variant_id);
-	if (ret < 0) {
-		dev_err(da9063->dev, "Cannot read chip variant id.\n");
-		return -EIO;
-	}
-
-	variant_code = variant_id >> DA9063_CHIP_VARIANT_SHIFT;
-
-	dev_info(da9063->dev,
-		 "Device detected (chip-ID: 0x%02X, var-ID: 0x%02X)\n",
-		 model, variant_id);
-
-	if (variant_code < PMIC_DA9063_BB && variant_code != PMIC_DA9063_AD) {
-		dev_err(da9063->dev,
-			"Cannot support variant code: 0x%02X\n", variant_code);
-		return -ENODEV;
-	}
-
-	da9063->variant_code = variant_code;
-
 	ret = da9063_irq_init(da9063);
 	if (ret) {
 		dev_err(da9063->dev, "Cannot initialize interrupts.\n");
diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index 455de74..2654b49 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -22,12 +22,102 @@
 #include <linux/of.h>
 #include <linux/regulator/of_regulator.h>
 
+/*
+ * Raw I2C access required for just accessing chip and variant info before we
+ * know which device is present. The info read from the device using this
+ * approach is then used to select the correct regmap tables.
+ */
+static int da9063_i2c_blockreg_read(struct i2c_client *client, u16 addr,
+				    u8 *buf, int count)
+{
+	struct i2c_msg xfer[3];
+	u8 page_num, paged_addr;
+	u8 page_buf[2];
+	int ret;
+
+	/* Determine page info based on register address */
+	page_num = (addr / 0x100);
+	if (page_num > 1)
+		return -EINVAL;
+
+	paged_addr = (addr % 0x100) & 0xFF;
+	page_buf[0] = DA9063_REG_PAGE_CON;
+	page_buf[1] = (page_num << DA9063_I2C_PAGE_SEL_SHIFT) &
+		      DA9063_REG_PAGE_MASK;
+
+	/* Write reg address, page selection */
+	xfer[0].addr = client->addr;
+	xfer[0].flags = 0;
+	xfer[0].len = 2;
+	xfer[0].buf = page_buf;
+
+	/* Select register address */
+	xfer[1].addr = client->addr;
+	xfer[1].flags = 0;
+	xfer[1].len = 1;
+	xfer[1].buf = &paged_addr;
+
+	/* Read data */
+	xfer[2].addr = client->addr;
+	xfer[2].flags = I2C_M_RD;
+	xfer[2].len = count;
+	xfer[2].buf = buf;
+
+	ret = i2c_transfer(client->adapter, xfer, 3);
+	if (ret == 3)
+		return 0;
+	else if (ret < 0)
+		return ret;
+	else
+		return -EIO;
+}
+
+enum {
+	DA9063_DEV_ID_REG = 0,
+	DA9063_VAR_ID_REG,
+	DA9063_CHIP_ID_REGS,
+};
+
+static int da9063_get_device_type(struct i2c_client *i2c, struct da9063 *da9063)
+{
+	int ret;
+	u8 buf[DA9063_CHIP_ID_REGS];
+
+	ret = da9063_i2c_blockreg_read(i2c, DA9063_REG_DEVICE_ID, buf,
+				       DA9063_CHIP_ID_REGS);
+	if (ret < 0) {
+		dev_err(da9063->dev, "Cannot read chip id info.\n");
+		return ret;
+	}
+
+	if (buf[DA9063_DEV_ID_REG] != PMIC_CHIP_ID_DA9063) {
+		dev_err(da9063->dev,
+			"Invalid chip device id: 0x%02x\n",
+			buf[DA9063_DEV_ID_REG]);
+		return -ENODEV;
+	}
+
+	dev_info(da9063->dev,
+		 "Device detected (chip-ID: 0x%02X, var-ID: 0x%02X)\n",
+		 buf[DA9063_DEV_ID_REG], buf[DA9063_VAR_ID_REG]);
+
+	da9063->variant_code =
+		(buf[DA9063_VAR_ID_REG] & DA9063_VARIANT_ID_MRC_MASK)
+		>> DA9063_VARIANT_ID_MRC_SHIFT;
+
+	return 0;
+}
+
+/*
+ * Variant specific regmap configs
+ */
+
 static const struct regmap_range da9063_ad_readable_ranges[] = {
 	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_AD_REG_SECOND_D),
 	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_ID_32_31),
 	regmap_reg_range(DA9063_REG_SEQ_A, DA9063_REG_AUTO3_LOW),
 	regmap_reg_range(DA9063_REG_T_OFFSET, DA9063_AD_REG_GP_ID_19),
-	regmap_reg_range(DA9063_REG_CHIP_ID, DA9063_REG_CHIP_VARIANT),
+	regmap_reg_range(DA9063_REG_DEVICE_ID, DA9063_REG_VARIANT_ID),
 };
 
 static const struct regmap_range da9063_ad_writeable_ranges[] = {
@@ -72,7 +162,7 @@
 	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_ID_32_31),
 	regmap_reg_range(DA9063_REG_SEQ_A, DA9063_REG_AUTO3_LOW),
 	regmap_reg_range(DA9063_REG_T_OFFSET, DA9063_BB_REG_GP_ID_19),
-	regmap_reg_range(DA9063_REG_CHIP_ID, DA9063_REG_CHIP_VARIANT),
+	regmap_reg_range(DA9063_REG_DEVICE_ID, DA9063_REG_VARIANT_ID),
 };
 
 static const struct regmap_range da9063_bb_writeable_ranges[] = {
@@ -117,7 +207,7 @@
 	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_ID_32_31),
 	regmap_reg_range(DA9063_REG_SEQ_A, DA9063_REG_AUTO3_LOW),
 	regmap_reg_range(DA9063_REG_T_OFFSET, DA9063_BB_REG_GP_ID_19),
-	regmap_reg_range(DA9063_REG_CHIP_ID, DA9063_REG_CHIP_VARIANT),
+	regmap_reg_range(DA9063_REG_DEVICE_ID, DA9063_REG_VARIANT_ID),
 };
 
 static const struct regmap_range da9063l_bb_writeable_ranges[] = {
@@ -159,7 +249,7 @@
 static const struct regmap_range_cfg da9063_range_cfg[] = {
 	{
 		.range_min = DA9063_REG_PAGE_CON,
-		.range_max = DA9063_REG_CHIP_VARIANT,
+		.range_max = DA9063_REG_CONFIG_ID,
 		.selector_reg = DA9063_REG_PAGE_CON,
 		.selector_mask = 1 << DA9063_I2C_PAGE_SEL_SHIFT,
 		.selector_shift = DA9063_I2C_PAGE_SEL_SHIFT,
@@ -173,7 +263,7 @@
 	.val_bits = 8,
 	.ranges = da9063_range_cfg,
 	.num_ranges = ARRAY_SIZE(da9063_range_cfg),
-	.max_register = DA9063_REG_CHIP_VARIANT,
+	.max_register = DA9063_REG_CONFIG_ID,
 
 	.cache_type = REGCACHE_RBTREE,
 };
@@ -199,18 +289,56 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
 	da9063->chip_irq = i2c->irq;
 	da9063->type = id->driver_data;
 
-	if (da9063->variant_code == PMIC_DA9063_AD) {
-		da9063_regmap_config.rd_table = &da9063_ad_readable_table;
-		da9063_regmap_config.wr_table = &da9063_ad_writeable_table;
-		da9063_regmap_config.volatile_table = &da9063_ad_volatile_table;
-	} else if (da9063->type == PMIC_TYPE_DA9063L) {
-		da9063_regmap_config.rd_table = &da9063l_bb_readable_table;
-		da9063_regmap_config.wr_table = &da9063l_bb_writeable_table;
-		da9063_regmap_config.volatile_table = &da9063l_bb_volatile_table;
-	} else {
-		da9063_regmap_config.rd_table = &da9063_bb_readable_table;
-		da9063_regmap_config.wr_table = &da9063_bb_writeable_table;
-		da9063_regmap_config.volatile_table = &da9063_bb_volatile_table;
+	ret = da9063_get_device_type(i2c, da9063);
+	if (ret < 0)
+		return ret;
+
+	switch (da9063->type) {
+	case PMIC_TYPE_DA9063:
+		switch (da9063->variant_code) {
+		case PMIC_DA9063_AD:
+			da9063_regmap_config.rd_table =
+				&da9063_ad_readable_table;
+			da9063_regmap_config.wr_table =
+				&da9063_ad_writeable_table;
+			da9063_regmap_config.volatile_table =
+				&da9063_ad_volatile_table;
+			break;
+		case PMIC_DA9063_BB:
+		case PMIC_DA9063_CA:
+			da9063_regmap_config.rd_table =
+				&da9063_bb_readable_table;
+			da9063_regmap_config.wr_table =
+				&da9063_bb_writeable_table;
+			da9063_regmap_config.volatile_table =
+				&da9063_bb_volatile_table;
+			break;
+		default:
+			dev_err(da9063->dev,
+				"Chip variant not supported for DA9063\n");
+			return -ENODEV;
+		}
+		break;
+	case PMIC_TYPE_DA9063L:
+		switch (da9063->variant_code) {
+		case PMIC_DA9063_BB:
+		case PMIC_DA9063_CA:
+			da9063_regmap_config.rd_table =
+				&da9063l_bb_readable_table;
+			da9063_regmap_config.wr_table =
+				&da9063l_bb_writeable_table;
+			da9063_regmap_config.volatile_table =
+				&da9063l_bb_volatile_table;
+			break;
+		default:
+			dev_err(da9063->dev,
+				"Chip variant not supported for DA9063L\n");
+			return -ENODEV;
+		}
+		break;
+	default:
+		dev_err(da9063->dev, "Chip type not supported\n");
+		return -ENODEV;
 	}
 
 	da9063->regmap = devm_regmap_init_i2c(i2c, &da9063_regmap_config);
diff --git a/include/linux/mfd/da9063/registers.h b/include/linux/mfd/da9063/registers.h
index ba706b0..1dbabf1 100644
--- a/include/linux/mfd/da9063/registers.h
+++ b/include/linux/mfd/da9063/registers.h
@@ -292,8 +292,10 @@
 #define	DA9063_BB_REG_GP_ID_19		0x134
 
 /* Chip ID and variant */
-#define	DA9063_REG_CHIP_ID		0x181
-#define	DA9063_REG_CHIP_VARIANT		0x182
+#define	DA9063_REG_DEVICE_ID		0x181
+#define	DA9063_REG_VARIANT_ID		0x182
+#define	DA9063_REG_CUSTOMER_ID		0x183
+#define	DA9063_REG_CONFIG_ID		0x184
 
 /*
  * PMIC registers bits
@@ -929,9 +931,6 @@
 #define	DA9063_RTC_CLOCK			0x40
 #define	DA9063_OUT_32K_EN			0x80
 
-/* DA9063_REG_CHIP_VARIANT */
-#define	DA9063_CHIP_VARIANT_SHIFT		4
-
 /* DA9063_REG_BUCK_ILIM_A (addr=0x9A) */
 #define DA9063_BIO_ILIM_MASK			0x0F
 #define DA9063_BMEM_ILIM_MASK			0xF0
@@ -1065,4 +1064,10 @@
 #define		DA9063_MON_A10_IDX_LDO9		0x04
 #define		DA9063_MON_A10_IDX_LDO10	0x05
 
+/* DA9063_REG_VARIANT_ID (addr=0x182) */
+#define	DA9063_VARIANT_ID_VRC_SHIFT		0
+#define DA9063_VARIANT_ID_VRC_MASK		0x0F
+#define	DA9063_VARIANT_ID_MRC_SHIFT		4
+#define DA9063_VARIANT_ID_MRC_MASK		0xF0
+
 #endif /* _DA9063_REG_H */
-- 
1.9.1

