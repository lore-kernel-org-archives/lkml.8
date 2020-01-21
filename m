Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC65FC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 13:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD34E2070C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 13:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKigIhFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgAUNqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 08:46:08 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39804 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgAUNqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 08:46:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so3252428wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 05:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=EMbfMg7Qo+Hm2kXhOfYTm1cW5XDCu6N6YPWoxa4vcrQ=;
        b=lKigIhFYQBVG/pdUJCj+7qUUfX9MHCRFSnlqqHaEd7yU68V1H3o4aV5fjP99tonI1+
         tNbvwZFeaSo6JYpiUP+hX4sukDafouLwtP9prxyOX3hSc4tZzsQltUCDTJfLXRc2EhYP
         yDDQRVqigKk095qrWBPEjXLi8K+AypvaPfb/JdHN6IHZzIctxYOZxkEfNx5MiTssDUnd
         mS7zydpozb/CGAtewQ6iFLQ0tr33ICu1hTGpIMsLLNbc/3k1lq/fETso6VjRdgrabL82
         eLYs3Wqr8h53wRjV9zXFunpzwdejCnFINNoVFnKZxPppKD4xOriJjqIXGi1KLtQsNFnJ
         D8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=EMbfMg7Qo+Hm2kXhOfYTm1cW5XDCu6N6YPWoxa4vcrQ=;
        b=Ii6jrP+FBDm6zcbWk4qX5VL3lMiv2j6u8a+Q4Sx4nji9VX/Np9qtxM2kZbiKVpiAaV
         /c0tdy8s1b/o10C23WOLUi68XPBAVh4wWgatpCnDIoAFQ1Qv1UJk0GArp3F/4ENx8vdv
         vtid5AJvp7JiKi6Yv+HnP3OObjm2JaOY0r2x5/veChsm6BM+e8l4ZIvowr0OyQ+KumN7
         TGtUaVbmWazGTfkcadJk7SEvvr8Q8YoAF7MIApVyAnDP0aApR1CcLVhHnE2D6Pt5pbwP
         abw6h9delpLtBOBopROsDQa8oBrizJLeqxLuqUtL4dGe+C6Jt6oOsUcXoloIVJ4NMeKy
         IgWQ==
X-Gm-Message-State: APjAAAVe4r2yRaWMyQ9tXtaEBNB69inUiP/7/cQu/aTdCfgqp92M12nt
        CDqr+/KdGnS682TEc0wLGsc=
X-Google-Smtp-Source: APXvYqzIYhwGUf9A1lMDd1M8zINx+5WO5H2iFAMczr+QRR6CGgNF4gs3NgEIj9ip8LOBQoNDXJ0y1A==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr5447495wrn.5.1579614366426;
        Tue, 21 Jan 2020 05:46:06 -0800 (PST)
Received: from localhost.localdomain ([197.254.95.38])
        by smtp.googlemail.com with ESMTPSA id x17sm51590093wrt.74.2020.01.21.05.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 05:46:05 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] drm/i915: conversion to new drm logging macros.
Date:   Tue, 21 Jan 2020 16:45:54 +0300
Message-Id: <20200121134559.17355-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series continues the conversion to the new struct drm_device based
logging macros in various files in drm/i915. These patches were
achieved both using coccinelle and manually.

v2: rebase patches onto drm-tip to fix merge conflict in v1 series.

Wambui Karuga (5):
  drm/i915/atomic: use struct drm_device logging macros for debug
  drm/i915/bios: convert to struct drm_device based logging macros.
  drm/i915/audio: convert to new struct drm_device logging macros.
  drm/i915/bw: convert to new drm_device based logging macros.
  drm/i915/cdclk: use new struct drm_device logging macros.

 .../gpu/drm/i915/display/intel_atomic_plane.c |   9 +-
 drivers/gpu/drm/i915/display/intel_audio.c    |  73 ++--
 drivers/gpu/drm/i915/display/intel_bios.c     | 357 +++++++++++-------
 drivers/gpu/drm/i915/display/intel_bw.c       |  29 +-
 drivers/gpu/drm/i915/display/intel_cdclk.c    | 109 +++---
 5 files changed, 339 insertions(+), 238 deletions(-)

-- 
2.17.1

