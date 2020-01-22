Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F773C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 11:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62FAC24680
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 11:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9jZRoXs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgAVLIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 06:08:52 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35330 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbgAVLIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 06:08:51 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so6726223wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 03:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V/QxijJMYTIJinF8V9bOrqtS4KGLiuqhnFZl4QbyPRY=;
        b=C9jZRoXsUwcqjPQhcoVmI2ElcZew/wsjk3az+5v3copiv8k+v2XIz7toq4RQqSugln
         HhwF3g4wsZe9/R0l0T8VGCCaj1asImY+eskODMV8T7GJhP+ZsmiEvprqlA/vq4IYGKKR
         uOrIFQ0L+he9J72oyZdsaTP7T8YHFewSl8rQXAB9I0iY3QUXoPiTwMIksz+qRznPiJ2e
         WON3VdUuJ1kPjVAvUdZg2riMMtdC3sCRoGJCgQ1zFcIRW92A045ZIC1ssmJvVj46pH+t
         s4iEuVTdSziqcPM8Z01mpu40mIqKpNdxzR3S4lRdot3S9s4juNyN7tuSQKF3A+CfTQ77
         YsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V/QxijJMYTIJinF8V9bOrqtS4KGLiuqhnFZl4QbyPRY=;
        b=cKgGkiGFyD99jQkc+hQcCLIS0ThVTvM6dREzw6Jq6ZGD4UQKPH9cWQH5dxnqwmD31s
         933QTI+lPPWPObW7zezdDMZaLn9vS4+OkM8KP/Zm+S0DMggJ1vDNJTUtbiHWMM1PR9fg
         ThQEowA9ws6roBA7cQpRJE2smRbUMb4OeixWnhWSdtPbqqCqn41PdOCksXT1x3E6oLcP
         MNdaa7ysFkolTaJgyWCqyr88CUqC0RDoDAj4FQUMRBjxq122FGso4UBx/fg5YcVJK9H/
         9/EkgPAhWkkbRxlDeo95bvyrF/xMbTGOmVNXMSpKrsZR+7a4C/NFkvznECHXv5EQXGID
         G6GQ==
X-Gm-Message-State: APjAAAWao+Zdpe47pKdPP3OR+4kUVBSdD8Cyd3bls7EQfST5mNTxY/su
        9/cRkt0Cl2AA9sS1ShFQSWU=
X-Google-Smtp-Source: APXvYqw/hNW4vnUyHCYO86uMFLlBAX3aXktEgSX5uf+c6AQoCxCtN0YNtab8ZCu2YtE4WzbcKOM8qQ==
X-Received: by 2002:a05:600c:30a:: with SMTP id q10mr2446398wmd.84.1579691329918;
        Wed, 22 Jan 2020 03:08:49 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id l3sm52454380wrt.29.2020.01.22.03.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 03:08:49 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] conversion to struct drm_device logging macros.
Date:   Wed, 22 Jan 2020 14:08:38 +0300
Message-Id: <20200122110844.2022-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series continues the ongoing conversion to the new struct
drm_device based logging macros for debug in i915.

v2: address merge conflict in i915/display/intel_dp.c due to newer
changes in file.

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
 drivers/gpu/drm/i915/display/intel_dp.c       | 357 ++++++++++--------
 drivers/gpu/drm/i915/display/intel_hdcp.c     | 138 ++++---
 drivers/gpu/drm/i915/display/intel_opregion.c | 134 ++++---
 6 files changed, 576 insertions(+), 410 deletions(-)

-- 
2.25.0

