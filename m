Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382D4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 01:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CE7D20A8B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 01:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brYMw3xg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgGCBqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 21:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgGCBqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 21:46:47 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F5EC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 18:46:47 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id h28so26043120edz.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 18:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=qLfiDSVGg8dEfX7H/ROzYciq9xBdzFyzcF564zjEEEg=;
        b=brYMw3xgb295hMMOFsRoJbIg9S3lYWKCJj1HKtFyykC5xptIURUn/5m87F8t3s1P20
         NZ8HfGOqrZvbxxG4Kme5nRQ3ymD9yBRfDjC7IzQ3zW/K8iRI+SMQzTi5WOpMjC6Caw0P
         1+J+wlelVd3JTTISG4OiewowQ21jHNmJD4nKLirrFflSL1CJ+hXKIJHgakBsT09Tz+91
         noeOb4D3PDtudeqHf/LzNAAyeuQRTMCzXO/AKHSErGpuANbuDyAmy6SV83wDzyfufB4d
         EKHpGmOpUhCzqDr+ZAxaFSZSGWn0P61TaZVGp+2YyfW4aYe7h+St/SgWjuWp9oi1cOdD
         TuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=qLfiDSVGg8dEfX7H/ROzYciq9xBdzFyzcF564zjEEEg=;
        b=OTypJRIBnlF7Dn+qxYfUpwB1G1xMM3O75Wv92r51+OR3mxev0hE6ohmLYhXV4rfnf6
         t8SvzGHpdcFnFLn76gHO3EtLKPZ9K5GDXtVgeorDAGsfQNvUyczCgRl/uanYDmOprms8
         oK90xPNufBaY1VTbzqvlmh+TcV3OIHYR+uoj0xdnXOeZrs646d8qsaTki+DPmm2dM7ek
         tzyVXWrOJeVyLrv9NA4GfoVozZ3sk5it3lu34JB0FyRo3+P1TmP/da5an3UfwpddpKqr
         YxktFqwRFSSbW/tqm/eY65Tp9wuq2ADW2xr1aIXEkAon97QUD2NPas3cK7vxn1iBPVoT
         v1Hw==
X-Gm-Message-State: AOAM532CwZge9FEH3oT8NenT1PbfJrsE5C2VR58C2Tii49RjU2imIUzD
        hfa9dm0PquRCEdUYh9JgkSKZBn8pXx33lJJP4Wgw190BFkE=
X-Google-Smtp-Source: ABdhPJyvQTydtXIP+ZxCaDjd7fW3WuNA6PUXIaUEdGV3/8+NR9OWrkU+8hc5H1HlpWfRv1RXbg0x8uaTa7xWXK75/XM=
X-Received: by 2002:aa7:ce84:: with SMTP id y4mr36809935edv.113.1593740805713;
 Thu, 02 Jul 2020 18:46:45 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 3 Jul 2020 11:46:34 +1000
Message-ID: <CAPM=9tx-1Z5fRAAENHe-qnpBPvaQfn24-84QR-vnivH5-qQDEg@mail.gmail.com>
Subject: [git pull] drm fixes for 5.8-rc4
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

Pretty usual rc4 pull, two usual amdgpu, i915 pulls, and some misc arm
driver fixes.
The bigger bit is including the asm sources for some GPU shaders that
were contained in the i915 driver, otherwise it's pretty much business
as usual.

Dave.

drm-fixes-2020-07-03:
drm fixes for 5.8-rc4

dma-buf:
- fix a use-after-free bug

amdgpu:
- Fix for vega20 boards without RAS support
- DC bandwidth revalidation fix
- Fix Renoir vram info fetching
- Fix hwmon freq printing

i915:
- GVT fixes
  - Two missed MMIO handler fixes for SKL/CFL
  - Fix mask register bits check
  - Fix one lockdep error for debugfs entry access
- Include asm sources for render cache clear batches

msm:
- memleak fix
- display block fix
- address space fixes

exynos:
- error value and reference count fix
- error print removal

sun4i:
- remove HPD polling
The following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68:

  Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-07-03

for you to fetch changes up to 1298a549e22abe36c82208406c7069280553c7dd:

  Merge tag 'drm-misc-fixes-2020-07-02' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2020-07-03
11:18:21 +1000)

----------------------------------------------------------------
drm fixes for 5.8-rc4

dma-buf:
- fix a use-after-free bug

amdgpu:
- Fix for vega20 boards without RAS support
- DC bandwidth revalidation fix
- Fix Renoir vram info fetching
- Fix hwmon freq printing

i915:
- GVT fixes
  - Two missed MMIO handler fixes for SKL/CFL
  - Fix mask register bits check
  - Fix one lockdep error for debugfs entry access
- Include asm sources for render cache clear batches

msm:
- memleak fix
- display block fix
- address space fixes

exynos:
- error value and reference count fix
- error print removal

sun4i:
- remove HPD polling

----------------------------------------------------------------
Alex Deucher (2):
      drm/amdgpu/atomfirmware: fix vram_info fetching for renoir
      drm/amdgpu: use %u rather than %d for sclk/mclk

Bernard Zhao (1):
      drm/msm: fix potential memleak in error branch

Chen Tao (1):
      drm/msm/dpu: fix error return code in dpu_encoder_init

Chen-Yu Tsai (1):
      drm: sun4i: hdmi: Remove extra HPD polling

Colin Xu (4):
      drm/i915/gvt: Add one missing MMIO handler for D_SKL_PLUS
      drm/i915/gvt: Fix two CFL MMIO handling caused by regression.
      drm/i915/gvt: Fix incorrect check of enabled bits in mask registers
      drm/i915/gvt: Use GFP_ATOMIC instead of GFP_KERNEL in atomic context

Dave Airlie (5):
      Merge tag 'drm-msm-fixes-2020-06-25' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes
      Merge tag 'exynos-drm-fixes-for-v5.8-rc4' of
git://git.kernel.org/.../daeinki/drm-exynos into drm-fixes
      Merge tag 'drm-intel-fixes-2020-07-01' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-5.8-2020-07-01' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2020-07-02' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Eric Anholt (2):
      drm/msm: Fix address space size after refactor.
      drm/msm: Fix setup of a6xx create_address_space.

Ivan Mironov (1):
      drm/amd/powerplay: Fix NULL dereference in lock_bus() on Vega20 w/o RAS

Jani Nikula (1):
      Merge tag 'gvt-fixes-2020-06-17' of
https://github.com/intel/gvt-linux into drm-intel-fixes

John Stultz (1):
      drm/msm: Fix 0xfffflub in "Refactor address space initialization"

Jordan Crouse (1):
      drm/msm: Fix up the rest of the messed up address sizes

Kalyan Thota (1):
      drm/msm/dpu: request for display color blocks based on hw catalog entry

Krishna Manikandan (1):
      drm/msm/dpu: allow initialization of encoder locks during encoder init

Marek Szyprowski (1):
      drm/exynos: Properly propagate return value in drm_iommu_attach_device()

Navid Emamdoost (1):
      drm/exynos: fix ref count leak in mic_pre_enable

Nicholas Kazlauskas (1):
      drm/amd/display: Only revalidate bandwidth on medium and fast updates

Rodrigo Vivi (1):
      drm/i915: Include asm sources for {ivb, hsw}_clear_kernel.c

Sumit Semwal (1):
      dma-buf: Move dma_buf_release() from fops to dentry_ops

Tamseel Shams (1):
      drm/exynos: Remove dev_err() on platform_get_irq() failure

 drivers/dma-buf/dma-buf.c                          |  54 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             |   4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  10 +-
 .../gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c   |  11 +-
 drivers/gpu/drm/exynos/exynos_drm_dma.c            |   4 +-
 drivers/gpu/drm/exynos/exynos_drm_g2d.c            |   1 -
 drivers/gpu/drm/exynos/exynos_drm_mic.c            |   4 +-
 drivers/gpu/drm/i915/gt/shaders/README             |  46 ++++++++
 .../gpu/drm/i915/gt/shaders/clear_kernel/hsw.asm   | 119 +++++++++++++++++++++
 .../gpu/drm/i915/gt/shaders/clear_kernel/ivb.asm   | 117 ++++++++++++++++++++
 drivers/gpu/drm/i915/gvt/debugfs.c                 |   2 +-
 drivers/gpu/drm/i915/gvt/handlers.c                |  24 +++--
 drivers/gpu/drm/i915/gvt/mmio_context.h            |   6 +-
 drivers/gpu/drm/i915/gvt/reg.h                     |   5 +
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c              |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |   2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |  18 ++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   2 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c           |   2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c           |   2 +-
 drivers/gpu/drm/msm/msm_submitqueue.c              |   4 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |   5 +-
 25 files changed, 373 insertions(+), 76 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/gt/shaders/README
 create mode 100644 drivers/gpu/drm/i915/gt/shaders/clear_kernel/hsw.asm
 create mode 100644 drivers/gpu/drm/i915/gt/shaders/clear_kernel/ivb.asm
