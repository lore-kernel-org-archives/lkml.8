Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4726FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B34E20773
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="s31GgKPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbgGMJjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 05:39:09 -0400
Received: from mail-eopbgr80050.outbound.protection.outlook.com ([40.107.8.50]:19846
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729027AbgGMJjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 05:39:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAS7GWdWo4J6K2OAg+5zocp+GDhviQUdKVON/szo9bUGH51Rawye8BvKpq4es6n+Dv3/H8/UjUDoTjgttYfnc+t6RXTiPxM1bFZ/xVHBWUHuYCYcES4R77jIkDZWIcJO8jZ9yAsIqC5osaUjr9EIBeWg1XoAZQsTRfiMlrmqryfveYc9RUCxcGFpZ7KmU5UGwcv+oMJ90YqnR57nMWAKOW9F1iwy40w6yfbDrLkAaPjcaFKdd5a0npwtMkOrbY3Qxtqki62zl0MvuVJv2JvrRQZpQ/65LwBePeQhf0FNUyRPibac5sOCkk0HUMr74Rcc88A9oeHKt+ZuiPcH59WQJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6e3rxkiRHeAiJo0XyEaVly70TBPHO6JDcKbWroPbuj4=;
 b=Iz4gaXTz2DjbFDUmxXjP9Uxaf9mcRmlcHvAPjUeFqXXqpQJeH8bip2gwQqzs8B4XgPIP9sdYJQdC8alQ8wO1iyZz/MibuEs3IFWQ9yde1563ygLkJ6YD6cOAv/c2HxGY7F11g9LOvKv/A+Civ1/ix8AjaIBEgRfJWaPYZglAT/BgHsCZ1GMKvnRiJADgG99O6RVYysZDCjhOQhKlcgeE15lsooBviPF444aDY12ss/C9+EpaybcGxSIx04T3yOCK/WODGvtubjqUmYHCJI/U7uM1EfXzgLCqLpY0RTcCtmJR0sNwsTU3vbdRiwOD2vNE0GeuY31I6mEPccIdKLtNWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=diasemi.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=diasemi.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6e3rxkiRHeAiJo0XyEaVly70TBPHO6JDcKbWroPbuj4=;
 b=s31GgKPrpA5ByaB3be+acfbRPolFkrBIcaTHaepaCxrRySgCS5XlTIRql6QnpMw+xtu0SCpPmW/7MwPF1cVuLwcug1TL1lU56EqipHEJXB+M0lwLi6oKdL27jw2TevFGQYmtfrYdM+e6ikOMo6oY98QLoJrXsqZEzR13rBXnfbk=
Received: from AM6PR0502CA0046.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::23) by AM0PR10MB2387.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:db::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Mon, 13 Jul
 2020 09:39:01 +0000
Received: from AM5EUR02FT030.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:56:cafe::a3) by AM6PR0502CA0046.outlook.office365.com
 (2603:10a6:20b:56::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend
 Transport; Mon, 13 Jul 2020 09:39:01 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; vger.kernel.org; dkim=none
 (message not signed) header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 AM5EUR02FT030.mail.protection.outlook.com (10.152.8.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3174.21 via Frontend Transport; Mon, 13 Jul 2020 09:39:01 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Mon, 13 Jul 2020 11:38:59 +0200
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 04BC33FBE7; Mon, 13 Jul 2020 10:38:59 +0100 (BST)
Message-ID: <9d9f9609125d5af7fc0bee024c76049cbfeeb287.1594632559.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1594632559.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1594632559.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Mon, 13 Jul 2020 10:38:59 +0100
Subject: [RESEND PATCH v3 2/2] mfd: da9063: Add support for latest DA silicon revision
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(39850400004)(396003)(136003)(46966005)(82740400003)(2616005)(426003)(6266002)(5660300002)(33310700002)(316002)(356005)(107886003)(8936002)(336012)(86362001)(70206006)(2906002)(47076004)(8676002)(82310400002)(70586007)(81166007)(6916009)(478600001)(36906005)(83380400001)(186003)(26005)(54906003)(42186006)(36756003)(4326008)(136400200001);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14ce06d0-5601-432b-ec16-08d82710931e
X-MS-TrafficTypeDiagnostic: AM0PR10MB2387:
X-Microsoft-Antispam-PRVS: <AM0PR10MB23874EC7B224E5D4E6FCDB72A7600@AM0PR10MB2387.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CzpxILjxR4RUeUea9cClmUFvixzeD+Doc0hu7uKuBYjlfMsmyD5NjcEjP/s77EOinpsuA40jE5CBHyUOjhfR3OdDsYCiCa+IZSmyLto5Wbuq0/7bz0Tsj7M7oSCREyaDnm/Lbe5jATSF0hEAOsGVbZUK/F9MfMjBWYrcHM92hVgS5Aq0HgKZcArniQOAKLeNfd9kXLI6qEdsdaUSzjw3NcWynakOJXa7b9ZkuxytsLE+k+aq+BWxDYkZckmdByWj0hmw2/IxZxs7wR6wUziiGsj/PQPbVs9hkrVFV8MTBA6iW9l0sIlZNBLNSrw95oilEoZ4jhuQH0xfL7ZVoVwUJkK7vd3LBM1slTKMUbqJ7u1TohXRYE6Y5x8gCfIfktgbZvSGkgfly4j/hakWgTx5FGn9MfcF7cGvm+WvFbV9e7eTuUfmu1mWunecZkZTnrrb4SJF7AMoVc2xp1IJahyQKA==
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 09:39:01.1803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ce06d0-5601-432b-ec16-08d82710931e
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT030.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2387
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This update adds new regmap tables to support the latest DA silicon
which will automatically be selected based on the chip and variant
information read from the device.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---

v3:
 - No change

v2:
 - No change

 drivers/mfd/da9063-i2c.c        | 91 ++++++++++++++++++++++++++++++++++++-----
 include/linux/mfd/da9063/core.h |  1 +
 2 files changed, 82 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index 4815489..b8217ad 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -197,7 +197,7 @@ static int da9063_get_device_type(struct i2c_client *i2c, struct da9063 *da9063)
 	regmap_reg_range(DA9063_BB_REG_GP_ID_0, DA9063_BB_REG_GP_ID_19),
 };
 
-static const struct regmap_range da9063_bb_volatile_ranges[] = {
+static const struct regmap_range da9063_bb_da_volatile_ranges[] = {
 	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_REG_EVENT_D),
 	regmap_reg_range(DA9063_REG_CONTROL_A, DA9063_REG_CONTROL_B),
 	regmap_reg_range(DA9063_REG_CONTROL_E, DA9063_REG_CONTROL_F),
@@ -219,9 +219,9 @@ static int da9063_get_device_type(struct i2c_client *i2c, struct da9063 *da9063)
 	.n_yes_ranges = ARRAY_SIZE(da9063_bb_writeable_ranges),
 };
 
-static const struct regmap_access_table da9063_bb_volatile_table = {
-	.yes_ranges = da9063_bb_volatile_ranges,
-	.n_yes_ranges = ARRAY_SIZE(da9063_bb_volatile_ranges),
+static const struct regmap_access_table da9063_bb_da_volatile_table = {
+	.yes_ranges = da9063_bb_da_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(da9063_bb_da_volatile_ranges),
 };
 
 static const struct regmap_range da9063l_bb_readable_ranges[] = {
@@ -241,7 +241,7 @@ static int da9063_get_device_type(struct i2c_client *i2c, struct da9063 *da9063)
 	regmap_reg_range(DA9063_BB_REG_GP_ID_0, DA9063_BB_REG_GP_ID_19),
 };
 
-static const struct regmap_range da9063l_bb_volatile_ranges[] = {
+static const struct regmap_range da9063l_bb_da_volatile_ranges[] = {
 	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_REG_EVENT_D),
 	regmap_reg_range(DA9063_REG_CONTROL_A, DA9063_REG_CONTROL_B),
 	regmap_reg_range(DA9063_REG_CONTROL_E, DA9063_REG_CONTROL_F),
@@ -263,9 +263,64 @@ static int da9063_get_device_type(struct i2c_client *i2c, struct da9063 *da9063)
 	.n_yes_ranges = ARRAY_SIZE(da9063l_bb_writeable_ranges),
 };
 
-static const struct regmap_access_table da9063l_bb_volatile_table = {
-	.yes_ranges = da9063l_bb_volatile_ranges,
-	.n_yes_ranges = ARRAY_SIZE(da9063l_bb_volatile_ranges),
+static const struct regmap_access_table da9063l_bb_da_volatile_table = {
+	.yes_ranges = da9063l_bb_da_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(da9063l_bb_da_volatile_ranges),
+};
+
+static const struct regmap_range da9063_da_readable_ranges[] = {
+	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_BB_REG_SECOND_D),
+	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_ID_32_31),
+	regmap_reg_range(DA9063_REG_SEQ_A, DA9063_REG_AUTO3_LOW),
+	regmap_reg_range(DA9063_REG_T_OFFSET, DA9063_BB_REG_GP_ID_11),
+	regmap_reg_range(DA9063_REG_DEVICE_ID, DA9063_REG_VARIANT_ID),
+};
+
+static const struct regmap_range da9063_da_writeable_ranges[] = {
+	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_REG_PAGE_CON),
+	regmap_reg_range(DA9063_REG_FAULT_LOG, DA9063_REG_VSYS_MON),
+	regmap_reg_range(DA9063_REG_COUNT_S, DA9063_BB_REG_ALARM_Y),
+	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_ID_32_31),
+	regmap_reg_range(DA9063_REG_SEQ_A, DA9063_REG_AUTO3_LOW),
+	regmap_reg_range(DA9063_REG_CONFIG_I, DA9063_BB_REG_MON_REG_4),
+	regmap_reg_range(DA9063_BB_REG_GP_ID_0, DA9063_BB_REG_GP_ID_11),
+};
+
+static const struct regmap_access_table da9063_da_readable_table = {
+	.yes_ranges = da9063_da_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(da9063_da_readable_ranges),
+};
+
+static const struct regmap_access_table da9063_da_writeable_table = {
+	.yes_ranges = da9063_da_writeable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(da9063_da_writeable_ranges),
+};
+
+static const struct regmap_range da9063l_da_readable_ranges[] = {
+	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_REG_MON_A10_RES),
+	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_ID_32_31),
+	regmap_reg_range(DA9063_REG_SEQ_A, DA9063_REG_AUTO3_LOW),
+	regmap_reg_range(DA9063_REG_T_OFFSET, DA9063_BB_REG_GP_ID_11),
+	regmap_reg_range(DA9063_REG_DEVICE_ID, DA9063_REG_VARIANT_ID),
+};
+
+static const struct regmap_range da9063l_da_writeable_ranges[] = {
+	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_REG_PAGE_CON),
+	regmap_reg_range(DA9063_REG_FAULT_LOG, DA9063_REG_VSYS_MON),
+	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_ID_32_31),
+	regmap_reg_range(DA9063_REG_SEQ_A, DA9063_REG_AUTO3_LOW),
+	regmap_reg_range(DA9063_REG_CONFIG_I, DA9063_BB_REG_MON_REG_4),
+	regmap_reg_range(DA9063_BB_REG_GP_ID_0, DA9063_BB_REG_GP_ID_11),
+};
+
+static const struct regmap_access_table da9063l_da_readable_table = {
+	.yes_ranges = da9063l_da_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(da9063l_da_readable_ranges),
+};
+
+static const struct regmap_access_table da9063l_da_writeable_table = {
+	.yes_ranges = da9063l_da_writeable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(da9063l_da_writeable_ranges),
 };
 
 static const struct regmap_range_cfg da9063_range_cfg[] = {
@@ -333,7 +388,15 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
 			da9063_regmap_config.wr_table =
 				&da9063_bb_writeable_table;
 			da9063_regmap_config.volatile_table =
-				&da9063_bb_volatile_table;
+				&da9063_bb_da_volatile_table;
+			break;
+		case PMIC_DA9063_DA:
+			da9063_regmap_config.rd_table =
+				&da9063_da_readable_table;
+			da9063_regmap_config.wr_table =
+				&da9063_da_writeable_table;
+			da9063_regmap_config.volatile_table =
+				&da9063_bb_da_volatile_table;
 			break;
 		default:
 			dev_err(da9063->dev,
@@ -350,7 +413,15 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
 			da9063_regmap_config.wr_table =
 				&da9063l_bb_writeable_table;
 			da9063_regmap_config.volatile_table =
-				&da9063l_bb_volatile_table;
+				&da9063l_bb_da_volatile_table;
+			break;
+		case PMIC_DA9063_DA:
+			da9063_regmap_config.rd_table =
+				&da9063l_da_readable_table;
+			da9063_regmap_config.wr_table =
+				&da9063l_da_writeable_table;
+			da9063_regmap_config.volatile_table =
+				&da9063l_bb_da_volatile_table;
 			break;
 		default:
 			dev_err(da9063->dev,
diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h
index 5cd06ab2..fa7a43f 100644
--- a/include/linux/mfd/da9063/core.h
+++ b/include/linux/mfd/da9063/core.h
@@ -35,6 +35,7 @@ enum da9063_variant_codes {
 	PMIC_DA9063_AD = 0x3,
 	PMIC_DA9063_BB = 0x5,
 	PMIC_DA9063_CA = 0x6,
+	PMIC_DA9063_DA = 0x7,
 };
 
 /* Interrupts */
-- 
1.9.1

