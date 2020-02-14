Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3C1C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273E8222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581713785;
	bh=/QMwTLfXW+PmNIq+9xGQIumOxIVmapHYg6xWscl+9DI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=kIQNR5Ux09VRbXLinyLwWFG8tGu23qzC8yMQ6tsSNDpf8eC6YYPKeATDRJbVHc+6H
	 xoGAonZRQ2rdik4qSZWGdtSSlHkguPu5irnVBjimxruIiYsJ8KXub0OnP+JEHHYsXs
	 bDqrtgtV4fLcslojHGon6qqlgQoXZJNyws2rfvvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388413AbgBNU4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:56:24 -0500
Received: from foss.arm.com ([217.140.110.172]:44974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388053AbgBNU4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:56:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 176A0101E;
        Fri, 14 Feb 2020 12:56:23 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DF8D3F68F;
        Fri, 14 Feb 2020 12:56:22 -0800 (PST)
Date:   Fri, 14 Feb 2020 20:56:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: aiu: fix acodec dai input name init" to the asoc tree
In-Reply-To:  <20200214131350.337968-5-jbrunet@baylibre.com>
Message-Id:  <applied-20200214131350.337968-5-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: aiu: fix acodec dai input name init

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

From 74a56f2a4a9ec72ef1daceeb2dda8b41370c1419 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 14 Feb 2020 14:13:49 +0100
Subject: [PATCH] ASoC: meson: aiu: fix acodec dai input name init

Remove the double initialization of the dai input name as reported by
sparse.

Fixes: 65816025d461 ("ASoC: meson: aiu: add internal dac codec control support")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20200214131350.337968-5-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/aiu-acodec-ctrl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/meson/aiu-acodec-ctrl.c b/sound/soc/meson/aiu-acodec-ctrl.c
index 12d8a4d351a1..b8e88b1a4fc8 100644
--- a/sound/soc/meson/aiu-acodec-ctrl.c
+++ b/sound/soc/meson/aiu-acodec-ctrl.c
@@ -128,7 +128,6 @@ static const struct snd_soc_dai_ops aiu_acodec_ctrl_output_ops = {
 
 #define AIU_ACODEC_INPUT(xname) {				\
 	.name = "ACODEC CTRL " xname,				\
-	.name = xname,						\
 	.playback = AIU_ACODEC_STREAM(xname, "Playback", 8),	\
 	.ops = &aiu_acodec_ctrl_input_ops,			\
 	.probe = meson_codec_glue_input_dai_probe,		\
-- 
2.20.1

