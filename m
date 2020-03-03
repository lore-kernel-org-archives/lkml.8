Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DC8C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF58320836
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgCCKp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:45:56 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.4]:43228 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728731AbgCCKpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:45:54 -0500
Received: from [100.112.193.251] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-west-1.aws.symcld.net id 4B/8D-38240-F553E5E5; Tue, 03 Mar 2020 10:45:51 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRWlGSWpSXmKPExsVy8IPnUd1407g
  4g87L3Bb3vx5ltLi8aw6bA5PHnWt72Dw+b5ILYIpizcxLyq9IYM2YujajYINJxdKzOg2Mv/S6
  GLk4hATWMUq8vdbK0sXICeRUSCw7Mo8RxOYVyJRYevAgO4jNKeAu8WD3KTaIGjeJQ2/+gMXZB
  CwkJp94ABZnEVCR6J/fygpiCwv4SzzdOBEozsEhAhQ/98YcxGQWiJD4c4oZYrqgxMmZT8C2Mg
  tISBx88YIZYrqBxOkFjSwTGHlnISmbhaRsASPTKkaLpKLM9IyS3MTMHF1DAwNdQ0MjXUNLYyC
  21Eus0k3USy3VLU8tLtE11EssL9YrrsxNzknRy0st2cQIDLSUgoPHdzAuW/te7xCjJAeTkihv
  plBcnBBfUn5KZUZicUZ8UWlOavEhRhkODiUJ3jnGQDnBotT01Iq0zBxg0MOkJTh4lER400HSv
  MUFibnFmekQqVOMilLivFNBEgIgiYzSPLg2WKRdYpSVEuZlZGBgEOIpSC3KzSxBlX/FKM7BqC
  TMGwwyhSczrwRu+iugxUxAi3ueR4MsLklESEk1MAWt+egWucXfhCv4cLjIStvfBezybNE7d+q
  rqRpor/BZ+K9Te7Pf7JlnlH/HaZawhzWv/5kT8fnUi60VkyKtNu65qZFUKLbu7c+z87trZr3v
  +DzB/cFd961pT6U0xD8/vxx9t9uwIXHFw6TQmIr5ul4lRv4RUzk8DaP0nvzYa3/wao7OitjH2
  3y3y3juKNkQtffxvg+3HEqTbE+elVs366dqpqpe1/EZp2987+yZYhxa2iBk8veolMK6c+kMTy
  ck5Sqab28UcF59yPshn8aBwFPxOW+cd0ncj5n4royV+WzV4k9Rak/6TOzbc6/FLpsRv63jpVE
  9d5v28xPGc07ahM6Zz6k+y5Un5tXmib1bGZVYijMSDbWYi4oTAc/AnW4vAwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-9.tower-268.messagelabs.com!1583232350!610830!1
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16795 invoked from network); 3 Mar 2020 10:45:51 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-9.tower-268.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 3 Mar 2020 10:45:51 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.468.0; Tue, 3 Mar 2020 10:45:50 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 615DC3FBE7; Tue,  3 Mar 2020 10:45:50 +0000 (GMT)
Message-ID: <cfff1008ee8db500542cd5d2445ffd3c61e64738.1583231441.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1583231441.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1583231441.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Tue, 3 Mar 2020 10:45:50 +0000
Subject: [PATCH v2 2/2] mfd: da9063: Add support for latest DA silicon revision
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

