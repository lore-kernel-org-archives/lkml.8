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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA8EC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7862621775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHmP2Y0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgBFIAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 03:00:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33575 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbgBFIAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 03:00:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id u6so5962389wrt.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 00:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=APfflRhO4/tzwp2vW1hianE0xPgvyD/AvtSbcCHEmyo=;
        b=hHmP2Y0JJmFqc97yXsqggVUNX4wL3ky6p1RdRi5g23Y2RmpwSSIMSId3tN5Y6c1v1l
         Mc2I2j7IfvTsYV/kineOwVhMvUH9RHykbR/vlKeqYSJkbPnJHZm0wGtwWJwJrgdXqSHs
         4+Uvsn+ghwCQdCyj4X2qPpX9t4ROM2EXihzxl3zrCeSI8f/1o2RFltx8GfyPuqa2GgIa
         D9bgO+AcKltaIj/FwUdmhspSW9MXACJk3J4c1v8OnGqM9/c6gqQKTTXAldIZ+4g92maP
         IBbPAv6ls+EObDkJkNRET0lePQjz0E9pRJKuHtzp/JE5k+nx0H/iaZazhuC00G0N3TKh
         RLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=APfflRhO4/tzwp2vW1hianE0xPgvyD/AvtSbcCHEmyo=;
        b=e4VRaiEYbuYD2KogUR6A4f56b36Dr12WYDpfewdQ+/PNcoYCG5tP3421q+mfnKmsje
         tHcIMZrQ0aNzQnjjOYelkoPXhsgQqgR/XQv124j20Zg/ySChJGuLA4y4Q9Do/YKlaf4E
         5jhClkuIE8dlJcNx0m1tKHwC0uCSEwJ1KXuEc2mV0jlckBBEoDM6HSCUglMUfDrc6VnR
         mFjpBAOaAk+iSSgYgwWloDF8bgiBnkdd7p5oZq+7P038/eC+CzJgUHt8s/q9MLSlpsPP
         kPgG8cEsA8QH5e1fznzMz7GdDqUEpsPHgSFGLTYWeLvziGtCQ8aebqqBX+jJKXF60AgE
         0Pfw==
X-Gm-Message-State: APjAAAUvzOFgpMcpZiYcvz+yMmbs2Ap1GwW2AI69Op9QE61wUFHENNlT
        OmF7yc+Zj3daBsvxgoD9e3ZTaPnQ2Vk=
X-Google-Smtp-Source: APXvYqzaQ8jg92IYvt5pJdfXMNBK8bX6qLc6se2t5Y67WS/PAMWBLjhGC2RBs6xV6t/JB1Ci/vTGfA==
X-Received: by 2002:adf:e781:: with SMTP id n1mr2529245wrm.56.1580976042546;
        Thu, 06 Feb 2020 00:00:42 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id u8sm2635132wmm.15.2020.02.06.00.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 00:00:42 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/12] drm/i915/crt: automatic conversion to drm_device based logging macros.
Date:   Thu,  6 Feb 2020 11:00:06 +0300
Message-Id: <20200206080014.13759-6-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206080014.13759-1-wambui.karugax@gmail.com>
References: <20200206080014.13759-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaces various instances of the printk based logging macros with the
struct drm_device based logging macros in i915/display/intel_crt.c using
the following coccinelle script that matches based on the existence of a
drm_i915_private device pointer:
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

Checkpatch warnings were addressed manually.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_crt.c | 49 +++++++++++++++---------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_crt.c b/drivers/gpu/drm/i915/display/intel_crt.c
index 0e2f63b0d458..45ecc7d9c829 100644
--- a/drivers/gpu/drm/i915/display/intel_crt.c
+++ b/drivers/gpu/drm/i915/display/intel_crt.c
@@ -420,7 +420,8 @@ static int hsw_crt_compute_config(struct intel_encoder *encoder,
 	/* LPT FDI RX only supports 8bpc. */
 	if (HAS_PCH_LPT(dev_priv)) {
 		if (pipe_config->bw_constrained && pipe_config->pipe_bpp < 24) {
-			DRM_DEBUG_KMS("LPT only supports 24bpp\n");
+			drm_dbg_kms(&dev_priv->drm,
+				    "LPT only supports 24bpp\n");
 			return -EINVAL;
 		}
 
@@ -449,7 +450,8 @@ static bool ilk_crt_detect_hotplug(struct drm_connector *connector)
 		crt->force_hotplug_required = false;
 
 		save_adpa = adpa = intel_de_read(dev_priv, crt->adpa_reg);
-		DRM_DEBUG_KMS("trigger hotplug detect cycle: adpa=0x%x\n", adpa);
+		drm_dbg_kms(&dev_priv->drm,
+			    "trigger hotplug detect cycle: adpa=0x%x\n", adpa);
 
 		adpa |= ADPA_CRT_HOTPLUG_FORCE_TRIGGER;
 		if (turn_off_dac)
@@ -461,7 +463,8 @@ static bool ilk_crt_detect_hotplug(struct drm_connector *connector)
 					    crt->adpa_reg,
 					    ADPA_CRT_HOTPLUG_FORCE_TRIGGER,
 					    1000))
-			DRM_DEBUG_KMS("timed out waiting for FORCE_TRIGGER");
+			drm_dbg_kms(&dev_priv->drm,
+				    "timed out waiting for FORCE_TRIGGER");
 
 		if (turn_off_dac) {
 			intel_de_write(dev_priv, crt->adpa_reg, save_adpa);
@@ -475,7 +478,8 @@ static bool ilk_crt_detect_hotplug(struct drm_connector *connector)
 		ret = true;
 	else
 		ret = false;
-	DRM_DEBUG_KMS("ironlake hotplug adpa=0x%x, result %d\n", adpa, ret);
+	drm_dbg_kms(&dev_priv->drm, "ironlake hotplug adpa=0x%x, result %d\n",
+		    adpa, ret);
 
 	return ret;
 }
@@ -505,7 +509,8 @@ static bool valleyview_crt_detect_hotplug(struct drm_connector *connector)
 	reenable_hpd = intel_hpd_disable(dev_priv, crt->base.hpd_pin);
 
 	save_adpa = adpa = intel_de_read(dev_priv, crt->adpa_reg);
-	DRM_DEBUG_KMS("trigger hotplug detect cycle: adpa=0x%x\n", adpa);
+	drm_dbg_kms(&dev_priv->drm,
+		    "trigger hotplug detect cycle: adpa=0x%x\n", adpa);
 
 	adpa |= ADPA_CRT_HOTPLUG_FORCE_TRIGGER;
 
@@ -513,7 +518,8 @@ static bool valleyview_crt_detect_hotplug(struct drm_connector *connector)
 
 	if (intel_de_wait_for_clear(dev_priv, crt->adpa_reg,
 				    ADPA_CRT_HOTPLUG_FORCE_TRIGGER, 1000)) {
-		DRM_DEBUG_KMS("timed out waiting for FORCE_TRIGGER");
+		drm_dbg_kms(&dev_priv->drm,
+			    "timed out waiting for FORCE_TRIGGER");
 		intel_de_write(dev_priv, crt->adpa_reg, save_adpa);
 	}
 
@@ -524,7 +530,8 @@ static bool valleyview_crt_detect_hotplug(struct drm_connector *connector)
 	else
 		ret = false;
 
-	DRM_DEBUG_KMS("valleyview hotplug adpa=0x%x, result %d\n", adpa, ret);
+	drm_dbg_kms(&dev_priv->drm,
+		    "valleyview hotplug adpa=0x%x, result %d\n", adpa, ret);
 
 	if (reenable_hpd)
 		intel_hpd_enable(dev_priv, crt->base.hpd_pin);
@@ -564,7 +571,8 @@ static bool intel_crt_detect_hotplug(struct drm_connector *connector)
 		/* wait for FORCE_DETECT to go off */
 		if (intel_de_wait_for_clear(dev_priv, PORT_HOTPLUG_EN,
 					    CRT_HOTPLUG_FORCE_DETECT, 1000))
-			DRM_DEBUG_KMS("timed out waiting for FORCE_DETECT to go off");
+			drm_dbg_kms(&dev_priv->drm,
+				    "timed out waiting for FORCE_DETECT to go off");
 	}
 
 	stat = intel_de_read(dev_priv, PORT_HOTPLUG_STAT);
@@ -635,13 +643,16 @@ static bool intel_crt_detect_ddc(struct drm_connector *connector)
 		 * have to check the EDID input spec of the attached device.
 		 */
 		if (!is_digital) {
-			DRM_DEBUG_KMS("CRT detected via DDC:0x50 [EDID]\n");
+			drm_dbg_kms(&dev_priv->drm,
+				    "CRT detected via DDC:0x50 [EDID]\n");
 			ret = true;
 		} else {
-			DRM_DEBUG_KMS("CRT not detected via DDC:0x50 [EDID reports a digital panel]\n");
+			drm_dbg_kms(&dev_priv->drm,
+				    "CRT not detected via DDC:0x50 [EDID reports a digital panel]\n");
 		}
 	} else {
-		DRM_DEBUG_KMS("CRT not detected via DDC:0x50 [no valid EDID found]\n");
+		drm_dbg_kms(&dev_priv->drm,
+			    "CRT not detected via DDC:0x50 [no valid EDID found]\n");
 	}
 
 	kfree(edid);
@@ -666,7 +677,7 @@ intel_crt_load_detect(struct intel_crt *crt, u32 pipe)
 	u8 st00;
 	enum drm_connector_status status;
 
-	DRM_DEBUG_KMS("starting load-detect on CRT\n");
+	drm_dbg_kms(&dev_priv->drm, "starting load-detect on CRT\n");
 
 	bclrpat_reg = BCLRPAT(pipe);
 	vtotal_reg = VTOTAL(pipe);
@@ -807,9 +818,9 @@ intel_crt_detect(struct drm_connector *connector,
 	int status, ret;
 	struct intel_load_detect_pipe tmp;
 
-	DRM_DEBUG_KMS("[CONNECTOR:%d:%s] force=%d\n",
-		      connector->base.id, connector->name,
-		      force);
+	drm_dbg_kms(&dev_priv->drm, "[CONNECTOR:%d:%s] force=%d\n",
+		    connector->base.id, connector->name,
+		    force);
 
 	if (i915_modparams.load_detect_test) {
 		wakeref = intel_display_power_get(dev_priv,
@@ -830,11 +841,13 @@ intel_crt_detect(struct drm_connector *connector,
 		 * only trust an assertion that the monitor is connected.
 		 */
 		if (intel_crt_detect_hotplug(connector)) {
-			DRM_DEBUG_KMS("CRT detected via hotplug\n");
+			drm_dbg_kms(&dev_priv->drm,
+				    "CRT detected via hotplug\n");
 			status = connector_status_connected;
 			goto out;
 		} else
-			DRM_DEBUG_KMS("CRT not detected via hotplug\n");
+			drm_dbg_kms(&dev_priv->drm,
+				    "CRT not detected via hotplug\n");
 	}
 
 	if (intel_crt_detect_ddc(connector)) {
@@ -930,7 +943,7 @@ void intel_crt_reset(struct drm_encoder *encoder)
 		intel_de_write(dev_priv, crt->adpa_reg, adpa);
 		intel_de_posting_read(dev_priv, crt->adpa_reg);
 
-		DRM_DEBUG_KMS("crt adpa set to 0x%x\n", adpa);
+		drm_dbg_kms(&dev_priv->drm, "crt adpa set to 0x%x\n", adpa);
 		crt->force_hotplug_required = true;
 	}
 
-- 
2.25.0

