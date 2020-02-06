Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360A9C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD0D21775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4yfRQtA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgBFIBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 03:01:02 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53146 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbgBFIA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 03:00:59 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so5181923wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 00:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wjYTnVG7+ACFqI6Svg5/K0RXWs6QPB8w7ppawHLSitc=;
        b=P4yfRQtAB4VabCdxENb0Uuh8NGyU7hCdvSuzBRSnhUl2oapF/b4yecb4bpoNC031az
         5zJMosZmH6+xKQpUd/M5/b1fzvp62tCe7is56i1ITXbZdrcy+lx8x45rcliQKpPQlnl/
         nFZntTVdS2L2FcMeOGzGpvz8aQOayO0Of1ZFB9s+FSxcaVR4cXKeDO2C5me3G65KxJeB
         mr4rjQMRKY2Ka2tVBF8V+8nediKPrIEWkCAZSJynA5NrQ4fVPM2KtAkSXuGwmHvLkcsn
         F1jDWPV9R0C5RgqAalhxKcJeddI1/g1vaxzyp65ui7sPrc3s+HcHTd/AdEcnPiZqi7qF
         /QRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wjYTnVG7+ACFqI6Svg5/K0RXWs6QPB8w7ppawHLSitc=;
        b=eg3oUhtYEDlfRx6rgJUyovn6vX1o3RAuQISFxYaWtiMfjJsC8T6iv5t+G3EG2VAKK2
         YkBCaJ/uVd41jIqYrbqXKkt9ee//kFFy9QVUtGIrbo150G56fXA00ZqOoJ+HjQobIwNz
         /xflUokRT2aeIuOvqGWlDegG3FWh/Mm4l+3gWaBqjLrQIRWPPdx57kRkHHzruJnOkWcz
         3/qlBRMPH0ShQgHuSCpDuBz2CW3dwl/2BMX4zdZxmPlMyCfBLw89Oua5XaxL6fa/qnc4
         l79XDa6VB15cc+OSlXn1AtcSmBz/DLF1h9OpZQHp0bVr7X+oulUeG/pyHC2KXgiuOX7e
         SS4w==
X-Gm-Message-State: APjAAAUYTNXdoiVWQZjopJbT3ttpFXsn7fL0LKUZvmr+207+hlwOX3/T
        ckIqoBVXobYTl/Zqc9nLXlE=
X-Google-Smtp-Source: APXvYqw/7R5mDQLPE/OgZOnxm7jnVRsngzFLhwuIeUJIRXLaWnKYMNVc5zKgGdxXSI18KAeLxFXlog==
X-Received: by 2002:a7b:c3d1:: with SMTP id t17mr2879567wmj.27.1580976056631;
        Thu, 06 Feb 2020 00:00:56 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id u8sm2635132wmm.15.2020.02.06.00.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 00:00:56 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/12] drm/i915/dp_mst: convert to drm_device based logging macros.
Date:   Thu,  6 Feb 2020 11:00:10 +0300
Message-Id: <20200206080014.13759-10-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206080014.13759-1-wambui.karugax@gmail.com>
References: <20200206080014.13759-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conversion of instances of the printk based drm logging macros to the
struct drm_device based logging macros in i915/display/intel_dp_mst.c.
This also involves extracting the drm_i915_private device pointer from
various intel types to use in the macros.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_dp_mst.c | 30 ++++++++++++++-------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index b8aee506d595..45028faa4409 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -42,6 +42,7 @@ static int intel_dp_mst_compute_link_config(struct intel_encoder *encoder,
 					    struct drm_connector_state *conn_state,
 					    struct link_config_limits *limits)
 {
+	struct drm_i915_private *i915 = to_i915(encoder->base.dev);
 	struct drm_atomic_state *state = crtc_state->uapi.state;
 	struct intel_dp_mst_encoder *intel_mst = enc_to_mst(encoder);
 	struct intel_dp *intel_dp = &intel_mst->primary->dp;
@@ -73,7 +74,8 @@ static int intel_dp_mst_compute_link_config(struct intel_encoder *encoder,
 	}
 
 	if (slots < 0) {
-		DRM_DEBUG_KMS("failed finding vcpi slots:%d\n", slots);
+		drm_dbg_kms(&i915->drm,
+			    "failed finding vcpi slots:%d\n", slots);
 		return slots;
 	}
 
@@ -322,15 +324,18 @@ static void intel_mst_disable_dp(struct intel_encoder *encoder,
 	struct intel_dp *intel_dp = &intel_dig_port->dp;
 	struct intel_connector *connector =
 		to_intel_connector(old_conn_state->connector);
+	struct drm_i915_private *i915 = to_i915(encoder->base.dev);
 	int ret;
 
-	DRM_DEBUG_KMS("active links %d\n", intel_dp->active_mst_links);
+	drm_dbg_kms(&i915->drm,
+		    "active links %d\n", intel_dp->active_mst_links);
 
 	drm_dp_mst_reset_vcpi_slots(&intel_dp->mst_mgr, connector->port);
 
 	ret = drm_dp_update_payload_part1(&intel_dp->mst_mgr);
 	if (ret) {
-		DRM_DEBUG_KMS("failed to update payload %d\n", ret);
+		drm_dbg_kms(&i915->drm,
+			    "failed to update payload %d\n", ret);
 	}
 	if (old_crtc_state->has_audio)
 		intel_audio_codec_disable(encoder,
@@ -371,7 +376,8 @@ static void intel_mst_post_disable_dp(struct intel_encoder *encoder,
 
 	if (intel_de_wait_for_set(dev_priv, intel_dp->regs.dp_tp_status,
 				  DP_TP_STATUS_ACT_SENT, 1))
-		DRM_ERROR("Timed out waiting for ACT sent when disabling\n");
+		drm_err(&dev_priv->drm,
+			"Timed out waiting for ACT sent when disabling\n");
 	drm_dp_check_act_status(&intel_dp->mst_mgr);
 
 	drm_dp_mst_deallocate_vcpi(&intel_dp->mst_mgr, connector->port);
@@ -405,7 +411,8 @@ static void intel_mst_post_disable_dp(struct intel_encoder *encoder,
 		intel_dig_port->base.post_disable(&intel_dig_port->base,
 						  old_crtc_state, NULL);
 
-	DRM_DEBUG_KMS("active links %d\n", intel_dp->active_mst_links);
+	drm_dbg_kms(&dev_priv->drm, "active links %d\n",
+		    intel_dp->active_mst_links);
 }
 
 static void intel_mst_pre_pll_enable_dp(struct intel_encoder *encoder,
@@ -445,7 +452,8 @@ static void intel_mst_pre_enable_dp(struct intel_encoder *encoder,
 		    INTEL_GEN(dev_priv) >= 12 && first_mst_stream &&
 		    !intel_dp_mst_is_master_trans(pipe_config));
 
-	DRM_DEBUG_KMS("active links %d\n", intel_dp->active_mst_links);
+	drm_dbg_kms(&dev_priv->drm, "active links %d\n",
+		    intel_dp->active_mst_links);
 
 	if (first_mst_stream)
 		intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_ON);
@@ -461,7 +469,7 @@ static void intel_mst_pre_enable_dp(struct intel_encoder *encoder,
 				       pipe_config->pbn,
 				       pipe_config->dp_m_n.tu);
 	if (!ret)
-		DRM_ERROR("failed to allocate vcpi\n");
+		drm_err(&dev_priv->drm, "failed to allocate vcpi\n");
 
 	intel_dp->active_mst_links++;
 	temp = intel_de_read(dev_priv, intel_dp->regs.dp_tp_status);
@@ -491,11 +499,12 @@ static void intel_mst_enable_dp(struct intel_encoder *encoder,
 	struct intel_dp *intel_dp = &intel_dig_port->dp;
 	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
 
-	DRM_DEBUG_KMS("active links %d\n", intel_dp->active_mst_links);
+	drm_dbg_kms(&dev_priv->drm, "active links %d\n",
+		    intel_dp->active_mst_links);
 
 	if (intel_de_wait_for_set(dev_priv, intel_dp->regs.dp_tp_status,
 				  DP_TP_STATUS_ACT_SENT, 1))
-		DRM_ERROR("Timed out waiting for ACT sent\n");
+		drm_err(&dev_priv->drm, "Timed out waiting for ACT sent\n");
 
 	drm_dp_check_act_status(&intel_dp->mst_mgr);
 
@@ -727,7 +736,8 @@ static void intel_dp_destroy_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 {
 	struct drm_i915_private *dev_priv = to_i915(connector->dev);
 
-	DRM_DEBUG_KMS("[CONNECTOR:%d:%s]\n", connector->base.id, connector->name);
+	drm_dbg_kms(&dev_priv->drm, "[CONNECTOR:%d:%s]\n", connector->base.id,
+		    connector->name);
 	drm_connector_unregister(connector);
 
 	if (dev_priv->fbdev)
-- 
2.25.0

