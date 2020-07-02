Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40299C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 246DA20772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbgGBOXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729399AbgGBOXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:23:12 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE67FC08C5C1;
        Thu,  2 Jul 2020 07:23:11 -0700 (PDT)
Received: from xps.home (unknown [IPv6:2a01:e35:2fb5:1510:315a:ecf0:6250:a3ed])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 34A3E2A5EC7;
        Thu,  2 Jul 2020 15:23:10 +0100 (BST)
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     kernel@collabora.com,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/4] ASoC: fsl_asrc: swap input and output clocks in capture mode
Date:   Thu,  2 Jul 2020 16:22:35 +0200
Message-Id: <20200702142235.235869-5-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702142235.235869-1-arnaud.ferraris@collabora.com>
References: <20200702142235.235869-1-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The input clock is the reference clock we need to convert the stream to,
which therefore has to be the clock of the origin stream/device.

When the stream is bi-directional and we want ASRC to act on both
directions, we need to swap the input and output clocks between the
playback and capture streams.

As some of the clocks have different ID's depending on whether they are
used as input or output, this requires adding a new function to find the
output clock ID corresponding to a given input clock.

Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
---
 sound/soc/fsl/fsl_asrc.c | 50 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 65e7307a3df0..5aeab1fbcdd9 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -506,6 +506,50 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair, bool use_ideal_rate)
 	return fsl_asrc_set_ideal_ratio(pair, inrate, outrate);
 }
 
+/**
+ * Select the output clock corresponding to a given input clock (and vice-versa)
+ *
+ * If we want to setup a capture channel, the input and output clocks have to
+ * be swapped.
+ * However, even if most of the clocks have the same index when used as input
+ * or output, some of them (ESAI, SSI* and SPDIF) are different:
+ * - the TX output clock has the index of the corresponding RX input clock
+ * - the RX output clock has the index of the corresponding TX input clock
+ *
+ * This function makes sure that we use the proper clock index when swapping
+ * the input and output clocks.
+ */
+static enum asrc_outclk fsl_asrc_get_capture_clock(enum asrc_inclk inclk)
+{
+	enum asrc_outclk outclk;
+
+	switch (inclk) {
+	case INCLK_ESAI_RX:
+	case INCLK_SSI1_RX:
+	case INCLK_SSI2_RX:
+	case INCLK_SPDIF_RX:
+		outclk = inclk + 0x8;
+		break;
+	case INCLK_SSI3_RX:
+		outclk = OUTCLK_SSI3_RX;
+		break;
+	case INCLK_ESAI_TX:
+	case INCLK_SSI1_TX:
+	case INCLK_SSI2_TX:
+	case INCLK_SPDIF_TX:
+		outclk = inclk - 0x8;
+		break;
+	case INCLK_SSI3_TX:
+		outclk = OUTCLK_SSI3_TX;
+		break;
+	default:
+		outclk = inclk;
+		break;
+	}
+
+	return outclk;
+}
+
 /**
  * Start the assigned ASRC pair
  *
@@ -604,15 +648,17 @@ static int fsl_asrc_dai_hw_params(struct snd_pcm_substream *substream,
 
 	config.pair = pair->index;
 	config.channel_num = channels;
-	config.inclk = asrc->inclk;
-	config.outclk = asrc->outclk;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		config.inclk = asrc->inclk;
+		config.outclk = asrc->outclk;
 		config.input_format   = params_format(params);
 		config.output_format  = asrc->asrc_format;
 		config.input_sample_rate  = rate;
 		config.output_sample_rate = asrc->asrc_rate;
 	} else {
+		config.inclk = fsl_asrc_get_capture_clock(asrc->outclk);
+		config.outclk = fsl_asrc_get_capture_clock(asrc->inclk);
 		config.input_format   = asrc->asrc_format;
 		config.output_format  = params_format(params);
 		config.input_sample_rate  = asrc->asrc_rate;
-- 
2.27.0

