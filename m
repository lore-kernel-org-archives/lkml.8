Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6A2C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 037EE2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392012AbgAXLji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:39:38 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.69]:47940 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391379AbgAXLZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:25:36 -0500
Received: from [46.226.52.200] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.eu-west-1.aws.symcld.net id 90/69-28161-D24DA2E5; Fri, 24 Jan 2020 11:25:33 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRWlGSWpSXmKPExsVy8IPnUV3dK1p
  xBsf/cVrc/3qU0eLyrjlsDkwed67tYfP4vEkugCmKNTMvKb8igTVjUssC1oK/xhVLr/xnb2A8
  rdfFyMUhJLCeUaLrxzLGLkZOIKdCYt7330wgNq9ApsTyZy/A4pwC7hIHnxxm62LkAKpxk1jR4
  wkSZhOwkJh84gEbiM0ioCox9/9RdhBbWCBYYvn+HmaQchEBFYlzb8xBTGaBCIk/p5ghhgtKnJ
  z5hAXEZhaQkDj44gUzxAEGEqcXNILFJQTsJaa/vwo2RUJAX6LxWCxE2FDi+6xvLBBhc4m167w
  mMArOQjJ0FpKhCxiZVjGaJxVlpmeU5CZm5ugaGhjoGhoa6RpamulaGuklVukm6aWW6panFpfo
  GuollhfrFVfmJuek6OWllmxiBAZxSsGRmB2Mc36+0zvEKMnBpCTK2zVXK06ILyk/pTIjsTgjv
  qg0J7X4EKMMB4eSBK/9JaCcYFFqempFWmYOMKJg0hIcPEoivJ4gad7igsTc4sx0iNQpRkUpcd
  7ZIAkBkERGaR5cGyyKLzHKSgnzMjIwMAjxFKQW5WaWoMq/YhTnYFQS5k0DmcKTmVcCN/0V0GI
  moMUuSmCLSxIRUlINTBcW77vkufiUZKqrzcSJU6P7MpWOXKll5+n7y8i/tn5fQtIegS77Dd6V
  lpuXx3XM0RM5e1pGxUFgW61FptMMgY7uj205jz+Ht5ye8GMF9/S7a+ZuC87drXpq44q2rRblD
  ZyrVJf7TTyXUJVQMl3Ry2fVQoGrGj0Sq97Xi0b7lMe7LyvX1FDZ+vCXiGFqh//hTwEMPDL7+O
  an+0nZ2jo922Aduvx1oEfGyr5m7h5/b/sDNgL7Z4Xt2i66/+RtqePnfCQyt6+UOyCa7d5sc+f
  una1xZttTo9hCreexvD539rrtJqcUjQeTXzsUNSaWXTK7prTyyUPlpo8mAYvFFJ6LXr+dPuP2
  B04Z7Vz2W8W2SizFGYmGWsxFxYkAtw2ZK10DAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-16.tower-288.messagelabs.com!1579865132!585135!1
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.25; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4369 invoked from network); 24 Jan 2020 11:25:33 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-16.tower-288.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 24 Jan 2020 11:25:33 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.468.0; Fri, 24 Jan 2020 11:25:32 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 6F8E53FBE7; Fri, 24 Jan 2020 11:25:32 +0000 (GMT)
Message-ID: <d4bf00408895f8b6d4aadc95e3059e5e3a848566.1579864546.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1579864546.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1579864546.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Fri, 24 Jan 2020 11:25:32 +0000
Subject: [RESEND PATCH 2/2] mfd: da9063: Add support for latest DA silicon revision
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 24/01/2020 10:17:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This update adds new regmap tables to support the latest DA silicon
which will automatically be selected based on the chip and variant
information read from the device.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 drivers/mfd/da9063-i2c.c        | 91 ++++++++++++++++++++++++++++++++++++-----
 include/linux/mfd/da9063/core.h |  1 +
 2 files changed, 82 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index c7f3057..ee48203 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -180,7 +180,7 @@ static int da9063_get_device_type(struct i2c_client *i2c, struct da9063 *da9063)
 	regmap_reg_range(DA9063_BB_REG_GP_ID_0, DA9063_BB_REG_GP_ID_19),
 };
 
-static const struct regmap_range da9063_bb_volatile_ranges[] = {
+static const struct regmap_range da9063_bb_da_volatile_ranges[] = {
 	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_REG_EVENT_D),
 	regmap_reg_range(DA9063_REG_CONTROL_A, DA9063_REG_CONTROL_B),
 	regmap_reg_range(DA9063_REG_CONTROL_E, DA9063_REG_CONTROL_F),
@@ -202,9 +202,9 @@ static int da9063_get_device_type(struct i2c_client *i2c, struct da9063 *da9063)
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
@@ -224,7 +224,7 @@ static int da9063_get_device_type(struct i2c_client *i2c, struct da9063 *da9063)
 	regmap_reg_range(DA9063_BB_REG_GP_ID_0, DA9063_BB_REG_GP_ID_19),
 };
 
-static const struct regmap_range da9063l_bb_volatile_ranges[] = {
+static const struct regmap_range da9063l_bb_da_volatile_ranges[] = {
 	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_REG_EVENT_D),
 	regmap_reg_range(DA9063_REG_CONTROL_A, DA9063_REG_CONTROL_B),
 	regmap_reg_range(DA9063_REG_CONTROL_E, DA9063_REG_CONTROL_F),
@@ -246,9 +246,64 @@ static int da9063_get_device_type(struct i2c_client *i2c, struct da9063 *da9063)
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
@@ -316,7 +371,15 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
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
@@ -333,7 +396,15 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
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

