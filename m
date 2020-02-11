Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDFAC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390CD20708
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581436186;
	bh=NeKOtKE8EvR1hteFJIWgc00lxpPStymx8g9tR/Td5lw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=wcUjzMMMNpLeYRpbvfP2C1q/yVm2OE+HYnhFDfnK0XVz5hGtea1IllKbss8UddMHC
	 dt/EFv9aQ4qnAOdzexXRcF7XMS+O4zb8+2wj5iEwMPcOc0wLbawaOryTUrRtT/l3Xi
	 Zl2qg5/f5rWVRudhjJCNEn13TBKjGlK1n9+NKJl4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbgBKPtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:49:45 -0500
Received: from foss.arm.com ([217.140.110.172]:48652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730534AbgBKPtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:49:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7843713A1;
        Tue, 11 Feb 2020 07:49:43 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2AF73F68E;
        Tue, 11 Feb 2020 07:49:42 -0800 (PST)
Date:   Tue, 11 Feb 2020 15:49:41 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     alexandre.torgue@st.com, alsa-devel@alsa-project.org,
        broonie@kernel.org, Etienne Carriere <etienne.carriere@st.com>,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>, mcoquelin.stm32@gmail.com,
        olivier.moysan@st.com, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: stm32: sai: manage error when getting reset controller" to the asoc tree
In-Reply-To: <20200203100814.22944-2-olivier.moysan@st.com>
Message-Id: <applied-20200203100814.22944-2-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: sai: manage error when getting reset controller

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

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

From 028476c861e3eb660d8d104ef39fccb34c04a0d5 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Mon, 3 Feb 2020 11:08:09 +0100
Subject: [PATCH] ASoC: stm32: sai: manage error when getting reset controller

Return an error when the SAI driver fails to get a reset controller.
Also add an error trace, except on probe defer status.

Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Link: https://lore.kernel.org/r/20200203100814.22944-2-olivier.moysan@st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_sai.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index e20267504b16..b824ba6cb028 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -197,12 +197,16 @@ static int stm32_sai_probe(struct platform_device *pdev)
 		return sai->irq;
 
 	/* reset */
-	rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
-	if (!IS_ERR(rst)) {
-		reset_control_assert(rst);
-		udelay(2);
-		reset_control_deassert(rst);
+	rst = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(rst)) {
+		if (PTR_ERR(rst) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Reset controller error %ld\n",
+				PTR_ERR(rst));
+		return PTR_ERR(rst);
 	}
+	reset_control_assert(rst);
+	udelay(2);
+	reset_control_deassert(rst);
 
 	/* Enable peripheral clock to allow register access */
 	ret = clk_prepare_enable(sai->pclk);
-- 
2.20.1

