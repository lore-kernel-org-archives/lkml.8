Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4033C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB56023435
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586181831;
	bh=UbkFYXsatuzQbUdxGVDQAxnHxupZla2aqzUmbNgnnGI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=LKKqNGr1h10K+uVb58MRzEP07hHl2JTsizglBq73zzifUBTupWxjE08zE/PaZ4oyf
	 FWCN7qoXiim0va3fwuD6JjwxGmcNFsUkGqBFiU/xZW7TNuhNqaFJdttcYCEerqdyIp
	 V3mTNBQpzH21KByOSOHajMD67m3sWZaDASRs6QaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgDFODu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:03:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbgDFODu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:03:50 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F061C23433;
        Mon,  6 Apr 2020 14:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586181829;
        bh=UbkFYXsatuzQbUdxGVDQAxnHxupZla2aqzUmbNgnnGI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=F8Wsfrq0K11uyIa+GRybKbyBxjyoiQ72PIhjJXXAD60jFxbbOrC4Q4w3iv3l/BCOg
         lJlT3GYD87feNnOAUIEaPoSpOJQBWeGU4GmwpJPLNmpRQZAqKLlBlFIku2Bnqr6+Je
         TKQsB7z6IBrmoerd2HKKbinAfmIEktdHGKNMqioo=
Date:   Mon, 06 Apr 2020 15:03:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        alsa-devel@alsa-project.org,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: stm32: sai: Add missing cleanup" to the asoc tree
In-Reply-To:  <1586099028-5104-1-git-send-email-Julia.Lawall@inria.fr>
Message-Id:  <applied-1586099028-5104-1-git-send-email-Julia.Lawall@inria.fr>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: sai: Add missing cleanup

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

From 7506baeed8d05fc164254c64af14cfed2ac14446 Mon Sep 17 00:00:00 2001
From: Julia Lawall <Julia.Lawall@inria.fr>
Date: Sun, 5 Apr 2020 17:03:48 +0200
Subject: [PATCH] ASoC: stm32: sai: Add missing cleanup

The commit 0d6defc7e0e4 ("ASoC: stm32: sai: manage rebind issue")
converts some function calls to their non-devm equivalents.  The
appropriate cleanup code was added to the remove function, but not
to the probe function.  Add a call to snd_dmaengine_pcm_unregister
to compensate for the call to snd_dmaengine_pcm_register in case
of subsequent failure.

Fixes: commit 0d6defc7e0e4 ("ASoC: stm32: sai: manage rebind issue")
Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Acked-by: Olivier Moysan <olivier.moysan@st.com>
Link: https://lore.kernel.org/r/1586099028-5104-1-git-send-email-Julia.Lawall@inria.fr
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 2bd280c01c33..0d0c9afd8791 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1556,8 +1556,10 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 
 	ret = snd_soc_register_component(&pdev->dev, &stm32_component,
 					 &sai->cpu_dai_drv, 1);
-	if (ret)
+	if (ret) {
+		snd_dmaengine_pcm_unregister(&pdev->dev);
 		return ret;
+	}
 
 	if (STM_SAI_PROTOCOL_IS_SPDIF(sai))
 		conf = &stm32_sai_pcm_config_spdif;
-- 
2.20.1

