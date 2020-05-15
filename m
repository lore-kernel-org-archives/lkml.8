Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF49C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 06:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B292F2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 06:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3L79/Vs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgEOGNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 02:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726224AbgEOGNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 02:13:05 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2472C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 23:13:04 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l21so1285716eji.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 23:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=WGpH8vzYA2O2asAL93/5EGlm3UBsxHh1y17bTCGAJjE=;
        b=l3L79/VsnlZ8sPU/zFdRtqgt2aYRl+HDoUU86XJvies49Zb9O3HO3or+T/pTlE4c69
         uqevseBJGdmHxg2HjDIgXrQLqK9pfcFB14ohQy1gzp60H+bXxAdyVD35vydshQYtJes3
         SkA2tKDHfXsI+C2uusfGi8Z8iPbA6VI2mctIJm7AwlECqDP5TkPbyEhb8i9+skP4stdH
         Nnod7r8CdPGOIMRyEAZsDXqLAeQUOZ7XrpIwChV5jCJr7olbzWI1lEs6tQNlkIoXHTff
         oDBu1ZwkFySKO/44c62dUDhJJ8qgrGbhdQ3iV+fslLnt5ZCDh2CtxAP+M1iSHtEcSe3d
         TmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=WGpH8vzYA2O2asAL93/5EGlm3UBsxHh1y17bTCGAJjE=;
        b=looLJvkcCe25YSeJ22+3/dwMFf9pSQ8gXJe4oJCuzGcnvp2zX7Px/ihNGc1LN0I0mg
         V+x+yLZ0/5TEZ4Pu0D00IIbs843gd0bZlco/8gBovVKascd0Q6XW/KePBNNkV9lziMlh
         XEpM6Y8b2nbnguiXkJ+Luz+X2BYQTtZoohoP3lGmYwp0sFI4dZ+N8QKvIkepmibZDNPz
         lUIA8+6ea2NyUGXQC7CqoBkIhSXXDLBuLC/jr+91PWYn+7EJian3NxB6JtJq1x4UKfOD
         N9W6h0HLsANi86Lj+vXhgf/hzUQcjCiaVHj9VczzT4OGAymGEyD3w2NDr5GHtg54/LbQ
         yKLg==
X-Gm-Message-State: AOAM5333SbiK4enKrEjF8SoK6nR3tk0kSJ7BNVqCWHbRexXZIZOHCAR5
        j5PumPIEMebfnQqdSVsDactpg78oYHIh+1I4S0A=
X-Google-Smtp-Source: ABdhPJzGJTdI4zuEEvgmk1kXIUqd31ishDRWRj+/eoYTa1TlR5Qa46NQN5UWJoATVF/Y9rUTN/1ptG4ZaITCkWy7Lk8=
X-Received: by 2002:a17:907:41dd:: with SMTP id og21mr1283292ejb.368.1589523183144;
 Thu, 14 May 2020 23:13:03 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 15 May 2020 16:12:52 +1000
Message-ID: <CAPM=9tx=si98hr3_MvAviRZ6LZMUFnFOJBFBk+Lpj3aLQz5M6A@mail.gmail.com>
Subject: [git pull] drm fixes for 5.7-rc6
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

As mentioned last week an i915 PR came in late, but I left it, so the
i915 bits of this cover 2 weeks, which is why it's likely a bit larger
than usual. Otherwise it's mostly amdgpu fixes, one tegra fix, one
meson fix.

Regards,
Dave.

drm-fixes-2020-05-15:
drm fixes for v5.7-rc6

i915 (two weeks):
- Handle idling during i915_gem_evict_something busy loops (Chris)
- Mark current submissions with a weak-dependency (Chris)
- Propagate error from completed fences (Chris)
- Fixes on execlist to avoid GPU hang situation (Chris)
- Fixes couple deadlocks (Chris)
- Timeslice preemption fixes (Chris)
- Fix Display Port interrupt handling on Tiger Lake (Imre)
- Reduce debug noise around Frame Buffer Compression (Peter)
- Fix logic around IPC W/a for Coffee Lake and Kaby Lake (Sultan)
- Avoid dereferencing a dead context (Chris)

tegra:
- tegra120/4 smmu fixes

 amdgpu:
- Clockgating fixes
- Fix fbdev with scatter/gather display
- S4 fix for navi
- Soft recovery for gfx10
- Freesync fixes
- Atomic check cursor fix
- Add a gfxoff quirk
- MST fix

amdkfd:
- Fix GEM reference counting

meson:
- error code propogation fix
The following changes since commit 2ef96a5bb12be62ef75b5828c0aab838ebb29cb8:

  Linux 5.7-rc5 (2020-05-10 15:16:58 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-05-15

for you to fetch changes up to 1d2a1eb13610a9c8ec95f6f1e02cef55000f28e3:

  Merge tag 'drm-misc-fixes-2020-05-14' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2020-05-15
16:00:57 +1000)

----------------------------------------------------------------
drm fixes for v5.7-rc6

i915 (two weeks):
- Handle idling during i915_gem_evict_something busy loops (Chris)
- Mark current submissions with a weak-dependency (Chris)
- Propagate error from completed fences (Chris)
- Fixes on execlist to avoid GPU hang situation (Chris)
- Fixes couple deadlocks (Chris)
- Timeslice preemption fixes (Chris)
- Fix Display Port interrupt handling on Tiger Lake (Imre)
- Reduce debug noise around Frame Buffer Compression (Peter)
- Fix logic around IPC W/a for Coffee Lake and Kaby Lake (Sultan)
- Avoid dereferencing a dead context (Chris)

tegra:
- tegra120/4 smmu fixes

 amdgpu:
- Clockgating fixes
- Fix fbdev with scatter/gather display
- S4 fix for navi
- Soft recovery for gfx10
- Freesync fixes
- Atomic check cursor fix
- Add a gfxoff quirk
- MST fix

amdkfd:
- Fix GEM reference counting

meson:
- error code propogation fix

----------------------------------------------------------------
Alex Deucher (2):
      drm/amdgpu: force fbdev into vram
      drm/amdgpu: implement soft_recovery for gfx10

Bernard Zhao (1):
      drm/meson: pm resume add return errno branch

Chris Wilson (10):
      drm/i915: Avoid dereferencing a dead context
      drm/i915/gt: Make timeslicing an explicit engine property
      drm/i915: Check current i915_vma.pin_count status first on unbind
      drm/i915/gt: Yield the timeslice if caught waiting on a user semaphore
      drm/i915/gem: Remove object_is_locked assertion from
unpin_from_display_plane
      drm/i915/execlists: Avoid reusing the same logical CCID
      drm/i915/execlists: Track inflight CCID
      drm/i915: Propagate error from completed fences
      drm/i915: Mark concurrent submissions with a weak-dependency
      drm/i915: Handle idling during i915_gem_evict_something busy loops

Colin Xu (1):
      drm/i915/gvt: Init DPLL/DDI vreg for virtual display instead of
inheritance.

Dave Airlie (5):
      Merge tag 'drm-intel-fixes-2020-05-07' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm/tegra/for-5.7-fixes' of
git://anongit.freedesktop.org/tegra/linux into drm-fixes
      Merge tag 'amd-drm-fixes-5.7-2020-05-13' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2020-05-13-1' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-misc-fixes-2020-05-14' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Evan Quan (4):
      drm/amdgpu: disable MGCG/MGLS also on gfx CG ungate
      drm/amdgpu: drop unnecessary cancel_delayed_work_sync on PG ungate
      drm/amd/powerplay: perform PG ungate prior to CG ungate
      drm/amdgpu: enable hibernate support on Navi1X

Felix Kuehling (1):
      drm/amdgpu: Use GEM obj reference for KFD BOs

Imre Deak (1):
      drm/i915/tgl+: Fix interrupt handling for DP AUX transactions

Leo (Hanghong) Ma (1):
      drm/amd/amdgpu: Update update_config() logic

Nicholas Kazlauskas (1):
      drm/amd/display: Fix vblank and pageflip event handling for FreeSync

Peter Jones (1):
      Make the "Reducing compressed framebufer size" message be DRM_INFO_ONCE()

Rodrigo Vivi (1):
      Merge tag 'gvt-fixes-2020-05-12' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Simon Ser (1):
      drm/amd/display: add basic atomic check for cursor plane

Sultan Alsawaf (1):
      drm/i915: Don't enable WaIncreaseLatencyIPCEnabled when IPC is disabled

Thierry Reding (2):
      drm/tegra: Fix SMMU support on Tegra124 and Tegra210
      gpu: host1x: Use SMMU on Tegra124 and Tegra210

Tom St Denis (1):
      drm/amd/amdgpu: add raven1 part to the gfxoff quirk list

Zhenyu Wang (1):
      drm/i915/gvt: Fix kernel oops for 3-level ppgtt guest

 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c             |   3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |  22 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  14 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 163 ++++++++++-----------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |  10 +-
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c      |   6 +-
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         |   8 +-
 drivers/gpu/drm/i915/display/intel_fbc.c           |   3 +-
 drivers/gpu/drm/i915/gem/i915_gem_domain.c         |   7 +-
 drivers/gpu/drm/i915/gt/intel_context_types.h      |   8 +-
 drivers/gpu/drm/i915/gt/intel_engine.h             |   9 --
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          |   6 +
 drivers/gpu/drm/i915/gt/intel_engine_types.h       |  35 ++++-
 drivers/gpu/drm/i915/gt/intel_gt_irq.c             |  15 +-
 drivers/gpu/drm/i915/gt/intel_lrc.c                | 120 ++++++++++-----
 drivers/gpu/drm/i915/gt/selftest_lrc.c             |  34 +++--
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c  |   2 +-
 drivers/gpu/drm/i915/gvt/display.c                 |  49 ++++++-
 drivers/gpu/drm/i915/gvt/scheduler.c               |  10 +-
 drivers/gpu/drm/i915/i915_gem_evict.c              |  26 ++--
 drivers/gpu/drm/i915/i915_gpu_error.c              |  12 +-
 drivers/gpu/drm/i915/i915_irq.c                    |  16 +-
 drivers/gpu/drm/i915/i915_perf.c                   |   6 +-
 drivers/gpu/drm/i915/i915_reg.h                    |   1 +
 drivers/gpu/drm/i915/i915_request.c                |  12 +-
 drivers/gpu/drm/i915/i915_scheduler.c              |   6 +-
 drivers/gpu/drm/i915/i915_scheduler.h              |   3 +-
 drivers/gpu/drm/i915/i915_scheduler_types.h        |   1 +
 drivers/gpu/drm/i915/i915_vma.c                    |  25 ++--
 drivers/gpu/drm/i915/intel_pm.c                    |   2 +-
 drivers/gpu/drm/i915/selftests/i915_vma.c          |   2 +-
 drivers/gpu/drm/meson/meson_drv.c                  |   4 +-
 drivers/gpu/drm/tegra/drm.c                        |   3 +-
 drivers/gpu/host1x/dev.c                           |  59 +++++++-
 include/linux/host1x.h                             |   3 +
 38 files changed, 439 insertions(+), 274 deletions(-)
