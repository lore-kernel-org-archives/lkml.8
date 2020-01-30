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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370CFC33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 08:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD5A2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 08:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qUmWV/5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgA3Icz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 03:32:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32984 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgA3Icx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 03:32:53 -0500
Received: by mail-wr1-f66.google.com with SMTP id b6so2978548wrq.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 00:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2pcDxaz1r4lnc+nRs7lVUX0N/1Eh6e9jSwk1X6FXGgE=;
        b=qUmWV/5yag6pLFCbZLyu5GznADzlwTRav4iWYGR55YHD1vX4gxk/Wng1gIw5k8vWrr
         Qpp/Q3a8uW102Gliljtw4iKyjf3V+8d326VADG22ie70Kqi38OjRVVULgrfsToDgODLN
         gZcFzxhWuB86jxVr9jNI1p4331Or4oLILxkoOq78l+USXSQqEkKLurC6HVc3qIJXcTAG
         mzGpf0Yv29EYgKslTRvZWPGdFZUPhxlPoZ5xRjPdn7FWF5jkINn861WOAQZ4C4OWXM9u
         gZK5XAPStnjuIYNgXpt6rDRdKQXxdYpU+WnpPrMYmyPya4GIozZxvXFTSiz90mbJPIc6
         dobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2pcDxaz1r4lnc+nRs7lVUX0N/1Eh6e9jSwk1X6FXGgE=;
        b=JSuww74MGumqUSSG2Jrd9y8+3qC7JP7hBewM/9BmKjd8T12git30ZR9FtgOD5ua+Qz
         bGbVS1aRPU4kyunIqoet9tw/n5p/VR71XS5tVI3SfMngHxAxvrbwIrp/83YLX4nx15RK
         D7NE9H7l6GCm697dxqhvK0/49IUfvOVbO4sRy+tHNfNssQBxY/N6DgBGmxlyiwNmBnM7
         gXfhgKqsWp0OyU6A30YZtp3uQai2hwESzVtETIuG46pZn1KQ/ewXkY/T8w4BjPOdlVEI
         iSoC7yAwLmKYEERa3aGe9VnYZkoa13tXpYEEOSUfOtn5YUUrvP6iIxiREejadx545HRq
         K8nw==
X-Gm-Message-State: APjAAAUHCcZ/kxEcOicrX8Ei8HHlnprC3EWGv9enrvg9BHzUdAJgfhSO
        HVg8g45MqkCSuvMMQgQYew5g8x1KCcA=
X-Google-Smtp-Source: APXvYqzbNJO+RIK8BP1aWXfkEitt7hAQWMdFXdmI8BW8FcpP2VAjvf1Fd/Wl7WwHBFCzT96ZppILzA==
X-Received: by 2002:a5d:53c1:: with SMTP id a1mr3868300wrw.373.1580373171373;
        Thu, 30 Jan 2020 00:32:51 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id i11sm6363678wrs.10.2020.01.30.00.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 00:32:50 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] drm/i915/tv: automatic conversion to drm_device based logging macros.
Date:   Thu, 30 Jan 2020 11:32:22 +0300
Message-Id: <20200130083229.12889-6-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130083229.12889-1-wambui.karugax@gmail.com>
References: <20200130083229.12889-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts most uses of the printk based logging macros to the struct
drm_device based logging macros in i915/display/intel_tv.c using the
following coccinelle script that matches based on the existence of a
drm_i915_private device pointer:
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
 drivers/gpu/drm/i915/display/intel_tv.c | 26 ++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_tv.c b/drivers/gpu/drm/i915/display/intel_tv.c
index fa155a028e2b..4f81ee26b7ab 100644
--- a/drivers/gpu/drm/i915/display/intel_tv.c
+++ b/drivers/gpu/drm/i915/display/intel_tv.c
@@ -1146,7 +1146,7 @@ intel_tv_get_config(struct intel_encoder *encoder,
 
 	intel_tv_mode_to_mode(&mode, &tv_mode);
 
-	DRM_DEBUG_KMS("TV mode:\n");
+	drm_dbg_kms(&dev_priv->drm, "TV mode:\n");
 	drm_mode_debug_printmodeline(&mode);
 
 	intel_tv_scale_mode_horiz(&mode, hdisplay,
@@ -1202,7 +1202,7 @@ intel_tv_compute_config(struct intel_encoder *encoder,
 
 	pipe_config->output_format = INTEL_OUTPUT_FORMAT_RGB;
 
-	DRM_DEBUG_KMS("forcing bpc to 8 for TV\n");
+	drm_dbg_kms(&dev_priv->drm, "forcing bpc to 8 for TV\n");
 	pipe_config->pipe_bpp = 8*3;
 
 	pipe_config->port_clock = tv_mode->clock;
@@ -1217,7 +1217,8 @@ intel_tv_compute_config(struct intel_encoder *encoder,
 		extra = adjusted_mode->crtc_vdisplay - vdisplay;
 
 		if (extra < 0) {
-			DRM_DEBUG_KMS("No vertical scaling for >1024 pixel wide modes\n");
+			drm_dbg_kms(&dev_priv->drm,
+				    "No vertical scaling for >1024 pixel wide modes\n");
 			return -EINVAL;
 		}
 
@@ -1250,7 +1251,7 @@ intel_tv_compute_config(struct intel_encoder *encoder,
 		tv_conn_state->bypass_vfilter = false;
 	}
 
-	DRM_DEBUG_KMS("TV mode:\n");
+	drm_dbg_kms(&dev_priv->drm, "TV mode:\n");
 	drm_mode_debug_printmodeline(adjusted_mode);
 
 	/*
@@ -1622,7 +1623,7 @@ intel_tv_detect_type(struct intel_tv *intel_tv,
 
 	type = -1;
 	tv_dac = intel_de_read(dev_priv, TV_DAC);
-	DRM_DEBUG_KMS("TV detected: %x, %x\n", tv_ctl, tv_dac);
+	drm_dbg_kms(&dev_priv->drm, "TV detected: %x, %x\n", tv_ctl, tv_dac);
 	/*
 	 *  A B C
 	 *  0 1 1 Composite
@@ -1630,16 +1631,19 @@ intel_tv_detect_type(struct intel_tv *intel_tv,
 	 *  0 0 0 Component
 	 */
 	if ((tv_dac & TVDAC_SENSE_MASK) == (TVDAC_B_SENSE | TVDAC_C_SENSE)) {
-		DRM_DEBUG_KMS("Detected Composite TV connection\n");
+		drm_dbg_kms(&dev_priv->drm,
+			    "Detected Composite TV connection\n");
 		type = DRM_MODE_CONNECTOR_Composite;
 	} else if ((tv_dac & (TVDAC_A_SENSE|TVDAC_B_SENSE)) == TVDAC_A_SENSE) {
-		DRM_DEBUG_KMS("Detected S-Video TV connection\n");
+		drm_dbg_kms(&dev_priv->drm,
+			    "Detected S-Video TV connection\n");
 		type = DRM_MODE_CONNECTOR_SVIDEO;
 	} else if ((tv_dac & TVDAC_SENSE_MASK) == 0) {
-		DRM_DEBUG_KMS("Detected Component TV connection\n");
+		drm_dbg_kms(&dev_priv->drm,
+			    "Detected Component TV connection\n");
 		type = DRM_MODE_CONNECTOR_Component;
 	} else {
-		DRM_DEBUG_KMS("Unrecognised TV connection\n");
+		drm_dbg_kms(&dev_priv->drm, "Unrecognised TV connection\n");
 		type = -1;
 	}
 
@@ -1800,7 +1804,7 @@ intel_tv_get_modes(struct drm_connector *connector)
 		 */
 		intel_tv_mode_to_mode(mode, tv_mode);
 		if (count == 0) {
-			DRM_DEBUG_KMS("TV mode:\n");
+			drm_dbg_kms(&dev_priv->drm, "TV mode:\n");
 			drm_mode_debug_printmodeline(mode);
 		}
 		intel_tv_scale_mode_horiz(mode, input->w, 0, 0);
@@ -1880,7 +1884,7 @@ intel_tv_init(struct drm_i915_private *dev_priv)
 		return;
 
 	if (!intel_bios_is_tv_present(dev_priv)) {
-		DRM_DEBUG_KMS("Integrated TV is not present.\n");
+		drm_dbg_kms(&dev_priv->drm, "Integrated TV is not present.\n");
 		return;
 	}
 
-- 
2.25.0

