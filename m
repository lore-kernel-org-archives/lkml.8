Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A72CC2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 21:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30CCD20775
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 21:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585173104;
	bh=9frJH47f5iN/FIA6vGcLLofwEV7gZc2xR5GYXejNcHo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=UoY5DGA+f4/Q178G81xfzZA1qSgtl0KMFzTzT+pENkWUMjd3wz4UMW5+NljfH3bmM
	 RBIEFUXhcdMIzAdsQV4W4OSQRkBJTcBWS8GplHSfownNtzFO0YuP6lHZU+yV8wMdis
	 PWpPJccnrrvpgRnhL4EycRw+qBPZphRa4rp9w1hY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgCYVvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 17:51:43 -0400
Received: from foss.arm.com ([217.140.110.172]:53526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgCYVvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 17:51:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47C281FB;
        Wed, 25 Mar 2020 14:51:38 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD9993F71E;
        Wed, 25 Mar 2020 14:51:37 -0700 (PDT)
Date:   Wed, 25 Mar 2020 21:51:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        alsa-devel@alsa-project.org,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Jaroslav Kysela <perex@perex.cz>,
        kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: mchp-i2s-mcc: make signed 1 bit bitfields unsigned" to the asoc tree
In-Reply-To:  <20200325132913.110115-1-colin.king@canonical.com>
Message-Id:  <applied-20200325132913.110115-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: mchp-i2s-mcc: make signed 1 bit bitfields unsigned

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

From 633fddee7355e46a5b5ec471abb58d65e1e41012 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Wed, 25 Mar 2020 13:29:13 +0000
Subject: [PATCH] ASoC: mchp-i2s-mcc: make signed 1 bit bitfields unsigned

The signed 1 bit bitfields should be unsigned, so make them unsigned.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Link: https://lore.kernel.org/r/20200325132913.110115-1-colin.king@canonical.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/mchp-i2s-mcc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/atmel/mchp-i2s-mcc.c b/sound/soc/atmel/mchp-i2s-mcc.c
index befc2a3a05b0..3cb63886195f 100644
--- a/sound/soc/atmel/mchp-i2s-mcc.c
+++ b/sound/soc/atmel/mchp-i2s-mcc.c
@@ -239,10 +239,10 @@ struct mchp_i2s_mcc_dev {
 	unsigned int				frame_length;
 	int					tdm_slots;
 	int					channels;
-	int					gclk_use:1;
-	int					gclk_running:1;
-	int					tx_rdy:1;
-	int					rx_rdy:1;
+	unsigned int				gclk_use:1;
+	unsigned int				gclk_running:1;
+	unsigned int				tx_rdy:1;
+	unsigned int				rx_rdy:1;
 };
 
 static irqreturn_t mchp_i2s_mcc_interrupt(int irq, void *dev_id)
-- 
2.20.1

