Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216F6C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 03:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF0D6206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 03:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzhIu2up"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbgFHDQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 23:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbgFHDQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 23:16:13 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D656DC08C5C3
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 20:16:11 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id c35so12181457edf.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 20:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=RwodZOi7o/ywT3/p/CGo5ZiCzBS9j2yDhvmEVdB4jOE=;
        b=rzhIu2upN6pjxcGyVdWzHvnN+sLOJ8FlsX2zxonIMkHiyiJobF7szyhdFblAlBY9LI
         16ZCJMynTlJMDRxPDjh/Nb1si/sqgZ+/Q7W9hHuxPb9dU66t1Gy4yqnj6zkZPF3I4o5L
         z0CI+hOIEr3vfMDqB0AUb/AiK8d2K1v0U3f8YSNU5pVMsmg1i1jOygEDqaNI8pOs7Pph
         Ls7jXJr2YUI46R8O8W84S3cr22XpHTlfy7D4OPz5o2NufudmdpxAwycdyNeZ2K3RvO3X
         pM1l+3qsR4Ws1Hwkn1MNU6PDqOqzRKbPLjVK0nUUg5BCSfxAFO8TT5+Z6qki/hlpjN2Y
         iGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=RwodZOi7o/ywT3/p/CGo5ZiCzBS9j2yDhvmEVdB4jOE=;
        b=QYfLDKqT1r/+mENE8p14rec26zVJmiCjCtk7i13GqWOx97NQDaDXYkIaOmDXqsnyvr
         hv+dCxJAMZRKL33iwQC3oiT+EizTs/PphkrWC43B5yi6hbQGOocIxS612MdVAH7xR/4F
         7J0+FAF8StnNW3KfFpp+UPQauTlrZ3CZwUHOw9hLFZLFtfY/9on/yTrPsNzRL4Im6tOV
         YN9/TZ1nm8lf4XfdeLm1ABiwl0dCBhgxfzTaXGSxSwQnTkLIQnYXXlsP96DeyQyGDLXQ
         cYG87sLckzkNNs8NdjGseWi8qKiQE0A78vjZCtWI+Z1VFM/jqxku1hPXoEIZzNFBNjqf
         5YKw==
X-Gm-Message-State: AOAM531CTe3DwjcYNPYt61+5Vc4tIEEZUgXR7pR9wrwSeE9pu6hVa/1i
        ltUK97dhoiN2EWhHrkgVtMlqapL96yKapqzzjzU=
X-Google-Smtp-Source: ABdhPJynH4mvWajgdyF7Eses/N2rktzaSmin3LJRPl3LDG1Qp9np8SXLYru7Vgmrg9yCcf11MQGKq3Oxcxv9Dgivsq8=
X-Received: by 2002:a05:6402:1481:: with SMTP id e1mr20104712edv.113.1591586169246;
 Sun, 07 Jun 2020 20:16:09 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 8 Jun 2020 13:15:58 +1000
Message-ID: <CAPM=9tzk9DL+Smnc6wdDpGvex8_2qi4TtmCfi-cevBE8-jLGTA@mail.gmail.com>
Subject: [git pull] drm next fixes for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

This are the fixes from last week for the stuff merged in the merge
window. It got a bunch of nouveau fixes for HDA audio on some new
GPUs, some i915 and some amdpgu fixes.

I've got another pull request with Rob's msm next stuff in it I'll
send along after this, it was in -next all along, but it needed a
revert before I merged it, and it also was on a different base, so
I'll sent a separate pull from my fixes branch to avoid me having to
backmerge anything here yet.

Dave.

drm-next-2020-06-08:
drm fixes for 5.7-rc1

i915:
- gvt: Fix one clang warning on debug only function
       Use ARRAY_SIZE for coccicheck warn
- Use after free fix for display global state.
- Whitelisting context-local timestamp on Gen9
  and two scheduler fixes with deps (Cc: stable)
- Removal of write flag from sysfs files where
  ineffective

nouveau:
- HDMI/DP audio HDA fixes
- display hang fix for Volta/Turing
- GK20A regression fix.

amdgpu:
- Prevent hwmon accesses while GPU is in reset
- CTF interrupt fix
- Backlight fix for renoir
- Fix for display sync groups
- Display bandwidth validation workaround
The following changes since commit 9ca1f474cea0edc14a1d7ec933e5472c0ff115d3=
:

  Merge tag 'amd-drm-next-5.8-2020-05-27' of
git://people.freedesktop.org/~agd5f/linux into drm-next (2020-05-28
16:10:17 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-06-08

for you to fetch changes up to 8d286e2ff4400d313955b4203fc640ca6fd9228b:

  Merge tag 'drm-intel-next-fixes-2020-06-04' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next (2020-06-08
11:59:57 +1000)

----------------------------------------------------------------
drm fixes for 5.7-rc1

i915:
- gvt: Fix one clang warning on debug only function
       Use ARRAY_SIZE for coccicheck warn
- Use after free fix for display global state.
- Whitelisting context-local timestamp on Gen9
  and two scheduler fixes with deps (Cc: stable)
- Removal of write flag from sysfs files where
  ineffective

nouveau:
- HDMI/DP audio HDA fixes
- display hang fix for Volta/Turing
- GK20A regression fix.

amdgpu:
- Prevent hwmon accesses while GPU is in reset
- CTF interrupt fix
- Backlight fix for renoir
- Fix for display sync groups
- Display bandwidth validation workaround

----------------------------------------------------------------
Aishwarya Ramakrishnan (1):
      drm/i915/gvt: Use ARRAY_SIZE for vgpu_types

Alex Deucher (2):
      drm/amdgpu/pm: return an error during GPU reset or suspend (v2)
      drm/amdgpu/display: use blanked rather than plane state for sync grou=
ps

Ben Skeggs (8):
      drm/nouveau/disp/gm200-: fix NV_PDISP_SOR_HDMI2_CTRL(n) selection
      drm/nouveau/kms/gt215-: fix race with audio driver runpm
      drm/nouveau/disp: provide hint to OR allocation about HDA requirement=
s
      drm/nouveau/disp: split part of OR allocation logic into a function
      drm/nouveau/disp: modify OR allocation policy to account for HDA
requirements
      drm/nouveau/disp/gp100: split SOR implementation from gm200
      drm/nouveau/disp/gm200-: detect and potentially disable HDA
support on some SORs
      drm/nouveau/kms/nv50-: clear SW state of disabled windows harder

Chris Wilson (9):
      drm/i915: Don't set queue-priority hint when supressing the reschedul=
e
      drm/i915/gt: Remove errant assertion in __intel_context_do_pin
      drm/i915: Disable semaphore inter-engine sync without timeslicing
      drm/i915: Avoid using rq->engine after free during i915_fence_release
      drm/i915/gem: Avoid iterating an empty list
      drm/i915: Reorder await_execution before await_request
      drm/i915/gt: Do not schedule normal requests immediately along virtua=
l
      drm/i915: Check for awaits on still currently executing requests
      drm/i915: Whitelist context-local timestamp in the gen9 cmdparser

Dave Airlie (3):
      Merge branch 'linux-5.8' of git://github.com/skeggsb/linux into drm-n=
ext
      Merge tag 'amd-drm-fixes-5.8-2020-06-04' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'drm-intel-next-fixes-2020-06-04' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next

Evan Quan (1):
      drm/amd/powerplay: ack the SMUToHost interrupt on receive V2

Harry Wentland (1):
      Revert "drm/amd/display: disable dcn20 abm feature for bring up"

Jani Nikula (2):
      drm/i915/params: don't expose inject_probe_failure in debugfs
      drm/i915/params: fix i915.fake_lmem_start module param sysfs permissi=
ons

Joonas Lahtinen (1):
      Merge tag 'gvt-next-fixes-2020-05-28' of
https://github.com/intel/gvt-linux into drm-intel-next-fixes

Nathan Chancellor (1):
      drm/i915: Mark check_shadow_context_ppgtt as maybe unused

Nicholas Kazlauskas (1):
      drm/amd/display: Revalidate bandwidth before commiting DC updates

Thierry Reding (1):
      drm/nouveau: gr/gk20a: Use firmware version 0

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Fix global state use-after-frees with a refcount

 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             | 171 ++++++++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  11 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  30 +-
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c          |   6 +
 drivers/gpu/drm/i915/display/intel_global_state.c  |  45 ++-
 drivers/gpu/drm/i915/display/intel_global_state.h  |   3 +
 drivers/gpu/drm/i915/gem/i915_gem_context.c        |   4 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c          |  15 +-
 drivers/gpu/drm/i915/gt/intel_context.c            |   2 -
 drivers/gpu/drm/i915/gvt/vgpu.c                    |   2 +-
 drivers/gpu/drm/i915/i915_cmd_parser.c             |   4 +
 drivers/gpu/drm/i915/i915_params.c                 |   2 +-
 drivers/gpu/drm/i915/i915_params.h                 |   2 +-
 drivers/gpu/drm/i915/i915_request.c                | 359 +++++++++++++----=
----
 drivers/gpu/drm/i915/i915_scheduler.c              |  16 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |  21 +-
 drivers/gpu/drm/nouveau/dispnv50/wndw.c            |   5 +-
 drivers/gpu/drm/nouveau/include/nvif/cl5070.h      |   3 +-
 drivers/gpu/drm/nouveau/nouveau_encoder.h          |   1 +
 drivers/gpu/drm/nouveau/nvkm/engine/disp/Kbuild    |   1 +
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gp100.c   |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gp102.c   |   2 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/hdmigm200.c   |   4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h     |   1 +
 drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.c    |  73 +++--
 drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h    |   2 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/rootnv50.c    |   4 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/sorgm200.c    |  36 ++-
 .../gpu/drm/nouveau/nvkm/engine/disp/sorgp100.c    |  93 ++++++
 .../gpu/drm/nouveau/nvkm/engine/disp/sorgv100.c    |  35 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/sortu102.c    |  32 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gk20a.c     |   2 +-
 32 files changed, 778 insertions(+), 211 deletions(-)
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/sorgp100.c
