Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBF3C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 20:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD8E42071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 20:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vWqoevsZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgIAUa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 16:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgIAUa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 16:30:57 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55540C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 13:30:57 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s205so3153319lja.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 13:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=la4DhayotspIOU+5g3vlgWa+RmakeChJjrIIEgn/ogw=;
        b=vWqoevsZD5zI8pIeuO8Ca2MITs/+7hzQveMdlSNzHuhxVOK5oSTeVvD1gfPyZm7r74
         huwNUkANsJTVTK2REuI0NafvjxEECEqlZiPV9M1fBW+GvUExz8VzGS390aQGzwtkylY3
         MgHSMUFyVIjnYHSuSYGV7rNvNaq/SETtaLQT5jJi3zs6KVEbAN3vRRpYOZIpIBbuFkIL
         hsyvpdEBbcR40bjZ5ZAswN38z+oZRwWi/MAUhEIuSn7pNVbnJuZeEOobnFe2GQtZSfHc
         MsQX43/pXgEFu16AxmUKV4Tgp2EJHRB6m+TbUlIfE9/VE8cCM8ZspbTPLlX5EHXmm46E
         cotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=la4DhayotspIOU+5g3vlgWa+RmakeChJjrIIEgn/ogw=;
        b=AcD/4YHJUgCtVtTjh4CODc+WfcM4KPnqEA1bqYYL7GwFX/fDEaOFair/EO/I/SMCpB
         5WOJ4oXI1esjlY3MBEwmciMIRjFITooCvCnJIsHo3iBuamnhxoLk0aRaBfHMfgMcFyGy
         lrYlL7kVwZzXVklm0QbkT4ZKP0vplvuVufZZllGtD6CvJFXLwfDP42y4G5kLtTHy8o5O
         UuLrBt7QpbamaUlOjadLW6jPscfLL/U2/rSF+Rm2thhMSFeI/K7v7ZwYCqcrma/1rKW8
         1edlP+HhE1a+4is93D+NCsrOOnvxEVnIBKowRem0wxIaNr4D0+UN4csdF0QLsT2KQ4a/
         MFYQ==
X-Gm-Message-State: AOAM532KhxwG23M+TbVbW7wHfNpxvhddYBsClQBSrq+Z/ZvH7GaREtRz
        UlGm27lKNPhR1/kG2mizBrs=
X-Google-Smtp-Source: ABdhPJx/W4RCS7rXI0/ehjeP/Ih206sqprvXQ3FMt1vaGuoqaB4m4MYMUMogPEZVR8ee9fxp/RYNag==
X-Received: by 2002:a2e:9b8f:: with SMTP id z15mr1407054lji.215.1598992255760;
        Tue, 01 Sep 2020 13:30:55 -0700 (PDT)
Received: from localhost.localdomain ([188.163.51.46])
        by smtp.gmail.com with ESMTPSA id t1sm517996lfc.52.2020.09.01.13.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 13:30:55 -0700 (PDT)
From:   Roman Stratiienko <r.stratiienko@gmail.com>
To:     jernej.skrabec@siol.net
Cc:     Roman Stratiienko <r.stratiienko@gmail.com>, megous@megous.com,
        jernej.skrabec@gmail.com, linux-sunxi@googlegroups.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RFC: sun4i/drm: Swap back U and V channels for DRM_FORMAT_YVU4xx
Date:   Tue,  1 Sep 2020 23:30:47 +0300
Message-Id: <20200901203047.1110851-1-r.stratiienko@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: e1ef9006663b ("drm/sun4i: Wire in DE2 YUV support")
Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>

---
CC: megous@megous.com
CC: jernej.skrabec@gmail.com
CC: linux-sunxi@googlegroups.com
CC: dri-devel@lists.freedesktop.org
CC: linux-arm-kernel@lists.infradead.org
CC: linux-kernel@vger.kernel.org

Hi, this patch fixes wrong colors during video playback for me.
Implemented ugly for now, please review/suggest how to improve.
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c    |  8 +++++++-
 drivers/gpu/drm/sun4i/sun8i_mixer.h    |  2 +-
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c |  2 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 28 +++++++++++++++++++-------
 4 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index dce40c430100..bbbeef44899a 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -31,6 +31,7 @@
 struct de2_fmt_info {
 	u32	drm_fmt;
 	u32	de2_fmt;
+	bool	swap_uv;
 };
 
 static bool hw_preconfigured;
@@ -219,14 +220,17 @@ static const struct de2_fmt_info de2_formats[] = {
 	{
 		.drm_fmt = DRM_FORMAT_YVU422,
 		.de2_fmt = SUN8I_MIXER_FBFMT_YUV422,
+		.swap_uv = true,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_YVU420,
 		.de2_fmt = SUN8I_MIXER_FBFMT_YUV420,
+		.swap_uv = true,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_YVU411,
 		.de2_fmt = SUN8I_MIXER_FBFMT_YUV411,
+		.swap_uv = true,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_P010,
@@ -238,13 +242,15 @@ static const struct de2_fmt_info de2_formats[] = {
 	},
 };
 
-int sun8i_mixer_drm_format_to_hw(u32 format, u32 *hw_format)
+int sun8i_mixer_drm_format_to_hw(u32 format, u32 *hw_format, bool *swap_uv)
 {
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(de2_formats); ++i)
 		if (de2_formats[i].drm_fmt == format) {
 			*hw_format = de2_formats[i].de2_fmt;
+			if (swap_uv)
+				*swap_uv = de2_formats[i].swap_uv;
 			return 0;
 		}
 
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index 79a74bca1ea3..6358ffd251f9 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -207,5 +207,5 @@ sun8i_channel_base(struct sun8i_mixer *mixer, int channel)
 		return DE2_CH_BASE + channel * DE2_CH_SIZE;
 }
 
-int sun8i_mixer_drm_format_to_hw(u32 format, u32 *hw_format);
+int sun8i_mixer_drm_format_to_hw(u32 format, u32 *hw_format, bool *swap_uv);
 #endif /* _SUN8I_MIXER_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index a7f21f08ec89..57bbd9f1071c 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -215,7 +215,7 @@ static int sun8i_ui_layer_update_formats(struct sun8i_mixer *mixer, int channel,
 	ch_base = sun8i_channel_base(mixer, channel);
 
 	fmt = state->fb->format;
-	ret = sun8i_mixer_drm_format_to_hw(fmt->format, &hw_fmt);
+	ret = sun8i_mixer_drm_format_to_hw(fmt->format, &hw_fmt, NULL);
 	if (ret || fmt->is_yuv) {
 		DRM_DEBUG_DRIVER("Invalid format\n");
 		return -EINVAL;
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index 3553e38ec642..4da51155c4d5 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -313,7 +313,7 @@ static int sun8i_vi_layer_update_formats(struct sun8i_mixer *mixer, int channel,
 	ch_base = sun8i_channel_base(mixer, channel);
 
 	fmt = state->fb->format;
-	ret = sun8i_mixer_drm_format_to_hw(fmt->format, &hw_fmt);
+	ret = sun8i_mixer_drm_format_to_hw(fmt->format, &hw_fmt, NULL);
 	if (ret) {
 		DRM_DEBUG_DRIVER("Invalid format\n");
 		return ret;
@@ -368,8 +368,17 @@ static int sun8i_vi_layer_update_buffer(struct sun8i_mixer *mixer, int channel,
 	struct drm_gem_cma_object *gem;
 	u32 dx, dy, src_x, src_y;
 	dma_addr_t paddr;
+	bool swap_uv;
 	u32 ch_base;
-	int i;
+	u32 hw_fmt;
+	int ret;
+	int i, j;
+
+	ret = sun8i_mixer_drm_format_to_hw(plane->state->fb->format->format, &hw_fmt, &swap_uv);
+	if (ret) {
+		DRM_DEBUG_DRIVER("Invalid format\n");
+		return ret;
+	}
 
 	ch_base = sun8i_channel_base(mixer, channel);
 
@@ -377,7 +386,12 @@ static int sun8i_vi_layer_update_buffer(struct sun8i_mixer *mixer, int channel,
 	src_x = (state->src.x1 >> 16) & ~(format->hsub - 1);
 	src_y = (state->src.y1 >> 16) & ~(format->vsub - 1);
 
-	for (i = 0; i < format->num_planes; i++) {
+	for (j = 0; j < format->num_planes; j++) {
+		i = j;
+		if (swap_uv && i > 0 && format->num_planes == 3) {
+			i = j == 1 ? 2 : 1;
+		}
+
 		/* Get the physical address of the buffer in memory */
 		gem = drm_fb_cma_get_gem_obj(fb, i);
 
@@ -400,18 +414,18 @@ static int sun8i_vi_layer_update_buffer(struct sun8i_mixer *mixer, int channel,
 
 		/* Set the line width */
 		DRM_DEBUG_DRIVER("Layer %d. line width: %d bytes\n",
-				 i + 1, fb->pitches[i]);
+				 j + 1, fb->pitches[i]);
 		regmap_write(mixer->engine.regs,
 			     SUN8I_MIXER_CHAN_VI_LAYER_PITCH(ch_base,
-							     overlay, i),
+							     overlay, j),
 			     fb->pitches[i]);
 
 		DRM_DEBUG_DRIVER("Setting %d. buffer address to %pad\n",
-				 i + 1, &paddr);
+				 j + 1, &paddr);
 
 		regmap_write(mixer->engine.regs,
 			     SUN8I_MIXER_CHAN_VI_LAYER_TOP_LADDR(ch_base,
-								 overlay, i),
+								 overlay, j),
 			     lower_32_bits(paddr));
 	}
 
-- 
2.25.1

