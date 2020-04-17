Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AB2C3815B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E85E921D94
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbgDQK4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:56:05 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.2]:61294 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729648AbgDQKzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:55:52 -0400
Received: from [100.113.1.220] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-central-1.aws.symcld.net id 0D/04-36549-43B899E5; Fri, 17 Apr 2020 10:55:48 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRWlGSWpSXmKPExsVy8MN7XV3j7pl
  xBufecljc/3qU0eLyrjlsDkwed67tYfP4vEkugCmKNTMvKb8igTXj75KVzAUbTCo+fp7J3MD4
  S6+LkYtDSGAdo8S1mUeZuxg5gZwKialLj7CB2LwCmRI/931jAbE5Bdwljmx+xghR4yYxb85XJ
  hCbTcBCYvKJB2D1LAKqEr9WHwWKc3AIC/hLHHnnCWKKCKhInHtjDmIyC0RI/DnFDDFcUOLkzC
  dgw5kFJCQOvngBdYCBxOkFjSwTGHlnISmbhaRsASPTKkbLpKLM9IyS3MTMHF1DAwNdQ0NjXWN
  dQyMjvcQq3US91FLd5NS8kqJEoKxeYnmxXnFlbnJOil5easkmRmCwpRQyV+1gvLj8vd4hRkkO
  JiVRXqW2mXFCfEn5KZUZicUZ8UWlOanFhxhlODiUJHhLuoBygkWp6akVaZk5wMCHSUtw8CiJ8
  CZ2AqV5iwsSc4sz0yFSpxgVpcR5ZUD6BEASGaV5cG2waLvEKCslzMvIwMAgxFOQWpSbWYIq/4
  pRnINRSZiXGWQKT2ZeCdz0V0CLmYAWRztMB1lckoiQkmpgslELyOn+cuVgye+gWK+pxo+ZTRQ
  mtpx48ChKQFP6MPeqB8vOz/zxL+N0fNVmzrp/79VbQu25c/LOKeZw3lLsZ053EDu8Q/js4mXW
  9fZdzjX2d7Z8OfN3u7hBzdYjmtLdXjaMJU3OwqpnbrzJurb8Xvq7ua8+GQZkHKrod1/mY2Mr1
  Vw7f3KEm3mnxv3fEZ37yvk1A3vUFkyN8NeMjXd7XtGz3P71AqubuUd/HdEJWBYe+2FK5rV7Gq
  JfbN58SAr4M+F2Wkj6Jdu7i7imypfapFTOXqaoeur5+tPb/63Y58p5O9fgBevGslX9qvzsVR0
  r7vd+dv75eVpTk/fB7MM9s5PWpVXkSu8vsq7/fdVDiaU4I9FQi7moOBEA+gZd+zEDAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-34.tower-229.messagelabs.com!1587120946!3259154!1
X-Originating-IP: [193.240.239.45]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 2145 invoked from network); 17 Apr 2020 10:55:47 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (193.240.239.45)
  by server-34.tower-229.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 17 Apr 2020 10:55:47 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Fri, 17 Apr 2020 12:55:46 +0200
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 201D63FBE7; Fri, 17 Apr 2020 11:55:46 +0100 (BST)
Message-ID: <55912c9fefefdec240bde339a2da79cefc936b4e.1587120185.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1587120185.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1587120185.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Fri, 17 Apr 2020 11:55:46 +0100
Subject: [PATCH v3 2/2] mfd: da9063: Add support for latest DA silicon revision
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

