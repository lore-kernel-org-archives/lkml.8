Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E104C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 04:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF254221EA
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 04:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIoULuR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbgDREYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 00:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725440AbgDREYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 00:24:47 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAF7C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 21:24:45 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id n17so3138749ejh.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 21:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=KBazz/io4zB337FE32+j8O9LmbM2Ojdb+G1jwNFZHzc=;
        b=TIoULuR6pSS7qF+35ZooJKmh4zn0jJ0F0lmm72vtCaOAH9qI+I7DVatI+c2wyxBSL9
         aMVhdNaSkwrjuTOUj1Wm5r/qtU2yqUb5N483BLnVxodd1IYwfTJgEPkDnFCGIU1qSYqz
         KaChHwPnSE3WXcbmLkTlznL4PU9kpNxrhDxxIKf7PM7wYW1Qh1hi/xHrWYX7qJpmWO4f
         a+uykNAKtIM286GEh3SO/ofUxuzNp8GGOSoG9pV7gYARfpt0O4E7TxvQYBsmoZlLrhPH
         DTgh5CLWQZ4hTVgMGUz1KfFfVRNJMYVM8HEixCI37vge9CYgug2s+U96cMf6LJjUY7D3
         /VGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=KBazz/io4zB337FE32+j8O9LmbM2Ojdb+G1jwNFZHzc=;
        b=LkEbml6oUbXW4/uzOBGR7ZqZMFp97QFdKzvI+GgvkLbwH7QqSgr1nSiGSnFfLZDD6v
         gQBBCidJUaOoQzR9/nHrGHdHu45Qg+uLQvDKPWRmo6CIKHnzV+kPYee/pIdCkAbpSUOA
         qA1+DrUHS8ASBSqwm8AyOZF/yIa7yn48UL0Z8BlL5ceKfsH5IORowiEL87uvOVtM4AFQ
         pg0R7IKtsGctD4dzSaH/AvFjZo5LNJWqTku9tyLi7bFW4jOZYeXJjIBM7a7L9DqYaqkm
         MP9QMBPbAa2wwMJjRMpvtNOiyvyagA17jOZOcjtPzx7eeeeZX11k1MHGFGnnQARswHdx
         wQIA==
X-Gm-Message-State: AGi0PuY5NSi1gHjey6w8/B9so3Baj8xMACddhh2emh/fobEewWKyYUh4
        LNpZGKNkq/qXFuhKLHzlmRWzfE7JUjyJ4EX60OWEo26w
X-Google-Smtp-Source: APiQypIACnYxc28zp8rR2XbSkGCVW0GqITrKgvddjeZlAneug7hNzxQ4GFs0nvOmQYlWEe7K7QjQpIWhModM9oXNcjs=
X-Received: by 2002:a17:906:64b:: with SMTP id t11mr6229593ejb.336.1587183883952;
 Fri, 17 Apr 2020 21:24:43 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Sat, 18 Apr 2020 14:24:32 +1000
Message-ID: <CAPM=9tyt1N=QTmsyBKYzMqYJLbNzrgrnNoqQrzn3735ePSCODQ@mail.gmail.com>
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

Quiet enough for rc2, mostly amdgpu fixes, a couple of i915 fixes, and
one nouveau module firmware fix.

Regards,
Dave.

drm-fixes-2020-04-18:
drm fixes for 5.7-rc2

i915:
- Fix guest page access by using the brand new VFIO dma r/w interface (Yan)
- Fix for i915 perf read buffers (Ashutosh)

amdgpu:
- gfx10 fix
- SMU7 overclocking fix
- RAS fix
- GPU reset fix
- Fix a regression in a previous s/r fix
- Add a gfxoff quirk

nouveau:
- fix missing MODULE_FIRMWARE
The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-04-18

for you to fetch changes up to 4da858c086433cd012c0bb16b5921f6fafe3f803:

  Merge branch 'linux-5.7' of git://github.com/skeggsb/linux into
drm-fixes (2020-04-16 15:40:02 +1000)

----------------------------------------------------------------
drm fixes for 5.7-rc2

i915:
- Fix guest page access by using the brand new VFIO dma r/w interface (Yan)
- Fix for i915 perf read buffers (Ashutosh)

amdgpu:
- gfx10 fix
- SMU7 overclocking fix
- RAS fix
- GPU reset fix
- Fix a regression in a previous s/r fix
- Add a gfxoff quirk

nouveau:
- fix missing MODULE_FIRMWARE

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu/gfx9: add gfxoff quirk

Ashutosh Dixit (1):
      drm/i915/perf: Do not clear pollin for small user read buffers

Ben Skeggs (1):
      drm/nouveau/sec2/gv100-: add missing MODULE_FIRMWARE()

Dave Airlie (3):
      Merge tag 'drm-intel-fixes-2020-04-15' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-5.7-2020-04-15' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge branch 'linux-5.7' of git://github.com/skeggsb/linux into drm-fixes

Evan Quan (2):
      drm/amd/powerplay: unload mp1 for Arcturus RAS baco reset
      drm/amdgpu: fix wrong vram lost counter increment V2

Likun Gao (1):
      Revert "drm/amdgpu: change SH MEM alignment mode for gfx10"

Prike Liang (1):
      drm/amdgpu: fix the hw hang during perform system reboot and reset

Rodrigo Vivi (1):
      Merge tag 'gvt-fixes-2020-04-14' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Sergei Lopatin (1):
      drm/amd/powerplay: force the trim of the mclk dpm_levels if OD is enabled

Yan Zhao (3):
      drm/i915/gvt: hold reference of VFIO group during opening of vgpu
      drm/i915/gvt: subsitute kvm_read/write_guest with vfio_dma_rw
      drm/i915/gvt: switch to user vfio_group_pin/upin_pages

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       | 22 +++++++-
 drivers/gpu/drm/amd/amdgpu/cik.c                 |  2 -
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c            |  2 +
 drivers/gpu/drm/amd/amdgpu/nv.c                  |  4 --
 drivers/gpu/drm/amd/amdgpu/soc15.c               |  4 --
 drivers/gpu/drm/amd/amdgpu/vi.c                  |  2 -
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c |  5 +-
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c        |  6 +++
 drivers/gpu/drm/i915/gvt/kvmgt.c                 | 46 ++++++++---------
 drivers/gpu/drm/i915/i915_perf.c                 | 65 ++++--------------------
 drivers/gpu/drm/nouveau/nvkm/engine/sec2/gp108.c |  3 ++
 drivers/gpu/drm/nouveau/nvkm/engine/sec2/tu102.c | 16 ++++++
 13 files changed, 85 insertions(+), 94 deletions(-)
