Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0B6C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A33A206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="1bHWbwnX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgGMJjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 05:39:06 -0400
Received: from mail-eopbgr60077.outbound.protection.outlook.com ([40.107.6.77]:47738
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726991AbgGMJjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 05:39:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7rLlkTcOLivM/FR2EFAgI370TYPAMq4au+5Ms+rs3f6IuMxVcIsmRJdyMbGUuHnvKuTGYQVB+Db1hqaTh6OTA1XUDAjanDR+qOhyipswKlVzN7ieImI+KLXQWWu3MqUhnckMjebPizeTmf2ubLVatRFcGk7E+FiyRdxXQuLt0Xu9hJ1RcY3GsYj0Uk+nbgCCG1tEJSLkCLHJxKC3f9zzulnewie3hnqwHSebGfKoLvPUad8KiSkn/8ww6QS+jrUpMrVQl6g6XzBjTt7NZH+YCxxEx+642AkCQXOllW86M4/ZaqQAApClRMizsabT9IfhTObKNWaw4fH0uBgdmQkZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kx7pw2HAuvYAlZwmll3S+MeD7IMqCircd/1mkfDVfx8=;
 b=KwPc4CNxTauEHg64ukiLEYOXXyOC4xVbbv40hxKRQo59ZWPPwt6FINQ/0tSBGF3TZVgwPW7yLubaHP9O4XFNugkcZC/F6Bl3dc0VRTpU9S+cOIZIiG3B6c9xR0OwifFKg7nRhzZ/PhKiDGLjya5wbeDNYtBj/wawlw6YGqPF339EvruSDCy/jijek/++LnMRvcmDXbw2+alPHECFSWntV6WvvLULOAej4GKbwZ7g39p9rUdAOjwK6DTxrR5yJCjnDypFiAGveiYgMx0HlmGod2Wht1eQECF3h/klG+dMJy5Z2GBS0n0FS90mzakKwgS0UehuQ0G126bWPvJY41iiZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=diasemi.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=diasemi.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kx7pw2HAuvYAlZwmll3S+MeD7IMqCircd/1mkfDVfx8=;
 b=1bHWbwnXVMT1g575mNKTY+a21MBRiB0Xi9xBwJmmuSt1bquj+U7qkt08L7txi/mCWbik3TAg7UErg6/em5ECSYzDYKCnDe14Rhyl7O1BBmT/COr1P+1gVmnsRZrQ3heg86ni0CB3mJl+4D78GO2vS74jGOZFiQSK443PF9+iPak=
Received: from AM6PR0502CA0067.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::44) by AM0PR10MB2898.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:159::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Mon, 13 Jul
 2020 09:39:00 +0000
Received: from AM5EUR02FT030.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:56:cafe::74) by AM6PR0502CA0067.outlook.office365.com
 (2603:10a6:20b:56::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend
 Transport; Mon, 13 Jul 2020 09:39:00 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; vger.kernel.org; dkim=none
 (message not signed) header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 AM5EUR02FT030.mail.protection.outlook.com (10.152.8.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3174.21 via Frontend Transport; Mon, 13 Jul 2020 09:38:59 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Mon, 13 Jul 2020 11:38:58 +0200
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 01AFA3FBE5; Mon, 13 Jul 2020 10:38:58 +0100 (BST)
Message-ID: <565560ffd791f597826fe724843e69dd0a315c18.1594632559.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1594632559.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1594632559.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Mon, 13 Jul 2020 10:38:57 +0100
Subject: [RESEND PATCH v3 1/2] mfd: da9063: Fix revision handling to correctly select
 reg tables
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39850400004)(346002)(376002)(46966005)(336012)(4326008)(426003)(5660300002)(8676002)(36906005)(356005)(478600001)(82310400002)(81166007)(186003)(107886003)(8936002)(26005)(6916009)(54906003)(83380400001)(42186006)(86362001)(70586007)(70206006)(316002)(33310700002)(2616005)(6266002)(47076004)(30864003)(82740400003)(36756003)(2906002)(136400200001);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e53dc2cb-7446-4b9b-19e5-08d827109225
X-MS-TrafficTypeDiagnostic: AM0PR10MB2898:
X-Microsoft-Antispam-PRVS: <AM0PR10MB28989B271323C7D15FF17982A7600@AM0PR10MB2898.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pU9Gzxy3LaLG6Io2SPsTEyWIIJRY1iFTHSANuj5magExpWaOPlhG3PJyE6QeAdwDdle5FY/jzAHPpAO9T9S3pnEI7AjL6g0GycTHr07Av0nYapTjCbKNN+tZbwUy37p+D90RG+Tn+cZf6QHPUhyvWcbjizE2Zc0fetAMhzfUVNKcUg2TWBd3L6p/OxDtreija4LS5PMpOEFgkw15X7BdmRBfzeO11Iar6xOuhbPgFb7G9h1Iav+ndprZCKUG4CnzveFA1lUK3Zdwy4RVic4rvgSmTYojTU6OVGGBVs0KVGxiBU8/pr71LUjaEPxM1LuFvkIuujuCB1/FIuKHdcToTXmVIjY9vn7Sgi2PSISxqhDN2MoiLiNSFADACk6wA8dUjNORXNojTJ6cwGvTqeMK7vXWY0LwZR+EPvwH7Zs6sMuenSCPW5EOKpJ20zYJsugRCRIKYMiCpg3jsVgKbhSRQg==
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 09:38:59.5421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e53dc2cb-7446-4b9b-19e5-08d827109225
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT030.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2898
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

v3:
 - Replaced magic numbers around I2C paged access code with enums and defines
 - Small style tidy ups as requested by Lee Jones

v2:
 - Use raw I2C read access instead of a temporary regmap to interrogate chip and
   variant id registers

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

