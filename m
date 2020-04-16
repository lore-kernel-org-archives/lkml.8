Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B8CC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B0D821927
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587050675;
	bh=GnToagv/JMdsp4pV82751Mkw0KqzEMylRJu5RhScSao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=OsVlHYZ9S9yLPZt7rou3vntDfq/LZ8QXoQo0GUxrcUzw8ZuQy/wwTBOxiYn2GsoSa
	 P/lE0TZ7Fhw2GZjfn1RUYRdcHCaAWMA7EUuoagO8QiwH06t+22hbWx0J+YEo2PaLyB
	 bM7uKw10Pjf1ntdb9Th5F7j12fqG4ZTJa/AXC2dE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395203AbgDPPYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:24:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388875AbgDPPYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:24:09 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE021206D6;
        Thu, 16 Apr 2020 15:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587050648;
        bh=GnToagv/JMdsp4pV82751Mkw0KqzEMylRJu5RhScSao=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=0KqSWXl/QzDrV7AjiHnWchUJDNYq8kviGVdSpCtEAoCFyWmlamN/Zy2ObA/kj7zlc
         Xm+mejorc29Nnojj8wELxg6Qacu2j9eQz9y1al6fIMkKPlTxzW7ZkvDcBr2sYFMeBP
         i7ynWD4guGHIuWOaezMwUQL27yFD4V6TwtERy2VA=
Date:   Thu, 16 Apr 2020 16:24:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     alexandre.torgue@st.com, alsa-devel@alsa-project.org,
        arnaud.pouliquen@st.com, benjamin.gaignard@st.com,
        broonie@kernel.org, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>, mcoquelin.stm32@gmail.com,
        olivier.moysan@st.com, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: stm32: sai: fix master clock management" to the asoc tree
In-Reply-To:  <1554883716-10436-1-git-send-email-olivier.moysan@st.com>
Message-Id:  <applied-1554883716-10436-1-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: sai: fix master clock management

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

From cc34920a122b6ad7593d5751303c073fd12b96e4 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Wed, 10 Apr 2019 10:08:36 +0200
Subject: [PATCH] ASoC: stm32: sai: fix master clock management

When master clock is used, master clock rate is set exclusively.
Parent clocks of master clock cannot be changed after a call to
clk_set_rate_exclusive(). So the parent clock of SAI kernel clock
must be set before.
Ensure also that exclusive rate operations are balanced
in STM32 SAI driver.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 64 +++++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 17 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 83d8a7ac56f4..d7045aa520de 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -70,6 +70,7 @@
 #define SAI_IEC60958_STATUS_BYTES	24
 
 #define SAI_MCLK_NAME_LEN		32
+#define SAI_RATE_11K			11025
 
 /**
  * struct stm32_sai_sub_data - private data of SAI sub block (block A or B)
@@ -309,6 +310,25 @@ static int stm32_sai_set_clk_div(struct stm32_sai_sub_data *sai,
 	return ret;
 }
 
+static int stm32_sai_set_parent_clock(struct stm32_sai_sub_data *sai,
+				      unsigned int rate)
+{
+	struct platform_device *pdev = sai->pdev;
+	struct clk *parent_clk = sai->pdata->clk_x8k;
+	int ret;
+
+	if (!(rate % SAI_RATE_11K))
+		parent_clk = sai->pdata->clk_x11k;
+
+	ret = clk_set_parent(sai->sai_ck, parent_clk);
+	if (ret)
+		dev_err(&pdev->dev, " Error %d setting sai_ck parent clock. %s",
+			ret, ret == -EBUSY ?
+			"Active stream rates conflict\n" : "\n");
+
+	return ret;
+}
+
 static long stm32_sai_mclk_round_rate(struct clk_hw *hw, unsigned long rate,
 				      unsigned long *prate)
 {
@@ -490,25 +510,29 @@ static int stm32_sai_set_sysclk(struct snd_soc_dai *cpu_dai,
 	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
 	int ret;
 
-	if (dir == SND_SOC_CLOCK_OUT) {
+	if (dir == SND_SOC_CLOCK_OUT && sai->sai_mclk) {
 		ret = regmap_update_bits(sai->regmap, STM_SAI_CR1_REGX,
 					 SAI_XCR1_NODIV,
 					 (unsigned int)~SAI_XCR1_NODIV);
 		if (ret < 0)
 			return ret;
 
-		dev_dbg(cpu_dai->dev, "SAI MCLK frequency is %uHz\n", freq);
-		sai->mclk_rate = freq;
+		/* If master clock is used, set parent clock now */
+		ret = stm32_sai_set_parent_clock(sai, freq);
+		if (ret)
+			return ret;
 
-		if (sai->sai_mclk) {
-			ret = clk_set_rate_exclusive(sai->sai_mclk,
-						     sai->mclk_rate);
-			if (ret) {
-				dev_err(cpu_dai->dev,
-					"Could not set mclk rate\n");
-				return ret;
-			}
+		ret = clk_set_rate_exclusive(sai->sai_mclk, freq);
+		if (ret) {
+			dev_err(cpu_dai->dev,
+				ret == -EBUSY ?
+				"Active streams have incompatible rates" :
+				"Could not set mclk rate\n");
+			return ret;
 		}
+
+		dev_dbg(cpu_dai->dev, "SAI MCLK frequency is %uHz\n", freq);
+		sai->mclk_rate = freq;
 	}
 
 	return 0;
@@ -916,11 +940,13 @@ static int stm32_sai_configure_clock(struct snd_soc_dai *cpu_dai,
 	int div = 0, cr1 = 0;
 	int sai_clk_rate, mclk_ratio, den;
 	unsigned int rate = params_rate(params);
+	int ret;
 
-	if (!(rate % 11025))
-		clk_set_parent(sai->sai_ck, sai->pdata->clk_x11k);
-	else
-		clk_set_parent(sai->sai_ck, sai->pdata->clk_x8k);
+	if (!sai->sai_mclk) {
+		ret = stm32_sai_set_parent_clock(sai, rate);
+		if (ret)
+			return ret;
+	}
 	sai_clk_rate = clk_get_rate(sai->sai_ck);
 
 	if (STM_SAI_IS_F4(sai->pdata)) {
@@ -1079,9 +1105,13 @@ static void stm32_sai_shutdown(struct snd_pcm_substream *substream,
 	regmap_update_bits(sai->regmap, STM_SAI_CR1_REGX, SAI_XCR1_NODIV,
 			   SAI_XCR1_NODIV);
 
-	clk_disable_unprepare(sai->sai_ck);
+	/* Release mclk rate only if rate was actually set */
+	if (sai->mclk_rate) {
+		clk_rate_exclusive_put(sai->sai_mclk);
+		sai->mclk_rate = 0;
+	}
 
-	clk_rate_exclusive_put(sai->sai_mclk);
+	clk_disable_unprepare(sai->sai_ck);
 
 	spin_lock_irqsave(&sai->irq_lock, flags);
 	sai->substream = NULL;
-- 
2.20.1

