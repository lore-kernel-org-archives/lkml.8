Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B535C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 03:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5695520706
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 03:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="UBT+WpV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388683AbgEZDW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 23:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388614AbgEZDW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 23:22:56 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48290C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 20:22:56 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id n11so13778842qkn.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 20:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U6JoPTdjkz+45kY9odem2/tpmIH2DgJ0qZswkC57fvc=;
        b=UBT+WpV+fwo5sJ72GfNEyroLg1nDR6g6zWr1i/S332QzFn6I5QLJk41CJySQyfSTvw
         mKbH5t27SNkMuBPDUn0V9xfp9r4kwLtKa5zbmDH4290Ht4Zwrql4L1DJ6/XQz1zX9IFU
         1wHGQv2bV8/ttdhMID2Hy7Rv65yHCGPd3SlE/EGI/ZOqzGkT9xe9niJVHPEUJeJKBb1Z
         1MqvjfmhWRHyYxxutMM5414FAa2dvfT8QffdXO69qk7KFU9dQue39UMZaQ4y6+0rSc/L
         3QymdjgAAdT2vVDZHw3oGG6bVgWV8bc4JiVttos9TXMydLQHUBs0vCJUqOMaMPRbOpwS
         dTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U6JoPTdjkz+45kY9odem2/tpmIH2DgJ0qZswkC57fvc=;
        b=ATor0XTkU2msw3Lu2h0X01MVWf4eIz5NwviWjrB+N8HBNHIeJg4G/adJXOhFyP2yo8
         LbqZSLc9nCtlyhB/HCJ4KpfbGAnfhIXyhtL/HR3nYXyUuK+6GkqqITOCmTVNHLUnTqTm
         zBsFNik8aXOmAXsFUzGHif780dE32a8sEGFX202l6AyQug9pAF5jXRuyNW4XkN/PEClD
         haTTVMeYQ4Ex50QBB++xl/Gsl2XXa8/pWwmyp0M9nBaspeHVDGH8oguk1jioPlxS/llE
         tUlRSZEryin/XHRXODtM5lzxe/pq50MibNty8EQMMLq4dq38oMSZWq4kzMqezuXN5v++
         +qXg==
X-Gm-Message-State: AOAM532FeqcAMzCgH5XYWaAmYE4YseGWSaOmR/Dc1lPvD2q40dcixHpN
        iMs87v6oyUmCBBBxuqHrCcQeEg==
X-Google-Smtp-Source: ABdhPJxhFrY2/78u8LUmuMCxUroab82NWds/IAcGEufa6ErIyeUyEgjZGc1K4ik+4puto44Ztigowg==
X-Received: by 2002:ae9:ebd7:: with SMTP id b206mr11255223qkg.372.1590463375513;
        Mon, 25 May 2020 20:22:55 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id k20sm2530796qtu.16.2020.05.25.20.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 20:22:55 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shubhashree Dhar <dhar@codeaurora.org>,
        Raviteja Tamatam <travitej@codeaurora.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        zhengbin <zhengbin13@huawei.com>,
        Allison Randal <allison@lohutok.net>,
        Brian Masney <masneyb@onstation.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/8] drm/msm/dpu: move some sspp caps to dpu_caps
Date:   Mon, 25 May 2020 23:22:10 -0400
Message-Id: <20200526032235.21930-4-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200526032235.21930-1-jonathan@marek.ca>
References: <20200526032235.21930-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This isn't something that ever changes between planes, so move it to
dpu_caps struct. Making this change will allow more re-use in the
"SSPP sub blocks config" part of the catalog, in particular when adding
support for SM8150 and SM8250 which have different max_linewidth.

This also sets max_hdeci_exp/max_vdeci_exp to 0 for sc7180, as decimation
is not supported on the newest DPU versions. (note that decimation is not
implemented, so this changes nothing)

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 14 +++++------
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    | 24 +++++++------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c     |  6 ++---
 3 files changed, 17 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index c567917541e8..496407f1cd08 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -68,6 +68,10 @@ static const struct dpu_caps sdm845_dpu_caps = {
 	.has_dim_layer = true,
 	.has_idle_pc = true,
 	.has_3d_merge = true,
+	.max_linewidth = DEFAULT_DPU_OUTPUT_LINE_WIDTH,
+	.pixel_ram_size = DEFAULT_PIXEL_RAM_SIZE,
+	.max_hdeci_exp = MAX_HORZ_DECIMATION,
+	.max_vdeci_exp = MAX_VERT_DECIMATION,
 };
 
 static const struct dpu_caps sc7180_dpu_caps = {
@@ -78,6 +82,8 @@ static const struct dpu_caps sc7180_dpu_caps = {
 	.ubwc_version = DPU_HW_UBWC_VER_20,
 	.has_dim_layer = true,
 	.has_idle_pc = true,
+	.max_linewidth = DEFAULT_DPU_OUTPUT_LINE_WIDTH,
+	.pixel_ram_size = DEFAULT_PIXEL_RAM_SIZE,
 };
 
 static const struct dpu_mdp_cfg sdm845_mdp[] = {
@@ -176,16 +182,9 @@ static const struct dpu_ctl_cfg sc7180_ctl[] = {
  *************************************************************/
 
 /* SSPP common configuration */
-static const struct dpu_sspp_blks_common sdm845_sspp_common = {
-	.maxlinewidth = DEFAULT_DPU_OUTPUT_LINE_WIDTH,
-	.pixel_ram_size = DEFAULT_PIXEL_RAM_SIZE,
-	.maxhdeciexp = MAX_HORZ_DECIMATION,
-	.maxvdeciexp = MAX_VERT_DECIMATION,
-};
 
 #define _VIG_SBLK(num, sdma_pri, qseed_ver) \
 	{ \
-	.common = &sdm845_sspp_common, \
 	.maxdwnscale = MAX_DOWNSCALE_RATIO, \
 	.maxupscale = MAX_UPSCALE_RATIO, \
 	.smart_dma_priority = sdma_pri, \
@@ -205,7 +204,6 @@ static const struct dpu_sspp_blks_common sdm845_sspp_common = {
 
 #define _DMA_SBLK(num, sdma_pri) \
 	{ \
-	.common = &sdm845_sspp_common, \
 	.maxdwnscale = SSPP_UNITY_SCALE, \
 	.maxupscale = SSPP_UNITY_SCALE, \
 	.smart_dma_priority = sdma_pri, \
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index f45f031a3a05..7a8d1c6658d2 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -290,6 +290,10 @@ struct dpu_qos_lut_tbl {
  * @has_dim_layer      dim layer feature status
  * @has_idle_pc        indicate if idle power collapse feature is supported
  * @has_3d_merge       indicate if 3D merge is supported
+ * @max_linewidth      max linewidth for sspp
+ * @pixel_ram_size     size of latency hiding and de-tiling buffer in bytes
+ * @max_hdeci_exp      max horizontal decimation supported (max is 2^value)
+ * @max_vdeci_exp      max vertical decimation supported (max is 2^value)
  */
 struct dpu_caps {
 	u32 max_mixer_width;
@@ -301,22 +305,11 @@ struct dpu_caps {
 	bool has_dim_layer;
 	bool has_idle_pc;
 	bool has_3d_merge;
-};
-
-/**
- * struct dpu_sspp_blks_common : SSPP sub-blocks common configuration
- * @maxwidth: max pixelwidth supported by this pipe
- * @pixel_ram_size: size of latency hiding and de-tiling buffer in bytes
- * @maxhdeciexp: max horizontal decimation supported by this pipe
- *				(max is 2^value)
- * @maxvdeciexp: max vertical decimation supported by this pipe
- *				(max is 2^value)
- */
-struct dpu_sspp_blks_common {
-	u32 maxlinewidth;
+	/* SSPP limits */
+	u32 max_linewidth;
 	u32 pixel_ram_size;
-	u32 maxhdeciexp;
-	u32 maxvdeciexp;
+	u32 max_hdeci_exp;
+	u32 max_vdeci_exp;
 };
 
 /**
@@ -342,7 +335,6 @@ struct dpu_sspp_blks_common {
  * @virt_num_formats: Number of supported formats for virtual planes
  */
 struct dpu_sspp_sub_blks {
-	const struct dpu_sspp_blks_common *common;
 	u32 creq_vblank;
 	u32 danger_vblank;
 	u32 maxdwnscale;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 3b9c33e694bf..33f6c56f01ed 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -153,7 +153,7 @@ static int _dpu_plane_calc_fill_level(struct drm_plane *plane,
 
 	pdpu = to_dpu_plane(plane);
 	pstate = to_dpu_plane_state(plane->state);
-	fixed_buff_size = pdpu->pipe_sblk->common->pixel_ram_size;
+	fixed_buff_size = pdpu->catalog->caps->pixel_ram_size;
 
 	list_for_each_entry(tmp, &pdpu->mplane_list, mplane_list) {
 		if (!tmp->base.state->visible)
@@ -709,7 +709,7 @@ int dpu_plane_validate_multirect_v2(struct dpu_multirect_plane_states *plane)
 		 * So we cannot support more than half of the supported SSPP
 		 * width for tiled formats.
 		 */
-		width_threshold = dpu_plane[i]->pipe_sblk->common->maxlinewidth;
+		width_threshold = dpu_plane[i]->catalog->caps->max_linewidth;
 		if (has_tiled_rect)
 			width_threshold /= 2;
 
@@ -887,7 +887,7 @@ static int dpu_plane_atomic_check(struct drm_plane *plane,
 	fb_rect.x2 = state->fb->width;
 	fb_rect.y2 = state->fb->height;
 
-	max_linewidth = pdpu->pipe_sblk->common->maxlinewidth;
+	max_linewidth = pdpu->catalog->caps->max_linewidth;
 
 	fmt = to_dpu_format(msm_framebuffer_format(state->fb));
 
-- 
2.26.1

