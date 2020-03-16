Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBAFC1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 05:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543F420736
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 05:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584338189;
	bh=cXZqQW4/mcY/jxsnCR+Mz1HLzydbspS5ElOVcB9LnGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RsMX1oh/w7X0dZ5jUz2kyy2d9GHYOXG5rXDn2xT74EpFslSA2LLC3wfgkmNDGypcD
	 QxXutXA35PHSFAjSjQwacnKG9NEGAP8JrFeSOig4yxVGIRS8gSQc6xJT8ZZvKvwzOR
	 2Cq2X5C82AhlIYvKzh8sGsdLiitX2zHPcLPrOBjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbgCPF42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 01:56:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728856AbgCPF41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 01:56:27 -0400
Received: from vkoul-mobl.Dlink (unknown [49.207.58.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FE842071C;
        Mon, 16 Mar 2020 05:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584338186;
        bh=cXZqQW4/mcY/jxsnCR+Mz1HLzydbspS5ElOVcB9LnGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VFRGCTuBXLHKeN9x8aXnI8R5G2VaDjLgGY/XqPaPrHz8YGM67TkZpV2zttsoK6Wyj
         gDT0WTlNdEEBzZf69Qm+31hF3ASV43bmA5xKcksrBGnY3c/IgJAxwXjfH482kvf1LP
         sR5U/e3h6fmkjHHSq1PF5DbCnjdSXKun6wuClDMs=
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/9] ASoC: qcom: q6asm-dai: add support for ALAC and APE decoders
Date:   Mon, 16 Mar 2020 11:22:20 +0530
Message-Id: <20200316055221.1944464-9-vkoul@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316055221.1944464-1-vkoul@kernel.org>
References: <20200316055221.1944464-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm DSPs also supports the ALAC and APE decoders, so add support
for these and convert the snd_codec_params to qdsp format.

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 70 +++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 53c250778eea..833486545d4b 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -41,6 +41,9 @@
 #define Q6ASM_DAI_TX	1
 #define Q6ASM_DAI_RX	2
 
+#define ALAC_CH_LAYOUT_MONO   ((101 << 16) | 1)
+#define ALAC_CH_LAYOUT_STEREO ((101 << 16) | 2)
+
 enum stream_state {
 	Q6ASM_STREAM_IDLE = 0,
 	Q6ASM_STREAM_STOPPED,
@@ -628,12 +631,16 @@ static int q6asm_dai_compr_set_params(struct snd_compr_stream *stream,
 	struct q6asm_dai_data *pdata;
 	struct q6asm_flac_cfg flac_cfg;
 	struct q6asm_wma_cfg wma_cfg;
+	struct q6asm_alac_cfg alac_cfg;
+	struct q6asm_ape_cfg ape_cfg;
 	unsigned int wma_v9 = 0;
 	struct device *dev = c->dev;
 	int ret;
 	union snd_codec_options *codec_options;
 	struct snd_dec_flac *flac;
 	struct snd_dec_wma *wma;
+	struct snd_dec_alac *alac;
+	struct snd_dec_ape *ape;
 
 	codec_options = &(prtd->codec_param.codec.options);
 
@@ -756,6 +763,65 @@ static int q6asm_dai_compr_set_params(struct snd_compr_stream *stream,
 			dev_err(dev, "WMA9 CMD failed:%d\n", ret);
 			return -EIO;
 		}
+		break;
+
+	case SND_AUDIOCODEC_ALAC:
+		memset(&alac_cfg, 0x0, sizeof(alac_cfg));
+		alac = &codec_options->alac_d;
+
+		alac_cfg.sample_rate = params->codec.sample_rate;
+		alac_cfg.avg_bit_rate = params->codec.bit_rate;
+		alac_cfg.bit_depth = prtd->bits_per_sample;
+		alac_cfg.num_channels = params->codec.ch_in;
+
+		alac_cfg.frame_length = alac->frame_length;
+		alac_cfg.pb = alac->pb;
+		alac_cfg.mb = alac->mb;
+		alac_cfg.kb = alac->kb;
+		alac_cfg.max_run = alac->max_run;
+		alac_cfg.compatible_version = alac->compatible_version;
+		alac_cfg.max_frame_bytes = alac->max_frame_bytes;
+
+		switch (params->codec.ch_in) {
+		case 1:
+			alac_cfg.channel_layout_tag = ALAC_CH_LAYOUT_MONO;
+			break;
+		case 2:
+			alac_cfg.channel_layout_tag = ALAC_CH_LAYOUT_STEREO;
+			break;
+		}
+		ret = q6asm_stream_media_format_block_alac(prtd->audio_client,
+							   &alac_cfg);
+		if (ret < 0) {
+			dev_err(dev, "ALAC CMD Format block failed:%d\n", ret);
+			return -EIO;
+		}
+		break;
+
+	case SND_AUDIOCODEC_APE:
+		memset(&ape_cfg, 0x0, sizeof(ape_cfg));
+		ape = &codec_options->ape_d;
+
+		ape_cfg.sample_rate = params->codec.sample_rate;
+		ape_cfg.num_channels = params->codec.ch_in;
+		ape_cfg.bits_per_sample = prtd->bits_per_sample;
+
+		ape_cfg.compatible_version = ape->compatible_version;
+		ape_cfg.compression_level = ape->compression_level;
+		ape_cfg.format_flags = ape->format_flags;
+		ape_cfg.blocks_per_frame = ape->blocks_per_frame;
+		ape_cfg.final_frame_blocks = ape->final_frame_blocks;
+		ape_cfg.total_frames = ape->total_frames;
+		ape_cfg.seek_table_present = ape->seek_table_present;
+
+		ret = q6asm_stream_media_format_block_ape(prtd->audio_client,
+							  &ape_cfg);
+		if (ret < 0) {
+			dev_err(dev, "APE CMD Format block failed:%d\n", ret);
+			return -EIO;
+		}
+		break;
+
 	default:
 		break;
 	}
@@ -855,10 +921,12 @@ static int q6asm_dai_compr_get_caps(struct snd_compr_stream *stream,
 	caps->max_fragment_size = COMPR_PLAYBACK_MAX_FRAGMENT_SIZE;
 	caps->min_fragments = COMPR_PLAYBACK_MIN_NUM_FRAGMENTS;
 	caps->max_fragments = COMPR_PLAYBACK_MAX_NUM_FRAGMENTS;
-	caps->num_codecs = 3;
+	caps->num_codecs = 5;
 	caps->codecs[0] = SND_AUDIOCODEC_MP3;
 	caps->codecs[1] = SND_AUDIOCODEC_FLAC;
 	caps->codecs[2] = SND_AUDIOCODEC_WMA;
+	caps->codecs[3] = SND_AUDIOCODEC_ALAC;
+	caps->codecs[4] = SND_AUDIOCODEC_APE;
 
 	return 0;
 }
-- 
2.24.1

