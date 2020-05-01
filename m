Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB6AC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 02:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13B3D20857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 02:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tjSxAd9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgEAC7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 22:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727889AbgEAC7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 22:59:24 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAAAC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 19:59:22 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r7so6285274edo.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 19:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=9BvwbukpJCOyWGz2Ayddnk6vUOMMJxko1agdrv37LLk=;
        b=tjSxAd9+dn65rQ65WKvySw3w+d/xep77yOA09bmRkud7KUuQTYkRvXa950i0jKF4As
         51RE0Y0PdqDrnA/xbn4thel9w2eQdsAdGWEXAWRNFYBHLZ8DQUJt1g/eqmipMftg2Vg4
         60H5BFW1HTC8E5hxEfSfDpwXQ7PhdDJPJV1WXbkXmhVKTT+lVspDaYk602hdkG3XS6ic
         Z7uFjsHElDzj3xpB+Y0Jzhc91lOEReE0cyuLPEzxRN0554pZchX2rd8hWxnyJlF7MY0D
         nbDAnJgL3PD3UNK7IuXKtRhXMS1uC04yA1yDRvwin4C3tBxj/FJ+h485O9J9kRuAH7My
         QhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=9BvwbukpJCOyWGz2Ayddnk6vUOMMJxko1agdrv37LLk=;
        b=X24Qyeun08A3kJIW2w1iVkNQV4aAo/e2LUaFItNuJ5lgZBpok0ecBzq6CImY1qofOv
         XPwl/8EQ0paANwp7zzoqTmmKD7EvzYMmrjse1cNEPF4iRkiTYUp/6d5lkAz062FOBZY3
         EqESJ1BAHJUhmpRhSk2huMxghXpPGjueq+7MsvXLz28CToZcF/wbaDwUoWw57RsqFuGf
         AbV7gGHXGPYVkdABKWGvGCr3maiQVj6pWWKVYyahTcYuX2gjgI+Hj2Ylz4Asaq4u/nP7
         zzzu4oHc4ta1EBgkfs2QYKjP6zo8N2sREKEZ6zVBX03Dn6h7m43ScKBVck176Nu1pe8x
         elpg==
X-Gm-Message-State: AGi0PuZegoZm65j6B+h69Dwf9TF52rvRGyv+QM3GRkQKcwQHamhla1/2
        FSQo9Z1C/62JhAVZFJJ+hbprCDgxlcDhZyVTeZM=
X-Google-Smtp-Source: APiQypJQ7DbJv+OIfVJf0+64V2IHEvnV5TtpT75PZot0BX6bosJ59XAEOc0aJ/N+IjgVcFsGbO6xb/Ln8Ut6qmESmkg=
X-Received: by 2002:a50:f1d6:: with SMTP id y22mr1755016edl.298.1588301961312;
 Thu, 30 Apr 2020 19:59:21 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 1 May 2020 12:59:10 +1000
Message-ID: <CAPM=9tzf-buFu3YY69tzLw=bwwYVD_37RiGazpFXz+OgayWfFw@mail.gmail.com>
Subject: [git pull] drm fixes for 5.7-rc4
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

Regular scheduled fixes pull for graphics. Nothing to extreme bunch of
amdgpu fixes, i915 and qxl fixes, along with some misc ones.

All seems to be progressing normally.

Dave.

drm-fixes-2020-05-01:
drm fixes for 5.7-rc4

core:
- EDID off by one DTD fix
- DP mst write return code fix

dma-buf:
- fix SET_NAME ioctl uapi
- doc fixes

amdgpu:
- Fix a green screen on resume issue
- PM fixes for SR-IOV
- SDMA fix for navi
- Renoir display fixes
- Cursor and pageflip stuttering fixes
- Misc additional display fixes
- (uapi) Add additional DCC tiling flags for navi1x

i915:
- Fix selftest refcnt leak (Xiyu)
- Fix gem vma lock (Chris)
- Fix gt's i915_request.timeline acquire by checking if cacheline is
valid (Chris)
- Fix IRQ postinistall fault masks (Matt)

qxl:
- use after gree fix
- fix lost kunmap
- release leak fix

virtio:
- context destruction fix
The following changes since commit 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c=
:

  Linux 5.7-rc3 (2020-04-26 13:51:02 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-05-01

for you to fetch changes up to e3dcd86b3b4c045a4db17c02340138a4c514fe20:

  Merge tag 'amd-drm-fixes-5.7-2020-04-29' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes (2020-05-01
11:19:55 +1000)

----------------------------------------------------------------
drm fixes for 5.7-rc4

core:
- EDID off by one DTD fix
- DP mst write return code fix

dma-buf:
- fix SET_NAME ioctl uapi
- doc fixes

amdgpu:
- Fix a green screen on resume issue
- PM fixes for SR-IOV
 SDMA fix for navi
- Renoir display fixes
- Cursor and pageflip stuttering fixes
- Misc additional display fixes
- (uapi) Add additional DCC tiling flags for navi1x

i915:
- Fix selftest refcnt leak (Xiyu)
- Fix gem vma lock (Chris)
- Fix gt's i915_request.timeline acquire by checking if cacheline is
valid (Chris)
- Fix IRQ postinistall fault masks (Matt)

qxl:
- use after gree fix
- fix lost kunmap
- release leak fix

virtio:
- context destruction fix

----------------------------------------------------------------
Aric Cyr (1):
      drm/amd/display: Use cursor locking to prevent flip delays

Aurabindo Pillai (1):
      drm/amd/display: DispalyPort: Write OUI only if panel supports it

Chris Wilson (2):
      drm/i915/gem: Hold obj->vma.lock over for_each_ggtt_vma()
      drm/i915/gt: Check cacheline is valid before acquiring

Daniel Vetter (1):
      dma-buf: Fix SET_NAME ioctl uapi

Dave Airlie (3):
      Merge tag 'drm-misc-fixes-2020-04-30' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2020-04-30' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-5.7-2020-04-29' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes

Dmytro Laktyushkin (2):
      drm/amd/display: check if REFCLK_CNTL register is present
      drm/amd/display: fix rn soc bb update

Gurchetan Singh (1):
      drm/virtio: only destroy created contexts

Lyude Paul (1):
      drm/dp_mst: Fix drm_dp_send_dpcd_write() return code

Marek Ol=C5=A1=C3=A1k (3):
      drm/amdgpu: add tiling flags from Mesa
      drm/amdgpu: invalidate L2 before SDMA IBs (v2)
      drm/amdgpu: bump version for invalidate L2 before SDMA IBs

Matt Roper (1):
      drm/i915: Use proper fault mask in interrupt postinstall too

Nicholas Kazlauskas (1):
      drm/amd/display: Defer cursor update around VUPDATE for all ASIC

Randy Dunlap (1):
      dma-buf: fix documentation build warnings

Rodrigo Siqueira (1):
      drm/amd/display: Fix green screen issue after suspend

Sung Lee (1):
      drm/amd/display: Update downspread percent to match spreadsheet for D=
CN2.1

Tiecheng Zhou (2):
      Revert "drm/amd/powerplay: avoid using pm_en before it is initialized=
"
      drm/amd/powerplay: avoid using pm_en before it is initialized revised

Vasily Averin (4):
      drm/qxl: qxl_release leak in qxl_draw_dirty_fb()
      drm/qxl: qxl_release leak in qxl_hw_surface_alloc()
      drm/qxl: lost qxl_bo_kunmap_atomic_page in qxl_image_init_helper()
      drm/qxl: qxl_release use after free

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/edid: Fix off-by-one in DispID DTD pixel clock

Xiaodong Yan (1):
      drm/amd/display: blank dp stream before re-train the link

Xiyu Yang (1):
      drm/i915/selftests: Fix i915_address_space refcnt leak

 drivers/dma-buf/dma-buf.c                          |  7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  3 +-
 drivers/gpu/drm/amd/amdgpu/navi10_sdma_pkt_open.h  | 16 +++++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c             | 14 +++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 38 ++++++++---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   | 27 ++++++++
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    | 40 ++---------
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |  1 +
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  | 10 +++
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h  |  1 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c  |  1 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c   | 15 +++++
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.h   | 20 ++++--
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  | 14 +++-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |  3 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c  |  1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c   |  1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.h   |  3 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |  4 ++
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c  |  1 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c  | 77 ++++++++++--------=
----
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h        | 16 +++++
 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h  |  1 +
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c      |  9 +--
 drivers/gpu/drm/drm_dp_mst_topology.c              |  8 ++-
 drivers/gpu/drm/drm_edid.c                         |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_tiling.c         | 20 +++++-
 drivers/gpu/drm/i915/gem/selftests/huge_pages.c    | 12 ++--
 drivers/gpu/drm/i915/gt/intel_timeline.c           |  2 +
 drivers/gpu/drm/i915/i915_irq.c                    |  6 +-
 drivers/gpu/drm/i915/i915_vma.c                    | 10 +--
 drivers/gpu/drm/qxl/qxl_cmd.c                      | 10 +--
 drivers/gpu/drm/qxl/qxl_display.c                  |  6 +-
 drivers/gpu/drm/qxl/qxl_draw.c                     |  7 +-
 drivers/gpu/drm/qxl/qxl_image.c                    |  3 +-
 drivers/gpu/drm/qxl/qxl_ioctl.c                    |  5 +-
 drivers/gpu/drm/virtio/virtgpu_kms.c               | 17 ++---
 include/linux/dma-buf.h                            |  3 +-
 include/uapi/drm/amdgpu_drm.h                      |  4 ++
 include/uapi/linux/dma-buf.h                       |  6 ++
 40 files changed, 290 insertions(+), 154 deletions(-)
