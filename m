Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93337C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 15:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666BE2072D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 15:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583509871;
	bh=0gPAyKzA3Du6cO7P+Pk28G5fPpL01sEW95ybQ0wcL/Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=JMWJXtis/4ta6lww+hw7JVXm9X+E4EGK6SNEl6+/M0AeucBDpiYGDTJSzXJeN4nT2
	 ICIQhNVCtJ0k5T/xTFQPCyd20zTXFJEkK6cFr19W/4HcqbqAgttYvidKcU6vSa2T42
	 UAo01TFj8moq9auU5RwuUpbUOluyByh1xFvHgHtA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgCFPvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 10:51:10 -0500
Received: from foss.arm.com ([217.140.110.172]:35778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgCFPvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 10:51:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A28B30E;
        Fri,  6 Mar 2020 07:51:09 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0C1C3F237;
        Fri,  6 Mar 2020 07:51:08 -0800 (PST)
Date:   Fri, 06 Mar 2020 15:51:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wcd9335: fix address map representation" to the asoc tree
In-Reply-To:  <20200306152633.25836-1-srinivas.kandagatla@linaro.org>
Message-Id:  <applied-20200306152633.25836-1-srinivas.kandagatla@linaro.org>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: wcd9335: fix address map representation

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From d902e7856d2a3b5da7acab90e5faec22e395e57a Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Fri, 6 Mar 2020 15:26:33 +0000
Subject: [PATCH] ASoC: wcd9335: fix address map representation

slimbus addresses are 16 bit wide, masking page numbers
to wcd register at offset of 12 will limit the number for pages.
So it becomes impossible to write to page 0x10 registers.
Remove masking 0x800 (slimbus address range) from register address
and making use of window parameters in regmap config should fix it
and also will represent the registers exactly inline with Datasheet.

Remove this unnessary masking and make the registers be inline
with datasheet.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20200306152633.25836-1-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wcd9335.c | 18 +++++++++---------
 sound/soc/codecs/wcd9335.h |  7 ++++---
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index f11ffa28683b..700cc1212770 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -4926,11 +4926,11 @@ static const struct regmap_range_cfg wcd9335_ranges[] = {
 		.name = "WCD9335",
 		.range_min =  0x0,
 		.range_max =  WCD9335_MAX_REGISTER,
-		.selector_reg = WCD9335_REG(0x0, 0),
+		.selector_reg = WCD9335_SEL_REGISTER,
 		.selector_mask = 0xff,
 		.selector_shift = 0,
-		.window_start = 0x0,
-		.window_len = 0x1000,
+		.window_start = 0x800,
+		.window_len = 0x100,
 	},
 };
 
@@ -4968,12 +4968,12 @@ static const struct regmap_range_cfg wcd9335_ifc_ranges[] = {
 	{
 		.name = "WCD9335-IFC-DEV",
 		.range_min =  0x0,
-		.range_max = WCD9335_REG(0, 0x7ff),
-		.selector_reg = WCD9335_REG(0, 0x0),
-		.selector_mask = 0xff,
+		.range_max = WCD9335_MAX_REGISTER,
+		.selector_reg = WCD9335_SEL_REGISTER,
+		.selector_mask = 0xfff,
 		.selector_shift = 0,
-		.window_start = 0x0,
-		.window_len = 0x1000,
+		.window_start = 0x800,
+		.window_len = 0x400,
 	},
 };
 
@@ -4981,7 +4981,7 @@ static struct regmap_config wcd9335_ifc_regmap_config = {
 	.reg_bits = 16,
 	.val_bits = 8,
 	.can_multi_write = true,
-	.max_register = WCD9335_REG(0, 0x7FF),
+	.max_register = WCD9335_MAX_REGISTER,
 	.ranges = wcd9335_ifc_ranges,
 	.num_ranges = ARRAY_SIZE(wcd9335_ifc_ranges),
 };
diff --git a/sound/soc/codecs/wcd9335.h b/sound/soc/codecs/wcd9335.h
index 4d9be2496c30..72060824c743 100644
--- a/sound/soc/codecs/wcd9335.h
+++ b/sound/soc/codecs/wcd9335.h
@@ -8,9 +8,9 @@
  * in slimbus mode the reg base starts from 0x800
  * in i2s/i2c mode the reg base is 0x0
  */
-#define WCD9335_REG(pg, r)	((pg << 12) | (r) | 0x800)
+#define WCD9335_REG(pg, r)	((pg << 8) | (r))
 #define WCD9335_REG_OFFSET(r)	(r & 0xFF)
-#define WCD9335_PAGE_OFFSET(r)	((r >> 12) & 0xFF)
+#define WCD9335_PAGE_OFFSET(r)	((r >> 8) & 0xFF)
 
 /* Page-0 Registers */
 #define WCD9335_PAGE0_PAGE_REGISTER		WCD9335_REG(0x00, 0x000)
@@ -600,7 +600,8 @@
 #define WCD9335_CDC_CLK_RST_CTRL_FS_CNT_ENABLE	BIT(0)
 #define WCD9335_CDC_CLK_RST_CTRL_FS_CNT_DISABLE	0
 #define WCD9335_CDC_TOP_TOP_CFG1	WCD9335_REG(0x0d, 0x082)
-#define WCD9335_MAX_REGISTER	WCD9335_REG(0x80, 0x0FF)
+#define WCD9335_MAX_REGISTER	0xffff
+#define WCD9335_SEL_REGISTER	0x800
 
 /* SLIMBUS Slave Registers */
 #define WCD9335_SLIM_PGD_PORT_INT_EN0	WCD9335_REG(0, 0x30)
-- 
2.20.1

