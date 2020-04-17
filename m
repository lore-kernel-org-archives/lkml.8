Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E93BC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58E9D21D94
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbgDQK4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:56:00 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.115]:60521 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729645AbgDQKzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:55:49 -0400
Received: from [100.113.7.14] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.eu-central-1.aws.symcld.net id DD/19-46409-23B899E5; Fri, 17 Apr 2020 10:55:46 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRWlGSWpSXmKPExsVy8MN7XV2j7pl
  xBtvWc1rc/3qU0eLyrjlsDkwed67tYfP4vEkugCmKNTMvKb8igTXj5IRrzAX/wyseX1vP3sC4
  xKeLkYtDSGAdo8TXno0sXYycQE6FxMer29lAbF6BTIk3tw+yg9icAu4SRzY/Y4SocZOYN+crE
  4jNJmAhMfnEA7B6FgFViSnXmlhBbGGBKIn/l/4B2RwcIgIqEufemIOYzAIREn9OMUNMF5Q4Of
  MJ2FZmAQmJgy9eMENMN5A4vaCRZQIj7ywkZbOQlC1gZFrFaJlUlJmeUZKbmJmja2hgoGtoaKx
  rCmSZ6yVW6SbppZbqJqfmlRQlAmX1EsuL9Yorc5NzUvTyUks2MQLDLaWQNXsH49b57/UOMUpy
  MCmJ8iq1zYwT4kvKT6nMSCzOiC8qzUktPsQow8GhJMFb0gWUEyxKTU+tSMvMAYY+TFqCg0dJh
  DexEyjNW1yQmFucmQ6ROsWoy7Hz6LxFzEIsefl5qVLivDIgMwRAijJK8+BGwOLwEqOslDAvIw
  MDgxBPQWpRbmYJqvwrRnEORiVhXmaQKTyZeSVwm14BHcEEdES0w3SQI0oSEVJSDUzsRmvuP+v
  1rl43W/HehjJ5nhf7f5exXHl20ibPWb8wKLb95N+0+dWXrTsfZa2tUX13MCjt9NHyaMfoZfOu
  N84+UBauzff8V9zX9OJC3p0G7ptjjXneTPRUup+933fafqWyWy2XvRPtvE+JtKl/nNmlpsPtK
  i+0qaktxVqq8l5nr1nD3xSRvSornxokTVwlKLlI/aiRF/feXabtJ26+0TQu3Sph8zQ+emowz9
  pe9bfZR7cfbrm75sJ6Fs7Oiv/fZp6rmMDx9U5Qc5fuBI95+pU3Hxa+0F6W++HiO/H58mkVr+2
  +JkpvMcng0LmbL66/241p2t42HTe21zmndl07e8BqhjBXccDS3W0vrb78P6LEUpyRaKjFXFSc
  CAARnsQFPgMAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-30.tower-239.messagelabs.com!1587120945!1553138!1
X-Originating-IP: [193.240.239.45]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5369 invoked from network); 17 Apr 2020 10:55:46 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (193.240.239.45)
  by server-30.tower-239.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 17 Apr 2020 10:55:46 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Fri, 17 Apr 2020 12:55:45 +0200
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 1D0F73FBE5; Fri, 17 Apr 2020 11:55:45 +0100 (BST)
Message-ID: <a019b698f0c643455e07e7a94dcf0478b1b1f4d4.1587120185.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1587120185.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1587120185.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Fri, 17 Apr 2020 11:55:45 +0100
Subject: [PATCH v3 1/2] mfd: da9063: Fix revision handling to correctly select
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
 drivers/mfd/da9063-core.c            |  31 ------
 drivers/mfd/da9063-i2c.c             | 184 +++++++++++++++++++++++++++++++----
 include/linux/mfd/da9063/registers.h |  15 ++-
 3 files changed, 177 insertions(+), 53 deletions(-)

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
index 455de74..4815489 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -22,12 +22,124 @@
 #include <linux/of.h>
 #include <linux/regulator/of_regulator.h>
 
+/*
+ * Raw I2C access required for just accessing chip and variant info before we
+ * know which device is present. The info read from the device using this
+ * approach is then used to select the correct regmap tables.
+ */
+
+#define DA9063_REG_PAGE_SIZE		0x100
+#define DA9063_REG_PAGED_ADDR_MASK	0xFF
+
+enum da9063_page_sel_buf_fmt {
+	DA9063_PAGE_SEL_BUF_PAGE_REG = 0,
+	DA9063_PAGE_SEL_BUF_PAGE_VAL,
+	DA9063_PAGE_SEL_BUF_SIZE,
+};
+
+enum da9063_paged_read_msgs {
+	DA9063_PAGED_READ_MSG_PAGE_SEL = 0,
+	DA9063_PAGED_READ_MSG_REG_SEL,
+	DA9063_PAGED_READ_MSG_DATA,
+	DA9063_PAGED_READ_MSG_CNT,
+};
+
+static int da9063_i2c_blockreg_read(struct i2c_client *client, u16 addr,
+				    u8 *buf, int count)
+{
+	struct i2c_msg xfer[DA9063_PAGED_READ_MSG_CNT];
+	u8 page_sel_buf[DA9063_PAGE_SEL_BUF_SIZE];
+	u8 page_num, paged_addr;
+	int ret;
+
+	/* Determine page info based on register address */
+	page_num = (addr / DA9063_REG_PAGE_SIZE);
+	if (page_num > 1) {
+		dev_err(&client->dev, "Invalid register address provided\n");
+		return -EINVAL;
+	}
+
+	paged_addr = (addr % DA9063_REG_PAGE_SIZE) & DA9063_REG_PAGED_ADDR_MASK;
+	page_sel_buf[DA9063_PAGE_SEL_BUF_PAGE_REG] = DA9063_REG_PAGE_CON;
+	page_sel_buf[DA9063_PAGE_SEL_BUF_PAGE_VAL] =
+		(page_num << DA9063_I2C_PAGE_SEL_SHIFT) & DA9063_REG_PAGE_MASK;
+
+	/* Write reg address, page selection */
+	xfer[DA9063_PAGED_READ_MSG_PAGE_SEL].addr = client->addr;
+	xfer[DA9063_PAGED_READ_MSG_PAGE_SEL].flags = 0;
+	xfer[DA9063_PAGED_READ_MSG_PAGE_SEL].len = DA9063_PAGE_SEL_BUF_SIZE;
+	xfer[DA9063_PAGED_READ_MSG_PAGE_SEL].buf = page_sel_buf;
+
+	/* Select register address */
+	xfer[DA9063_PAGED_READ_MSG_REG_SEL].addr = client->addr;
+	xfer[DA9063_PAGED_READ_MSG_REG_SEL].flags = 0;
+	xfer[DA9063_PAGED_READ_MSG_REG_SEL].len = sizeof(paged_addr);
+	xfer[DA9063_PAGED_READ_MSG_REG_SEL].buf = &paged_addr;
+
+	/* Read data */
+	xfer[DA9063_PAGED_READ_MSG_DATA].addr = client->addr;
+	xfer[DA9063_PAGED_READ_MSG_DATA].flags = I2C_M_RD;
+	xfer[DA9063_PAGED_READ_MSG_DATA].len = count;
+	xfer[DA9063_PAGED_READ_MSG_DATA].buf = buf;
+
+	ret = i2c_transfer(client->adapter, xfer, DA9063_PAGED_READ_MSG_CNT);
+	if (ret < 0) {
+		dev_err(&client->dev, "Paged block read failed: %d\n", ret);
+		return ret;
+	}
+
+	if (ret != DA9063_PAGED_READ_MSG_CNT) {
+		dev_err(&client->dev, "Paged block read failed to complete\n");
+		return -EIO;
+	}
+
+	return 0;
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
+	u8 buf[DA9063_CHIP_ID_REGS];
+	int ret;
+
+	ret = da9063_i2c_blockreg_read(i2c, DA9063_REG_DEVICE_ID, buf,
+				       DA9063_CHIP_ID_REGS);
+	if (ret)
+		return ret;
+
+	if (buf[DA9063_DEV_ID_REG] != PMIC_CHIP_ID_DA9063) {
+		dev_err(da9063->dev,
+			"Invalid chip device ID: 0x%02x\n",
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
@@ -72,7 +184,7 @@
 	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_ID_32_31),
 	regmap_reg_range(DA9063_REG_SEQ_A, DA9063_REG_AUTO3_LOW),
 	regmap_reg_range(DA9063_REG_T_OFFSET, DA9063_BB_REG_GP_ID_19),
-	regmap_reg_range(DA9063_REG_CHIP_ID, DA9063_REG_CHIP_VARIANT),
+	regmap_reg_range(DA9063_REG_DEVICE_ID, DA9063_REG_VARIANT_ID),
 };
 
 static const struct regmap_range da9063_bb_writeable_ranges[] = {
@@ -117,7 +229,7 @@
 	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_ID_32_31),
 	regmap_reg_range(DA9063_REG_SEQ_A, DA9063_REG_AUTO3_LOW),
 	regmap_reg_range(DA9063_REG_T_OFFSET, DA9063_BB_REG_GP_ID_19),
-	regmap_reg_range(DA9063_REG_CHIP_ID, DA9063_REG_CHIP_VARIANT),
+	regmap_reg_range(DA9063_REG_DEVICE_ID, DA9063_REG_VARIANT_ID),
 };
 
 static const struct regmap_range da9063l_bb_writeable_ranges[] = {
@@ -159,7 +271,7 @@
 static const struct regmap_range_cfg da9063_range_cfg[] = {
 	{
 		.range_min = DA9063_REG_PAGE_CON,
-		.range_max = DA9063_REG_CHIP_VARIANT,
+		.range_max = DA9063_REG_CONFIG_ID,
 		.selector_reg = DA9063_REG_PAGE_CON,
 		.selector_mask = 1 << DA9063_I2C_PAGE_SEL_SHIFT,
 		.selector_shift = DA9063_I2C_PAGE_SEL_SHIFT,
@@ -173,7 +285,7 @@
 	.val_bits = 8,
 	.ranges = da9063_range_cfg,
 	.num_ranges = ARRAY_SIZE(da9063_range_cfg),
-	.max_register = DA9063_REG_CHIP_VARIANT,
+	.max_register = DA9063_REG_CONFIG_ID,
 
 	.cache_type = REGCACHE_RBTREE,
 };
@@ -199,18 +311,56 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
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
+	if (ret)
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

