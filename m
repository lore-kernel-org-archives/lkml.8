Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC01C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 08:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A797214DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 08:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8XC/n5I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgA3IdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 03:33:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33003 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgA3IdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 03:33:02 -0500
Received: by mail-wr1-f66.google.com with SMTP id b6so2979092wrq.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 00:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3dxWyTLXrZeEhnN/rlOo+rQE0cKhTGc+Bj4z4DrHgrg=;
        b=n8XC/n5ICIo9IPWZtYzatOWLUbzNLcwQeRbZ9QsawNwzhwXdyK3FgBVtyuCblVUTRO
         LvOc97rEgrifjv3dDkhuV18js9dqjraLeqbFT0e1PSVyvVbOuBlkTAYqDLec5mrGrhjx
         RBZhuAcqQj5g1d9lURFiK+nbm04lvvYU0nGUybd92D33hm1iAc7lQLJ970MGj6LMUa7M
         QKZ2isKVwNAJl34nRuVSv2vjSf8vQTkNx55e8oRpLJUqcPaZ26HKFjAJkFw2OmAqldeG
         IZXjr3kbPnTCPWsCgj39WJacx4fYcVgBisyw8T6s8uul3Pu0ihf6sYP2S08dVCjEvJBT
         +dbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3dxWyTLXrZeEhnN/rlOo+rQE0cKhTGc+Bj4z4DrHgrg=;
        b=o1l0r524XNzRNdj2pYWiRfb8DSZYjdBdeFwNa19WETHwfF9HWu/fX+sxZ7TomW9CJ6
         sI6DRtPBQsKA/yiL+k5jC/UWVx1SE5SXmElfiehFSdf/qYkZk1mHSfijJs/xlEwodjJS
         PgEU2efIT06o2VapmsraylabHtYfUnO2/lFMyQsa9L0o5URWFWPfJKEzbrIxnBtxy3cn
         pvCBqgmJUDkR0lUqU/WvYuwJSUNpDYCx3fS5n/IUR7Uu8yDQMbohLdlBwEJLi0VyZ95k
         /wVp1QVHKRFz/d0qpmcL6LABkxgVQ5yuyyduGAtYS425DTCOvx+KKtSBDy3Tlb0998hN
         83KQ==
X-Gm-Message-State: APjAAAW4qEgNXWRRMUXPr0CzeNfTxcAm8uFOVO+uvgVR2c6szCSr5vxP
        c5+iRNlkKT4z3RfAuQBmaYk=
X-Google-Smtp-Source: APXvYqwwDretUyLMrPPyWsa2YOKUZ9nU3+0soaRFgJeZ9shCWmldX09rIgAYp/uxsGRISnW5igwjQA==
X-Received: by 2002:adf:a453:: with SMTP id e19mr3656374wra.305.1580373179237;
        Thu, 30 Jan 2020 00:32:59 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id i11sm6363678wrs.10.2020.01.30.00.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 00:32:58 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] drm/i915/sprite: automatic conversion to drm_device based logging macros
Date:   Thu, 30 Jan 2020 11:32:24 +0300
Message-Id: <20200130083229.12889-8-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130083229.12889-1-wambui.karugax@gmail.com>
References: <20200130083229.12889-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conversion of most instances of the printk based logging macros to the
struct drm_device based logging macros in i915/display/intel_sprite.c
This was done automatically by the following coccinelle script that
matches based on the existence of a struct drm_i915_private device:
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
 drivers/gpu/drm/i915/display/intel_sprite.c | 60 ++++++++++++---------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_sprite.c b/drivers/gpu/drm/i915/display/intel_sprite.c
index 2f277d1fc6f1..8a4b5ad12d58 100644
--- a/drivers/gpu/drm/i915/display/intel_sprite.c
+++ b/drivers/gpu/drm/i915/display/intel_sprite.c
@@ -113,8 +113,9 @@ void intel_pipe_update_start(const struct intel_crtc_state *new_crtc_state)
 	 * re-entry as well.
 	 */
 	if (intel_psr_wait_for_idle(new_crtc_state, &psr_status))
-		DRM_ERROR("PSR idle timed out 0x%x, atomic update may fail\n",
-			  psr_status);
+		drm_err(&dev_priv->drm,
+			"PSR idle timed out 0x%x, atomic update may fail\n",
+			psr_status);
 
 	local_irq_disable();
 
@@ -135,8 +136,9 @@ void intel_pipe_update_start(const struct intel_crtc_state *new_crtc_state)
 			break;
 
 		if (!timeout) {
-			DRM_ERROR("Potential atomic update failure on pipe %c\n",
-				  pipe_name(crtc->pipe));
+			drm_err(&dev_priv->drm,
+				"Potential atomic update failure on pipe %c\n",
+				pipe_name(crtc->pipe));
 			break;
 		}
 
@@ -221,17 +223,20 @@ void intel_pipe_update_end(struct intel_crtc_state *new_crtc_state)
 
 	if (crtc->debug.start_vbl_count &&
 	    crtc->debug.start_vbl_count != end_vbl_count) {
-		DRM_ERROR("Atomic update failure on pipe %c (start=%u end=%u) time %lld us, min %d, max %d, scanline start %d, end %d\n",
-			  pipe_name(pipe), crtc->debug.start_vbl_count,
-			  end_vbl_count,
-			  ktime_us_delta(end_vbl_time, crtc->debug.start_vbl_time),
-			  crtc->debug.min_vbl, crtc->debug.max_vbl,
-			  crtc->debug.scanline_start, scanline_end);
+		drm_err(&dev_priv->drm,
+			"Atomic update failure on pipe %c (start=%u end=%u) time %lld us, min %d, max %d, scanline start %d, end %d\n",
+			pipe_name(pipe), crtc->debug.start_vbl_count,
+			end_vbl_count,
+			ktime_us_delta(end_vbl_time,
+				       crtc->debug.start_vbl_time),
+			crtc->debug.min_vbl, crtc->debug.max_vbl,
+			crtc->debug.scanline_start, scanline_end);
 	}
 #ifdef CONFIG_DRM_I915_DEBUG_VBLANK_EVADE
 	else if (ktime_us_delta(end_vbl_time, crtc->debug.start_vbl_time) >
 		 VBLANK_EVASION_TIME_US)
-		DRM_WARN("Atomic update on pipe (%c) took %lld us, max time under evasion is %u us\n",
+		drm_warn(&dev_priv->drm,
+			 "Atomic update on pipe (%c) took %lld us, max time under evasion is %u us\n",
 			 pipe_name(pipe),
 			 ktime_us_delta(end_vbl_time, crtc->debug.start_vbl_time),
 			 VBLANK_EVASION_TIME_US);
@@ -2029,7 +2034,8 @@ int chv_plane_check_rotation(const struct intel_plane_state *plane_state)
 	if (IS_CHERRYVIEW(dev_priv) &&
 	    rotation & DRM_MODE_ROTATE_180 &&
 	    rotation & DRM_MODE_REFLECT_X) {
-		DRM_DEBUG_KMS("Cannot rotate and reflect at the same time\n");
+		drm_dbg_kms(&dev_priv->drm,
+			    "Cannot rotate and reflect at the same time\n");
 		return -EINVAL;
 	}
 
@@ -2084,21 +2090,24 @@ static int skl_plane_check_fb(const struct intel_crtc_state *crtc_state,
 
 	if (rotation & ~(DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_180) &&
 	    is_ccs_modifier(fb->modifier)) {
-		DRM_DEBUG_KMS("RC support only with 0/180 degree rotation (%x)\n",
-			      rotation);
+		drm_dbg_kms(&dev_priv->drm,
+			    "RC support only with 0/180 degree rotation (%x)\n",
+			    rotation);
 		return -EINVAL;
 	}
 
 	if (rotation & DRM_MODE_REFLECT_X &&
 	    fb->modifier == DRM_FORMAT_MOD_LINEAR) {
-		DRM_DEBUG_KMS("horizontal flip is not supported with linear surface formats\n");
+		drm_dbg_kms(&dev_priv->drm,
+			    "horizontal flip is not supported with linear surface formats\n");
 		return -EINVAL;
 	}
 
 	if (drm_rotation_90_or_270(rotation)) {
 		if (fb->modifier != I915_FORMAT_MOD_Y_TILED &&
 		    fb->modifier != I915_FORMAT_MOD_Yf_TILED) {
-			DRM_DEBUG_KMS("Y/Yf tiling required for 90/270!\n");
+			drm_dbg_kms(&dev_priv->drm,
+				    "Y/Yf tiling required for 90/270!\n");
 			return -EINVAL;
 		}
 
@@ -2121,9 +2130,10 @@ static int skl_plane_check_fb(const struct intel_crtc_state *crtc_state,
 		case DRM_FORMAT_Y216:
 		case DRM_FORMAT_XVYU12_16161616:
 		case DRM_FORMAT_XVYU16161616:
-			DRM_DEBUG_KMS("Unsupported pixel format %s for 90/270!\n",
-				      drm_get_format_name(fb->format->format,
-							  &format_name));
+			drm_dbg_kms(&dev_priv->drm,
+				    "Unsupported pixel format %s for 90/270!\n",
+				    drm_get_format_name(fb->format->format,
+							&format_name));
 			return -EINVAL;
 		default:
 			break;
@@ -2139,7 +2149,8 @@ static int skl_plane_check_fb(const struct intel_crtc_state *crtc_state,
 	     fb->modifier == I915_FORMAT_MOD_Yf_TILED_CCS ||
 	     fb->modifier == I915_FORMAT_MOD_Y_TILED_GEN12_RC_CCS ||
 	     fb->modifier == I915_FORMAT_MOD_Y_TILED_GEN12_MC_CCS)) {
-		DRM_DEBUG_KMS("Y/Yf tiling not supported in IF-ID mode\n");
+		drm_dbg_kms(&dev_priv->drm,
+			    "Y/Yf tiling not supported in IF-ID mode\n");
 		return -EINVAL;
 	}
 
@@ -2166,10 +2177,11 @@ static int skl_plane_check_dst_coordinates(const struct intel_crtc_state *crtc_s
 	 */
 	if ((IS_GEMINILAKE(dev_priv) || IS_CANNONLAKE(dev_priv)) &&
 	    (crtc_x + crtc_w < 4 || crtc_x > pipe_src_w - 4)) {
-		DRM_DEBUG_KMS("requested plane X %s position %d invalid (valid range %d-%d)\n",
-			      crtc_x + crtc_w < 4 ? "end" : "start",
-			      crtc_x + crtc_w < 4 ? crtc_x + crtc_w : crtc_x,
-			      4, pipe_src_w - 4);
+		drm_dbg_kms(&dev_priv->drm,
+			    "requested plane X %s position %d invalid (valid range %d-%d)\n",
+			    crtc_x + crtc_w < 4 ? "end" : "start",
+			    crtc_x + crtc_w < 4 ? crtc_x + crtc_w : crtc_x,
+			    4, pipe_src_w - 4);
 		return -ERANGE;
 	}
 
-- 
2.25.0

