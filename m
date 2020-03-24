Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5030C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E32620775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgCXJ7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:59:24 -0400
Received: from pecan2-mail.exetel.com.au ([220.233.0.71]:37923 "EHLO
        pecan2.exetel.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbgCXJ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:59:24 -0400
X-Greylist: delayed 2927 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Mar 2020 05:59:21 EDT
Received: from 41.68.233.220.static.exetel.com.au ([220.233.68.41] helo=localhost.localdomain)
        by pecan2.exetel.com.au with esmtp (Exim 4.91)
        (envelope-from <flatmax@flatmax.org>)
        id 1jGfZc-0000Zd-ME; Tue, 24 Mar 2020 20:10:12 +1100
From:   Matt Flax <flatmax@flatmax.org>
Cc:     Matt Flax <flatmax@flatmax.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        YueHaibing <yuehaibing@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        alsa-devel@alsa-project.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: bcm2835-i2s: substream alignment now independent in hwparams
Date:   Tue, 24 Mar 2020 20:08:21 +1100
Message-Id: <20200324090823.20754-1-flatmax@flatmax.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Substream sample alignment was being set in hwparams for both
substreams at the same time. This became a problem when	the Audio
Injector isolated sound card needed to offset sample alignment
for high sample	rates. The latency difference between playback
and capture occurs because of the digital isolation chip
propagation time, particularly when the codec is master and
the DAC return is twice delayed.

This patch sets sample alignment registers  based on the substream
direction in hwparams. This gives the machine driver more control
over sample alignment in the bcm2835 i2s driver.

Signed-off-by: Matt Flax <flatmax@flatmax.org>
---
 sound/soc/bcm/bcm2835-i2s.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
index e6a12e271b07..9db542699a13 100644
--- a/sound/soc/bcm/bcm2835-i2s.c
+++ b/sound/soc/bcm/bcm2835-i2s.c
@@ -493,11 +493,6 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	bcm2835_i2s_calc_channel_pos(&rx_ch1_pos, &rx_ch2_pos,
-		rx_mask, slot_width, data_delay, odd_slot_offset);
-	bcm2835_i2s_calc_channel_pos(&tx_ch1_pos, &tx_ch2_pos,
-		tx_mask, slot_width, data_delay, odd_slot_offset);
-
 	/*
 	 * Transmitting data immediately after frame start, eg
 	 * in left-justified or DSP mode A, only works stable
@@ -508,19 +503,26 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
 			"Unstable slave config detected, L/R may be swapped");
 
 	/*
-	 * Set format for both streams.
-	 * We cannot set another frame length
-	 * (and therefore word length) anyway,
-	 * so the format will be the same.
+	 * Set format on a per stream basis.
+	 * The alignment format can be different depending on direction.
 	 */
-	regmap_write(dev->i2s_regmap, BCM2835_I2S_RXC_A_REG, 
-		  format
-		| BCM2835_I2S_CH1_POS(rx_ch1_pos)
-		| BCM2835_I2S_CH2_POS(rx_ch2_pos));
-	regmap_write(dev->i2s_regmap, BCM2835_I2S_TXC_A_REG, 
-		  format
-		| BCM2835_I2S_CH1_POS(tx_ch1_pos)
-		| BCM2835_I2S_CH2_POS(tx_ch2_pos));
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		bcm2835_i2s_calc_channel_pos(&rx_ch1_pos, &rx_ch2_pos,
+			rx_mask, slot_width, data_delay, odd_slot_offset);
+		regmap_write(dev->i2s_regmap, BCM2835_I2S_RXC_A_REG,
+			  format
+			| BCM2835_I2S_CH1_POS(rx_ch1_pos)
+			| BCM2835_I2S_CH2_POS(rx_ch2_pos));
+	}
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		bcm2835_i2s_calc_channel_pos(&tx_ch1_pos, &tx_ch2_pos,
+			tx_mask, slot_width, data_delay, odd_slot_offset);
+		regmap_write(dev->i2s_regmap, BCM2835_I2S_TXC_A_REG,
+			  format
+			| BCM2835_I2S_CH1_POS(tx_ch1_pos)
+			| BCM2835_I2S_CH2_POS(tx_ch2_pos));
+	}
 
 	/* Setup the I2S mode */
 
-- 
2.20.1

