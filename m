Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0014CC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 02:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C523D20848
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 02:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaQ+wcPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgH1Cfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 22:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbgH1Cfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 22:35:33 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD3CC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 19:35:32 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id ay8so958786edb.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 19:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=wKhv052n7ideRkNrdUibHhJ56ASTzeeOANzERkwGRBQ=;
        b=LaQ+wcPitkKw6HLSACAzw9MAk1j5UzunAlVee3rwjpYhL6IPReaHReAyyx5nQf0tdK
         W5iwN6vYt5LXQjFhsNOy7ItAgkjhU6sZY6B8ti1lr/j9kbG1m+WiCjGYJIvmWOZLbTKk
         6ts2LhDDHJLOg8Qc3mpzAwZTppzzEbpWVT99C5gUsbxdIPLMDPTRLaMcYo36A6kWb0f+
         74nFOzPYxOj4KLi6+rYHA13KrChez77OUK+SVYNq6b/wkP36nNbc0H7BAs3vVaSf+Oy+
         gL8EBxQCDl6Z8uezlakaOIZ3FGBjmUkgpX2neIwsJU7MWN17HZwRhJQuvNFPGBk0AdCB
         Z5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=wKhv052n7ideRkNrdUibHhJ56ASTzeeOANzERkwGRBQ=;
        b=g0Ky95AKbbz4sk541AomRfSOyLJrR6+pObZ/KnmcETm5gVPGOxqDhmzLBYKkJ7VfLk
         BTeJqdAkgPRF+1wHmARJANYNfZAoSu75IdTCbHdDmguGfUIn1ekNENrMwzo5p3DvZ8zb
         d2QYeDxeNSBrdxBeZOixpvRYYhBmYhv+c5rww5wMHLTTOTmOLx1QgkZYy0iW9/deszF3
         fSp3B9YwvxBEpTlANpvo3HvuTs3Kayaw1qYHVhZy0lOXExWjkGTSrRZR0w+5xzC3OtBJ
         eJ/C6Yj5GKcYczvXNaacrHO+qIsrVQmvrMe92ESAjuccEKmQ8PgFtcZJw+MzmQqP1g0x
         C7LQ==
X-Gm-Message-State: AOAM53073eAOn98FxelfUqWUyhucmyEhVZsRv6WKCgM6bA44vzOsXNEQ
        Iw0Q2X3xU60d0/moCOsTKSi6dkuznq6YjEZhn34yCBYkQvw=
X-Google-Smtp-Source: ABdhPJzNfnEooASArx2KeMmCdC9bvRxAd203/FdoBKylq+5AcX5DVOhNf6CKdzh+BzVSXYcNYnJdmhWHzUIluqBQV5A=
X-Received: by 2002:aa7:c983:: with SMTP id c3mr22100887edt.383.1598582131344;
 Thu, 27 Aug 2020 19:35:31 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 28 Aug 2020 12:35:20 +1000
Message-ID: <CAPM=9tz1s-Mt7ba-82zMPP8hAmenxBj51QzRAq_=TkD0VLJRKw@mail.gmail.com>
Subject: [git pull] drm fixes for 5.9-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

As expected a bit of an rc3 uptick, amdgpu and msm are the main ones,
one msm patch was from the merge window, but had dependencies and we
dropped it until the other tree had landed. Otherwise it's a couple of
fixes for core, and etnaviv, and single i915, exynos, omap fixes.

I'm still tracking the Sandybridge gpu relocations issue, if we don't
see much movement I might just queue up the reverts. I'll talk to
Daniel next week once he's back from holidays.

Dave.

drm-fixes-2020-08-28:
drm fixes for 5.9-rc3

core:
- Take modeset bkl for legacy drivers.

dp_mst:
- Allow null crtc in dp_mst.

i915:
- Fix command parser desc matching with masks

amdgpu:
- Misc display fixes
- Backlight fixes
- MPO fix for DCN1
- Fixes for Sienna Cichlid
- Fixes for Navy Flounder
- Vega SW CTF fixes
- SMU fix for Raven
- Fix a possible overflow in INFO ioctl
- Gfx10 clockgating fix

msm:
- opp/bw scaling patch followup
- frequency restoring fux
- vblank in atomic commit fix
- dpu modesetting fixes
- fencing fix

etnaviv:
- scheduler interaction fix
- gpu init regression fix

exynos:
- Just drop __iommu annotation to fix sparse warning.

omap:
- locking state fix.
The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bccd:

  Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-08-28

for you to fetch changes up to 2a3f9da32de4616f0104209194e9bd3dfae092c9:

  Merge tag 'drm-intel-fixes-2020-08-27' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2020-08-28
11:02:53 +1000)

----------------------------------------------------------------
drm fixes for 5.9-rc3

core:
- Take modeset bkl for legacy drivers.

dp_mst:
- Allow null crtc in dp_mst.

i915:
- Fix command parser desc matching with masks

amdgpu:
- Misc display fixes
- Backlight fixes
- MPO fix for DCN1
- Fixes for Sienna Cichlid
- Fixes for Navy Flounder
- Vega SW CTF fixes
- SMU fix for Raven
- Fix a possible overflow in INFO ioctl
- Gfx10 clockgating fix

msm:
- opp/bw scaling patch followup
- frequency restoring fux
- vblank in atomic commit fix
- dpu modesetting fixes
- fencing fix

etnaviv:
- scheduler interaction fix
- gpu init regression fix

exynos:
- Just drop __iommu annotation to fix sparse warning.

omap:
- locking state fix.

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu: Fix buffer overflow in INFO ioctl

Alexander Monakov (1):
      drm/amd/display: use correct scale for actual_brightness

Bhawanpreet Lakha (1):
      drm/dp_mst: Don't return error code when crtc is null

Brandon Syu (1):
      drm/amd/display: Keep current gain when ABM disable immediately

Christian Gmeiner (1):
      drm/etnaviv: fix external abort seen on GC600 rev 0x19

Daniel Vetter (1):
      drm/modeset-lock: Take the modeset BKL for legacy drivers

Dave Airlie (6):
      Merge tag 'exynos-drm-fixes-v5.9-rc3' of
git://git.kernel.org/.../daeinki/drm-exynos into drm-fixes
      Merge branch 'etnaviv/fixes' of
https://git.pengutronix.de/git/lst/linux into drm-fixes
      Merge tag 'drm-msm-fixes-2020-08-24' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes
      Merge tag 'amd-drm-fixes-5.9-2020-08-26' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2020-08-26' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2020-08-27' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Dinghao Liu (1):
      drm/amd/display: Fix memleak in amdgpu_dm_mode_config_init

Dmitry Baryshkov (1):
      drm/msm/a6xx: fix gmu start on newer firmware

Evan Quan (4):
      drm/amd/pm: correct Vega10 swctf limit setting
      drm/amd/pm: correct Vega12 swctf limit setting
      drm/amd/pm: correct Vega20 swctf limit setting
      drm/amd/pm: correct the thermal alert temperature limit settings

Furquan Shaikh (1):
      drivers: gpu: amd: Initialize amdgpu_dm_backlight_caps object to
0 in amdgpu_dm_update_backlight_caps

Jaehyun Chung (1):
      drm/amd/display: Revert HDCP disable sequence change

Jiansong Chen (5):
      drm/amd/pm: enable run_btc callback for sienna_cichlid
      drm/amd/pm: set VCN pg per instances
      drm/amdgpu/gfx10: refine mgcg setting
      drm/amdgpu: use MODE1 reset for navy_flounder by default
      drm/amdgpu: disable runtime pm for navy_flounder

Jonathan Marek (1):
      drm/msm/a6xx: fix frequency not always being restored on GMU resume

Kalyan Thota (2):
      drm/msm/dpu: Fix reservation failures in modeset
      drm/msm/dpu: Fix scale params in plane validation

Krishna Manikandan (1):
      drm/msm: add shutdown support for display platform_driver

Lucas Stach (1):
      drm/etnaviv: always start/stop scheduler in timeout processing

Maarten Lankhorst (1):
      Merge tag 'v5.9-rc2' into drm-misc-fixes

Marek Szyprowski (1):
      drm/exynos: gem: Fix sparse warning

Mika Kuoppala (1):
      drm/i915: Fix cmd parser desc matching with masks

Nicholas Kazlauskas (2):
      drm/amd/display: Reject overlay plane configurations in
multi-display scenarios
      drm/amd/powerplay: Fix hardmins not being sent to SMU for RV

Rob Clark (6):
      drm/msm/dpu: fix unitialized variable error
      drm/msm/adreno: fix updating ring fence
      drm/msm/gpu: make ringbuffer readonly
      drm/msm: enable vblank during atomic commits
      drm/msm/a6xx: fix crashdec section name typo
      drm/msm/a6xx: add module param to enable debugbus snapshot

Samson Tam (1):
      drm/amd/display: Fix passive dongle mistaken as active dongle in
EDID emulation

Sharat Masetty (1):
      drm: msm: a6xx: use dev_pm_opp_set_bw to scale DDR

Sung Lee (1):
      drm/amd/display: Send DISPLAY_OFF after power down on boot

Tao Zhou (1):
      drm/amdgpu: add asd fw check before loading asd

Tomi Valkeinen (1):
      drm/omap: fix incorrect lock state

Tong Zhang (1):
      drm/amd/display: should check error using DC_OK

Wayne Lin (1):
      drm/amd/display: Retry AUX write when fail occurs

 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |  5 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |  6 +-
 drivers/gpu/drm/amd/amdgpu/nv.c                    |  1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 93 ++++++++++++----------
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  2 +-
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  | 10 +++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |  3 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |  8 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |  2 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  | 53 +++++++-----
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |  8 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h    |  2 +
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c  |  9 +--
 .../gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c   | 22 ++---
 .../gpu/drm/amd/powerplay/hwmgr/vega12_thermal.c   | 21 ++---
 .../gpu/drm/amd/powerplay/hwmgr/vega20_thermal.c   | 21 ++---
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 11 ++-
 drivers/gpu/drm/drm_atomic_helper.c                |  7 +-
 drivers/gpu/drm/drm_color_mgmt.c                   |  2 +-
 drivers/gpu/drm/drm_crtc.c                         |  4 +-
 drivers/gpu/drm/drm_dp_mst_topology.c              |  4 +-
 drivers/gpu/drm/drm_mode_object.c                  |  4 +-
 drivers/gpu/drm/drm_plane.c                        |  2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c              | 11 ++-
 drivers/gpu/drm/etnaviv/etnaviv_sched.c            | 11 +--
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c          |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_gem.h            |  2 +-
 drivers/gpu/drm/i915/i915_cmd_parser.c             | 14 +++-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              | 38 ++++++---
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c        |  3 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h        |  2 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c         |  4 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |  2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |  2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        | 20 ++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |  4 +-
 drivers/gpu/drm/msm/msm_atomic.c                   | 36 +++++++++
 drivers/gpu/drm/msm/msm_drv.c                      |  8 ++
 drivers/gpu/drm/msm/msm_ringbuffer.c               |  3 +-
 drivers/gpu/drm/omapdrm/omap_crtc.c                |  3 +-
 include/drm/drm_modeset_lock.h                     |  9 ++-
 43 files changed, 310 insertions(+), 169 deletions(-)
