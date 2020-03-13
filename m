Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE5EC1975A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 00:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946CC206E7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 00:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5UuVhX6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgCMA7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 20:59:04 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37784 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgCMA7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 20:59:04 -0400
Received: by mail-ot1-f68.google.com with SMTP id i12so3131200otp.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 17:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=TnpQ6V6taC2d+5gH+3qWxA+XUrG8et4gYzT+TRKC6CU=;
        b=X5UuVhX6/uQ1KACRX2V1YK5gQz5EqyEwnRhe9FyB0OwldFZt4L9krlHNmGA+FayGdB
         b5ZEma3NGnqntvJf9MXnUPTkWPZJ8w8XZ99Nw0x0/Gzl7Pd9AubdeFrhYVJ6Kk7nzqyi
         BHOpcJXUrTjb0fT3vAruIHlkvO9aWGs5unWQKr/NDiZo5PqYnJpUMLcEf2ZzwYb44jaZ
         adjwBRQSHSGnypDNGkYlrN9vHNXAASjqqfaD2CRUHOwdHCvLFL/Rr2IWvrPpSCOd7EYR
         Yf1pc5ZBqPMyOzL9xnBUNjk8C+naGbFuOZYx0FMFNvfpoc2XsXeVERaDUpImZpduCuXv
         HUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=TnpQ6V6taC2d+5gH+3qWxA+XUrG8et4gYzT+TRKC6CU=;
        b=Dc3VfHRZ5qBSzUp3aZ3OJDL1kfM//eY7G4nud3jhkwG/QRVR1XAU8rM0GMtvI+5jA8
         YOk7QV11mt5vUDjEThjADnykGVbR6bZOKNgXezljE16cafH6NkckKA8ZBtGQ1V/2PNNv
         0nvRLr6/NFziX7ISDQtkJ5tRhZD+HfR3oygBrundLRtbYPQf5VKVsHWlK5y/0bS5hzd3
         hxy0dt2ZSG87e7e6y4ckfQjRRItR49YzwzEcAT75SZz9nm261YomaurObCo0FPbUMzs6
         /zFCWOcVv2LT23LQhImjdVvk/HBRcYwYa+gwv3lKsyBZH+w3M4AudqL2U5g84lQ/zzdc
         s5yg==
X-Gm-Message-State: ANhLgQ3GOLdnkwM0cZfOifg9xyap+oQ0v4qyEYuQZfNBlM7tjkC0eePO
        CgNmtGRZIECg8YjzXqNtT8Cj+8DRUNpQsluBE2MYns1a
X-Google-Smtp-Source: ADFU+vu0h+sm6tuAYmid4Oy1/UoWBnDMBLwzuPZY48BisLtyMz8xLfoEleQV5Xynh6jPjyoZ6SKT2LditCYeptJsd/w=
X-Received: by 2002:a9d:69d3:: with SMTP id v19mr8860958oto.320.1584061142725;
 Thu, 12 Mar 2020 17:59:02 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 13 Mar 2020 10:58:51 +1000
Message-ID: <CAPM=9tyX3+Qk05feqP=5SbePrg7kWvZu1O0J1pxZk+8Yj=Xjew@mail.gmail.com>
Subject: [git pull] drm fixes for 5.6-rc6
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

It's a bit quieter, probably not as much as it could be. There is on
large regression fix in here from Lyude for displayport bandwidth
calculations, there've been reports of multi-monitor in docks not
working since -rc1 and this has been tested to fix those.

Otherwise it's a bunch of i915 (with some GVT fixes), a set of amdgpu
watermark + bios fixes, and an exynos iommu cleanup fix.

I'm in for dental surgery early next week but I think I should have
recovered enough to send fixes as regular.

Regards,
Dave.
drm-fixes-2020-03-13:
drm fixes for 5.6-rc6

core:
- DP MST bandwidth regression fix.

i915:
- hard lockup fix
- GVT fixes
- 32-bit alignment issue fix
- timeline wait fixes
- cacheline_retire and free

amdgpu:
- Update the display watermark bounding box for navi14
- Fix fetching vbios directly from rom on vega20/arcturus
- Navi and renoir watermark fixes

exynos:
- iommu object cleanup fix

The following changes since commit 2c523b344dfa65a3738e7039832044aa133c75fb:

  Linux 5.6-rc5 (2020-03-08 17:44:44 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-03-13

for you to fetch changes up to 16b78f052d0129cd2998305480da6c4e3ac220a8:

  Merge tag 'topic/mst-bw-check-fixes-for-airlied-2020-03-12-2' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2020-03-13
10:38:25 +1000)

----------------------------------------------------------------
drm fixes for 5.6-rc6

core:
- DP MST bandwidth regression fix.

i915:
- hard lockup fix
- GVT fixes
- 32-bit alignment issue fix
- timeline wait fixes
- cacheline_retire and free

amdgpu:
- Update the display watermark bounding box for navi14
- Fix fetching vbios directly from rom on vega20/arcturus
- Navi and renoir watermark fixes

exynos:
- iommu object cleanup fix


----------------------------------------------------------------
Chris Wilson (5):
      drm/i915: Actually emit the await_start
      drm/i915: Return early for await_start on same timeline
      drm/i915/execlists: Enable timeslice on partial virtual engine dequeue
      drm/i915/gt: Close race between cacheline_retire and free
      drm/i915: Defer semaphore priority bumping to a workqueue

Dave Airlie (4):
      Merge tag 'exynos-drm-fixes-for-v5.6-rc5-v2' of
git://git.kernel.org/.../daeinki/drm-exynos into drm-fixes
      Merge tag 'amd-drm-fixes-5.6-2020-03-11' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2020-03-12' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'topic/mst-bw-check-fixes-for-airlied-2020-03-12-2' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Hawking Zhang (1):
      drm/amdgpu: correct ROM_INDEX/DATA offset for VEGA20

Hersen Wu (1):
      drm/amdgpu/powerplay: nv1x, renior copy dcn clock settings of
watermark to smu during boot up

Jani Nikula (1):
      Merge tag 'gvt-fixes-2020-03-10' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Lyude Paul (4):
      drm/dp_mst: Rename drm_dp_mst_is_dp_mst_end_device() to be less redundant
      drm/dp_mst: Use full_pbn instead of available_pbn for bandwidth checks
      drm/dp_mst: Reprobe path resources in CSN handler
      drm/dp_mst: Rewrite and fix bandwidth limit checks

Marek Szyprowski (1):
      drm/exynos: Fix cleanup of IOMMU related objects

Martin Leung (1):
      drm/amd/display: update soc bb for nv14

Matthew Auld (1):
      drm/i915: be more solid in checking the alignment

Tina Zhang (2):
      drm/i915/gvt: Fix emulated vbt size issue
      drm/i915/gvt: Fix dma-buf display blur issue on CFL

Zhenyu Wang (1):
      drm/i915/gvt: Fix unnecessary schedule timer when no vGPU exits

 drivers/gpu/drm/amd/amdgpu/soc15.c                 |  25 ++-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  | 114 +++++++++++++
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         |   7 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         |  22 ++-
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c         |   5 +-
 drivers/gpu/drm/drm_dp_mst_topology.c              | 184 ++++++++++++++-------
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c      |   5 +-
 drivers/gpu/drm/exynos/exynos7_drm_decon.c         |   5 +-
 drivers/gpu/drm/exynos/exynos_drm_dma.c            |  28 +++-
 drivers/gpu/drm/exynos/exynos_drm_drv.h            |   6 +-
 drivers/gpu/drm/exynos/exynos_drm_fimc.c           |   5 +-
 drivers/gpu/drm/exynos/exynos_drm_fimd.c           |   5 +-
 drivers/gpu/drm/exynos/exynos_drm_g2d.c            |   5 +-
 drivers/gpu/drm/exynos/exynos_drm_gsc.c            |   5 +-
 drivers/gpu/drm/exynos/exynos_drm_rotator.c        |   5 +-
 drivers/gpu/drm/exynos/exynos_drm_scaler.c         |   6 +-
 drivers/gpu/drm/exynos/exynos_mixer.c              |   7 +-
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c     |   3 +-
 drivers/gpu/drm/i915/gt/intel_lrc.c                |  29 ++--
 drivers/gpu/drm/i915/gt/intel_timeline.c           |   8 +-
 drivers/gpu/drm/i915/gvt/display.c                 |   3 +-
 drivers/gpu/drm/i915/gvt/opregion.c                |   5 +-
 drivers/gpu/drm/i915/gvt/vgpu.c                    |  12 +-
 drivers/gpu/drm/i915/i915_request.c                |  28 +++-
 drivers/gpu/drm/i915/i915_request.h                |   2 +
 drivers/gpu/drm/i915/i915_utils.h                  |   5 +
 include/drm/drm_dp_mst_helper.h                    |   4 +-
 27 files changed, 405 insertions(+), 133 deletions(-)
