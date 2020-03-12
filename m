Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187F7C0044D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18354206F7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mmGkCmqF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387633AbgCLA5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 20:57:45 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:41913 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387596AbgCLA5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 20:57:41 -0400
Received: by mail-pl1-f202.google.com with SMTP id u3so2323655plm.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 17:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hrX565yTBVUaBRHBANP/oUW6tx77j7n+/fB0WrNdRuo=;
        b=mmGkCmqF1t4vIGKl1vxRmYa4Iw9gw+m0F2Rl36GDX5iFly8hLcreI4jW1JM0aj9fke
         mEhYDzVhpOaAmixqSzg4Zm5LcbvnOrul+h7AKhTqr9vwmuCxeJ2hQ6GiB7gc7kWUHvWH
         B1bfDHrvt/E9HTfMP0pIbWBLiFG9MjkavH0Otsac92H+MB+4jaFXYn7fzfii6HNUyEP9
         LoaEAooybbbw4wOPB1wo2ldXZ2cMJX2PtI9ACfh7AzN+OehezA9MI68uW7Y5jVc6czVo
         mle4uCa7o5PzON+Fe+JJ9FApEx33Sw+Z31PPH7UTQaaVSJQoZXojHjMc4kixdB5/w0cq
         T5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hrX565yTBVUaBRHBANP/oUW6tx77j7n+/fB0WrNdRuo=;
        b=I3A4xkR9RwUHSMwEkDzvQ3qtRG1veiyoZczAvRUMlpKKlD/z6MyArEFWkAFpWewPMT
         Qxv8ZyvR+pMRLGuJOuUebgI2huXd3S0W3lHV2Hw0tvGHU9C8LMkfkEXtCj4vrM9o30/i
         SSGccgwimM2uMW5QQEiDG1fynLD+Wf4crhOFULRsMEa7d6VdXSePGvxEsdLtY3aGmwzD
         AKqZ0OIxitRnLl+wCAxPpprtIXLcKhcwdvWe17kIff9tFfva0m4BywoudpAe5kWGQ9Uu
         pb3uVUU3PNc1h2bOh8WV3gmz35DKXU1EeW7W8mpsqenyC7RBr35nKG4EkcKE7uRNnq/y
         Hcjw==
X-Gm-Message-State: ANhLgQ0MCPGPu7nIJJapOEFbfxCpJZ6cp00pipkql0X8Zel0c6SVXBEu
        OKfcH7qufAYLxaTzENSGfkuTMj9e+nIJ
X-Google-Smtp-Source: ADFU+vvwh7TxtyhUhqTq0JD2HSw6HCRI/lZYTYLR36CPZC7RY1ZRfZmp0+bpIdsz6npDN4qgr1AMMVBexP3l
X-Received: by 2002:a17:90a:2103:: with SMTP id a3mr1404774pje.181.1583974660505;
 Wed, 11 Mar 2020 17:57:40 -0700 (PDT)
Date:   Wed, 11 Mar 2020 17:57:22 -0700
In-Reply-To: <20200312005722.48803-1-rajatja@google.com>
Message-Id: <20200312005722.48803-6-rajatja@google.com>
Mime-Version: 1.0
References: <20200312005722.48803-1-rajatja@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v8 5/5] drm/i915: Enable support for integrated privacy screen
From:   Rajat Jain <rajatja@google.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        "=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=" 
        <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Imre Deak <imre.deak@intel.com>,
        "=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?=" <jose.souza@intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, gregkh@linuxfoundation.org,
        mathewk@google.com, Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@denx.de>,
        seanpaul@google.com, Duncan Laurie <dlaurie@google.com>,
        jsbarnes@google.com, Thierry Reding <thierry.reding@gmail.com>,
        mpearson@lenovo.com, Nitin Joshi1 <njoshi1@lenovo.com>,
        Sugumaran Lacshiminarayanan <slacshiminar@lenovo.com>,
        Tomoki Maruichi <maruichit@lenovo.com>
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for an ACPI based integrated privacy screen that is
available on some systems.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v8: - separate the APCI privacy screen into a separate patch.
    - Don't destroy the property if there is no privacy screen (because
      drm core doesn't like destroying property in late_register()).
    - The setting change needs to be committed in ->update_pipe() for 
      ddi.c as well as dp.c and both of them call intel_dp_add_properties()
v7: Look for ACPI node in ->late_register() hook.
    Do the scan only once per drm_device (instead of 1 per drm_connector)
v6: Addressed minor comments from Jani at
    https://lkml.org/lkml/2020/1/24/1143
     - local variable renamed.
     - used drm_dbg_kms()
     - used acpi_device_handle()
     - Used opaque type acpi_handle instead of void*
v5: same as v4
v4: Same as v3
v3: fold the code into existing acpi_device_id_update() function
v2: formed by splitting the original patch into ACPI lookup, and privacy
    screen property. Also move it into i915 now that I found existing code
    in i915 that can be re-used.

 drivers/gpu/drm/i915/display/intel_atomic.c |  2 ++
 drivers/gpu/drm/i915/display/intel_ddi.c    |  1 +
 drivers/gpu/drm/i915/display/intel_dp.c     | 34 ++++++++++++++++++++-
 drivers/gpu/drm/i915/display/intel_dp.h     |  5 +++
 4 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_atomic.c b/drivers/gpu/drm/i915/display/intel_atomic.c
index d043057d2fa03..9898d8980e7ce 100644
--- a/drivers/gpu/drm/i915/display/intel_atomic.c
+++ b/drivers/gpu/drm/i915/display/intel_atomic.c
@@ -150,6 +150,8 @@ int intel_digital_connector_atomic_check(struct drm_connector *conn,
 	    new_conn_state->base.picture_aspect_ratio != old_conn_state->base.picture_aspect_ratio ||
 	    new_conn_state->base.content_type != old_conn_state->base.content_type ||
 	    new_conn_state->base.scaling_mode != old_conn_state->base.scaling_mode ||
+	    new_conn_state->base.privacy_screen_status !=
+		old_conn_state->base.privacy_screen_status ||
 	    !blob_equal(new_conn_state->base.hdr_output_metadata,
 			old_conn_state->base.hdr_output_metadata))
 		crtc_state->mode_changed = true;
diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index 73d0f4648c06a..69a5423216dc5 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -3708,6 +3708,7 @@ static void intel_ddi_update_pipe(struct intel_encoder *encoder,
 	if (!intel_crtc_has_type(crtc_state, INTEL_OUTPUT_HDMI))
 		intel_ddi_update_pipe_dp(encoder, crtc_state, conn_state);
 
+	intel_dp_update_privacy_screen(encoder, crtc_state, conn_state);
 	intel_hdcp_update_pipe(encoder, crtc_state, conn_state);
 }
 
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 3ddc424b028c1..5f33ebb466135 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -62,6 +62,7 @@
 #include "intel_lspcon.h"
 #include "intel_lvds.h"
 #include "intel_panel.h"
+#include "intel_privacy_screen.h"
 #include "intel_psr.h"
 #include "intel_sideband.h"
 #include "intel_tc.h"
@@ -5886,6 +5887,10 @@ intel_dp_connector_register(struct drm_connector *connector)
 		dev_priv->acpi_scan_done = true;
 	}
 
+	/* Check for integrated Privacy screen support */
+	if (intel_privacy_screen_present(to_intel_connector(connector)))
+		drm_connector_attach_privacy_screen_property(connector);
+
 	DRM_DEBUG_KMS("registering %s bus for %s\n",
 		      intel_dp->aux.name, connector->kdev->kobj.name);
 
@@ -6883,6 +6888,33 @@ intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *connect
 		connector->state->scaling_mode = DRM_MODE_SCALE_ASPECT;
 
 	}
+
+	/*
+	 * Created here, but depending on result of probing for privacy-screen
+	 * in intel_dp_connector_register(), gets attached in that function.
+	 * Need to create here because the drm core doesn't like creating
+	 * properties during ->late_register().
+	 */
+	drm_connector_create_privacy_screen_property(connector);
+}
+
+void
+intel_dp_update_privacy_screen(struct intel_encoder *encoder,
+			       const struct intel_crtc_state *crtc_state,
+			       const struct drm_connector_state *conn_state)
+{
+	struct drm_connector *connector = conn_state->connector;
+
+	intel_privacy_screen_set_val(to_intel_connector(connector),
+				     conn_state->privacy_screen_status);
+}
+
+static void intel_dp_update_pipe(struct intel_encoder *encoder,
+				 const struct intel_crtc_state *crtc_state,
+				 const struct drm_connector_state *conn_state)
+{
+	intel_dp_update_privacy_screen(encoder, crtc_state, conn_state);
+	intel_panel_update_backlight(encoder, crtc_state, conn_state);
 }
 
 static void intel_dp_init_panel_power_timestamps(struct intel_dp *intel_dp)
@@ -7826,7 +7858,7 @@ bool intel_dp_init(struct drm_i915_private *dev_priv,
 	intel_encoder->compute_config = intel_dp_compute_config;
 	intel_encoder->get_hw_state = intel_dp_get_hw_state;
 	intel_encoder->get_config = intel_dp_get_config;
-	intel_encoder->update_pipe = intel_panel_update_backlight;
+	intel_encoder->update_pipe = intel_dp_update_pipe;
 	intel_encoder->suspend = intel_dp_encoder_suspend;
 	if (IS_CHERRYVIEW(dev_priv)) {
 		intel_encoder->pre_pll_enable = chv_dp_pre_pll_enable;
diff --git a/drivers/gpu/drm/i915/display/intel_dp.h b/drivers/gpu/drm/i915/display/intel_dp.h
index 0c7be8ed1423a..e4594e27ce5a8 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.h
+++ b/drivers/gpu/drm/i915/display/intel_dp.h
@@ -123,4 +123,9 @@ static inline unsigned int intel_dp_unused_lane_mask(int lane_count)
 
 u32 intel_dp_mode_to_fec_clock(u32 mode_clock);
 
+void
+intel_dp_update_privacy_screen(struct intel_encoder *encoder,
+			       const struct intel_crtc_state *crtc_state,
+			       const struct drm_connector_state *conn_state);
+
 #endif /* __INTEL_DP_H__ */
-- 
2.25.1.481.gfbce0eb801-goog

