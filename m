Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A85C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 21:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763792072F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 21:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2vwhUPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgDIVKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 17:10:45 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:33006 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgDIVKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 17:10:44 -0400
Received: by mail-ed1-f46.google.com with SMTP id z65so1828854ede.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 14:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=ImDQWxRWW9SOwmZB0n9hPAeyBxMIzIaaQZWsWc1epVg=;
        b=c2vwhUPXXuYGz3e+D2CkrIsaE5V+fuxFsy0plf2/hP223RRzPFeqPWwc6fKzBRb8ss
         74pwnYybbT+K5sTxp07DhHB381FKnmfJmwyuWAZwD3l/Pi49C+PoViluNan4Hlk4jhzo
         cinJYth3YMjONt0vHKJD7h8PSGjcI3B2hhD8WDtNb89ozVqxgrvNQ+dYBKMKN+5mNgcw
         ycwzdlVVJ8rd7RDD6AhldPHBvk5YJArz/uJ9Iumb/uaOBy7BKvz+/CThD8L7Il8ghm+G
         CIvP9lQezmycX9jubXkBQj+S5TCAcPs451kcgB4BTvVvIJeiJfMC/rI8kbCm77MnRCKy
         Cmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=ImDQWxRWW9SOwmZB0n9hPAeyBxMIzIaaQZWsWc1epVg=;
        b=Nip5hHnfZyQBGCE8lJ2PmwtGzgol1aC/yVMIc7aSaArlEmJV4csQ8MgtxI6ipPp/Ur
         C5shszdpxGSGfEBU6HLR4Wt02REH94ZoppF2ufHwhG8T69X3kTh3Xh7AUTkW+cE9EH5E
         DWXvxkcuCQz5rL04lYQtgyxAFzR+3BMATHJV+B1id53JkcYOCfm7g0J3BFinxCB0t25I
         148EPqUbzIFSzRhJhf1TJguQctq1tDikoseNgCJVYCeOPAEq20v4OZvt8Juuo8+Fw8Td
         UXIZT4grHWoqua4+ClKrK1Ysv1GeL5pEjUrBlANttA4cRFe4G7PuW5EWiNJPqJE3DqZv
         YRCQ==
X-Gm-Message-State: AGi0PuapgC3OEwdVvUJaT3mlC6oOQ/Pd1whBRDlN/WFXfWZEPnHOvzPp
        scLKroA5gYZ2afwyAGYqkDRD+ykxEkcstLLBR1U=
X-Google-Smtp-Source: APiQypJoNNQ6QkdYBKL4ifFwaYAWtu73oRykIC0rzcBgVx7MfFBgH2l3IRl6yPKOxA4IMhtJke8LAGWq6JsLhxf3wd8=
X-Received: by 2002:a17:906:af6f:: with SMTP id os15mr1013742ejb.78.1586466641059;
 Thu, 09 Apr 2020 14:10:41 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 10 Apr 2020 07:10:29 +1000
Message-ID: <CAPM=9tw-uwox1_LrO_9S=Fh_E+Syc9G2EtV9CehKvYWcKEMY+g@mail.gmail.com>
Subject: [git pull] drm fixes for 5.7-rc1 (part two)
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

As previously mentioned more fixes did turn up in the latter part of the we=
ek.

The drm_local_map build regression fix is here, along with temporary
disabling of the hugepage work due to some amdgpu related crashes.

Otherwise it's just a bunch of i915, and amdgpu fixes.

Have a good Easter!
Dave.

drm-next-2020-04-10:
drm fixes for 5.7-rc1 (part two)

legacy:
- fix drm_local_map.offset type

ttm:
- temporarily disable hugepages to debug amdgpu problems.

prime:
- fix sg extraction

amdgpu:
- Various Renoir fixes
- Fix gfx clockgating sequence on gfx10
- RAS fixes
- Avoid MST property creation after registration
- Various cursor/viewport fixes
- Fix a confusing log message about optional firmwares

i915:
- Flush all the reloc_gpu batch (Chris)
- Ignore readonly failures when updating relocs (Chris)
- Fill all the unused space in the GGTT (Chris)
- Return the right vswing table (Jose)
- Don't enable DDI IO power on a TypeC port in TBT mode for ICL+ (Imre)

analogix_dp:
- probe fix

virtio:
- oob fix in object create
The following changes since commit 12ab316ced2c5f32ced0e6300a054db644b5444a=
:

  Merge tag 'amd-drm-next-5.7-2020-04-01' of
git://people.freedesktop.org/~agd5f/linux into drm-next (2020-04-08
09:34:27 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-04-10

for you to fetch changes up to 74bd4f0c921cc9cf5f99ba4129dafe35496de6f3:

  Merge tag 'amd-drm-fixes-5.7-2020-04-08' of
git://people.freedesktop.org/~agd5f/linux into drm-next (2020-04-10
06:42:53 +1000)

----------------------------------------------------------------
drm fixes for 5.7-rc1 (part two)

legacy:
- fix drm_local_map.offset type

ttm:
- temporarily disable hugepages to debug amdgpu problems.

prime:
- fix sg extraction

amdgpu:
- Various Renoir fixes
- Fix gfx clockgating sequence on gfx10
- RAS fixes
- Avoid MST property creation after registration
- Various cursor/viewport fixes
- Fix a confusing log message about optional firmwares

i915:
- Flush all the reloc_gpu batch (Chris)
- Ignore readonly failures when updating relocs (Chris)
- Fill all the unused space in the GGTT (Chris)
- Return the right vswing table (Jose)
- Don't enable DDI IO power on a TypeC port in TBT mode for ICL+ (Imre)

analogix_dp:
- probe fix

virtio:
- oob fix in object create

----------------------------------------------------------------
Aaron Liu (1):
      drm/amdgpu: unify fw_write_wait for new gfx9 asics

Aaron Ma (1):
      drm/amdgpu: Fix oops when pp_funcs is unset in ACPI event

Alex Deucher (2):
      drm/amdgpu/psp: dont warn on missing optional TA's
      drm/amdgpu/display: fix warning when compiling without debugfs

Chengming Gui (1):
      drm/amd/amdgpu: Correct gfx10's CG sequence

Chris Wilson (4):
      drm/i915/gt: Fill all the unused space in the GGTT
      drm/i915/gem: Ignore readonly failures when updating relocs
      drm/i915/gem: Flush all the reloc_gpu batch
      drm/legacy: Fix type for drm_local_map.offset

Dave Airlie (3):
      Merge tag 'drm-misc-next-fixes-2020-04-09' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-intel-next-fixes-2020-04-08' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'amd-drm-fixes-5.7-2020-04-08' of
git://people.freedesktop.org/~agd5f/linux into drm-next

Eric Yang (1):
      drm/amd/display: change default pipe_split policy for DCN1

Evan Quan (1):
      drm/amd/powerplay: error out on forcing clock setting not supported

Imre Deak (1):
      drm/i915/icl+: Don't enable DDI IO power on a TypeC port in TBT mode

Isabel Zhang (1):
      drm/amd/display: Update stream adjust in dc_stream_adjust_vmin_vmax

Jerry (Fangzhi) Zuo (1):
      drm/amd/display: Avoid create MST prop after registration

Jiri Slaby (1):
      drm/virtio: fix OOB in virtio_gpu_object_create

John Clements (2):
      drm/amdgpu: resolve mGPU RAS query instability
      drm/amdgpu: update RAS related dmesg print

Joshua Aberback (1):
      drm/amd/display: Acknowledge wm_optimized_required

Jos=C3=A9 Roberto de Souza (1):
      drm/i915/dp: Return the right vswing tables

Likun Gao (1):
      drm/amdgpu: change SH MEM alignment mode for gfx10

Marek Szyprowski (2):
      drm/prime: fix extracting of the DMA addresses from a scatterlist
      drm/bridge: analogix_dp: Split bind() into probe() and real bind()

Maxime Ripard (1):
      Merge drm/drm-next into drm-misc-next-fixes

Michael Strauss (1):
      drm/amd/display: Check for null fclk voltage when parsing clock table

Nicholas Kazlauskas (5):
      drm/amd/display: Translate cursor position by source rect
      drm/amd/display: Fix incorrect cursor pos on scaled primary plane
      drm/amd/display: Program viewport when source pos changes for DCN20 h=
w seq
      drm/amd/display: Calculate scaling ratios on every medium/full update
      drm/amd/display: Make cursor source translation adjustment optional

Prike Liang (2):
      drm/amd/powerplay: implement the is_dpm_running()
      drm/amdgpu: fix gfx hang during suspend with video playback (v2)

Shirish S (1):
      drm/amd/display: re-order asic declarations

Thomas Hellstrom (VMware) (1):
      drm/ttm: Temporarily disable the huge_fault() callback

Tiecheng Zhou (1):
      drm/amd/powerplay: avoid using pm_en before it is initialized

Yuxian Dai (1):
      drm/amdgpu/powerplay: using the FCLK DPM table to set the MCLK

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  6 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            | 20 +++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             | 25 +++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c              |  6 ++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c            | 13 +++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 17 +++---
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  8 +++
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           | 20 +++++--
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |  2 +
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    | 17 ++++++
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  | 40 +++++++++++++-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |  1 +
 drivers/gpu/drm/amd/display/include/dal_asic_id.h  |  6 ++-
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c      |  3 +-
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       | 47 +++++++++++++++-
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c         | 18 +++++++
 drivers/gpu/drm/amd/powerplay/renoir_ppt.h         |  2 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 33 ++++++++----
 drivers/gpu/drm/drm_prime.c                        | 37 ++++++++-----
 drivers/gpu/drm/exynos/exynos_dp.c                 | 29 +++++-----
 drivers/gpu/drm/i915/display/intel_ddi.c           | 11 ++--
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c     | 14 ++---
 drivers/gpu/drm/i915/gt/intel_ggtt.c               | 37 +++++++++----
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    | 36 +++++++------
 drivers/gpu/drm/ttm/ttm_bo_vm.c                    | 63 ------------------=
----
 drivers/gpu/drm/virtio/virtgpu_object.c            | 14 ++---
 include/drm/bridge/analogix_dp.h                   |  5 +-
 include/drm/drm_legacy.h                           |  2 +-
 33 files changed, 354 insertions(+), 192 deletions(-)
