Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91DFC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77508206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgDFIzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 04:55:04 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.4]:32400 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726533AbgDFIzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 04:55:02 -0400
Received: from [100.113.3.58] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-central-1.aws.symcld.net id 01/2A-46407-36EEA8E5; Mon, 06 Apr 2020 08:54:59 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRWlGSWpSXmKPExsVy8MN7Xd2kd11
  xBhcXM1vc/3qU0eLyrjlsDkwed67tYfP4vEkugCmKNTMvKb8igTVj6tqMgg0mFUvP6jQw/tLr
  YuTiEBJYyyix+tt09i5GTiCnQqJtQheYzSuQKbF53npmEJtTwF3i9t6jjBA1bhKXHn1nAbHZB
  CwkJp94wAZiswioSHS2bAazhQXCJN7f+wJUz8EhAhQ/98YcxGQWiJD4c4oZYrqgxMmZT8CmMA
  tISBx88YIZYrqBxOkFjSwTGHlnISmbhaRsASPTKkbLpKLM9IyS3MTMHF1DAwNdQ0NjXSNdI2N
  jvcQq3US91FLd5NS8kqJEoKxeYnmxXnFlbnJOil5easkmRmCopRQyvdzBuG3te71DjJIcTEqi
  vFNfdMUJ8SXlp1RmJBZnxBeV5qQWH2KU4eBQkuA98BooJ1iUmp5akZaZAwx7mLQEB4+SCO+SV
  0Bp3uKCxNzizHSI1ClGRSlx3jtvgBICIImM0jy4NlisXWKUlRLmZWRgYBDiKUgtys0sQZV/xS
  jOwagkzLsbZApPZl4J3PRXQIuZgBaz5bWDLC5JREhJNTA9n84eWPkh01zpLFvcz8YPPQe2nHu
  ko31j0n4j29rs8xnsemym01U1TE75ntl8v+G/qse/voJbjCklhx4nXHn/L2snq+is/R2T5QLe
  X5z2Pf9sjQWjtuymZH358y+2Sy93+i3753SkaqT19B/qQuudc9JOHo/wj7p45WJBX8m2qnw+0
  WDt8Cks5Y95nh2bc/YuT+T0nTKzDzxhTqvbrKtWvOGGXvpvtv2RC6xve1+NNxI+8CnB6sPqmU
  sf51WdTE96YhZmdGTyqom827d8usxWuOL86hwzh61t8xL45zysKvMzvHLwREU0l2LFPXUB8b7
  Tv4oU2TpeXFzV6qqu5DNb5fTlPfqLzs+8+naBWP1hJZbijERDLeai4kQA+F609TADAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-14.tower-233.messagelabs.com!1586163297!180744!1
X-Originating-IP: [193.240.239.45]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28762 invoked from network); 6 Apr 2020 08:54:57 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (193.240.239.45)
  by server-14.tower-233.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 6 Apr 2020 08:54:57 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Mon, 6 Apr 2020 10:54:57 +0200
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 118073FBE7; Mon,  6 Apr 2020 09:54:57 +0100 (BST)
Message-ID: <f468a3c56496edf3641b41cbd7797b344c8a99dc.1586162737.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1586162737.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1586162737.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Mon, 6 Apr 2020 09:54:57 +0100
Subject: [RESEND v2 PATCH 2/2] mfd: da9063: Add support for latest DA silicon revision
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
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
 drivers/mfd/da9063-i2c.c        | 91 ++++++++++++++++++++++++++++++++++++-----
 include/linux/mfd/da9063/core.h |  1 +
 2 files changed, 82 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index 2654b49..38452ae 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -175,7 +175,7 @@ static int da9063_get_device_type(struct i2c_client *i2c, struct da9063 *da9063)
 	regmap_reg_range(DA9063_BB_REG_GP_ID_0, DA9063_BB_REG_GP_ID_19),
 };
 
-static const struct regmap_range da9063_bb_volatile_ranges[] = {
+static const struct regmap_range da9063_bb_da_volatile_ranges[] = {
 	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_REG_EVENT_D),
 	regmap_reg_range(DA9063_REG_CONTROL_A, DA9063_REG_CONTROL_B),
 	regmap_reg_range(DA9063_REG_CONTROL_E, DA9063_REG_CONTROL_F),
@@ -197,9 +197,9 @@ static int da9063_get_device_type(struct i2c_client *i2c, struct da9063 *da9063)
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
@@ -219,7 +219,7 @@ static int da9063_get_device_type(struct i2c_client *i2c, struct da9063 *da9063)
 	regmap_reg_range(DA9063_BB_REG_GP_ID_0, DA9063_BB_REG_GP_ID_19),
 };
 
-static const struct regmap_range da9063l_bb_volatile_ranges[] = {
+static const struct regmap_range da9063l_bb_da_volatile_ranges[] = {
 	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_REG_EVENT_D),
 	regmap_reg_range(DA9063_REG_CONTROL_A, DA9063_REG_CONTROL_B),
 	regmap_reg_range(DA9063_REG_CONTROL_E, DA9063_REG_CONTROL_F),
@@ -241,9 +241,64 @@ static int da9063_get_device_type(struct i2c_client *i2c, struct da9063 *da9063)
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
@@ -311,7 +366,15 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
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
@@ -328,7 +391,15 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
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
index 5cd06ab..fa7a43f 100644
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

