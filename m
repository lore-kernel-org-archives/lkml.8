Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5919CC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1919D20728
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="crdbNM5G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388592AbgAPVQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:16:54 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20378 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729991AbgAPVQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 16:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579209412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IkDDfygYV/dJ5JC6E6LZqeFJ3qyr4J6qXCa7+p5wB7s=;
        b=crdbNM5GKazgGHWcWHeTlG3BckisUKfMJubNCb+hUZpq9DfYR6KcZlp071a7rd+mI8uGA/
        HwHAF/39JSKvyGRuEFxygQGm8tpmBiV2hlfKHZoFIbQ5pt9G3fJzWikJiTbBeVoysPL/iK
        zru9z2GscADj/T2EOBP9lUSLai4jt3w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-OvEahANrPzW9tOEDTg8l9Q-1; Thu, 16 Jan 2020 16:16:47 -0500
X-MC-Unique: OvEahANrPzW9tOEDTg8l9Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51BCD800D5A;
        Thu, 16 Jan 2020 21:16:45 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-90.bss.redhat.com [10.20.1.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7BFC660C63;
        Thu, 16 Jan 2020 21:16:43 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org,
        Furquan Shaikh <furquan@google.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Perry Yuan <pyuan@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ramalingam C <ramalingam.c@intel.com>,
        Lee Shawn C <shawn.c.lee@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] drm/i915: Fix eDP DPCD aux max backlight calculations
Date:   Thu, 16 Jan 2020 16:16:08 -0500
Message-Id: <20200116211623.53799-2-lyude@redhat.com>
In-Reply-To: <20200116211623.53799-1-lyude@redhat.com>
References: <20200116211623.53799-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Max backlight value for the panel was being calculated using byte
count i.e. 0xffff if 2 bytes are supported for backlight brightness
and 0xff if 1 byte is supported. However, EDP_PWMGEN_BIT_COUNT
determines the number of active control bits used for the brightness
setting. Thus, even if the panel uses 2 byte setting, it might not use
all the control bits. Thus, max backlight should be set based on the
value of EDP_PWMGEN_BIT_COUNT instead of assuming 65535 or 255.

Additionally, EDP_PWMGEN_BIT_COUNT was being updated based on the VBT
frequency which results in a different max backlight value. Thus,
setting of EDP_PWMGEN_BIT_COUNT is moved to setup phase instead of
enable so that max backlight can be calculated correctly. Only the
frequency divider is set during the enable phase using the value of
EDP_PWMGEN_BIT_COUNT.

This is based off the original patch series from Furquan Shaikh
<furquan@google.com>:

https://patchwork.freedesktop.org/patch/317255/?series=3D62326&rev=3D3

Changes since original patch:
* Remove unused intel_dp variable in intel_dp_aux_setup_backlight()
* Fix checkpatch issues
* Make sure that we rewrite the pwmgen bit count whenever we bring the
  panel out of D3 mode

v2 by Jani:
* rebase
* fix readb return value check

Cc: Furquan Shaikh <furquan@google.com>
Tested-by: AceLan Kao <acelan.kao@canonical.com>
Tested-by: Perry Yuan <pyuan@redhat.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 .../drm/i915/display/intel_display_types.h    |   3 +
 .../drm/i915/display/intel_dp_aux_backlight.c | 139 ++++++++++++------
 2 files changed, 95 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers=
/gpu/drm/i915/display/intel_display_types.h
index fdd943a17de3..155ce49ae764 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -214,6 +214,9 @@ struct intel_panel {
 		u8 controller;		/* bxt+ only */
 		struct pwm_device *pwm;
=20
+		/* DPCD backlight */
+		u8 pwmgen_bit_count;
+
 		struct backlight_device *device;
=20
 		/* Connector and platform specific backlight functions */
diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/driv=
ers/gpu/drm/i915/display/intel_dp_aux_backlight.c
index 7c653f8c307f..345eed641455 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
@@ -111,61 +111,28 @@ static bool intel_dp_aux_set_pwm_freq(struct intel_=
connector *connector)
 {
 	struct drm_i915_private *dev_priv =3D to_i915(connector->base.dev);
 	struct intel_dp *intel_dp =3D enc_to_intel_dp(connector->encoder);
-	int freq, fxp, fxp_min, fxp_max, fxp_actual, f =3D 1;
-	u8 pn, pn_min, pn_max;
+	const u8 pn =3D connector->panel.backlight.pwmgen_bit_count;
+	int freq, fxp, f, fxp_actual, fxp_min, fxp_max;
=20
-	/* Find desired value of (F x P)
-	 * Note that, if F x P is out of supported range, the maximum value or
-	 * minimum value will applied automatically. So no need to check that.
-	 */
 	freq =3D dev_priv->vbt.backlight.pwm_freq_hz;
-	DRM_DEBUG_KMS("VBT defined backlight frequency %u Hz\n", freq);
 	if (!freq) {
 		DRM_DEBUG_KMS("Use panel default backlight frequency\n");
 		return false;
 	}
=20
 	fxp =3D DIV_ROUND_CLOSEST(KHz(DP_EDP_BACKLIGHT_FREQ_BASE_KHZ), freq);
+	f =3D clamp(DIV_ROUND_CLOSEST(fxp, 1 << pn), 1, 255);
+	fxp_actual =3D f << pn;
=20
-	/* Use highest possible value of Pn for more granularity of brightness
-	 * adjustment while satifying the conditions below.
-	 * - Pn is in the range of Pn_min and Pn_max
-	 * - F is in the range of 1 and 255
-	 * - FxP is within 25% of desired value.
-	 *   Note: 25% is arbitrary value and may need some tweak.
-	 */
-	if (drm_dp_dpcd_readb(&intel_dp->aux,
-			       DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &pn_min) !=3D 1) {
-		DRM_DEBUG_KMS("Failed to read pwmgen bit count cap min\n");
-		return false;
-	}
-	if (drm_dp_dpcd_readb(&intel_dp->aux,
-			       DP_EDP_PWMGEN_BIT_COUNT_CAP_MAX, &pn_max) !=3D 1) {
-		DRM_DEBUG_KMS("Failed to read pwmgen bit count cap max\n");
-		return false;
-	}
-	pn_min &=3D DP_EDP_PWMGEN_BIT_COUNT_MASK;
-	pn_max &=3D DP_EDP_PWMGEN_BIT_COUNT_MASK;
-
+	/* Ensure frequency is within 25% of desired value */
 	fxp_min =3D DIV_ROUND_CLOSEST(fxp * 3, 4);
 	fxp_max =3D DIV_ROUND_CLOSEST(fxp * 5, 4);
-	if (fxp_min < (1 << pn_min) || (255 << pn_max) < fxp_max) {
-		DRM_DEBUG_KMS("VBT defined backlight frequency out of range\n");
-		return false;
-	}
=20
-	for (pn =3D pn_max; pn >=3D pn_min; pn--) {
-		f =3D clamp(DIV_ROUND_CLOSEST(fxp, 1 << pn), 1, 255);
-		fxp_actual =3D f << pn;
-		if (fxp_min <=3D fxp_actual && fxp_actual <=3D fxp_max)
-			break;
-	}
-
-	if (drm_dp_dpcd_writeb(&intel_dp->aux,
-			       DP_EDP_PWMGEN_BIT_COUNT, pn) < 0) {
-		DRM_DEBUG_KMS("Failed to write aux pwmgen bit count\n");
+	if (fxp_min > fxp_actual || fxp_actual > fxp_max) {
+		DRM_DEBUG_KMS("Actual frequency out of range\n");
 		return false;
 	}
+
 	if (drm_dp_dpcd_writeb(&intel_dp->aux,
 			       DP_EDP_BACKLIGHT_FREQ_SET, (u8) f) < 0) {
 		DRM_DEBUG_KMS("Failed to write aux backlight freq\n");
@@ -179,6 +146,7 @@ static void intel_dp_aux_enable_backlight(const struc=
t intel_crtc_state *crtc_st
 {
 	struct intel_connector *connector =3D to_intel_connector(conn_state->co=
nnector);
 	struct intel_dp *intel_dp =3D enc_to_intel_dp(connector->encoder);
+	struct intel_panel *panel =3D &connector->panel;
 	u8 dpcd_buf, new_dpcd_buf, edp_backlight_mode;
=20
 	if (drm_dp_dpcd_readb(&intel_dp->aux,
@@ -197,6 +165,12 @@ static void intel_dp_aux_enable_backlight(const stru=
ct intel_crtc_state *crtc_st
 	case DP_EDP_BACKLIGHT_CONTROL_MODE_PRODUCT:
 		new_dpcd_buf &=3D ~DP_EDP_BACKLIGHT_CONTROL_MODE_MASK;
 		new_dpcd_buf |=3D DP_EDP_BACKLIGHT_CONTROL_MODE_DPCD;
+
+		if (drm_dp_dpcd_writeb(&intel_dp->aux,
+				       DP_EDP_PWMGEN_BIT_COUNT,
+				       panel->backlight.pwmgen_bit_count) < 0)
+			DRM_DEBUG_KMS("Failed to write aux pwmgen bit count\n");
+
 		break;
=20
 	/* Do nothing when it is already DPCD mode */
@@ -226,20 +200,91 @@ static void intel_dp_aux_disable_backlight(const st=
ruct drm_connector_state *old
 				 false);
 }
=20
+static u32 intel_dp_aux_calc_max_backlight(struct intel_connector *conne=
ctor)
+{
+	struct drm_i915_private *i915 =3D to_i915(connector->base.dev);
+	struct intel_dp *intel_dp =3D enc_to_intel_dp(connector->encoder);
+	struct intel_panel *panel =3D &connector->panel;
+	u32 max_backlight =3D 0;
+	int freq, fxp, fxp_min, fxp_max, fxp_actual, f =3D 1;
+	u8 pn, pn_min, pn_max;
+
+	if (drm_dp_dpcd_readb(&intel_dp->aux, DP_EDP_PWMGEN_BIT_COUNT, &pn) =3D=
=3D 1) {
+		pn &=3D DP_EDP_PWMGEN_BIT_COUNT_MASK;
+		max_backlight =3D (1 << pn) - 1;
+	}
+
+	/* Find desired value of (F x P)
+	 * Note that, if F x P is out of supported range, the maximum value or
+	 * minimum value will applied automatically. So no need to check that.
+	 */
+	freq =3D i915->vbt.backlight.pwm_freq_hz;
+	DRM_DEBUG_KMS("VBT defined backlight frequency %u Hz\n", freq);
+	if (!freq) {
+		DRM_DEBUG_KMS("Use panel default backlight frequency\n");
+		return max_backlight;
+	}
+
+	fxp =3D DIV_ROUND_CLOSEST(KHz(DP_EDP_BACKLIGHT_FREQ_BASE_KHZ), freq);
+
+	/* Use highest possible value of Pn for more granularity of brightness
+	 * adjustment while satifying the conditions below.
+	 * - Pn is in the range of Pn_min and Pn_max
+	 * - F is in the range of 1 and 255
+	 * - FxP is within 25% of desired value.
+	 *   Note: 25% is arbitrary value and may need some tweak.
+	 */
+	if (drm_dp_dpcd_readb(&intel_dp->aux,
+			      DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &pn_min) !=3D 1) {
+		DRM_DEBUG_KMS("Failed to read pwmgen bit count cap min\n");
+		return max_backlight;
+	}
+	if (drm_dp_dpcd_readb(&intel_dp->aux,
+			      DP_EDP_PWMGEN_BIT_COUNT_CAP_MAX, &pn_max) !=3D 1) {
+		DRM_DEBUG_KMS("Failed to read pwmgen bit count cap max\n");
+		return max_backlight;
+	}
+	pn_min &=3D DP_EDP_PWMGEN_BIT_COUNT_MASK;
+	pn_max &=3D DP_EDP_PWMGEN_BIT_COUNT_MASK;
+
+	fxp_min =3D DIV_ROUND_CLOSEST(fxp * 3, 4);
+	fxp_max =3D DIV_ROUND_CLOSEST(fxp * 5, 4);
+	if (fxp_min < (1 << pn_min) || (255 << pn_max) < fxp_max) {
+		DRM_DEBUG_KMS("VBT defined backlight frequency out of range\n");
+		return max_backlight;
+	}
+
+	for (pn =3D pn_max; pn >=3D pn_min; pn--) {
+		f =3D clamp(DIV_ROUND_CLOSEST(fxp, 1 << pn), 1, 255);
+		fxp_actual =3D f << pn;
+		if (fxp_min <=3D fxp_actual && fxp_actual <=3D fxp_max)
+			break;
+	}
+
+	DRM_DEBUG_KMS("Using eDP pwmgen bit count of %d\n", pn);
+	if (drm_dp_dpcd_writeb(&intel_dp->aux,
+			       DP_EDP_PWMGEN_BIT_COUNT, pn) < 0) {
+		DRM_DEBUG_KMS("Failed to write aux pwmgen bit count\n");
+		return max_backlight;
+	}
+	panel->backlight.pwmgen_bit_count =3D pn;
+
+	max_backlight =3D (1 << pn) - 1;
+
+	return max_backlight;
+}
+
 static int intel_dp_aux_setup_backlight(struct intel_connector *connecto=
r,
 					enum pipe pipe)
 {
-	struct intel_dp *intel_dp =3D enc_to_intel_dp(connector->encoder);
 	struct intel_panel *panel =3D &connector->panel;
=20
-	if (intel_dp->edp_dpcd[2] & DP_EDP_BACKLIGHT_BRIGHTNESS_BYTE_COUNT)
-		panel->backlight.max =3D 0xFFFF;
-	else
-		panel->backlight.max =3D 0xFF;
+	panel->backlight.max =3D intel_dp_aux_calc_max_backlight(connector);
+	if (!panel->backlight.max)
+		return -ENODEV;
=20
 	panel->backlight.min =3D 0;
 	panel->backlight.level =3D intel_dp_aux_get_backlight(connector);
-
 	panel->backlight.enabled =3D panel->backlight.level !=3D 0;
=20
 	return 0;
--=20
2.24.1

