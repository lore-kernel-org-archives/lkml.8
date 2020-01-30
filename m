Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A1EC33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 05:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A5F2067C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 05:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTr/pcgE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgA3F64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 00:58:56 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:40761 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgA3F6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 00:58:55 -0500
Received: by mail-lj1-f181.google.com with SMTP id n18so1942985ljo.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 21:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=Hs0xUuGTKEhsGZ+dwNL+owrBj7yRBfCY7rw4mKnEzLQ=;
        b=oTr/pcgEx7a2Jx1v0+oJV/9k2eVsT0BSDdoiThoGdgcZB3tF4paG6lsHzYRev/he0I
         qzx+qqy60u9igz9V5nFNDqbeeUctGKq67Ov+jG5lGXKVt8wPD7VdbuSpqldbFsLopRDm
         sQDYcbC2hes/pBmhcTfi1tmh4r9dFu1115zvdrMCHU5l0Ov371BKdtTpkmsXPsCe7x+2
         tZx76YLFMrDVCXPgGPfFNgkLyqghujxunkwL0a8J+Ju5quOWG4SO1fZgtTJ9UNUwuuyW
         o37WArSY2bcdc/K1RmqRb04pCzcPwvzhSJj3Vwqw7NWt9O4LtYxdy74D+HOI2bgaK4Ig
         /Ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=Hs0xUuGTKEhsGZ+dwNL+owrBj7yRBfCY7rw4mKnEzLQ=;
        b=fKgr5B0LhTioQ4BzR6Flotx7GvBS7vyOJCJWf4NPP03izWCjCSDOjzV7oDT5MpJpou
         N2AeBf01kaJDuyuQ6k/fXNTj8q+bL7n0JLOvRXRPxHCrDwsYibkxrE4aUM+ZCDBDpRTN
         fFZK57yFau26LD33Z4biHtM6zYA1n+PpIbNdsayFusHvrHHPHT7TQT0UcMluCczHgRqu
         GaUT+DdyWqIogG56Iw4LyhRW/65Nol5Ck8Mb8pqgOnpe1oQrPdqs2c4yg9KclXk5yR6b
         +hqTcCpeRFTfA8TKuSA4mfO0l8rwAEMRk2v3Z/rVr5IewmcMm11XFUqALplWj0Xk0o4x
         HQvw==
X-Gm-Message-State: APjAAAV50vTmzupUmqdMqnYn9nTeG6GmeSm369vqYNVjmwmc+0W7cg8H
        uHMJx1JBOdifv0f9/QbXQ/FEHNmXm9P6CzRsC7E=
X-Google-Smtp-Source: APXvYqxGSigWdhfgVA2J3mlEC6WJJG2sHstr96AYUWw86cdIBg2NlBubxSamQ+Yeezyj2/8ObiZLSV9xbqmBhyVLFDE=
X-Received: by 2002:a2e:548:: with SMTP id 69mr1767151ljf.67.1580363913622;
 Wed, 29 Jan 2020 21:58:33 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 30 Jan 2020 15:58:11 +1000
Message-ID: <CAPM=9twBvYvUoijdzAi2=FGLys0pfaK+PZw-uq2kyxqZipeujA@mail.gmail.com>
Subject: [git pull] drm for 5.6-rc1
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

This is the main pull request for graphics for 5.6. Usual selection of
changes all over.

It has two known conflicts, one in i915_gem_gtt, where you should juat
take what's in the pull (it looks messier than it is), and one due to
ioremap_nocache removal, link below with a patch from sfr.

https://lore.kernel.org/lkml/20200108170803.1c91b20d@canb.auug.org.au/

I've got one outstanding vmwgfx pull that touches mm so kept it
separate until after all of this lands. I'll try and get it to you
soon after this, but it might be early next week. (nothing wrong with
code, just my schedule is messy.)

This also hits a lot of fbdev drivers with some cleanups.

Other notables:
- vulkan timeline semaphore support added to syncobjs
- nouveau turing secureboot/graphics support
- Displayport MST display stream compression support

Regards,
Dave.

drm-next-2020-01-30:
drm pull for 5.6-rc1

uapi:
- dma-buf heaps added (and fixed)
- command line add support for panel oreientation
- command line allow overriding penguin count

drm:
- mipi dsi definition updates
- lockdep annotations for dma_resv
- remove dma-buf kmap/kunmap support
- constify fb_ops in all fbdev drivers
- MST fix for daisy chained hotplug-
- CTA-861-G modes with VIC >=3D 193 added
- fix drm_panel_of_backlight export
- LVDS decoder support
- more device based logging support
- scanline alighment for dumb buffers
- MST DSC helpers

scheduler:
- documentation fixes
- job distribution improvements

panel:
- Logic PD type 28 panel support
- Jimax8729d MIPI-DSI
- igenic JZ4770
- generic DSI devicetree bindings
- sony acx424AKP panel
- Leadtek LTK500HD1829
- xinpeng XPP055C272
- AUO B116XAK01
- GiantPlus GPM940B0
- BOE NV140FHM-N49
- Satoz SAT050AT40H12R2
- Sharp LS020B1DD01D panels.

ttm:
- use blocking WW lock

i915:
- hw/uapi state separation
- Lock annotation improvements
- selftest improvements
- ICL/TGL DSI VDSC support
- VBT parsing improvments
- Display refactoring
- DSI updates + fixes
- HDCP 2.2 for CFL
- CML PCI ID fixes
- GLK+ fbc fix
- PSR fixes
- GEN/GT refactor improvments
- DP MST fixes
- switch context id alloc to xarray
- workaround updates
- LMEM debugfs support
- tiled monitor fixes
- ICL+ clock gating programming removed
- DP MST disable sequence fixed
- LMEM discontiguous object maps
- prefaulting for discontiguous objects
- use LMEM for dumb buffers if possible
- add LMEM mmap support

amdgpu:
- enable sync object timelines for vulkan
- MST atomic routines
- enable MST DSC support
- add DMCUB display microengine support
- DC OEM i2c support
- Renoir DC fixes
- Initial HDCP 2.x support
- BACO support for Arcturus
- Use BACO for runtime PM power save
- gfxoff on navi10
- gfx10 golden updates and fixes
- DCN support on POWER
- GFXOFF for raven1 refresh
- MM engine idle handlers cleanup
- 10bpc EDP panel fixes
- renoir watermark fixes
- SR-IOV fixes
- Arcturus VCN fixes
- GDDR6 training fixes
- freesync fixes
- Pollock support

amdkfd:
- unify more codepath with amdgpu
- use KIQ to setup HIQ rather than MMIO

radeon:
- fix vma fault handler race
- PPC DMA fix
- register check fixes for r100/r200

nouveau:
- mmap_sem vs dma_resv fix
- rewrite the ACR secure boot code for Turing
- TU10x graphics engine support (TU11x pending)
- Page kind mapping for turing
- 10-bit LUT support
- GP10B Tegra fixes
- HD audio regression fix

hisilicon/hibmc:
- use generic fbdev code and helpers

rockchip:
- dsi/px30 support

virtio:
- fb damage support
- static some functions

vc4:
- use dma_resv lock wrappers

msm:
- use dma_resv lock wrappers
- sc7180 display + DSI support
- a618 support
- UBWC support improvements

vmwgfx:
- updates + new logging uapi

exynos:
- enable/disable callback cleanups

etnaviv:
- use dma_resv lock wrappers

atmel-hlcdc:
- clock fixes

mediatek:
- cmdq support
- non-smooth cursor fixes
- ctm property support

sun4i:
- suspend support
- A64 mipi dsi support

rcar-du:
- Color management module support
- LVDS encoder dual-link support
- R8A77980 support

analogic:
- add support for an6345

ast:
- atomic modeset support
- primary plane garbage fix

arcgpu:
- fixes for fourcc handling

tegra:
- minor fixes and improvments

mcde:
- vblank support

meson:
- OSD1 plane AFBC commit

gma500:
- add pageflip support
- reomve global drm_dev

komeda:
- tweak debugfs output
- d32 support
- runtime PM suppotr

udl:
- use generic shmem helpers
- cleanup and fixes
The following changes since commit def9d2780727cec3313ed3522d0123158d87224d=
:

  Linux 5.5-rc7 (2020-01-19 16:02:49 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-01-30

for you to fetch changes up to d47c7f06268082bc0082a15297a07c0da59b0fc4:

  Merge branch 'linux-5.6' of git://github.com/skeggsb/linux into
drm-next (2020-01-30 15:18:38 +1000)

----------------------------------------------------------------
drm pull for 5.6-rc1

uapi:
- dma-buf heaps added (and fixed)
- command line add support for panel oreientation
- command line allow overriding penguin count

drm:
- mipi dsi definition updates
- lockdep annotations for dma_resv
- remove dma-buf kmap/kunmap support
- constify fb_ops in all fbdev drivers
- MST fix for daisy chained hotplug-
- CTA-861-G modes with VIC >=3D 193 added
- fix drm_panel_of_backlight export
- LVDS decoder support
- more device based logging support
- scanline alighment for dumb buffers
- MST DSC helpers

scheduler:
- documentation fixes
- job distribution improvements

panel:
- Logic PD type 28 panel support
- Jimax8729d MIPI-DSI
- igenic JZ4770
- generic DSI devicetree bindings
- sony acx424AKP panel
- Leadtek LTK500HD1829
- xinpeng XPP055C272
- AUO B116XAK01
- GiantPlus GPM940B0
- BOE NV140FHM-N49
- Satoz SAT050AT40H12R2
- Sharp LS020B1DD01D panels.

ttm:
- use blocking WW lock

i915:
- hw/uapi state separation
- Lock annotation improvements
- selftest improvements
- ICL/TGL DSI VDSC support
- VBT parsing improvments
- Display refactoring
- DSI updates + fixes
- HDCP 2.2 for CFL
- CML PCI ID fixes
- GLK+ fbc fix
- PSR fixes
- GEN/GT refactor improvments
- DP MST fixes
- switch context id alloc to xarray
- workaround updates
- LMEM debugfs support
- tiled monitor fixes
- ICL+ clock gating programming removed
- DP MST disable sequence fixed
- LMEM discontiguous object maps
- prefaulting for discontiguous objects
- use LMEM for dumb buffers if possible
- add LMEM mmap support

amdgpu:
- enable sync object timelines for vulkan
- MST atomic routines
- enable MST DSC support
- add DMCUB display microengine support
- DC OEM i2c support
- Renoir DC fixes
- Initial HDCP 2.x support
- BACO support for Arcturus
- Use BACO for runtime PM power save
- gfxoff on navi10
- gfx10 golden updates and fixes
- DCN support on POWER
- GFXOFF for raven1 refresh
- MM engine idle handlers cleanup
- 10bpc EDP panel fixes
- renoir watermark fixes
- SR-IOV fixes
- Arcturus VCN fixes
- GDDR6 training fixes
- freesync fixes
- Pollock support

amdkfd:
- unify more codepath with amdgpu
- use KIQ to setup HIQ rather than MMIO

radeon:
- fix vma fault handler race
- PPC DMA fix
- register check fixes for r100/r200

nouveau:
- mmap_sem vs dma_resv fix
- rewrite the ACR secure boot code for Turing
- TU10x graphics engine support (TU11x pending)
- Page kind mapping for turing
- 10-bit LUT support
- GP10B Tegra fixes
- HD audio regression fix

hisilicon/hibmc:
- use generic fbdev code and helpers

rockchip:
- dsi/px30 support

virtio:
- fb damage support
- static some functions

vc4:
- use dma_resv lock wrappers

msm:
- use dma_resv lock wrappers
- sc7180 display + DSI support
- a618 support
- UBWC support improvements

vmwgfx:
- updates + new logging uapi

exynos:
- enable/disable callback cleanups

etnaviv:
- use dma_resv lock wrappers

atmel-hlcdc:
- clock fixes

mediatek:
- cmdq support
- non-smooth cursor fixes
- ctm property support

sun4i:
- suspend support
- A64 mipi dsi support

rcar-du:
- Color management module support
- LVDS encoder dual-link support
- R8A77980 support

analogic:
- add support for an6345

ast:
- atomic modeset support
- primary plane garbage fix

arcgpu:
- fixes for fourcc handling

tegra:
- minor fixes and improvments

mcde:
- vblank support

meson:
- OSD1 plane AFBC commit

gma500:
- add pageflip support
- reomve global drm_dev

komeda:
- tweak debugfs output
- d32 support
- runtime PM suppotr

udl:
- use generic shmem helpers
- cleanup and fixes

----------------------------------------------------------------
Aaron Liu (3):
      drm/amd/powerplay: update SMU12_DRIVER_IF_VERSION to 11
      drm/amdgpu: update goldensetting for renoir
      drm/amdkfd: use kiq to load the mqd of hiq queue for gfx v9 (v6)

Abdiel Janulgue (4):
      drm/i915: Introduce DRM_I915_GEM_MMAP_OFFSET
      drm/i915: Introduce remap_io_sg() to prefault discontiguous objects
      drm/i915/gem: Extend mmap support for lmem
      drm/i915/selftests: Extend fault handler selftests to all memory regi=
ons

Adam Ford (2):
      dt-bindings: Add Logic PD Type 28 display panel
      drm/panel: simple: Add Logic PD Type 28 display support

Aditya Pakki (1):
      drm: remove duplicate check on parent and avoid BUG_ON

Aidan Yang (1):
      drm/amd/display: Disable integerscaling for downscale and MPO

Alex Deucher (68):
      drm/amdgpu/display: fix the build when CONFIG_DRM_AMD_DC_DCN is not s=
et
      drm/amdgpu/display: fix warning when CONFIG_DRM_AMD_DC_DCN is not set
      drm/amdgpu/soc15: move struct definition around to align with
other soc15 asics
      drm/amdgpu/nv: add asic func for fetching vbios from rom directly
      drm/amdgpu/powerplay: properly set PP_GFXOFF_MASK (v2)
      drm/amdgpu: disable gfxoff when using register read interface
      drm/amdgpu: remove experimental flag for Navi14
      drm/amdgpu: disable gfxoff on original raven
      Revert "drm/amd/display: enable S/G for RAVEN chip"
      drm/amdgpu: add asic callback for BACO support
      drm/amdgpu: add supports_baco callback for soc15 asics. (v2)
      drm/amdgpu: add supports_baco callback for SI asics.
      drm/amdgpu: add supports_baco callback for CIK asics.
      drm/amdgpu: add supports_baco callback for VI asics.
      drm/amdgpu: add supports_baco callback for NV asics.
      drm/amdgpu: add a amdgpu_device_supports_baco helper
      drm/amdgpu: rename amdgpu_device_is_px to amdgpu_device_supports_boco=
 (v2)
      drm/amdgpu: add additional boco checks to runtime suspend/resume (v2)
      drm/amdgpu: split swSMU baco_reset into enter and exit
      drm/amdgpu: add helpers for baco entry and exit
      drm/amdgpu: add baco support to runtime suspend/resume
      drm/amdgpu: start to disentangle boco from runtime pm
      drm/amdgpu: disentangle runtime pm and vga_switcheroo
      drm/amdgpu: enable runtime pm on BACO capable boards if runpm=3D1
      drm/amdgpu: simplify runtime suspend
      drm/amd/display: add default clocks if not able to fetch them
      MAINTAINERS: Drop Rex Zhu for amdgpu powerplay
      drm/amdgpu: move pci handling out of pm ops
      drm/amdgpu: flag vram lost on baco reset for VI/CIK
      drm/amd/display: re-enable wait in pipelock, but add timeout
      drm/radeon: fix r1xx/r2xx register checker for POT textures
      drm/amdgpu: add header line for power profile on Arcturus
      drm/amdgpu/display: add fallthrough comment
      drm/amdgpu: fix license on Kconfig and Makefiles
      drm/amdgpu/gfx10: make ring tests less chatty
      drm/amdgpu/sdma5: make ring tests less chatty
      drm/amdgpu/pm_runtime: update usage count in fence handling
      drm/amdgpu/smu: fix spelling
      drm/amdgpu: wait for all rings to drain before runtime suspending
      drm/amdgpu/smu: add metrics table lock
      drm/amdgpu/smu: add metrics table lock for arcturus (v2)
      drm/amdgpu/smu: add metrics table lock for navi (v2)
      drm/amdgpu/smu: add metrics table lock for renoir (v2)
      drm/amdgpu/smu: add metrics table lock for vega20 (v2)
      drm/amdgpu/display: include delay.h
      drm/amdgpu/display: include delay.h
      drm/amdgpu/display: use msleep rather than udelay for HDCP
      drm/amdgpu/smu/navi: Adjust default behavior for peak sclk profile
      drm/amdgpu/smu: add peak profile support for navi12
      Revert "drm/amdgpu: simplify ATPX detection"
      drm/amdgpu/smu: make the set_performance_level logic easier to follow
      drm/amdgpu/gmc: move invaliation bitmap setup to common code
      drm/amdgpu/gmc10: use common invalidation engine helper
      drm/amdgpu/gfx: simplify old firmware warning
      Revert "drm/amdgpu: Set no-retry as default."
      drm/amdgpu/display: protect new DSC code with CONFIG_DRM_AMD_DC_DCN
      drm/dp_mst: fix documentation of drm_dp_mst_add_affected_dsc_crtcs
      drm/amdgpu/powerplay: fix warning in smu_v11_0.c
      drm/amdgpu/gfx9: remove unused sdma headers
      drm/amdgpu/display: set gpu vm flag for all asics which support it
      drm/amdgpu: enable S/G display on PCO and RV2 (v2)
      drm/amdgpu/display: set gpu vm flag for renoir
      drm/amdgpu/gmc10: remove dead code
      drm/amdgpu/gmc10: free stolen memory in late_init
      drm/amdgpu/psp: declare navi1x ta firmware
      drm/amdgpu/pm: properly handle runtime pm
      drm/amdgpu/debugfs: properly handle runtime pm
      drm/amdgpu/pm: clean up return types

Alex Sierra (9):
      drm/amdgpu: add flag to indicate amdgpu vm context
      amd/amdgpu: force to trigger a no-retry-fault after a retry-fault
      drm/amdgpu: Avoid reclaim fs while eviction lock
      drm/amdgpu: kiq pm4 function implementation for gfx_v9
      drm/amdgpu: implement tlbs invalidate on gfx9 gfx10
      drm/amdgpu: replace kcq enable/disable functions on gfx_v9
      drm/amdgpu: export function to flush TLB via pasid
      drm/amdgpu: GPU TLB flush API moved to amdgpu_amdkfd
      drm/amdgpu: flush TLB functions removal from kfd2kgd interface

Alvin Lee (4):
      drm/amd/display: Changes in dc to allow full update in some cases
      drm/amd/display: Fix 300Hz Freesync bug
      drm/amd/display: Don't always set pstate true if dummy latency =3D 0
      drm/amd/display: Enable double buffer for OTG_BLANK

Amanda Liu (3):
      drm/amd/display: Fix screen tearing on vrr tests
      drm/amd/display: Reinstate LFC optimization
      drm/amd/display: Clear state after exiting fixed active VRR state

Andi Shyti (4):
      drm/i915/gt: Replace I915_READ with intel_uncore_read
      drm/i915/gt: Replace I915_WRITE with its uncore counterpart
      drm/i915/rps: Add frequency translation helpers
      drm/i915/gt: Move pm debug files into a gt aware debugfs

Andrew F. Davis (4):
      dma-buf: Add dma-buf heaps framework
      dma-buf: heaps: Use _IOCTL_ for userspace IOCTL identifier
      dma-buf: heaps: Remove redundant heap identifier from system heap nam=
e
      omapfb/dss: remove unneeded conversions to bool

Andrey Grodzovsky (7):
      drm/scheduler: Avoid accessing freed bad job.
      drm/amdgpu: Fix BACO entry failure in NAVI10.
      drm/amdgpu: reverts commit ce316fa55ef0f1751276b846a54fb3b835bd5e64.
      drm: Add Reusable task barrier.
      drm/amdgpu: Add task barrier to XGMI hive.
      drm/amdgpu: Redo XGMI reset synchronization.
      drm/amdgpu: Switch from system_highpri_wq to system_unbound_wq

Andrzej Pietrasiewicz (13):
      drm/radeon: Provide ddc symlink in connector sysfs directory
      drm/amdgpu: Provide ddc symlink in dm connector's sysfs directory
      drm: rockchip: Provide ddc symlink in rk3066_hdmi sysfs directory
      drm: rockchip: Provide ddc symlink in inno_hdmi sysfs directory
      drm/msm/hdmi: Provide ddc symlink in hdmi connector sysfs directory
      drm/exynos: Provide ddc symlink in connector's sysfs
      drm/mediatek: Provide ddc symlink in hdmi connector sysfs directory
      drm/tilcdc: Provide ddc symlink in connector sysfs directory
      drm/i915: Provide ddc symlink in hdmi connector sysfs directory
      drm/tegra: Provide ddc symlink in output connector sysfs directory
      drm/vc4: Provide ddc symlink in connector sysfs directory
      drm: zte: Provide ddc symlink in hdmi connector sysfs directory
      drm: zte: Provide ddc symlink in vga connector sysfs directory

Andy Shevchenko (1):
      drm/drm_panel: Fix EXPORT of drm_panel_of_backlight() one more time

Animesh Manna (1):
      drm/i915/dsb: Fix in mmio offset calculation of DSB instance

Anthony Koo (10):
      drm/amd/display: set MSA MISC1 bit 6 while sending colorimetry in VSC=
 SDP
      drm/amd/display: Clean up some code with unused registers
      drm/amd/display: cleanup of construct and destruct funcs
      drm/amd/display: cleanup of function pointer tables
      drm/amd/display: rename core_dc to dc
      drm/amd/display: add separate of private hwss functions
      drm/amd/display: add DP protocol version
      drm/amd/display: Limit NV12 chroma workaround
      drm/amd/display: Do not handle linkloss for eDP
      drm/amd/display: make PSR static screen entry within 30 ms

Aric Cyr (16):
      drm/amd/display: 3.2.57
      drm/amd/display: 3.2.58
      drm/amd/display: 3.2.59
      drm/amd/display: 3.2.60
      drm/amd/display: 3.2.61
      drm/amd/display: fix cursor positioning for multiplane cases
      drm/amd/display: 3.2.62
      drm/amd/display: Remove integer scaling code from DC and fix cursor
      drm/amd/display: 3.2.63
      drm/amd/display: scaling changes should also be a full update
      drm/amd/display: 3.2.64
      drm/amd/display: Fix manual trigger source for DCN2
      drm/amd/display: 3.2.65
      drm/amd/display: 3.2.66
      drm/amd/display: 3.2.67
      drm/amd/display: 3.2.68

Arnd Bergmann (3):
      drm/amd/display: include linux/slab.h where needed
      drm: meson: fix address type confusion
      drm/tegra: sor: Mark PM functions as __maybe_unused

Bartlomiej Zolnierkiewicz (3):
      video: fbdev: mmp: remove duplicated MMP_DISP dependency
      video: fbdev: mmp: add COMPILE_TEST support
      video: fbdev: mmp: fix sparse warnings about using incorrect types

Ben Skeggs (86):
      drm/nouveau/gr/gk208-gm10x: regenerate built-in firmware
      drm/nouveau/core: fix missing newline in fw loader error message
      drm/nouveau/fault/tu102: define nvkm_fault_func.pin
      drm/nouveau/gr/gf100-: remove dtor
      drm/nouveau/gr/gk20a,gm200-: add terminators to method lists read fro=
m fw
      drm/nouveau/gr/gv100-: modify gr init to match newer version of RM
      drm/nouveau/disp/dp: fix typo when determining failsafe link configur=
ation
      drm/nouveau/fault/gv100-: fix memory leak on module unload
      drm/nouveau/flcn: move fetching of configuration until first use
      drm/nouveau/flcn: fetch PRI address from TOP if not provided by
constructor
      drm/nouveau/flcn: export existing funcs
      drm/nouveau/core: output fw size in debug messages
      drm/nouveau/core: add a macro to better handle multiple firmware vers=
ions
      drm/nouveau/core: add representation of generic binary objects
      drm/nouveau/core: define ACR subdev
      drm/nouveau/acr: add stub implementation for all GPUs currently
supported by SECBOOT
      drm/nouveau/acr: add loaders for currently available LS firmware imag=
es
      drm/nouveau/gsp: select implementation based on available firmware
      drm/nouveau/gsp: initialise SW state for falcon from constructor
      drm/nouveau/pmu/gp10b: split from gm20b implementation
      drm/nouveau/pmu: select implementation based on available firmware
      drm/nouveau/pmu: initialise SW state for falcon from constructor
      drm/nouveau/gr/gf100-: use nvkm_blob structure for fecs/gpccs fw
      drm/nouveau/gr/gk20a,gm200-: use nvkm_firmware_load_blob for sw init
      drm/nouveau/gr/gf100-: drop fuc_ prefix on sw init
      drm/nouveau/gr/gf100-: move fecs/gpccs ucode into their substructures
      drm/nouveau/gr/gp108: split from gp107
      drm/nouveau/gr/gf100-: select implementation based on available FW
      drm/nouveau/gr/gf100-: initialise SW state for falcon from constructo=
r
      drm/nouveau/sec2/gp108: split from gp102 implementation
      drm/nouveau/sec2: select implementation based on available firmware
      drm/nouveau/sec2: initialise SW state for falcon from constructor
      drm/nouveau/sec2: use falcon funcs
      drm/nouveau/sec2: move interrupt handler to hw-specific module
      drm/nouveau/nvdec: select implementation based on available fw
      drm/nouveau/nvdec: initialise SW state for falcon from constructor
      drm/nouveau/nvdec/gm107: rename from gp102 implementation
      drm/nouveau/nvdec/gm107-: add missing engine instances
      drm/nouveau/nvenc: add a stub implementation for the GPUs where
it should be supported
      drm/nouveau/flcn: specify FBIF offset from subdev
      drm/nouveau/flcn: move bind_context WAR out of common code
      drm/nouveau/flcn: specify EMEM address from subdev
      drm/nouveau/flcn: specify debug/production register offset from subde=
v
      drm/nouveau/flcn: specify queue register offsets from subdev
      drm/nouveau/flcn: reset sec2/gsp falcons harder
      drm/nouveau/flcn: add printk macros
      drm/nouveau/flcn: split msgqueue into multiple pieces
      drm/nouveau/flcn/qmgr: explicitly create queue manager from subdevs
      drm/nouveau/flcn/cmdq: explicitly create command queue(s) from subdev=
s
      drm/nouveau/flcn/msgq: explicitly create message queue from subdevs
      drm/nouveau/flcn/qmgr: move sequence tracking from nvkm_msgqueue
to nvkm_falcon_qmgr
      drm/nouveau/flcn/qmgr: allow arbtrary priv + return code for callback=
s
      drm/nouveau/flcn/qmgr: support syncronous command submission
from common code
      drm/nouveau/flcn/qmgr: rename remaining nvkm_msgqueue bits to
nvkm_falcon_qmgr
      drm/nouveau/flcn/cmdq: split the condition for queue readiness
vs pmu acr readiness
      drm/nouveau/flcn/cmdq: cmd_queue_push can't fail, remove error
handling for it
      drm/nouveau/flcn/cmdq: cmd_queue_close always commits, simplify it
      drm/nouveau/flcn/cmdq: switch to falcon queue printk macros
      drm/nouveau/flcn/cmdq: drop nvkm_msgqueue argument to functions
      drm/nouveau/flcn/cmdq: implement a more explicit send() interface
      drm/nouveau/flcn/cmdq: rename cmdq-related nvkm_msqqueue_queue
to nvkm_falcon_cmdq
      drm/nouveau/flcn/cmdq: move command generation to subdevs
      drm/nouveau/flcn/msgq: remove error handling for
msg_queue_open(), it can't fail
      drm/nouveau/flcn/msgq: simplify msg_queue_pop() error handling
      drm/nouveau/flcn/msgq: switch to falcon queue printk macros
      drm/nouveau/flcn/msgq: drop nvkm_msgqueue argument to functions
      drm/nouveau/flcn/msgq: move handling of init message to subdevs
      drm/nouveau/flcn/msgq: pass explicit message queue pointer to recv()
      drm/nouveau/flcn/msgq: rename msgq-related nvkm_msgqueue_queue
to nvkm_falcon_msgq
      drm/nouveau/secboot: move code to boot LS falcons to subdevs
      drm/nouveau/core/memory: add macros to read/write blocks from objects
      drm/nouveau/fb/gp102-: unlock VPR as part of FB init
      drm/nouveau/acr: implement new subdev to replace "secure boot"
      drm/nouveau/secboot: remove
      drm/nouveau/core: remove previous versioned fw loader
      drm/nouveau/acr/tu10x: initial support
      drm/nouveau/gr/tu10x: initial support
      drm/nouveau/mmu: fix comptag memory leak
      drm/nouveau: zero vma pointer even if we only unreference it
rather than free
      drm/nouveau: reject attempts to submit to dead channels
      drm/nouveau: signal pending fences when channel has been killed
      drm/nouveau: support synchronous pushbuf submission
      drm/nouveau/disp/nv50-: prevent oops when no channel method map provi=
ded
      drm/nouveau/disp/gv100-: not all channel types support reporting
error codes
      drm/nouveau/acr: return error when registering LSF if ACR not support=
ed
      drm/nouveau/fb/gp102-: allow module to load even when scrubber
binary is missing

Benjamin Gaignard (4):
      drm: atomic helper: fix W=3D1 warnings
      drm/crtc-helper: drm_connector_get_single_encoder prototype is missin=
g
      drm/modes: tag unused variables to avoid warnings
      drm/fb-cma-helpers: Fix include issue

Bhawanpreet Lakha (22):
      drm/amd/display: Drop CONFIG_DRM_AMD_DC_DCN2_0 and DSC_SUPPORTED
      drm/amd/display: Drop CONFIG_DRM_AMD_DC_DCN2_1 flag
      drm/amd/display: rename DCN1_0 kconfig to DCN
      drm/amd/display: Add PSP block to verify HDCP2.2 steps
      drm/amd/display: Add DDC handles for HDCP2.2
      drm/amd/display: Add execution and transition states for HDCP2.2
      drm/amd/display: Add logging for HDCP2.2
      drm/amd/display: Change ERROR to WARN for HDCP module
      drm/amd/display: Enable HDCP 2.2
      drm/amd/display: Handle hdcp2.2 type0/1 in dm
      drm/amd/display: Refactor HDCP to handle multiple displays per link
      drm/amd/display: add force Type0/1 flag
      drm/amd/display: Refactor HDCP encryption status update
      drm/amd/display: add and use defines from drm_hdcp.h
      drm/amd/display: use drm defines for MAX CASCADE MASK
      drm/amd/display: split rxstatus for hdmi and dp
      drm/amd/display: Fix static analysis bug in validate_bksv
      drm/amd/display: Null check aconnector in event_property_validate
      drm/amd/display: Load TA firmware for navi10/12/14
      drm/amd/display: fix psp return condition for hdcp module
      drm/amd/display: Fix hdcp1 create session
      drm/amd/display: Return correct Error code for validate h_prime

Bibby Hsieh (11):
      drm/mediatek: use DRM core's atomic commit helper
      drm/mediatek: handle events when enabling/disabling crtc
      drm/mediatek: update cursors by using async atomic update
      drm/mediatek: disable all the planes in atomic_disable
      drm/mediatek: remove unused external function
      soc: mediatek: cmdq: remove OR opertaion from err return
      soc: mediatek: cmdq: define the instruction struct
      soc: mediatek: cmdq: add polling function
      soc: mediatek: cmdq: add cmdq_dev_get_client_reg function
      drm/mediatek: support CMDQ interface in ddp component
      drm/mediatek: apply CMDQ control flow

Boris Brezillon (20):
      drm/exynos: Don't reset bridge->next
      drm/bridge: Rename bridge helpers targeting a bridge chain
      drm/bridge: Introduce drm_bridge_get_next_bridge()
      drm: Stop accessing encoder->bridge directly
      drm/bridge: Make the bridge chain a double-linked list
      drm/bridge: Add the drm_for_each_bridge_in_chain() helper
      drm/bridge: Add the drm_bridge_get_prev_bridge() helper
      drm/bridge: Clarify the atomic enable/disable hooks semantics
      drm/bridge: Add a drm_bridge_state object
      drm/bridge: Patch atomic hooks to take a drm_bridge_state
      drm/bridge: Add an ->atomic_check() hook
      drm/bridge: Add the necessary bits to support bus format negotiation
      drm/bridge: Fix a NULL pointer dereference in
drm_atomic_bridge_chain_check()
      Revert "drm/bridge: Fix a NULL pointer dereference in
drm_atomic_bridge_chain_check()"
      Revert "drm/bridge: Add the necessary bits to support bus format
negotiation"
      Revert "drm/bridge: Add an ->atomic_check() hook"
      Revert "drm/bridge: Patch atomic hooks to take a drm_bridge_state"
      Revert "drm/bridge: Add a drm_bridge_state object"
      drm/vc4: dsi: Fix bridge chain handling
      drm/exynos: dsi: Fix bridge chain handling

Brandon Syu (1):
      drm/amd/display: fixed that I2C over AUX didn't read data issue

Brian Masney (4):
      dt-bindings: drm/msm/gpu: document second interconnect
      drm/msm/gpu: add support for ocmem interconnect path
      drm/msm/a3xx: set interconnect bandwidth vote
      drm/msm/a4xx: set interconnect bandwidth vote

Bruce Chang (1):
      drm/i915: Avoid atomic context for error capture

CK Hu (1):
      Merge tag 'v5.5-next-cmdq-stable' of
https://git.kernel.org/.../matthias.bgg/linux

Camille Cho (1):
      drm/amd/display: Add definition for number of backlight data points

Charlene Liu (3):
      drm/amd/display: HDMI 2.x audio bandwidth check
      drm/amd/display: Add warmup escape call support
      drm/amd/display: rename _lvp to l_vp

Chen Wandun (1):
      drm/amd/powerplay: return errno code to caller when error occur

Chen Zhou (4):
      drm/gma500: remove set but not used variables 'hist_reg'
      drm/i915/gtt: add missing include file asm/smp.h
      drm/amd/display: remove unnecessary conversion to bool
      drm/nouveau: fix build error without CONFIG_IOMMU_API

Chris Park (1):
      drm/amd/display: Add default switch case for DCC

Chris Wilson (268):
      drm/i915/selftests: Spin on all engines simultaneously
      drm/i915/gt: Pull timeline initialise to intel_gt_init_early
      drm/i915/gt: Call intel_gt_sanitize() directly
      drm/i915/gem: Leave reloading kernel context on resume to GT
      drm/i915/gt: Move user_forcewake application to GT
      drm/i915: Defer rc6 shutdown to suspend_late
      drm/i915/selftests: Add intel_gt_suspend_prepare
      drm/i915/perf: Reverse a ternary to make sparse happy
      drm/i915/selftests: Flush all active callbacks
      drm/i915/execlists: Verify context register state before execution
      drm/i915/execlists: Ignore the inactive kernel context in
assert_pending_valid
      drm/i915/gt: Drop false assertion on user_forcewake
      drm/i915: Protect request peeking with RCU
      drm/i915/execlists: Reset CSB pointers by mmio as well
      drm/i915/gem: Early rejection of no-aperture map_ggtt
      drm/i915/gt: Only drop heartbeat.systole if the sole owner
      drm/i915/gem: Fix error path to unlock if the GEM context is closed
      drm/i915/gt: Cleanup heartbeat systole first
      drm/i915: Leave the aliasing-ppgtt size alone
      drm/i915/gt: Defer engine registration until fully initialised
      drm/i915/gem: Safely acquire the ctx->vm when copying
      drm: Move EXPORT_SYMBOL_FOR_TESTS_ONLY under a separate Kconfig
      drm: Expose a method for creating anonymous struct file around drm_mi=
nor
      drm/i915/selftests: Replace mock_file hackery with drm's true fake
      drm/i915/selftests: Wrap vm_mmap() around GEM objects
      drm/i915/selftests: Verify mmap_gtt revocation on unbinding
      drm/i915/selftests: Complete transition to a real struct file mock
      drm/i915/selftests: Mark up sole accessor to ctx->vm as being protect=
ed
      drm/i915/pmu: Cheat when reading the actual frequency to avoid fw
      drm/i915/pmu: Only use exclusive mmio access for gen7
      drm/i915/icl: Refine PG_HYSTERESIS
      drm/i915: Protect context while grabbing its name for the request
      drm/i915/gem: Embed context/timeline name inside the GEM context
      drm/i915/gem: Update context name on closing
      drm/i915: Show guilty context name on GPU reset
      drm/i915: Cancel context if it hangs after it is closed
      drm/i915/pmu: "Frequency" is reported as accumulated cycles
      drm/i915/selftests: Exercise parallel blit operations on a single ctx
      drm/i915/selftests: Fill all the drm_vma_manager holes
      drm/i915: Taint the kernel on dumping the GEM ftrace buffer
      drm/i915/execlists: Reduce barrier on context switch to a wmb()
      drm/i915/userptr: Try to acquire the page lock around set_page_dirty(=
)
      drm/i915/userptr: Handle unlocked gup retries
      drm/i915/execlists: Move reset_active() from schedule-out to schedule=
-in
      drm/i915/selftests: Perform some basic cycle counting of MI ops
      drm/i915/gem: Replace implicit dev_priv->uncore for stolen init
      drm/i915/gem: Pass mem region to preallocated stolen
      drm/i915: Remove leftover gem.pm_notifier member
      drm/i915/gt: Try an extra flush on the Haswell blitter
      drm/i915: Flush context free work on cleanup
      drm/i915/selftests: Remove unused local variable 'file'
      drm/i915/gt: Flush gen7 even harder
      drm/i915/gt: Invalidate as we write the gen7 breadcrumb
      drm/i915/fbdev: Restore physical addresses for fb_mmap()
      drm/i915/gt: Set unused mocs entry to follow PTE on tgl as on all oth=
ers
      drm/i915/gt: Tidy up debug-warns for the mocs control table
      drm/i915/gt: Refactor mocs loops into single control macro
      drm/i915/selftests: Add coverage of mocs registers
      drm/i915: Split i915_active.mutex into an irq-safe spinlock for the r=
btree
      drm/i915/gt: Wait for new requests in intel_gt_retire_requests()
      drm/i915/gem: Silence sparse for RCU protection inside the constructo=
r
      drm/i915: Simplify NEEDS_WaRsDisableCoarsePowerGating
      drm/i915/gt: Use gt locals for accessing rc6
      drm/i915/gt: Flush retire.work timer object on unload
      drm/i915/selftests: Exercise long preemption chains
      drm/i915/selftests: Disable heartbeat around context barrier tests
      drm/i915/gt: Mention which device failed
      drm/i915/gem: Purge the sudden reappearance of i915_gem_object_pin()
      drm/i915/selftests: Add intel_gt_driver_late_release for mock device
      drm/i915/gt: Only wait for register chipset flush if active
      drm/i915/gt: Make intel_ring_unpin() safe for concurrent pint
      drm/i915/gem: Track ggtt writes from userspace on the bound vma
      drm/i915/gem: Merge GGTT vma flush into a single loop
      drm/i915/gem: Protect the obj->vma.list during iteration
      drm/amdgpu/dm: Do not throw an error for a display with no audio
      drm/i915/gt: Move new timelines to the end of active_list
      drm/i915/gt: Schedule next retirement worker first
      drm/i915/gt: Flush the requests after wedging on suspend
      drm/i915/gem: Manually dump the debug trace on GEM_BUG_ON
      drm/i915: Wait until the intel_wakeref idle callback is complete
      drm/i915/selftests: Exercise rc6 w/a handling
      drm/i915/selftests: Be explicit in ERR_PTR handling
      drm/i915/selftests: Take a ref to the request we wait upon
      drm/i915: Mark up the calling context for intel_wakeref_put()
      drm/i915/gt: Close race between engine_park and intel_gt_retire_reque=
sts
      drm/i915/gt: Unlock engine-pm after queuing the kernel context switch
      drm/i915/gt: Declare timeline.lock to be irq-free
      drm/i915/gt: Fixup config ifdeffery for pm_suspend_target_state
      Revert "drm/i915/gt: Wait for new requests in intel_gt_retire_request=
s()"
      drm/i915: Serialise with remote retirement
      drm/i915/gt: Hold request reference while waiting for w/a verificatio=
n
      drm/i915/execlists: Lock the request while validating it during promo=
tion
      drm/i915: Mark intel_wakeref_get() as a sleeper
      drm/i915/selftests: Always hold a reference on a waited upon request
      drm/i915/selftests: Shorten infinite wait for sseu
      drm/i915: Use a ctor for TYPESAFE_BY_RCU i915_request
      drm/i915/selftests: Force bonded submission to overlap
      drm/i915/selftests: Flush the active callbacks
      drm/i915/selftests: Include the subsubtest name for live_parallel_eng=
ines
      drm/i915: Switch kunmap() to take the page not vaddr
      drm/i915/gt: Mark the execlists->active as the primary volatile acces=
s
      drm/i915/execlists: Fixup cancel_port_requests()
      drm/i915: Serialise with engine-pm around requests on the kernel_cont=
ext
      drm/i915/gt: Adapt engine_park synchronisation rules for engine_retir=
e
      drm/i915/gt: Schedule request retirement when timeline idles
      drm/i915/selftests: Move mock_vma to the heap to reduce stack_frame
      drm/i915: Default to a more lenient forced preemption timeout
      drm/i915: Reduce nested prepare_remote_context() to a trylock
      drm/i915/gt: Manual rc6 entry upon parking
      drm/i915: Serialise i915_active_fence_set() with itself
      drm/i915/gt: Defer breadcrumb processing to after the irq handler
      drm/i915/gem: Excise the per-batch whitelist from the context
      drm/i915/selftests: Try to show where the pulse went
      drm/i915/selftests: Count the number of engines used
      drm/i915/selftests: Drop local vm reference!
      drm/i915/selftests: Use sgt_iter for huge_pages_free
      drm/i915/selftests: Always lock the drm_mm around insert/remove
      drm/i915/selftests: Wait only on the expected barrier
      Revert "drm/i915: use a separate context for gpu relocs"
      drm/i915/gem: Take timeline->mutex to walk list-of-requests
      drm/i915/execlists: Ensure the tasklet is decoupled upon shutdown
      drm/i915/selftests: Keep engine awake during live_coherency
      drm/i915/gen7: Re-enable full-ppgtt for ivb & hsw
      drm/i915/gt: Push the flush_pd before the set-context
      drm/i915: Serialise access to GFX_FLSH_CNTL
      drm/i915: Refactor gen6_flush_pd()
      drm/i915/gt: Use soft-rc6 for w/a protection
      drm/i915/gt: Simplify rc6 w/a application
      drm/i915/gem: Unbind all current vma on changing cache-level
      drm/i915: Specialise i915_active.work lock classes
      drm/i915: Serialise i915_active_wait() with its retirement
      drm/i915/gem: Take runtime-pm wakeref prior to unbinding
      drm/i915: Lift i915_vma_pin() out of intel_renderstate_emit()
      drm/i915/execlists: Add a couple more validity checks to assert_pendi=
ng()
      drm/i915/execlists: Skip nested spinlock for validating pending
      drm/i915/gt: Track the context validity explicitly
      drm/i915/gem: Avoid parking the vma as we unbind
      drm/i915/gt: Set the PD again for Haswell
      drm/i915/gem: Try to flush pending unbind events
      drm/i915/gem: Hold the obj->vma.lock while walking the vma.list
      drm/i915/gem: Hook user-extensions upto MMAP_OFFSET_IOCTL
      drm/i915: Remove vestigal i915_gem_context locals from cmdparser
      drm/i915: Ignore most failures during evict-vm
      drm/i915: Try hard to bind the context
      drm/i915/gt: Bump the PP_DIR invalidation for Baytrail
      drm/i915/gem: Reinitialise the local list before repeating
      drm/i915/gt: Save irqstate around virtual_context_destroy
      drm/i915: Serialise i915_active_acquire() with __active_retire()
      drm/i915/gt: Trim gen6 ppgtt updates to PD cachelines
      drm/i915: Claim vma while under closed_lock in i915_vma_parked()
      drm/i915/gt: Acquire a GT wakeref for the breadcrumb interrupt
      drm/i915/gem: Flush the pwrite through the chipset before signaling
      drm/i915: Check for error before calling cmpxchg()
      drm/i915: Propagate errors on awaiting already signaled fences
      drm/i915: Propagate errors on awaiting already signaled dma-fences
      drm/i915/gem: Pin gen6_ppgtt prior to constructing the request
      drm/i915: Avoid calling i915_gem_object_unbind holding object lock
      drm/i915/gtt: Account for preallocation in asserts
      drm/i915/gt: Turn vm off then on again for gen7 mm switch
      drm/i915/gem: Comment on inability to check args.pad for MMAP_OFFSET
      drm/i915: Flesh out device_info pretty printer
      drm/i915/gem: Avoid rcu_barrier() from shrinker paths
      drm/i915: Change i915_vma_unbind() to report -EAGAIN on activity
      drm/i915/gt: Detect if we miss WaIdleLiteRestore
      drm/i915: Copy across scheduler behaviour flags across submit fences
      drm/i915/gt: Check we are the Ironlake IPS provider before deregister=
ing
      drm/i915/gem: Wait on unbind barriers when invalidating userptr
      drm/i915/selftests: Show the i915_active on failure
      drm/i915: Use the i915_device name for identifying our request fences
      drm/i915/gt: Disable manual rc6 for Braswell/Baytrail
      drm/i915: Fix cmdparser drm.debug
      drm/i915: Remove redundant parameters from intel_engine_cmd_parser
      drm/i915: Simplify error escape from cmdparser
      drm/i915/gem: Tidy up error handling for eb_parse()
      drm/i915: Align start for memcpy_from_wc
      drm/i915/gt: Only ignore rc6 parking for PCU on byt/bsw
      drm/i915/gem: Prepare gen7 cmdparser for async execution
      drm/i915/gem: Asynchronous cmdparser
      drm/i915: Set fence_work.ops before dma_fence_init
      drm/i915/gt: Mark up ips_mchdev pointer access
      drm/i915: Use EAGAIN for trylock failures
      drm/i915/gem: Serialise object before changing cache-level
      drm/i915/gem: Apply lmem size restriction to get_pages
      drm/i915/gt: Tidy up full-ppgtt on Ivybridge
      drm/i915: Eliminate the trylock for awaiting an earlier request
      drm/i915/gt: Avoid multi-LRI on Sandybridge
      drm/i915/gem: Keep request alive while attaching fences
      drm/i915/gt: Eliminate the trylock for reading a timeline's hwsp
      drm/i915: Unpin vma->obj on early error
      drm/i915/pmu: Skip sampling engines if gt is asleep
      drm/i915: Hold reference to intel_frontbuffer as we track activity
      drm/i915/gt: Ratelimit display power w/a
      drm/i915/gt: Remove direct invocation of breadcrumb signaling
      drm/i915: Ratelimit i915_globals_park
      drm/i915/gt: Schedule request retirement when signaler idles
      drm/i915/gt: Track engine round-trip times
      drm/i915/gt: Use non-forcewake writes for RPS
      drm/i915/gt: Suppress threshold updates on RPS parking
      drm/i915/gt: Add breadcrumb retire to physical engine
      drm/i915/gt: Teach veng to defer the context allocation
      drm/i915: Drop GEM context as a direct link from i915_request
      drm/i915: Push the use-semaphore marker onto the intel_context
      drm/i915/execlists: Select arb on/off around batches based on preempt=
ion
      drm/i915/selftests: Setup engine->retire for mock_engine
      drm/i915: Remove i915->kernel_context
      drm/i915/gt: Repeat wait_for_idle for retirement workers
      drm/i915: Move i915_gem_init_contexts() earlier
      drm/i915/gt: Pull GT initialisation under intel_gt_init()
      drm/i915/gt: Pull intel_gt_init_hw() into intel_gt_resume()
      drm/i915/gt: Merge engine init/setup loops
      drm/i915: Add a simple is-bound check before unbinding
      drm/i915: Introduce a vma.kref
      drm/i915: Mark the GEM context link as RCU protected
      drm/i915/gt: Tidy up checking active timelines during retirement
      drm/i915/gt: Flush other retirees inside intel_gt_retire_requests()
      drm/i915: Add spaces before compound GEM_TRACE
      drm/i915/gt: Stop poking at engine->serial at a high level
      drm/i915/gt: Apply sanitiization just before resume
      drm/i915/gt: Ignore incomplete engines after init failure
      drm/i915/selftests: Err out on coherency if initialisation failed
      drm/i915: Restore very early GPU reset
      drn/i915: Break up long i915_buddy_free_list() with a cond_resched()
      drm/i915/gt: Ensure that all new contexts clear STOP_RING
      drm/i915/gt: Avoid using tag 0 for the very first submission
      drm/i915/gt: Avoid using the GPU before initialisation
      drm/i915/gt: Do not restore invalid RS state
      drm/i915/selftests: Flush the context worker
      drm/i915/gt: Leave RING_BB_STATE to default value
      drm/i915/gt: Tweak flushes around ivb ppgtt
      drm/i915/gt: Restore coarse power gating
      drm/i915/gem: Drop local vma->vm_file reference
      drm/i915/gem: Single page objects are naturally contiguous
      drm/i915/gt: Flush ongoing retires during wait_for_idle
      drm/i915/gt: Include a bunch more rcs image state
      drm/i915/gt: Clear LRC image inline
      drm/i915/gt: Ignore stale context state upon resume
      drm/i915/gt: Discard stale context state from across idling
      drm/i915/gt: Always poison the kernel_context image before unparking
      drm/i915/gem: Support discontiguous lmem object maps
      drm/i915/selftests: Move igt_atomic_section[] out of the header
      drm/i915/selftests: Make headers self-contained
      drm/i915/selftests: Compare user mmap against GPU
      drm/i915/selftests: Fixup sparse __user annotation on local var
      drm/i915/selftests: Impose a timeout for request submission
      drm/i915: Merge i915_request.flags with i915_request.fence.flags
      drm/i915/gt: Convert the final GEM_TRACE to GT_TRACE and co
      drm/i915/gt: Drop mutex serialisation between context pin/unpin
      drm/i915/gt: Use memset_p to clear the ports
      drm/i915/gt: Mark up virtual engine uabi_instance
      drm/i915/gt: Take responsibility for engine->release as the last step
      drm/i915/gt: Always force restore freshly pinned contexts
      drm/i915/gt: Drop a defunct timeline assertion
      drm/i915: Early return for no-op i915_vma_pin_fence()
      drm/i915: Reduce warning for i915_vma_pin_iomap() without runtime-pm
      drm/i915: Pin the context as we work on it
      drm/i915/gt: Push context state allocation earlier
      drm/i915/gt: Pull context activation into central intel_context_pin()
      drm/i915/gt: runtime-pm is no longer required for ce->ops->pin()
      drm/i915/gt: Skip trying to unbind in restore_ggtt_mappings
      drm/i915/gt: Mark context->state vma as active while pinned
      drm/i915/gt: Mark ring->vma as active while pinned
      drm/i915: Start chopping up the GPU error capture
      drm/i915: Drop the shadow w/a batch buffer
      drm/i915: Drop the shadow ring state from the error capture
      drm/i915: Drop request list from error state
      drm/i915/gt: Hold rpm wakeref before taking ggtt->vm.mutex
      drm/i915: Correct typo in i915_vma_compress_finish stub
      drm/i915/gt: Always reset the timeslice after a context switch

Christian K=C3=B6nig (8):
      drm/ttm: ttm_tt_init_fields() can be static
      drm/ttm: also export ttm_bo_vm_fault v2
      drm/radeon: finally fix the racy VMA setup
      drm/amdgpu: move VM eviction decision into amdgpu_vm.c
      drm/amdgpu: explicitely sync to VM updates v2
      drm/amdgpu: stop adding VM updates fences to the resv obj
      drm/amdgpu: add VM eviction lock v3
      drm/amdgpu: drop amdgpu_job.owner

Christophe JAILLET (1):
      pxa168fb: Fix the function used to release some memory in an
error handling path

Chuhong Yuan (2):
      drm/virtgpu: fix double unregistration
      drm/gma500: add a missed gma_power_end in error path

Chunming Zhou (1):
      drm/amdgpu: add DRIVER_SYNCOBJ_TIMELINE to amdgpu

Claudiu Beznea (3):
      drm: atmel-hlcdc: use double rate for pixel clock only if supported
      drm: atmel-hlcdc: enable clock before configuring timing engine
      Revert "drm: atmel-hlcdc: enable sys_clk during initalization."

Clint Taylor (1):
      drm/i915: Disable display interrupts during display IRQ handler

Colin Ian King (21):
      drm/amd/display: fix dereference of pointer aconnector when it is nul=
l
      drm/amd/display: remove duplicated assignment to grph_obj_type
      drm/amd/display: remove redundant variable status
      drm/amd/display: fix spelling mistake "exeuction" -> "execution"
      drm/amd/display: remove duplicated comparison expression
      drm/dp_mst: fix multiple frees of tx->bytes
      drm/amdgpu: remove redundant assignment to pointer write_frame
      drm/amd/powerplay: remove redundant assignment to variables
HiSidd and LoSidd
      drm/radeon: remove redundant assignment to variable ret
      drm/panel: clean up indentation issue
      drm/amd/display: fix double assignment to msg_id field
      drm/amd/display: remove redundant assignment to variable v_total
      drm/i915/selftests: fix uninitialized variable sum when summing up va=
lues
      drm/i915/display: remove duplicated assignment to pointer crtc_state
      drm/i915: remove redundant checks for a null fb pointer
      dma-buf: fix resource leak on -ENOTTY error return path
      drm/amd/powerplay: fix various dereferences of a pointer before
it is null checked
      drm/gma500: fix null dereference of pointer fb before null check
      drm/i915: fix uninitialized pointer reads on pointers to and from
      fbdev: matrox: make array wtst_xlat static const, makes object smalle=
r
      drm/nouveau/nouveau: fix incorrect sizeof on args.src an args.dst

Dale Zhao (1):
      drm/amd/display: Use absolute time stamp to follow the eDP T7
spec requirement

Dan Carpenter (6):
      drm/amdgpu: Fix a bug in jpeg_v1_0_start()
      drm/i915/bios: fix off by one in parse_generic_dtd()
      drm/i915/selftests: remove a condition
      drm/i915: fix an error code in intel_modeset_all_tiles()
      gpu/drm: clean up white space in drm_legacy_lock_master_cleanup()
      drm/nouveau/secboot/gm20b: initialize pointer in gm20b_secboot_new()

Daniel Vetter (51):
      drm/property: Enforce more lifetime rules
      drm/todo: Add entry to remove load/unload hooks
      dma_resv: prime lockdep annotations
      drm/nouveau: slowpath for pushbuf ioctl
      drm/ttm: remove ttm_bo_wait_unreserved
      drm/i915: Switch obj->mm.lock lockdep annotations on its head
      lockdep: add might_lock_nested()
      drm/i915: use might_lock_nested in get_pages annotation
      drm/fb-helper: unexport drm_fb_helper_generic_probe
      drm/atmel: ditch fb_create wrapper
      drm/tilcdc: Drop drm_gem_fb_create wrapper
      drm/xen: Simplify fb_create
      drm/modeset: Prime modeset lock vs dma_resv
      dma-resv: Also prime acquire ctx for lockdep
      drm/msm: Don't init ww_mutec acquire ctx before needed
      drm/mediatek: don't open-code drm_gem_fb_create
      drm/tegra: Map cmdbuf once for reloc processing
      drm/tegra: Delete host1x_bo_ops->k(un)map
      drm/i915: Remove dma_buf_kmap selftest
      staging/android/ion: delete dma_buf->kmap/unmap implemenation
      drm/i915: Drop dma_buf->k(un)map
      drm/omapdrm: Drop dma_buf->k(un)map
      drm/tegra: Remove dma_buf->k(un)map
      dma-buf: Drop dma_buf_k(un)map
      drm/vmwgfx: Delete mmaping functions
      media/videobuf2: Drop dma_buf->k(un)map support
      drm/tee_shm: Drop dma_buf_k(unmap) support
      xen/gntdev-dmabuf: Ditch dummy map functions
      sample/vfio-mdev/mbocs: Remove dma_buf_k(un)map support
      drm/armada: Delete dma_buf->k(un)map implemenation
      dma-buf: Remove kernel map/unmap hooks
      drm/fourcc: Fill out all block sizes for P10/12/16
      drm/fourcc: Fill out all block sizes for P210
      drm/rect: update kerneldoc for drm_rect_clip_scaled()
      drm/rockchip: Use drm_gem_fb_create_with_dirty
      drm/todo: Add entry for fb funcs related cleanups
      drm/atomic: Update docs around locking and commit sequencing
      drm/doc: Drop :c:func: markup
      drm/gma500: globle no more!
      drm/atmel: plane_state->fb iff plane_state->crtc
      drm/virtio: plane_state->fb iff plane_state->crtc
      Merge tag 'drm-misc-next-2019-12-16' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'arcpgu-updates-2019.12.16' of
github.com:abrodkin/linux into drm-next
      drm/msm: Use dma_resv locking wrappers
      drm/vc4: Use dma_resv locking wrappers
      drm/etnaviv: Use dma_resv locking wrappers
      drm/malidp: plane_state->fb iff plane_state->crtc
      drm/mediatek: plane_state->fb iff plane_state->crtc
      Merge tag 'drm-next-5.6-2019-12-11' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'du-next-20191218' of
git://linuxtv.org/pinchartl/media into drm-next
      drm/todo: Updating logging todo

Daniele Ceraolo Spurio (11):
      drm/i915/guc: Properly capture & release GuC interrupts on Gen11+
      drm/i915/guc: Drop leftover preemption code
      drm/i915/guc: add a helper to allocate and map guc vma
      drm/i915/guc: kill doorbell code and selftests
      drm/i915/guc: kill the GuC client
      drm/i915/guc: Merge communication_stop and communication_disable
      drm/i915/guc/ct: Drop guards in enable/disable calls
      drm/i915/guc/ct: Stop expecting multiple CT channels
      drm/i915/guc/ct: Group request-related variables in a sub-structure
      drm/i915/guc: Remove function pointers for send/receive calls
      drm/i915/guc: Unify notify() functions

Dave Airlie (17):
      Merge tag 'drm-intel-next-2019-12-23' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'drm-misc-next-2020-01-02' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-misc-next-2020-01-07' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-misc-next-2020-01-10' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'amd-drm-next-5.6-2020-01-09' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'amd-drm-next-5.6-2020-01-10-dp-mst-dsc' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'drm/tegra/for-5.6-rc1' of
git://anongit.freedesktop.org/tegra/linux into drm-next
      Merge tag 'mediatek-drm-next-5.6' of
https://github.com/ckhu-mediatek/linux.git-tags into drm-next
      Merge branch 'linux-5.6' of git://github.com/skeggsb/linux into drm-n=
ext
      Merge tag 'drm-intel-next-2020-01-14' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'amd-drm-next-5.6-2020-01-17' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Backmerge v5.5-rc7 into drm-next
      Merge tag 'drm-msm-next-2020-01-14' of
https://gitlab.freedesktop.org/drm/msm into drm-next
      Merge branch 'vmwgfx-next' of
git://people.freedesktop.org/~thomash/linux into drm-next
      Merge tag 'exynos-drm-next-for-v5.6' of
git://git.kernel.org/.../daeinki/drm-exynos into drm-next
      Merge branch 'linux-5.6' of git://github.com/skeggsb/linux into drm-n=
ext
      Merge branch 'linux-5.6' of git://github.com/skeggsb/linux into drm-n=
ext

David (Dingchen) Zhang (2):
      drm/amd/display: add debugfs sdp hook up function for Navi
      drm: add dp helper to initialize remote aux channel.

David Francis (9):
      drm/dp_mst: Add PBN calculation for DSC modes
      drm/dp_mst: Parse FEC capability on MST ports
      drm/dp_mst: Add MST support to DP DPCD R/W functions
      drm/dp_mst: Fill branch->num_ports
      drm/dp_mst: Add helpers for MST DSC and virtual DPCD aux
      drm/amd/display: Initialize DSC PPS variables to 0
      drm/amd/display: Validate DSC caps on MST endpoints
      drm/amd/display: Write DSC enable to MST DPCD
      drm/amd/display: MST DSC compute fair share

David Galiffi (3):
      drm/amd/display: Fix assert observed when performing dummy p-state ch=
eck
      drm/amd/display: Create debug option to disable v.active clock
change policy.
      drm/amd/display: Fixed kernel panic when booting with DP-to-HDMI dong=
le

Dennis Li (3):
      drm/amdgpu: define soc15_ras_field_entry for reuse
      drm/amdgpu: refine query function of mmhub EDC counter in vg20
      drm/amdgpu: implement querying ras error count for mmhub9.4

Derek Lai (1):
      drm/amd/display: Specified VR patch skip to reset segment to 0

Dhinakaran Pandiyan (9):
      drm/i915: Use intel_tile_height() instead of re-implementing
      drm/i915: Move CCS stride alignment W/A inside intel_fb_stride_alignm=
ent
      drm/i915: Extract framebufer CCS offset checks into a function
      drm/framebuffer: Format modifier for Intel Gen-12 render compression
      drm/i915/tgl: Gen-12 render decompression
      drm/i915: Skip rotated offset adjustment for unsupported modifiers
      drm/framebuffer: Format modifier for Intel Gen-12 media compression
      drm/fb: Extend format_info member arrays to handle four planes
      drm/i915/tgl: Gen-12 display can decompress surfaces compressed
by the media engine

Dingchen Zhang (2):
      drm: remove the newline for CRC source name.
      drm: Set crc->opened to false before setting crc source to NULL.

Dmytro Laktyushkin (3):
      drm/amd/display: fix dml20 min_dst_y_next_start calculation
      drm/amd/display: update dml related structs
      drm/amd/display: expand dml structs

Don Hiatt (1):
      drm/i915/guc: Skip suspend/resume GuC action on platforms w/o
GuC submission

Douglas Anderson (1):
      drm/msm: Fix error about comments within a comment block

Drew Davenport (6):
      drm/msm/dpu: Remove unnecessary NULL checks
      drm/msm/dpu: Remove unnecessary NULL checks
      drm/msm/dpu: Remove unnecessary NULL checks
      drm/msm/dpu: Remove unnecessary NULL check
      drm/msm/dpu: Remove unreachable code
      drm/msm/dpu: Remove unnecessary NULL checks

Emil Velikov (6):
      drm: use correct dev node location in comment
      drm/panfrost: remove DRM_AUTH and respective comment
      drm: drop DRM_AUTH from PRIME_TO/FROM_HANDLE ioctls
      drm/vmwgfx: move the require_exist handling together
      drm/vmwgfx: check master authentication in surface_ref ioctls
      drm/vmwgfx: drop DRM_AUTH for render ioctls

Emily Deng (2):
      drm/amdgpu/sriov: No need the event 3 and 4 now
      drm/amdgpu/sriov: Tonga sriov also need load firmware with smu

Eric Yang (6):
      drm/amd/display: Renoir chroma viewport WA
      drm/amd/display: update sr and pstate latencies for Renoir
      drm/amd/display: fix dprefclk and ss percentage reading on RN
      drm/amd/display: update dispclk and dppclk vco frequency
      drm/amd/display: update chroma viewport wa
      drm/amd/display: fix chroma vp wa corner case

Eugeniy Paltsev (4):
      DRM: ARC: PGU: fix framebuffer format switching
      DRM: ARC: PGU: cleanup supported format list code
      DRM: ARC: PGU: replace unsupported by HW RGB888 format by XRGB888
      DRM: ARC: PGU: add ARGB8888 format to supported format list

Evan Quan (23):
      drm/amd/powerplay: avoid DPM reenable process on Navi1x ASICs V2
      drm/amd/powerplay: issue BTC on Navi during SMU setup
      drm/amd/powerplay: issue no PPSMC_MSG_GetCurrPkgPwr on unsupported AS=
ICs
      drm/amd/powerplay: correct fine grained dpm force level setting
      drm/amd/powerplay: correct swSMU baco reset related settings
      drm/amd/powerplay: add Arcturus baco reset support
      drm/amd/powerplay: add missing header file declaration
      drm/amd/powerplay: drop unnecessary warning prompt
      drm/amd/powerplay: pre-check the SMU state before issuing message
      drm/amd/powerplay: clear VBIOS scratchs on baco exit V2
      drm/amd/powerplay: support custom power profile setting
      drm/amd/powerplay: add check for baco support on Arcturus
      drm/amdgpu: correct RLC firmwares loading sequence
      drm/amd/powerplay: avoid deadlock on Vega20 swSMU routine
      drm/amd/powerplay: retrieve the enabled feature mask from cache
      drm/amd/powerplay: add smu11_driver_if_arcturus.h new OOB members
      drm/amd/powerplay: cache the watermark settings on system memory
      drm/amd/powerplay: unified VRAM address for driver table
interaction with SMU V2
      drm/amd/powerplay: refine code to support no-dpm case
      drm/amd/powerplay: issue proper hdp flush for table transferring
      drm/amd/powerplay: cleanup the interfaces for powergate setting
through SMU
      drm/amd/powerplay: cover the powerplay implementation details V3
      drm/amd/powerplay: a quick fix for the deadlock issue below

Fabien Parent (1):
      drm/mediatek: Fix indentation in Makefile

Fabio Estevam (1):
      drm/msm/adreno: Do not print error on "qcom, gpu-pwrlevels" absence

Fabrizio Castro (14):
      drm: of: Add drm_of_lvds_get_dual_link_pixel_order
      drm: rcar-du: lvds: Improve identification of panels
      drm: rcar-du: lvds: Get dual link configuration from DT
      drm: rcar-du: lvds: Allow for even and odd pixels swap
      dt-bindings: display: bridge: Convert lvds-transmitter binding
to json-schema
      dt-bindings: display: bridge: lvds-transmitter: Document powerdown-gp=
ios
      dt-bindings: display: bridge: lvds-transmitter: Absorb ti, ds90c185.t=
xt
      dt-bindings: display: bridge: lvds-transmitter: Document "ti, sn75lvd=
s83"
      drm/bridge: Repurpose lvds-encoder.c
      drm/bridge: lvds-codec: Add "lvds-decoder" support
      drm/bridge: lvds-codec: Simplify panel DT node localisation
      dt-bindings: display: bridge: Repurpose lvds-encoder
      dt-bindings: display: bridge: lvds-codec: Document ti, ds90cf384a
      dt-bindings: display: bridge: lvds-codec: Absorb thine, thc63lvdm83d.=
txt

Felix Kuehling (7):
      drm/amdgpu: Raise KFD unpinned system memory limit
      drm/amdgpu: Optimize KFD page table reservation
      drm/amdkfd: Fix permissions of hang_hws
      drm/amdkfd: Remove unused variable
      drm/amdkfd: Improve HWS hang detection and handling
      drm/amdkfd: Avoid hanging hardware in stop_cpsch
      drm/amdkfd: Improve kfd_process lookup in kfd_ioctl

Flora Cui (1):
      drm/amdgpu: add header file for macro SZ_1M

Frank.Min (3):
      drm/amdgpu: enlarge agp_start address into 48bit
      drm/amdgpu: enable xgmi init for sriov use case
      drm/amdgpu: remove FB location config for sriov

Fritz Koenig (2):
      drm/msm/dpu: Add UBWC support for RGB8888 formats
      drm/msm/dpu: Allow UBWC on NV12

Gabriela Bittencourt (3):
      drm/vkms: Update VKMS documentation
      drm/doc: Add VKMS module description and use to "Testing and Validati=
on"
      drm/vkms: Fix typo and preposion in function documentation

Geert Uytterhoeven (3):
      dt-bindings: display: renesas: du: Add vendor prefix to vsps property
      drm: rcar-du: Recognize "renesas,vsps" in addition to "vsps"
      drm/mipi_dbi: Fix off-by-one bugs in mipi_dbi_blank()

George Shen (2):
      drm/amd/display: Increase the number of retries after AUX DEFER
      drm/amd/display: Add w/a to reset PHY before link training in
verify_link_cap

Gerd Hoffmann (8):
      drm/virtio: fix byteorder handling in
virtio_gpu_cmd_transfer_{from, to}_host_3d functions
      drm/virtio: Simplify virtio_gpu_primary_plane_update workflow.
      drm/virtio: factor out virtio_gpu_update_dumb_bo
      drm: call drm_gem_object_funcs.mmap with fake offset
      drm: share address space for dma bufs
      drm/virtio: skip set_scanout if framebuffer didn't change
      drm/virtio: batch display update commands.
      drm/virtio: use damage info for display updates.

Guchun Chen (7):
      drm/amdgpu: add check before enabling/disabling broadcast mode
      drm/amdgpu: drop useless BACO arg in amdgpu_ras_reset_gpu
      drm/amdgpu: move umc offset to one new header file for Arcturus
      drm/amdgpu: add missed return value set for error case
      drm/amdgpu: simplify function return logic
      drm/amdgpu: add MCUMC_ADDRT0 offset to ip header file
      drm/amdgpu: calculate MCUMC_ADDRT0 per asic's UMC offset

Gurchetan Singh (12):
      drm/vram: remove unused declaration
      udmabuf: use cache_sgt_mapping option
      udmabuf: add a pointer to the miscdevice in dma-buf private data
      udmabuf: separate out creating/destroying scatter-table
      udmabuf: implement begin_cpu_access/end_cpu_access hooks
      udmabuf: fix dma-buf cpu access
      drm/virtio: static-ify virtio_fence_signaled
      drm/virtio: static-ify virtio_gpu_framebuffer_init
      drm/virtio: get rid of drm_encoder_to_virtio_gpu_output
      drm/virtio: simplify getting fake offset
      drm/virtio: move to_virtio_fence inside virtgpu_fence
      drm/virtio: move drm_connector_to_virtio_gpu_output to virtgpu_displa=
y

Gustavo A. R. Silva (1):
      video: fbdev: fsl-diu-fb: mark expected switch fall-throughs

Gwan-gyeong Mun (1):
      drm/i915: Split a setting of MSA to MST and SST

Hans Verkuil (1):
      drm/Kconfig: add missing 'depends on DRM' for DRM_DP_CEC

Hans de Goede (19):
      drm/modes: parse_cmdline: Fix possible reference past end of string
      drm/modes: parse_cmdline: Make various char pointers const
      drm/modes: parse_cmdline: Stop parsing extras after bpp / refresh at =
', '
      drm/modes: parse_cmdline: Accept extras directly after mode
combined with options
      drm/modes: parse_cmdline: Rework drm_mode_parse_cmdline_options()
      drm/modes: parse_cmdline: Add freestanding argument to
drm_mode_parse_cmdline_options()
      drm/modes: parse_cmdline: Set bpp/refresh_specified after
successful parsing
      drm/modes: parse_cmdline: Allow specifying stand-alone options
      drm/modes: parse_cmdline: Add support for specifying
panel_orientation (v2)
      drm/modes: parse_cmdline: Remove some unnecessary code (v2)
      drm/modes: parse_cmdline: Explicitly memset the passed in
drm_cmdline_mode struct
      drm/i915: opregion: set opregion chpd value to indicate the
driver handles hotplug
      ACPI / LPSS: Rename pwm_backlight pwm-lookup to pwm_soc_backlight
      mfd: intel_soc_pmic: Rename pwm_backlight pwm-lookup to pwm_pmic_back=
light
      drm/i915: DSI: select correct PWM controller to use based on the VBT
      drm/i915/dsi: Move poking of panel-enable GPIO to intel_dsi_vbt.c
      drm/i915/dsi: Init panel-enable GPIO to low when the LCD is
initially off (v2)
      drm/i915/dsi: Move Crystal Cove PMIC panel GPIO lookup from mfd
to the i915 driver
      drm/i915/dsi: Control panel and backlight enable GPIOs on BYT

Harigovindan P (2):
      drm/msm: add DSI support for sc7180
      drm/msm: update LANE_CTRL register value from default value

Harry Wentland (1):
      drm/amd/display: Drop AMD_EDID_UTILITY defines

Hawking Zhang (18):
      drm/amdgpu: enable ras capablity check on arcturus
      drm/amdgpu: init umc functions for arcturus umc ras
      drm/amdgpu: add psp funcs for ring write pointer read/write
      drm/amdgpu: add helper func for psp ring cmd submission
      drm/amdgpu: switch to common helper func for psp cmd submission
      drm/amdgpu: pull ras controller int status only when ras enabled
      drm/amdgpu: apply gpr/gds workaround before enabling GFX EDC mode
      drm/amdgpu: drop asd shared memory
      drm/amdgpu: unload asd in psp hw de-init phase
      drm/amdgpu: load np fw prior before loading the TAs
      drm/amdgpu: fix resume failures due to psp fw loading sequence change=
 (v3)
      drm/amdgpu: add query_ras_error_count function for sdma v4
      drm/amdgpu: support error reporting for sdma ip block
      drm/amdgpu: add ras_late_init and ras_fini for sdma v4
      drm/amdgpu: read sdma edc counter to clear the counters
      drm/amdgpu: check sdma ras funcs pointer before accessing
      drm/amdgpu: check if driver should try recovery in ras recovery path
      drm/amdgpu: add arcturus to gpu recovery check code path

Heiko Stuebner (12):
      drm/bridge/synopsys: dsi: driver-specific configuration of phy timing=
s
      drm/bridge/synopsys: dsi: move phy_ops callbacks around panel enablem=
ent
      dt-bindings: display: rockchip-dsi: document external phys
      drm/rockchip: add ability to handle external dphys in mipi-dsi
      dt-bindings: display: rockchip-dsi: add px30 compatible
      drm/rockchip: dsi: add px30 support
      dt-bindings: Add vendor prefix for Xinpeng Technology
      dt-bindings: display: panel: Add binding document for Xinpeng XPP055C=
272
      drm/panel: add panel driver for Xinpeng XPP055C272 panels
      dt-bindings: Add vendor prefix for Leadtek Technology
      dt-bindings: display: panel: Add binding document for Leadtek LTK500H=
D1829
      drm/panel: add panel driver for Leadtek LTK500HD1829

Huang Rui (4):
      drm/amdkfd: expose num_sdma_queues_per_engine data field to
topology node (v2)
      drm/amdkfd: expose num_cp_queues data field to topology node (v2)
      drm/amdkfd: use map_queues for hiq on gfx v10 as well
      drm/amdgpu: only set cp active field for kiq queue

Hugo Hu (3):
      drm/amd/display: Update background color in bottommost mpcc
      drm/amd/display: Save/restore link setting for disable phy when
link retraining
      drm/amd/display: disable lttpr for Navi

Icenowy Zheng (4):
      drm/bridge: move ANA78xx driver to analogix subdirectory
      drm/bridge: split some definitions of ANX78xx to dedicated headers
      drm/bridge: extract some Analogix I2C DP common code
      drm/bridge: Add Analogix anx6345 support

Ilia Mirkin (1):
      drm/nouveau/kms/gf119-: allow both 256- and 1024-sized LUTs to be use=
d

Ilya Bakoulin (1):
      drm/amd/display: Add DSC 422Native debug option

Imre Deak (10):
      drm/i915: Fix detection for a CMP-V PCH
      drm/i915: Restore GT coarse power gating workaround
      drm/i915: Add helpers to select correct ccs/aux planes
      drm/i915/tgl: Make sure FBs have a correct CCS plane stride
      drm/i915: Make sure Y slave planes get all the required state
      drm/i915: Make sure CCS YUV semiplanar format checks work
      drm/i915: Add support for non-power-of-2 FB plane alignment
      drm/i915/tgl: Make sure a semiplanar UV plane is tile row size aligne=
d
      drm/i915: Add debug message for FB plane[0].offset!=3D0 error
      drm/i915: Make sure plane dims are correct for UV CCS planes

Inki Dae (1):
      drm/exynos: change callback names

Jack Zhang (7):
      drm/amd/amdgpu/sriov temporarily skip ras,dtm,hdcp for arcturus VF
      drm/amd/amdgpu/sriov skip RLCG s/r list for arcturus VF.
      drm/amd/amdgpu/sriov skip jpeg ip block for ARCTURUS VF
      amd/amdgpu/sriov swSMU disable for sriov
      amd/amdgpu/sriov enable onevf mode for ARCTURUS VF
      amd/amdgpu/sriov tdr enablement with pp_onevf_mode
      drm/amdgpu/sriov skip the update of SMU_TABLE_ACTIVITY_MONITOR_COEFF

Jacopo Mondi (6):
      dt-bindings: display: renesas,cmm: Add R-Car CMM documentation
      dt-bindings: display: renesas,du: Document cmms property
      drm: rcar-du: Add support for CMM
      drm: rcar-du: kms: Initialize CMM instances
      drm: rcar-du: crtc: Control CMM operations
      drm: rcar-du: crtc: Register GAMMA_LUT properties

Jaehyun Chung (2):
      drm/amd/display: DML Validation Dump/Check with Logging
      drm/amd/display: Wrong ifdef guards were used around DML validation

Jagan Teki (5):
      dt-bindings: sun6i-dsi: Document A64 MIPI-DSI controller
      dt-bindings: sun6i-dsi: Add A64 DPHY compatible (w/ A31 fallback)
      drm/sun4i: dsi: Get the mod clock for A31
      drm/sun4i: dsi: Handle bus clock via regmap_mmio_attach_clk
      drm/sun4i: dsi: Add Allwinner A64 MIPI DSI support

James Ausmus (1):
      drm/i915/tgl: Add second TGL PCH ID

James Jones (2):
      drm/nouveau: Fix ttm move init with multiple GPUs
      drm/nouveau/mmu: Add correct turing page kinds

James Zhu (13):
      drm/amdgpu/gfx: Clear more EDC cnt
      drm/amdgpu/gfx: Increase dispatch packet number
      drm/amdgpu/gfx: Improvement on EDC GPR workarounds
      drm/amdgpu: Add mmCOMPUTE_STATIC_THREAD_MGMT_SE4-7 to support Arcturu=
s
      drm/amdgpu/gfx: Replace ARRAY_SIZE with size variable
      drm/amdgpu/gfx: Add mmCOMPUTE_STATIC_THREAD_MGMT_SE4-7 to support Arc=
turus
      drm/amdgpu/gfx: Add mmSDMA2-7_EDC_COUNTER to support Arcturus
      drm/amdgpu/vcn: support multiple-instance dpg pause mode
      drm/amdgpu/vcn: support multiple instance direct SRAM read and write =
(v2)
      drm/amdgpu/vcn: move macro from vcn2.0 to share amdgpu_vcn (v2)
      drm/amdgpu/vcn2.5: add DPG mode start and stop
      drm/amdgpu/vcn2.5: add dpg pause mode
      drm/amdgpu/vcn2.5: implement indirect DPG SRAM mode

Jane Jian (6):
      drm/amdgpu: add VCN2.5 MMSCH start for Arcturus
      drm/amdgpu: add VCN2.5 sriov start for Arctrus
      drm/amdgpu: update VCN1(dual instances) fw types ID and VCN ip block =
type
      drm/amdgpu: skip VCN2.5 power gating and clock gating for sriov Arctu=
rus
      drm/amdgpu: enable VCN0 and VCN1 sriov instances support for Arcturus
      drm/amdgpu: disable VCN2.5 ib test for Arcturus sriov

Jani Nikula (75):
      drm/i915: add for_each_port() and use it
      drm/i915: update rawclk also on resume
      drm/i915/dsc: make parameter arrays const
      drm/i915/dsc: clean up rc parameter table access
      drm/i915/dsc: split out encoder specific parts from DSC compute param=
s
      drm/i915/dsc: rename functions for consistency
      drm/i915/display: only include intel_dp_link_training.h where needed
      drm/dsi: clean up DSI data type definitions
      drm/dsi: add missing DSI data types
      drm/dsi: add missing DSI DCS commands
      drm/dsi: rename MIPI_DCS_SET_PARTIAL_AREA to MIPI_DCS_SET_PARTIAL_ROW=
S
      drm/dsi: add helpers for DSI compression mode and PPS packets
      drm/i915/bios: use a flag for vbt hdmi level shift presence
      drm/i915/bios: store child devices in a list
      drm/i915: use drm_debug_enabled() to check for debug categories
      drm/nouveau: use drm_debug_enabled() to check for debug categories
      drm/amdgpu: use drm_debug_enabled() to check for debug categories
      drm/print: rename drm_debug to __drm_debug to discourage use
      drm/print: underscore prefix functions that should be private to prin=
t
      drm/print: convert debug category macros into an enum
      drm/print: group logging functions by prink or device based
      Merge drm/drm-next into drm-intel-next-queued
      drm/i915: fix accidental static variable use
      drm/r128: make ATI PCI GART part of its only user, r128
      Merge tag 'topic/drm-mipi-dsi-dsc-updates-2019-11-11' of
git://anongit.freedesktop.org/drm/drm-intel into drm-intel-next-queued
      video: fb_defio: preserve user fb_ops
      drm/fb-helper: don't preserve fb_ops across deferred IO use
      video: smscufx: don't restore fb_mmap after deferred IO cleanup
      video: udlfb: don't restore fb_mmap after deferred IO cleanup
      video: fbdev: vesafb: modify the static fb_ops directly
      video: fbmem: use const pointer for fb_ops
      video: omapfb: use const pointer for fb_ops
      video: fbdev: atyfb: modify the static fb_ops directly
      video: fbdev: mb862xx: modify the static fb_ops directly
      video: fbdev: nvidia: modify the static fb_ops directly
      video: fbdev: uvesafb: modify the static fb_ops directly
      video: fbdev: make fbops member of struct fb_info a const pointer
      drm: constify fb ops across all drivers
      video: fbdev: intelfb: use const pointer for fb_ops
      video: constify fb ops across all drivers
      HID: picoLCD: constify fb ops
      samples: vfio-mdev: constify fb ops
      drm/i915/bios: pass devdata to parse_ddi_port
      drm/i915/bios: parse compression parameters block
      drm/i915/bios: add support for querying DSC details for encoder
      drm/i915/dsc: move DP specific compute params to intel_dp.c
      drm/i915/dsc: move slice height calculation to encoder
      drm/i915/dsc: add support for computing and writing PPS for DSI encod=
ers
      drm/i915/dsc: make DSC source support helper generic
      drm/i915/dsc: add basic hardware state readout support
      drm/i915/dsi: set pipe_bpp on ICL configure config
      drm/i915/dsi: abstract afe_clk calculation
      drm/i915/dsi: use afe_clk() instead of intel_dsi_bitrate()
      drm/i915/dsi: take compression into account in afe_clk()
      drm/i915/dsi: use compressed pixel format with DSC
      drm/i915/dsi: account for DSC in horizontal timings
      drm/i915/dsi: add support for DSC
      Merge drm/drm-next into drm-intel-next-queued
      auxdisplay: constify fb ops
      media: constify fb ops across all drivers
      drm/i915/dsi: fix pipe D readout for DSI transcoders
      drm/print: introduce new struct drm_device based logging macros
      drm/i915/dsc: fix DSC register selection for ICL DSI transcoders
      drm/i915/dsc: clarify DSC support for pipe A on ICL
      drm/i915/dsc: fix DSC power domains for DSI
      drm/client: convert to drm device based logging
      drm/fb-helper: convert to drm device based logging
      drm/gem-fb-helper: convert to drm device based logging
      drm/i915: fix comment for POWER_DOMAIN_TRANSCODER_VDSC_PW2
      drm/i915/selftests: make mock_context.h self-contained
      drm/i915/selftests: make mock_drm.h self-contained
      drm/i915: Update DRIVER_DATE to 20191223
      Merge branch 'ib-pinctrl-unreg-mappings' of
git://git.kernel.org/.../linusw/linux-pinctrl into
drm-intel-next-queued
      Merge drm/drm-next into drm-intel-next-queued
      drm/i915: Update DRIVER_DATE to 20200114

Jay Cornwall (1):
      drm/amdgpu: Update Arcturus golden registers

Jean Delvare (1):
      drm/edid: no CEA v3 extension is not an error

Jerry Han (1):
      drm/panel: Add Boe Himax8279d MIPI-DSI LCD panel

Jing Zhou (1):
      drm/amd/display: rx_validation failed resume from sleep

John Clements (15):
      drm/amdgpu: Resolved offchip EEPROM I/O issue
      drm/amdgpu: Added ASIC specific checks in gfxhub V1.1 get XGMI info
      drm/amdgpu: Added RAS UMC error query support for Arcturus
      drm/amdgpu: Added ASIC specific check in gmc v9.0 ECC interrupt
programming sequence
      drm/amdgpu: by default output PSP ret status in event of cmd failure
      drm/amdgpu: amalgamate PSP TA load/unload functions
      drm/amdgpu: amalgamated PSP TA invoke functions
      drm/amdgpu: update UMC 6.1 RAS error counter register access path
      drm/amdgpu: resolve bug in UMC 6 error counter query
      drm/amdgpu: added function to wait for PSP BL availability
      drm/amdgpu: removed GFX RAS support check in UMC ECC callback
      drm/amdgpu: resolved bug in UMC RAS CE query
      drm/amdgpu: updated UMC error address record with correct channel ind=
ex
      drm/amdgpu: disable XGMI TA unload for arcturus
      drm/amdgpu: preserve RSMU UMC index mode state

John Stultz (5):
      dma-buf: heaps: Add heap helpers
      dma-buf: heaps: Add system heap to dmabuf heaps
      dma-buf: heaps: Add CMA heap to dmabuf heaps
      kselftests: Add dma-heap test
      drm: msm: Quiet down plane errors in atomic_check

Jonathan Kim (2):
      drm/amdgpu: add perfmons accessible during df c-states
      drm/amdgpu: attempt xgmi perfmon re-arm on failed arm

Joseph Gravenor (8):
      drm/amd/display: Renoir chroma viewport WA change formula
      drm/amd/display: Renoir chroma viewport WA Read the correct register
      drm/amd/display: fix DalDramClockChangeLatencyNs override
      drm/amd/display: populate bios integrated info for renoir
      drm/amd/display: have two different sr and pstate latency tables
for renoir
      drm/amd/display: update p-state latency for renoir when using lpddr4
      drm/amd/display: update sr latency for renoir when using lpddr4
      drm/amd/display: stop doing unnecessary detection when going to D3

Joseph Greathouse (3):
      drm/amdgpu: Create generic DF struct in adev
      drm/amdgpu: add defines for DF and TCP Hashing
      drm/amdgpu: Match TC hash settings to DF settings (v2)

Joshua Aberback (2):
      drm/amd/display: Adjust DML workaround threshold
      drm/amd/display: Add interface to adjust DSC max target bpp limit

Josip Pavic (2):
      drm/amd/display: fix regamma build optimization
      drm/amd/display: implement fw-driver interface for abm 2.4

Jos=C3=A9 Roberto de Souza (30):
      drm/i915: Add for_each_new_intel_connector_in_state()
      drm/i915/display: Fix TRANS_DDI_MST_TRANSPORT_SELECT definition
      drm/i915/display/dsi: Add support to pipe D
      drm/i915/display/mst: Enable virtual channel payload allocation earli=
er
      drm/i915/mst: Check uapi enable not intel one during mst atomic check
      drm/i915/psr: Add bits per pixel limitation
      drm/i915/psr: Refactor psr short pulse handler
      drm/i915/psr: Enable ALPM lock timeout error interruption
      drm/i915/psr: Check if sink PSR capability changed
      drm/i915/vbt: Parse power conservation features block
      drm/i915/display: Suspend MST topology manager before destroy fbdev
      drm/i915/display: Check the old state to find port sync slave
      drm/i915/dp: Power down sink before disable pipe/transcoder clock
      drm/i915/display/mst: Move DPMS_OFF call to post_disable
      drm/i915: Add new EHL/JSL PCI ids
      drm/i915/display: Do not check for the ddb allocations of turned off =
pipes
      drm/i915/display/tgl: Fix the order of the step to turn
transcoder clock off
      drm/i915/display: Refactor intel_commit_modeset_disables()
      drm/i915/display: Share intel_connector_needs_modeset()
      drm/i915/tgl: Select master transcoder for MST stream
      drm/i915/display: Always enables MST master pipe first
      drm/i915/dp: Fix MST disable sequence
      drm/i915/display: Prepare for fastset external dependencies check
      drm/i915/mst: Force modeset on MST slaves when master needs a modeset
      drm/i915/display: Add comment to a function that probably can be remo=
ved
      drm/i915/display: Use external dependency loop for port sync
      drm/i915/display: Force the state compute phase once to enable PSR
      drm/i915/display/icl+: Do not program clockgating
      drm/i915/display: Fix warning about MST and DDI restrictions
      drm/mst: Don't do atomic checks over disabled managers

Jules Irenge (1):
      drm: radeon: replace 0 with NULL

Julia Lawall (1):
      drm: bridge: dw-hdmi: constify copied structure

Jun Lei (3):
      drm/amd/display: add oem i2c implemenation in dc
      drm/amd/display: support virtual DCN
      drm/amd/display: fixup DML dependencies

Juston Li (1):
      drm/i915: coffeelake supports hdcp2.2

Jyri Sarha (1):
      drm/tilcdc: Remove obsolete bundled tilcdc tfp410 driver

Kai Vehmanen (2):
      drm/i915/dp: fix DP audio for PORT_A on gen12+
      drm/i915: Limit audio CDCLK>=3D2*BCLK constraint back to GLK only

Kalyan Thota (4):
      dt-bindings: msm:disp: add sc7180 DPU variant
      msm:disp:dpu1: add support for display for SC7180 target
      msm:disp:dpu1: setup display datapath for SC7180 target
      msm:disp:dpu1: add mixer selection for display topology

Kenneth Feng (1):
      drm/amd/powerplay: sw ctf for arcturus

Kevin Wang (5):
      drm/amdgpu: enable gfxoff feature for navi10 asic
      drm/amdgpu/smu: use unified variable smu->is_apu to check apu
asic platform
      drm/amdgpu/smu: add helper function smu_get_dpm_level_range()
for smu driver
      drm/amdgpu: use linux size macro to simplify ONE_Kib & One_Mib
      drm/amdgpu/smu: custom pstate profiling clock frequence for navi
series asics

Kieran Bingham (1):
      drm: rcar-du: Add r8a77980 support

Krunoslav Kovac (1):
      drm/amd/display: Change HDR_MULT check

Krzysztof Kozlowski (12):
      vga: Fix Kconfig indentation
      drm/udl: Fix Kconfig indentation
      drm/rockchip: Fix Kconfig indentation
      drm/omap: Fix Kconfig indentation
      drm/nouveau: Fix Kconfig indentation
      drm/lima: Fix Kconfig indentation
      drm/bridge: Fix Kconfig indentation
      drm/mgag200: Fix Kconfig indentation
      drm/vc4: Fix Kconfig indentation
      drm/sun4i: Fix Kconfig indentation
      drm/amd: Fix Kconfig indentation
      drm/exynos: Rename Exynos to lowercase

Laurent Pinchart (2):
      drm: rcar-du: lvds: Get mode from state
      drm: of: Fix linking when CONFIG_OF is not set

Le Ma (11):
      drm/amdgpu: remove ras global recovery handling from
ras_controller_int handler
      drm/amdgpu: export amdgpu_ras_find_obj to use externally
      drm/amdgpu: clear ras controller status registers when interrupt occu=
rs
      drm/amdgpu: clear uncorrectable parity error status bit
      drm/amdgpu: enable/disable doorbell interrupt in baco entry/exit help=
er
      drm/amdgpu: add concurrent baco reset support for XGMI
      drm/amdgpu: support full gpu reset workflow when ras
err_event_athub occurs
      drm/amdgpu: clear err_event_athub flag after reset exit
      drm/amdgpu: reduce redundant uvd context lost warning message
      drm/amdgpu: add condition to enable baco for ras recovery
      drm/amdgpu: fix ctx init failure for asics without gfx ring

Leandro Ribeiro (1):
      drm/doc: Update IGT documentation

Lee Shawn C (2):
      drm/i915/cml: Remove unsupport PCI ID
      drm/i915/cml: Separate U series pci id from origianl list.

Leo (Hanghong) Ma (3):
      drm/amd/display: Add some hardware status in DTN log debugfs
      drm/amd/display: Add hubp clock status in DTN log for Navi
      drm/amd/display: Change the delay time before enabling FEC

Leo Li (2):
      drm/amd/display: Send vblank and user events at vsartup for DCN
      drm/amd/display: Disable VUpdate interrupt for DCN hardware

Leo Liu (29):
      drm/amdgpu: add JPEG HW IP and SW structures
      drm/amdgpu: add amdgpu_jpeg and JPEG tests
      drm/amdgpu: separate JPEG1.0 code out from VCN1.0
      drm/amdgpu: use the JPEG structure for general driver support
      drm/amdgpu: add JPEG IP block type
      drm/amdgpu: add JPEG common functions to amdgpu_jpeg
      drm/amdgpu: add JPEG v2.0 function supports
      drm/amdgpu: remove unnecessary JPEG2.0 code from VCN2.0
      drm/amdgpu: add JPEG PG and CG interface
      drm/amdgpu: add PG and CG for JPEG2.0
      drm/amd/powerplay: add JPEG Powerplay interface
      drm/amd/powerplay: add JPEG power control for Navi1x
      drm/amd/powerplay: add Powergate JPEG for Renoir
      drm/amd/powerplay: add JPEG power control for Renoir
      drm/amd/powerplay: set JPEG to SMU dpm
      drm/amdgpu: enable JPEG2.0 dpm
      drm/amdgpu: add driver support for JPEG2.0 and above
      drm/amdgpu: enable JPEG2.0 for Navi1x and Renoir
      drm/amdgpu: move JPEG2.5 out from VCN2.5
      drm/amdgpu: enable Arcturus CG for VCN and JPEG blocks
      drm/amdgpu: enable Arcturus JPEG2.5 block
      drm/amdgpu/vcn2.5: fix the enc loop with hw fini
      drm/amdgpu: fix VCN2.x number of irq types
      drm/amdgpu: fix JPEG instance checking when ctx init
      drm/amdgpu/vcn1.0: use its own idle handler and begin use funcs
      drm/amdgpu/vcn: remove JPEG related code from idle handler and begin =
use
      drm/amdgpu/vcn: remove unnecessary included headers
      drm/amdgpu/vcn2.5: fix PSP FW loading for the second instance
      drm/amdgpu: enable VCN2.5 IP block for Arcturus

Lewis Huang (2):
      drm/amd/display: remove psr state condition when psr exit case
      drm/amd/display: Add monitor patch for AUO dpcd issue

Likun Gao (2):
      drm/amdgpu/powerplay: unify smu send message function
      drm/amdgpu/powerplay: fix NULL pointer issue when SMU disabled

Linus Walleij (8):
      drm/panel: Add DT bindings for Sony ACX424AKP
      drm/mcde: Reuse global DSI command defs
      drm/mcde: Do not needlessly logically and with 3
      drm/panel: Add generic DSI display controller YAML bindings
      drm/panel: rpi: Drop unused GPIO includes
      drm/gma500: Pass GPIO for Intel MID using descriptors
      drm/mcde: Some fixes to handling video mode
      drm/panel: Add driver for Sony ACX424AKP panel

Lionel Landwerlin (3):
      drm/i915/perf: always consider holding preemption a privileged op
      drm/i915/perf: don't forget noa wait after oa config
      drm/i915/perf: Add preemption check while waiting for OA

Lowry Li (Arm Technology China) (1):
      drm/komeda: Adds gamma and color-transform support for DOU-IPS

Luben Tuikov (1):
      drm/amdgpu: simplify padding calculations (v2)

Lucas De Marchi (28):
      drm/i915: add wrappers to get intel connector state
      drm/i915/tgl: do not enable transcoder clock twice on MST
      drm/i915: avoid reading DP_TP_CTL twice
      drm/i915: switch intel_ddi_init() to intel types
      drm/i915: do not warn late about hdmi on port A
      drm/i915/bios: rename bios to oprom when mapping pci rom
      drm/i915/bios: make sure to check vbt size
      drm/i915/tgl: allow DVI/HDMI on port A
      drm/i915/dsb: remove atomic operations
      drm/i915/dsb: fix extra warning on error path handling
      drm/i915/dsb: fix cmd_buf being wrongly set
      drm/i915/bios: do not discard address space
      drm/i915/bios: fold pci rom map/unmap into copy function
      drm/i915/bios: assume vbt is 4-byte aligned into oprom
      drm/i915/bios: remove extra debug messages
      drm/i915/display: move clk off sanitize to its own function
      drm/i915/display: use clk_off name to avoid double negation
      drm/i915/display: fix phy name
      drm/i915: simplify prefixes on device_info
      drm/i915: prefer 3-letter acronym for pineview
      drm/i915: prefer 3-letter acronym for haswell
      drm/i915: prefer 3-letter acronym for skylake
      drm/i915: prefer 3-letter acronym for cannonlake
      drm/i915: prefer 3-letter acronym for icelake
      drm/i915: prefer 3-letter acronym for ironlake
      drm/i915: prefer 3-letter acronym for broadwell
      drm/i915: prefer 3-letter acronym for ivybridge
      drm/i915: prefer 3-letter acronym for tigerlake

Lucy Li (1):
      drm/amd/display: Disable link before reenable

Lukas Bulwahn (1):
      drm/vmwgfx: Replace deprecated PTR_RET

Lukasz Fiedorowicz (1):
      drm/i915/lmem: debugfs for LMEM details

Lyude Paul (3):
      drm/nouveau/kms/nv50-: Remove nv50_mstc_best_encoder()
      drm/nouveau/kms/nv50-: Use less encoders by making mstos per-head
      drm/nouveau/kms/nv50-: Report possible_crtcs incorrectly on mstos, fo=
r now

Ma Feng (5):
      drm/amdgpu: Remove unneeded variable 'ret' in amdgpu_device.c
      drm/amdgpu: Remove unneeded variable 'ret' in navi10_ih.c
      drm/i915: use true,false for bool variable in i915_debugfs.c
      drm/i915/dp: use true,false for bool variable in intel_dp.c
      drm/i915: use true,false for bool variable in intel_crt.c

Maarten Lankhorst (15):
      drm/i915: Handle a few more cases for crtc hw/uapi split, v3.
      drm/i915: Add aliases for uapi and hw to crtc_state
      drm/i915: Perform manual conversions for crtc uapi/hw split, v2.
      drm/i915: Perform automated conversions for crtc uapi/hw split,
base -> hw.
      drm/i915: Perform automated conversions for crtc uapi/hw split,
base -> uapi.
      drm/i915: Complete crtc hw/uapi split, v6.
      drm/i915: Add aliases for uapi and hw to plane_state
      drm/i915: Perform manual conversions for plane uapi/hw split, v2.
      drm/i915: Perform automated conversions for plane uapi/hw split,
base -> hw.
      drm/i915: Perform automated conversions for plane uapi/hw split,
base -> uapi.
      drm/i915: Complete plane hw and uapi split, v2.
      drm/i915: Remove special case slave handling during hw programming, v=
3.
      Merge tag 'topic/drm-mipi-dsi-dsc-updates-2019-11-11' of
ssh://git.freedesktop.org/git/drm-intel into drm-misc-next
      udmabuf: Remove deleted map/unmap handlers.
      Merge drm/drm-next into drm-misc-next

Manasi Navare (6):
      drm/fbdev: Fallback to non tiled mode if all tiles not present
      drm: Handle connector tile support only for modes that match tile siz=
e
      drm/fbdev: Fallback to non tiled mode if all tiles not present
      drm/i915/dp: Make sure all tiled connectors get added to the
state with full modeset
      drm/i915/dp: Make port sync mode assignments only if all tiles presen=
t
      drm/i915/dp: Disable Port sync mode correctly on teardown

Mao Wenan (1):
      drm/i915/perf: drop pointless static qualifier in
i915_perf_add_config_ioctl()

Mario Kleiner (1):
      drm/amd/display: Reorder detect_edp_sink_caps before link settings re=
ad.

Mark Yacoub (2):
      drm/mediatek: Return from mtk_ovl_layer_config after mtk_ovl_layer_of=
f
      drm/mediatek: Turn off Alpha bit when plane format has no alpha

Markus Elfring (4):
      drm/komeda: Use devm_platform_ioremap_resource() in komeda_dev_create=
()
      drm/qxl: Complete exception handling in qxl_device_init()
      video: ocfb: Use devm_platform_ioremap_resource() in ocfb_probe()
      video: pxafb: Use devm_platform_ioremap_resource() in pxafb_probe()

Martin Leung (2):
      drm/amd/display: Enable Seamless Boot Transition for Multiple Streams
      drm/amd/display: Adding forgotten hubbub func

Martin Tsai (1):
      drm/amd/display: Use mdelay to avoid context switch

Masahiro Yamada (3):
      drm/i915: change to_mock() to an inline function
      drm/i915: make more headers self-contained
      drm/i915: reimplement header test feature

Matt Roper (20):
      drm/i915: Expand documentation for gen12 DP pre-enable sequence
      Revert "drm/i915/ehl: Update MOCS table for EHL"
      drm/i915/tgl: MOCS table update
      drm/i915/vbt: Parse panel options separately from timing data
      drm/i915/vbt: Handle generic DTD block
      drm/i915/ehl: Update voltage level checks
      drm/i915/tgl: Add DKL PHY vswing table for HDMI
      drm/i915: Handle SDEISR according to PCH rather than platform
      drm/i915/ehl: Make icp_digital_port_connected() use phy instead of po=
rt
      drm/i915: Program SHPD_FILTER_CNT on CNP+
      drm/i915/irq: Refactor gen11 display interrupt handling
      drm/i915/tgl: Program BW_BUDDY registers during display init
      drm/i915/ehl: Define EHL powerwells independently of ICL
      drm/i915/tgl: Drop Wa#1178
      drm/i915/icl: Cleanup combo PHY aux power well handlers
      drm/i915: Extend WaDisableDARBFClkGating to icl,ehl,tgl
      drm/i915: Add Wa_1408615072 and Wa_1407596294 to icl,ehl
      drm/i915/tgl: Extend Wa_1408615072 to tgl
      drm/i915/tgl: Assume future platforms will inherit TGL's SFC capabili=
ty
      drm/i915: Add Wa_1407352427:icl,ehl

Matthew Auld (3):
      drm/i915/lmem: fixup fake lmem teardown
      drm/i915: make pool objects read-only
      drm/i915/gtt: split up i915_gem_gtt

Matthew Brost (1):
      drm/i915/guc: Update uncore access path in flush_ggtt_writes

Maxime Ripard (4):
      drm/bridge: anx6345: Fix compilation breakage on systems without CONF=
IG_OF
      drm/sun4i: backend: Make sure we enforce the clock rate
      drm/sun4i: drc: Make sure we enforce the clock rate
      dt-bindings: display: Convert Allwinner display pipeline to schemas

Maya Rashish (1):
      Correct function name in comment

Michael Strauss (6):
      drm/amd/display: Avoid conflict between HDR multiplier and 3dlut
      drm/amd/display: Fix Dali clk mgr construct
      drm/amd/display: Disable chroma viewport w/a when rotated 180 degrees
      drm/amd/display: Add delay after h' watchdog timeout event
      drm/amd/display: add Pollock IDs, fix Pollock & Dali clk mgr construc=
t
      drm/amd/display: Update HDMI hang w/a to apply to all TMDS signals

Michal Wajdeczko (8):
      drm/i915/uc: Drop explicit i915 param in some uc_fw functions
      drm/i915/uc: Drop explicit gt param in some uc_fw functions
      drm/i915/uc: Drop explicit ggtt param in some uc_fw functions
      drm/i915: Improve i915_inject_probe_error macro
      drm/i915/uc: Add ops to intel_uc
      drm/i915/uc: Add init_fw/fini_fw to to intel_uc_ops
      drm/i915/uc: Add init/fini to to intel_uc_ops
      drm/i915/uc: Add sanitize to to intel_uc_ops

Michel Thierry (1):
      drm/i915/tgl: Implement Wa_1604555607

Mihail Atanassov (7):
      drm/komeda: Add debugfs node to control error verbosity
      drm/komeda: Remove CONFIG_KOMEDA_ERROR_PRINT
      drm/komeda: Optionally dump DRM state on interrupts
      drm/komeda: Add option to print WARN- and INFO-level IRQ events
      drm/komeda: add rate limiting disable to err_verbosity
      drm/mediatek: Fix build break
      drm/bridge: panel: export drm_panel_bridge_connector

Mikita Lipski (17):
      drm/amd/display: Add MST atomic routines
      drm/amd/display: Add debugfs initalization on mst connectors
      drm/amd/display: Fix debugfs on MST connectors
      drm/amd/display: Fix coding error in connector atomic check
      drm/amd/display: Return a correct error value
      drm/dp_mst: Add new quirk for Synaptics MST hubs
      drm/dp_mst: Manually overwrite PBN divider for calculating timeslots
      drm/dp_mst: Add DSC enablement helpers to DRM
      drm/dp_mst: Add branch bandwidth validation to MST atomic check
      drm/dp_mst: Rename drm_dp_mst_atomic_check_topology_state
      drm/amd/display: Add PBN per slot calculation for DSC
      drm/amd/display: Check return value of drm helper
      drm/amd/display: Recalculate VCPI slots for new DSC connectors
      drm/dp_mst: Add helper to trigger modeset on affected DSC MST CRTCs
      drm/amd/display: Trigger modesets on MST DSC connectors
      drm/amd/display: Fix compilation warnings on i386
      drm/amdgpu/display: Use u64 divide macro for round up division

Miquel Raynal (12):
      dt-bindings: display: rockchip-lvds: Declare PX30 compatible
      dt-bindings: display: rockchip-lvds: Document PX30 PHY
      drm/rockchip: lvds: Fix indentation of a #define
      drm/rockchip: lvds: Harmonize function names
      drm/rockchip: lvds: Change platform data to hold helper_funcs pointer
      drm/rockchip: lvds: Create an RK3288 specific probe function
      drm/rockchip: lvds: improve error handling in helper functions
      drm/rockchip: lvds: move hardware-specific functions together
      drm/rockchip: lvds: Add PX30 support
      dt-bindings: Add vendor prefix for Satoz
      dt-bindings: display: simple: Add Satoz panel
      drm/panel: simple: Add Satoz SAT050AT40H12R2 panel support

Monk Liu (8):
      drm/amdgpu: use CPU to flush vmhub if sched stopped
      drm/amdgpu: fix calltrace during kmd unload(v3)
      drm/amdgpu: skip rlc ucode loading for SRIOV gfx10
      drm/amdgpu: do autoload right after MEC loaded for SRIOV VF
      drm/amdgpu: should stop GFX ring in hw_fini
      drm/amdgpu: fix GFX10 missing CSIB set(v3)
      drm/amdgpu: fix double gpu_recovery for NV of SRIOV
      drm/amdgpu: fix KIQ ring test fail in TDR of SRIOV

Nathan Chancellor (3):
      drm/amd/display: Use NULL for pointer assignment in
copy_stream_update_to_stream
      drm/amdgpu: Ensure ret is always initialized when using SOC15_WAIT_ON=
_RREG
      drm: msm: mdp4: Adjust indentation in mdp4_dsi_encoder_enable

Navid Emamdoost (1):
      drm/vmwgfx: prevent memory leak in vmw_cmdbuf_res_add

Neil Armstrong (9):
      drm/meson: add AFBC decoder registers for GXM and G12A
      drm/meson: add RDMA register bits defines
      drm/meson: store the framebuffer width for plane commit
      drm/meson: add RDMA module driver
      drm/meson: Add AFBCD module driver
      drm/meson: plane: add support for AFBC mode for OSD1 plane
      drm/meson: viu: add AFBC modules routing functions
      drm/meson: hold 32 lines after vsync to give time for AFBC start
      drm/meson: crtc: add OSD1 plane AFBC commit

Nicholas Kazlauskas (27):
      drm/amdgpu: Add ucode support for DMCUB
      drm/amdgpu: Add PSP loading support for DMCUB ucode
      drm/amd/display: Drop DMCUB from DCN21 resources
      drm/amd/display: Add the DMUB service
      drm/amd/display: Hook up the DMUB service in DM
      drm/amdgpu: Add DMCUB to firmware query interface
      drm/amd/display: Add DMUB support to DC
      drm/amd/display: Register DMUB service with DC
      drm/amd/display: Drop CONFIG_DRM_AMD_DC_DMUB guards
      drm/amd/display: Add DMUB service function check if hw initialized
      drm/amd/display: Add DMUB param to load inst const from driver
      drm/amd/display: Don't spin forever waiting for DMCUB phy/auto init
      drm/amd/display: Spin for DMCUB PHY init in DC
      drm/amd/display: Add Navi10 DMUB VBIOS code
      drm/amd/display: Only wait for DMUB phy init on dcn21
      drm/amd/display: Return DMUB_STATUS_OK when autoload unsupported
      drm/amd/display: Program CW5 for tracebuffer for dcn20
      drm/amd/display: Split DMUB cmd type into type/subtype
      drm/amd/display: Add shared DMCUB/driver firmware state cache window
      drm/amd/display: Extend DMCUB offload testing into dcn20/21
      drm/amd/display: Get DMUB registers from ASIC specific structs
      drm/amd/display: Use physical addressing for DMCUB on both dcn20/21
      drm/amd/display: Perform DMUB hw_init on resume
      drm/amd/display: Get cache window sizes from DMCUB firmware
      drm/amd/display: Flush framebuffer data before passing to DMCUB
      drm/amd/display: Read inst_fb data back during DMUB loading
      drm/amd/display: Soft reset DMUIF during DMUB reset

Nickey Yang (1):
      drm: rockchip: rk3066_hdmi: set edid fifo address

Nikola Cornij (8):
      drm/amd/display: Add a sanity check for DSC already enabled/disabled
      drm/amd/display: Connect DIG FE to its BE before link training starts
      drm/amd/display: Use a temporary copy of the current state when
updating DSC config
      drm/amd/display: Map DSC resources 1-to-1 if numbers of OPPs and
DSCs are equal
      drm/amd/display: Reset steer fifo before unblanking the stream
      drm/amd/display: Map ODM memory correctly when doing ODM combine
      drm/amd/display: Add debug option to override DSC target bpp incremen=
t
      drm/amd/display: Disable secondary link for certain monitors

Niranjana Vishwanathapura (1):
      drm/i915: Remove unwanted rcu_read_lock/unlock

Nirmoy Das (8):
      drm/scheduler: rework entity creation
      drm/amdgpu: replace vm_pte's run-queue list with drm gpu scheds list
      amd/amdgpu: add sched array to IPs with multiple run-queues
      drm/scheduler: do not keep a copy of sched list
      drm/amdgpu: catch amdgpu_irq_add_id failure
      drm/amdgpu: error out on entity with no run queue
      drm/scheduler: improve job distribution with multiple queues
      drm/scheduler: fix documentation by replacing rq_list with sched_list

Noah Abradjian (11):
      drm/amd/display: Remove flag check in mpcc update
      drm/amd/display: Modify logic for when to wait for mpcc idle
      drm/amd/display: Remove redundant call
      drm/amd/display: Add wait for flip not pending on pipe unlock
      drm/amd/display: Use pipe_count for num of opps
      drm/amd/display: Collapse resource arrays when pipe is disabled
      drm/amd/display: Remove reliance on pipe indexing
      drm/amd/display: Add double buffering to dcn20 OCSC
      drm/amd/display: Fix double buffering in dcn2 ICSC
      drm/amd/display: Double buffer dcn2 Gamut Remap
      drm/amd/display: Indirect reg read macro with shift and mask

Oak Zeng (1):
      drm/amdgpu: Apply noretry setting for mmhub9.4

Ondrej Jirman (1):
      drm: sun4i: Add support for suspending the display driver

Pan Zhang (1):
      gpu: drm: dead code elimination

Pan, Xinhui (1):
      drm/amdgpu: add the lost mutex_init back

Pankaj Bharadiya (1):
      drm/i915/display: cleanup intel_bw_state on i915 module removal

Patrik Jakobsson (1):
      drm/scdc: Fix typo in bit definition of SCDC_STATUS_FLAGS

Paul Cercueil (8):
      dt-bindings: display/ingenic: Add compatible string for JZ4770
      gpu/drm: ingenic: Avoid null pointer deference in plane atomic update
      gpu/drm: ingenic: Use the plane's src_[x,y] to configure DMA length
      gpu/drm: ingenic: Set max FB height to 4095
      gpu/drm: ingenic: Check for display size in CRTC atomic check
      gpu/drm: ingenic: Add support for the JZ4770
      dt-bindings: panel-simple: Add compatible for GiantPlus GPM940B0
      dt-bindings: panel-simple: Add compatible for Sharp LS020B1DD01D

Paul Hsieh (3):
      drm/amd/display: Reset PHY in link re-training
      drm/amd/display: check link status before disable stream
      drm/amd/display: reallocate MST payload when link loss

Paul Kocialkowski (3):
      drm/gma500: Add missing call to allow enabling vblank on psb/cdv
      drm/gma500: Add page flip support on psb/cdv
      drm/gma500: Fixup fbdev stolen size usage evaluation

Peter Rosin (4):
      fbdev: fix numbering of fbcon options
      fbdev: fbmem: allow overriding the number of bootup logos
      fbdev: fbmem: avoid exporting fb_center_logo
      drm: atmel-hlcdc: prefer a lower pixel-clock than requested

Philip Yang (1):
      drm/amdkfd: queue kfd interrupt work to different CPU

Pi-Hsun Shih (1):
      drm/mediatek: Check return value of mtk_drm_ddp_comp_for_plane.

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: add cache flush workaround to gfx8 emit_fence

Qiang Yu (1):
      drm/lima: use drm_sched_fault for error task handling

Qingqing Zhuo (1):
      drm/amd/display: AVI info package change due to spec update

Radhakrishna Sripada (1):
      drm/i915/tgl: Wa_1606679103

Ramalingam C (3):
      drm/i915: FB backing gem obj should reside in LMEM
      drm/i915: lookup for mem_region of a mem_type
      drm/i915: Create dumb buffer from LMEM

Reza Amini (3):
      drm/amd/display: Unify all scaling when Integer Scaling enabled
      drm/amd/display: Implement DePQ for DCN1
      drm/amd/display: Implement DePQ for DCN2

Rob Clark (9):
      drm/msm/dpu: ignore NULL clocks
      drm/msm/a6xx: restore previous freq on resume
      drm/msm/adreno: fix zap vs no-zap handling
      drm/msm/dsi: split clk rate setting and enable
      dt-bindings: display: panel: Add AUO B116XAK01 panel bindings
      drm/panel: Add support for AUO B116XAK01 panel
      drm/msm: support firmware-name for zap fw (v2)
      drm/msm: allow zapfw to not be specified in gpulist
      dt-bindings: drm/msm/gpu: Document firmware-name

Robin Murphy (1):
      drm/panfrost: Register devfreq cooling device

Rodrigo Siqueira (3):
      drm: Fix DSC throughput mode 0 mask definition
      drm: Add FEC registers for LT-tunable repeaters
      drm/amd/include: Add OCSC registers

Roland Scheidegger (1):
      drm/vmwgfx: add ioctl for messaging from/to guest userspace to/from h=
ost

Roman Li (4):
      drm/amdgpu: move dpcs headers to dpcs includes
      drm/amdgpu: add dpcs20 registers
      drm/amd/display: add missing dcn link encoder regs
      drm/amd/display: Default max bpc to 16 for eDP

Sam Bobroff (2):
      drm/radeon: fix bad DMA from INTERRUPT_CNTL2
      drm/amdgpu: fix bad DMA from INTERRUPT_CNTL2

Sam Ravnborg (33):
      drm/exynos: fix opencoded use of drm_panel_*
      drm/exynos: fix opencoded use of drm_panel_*
      drm/msm: fix opencoded use of drm_panel_*
      drm/tegra: fix opencoded use of drm_panel_*
      drm/drm_panel: no error when no callback
      drm/panel: add backlight support
      drm/panel: simple: use drm_panel backlight support
      drm: get drm_bridge_panel connector via helper
      drm/panel: add drm_connector argument to get_modes()
      drm/panel: decouple connector from drm_panel
      drm/panel: drop drm_device from drm_panel
      drm/panel: feiyang-fy07024di26a30d: use drm_panel backlight support
      drm/panel: ilitek-ili9881c: use drm_panel backlight support
      drm/panel: innolux-p079zca: use drm_panel backlight support
      drm/panel: kingdisplay-kd097d04: use drm_panel backlight support
      drm/panel: lvds: use drm_panel backlight support
      drm/panel: olimex-lcd-olinuxino: use drm_panel backlight support
      drm/panel: osd-osd101t2587-53ts: use drm_panel backlight support
      drm/panel: panasonic-vvx10f034n00: use drm_panel backlight support
      drm/panel: raydium-rm68200: use drm_panel backlight support
      drm/panel: rocktech-jh057n00900: use drm_panel backlight support
      drm/panel: ronbo-rb070d30: use drm_panel backlight support
      drm/panel: seiko-43wvf1g: use drm_panel backlight support
      drm/panel: sharp-lq101r1sx01: use drm_panel backlight support
      drm/panel: sharp-ls043t1le01: use drm_panel backlight support
      drm/panel: sitronix-st7701: use drm_panel backlight support
      drm/panel: sitronix-st7789v: use drm_panel backlight support
      drm/panel: tpo-td028ttec1: use drm_panel backlight support
      drm/panel: tpo-tpg110: use drm_panel backlight support
      drm/drm_panel: fix EXPORT of drm_panel_of_backlight
      dt-bindings: fix warnings in xinpeng,xpp055c272.yaml
      dt-bindings: one binding file for all simple panels
      dt-bindings: display: add BOE 14" panel

Samson Tam (4):
      drm/amd/display: Fix stereo with DCC enabled
      drm/amd/display: revert change causing DTN hang for RV
      drm/amd/display: fix 270 degree rotation for mixed-SLS mode
      drm/amd/display: fix missing cursor on some rotated SLS displays

Sean Paul (2):
      MAINTAINERS: Remove myself from drm-misc entry
      drm/dp_mst: Clear all payload id tables downstream when initializing

Sharat Masetty (3):
      drm: msm: Add 618 gpu to the adreno gpu list
      drm: msm: a6xx: Add support for A618
      drm: msm: a6xx: Dump GBIF registers, debugbus in gpu state

Shubhashree Dhar (3):
      msm: disp: dpu1: add support to access hw irqs regs depending on revi=
sion
      msm:disp:dpu1: add scaler support on SC7180 display
      msm:disp:dpu1: Fix core clk rate in display driver

Simon Ser (1):
      drm/amdgpu: log when amdgpu.dc=3D1 but ASIC is unsupported

Souptick Joarder (1):
      video/fbdev/68328fb: Remove dead code

Stanislav Lisovskiy (2):
      drm/i915: Support more QGV points
      drm/i915: Bump up CDCLK to eliminate underruns on TGL

Stephan Gerhold (8):
      drm/mcde: Provide vblank handling unconditionally
      drm/mcde: Fix frame sync setup for video mode panels
      drm/mcde: dsi: Make video mode errors more verbose
      drm/mcde: dsi: Delay start of video stream generator
      drm/mcde: dsi: Fix duplicated DSI connector
      drm/mcde: dsi: Enable clocks in pre_enable() instead of mode_set()
      drm/mcde: Handle pending vblank while disabling display
      drm/msm/dsi: Delay drm_panel_enable() until dsi_mgr_bridge_enable()

Stephen Boyd (1):
      drm/msm/dpu: Mark various data tables as const

Stephen Rothwell (2):
      merge fix for "ftrace: Rework event_create_dir()"
      linux-next: build failure after merge of the drm-misc tree

Steven Price (1):
      dma_resv: prime lockdep annotations

Stuart Summers (3):
      Skip MCHBAR queries when display is not available
      drm/i915: Do not initialize display BW when display not available
      drm/i915: Use intel_gt_pm_put_async in GuC submission path

Stylon Wang (1):
      drm/amd/display: Fix incorrect deep color setting in YCBCR420 modes

Sung Lee (5):
      drm/amd/display: Use SIGNAL_TYPE_NONE in disable_output unless eDP
      drm/amd/display: Fix update_bw_bounding_box Calcs
      drm/amd/display: Lower DPP DTO only when safe
      drm/amd/display: Formula refactor for calculating DPP CLK DTO
      drm/amd/display: Use SMU ClockTable Values for DML Calculations

Takashi Iwai (1):
      drm/nouveau: Add HD-audio component notifier support

Thierry Reding (14):
      drm: Fix a couple of typos, punctation and whitespace issues
      drm/atomic: Spell CRTC consistently
      gpu: host1x: Rename "parent" to "host"
      drm/tegra: Do not implement runtime PM
      drm/tegra: output: Implement system suspend/resume
      drm/nouveau/fault: Add support for GP10B
      drm/nouveau: Do not try to disable PCI device on Tegra
      drm/nouveau/tegra: Avoid pulsing reset twice
      drm/nouveau/tegra: Set clock rate if not set
      drm/nouveau/secboot/gm20b,gp10b: Read WPR configuration from GPU regi=
sters
      drm/nouveau/ltc/gp10b: Add custom L2 cache implementation
      drm/nouveau/ce/gp10b: Use correct copy engine
      drm/nouveau/pmu/gm20b,gp10b: Fix Falcon bootstrapping
      drm/nouveau/gr/gp10b: Use gp100_grctx and gp100_gr_zbc

Thomas Anderson (2):
      drm/edid: Increase size of VDB and CMDB bitmaps to 256 bits
      drm/amd/display: Reduce HDMI pixel encoding if max clock is exceeded

Thomas Hellstrom (5):
      drm/ttm: Remove explicit typecasts of vm_private_data
      drm/ttm: Convert vm callbacks to helpers
      drm/vmwgfx: Don't use the HB port if memory encryption is active
      drm/vmwgfx: Bump driver minor version
      drm/vmwgfx: Use VM_PFNMAP instead of VM_MIXEDMAP when possible

Thomas Zimmermann (80):
      drm/todo: Convert drivers to generic fbdev emulation
      drm/fb-helper: Remove drm_fb_helper_fbdev_{setup, teardown}()
      drm/ast: Remove last traces of struct ast_gem_object
      drm/ast: Check video-mode requirements against VRAM size
      drm/ast: Don't clear base address and offset with default values
      drm/ast: Split ast_set_ext_reg() into color and threshold function
      drm/ast: Split ast_set_vbios_mode_info()
      drm/ast: Add primary plane
      drm/ast: Add CRTC helpers for atomic modesetting
      drm/ast: Add cursor plane
      drm/ast: Enable atomic modesetting
      drm/udl: Remove flags field from struct udl_gem_object
      drm/udl: Allocate GEM object via struct drm_driver.gem_create_object
      drm/udl: Switch to SHMEM
      drm/udl: Remove struct udl_gem_object and functions
      drm/ast: Replace drm_get_pci_device() and drm_put_dev()
      drm/ast: Call struct drm_driver.{load, unload} before registering dev=
ice
      drm/udl: Replace fbdev code with generic emulation
      drm/fb-helper: Remove drm_fb_helper_unlink_fbi()
      fbdev: Unexport unlink_framebuffer()
      drm/gma500: Remove addr_space field from psb_framebuffer
      drm/gma500: Remove field 'fbdev' from struct psb_framebuffer
      drm/gma500: Replace struct psb_framebuffer with struct drm_framebuffe=
r
      drm/gma500: Pass struct drm_gem_object to framebuffer functions
      drm/gma500: Store framebuffer in struct drm_fb_helper
      drm/gma500: Remove struct psb_fbdev
      drm/udl: Unmap buffer object after damage update
      drm/udl: Remove udl implementation of GEM's free_object()
      drm/udl: Store active framebuffer in device structure
      drm/udl: Call udl_handle_damage() with DRM framebuffer
      drm/udl: Replace struct udl_framebuffer with generic implementation
      drm/pci: Only build drm_pci.c if CONFIG_PCI is set
      drm/pci: Hide legacy PCI functions from non-legacy code
      drm/ast: Don't include <drm/drm_pci.h>
      drm/i810: Don't include <drm/drm_pci.h>
      drm/mga: Don't include <drm/drm_pci.h>
      drm/mgag200: Don't include <drm/drm_pci.h>
      drm/r128: Don't include <drm/drm_pci.h>
      drm/radeon: Don't include <drm/drm_pci.h>
      drm/savage: Don't include <drm/drm_pci.h>
      drm/sis: Don't include <drm/drm_pci.h>
      drm/tdfx: Don't include <drm/drm_pci.h>
      drm/via: Don't include <drm/drm_pci.h>
      drm/gma500: Call psb_driver_{load, unload}() before registering devic=
e
      drm/mgag200: Call mgag200_driver_{load, unload}() before
registering device
      drm/mgag200: Debug-print unique revisions id on G200 SE
      drm/udl: Remove unused statistics counters
      drm/udl: Don't track number of identical and sent pixels per line
      drm/udl: Vmap framebuffer after all tests succeeded in damage handlin=
g
      drm/udl: Move clip-rectangle code out of udl_handle_damage()
      drm/udl: Move log-cpp code out of udl_damage_handler()
      drm/udl: Begin/end access to imported buffers in damage-handler
      drm/udl: Remove field lost_pixels from struct udl_device
      drm/ast: Move modesetting code to CRTC's atomic_flush()
      drm/ast: Enable and disable screen in primary-plane functions
      drm/ast: Clean up arguments of register functions
      drm/ast: Add plane atomic_check() functions
      drm/ast: Introduce struct ast_crtc_state
      drm/ast: Store VBIOS mode info in struct ast_crtc_state
      drm/ast: Store primary-plane format in struct ast_crtc_state
      drm/udl: Init connector before encoder and CRTC
      drm/udl: Convert to struct drm_simple_display_pipe
      drm/udl: Switch to atomic suspend/resume helpers
      drm/udl: Inline DPMS code into CRTC enable and disable functions
      drm/udl: Set preferred color depth to 16 bpp
      drm/udl: Convert to drm_atomic_helper_dirtyfb()
      drm/udl: Remove struct udl_device.active_fb_16
      drm/udl: Move udl_handle_damage() into udl_modeset.c
      drm/udl: Remove udl_fb.c
      drm/hisilicon/hibmc: Switch to generic fbdev emulation
      drm/hisilicon/hibmc: Replace struct hibmc_framebuffer with generic co=
de
      drm/vram: Support scanline alignment for dumb buffers
      drm/hisilicon/hibmc: Implement hibmc_dumb_create() with generic helpe=
rs
      drm/hisilicon/hibmc: Export VRAM MM information to debugfs
      drm/vram-helper: Remove interruptible flag from public interface
      drm/vram-helper: Remove BO device from public interface
      drm/vram-helper: Support struct drm_driver.gem_create_object
      drm/mgag200: Add module parameter to pin all buffers at offset 0
      drm/udl: Make udl driver depend on CONFIG_USB
      drm/vmwgfx: Call vmw_driver_{load,unload}() before registering device

Thong Thai (1):
      Revert "drm/amdgpu: enable VCN DPG on Raven and Raven2"

Tianci.Yin (9):
      drm/amdgpu/gfx10: update gfx golden settings
      drm/amdgpu/gfx10: update gfx golden settings for navi14
      drm/amdgpu/gfx10: update gfx golden settings
      drm/amdgpu/gfx10: update gfx golden settings for navi14
      drm/amdgpu: update the method to get fb_loc of memory training(V4)
      drm/amdgpu: remove memory training p2c buffer reservation(V2)
      drm/amdgpu/gfx10: update gfx golden settings
      drm/amdgpu/gfx10: update gfx golden settings for navi14
      drm/amdgpu: fix modprobe failure of the secondary GPU when GDDR6
training enabled(V5)

Tiecheng Zhou (1):
      drm/amdgpu/sriov: workaround on rev_id for Navi12 under sriov

Timothy Pearson (4):
      amdgpu: Enable KFD on POWER systems
      amdgpu: Prepare DCN floating point macros for generic arch support
      amdgpu: Enable initial DCN support on POWER
      amdgpu: Wrap FPU dependent functions in dc20

Tobias Schramm (1):
      drm/panel: Add support for BOE NV140FHM-N49 panel to panel-simple

Tom St Denis (1):
      drm/amd/amdgpu: add missing umc_6_1_2_sh_mask.h header file (v2)

Torsten Duwe (2):
      drm/bridge: Prepare Analogix anx6345 support
      drm/bridge: fix anx6345 compilation for v5.5

Tvrtko Ursulin (9):
      drm/i915/dsb: Remove PIN_MAPPABLE from the DSB object VMA
      drm/i915/query: Align flavour of engine data lookup
      drm/i915/pmu: Report frequency as zero while GPU is sleeping
      drm/i915: Improve execbuf debug
      drm/i915: Fix pid leak with banned clients
      drm/i915/pmu: Ensure monotonic rc6
      drm/i915: Switch context id allocation directly to xarray
      drm/i915: Revert "drm/i915/tgl: Wa_1607138340"
      drm/i915/pmu: Do not use colons or dashes in PMU names

Uma Shankar (1):
      Revert "drm/fbdev: Fallback to non tiled mode if all tiles not presen=
t"

Umesh Nerlige Ramappa (2):
      drm/i915/perf: Allow non-privileged access when OA buffer is not samp=
led
      drm/i915/perf: Configure OAR for specific context

Vandita Kulkarni (4):
      drm/i915/dsi: Define command mode registers
      drm/i915/dsi: Do not read the transcoder register.
      drm/i915/dsi: Fix state mismatch warns for horizontal timings with DS=
C
      drm/i915: Fix WARN_ON condition for cursor plane ddb allocation

Venkata Sandeep Dhanalakota (3):
      drm/i915/perf: Register sysctl path globally
      drm/i915: Introduce new macros for tracing
      drm/i915: Fix typecheck macro in GT_TRACE

Ville Syrj=C3=A4l=C3=A4 (88):
      drm/i915: Expose 10:10:10 XRGB formats on SNB-BDW sprites
      drm/i915: Expose alpha formats on VLV/CHV primary planes
      drm/i915: Add missing 10bpc formats for pipe B sprites on CHV
      drm/i915: Expose C8 on VLV/CHV sprite planes
      drm/i915: Add 10bpc formats with alpha for icl+
      drm/i915: Sort format arrays consistently
      drm/i915: Eliminate redundancy in intel_primary_plane_create()
      drm/i915: Frob the correct crtc state in intel_crtc_disable_noatomic(=
)
      drm/i915: Preload LUTs if the hw isn't currently using them
      drm/i915: Don't oops in dumb_create ioctl if we have no crtcs
      drm/i915: Do not override mode's aspect ratio with the prop value NON=
E
      drm/i915: Drop redundant aspec ratio prop value initialization
      drm/i915: Fix frame start delay programming
      drm/i915: Change intel_encoders_<hook>() calling convention
      drm/i915: Add intel_crtc_vblank_off()
      drm/i915: Move assert_vblank_disabled() into intel_crtc_vblank_on()
      drm/i915: Move crtc_state to tighter scope
      drm/i915: Pass intel_crtc to ironlake_fdi_disable()
      drm/i915: Change watermark hook calling convention
      drm/i915: Pass dev_priv to cpt_verify_modeset()
      drm/i915: s/intel_crtc/crtc/ in .crtc_enable() and .crtc_disable()
      drm/i915: s/pipe_config/new_crtc_state/ in .crtc_enable()
      drm/i915: Change .crtc_enable/disable() calling convention
      drm/rect: Avoid division by zero
      drm/rect: Keep the scaled clip bounded
      drm/rect: Keep the clipped dst rectangle in place
      drm/selftests: Add drm_rect selftests
      drm: Inline drm_color_lut_extract()
      drm/i915: Don't set undefined bits in dirty_pipes
      drm/i915: Use the correct PCH transcoder for LPT/WPT in
intel_sanitize_frame_start_delay()
      drm/i915: Switch intel_crtc_disable_noatomic() to intel_ types
      drm/i915: Use drm_rect to simplify plane {crtc,src}_{x,y,w,h} printin=
g
      drm/i915: Switch to intel_ types in debugfs display_info
      drm/i915: Reorganize plane/fb dump in debugfs
      drm/i915: Refactor debugfs display info code
      drm/i915: Dump the mode for the crtc just the once
      drm/i915: Use drm_modeset_lock_all() in debugfs display info
      drm/i915: Use the canonical [CRTC:%d:%s]/etc. format in i915_display_=
info
      drm/i915: Dump both the uapi and hw states for crtcs and planes
      drm/i915: Stop using connector->encoder and encoder->crtc links
in i915_display_info
      drm/i915: Clean up arguments to nv12/scaler w/a funcs
      drm/i915: Pass dev_priv to ilk_disable_lp_wm()
      drm/i915: s/pipe_config/new_crtc_state/ intel_{pre,post}_plane_update=
()
      drm/i915: Clean up intel_{pre,post}_plane_update()
      drm/i915: Clean up the gen2 "no planes -> underrun" workaround
      drm/i915: Nuke intel_pre_disable_primary_noatomic()
      drm/i915: Make intel_crtc_arm_fifo_underrun() functional on gen2
      drm/i915/fbc: Disable fbc by default on all glk+
      drm/i915/fbc: Nuke bogus single pipe fbc1 restriction
      drm/i915: Relocate intel_crtc_active()
      drm/i915/fbc: Remove the FBC_RT_BASE setup for ILK/SNB
      drm/i915/fbc: Precompute gen9 cfb stride w/a
      drm/i915/fbc: Track plane visibility
      drm/i915/fbc: Store fence_id directly in fbc cache/params
      drm/i915/fbc: Make fence_id optional for i965gm
      drm/i915/fbc: s/gen9 && !glk/gen9_bc || bxt/
      drm/i915/fbc: Nuke fbc.enabled
      drm/i915/fbc: Start using flip nuke
      drm/i915/fbc: Wait for vblank after FBC disable on glk+
      drm/i915/fbc: Enable fbc by default on glk+ once again
      drm/i915/fbc: Reallocate cfb if we need more of it
      drm/i915/hdcp: Nuke intel_hdcp_transcoder_config()
      drm/i915: ELiminate intel_pipe_to_cpu_transcoder() from assert_fdi_tx=
()
      drm/i915: Pass cpu transcoder to assert_pipe()
      drm/i915: Streamline skl_commit_modeset_enables()
      drm/edid: Abstract away cea_edid_modes[]
      drm/edid: Add CTA-861-G modes with VIC >=3D 193
      drm/edid: Throw away the dummy VIC 0 cea mode
      drm/edid: Make sure the CEA mode arrays have the correct amount of mo=
des
      drm: Add __drm_atomic_helper_crtc_state_reset() & co.
      drm/i915: s/intel_crtc/crtc/ in intel_crtc_init()
      drm/i915: Introduce intel_crtc_{alloc,free}()
      drm/i915: Introduce intel_crtc_state_reset()
      drm/i915: Introduce intel_plane_state_reset()
      drm/i915: Call hsw_fdi_link_train() directly()
      drm/i915: Nuke .post_pll_disable() for DDI platforms
      drm/i915: Pass old crtc state to skylake_scaler_disable()
      drm/i915: Pass old crtc state to intel_crtc_vblank_off()
      drm/i915: Move stuff from haswell_crtc_disable() into encoder
.post_disable()
      drm/i915/fbc: Reject PLANE_OFFSET.y%4!=3D0 on icl+ too
      drm/i915/fbc: Remove second redundant intel_fbc_pre_update() call
      drm/i915: Rename pipe update tracepoints
      drm/i915: Introduce intel_crtc_state_alloc()
      drm/i915: Fix MST disable sequence
      drm/i915: Pass cpu_transcoder to assert_pipe_disabled() always
      drm/i915: Pass intel_connector to intel_attached_*()
      drm/i915: Pass intel_encoder to enc_to_*()
      drm/i915: Use the passed in encoder

Vivek Kasireddy (1):
      drm/i915/dsi: Parse the I2C element from the VBT MIPI sequence block =
(v3)

Wambui Karuga (16):
      drm: use DIV_ROUND_UP helper macro for calculations
      drm/rockchip: use DRM_DEV_ERROR for log output
      drm/panel: declare variable as __be16
      drm/msm: use BUG_ON macro for debugging.
      drm/radeon: remove boolean checks in if statements.
      drm/radeon: remove unnecessary braces around conditionals.
      drm/amd: use list_for_each_entry for list iteration.
      drm/omapdrm: use BUG_ON macro for error debugging.
      drm/i915/pch: convert to using the drm_dbg_kms() macro.
      drm/i915/pm: use new struct drm_device logging macros.
      drm/i915/lmem: use new struct drm_device based logging macros.
      drm/i915/sideband: convert to using new struct drm_device logging mac=
ros
      drm/i915/uncore: use new struct drm_device based macros.
      drm/nouveau/fb/gf100-: declare constants as unsigned long long.
      drm/nouveau/kms/nv04: remove set but unused variable.
      drm/nouveau: use NULL for pointer assignment.

Wayne Lin (3):
      drm/edid: Add aspect ratios to HDMI 4K modes
      drm/edid: Add alternate clock for SMPTE 4K
      drm/dp_mst: Remove VCPI while disabling topology mgr

Wenjing Liu (7):
      drm/amd/display: add color space option when sending link test patter=
n
      drm/amd/display: add dc dsc functions to return bpp range for
pixel encoding
      drm/amd/display: remove spam DSC log
      drm/amd/display: add dsc policy getter
      drm/amd/display: wait for update when setting dpg test pattern
      drm/amd/display: wait for test pattern after when all pipes are progr=
ammed
      drm/amd/display: skip opp blank or unblank if test pattern enabled

Wyatt Wood (3):
      drm/amd/display: Driverside changes to support PSR in DMCUB
      drm/amd/display: DMCUB FW Changes to support PSR
      drm/amd/display: Fix DMUB PSR command IDs

Xiaodong Yan (1):
      drm/amd/display: add event type check before restart the authenticati=
on

Xiaojie Yuan (7):
      drm/amdgpu/gfx10: fix mqd backup/restore for gfx rings (v2)
      drm/amdgpu/gfx10: explicitly wait for cp idle after halt/unhalt
      drm/amdgpu/gfx10: fix out-of-bound mqd_backup array access
      drm/amdgpu/gfx10: re-init clear state buffer after gpu reset
      drm/amdgpu/gfx10: unlock srbm_mutex after queue programming finish
      drm/amdgpu/gfx10: remove outdated comments
      drm/amd/display: fix kernel_fpu_begin/_end() warnings

Xiaomeng Hou (4):
      drm/amd/powerplay: implement interface to retrieve gpu
temperature for renoir
      drm/amd/powerplay: implement interface to retrieve clock freq for ren=
oir
      drm/amd/powerplay: implement the get_enabled_mask callback for smu12
      drm/amd/powerplay: correct the value retrieved through GPU_LOAD
sensor interface

Yannick Fertr=C3=A9 (1):
      drm/stm: ltdc: move pinctrl to encoder mode set

Yintian Tao (5):
      drm/amdgpu: put flush_delayed_work at first
      drm/amdgpu: not remove sysfs if not create sysfs
      drm/amd/powerplay: enable pp one vf mode for vega10
      drm/amd/powerplay: skip soc clk setting under pp one vf
      drm/amd/powerplay: skip disable dynamic state management

Yong Zhao (24):
      drm/amdkfd: Adjust function sequences to avoid unnecessary declaratio=
ns
      drm/amdkfd: Only keep release_mem function for Hawaii
      drm/amdkfd: Use kernel queue v9 functions for v10
      drm/amdkfd: Simplify the mmap offset related bit operations
      drm/amdkfd: Use better name to indicate the offset is in dwords
      drm/amdkfd: Avoid using doorbell_off as offset in process doorbell pa=
ges
      drm/amdkfd: Rename create_cp_queue() to init_user_queue()
      drm/amdkfd: Implement queue priority controls for gfx10
      drm/amdkfd: Update get_wave_state() for GFX10
      drm/amdkfd: Fix a bug when calculating save_area_used_size
      drm/amdkfd: Use QUEUE_IS_ACTIVE macro in mqd v10
      drm/amdkfd: Stop using GFP_NOIO explicitly for two places
      drm/amdkfd: Merge CIK kernel queue functions into VI
      drm/amdkfd: Eliminate ops_asic_specific in kernel queue
      drm/amdkfd: Rename kfd_kernel_queue_*.c to kfd_packet_manager_*.c
      drm/amdkfd: Delete KFD_MQD_TYPE_COMPUTE
      drm/amdkfd: DIQ should not use HIQ way to allocate memory
      drm/amdkfd: Remove duplicate functions update_mqd_hiq()
      drm/amdkfd: Contain MMHUB number in mmhub_v9_4_setup_vm_pt_regs()
      drm/amdkfd: Eliminate unnecessary kernel queue function pointers
      drm/amdkfd: Use Arcturus specific set_vm_context_page_table_base()
      drm/amdgpu: Add CU info print log
      drm/amdkfd: Improve function get_sdma_rlc_reg_offset() (v2)
      drm/amdkfd: Add a message when SW scheduler is used

Yongqiang Niu (3):
      drm/mediatek: Fix can't get component for external display plane.
      drm/mediatek: Add gamma property according to hardware capability
      drm/mediatek: Add ctm property support

Yongqiang Sun (9):
      drm/amd/display: Change dmcu init sequence for dmcub loading dmcu FW.
      drm/amd/display: Add PSP FW version mask.
      drm/amd/display: optimize bandwidth after commit streams.
      drm/amd/display: Add debug trace for dmcub FW autoload.
      drm/amd/display: Add DMCUB__PG_DONE trace code enum
      drm/amd/display: Compare clock state member to determine optimization=
.
      drm/amd/display: programing surface flip by dmcub.
      drm/amd/display: Refactor surface flip programming
      drm/amd/display: Only program surface flip for video plane via dmcub

YueHaibing (14):
      drm/amd/display: remove set but not used variable 'ds_port'
      drm/amd/display: remove set but not used variable 'bpc'
      drm/amd/display: remove set but not used variable 'msg_out'
      drm/amd/powerplay: remove set but not used variable 'stretch_amount2'
      fbdev: omapfb: use devm_platform_ioremap_resource() to simplify code
      fbdev: s3c-fb: use devm_platform_ioremap_resource() to simplify code
      fbdev/sa1100fb: use devm_platform_ioremap_resource() to simplify code
      drm/i915: Add missing include file <linux/math64.h>
      gpu: host1x: Remove dev_err() on platform_get_irq() failure
      drm/nouveau/kms/nv04-nv4x: Use match_string() helper to simplify the =
code
      drm/nouveau: Fix copy-paste error in nouveau_fence_wait_uevent_handle=
r
      drm/nouveau/drm/ttm: Remove set but not used variable 'mem'
      drm/nouveau/kms/nv50: remove set but not unused variable 'nv_connecto=
r'
      drm/nouveau/kms/nv04: remove set but not used variable 'width'

Zhan Liu (4):
      drm/amd/display: Include num_vmid and num_dsc within NV14's resource =
caps
      drm/amd/display: Loading NV10/14 Bounding Box Data Directly From Code
      drm/amd/powerplay: Add SMU WMTABLE Validity Check for Renoir
      drm/amd/display: Don't disable DP PHY when link loss happens

Zhan liu (3):
      drm/amd/display: Modify comments to match the code
      drm/amd/display: Adding NV14 IP Parameters
      drm/amd/display: Get NV14 specific ip params as needed

Zhang Xiaoxu (2):
      drm/i915: Fix multiple definition of 'i915_vma_capture_finish'
      drm/i915: Fix too few arguments to function i915_capture_error_state

Zhigang Luo (4):
      drm/amd/amdgpu: L1 Policy(1/5) - removed VM settings for mmhub
and gfxhub from VF
      drm/amd/amdgpu: L1 Policy(2/5) - removed GC GRBM violations from gfxh=
ub
      drm/amd/amdgpu: L1 Policy(3/5) - removed ECC interrupt from VF
      drm/amd/amdgpu: L1 Policy(5/5) - removed IH_CHICKEN from VF

abdoulaye berthe (13):
      drm/amd/display: initialize lttpr
      drm/amd/display: check for dp rev before reading lttpr regs
      drm/amd/display: configure lttpr mode
      drm/amd/display: implement lttpr logic
      drm/amd/display: use previous aux timeout val if no repeater.
      drm/amd/display: disable lttpr for invalid lttpr caps.
      drm/amd/display: add automated audio test support
      drm/amd/display: add log for lttpr
      drm/amd/display: check for repeater when setting aux_rd_interval.
      drm/amd/display: correct log message for lttpr
      drm/amd/display: disable lttpr for RN
      drm/amd/display: Update extended timeout support for DCN20 and DCN21
      drm/amd/display: store lttpr mode with dpcd

changzhu (5):
      drm/amd/powerplay: enable gpu_busy_percent sys interface for renoir (=
v2)
      drm/amdgpu: initialize vm_inv_eng0_sem for gfxhub and mmhub
      drm/amdgpu: invalidate mmhub semaphore workaround in gmc9/gmc10
      drm/amdgpu: avoid using invalidate semaphore for picasso
      drm/amdgpu: enable gfxoff for raven1 refresh

james qian wang (Arm Technology China) (10):
      drm/komeda: Fix komeda driver build error
      drm: Add a new helper drm_color_ctm_s31_32_to_qm_n()
      drm/komeda: Add drm_lut_to_fgamma_coeffs()
      drm/komeda: Add drm_ctm_to_coeffs()
      drm/komeda: Clean warnings: candidate for 'gnu_printf=E2=80=99 format=
 attribute
      drm/komeda: Correct d71 register block counting
      drm/komeda: Update the chip identify
      drm/komeda: Enable new product D32 support
      drm/komeda: Add event handling for EMPTY/FULL
      drm/komeda: Add runtime_pm support

kbuild test robot (1):
      video: fbdev: mmp: fix platform_get_irq.cocci warnings

shaoyunl (1):
      drm/amdgpu: check rlc_g firmware pointer is valid before using it

yu kuai (15):
      drm/amdgpu: remove 4 set but not used variable in
amdgpu_atombios_get_connector_info_from_object_table
      drm/amdgpu: add function parameter description in
'amdgpu_device_set_cg_state'
      drm/amdgpu: add function parameter description in 'amdgpu_gart_bind'
      drm/amdgpu: remove set but not used variable 'dig_connector'
      drm/amdgpu: remove set but not used variable 'dig'
      drm/amdgpu: remove always false comparison in
'amdgpu_atombios_i2c_process_i2c_ch'
      drm/amdgpu: remove set but not used variable 'mc_shared_chmap'
      drm/amdgpu: remove set but not used variable 'mc_shared_chmap'
from 'gfx_v6_0.c' and 'gfx_v7_0.c'
      drm/amdgpu: remove set but not used variable 'amdgpu_connector'
      drm/amdgpu: remove set but not used variable 'count'
      drm/amdgpu: remove set but not used variable 'invalid'
      drm/amd/powerplay: remove set but not used variable 'us_mvdd'
      drm/bridge: cdns: remove set but not used variable 'bpp'
      drm/bridge: cdns: remove set but not used variable 'nlanes'
      drm/radeon: remove three set but not used variable

zhengbin (65):
      drm/amd/powerplay: remove set but not used variable
'vbios_version', 'data'
      drm/amd/powerplay: remove set but not used variable 'data'
      drm/amd/display: Use static const, not const static
      drm/amd/powerplay: remove set but not used variable 'threshold', 'sta=
te'
      drm/gma500: remove set but not used variable 'htotal'
      drm/gma500: remove set but not used variable 'error'
      drm/gma500: remove set but not used variable 'is_hdmi','is_crt'
      drm/gma500: remove set but not used variable 'channel_eq'
      drm/amdkfd: remove set but not used variable 'top_dev'
      drm/amd/display: remove set but not used variable 'old_plane_crtc'
      drm/amd/display: remove set but not used variable 'bp' in bios_parser=
2.c
      drm/amd/display: remove set but not used variable 'bp' in bios_parser=
.c
      drm/amd/display: remove set but not used variable 'min_content'
      drm/radeon: remove set but not used variable 'size', 'relocs_chunk'
      drm/radeon: remove set but not used variable 'backbias_response_time'
      drm/radeon: remove set but not used variable 'dig_connector'
      drm/radeon: remove set but not used variable 'radeon_connector'
      drm/radeon: remove set but not used variable 'blocks'
      drm/radeon: remove set but not used variable 'tv_pll_cntl1'
      drm/amdgpu: remove not needed memset
      drm/amd/powerplay: Use ARRAY_SIZE for smu7_profiling
      drm/amdgpu: Use ARRAY_SIZE for sos_old_versions
      drm/amd/powerplay: Remove unneeded variable 'result' in smu10_hwmgr.c
      drm/amd/powerplay: Remove unneeded variable 'result' in vega10_hwmgr.=
c
      drm/amd/powerplay: Remove unneeded variable 'ret' in smu7_hwmgr.c
      drm/amd/powerplay: Remove unneeded variable 'result' in vega12_hwmgr.=
c
      drm/amd/powerplay: Remove unneeded variable 'ret' in amdgpu_smu.c
      drm/amd/display: Remove unneeded semicolon in bios_parser.c
      drm/amd/display: Remove unneeded semicolon in bios_parser2.c
      drm/amd/display: Remove unneeded semicolon in hdcp.c
      drm/amd/display: Remove unneeded semicolon in display_rq_dlg_calc_21.=
c
      drm/sun4i: Remove unneeded semicolon in sun8i_mixer.c
      drm/sun4i: Remove unneeded semicolon in sun4i_layer.c
      drm/bochs: Remove unneeded semicolon
      drm/i915: Remove unneeded semicolon
      drm/amd/display: Remove unneeded semicolon
      drm/amdgpu: Remove unneeded semicolon in amdgpu_pmu.c
      drm/amdgpu: Remove unneeded semicolon in gfx_v10_0.c
      drm/amdgpu: Remove unneeded semicolon in amdgpu_ras.c
      drm/radeon: use true,false for bool variable in r100.c
      drm/radeon: use true,false for bool variable in si.c
      drm/radeon: use true,false for bool variable in r600.c
      drm/radeon: use true, false for bool variable in evergreen.c
      drm/radeon: use true,false for bool variable in rv770.c
      drm/radeon: use true,false for bool variable in cik.c
      drm/radeon: use true,false for bool variable in ni.c
      drm/amdgpu: use true, false for bool variable in mxgpu_ai.c
      drm/amdgpu: use true, false for bool variable in mxgpu_nv.c
      drm/amdgpu: use true, false for bool variable in amdgpu_device.c
      drm/amdgpu: use true, false for bool variable in amdgpu_debugfs.c
      drm/amdgpu: use true, false for bool variable in amdgpu_psp.c
      drm/msm/hdmi: Remove unneeded semicolon
      drm/msm/mdp5: Remove unneeded semicolon
      drm/msm/dpu: Remove unneeded semicolon in dpu_plane.c
      drm/msm/dpu: Remove unneeded semicolon in dpu_encoder.c
      drm: meson: Remove unneeded semicolon
      drm/amd/powerplay: use true, false for bool variable in vega20_hwmgr.=
c
      drm/amd/display: use true, false for bool variable in dc_link_ddc.c
      drm/amd/display: use true, false for bool variable in dcn10_hw_sequen=
cer.c
      drm/amd/display: use true, false for bool variable in dcn20_hwseq.c
      drm/amd/display: use true, false for bool variable in
display_mode_vba_21.c
      drm/amd/display: use true, false for bool variable in dce_calcs.c
      drm/amd/display: use true, false for bool variable in
display_rq_dlg_calc_20.c
      drm/amd/display: use true, false for bool variable in
display_rq_dlg_calc_20v2.c
      drm/amd/display: use true, false for bool variable in
display_rq_dlg_calc_21.c

zhong jiang (1):
      dma-heap: Make the symbol 'dma_heap_ioctl_cmds' static

 .../allwinner,sun4i-a10-display-backend.yaml       |  291 ++
 .../allwinner,sun4i-a10-display-engine.yaml        |  114 +
 .../allwinner,sun4i-a10-display-frontend.yaml      |  138 +
 .../bindings/display/allwinner,sun4i-a10-hdmi.yaml |  183 +
 .../bindings/display/allwinner,sun4i-a10-tcon.yaml |  676 ++++
 .../display/allwinner,sun4i-a10-tv-encoder.yaml    |   62 +
 .../bindings/display/allwinner,sun6i-a31-drc.yaml  |  138 +
 .../display/allwinner,sun6i-a31-mipi-dsi.yaml      |   33 +-
 .../display/allwinner,sun8i-a83t-de2-mixer.yaml    |  118 +
 .../display/allwinner,sun8i-a83t-dw-hdmi.yaml      |  273 ++
 .../display/allwinner,sun8i-a83t-hdmi-phy.yaml     |  117 +
 .../display/allwinner,sun8i-r40-tcon-top.yaml      |  382 ++
 .../bindings/display/allwinner,sun9i-a80-deu.yaml  |  133 +
 .../bindings/display/bridge/lvds-codec.yaml        |  131 +
 .../bindings/display/bridge/lvds-transmitter.txt   |   66 -
 .../bindings/display/bridge/thine,thc63lvdm83d.txt |   50 -
 .../bindings/display/bridge/ti,ds90c185.txt        |   55 -
 .../bindings/display/dsi-controller.yaml           |   91 +
 .../devicetree/bindings/display/ingenic,lcd.txt    |    1 +
 .../devicetree/bindings/display/msm/dpu.txt        |    4 +-
 .../devicetree/bindings/display/msm/gpu.txt        |    9 +-
 .../display/panel/ampire,am-480272h3tmqw-t01h.yaml |   42 -
 .../display/panel/ampire,am800480r3tmqwa1h.txt     |    7 -
 .../bindings/display/panel/giantplus,gpm940b0.txt  |   12 -
 .../display/panel/leadtek,ltk500hd1829.yaml        |   49 +
 .../bindings/display/panel/logicpd,type28.yaml     |   42 +
 .../bindings/display/panel/panel-simple.yaml       |   69 +
 .../bindings/display/panel/sharp,ls020b1dd01d.txt  |   12 -
 .../bindings/display/panel/sony,acx424akp.yaml     |   49 +
 .../bindings/display/panel/xinpeng,xpp055c272.yaml |   49 +
 .../devicetree/bindings/display/renesas,cmm.yaml   |   67 +
 .../devicetree/bindings/display/renesas,du.txt     |   15 +-
 .../display/rockchip/dw_mipi_dsi_rockchip.txt      |   13 +-
 .../bindings/display/rockchip/rockchip-lvds.txt    |    4 +
 .../bindings/display/sunxi/sun4i-drm.txt           |  637 ----
 .../devicetree/bindings/display/tilcdc/tfp410.txt  |   21 -
 .../phy/allwinner,sun6i-a31-mipi-dphy.yaml         |    6 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |    6 +
 Documentation/fb/fbcon.rst                         |   13 +-
 Documentation/fb/modedb.rst                        |    3 +
 Documentation/gpu/drm-internals.rst                |    4 +-
 Documentation/gpu/drm-kms.rst                      |   19 +-
 Documentation/gpu/drm-mm.rst                       |   68 +-
 Documentation/gpu/drm-uapi.rst                     |   49 +-
 Documentation/gpu/i915.rst                         |    3 -
 Documentation/gpu/todo.rst                         |   68 +-
 MAINTAINERS                                        |   31 +-
 arch/arm/mach-u300/core.c                          |    2 +-
 .../intel-mid/device_libs/platform_tc35876x.c      |   26 +-
 drivers/acpi/acpi_lpss.c                           |   11 +-
 drivers/auxdisplay/cfag12864bfb.c                  |    2 +-
 drivers/auxdisplay/ht16k33.c                       |    2 +-
 drivers/dma-buf/Kconfig                            |   11 +
 drivers/dma-buf/Makefile                           |    2 +
 drivers/dma-buf/dma-buf.c                          |   63 +-
 drivers/dma-buf/dma-heap.c                         |  298 ++
 drivers/dma-buf/dma-resv.c                         |   32 +
 drivers/dma-buf/heaps/Kconfig                      |   14 +
 drivers/dma-buf/heaps/Makefile                     |    4 +
 drivers/dma-buf/heaps/cma_heap.c                   |  177 +
 drivers/dma-buf/heaps/heap-helpers.c               |  271 ++
 drivers/dma-buf/heaps/heap-helpers.h               |   53 +
 drivers/dma-buf/heaps/system_heap.c                |  123 +
 drivers/dma-buf/udmabuf.c                          |   84 +-
 drivers/gpu/drm/Kconfig                            |    9 +-
 drivers/gpu/drm/Makefile                           |    4 +-
 drivers/gpu/drm/amd/acp/Kconfig                    |   10 +-
 drivers/gpu/drm/amd/amdgpu/Makefile                |    8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   55 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |   44 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |    2 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c    |   91 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c |  149 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c  |   41 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c  |   41 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  |  191 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h  |    7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |   16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c       |   22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   |   38 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h   |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   25 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            |  113 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h            |    3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |  139 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  258 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_df.h             |   62 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |   24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c        |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c            |  211 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h            |   24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  100 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c             |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |   14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c           |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |    8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |    8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |   42 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |   12 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c            |   13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c             |    1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |   17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c            |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h            |    1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c           |  211 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h           |   64 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |   47 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             | 1060 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h             |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c            |   20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  554 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |   27 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |   26 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h            |   11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c           |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h           |   11 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c           |   48 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h           |    8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   45 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c          |   11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h          |    9 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c            |   10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h            |   35 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |   18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |    7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |  188 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h            |   70 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |   51 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h           |   14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  140 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |   19 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c        |   13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c           |   18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h           |    2 +
 drivers/gpu/drm/amd/amdgpu/atombios_dp.c           |    5 -
 drivers/gpu/drm/amd/amdgpu/atombios_i2c.c          |    5 -
 drivers/gpu/drm/amd/amdgpu/cik.c                   |   14 +-
 drivers/gpu/drm/amd/amdgpu/cik.h                   |    2 -
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c              |   12 +-
 drivers/gpu/drm/amd/amdgpu/df_v1_7.c               |    9 +-
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c               |  185 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |  102 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c              |    3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              |    3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |   10 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  413 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c           |   81 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |  131 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |   33 +
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |   34 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |  164 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h              |   18 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c             |  586 +++
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h             |   32 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c             |  827 ++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h             |   42 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c             |  641 ++++
 .../nvdec/gp102.c =3D> amd/amdgpu/jpeg_v2_5.h}       |   23 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c            |  232 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c            |  360 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h            |    4 +
 drivers/gpu/drm/amd/amdgpu/mmsch_v1_0.h            |   12 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c              |   82 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h              |    4 -
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c              |   10 +-
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c             |    3 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c             |   35 +-
 drivers/gpu/drm/amd/amdgpu/nv.c                    |   43 +-
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h            |    1 +
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c             |   65 +-
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c             |  154 +-
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c             |   84 +-
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c              |   89 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c             |   12 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c             |   12 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |  189 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c             |   45 +-
 drivers/gpu/drm/amd/amdgpu/si.c                    |    6 +
 drivers/gpu/drm/amd/amdgpu/si_dma.c                |    8 +-
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c         |    4 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |  153 +-
 drivers/gpu/drm/amd/amdgpu/soc15.h                 |   12 +
 drivers/gpu/drm/amd/amdgpu/soc15_common.h          |    1 +
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.c              |  244 +-
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.h              |    3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |  589 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.h              |    2 +
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c              |  601 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.h              |   13 -
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c              |  883 +++--
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c             |   22 +-
 drivers/gpu/drm/amd/amdgpu/vi.c                    |   54 +-
 drivers/gpu/drm/amd/amdgpu/vi.h                    |    2 -
 drivers/gpu/drm/amd/amdkfd/Makefile                |    6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |   59 +-
 drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c            |   10 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c           |    2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |   24 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   45 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |    3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c          |   14 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c            |    1 -
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c             |    3 -
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c      |  100 +-
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h      |   40 +-
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c  |  348 --
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c   |    5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   |   66 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |   34 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c    |    9 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c    |   36 +-
 ...d_kernel_queue_v9.c =3D> kfd_packet_manager_v9.c} |   90 +-
 ...d_kernel_queue_vi.c =3D> kfd_packet_manager_vi.c} |   41 -
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   32 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   13 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |   18 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |    7 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h          |    2 +
 drivers/gpu/drm/amd/display/Kconfig                |   33 +-
 drivers/gpu/drm/amd/display/Makefile               |    4 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  738 +++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   58 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |    1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |   67 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h |    9 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |   72 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  |   19 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  452 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.h    |    7 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   |    6 -
 drivers/gpu/drm/amd/display/dc/Makefile            |   18 +-
 drivers/gpu/drm/amd/display/dc/basics/Makefile     |    2 +-
 drivers/gpu/drm/amd/display/dc/basics/dc_common.c  |  101 +
 .../display/dc/basics/dc_common.h}                 |   36 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c  |    8 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |   78 +-
 .../gpu/drm/amd/display/dc/bios/command_table2.c   |   85 +
 .../amd/display/dc/bios/command_table_helper2.c    |    6 +-
 drivers/gpu/drm/amd/display/dc/calcs/Makefile      |   11 +-
 drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c   |   24 +-
 drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c   |   33 +-
 drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile    |    6 +-
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c   |   17 +-
 .../amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c |   12 +-
 .../dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c       |    6 +-
 .../amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c   |   46 +-
 .../amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.h   |    6 +-
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  |   60 +-
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c        |    6 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  354 +-
 drivers/gpu/drm/amd/display/dc/core/dc_debug.c     |   10 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |  302 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c  |   28 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |  840 +++-
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c |  101 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  193 +-
 drivers/gpu/drm/amd/display/dc/core/dc_sink.c      |    8 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |  125 +-
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c   |   34 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |   93 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       |  134 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h       |   60 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h       |   62 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h            |   25 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c         |  297 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |   28 -
 drivers/gpu/drm/amd/display/dc/dc_link.h           |   17 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |   29 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h          |   54 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.h       |    4 -
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c       |   46 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.h       |    4 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |    6 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.h  |   10 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c      |   90 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h      |   13 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.c     |    2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h     |   17 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c.c       |   19 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c    |    6 -
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.h    |    8 -
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c    |   43 -
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.h    |    6 +-
 .../drm/amd/display/dc/dce/dce_stream_encoder.c    |   21 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c      |  220 ++
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h      |   47 +
 .../amd/display/dc/dce100/dce100_hw_sequencer.c    |    3 +-
 .../amd/display/dc/dce100/dce100_hw_sequencer.h    |    1 +
 .../drm/amd/display/dc/dce100/dce100_resource.c    |   10 +-
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |  135 +-
 .../amd/display/dc/dce110/dce110_hw_sequencer.h    |    2 +-
 .../drm/amd/display/dc/dce110/dce110_resource.c    |   13 +-
 .../display/dc/dce110/dce110_timing_generator.c    |   11 +-
 .../display/dc/dce110/dce110_timing_generator.h    |    3 +-
 .../amd/display/dc/dce112/dce112_hw_sequencer.c    |    2 +-
 .../amd/display/dc/dce112/dce112_hw_sequencer.h    |    1 +
 .../drm/amd/display/dc/dce112/dce112_resource.c    |   10 +-
 .../amd/display/dc/dce120/dce120_hw_sequencer.c    |    2 +-
 .../amd/display/dc/dce120/dce120_hw_sequencer.h    |    1 +
 .../drm/amd/display/dc/dce120/dce120_resource.c    |   14 +-
 .../display/dc/dce120/dce120_timing_generator.c    |   11 +-
 .../drm/amd/display/dc/dce80/dce80_hw_sequencer.c  |    2 +-
 .../drm/amd/display/dc/dce80/dce80_hw_sequencer.h  |    1 +
 .../gpu/drm/amd/display/dc/dce80/dce80_resource.c  |   10 +-
 drivers/gpu/drm/amd/display/dc/dcn10/Makefile      |    3 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c   |    6 -
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h   |    4 -
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c    |   30 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c  |    2 -
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dwb.c   |    4 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dwb.h   |    2 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c    |    3 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h    |    8 -
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c  |    7 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h  |    3 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |  731 ++--
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h  |  182 +-
 .../display/dc/dcn10/dcn10_hw_sequencer_debug.h    |   43 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c  |  111 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.h  |   33 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_ipp.c   |    4 -
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_ipp.h   |    6 -
 .../drm/amd/display/dc/dcn10/dcn10_link_encoder.h  |   30 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c   |   21 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c   |    5 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c  |   24 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h  |   13 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |   12 +-
 .../amd/display/dc/dcn10/dcn10_stream_encoder.c    |    6 +-
 .../amd/display/dc/dcn10/dcn10_stream_encoder.h    |    9 +-
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile      |   12 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c  |   20 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c   |   26 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.h   |   64 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dpp_cm.c    |  158 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c   |   30 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h   |    2 -
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c    |    6 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c  |  316 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h  |   16 -
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |  579 ++-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h |  148 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c  |  133 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.h  |   33 +
 .../drm/amd/display/dc/dcn20/dcn20_link_encoder.c  |    7 +-
 .../drm/amd/display/dc/dcn20/dcn20_link_encoder.h  |  182 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c   |   55 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.h   |   22 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.c   |   16 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.h   |    1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c  |   45 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.h  |    5 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |  202 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.h  |    5 +-
 .../amd/display/dc/dcn20/dcn20_stream_encoder.c    |   15 +-
 .../amd/display/dc/dcn20/dcn20_stream_encoder.h    |    1 +
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile      |   11 +-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c  |  718 +++-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.h  |    1 +
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c |   14 +-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.h |   16 +-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c  |  142 +
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.h  |   33 +
 .../drm/amd/display/dc/dcn21/dcn21_link_encoder.c  |    2 -
 .../drm/amd/display/dc/dcn21/dcn21_link_encoder.h  |   39 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c  |  152 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h        |    2 -
 drivers/gpu/drm/amd/display/dc/dm_pp_smu.h         |   10 -
 drivers/gpu/drm/amd/display/dc/dm_services.h       |   10 +
 drivers/gpu/drm/amd/display/dc/dm_services_types.h |    3 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile        |   17 +-
 .../amd/display/dc/dml/dcn20/display_mode_vba_20.c |  172 +-
 .../display/dc/dml/dcn20/display_mode_vba_20v2.c   |  177 +-
 .../display/dc/dml/dcn20/display_rq_dlg_calc_20.c  |   27 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c        |   24 +-
 .../amd/display/dc/dml/dcn21/display_mode_vba_21.c |  169 +-
 .../display/dc/dml/dcn21/display_rq_dlg_calc_21.c  |   30 +-
 .../drm/amd/display/dc/dml/display_mode_enums.h    |   20 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_lib.c  |   12 -
 .../gpu/drm/amd/display/dc/dml/display_mode_lib.h  |    8 -
 .../drm/amd/display/dc/dml/display_mode_structs.h  |   14 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.c  |   32 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.h  |  132 +-
 .../gpu/drm/amd/display/dc/dml/dml_common_defs.c   |    2 +-
 .../gpu/drm/amd/display/dc/dml/dml_inline_defs.h   |    2 +-
 drivers/gpu/drm/amd/display/dc/dsc/Makefile        |    8 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c        |  132 +-
 drivers/gpu/drm/amd/display/dc/dsc/dscc_types.h    |    2 -
 drivers/gpu/drm/amd/display/dc/dsc/qp_tables.h     |    2 -
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c       |    2 -
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h       |    2 -
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c   |    2 -
 drivers/gpu/drm/amd/display/dc/gpio/Makefile       |    9 +-
 .../amd/display/dc/gpio/dcn20/hw_factory_dcn20.c   |   14 +-
 .../amd/display/dc/gpio/dcn20/hw_factory_dcn20.h   |    2 -
 .../amd/display/dc/gpio/dcn20/hw_translate_dcn20.c |    2 -
 .../amd/display/dc/gpio/dcn20/hw_translate_dcn20.h |    2 -
 .../amd/display/dc/gpio/dcn21/hw_factory_dcn21.c   |    2 -
 .../amd/display/dc/gpio/dcn21/hw_factory_dcn21.h   |    2 -
 .../amd/display/dc/gpio/dcn21/hw_translate_dcn21.c |    2 -
 .../amd/display/dc/gpio/dcn21/hw_translate_dcn21.h |    2 -
 drivers/gpu/drm/amd/display/dc/gpio/ddc_regs.h     |   12 -
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c       |   16 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c   |   12 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_generic.c   |   23 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c       |   32 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c |   12 +-
 drivers/gpu/drm/amd/display/dc/inc/core_status.h   |    2 -
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |   37 +-
 drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h   |    2 +-
 drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h    |   13 +-
 .../amd/display/dc/{calcs =3D> inc}/dcn_calc_math.h  |    0
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h    |    7 +-
 .../drm/amd/display/dc/inc/hw/clk_mgr_internal.h   |   12 -
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h   |    4 -
 drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h       |    2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h        |   32 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h        |    2 -
 drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h        |   15 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h       |   34 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h  |   17 +-
 .../gpu/drm/amd/display/dc/inc/hw/link_encoder.h   |    9 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h  |    2 -
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h        |   10 -
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h        |    5 +-
 .../gpu/drm/amd/display/dc/inc/hw/stream_encoder.h |   11 +-
 .../drm/amd/display/dc/inc/hw/timing_generator.h   |   11 +-
 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h  |  370 +-
 .../drm/amd/display/dc/inc/hw_sequencer_private.h  |  156 +
 drivers/gpu/drm/amd/display/dc/inc/link_hwss.h     |    6 +-
 drivers/gpu/drm/amd/display/dc/inc/reg_helper.h    |   32 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h      |    6 +-
 drivers/gpu/drm/amd/display/dc/irq/Makefile        |    6 +-
 .../amd/display/dc/irq/dce110/irq_service_dce110.c |    8 +-
 .../amd/display/dc/irq/dce120/irq_service_dce120.c |    4 +-
 .../amd/display/dc/irq/dce80/irq_service_dce80.c   |    4 +-
 .../amd/display/dc/irq/dcn10/irq_service_dcn10.c   |    4 +-
 .../amd/display/dc/irq/dcn20/irq_service_dcn20.c   |    4 +-
 .../amd/display/dc/irq/dcn21/irq_service_dcn21.c   |    4 +-
 drivers/gpu/drm/amd/display/dc/irq/irq_service.c   |    2 +-
 drivers/gpu/drm/amd/display/dc/os_types.h          |   35 +-
 .../display/dc/virtual/virtual_stream_encoder.c    |    9 +-
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |  289 ++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h    |   48 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd_vbios.h  |   41 +
 .../gpu/drm/amd/display/dmub/inc/dmub_fw_meta.h    |   63 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_rb.h     |  154 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h    |  506 +++
 .../drm/amd/display/dmub/inc/dmub_trace_buffer.h   |   69 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_types.h  |   64 +
 drivers/gpu/drm/amd/display/dmub/src/Makefile      |   27 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c  |  202 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h  |  182 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c  |   64 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h  |   41 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_reg.c    |  109 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_reg.h    |  124 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    |  505 +++
 drivers/gpu/drm/amd/display/include/dal_asic_id.h  |   32 +-
 drivers/gpu/drm/amd/display/include/dal_types.h    |    4 -
 .../amd/display/include/grph_object_ctrl_defs.h    |    3 +-
 .../drm/amd/display/include/link_service_types.h   |    7 +
 drivers/gpu/drm/amd/display/include/logger_types.h |    6 -
 .../drm/amd/display/modules/color/color_gamma.c    |   47 +-
 .../drm/amd/display/modules/freesync/freesync.c    |   37 +-
 drivers/gpu/drm/amd/display/modules/hdcp/Makefile  |    3 +-
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c    |  103 +-
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h    |  197 +-
 .../drm/amd/display/modules/hdcp/hdcp1_execution.c |   40 +-
 .../amd/display/modules/hdcp/hdcp1_transition.c    |   20 +-
 .../drm/amd/display/modules/hdcp/hdcp2_execution.c |  886 +++++
 .../amd/display/modules/hdcp/hdcp2_transition.c    |  679 ++++
 .../gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c    |  326 ++
 .../gpu/drm/amd/display/modules/hdcp/hdcp_log.c    |  118 +
 .../gpu/drm/amd/display/modules/hdcp/hdcp_log.h    |   98 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp_psp.c    |  510 ++-
 .../gpu/drm/amd/display/modules/hdcp/hdcp_psp.h    |  194 +
 .../gpu/drm/amd/display/modules/inc/mod_freesync.h |    1 +
 drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h |   15 +-
 .../drm/amd/display/modules/inc/mod_info_packet.h  |    4 +-
 .../gpu/drm/amd/display/modules/inc/mod_shared.h   |    2 -
 .../amd/display/modules/info_packet/info_packet.c  |   46 +-
 .../drm/amd/display/modules/power/power_helpers.c  |    7 +-
 drivers/gpu/drm/amd/include/amd_shared.h           |    5 +-
 .../amd/include/asic_reg/dcn/dcn_2_0_0_offset.h    |    4 +
 .../amd/include/asic_reg/dcn/dcn_2_0_0_sh_mask.h   |    9 +-
 .../amd/include/asic_reg/dcn/dcn_2_1_0_offset.h    |    5 +-
 .../amd/include/asic_reg/dcn/dcn_2_1_0_sh_mask.h   |    8 +
 .../drm/amd/include/asic_reg/df/df_3_6_offset.h    |   19 +
 .../drm/amd/include/asic_reg/df/df_3_6_sh_mask.h   |    8 +
 .../amd/include/asic_reg/dpcs/dpcs_2_0_0_offset.h  |  647 ++++
 .../amd/include/asic_reg/dpcs/dpcs_2_0_0_sh_mask.h | 3912 ++++++++++++++++=
+++
 .../asic_reg/{dcn =3D> dpcs}/dpcs_2_1_0_offset.h     |    0
 .../asic_reg/{dcn =3D> dpcs}/dpcs_2_1_0_sh_mask.h    |    0
 .../drm/amd/include/asic_reg/gc/gc_9_0_offset.h    |    8 +
 .../drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h   |    6 +
 .../amd/include/asic_reg/mmhub/mmhub_1_0_offset.h  |   16 +
 .../amd/include/asic_reg/mmhub/mmhub_1_0_sh_mask.h |  122 +
 .../include/asic_reg/mmhub/mmhub_9_4_0_offset.h    |   53 -
 .../include/asic_reg/mmhub/mmhub_9_4_0_sh_mask.h   |  257 --
 .../amd/include/asic_reg/umc/umc_6_1_1_offset.h    |    2 +
 .../amd/include/asic_reg/umc/umc_6_1_2_offset.h    |   33 +
 .../amd/include/asic_reg/umc/umc_6_1_2_sh_mask.h   |   91 +
 drivers/gpu/drm/amd/include/atomfirmware.h         |   14 -
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h    |    6 +-
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c      |    6 +-
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         |  378 +-
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       |  161 +-
 .../gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c  |   18 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c        |   13 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c       |   30 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c  |    3 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |   10 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |  164 +-
 .../gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c |    3 +
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c |    4 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c |    2 +-
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h     |   24 +-
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h          |    1 +
 .../amd/powerplay/inc/smu11_driver_if_arcturus.h   |   14 +-
 .../gpu/drm/amd/powerplay/inc/smu12_driver_if.h    |    7 +-
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h      |   10 +-
 drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h      |   15 +
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         |  126 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.h         |   14 +
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c         |  228 +-
 drivers/gpu/drm/amd/powerplay/smu_internal.h       |   10 +-
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c          |  202 +-
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c          |  133 +-
 drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c   |    4 +-
 drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c |    7 +-
 .../gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c    |    5 +-
 drivers/gpu/drm/amd/powerplay/smumgr/smu9_smumgr.c |   56 +-
 .../gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c   |   19 +-
 .../gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c   |    5 +-
 .../gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c   |   10 +-
 .../gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c    |   27 +-
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c         |   13 +-
 drivers/gpu/drm/arc/arcpgu_crtc.c                  |   36 +-
 drivers/gpu/drm/arc/arcpgu_regs.h                  |    2 +-
 drivers/gpu/drm/arm/display/Kconfig                |    6 -
 .../gpu/drm/arm/display/include/malidp_product.h   |    3 +-
 drivers/gpu/drm/arm/display/komeda/Makefile        |    5 +-
 .../gpu/drm/arm/display/komeda/d71/d71_component.c |   22 +-
 drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c   |   80 +-
 drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h  |   16 +
 .../gpu/drm/arm/display/komeda/komeda_color_mgmt.c |   66 +
 .../gpu/drm/arm/display/komeda/komeda_color_mgmt.h |   10 +-
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c   |    5 +
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c    |  129 +-
 drivers/gpu/drm/arm/display/komeda/komeda_dev.h    |   47 +-
 drivers/gpu/drm/arm/display/komeda/komeda_drv.c    |   52 +-
 drivers/gpu/drm/arm/display/komeda/komeda_event.c  |   26 +-
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c    |    8 +-
 .../gpu/drm/arm/display/komeda/komeda_pipeline.h   |    3 +
 .../drm/arm/display/komeda/komeda_pipeline_state.c |    6 +
 drivers/gpu/drm/arm/malidp_planes.c                |    2 +-
 drivers/gpu/drm/armada/armada_fbdev.c              |    2 +-
 drivers/gpu/drm/armada/armada_gem.c                |   12 -
 drivers/gpu/drm/ast/ast_drv.c                      |   67 +-
 drivers/gpu/drm/ast/ast_drv.h                      |   20 +-
 drivers/gpu/drm/ast/ast_main.c                     |   54 +-
 drivers/gpu/drm/ast/ast_mode.c                     |  812 ++--
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     |   18 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c       |   27 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c    |    2 +-
 drivers/gpu/drm/bochs/bochs_hw.c                   |    2 +-
 drivers/gpu/drm/bridge/Kconfig                     |   26 +-
 drivers/gpu/drm/bridge/Makefile                    |    6 +-
 drivers/gpu/drm/bridge/analogix-anx78xx.h          |  703 ----
 drivers/gpu/drm/bridge/analogix/Kconfig            |   23 +
 drivers/gpu/drm/bridge/analogix/Makefile           |    4 +-
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c |  817 ++++
 .../drm/bridge/{ =3D> analogix}/analogix-anx78xx.c   |  146 +-
 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.h |  249 ++
 .../gpu/drm/bridge/analogix/analogix-i2c-dptx.c    |  165 +
 .../gpu/drm/bridge/analogix/analogix-i2c-dptx.h    |  256 ++
 .../drm/bridge/analogix/analogix-i2c-txcommon.h    |  234 ++
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |    2 +-
 drivers/gpu/drm/bridge/cdns-dsi.c                  |    6 +-
 drivers/gpu/drm/bridge/lvds-codec.c                |  151 +
 drivers/gpu/drm/bridge/lvds-encoder.c              |  155 -
 drivers/gpu/drm/bridge/panel.c                     |   20 +-
 drivers/gpu/drm/bridge/parade-ps8622.c             |    2 +-
 .../gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c    |    2 +-
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      |   40 +-
 drivers/gpu/drm/bridge/tc358764.c                  |    2 +-
 drivers/gpu/drm/bridge/tc358767.c                  |    2 +-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |    2 +-
 drivers/gpu/drm/drm_agpsupport.c                   |    4 +-
 drivers/gpu/drm/drm_atomic.c                       |   30 +-
 drivers/gpu/drm/drm_atomic_helper.c                |  149 +-
 drivers/gpu/drm/drm_atomic_state_helper.c          |   78 +-
 drivers/gpu/drm/drm_atomic_uapi.c                  |   16 +-
 drivers/gpu/drm/drm_bridge.c                       |  280 +-
 drivers/gpu/drm/drm_client.c                       |   10 +-
 drivers/gpu/drm/drm_client_modeset.c               |   72 +
 drivers/gpu/drm/drm_color_mgmt.c                   |   40 +-
 drivers/gpu/drm/drm_crtc_helper.c                  |    2 +
 drivers/gpu/drm/drm_debugfs_crc.c                  |    9 +-
 drivers/gpu/drm/drm_dp_aux_dev.c                   |   12 +-
 drivers/gpu/drm/drm_dp_helper.c                    |   45 +-
 drivers/gpu/drm/drm_dp_mst_topology.c              |  468 ++-
 drivers/gpu/drm/drm_drv.c                          |    5 +-
 drivers/gpu/drm/drm_edid.c                         |  279 +-
 drivers/gpu/drm/drm_encoder.c                      |   15 +-
 drivers/gpu/drm/drm_fb_cma_helper.c                |    1 +
 drivers/gpu/drm/drm_fb_helper.c                    |  206 +-
 drivers/gpu/drm/drm_file.c                         |   44 +-
 drivers/gpu/drm/drm_fourcc.c                       |    8 +-
 drivers/gpu/drm/drm_gem.c                          |    3 -
 drivers/gpu/drm/drm_gem_framebuffer_helper.c       |    5 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c             |    3 +
 drivers/gpu/drm/drm_gem_vram_helper.c              |   53 +-
 drivers/gpu/drm/drm_internal.h                     |   22 +
 drivers/gpu/drm/drm_ioctl.c                        |    4 +-
 drivers/gpu/drm/drm_lock.c                         |    3 +-
 drivers/gpu/drm/drm_mipi_dbi.c                     |    4 +-
 drivers/gpu/drm/drm_mipi_dsi.c                     |   57 +-
 drivers/gpu/drm/drm_mode_config.c                  |   28 +
 drivers/gpu/drm/drm_mode_object.c                  |   14 +
 drivers/gpu/drm/drm_modes.c                        |  255 +-
 drivers/gpu/drm/drm_of.c                           |  116 +
 drivers/gpu/drm/drm_panel.c                        |  109 +-
 drivers/gpu/drm/drm_pci.c                          |   17 +-
 drivers/gpu/drm/drm_prime.c                        |    9 +-
 drivers/gpu/drm/drm_print.c                        |   18 +-
 drivers/gpu/drm/drm_probe_helper.c                 |    4 +-
 drivers/gpu/drm/drm_rect.c                         |   42 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.c              |    7 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c       |    8 +-
 drivers/gpu/drm/exynos/Kconfig                     |    6 +-
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c      |   10 +-
 drivers/gpu/drm/exynos/exynos7_drm_decon.c         |   10 +-
 drivers/gpu/drm/exynos/exynos_dp.c                 |    1 -
 drivers/gpu/drm/exynos/exynos_drm_crtc.c           |    8 +-
 drivers/gpu/drm/exynos/exynos_drm_dpi.c            |    4 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.h            |    8 +-
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |   34 +-
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c          |    2 +-
 drivers/gpu/drm/exynos/exynos_drm_fimd.c           |   10 +-
 drivers/gpu/drm/exynos/exynos_drm_vidi.c           |    8 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |    6 +-
 drivers/gpu/drm/exynos/exynos_mixer.c              |    8 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c          |    2 +-
 drivers/gpu/drm/gma500/accel_2d.c                  |   19 +-
 drivers/gpu/drm/gma500/cdv_intel_display.c         |    8 +-
 drivers/gpu/drm/gma500/cdv_intel_dp.c              |    3 -
 drivers/gpu/drm/gma500/framebuffer.c               |  135 +-
 drivers/gpu/drm/gma500/framebuffer.h               |   15 -
 drivers/gpu/drm/gma500/gma_display.c               |   48 +
 drivers/gpu/drm/gma500/gma_display.h               |    6 +
 drivers/gpu/drm/gma500/mdfld_intel_display.c       |   23 -
 drivers/gpu/drm/gma500/oaktrail_hdmi.c             |    4 +-
 drivers/gpu/drm/gma500/oaktrail_lvds.c             |    1 +
 drivers/gpu/drm/gma500/psb_drv.c                   |   44 +-
 drivers/gpu/drm/gma500/psb_drv.h                   |    8 +-
 drivers/gpu/drm/gma500/psb_intel_display.c         |    1 +
 drivers/gpu/drm/gma500/psb_intel_drv.h             |    3 +
 drivers/gpu/drm/gma500/psb_irq.c                   |   23 +-
 drivers/gpu/drm/gma500/tc35876x-dsi-lvds.c         |   88 +-
 drivers/gpu/drm/hisilicon/hibmc/Makefile           |    2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c     |    4 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c    |    6 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h    |   26 -
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c  |  240 --
 drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c        |  116 +-
 drivers/gpu/drm/i810/i810_dma.c                    |    2 +-
 drivers/gpu/drm/i810/i810_drv.c                    |    3 +-
 drivers/gpu/drm/i915/.gitignore                    |    1 +
 drivers/gpu/drm/i915/Kconfig.debug                 |    2 +
 drivers/gpu/drm/i915/Makefile                      |   42 +-
 drivers/gpu/drm/i915/display/Makefile              |    6 -
 drivers/gpu/drm/i915/display/icl_dsi.c             |  289 +-
 drivers/gpu/drm/i915/display/intel_atomic.c        |   87 +-
 drivers/gpu/drm/i915/display/intel_atomic.h        |    8 +
 drivers/gpu/drm/i915/display/intel_atomic_plane.c  |  138 +-
 drivers/gpu/drm/i915/display/intel_atomic_plane.h  |    5 +-
 drivers/gpu/drm/i915/display/intel_audio.c         |   16 +-
 drivers/gpu/drm/i915/display/intel_bios.c          |  563 ++-
 drivers/gpu/drm/i915/display/intel_bios.h          |    5 +
 drivers/gpu/drm/i915/display/intel_bw.c            |   36 +-
 drivers/gpu/drm/i915/display/intel_bw.h            |    1 +
 drivers/gpu/drm/i915/display/intel_cdclk.c         |   32 +-
 drivers/gpu/drm/i915/display/intel_color.c         |  198 +-
 drivers/gpu/drm/i915/display/intel_crt.c           |   58 +-
 drivers/gpu/drm/i915/display/intel_ddi.c           |  578 +--
 drivers/gpu/drm/i915/display/intel_ddi.h           |    2 +-
 drivers/gpu/drm/i915/display/intel_display.c       | 4031 ++++++++++++----=
----
 drivers/gpu/drm/i915/display/intel_display.h       |   49 +-
 drivers/gpu/drm/i915/display/intel_display_power.c |   81 +-
 drivers/gpu/drm/i915/display/intel_display_power.h |    2 +-
 drivers/gpu/drm/i915/display/intel_display_types.h |  107 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |  263 +-
 .../gpu/drm/i915/display/intel_dp_aux_backlight.c  |   15 +-
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |  254 +-
 drivers/gpu/drm/i915/display/intel_dp_mst.h        |    5 +
 drivers/gpu/drm/i915/display/intel_dpio_phy.c      |   32 +-
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c      |   24 +-
 drivers/gpu/drm/i915/display/intel_dsb.c           |   37 +-
 drivers/gpu/drm/i915/display/intel_dsb.h           |    2 +-
 drivers/gpu/drm/i915/display/intel_dsi.h           |   14 +-
 .../gpu/drm/i915/display/intel_dsi_dcs_backlight.c |    8 +-
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c       |  229 +-
 drivers/gpu/drm/i915/display/intel_dvo.c           |   22 +-
 drivers/gpu/drm/i915/display/intel_fbc.c           |  309 +-
 drivers/gpu/drm/i915/display/intel_fbc.h           |   11 +-
 drivers/gpu/drm/i915/display/intel_fbdev.c         |    2 +-
 drivers/gpu/drm/i915/display/intel_fifo_underrun.c |   24 +-
 drivers/gpu/drm/i915/display/intel_hdcp.c          |    2 +-
 drivers/gpu/drm/i915/display/intel_hdmi.c          |  152 +-
 drivers/gpu/drm/i915/display/intel_hdmi.h          |    2 +-
 drivers/gpu/drm/i915/display/intel_hotplug.c       |    4 +-
 drivers/gpu/drm/i915/display/intel_lspcon.c        |   12 +-
 drivers/gpu/drm/i915/display/intel_lvds.c          |   12 +-
 drivers/gpu/drm/i915/display/intel_opregion.c      |    7 +
 drivers/gpu/drm/i915/display/intel_overlay.c       |   12 +-
 drivers/gpu/drm/i915/display/intel_panel.c         |   30 +-
 drivers/gpu/drm/i915/display/intel_pipe_crc.c      |    8 +-
 drivers/gpu/drm/i915/display/intel_psr.c           |  177 +-
 drivers/gpu/drm/i915/display/intel_psr.h           |    5 +
 drivers/gpu/drm/i915/display/intel_sdvo.c          |   51 +-
 drivers/gpu/drm/i915/display/intel_sprite.c        |  452 ++-
 drivers/gpu/drm/i915/display/intel_tv.c            |   16 +-
 drivers/gpu/drm/i915/display/intel_vbt_defs.h      |   62 +-
 drivers/gpu/drm/i915/display/intel_vdsc.c          |  305 +-
 drivers/gpu/drm/i915/display/intel_vdsc.h          |   11 +-
 drivers/gpu/drm/i915/display/vlv_dsi.c             |   95 +-
 drivers/gpu/drm/i915/display/vlv_dsi_pll.c         |   12 +-
 drivers/gpu/drm/i915/gem/Makefile                  |    5 -
 drivers/gpu/drm/i915/gem/i915_gem_clflush.c        |   11 +-
 drivers/gpu/drm/i915/gem/i915_gem_context.c        |  385 +-
 drivers/gpu/drm/i915/gem/i915_gem_context.h        |   49 +-
 drivers/gpu/drm/i915/gem/i915_gem_context_types.h  |   28 +-
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c         |   36 -
 drivers/gpu/drm/i915/gem/i915_gem_domain.c         |  184 +-
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c     |  322 +-
 drivers/gpu/drm/i915/gem/i915_gem_ioctls.h         |    4 +-
 drivers/gpu/drm/i915/gem/i915_gem_lmem.c           |   43 -
 drivers/gpu/drm/i915/gem/i915_gem_lmem.h           |    8 -
 drivers/gpu/drm/i915/gem/i915_gem_mman.c           |  529 ++-
 drivers/gpu/drm/i915/gem/i915_gem_mman.h           |   31 +
 drivers/gpu/drm/i915/gem/i915_gem_object.c         |   47 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.h         |   35 +-
 drivers/gpu/drm/i915/gem/i915_gem_object_types.h   |   29 +-
 drivers/gpu/drm/i915/gem/i915_gem_pages.c          |   91 +-
 drivers/gpu/drm/i915/gem/i915_gem_phys.c           |    2 +-
 drivers/gpu/drm/i915/gem/i915_gem_pm.c             |   24 +-
 drivers/gpu/drm/i915/gem/i915_gem_region.c         |    5 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c          |    2 +
 drivers/gpu/drm/i915/gem/i915_gem_shrinker.c       |    5 +-
 drivers/gpu/drm/i915/gem/i915_gem_stolen.c         |  221 +-
 drivers/gpu/drm/i915/gem/i915_gem_tiling.c         |    1 +
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c        |   24 +-
 .../gpu/drm/i915/gem/selftests/huge_gem_object.c   |   11 +-
 .../gpu/drm/i915/gem/selftests/huge_gem_object.h   |    6 +
 drivers/gpu/drm/i915/gem/selftests/huge_pages.c    |   66 +-
 .../drm/i915/gem/selftests/i915_gem_client_blt.c   |    2 +
 .../drm/i915/gem/selftests/i915_gem_coherency.c    |   17 +-
 .../gpu/drm/i915/gem/selftests/i915_gem_context.c  |  171 +-
 .../gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c   |  101 -
 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c |  577 ++-
 .../drm/i915/gem/selftests/i915_gem_object_blt.c   |  125 +-
 drivers/gpu/drm/i915/gem/selftests/mock_context.c  |   21 +-
 drivers/gpu/drm/i915/gem/selftests/mock_context.h  |    5 +-
 drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c   |   16 -
 drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.h   |    2 +-
 .../gpu/drm/i915/gem/selftests/mock_gem_object.h   |    2 +
 drivers/gpu/drm/i915/gt/Makefile                   |    5 -
 drivers/gpu/drm/i915/gt/debugfs_engines.c          |   36 +
 drivers/gpu/drm/i915/gt/debugfs_engines.h          |   14 +
 drivers/gpu/drm/i915/gt/debugfs_gt.c               |   42 +
 drivers/gpu/drm/i915/gt/debugfs_gt.h               |   39 +
 drivers/gpu/drm/i915/gt/debugfs_gt_pm.c            |  601 +++
 drivers/gpu/drm/i915/gt/debugfs_gt_pm.h            |   14 +
 drivers/gpu/drm/i915/gt/gen6_ppgtt.c               |  482 +++
 drivers/gpu/drm/i915/gt/gen6_ppgtt.h               |   76 +
 drivers/gpu/drm/i915/gt/gen8_ppgtt.c               |  723 ++++
 drivers/gpu/drm/i915/gt/gen8_ppgtt.h               |   13 +
 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c        |   66 +-
 drivers/gpu/drm/i915/gt/intel_context.c            |  189 +-
 drivers/gpu/drm/i915/gt/intel_context.h            |   85 +-
 drivers/gpu/drm/i915/gt/intel_context_types.h      |   12 +-
 drivers/gpu/drm/i915/gt/intel_engine.h             |   25 +-
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          |  211 +-
 drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c   |   22 +-
 drivers/gpu/drm/i915/gt/intel_engine_pm.c          |   63 +-
 drivers/gpu/drm/i915/gt/intel_engine_pm.h          |   21 +
 drivers/gpu/drm/i915/gt/intel_engine_types.h       |   26 +-
 drivers/gpu/drm/i915/gt/intel_engine_user.c        |    4 +
 drivers/gpu/drm/i915/gt/intel_ggtt.c               | 1486 ++++++++
 drivers/gpu/drm/i915/gt/intel_gpu_commands.h       |   29 +
 drivers/gpu/drm/i915/gt/intel_gt.c                 |  280 +-
 drivers/gpu/drm/i915/gt/intel_gt.h                 |   13 +-
 drivers/gpu/drm/i915/gt/intel_gt_irq.c             |   12 +-
 drivers/gpu/drm/i915/gt/intel_gt_pm.c              |   80 +-
 drivers/gpu/drm/i915/gt/intel_gt_pm.h              |    7 +-
 drivers/gpu/drm/i915/gt/intel_gt_requests.c        |   51 +-
 drivers/gpu/drm/i915/gt/intel_gt_requests.h        |    1 +
 drivers/gpu/drm/i915/gt/intel_gt_types.h           |    7 +
 drivers/gpu/drm/i915/gt/intel_gtt.c                |  598 +++
 drivers/gpu/drm/i915/gt/intel_gtt.h                |  587 +++
 drivers/gpu/drm/i915/gt/intel_lrc.c                |  637 ++--
 drivers/gpu/drm/i915/gt/intel_lrc.h                |    7 +-
 drivers/gpu/drm/i915/gt/intel_lrc_reg.h            |    4 +-
 drivers/gpu/drm/i915/gt/intel_mocs.c               |  179 +-
 drivers/gpu/drm/i915/gt/intel_ppgtt.c              |  218 ++
 drivers/gpu/drm/i915/gt/intel_rc6.c                |  149 +-
 drivers/gpu/drm/i915/gt/intel_rc6.h                |    6 +-
 drivers/gpu/drm/i915/gt/intel_rc6_types.h          |    4 +-
 drivers/gpu/drm/i915/gt/intel_renderstate.c        |   97 +-
 drivers/gpu/drm/i915/gt/intel_renderstate.h        |   17 +-
 drivers/gpu/drm/i915/gt/intel_reset.c              |  142 +-
 drivers/gpu/drm/i915/gt/intel_ring_submission.c    |  245 +-
 drivers/gpu/drm/i915/gt/intel_rps.c                |  123 +-
 drivers/gpu/drm/i915/gt/intel_rps.h                |    3 +-
 drivers/gpu/drm/i915/gt/intel_timeline.c           |   91 +-
 drivers/gpu/drm/i915/gt/intel_timeline.h           |    4 +-
 drivers/gpu/drm/i915/gt/intel_timeline_types.h     |   14 +-
 drivers/gpu/drm/i915/gt/intel_workarounds.c        |   49 +-
 drivers/gpu/drm/i915/gt/mock_engine.c              |   57 +-
 drivers/gpu/drm/i915/gt/selftest_context.c         |  120 +-
 drivers/gpu/drm/i915/gt/selftest_engine_cs.c       |  360 +-
 .../gpu/drm/i915/gt/selftest_engine_heartbeat.c    |   36 +-
 drivers/gpu/drm/i915/gt/selftest_gt_pm.c           |   19 +
 drivers/gpu/drm/i915/gt/selftest_hangcheck.c       |  180 +-
 drivers/gpu/drm/i915/gt/selftest_lrc.c             |  608 ++-
 drivers/gpu/drm/i915/gt/selftest_mocs.c            |  419 ++
 drivers/gpu/drm/i915/gt/selftest_rc6.c             |  203 +
 drivers/gpu/drm/i915/gt/selftest_rc6.h             |   13 +
 drivers/gpu/drm/i915/gt/selftest_timeline.c        |    6 +-
 drivers/gpu/drm/i915/gt/selftest_workarounds.c     |   72 +-
 drivers/gpu/drm/i915/gt/selftests/mock_timeline.c  |    2 +-
 drivers/gpu/drm/i915/gt/selftests/mock_timeline.h  |    2 +
 drivers/gpu/drm/i915/gt/uc/Makefile                |    5 -
 drivers/gpu/drm/i915/gt/uc/intel_guc.c             |   69 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc.h             |   46 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_ads.c         |   24 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c          |  309 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_ct.h          |   52 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_fw.c          |    2 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_fwif.h        |    1 -
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c  |  733 +---
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.h  |   54 +-
 drivers/gpu/drm/i915/gt/uc/intel_huc_fw.c          |    2 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc.c              |  143 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc.h              |   36 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c           |   58 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.h           |    5 +-
 drivers/gpu/drm/i915/gt/uc/selftest_guc.c          |  299 --
 drivers/gpu/drm/i915/gvt/cmd_parser.h              |    4 +
 drivers/gpu/drm/i915/gvt/display.h                 |    5 +
 drivers/gpu/drm/i915/gvt/edid.h                    |    4 +
 drivers/gpu/drm/i915/gvt/execlist.h                |    2 +
 drivers/gpu/drm/i915/gvt/fb_decoder.h              |    2 +
 drivers/gpu/drm/i915/gvt/gtt.c                     |    2 +-
 drivers/gpu/drm/i915/gvt/handlers.c                |    8 +-
 drivers/gpu/drm/i915/gvt/hypercall.h               |    4 +
 drivers/gpu/drm/i915/gvt/interrupt.h               |    3 +
 drivers/gpu/drm/i915/gvt/mmio.h                    |    2 +
 drivers/gpu/drm/i915/gvt/page_track.h              |    3 +
 drivers/gpu/drm/i915/gvt/sched_policy.h            |    3 +
 drivers/gpu/drm/i915/gvt/scheduler.c               |   43 +-
 drivers/gpu/drm/i915/i915_active.c                 |  142 +-
 drivers/gpu/drm/i915/i915_active.h                 |   28 +-
 drivers/gpu/drm/i915/i915_active_types.h           |   15 -
 drivers/gpu/drm/i915/i915_buddy.c                  |    4 +-
 drivers/gpu/drm/i915/i915_cmd_parser.c             |  318 +-
 drivers/gpu/drm/i915/i915_debugfs.c                |  421 +-
 drivers/gpu/drm/i915/i915_drv.c                    |   41 +-
 drivers/gpu/drm/i915/i915_drv.h                    |  111 +-
 drivers/gpu/drm/i915/i915_gem.c                    |  383 +-
 drivers/gpu/drm/i915/i915_gem.h                    |   10 +-
 drivers/gpu/drm/i915/i915_gem_evict.c              |   39 +-
 drivers/gpu/drm/i915/i915_gem_fence_reg.c          |    3 +
 drivers/gpu/drm/i915/i915_gem_gtt.c                | 3601 +---------------=
-
 drivers/gpu/drm/i915/i915_gem_gtt.h                |  629 +--
 drivers/gpu/drm/i915/i915_getparam.c               |    1 +
 drivers/gpu/drm/i915/i915_globals.c                |   53 +-
 drivers/gpu/drm/i915/i915_gpu_error.c              | 1257 +++---
 drivers/gpu/drm/i915/i915_gpu_error.h              |  329 +-
 drivers/gpu/drm/i915/i915_irq.c                    |   84 +-
 drivers/gpu/drm/i915/i915_memcpy.c                 |   75 +-
 drivers/gpu/drm/i915/i915_memcpy.h                 |    2 +
 drivers/gpu/drm/i915/i915_mm.c                     |   69 +
 drivers/gpu/drm/i915/i915_pci.c                    |  247 +-
 drivers/gpu/drm/i915/i915_perf.c                   |   62 +-
 drivers/gpu/drm/i915/i915_perf.h                   |    2 +
 drivers/gpu/drm/i915/i915_perf_types.h             |    1 -
 drivers/gpu/drm/i915/i915_pmu.c                    |   63 +-
 drivers/gpu/drm/i915/i915_reg.h                    |  164 +-
 drivers/gpu/drm/i915/i915_request.c                |  156 +-
 drivers/gpu/drm/i915/i915_request.h                |   70 +-
 drivers/gpu/drm/i915/i915_scheduler.c              |   14 +-
 drivers/gpu/drm/i915/i915_scheduler.h              |    1 +
 drivers/gpu/drm/i915/i915_selftest.h               |    4 +
 drivers/gpu/drm/i915/i915_sw_fence.c               |   40 +-
 drivers/gpu/drm/i915/i915_sw_fence.h               |    5 +-
 drivers/gpu/drm/i915/i915_sw_fence_work.c          |   15 +-
 drivers/gpu/drm/i915/i915_sysfs.c                  |   37 +-
 drivers/gpu/drm/i915/i915_trace.h                  |    6 +-
 drivers/gpu/drm/i915/i915_utils.c                  |    2 +-
 drivers/gpu/drm/i915/i915_utils.h                  |    2 +-
 drivers/gpu/drm/i915/i915_vma.c                    |   92 +-
 drivers/gpu/drm/i915/i915_vma.h                    |  147 +-
 drivers/gpu/drm/i915/i915_vma_types.h              |  294 ++
 drivers/gpu/drm/i915/intel_device_info.c           |   45 +-
 drivers/gpu/drm/i915/intel_device_info.h           |    9 +-
 drivers/gpu/drm/i915/intel_memory_region.c         |   32 +-
 drivers/gpu/drm/i915/intel_memory_region.h         |   14 +
 drivers/gpu/drm/i915/intel_pch.c                   |   47 +-
 drivers/gpu/drm/i915/intel_pch.h                   |    1 +
 drivers/gpu/drm/i915/intel_pm.c                    |  721 ++--
 drivers/gpu/drm/i915/intel_pm.h                    |    2 +-
 drivers/gpu/drm/i915/intel_region_lmem.c           |   18 +-
 drivers/gpu/drm/i915/intel_sideband.c              |   29 +-
 drivers/gpu/drm/i915/intel_uncore.c                |   25 +-
 drivers/gpu/drm/i915/intel_wakeref.c               |    5 +-
 drivers/gpu/drm/i915/intel_wakeref.h               |   28 +-
 drivers/gpu/drm/i915/oa/Makefile                   |    7 -
 drivers/gpu/drm/i915/selftests/i915_active.c       |   43 +-
 drivers/gpu/drm/i915/selftests/i915_gem.c          |   11 +-
 drivers/gpu/drm/i915/selftests/i915_gem_evict.c    |    8 +-
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c      |  109 +-
 .../gpu/drm/i915/selftests/i915_live_selftests.h   |   12 +-
 .../gpu/drm/i915/selftests/i915_mock_selftests.h   |    8 +-
 drivers/gpu/drm/i915/selftests/i915_perf.c         |    2 +-
 .../gpu/drm/i915/selftests/i915_perf_selftests.h   |   19 +
 drivers/gpu/drm/i915/selftests/i915_request.c      |  129 +-
 drivers/gpu/drm/i915/selftests/i915_selftest.c     |   43 +
 drivers/gpu/drm/i915/selftests/igt_atomic.c        |   47 +
 drivers/gpu/drm/i915/selftests/igt_atomic.h        |   41 +-
 drivers/gpu/drm/i915/selftests/igt_live_test.h     |    2 +-
 drivers/gpu/drm/i915/selftests/igt_mmap.c          |   39 +
 drivers/gpu/drm/i915/selftests/igt_mmap.h          |   19 +
 drivers/gpu/drm/i915/selftests/igt_spinner.c       |   40 +-
 .../gpu/drm/i915/selftests/intel_memory_region.c   |   43 +-
 drivers/gpu/drm/i915/selftests/mock_drm.c          |   73 -
 drivers/gpu/drm/i915/selftests/mock_drm.h          |   18 +-
 drivers/gpu/drm/i915/selftests/mock_gem_device.c   |   26 +-
 drivers/gpu/drm/i915/selftests/mock_gtt.c          |    9 +-
 drivers/gpu/drm/i915/selftests/mock_gtt.h          |    3 +
 drivers/gpu/drm/i915/selftests/mock_region.h       |    5 +
 drivers/gpu/drm/i915/selftests/mock_uncore.h       |    3 +
 drivers/gpu/drm/imx/imx-ldb.c                      |    2 +-
 drivers/gpu/drm/imx/parallel-display.c             |    2 +-
 drivers/gpu/drm/ingenic/ingenic-drm.c              |   38 +-
 drivers/gpu/drm/lima/Kconfig                       |    2 +-
 drivers/gpu/drm/lima/lima_sched.c                  |   40 +-
 drivers/gpu/drm/lima/lima_sched.h                  |    2 -
 drivers/gpu/drm/mcde/mcde_display.c                |   57 +-
 drivers/gpu/drm/mcde/mcde_drm.h                    |    1 +
 drivers/gpu/drm/mcde/mcde_drv.c                    |   18 +-
 drivers/gpu/drm/mcde/mcde_dsi.c                    |  416 +-
 drivers/gpu/drm/mcde/mcde_dsi_regs.h               |   22 +-
 drivers/gpu/drm/mediatek/Makefile                  |    3 +-
 drivers/gpu/drm/mediatek/mtk_disp_color.c          |    7 +-
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c            |   76 +-
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c           |   43 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |  190 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.h            |    2 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        |  184 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |   56 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |   92 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h             |    7 -
 drivers/gpu/drm/mediatek/mtk_drm_fb.c              |   92 -
 drivers/gpu/drm/mediatek/mtk_drm_fb.h              |   13 -
 drivers/gpu/drm/mediatek/mtk_drm_plane.c           |   50 +-
 drivers/gpu/drm/mediatek/mtk_drm_plane.h           |    2 +
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |    2 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c                |   15 +-
 drivers/gpu/drm/meson/Makefile                     |    1 +
 drivers/gpu/drm/meson/meson_crtc.c                 |   81 +-
 drivers/gpu/drm/meson/meson_drv.c                  |   50 +-
 drivers/gpu/drm/meson/meson_drv.h                  |   23 +
 drivers/gpu/drm/meson/meson_osd_afbcd.c            |  389 ++
 drivers/gpu/drm/meson/meson_osd_afbcd.h            |   28 +
 drivers/gpu/drm/meson/meson_plane.c                |  231 +-
 drivers/gpu/drm/meson/meson_rdma.c                 |  135 +
 drivers/gpu/drm/meson/meson_rdma.h                 |   21 +
 drivers/gpu/drm/meson/meson_registers.h            |  110 +
 drivers/gpu/drm/meson/meson_viu.c                  |   83 +-
 drivers/gpu/drm/meson/meson_viu.h                  |   19 +
 drivers/gpu/drm/mga/mga_drv.h                      |    2 +-
 drivers/gpu/drm/mgag200/Kconfig                    |    8 +-
 drivers/gpu/drm/mgag200/mgag200_cursor.c           |    5 +-
 drivers/gpu/drm/mgag200/mgag200_drv.c              |   61 +-
 drivers/gpu/drm/mgag200/mgag200_i2c.c              |    3 +-
 drivers/gpu/drm/mgag200/mgag200_main.c             |    8 +-
 drivers/gpu/drm/mgag200/mgag200_mode.c             |    2 +-
 drivers/gpu/drm/mgag200/mgag200_ttm.c              |    2 +-
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c              |    8 +
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c              |    8 +
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |   11 +-
 drivers/gpu/drm/msm/adreno/a6xx.xml.h              |   52 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |   32 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |    3 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |   81 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |    9 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c        |   52 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h        |   16 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c         |   11 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |   66 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |   17 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |   15 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |  186 +-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c   |   73 +-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |   73 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c        |   18 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  241 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   38 +-
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog_format.h  |    4 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c         |   92 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h         |   26 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c  |   22 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h  |    1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        |   36 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h        |    8 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c          |   13 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h          |    2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c    |    8 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h    |    2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c        |    8 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h        |    5 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_io_util.c        |   27 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |    1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |   34 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c             |    6 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c           |    6 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c   |    2 +-
 .../gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c    |    2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c           |    2 +-
 drivers/gpu/drm/msm/dsi/dsi.h                      |    2 +
 drivers/gpu/drm/msm/dsi/dsi_cfg.c                  |   24 +
 drivers/gpu/drm/msm/dsi/dsi_cfg.h                  |    2 +
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |   46 +-
 drivers/gpu/drm/msm/dsi/dsi_manager.c              |   64 +-
 drivers/gpu/drm/msm/edp/edp_bridge.c               |   10 +-
 drivers/gpu/drm/msm/hdmi/hdmi_connector.c          |    8 +-
 drivers/gpu/drm/msm/msm_drv.c                      |    4 +-
 drivers/gpu/drm/msm/msm_fbdev.c                    |    2 +-
 drivers/gpu/drm/msm/msm_gem_submit.c               |   19 +-
 drivers/gpu/drm/msm/msm_gpu.h                      |    7 +
 drivers/gpu/drm/mxsfb/mxsfb_out.c                  |    2 +-
 drivers/gpu/drm/nouveau/Kconfig                    |    4 +-
 drivers/gpu/drm/nouveau/dispnv04/arb.c             |    6 +-
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c          |   13 +-
 drivers/gpu/drm/nouveau/dispnv50/base907c.c        |   11 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |  228 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.h            |    6 +-
 drivers/gpu/drm/nouveau/dispnv50/head.c            |   43 +-
 drivers/gpu/drm/nouveau/dispnv50/head.h            |   10 +-
 drivers/gpu/drm/nouveau/dispnv50/head507d.c        |    9 +-
 drivers/gpu/drm/nouveau/dispnv50/head827d.c        |    1 +
 drivers/gpu/drm/nouveau/dispnv50/head907d.c        |   11 +-
 drivers/gpu/drm/nouveau/dispnv50/head917d.c        |    1 +
 drivers/gpu/drm/nouveau/dispnv50/headc37d.c        |   11 +-
 drivers/gpu/drm/nouveau/dispnv50/headc57d.c        |   12 +-
 drivers/gpu/drm/nouveau/dispnv50/lut.c             |    2 +-
 drivers/gpu/drm/nouveau/dispnv50/wndw.c            |   17 +-
 drivers/gpu/drm/nouveau/dispnv50/wndw.h            |    3 +-
 drivers/gpu/drm/nouveau/dispnv50/wndwc37e.c        |   11 +-
 drivers/gpu/drm/nouveau/dispnv50/wndwc57e.c        |   11 +-
 drivers/gpu/drm/nouveau/include/nvfw/acr.h         |  152 +
 drivers/gpu/drm/nouveau/include/nvfw/flcn.h        |   97 +
 drivers/gpu/drm/nouveau/include/nvfw/fw.h          |   28 +
 drivers/gpu/drm/nouveau/include/nvfw/hs.h          |   31 +
 drivers/gpu/drm/nouveau/include/nvfw/ls.h          |   53 +
 drivers/gpu/drm/nouveau/include/nvfw/pmu.h         |   98 +
 drivers/gpu/drm/nouveau/include/nvfw/sec2.h        |   60 +
 drivers/gpu/drm/nouveau/include/nvif/class.h       |    3 +
 drivers/gpu/drm/nouveau/include/nvif/if0008.h      |    2 +-
 drivers/gpu/drm/nouveau/include/nvif/mmu.h         |    4 +-
 drivers/gpu/drm/nouveau/include/nvkm/core/device.h |   10 +-
 drivers/gpu/drm/nouveau/include/nvkm/core/falcon.h |   77 +
 .../gpu/drm/nouveau/include/nvkm/core/firmware.h   |   51 +-
 drivers/gpu/drm/nouveau/include/nvkm/core/memory.h |   16 +
 drivers/gpu/drm/nouveau/include/nvkm/core/os.h     |   13 +
 .../gpu/drm/nouveau/include/nvkm/engine/falcon.h   |   20 +-
 drivers/gpu/drm/nouveau/include/nvkm/engine/gr.h   |    2 +
 .../gpu/drm/nouveau/include/nvkm/engine/nvdec.h    |    8 +-
 .../gpu/drm/nouveau/include/nvkm/engine/nvenc.h    |   10 +
 drivers/gpu/drm/nouveau/include/nvkm/engine/sec2.h |   13 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/acr.h  |  126 +
 .../gpu/drm/nouveau/include/nvkm/subdev/fault.h    |    1 +
 drivers/gpu/drm/nouveau/include/nvkm/subdev/fb.h   |    2 +
 drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h  |    5 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/ltc.h  |    1 +
 drivers/gpu/drm/nouveau/include/nvkm/subdev/pmu.h  |   14 +-
 drivers/gpu/drm/nouveau/nouveau_bo.c               |    5 +-
 drivers/gpu/drm/nouveau/nouveau_chan.c             |    2 +
 drivers/gpu/drm/nouveau/nouveau_dmem.c             |    4 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |    3 +-
 drivers/gpu/drm/nouveau/nouveau_drv.h              |   11 +-
 drivers/gpu/drm/nouveau/nouveau_fbcon.c            |    4 +-
 drivers/gpu/drm/nouveau/nouveau_fence.c            |   12 +-
 drivers/gpu/drm/nouveau/nouveau_fence.h            |    1 +
 drivers/gpu/drm/nouveau/nouveau_gem.c              |   68 +-
 drivers/gpu/drm/nouveau/nouveau_hwmon.c            |    2 +-
 drivers/gpu/drm/nouveau/nouveau_ttm.c              |    4 -
 drivers/gpu/drm/nouveau/nouveau_vmm.c              |    2 +-
 drivers/gpu/drm/nouveau/nvif/mmu.c                 |    1 +
 drivers/gpu/drm/nouveau/nvkm/Kbuild                |    1 +
 drivers/gpu/drm/nouveau/nvkm/core/firmware.c       |   67 +-
 drivers/gpu/drm/nouveau/nvkm/core/memory.c         |    2 +-
 drivers/gpu/drm/nouveau/nvkm/core/subdev.c         |    2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  |  108 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/priv.h  |    2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c |   24 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/channv50.c    |    2 +
 drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c      |    2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c   |   23 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/Kbuild      |    3 +
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.c  |   27 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h  |   10 +
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk20a.c  |    6 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm20b.c  |    6 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgv100.c  |   23 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxtu102.c  |   95 +
 .../drm/nouveau/nvkm/engine/gr/fuc/hubgk208.fuc5.h |  786 ++--
 .../drm/nouveau/nvkm/engine/gr/fuc/hubgm107.fuc5.h |  786 ++--
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c     |  311 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.h     |   90 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf104.c     |    9 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf108.c     |    9 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf110.c     |    9 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf117.c     |    9 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf119.c     |    9 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gk104.c     |    9 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gk110.c     |    9 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gk110b.c    |    9 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gk208.c     |    9 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gk20a.c     |  130 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gm107.c     |    9 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gm200.c     |  160 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gm20b.c     |   98 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gp100.c     |   23 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gp102.c     |   21 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gp104.c     |   34 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gp107.c     |   23 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gp108.c     |   97 +
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gp10b.c     |   39 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gv100.c     |   29 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c     |  177 +
 drivers/gpu/drm/nouveau/nvkm/engine/nvdec/Kbuild   |    2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/nvdec/base.c   |   42 +-
 .../core/msgqueue.h =3D> nvkm/engine/nvdec/gm107.c}  |   54 +-
 drivers/gpu/drm/nouveau/nvkm/engine/nvdec/priv.h   |   14 +-
 drivers/gpu/drm/nouveau/nvkm/engine/nvenc/Kbuild   |    3 +-
 drivers/gpu/drm/nouveau/nvkm/engine/nvenc/base.c   |   63 +
 drivers/gpu/drm/nouveau/nvkm/engine/nvenc/gm107.c  |   63 +
 drivers/gpu/drm/nouveau/nvkm/engine/nvenc/priv.h   |   19 +
 drivers/gpu/drm/nouveau/nvkm/engine/sec2/Kbuild    |    1 +
 drivers/gpu/drm/nouveau/nvkm/engine/sec2/base.c    |  109 +-
 drivers/gpu/drm/nouveau/nvkm/engine/sec2/gp102.c   |  312 +-
 drivers/gpu/drm/nouveau/nvkm/engine/sec2/gp108.c   |   39 +
 drivers/gpu/drm/nouveau/nvkm/engine/sec2/priv.h    |   24 +-
 drivers/gpu/drm/nouveau/nvkm/engine/sec2/tu102.c   |   47 +-
 drivers/gpu/drm/nouveau/nvkm/falcon/Kbuild         |    6 +-
 drivers/gpu/drm/nouveau/nvkm/falcon/base.c         |   87 +-
 drivers/gpu/drm/nouveau/nvkm/falcon/cmdq.c         |  214 ++
 drivers/gpu/drm/nouveau/nvkm/falcon/msgq.c         |  213 ++
 drivers/gpu/drm/nouveau/nvkm/falcon/msgqueue.c     |  577 ---
 drivers/gpu/drm/nouveau/nvkm/falcon/msgqueue.h     |  213 --
 .../drm/nouveau/nvkm/falcon/msgqueue_0137c63d.c    |  436 ---
 .../drm/nouveau/nvkm/falcon/msgqueue_0148cdec.c    |  264 --
 drivers/gpu/drm/nouveau/nvkm/falcon/priv.h         |    6 +-
 drivers/gpu/drm/nouveau/nvkm/falcon/qmgr.c         |   87 +
 drivers/gpu/drm/nouveau/nvkm/falcon/qmgr.h         |   89 +
 drivers/gpu/drm/nouveau/nvkm/falcon/v1.c           |   86 +-
 drivers/gpu/drm/nouveau/nvkm/nvfw/Kbuild           |    7 +
 drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c            |  165 +
 drivers/gpu/drm/nouveau/nvkm/nvfw/flcn.c           |  115 +
 drivers/gpu/drm/nouveau/nvkm/nvfw/fw.c             |   51 +
 drivers/gpu/drm/nouveau/nvkm/nvfw/hs.c             |   62 +
 drivers/gpu/drm/nouveau/nvkm/nvfw/ls.c             |  108 +
 drivers/gpu/drm/nouveau/nvkm/subdev/Kbuild         |    2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/Kbuild     |   10 +
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c     |  411 ++
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/gm200.c    |  470 +++
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/gm20b.c    |  134 +
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/gp102.c    |  281 ++
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/gp108.c    |  111 +
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/gp10b.c    |   57 +
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c     |  180 +
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c     |  253 ++
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/priv.h     |  151 +
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/tu102.c    |  215 ++
 drivers/gpu/drm/nouveau/nvkm/subdev/fault/Kbuild   |    1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fault/base.c   |    3 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fault/gp100.c  |   17 +-
 .../nvkm/subdev/fault/gp10b.c}                     |   46 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fault/gv100.c  |    1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fault/priv.h   |   10 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fault/tu102.c  |    1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/base.c      |   38 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gp102.c     |   97 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gv100.c     |    9 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/priv.h      |   10 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf100.c  |    2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf108.c  |    2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c  |    2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgm107.c  |    2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgm200.c  |    2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp100.c  |    2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/Kbuild     |    1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/base.c     |   59 +
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/gv100.c    |   53 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/priv.h     |   15 +
 drivers/gpu/drm/nouveau/nvkm/subdev/ltc/Kbuild     |    1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/ltc/gp10b.c    |   65 +
 drivers/gpu/drm/nouveau/nvkm/subdev/ltc/priv.h     |    2 +
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/gf100.c    |    3 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/gm200.c    |    3 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/nv50.c     |    3 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/priv.h     |    8 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/tu102.c    |   16 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/ummu.c     |    7 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgf100.c |    6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c |    6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmnv50.c  |    6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/Kbuild     |    1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c     |   53 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gf100.c    |   15 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gf119.c    |    9 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gk104.c    |    9 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gk110.c    |    9 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gk208.c    |    9 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gk20a.c    |   21 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gm107.c    |    9 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gm20b.c    |  216 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gp100.c    |    9 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gp102.c    |    9 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gp10b.c    |  101 +
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gt215.c    |   27 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/priv.h     |   33 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/Kbuild |   17 -
 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr.c  |   54 -
 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr.h  |   70 -
 .../gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c | 1241 ------
 .../gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.h |  167 -
 .../gpu/drm/nouveau/nvkm/subdev/secboot/acr_r361.c |  229 --
 .../gpu/drm/nouveau/nvkm/subdev/secboot/acr_r361.h |   71 -
 .../gpu/drm/nouveau/nvkm/subdev/secboot/acr_r364.c |  117 -
 .../gpu/drm/nouveau/nvkm/subdev/secboot/acr_r367.c |  418 --
 .../gpu/drm/nouveau/nvkm/subdev/secboot/acr_r370.c |  168 -
 .../gpu/drm/nouveau/nvkm/subdev/secboot/acr_r370.h |   50 -
 .../gpu/drm/nouveau/nvkm/subdev/secboot/acr_r375.c |   94 -
 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/base.c |  213 --
 .../gpu/drm/nouveau/nvkm/subdev/secboot/gm200.c    |  262 --
 .../gpu/drm/nouveau/nvkm/subdev/secboot/gm200.h    |   46 -
 .../gpu/drm/nouveau/nvkm/subdev/secboot/gm20b.c    |  148 -
 .../gpu/drm/nouveau/nvkm/subdev/secboot/gp102.c    |  264 --
 .../gpu/drm/nouveau/nvkm/subdev/secboot/gp108.c    |   88 -
 .../gpu/drm/nouveau/nvkm/subdev/secboot/gp10b.c    |   95 -
 .../gpu/drm/nouveau/nvkm/subdev/secboot/hs_ucode.c |   97 -
 .../gpu/drm/nouveau/nvkm/subdev/secboot/hs_ucode.h |   81 -
 .../gpu/drm/nouveau/nvkm/subdev/secboot/ls_ucode.h |  161 -
 .../drm/nouveau/nvkm/subdev/secboot/ls_ucode_gr.c  |  160 -
 .../nvkm/subdev/secboot/ls_ucode_msgqueue.c        |  177 -
 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/priv.h |   65 -
 drivers/gpu/drm/omapdrm/displays/Kconfig           |    6 +-
 drivers/gpu/drm/omapdrm/dss/Kconfig                |   12 +-
 drivers/gpu/drm/omapdrm/dss/dispc.c                |    3 +-
 drivers/gpu/drm/omapdrm/omap_connector.c           |    3 +-
 drivers/gpu/drm/omapdrm/omap_drv.c                 |    4 +-
 drivers/gpu/drm/omapdrm/omap_encoder.c             |    3 +-
 drivers/gpu/drm/omapdrm/omap_fbdev.c               |    2 +-
 drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c          |   21 -
 drivers/gpu/drm/panel/Kconfig                      |   43 +
 drivers/gpu/drm/panel/Makefile                     |    4 +
 drivers/gpu/drm/panel/panel-arm-versatile.c        |    6 +-
 drivers/gpu/drm/panel/panel-boe-himax8279d.c       |  978 +++++
 .../gpu/drm/panel/panel-feiyang-fy07024di26a30d.c  |   16 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c       |   19 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c      |   29 +-
 drivers/gpu/drm/panel/panel-innolux-p079zca.c      |   45 +-
 drivers/gpu/drm/panel/panel-jdi-lt070me05000.c     |   11 +-
 drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c |   43 +-
 drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c |  531 +++
 drivers/gpu/drm/panel/panel-lg-lb035q02.c          |    6 +-
 drivers/gpu/drm/panel/panel-lg-lg4573.c            |   14 +-
 drivers/gpu/drm/panel/panel-lvds.c                 |   46 +-
 drivers/gpu/drm/panel/panel-nec-nl8048hl11.c       |    6 +-
 drivers/gpu/drm/panel/panel-novatek-nt39016.c      |    6 +-
 drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c |   29 +-
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c   |   11 +-
 drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c |   37 +-
 .../gpu/drm/panel/panel-panasonic-vvx10f034n00.c   |   62 +-
 .../gpu/drm/panel/panel-raspberrypi-touchscreen.c  |   11 +-
 drivers/gpu/drm/panel/panel-raydium-rm67191.c      |    8 +-
 drivers/gpu/drm/panel/panel-raydium-rm68200.c      |   26 +-
 drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c |   35 +-
 drivers/gpu/drm/panel/panel-ronbo-rb070d30.c       |   31 +-
 drivers/gpu/drm/panel/panel-samsung-ld9040.c       |    4 +-
 drivers/gpu/drm/panel/panel-samsung-s6d16d0.c      |    6 +-
 drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c      |    6 +-
 drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c   |    6 +-
 drivers/gpu/drm/panel/panel-samsung-s6e63m0.c      |    6 +-
 drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c      |    4 +-
 drivers/gpu/drm/panel/panel-seiko-43wvf1g.c        |   54 +-
 drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c    |   34 +-
 drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c    |    6 +-
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c    |   37 +-
 drivers/gpu/drm/panel/panel-simple.c               |  225 +-
 drivers/gpu/drm/panel/panel-sitronix-st7701.c      |   23 +-
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c     |   49 +-
 drivers/gpu/drm/panel/panel-sony-acx424akp.c       |  550 +++
 drivers/gpu/drm/panel/panel-sony-acx565akm.c       |    6 +-
 drivers/gpu/drm/panel/panel-tpo-td028ttec1.c       |   20 +-
 drivers/gpu/drm/panel/panel-tpo-td043mtea1.c       |    6 +-
 drivers/gpu/drm/panel/panel-tpo-tpg110.c           |   26 +-
 drivers/gpu/drm/panel/panel-truly-nt35597.c        |    4 +-
 drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c   |  398 ++
 drivers/gpu/drm/panfrost/panfrost_devfreq.c        |   32 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c            |    6 +-
 drivers/gpu/drm/panfrost/panfrost_job.c            |    8 +-
 drivers/gpu/drm/pl111/pl111_drv.c                  |    2 +-
 drivers/gpu/drm/qxl/qxl_kms.c                      |    2 +-
 drivers/gpu/drm/r128/Makefile                      |    2 +-
 drivers/gpu/drm/{ =3D> r128}/ati_pcigart.c           |    5 +-
 .../drm =3D> drivers/gpu/drm/r128}/ati_pcigart.h     |    0
 drivers/gpu/drm/r128/r128_drv.c                    |    2 +-
 drivers/gpu/drm/r128/r128_drv.h                    |    3 +-
 drivers/gpu/drm/radeon/atom.h                      |    1 +
 drivers/gpu/drm/radeon/atombios_crtc.c             |    3 +-
 drivers/gpu/drm/radeon/atombios_dp.c               |    6 +-
 drivers/gpu/drm/radeon/atombios_encoders.c         |   11 +-
 drivers/gpu/drm/radeon/atombios_i2c.c              |    5 -
 drivers/gpu/drm/radeon/btc_dpm.c                   |    3 +-
 drivers/gpu/drm/radeon/ci_dpm.c                    |    3 +-
 drivers/gpu/drm/radeon/cik.c                       |    8 +-
 drivers/gpu/drm/radeon/cik_sdma.c                  |    2 +-
 drivers/gpu/drm/radeon/cypress_dpm.c               |    2 +-
 drivers/gpu/drm/radeon/evergreen.c                 |    4 +-
 drivers/gpu/drm/radeon/kv_dpm.c                    |    3 +-
 drivers/gpu/drm/radeon/ni.c                        |    8 +-
 drivers/gpu/drm/radeon/ni_dpm.c                    |    3 +-
 drivers/gpu/drm/radeon/r100.c                      |   16 +-
 drivers/gpu/drm/radeon/r300.c                      |    2 +-
 drivers/gpu/drm/radeon/r420.c                      |    2 +-
 drivers/gpu/drm/radeon/r600.c                      |   10 +-
 drivers/gpu/drm/radeon/r600_cs.c                   |    8 +-
 drivers/gpu/drm/radeon/radeon_agp.c                |    3 +-
 drivers/gpu/drm/radeon/radeon_asic.c               |    2 +-
 drivers/gpu/drm/radeon/radeon_atombios.c           |   18 +-
 drivers/gpu/drm/radeon/radeon_audio.c              |    2 +-
 drivers/gpu/drm/radeon/radeon_bios.c               |   16 +-
 drivers/gpu/drm/radeon/radeon_clocks.c             |    3 +-
 drivers/gpu/drm/radeon/radeon_combios.c            |    6 +-
 drivers/gpu/drm/radeon/radeon_connectors.c         |  149 +-
 drivers/gpu/drm/radeon/radeon_cs.c                 |    2 +-
 drivers/gpu/drm/radeon/radeon_device.c             |    2 +-
 drivers/gpu/drm/radeon/radeon_display.c            |    8 +-
 drivers/gpu/drm/radeon/radeon_dp_mst.c             |    2 +-
 drivers/gpu/drm/radeon/radeon_encoders.c           |    3 +-
 drivers/gpu/drm/radeon/radeon_fb.c                 |    4 +-
 drivers/gpu/drm/radeon/radeon_gart.c               |    2 +-
 drivers/gpu/drm/radeon/radeon_gem.c                |    3 +-
 drivers/gpu/drm/radeon/radeon_i2c.c                |    2 +-
 drivers/gpu/drm/radeon/radeon_irq_kms.c            |    2 +-
 drivers/gpu/drm/radeon/radeon_kms.c                |    2 +-
 drivers/gpu/drm/radeon/radeon_legacy_encoders.c    |    6 +-
 drivers/gpu/drm/radeon/radeon_legacy_tv.c          |    8 +-
 drivers/gpu/drm/radeon/radeon_pm.c                 |    4 +-
 drivers/gpu/drm/radeon/radeon_ttm.c                |   31 +-
 drivers/gpu/drm/radeon/radeon_vce.c                |    4 +-
 drivers/gpu/drm/radeon/radeon_vm.c                 |   16 +-
 drivers/gpu/drm/radeon/rs600.c                     |    2 +-
 drivers/gpu/drm/radeon/rs690.c                     |    2 +-
 drivers/gpu/drm/radeon/rs780_dpm.c                 |    3 +-
 drivers/gpu/drm/radeon/rv770.c                     |    4 +-
 drivers/gpu/drm/radeon/si.c                        |    8 +-
 drivers/gpu/drm/radeon/si_dpm.c                    |    8 +-
 drivers/gpu/drm/radeon/trinity_dpm.c               |    3 +-
 drivers/gpu/drm/rcar-du/Kconfig                    |    8 +
 drivers/gpu/drm/rcar-du/Makefile                   |    1 +
 drivers/gpu/drm/rcar-du/rcar_cmm.c                 |  217 ++
 drivers/gpu/drm/rcar-du/rcar_cmm.h                 |   58 +
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c             |   81 +-
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h             |    2 +
 drivers/gpu/drm/rcar-du/rcar_du_drv.c              |    6 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.h              |    2 +
 drivers/gpu/drm/rcar-du/rcar_du_group.c            |   10 +
 drivers/gpu/drm/rcar-du/rcar_du_group.h            |    2 +
 drivers/gpu/drm/rcar-du/rcar_du_kms.c              |   93 +-
 drivers/gpu/drm/rcar-du/rcar_du_regs.h             |    5 +
 drivers/gpu/drm/rcar-du/rcar_lvds.c                |  320 +-
 drivers/gpu/drm/rockchip/Kconfig                   |    9 +-
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c    |  175 +-
 drivers/gpu/drm/rockchip/inno_hdmi.c               |    6 +-
 drivers/gpu/drm/rockchip/rk3066_hdmi.c             |   10 +-
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c         |   54 +-
 drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c      |    2 +-
 drivers/gpu/drm/rockchip/rockchip_lvds.c           |  488 ++-
 drivers/gpu/drm/rockchip/rockchip_lvds.h           |   19 +-
 drivers/gpu/drm/savage/savage_drv.c                |    2 +-
 drivers/gpu/drm/scheduler/sched_entity.c           |   89 +-
 drivers/gpu/drm/scheduler/sched_main.c             |   33 +-
 drivers/gpu/drm/selftests/Makefile                 |    3 +-
 drivers/gpu/drm/selftests/drm_cmdline_selftests.h  |    5 +
 drivers/gpu/drm/selftests/drm_modeset_selftests.h  |    4 +
 .../gpu/drm/selftests/test-drm_cmdline_parser.c    |  122 +
 drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c |   12 +-
 .../gpu/drm/selftests/test-drm_modeset_common.h    |    7 +
 drivers/gpu/drm/selftests/test-drm_rect.c          |  223 ++
 drivers/gpu/drm/sis/sis_drv.c                      |    2 +-
 drivers/gpu/drm/sti/sti_dvo.c                      |    2 +-
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c              |   13 +
 drivers/gpu/drm/stm/ltdc.c                         |   24 +-
 drivers/gpu/drm/sun4i/Kconfig                      |   16 +-
 drivers/gpu/drm/sun4i/sun4i_backend.c              |    9 +
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |   22 +
 drivers/gpu/drm/sun4i/sun4i_layer.c                |    4 +-
 drivers/gpu/drm/sun4i/sun4i_lvds.c                 |    2 +-
 drivers/gpu/drm/sun4i/sun4i_rgb.c                  |    2 +-
 drivers/gpu/drm/sun4i/sun6i_drc.c                  |    8 +
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c             |   49 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.c                |    8 +-
 drivers/gpu/drm/tdfx/tdfx_drv.c                    |    2 +-
 drivers/gpu/drm/tegra/dc.c                         |  147 +-
 drivers/gpu/drm/tegra/dpaux.c                      |    2 +-
 drivers/gpu/drm/tegra/drm.c                        |    4 +-
 drivers/gpu/drm/tegra/drm.h                        |    2 +
 drivers/gpu/drm/tegra/dsi.c                        |  177 +-
 drivers/gpu/drm/tegra/fb.c                         |    2 +-
 drivers/gpu/drm/tegra/gem.c                        |   40 -
 drivers/gpu/drm/tegra/gr2d.c                       |    4 +-
 drivers/gpu/drm/tegra/gr3d.c                       |    4 +-
 drivers/gpu/drm/tegra/hdmi.c                       |  125 +-
 drivers/gpu/drm/tegra/hub.c                        |  198 +-
 drivers/gpu/drm/tegra/hub.h                        |    2 +-
 drivers/gpu/drm/tegra/output.c                     |   18 +-
 drivers/gpu/drm/tegra/sor.c                        |  170 +-
 drivers/gpu/drm/tegra/vic.c                        |    8 +-
 drivers/gpu/drm/tilcdc/Makefile                    |    1 -
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                |   11 +-
 drivers/gpu/drm/tilcdc/tilcdc_tfp410.c             |  379 --
 drivers/gpu/drm/tilcdc/tilcdc_tfp410.h             |   15 -
 drivers/gpu/drm/tiny/st7586.c                      |    2 +-
 drivers/gpu/drm/ttm/ttm_bo.c                       |   36 -
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |    1 -
 drivers/gpu/drm/ttm/ttm_bo_vm.c                    |   27 +-
 drivers/gpu/drm/ttm/ttm_tt.c                       |    5 +-
 drivers/gpu/drm/tve200/tve200_drv.c                |    2 +-
 drivers/gpu/drm/udl/Kconfig                        |    6 +-
 drivers/gpu/drm/udl/Makefile                       |    2 +-
 drivers/gpu/drm/udl/udl_connector.c                |   21 +-
 drivers/gpu/drm/udl/udl_dmabuf.c                   |  255 --
 drivers/gpu/drm/udl/udl_drv.c                      |   47 +-
 drivers/gpu/drm/udl/udl_drv.h                      |   85 +-
 drivers/gpu/drm/udl/udl_encoder.c                  |   70 -
 drivers/gpu/drm/udl/udl_fb.c                       |  527 ---
 drivers/gpu/drm/udl/udl_gem.c                      |  253 +-
 drivers/gpu/drm/udl/udl_main.c                     |    9 -
 drivers/gpu/drm/udl/udl_modeset.c                  |  378 +-
 drivers/gpu/drm/udl/udl_transfer.c                 |   12 +-
 drivers/gpu/drm/v3d/v3d_drv.c                      |    8 +-
 drivers/gpu/drm/vc4/Kconfig                        |    8 +-
 drivers/gpu/drm/vc4/vc4_dsi.c                      |   34 +-
 drivers/gpu/drm/vc4/vc4_gem.c                      |   11 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |   12 +-
 drivers/gpu/drm/via/via_dmablit.c                  |    2 +-
 drivers/gpu/drm/via/via_drv.c                      |    2 +-
 drivers/gpu/drm/via/via_map.c                      |    3 +-
 drivers/gpu/drm/virtio/virtgpu_display.c           |    5 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c               |    2 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h               |   30 +-
 drivers/gpu/drm/virtio/virtgpu_fence.c             |    5 +-
 drivers/gpu/drm/virtio/virtgpu_gem.c               |    4 +-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c             |   22 +-
 drivers/gpu/drm/virtio/virtgpu_plane.c             |  112 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c                |   42 +-
 drivers/gpu/drm/vkms/vkms_composer.c               |    8 +-
 drivers/gpu/drm/vkms/vkms_drv.c                    |    8 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c         |    4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |   76 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |    6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |   21 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c                 |    2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c                |   90 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_prime.c              |   33 -
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c            |   16 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c           |    4 +
 drivers/gpu/drm/xen/xen_drm_front_kms.c            |    9 +-
 drivers/gpu/drm/zte/zx_hdmi.c                      |    6 +-
 drivers/gpu/drm/zte/zx_vga.c                       |    6 +-
 drivers/gpu/host1x/bus.c                           |   79 +-
 drivers/gpu/host1x/dev.c                           |    4 +-
 drivers/gpu/host1x/job.c                           |   21 +-
 drivers/gpu/host1x/syncpt.c                        |    2 +-
 drivers/gpu/vga/Kconfig                            |    2 +-
 drivers/hid/hid-picolcd_fb.c                       |    3 +-
 .../media/common/videobuf2/videobuf2-dma-contig.c  |    8 -
 drivers/media/common/videobuf2/videobuf2-dma-sg.c  |    8 -
 drivers/media/common/videobuf2/videobuf2-vmalloc.c |    8 -
 drivers/media/pci/ivtv/ivtvfb.c                    |    3 +-
 drivers/media/platform/vivid/vivid-osd.c           |    3 +-
 drivers/mfd/intel_soc_pmic_core.c                  |   21 +-
 drivers/misc/fastrpc.c                             |    8 -
 drivers/pinctrl/core.c                             |   41 +-
 drivers/pinctrl/core.h                             |    4 -
 drivers/pinctrl/devicetree.c                       |    4 +-
 drivers/soc/mediatek/mtk-cmdq-helper.c             |  147 +-
 drivers/staging/android/ion/ion.c                  |   14 -
 drivers/tee/tee_shm.c                              |    6 -
 drivers/video/fbdev/68328fb.c                      |   14 +-
 drivers/video/fbdev/acornfb.c                      |    2 +-
 drivers/video/fbdev/amba-clcd.c                    |    2 +-
 drivers/video/fbdev/amifb.c                        |    2 +-
 drivers/video/fbdev/arcfb.c                        |    2 +-
 drivers/video/fbdev/arkfb.c                        |    2 +-
 drivers/video/fbdev/asiliantfb.c                   |    2 +-
 drivers/video/fbdev/atmel_lcdfb.c                  |    2 +-
 drivers/video/fbdev/aty/aty128fb.c                 |    2 +-
 drivers/video/fbdev/aty/atyfb.h                    |    2 +-
 drivers/video/fbdev/aty/atyfb_base.c               |    6 +-
 drivers/video/fbdev/aty/mach64_cursor.c            |    4 +-
 drivers/video/fbdev/aty/radeon_base.c              |    2 +-
 drivers/video/fbdev/au1100fb.c                     |    2 +-
 drivers/video/fbdev/au1200fb.c                     |    2 +-
 drivers/video/fbdev/broadsheetfb.c                 |    2 +-
 drivers/video/fbdev/bw2.c                          |    2 +-
 drivers/video/fbdev/carminefb.c                    |    2 +-
 drivers/video/fbdev/cg14.c                         |    2 +-
 drivers/video/fbdev/cg3.c                          |    2 +-
 drivers/video/fbdev/cg6.c                          |    2 +-
 drivers/video/fbdev/chipsfb.c                      |    2 +-
 drivers/video/fbdev/cirrusfb.c                     |    2 +-
 drivers/video/fbdev/clps711x-fb.c                  |    2 +-
 drivers/video/fbdev/cobalt_lcdfb.c                 |    2 +-
 drivers/video/fbdev/controlfb.c                    |    2 +-
 drivers/video/fbdev/core/fb_defio.c                |    3 -
 drivers/video/fbdev/core/fbcon.c                   |    7 +
 drivers/video/fbdev/core/fbmem.c                   |   35 +-
 drivers/video/fbdev/cyber2000fb.c                  |    2 +-
 drivers/video/fbdev/da8xx-fb.c                     |    2 +-
 drivers/video/fbdev/dnfb.c                         |    2 +-
 drivers/video/fbdev/efifb.c                        |    2 +-
 drivers/video/fbdev/ep93xx-fb.c                    |    2 +-
 drivers/video/fbdev/fb-puv3.c                      |    2 +-
 drivers/video/fbdev/ffb.c                          |    2 +-
 drivers/video/fbdev/fm2fb.c                        |    2 +-
 drivers/video/fbdev/fsl-diu-fb.c                   |    4 +-
 drivers/video/fbdev/g364fb.c                       |    2 +-
 drivers/video/fbdev/gbefb.c                        |    2 +-
 drivers/video/fbdev/geode/gx1fb_core.c             |    2 +-
 drivers/video/fbdev/geode/gxfb_core.c              |    2 +-
 drivers/video/fbdev/geode/lxfb_core.c              |    2 +-
 drivers/video/fbdev/goldfishfb.c                   |    2 +-
 drivers/video/fbdev/grvga.c                        |    2 +-
 drivers/video/fbdev/gxt4500.c                      |    2 +-
 drivers/video/fbdev/hecubafb.c                     |    2 +-
 drivers/video/fbdev/hgafb.c                        |    2 +-
 drivers/video/fbdev/hitfb.c                        |    2 +-
 drivers/video/fbdev/hpfb.c                         |    2 +-
 drivers/video/fbdev/hyperv_fb.c                    |    2 +-
 drivers/video/fbdev/i740fb.c                       |    2 +-
 drivers/video/fbdev/imsttfb.c                      |    2 +-
 drivers/video/fbdev/imxfb.c                        |    2 +-
 drivers/video/fbdev/intelfb/intelfb.h              |    2 +-
 drivers/video/fbdev/intelfb/intelfbdrv.c           |    2 +-
 drivers/video/fbdev/kyro/fbdev.c                   |    2 +-
 drivers/video/fbdev/leo.c                          |    2 +-
 drivers/video/fbdev/macfb.c                        |    2 +-
 drivers/video/fbdev/matrox/matroxfb_crtc2.c        |    2 +-
 drivers/video/fbdev/matrox/matroxfb_misc.c         |    5 +-
 drivers/video/fbdev/maxinefb.c                     |    2 +-
 drivers/video/fbdev/mb862xx/mb862xxfb.h            |    2 +-
 drivers/video/fbdev/mb862xx/mb862xxfb_accel.c      |   15 +-
 drivers/video/fbdev/mb862xx/mb862xxfbdrv.c         |    4 +-
 drivers/video/fbdev/mbx/mbxfb.c                    |    2 +-
 drivers/video/fbdev/metronomefb.c                  |    2 +-
 drivers/video/fbdev/mmp/Kconfig                    |    2 +-
 drivers/video/fbdev/mmp/fb/Kconfig                 |    4 -
 drivers/video/fbdev/mmp/fb/mmpfb.c                 |    4 +-
 drivers/video/fbdev/mmp/hw/Kconfig                 |    7 +-
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c              |   58 +-
 drivers/video/fbdev/mmp/hw/mmp_ctrl.h              |   10 +-
 drivers/video/fbdev/mmp/hw/mmp_spi.c               |    6 +-
 drivers/video/fbdev/mx3fb.c                        |    5 +-
 drivers/video/fbdev/neofb.c                        |    2 +-
 drivers/video/fbdev/nvidia/nvidia.c                |   20 +-
 drivers/video/fbdev/ocfb.c                         |   11 +-
 drivers/video/fbdev/offb.c                         |    2 +-
 drivers/video/fbdev/omap/omapfb_main.c             |    2 +-
 drivers/video/fbdev/omap2/omapfb/dss/dispc.c       |    6 +-
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c     |    2 +-
 drivers/video/fbdev/omap2/omapfb/vrfb.c            |    4 +-
 drivers/video/fbdev/p9100.c                        |    2 +-
 drivers/video/fbdev/platinumfb.c                   |    2 +-
 drivers/video/fbdev/pm2fb.c                        |    2 +-
 drivers/video/fbdev/pm3fb.c                        |    2 +-
 drivers/video/fbdev/pmag-aa-fb.c                   |    2 +-
 drivers/video/fbdev/pmag-ba-fb.c                   |    2 +-
 drivers/video/fbdev/pmagb-b-fb.c                   |    2 +-
 drivers/video/fbdev/ps3fb.c                        |    2 +-
 drivers/video/fbdev/pvr2fb.c                       |    2 +-
 drivers/video/fbdev/pxa168fb.c                     |    8 +-
 drivers/video/fbdev/pxafb.c                        |   14 +-
 drivers/video/fbdev/q40fb.c                        |    2 +-
 drivers/video/fbdev/riva/fbdev.c                   |    2 +-
 drivers/video/fbdev/s3c-fb.c                       |    5 +-
 drivers/video/fbdev/s3c2410fb.c                    |    2 +-
 drivers/video/fbdev/s3fb.c                         |    2 +-
 drivers/video/fbdev/sa1100fb.c                     |    6 +-
 drivers/video/fbdev/savage/savagefb_driver.c       |    2 +-
 drivers/video/fbdev/sh7760fb.c                     |    2 +-
 drivers/video/fbdev/sh_mobile_lcdcfb.c             |    4 +-
 drivers/video/fbdev/simplefb.c                     |    2 +-
 drivers/video/fbdev/sis/sis_main.c                 |    2 +-
 drivers/video/fbdev/skeletonfb.c                   |    2 +-
 drivers/video/fbdev/sm712fb.c                      |    2 +-
 drivers/video/fbdev/smscufx.c                      |    3 +-
 drivers/video/fbdev/ssd1307fb.c                    |    2 +-
 drivers/video/fbdev/sstfb.c                        |    2 +-
 drivers/video/fbdev/stifb.c                        |    2 +-
 drivers/video/fbdev/sunxvr1000.c                   |    2 +-
 drivers/video/fbdev/sunxvr2500.c                   |    2 +-
 drivers/video/fbdev/sunxvr500.c                    |    2 +-
 drivers/video/fbdev/tcx.c                          |    2 +-
 drivers/video/fbdev/tdfxfb.c                       |    2 +-
 drivers/video/fbdev/tgafb.c                        |    2 +-
 drivers/video/fbdev/tmiofb.c                       |    2 +-
 drivers/video/fbdev/tridentfb.c                    |    2 +-
 drivers/video/fbdev/udlfb.c                        |    1 -
 drivers/video/fbdev/uvesafb.c                      |    4 +-
 drivers/video/fbdev/valkyriefb.c                   |    2 +-
 drivers/video/fbdev/vesafb.c                       |    6 +-
 drivers/video/fbdev/vfb.c                          |    2 +-
 drivers/video/fbdev/vga16fb.c                      |    2 +-
 drivers/video/fbdev/vt8500lcdfb.c                  |    2 +-
 drivers/video/fbdev/vt8623fb.c                     |    2 +-
 drivers/video/fbdev/w100fb.c                       |    2 +-
 drivers/video/fbdev/wm8505fb.c                     |    2 +-
 drivers/video/fbdev/xen-fbfront.c                  |    2 +-
 drivers/video/fbdev/xilinxfb.c                     |    2 +-
 drivers/xen/gntdev-dmabuf.c                        |   23 -
 include/drm/bridge/dw_mipi_dsi.h                   |    9 +
 include/drm/drm_atomic.h                           |   62 +-
 include/drm/drm_atomic_helper.h                    |    8 +-
 include/drm/drm_atomic_state_helper.h              |    6 +
 include/drm/drm_bridge.h                           |  136 +-
 include/drm/drm_color_mgmt.h                       |   25 +-
 include/drm/drm_connector.h                        |   24 +-
 include/drm/drm_dp_helper.h                        |   12 +-
 include/drm/drm_dp_mst_helper.h                    |   32 +-
 include/drm/drm_encoder.h                          |    7 +-
 include/drm/drm_fb_cma_helper.h                    |    2 +
 include/drm/drm_fb_helper.h                        |   40 -
 include/drm/drm_file.h                             |    3 +
 include/drm/drm_fourcc.h                           |    8 +-
 include/drm/drm_gem.h                              |    4 +-
 include/drm/drm_gem_vram_helper.h                  |    8 +-
 include/drm/drm_legacy.h                           |   29 +-
 include/drm/drm_mipi_dsi.h                         |    4 +
 include/drm/drm_of.h                               |   21 +
 include/drm/drm_panel.h                            |   58 +-
 include/drm/drm_pci.h                              |   19 +-
 include/drm/drm_print.h                            |  304 +-
 include/drm/drm_rect.h                             |    2 +
 include/drm/drm_scdc_helper.h                      |    6 +-
 include/drm/drm_util.h                             |    2 +-
 include/drm/gpu_scheduler.h                        |   22 +-
 include/drm/i915_pciids.h                          |   31 +-
 include/drm/task_barrier.h                         |  107 +
 include/drm/ttm/ttm_bo_api.h                       |   10 +-
 include/linux/dma-buf.h                            |   27 -
 include/linux/dma-heap.h                           |   59 +
 include/linux/fb.h                                 |    4 +-
 include/linux/host1x.h                             |   28 +-
 include/linux/lockdep.h                            |    8 +
 include/linux/mailbox/mtk-cmdq-mailbox.h           |   11 +
 include/linux/pinctrl/machine.h                    |    5 +
 include/linux/platform_data/tc35876x.h             |   11 -
 include/linux/soc/mediatek/mtk-cmdq.h              |   53 +
 include/uapi/drm/amdgpu_drm.h                      |    3 +
 include/uapi/drm/drm_fourcc.h                      |   24 +
 include/uapi/drm/exynos_drm.h                      |    2 +-
 include/uapi/drm/i915_drm.h                        |   32 +
 include/uapi/drm/nouveau_drm.h                     |    1 +
 include/uapi/drm/vmwgfx_drm.h                      |   17 +
 include/uapi/linux/dma-heap.h                      |   53 +
 include/video/mipi_display.h                       |   24 +-
 samples/vfio-mdev/mbochs.c                         |   16 -
 samples/vfio-mdev/mdpy-fb.c                        |    2 +-
 tools/testing/selftests/dmabuf-heaps/Makefile      |    6 +
 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c |  396 ++
 1688 files changed, 78209 insertions(+), 41348 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/display/allwinner,sun4i-a10-display-backe=
nd.yaml
 create mode 100644
Documentation/devicetree/bindings/display/allwinner,sun4i-a10-display-engin=
e.yaml
 create mode 100644
Documentation/devicetree/bindings/display/allwinner,sun4i-a10-display-front=
end.yaml
 create mode 100644
Documentation/devicetree/bindings/display/allwinner,sun4i-a10-hdmi.yaml
 create mode 100644
Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml
 create mode 100644
Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tv-encoder.ya=
ml
 create mode 100644
Documentation/devicetree/bindings/display/allwinner,sun6i-a31-drc.yaml
 create mode 100644
Documentation/devicetree/bindings/display/allwinner,sun8i-a83t-de2-mixer.ya=
ml
 create mode 100644
Documentation/devicetree/bindings/display/allwinner,sun8i-a83t-dw-hdmi.yaml
 create mode 100644
Documentation/devicetree/bindings/display/allwinner,sun8i-a83t-hdmi-phy.yam=
l
 create mode 100644
Documentation/devicetree/bindings/display/allwinner,sun8i-r40-tcon-top.yaml
 create mode 100644
Documentation/devicetree/bindings/display/allwinner,sun9i-a80-deu.yaml
 create mode 100644
Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
 delete mode 100644
Documentation/devicetree/bindings/display/bridge/thine,thc63lvdm83d.txt
 delete mode 100644
Documentation/devicetree/bindings/display/bridge/ti,ds90c185.txt
 create mode 100644
Documentation/devicetree/bindings/display/dsi-controller.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h=
.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/ampire,am800480r3tmqwa1h.tx=
t
 delete mode 100644
Documentation/devicetree/bindings/display/panel/giantplus,gpm940b0.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/logicpd,type28.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/panel-simple.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/sharp,ls020b1dd01d.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/sony,acx424akp.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml
 create mode 100644 Documentation/devicetree/bindings/display/renesas,cmm.y=
aml
 delete mode 100644
Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
 delete mode 100644 Documentation/devicetree/bindings/display/tilcdc/tfp410=
.txt
 create mode 100644 drivers/dma-buf/dma-heap.c
 create mode 100644 drivers/dma-buf/heaps/Kconfig
 create mode 100644 drivers/dma-buf/heaps/Makefile
 create mode 100644 drivers/dma-buf/heaps/cma_heap.c
 create mode 100644 drivers/dma-buf/heaps/heap-helpers.c
 create mode 100644 drivers/dma-buf/heaps/heap-helpers.h
 create mode 100644 drivers/dma-buf/heaps/system_heap.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
 rename drivers/gpu/drm/{nouveau/nvkm/engine/nvdec/gp102.c =3D>
amd/amdgpu/jpeg_v2_5.h} (63%)
 delete mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c
 rename drivers/gpu/drm/amd/amdkfd/{kfd_kernel_queue_v9.c =3D>
kfd_packet_manager_v9.c} (81%)
 rename drivers/gpu/drm/amd/amdkfd/{kfd_kernel_queue_vi.c =3D>
kfd_packet_manager_vi.c} (91%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/basics/dc_common.c
 rename drivers/gpu/drm/{nouveau/nvkm/subdev/secboot/acr_r367.h =3D>
amd/display/dc/basics/dc_common.h} (51%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.h
 rename drivers/gpu/drm/amd/display/dc/{calcs =3D> inc}/dcn_calc_math.h (10=
0%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private=
.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_vbios.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/inc/dmub_fw_meta.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/inc/dmub_rb.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/inc/dmub_trace_buffer.=
h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/inc/dmub_types.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_reg.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_reg.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
 create mode 100644 drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_executio=
n.c
 create mode 100644 drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transiti=
on.c
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_2_0_0_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_2_0_0_sh_mask.h
 rename drivers/gpu/drm/amd/include/asic_reg/{dcn =3D>
dpcs}/dpcs_2_1_0_offset.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{dcn =3D>
dpcs}/dpcs_2_1_0_sh_mask.h (100%)
 delete mode 100644
drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_0_offset.h
 delete mode 100644
drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_2_offs=
et.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_2_sh_m=
ask.h
 delete mode 100644 drivers/gpu/drm/bridge/analogix-anx78xx.h
 create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
 rename drivers/gpu/drm/bridge/{ =3D> analogix}/analogix-anx78xx.c (90%)
 create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.h
 create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c
 create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.h
 create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-i2c-txcommon.h
 create mode 100644 drivers/gpu/drm/bridge/lvds-codec.c
 delete mode 100644 drivers/gpu/drm/bridge/lvds-encoder.c
 delete mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
 create mode 100644 drivers/gpu/drm/i915/.gitignore
 delete mode 100644 drivers/gpu/drm/i915/display/Makefile
 delete mode 100644 drivers/gpu/drm/i915/gem/Makefile
 create mode 100644 drivers/gpu/drm/i915/gem/i915_gem_mman.h
 delete mode 100644 drivers/gpu/drm/i915/gt/Makefile
 create mode 100644 drivers/gpu/drm/i915/gt/debugfs_engines.c
 create mode 100644 drivers/gpu/drm/i915/gt/debugfs_engines.h
 create mode 100644 drivers/gpu/drm/i915/gt/debugfs_gt.c
 create mode 100644 drivers/gpu/drm/i915/gt/debugfs_gt.h
 create mode 100644 drivers/gpu/drm/i915/gt/debugfs_gt_pm.c
 create mode 100644 drivers/gpu/drm/i915/gt/debugfs_gt_pm.h
 create mode 100644 drivers/gpu/drm/i915/gt/gen6_ppgtt.c
 create mode 100644 drivers/gpu/drm/i915/gt/gen6_ppgtt.h
 create mode 100644 drivers/gpu/drm/i915/gt/gen8_ppgtt.c
 create mode 100644 drivers/gpu/drm/i915/gt/gen8_ppgtt.h
 create mode 100644 drivers/gpu/drm/i915/gt/intel_ggtt.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gtt.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gtt.h
 create mode 100644 drivers/gpu/drm/i915/gt/intel_ppgtt.c
 create mode 100644 drivers/gpu/drm/i915/gt/selftest_mocs.c
 create mode 100644 drivers/gpu/drm/i915/gt/selftest_rc6.c
 create mode 100644 drivers/gpu/drm/i915/gt/selftest_rc6.h
 delete mode 100644 drivers/gpu/drm/i915/gt/uc/Makefile
 delete mode 100644 drivers/gpu/drm/i915/gt/uc/selftest_guc.c
 create mode 100644 drivers/gpu/drm/i915/i915_vma_types.h
 delete mode 100644 drivers/gpu/drm/i915/oa/Makefile
 create mode 100644 drivers/gpu/drm/i915/selftests/i915_perf_selftests.h
 create mode 100644 drivers/gpu/drm/i915/selftests/igt_atomic.c
 create mode 100644 drivers/gpu/drm/i915/selftests/igt_mmap.c
 create mode 100644 drivers/gpu/drm/i915/selftests/igt_mmap.h
 delete mode 100644 drivers/gpu/drm/i915/selftests/mock_drm.c
 delete mode 100644 drivers/gpu/drm/mediatek/mtk_drm_fb.c
 delete mode 100644 drivers/gpu/drm/mediatek/mtk_drm_fb.h
 create mode 100644 drivers/gpu/drm/meson/meson_osd_afbcd.c
 create mode 100644 drivers/gpu/drm/meson/meson_osd_afbcd.h
 create mode 100644 drivers/gpu/drm/meson/meson_rdma.c
 create mode 100644 drivers/gpu/drm/meson/meson_rdma.h
 create mode 100644 drivers/gpu/drm/nouveau/include/nvfw/acr.h
 create mode 100644 drivers/gpu/drm/nouveau/include/nvfw/flcn.h
 create mode 100644 drivers/gpu/drm/nouveau/include/nvfw/fw.h
 create mode 100644 drivers/gpu/drm/nouveau/include/nvfw/hs.h
 create mode 100644 drivers/gpu/drm/nouveau/include/nvfw/ls.h
 create mode 100644 drivers/gpu/drm/nouveau/include/nvfw/pmu.h
 create mode 100644 drivers/gpu/drm/nouveau/include/nvfw/sec2.h
 create mode 100644 drivers/gpu/drm/nouveau/include/nvkm/core/falcon.h
 create mode 100644 drivers/gpu/drm/nouveau/include/nvkm/subdev/acr.h
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxtu102.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/gr/gp108.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c
 rename drivers/gpu/drm/nouveau/{include/nvkm/core/msgqueue.h =3D>
nvkm/engine/nvdec/gm107.c} (53%)
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/nvenc/base.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/nvenc/gm107.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/nvenc/priv.h
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/sec2/gp108.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/falcon/cmdq.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/falcon/msgq.c
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/falcon/msgqueue.c
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/falcon/msgqueue.h
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/falcon/msgqueue_0137c63d.c
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/falcon/msgqueue_0148cdec.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/falcon/qmgr.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/falcon/qmgr.h
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/nvfw/Kbuild
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/nvfw/flcn.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/nvfw/fw.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/nvfw/hs.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/nvfw/ls.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/acr/Kbuild
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/acr/gm200.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/acr/gm20b.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/acr/gp102.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/acr/gp108.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/acr/gp10b.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/acr/priv.h
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/acr/tu102.c
 rename drivers/gpu/drm/{amd/amdkfd/kfd_kernel_queue_cik.c =3D>
nouveau/nvkm/subdev/fault/gp10b.c} (55%)
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/base.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/priv.h
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/ltc/gp10b.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gp10b.c
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/Kbuild
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr.c
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr.h
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.h
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r361.c
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r361.h
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r364.c
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r367.c
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r370.c
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r370.h
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r375.c
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/base.c
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/gm200.c
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/gm200.h
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/gm20b.c
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/gp102.c
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/gp108.c
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/gp10b.c
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/hs_ucode.c
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/hs_ucode.h
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/ls_ucode.h
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/ls_ucode_gr=
.c
 delete mode 100644
drivers/gpu/drm/nouveau/nvkm/subdev/secboot/ls_ucode_msgqueue.c
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/priv.h
 create mode 100644 drivers/gpu/drm/panel/panel-boe-himax8279d.c
 create mode 100644 drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c
 create mode 100644 drivers/gpu/drm/panel/panel-sony-acx424akp.c
 create mode 100644 drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c
 rename drivers/gpu/drm/{ =3D> r128}/ati_pcigart.c (98%)
 rename {include/drm =3D> drivers/gpu/drm/r128}/ati_pcigart.h (100%)
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_cmm.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_cmm.h
 create mode 100644 drivers/gpu/drm/selftests/test-drm_rect.c
 delete mode 100644 drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
 delete mode 100644 drivers/gpu/drm/tilcdc/tilcdc_tfp410.h
 delete mode 100644 drivers/gpu/drm/udl/udl_dmabuf.c
 delete mode 100644 drivers/gpu/drm/udl/udl_encoder.c
 delete mode 100644 drivers/gpu/drm/udl/udl_fb.c
 create mode 100644 include/drm/task_barrier.h
 create mode 100644 include/linux/dma-heap.h
 delete mode 100644 include/linux/platform_data/tc35876x.h
 create mode 100644 include/uapi/linux/dma-heap.h
 create mode 100644 tools/testing/selftests/dmabuf-heaps/Makefile
 create mode 100644 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
