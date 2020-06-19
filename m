Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78107C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E0A12080D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5la7ei+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgFSDBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 23:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgFSDA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 23:00:58 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CE9C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 20:00:57 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l12so8573187ejn.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 20:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=td2Z3NCASFr+uPNMbTzjmLK02pJ5tD3L8YyRsEoL8qQ=;
        b=o5la7ei+PTqz1iyemhAvSGC/gUX3qUdGb00YAZodXgd3eKc2F/G5G3ptHxTN6aw3Pf
         +YcGnQrbRTZHHQz3qaLZmL2agYBnbxeP2AdYK3pgYtBA9URcxtAWTkPRCME+ioyNoetg
         c1pp19CzvRc35j4VrTS/NYxsU3HW8+gLJLtvemC359MJ6hUsObTW3vpY7Zr2pBeC2NtZ
         PqdpZzTmaqU0M95wcoejCJz1FFfAlQjQwc8EKbMVCg8RGodjHZoMD0re0+X+othF4kxN
         k/moMr58/z52RYSDng8c5ZCot6nf9UPcKPmFLP6XN3QPJ9/UL4bL/djBVy1CsuuyKKyO
         cSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=td2Z3NCASFr+uPNMbTzjmLK02pJ5tD3L8YyRsEoL8qQ=;
        b=PLE7o8XgnMdmvw4+X4Ya2sd7prWQDK/tvrrXwUJj+cLNUXkPIrEJCYlm1dgwFFEiX4
         Q71n+XewknlL9EwB6IKxMvhRVh2KgvTJyUZBDulIGy/Xn+6xzYa53psFkJ/Vk2I/FgkZ
         LVd6JxDFPHS+tmg5kpbvPefdvTLbh5RVyP57mkyeZJ9jvoToEMnl6wGfcwarcYZR5RqN
         2ofYdDW8GL/2oQAimVHhojkg5GHcT7qs2mLMb2/64nyHWnz5oGdte5l3riolHNE0Bod2
         K50OGZLoNT3rIY5t4iIAreG7rJhTYuxEv21ywK6TYNF9oIYZZ7/fYmkXCjdRMECNrSAC
         DwOA==
X-Gm-Message-State: AOAM533jOtkRZZSd/UG9TKMHZ+81BR+jkwOj0pZQoxdaCgrVJzODi+Ap
        2Dbgr/3b8Xk1dSrlIFLXyOpYXc0MiOGqyA6LbZGqa7pUs1k=
X-Google-Smtp-Source: ABdhPJyQfvcrVk9dbVjwqoOkHDEn1mvJzKO4yQfJ3mjG0eojf41zE69EgWWBWelWyWniyZgfm37yM3qJOwthe47jooc=
X-Received: by 2002:a17:906:2507:: with SMTP id i7mr1556624ejb.419.1592535653626;
 Thu, 18 Jun 2020 20:00:53 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 19 Jun 2020 13:00:42 +1000
Message-ID: <CAPM=9tzY6Md_x57APC-u0eWTztTmB1g-78XQk-dFS++7W1DtgQ@mail.gmail.com>
Subject: [git pull] drm fixes for 5.7-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

rc2 fixes, just i915 and amd here, i915 has some workaround movement
so they get applied at the right times, and a timeslicing fix, along
with some display fixes. AMD has a few display floating point fix and
a devcgroup fix for amdkfd.

drm-fixes-2020-06-19:
drm fixes for 5.8-rc2

i915:
- Fix for timeslicing and virtual engines/unpremptable requests
  (+ 1 dependency patch)
- Fixes into TypeC register programming and interrupt storm detecting
- Disable DIP on MST ports with the transcoder clock still on
- Avoid missing GT workarounds at reset for HSW and older gens
- Fix for unwinding multiple requests missing force restore
- Fix encoder type check for DDI vswing sequence
- Build warning fixes

amdgpu:
- Fix kvfree/kfree mixup
- Fix hawaii device id in powertune configuration
- Display FP fixes
- Documentation fixes

amdkfd:
- devcgroup check fix
The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-06-19

for you to fetch changes up to 8a7a3d1d0dcf2bb63dafe7275020420005e13e54:

  Merge tag 'amd-drm-fixes-5.8-2020-06-17' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes (2020-06-19
10:02:30 +1000)

----------------------------------------------------------------
drm fixes for 5.8-rc2

i915:
- Fix for timeslicing and virtual engines/unpremptable requests
  (+ 1 dependency patch)
- Fixes into TypeC register programming and interrupt storm detecting
- Disable DIP on MST ports with the transcoder clock still on
- Avoid missing GT workarounds at reset for HSW and older gens
- Fix for unwinding multiple requests missing force restore
- Fix encoder type check for DDI vswing sequence
- Build warning fixes

amdgpu:
- Fix kvfree/kfree mixup
- Fix hawaii device id in powertune configuration
- Display FP fixes
- Documentation fixes

amdkfd:
- devcgroup check fix

----------------------------------------------------------------
Alex Deucher (2):
      drm/amdgpu/pm: update comment to clarify Overdrive interfaces
      drm/amdgpu: fix documentation around busy_percentage

Arnd Bergmann (2):
      drm/i915/pmu: avoid an maybe-uninitialized warning
      drm/i915: work around false-positive maybe-uninitialized warning

Chris Wilson (10):
      drm/i915/gt: Incorporate the virtual engine into timeslicing
      drm/i915/selftests: Restore to default heartbeat
      drm/i915/gt: Prevent timeslicing into unpreemptable requests
      drm/i915/gt: Incrementally check for rewinding
      drm/i915/gt: Move hsw GT workarounds from init_clock_gating to workarounds
      drm/i915/gt: Move ivb GT workarounds from init_clock_gating to workarounds
      drm/i915/gt: Move vlv GT workarounds from init_clock_gating to workarounds
      drm/i915/gt: Move snb GT workarounds from init_clock_gating to workarounds
      drm/i915/gt: Move ilk GT workarounds from init_clock_gating to workarounds
      drm/i915/gt: Move gen4 GT workarounds from init_clock_gating to
workarounds

Dave Airlie (2):
      Merge tag 'drm-intel-fixes-2020-06-18' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-5.8-2020-06-17' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes

Denis Efremov (2):
      drm/amd/display: Use kvfree() to free coeff in build_regamma()
      drm/amd/display: Use kfree() to free rgb_user in
calculate_user_regamma_ramp()

Imre Deak (2):
      drm/i915/icl: Disable DIP on MST ports with the transcoder clock still on
      drm/i915/icl+: Fix hotplug interrupt disabling after storm detection

Khaled Almahallawy (1):
      drm/i915/tc: fix the reset of ln0

Lorenz Brun (1):
      drm/amdkfd: Use correct major in devcgroup check

Rodrigo Siqueira (1):
      drm/amd/display: Rework dsc to isolate FPU operations

Sandeep Raghuraman (1):
      drm/amdgpu: Replace invalid device ID with a valid device ID

Vandita Kulkarni (1):
      drm/i915/display: Fix the encoder type check

 Documentation/gpu/amdgpu.rst                       |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   3 +-
 drivers/gpu/drm/amd/display/dc/dsc/Makefile        |   2 -
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c        |  18 +-
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c       | 151 ++++++++++++-
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h       |   5 +-
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c   |  27 +--
 .../drm/amd/display/modules/color/color_gamma.c    |   4 +-
 drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c   |   2 +-
 drivers/gpu/drm/i915/display/intel_ddi.c           |  12 +-
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |   8 +
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          |   4 +-
 drivers/gpu/drm/i915/gt/intel_lrc.c                |  52 ++++-
 drivers/gpu/drm/i915/gt/intel_ring.c               |   4 +
 drivers/gpu/drm/i915/gt/intel_workarounds.c        | 241 +++++++++++++++++++++
 drivers/gpu/drm/i915/gt/selftest_hangcheck.c       |  25 +--
 drivers/gpu/drm/i915/gt/selftest_lrc.c             | 185 ++++++++++++----
 drivers/gpu/drm/i915/gt/selftest_mocs.c            |  18 +-
 drivers/gpu/drm/i915/gt/selftest_ring.c            | 110 ++++++++++
 drivers/gpu/drm/i915/gt/selftest_rps.c             |  69 +++---
 drivers/gpu/drm/i915/gt/selftest_timeline.c        |  15 +-
 drivers/gpu/drm/i915/gt/selftest_workarounds.c     |   2 +
 drivers/gpu/drm/i915/i915_irq.c                    |   1 +
 drivers/gpu/drm/i915/i915_pmu.c                    |  84 +++----
 drivers/gpu/drm/i915/i915_priolist_types.h         |   2 +-
 drivers/gpu/drm/i915/i915_reg.h                    |   2 +-
 drivers/gpu/drm/i915/intel_pm.c                    | 206 +-----------------
 .../gpu/drm/i915/selftests/i915_mock_selftests.h   |   1 +
 29 files changed, 834 insertions(+), 432 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/gt/selftest_ring.c
