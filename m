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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B0DC3524C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 08:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D4D2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 08:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OV0g5ehL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgA3IdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 03:33:19 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46490 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgA3IdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 03:33:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so2851002wrl.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 00:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TsYYlR0H8+3dQ4sHbB6QwaVOLKz9hOJEYsIrLuaV02I=;
        b=OV0g5ehLnpgelN3GOQsCVZjGTwF9RvG8qj9YaJzrgjzLWhmgvhTnjDYvRiy+/mjGBY
         ys1K/H16dPB1rt2dUSxMAr7+kbs28MqWHMlhtlnVmReFa/UFt+d3y2F7fZiRnimRN5WG
         5fdSgegAuFokTU0SlkOSRThamFYGFSCNjBPKhXZ0KF99HE7ZTBMIScCYGBct5HZvtyWc
         vuGzVcAw2NO45gLXJnLf5JigB0aDe56DqQb8/qi/I//y47YVkZHnJ9P5M8mKAKmHZFJN
         OqM45//pyWyU+eC+HwfNGL5WHUR/+1J8OW4i5iFS9cUdfjibxhHxtGrUJbHtZF+Fzkjt
         Z1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TsYYlR0H8+3dQ4sHbB6QwaVOLKz9hOJEYsIrLuaV02I=;
        b=DeGnRmDR2kyqSzm6EvYDKFq9Rj+WppsBwaH5ZyS4MfvmNuQSO4I0dDwFhRChgJozQV
         F0+WIwEj5wRZtiBBf8Z4PE3Z9PcSbM9v00D1Y/3LutdVoiEwrWtKTeYWaWUf0T+RPWWX
         oAjyNPL+KSuW1ekdqgrt06MyrsNL8h8F8zZHTErz4Ple0Oc8DgZzixSOnWlG9z6EGT/o
         NjS2e3lu5GebYt4XDOALR5Ewa4Yu75k4MFtcKgfY9630tMb5YujXzSvW1MFgFHyG4JOP
         xY9uYAtdL5Wiro9oPkppG1tdjuJQA5HeI8y/eDoMqfV1Lw/RxDBHBisHF3jTUITxTVT+
         ON0Q==
X-Gm-Message-State: APjAAAWMYx6msaKzvja3epSyda+DFPk/PEOLbZF2FWhxm7xC4Xu8o173
        i7szQkXnkBLVKAUjkysYKBu24b+zSt0=
X-Google-Smtp-Source: APXvYqyb6oHDc0RH4eeuEhk5mSJhStqPuHMa/1BkAYKP0BO3CO3Bwb8NIYoMxWb2M7IFLWfItwCnrg==
X-Received: by 2002:a5d:4446:: with SMTP id x6mr3977081wrr.312.1580373195006;
        Thu, 30 Jan 2020 00:33:15 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id i11sm6363678wrs.10.2020.01.30.00.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 00:33:14 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] drm/i915/pipe_crc: automatic conversion to drm_device based logging macros.
Date:   Thu, 30 Jan 2020 11:32:28 +0300
Message-Id: <20200130083229.12889-12-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130083229.12889-1-wambui.karugax@gmail.com>
References: <20200130083229.12889-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conversion of various instances of the printk based logging macros to
the new struct drm_device based logging macros in
i915/display/intel_pipe_crc.c using the following coccinelle script that
transforms based on the existence of a drm_i915_private device pointer:
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

Checkpatch warnings were addressed manually.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_pipe_crc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_pipe_crc.c b/drivers/gpu/drm/i915/display/intel_pipe_crc.c
index b83062201212..d071a1604590 100644
--- a/drivers/gpu/drm/i915/display/intel_pipe_crc.c
+++ b/drivers/gpu/drm/i915/display/intel_pipe_crc.c
@@ -570,7 +570,7 @@ int intel_crtc_verify_crc_source(struct drm_crtc *crtc, const char *source_name,
 	enum intel_pipe_crc_source source;
 
 	if (display_crc_ctl_parse_source(source_name, &source) < 0) {
-		DRM_DEBUG_DRIVER("unknown source %s\n", source_name);
+		drm_dbg(&dev_priv->drm, "unknown source %s\n", source_name);
 		return -EINVAL;
 	}
 
@@ -595,14 +595,15 @@ int intel_crtc_set_crc_source(struct drm_crtc *crtc, const char *source_name)
 	bool enable;
 
 	if (display_crc_ctl_parse_source(source_name, &source) < 0) {
-		DRM_DEBUG_DRIVER("unknown source %s\n", source_name);
+		drm_dbg(&dev_priv->drm, "unknown source %s\n", source_name);
 		return -EINVAL;
 	}
 
 	power_domain = POWER_DOMAIN_PIPE(crtc->index);
 	wakeref = intel_display_power_get_if_enabled(dev_priv, power_domain);
 	if (!wakeref) {
-		DRM_DEBUG_KMS("Trying to capture CRC while pipe is off\n");
+		drm_dbg_kms(&dev_priv->drm,
+			    "Trying to capture CRC while pipe is off\n");
 		return -EIO;
 	}
 
-- 
2.25.0

