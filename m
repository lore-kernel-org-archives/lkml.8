Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A58EC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C14C222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393246AbgBNSMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:12:18 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:32993 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393208AbgBNSMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:12:13 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1j2fD2-0005g2-9K; Fri, 14 Feb 2020 17:57:01 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     jani.nikula@linux.intel.com, ville.syrjala@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ramalingam C <ramalingam.c@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4] drm/i915: Init lspcon after HPD in intel_dp_detect()
Date:   Sat, 15 Feb 2020 01:56:27 +0800
Message-Id: <20200214175646.25532-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On HP 800 G4 DM, if HDMI cable isn't plugged before boot, the HDMI port
becomes useless and never responds to cable hotplugging:
[    3.031904] [drm:lspcon_init [i915]] *ERROR* Failed to probe lspcon
[    3.031945] [drm:intel_ddi_init [i915]] *ERROR* LSPCON init failed on port D

Seems like the lspcon chip on the system in question only gets powered
after the cable is plugged.

So let's call lspcon_init() dynamically to properly initialize the
lspcon chip and make HDMI port work.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v4:
 - Trust VBT in intel_infoframe_init().
 - Init lspcon in intel_dp_detect().

v3:
 - Make sure it's handled under long HPD case.

v2: 
 - Move lspcon_init() inside of intel_dp_hpd_pulse().

 drivers/gpu/drm/i915/display/intel_ddi.c  | 17 +----------------
 drivers/gpu/drm/i915/display/intel_dp.c   | 13 ++++++++++++-
 drivers/gpu/drm/i915/display/intel_hdmi.c |  2 +-
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index 33f1dc3d7c1a..ca717434b406 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -4741,7 +4741,7 @@ void intel_ddi_init(struct drm_i915_private *dev_priv, enum port port)
 		&dev_priv->vbt.ddi_port_info[port];
 	struct intel_digital_port *intel_dig_port;
 	struct intel_encoder *encoder;
-	bool init_hdmi, init_dp, init_lspcon = false;
+	bool init_hdmi, init_dp;
 	enum phy phy = intel_port_to_phy(dev_priv, port);
 
 	init_hdmi = port_info->supports_dvi || port_info->supports_hdmi;
@@ -4754,7 +4754,6 @@ void intel_ddi_init(struct drm_i915_private *dev_priv, enum port port)
 		 * is initialized before lspcon.
 		 */
 		init_dp = true;
-		init_lspcon = true;
 		init_hdmi = false;
 		DRM_DEBUG_KMS("VBT says port %c has lspcon\n", port_name(port));
 	}
@@ -4833,20 +4832,6 @@ void intel_ddi_init(struct drm_i915_private *dev_priv, enum port port)
 			goto err;
 	}
 
-	if (init_lspcon) {
-		if (lspcon_init(intel_dig_port))
-			/* TODO: handle hdmi info frame part */
-			DRM_DEBUG_KMS("LSPCON init success on port %c\n",
-				port_name(port));
-		else
-			/*
-			 * LSPCON init faied, but DP init was success, so
-			 * lets try to drive as DP++ port.
-			 */
-			DRM_ERROR("LSPCON init failed on port %c\n",
-				port_name(port));
-	}
-
 	intel_infoframe_init(intel_dig_port);
 
 	return;
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index c7424e2a04a3..43117aa86292 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -5663,8 +5663,19 @@ intel_dp_detect(struct drm_connector *connector,
 	/* Can't disconnect eDP */
 	if (intel_dp_is_edp(intel_dp))
 		status = edp_detect(intel_dp);
-	else if (intel_digital_port_connected(encoder))
+	else if (intel_digital_port_connected(encoder)) {
+		if (intel_bios_is_lspcon_present(dev_priv, dig_port->base.port) &&
+		    !dig_port->lspcon.active) {
+			if (lspcon_init(dig_port))
+				DRM_DEBUG_KMS("LSPCON init success on port %c\n",
+					      port_name(dig_port->base.port));
+			else
+				DRM_DEBUG_KMS("LSPCON init failed on port %c\n",
+					      port_name(dig_port->base.port));
+		}
+
 		status = intel_dp_detect_dpcd(intel_dp);
+	}
 	else
 		status = connector_status_disconnected;
 
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 93ac0f296852..27a5aa8cefc9 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -3100,7 +3100,7 @@ void intel_infoframe_init(struct intel_digital_port *intel_dig_port)
 		intel_dig_port->set_infoframes = g4x_set_infoframes;
 		intel_dig_port->infoframes_enabled = g4x_infoframes_enabled;
 	} else if (HAS_DDI(dev_priv)) {
-		if (intel_dig_port->lspcon.active) {
+		if (intel_bios_is_lspcon_present(dev_priv, intel_dig_port->base.port)) {
 			intel_dig_port->write_infoframe = lspcon_write_infoframe;
 			intel_dig_port->read_infoframe = lspcon_read_infoframe;
 			intel_dig_port->set_infoframes = lspcon_set_infoframes;
-- 
2.17.1

