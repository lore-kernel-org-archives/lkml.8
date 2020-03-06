Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D136FC3F2D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 02:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934E0206D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 02:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnGD6pIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgCFCfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 21:35:50 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38284 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFCfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 21:35:50 -0500
Received: by mail-oi1-f195.google.com with SMTP id x75so1081232oix.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 18:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=st7rFi5+tigxm8DXMu+JVLUrGkxdt8+g7TRf3qNXqwg=;
        b=QnGD6pInLENvKb2gJnmZ1WQpqK/MbGqryeHlxxKrLzb7+xp6Ef+g7UMmarpPvdE7JB
         Q8QZAqKJl0QWxxznYrSqTMm+oqhDNumd87vI13HnsqvbyYhDIJhBRysAzriFCq+kNdkC
         oCNVOAUT2b/Oqwkd6sCm06uGmv9U/nfkRbmco1aJTcQx1RM+srkElzhtNSw0VfrNoUhG
         Cs8Xm8/4EeSAiCA8eZjojlXkfg2ETWcI44VS0YjKiqooOXnQS2KLy4L2En11JTuDCdp3
         rnK5DEeU3y5lgoSWPFTaadLTlzqSNV0K1MMfiOTIWg5y6v3QWRWQd80+PajAF1YqVC5z
         iTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=st7rFi5+tigxm8DXMu+JVLUrGkxdt8+g7TRf3qNXqwg=;
        b=osJ4109iYCONVCeR6VuyneX02b8o2FDHPpldI50ecYsdAlZ5csMCmLz1PPNLAZ150D
         mDp6VYTpzmvTORuSQQcO1qhUKZcTelBZC54x5Neih1uQ3LGUS4H7cFa1zrOKXL/z0Bwx
         JrTSWiILdIGeurGdC4y3njmJqyT5Ge2GQmk7786GPwIMMqCRmmp+p6z/iB0Qk2HT8Pfb
         KpkwoixBHfx6EjJmx/8hf/QxFeqwtXe4waw0y4kTpgb4R3kqSxsHFfmUpu91YwWCT4KZ
         WKiaO7pgfTrFqFBnKI7QQIsG6MCLh68QxBoiVoDzr6O26IrNDb3zlSHAvNuAi/D0ilT1
         4gNQ==
X-Gm-Message-State: ANhLgQ3oui4qh/HCD0xmMcD3E9XRuwyIysuC93xn0V9aG6SaM3U2Q5nY
        QJBdDQhCXdF5YOlNKWLmnfkIxtItBSIKJpNSzubOVwlIX8U=
X-Google-Smtp-Source: ADFU+vvBbK8TVAGoCqhS1nPpYaDpzrnbABIxMMYV8JPp1G5cQzEfWakv+pkLCAW0wtSPf+ViEEwAngDJIZU3xUIcomE=
X-Received: by 2002:aca:3857:: with SMTP id f84mr1052131oia.150.1583462148584;
 Thu, 05 Mar 2020 18:35:48 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 6 Mar 2020 12:35:37 +1000
Message-ID: <CAPM=9tzi8ZaowmegAgeHSO3cLB5VRid9h=TMX=v+YcHEb5Cx_A@mail.gmail.com>
Subject: [git pull] drm fixes for 5.6-rc5
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

Weekly fixes round, looks like a few people woke up, got a bunch of
fixes across the drivers. Bit bigger than I'd like but they all seem
fine and hopefully it quiets down now.

sun4i, kirin, mediatek and exynos on the ARM side.
virtio-gpu and core have some mmap fixes, and there is a dma-buf leak.
one ttm fence leak is also fixed.

Otherwise it's mostly amdgpu and i915. One of the i915 fixes is for a
very long latency I was seeing (using latencytop) running gnome-shell
locally when using firefox and eating nearly all my RAM, it really
helps with desktop responsiveness esp when firefox is chewing a lot.

Dave.

drm-fixes-2020-03-06:
drm fixes for 5.6-rc5

dma-buf:
- fix memory leak

core:
- shmem object mmap fix.

ttm:
- Fix fence leak in ttm_buffer_object_transfer().

amdgpu:
- Gfx reset fix for gfx9, 10
- Fix for gfx10
- DP MST fix
- DCC fix
- Renoir power fixes
- Navi power fix

i915:
- Break up long lists of object reclaim with cond_resched()
- PSR probe fix
- TGL workarounds
- Selftest return value fix
- Drop timeline mutex while waiting for retirement
- Wait for OA configuration completion before writes to OA buffer

virtio:
- Fix resource id creation race in virtio.
- mmap fixes

sun4i:
- Fixes for sun4i VI layer format support.

kirin:
- kirin: Revert "Fix for hikey620 display offset problem"

exynos:
- fix a kernel oops problem in case that driver is loaded as module.
- fix a regulator warning issue when I2C DDC adapter cannot be gathered.
- print out an error message only in error case excepting -EPROBE_DEFER.

mediatek:
- overlay, cursor and gce fixes.
`
The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b=
:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-03-06

for you to fetch changes up to 2ac4853e295bba53209917e14af701c45c99ce04:

  Merge tag 'amd-drm-fixes-5.6-2020-03-05' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes (2020-03-06
11:06:33 +1000)

----------------------------------------------------------------
drm fixes for 5.6-rc5

dma-buf:
- fix memory leak

core:
- shmem object mmap fix.

ttm:
- Fix fence leak in ttm_buffer_object_transfer().

amdgpu:
- Gfx reset fix for gfx9, 10
- Fix for gfx10
- DP MST fix
- DCC fix
- Renoir power fixes
- Navi power fix

i915:
- Break up long lists of object reclaim with cond_resched()
- PSR probe fix
- TGL workarounds
- Selftest return value fix
- Drop timeline mutex while waiting for retirement
- Wait for OA configuration completion before writes to OA buffer

virtio:
- Fix resource id creation race in virtio.
- mmap fixes

sun4i:
- Fixes for sun4i VI layer format support.

kirin:
- kirin: Revert "Fix for hikey620 display offset problem"

exynos:
- fix a kernel oops problem in case that driver is loaded as module.
- fix a regulator warning issue when I2C DDC adapter cannot be gathered.
- print out an error message only in error case excepting -EPROBE_DEFER.

mediatek:
- overlay, cursor and gce fixes.
`

----------------------------------------------------------------
Ahzo (1):
      drm/ttm: fix leaking fences via ttm_buffer_object_transfer

Bhawanpreet Lakha (1):
      drm/amd/display: Clear link settings on MST disable connector

Bibby Hsieh (4):
      drm/mediatek: Add plane check in async_check function
      drm/mediatek: Add fb swap in async_update
      drm/mediatek: Move gce event property to mutex device node
      drm/mediatek: Make sure previous message done or be aborted before se=
nd

Chris Wilson (4):
      drm/i915/gem: Break up long lists of object reclaim
      drm/i915: Protect i915_request_await_start from early waits
      drm/i915/perf: Reintroduce wait on OA configuration completion
      drm/i915/gt: Drop the timeline->mutex as we wait for retirement

Cong Wang (1):
      dma-buf: free dmabuf->name in dma_buf_release()

Dan Carpenter (1):
      drm/i915/selftests: Fix return in assert_mmap_offset()

Dave Airlie (5):
      Merge tag 'exynos-drm-fixes-for-v5.6-rc5' of
git://git.kernel.org/.../daeinki/drm-exynos into drm-fixes
      Merge tag 'mediatek-drm-fixes-5.6' of
https://github.com/ckhu-mediatek/linux.git-tags into drm-fixes
      Merge tag 'drm-misc-fixes-2020-03-05' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2020-03-05' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-5.6-2020-03-05' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes

Evan Benn (1):
      drm/mediatek: Find the cursor plane instead of hard coding it

Gerd Hoffmann (3):
      drm/shmem: add support for per object caching flags.
      drm/virtio: fix mmap page attributes
      drm/shmem: drop pgprot_decrypted()

Hersen Wu (1):
      drm/amdgpu/display: navi1x copy dcn watermark clock settings to
smu resume from s3 (v2)

Icenowy Zheng (1):
      drm/bridge: analogix-anx6345: fix set of link bandwidth

Jernej Skrabec (3):
      drm/sun4i: de2/de3: Remove unsupported VI layer formats
      drm/sun4i: Add separate DE3 VI layer formats
      drm/sun4i: Fix DE2 VI layer format support

John Bates (1):
      drm/virtio: fix resource id creation race

John Stultz (1):
      drm: kirin: Revert "Fix for hikey620 display offset problem"

Josip Pavic (1):
      drm/amd/display: fix dcc swath size calculations on dcn1

Jos=C3=A9 Roberto de Souza (1):
      drm/i915/psr: Force PSR probe only after full initialization

Lucas De Marchi (1):
      drm/i915/tgl: Add Wa_1608008084

Marek Szyprowski (3):
      drm/exynos: dsi: propagate error value and silence meaningless warnin=
g
      drm/exynos: dsi: fix workaround for the legacy clock name
      drm/exynos: hdmi: don't leak enable HDMI_EN regulator if probe fails

Matt Roper (2):
      drm/i915: Program MBUS with rmw during initialization
      drm/i915/tgl: Add Wa_22010178259:tgl

Phong LE (1):
      drm/mediatek: Handle component type MTK_DISP_OVL_2L correctly

Prike Liang (2):
      drm/amd/powerplay: fix pre-check condition for setting clock range
      drm/amd/powerplay: map mclk to fclk for COMBINATIONAL_BYPASS case

Sean Paul (1):
      drm/mediatek: Ensure the cursor plane is on top of other overlays

Tianci.Yin (1):
      drm/amdgpu: disable 3D pipe 1 on Navi1x

Tomeu Vizoso (1):
      drm/panfrost: Don't try to map on error faults

Yintian Tao (1):
      drm/amdgpu: clean wptr on wb when gpu recovery

 drivers/dma-buf/dma-buf.c                          |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |  98 ++++++++++-------=
--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  69 ++++++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |   1 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c    |   4 +-
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         |   2 +-
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c         |   6 +-
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c          |   3 -
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c |   3 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c             |  16 +++-
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |  12 ++-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |  22 +++--
 drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h    |   1 -
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c    |  20 ----
 drivers/gpu/drm/i915/display/intel_display_power.c |  29 +++++-
 drivers/gpu/drm/i915/display/intel_psr.c           |  25 ++++-
 drivers/gpu/drm/i915/display/intel_psr.h           |   1 +
 drivers/gpu/drm/i915/gem/i915_gem_object.c         |   1 +
 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c |   2 +-
 drivers/gpu/drm/i915/gt/intel_gt_requests.c        |  14 ++-
 drivers/gpu/drm/i915/gt/intel_workarounds.c        |  19 ++--
 drivers/gpu/drm/i915/i915_drv.c                    |   3 +
 drivers/gpu/drm/i915/i915_drv.h                    |   2 +-
 drivers/gpu/drm/i915/i915_perf.c                   |  58 ++++++++----
 drivers/gpu/drm/i915/i915_perf_types.h             |   3 +-
 drivers/gpu/drm/i915/i915_reg.h                    |   1 +
 drivers/gpu/drm/i915/i915_request.c                |  41 +++++---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |  30 ++++--
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        |   1 +
 drivers/gpu/drm/mediatek/mtk_drm_plane.c           |   7 ++
 drivers/gpu/drm/panfrost/panfrost_mmu.c            |  44 ++++-----
 drivers/gpu/drm/sun4i/sun8i_mixer.c                | 104 +++++++++++++++++=
+---
 drivers/gpu/drm/sun4i/sun8i_mixer.h                |  11 +++
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c             |  66 +++++++++++--
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |   1 +
 drivers/gpu/drm/virtio/virtgpu_object.c            |   5 +-
 include/drm/drm_gem_shmem_helper.h                 |   5 +
 38 files changed, 520 insertions(+), 212 deletions(-)
