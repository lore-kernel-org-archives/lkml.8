Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B4BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 01:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AF9B20708
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 01:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7gWZuXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGJBNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 21:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgGJBNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 21:13:54 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1323DC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 18:13:54 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id dm19so3262929edb.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 18:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=cvyvTNjL9sO8QwiHLhFIfmSoy7w9faKtXodf+qkqK+w=;
        b=a7gWZuXzE4qvoiHZDB6MpUH2LlGfjaegoBKXpNeX049tN4L6bLKiEvj1nvfmaa4zFt
         R6PerwLufpInPvEDOdhiafd1lzlnP0CqrZtA9DJqjPo7cy4MQ7HKAYPxyT3XVrY4IM0R
         xwjPuD/gbtOtkTZ0Ym5WlvA+dPXA0zM186Dd5Q+qXMyexXtpnxE5E8oZHxX5BmNOFzep
         sc2FKCwhhpd9pXBd1YfvT3/ztRemle2h/LvDZ+pPjSJ3FJDZRUzIKGZI2gURM4S5/W8A
         8cQ9tmkSU20oAzn/jwOV9YNoEzG9hq0uWwTbwZumzLg6iDtTurXCFu+D8Ve+4nxzam1v
         xZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=cvyvTNjL9sO8QwiHLhFIfmSoy7w9faKtXodf+qkqK+w=;
        b=FJY2OQLok4LgsP4ZpChdkjeoRM0D7o0W86sG2cNIMcGr8yEv86CPqsXnmCF6BCmZId
         GjFVeXcoe01BXG/FZy6iPRLNvBb+6XKUJs9tOlhDMP6Bl+/1a0jfwckVdS2nBX0L+/ik
         GJZu5MjcILET4V6GXcFN8zeFFUoET3O2tHe109dJFqiD1mNn8r+Acg+wWrgCPgqECtrz
         H90oadPD/uY8k8s5Hwzn6ydYLF2N2rOIRhJKrS5crnNnvC8R3eJHprISF/2PpNA+/Mnz
         qGekFFq/aDlC+Ftn/SVOIOS0gQqe2NZsbK1AOXshX/2jHMY2Ba/5qo7XTQGUm/FuAzUQ
         l3eA==
X-Gm-Message-State: AOAM530Zz+F34WV6ehrAWWQzJIAW7IdrdPKOK8r34kxujR0Yfeifv8wE
        r+mEoLJU/qGvlbIQLzy/rXZF2YbJLJyKAyI2xQg=
X-Google-Smtp-Source: ABdhPJwyyjj9kbeNAi5Y6UO0hnmLyhVwJxKK6EN0JK63V0VEEIqjZ+HMmGObUovQLLCvPbutflo91jhs1stu+AUeTaw=
X-Received: by 2002:a50:f08c:: with SMTP id v12mr73562639edl.119.1594343632612;
 Thu, 09 Jul 2020 18:13:52 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 10 Jul 2020 11:13:41 +1000
Message-ID: <CAPM=9tzAJTvCx4_2o1RyK78n-Sr6MCByLTF=_P8mhDntxf4v4g@mail.gmail.com>
Subject: [git pull] drm fixes for 5.8-rc5
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

Hi Linus,

I've been off most of the week, but some fixes have piled up. Seems a
bit busier than last week, but they are pretty spread out across a
bunch of drivers, none of them seem that big or worried me too much.

Regards,
Dave.

drm-fixes-2020-07-10:
drm fixes for 5.8-rc5

amdgpu:
- Fix a suspend/resume issue with PSP
- Backlight fix for Renoir
- Fix for gpu recovery debugging

radeon:
- Fix a double free in error path

i915:
- fbc fencing fix
- debugfs panic fix
- gem vma constuction fix
- gem pin under vm->nutex fix

nouveau:
- SVM fixes
- display fixes

meson:
- OSD burst length fixes

hibmc:
- runtime warning fix

mediatek:
- cmdq, mmsys fixes
- visibility check fixes
The following changes since commit dcb7fd82c75ee2d6e6f9d8cc71c52519ed52e258=
:

  Linux 5.8-rc4 (2020-07-05 16:20:22 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-07-10

for you to fetch changes up to 38794a5465b752118098e36cf95c59083f9f1f88:

  Merge tag 'amd-drm-fixes-5.8-2020-07-09' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes (2020-07-10
07:02:02 +1000)

----------------------------------------------------------------
drm fixes for 5.8-rc5

amdgpu:
- Fix a suspend/resume issue with PSP
- Backlight fix for Renoir
- Fix for gpu recovery debugging

radeon:
- Fix a double free in error path

i915:
- fbc fencing fix
- debugfs panic fix
- gem vma constuction fix
- gem pin under vm->nutex fix

nouveau:
- SVM fixes
- display fixes

meson:
- OSD burst length fixes

hibmc:
- runtime warning fix

mediatek:
- cmdq, mmsys fixes
- visibility check fixes

----------------------------------------------------------------
Aaron Ma (1):
      drm/amd/display: add dmcub check on RENOIR

Ben Skeggs (2):
      drm/nouveau/kms/nv50-: bail from nv50_audio_disable() early if
audio not enabled
      drm/nouveau/i2c/g94-: increase NV_PMGR_DP_AUXCTL_TRANSACTREQ timeout

Bernard Zhao (1):
      drm/mediatek: Remove unnecessary conversion to bool

Chris Wilson (4):
      drm/i915: Skip stale object handle for debugfs per-file-stats
      drm/i915: Drop vm.ref for duplicate vma on construction
      drm/i915: Also drop vm.ref along error paths for vma construction
      drm/i915/gt: Pin the rings before marking active

Dave Airlie (5):
      Merge tag 'mediatek-drm-fixes-5.8' of
https://git.kernel.org/.../chunkuang.hu/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2020-07-08' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge branch 'linux-5.8' of git://github.com/skeggsb/linux into drm-f=
ixes
      Merge tag 'drm-intel-fixes-2020-07-08' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-5.8-2020-07-09' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes

Enric Balletbo i Serra (3):
      drm/mediatek: Remove debug messages for function calls
      drm/mediatek: mtk_mt8173_hdmi_phy: Remove unnused const variables
      drm/mediatek: mtk_hdmi: Remove debug messages for function calls

Hsin-Yi Wang (2):
      drm/mediatek: Fix device passed to cmdq
      drm/mediatek: Check plane visibility in atomic_update

Huang Rui (2):
      drm/amdgpu: asd function needs to be unloaded in suspend phase
      drm/amdgpu: add TMR destory function for psp

Marek Ol=C5=A1=C3=A1k (1):
      drm/amdgpu: don't do soft recovery if gpu_recovery=3D0

Martin Blumenstingl (1):
      drm/meson: viu: fix setting the OSD burst length in
VIU_OSD1_FIFO_CTRL_STAT

Matthias Brugger (1):
      drm/mediatek: Delete not used of_device_get_match_data

Ralph Campbell (2):
      drm/nouveau/svm: fix migrate page regression
      drm/nouveau/nouveau: fix page fault on device private memory

Tom Rix (1):
      drm/radeon: fix double free

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915/fbc: Fix fence_y_offset handling

YueHaibing (1):
      drm/mediatek: Fix Kconfig warning

Zenghui Yu (1):
      drm/hisilicon/hibmc: Move drm_fbdev_generic_setup() down to
avoid the splat

 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c            |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            | 63 ++++++++++++++++++=
++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c    |  5 +-
 drivers/gpu/drm/i915/display/intel_display.c       | 11 ++++
 drivers/gpu/drm/i915/display/intel_display.h       |  1 +
 drivers/gpu/drm/i915/display/intel_fbc.c           | 32 ++++-------
 drivers/gpu/drm/i915/gt/intel_context.c            | 12 ++---
 drivers/gpu/drm/i915/i915_debugfs.c                |  2 +-
 drivers/gpu/drm/i915/i915_drv.h                    |  6 +--
 drivers/gpu/drm/i915/i915_vma.c                    | 15 +++---
 drivers/gpu/drm/mediatek/Kconfig                   |  2 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |  8 +--
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  6 +--
 drivers/gpu/drm/mediatek/mtk_drm_plane.c           | 25 +++++----
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |  5 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c                | 12 +----
 drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c     | 52 ------------------
 drivers/gpu/drm/meson/meson_registers.h            |  6 +++
 drivers/gpu/drm/meson/meson_viu.c                  | 11 +---
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |  3 ++
 drivers/gpu/drm/nouveau/nouveau_dmem.c             |  2 +-
 drivers/gpu/drm/nouveau/nouveau_svm.c              |  1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c   |  4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c |  4 +-
 drivers/gpu/drm/radeon/ci_dpm.c                    |  7 ++-
 26 files changed, 145 insertions(+), 155 deletions(-)
