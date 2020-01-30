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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D01C35248
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 08:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7A9214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 08:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ja7i3oaH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgA3IdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 03:33:06 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38445 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgA3IdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 03:33:05 -0500
Received: by mail-wm1-f67.google.com with SMTP id a9so3140053wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 00:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kya4/8Wbnv4vmokxOyL0Eup/HYclo1ALmYw9uxIEbi4=;
        b=ja7i3oaH/Ib+llOlQRhEGq0rWhseVyALyTsJoGK+Hu0wRN5KvESZ2dTYTmz18nvJZO
         T6nYs8xgtTdU0xSLPFYESd8Q0Ass35JoBsXvgoXv9RpNmz7AoyNBkd/evqU3gSdPIxE3
         ZHDO/Nis5p2dF4zdeeKa5NjoNPknlfNGCKvUwQ2DrO3zSIGnlHmNNnku7FFGdgy1SLKz
         xIJpChnvmbZ/AB2qT/m6uQ8wooOFvzCrUnEudHpjGapIyhs8rsEJlFiVmwP67o+ONFp0
         vK1QgMTgsMGHvEL9GkGHYVHMafeNigIYVx3LoKaXJvAw9XWwIq+w6OO9YBBNpjztga/K
         xmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kya4/8Wbnv4vmokxOyL0Eup/HYclo1ALmYw9uxIEbi4=;
        b=a0NCIFMxst5CO3ms3XQSiUHbPE1P8PVxahk+oImtJZPwEAyT/IKQPGZHpp/EaoJU8k
         IKHmRJooYwSurn3AtV40LKZhNsPsUZRgxLgq1UiweLiwsBY0qW3TH/AKt8ig1MzwG4L6
         mgH5RQXSL0AvKO/cseYmGGJD/DD9k+lyfispuCy7JaPdTwd35Q2UyetK4aAvGRy1yjMw
         JLtDGq+27gSoj+Ka19fBmAwold2G1e9dWc5B1RQB6SDQgrnSaqdRfNqxwAwUI+yIBUSe
         8emG50WZFj/iN/lKLYl4yVzxAwqr71d1C7K8GefyEJ8xhFtIbBwCwxjlig5H6UZdEQ8O
         9SbA==
X-Gm-Message-State: APjAAAV1C/poE03Z1AC5G2QOmWta3R+wY8s/TTCXzmB/NVk0E5dnnd+s
        2jQkIglnUpdjJUiRbxc3UooTJqaKfSk=
X-Google-Smtp-Source: APXvYqwVmfLosBrDflGQNvPTxxesypnnu1jDu6zu6/cOwfqG6u0gLimLaOoke7eKnvRa7wVVxyKCWA==
X-Received: by 2002:a05:600c:2056:: with SMTP id p22mr3923889wmg.136.1580373182964;
        Thu, 30 Jan 2020 00:33:02 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id i11sm6363678wrs.10.2020.01.30.00.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 00:33:02 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] drm/i915/sdvo: automatic conversion to drm_device based logging macros.
Date:   Thu, 30 Jan 2020 11:32:25 +0300
Message-Id: <20200130083229.12889-9-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130083229.12889-1-wambui.karugax@gmail.com>
References: <20200130083229.12889-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts instances of the printk based drm logging macros to the new
struct drm_device based logging macros in i915/display/intel_sdvo.c
This was done automatically using the following coccinelle script that
matches based on the existence of a drm_i915_private device pointer:
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
 drivers/gpu/drm/i915/display/intel_sdvo.c | 29 +++++++++++++----------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_sdvo.c b/drivers/gpu/drm/i915/display/intel_sdvo.c
index 225b6402718e..4ddb81428cab 100644
--- a/drivers/gpu/drm/i915/display/intel_sdvo.c
+++ b/drivers/gpu/drm/i915/display/intel_sdvo.c
@@ -1477,7 +1477,8 @@ static void intel_sdvo_pre_enable(struct intel_encoder *intel_encoder,
 	else
 		intel_sdvo_get_dtd_from_mode(&output_dtd, mode);
 	if (!intel_sdvo_set_output_timing(intel_sdvo, &output_dtd))
-		DRM_INFO("Setting output timings on %s failed\n",
+		drm_info(&dev_priv->drm,
+			 "Setting output timings on %s failed\n",
 			 SDVO_NAME(intel_sdvo));
 
 	/* Set the input timing to the screen. Assume always input 0. */
@@ -1501,7 +1502,8 @@ static void intel_sdvo_pre_enable(struct intel_encoder *intel_encoder,
 	if (IS_TV(intel_sdvo_connector) || IS_LVDS(intel_sdvo_connector))
 		input_dtd.part2.sdvo_flags = intel_sdvo->dtd_sdvo_flags;
 	if (!intel_sdvo_set_input_timing(intel_sdvo, &input_dtd))
-		DRM_INFO("Setting input timings on %s failed\n",
+		drm_info(&dev_priv->drm,
+			 "Setting input timings on %s failed\n",
 			 SDVO_NAME(intel_sdvo));
 
 	switch (crtc_state->pixel_multiplier) {
@@ -1622,7 +1624,7 @@ static void intel_sdvo_get_config(struct intel_encoder *encoder,
 		 * Some sdvo encoders are not spec compliant and don't
 		 * implement the mandatory get_timings function.
 		 */
-		DRM_DEBUG_DRIVER("failed to retrieve SDVO DTD\n");
+		drm_dbg(&dev_priv->drm, "failed to retrieve SDVO DTD\n");
 		pipe_config->quirks |= PIPE_CONFIG_QUIRK_MODE_SYNC_FLAGS;
 	} else {
 		if (dtd.part2.dtd_flags & DTD_FLAG_HSYNC_POSITIVE)
@@ -1813,8 +1815,9 @@ static void intel_enable_sdvo(struct intel_encoder *encoder,
 	 * a given it the status is a success, we succeeded.
 	 */
 	if (success && !input1) {
-		DRM_DEBUG_KMS("First %s output reported failure to "
-				"sync\n", SDVO_NAME(intel_sdvo));
+		drm_dbg_kms(&dev_priv->drm,
+			    "First %s output reported failure to "
+			    "sync\n", SDVO_NAME(intel_sdvo));
 	}
 
 	if (0)
@@ -2226,8 +2229,8 @@ static void intel_sdvo_get_lvds_modes(struct drm_connector *connector)
 	struct drm_i915_private *dev_priv = to_i915(connector->dev);
 	struct drm_display_mode *newmode;
 
-	DRM_DEBUG_KMS("[CONNECTOR:%d:%s]\n",
-		      connector->base.id, connector->name);
+	drm_dbg_kms(&dev_priv->drm, "[CONNECTOR:%d:%s]\n",
+		    connector->base.id, connector->name);
 
 	/*
 	 * Fetch modes from VBT. For SDVO prefer the VBT mode since some
@@ -3276,8 +3279,9 @@ bool intel_sdvo_init(struct drm_i915_private *dev_priv,
 		u8 byte;
 
 		if (!intel_sdvo_read_byte(intel_sdvo, i, &byte)) {
-			DRM_DEBUG_KMS("No SDVO device found on %s\n",
-				      SDVO_NAME(intel_sdvo));
+			drm_dbg_kms(&dev_priv->drm,
+				    "No SDVO device found on %s\n",
+				    SDVO_NAME(intel_sdvo));
 			goto err;
 		}
 	}
@@ -3300,8 +3304,9 @@ bool intel_sdvo_init(struct drm_i915_private *dev_priv,
 
 	if (intel_sdvo_output_setup(intel_sdvo,
 				    intel_sdvo->caps.output_flags) != true) {
-		DRM_DEBUG_KMS("SDVO output failed to setup on %s\n",
-			      SDVO_NAME(intel_sdvo));
+		drm_dbg_kms(&dev_priv->drm,
+			    "SDVO output failed to setup on %s\n",
+			    SDVO_NAME(intel_sdvo));
 		/* Output_setup can leave behind connectors! */
 		goto err_output;
 	}
@@ -3338,7 +3343,7 @@ bool intel_sdvo_init(struct drm_i915_private *dev_priv,
 						    &intel_sdvo->pixel_clock_max))
 		goto err_output;
 
-	DRM_DEBUG_KMS("%s device VID/DID: %02X:%02X.%02X, "
+	drm_dbg_kms(&dev_priv->drm, "%s device VID/DID: %02X:%02X.%02X, "
 			"clock range %dMHz - %dMHz, "
 			"input 1: %c, input 2: %c, "
 			"output 1: %c, output 2: %c\n",
-- 
2.25.0

