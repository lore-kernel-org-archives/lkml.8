Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43356C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 03:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F88B2076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 03:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyfrtGrw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgFHDeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 23:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbgFHDeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 23:34:03 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E596C08C5C3
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 20:34:03 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id l27so16637474ejc.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 20:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6XfW1mKwb87eK226dwnXsOAnQgHyjQ9PE5+w0JxGQpA=;
        b=SyfrtGrwB7bcudUCp6NbYRGFd9aZTNDDpreoldBoCMmCMOFMRKUVTodPccBCLiUX1l
         DT6GU/fqWSPQusG8Wz/tpfit1blUICkxFFAcjjX2kAhKEcYsCu23HQaiCUuGjxTOVU1q
         GYMyPDcNW26y/PvznJajjiiQ0vgxjZzrlFdcaNeYqpr0M2obacp5ctVOXi+n/++JicYi
         qw3xd444rfLPf/6EW7cBPUB65f+KJTWPI2BdgjVUEYX3zUvU9+/2I3DtWwgde3YyvdZF
         NGJf4YhdvDgOZo87AUn0dI4RJOWITBWOkqnrLRpZeB9nwFf0HZ8+M0VbvBjhB1P3TyJn
         q0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6XfW1mKwb87eK226dwnXsOAnQgHyjQ9PE5+w0JxGQpA=;
        b=MNHKwbleBudzuYN2JTuqvpU2sT3qHFmjHNl8C5AHCgyDnx96AWdZ8rmjRoAfd+4NMz
         sp4BAIicvRMVG6nYCTO6bdWJm0O18lKEvZJ7VU0fA0bPpOinfasbP/KM+d5NY2nJvH8Z
         eqkwUMLehrCCq2DhagfmpAT5fid+a1AUa+l0lD3oFEdaJ6LAeUl2DTSNF4zLZ5CnbEZ9
         UmsVCueAHpLT8WJ2ylulDgP6FqP61gb4f0jfisTjkuHYNV/oUPMQ17qeDz+W97nPojk5
         icCWYoT3Ms83AQTnltjSN6yKdVzDB0iKBqemk0JrF7qp0BE2K8G7y6JmE9l4TTyytUzv
         g13w==
X-Gm-Message-State: AOAM532oDb54U3MlKlJajeEHacUCouwMf/YzyVa8v4zJ7vt6dDqmocVp
        qeU51qfttux7ikNP2WuCHlpTl/JuM7ZDg8gr2t0=
X-Google-Smtp-Source: ABdhPJwHaUyCkXTiuvSsDZ79w04+Gy5pyHGgzmC5p1mDbrhKXCrP+dqa5JXA0hjHPgANBJE/C1JgmHGwIwlYWohrnK0=
X-Received: by 2002:a17:906:2507:: with SMTP id i7mr11425190ejb.419.1591587242023;
 Sun, 07 Jun 2020 20:34:02 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 8 Jun 2020 13:33:51 +1000
Message-ID: <CAPM=9two=B8nCSP9+9x3oGM9HUm0dDk3aY=ePUuVeh6530v94Q@mail.gmail.com>
Subject: [git pull] drm msm next for 5.8-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This should be the final feature pull for drm for rc1. This tree has
been in next for a couple of weeks, but Rob missed an arm32 build
issue, so I was awaiting the tree with a patch reverted. The tree was
also based on an 5.7-rc5 tree so I didn't want to futz around with
backmerging just for this, so I'm sending it from a topic branch based
on v5.7.

Dave.

drm-next-msm-5.8-2020-06-08:
drm msm next for 5.8-rc1

* new gpu support: a405, a640, a650
* dpu: color processing support
* mdp5: support for msm8x36 (the thing with a405)
* some prep work for per-context pagetables (ie the part that
  does not depend on in-flight iommu patches)
* last but not least, UABI update for submit ioctl to support
  syncobj (from Bas)
The following changes since commit 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162:

  Linux 5.7 (2020-05-31 16:49:15 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-msm-5.8-2020-06-08

for you to fetch changes up to efe792f39ddbc6396b9142afff97855ee357b492:

  Merge https://gitlab.freedesktop.org/drm/msm into drm-next-msm-5.8
(2020-06-08 13:22:57 +1000)

----------------------------------------------------------------
drm msm next for 5.8-rc1

* new gpu support: a405, a640, a650
* dpu: color processing support
* mdp5: support for msm8x36 (the thing with a405)
* some prep work for per-context pagetables (ie the part that
  does not depend on in-flight iommu patches)
* last but not least, UABI update for submit ioctl to support
  syncobj (from Bas)

----------------------------------------------------------------
Bas Nieuwenhuizen (1):
      drm/msm: Add syncobj support.

Bjorn Andersson (1):
      drm/msm: Fix undefined "rd_full" link error

Christophe JAILLET (2):
      drm/msm/a6xx: Fix a typo in an error message
      drm/msm: Fix typo

Dave Airlie (1):
      Merge https://gitlab.freedesktop.org/drm/msm into drm-next-msm-5.8

Hongbo Yao (1):
      drm/msm/dpu: Fix compile warnings

Jonathan Marek (10):
      drm/msm: add msm_gem_get_and_pin_iova_range
      drm/msm: add internal MSM_BO_MAP_PRIV flag
      drm/msm/a6xx: use msm_gem for GMU memory objects
      drm/msm/a6xx: add A640/A650 to gpulist
      drm/msm/a6xx: HFI v2 for A640 and A650
      drm/msm/a6xx: A640/A650 GMU firmware path
      drm/msm/a6xx: update pdc/rscc GMU registers for A640/A650
      drm/msm/a6xx: enable GMU log
      drm/msm/a6xx: update a6xx_hw_init for A640 and A650
      drm/msm/a6xx: skip HFI set freq if GMU is powered down

Jordan Crouse (4):
      drm/msm: Check for powered down HW in the devfreq callbacks
      drm/msm: Attach the IOMMU device during initialization
      drm/msm: Refactor address space initialization
      drm/msm: Update the MMU helper function APIs

Kalyan Thota (3):
      drm/msm/dpu: add support for color processing blocks in dpu driver
      drm/msm/dpu: add support for pcc color block in dpu driver
      drm/msm/dpu: add support for clk and bw scaling for display

Konrad Dybcio (1):
      drm/msm/mdp5: Add MDP5 configuration for MSM8x36.

Krishna Manikandan (1):
      drm/msm/dpu: update bandwidth threshold check

Rob Clark (1):
      Revert "drm/msm/dpu: add support for clk and bw scaling for display"

Roy Spliet (1):
      drm/msm/mdp5: Fix mdp5_init error path for failed mdp5_kms allocation

Shawn Guo (2):
      drm/msm/a4xx: add adreno a405 support
      drm/msm/a4xx: add a405_registers for a405 device

kbuild test robot (2):
      drm/msm/a6xx: a6xx_hfi_send_start() can be static
      drm/msm/dpu: dpu_setup_dspp_pcc() can be static

 drivers/gpu/drm/msm/Makefile                   |   1 +
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c          |  16 +
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c          |   1 +
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c          |  83 ++++-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c          |   7 +
 drivers/gpu/drm/msm/adreno/a6xx.xml.h          |  14 +
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c          | 418 +++++++++++++++++++------
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h          |  37 ++-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h      |  48 +--
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c          |  70 ++++-
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c          | 123 +++++++-
 drivers/gpu/drm/msm/adreno/a6xx_hfi.h          |  50 ++-
 drivers/gpu/drm/msm/adreno/adreno_device.c     |  35 +++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c        |  27 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h        |  23 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c  |  23 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c       |  95 ++++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h       |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c    |  12 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c |  48 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h |  39 +++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c     |  26 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h     |   3 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.c    | 129 ++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.h    | 100 ++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h    |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c        |  18 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h        |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c         |  58 +++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h         |   2 +
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c       |  18 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c       |  80 ++++-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c      |   4 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c       |  21 +-
 drivers/gpu/drm/msm/msm_drv.c                  |   6 +-
 drivers/gpu/drm/msm/msm_drv.h                  |  15 +-
 drivers/gpu/drm/msm/msm_gem.c                  |  31 +-
 drivers/gpu/drm/msm/msm_gem.h                  |   1 +
 drivers/gpu/drm/msm/msm_gem_submit.c           | 232 +++++++++++++-
 drivers/gpu/drm/msm/msm_gem_vma.c              |  42 +--
 drivers/gpu/drm/msm/msm_gpu.c                  |  49 +--
 drivers/gpu/drm/msm/msm_gpu.h                  |   4 +-
 drivers/gpu/drm/msm/msm_gpummu.c               |  10 +-
 drivers/gpu/drm/msm/msm_iommu.c                |  22 +-
 drivers/gpu/drm/msm/msm_mmu.h                  |   5 +-
 drivers/gpu/drm/msm/msm_rd.c                   |   4 +-
 include/uapi/drm/msm_drm.h                     |  24 +-
 47 files changed, 1697 insertions(+), 382 deletions(-)
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.h
