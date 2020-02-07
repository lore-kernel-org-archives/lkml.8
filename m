Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336DDC35247
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 03:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E582192A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 03:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBawjRjK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgBGDaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 22:30:03 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:41976 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgBGDaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 22:30:02 -0500
Received: by mail-ot1-f46.google.com with SMTP id r27so814946otc.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 19:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=7rcH5N/D5nkl9g+pKqnG3At/cesCrlmmNrhOINK5fjk=;
        b=ZBawjRjKk76jVjBC6icoJJ6Hhmfm5RDrhTLRQrfRzA6/yOlFx87zXZMm82n4m6I8ao
         pXVhoxC6DlKs5KipxwQb5ctNLaKxP04S+INlr+juHDCPDKryToHMZQyA56Y4QNZAt6ov
         5Y4i1c5VAQDBVrDCtX3jDfwIfpYQEbe9P4vX+0J8a7kAEtPd5OZYHtTE2ds3XTdnV5Xo
         3LEiExhF2jTx6nAenScHrCxSNbmmvKOk9thdWXrFw65kVzXWs6/j2ByLYMFo1g7Geh+r
         edReGTW0pdmmNhcrnB+IV14xGHTVrAFGcIKOxuhcEAsvnb/ztxCzm5pKPNSdrfR7wkKb
         8sFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=7rcH5N/D5nkl9g+pKqnG3At/cesCrlmmNrhOINK5fjk=;
        b=hpxoMinfp8p8/9LzBXJhvT9PhI6JXAkEBPioS6XNbVjIWOt8WWNobNb/iN4xq6aluI
         kvZ+erJDqVcG3Dg1FA44x+o6rGJX9cjNt1zgfds+1yzfIgbQ6Emg7wXO4ITlNtAplLPD
         lvx6UgCtPQWVeDatLnMV8Bx8Thr5PkMrE+lqP9nSUi/lEhHIrTj5Qj3xmG4sKXaS0rje
         /ADF7cbAp2BNbSjewI+CwmJOPjz8kwuAYVxd3pY1fEMxBueVYOt01vBXwazZkMu3gvQr
         tDud749JhPLoIA6Wm/SG86nHxbSr1HDAkVh/XeUVgxvLDq75Y752AvEyP+k/KJhneE7R
         6KoA==
X-Gm-Message-State: APjAAAWpCBl1KEKnROlGyBXKNsgyyvln2o76SlqHNcMNw2SKPm3ElthW
        zrCUkjOWV9VhB8NebXQZ1BNwE26gk2LOxM/NejsgJcbH
X-Google-Smtp-Source: APXvYqxJdw5tRp+KUCITV04TT4ZaxL+/WVl9LOFTIQ+06QT2vP9mbRejOuPVDyE+LLpGnqjjyrAQtUjbFpQp9DhCJyg=
X-Received: by 2002:a05:6830:2015:: with SMTP id e21mr1078100otp.106.1581046200951;
 Thu, 06 Feb 2020 19:30:00 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 7 Feb 2020 13:29:48 +1000
Message-ID: <CAPM=9tzWZoQ_t-v2p=m4LKFE+Mb9oofL406dLvaXOiappqcNhA@mail.gmail.com>
Subject: [git pull] drm fixes for 5.6-rc1
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

Just some fixes on top of the merge windows pull, the tegra changes
fix some regressions in the merge, nouveau has a few modesetting
fixes. The amdgpu fixes are bit bigger, but they contain a couple of
weeks of fixes, and doesn't seem to contain anything that isn't really
a fix.

Regards,
Dave.

drm-next-2020-02-04:
drm fixes for 5.6-rc1

The following changes since commit b45f1b3b585e195a7daead16d914e164310b1df6=
:

  Merge branch 'ttm-prot-fix' of
git://people.freedesktop.org/~thomash/linux into drm-next (2020-01-31
16:58:35 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-02-07

for you to fetch changes up to 9f880327160feb695de03caa29604883b0d00087:

  Merge tag 'amd-drm-next-5.6-2020-02-05' of
git://people.freedesktop.org/~agd5f/linux into drm-next (2020-02-07
12:29:36 +1000)

----------------------------------------------------------------
drm fixes for 5.6-rc1

tegra:
- merge window regression fixes

nouveau:
- couple of volta/turing modesetting fixes

amdgpu:
- EDC fixes for Arcturus
- GDDR6 memory training fixe
- Fix for reading gfx clockgating registers while in GFXOFF state
- i2c freq fixes
- Misc display fixes
- TLB invalidation fix when using semaphores
- VCN 2.5 instancing fixes
- Switch raven1 gfxoff to a blacklist
- Coreboot workaround for KV/KB
- Root cause dongle fixes for display and revert workaround
- Enable GPU reset for renoir and navi
- Navi overclocking fixes
- Fix up confusing warnings in display clock validation on raven

amdkfd:
- SDMA fix

radeon:
- Misc LUT fixes

----------------------------------------------------------------
Alex Deucher (12):
      drm/amdgpu: attempt to enable gfxoff on more raven1 boards (v2)
      drm/amdgpu: original raven doesn't support full asic reset
      drm/amdgpu: enable GPU reset by default on Navi
      drm/amdgpu: enable GPU reset by default on renoir
      drm/amdgpu/navi10: add mclk to navi10_get_clock_by_type_with_latency
      drm/amdgpu/navi: fix index for OD MCLK
      drm/amdgpu/navi10: add OD_RANGE for navi overclocking
      drm/amdgpu: fetch default VDDC curve voltages (v2)
      drm/amdgpu/display: handle multiple numbers of fclks in dcn_calcs.c (=
v2)
      drm/amdgpu/smu10: fix smu10_get_clock_by_type_with_latency
      drm/amdgpu/smu10: fix smu10_get_clock_by_type_with_voltage
      drm/amdgpu: update default voltage for boot od table for navi1x

Alex Sierra (1):
      drm/amdgpu: modify packet size for pm4 flush tlbs

Anthony Koo (1):
      drm/amd/display: Refactor to remove diags specific rgam func

Aric Cyr (1):
      drm/amd/display: 3.2.69

Ben Skeggs (3):
      drm/nouveau/disp/gv100-: halt
NV_PDISP_FE_RM_INTR_STAT_CTRL_DISP_ERROR storms
      drm/nouveau/kms/gv100-: move window ownership setup into modesetting =
path
      drm/nouveau/kms/gv100-: avoid sending a core update until the
first modeset

Bhawanpreet Lakha (1):
      drm/amd/display: Fix HW/SW state mismatch

Brandon Syu (1):
      drm/amd/display: fix rotation_angle to use enum values

Christian K=C3=B6nig (1):
      drm/amdgpu: add coreboot workaround for KV/KB

Colin Ian King (4):
      drm/amd/amdgpu: fix spelling mistake "to" -> "too"
      drm/amd/display: fix for-loop with incorrectly sized loop counter (v2=
)
      drm/amd/powerplay: fix spelling mistake "Attemp" -> "Attempt"
      drm/amd/display: fix spelling mistake link_integiry_check ->
link_integrity_check

Daniel Vetter (2):
      radeon: insert 10ms sleep in dce5_crtc_load_lut
      radeon: completely remove lut leftovers

Dave Airlie (3):
      Merge tag 'drm/tegra/for-5.6-rc1-fixes' of
git://anongit.freedesktop.org/tegra/linux into drm-next
      Merge branch 'linux-5.6' of git://github.com/skeggsb/linux into drm-n=
ext
      Merge tag 'amd-drm-next-5.6-2020-02-05' of
git://people.freedesktop.org/~agd5f/linux into drm-next

Dennis Li (6):
      drm/amdgpu: update mmhub 9.4.1 header files for Acrturus
      drm/amdgpu: enable RAS feature for more mmhub sub-blocks of Acrturus
      drm/amdgpu: refine the security check for RAS functions
      drm/amdgpu: abstract EDC counter clear to a separated function
      drm/amdgpu: add EDC counter registers of gc for Arcturus
      drm/amdgpu: add RAS support for the gfx block of Arcturus

Dor Askayo (1):
      drm/amd/display: do not allocate display_mode_lib unnecessarily

Evan Quan (1):
      drm/amd/powerplay: fix navi10 system intermittent reboot issue V2

Felix Kuehling (2):
      drm/amdgpu: Fix TLB invalidation request when using semaphore
      drm/amdgpu: Use the correct flush_type in flush_gpu_tlb_pasid

Haiyi Zhou (1):
      drm/amd/display: Fixed comment styling

Harry Wentland (2):
      drm/amd/display: Retrain dongles when SINK_COUNT becomes non-zero
      Revert "drm/amd/display: Don't skip link training for empty dongle"

Isabel Zhang (1):
      drm/amd/display: changed max_downscale_src_width to 4096.

James Zhu (5):
      drm/amdgpu/vcn: Share vcn_v2_0_dec_ring_test_ring to vcn2.5
      drm/amdgpu/vcn2.5: fix a bug for the 2nd vcn instance (v2)
      drm/amdgpu/vcn: fix vcn2.5 instance issue
      drm/amdgpu/vcn: fix typo error
      drm/amdgpu/vcn: use inst_idx relacing inst

Jerry (Fangzhi) Zuo (1):
      drm/amd/display: Fix DML dummyinteger types mismatch

John Clements (1):
      drm/amdgpu: added support to get mGPU DRAM base

Joseph Greathouse (1):
      drm/amdgpu: Enable DISABLE_BARRIER_WAITCNT for Arcturus

Lewis Huang (2):
      drm/amd/display: Refine i2c frequency calculating sequence
      drm/amd/display: init hw i2c speed

Lyude Paul (1):
      drm/amd/dm/mst: Ignore payload update failures

Matt Coffin (1):
      drm/amdgpu/smu_v11_0: Correct behavior of restoring default tables (v=
2)

Mikita Lipski (1):
      drm/amd/display: Fix a typo when computing dsc configuration

Nathan Chancellor (1):
      drm/amdgpu: Fix implicit enum conversion in gfx_v9_4_ras_error_inject

Nicholas Kazlauskas (8):
      drm/amd/display: Get fb base and fb offset for DMUB from registers
      drm/amd/display: Fallback to DMCUB when command table is missing
      drm/amd/display: Do DMCUB hw_init before DC
      drm/amd/display: Add hardware reset interface for DMUB service
      drm/amd/display: Call ATOM_INIT instead of ATOM_ENABLE for DMCUB
      drm/amd/display: Reset inbox rptr/wptr when resetting DMCUB
      drm/amd/display: Check hw_init state when determining if DMCUB
is initialized
      drm/amd/display: Only enable cursor on pipes that need it

Nirmoy Das (4):
      drm/amdgpu:  remove unnecessary conversion to bool
      drm/amdgpu: individualize fence allocation per entity
      drm/amdgpu: fix doc by clarifying sched_list definition
      drm/amdgpu: allocate entities on demand

Paul Hsieh (1):
      drm/amd/display: check pipe_ctx is split pipe or not

Roman Li (1):
      drm/amd/display: Fix update type for multiple planes

Stephen Rothwell (1):
      amdgpu: using vmalloc requires includeing vmalloc.h

Sung Lee (1):
      drm/amd/display: Do not send training pattern if VS Different

Thierry Reding (6):
      drm/tegra: sor: Suspend on clock registration failure
      drm/tegra: sor: Disable runtime PM on probe failure
      drm/tegra: sor: Initialize runtime PM before use
      drm/tegra: Relax IOMMU usage criteria on old Tegra
      drm/tegra: Reuse IOVA mapping where possible
      gpu: host1x: Set DMA direction only for DMA-mapped buffer objects

Tianci.Yin (2):
      drm/amdgpu: fix VRAM partially encroached issue in GDDR6 memory
training(V2)
      Revert "drm/amdgpu: fix modprobe failure of the secondary GPU
when GDDR6 training enabled(V5)"

Wenjing Liu (4):
      drm/amd/display: update MSA and VSC SDP on video test pattern request
      drm/amd/display: Add debug option to disable DSC support
      drm/amd/display: support VSC SDP update on video test pattern request
      drm/amd/display: use odm combine for YCbCr420 timing with
h_active greater than 4096

Yong Zhao (1):
      drm/amdkfd: Fix a bug in SDMA RLC queue counting under HWS mode

Zhan Liu (1):
      drm/amd/display: Move drm_dp_mst_atomic_check() to the front of
dc_validate_global_state()

chen gong (3):
      drm/amdgpu: provide a generic function interface for
reading/writing register by KIQ
      drm/amdgpu: add kiq version interface for RREG32/WREG32
      drm/amdgpu: read gfx register using RREG32_KIQ macro

xinhui pan (1):
      drm/amdgpu: initialize bo_va_list when add gws to process

zhengbin (1):
      drm/amd/powerplay: use true, false for bool variable in smu7_hwmgr.c

 drivers/gpu/drm/amd/amdgpu/Makefile                |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c            |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            | 229 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h            |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_df.h             |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |  96 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |   5 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |  20 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h            |  26 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |  92 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h           |   2 -
 drivers/gpu/drm/amd/amdgpu/athub_v1_0.c            |   4 +-
 drivers/gpu/drm/amd/amdgpu/athub_v2_0.c            |   4 +-
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c               |  59 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |  11 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |   5 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              | 220 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c              | 978 +++++++++++++++++=
++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h              |  35 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |  39 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |   3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |  15 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c            |   4 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c            |   4 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c            | 705 ++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/nv.c                    |   8 +-
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c             |  37 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |   4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c             |   4 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c                |   2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |  32 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c              |   2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c              |   2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              |   2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c              |   2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |   2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c              |   4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.h              |   1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c              | 105 +--
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c             |   2 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  10 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  82 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |  19 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  13 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |   2 +-
 .../gpu/drm/amd/display/dc/bios/command_table2.c   |  78 +-
 drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c   |  34 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  17 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |  30 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |  42 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |   3 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c    |  73 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.h    |   1 -
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |  30 +
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c  |  12 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c  |   2 +-
 .../amd/display/dc/dml/dcn20/display_mode_vba_20.c |  19 +-
 .../display/dc/dml/dcn20/display_mode_vba_20v2.c   |  24 +-
 .../amd/display/dc/dml/dcn21/display_mode_vba_21.c |  24 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.h  |   4 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c        |   3 +-
 drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h    |  17 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c  |  25 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h  |   8 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    |  19 +
 .../drm/amd/display/modules/color/color_gamma.c    | 307 +++----
 .../drm/amd/display/modules/color/color_gamma.h    |   4 -
 .../drm/amd/display/modules/freesync/freesync.c    |   2 +-
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h    |   2 +-
 .../drm/amd/display/modules/hdcp/hdcp1_execution.c |   8 +-
 .../amd/display/modules/hdcp/hdcp1_transition.c    |   4 +-
 .../drm/amd/include/asic_reg/df/df_3_6_offset.h    |   3 +
 .../drm/amd/include/asic_reg/df/df_3_6_sh_mask.h   |   8 +
 .../drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h   |   6 +-
 .../drm/amd/include/asic_reg/gc/gc_9_4_1_offset.h  | 264 ++++++
 .../drm/amd/include/asic_reg/gc/gc_9_4_1_sh_mask.h | 748 ++++++++++++++++
 .../include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h   | 128 +++
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         |  18 +
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c  |  23 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |   6 +-
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h     |   2 +
 drivers/gpu/drm/amd/powerplay/inc/smu_types.h      |   2 +
 .../gpu/drm/amd/powerplay/inc/smu_v11_0_ppsmc.h    |   5 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         | 187 +++-
 drivers/gpu/drm/amd/powerplay/smu_internal.h       |   3 +
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c          |   6 +
 .../gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c   |  12 +-
 .../gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c   |  12 +-
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c         |  28 +-
 drivers/gpu/drm/nouveau/dispnv50/core.h            |   6 +
 drivers/gpu/drm/nouveau/dispnv50/corec37d.c        |  23 +-
 drivers/gpu/drm/nouveau/dispnv50/corec57d.c        |   9 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |  16 +
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c   |   6 +
 drivers/gpu/drm/radeon/radeon_display.c            |   9 +-
 drivers/gpu/drm/radeon/radeon_mode.h               |   1 -
 drivers/gpu/drm/scheduler/sched_entity.c           |   2 +-
 drivers/gpu/drm/tegra/drm.c                        |  49 +-
 drivers/gpu/drm/tegra/gem.c                        |  10 +-
 drivers/gpu/drm/tegra/plane.c                      |  44 +-
 drivers/gpu/drm/tegra/sor.c                        |  49 +-
 drivers/gpu/host1x/job.c                           |  34 +-
 include/drm/gpu_scheduler.h                        |   5 +-
 112 files changed, 4510 insertions(+), 942 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_1_offset=
.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_1_sh_mas=
k.h
