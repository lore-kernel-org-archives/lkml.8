Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD9FC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDCB24672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzvBpaMP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgANJvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 04:51:50 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56250 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgANJvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 04:51:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so12971245wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 01:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aLEvn2Ayn70H2DlRMlH4wB1n/2RUWp9de4kG51hAiWM=;
        b=DzvBpaMP2qYCHMd+YfBzSn4MzVls4/yRDNRs0v+kJgeiL0gnvr8IBkkUKOvtRaF9Y5
         uJSstZ3c2fs8IrsqiJYZvScd4oDnoayzLFFLZfDORJw3qNfEXMwDVKyO5b+1NFUUligK
         MXrhv0oecFfvijVvcWXM9sGMsaqHbk7hwog0rQ3S7opEmZOCOj0EclL9s8XJJ1vxl7+R
         9ubHRzDEenBvDO4zBdc0ld7y+ij7ZlfB6ka41iQc0Q/cq4rrLl3KvJ3geB9l81aVf/IH
         dAe6SYVza6RKbm1ejOAaTGSK0z2cI2l52hSjx/fFDKh/NVu6EFVvV1EaWL/GVgJlyMsJ
         DaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aLEvn2Ayn70H2DlRMlH4wB1n/2RUWp9de4kG51hAiWM=;
        b=tzR1uskv/3XtmXmw6lC52YqsThwd2c50NUBogPBazHNYSWjIXfuwEK8JggSsFnBY8G
         PRj33vWd0DcPowzAjEle8We9yH1zQ61rjRtuPfuRUnByDTrbV9PLZcauvvo+Khno04ZM
         gqwXjQ3ZdeBOaQ41NuIO3oNtbtDDzeKujw6MdZXHEo0LuOL1qWcMHwSO2g0dqWrveZHL
         2iFbrtzBFTJ9wK9knRFvAvyuszhN+1v5pQDsjhfd3gvXpwB8N3pZsdwYT38aHcUbF6FQ
         rnpex5qyAmYWsnUZeWgjzZWUMxzHTLC4uQtVZvCFgE1jEKsdf3tgOMhkaqxBlgSBW9qF
         43Ow==
X-Gm-Message-State: APjAAAX+gCXAbDaieBGERXye+DRgCm7m44+vEn9RllMnj4pBPg20sbI0
        HruOA3tK3gR71ytZ523VhW8=
X-Google-Smtp-Source: APXvYqwyWuWTAyJH+tuEviOhQCKon0vWYXH2VG6re00JGO2LD1smug8lZ717yxjmjfCvfNIGKuuEzQ==
X-Received: by 2002:a1c:e108:: with SMTP id y8mr25411938wmg.147.1578995508532;
        Tue, 14 Jan 2020 01:51:48 -0800 (PST)
Received: from localhost.localdomain ([154.70.37.104])
        by smtp.googlemail.com with ESMTPSA id y20sm17454881wmi.25.2020.01.14.01.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 01:51:48 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] drm/i915: conversion to new drm logging macros.
Date:   Tue, 14 Jan 2020 12:51:02 +0300
Message-Id: <20200114095107.21197-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series continues the conversion to the new struct drm_device based
logging macros in drm/i915. These patches were mostly achieved using
coccinelle:
@rule1@
identifier fn, T;
@@

fn(struct drm_i915_private *T,...) {
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
)
...+>
}

Wambui Karuga (5):
  drm/i915/atomic: use new logging macros for debug
  drm/i915/audio: convert to new drm logging macros.
  drm/i915/bios: convert to new drm logging macros.
  drm/i915/bw: convert to new drm_device based logging macros.
  drm/i915/cdclk: use new drm logging macros.

 drivers/gpu/drm/i915/display/intel_atomic_plane.c |   9 +-
 drivers/gpu/drm/i915/display/intel_audio.c    |  71 ++--
 drivers/gpu/drm/i915/display/intel_bios.c     | 357 +++++++++++-------
 drivers/gpu/drm/i915/display/intel_bw.c       |  29 +-
 drivers/gpu/drm/i915/display/intel_cdclk.c    | 109 +++---
 5 files changed, 337 insertions(+), 238 deletions(-)

-- 
2.24.1

