Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFCDC33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 08:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ADF22082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 08:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlaiFCVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgA3Icw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 03:32:52 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34446 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbgA3Icu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 03:32:50 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so2959172wrr.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 00:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8J5B9hnulSOKfzbKUaNLIc6gRidEchVACCqkF5n/5e0=;
        b=RlaiFCVd0WeeQ/YCINHZ/y7a9IzTV8BJfbLguMk4fGAlfbhsJ2lbCjUzKxPfY643ta
         qDkUGlLSLo9e7kO6vGDxwEkmKKT4dQc0KhqYatHJZyGaHDHS2NeLN19wl6CtSDO6eje2
         LY1eQ7+ee9O8AEYUgmHZnUhpQbdAWJomUPIvtEjLOdTUIwTlJcj274mYzunvPc/oS2LS
         r1hiXBFizo8W3VTc1Eaw0kGW/4F3E5YMGxilYDuARlGFrAKNoM/NC6wLP2bZXQWBtY3U
         1aoBIdeliZXWRonYHA4/I1vR2faZv4T3rl3O8iQ1BKevx0GT+zpwGvfonPS4NqofrDeM
         NFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8J5B9hnulSOKfzbKUaNLIc6gRidEchVACCqkF5n/5e0=;
        b=LfydY+wPdI/4pa7iW8Bja+L3wWIASAJQJ8bnWkquL9XRChlavvamyXiXRUNNzTwdaH
         xIJOKCnBYFWGax8IRbmGRpdQNu6xF8pOGCw5zgzQ4aUNBqNej27vH5W7S70wndN4Euyx
         z4oh/Rf/OoaYDB8732JMXI0VIhvsZ0z9Qok4zpRA2TNLUW3EFdGvCzJGk4I2qmAJ4TeU
         wXVmoIza9/nFMMP/HOudqqFRimR5QkEWSIsSx1Cpjh5/0GU1ljQSgH6ok5hsO0KlY5cs
         fRkIE0uhjC7m59sg0IoS/4FnJgB/N4tvhyNXYav2iQu6bmKeSKNOTx5bqPAyiRhYZ3eG
         XckA==
X-Gm-Message-State: APjAAAU+XgnjFiRtKJdnUNl3beSx6lZ4LE644fcO+wAQze75l43xcgZz
        jaJvdD7B8MKlNYch/yFx7Z0=
X-Google-Smtp-Source: APXvYqwgoZSUJbFU4Qk6CmAckH0bjm+7XVHh3hsIITyipSfHKoiGk+5MUIu8LtNPy/o+QEqIlkb2wA==
X-Received: by 2002:adf:f1d0:: with SMTP id z16mr3894320wro.209.1580373168122;
        Thu, 30 Jan 2020 00:32:48 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id i11sm6363678wrs.10.2020.01.30.00.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 00:32:47 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] drm/i915/vdsc: convert to struct drm_device based logging macros.
Date:   Thu, 30 Jan 2020 11:32:21 +0300
Message-Id: <20200130083229.12889-5-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130083229.12889-1-wambui.karugax@gmail.com>
References: <20200130083229.12889-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts uses of the printk based drm logging macros to the new struct
drm_device based logging macros in i915/display/intel_vdsc.c.
This was done using the following coccinelle script that transforms
based on the existence of a struct drm_i915_private device:
@@
identifier fn, T;
@@

fn(...) {
...
struct drm_i915_private *T = ...;
<+...
(
-DRM_INFO(
+drm_info(&T->drm,
...)
|
-DRM_ERROR(
+drm_err(&T->drm,
...)
|
-DRM_WARN(
+drm_warn(&T->drm,
...)
|
-DRM_DEBUG(
+drm_dbg(&T->drm,
...)
|
-DRM_DEBUG_KMS(
+drm_dbg_kms(&T->drm,
...)
|
-DRM_DEBUG_DRIVER(
+drm_dbg(&T->drm,
...)
|
-DRM_DEBUG_ATOMIC(
+drm_dbg_atomic(&T->drm,
...)
)
...+>
}

@@
identifier fn, T;
@@

fn(...,struct drm_i915_private *T,...) {
<+...
(
-DRM_INFO(
+drm_info(&T->drm,
...)
|
-DRM_ERROR(
+drm_err(&T->drm,
...)
|
-DRM_WARN(
+drm_warn(&T->drm,
...)
|
-DRM_DEBUG(
+drm_dbg(&T->drm,
...)
|
-DRM_DEBUG_DRIVER(
+drm_dbg(&T->drm,
...)
|
-DRM_DEBUG_KMS(
+drm_dbg_kms(&T->drm,
...)
|
-DRM_DEBUG_ATOMIC(
+drm_dbg_atomic(&T->drm,
...)
)
...+>
}

Checkpatch warnings were fixed manually.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_vdsc.c | 28 +++++++++++------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_vdsc.c b/drivers/gpu/drm/i915/display/intel_vdsc.c
index a81abadb067f..5571f0442dd0 100644
--- a/drivers/gpu/drm/i915/display/intel_vdsc.c
+++ b/drivers/gpu/drm/i915/display/intel_vdsc.c
@@ -518,7 +518,7 @@ static void intel_dsc_pps_configure(struct intel_encoder *encoder,
 		pps_val |= DSC_422_ENABLE;
 	if (vdsc_cfg->vbr_enable)
 		pps_val |= DSC_VBR_ENABLE;
-	DRM_INFO("PPS0 = 0x%08x\n", pps_val);
+	drm_info(&dev_priv->drm, "PPS0 = 0x%08x\n", pps_val);
 	if (!is_pipe_dsc(crtc_state)) {
 		intel_de_write(dev_priv, DSCA_PICTURE_PARAMETER_SET_0,
 			       pps_val);
@@ -542,7 +542,7 @@ static void intel_dsc_pps_configure(struct intel_encoder *encoder,
 	/* Populate PICTURE_PARAMETER_SET_1 registers */
 	pps_val = 0;
 	pps_val |= DSC_BPP(vdsc_cfg->bits_per_pixel);
-	DRM_INFO("PPS1 = 0x%08x\n", pps_val);
+	drm_info(&dev_priv->drm, "PPS1 = 0x%08x\n", pps_val);
 	if (!is_pipe_dsc(crtc_state)) {
 		intel_de_write(dev_priv, DSCA_PICTURE_PARAMETER_SET_1,
 			       pps_val);
@@ -567,7 +567,7 @@ static void intel_dsc_pps_configure(struct intel_encoder *encoder,
 	pps_val = 0;
 	pps_val |= DSC_PIC_HEIGHT(vdsc_cfg->pic_height) |
 		DSC_PIC_WIDTH(vdsc_cfg->pic_width / num_vdsc_instances);
-	DRM_INFO("PPS2 = 0x%08x\n", pps_val);
+	drm_info(&dev_priv->drm, "PPS2 = 0x%08x\n", pps_val);
 	if (!is_pipe_dsc(crtc_state)) {
 		intel_de_write(dev_priv, DSCA_PICTURE_PARAMETER_SET_2,
 			       pps_val);
@@ -592,7 +592,7 @@ static void intel_dsc_pps_configure(struct intel_encoder *encoder,
 	pps_val = 0;
 	pps_val |= DSC_SLICE_HEIGHT(vdsc_cfg->slice_height) |
 		DSC_SLICE_WIDTH(vdsc_cfg->slice_width);
-	DRM_INFO("PPS3 = 0x%08x\n", pps_val);
+	drm_info(&dev_priv->drm, "PPS3 = 0x%08x\n", pps_val);
 	if (!is_pipe_dsc(crtc_state)) {
 		intel_de_write(dev_priv, DSCA_PICTURE_PARAMETER_SET_3,
 			       pps_val);
@@ -617,7 +617,7 @@ static void intel_dsc_pps_configure(struct intel_encoder *encoder,
 	pps_val = 0;
 	pps_val |= DSC_INITIAL_XMIT_DELAY(vdsc_cfg->initial_xmit_delay) |
 		DSC_INITIAL_DEC_DELAY(vdsc_cfg->initial_dec_delay);
-	DRM_INFO("PPS4 = 0x%08x\n", pps_val);
+	drm_info(&dev_priv->drm, "PPS4 = 0x%08x\n", pps_val);
 	if (!is_pipe_dsc(crtc_state)) {
 		intel_de_write(dev_priv, DSCA_PICTURE_PARAMETER_SET_4,
 			       pps_val);
@@ -642,7 +642,7 @@ static void intel_dsc_pps_configure(struct intel_encoder *encoder,
 	pps_val = 0;
 	pps_val |= DSC_SCALE_INC_INT(vdsc_cfg->scale_increment_interval) |
 		DSC_SCALE_DEC_INT(vdsc_cfg->scale_decrement_interval);
-	DRM_INFO("PPS5 = 0x%08x\n", pps_val);
+	drm_info(&dev_priv->drm, "PPS5 = 0x%08x\n", pps_val);
 	if (!is_pipe_dsc(crtc_state)) {
 		intel_de_write(dev_priv, DSCA_PICTURE_PARAMETER_SET_5,
 			       pps_val);
@@ -669,7 +669,7 @@ static void intel_dsc_pps_configure(struct intel_encoder *encoder,
 		DSC_FIRST_LINE_BPG_OFFSET(vdsc_cfg->first_line_bpg_offset) |
 		DSC_FLATNESS_MIN_QP(vdsc_cfg->flatness_min_qp) |
 		DSC_FLATNESS_MAX_QP(vdsc_cfg->flatness_max_qp);
-	DRM_INFO("PPS6 = 0x%08x\n", pps_val);
+	drm_info(&dev_priv->drm, "PPS6 = 0x%08x\n", pps_val);
 	if (!is_pipe_dsc(crtc_state)) {
 		intel_de_write(dev_priv, DSCA_PICTURE_PARAMETER_SET_6,
 			       pps_val);
@@ -694,7 +694,7 @@ static void intel_dsc_pps_configure(struct intel_encoder *encoder,
 	pps_val = 0;
 	pps_val |= DSC_SLICE_BPG_OFFSET(vdsc_cfg->slice_bpg_offset) |
 		DSC_NFL_BPG_OFFSET(vdsc_cfg->nfl_bpg_offset);
-	DRM_INFO("PPS7 = 0x%08x\n", pps_val);
+	drm_info(&dev_priv->drm, "PPS7 = 0x%08x\n", pps_val);
 	if (!is_pipe_dsc(crtc_state)) {
 		intel_de_write(dev_priv, DSCA_PICTURE_PARAMETER_SET_7,
 			       pps_val);
@@ -719,7 +719,7 @@ static void intel_dsc_pps_configure(struct intel_encoder *encoder,
 	pps_val = 0;
 	pps_val |= DSC_FINAL_OFFSET(vdsc_cfg->final_offset) |
 		DSC_INITIAL_OFFSET(vdsc_cfg->initial_offset);
-	DRM_INFO("PPS8 = 0x%08x\n", pps_val);
+	drm_info(&dev_priv->drm, "PPS8 = 0x%08x\n", pps_val);
 	if (!is_pipe_dsc(crtc_state)) {
 		intel_de_write(dev_priv, DSCA_PICTURE_PARAMETER_SET_8,
 			       pps_val);
@@ -744,7 +744,7 @@ static void intel_dsc_pps_configure(struct intel_encoder *encoder,
 	pps_val = 0;
 	pps_val |= DSC_RC_MODEL_SIZE(DSC_RC_MODEL_SIZE_CONST) |
 		DSC_RC_EDGE_FACTOR(DSC_RC_EDGE_FACTOR_CONST);
-	DRM_INFO("PPS9 = 0x%08x\n", pps_val);
+	drm_info(&dev_priv->drm, "PPS9 = 0x%08x\n", pps_val);
 	if (!is_pipe_dsc(crtc_state)) {
 		intel_de_write(dev_priv, DSCA_PICTURE_PARAMETER_SET_9,
 			       pps_val);
@@ -771,7 +771,7 @@ static void intel_dsc_pps_configure(struct intel_encoder *encoder,
 		DSC_RC_QUANT_INC_LIMIT1(vdsc_cfg->rc_quant_incr_limit1) |
 		DSC_RC_TARGET_OFF_HIGH(DSC_RC_TGT_OFFSET_HI_CONST) |
 		DSC_RC_TARGET_OFF_LOW(DSC_RC_TGT_OFFSET_LO_CONST);
-	DRM_INFO("PPS10 = 0x%08x\n", pps_val);
+	drm_info(&dev_priv->drm, "PPS10 = 0x%08x\n", pps_val);
 	if (!is_pipe_dsc(crtc_state)) {
 		intel_de_write(dev_priv, DSCA_PICTURE_PARAMETER_SET_10,
 			       pps_val);
@@ -799,7 +799,7 @@ static void intel_dsc_pps_configure(struct intel_encoder *encoder,
 				   vdsc_cfg->slice_width) |
 		DSC_SLICE_ROW_PER_FRAME(vdsc_cfg->pic_height /
 					vdsc_cfg->slice_height);
-	DRM_INFO("PPS16 = 0x%08x\n", pps_val);
+	drm_info(&dev_priv->drm, "PPS16 = 0x%08x\n", pps_val);
 	if (!is_pipe_dsc(crtc_state)) {
 		intel_de_write(dev_priv, DSCA_PICTURE_PARAMETER_SET_16,
 			       pps_val);
@@ -826,7 +826,7 @@ static void intel_dsc_pps_configure(struct intel_encoder *encoder,
 		rc_buf_thresh_dword[i / 4] |=
 			(u32)(vdsc_cfg->rc_buf_thresh[i] <<
 			      BITS_PER_BYTE * (i % 4));
-		DRM_INFO(" RC_BUF_THRESH%d = 0x%08x\n", i,
+		drm_info(&dev_priv->drm, " RC_BUF_THRESH%d = 0x%08x\n", i,
 			 rc_buf_thresh_dword[i / 4]);
 	}
 	if (!is_pipe_dsc(crtc_state)) {
@@ -883,7 +883,7 @@ static void intel_dsc_pps_configure(struct intel_encoder *encoder,
 				RC_MAX_QP_SHIFT) |
 			       (vdsc_cfg->rc_range_params[i].range_min_qp <<
 				RC_MIN_QP_SHIFT)) << 16 * (i % 2));
-		DRM_INFO(" RC_RANGE_PARAM_%d = 0x%08x\n", i,
+		drm_info(&dev_priv->drm, " RC_RANGE_PARAM_%d = 0x%08x\n", i,
 			 rc_range_params_dword[i / 2]);
 	}
 	if (!is_pipe_dsc(crtc_state)) {
-- 
2.25.0

