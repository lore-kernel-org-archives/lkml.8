Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38B1C33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 11:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52E52467A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 11:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auK2996R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbgAVLJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 06:09:10 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35360 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbgAVLJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 06:09:08 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so6727138wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 03:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Aqa2x06uPpOzGFeT4xa9AlF53RyKDahJswhSuJR8ygA=;
        b=auK2996RSOWLt4c3TtEpHbmcJTBmh49peziILLyaL23uZJtOI2ejy8BvlBWtvsT5mt
         TFcFrXetxzknYcw0aJTOnPt2FmXXswQdXC0fXToIrikFeMK04Jz4pUmDnAeQFCzEThqj
         7TIiGGkbIEsJ5K909LoS/AdVFxXpOeHBLUWCT5mB1NFVE3DHmFny9PqnoO1nSpqSg5qz
         bj/a3wnpZ7p+TJW2wHWFHQXbqfTqlhQtWnAmAdpnJlNBKpY5iWqOf/U+jjoviU2jcWTX
         gwxxKJUxLD8AqFBih6KUU7Pxhj0rDcpC/OPBX3/nZL36NLnBWP/zj1Shy/8Vna3ex3HJ
         UJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Aqa2x06uPpOzGFeT4xa9AlF53RyKDahJswhSuJR8ygA=;
        b=QupzHFjk/eppTGiCvTAHeWpWW8LSw9HnE3jdhQuYVbzbtnsX3ik6bQGLn1APz09390
         mPfhpS/LB2s3A7p4ScTRu4DfgWi0dQ6bWlRWOlp9Pe2iI9rInNWDF+TnOPD+EVvQaqYu
         BJx0Y6r7ziAGiK39bFc2Se69+MnTMCInTGlST2PTQQz5uhpkdorpfvU+iSAVEb/1HuYb
         NPSRliCFyC7xOmz6l5h7rj57ERIfwsFqGaDGcPm0C/GNWxFeQVrvNXiKNYx+PzhkjiVd
         B3X96tSpfJUHEF01NW4p87tAJYjE1bvAl+1KcWEQ/RDypAHBCL+TuLm56iLm1bZzIrvL
         mHgQ==
X-Gm-Message-State: APjAAAUhBbUYb+UbN9sTZeyML00uEZsXnUoXmKLpESF2J2x3Z0S7fphf
        lNC/wSS4UA/MBeVD5eZyf5E=
X-Google-Smtp-Source: APXvYqxZTYeHABGfg5dhcqN3ZaTdfuwjfOxHbyjc4FNl71SSP5A0M39Lh0g0pfsq+ybMkEgikKjXzQ==
X-Received: by 2002:a1c:20ce:: with SMTP id g197mr1963581wmg.172.1579691345467;
        Wed, 22 Jan 2020 03:09:05 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id l3sm52454380wrt.29.2020.01.22.03.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 03:09:04 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] drm/i915/opregion: conversion to struct drm_device logging macros.
Date:   Wed, 22 Jan 2020 14:08:43 +0300
Message-Id: <20200122110844.2022-6-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122110844.2022-1-wambui.karugax@gmail.com>
References: <20200122110844.2022-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts various instances of the printk based logging macros in
i915/display/intel_opregion.c with the new struct drm_device based
logging macros using the following coccinelle script:
@rule1@
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

@rule2@
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
 drivers/gpu/drm/i915/display/intel_opregion.c | 134 +++++++++++-------
 1 file changed, 80 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_opregion.c b/drivers/gpu/drm/i915/display/intel_opregion.c
index e59b4992ba1b..b54fe4dc0423 100644
--- a/drivers/gpu/drm/i915/display/intel_opregion.c
+++ b/drivers/gpu/drm/i915/display/intel_opregion.c
@@ -311,7 +311,7 @@ static int swsci(struct drm_i915_private *dev_priv,
 	/* The spec tells us to do this, but we are the only user... */
 	scic = swsci->scic;
 	if (scic & SWSCI_SCIC_INDICATOR) {
-		DRM_DEBUG_DRIVER("SWSCI request already in progress\n");
+		drm_dbg(&dev_priv->drm, "SWSCI request already in progress\n");
 		return -EBUSY;
 	}
 
@@ -335,7 +335,7 @@ static int swsci(struct drm_i915_private *dev_priv,
 	/* Poll for the result. */
 #define C (((scic = swsci->scic) & SWSCI_SCIC_INDICATOR) == 0)
 	if (wait_for(C, dslp)) {
-		DRM_DEBUG_DRIVER("SWSCI request timed out\n");
+		drm_dbg(&dev_priv->drm, "SWSCI request timed out\n");
 		return -ETIMEDOUT;
 	}
 
@@ -344,7 +344,7 @@ static int swsci(struct drm_i915_private *dev_priv,
 
 	/* Note: scic == 0 is an error! */
 	if (scic != SWSCI_SCIC_EXIT_STATUS_SUCCESS) {
-		DRM_DEBUG_DRIVER("SWSCI request error %u\n", scic);
+		drm_dbg(&dev_priv->drm, "SWSCI request error %u\n", scic);
 		return -EIO;
 	}
 
@@ -448,10 +448,11 @@ static u32 asle_set_backlight(struct drm_i915_private *dev_priv, u32 bclp)
 	struct opregion_asle *asle = dev_priv->opregion.asle;
 	struct drm_device *dev = &dev_priv->drm;
 
-	DRM_DEBUG_DRIVER("bclp = 0x%08x\n", bclp);
+	drm_dbg(&dev_priv->drm, "bclp = 0x%08x\n", bclp);
 
 	if (acpi_video_get_backlight_type() == acpi_backlight_native) {
-		DRM_DEBUG_KMS("opregion backlight request ignored\n");
+		drm_dbg_kms(&dev_priv->drm,
+			    "opregion backlight request ignored\n");
 		return 0;
 	}
 
@@ -468,7 +469,8 @@ static u32 asle_set_backlight(struct drm_i915_private *dev_priv, u32 bclp)
 	 * Update backlight on all connectors that support backlight (usually
 	 * only one).
 	 */
-	DRM_DEBUG_KMS("updating opregion backlight %d/255\n", bclp);
+	drm_dbg_kms(&dev_priv->drm, "updating opregion backlight %d/255\n",
+		    bclp);
 	drm_connector_list_iter_begin(dev, &conn_iter);
 	for_each_intel_connector_iter(connector, &conn_iter)
 		intel_panel_set_backlight_acpi(connector->base.state, bclp, 255);
@@ -485,13 +487,13 @@ static u32 asle_set_als_illum(struct drm_i915_private *dev_priv, u32 alsi)
 {
 	/* alsi is the current ALS reading in lux. 0 indicates below sensor
 	   range, 0xffff indicates above sensor range. 1-0xfffe are valid */
-	DRM_DEBUG_DRIVER("Illum is not supported\n");
+	drm_dbg(&dev_priv->drm, "Illum is not supported\n");
 	return ASLC_ALS_ILLUM_FAILED;
 }
 
 static u32 asle_set_pwm_freq(struct drm_i915_private *dev_priv, u32 pfmb)
 {
-	DRM_DEBUG_DRIVER("PWM freq is not supported\n");
+	drm_dbg(&dev_priv->drm, "PWM freq is not supported\n");
 	return ASLC_PWM_FREQ_FAILED;
 }
 
@@ -499,30 +501,36 @@ static u32 asle_set_pfit(struct drm_i915_private *dev_priv, u32 pfit)
 {
 	/* Panel fitting is currently controlled by the X code, so this is a
 	   noop until modesetting support works fully */
-	DRM_DEBUG_DRIVER("Pfit is not supported\n");
+	drm_dbg(&dev_priv->drm, "Pfit is not supported\n");
 	return ASLC_PFIT_FAILED;
 }
 
 static u32 asle_set_supported_rotation_angles(struct drm_i915_private *dev_priv, u32 srot)
 {
-	DRM_DEBUG_DRIVER("SROT is not supported\n");
+	drm_dbg(&dev_priv->drm, "SROT is not supported\n");
 	return ASLC_ROTATION_ANGLES_FAILED;
 }
 
 static u32 asle_set_button_array(struct drm_i915_private *dev_priv, u32 iuer)
 {
 	if (!iuer)
-		DRM_DEBUG_DRIVER("Button array event is not supported (nothing)\n");
+		drm_dbg(&dev_priv->drm,
+			"Button array event is not supported (nothing)\n");
 	if (iuer & ASLE_IUER_ROTATION_LOCK_BTN)
-		DRM_DEBUG_DRIVER("Button array event is not supported (rotation lock)\n");
+		drm_dbg(&dev_priv->drm,
+			"Button array event is not supported (rotation lock)\n");
 	if (iuer & ASLE_IUER_VOLUME_DOWN_BTN)
-		DRM_DEBUG_DRIVER("Button array event is not supported (volume down)\n");
+		drm_dbg(&dev_priv->drm,
+			"Button array event is not supported (volume down)\n");
 	if (iuer & ASLE_IUER_VOLUME_UP_BTN)
-		DRM_DEBUG_DRIVER("Button array event is not supported (volume up)\n");
+		drm_dbg(&dev_priv->drm,
+			"Button array event is not supported (volume up)\n");
 	if (iuer & ASLE_IUER_WINDOWS_BTN)
-		DRM_DEBUG_DRIVER("Button array event is not supported (windows)\n");
+		drm_dbg(&dev_priv->drm,
+			"Button array event is not supported (windows)\n");
 	if (iuer & ASLE_IUER_POWER_BTN)
-		DRM_DEBUG_DRIVER("Button array event is not supported (power)\n");
+		drm_dbg(&dev_priv->drm,
+			"Button array event is not supported (power)\n");
 
 	return ASLC_BUTTON_ARRAY_FAILED;
 }
@@ -530,9 +538,11 @@ static u32 asle_set_button_array(struct drm_i915_private *dev_priv, u32 iuer)
 static u32 asle_set_convertible(struct drm_i915_private *dev_priv, u32 iuer)
 {
 	if (iuer & ASLE_IUER_CONVERTIBLE)
-		DRM_DEBUG_DRIVER("Convertible is not supported (clamshell)\n");
+		drm_dbg(&dev_priv->drm,
+			"Convertible is not supported (clamshell)\n");
 	else
-		DRM_DEBUG_DRIVER("Convertible is not supported (slate)\n");
+		drm_dbg(&dev_priv->drm,
+			"Convertible is not supported (slate)\n");
 
 	return ASLC_CONVERTIBLE_FAILED;
 }
@@ -540,16 +550,17 @@ static u32 asle_set_convertible(struct drm_i915_private *dev_priv, u32 iuer)
 static u32 asle_set_docking(struct drm_i915_private *dev_priv, u32 iuer)
 {
 	if (iuer & ASLE_IUER_DOCKING)
-		DRM_DEBUG_DRIVER("Docking is not supported (docked)\n");
+		drm_dbg(&dev_priv->drm, "Docking is not supported (docked)\n");
 	else
-		DRM_DEBUG_DRIVER("Docking is not supported (undocked)\n");
+		drm_dbg(&dev_priv->drm,
+			"Docking is not supported (undocked)\n");
 
 	return ASLC_DOCKING_FAILED;
 }
 
 static u32 asle_isct_state(struct drm_i915_private *dev_priv)
 {
-	DRM_DEBUG_DRIVER("ISCT is not supported\n");
+	drm_dbg(&dev_priv->drm, "ISCT is not supported\n");
 	return ASLC_ISCT_STATE_FAILED;
 }
 
@@ -569,8 +580,8 @@ static void asle_work(struct work_struct *work)
 	aslc_req = asle->aslc;
 
 	if (!(aslc_req & ASLC_REQ_MSK)) {
-		DRM_DEBUG_DRIVER("No request on ASLC interrupt 0x%08x\n",
-				 aslc_req);
+		drm_dbg(&dev_priv->drm,
+			"No request on ASLC interrupt 0x%08x\n", aslc_req);
 		return;
 	}
 
@@ -739,11 +750,12 @@ static void intel_didl_outputs(struct drm_i915_private *dev_priv)
 	}
 	drm_connector_list_iter_end(&conn_iter);
 
-	DRM_DEBUG_KMS("%d outputs detected\n", i);
+	drm_dbg_kms(&dev_priv->drm, "%d outputs detected\n", i);
 
 	if (i > max_outputs)
-		DRM_ERROR("More than %d outputs in connector list\n",
-			  max_outputs);
+		drm_err(&dev_priv->drm,
+			"More than %d outputs in connector list\n",
+			max_outputs);
 
 	/* If fewer than max outputs, the list must be null terminated */
 	if (i < max_outputs)
@@ -823,7 +835,9 @@ static void swsci_setup(struct drm_i915_private *dev_priv)
 		if (requested_callbacks) {
 			u32 req = opregion->swsci_sbcb_sub_functions;
 			if ((req & tmp) != req)
-				DRM_DEBUG_DRIVER("SWSCI BIOS requested (%08x) SBCB callbacks that are not supported (%08x)\n", req, tmp);
+				drm_dbg(&dev_priv->drm,
+					"SWSCI BIOS requested (%08x) SBCB callbacks that are not supported (%08x)\n",
+					req, tmp);
 			/* XXX: for now, trust the requested callbacks */
 			/* opregion->swsci_sbcb_sub_functions &= tmp; */
 		} else {
@@ -831,9 +845,10 @@ static void swsci_setup(struct drm_i915_private *dev_priv)
 		}
 	}
 
-	DRM_DEBUG_DRIVER("SWSCI GBDA callbacks %08x, SBCB callbacks %08x\n",
-			 opregion->swsci_gbda_sub_functions,
-			 opregion->swsci_sbcb_sub_functions);
+	drm_dbg(&dev_priv->drm,
+		"SWSCI GBDA callbacks %08x, SBCB callbacks %08x\n",
+		opregion->swsci_gbda_sub_functions,
+		opregion->swsci_sbcb_sub_functions);
 }
 
 static int intel_no_opregion_vbt_callback(const struct dmi_system_id *id)
@@ -867,15 +882,17 @@ static int intel_load_vbt_firmware(struct drm_i915_private *dev_priv)
 
 	ret = request_firmware(&fw, name, &dev_priv->drm.pdev->dev);
 	if (ret) {
-		DRM_ERROR("Requesting VBT firmware \"%s\" failed (%d)\n",
-			  name, ret);
+		drm_err(&dev_priv->drm,
+			"Requesting VBT firmware \"%s\" failed (%d)\n",
+			name, ret);
 		return ret;
 	}
 
 	if (intel_bios_is_valid_vbt(fw->data, fw->size)) {
 		opregion->vbt_firmware = kmemdup(fw->data, fw->size, GFP_KERNEL);
 		if (opregion->vbt_firmware) {
-			DRM_DEBUG_KMS("Found valid VBT firmware \"%s\"\n", name);
+			drm_dbg_kms(&dev_priv->drm,
+				    "Found valid VBT firmware \"%s\"\n", name);
 			opregion->vbt = opregion->vbt_firmware;
 			opregion->vbt_size = fw->size;
 			ret = 0;
@@ -883,7 +900,8 @@ static int intel_load_vbt_firmware(struct drm_i915_private *dev_priv)
 			ret = -ENOMEM;
 		}
 	} else {
-		DRM_DEBUG_KMS("Invalid VBT firmware \"%s\"\n", name);
+		drm_dbg_kms(&dev_priv->drm, "Invalid VBT firmware \"%s\"\n",
+			    name);
 		ret = -EINVAL;
 	}
 
@@ -910,9 +928,10 @@ int intel_opregion_setup(struct drm_i915_private *dev_priv)
 	BUILD_BUG_ON(sizeof(struct opregion_asle_ext) != 0x400);
 
 	pci_read_config_dword(pdev, ASLS, &asls);
-	DRM_DEBUG_DRIVER("graphic opregion physical addr: 0x%x\n", asls);
+	drm_dbg(&dev_priv->drm, "graphic opregion physical addr: 0x%x\n",
+		asls);
 	if (asls == 0) {
-		DRM_DEBUG_DRIVER("ACPI OpRegion not supported!\n");
+		drm_dbg(&dev_priv->drm, "ACPI OpRegion not supported!\n");
 		return -ENOTSUPP;
 	}
 
@@ -925,21 +944,21 @@ int intel_opregion_setup(struct drm_i915_private *dev_priv)
 	memcpy(buf, base, sizeof(buf));
 
 	if (memcmp(buf, OPREGION_SIGNATURE, 16)) {
-		DRM_DEBUG_DRIVER("opregion signature mismatch\n");
+		drm_dbg(&dev_priv->drm, "opregion signature mismatch\n");
 		err = -EINVAL;
 		goto err_out;
 	}
 	opregion->header = base;
 	opregion->lid_state = base + ACPI_CLID;
 
-	DRM_DEBUG_DRIVER("ACPI OpRegion version %u.%u.%u\n",
-			 opregion->header->over.major,
-			 opregion->header->over.minor,
-			 opregion->header->over.revision);
+	drm_dbg(&dev_priv->drm, "ACPI OpRegion version %u.%u.%u\n",
+		opregion->header->over.major,
+		opregion->header->over.minor,
+		opregion->header->over.revision);
 
 	mboxes = opregion->header->mboxes;
 	if (mboxes & MBOX_ACPI) {
-		DRM_DEBUG_DRIVER("Public ACPI methods supported\n");
+		drm_dbg(&dev_priv->drm, "Public ACPI methods supported\n");
 		opregion->acpi = base + OPREGION_ACPI_OFFSET;
 		/*
 		 * Indicate we handle monitor hotplug events ourselves so we do
@@ -951,20 +970,20 @@ int intel_opregion_setup(struct drm_i915_private *dev_priv)
 	}
 
 	if (mboxes & MBOX_SWSCI) {
-		DRM_DEBUG_DRIVER("SWSCI supported\n");
+		drm_dbg(&dev_priv->drm, "SWSCI supported\n");
 		opregion->swsci = base + OPREGION_SWSCI_OFFSET;
 		swsci_setup(dev_priv);
 	}
 
 	if (mboxes & MBOX_ASLE) {
-		DRM_DEBUG_DRIVER("ASLE supported\n");
+		drm_dbg(&dev_priv->drm, "ASLE supported\n");
 		opregion->asle = base + OPREGION_ASLE_OFFSET;
 
 		opregion->asle->ardy = ASLE_ARDY_NOT_READY;
 	}
 
 	if (mboxes & MBOX_ASLE_EXT)
-		DRM_DEBUG_DRIVER("ASLE extension supported\n");
+		drm_dbg(&dev_priv->drm, "ASLE extension supported\n");
 
 	if (intel_load_vbt_firmware(dev_priv) == 0)
 		goto out;
@@ -995,12 +1014,14 @@ int intel_opregion_setup(struct drm_i915_private *dev_priv)
 		vbt = opregion->rvda;
 		vbt_size = opregion->asle->rvds;
 		if (intel_bios_is_valid_vbt(vbt, vbt_size)) {
-			DRM_DEBUG_KMS("Found valid VBT in ACPI OpRegion (RVDA)\n");
+			drm_dbg_kms(&dev_priv->drm,
+				    "Found valid VBT in ACPI OpRegion (RVDA)\n");
 			opregion->vbt = vbt;
 			opregion->vbt_size = vbt_size;
 			goto out;
 		} else {
-			DRM_DEBUG_KMS("Invalid VBT in ACPI OpRegion (RVDA)\n");
+			drm_dbg_kms(&dev_priv->drm,
+				    "Invalid VBT in ACPI OpRegion (RVDA)\n");
 			memunmap(opregion->rvda);
 			opregion->rvda = NULL;
 		}
@@ -1018,11 +1039,13 @@ int intel_opregion_setup(struct drm_i915_private *dev_priv)
 		OPREGION_ASLE_EXT_OFFSET : OPREGION_SIZE;
 	vbt_size -= OPREGION_VBT_OFFSET;
 	if (intel_bios_is_valid_vbt(vbt, vbt_size)) {
-		DRM_DEBUG_KMS("Found valid VBT in ACPI OpRegion (Mailbox #4)\n");
+		drm_dbg_kms(&dev_priv->drm,
+			    "Found valid VBT in ACPI OpRegion (Mailbox #4)\n");
 		opregion->vbt = vbt;
 		opregion->vbt_size = vbt_size;
 	} else {
-		DRM_DEBUG_KMS("Invalid VBT in ACPI OpRegion (Mailbox #4)\n");
+		drm_dbg_kms(&dev_priv->drm,
+			    "Invalid VBT in ACPI OpRegion (Mailbox #4)\n");
 	}
 
 out:
@@ -1058,20 +1081,22 @@ intel_opregion_get_panel_type(struct drm_i915_private *dev_priv)
 
 	ret = swsci(dev_priv, SWSCI_GBDA_PANEL_DETAILS, 0x0, &panel_details);
 	if (ret) {
-		DRM_DEBUG_KMS("Failed to get panel details from OpRegion (%d)\n",
-			      ret);
+		drm_dbg_kms(&dev_priv->drm,
+			    "Failed to get panel details from OpRegion (%d)\n",
+			    ret);
 		return ret;
 	}
 
 	ret = (panel_details >> 8) & 0xff;
 	if (ret > 0x10) {
-		DRM_DEBUG_KMS("Invalid OpRegion panel type 0x%x\n", ret);
+		drm_dbg_kms(&dev_priv->drm,
+			    "Invalid OpRegion panel type 0x%x\n", ret);
 		return -EINVAL;
 	}
 
 	/* fall back to VBT panel type? */
 	if (ret == 0x0) {
-		DRM_DEBUG_KMS("No panel type in OpRegion\n");
+		drm_dbg_kms(&dev_priv->drm, "No panel type in OpRegion\n");
 		return -ENODEV;
 	}
 
@@ -1081,7 +1106,8 @@ intel_opregion_get_panel_type(struct drm_i915_private *dev_priv)
 	 * via a quirk list :(
 	 */
 	if (!dmi_check_system(intel_use_opregion_panel_type)) {
-		DRM_DEBUG_KMS("Ignoring OpRegion panel type (%d)\n", ret - 1);
+		drm_dbg_kms(&dev_priv->drm,
+			    "Ignoring OpRegion panel type (%d)\n", ret - 1);
 		return -ENODEV;
 	}
 
-- 
2.25.0

