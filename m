Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206E0C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E534324682
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579018157;
	bh=Rw2K+7aX+3zsc6DZ3uyMlmytS7zSxIM+VXMvtkynmxQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=aM3JyaBTiMCGv5B6WJmaAChh6Vw6kIrTq/wR3OZ2cf2pVbbMp2cuma5tvXMevVSkT
	 8c3TqVk2wIyitjYhoLF2eY40ymDHHmyuRKah18ROCebVAYNYHnh4aFz79W2uMIys0R
	 B0x+K5gR9nu0pq0NPaInpWVvkKGJNM5lQT6q7D9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgANQJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 11:09:15 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37238 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgANQJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:09:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=lXZ19upwkhMk+xRdcs/ZKINinzvJGBfvwuhk1R5K6ok=; b=HrKBts6EZ6Y2
        HhKdy+HyppzSh2qUsV25EXnLXGXcSbt4olOUJ2QhcbljR6GDb500c/UAb8qFGn+7BeoBSGfudUnQN
        ZSzFTecc3oKH+kmuPCn96xWN1nIaXumUJ6wPd9jIO2MMrqS9KZlwdHAN+bd6zWpW7raYZUOytEHJM
        hmbb0=;
Received: from fw-tnat-cam7.arm.com ([217.140.106.55] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1irOkd-0001V7-Vw; Tue, 14 Jan 2020 16:09:08 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id A8EE7D02C77; Tue, 14 Jan 2020 16:09:07 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     alsa-devel@alsa-project.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Applied "ASoC: Intel: bytcr_rt5651: switch to using devm_fwnode_gpiod_get()" to the asoc tree
In-Reply-To: <20200103011754.GA260926@dtor-ws>
Message-Id: <applied-20200103011754.GA260926@dtor-ws>
X-Patchwork-Hint: ignore
Date:   Tue, 14 Jan 2020 16:09:07 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: Intel: bytcr_rt5651: switch to using devm_fwnode_gpiod_get()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.6

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

From e26c4e900b1a75b1e0c9e19e1f807666a8ad2fa1 Mon Sep 17 00:00:00 2001
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Thu, 2 Jan 2020 17:17:54 -0800
Subject: [PATCH] ASoC: Intel: bytcr_rt5651: switch to using
 devm_fwnode_gpiod_get()

devm_fwnode_get_index_gpiod_from_child() is going away as the name is
too unwieldy, let's switch to using the new devm_fwnode_gpiod_get().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Link: https://lore.kernel.org/r/20200103011754.GA260926@dtor-ws
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 3bb2732a9f7e..6d71352ea864 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -990,10 +990,11 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 
 	if (byt_rt5651_gpios) {
 		devm_acpi_dev_add_driver_gpios(codec_dev, byt_rt5651_gpios);
-		priv->ext_amp_gpio = devm_fwnode_get_index_gpiod_from_child(
-						&pdev->dev, "ext-amp-enable", 0,
-						codec_dev->fwnode,
-						GPIOD_OUT_LOW, "speaker-amp");
+		priv->ext_amp_gpio = devm_fwnode_gpiod_get(&pdev->dev,
+							   codec_dev->fwnode,
+							   "ext-amp-enable",
+							   GPIOD_OUT_LOW,
+							   "speaker-amp");
 		if (IS_ERR(priv->ext_amp_gpio)) {
 			ret_val = PTR_ERR(priv->ext_amp_gpio);
 			switch (ret_val) {
@@ -1009,10 +1010,11 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 				return ret_val;
 			}
 		}
-		priv->hp_detect = devm_fwnode_get_index_gpiod_from_child(
-						&pdev->dev, "hp-detect", 0,
-						codec_dev->fwnode,
-						GPIOD_IN, "hp-detect");
+		priv->hp_detect = devm_fwnode_gpiod_get(&pdev->dev,
+							codec_dev->fwnode,
+							"hp-detect",
+							GPIOD_IN,
+							"hp-detect");
 		if (IS_ERR(priv->hp_detect)) {
 			ret_val = PTR_ERR(priv->hp_detect);
 			switch (ret_val) {
-- 
2.20.1

