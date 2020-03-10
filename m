Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAC2C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B62320675
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFvOVqT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbgCJNbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:31:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33233 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgCJNba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:31:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id a25so12092348wrd.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n+AaYfOR1wnxBM1UyhiMJATpoI1M1VsyY4kmM1JkCJM=;
        b=sFvOVqT4cituQqCiIE/3IQKTicsxfagkwyO34fOf7aQxw6F57CglO7DZUQFYKQk1fD
         2/1/3kKeVnKiQa26Ed7Hb7MzQ7BgVK/iU2/H4C+AlTsSh0TgbYWRClRp/OSfyRzLTve3
         2vCer/gGbmFEyolW1HyAEGmtCmby8joUH/dKC5j/OHIUBor8h8JayH6iFZBBvt7HOXkS
         zC1LzLn+9TNfhjveh6CBKvfUtk/7vqlyl5fzd5JEHDadQ8goufiHv6JKPA6mv1su+1yI
         nT8GQSnDXqZbsAL8JUDmR3nHFLatEYgWKNYiKFdf3w86EZW0WK/w5b1JWbo7Zh3QU3GP
         pWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n+AaYfOR1wnxBM1UyhiMJATpoI1M1VsyY4kmM1JkCJM=;
        b=eaMaoT5rcLz4UwIVQId02Ak1MnN27CXSLP7JRo0iW6WLvyN0K++M3E4RSXbh9DXbC3
         MZ+SNPUSOVXLHGUfnyYipYySzAYQOnyM/bcKP/MCM3MihH3t0tWEfVfIfr0QiM9B1M+7
         RLHG3bOJx1eWCWxnFbMvV1L4RKSL/F/fv9kEos0a+nD1mUIhrfOETGz8/7XBuEBZIinm
         bXzEpEHjKR5fqA5Ms9MMJcMv4wVNYCIu3l87qiwNL3ABgcEZTHUvc4ilHl6WxuXvmqwI
         8ivnPQ0E/UoJEXX20ZGyoj1ssjJ30aj4b8k5Hu1dVF5RFJ1wrzgdyn6Ek9W53JxEUdbD
         gzCw==
X-Gm-Message-State: ANhLgQ1zWGnlx8EObRSmYlT74E2Zeo0/WS4M8mjXdRLmaubj1bNaJq2W
        KicaBRaXsmVMN9TrEsiHung=
X-Google-Smtp-Source: ADFU+vtIMlTgA2JO19QReP8CAkx20BGfjqLewkecDbptY9AHHaVUrpZfIUTw0mEzQHyqaJ9AmhBAUA==
X-Received: by 2002:adf:f70f:: with SMTP id r15mr27908592wrp.269.1583847087056;
        Tue, 10 Mar 2020 06:31:27 -0700 (PDT)
Received: from localhost.localdomain ([197.248.222.210])
        by smtp.googlemail.com with ESMTPSA id o7sm14047141wrx.60.2020.03.10.06.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:31:25 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 00/17] drm: subsytem-wide debugfs functions refactor
Date:   Tue, 10 Mar 2020 16:31:04 +0300
Message-Id: <20200310133121.27913-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.1
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
drm_driver, debugfs_init() hook to be changed to return void. 

v2: individual driver patches have been converted to have debugfs
functions return 0 instead of void to prevent breaking individual driver
builds.
The last patch then converts the .debugfs_hook() and its users across
all drivers to return void.

Wambui Karuga (17):
  drm/tegra: remove checks for debugfs functions return value
  drm/tilcdc: remove check for return value of debugfs functions.
  drm/v3d: make v3d_debugfs_init() return 0
  drm/vc4: remove check of return value of drm_debugfs functions
  drm/arc: make arcgpu_debugfs_init() return 0.
  drm/arm: make hdlcd_debugfs_init() return 0
  drm/etnaviv: remove check for return value of
    drm_debugfs_create_files()
  drm/msm: remove checks for return value of drm_debugfs_create_files()
  drm/sti: remove use of drm_debugfs functions as return values
  drm/vram-helper: make drm_vram_mm_debugfs_init() return 0
  drm/nouveau: make nouveau_drm_debugfs_init() return 0
  drm/pl111: make pl111_debugfs_init return 0
  drm/omap: remove checks for return value of drm_debugfs functions
  drm/i915: have *_debugfs_init() functions return void.
  drm: make various debugfs_init() functions return 0
  drm/debugfs: remove checks for return value of drm_debugfs functions.
  drm: convert .debugfs_init() hook to return void.

 drivers/gpu/drm/arc/arcpgu_drv.c              |  7 +--
 drivers/gpu/drm/arm/hdlcd_drv.c               |  7 +--
 drivers/gpu/drm/arm/malidp_drv.c              |  3 +-
 drivers/gpu/drm/drm_atomic.c                  |  8 ++--
 drivers/gpu/drm/drm_client.c                  |  8 ++--
 drivers/gpu/drm/drm_crtc_internal.h           |  2 +-
 drivers/gpu/drm/drm_debugfs.c                 | 45 +++++--------------
 drivers/gpu/drm/drm_framebuffer.c             |  8 ++--
 drivers/gpu/drm/drm_gem_vram_helper.c         | 14 ++----
 drivers/gpu/drm/drm_internal.h                |  2 +-
 drivers/gpu/drm/drm_mipi_dbi.c                |  6 +--
 drivers/gpu/drm/etnaviv/etnaviv_drv.c         | 18 ++------
 .../drm/i915/display/intel_display_debugfs.c  |  8 ++--
 .../drm/i915/display/intel_display_debugfs.h  |  4 +-
 drivers/gpu/drm/i915/i915_debugfs.c           |  8 ++--
 drivers/gpu/drm/i915/i915_debugfs.h           |  4 +-
 drivers/gpu/drm/msm/adreno/a5xx_debugfs.c     | 18 +++-----
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h         |  2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c      | 14 ++----
 drivers/gpu/drm/msm/msm_debugfs.c             | 23 +++-------
 drivers/gpu/drm/msm/msm_debugfs.h             |  2 +-
 drivers/gpu/drm/msm/msm_gpu.h                 |  2 +-
 drivers/gpu/drm/nouveau/nouveau_debugfs.c     | 26 +++++------
 drivers/gpu/drm/nouveau/nouveau_debugfs.h     |  8 ++--
 drivers/gpu/drm/omapdrm/omap_debugfs.c        | 29 +++---------
 drivers/gpu/drm/omapdrm/omap_drv.h            |  2 +-
 drivers/gpu/drm/pl111/pl111_debugfs.c         |  8 ++--
 drivers/gpu/drm/pl111/pl111_drm.h             |  2 +-
 drivers/gpu/drm/qxl/qxl_debugfs.c             | 21 +++------
 drivers/gpu/drm/qxl/qxl_drv.h                 | 13 +++---
 drivers/gpu/drm/qxl/qxl_ttm.c                 |  6 +--
 drivers/gpu/drm/sti/sti_compositor.c          |  6 +--
 drivers/gpu/drm/sti/sti_compositor.h          |  4 +-
 drivers/gpu/drm/sti/sti_crtc.c                |  2 +-
 drivers/gpu/drm/sti/sti_cursor.c              | 14 +++---
 drivers/gpu/drm/sti/sti_drv.c                 | 16 ++-----
 drivers/gpu/drm/sti/sti_dvo.c                 | 13 +++---
 drivers/gpu/drm/sti/sti_gdp.c                 |  7 +--
 drivers/gpu/drm/sti/sti_hda.c                 | 13 +++---
 drivers/gpu/drm/sti/sti_hdmi.c                | 13 +++---
 drivers/gpu/drm/sti/sti_hqvdp.c               | 12 ++---
 drivers/gpu/drm/sti/sti_mixer.c               | 10 ++---
 drivers/gpu/drm/sti/sti_mixer.h               |  2 +-
 drivers/gpu/drm/sti/sti_tvout.c               | 13 +++---
 drivers/gpu/drm/sti/sti_vid.c                 |  8 ++--
 drivers/gpu/drm/sti/sti_vid.h                 |  2 +-
 drivers/gpu/drm/tegra/dc.c                    | 11 +----
 drivers/gpu/drm/tegra/drm.c                   |  8 ++--
 drivers/gpu/drm/tegra/dsi.c                   | 11 +----
 drivers/gpu/drm/tegra/hdmi.c                  | 11 +----
 drivers/gpu/drm/tegra/sor.c                   | 11 +----
 drivers/gpu/drm/tilcdc/tilcdc_drv.c           | 17 ++-----
 drivers/gpu/drm/v3d/v3d_debugfs.c             |  8 ++--
 drivers/gpu/drm/v3d/v3d_drv.h                 |  2 +-
 drivers/gpu/drm/vc4/vc4_debugfs.c             | 11 ++---
 drivers/gpu/drm/vc4/vc4_drv.h                 |  2 +-
 drivers/gpu/drm/virtio/virtgpu_debugfs.c      |  3 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h          |  2 +-
 include/drm/drm_client.h                      |  2 +-
 include/drm/drm_debugfs.h                     | 16 +++----
 include/drm/drm_drv.h                         |  2 +-
 include/drm/drm_gem_vram_helper.h             |  2 +-
 include/drm/drm_mipi_dbi.h                    |  2 +-
 63 files changed, 204 insertions(+), 380 deletions(-)

-- 
2.25.1

