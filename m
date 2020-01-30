Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4246C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 08:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A70206D5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 08:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNe7I55/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgA3Ici (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 03:32:38 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:53456 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgA3Ich (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 03:32:37 -0500
Received: by mail-wm1-f50.google.com with SMTP id s10so2772102wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 00:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yE4btNB8EfxUzZqxFyA6oEbNKF4HFpMWZ+vsvZanBPg=;
        b=HNe7I55/5rRr8SyjTzJHXRpJUL6dRGWfNb+HRWVWLxMpgDX4FqSKzzcjy7STlolkxD
         pu5tpHr4B4jrLwlMcSIPtSNS6cGHqinsfJj65smxjqChnCCkdcNSeut9HxYhi4izOnN1
         6LWOG+pdV7MtOZ3wWyKLE9HHzrvk4nVeWqSHzsdRoVs8rESQG/BOGY03sbQpAQGy6Ibs
         6VWDYVI7GQ8Cnh0ug2O4FsimWhdHq4ki5xG7SYyeCos/GopA7+7rSXQGDmIDYUzsS597
         oJKd8PU/tJWmQrUoJOr0qUQpzjy7LnnG8DaBxrtZm/IucmR+n/prYUZGJY9YE3/6+4u8
         y43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yE4btNB8EfxUzZqxFyA6oEbNKF4HFpMWZ+vsvZanBPg=;
        b=nqz21BGSKA7vGQy0pjup70TXLje5DHlFlzLHFHlioxqo4zP6gjIWFm5TG4A0G50hMw
         XwNY/M3HytStZyzDoHvijoZrt+Y8GXtVBWBkCz6Cmm1yM6tck2AXq4HgcHiwNuqd84Fh
         8c3uv+q48PVIz3yvnZt8ZdMO1rnysJZYn3Ec3s0YPrKy2EpDHiIIZeBfsFEOQFP5CFCu
         Fblwy7G0AYLSG528ZUfEEX6f+bnfc5WP/4JvnNvds/TEf8FsS0jXZ94X0SN6qjnPNxC9
         vhGXHZ16xLuA6yjXisOCtoX4pfr1CQ/TULyP9EWOyyHbJhdWfKu6vq/DKNp77FwLbadc
         WsXg==
X-Gm-Message-State: APjAAAUqpOqIR61NNaDuVgSS5AWlOZkPKXlD8aCxlNiATEF0I0EtHhBp
        y1Ih4Qc3f7TjOYT+84MNUxE=
X-Google-Smtp-Source: APXvYqxy3AIofHVFPr2m//HDYIzmTD2loozf5TIXJg9FJJMqCPnU14ZPgW3fLcWsMJwM9OQUjcRL5A==
X-Received: by 2002:a7b:ce98:: with SMTP id q24mr3995609wmj.41.1580373155616;
        Thu, 30 Jan 2020 00:32:35 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id i11sm6363678wrs.10.2020.01.30.00.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 00:32:34 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/12] drm/i915/display: conversion to drm_device based logging macros
Date:   Thu, 30 Jan 2020 11:32:17 +0300
Message-Id: <20200130083229.12889-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series continues the conversion of the printk based logging macros
to the new struct drm_device based logging macros in the drm/i915/display
folder.
This series was achieved using the following coccinelle script
that transforms based on the existence of a struct drm_i915_private
instance in the function:
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


Wambui Karuga (12):
  drm/i915/vlv_dsi_pll: conversion to struct drm_device logging macros.
  drm/i915/vlv_dsi: conversion to drm_device based logging macros.
  drm/i915/vga: conversion to drm_device based logging macros.
  drm/i915/vdsc: convert to struct drm_device based logging macros.
  drm/i915/tv: automatic conversion to drm_device based logging macros.
  drm/i915/tc: automatic conversion to drm_device based logging macros.
  drm/i915/sprite: automatic conversion to drm_device based logging
    macros
  drm/i915/sdvo: automatic conversion to drm_device based logging
    macros.
  drm/i915/quirks: automatic conversion to drm_device based logging
    macros.
  drm/i915/psr: automatic conversion to drm_device based logging macros.
  drm/i915/pipe_crc: automatic conversion to drm_device based logging
    macros.
  drm/i915/panel: automatic conversion to drm_device based logging
    macros.

 drivers/gpu/drm/i915/display/intel_panel.c    | 100 ++++++++------
 drivers/gpu/drm/i915/display/intel_pipe_crc.c |   7 +-
 drivers/gpu/drm/i915/display/intel_psr.c      | 128 +++++++++++-------
 drivers/gpu/drm/i915/display/intel_quirks.c   |  10 +-
 drivers/gpu/drm/i915/display/intel_sdvo.c     |  29 ++--
 drivers/gpu/drm/i915/display/intel_sprite.c   |  60 ++++----
 drivers/gpu/drm/i915/display/intel_tc.c       |  33 +++--
 drivers/gpu/drm/i915/display/intel_tv.c       |  26 ++--
 drivers/gpu/drm/i915/display/intel_vdsc.c     |  28 ++--
 drivers/gpu/drm/i915/display/intel_vga.c      |   7 +-
 drivers/gpu/drm/i915/display/vlv_dsi.c        |  80 ++++++-----
 drivers/gpu/drm/i915/display/vlv_dsi_pll.c    |  47 ++++---
 12 files changed, 322 insertions(+), 233 deletions(-)

-- 
2.25.0

