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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7479C35246
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 08:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C82020CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 08:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDueHcms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbgA3Icr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 03:32:47 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40810 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbgA3Icq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 03:32:46 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so3134219wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 00:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vj+vPdCuY/CAQ3aMiPYuTj5faykMsBgab7cIAMUBapk=;
        b=SDueHcmsBoNCzvLdtvygZ2/A8Ol97TSnN+xBWJPawn1gdPn6Dp1KTt43HpXKkdjRQX
         oxi9B+H6AfB7pCov2SqulibR9wZvfyPI2z4MBPfMXgYN0lxGGPuk7jNgWAqJ9B7rVeh3
         kIubHQ8+rNLpoLYo/biLSF7Bkx544v2D3SmwhwOZsuThPb0b32SlKOO/IQ8LLzYmU2z+
         Vv3IyyjDrLVjj+4T1VI6c8SAIfheviu5Fz5Tkbn9aZzdWwzyi86ALYiqWdKbEwP8YUOA
         ZwhaDwbBsDnLLHjdly9Hgdn2NoyiWB9/39LTK4TQZwUOqXeKlRPwAG85oK0xZVVUEA6c
         H53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vj+vPdCuY/CAQ3aMiPYuTj5faykMsBgab7cIAMUBapk=;
        b=kxAaNj+/5OwpFGdbCzNC+MxMEIBSS2EU9cKMQQ3l8Ma+DUy/SSwFu2tUB3vDMVb3nC
         njQzd6aExYAAQmZoDakHCW0sWBd8be19/T+qrEMay1wG+VHsbo/AaWrsZX2UaZmIVwTP
         1qU64U0VeS9gdW8BVu9oogBWHBC4BHpZ4BPmjrTTRs6hfRHMXWDXlVEJKlOD8ZijkNBH
         J53jgae9Kc4ugk8mSZAd+WebQ7s248XfMV3bP+tBAR6JoAuPkq/7Nc2w0tKlZn3KxjyX
         horzXoaskk5VqSwrnQlTouMhPqeig4wTUCViTcvioYVE4E6l6EgnYqm0gRHWEp/HjuvN
         Mj1g==
X-Gm-Message-State: APjAAAXfyqZdPY64+taRTl8sPCLyvYcJAcvwdWFn5s9jsb9u+JDnXxPI
        fECqrObOFpvUYFFoZRaGgMA=
X-Google-Smtp-Source: APXvYqxAahDEhEt1uYDy+1mDAT1sYhKkpzFB0Bq/xaiQbnNvYABUZ7D+M2XdSEWu1u+KX2ULjR9J8w==
X-Received: by 2002:a1c:9dcb:: with SMTP id g194mr4030315wme.53.1580373165030;
        Thu, 30 Jan 2020 00:32:45 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id i11sm6363678wrs.10.2020.01.30.00.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 00:32:44 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] drm/i915/vga: conversion to drm_device based logging macros.
Date:   Thu, 30 Jan 2020 11:32:20 +0300
Message-Id: <20200130083229.12889-4-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130083229.12889-1-wambui.karugax@gmail.com>
References: <20200130083229.12889-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts the printk based logging macros to the struct drm_device based
logging macros in i915/display/intel_vga.c using the following
coccinelle script that matches based on the existence of a
drm_i915_private device pointer:
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
 drivers/gpu/drm/i915/display/intel_vga.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_vga.c b/drivers/gpu/drm/i915/display/intel_vga.c
index 7eb23f623661..be333699c515 100644
--- a/drivers/gpu/drm/i915/display/intel_vga.c
+++ b/drivers/gpu/drm/i915/display/intel_vga.c
@@ -46,7 +46,8 @@ void intel_vga_redisable_power_on(struct drm_i915_private *dev_priv)
 	i915_reg_t vga_reg = intel_vga_cntrl_reg(dev_priv);
 
 	if (!(intel_de_read(dev_priv, vga_reg) & VGA_DISP_DISABLE)) {
-		DRM_DEBUG_KMS("Something enabled VGA plane, disabling it\n");
+		drm_dbg_kms(&dev_priv->drm,
+			    "Something enabled VGA plane, disabling it\n");
 		intel_vga_disable(dev_priv);
 	}
 }
@@ -99,7 +100,7 @@ intel_vga_set_state(struct drm_i915_private *i915, bool enable_decode)
 	u16 gmch_ctrl;
 
 	if (pci_read_config_word(i915->bridge_dev, reg, &gmch_ctrl)) {
-		DRM_ERROR("failed to read control word\n");
+		drm_err(&i915->drm, "failed to read control word\n");
 		return -EIO;
 	}
 
@@ -112,7 +113,7 @@ intel_vga_set_state(struct drm_i915_private *i915, bool enable_decode)
 		gmch_ctrl |= INTEL_GMCH_VGA_DISABLE;
 
 	if (pci_write_config_word(i915->bridge_dev, reg, gmch_ctrl)) {
-		DRM_ERROR("failed to write control word\n");
+		drm_err(&i915->drm, "failed to write control word\n");
 		return -EIO;
 	}
 
-- 
2.25.0

