Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C4BC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 14:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6C924653
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 14:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UawKJfnu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgAUOcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 09:32:04 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:55357 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgAUOcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 09:32:03 -0500
Received: by mail-wm1-f54.google.com with SMTP id q9so3165272wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 06:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=qLpfOk1ZTqYL3sl9pfEhz5Xx/erysYZDRTRJ2cdP8Hs=;
        b=UawKJfnuMSQgmUuHc3aPKzKnMhPeh32MiDDtA1GqSTiPHgrZqlxPPnezQNpJqfH2kO
         qq0AFTkqn9nh5EgVIQ/LuhMo40HGyycLx04fxID+ibRHqomNZkKdRnOktrcwz9bmF1rt
         FM45IuWtshnWJ9wa6goei9ZjsqKlc4iub0sJC8udVzyN+NsnF+SbWBTqG3GbqUOFVxce
         clAq4A5RmVY2WV88UOsowKBgwBkqPAZFFxBeq9QedPjPxFabHXnJW8JoUZaxO2nDzr5n
         VMDZN2NdsGICnukAG7E4EwJSTYfSc41iS3cVZky05MvBM5h6HusiFaKLgQLHqbUiwtJa
         oYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=qLpfOk1ZTqYL3sl9pfEhz5Xx/erysYZDRTRJ2cdP8Hs=;
        b=dIX49qdkPzPkugc0/9DwXg5yaRkR/YfZCk0Xr+fZCpWBp/cx1OrNJ+2U30W0ApS8Tx
         GSCJJdYJWq0niGP1PmBYnlxdpBgNJ3fdxdouxZghXDTCpbEEP1ivtcDVOfnmCoxypPS0
         m2Imw+Ych8ADUzYtB8/eFtje97fvIjKk0v7iR0eWLHs8un1zf9GKfIZLQmMIOYMF7+jq
         a8Em4jgj1WE4oGLv5//n+SX0c3nO6JHWtHgFDxWysyDzpSo9btKZPo1kOUyTMvRciJE0
         7h/PYI6RHBQwrZtHe5c9SR9I7zLKto9Hzyx4waLu1L7ws/8FbkEkcY1+XVGiipavoMc/
         X5Xg==
X-Gm-Message-State: APjAAAWAbFqkvRuehV5oYv5u5pAcj+pXoYPYeijQUJNd967qkKlMvq8m
        2/0TsWMFOQ1Ztfr9xTz9Ays=
X-Google-Smtp-Source: APXvYqykAUt3BlKLSt2mxqLiNoLsqzzasnLDS1vsGFedEPdhJTbCnJ2DtQ7kzs7LImsKq1sqx+9jyA==
X-Received: by 2002:a05:600c:2c53:: with SMTP id r19mr4680841wmg.39.1579617121769;
        Tue, 21 Jan 2020 06:32:01 -0800 (PST)
Received: from localhost.localdomain ([197.254.95.38])
        by smtp.googlemail.com with ESMTPSA id g2sm52781284wrw.76.2020.01.21.06.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 06:32:01 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] conversion to struct drm_device logging macros. 
Date:   Tue, 21 Jan 2020 17:31:49 +0300
Message-Id: <20200121143155.20856-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series continues the ongoing conversion to the new struct
drm_device based logging macros for debug in i915. This series was done
using the coccinelle script:
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

Wambui Karuga (6):
  drm/i915/dsi: conversion to struct drm_device log macros
  drm/i915/ddi: convert to struct drm_device log macros.
  drm/i915/power: convert to struct drm_device macros in
    display/intel_display_power.c
  drm/i915/dp: conversion to struct drm_device logging macros.
  drm/i915/opregion: conversion to struct drm_device logging macros.
  drm/i915/hdcp: conversion to struct drm_device based logging macros

 drivers/gpu/drm/i915/display/icl_dsi.c        |  82 ++--
 drivers/gpu/drm/i915/display/intel_ddi.c      |  98 +++--
 .../drm/i915/display/intel_display_power.c    | 177 +++++----
 drivers/gpu/drm/i915/display/intel_dp.c       | 349 ++++++++++--------
 drivers/gpu/drm/i915/display/intel_hdcp.c     | 138 ++++---
 drivers/gpu/drm/i915/display/intel_opregion.c | 134 ++++---
 6 files changed, 572 insertions(+), 406 deletions(-)

-- 
2.17.1

