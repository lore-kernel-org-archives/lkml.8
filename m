Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41299C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18FE62072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586865578;
	bh=iQ0FSIWebUA6Tbs01biRgrtT29PK4sY32qVaXVLuuMk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=my8jbkJld9st/CHw5lF1NSzyRk/ByrwopzxlKlGR/ixssNGnpFVpBZGkPt7SG6vFf
	 3gdYbEDBHqW4s3MkhRlWLWUkTWwlfRGR9NZihN0vk6o5IIf8XA/JlBuDW4tFQy5fMz
	 tYQKOO01fZGHx/LFianAYOpabAJipPwHELZ7nYPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439750AbgDNL7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 07:59:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:33628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439740AbgDNL7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 07:59:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B318D206A2;
        Tue, 14 Apr 2020 11:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586865565;
        bh=iQ0FSIWebUA6Tbs01biRgrtT29PK4sY32qVaXVLuuMk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iic2G+2lC79jUfXdcno5+zVhsRM3jbj+AA06lzlK4m5NSNcl4LBWiBXPKgpSif4tx
         sfuXWQBTHoqPOIP6k0DWHG4FBOEgvApCjtVO+q+saoOk19yWQ0DUnuCROyfPqsDqAS
         52aBH3Z2Nuh8LP0PV7y/RqoJHI8UkHxzi+M6M2hw=
Date:   Tue, 14 Apr 2020 12:59:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     akshu.agrawal@amd.com, alsa-devel@alsa-project.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: Applied "ASoC: amd: Fix button configuration" to the asoc tree
In-Reply-To:  <20200414113527.13532-1-akshu.agrawal@amd.com>
Message-Id:  <applied-20200414113527.13532-1-akshu.agrawal@amd.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: amd: Fix button configuration

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

From 8dbcfcfc73d43df5a3dc306b6a4c1d996caf37e0 Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Tue, 14 Apr 2020 05:35:23 -0600
Subject: [PATCH] ASoC: amd: Fix button configuration

RT5682 buttons were incorrectly mapped.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Link: https://lore.kernel.org/r/20200414113527.13532-1-akshu.agrawal@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp3x-rt5682-max9836.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp3x-rt5682-max9836.c b/sound/soc/amd/acp3x-rt5682-max9836.c
index 024a7ee54cd5..e499c00e0c66 100644
--- a/sound/soc/amd/acp3x-rt5682-max9836.c
+++ b/sound/soc/amd/acp3x-rt5682-max9836.c
@@ -89,9 +89,9 @@ static int acp3x_5682_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
-	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_1, KEY_VOLUMEUP);
-	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_2, KEY_VOLUMEDOWN);
-	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_3, KEY_VOICECOMMAND);
+	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
+	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
+	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
 
 	ret = snd_soc_component_set_jack(component, &pco_jack, NULL);
 	if (ret) {
-- 
2.20.1

