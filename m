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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520E3C35246
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 08:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF0F214DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 08:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIPkwZu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgA3IdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 03:33:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42937 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgA3IdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 03:33:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id k11so2897773wrd.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 00:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+WPQnqUkCy+VyFr3VrFQpuj+AkRk2l9SsKUP05AZ3L0=;
        b=FIPkwZu8JCIdbgvI1vc3UWE/f1zn9iAxWqpx7JiiNG1HvgaGtvvqfDxnUsBdZSViQR
         QlTz1d+BSY7oZ8u3LRavAaLP7nj1v67jatCggGWucdbgGJ9kYC/3c8qRLCkAinzbnSGa
         x5avZuxBMhPkfvVDf4yhMPPEayWjV0o7KuqCFWbqb5RGEMrdq4vBCkZVnn31a6kRIk3s
         AJjWor5Pz24gdaXOrj2JLuiRjZNznl14uARJ9Hu9pGowyBYWv3MFppJbnozLJv2abk/S
         eq68GU/u4qJqNFmac8heKDsqwoHpNxD1KDQ6BRChAkhJ+193/5wgi5Ds6rkffn7jg/8C
         XCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+WPQnqUkCy+VyFr3VrFQpuj+AkRk2l9SsKUP05AZ3L0=;
        b=rzTukMc5XNGL3f4joItCzNaCkB0XnrHlK5USCJWrZ50mLWvQTujTS5QA/lHoHOQYkM
         EMkzQKbAHV2guL2wUlYfS2fW5KTupLAreAVLdRPmZUW613YYAjM17NNGoy7HwEtNCmYK
         XA03Q6jA3lrzVXsH8ggeg8BTE8DUOopQTSCiIVpARdXfWSniqYtcNKB5lYXDBi+fPCuz
         7k4VCgYdzCTdo7Solm7zf6m8cLM3nilYSUsvVw3zEI0+EO9lba/28ePwdai8KzEEEeIn
         l9HztUkc6gX7wi82QgRC0vMxqyPKmXcU8iUj1XyW6GdcTu9b8yuLJEL9HLFOIOOffKq3
         We+g==
X-Gm-Message-State: APjAAAVqsqsT5y6LzvtSSmHpkqARuoBgTVtLCnPxU14yrA6lsN6ye2Jv
        6+Vq/R0CHPhGb4dQxiqQ3SA=
X-Google-Smtp-Source: APXvYqwmDEbkuSNB6WSdMsgLsEj4Q/XOChlh3T7KQ7E9CMbGRoFnc/2t1UFdy/11d/JCh0ek2mP5mQ==
X-Received: by 2002:adf:ec06:: with SMTP id x6mr3828516wrn.335.1580373187394;
        Thu, 30 Jan 2020 00:33:07 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id i11sm6363678wrs.10.2020.01.30.00.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 00:33:06 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] drm/i915/quirks: automatic conversion to drm_device based logging macros.
Date:   Thu, 30 Jan 2020 11:32:26 +0300
Message-Id: <20200130083229.12889-10-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130083229.12889-1-wambui.karugax@gmail.com>
References: <20200130083229.12889-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts instances of the printk based drm logging macros to the struct
drm_device based logging macros in i915/display/intel_quirks.c using the
following coccinelle script that transforms based on the existence of a
struct drm_i915_private device:
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
 drivers/gpu/drm/i915/display/intel_quirks.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
index 399b1542509f..9d235d270dac 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.c
+++ b/drivers/gpu/drm/i915/display/intel_quirks.c
@@ -14,7 +14,7 @@
 static void quirk_ssc_force_disable(struct drm_i915_private *i915)
 {
 	i915->quirks |= QUIRK_LVDS_SSC_DISABLE;
-	DRM_INFO("applying lvds SSC disable quirk\n");
+	drm_info(&i915->drm, "applying lvds SSC disable quirk\n");
 }
 
 /*
@@ -24,14 +24,14 @@ static void quirk_ssc_force_disable(struct drm_i915_private *i915)
 static void quirk_invert_brightness(struct drm_i915_private *i915)
 {
 	i915->quirks |= QUIRK_INVERT_BRIGHTNESS;
-	DRM_INFO("applying inverted panel brightness quirk\n");
+	drm_info(&i915->drm, "applying inverted panel brightness quirk\n");
 }
 
 /* Some VBT's incorrectly indicate no backlight is present */
 static void quirk_backlight_present(struct drm_i915_private *i915)
 {
 	i915->quirks |= QUIRK_BACKLIGHT_PRESENT;
-	DRM_INFO("applying backlight present quirk\n");
+	drm_info(&i915->drm, "applying backlight present quirk\n");
 }
 
 /* Toshiba Satellite P50-C-18C requires T12 delay to be min 800ms
@@ -40,7 +40,7 @@ static void quirk_backlight_present(struct drm_i915_private *i915)
 static void quirk_increase_t12_delay(struct drm_i915_private *i915)
 {
 	i915->quirks |= QUIRK_INCREASE_T12_DELAY;
-	DRM_INFO("Applying T12 delay quirk\n");
+	drm_info(&i915->drm, "Applying T12 delay quirk\n");
 }
 
 /*
@@ -50,7 +50,7 @@ static void quirk_increase_t12_delay(struct drm_i915_private *i915)
 static void quirk_increase_ddi_disabled_time(struct drm_i915_private *i915)
 {
 	i915->quirks |= QUIRK_INCREASE_DDI_DISABLED_TIME;
-	DRM_INFO("Applying Increase DDI Disabled quirk\n");
+	drm_info(&i915->drm, "Applying Increase DDI Disabled quirk\n");
 }
 
 struct intel_quirk {
-- 
2.25.0

