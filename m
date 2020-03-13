Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E4AC5ACBF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9636B20767
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584094071;
	bh=Xcm3VCGWPDSjzjBWP/2DDPJCVTGZoHkn7ClLV4hpJZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IXtrmzJ3DeO2bAoVdEeqk5ICAWHELf306/rrYEGt2ur4Ku4l/rjdsXqRQc5DzZ1k1
	 wA/WenC7tXOLlPlPxiy4Nfs13iEvZe41Mw6rEX1WXpGwebGBTlgo8LR5/SbhRiLdXb
	 dNW7Eme349FF4ty8YhrUbHgw6g7+ayoRZ0qPjPQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgCMKHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:07:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgCMKHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:07:48 -0400
Received: from localhost.localdomain (unknown [171.76.107.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 963732074F;
        Fri, 13 Mar 2020 10:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584094068;
        bh=Xcm3VCGWPDSjzjBWP/2DDPJCVTGZoHkn7ClLV4hpJZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l7xxEBz9qfZBiG9M12zradv+/yKgdQnVj+rUlQo3iINa0Uxp1Gw7+hv56ZEk4Ib2R
         4zkV2oUMjrMjZ0UMzhDX+V5US8RKdnO9ycxsTUt8Lqo1ShqFEuL9GZbojZ9Fvx15j3
         o6WWazoqKTTU8AWMYwTRvYC2L3S77Y2yeJzdqNAA=
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
Subject: [PATCH v2 6/9] ALSA: compress: add alac & ape decoder params
Date:   Fri, 13 Mar 2020 15:37:05 +0530
Message-Id: <20200313100708.1558658-7-vkoul@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313095318.1555163-2-vkoul@kernel.org>
References: <20200313095318.1555163-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ALAC (Apple Lossless Audio Codec) and APE (Monkey's Lossless Audio
Codec) defines and parameters required to configure these.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 include/uapi/sound/compress_params.h | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/uapi/sound/compress_params.h b/include/uapi/sound/compress_params.h
index bf6f7155e775..79b14389ae41 100644
--- a/include/uapi/sound/compress_params.h
+++ b/include/uapi/sound/compress_params.h
@@ -75,7 +75,9 @@
 #define SND_AUDIOCODEC_G723_1                ((__u32) 0x0000000C)
 #define SND_AUDIOCODEC_G729                  ((__u32) 0x0000000D)
 #define SND_AUDIOCODEC_BESPOKE               ((__u32) 0x0000000E)
-#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_BESPOKE
+#define SND_AUDIOCODEC_ALAC                  ((__u32) 0x0000000F)
+#define SND_AUDIOCODEC_APE                   ((__u32) 0x00000010)
+#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_APE
 
 /*
  * Profile and modes are listed with bit masks. This allows for a
@@ -336,6 +338,26 @@ struct snd_dec_wma {
 	__u32 reserved;
 } __attribute__((packed, aligned(4)));
 
+struct snd_dec_alac {
+	__u32 frame_length;
+	__u8 compatible_version;
+	__u8 pb;
+	__u8 mb;
+	__u8 kb;
+	__u32 max_run;
+	__u32 max_frame_bytes;
+} __attribute__((packed, aligned(4)));
+
+struct snd_dec_ape {
+	__u16 compatible_version;
+	__u16 compression_level;
+	__u32 format_flags;
+	__u32 blocks_per_frame;
+	__u32 final_frame_blocks;
+	__u32 total_frames;
+	__u32 seek_table_present;
+} __attribute__((packed, aligned(4)));
+
 union snd_codec_options {
 	struct snd_enc_wma wma;
 	struct snd_enc_vorbis vorbis;
@@ -344,6 +366,8 @@ union snd_codec_options {
 	struct snd_enc_generic generic;
 	struct snd_dec_flac flac_d;
 	struct snd_dec_wma wma_d;
+	struct snd_dec_alac alac_d;
+	struct snd_dec_ape ape_d;
 } __attribute__((packed, aligned(4)));
 
 /** struct snd_codec_desc - description of codec capabilities
-- 
2.24.1

