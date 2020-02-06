Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF78C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BB8214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQq/hvOx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgBFIAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 03:00:24 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:33643 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbgBFIAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 03:00:23 -0500
Received: by mail-wm1-f53.google.com with SMTP id m10so275146wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 00:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=717ULV5tMYcnWVLJbk7js732Mzexo+MAur4TgOs8iIw=;
        b=RQq/hvOxg+pdxsZrU6a4uLbE3Nm58Fg4acFNoy2v7DeWygEJ5MZ92vQwxU3d/QtAlJ
         iBLg4kUa4Qqxsy4+OAGJySeBn0qlR6sVEHEM99VPZerFKTOkTQEJ5ll5nsRQygtT7nHl
         9TBNCcznM3+PEDvQfrX5AK0XtRNOYmxsRJgETI6WGdn/YMkf2yZj2SIUzcnFRPidkFCt
         8HhO721ODV62CQtL+HNEgYhmLbi3pknj2kLA6CK3wuinrXaKdTOZISHhhRyFHajaB9J4
         MBbjzeOFCdGWKS8Udq1dtGrn2WK/6nh2N3eRSzA9gyjan76GHkfPRYeDrZVY/63Ow7bh
         L1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=717ULV5tMYcnWVLJbk7js732Mzexo+MAur4TgOs8iIw=;
        b=YJQy98DSk/0MajgKksoFVUnmF+MFHIHcStPO1N+7FSYG6isiXFqcLb2fy1mRwDicin
         DZVTR3t5e4X1nj4ypJapo6GhPiJn+XgaOtWxMtgFe2wVpD4xlsEa4TMiBeeCnjUnDTbK
         xNrMwijmISUa3pCynLLa7GakoBjcxJw5vViOPxP+d+VaRPCFY8QzVp0bZTYy9EEryU5Z
         hgNBU7Q+QXGLz8tzE4DGq9XWk4J3XQYpT6kfeSVmLvoyS/KVRfpl/+TLWfkLRyPPDoRQ
         zlySf0vBa0Qui6njHJSXyjhPJBpCFM2a2p+PLt+fAHhKINd5lwaJHy53t4NiTaaF7sak
         0Xag==
X-Gm-Message-State: APjAAAWLu1RZgZcS6Iu/dHDMZuYkks3ztjPB6ziQOfkcfUTlii1VRFsu
        w7eGitpHJ6KTii4ccUvpT0A=
X-Google-Smtp-Source: APXvYqy31m7uWMPcQysBuNC6ZxTGwNajoatTfBj26GqLtCkvmbOzXNXHblk4KB9ZVDipy+qoJzlvdQ==
X-Received: by 2002:a1c:1b42:: with SMTP id b63mr2965332wmb.16.1580976021126;
        Thu, 06 Feb 2020 00:00:21 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id u8sm2635132wmm.15.2020.02.06.00.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 00:00:20 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/12] drm/i915/display: convert to drm_device based logging macros.
Date:   Thu,  6 Feb 2020 11:00:01 +0300
Message-Id: <20200206080014.13759-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset continues the conversion of the printk based drm logging
macros in drm/i915 to use the struct drm_device based logging macros.
This series was done both using coccinelle and manually.

v2: rebase onto drm-tip to fix conflicts with new changes in drm/i915.

Wambui Karuga (12):
  drm/i915/dp: convert to struct drm_device based logging macros.
  drm/i915/dp_link_training: convert to drm_device based logging macros.
  drm/i915/atomic: conversion to drm_device based logging macros.
  drm/i915/color: conversion to drm_device based logging macros.
  drm/i915/crt: automatic conversion to drm_device based logging macros.
  drm/i915/dp_aux_backlight: convert to drm_device based logging macros.
  drm/i915/dpll_mgr: convert to drm_device based logging macros.
  drm/i915/combo_phy: convert to struct drm_device logging macros.
  drm/i915/dp_mst: convert to drm_device based logging macros.
  drm/i915/dsi_vbt: convert to drm_device based logging macros.
  drm/i915/hdmi: convert to struct drm_device based logging macros.
  drm/i915/dpio_phy: convert to drm_device based logging macros.

 drivers/gpu/drm/i915/display/intel_atomic.c   |  23 +-
 drivers/gpu/drm/i915/display/intel_color.c    |   3 +-
 .../gpu/drm/i915/display/intel_combo_phy.c    |  23 +-
 drivers/gpu/drm/i915/display/intel_crt.c      |  49 ++-
 drivers/gpu/drm/i915/display/intel_dp.c       | 320 +++++++++++-------
 .../drm/i915/display/intel_dp_aux_backlight.c |  72 ++--
 .../drm/i915/display/intel_dp_link_training.c |  75 ++--
 drivers/gpu/drm/i915/display/intel_dp_mst.c   |  30 +-
 drivers/gpu/drm/i915/display/intel_dpio_phy.c |  28 +-
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c | 254 ++++++++------
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c  | 162 +++++----
 drivers/gpu/drm/i915/display/intel_hdmi.c     | 193 +++++++----
 12 files changed, 754 insertions(+), 478 deletions(-)

-- 
2.25.0

