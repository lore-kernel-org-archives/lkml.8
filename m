Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99586C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2072083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579275892;
	bh=/967xB+/cYvzMsCuYhElAPHe9VnRFEuTWVuo6fHsA7Y=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ADZ+ugLVq1ahQSpLgCLtziv/AU9hvG7QXVzymkIPYDKjjJWyNo9GnfsNoTQyFBmQr
	 wHDjPK7MBxOBPd6ZJOs/IrlESbNqo2n/vORfgbnb/dKQi/eM+v9unBdqemL9Odd8cC
	 r4RoLrHCSOD+WD7Ha0oGqBNZOETnNPb47kEoUM1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgAQPoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:44:30 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53780 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbgAQPoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:44:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=nTgcYnW1bBqfkqgXrC6bADcDL5m+JJlT4b9lz90Hafo=; b=bK8g+eoibs1c
        sshSw5ILQoPvUH2r+fGkJP36wgQioTIfHtdNDfPbwWA9DmXb/4rq0s+zW/8lr66WUmrgq4UzBGnrj
        GBnZUn9FN81lrYV3PnDWFEtBW9Pb1HIP22SVx5Qbi4ooTjqCeBqgp46ujjrM/Ck9Vok6c6HgwOERw
        Id7wc=;
Received: from fw-tnat-cam4.arm.com ([217.140.106.52] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1isTn9-0006rx-Qz; Fri, 17 Jan 2020 15:44:11 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 83ED6D02C26; Fri, 17 Jan 2020 15:44:11 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Alexander.Deucher@amd.com, alsa-devel@alsa-project.org,
        broonie@kernel.org, "Cc:"@sirena.org.uk, "Cc:"@sirena.org.uk,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, moderated@sirena.org.uk,
        open list <linux-kernel@vger.kernel.org>,
        Ravulapati@sirena.org.uk, Vishnu@sirena.org.uk,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: amd: Additional DAI for I2S SP instance." to the asoc tree
In-Reply-To: <1579261510-12580-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
Message-Id: <applied-1579261510-12580-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Patchwork-Hint: ignore
Date:   Fri, 17 Jan 2020 15:44:11 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: amd: Additional DAI for I2S SP instance.

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

From a174a6c226796824cb2f78157c0b183ed472fa3f Mon Sep 17 00:00:00 2001
From: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
Date: Fri, 17 Jan 2020 17:15:09 +0530
Subject: [PATCH] ASoC: amd: Additional DAI for I2S SP instance.

I2S SP instance has separate BCLK and LRCLK for Tx and Rx.
Creating additional DAI for Rx.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
Link: https://lore.kernel.org/r/1579261510-12580-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/raven/acp3x.h     | 2 +-
 sound/soc/amd/raven/pci-acp3x.c | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x.h b/sound/soc/amd/raven/acp3x.h
index b6a80dc0b641..21e7ac017f2b 100644
--- a/sound/soc/amd/raven/acp3x.h
+++ b/sound/soc/amd/raven/acp3x.h
@@ -13,7 +13,7 @@
 #define TDM_ENABLE 1
 #define TDM_DISABLE 0
 
-#define ACP3x_DEVS		3
+#define ACP3x_DEVS		4
 #define ACP3x_PHY_BASE_ADDRESS 0x1240000
 #define	ACP3x_I2S_MODE	0
 #define	ACP3x_REG_START	0x1240000
diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
index 2f9f52905853..65330bb50e74 100644
--- a/sound/soc/amd/raven/pci-acp3x.c
+++ b/sound/soc/amd/raven/pci-acp3x.c
@@ -225,7 +225,13 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 		pdevinfo[2].id = 1;
 		pdevinfo[2].parent = &pci->dev;
 		pdevinfo[2].num_res = 1;
-		pdevinfo[2].res = &adata->res[2];
+		pdevinfo[2].res = &adata->res[1];
+
+		pdevinfo[3].name = "acp3x_i2s_playcap";
+		pdevinfo[3].id = 2;
+		pdevinfo[3].parent = &pci->dev;
+		pdevinfo[3].num_res = 1;
+		pdevinfo[3].res = &adata->res[2];
 		for (i = 0; i < ACP3x_DEVS; i++) {
 			adata->pdev[i] =
 				platform_device_register_full(&pdevinfo[i]);
-- 
2.20.1

