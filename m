Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5B3C2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B6F206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgDFIzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 04:55:08 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.113]:56066 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726626AbgDFIy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 04:54:59 -0400
Received: from [100.113.5.27] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.eu-central-1.aws.symcld.net id F5/BA-36561-16EEA8E5; Mon, 06 Apr 2020 08:54:57 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRWlGSWpSXmKPExsVy8MN7Xd2Ed11
  xBv33rC3ufz3KaHF51xw2ByaPO9f2sHl83iQXwBTFmpmXlF+RwJqxZql+wQ7/ihcT7rA2MPa6
  dDFycQgJrGWUuLN0PlsXIyeQUyEx+8orVhCbVyBTYltLFzuIzSngLnF771FGiBo3iUuPvrOA2
  GwCFhKTTzwA62URUJHY/qQLrEZYIFHi0PXJQL0cHCJA8XNvzEFMZoEIiT+nmCGmC0qcnPkEbA
  qzgITEwRcvmCGmG0icXtDIMoGRdxaSsllIyhYwMq1itEwqykzPKMlNzMzRNTQw0DU0NNY1BbL
  M9RKrdJP0Ukt1k1PzSooSgbJ6ieXFesWVuck5KXp5qSWbGIHBllLImr2Dcev893qHGCU5mJRE
  eae+6IoT4kvKT6nMSCzOiC8qzUktPsQow8GhJMF74DVQTrAoNT21Ii0zBxj4MGkJDh4lEd4lr
  4DSvMUFibnFmekQqVOMuhw7j85bxCzEkpeflyolznvnDVCRAEhRRmke3AhYFF5ilJUS5mVkYG
  AQ4ilILcrNLEGVf8UozsGoJMy7G2QKT2ZeCdymV0BHMAEdwZbXDnJESSJCSqqBSenqE9fX8hd
  93t2d/2zDqX375zJsKEz/ys5+SOnVdf2Wy5UbEj+8PnY3rftYrrV3c9KFI66fLu+Yl8P17sY7
  l7D/ElWNH4Sn7vA28DI2ajNXeXkwmWEH67tAlXVejvuXF2qmLyizlOEtb/q2huVdyOxJ72YIW
  f5QlxQo7X7OXsd1euKWKWv01Z5yXHC3f5WpGloc8U/f7uedzaxPpGvv1koYGZamZDInaqyYHB
  GW9kJP0v3Grczmfen6P89dOcoqobY7qrTnPWeCx3GWknOmzPzTd60x7DESOeMY+H569OKVFx6
  qS2x1L7n24kqf1cQuKfd7fNNFDepzZ5pzTsyerfxz2fKt+naMKX/X6SkmKrEUZyQaajEXFScC
  AAM96UU9AwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-11.tower-246.messagelabs.com!1586163296!907083!1
X-Originating-IP: [193.240.239.45]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28985 invoked from network); 6 Apr 2020 08:54:56 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (193.240.239.45)
  by server-11.tower-246.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 6 Apr 2020 08:54:56 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Mon, 6 Apr 2020 10:54:56 +0200
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 0E7A93FBE5; Mon,  6 Apr 2020 09:54:56 +0100 (BST)
Message-ID: <f830d0c2c2210253855d26c05b0e941e9e6f77a9.1586162737.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1586162737.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1586162737.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Mon, 6 Apr 2020 09:54:56 +0100
Subject: [RESEND PATCH v2 1/2] mfd: da9063: Fix revision handling to correctly select
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

