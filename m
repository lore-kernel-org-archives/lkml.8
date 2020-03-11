Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BBDC10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C648F2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgCKFIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 01:08:40 -0400
Received: from smtprelay0101.hostedemail.com ([216.40.44.101]:44590 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728169AbgCKFHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 01:07:08 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id B96DA1802DA5B;
        Wed, 11 Mar 2020 05:07:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: force30_20c217ad3c02e
X-Filterd-Recvd-Size: 2686
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Mar 2020 05:07:04 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH -next 012/491] ARM/ZTE ARCHITECTURE: Use fallthrough;
Date:   Tue, 10 Mar 2020 21:51:26 -0700
Message-Id: <cb3feec0548088c3c2485965194c6fb09e7c0e3d.1583896348.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1583896344.git.joe@perches.com>
References: <cover.1583896344.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the various uses of fallthrough comments to fallthrough;

Done via script
Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/

Signed-off-by: Joe Perches <joe@perches.com>
---
 sound/soc/zte/zx-i2s.c   | 4 ++--
 sound/soc/zte/zx-spdif.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/zte/zx-i2s.c b/sound/soc/zte/zx-i2s.c
index 568cde6..1c1a44 100644
--- a/sound/soc/zte/zx-i2s.c
+++ b/sound/soc/zte/zx-i2s.c
@@ -294,7 +294,7 @@ static int zx_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 			zx_i2s_rx_dma_en(zx_i2s->reg_base, true);
 		else
 			zx_i2s_tx_dma_en(zx_i2s->reg_base, true);
-	/* fall thru */
+		fallthrough;
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		if (capture)
@@ -308,7 +308,7 @@ static int zx_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 			zx_i2s_rx_dma_en(zx_i2s->reg_base, false);
 		else
 			zx_i2s_tx_dma_en(zx_i2s->reg_base, false);
-	/* fall thru */
+		fallthrough;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		if (capture)
diff --git a/sound/soc/zte/zx-spdif.c b/sound/soc/zte/zx-spdif.c
index a3a07c0..b4168bd 100644
--- a/sound/soc/zte/zx-spdif.c
+++ b/sound/soc/zte/zx-spdif.c
@@ -218,7 +218,7 @@ static int zx_spdif_trigger(struct snd_pcm_substream *substream, int cmd,
 		val = readl_relaxed(zx_spdif->reg_base + ZX_FIFOCTRL);
 		val |= ZX_FIFOCTRL_TX_FIFO_RST;
 		writel_relaxed(val, zx_spdif->reg_base + ZX_FIFOCTRL);
-	/* fall thru */
+		fallthrough;
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		zx_spdif_cfg_tx(zx_spdif->reg_base, true);
-- 
2.24.0

