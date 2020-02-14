Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0268CC3B194
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 04:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8637206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 04:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wy8zSwLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgBNEQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 23:16:08 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:35118 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbgBNEQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 23:16:08 -0500
Received: by mail-wm1-f44.google.com with SMTP id b17so9142536wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 20:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=JsvSb1OTZBCAS9UwkfFT2iSw7XGG3ILzU9EUajBTbPI=;
        b=Wy8zSwLqgzhOpiKTRmsYMIV33bLle9+WHROty4DKm1NnLz/4041kDkujh6Tz3JLdEP
         cG9CBulANRF7DhNSBdzrmGBm/e7o+oBfaGmvxDs3BkewAGmMVF86+upXxt3M0eAdAc+V
         8ISNsZz5WSqdvmKTguWH539mI5zKk+TfL+ie9muIabGUJKjcoLEpZIRG8ZY6LIjvDwnQ
         2mVYmBehtcesnqblypKpZn21R98DbkRgG5uA2dLcq16zPmq1GeWdkQqP9O8xBp/ewk3q
         O+pn96hHyXeUNUMtEheYhF8uW8nTbxv63BredVLun6/DsrI0Yj6Lm5Zht+6DxQ02uWar
         hsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=JsvSb1OTZBCAS9UwkfFT2iSw7XGG3ILzU9EUajBTbPI=;
        b=s7KcIb5dEAj3JepOtUPOx5S7hjZYEoy/leh+tA7SRm0mLn2MTXJvzBYwmFjx3X5Nen
         5yVgnP4e3XasMZ9HxwD86haAKZAbKUlDjcCzh/vT6IxVxf+eRCslgvyaBdQjqOML1R0a
         W2Ktfl935h8pjwz8daAeIc2GAFSk7+zieXhTd0e7i99O/9zhETXjtLVZvBegpS8JxcVs
         3+8ku8f2PSHTVxyLgKWIj0jy66GPVeN2/NED7PcDiGQyhfklQw8kBhqG88DXFlZagALh
         XxhAN5TnFifO2ENI67wOWbs/gLp9E8DVVvfFMpj05AVMQKk87RP4cjU+GxIF7UlcuiY8
         nWMA==
X-Gm-Message-State: APjAAAV3pa9JhesQtRgsv9fPpXytUcobonuL6cH9nQ8b0eYfAXF8f26t
        O2etwaF091DbCIpqUqW/PONy2oH+f+zPVxoZ9z4=
X-Google-Smtp-Source: APXvYqzOsVKhzsjZjUpndoiiRV/arzg1UyTHHdOoZf5YDq4eMCVCcWDkCsD+7TIe8h4MZBzBXc9LClQ+dujSTruNtBw=
X-Received: by 2002:a1c:113:: with SMTP id 19mr1950579wmb.95.1581653765334;
 Thu, 13 Feb 2020 20:16:05 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 14 Feb 2020 14:15:53 +1000
Message-ID: <CAPM=9tzpGGiPB7oOkhjEn9MifjjVQ4TdH4GTtJeBf74SBn-NKg@mail.gmail.com>
Subject: [git pull] drm fixes for 5.6-rc2
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

This week's fixes ready for rc2. The core has a build fix for edid
code on certain compilers/arches/, one MST fix and one vgem fix.
Regular amdgpu fixes, and a couple of small driver fixes. The i915
fixes are bit larger than normal for this stage, but they were having
CI issues last week, and they hadn't sent any fixes last week due to
this.

Regards,
Dave.

drm-fixes-2020-02-14:
drm fixes for 5.6-rc2

core:
- edid build fix

mst:
- fix NULL ptr deref

vgem:
- fix close after free

msm:
- better dma-api usage

sun4i:
- disable allow_fb_modifiers

amdgpu:
- Additional OD fixes for navi
- Misc display fixes
- VCN 2.5 DPG fix
- Prevent build errors on PowerPC on some configs
- GDS EDC fix

i915:
- dsi/acpi fixes
- gvt locking and allocation fixes
- gem/gt fixes
- bios timing parameters fix
The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9=
:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-02-14

for you to fetch changes up to 6f4134b30b6ee33e2fd4d602099e6c5e60d0351a:

  Merge tag 'drm-intel-next-fixes-2020-02-13' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2020-02-14
13:04:46 +1000)

----------------------------------------------------------------
drm fixes for 5.6-rc2

core:
- edid build fix

mst:
- fix NULL ptr deref

vgem:
- fix close after free

msm:
- better dma-api usage

sun4i:
- disable allow_fb_modifiers

amdgpu:
- Additional OD fixes for navi
- Misc display fixes
- VCN 2.5 DPG fix
- Prevent build errors on PowerPC on some configs
- GDS EDC fix

i915:
- dsi/acpi fixes
- gvt locking and allocation fixes
- gem/gt fixes
- bios timing parameters fix

----------------------------------------------------------------
Alex Deucher (2):
      drm/amdgpu: update smu_v11_0_pptable.h
      drm/amdgpu:/navi10: use the ODCAP enum to index the caps array

Aric Cyr (1):
      drm/amd/display: Check engine is not NULL before acquiring

Boris Brezillon (1):
      drm/panfrost: Make sure the shrinker does not reclaim referenced BOs

Chris Wilson (19):
      drm/i915/pmu: Correct the rc6 offset upon enabling
      drm/i915/gem: Take local vma references for the parser
      drm/i915/selftests: Add a mock i915_vma to the mock_ring
      drm/i915/gt: Use the BIT when checking the flags, not the index
      drm/i915/execlists: Leave resetting ring to intel_ring
      drm/i915/gem: Store mmap_offsets in an rbtree rather than a plain lis=
t
      drm/i915: Don't show the blank process name for internal/simulated er=
rors
      drm/i915/gem: Detect overflow in calculating dumb buffer size
      drm/i915: Check activity on i915_vma after confirming pin_count=3D=3D=
0
      drm/i915: Stub out i915_gpu_coredump_put
      drm/i915: Tighten atomicity of i915_active_acquire vs i915_active_rel=
ease
      drm/i915/gt: Acquire ce->active before ce->pin_count/ce->pin_mutex
      drm/i915/gem: Tighten checks and acquiring the mmap object
      drm/i915: Keep track of request among the scheduling lists
      drm/i915/gt: Allow temporary suspension of inflight requests
      drm/i915/execlists: Offline error capture
      drm/i915/execlists: Take a reference while capturing the guilty reque=
st
      drm/i915/execlists: Reclaim the hanging virtual request
      drm/i915: Mark the removal of the i915_request from the sched.link

Daniel Kolesa (1):
      amdgpu: Prevent build errors regarding soft/hard-float FP ABI tags

Daniel Vetter (1):
      drm/vgem: Close use-after-free race in vgem_gem_create

Dave Airlie (4):
      Merge tag 'drm-misc-fixes-2020-02-07' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-misc-next-fixes-2020-02-07' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'amd-drm-fixes-5.6-2020-02-12' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-intel-next-fixes-2020-02-13' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Guchun Chen (2):
      drm/amdgpu: limit GDS clearing workaround in cold boot sequence
      drm/amdgpu: correct comment to clear up the confusion

Igor Druzhinin (2):
      drm/i915/gvt: fix high-order allocation failure on late load
      drm/i915/gvt: more locking for ppgtt mm LRU list

Isabel Zhang (1):
      drm/amd/display: Add initialitions for PLL2 clock source

James Zhu (2):
      drm/amdgpu/vcn2.5: fix DPG mode power off issue on instance 1
      drm/amdgpu/vcn2.5: fix warning

Jani Nikula (1):
      Merge tag 'gvt-fixes-2020-02-12' of
https://github.com/intel/gvt-linux into drm-intel-next-fixes

Jernej Skrabec (1):
      Revert "drm/sun4i: drv: Allow framebuffer modifiers in mode config"

Jonathan Kim (1):
      drm/amdgpu: fix amdgpu pmu to use hwc->config instead of hwc->conf

Jos=C3=A9 Roberto de Souza (2):
      drm/mst: Fix possible NULL pointer dereference in
drm_dp_mst_process_up_req()
      drm/i915: Fix preallocated barrier list append

Mauro Rossi (1):
      drm/edid: fix building error

Nicholas Kazlauskas (1):
      drm/amd/display: Don't map ATOM_ENABLE to ATOM_INIT

Roman Li (1):
      drm/amd/display: Fix psr static frames calculation

Sean Paul (1):
      drm/msm: Set dma maximum segment size for mdss

Sung Lee (3):
      drm/amd/display: Do not set optimized_require to false after plane di=
sable
      drm/amd/display: Use dcfclk to populate watermark ranges
      drm/amd/display: DCN2.x Do not program DPPCLK if same value

Vandita Kulkarni (1):
      drm/i915/bios: Fix the timing parameters

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915: Fix post-fastset modeset check for port sync
      drm/i915: Make a copy of the ggtt view for slave plane

Vivek Kasireddy (2):
      drm/i915/dsi: Lookup the i2c bus from ACPI NS only if CONFIG_ACPI=3Dy=
 (v2)
      drm/i915/dsi: Ensure that the ACPI adapter lookup overrides the bus n=
um

Yongqiang Sun (1):
      drm/amd/display: Limit minimum DPPCLK to 100MHz.

Zhang Xiaoxu (1):
      drm/i915: Fix i915_error_state_store error defination

 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c            |  15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h            |   3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  14 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |  14 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c              |   6 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c              |   8 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   5 +-
 .../gpu/drm/amd/display/dc/bios/command_table2.c   |   4 -
 drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile    |   6 +
 .../amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c   |   2 +-
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  |  20 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c       |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |   1 -
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c  |   6 +
 .../gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h  |  46 ++-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         |  22 +-
 drivers/gpu/drm/drm_dp_mst_topology.c              |   3 +-
 drivers/gpu/drm/drm_edid.c                         |   2 +-
 drivers/gpu/drm/i915/display/intel_bios.c          |   6 +-
 drivers/gpu/drm/i915/display/intel_display.c       |  44 ++-
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c       |  50 +--
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c     |  37 ++-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c           | 129 +++++---
 drivers/gpu/drm/i915/gem/i915_gem_object.c         |  18 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.h         |  12 +-
 drivers/gpu/drm/i915/gem/i915_gem_object_types.h   |   6 +-
 drivers/gpu/drm/i915/gt/intel_context.c            |  46 +--
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          |  13 +
 drivers/gpu/drm/i915/gt/intel_engine_types.h       |   1 +
 drivers/gpu/drm/i915/gt/intel_lrc.c                | 354 +++++++++++++++++=
+++-
 drivers/gpu/drm/i915/gt/mock_engine.c              |  17 +-
 drivers/gpu/drm/i915/gt/selftest_lrc.c             | 258 +++++++++++++++
 drivers/gpu/drm/i915/gvt/firmware.c                |   4 +-
 drivers/gpu/drm/i915/gvt/gtt.c                     |   4 +
 drivers/gpu/drm/i915/i915_active.c                 |  35 +-
 drivers/gpu/drm/i915/i915_active.h                 |   6 +
 drivers/gpu/drm/i915/i915_gem.c                    |   5 +-
 drivers/gpu/drm/i915/i915_gpu_error.c              |   2 +-
 drivers/gpu/drm/i915/i915_gpu_error.h              |   7 +-
 drivers/gpu/drm/i915/i915_pmu.c                    |  12 +
 drivers/gpu/drm/i915/i915_request.c                |   6 +-
 drivers/gpu/drm/i915/i915_request.h                |  60 ++++
 drivers/gpu/drm/i915/i915_scheduler.c              |  22 +-
 drivers/gpu/drm/i915/i915_vma.c                    |  14 +-
 drivers/gpu/drm/msm/msm_drv.c                      |   8 +
 drivers/gpu/drm/panfrost/panfrost_drv.c            |   1 +
 drivers/gpu/drm/panfrost/panfrost_gem.h            |   6 +
 drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c   |   3 +
 drivers/gpu/drm/panfrost/panfrost_job.c            |   7 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |   1 -
 drivers/gpu/drm/vgem/vgem_drv.c                    |   9 +-
 51 files changed, 1131 insertions(+), 251 deletions(-)
