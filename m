Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6ACDC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C3521741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTC5mVd7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgBFIAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 03:00:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34887 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbgBFIAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 03:00:50 -0500
Received: by mail-wr1-f66.google.com with SMTP id w12so5954667wrt.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 00:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dnYcLVKIvd6ueAGqMuFsO7/hDtBaHHSvjKuQVV0KtNU=;
        b=ZTC5mVd7KIiDzl+3/rGwlCWPYx8GuV7dUnSs38gSsQgnuvxgxEN53XONUYs5X6WOWn
         sQYYzlqqAgNKF0gDxCs3HsBA4Sc0CWikYZyE8EntwXqPAtHKUXKYDZPYNuHGZo5J2Z8x
         w5epXOsZ/C0/vFFTBlr9pHK6wqUqp8DjdiRl8C1X9Lcj+mKa6rRgAGa6tRYgUxtnVG9G
         rA8kFoAaQ2cgzXD6lBFkvkXDl7G3Q/r+PpDfQYVRfAg50NMK2z7sLYoxjiYZjNaWu1x/
         94k2efw2I2f2k5EwNhmEHJxZHfLL9+06Oxa1sctA5Z15ZCZ+kzeuEprW320JJWm2eg51
         UVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dnYcLVKIvd6ueAGqMuFsO7/hDtBaHHSvjKuQVV0KtNU=;
        b=c8n7Y6vtURJ3grKMWJ3QTPP9P5N9FHzFCLPMgq1njDQgFubnGfvf/nNXNBgUAjp6Fv
         4FTQ7T+sYi1YFWhTGntUjxn4vmiR1BRnUall46gm1nKCMJJIzNfGnMVUxIlaycd3mY6W
         v0Vgskk/B9Y3wDNtLj6DOPP7ykjvgx1j9WJms/FOkCN0JvUvBQUeZiPOqHuWDsaGNhal
         p+L9qI/Epp3SCR9jErb2nOLh2Wg6SNTnJN4hplS+RG6WXV1VM1+nM2yFG64gYBXTz7Ng
         K4na0giVvDMEdcLjbFWSNhmfZgOtowMJAlWEJBmHijUczrC3MD48CMnCnFoxySL9XNiP
         rWJA==
X-Gm-Message-State: APjAAAXeT76SVZV3PUGoxm37a6/1SCbx0hcApyaB7cVDQePv7Mw2HbnX
        6vw0LylxrFsQ7NQPzJ1j5UOHF2UTlko=
X-Google-Smtp-Source: APXvYqyAhAlyrIzzwOq/fYbZMTdtwl0Q1LiTeL2+KpFHE6hsl5b+eVt6niJMouHYMILRVDOjtCLofQ==
X-Received: by 2002:adf:a35e:: with SMTP id d30mr2194737wrb.33.1580976046402;
        Thu, 06 Feb 2020 00:00:46 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id u8sm2635132wmm.15.2020.02.06.00.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 00:00:45 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/12] drm/i915/dp_aux_backlight: convert to drm_device based logging macros.
Date:   Thu,  6 Feb 2020 11:00:07 +0300
Message-Id: <20200206080014.13759-7-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206080014.13759-1-wambui.karugax@gmail.com>
References: <20200206080014.13759-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conversion of the printk based drm logging macros to the struct
drm_device based logging macros in display/intel_dp_aux_backlight.c.
This also involves extracting the drm_i915_private device pointer from
various intel types to use in the macros.

Note that this converts DRM_DEBUG_DRIVER to drm_dbg().

References: https://lists.freedesktop.org/archives/dri-devel/2020-January/253381.html
Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 .../drm/i915/display/intel_dp_aux_backlight.c | 72 ++++++++++++-------
 1 file changed, 45 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
index e86feebef299..83d9c76e4da9 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
@@ -35,8 +35,9 @@ static void set_aux_backlight_enable(struct intel_dp *intel_dp, bool enable)
 
 	if (drm_dp_dpcd_readb(&intel_dp->aux, DP_EDP_DISPLAY_CONTROL_REGISTER,
 			      &reg_val) < 0) {
-		DRM_DEBUG_KMS("Failed to read DPCD register 0x%x\n",
-			      DP_EDP_DISPLAY_CONTROL_REGISTER);
+		drm_dbg_kms(&dp_to_i915(intel_dp)->drm,
+			    "Failed to read DPCD register 0x%x\n",
+			    DP_EDP_DISPLAY_CONTROL_REGISTER);
 		return;
 	}
 	if (enable)
@@ -46,8 +47,9 @@ static void set_aux_backlight_enable(struct intel_dp *intel_dp, bool enable)
 
 	if (drm_dp_dpcd_writeb(&intel_dp->aux, DP_EDP_DISPLAY_CONTROL_REGISTER,
 			       reg_val) != 1) {
-		DRM_DEBUG_KMS("Failed to %s aux backlight\n",
-			      enable ? "enable" : "disable");
+		drm_dbg_kms(&dp_to_i915(intel_dp)->drm,
+			    "Failed to %s aux backlight\n",
+			    enable ? "enable" : "disable");
 	}
 }
 
@@ -65,8 +67,9 @@ static u32 intel_dp_aux_get_backlight(struct intel_connector *connector)
 	if (drm_dp_dpcd_readb(&intel_dp->aux,
 			      DP_EDP_BACKLIGHT_MODE_SET_REGISTER,
 			      &mode_reg) != 1) {
-		DRM_DEBUG_KMS("Failed to read the DPCD register 0x%x\n",
-			      DP_EDP_BACKLIGHT_MODE_SET_REGISTER);
+		drm_dbg_kms(&dp_to_i915(intel_dp)->drm,
+			    "Failed to read the DPCD register 0x%x\n",
+			    DP_EDP_BACKLIGHT_MODE_SET_REGISTER);
 		return 0;
 	}
 
@@ -80,8 +83,9 @@ static u32 intel_dp_aux_get_backlight(struct intel_connector *connector)
 
 	if (drm_dp_dpcd_read(&intel_dp->aux, DP_EDP_BACKLIGHT_BRIGHTNESS_MSB,
 			     &read_val, sizeof(read_val)) < 0) {
-		DRM_DEBUG_KMS("Failed to read DPCD register 0x%x\n",
-			      DP_EDP_BACKLIGHT_BRIGHTNESS_MSB);
+		drm_dbg_kms(&dp_to_i915(intel_dp)->drm,
+			    "Failed to read DPCD register 0x%x\n",
+			    DP_EDP_BACKLIGHT_BRIGHTNESS_MSB);
 		return 0;
 	}
 	level = read_val[0];
@@ -111,7 +115,8 @@ intel_dp_aux_set_backlight(const struct drm_connector_state *conn_state, u32 lev
 	}
 	if (drm_dp_dpcd_write(&intel_dp->aux, DP_EDP_BACKLIGHT_BRIGHTNESS_MSB,
 			      vals, sizeof(vals)) < 0) {
-		DRM_DEBUG_KMS("Failed to write aux backlight level\n");
+		drm_dbg_kms(&dp_to_i915(intel_dp)->drm,
+			    "Failed to write aux backlight level\n");
 		return;
 	}
 }
@@ -133,7 +138,8 @@ static bool intel_dp_aux_set_pwm_freq(struct intel_connector *connector)
 
 	freq = dev_priv->vbt.backlight.pwm_freq_hz;
 	if (!freq) {
-		DRM_DEBUG_KMS("Use panel default backlight frequency\n");
+		drm_dbg_kms(&dev_priv->drm,
+			    "Use panel default backlight frequency\n");
 		return false;
 	}
 
@@ -146,13 +152,14 @@ static bool intel_dp_aux_set_pwm_freq(struct intel_connector *connector)
 	fxp_max = DIV_ROUND_CLOSEST(fxp * 5, 4);
 
 	if (fxp_min > fxp_actual || fxp_actual > fxp_max) {
-		DRM_DEBUG_KMS("Actual frequency out of range\n");
+		drm_dbg_kms(&dev_priv->drm, "Actual frequency out of range\n");
 		return false;
 	}
 
 	if (drm_dp_dpcd_writeb(&intel_dp->aux,
 			       DP_EDP_BACKLIGHT_FREQ_SET, (u8) f) < 0) {
-		DRM_DEBUG_KMS("Failed to write aux backlight freq\n");
+		drm_dbg_kms(&dev_priv->drm,
+			    "Failed to write aux backlight freq\n");
 		return false;
 	}
 	return true;
@@ -162,14 +169,16 @@ static void intel_dp_aux_enable_backlight(const struct intel_crtc_state *crtc_st
 					  const struct drm_connector_state *conn_state)
 {
 	struct intel_connector *connector = to_intel_connector(conn_state->connector);
+	struct drm_i915_private *i915 = to_i915(connector->base.dev);
 	struct intel_dp *intel_dp = intel_attached_dp(connector);
 	struct intel_panel *panel = &connector->panel;
 	u8 dpcd_buf, new_dpcd_buf, edp_backlight_mode;
 
 	if (drm_dp_dpcd_readb(&intel_dp->aux,
 			DP_EDP_BACKLIGHT_MODE_SET_REGISTER, &dpcd_buf) != 1) {
-		DRM_DEBUG_KMS("Failed to read DPCD register 0x%x\n",
-			      DP_EDP_BACKLIGHT_MODE_SET_REGISTER);
+		drm_dbg_kms(&i915->drm,
+			    "Failed to read DPCD register 0x%x\n",
+			    DP_EDP_BACKLIGHT_MODE_SET_REGISTER);
 		return;
 	}
 
@@ -186,7 +195,8 @@ static void intel_dp_aux_enable_backlight(const struct intel_crtc_state *crtc_st
 		if (drm_dp_dpcd_writeb(&intel_dp->aux,
 				       DP_EDP_PWMGEN_BIT_COUNT,
 				       panel->backlight.pwmgen_bit_count) < 0)
-			DRM_DEBUG_KMS("Failed to write aux pwmgen bit count\n");
+			drm_dbg_kms(&i915->drm,
+				    "Failed to write aux pwmgen bit count\n");
 
 		break;
 
@@ -203,7 +213,8 @@ static void intel_dp_aux_enable_backlight(const struct intel_crtc_state *crtc_st
 	if (new_dpcd_buf != dpcd_buf) {
 		if (drm_dp_dpcd_writeb(&intel_dp->aux,
 			DP_EDP_BACKLIGHT_MODE_SET_REGISTER, new_dpcd_buf) < 0) {
-			DRM_DEBUG_KMS("Failed to write aux backlight mode\n");
+			drm_dbg_kms(&i915->drm,
+				    "Failed to write aux backlight mode\n");
 		}
 	}
 
@@ -237,9 +248,11 @@ static u32 intel_dp_aux_calc_max_backlight(struct intel_connector *connector)
 	 * minimum value will applied automatically. So no need to check that.
 	 */
 	freq = i915->vbt.backlight.pwm_freq_hz;
-	DRM_DEBUG_KMS("VBT defined backlight frequency %u Hz\n", freq);
+	drm_dbg_kms(&i915->drm, "VBT defined backlight frequency %u Hz\n",
+		    freq);
 	if (!freq) {
-		DRM_DEBUG_KMS("Use panel default backlight frequency\n");
+		drm_dbg_kms(&i915->drm,
+			    "Use panel default backlight frequency\n");
 		return max_backlight;
 	}
 
@@ -254,12 +267,14 @@ static u32 intel_dp_aux_calc_max_backlight(struct intel_connector *connector)
 	 */
 	if (drm_dp_dpcd_readb(&intel_dp->aux,
 			      DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &pn_min) != 1) {
-		DRM_DEBUG_KMS("Failed to read pwmgen bit count cap min\n");
+		drm_dbg_kms(&i915->drm,
+			    "Failed to read pwmgen bit count cap min\n");
 		return max_backlight;
 	}
 	if (drm_dp_dpcd_readb(&intel_dp->aux,
 			      DP_EDP_PWMGEN_BIT_COUNT_CAP_MAX, &pn_max) != 1) {
-		DRM_DEBUG_KMS("Failed to read pwmgen bit count cap max\n");
+		drm_dbg_kms(&i915->drm,
+			    "Failed to read pwmgen bit count cap max\n");
 		return max_backlight;
 	}
 	pn_min &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
@@ -268,7 +283,8 @@ static u32 intel_dp_aux_calc_max_backlight(struct intel_connector *connector)
 	fxp_min = DIV_ROUND_CLOSEST(fxp * 3, 4);
 	fxp_max = DIV_ROUND_CLOSEST(fxp * 5, 4);
 	if (fxp_min < (1 << pn_min) || (255 << pn_max) < fxp_max) {
-		DRM_DEBUG_KMS("VBT defined backlight frequency out of range\n");
+		drm_dbg_kms(&i915->drm,
+			    "VBT defined backlight frequency out of range\n");
 		return max_backlight;
 	}
 
@@ -279,10 +295,11 @@ static u32 intel_dp_aux_calc_max_backlight(struct intel_connector *connector)
 			break;
 	}
 
-	DRM_DEBUG_KMS("Using eDP pwmgen bit count of %d\n", pn);
+	drm_dbg_kms(&i915->drm, "Using eDP pwmgen bit count of %d\n", pn);
 	if (drm_dp_dpcd_writeb(&intel_dp->aux,
 			       DP_EDP_PWMGEN_BIT_COUNT, pn) < 0) {
-		DRM_DEBUG_KMS("Failed to write aux pwmgen bit count\n");
+		drm_dbg_kms(&i915->drm,
+			    "Failed to write aux pwmgen bit count\n");
 		return max_backlight;
 	}
 	panel->backlight.pwmgen_bit_count = pn;
@@ -319,7 +336,8 @@ intel_dp_aux_display_control_capable(struct intel_connector *connector)
 	if (intel_dp->edp_dpcd[1] & DP_EDP_TCON_BACKLIGHT_ADJUSTMENT_CAP &&
 	    (intel_dp->edp_dpcd[2] & DP_EDP_BACKLIGHT_BRIGHTNESS_AUX_SET_CAP) &&
 	    !(intel_dp->edp_dpcd[2] & DP_EDP_BACKLIGHT_BRIGHTNESS_PWM_PIN_CAP)) {
-		DRM_DEBUG_KMS("AUX Backlight Control Supported!\n");
+		drm_dbg_kms(&dp_to_i915(intel_dp)->drm,
+			    "AUX Backlight Control Supported!\n");
 		return true;
 	}
 	return false;
@@ -328,8 +346,8 @@ intel_dp_aux_display_control_capable(struct intel_connector *connector)
 int intel_dp_aux_init_backlight_funcs(struct intel_connector *intel_connector)
 {
 	struct intel_panel *panel = &intel_connector->panel;
-	enum intel_backlight_type type =
-		to_i915(intel_connector->base.dev)->vbt.backlight.type;
+	struct drm_i915_private *i915 = to_i915(intel_connector->base.dev);
+	enum intel_backlight_type type = i915->vbt.backlight.type;
 
 	if (i915_modparams.enable_dpcd_backlight == 0 ||
 	    (i915_modparams.enable_dpcd_backlight == -1 &&
@@ -337,7 +355,7 @@ int intel_dp_aux_init_backlight_funcs(struct intel_connector *intel_connector)
 		return -ENODEV;
 
 	if (type != INTEL_BACKLIGHT_VESA_EDP_AUX_INTERFACE)
-		DRM_DEBUG_DRIVER("Ignoring VBT backlight type\n");
+		drm_dbg(&i915->drm, "Ignoring VBT backlight type\n");
 
 	panel->backlight.setup = intel_dp_aux_setup_backlight;
 	panel->backlight.enable = intel_dp_aux_enable_backlight;
-- 
2.25.0

