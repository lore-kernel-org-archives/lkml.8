Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C1AC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778B824692
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmRPvKz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgB0MCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:02:44 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:44682 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgB0MCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:02:44 -0500
Received: by mail-wr1-f43.google.com with SMTP id m16so2955016wrx.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 04:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g/5A+DVjtoaJs1559zHEyKQhyqf9vaTLbkhhN4nOCDM=;
        b=LmRPvKz2CUgXjJCFEXblXBOF1NvXvUrP+djNzDGtVq58AFcaDh45u0NlcKu8Fy0RPc
         R2unLoo70JJjoLejUFugE9/ZBCQvWBYQDgbto29i29LFpqUDBN/++2TBhXUfIMBFZ/al
         kNaATpys4YnqjJ/rs0l08bOmdVQ3+HbIwGLoXG/jkVQApcAnYZnsSHzQuuaO/JCZOd/G
         djK22cJKXR3lYAEdZdvZ9avLYKdV/+L+iSpEpAS7n+MkSdhNBj859AxT41Ehik3gARyc
         K1Nc6+kAJoAlSe39YyF1yKnzy1k8cuTjy3bBZ7aF2jBscKzHGGOMq0m6OBpjAdYLwiVP
         0XYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g/5A+DVjtoaJs1559zHEyKQhyqf9vaTLbkhhN4nOCDM=;
        b=EwqfGXWlHb/gyvRr2VK/29v8IJK8i4kB+lv0IK5RoJCISlpJrBt9vguuTUAweoPlnx
         vvHKUhcAejnnMVST7LtL/NUwube7GyJP1Eszi8WJF4E7hrIrhiwGNecWGUWj+xjjF6ph
         qHUDP13MK6c/hxABJj4OS+GAJ3Ku+ZGydf89rX2FPNoRy9DaAtYbsRlMmuPkHGWHk2zw
         s3d/DCcFSIvp/7Eh1xZNs5sq1JeT9UV+N7v3de0p/i9ZlYdUB3X3F2Bk14tQRPfAy2Wd
         +2DQNnvzAtWIrLy+yp5WMcos5yqxiiOWukIVzxIF2v5DPFUqVOqf93LFYJf1LXhq7x9r
         l/ag==
X-Gm-Message-State: APjAAAXfiGWRPWfE7kF7u0Sg5hANyQi3j0CqV6w+KSLtDWVyGNbxaFaF
        Hqyyh1J1VbngPPmIisQl+MM=
X-Google-Smtp-Source: APXvYqwQL4ocFAs/RYCUaTNRR88WGD+abcDxEJlxGuli1OHbJhXtMyV8Hmp9VIdJ7U76Z2LvEAE1tg==
X-Received: by 2002:adf:a285:: with SMTP id s5mr4837704wra.118.1582804961055;
        Thu, 27 Feb 2020 04:02:41 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id t10sm7655017wru.59.2020.02.27.04.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 04:02:40 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     daniel@ffwll.ch, airlied@linux.ie,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 00/21] drm: subsytem-wide debugfs functions refactor
Date:   Thu, 27 Feb 2020 15:02:11 +0300
Message-Id: <20200227120232.19413-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes work on various debugfs functions both in drm/core
and across various drivers in the subsystem.
Since commit 987d65d01356 (drm: debugfs: make drm_debugfs_create_files()
never fail), drm_debugfs_create_files() does not fail and only returns
zero. This series therefore removes the left over error handling and
checks for its return value across drm drivers.

As a result of these changes, most drm_debugfs functions are converted
to return void in this series. This also enables the
drm_driver,debugfs_init() hook to be changed to return void. 

Wambui Karuga (21):
  drm/debugfs: remove checks for return value of drm_debugfs functions.
  drm: convert the drm_driver.debugfs_init() hook to return void.
  drm: convert drm_debugfs functions to return void
  drm/vram-helper: make drm_vram_mm_debugfs_init() return void
  drm/vc4: remove check of return value of drm_debugfs functions
  drm/arc: make arcpgu_debugfs_init return void
  drm/arm: make hdlcd_debugfs_init() return void
  drm/etnaviv: remove check for return value of drm_debugfs function
  drm/nouveau: remove checks for return value of debugfs functions
  drm/tegra: remove checks for debugfs functions return value
  drm/v3d: make v3d_debugfs_init return void
  drm/msm: remove checks for return value of drm_debugfs functions.
  drm/omapdrm: remove checks for return value of drm_debugfs functions.
  drm/pl111: make pl111_debugfs_init return void
  drm/sti: remove use drm_debugfs functions as return value
  drm/i915: make *_debugfs_register() functions return void.
  drm/tilcdc: remove check for return value of debugfs functions.
  drm/virtio: make virtio_gpu_debugfs() return void.
  drm/mipi_dbi: make midi_dbi_debugfs_init() return void.
  drm/qxl: have debugfs functions return void.
  drm/arm: have malidp_debufs_init() return void

 drivers/gpu/drm/arc/arcpgu_drv.c              |  7 +--
 drivers/gpu/drm/arm/hdlcd_drv.c               |  7 +--
 drivers/gpu/drm/arm/malidp_drv.c              |  3 +-
 drivers/gpu/drm/drm_atomic.c                  |  8 +--
 drivers/gpu/drm/drm_client.c                  |  8 +--
 drivers/gpu/drm/drm_crtc_internal.h           |  2 +-
 drivers/gpu/drm/drm_debugfs.c                 | 49 +++++--------------
 drivers/gpu/drm/drm_framebuffer.c             |  8 +--
 drivers/gpu/drm/drm_gem_vram_helper.c         | 14 ++----
 drivers/gpu/drm/drm_internal.h                |  2 +-
 drivers/gpu/drm/drm_mipi_dbi.c                |  6 +--
 drivers/gpu/drm/etnaviv/etnaviv_drv.c         | 18 ++-----
 .../drm/i915/display/intel_display_debugfs.c  |  8 +--
 .../drm/i915/display/intel_display_debugfs.h  |  4 +-
 drivers/gpu/drm/i915/i915_debugfs.c           |  8 +--
 drivers/gpu/drm/i915/i915_debugfs.h           |  4 +-
 drivers/gpu/drm/msm/adreno/a5xx_debugfs.c     | 18 ++-----
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c      | 14 ++----
 drivers/gpu/drm/msm/msm_debugfs.c             | 21 +++-----
 drivers/gpu/drm/msm/msm_debugfs.h             |  2 +-
 drivers/gpu/drm/msm/msm_gpu.h                 |  2 +-
 drivers/gpu/drm/nouveau/nouveau_debugfs.c     | 26 ++++------
 drivers/gpu/drm/nouveau/nouveau_debugfs.h     |  5 +-
 drivers/gpu/drm/omapdrm/omap_debugfs.c        | 29 +++--------
 drivers/gpu/drm/omapdrm/omap_drv.h            |  2 +-
 drivers/gpu/drm/pl111/pl111_debugfs.c         |  8 +--
 drivers/gpu/drm/pl111/pl111_drm.h             |  2 +-
 drivers/gpu/drm/qxl/qxl_debugfs.c             | 21 +++-----
 drivers/gpu/drm/qxl/qxl_drv.h                 | 13 ++---
 drivers/gpu/drm/qxl/qxl_ttm.c                 |  6 +--
 drivers/gpu/drm/sti/sti_cursor.c              | 14 +++---
 drivers/gpu/drm/sti/sti_drv.c                 | 16 ++----
 drivers/gpu/drm/sti/sti_dvo.c                 | 13 ++---
 drivers/gpu/drm/sti/sti_gdp.c                 |  7 +--
 drivers/gpu/drm/sti/sti_hda.c                 | 13 ++---
 drivers/gpu/drm/sti/sti_hdmi.c                | 13 ++---
 drivers/gpu/drm/sti/sti_hqvdp.c               | 12 +++--
 drivers/gpu/drm/sti/sti_mixer.c               |  7 +--
 drivers/gpu/drm/sti/sti_tvout.c               | 13 ++---
 drivers/gpu/drm/sti/sti_vid.c                 |  8 +--
 drivers/gpu/drm/sti/sti_vid.h                 |  2 +-
 drivers/gpu/drm/tegra/dc.c                    | 11 +----
 drivers/gpu/drm/tegra/drm.c                   |  8 +--
 drivers/gpu/drm/tegra/dsi.c                   | 11 +----
 drivers/gpu/drm/tegra/hdmi.c                  | 11 +----
 drivers/gpu/drm/tegra/sor.c                   | 11 +----
 drivers/gpu/drm/tilcdc/tilcdc_drv.c           | 17 ++-----
 drivers/gpu/drm/v3d/v3d_debugfs.c             |  8 +--
 drivers/gpu/drm/v3d/v3d_drv.h                 |  2 +-
 drivers/gpu/drm/vc4/vc4_debugfs.c             | 11 ++---
 drivers/gpu/drm/vc4/vc4_drv.h                 |  2 +-
 drivers/gpu/drm/virtio/virtgpu_debugfs.c      |  3 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h          |  2 +-
 include/drm/drm_client.h                      |  2 +-
 include/drm/drm_debugfs.h                     |  6 +--
 include/drm/drm_drv.h                         |  2 +-
 include/drm/drm_gem_vram_helper.h             |  2 +-
 include/drm/drm_mipi_dbi.h                    |  2 +-
 58 files changed, 192 insertions(+), 362 deletions(-)

-- 
2.25.0

