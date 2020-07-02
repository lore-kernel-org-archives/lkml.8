Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93C7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D154120772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbgGBOXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729399AbgGBOXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:23:08 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF82DC08C5C1;
        Thu,  2 Jul 2020 07:23:08 -0700 (PDT)
Received: from xps.home (unknown [IPv6:2a01:e35:2fb5:1510:315a:ecf0:6250:a3ed])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3489A2A5C36;
        Thu,  2 Jul 2020 15:23:07 +0100 (BST)
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
Subject: [PATCH 2/4] ASoC: fsl_asrc: allow using arbitrary input and output clocks
Date:   Thu,  2 Jul 2020 16:22:33 +0200
Message-Id: <20200702142235.235869-3-arnaud.ferraris@collabora.com>
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

fsl_asrc currently uses hardcoded input and output clocks, preventing
its use for anything other than S/PDIF output.

This patch adds the ability to select any clock as input or output (by
using new DT properties), making it possible to use this peripheral in a
more advanced way.

Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
---
 sound/soc/fsl/fsl_asrc.c        | 18 ++++++++++++++++--
 sound/soc/fsl/fsl_asrc_common.h |  3 +++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 95f6a9617b0b..75df220e4b51 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -605,8 +605,8 @@ static int fsl_asrc_dai_hw_params(struct snd_pcm_substream *substream,
 
 	config.pair = pair->index;
 	config.channel_num = channels;
-	config.inclk = INCLK_NONE;
-	config.outclk = OUTCLK_ASRCK1_CLK;
+	config.inclk = asrc->inclk;
+	config.outclk = asrc->outclk;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		config.input_format   = params_format(params);
@@ -1067,6 +1067,20 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 
 	asrc->channel_avail = 10;
 
+	ret = of_property_read_u32(np, "fsl,asrc-input-clock",
+				   &asrc->inclk);
+	if (ret) {
+		dev_info(&pdev->dev, "no input clock specified, using none\n");
+		asrc->inclk = INCLK_NONE;
+	}
+
+	ret = of_property_read_u32(np, "fsl,asrc-output-clock",
+				   &asrc->outclk);
+	if (ret) {
+		dev_info(&pdev->dev, "no output clock specified, using default\n");
+		asrc->outclk = OUTCLK_ASRCK1_CLK;
+	}
+
 	ret = of_property_read_u32(np, "fsl,asrc-rate",
 				   &asrc->asrc_rate);
 	if (ret) {
diff --git a/sound/soc/fsl/fsl_asrc_common.h b/sound/soc/fsl/fsl_asrc_common.h
index 7e1c13ca37f1..1468878fbaca 100644
--- a/sound/soc/fsl/fsl_asrc_common.h
+++ b/sound/soc/fsl/fsl_asrc_common.h
@@ -89,6 +89,9 @@ struct fsl_asrc {
 	struct fsl_asrc_pair *pair[PAIR_CTX_NUM];
 	unsigned int channel_avail;
 
+	enum asrc_inclk inclk;
+	enum asrc_outclk outclk;
+
 	int asrc_rate;
 	snd_pcm_format_t asrc_format;
 	bool use_edma;
-- 
2.27.0

