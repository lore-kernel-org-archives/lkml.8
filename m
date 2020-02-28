Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AE7C3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 05:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7977246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 05:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbmRW3HY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgB1FWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 00:22:18 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:37842 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1FWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 00:22:17 -0500
Received: by mail-ot1-f43.google.com with SMTP id b3so1524751otp.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 21:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=kxGFCKJb9JKZgDTL0VAXjQbo9K94If/SEHivJGJ9qhI=;
        b=VbmRW3HYVzMu2xOKsC8a/dFEdX5O5XmW3rhJFoaeh6yQNtLqGs83Cxs2xF20HRcp7r
         XXaZSkqJ4y4NvkSfSQGJ0xbKvaZp/5NDPL7aNxvQ57uOPKueCnayVJH0T2Zn2+wuRua1
         HKvczIj5gQBtjHr3B2+cO27u5c0F3yCtcbFMWTnnCMFNHhTD5zNCHodZ3xfMZqHlqYE9
         upLVddJYnlC734Armqe3NnzRlADQUP2OuBHbrAEaCpbj1N3hwindIDHDwc74MVsLQQhH
         n3wI5rhvDAQGC5aYee3sEJ2ELuxxE780ZnrfmPL0Qv8XAfDWw+uZgs3SJhUK2mS0LlcS
         ecBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=kxGFCKJb9JKZgDTL0VAXjQbo9K94If/SEHivJGJ9qhI=;
        b=MPg+S0keA3ydBg/4tudSBLEe2KoaOVUxu0RyWpkh0ZknkGea8VjVltsxNkQaInH5vq
         vvVg0jpCWvrdO47KhBLVZIYA1wVvvIAf289vvJKKm67qd+UHWbqKCQwA7paG9sjMi83H
         kJA6xzOlOJ9BWFivKrbSUKw3A7xnAthTkLCpicVB+ogPcNWUsy1UPWsE28gaB37QWl91
         s5JN962fj7mneh8oIZpWe54bJ5S6pLHEy8VmvbWXCbsFD5cRVqplaBNN4vuARHKtbdfO
         KDTXCSb0X+jSAZKOsn+JuK/RK8/HRMfgfyXKUe1/DZsJNt6ZgeJYmz74ZBRvEU9/AGBU
         k+EA==
X-Gm-Message-State: APjAAAVBwoB+Z5nglFXWCoVgWPYBJvlOuBuK6GdWruKL9pcCDE0/IFoH
        OUQtoFHAVV9ewYvTa+5I8kTidNjoMwvQFGfMUIkSswPIfj8=
X-Google-Smtp-Source: APXvYqwG+tzF6SFB7qQUu5alJJm9TLCJMOhK8T/Y/Ou5kD3EJ9CdRToCUt1Re8NdkfdF0mP1/ij3OJivgCQYlJlc/iY=
X-Received: by 2002:a9d:3bc4:: with SMTP id k62mr2022039otc.186.1582867337062;
 Thu, 27 Feb 2020 21:22:17 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 28 Feb 2020 15:22:04 +1000
Message-ID: <CAPM=9tya9tFH13gF8AyOyP8SLMB-wyUNxBen=NY2ik9hr1Brjw@mail.gmail.com>
Subject: [git pull] drm fixes for 5.6-rc4
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

Just some fixes for this week, amdgpu, radeon and i915. The main i915
one is a regression Gen7 (Ivybridge/Haswell), this moves them back
from trying to use the full-ppgtt support to the aliasing version it
used to use due to gpu hangs. Otherwise it's pretty quiet.

Dave.

drm-fixes-2020-02-28:
drm fixes for 5.6.0-rc4

amdgpu:
- Drop DRIVER_USE_AGP
- Fix memory leak in GPU reset
- Resume fix for raven

radeon:
- Drop DRIVER_USE_AGP

i915:
- downgrade gen7 back to aliasing-ppgtt to avoid GPU hangs
- shrinker fix
- pmu leak and double free fixes
- gvt user after free and virtual display reset fixes
- randconfig build fix
The following changes since commit f8788d86ab28f61f7b46eb6be375f8a726783636=
:

  Linux 5.6-rc3 (2020-02-23 16:17:42 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-02-28

for you to fetch changes up to f091bf39700dd086ab244c823f389556fed0c513:

  Merge tag 'drm-intel-fixes-2020-02-27' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2020-02-28
12:40:49 +1000)

----------------------------------------------------------------
drm fixes for 5.6.0-rc4

amdgpu:
- Drop DRIVER_USE_AGP
- Fix memory leak in GPU reset
- Resume fix for raven

radeon:
- Drop DRIVER_USE_AGP

i915:
- downgrade gen7 back to aliasing-ppgtt to avoid GPU hangs
- shrinker fix
- pmu leak and double free fixes
- gvt user after free and virtual display reset fixes
- randconfig build fix

----------------------------------------------------------------
Chris Wilson (2):
      drm/i915/gtt: Downgrade gen7 (ivb, byt, hsw) back to aliasing-ppgtt
      drm/i915: Avoid recursing onto active vma from the shrinker

Daniel Vetter (2):
      drm/amdgpu: Drop DRIVER_USE_AGP
      drm/radeon: Inline drm_get_pci_dev

Dave Airlie (2):
      Merge tag 'amd-drm-fixes-5.6-2020-02-26' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2020-02-27' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Jani Nikula (2):
      drm/i915: fix header test with GCOV
      Merge tag 'gvt-fixes-2020-02-26' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Micha=C5=82 Winiarski (2):
      drm/i915/pmu: Avoid using globals for CPU hotplug state
      drm/i915/pmu: Avoid using globals for PMU events

Monk Liu (1):
      drm/amdgpu: fix memory leak during TDR test(v2)

Shirish S (1):
      amdgpu/gmc_v9: save/restore sdpif regs during S3

Tina Zhang (2):
      drm/i915/gvt: Separate display reset from ALL_ENGINES reset
      drm/i915/gvt: Fix orphan vgpu dmabuf_objs' lifetime

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              | 37 +++++++++++++-
 .../drm/amd/include/asic_reg/dce/dce_12_0_offset.h |  2 +
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c          |  6 ++-
 drivers/gpu/drm/i915/Makefile                      |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_shrinker.c       |  4 +-
 drivers/gpu/drm/i915/gvt/dmabuf.c                  |  2 +-
 drivers/gpu/drm/i915/gvt/vgpu.c                    |  2 +-
 drivers/gpu/drm/i915/i915_pci.c                    |  4 +-
 drivers/gpu/drm/i915/i915_pmu.c                    | 59 ++++++++++++------=
----
 drivers/gpu/drm/i915/i915_pmu.h                    | 11 +++-
 drivers/gpu/drm/radeon/radeon_drv.c                | 43 +++++++++++++++-
 drivers/gpu/drm/radeon/radeon_kms.c                |  6 +++
 14 files changed, 138 insertions(+), 43 deletions(-)
