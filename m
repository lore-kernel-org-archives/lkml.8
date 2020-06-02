Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF53C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 06:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D2AB20734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 06:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="umbR79u5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgFBGGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 02:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgFBGGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 02:06:50 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AF2C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 23:06:48 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id f7so11535140ejq.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 23:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=M+TsHjt56FC7SRtXs6KiJPkS7X7xXJdX2debwmNdKkE=;
        b=umbR79u5lizAgKsnE3kziWUGXeYZai/o/zRLtYY3biFjILdd3H6Q5cL+wXkehjEAU9
         4ZuPAHPw54lQsHQFhJPX1F0GsxzW9qKY33PNAZw4RCDO0O9RPN2Eb32EVMz0ddMr8tvX
         MZ1qeVuLzj145+0k/dXM7Pi8HnATQ3/GMYeSGi6ato5hxvVTaNwYya94K24D5llZY/sL
         76erEoPDyWNrFP4ax7bVlmR1F+9IUAVL5EF6gh+Au1njJKHcNEL96J7fT0ZDgocxdoHr
         nKiKSWkTz9eQ2C0kImgOE+Q5O71v+XiBcRkBg3/YqjbeIkCZGmBMeytH6cGwrR9CUP3w
         IedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=M+TsHjt56FC7SRtXs6KiJPkS7X7xXJdX2debwmNdKkE=;
        b=qU/FbWIjj58zQk2Kg7F0ZMJr3XJSTsMYhKTbcwoVwHUR7rhFlj3Dkh71hO+Ka3QwqE
         6jP6fHz7r3xETWVV4/0TmpvRIdssbE41znpmW+GBecGroXWBDnfUlwfu1dBiiZXK975z
         oOA+yMjTJ/L2d6p6M/2z6L9mKH12fqXRbIW9HFIffWpToD8ur/7kPbh6MoSQayjS6dd3
         eYhtJ3rTW2pN8U/86B2700M58iPNqlfc9NqD+NyhGzzUscH9Ils+8uCz+UHTSSsoDUyF
         WM9yEQgLJFgOHPE3fydkGTUvpywGSgNTtyqQchvCMMuwaHSeGYNxaOTCaTwNg/GwVtEH
         5Snw==
X-Gm-Message-State: AOAM531xrsINgpPDyhhMN0HamyZ2GRd4UffnUxR/yq3eJkBi/486I2TY
        koWijhkvu5kCoRV6dB32zhSExIsQbfpUWptvpd8=
X-Google-Smtp-Source: ABdhPJyHqrgC4zR9GWLe70dnLgbb7/xY6wdeFb7lSpq/8SnFrKyyFczQ6ZvztOIeo/6Dn7zzeAwiEaxogdoj4lzmbbk=
X-Received: by 2002:a17:906:2507:: with SMTP id i7mr3649706ejb.419.1591078005251;
 Mon, 01 Jun 2020 23:06:45 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Tue, 2 Jun 2020 16:06:32 +1000
Message-ID: <CAPM=9txGww+omvateOTizZRV9_wLdAbq6uAz3DRa_S6bn1jQuQ@mail.gmail.com>
Subject: [git pull] drm for 5.8-rc1
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

This is the main drm pull request for 5.8-rc1.

Highlights:
Core DRM had a lot of refactoring around managed drm resources to make
drivers simpler.
Intel Tigerlake support is on by default
amdgpu now support p2p PCI buffer sharing and encrypted GPU memory

It has one mm patch to export two symbols which should have the correct ack=
s.

This tree is a bit conflicty, the i915 ones are probably the hairy
ones, but amdgpu has a bunch as well, along with smattering of others.

I've pushed a merged by me tree here, which I think gets them all
correct, but please let me know if you think different.
https://cgit.freedesktop.org/~airlied/linux/log/?h=3Ddrm-5.8-merged

I have one msm pull outstanding that will come later, it's been in
-next, but it was on an rc5 base and it needed a revert to fix an
arm32 build issue so I left it off this pull and will follow it up
later. I also have a fixes pull for nouveau but didn't think it was
necessary to push it into this.

Dave.

drm-next-2020-06-02:
drm pull for 5.8-rc1

core:
- uapi: error out EBUSY when existing master
- uapi: rework SET/DROP MASTER permission handling
- remove drm_pci.h
- drm_pci* are now legacy
- introduced managed DRM resources
- subclassing support for drm_framebuffer
- simple encoder helper
- EDID improvements
- vblank + writeback documentation improved
- drm/mm - optimise tree searches
- port drivers to use devm_drm_dev_alloc

dma-buf:
- add flag for p2p buffer support

mst:
- ACT timeout improvements
- remove drm_dp_mst_has_audio
- don't use 2nd TX slot - spec recommends against it

bridge:
- dw-hdmi various improvements
- chrontel ch7033 support
- fix stack issues with old gcc

hdmi:
- add unpack function for drm infoframe

fbdev:
- misc fbdev driver fixes

i915:
- uapi: global sseu pinning
- uapi: OA buffer polling
- uapi: remove generated perf code
- uapi: per-engine default property values in sysfs
- Tigerlake GEN12 enabled.
- Lots of gem refactoring
- Tigerlake enablement patches
- move to drm_device logging
- Icelake gamma HW readout
- push MST link retrain to hotplug work
- bandwidth atomic helpers
- ICL fixes
- RPS/GT refactoring
- Cherryview full-ppgtt support
- i915 locking guidelines documented
- require linear fb stride to be 512 multiple on gen9
- Tigerlake SAGV support

amdgpu:
- uapi: encrypted GPU memory handling
- uapi: add MEM_SYNC IB flag
- p2p dma-buf support
- export VRAM dma-bufs
- FRU chip access support
- RAS/SR-IOV updates
- Powerplay locking fixes
- VCN DPG (powergating) enablement
- GFX10 clockgating fixes
- DC fixes
- GPU reset fixes
- navi SDMA fix
- expose FP16 for modesetting
- DP 1.4 compliance fixes
- gfx10 soft recovery
- Improved Critical Thermal Faults handling
- resizable BAR on gmc10

amdkfd:
- uapi: GWS resource management
- track GPU memory per process
- report PCI domain in topology

radeon:
- safe reg list generator fixes

nouveau:
- HD audio fixes on recent systems
- vGPU detection (fail probe if we're on one, for now)
- Interlaced mode fixes (mostly avoidance on Turing, which doesn't support =
it)
- SVM improvements/fixes
- NVIDIA format modifier support
- Misc other fixes.

adv7511:
- HDMI SPDIF support

ast:
- allocate crtc state size
- fix double assignment
- fix suspend

bochs:
- drop connector register

cirrus:
- move to tiny drivers.

exynos:
- fix imported dma-buf mapping
- enable runtime PM
- fixes and cleanups

mediatek:
- DPI pin mode swap
- config mipi_tx current/impedance

lima:
- devfreq + cooling device support
- task handling improvements
- runtime PM support

pl111:
- vexpress init improvements
- fix module auto-load

rcar-du:
- DT bindings conversion to YAML
- Planes zpos sanity check and fix
- MAINTAINERS entry for LVDS panel driver

mcde:
- fix return value

mgag200:
- use managed config init

stm:
- read endpoints from DT

vboxvideo:
- use PCI managed functions
- drop WC mtrr

vkms:
- enable cursor by default

rockchip:
- afbc support

virtio:
- various cleanups

qxl:
- fix cursor notify port

hisilicon:
- 128-byte stride alignment fix

sun4i:
- improved format handling
The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936=
:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-06-02

for you to fetch changes up to 9ca1f474cea0edc14a1d7ec933e5472c0ff115d3:

  Merge tag 'amd-drm-next-5.8-2020-05-27' of
git://people.freedesktop.org/~agd5f/linux into drm-next (2020-05-28
16:10:17 +1000)

----------------------------------------------------------------
drm pull for 5.8-rc1

core:
- uapi: error out EBUSY when existing master
- uapi: rework SET/DROP MASTER permission handling
- remove drm_pci.h
- drm_pci* are now legacy
- introduced managed DRM resources
- subclassing support for drm_framebuffer
- simple encoder helper
- edid improvements
- vblank + writeback documentation improved
- drm/mm - optimise tree searches
- port drivers to use devm_drm_dev_alloc

dma-buf:
- add flag for p2p buffer support

mst:
- ACT timeout improvements
- remove drm_dp_mst_has_audio
- don't use 2nd TX slot - spec recommends against it

bridge:
- dw-hdmi various improvements
- chrontel ch7033 support
- fix stack issues with old gcc

hdmi:
- add unpack function for drm infoframe

fbdev:
- misc fbdev driver fixes

i915:
- uapi: global sseu pinning
- uapi: OA buffer polling
- uapi: remove generated perf code
- uapi: per-engine default property values in sysfs
- Tigerlake GEN12 enabled.
- Lots of gem refactoring
- Tigerlake enablement patches
- move to drm_device logging
- Icelake gamma HW readout
- push MST link retrain to hotplug work
- bandwidth atomic helpers
- ICL fixes
- RPS/GT refactoring
- Cherryview full-ppgtt support
- i915 locking guidelines documented
- require linear fb stride to be 512 multiple on gen9
- Tigerlake SAGV support

amdgpu:
- uapi: encrypted GPU memory handling
- uapi: add MEM_SYNC IB flag
- p2p dma-buf support
- export VRAM dma-bufs
- FRU chip access support
- RAS/SR-IOV updates
- Powerplay locking fixes
- VCN DPG (powergating) enablement
- GFX10 clockgating fixes
- DC fixes
- GPU reset fixes
- navi SDMA fix
- expose FP16 for modesetting
- DP 1.4 compliance fixes
- gfx10 soft recovery
- Improved Critical Thermal Faults handling
- resizable BAR on gmc10

amdkfd:
- uapi: GWS resource management
- track GPU memory per process
- report PCI domain in topology

radeon:
- safe reg list generator fixes

nouveau:
- HD audio fixes on recent systems
- vGPU detection (fail probe if we're on one, for now)
- Interlaced mode fixes (mostly avoidance on Turing, which doesn't support =
it)
- SVM improvements/fixes
- NVIDIA format modifier support
- Misc other fixes.

adv7511:
- HDMI SPDIF support

ast:
- allocate crtc state size
- fix double assignment
- fix suspend

bochs:
- drop connector register

cirrus:
- move to tiny drivers.

exynos:
- fix imported dma-buf mapping
- enable runtime PM
- fixes and cleanups

mediatek:
- DPI pin mode swap
- config mipi_tx current/impedance

lima:
- devfreq + cooling device support
- task handling improvements
- runtime PM support

pl111:
- vexpress init improvements
- fix module auto-load

rcar-du:
- DT bindings conversion to YAML
- Planes zpos sanity check and fix
- MAINTAINERS entry for LVDS panel driver

mcde:
- fix return value

mgag200:
- use managed config init

stm:
- read endpoints from DT

vboxvideo:
- use PCI managed functions
- drop WC mtrr

vkms:
- enable cursor by default

rockchip:
- afbc support

virtio:
- various cleanups

qxl:
- fix cursor notify port

hisilicon:
- 128-byte stride alignment fix

sun4i:
- improved format handling

----------------------------------------------------------------
Aaron Liu (6):
      drm/amdgpu: unify fw_write_wait for new gfx9 asics
      drm/amdgpu: expand sdma copy_buffer interface with tmz parameter
      drm/amdgpu: expand amdgpu_copy_buffer interface with tmz parameter
      drm/amdgpu: enable TMZ bit in sdma copy pkt for sdma v4
      drm/amdgpu: enable TMZ bit in sdma copy pkt for sdma v5
      drm/amdgpu: enable TMZ bit in FRAME_CONTROL for gfx10

Aaron Ma (1):
      drm/amdgpu: Fix oops when pp_funcs is unset in ACPI event

Aditya Swarup (1):
      drm/i915/tgl: Add definitions for VRR registers and bits

Adrian Ratiu (1):
      dt-bindings: display: dw_mipi_dsi.txt: convert to yaml

Aishwarya Ramakrishnan (1):
      drm/amdkfd: Fix boolreturn.cocci warnings

Alan Swanson (1):
      drm/amdgpu: resize VRAM BAR for CPU access on gfx10

Alex Deucher (25):
      drm/amdgpu/psp: dont warn on missing optional TA's
      drm/amdgpu/display: fix warning when compiling without debugfs
      drm/amdgpu/ring: add no_scheduler flag
      drm/amdgpu/kiq: add no_scheduler flag to KIQ
      drm/amdgpu/ring: simplify scheduler setup logic
      drm/amdgpu/gfx9: add gfxoff quirk
      drm/amdgpu/display: fix aux registration (v2)
      drm/amdgpu/display: give aux i2c buses more meaningful names
      drm/amdgpu: add UAPI for creating encrypted buffers
      drm/amdgpu: define the TMZ bit for the PTE
      drm/amdgpu: set TMZ bits in PTEs for secure BO (v4)
      drm/amdgpu: move CS secure flag next the structs where it's used
      drm/amdgpu: check ring type for secure IBs
      drm/amdgpu: force fbdev into vram
      drm/amdgpu: implement soft_recovery for gfx10
      drm/amdgpu: drop pm_runtime_set_active
      drm/amdgpu: fix runpm logic in amdgpu_pmops_resume
      drm/amdgpu: drop extra runtime pm handling in resume pmop
      drm/amdgpu: only set DPM_FLAG_NEVER_SKIP for legacy ATPX BOCO
      drm/amdgpu: improve error handling in pcie_bw
      drm/amdgpu: drop navi pcie bw callback
      drm/amdgpu: move discovery gfx config fetching
      drm/amdgpu: move gpu_info parsing after common early init
      drm/amdgpu: fix pm sysfs node handling (v2)
      drm/amdgpu: add apu flags (v2)

Alex Sierra (7):
      drm/amdgpu: infinite retries fix from UTLC1 RB SDMA
      drm/amdgpu: ih doorbell size of range changed for nbio v7.4
      drm/amdgpu: enable IH ring 1 and ring 2 for navi
      drm/amdgpu: call psp to program ih cntl in SR-IOV for Navi
      drm/amdgpu: reroute VMC and UMD to IH ring 1 for oss v5
      amdgpu/drm: remove psp access on navi10 for sriov
      drm/amdgpu: pass unlocked flag to params at amdgpu_vm_bo_update_mappi=
ng

Alvin Lee (2):
      drm/amd/display: Revert to old formula in set_vtg_params
      drm/amd/display: Allow PState switch in VBLANK one display VACTIVE

Anand K Mistry (1):
      drm/mediatek: Stop iterating dma addresses when sg_dma_len() =3D=3D 0

Andi Shyti (1):
      drm/i915/gt: allow setting generic data pointer

Andrey Grodzovsky (4):
      drm/amdgpu: Add AQUIRE_MEM PACKET3 fields defintion
      drm/amdgpu: Add new ring callback to insert memory sync
      drm/amdgpu: Add mem_sync implementation for all the ASICs.
      drm/amdgpu: Add a UAPI flag for user to call mem_sync

Andriy Gapon (1):
      amdgpu_acpi: add backlight control for the DC case

Andrzej Pietrasiewicz (6):
      drm/core: Allow drivers allocate a subclass of struct drm_framebuffer
      drm/core: Add drm_afbc_framebuffer and a corresponding helper
      drm/rockchip: Add support for afbc
      drm/core: Use proper debugging macro
      drm/core: Calculate bpp in afbc helper
      drm: Don't free a struct never allocated by drm_gem_fb_init()

Andy Shevchenko (5):
      video: ssd1307fb: Convert driver to use ->probe_new()
      video: ssd1307fb: Introduce temporary variable to increase readabilit=
y
      video: ssd1307fb: Make use of device properties
      video: ssd1307fb: Convert to atomic PWM API
      video: ssd1307fb: Remove redundant forward declaration

Animesh Manna (7):
      drm/amd/display: Align macro name as per DP spec
      drm/dp: get/set phy compliance pattern
      drm/i915/dp: Made intel_dp_adjust_train() non-static
      drm/i915/dp: Preparation for DP phy compliance auto test
      drm/i915/dp: Add debugfs entry for DP phy compliance
      drm/i915/dp: Register definition for DP compliance register
      drm/i915/dp: Program vswing, pre-emphasis, test-pattern

Anshuman Gupta (7):
      drm/i915: Enable non-contiguous pipe fusing
      drm/i915/edp: Ignore short pulse when panel powered off
      drm/i915: Power well id for ICL PG3
      drm/i915: Add i915_lpsp_capability debugfs
      drm/i915: Add connector dbgfs for all connectors
      drm/i915: Add i915_lpsp_status debugfs attribute
      drm/i915: Add ICL PG3 PW ID for EHL

Anthony Koo (9):
      drm/amd/display: make all backlight calls link based
      drm/amd/display: move panel power seq to new panel struct
      drm/amd/display: destroy panel on link destruct
      drm/amd/display: change from panel to panel cntl
      drm/amd/display: fix bug in the logic for panel power control
      drm/amd/display: clean up some header paths
      drm/amd/display: add addition dc type to translate to dmub fw type
      drm/amd/display: move location of dmub_srv.h file
      drm/amd/display: Add struct field for future use

Aric Cyr (14):
      drm/amd/display: 3.2.77
      drm/amd/display: 3.2.78
      drm/amd/display: 3.2.79
      drm/amd/display: 3.2.80
      drm/amd/display: Fix HDR visual confirm
      drm/amd/display: Update MPCC if requested
      drm/amd/display: 3.2.81
      drm/amd/display: 3.2.82
      drm/amd/display: Use cursor locking to prevent flip delays
      drm/amd/display: 3.2.83
      drm/amd/display: 3.2.83.1
      drm/amd/display: Mode change with same timing causing long display bl=
ank
      drm/amd/display: 3.2.84
      drm/amd/display: Fix potential integer wraparound resulting in a hang

Arnd Bergmann (4):
      fbdev: mx3fb: avoid warning about psABI change
      drm/bridge: fix stack usage warning on old gcc
      drm/amdgpu: allocate large structures dynamically
      drm/i915: avoid unused scale_user_to_hw() warning

Ashutosh Dixit (1):
      drm/i915/perf: Do not clear pollin for small user read buffers

Aurabindo Pillai (7):
      amdgpu_kms: Remove unnecessary condition check
      drm/amd/amdgpu: add prefix for pr_* prints
      drm/amd/amdgpu: add print prefix for dev_* variants
      drm/amd/amdgpu: remove hardcoded module name in prints
      drm/amd/display: DispalyPort: Write OUI only if panel supports it
      drm/amd/display: Prevent dpcd reads with passive dongles
      drm/amd/display: remove unused module/stats

Bartlomiej Zolnierkiewicz (7):
      video: fbdev: controlfb: fix sparse warning about using incorrect typ=
e
      video: fbdev: controlfb: add COMPILE_TEST support
      video: fbdev: controlfb: remove obsolete module support
      video: fbdev: controlfb: remove function prototypes part #1
      video: fbdev: controlfb: remove function prototypes part #2
      video: fbdev: controlfb: remove function prototypes part #3
      video: fbdev: controlfb: fix build for COMPILE_TEST=3Dy &&
PPC_PMAC=3Dy && PPC32=3Dn

Ben Skeggs (14):
      drm/nouveau: fix out-of-tree module build
      drm/nouveau/acr: ensure falcon providing acr functions is
bootstrapped first
      drm/nouveau/core: add nvkm_subdev_new_() for bare subdevs
      drm/nouveau/ibus: use nvkm_subdev_new_()
      drm/nouveau/gr/gk20a: move MODULE_FIRMWARE firmware definitions
      drm/nouveau: remove open-coded version of
remove_conflicting_pci_framebuffers()
      drm/nouveau/bios: move ACPI _ROM handling
      drm/nouveau/disp/gv100-: expose capabilities class
      drm/nouveau/device: use regular PRI accessors in chipset detection
      drm/nouveau/disp/nv50-: increase timeout on pio channel free() pollin=
g
      drm/nouveau/disp/hda/gt215-: pass head to nvkm_ior.hda.eld()
      drm/nouveau/disp/hda/gf119-: add HAL for programming device entry in =
SF
      drm/nouveau/disp/hda/gf119-: select HDA device entry based on bound h=
ead
      drm/nouveau/disp/hda/gv100-: NV_PDISP_SF_AUDIO_CNTRL0 register moved

Bernard Zhao (7):
      drm/amdgpu: cleanup coding style in amdkfd a bit
      drm/amdgpu: shrink critical section in
amdgpu_amdkfd_gpuvm_free_memory_of_gpu
      drm/radeon: cleanup coding style a bit
      drm/amd/amdgpu: cleanup coding style a bit
      drm/exynos: make pointer to const data const type
      drm/mediatek: Cleanup coding style in mediatek a bit
      drm/mediatek: Eliminate the magic number in array size

Bhawanpreet Lakha (5):
      drm/amd/display: remove mod_hdcp_hdcp2_get_link_encryption_status()
      drm/amd/display: Guard calls to hdcp_ta and dtm_ta
      drm/amd/display: query hdcp capability during link detect
      drm/amd/display: add HDCP caps debugfs
      drm/amd/display: Handle GPU reset for DC block

Bjorn Andersson (4):
      dt-bindings: display: simple: Add BOE NV133FHM-N61
      panel: simple: Add BOE NV133FHM-N61
      dt-bindings: display: simple: Add IVO M133NWF4 R0
      panel: simple: Add Ivo M133NWF4 R0

Bogdan Togorean (2):
      drm: bridge: adv7511: Enable SPDIF DAI
      drm: bridge: adv7511: Extend list of audio sample rates

Boyuan Zhang (1):
      drm/amdgpu: change HWIP from UVD to VCN for VCN2.5

Charlene Liu (1):
      drm/amd/display: initialize get_max_link_cap

Chen Zhou (3):
      drm/i915/gt: fix spelling mistake "undeflow" -> "underflow"
      drm/amdgpu/uvd7: remove unnecessary conversion to bool
      drm/amd/display: remove duplicate headers

ChenTao (2):
      drm/radeon: fix unsigned comparison with 0
      drm/amdgpu/navi10: fix unsigned comparison with 0

Chengming Gui (1):
      drm/amd/amdgpu: Correct gfx10's CG sequence

Chris Wilson (171):
      drm/i915/gt: Restrict gen7 w/a batch to Haswell
      drm/i915: Move GGTT fence registers under gt/
      drm/i915/gt: Pull restoration of GGTT fences underneath the GT
      drm/i915: Remove manual save/resume of fence register state
      drm/i915/gt: Allocate i915_fence_reg array
      drm/i915/gt: Restore check for invalid vma for fencing
      drm/i915/gem: Check for a closed context when looking up an engine
      drm/i915: Fix up documentation paths after file moving
      drm/i915/gt: Always reschedule the new heartbeat
      drm/i915: Prefer '%ps' for printing function symbol names
      drm/i915: Use explicit flag to mark unreachable intel_context
      drm/i915/gt: Cancel a hung context if already closed
      drm/i915/gt: Report context-is-closed prior to pinning
      drm/i915/gt: Use the correct err_unlock unwind path for a closed cont=
ext
      drm/i915/gt: Treat idling as a RPS downclock event
      drm/i915/gt: Leave rps->cur_freq on unpark
      drm/i915/gt: Mark timeline->cacheline as destroyed after rcu grace pe=
riod
      drm/i915: Avoid live-lock with i915_vma_parked()
      drm/i915/gem: Avoid gem_context->mutex for simple vma lookup
      drm/i915: Rely on direct submission to the queue
      drm/i915: Extend intel_wakeref to support delayed puts
      drm/i915/gt: Delay release of engine-pm after last retirement
      drm/i915/gt: Only delay the context barrier pm
      drm/i915/gt: Select the deepest available parking mode for rc6
      drm/i915/execlists: Drop setting sibling priority hint on virtual eng=
ines
      drm/i915/selftests: Measure the energy consumed while in RC6
      drm/i915/execlists: Pull tasklet interrupt-bh local to direct submiss=
ion
      drm/i915: Immediately execute the fenced work
      drm/i915/gt: Stage the transfer of the virtual breadcrumb
      drm/i915: Drop final few uses of drm_i915_private.engine
      drm/i915/display: Remove useless but deadly local
      drm/i915/display: Return early after MISSING_CASE for write_dp_sdp
      drm/i915: Differentiate between aliasing-ppgtt and ggtt pinning
      drm/i915/execlists: Workaround switching back to a completed context
      drm/i915/execlists: Include priority info in trace_ports
      drm/i915/selftests: Check timeout before flush and cond checks
      drm/i915: Allow for different modes of interruptible i915_active_wait
      drm/i915: Wrap i915_active in a simple kreffed struct
      drm/i915/perf: Schedule oa_config after modifying the contexts
      drm/i915/gem: Split eb_vma into its own allocation
      drm/i915/execlists: Explicitly reset both reg and context runtime
      drm/i915/execlists: Double check breadcrumb before crying foul
      drm/i915: Defer kicking the tasklet until all rescheduling is complet=
e
      drm/i915/gt: Include a few tracek for timeslicing
      drm/i915/selftests: Tidy up an error message for live_error_interrupt
      drm/i915/execlists: Pause CS flow before reset
      drm/i915/gt: Include the execlists CCID of each port in the engine du=
mp
      drm/i915/gt: Fill all the unused space in the GGTT
      drm/i915/gem: Ignore readonly failures when updating relocs
      drm/i915/gt: Align engine dump active/pending
      drm/i915/gem: Try allocating va from free space
      drm/i915/gt: Only wait for GPU activity before unbinding a GGTT fence
      drm/i915/gt: Store the fence details on the fence
      drm/i915/gt: Make fence revocation unequivocal
      drm/i915/gem: Drop cached obj->bind_count
      drm/i915/uc: Cleanup kerneldoc warnings
      drm/i915/execlists: Peek at the next submission for error interrupts
      drm/i915/gem: Utilize rcu iteration of context engines
      drm/i915/selftests: Check for has-reset before testing hostile contex=
ts
      drm/i915: Keep a per-engine request pool
      drm/i915: Avoid setting timer->expires to 0
      drm/i915: Revoke mmap before fence
      drm/i915: Check current i915_vma.pin_count status first on unbind
      drm/i915/selftests: Wait until we start timeslicing after a submit
      drm/i915/gt: Free request pool from virtual engines
      drm/i915/gem: Flush all the reloc_gpu batch
      drm/i915/gem: Take DBG_FORCE_RELOC into account prior to using reloc_=
gpu
      drm/i915: Make exclusive awaits on i915_active optional
      drm/i915: Allow asynchronous waits on the i915_active barriers
      drm/i915/gem: Wait until the context is finally retired before
releasing engines
      drm/i915/gem: Promote 'remain' to unsigned long
      drm/i915/gt: Yield the timeslice if caught waiting on a user semaphor=
e
      drm/i915/selftests: Drop vestigal timeslicing assert
      drm/i915/gt: Mark up racy read of intel_ring.head
      drm/i915/gt: Mark up racy check of breadcrumb irq enabled
      drm/i915/selftests: Take an explicit ref for rq->batch
      drm: Don't return 0 from a void drm_fbdev_generic_setup
      dma-buf: Prettify typecasts for dma-fence-chain
      dma-buf: Report signaled links inside dma-fence-chain
      dma-buf: Exercise dma-fence-chain under selftests
      drm/i915/selftests: Check for an already completed timeslice
      agp/intel: Reinforce the barrier after GTT updates
      drm/i915/selftests: Exercise basic RPS interrupt generation
      drm/i915/gt: Update PMINTRMSK holding fw
      drm/i915/gt: Scrub execlists state on resume
      drm/i915/selftests: Delay spinner before waiting for an interrupt
      drm/i915/selftests: Take the engine wakeref around __rps_up_interrupt
      drm/i915/selftests: Move gpu energy measurement into its own little l=
ib
      drm/i915/selftests: Check power consumption at min/max frequencies
      drm/i915/gem: Remove object_is_locked assertion from
unpin_from_display_plane
      drm/i915/gt: Move the late flush_submission in retire to the end
      drm/i915/selftests: Verify frequency scaling with RPS
      drm/i915/selftests: Skip energy consumption tests if not controlling =
freq
      drm/i915/selftests: Check RPS controls
      drm/i915/selftests: Split RPS frequency measurement
      drm/i915/selftests: Show the pcode frequency table on error
      drm/i915/selftests: Exercise dynamic reclocking with RPS
      drm/i915/selftests: Show the pstate limits on any failure to reset mi=
n
      drm/i915/selftests: Show the full scaling curve on failure
      drm/i915/selftests: Disable C-states when measuring RPS frequency res=
ponse
      drm/i915/gt: Poison residual state [HWSP] across resume.
      drm/i915/selftests: Unroll the CS frequency loop
      drm/i915/selftests: Disable heartbeat around RPS interrupt testing
      drm/i915/selftests: Try to detect rollback during batchbuffer preempt=
ion
      drm/i915/gem: Hold obj->vma.lock over for_each_ggtt_vma()
      drm/i915/execlists: Drop request-before-CS assertion
      drm/i915/gt: Carefully order virtual_submission_tasklet
      drm/i915/gt: Check carefully for an idle engine in wait-for-idle
      drm/i915/selftests: Add request throughput measurement to perf
      drm/i915: Only close vma we open
      drm/i915/gt: Prefer soft-rc6 over RPS DOWN_TIMEOUT
      drm/i915/gt: Trace RPS events
      drm/i915/gt: Use the RPM config register to determine clk frequencies
      drm/i915: Drop rq->ring->vma peeking from error capture
      drm/i915/execlists: Check preempt-timeout target before submit_ports
      drm/i915/gt: Check cacheline is valid before acquiring
      drm/i915/gt: Sanitize GT first
      drm/i915/gt: Fix up clock frequency
      drm/i915/selftests: Tweak the tolerance for clock ticks to 12.5%
      drm/i915/execlists: Avoid reusing the same logical CCID
      drm/i915/execlists: Track inflight CCID
      drm/i915/execlists: Verify we don't submit two identical CCIDs
      drm/i915: Avoid dereferencing a dead context
      drm/i915/gt: Keep a no-frills swappable copy of the default context s=
tate
      drm/i915/gt: Always enable busy-stats for execlists
      drm/i915/gt: Move rps.enabled/active to flags
      drm/i915/gt: Track use of RPS interrupts in flags
      drm/i915/gt: Switch to manual evaluation of RPS
      drm/i915/gt: Apply the aggressive downclocking to parking
      drm/i915/gt: Restore aggressive post-boost downclocking
      drm/i915/gt: Move the batch buffer pool from the engine to the gt
      drm/i915/pmu: Keep a reference to module while active
      drm/i915/gt: Make timeslicing an explicit engine property
      drm/i915: Implement vm_ops->access for gdb access into mmaps
      drm/i915/gem: Use chained reloc batches
      drm/i915/gem: Use a single chained reloc batches for a single execbuf
      drm/i915/gem: Try an alternate engine for relocations
      drm/i915/gt: Sanitize RPS interrupts upon resume
      drm/i915/gem: Lazily acquire the device wakeref for freeing objects
      drm/i915: Allow some leniency in PCU reads
      drm/i915/gem: Specify address type for chained reloc batches
      drm/i915/gem: Implement legacy MI_STORE_DATA_IMM
      drm/i915/display: Warn if the FBC is still writing to stolen on remov=
al
      drm/i915/selftests: Repeat the rps clock frequency measurement
      drm/i915/gt: Small tidy of gen8+ breadcrumb emission
      drm/i915/execlists: Record the active CCID from before reset
      drm/i915/gt: Stop holding onto the pinned_default_state
      drm/i915: Propagate error from completed fences
      drm/i915: Mark concurrent submissions with a weak-dependency
      drm/i915: Remove wait priority boosting
      drm/i915: Ignore submit-fences on the same timeline
      drm/i915: Pull waiting on an external dma-fence into its routine
      drm/i915/gt: Improve precision on defer_request assert
      drm/i915: Prevent using semaphores to chain up to external fences
      drm/i915: Replace the hardcoded I915_FENCE_TIMEOUT
      drm/i915/gt: Mark up the racy read of execlists->context_tag
      drm/i915: Tidy awaiting on dma-fences
      drm/i915: Emit await(batch) before MI_BB_START
      drm/i915/selftests: Always flush before unpining after writing
      drm/i915/gt: Restore Cherryview back to full-ppgtt
      drm/i915: Handle idling during i915_gem_evict_something busy loops
      drm/i915/gt: Reset execlists registers before HWSP
      dma-buf: Use atomic_fetch_add() for the context id
      drm/i915/gt: Suspend tasklets before resume sanitization
      drm/i915/gem: Remove redundant exec_fence
      drm/i915: Mark the addition of the initial-breadcrumb in the request
      drm/i915: Drop I915_RESET_TIMEOUT and friends
      drm/i915: Drop no-semaphore boosting
      drm/i915: Show per-engine default property values in sysfs
      drm/i915/selftests: Always call the provided engine->emit_init_breadc=
rumb
      drm/i915/gt: Transfer old virtual breadcrumbs to irq_worker

Christian K=C3=B6nig (21):
      drm/mm: revert "Break long searches in fragmented address spaces"
      dma-buf: add peer2peer flag
      drm/ttm: lock resv object during destruction
      drm/amdgpu: note that we can handle peer2peer DMA-buf
      drm/amdgpu: add checks if DMA-buf P2P is supported
      drm/amdgpu: add support for exporting VRAM using DMA-buf v3
      drm/amdgpu: improve amdgpu_gem_info debugfs file
      drm/amdgpu: stop disable the scheduler during HW fini
      drm/amdgpu: fix and cleanup amdgpu_gem_object_close v4
      drm/amdgpu: change how we update mmRLC_SPM_MC_CNTL
      drm/amdgpu: also add the TMZ flag to GART
      drm/amdgpu: add TMZ handling to amdgpu_move_blit
      drm/amdgpu: stop evicting encrypted BOs to swap
      drm/amdgpu: cleanup amdgpu_ttm_copy_mem_to_mem and amdgpu_map_buffer =
v2
      drm/amdgpu: add full TMZ support into amdgpu_ttm_map_buffer v2
      drm/amdgpu: fix size calculation in amdgpu_ttm_copy_mem_to_mem
      drm/amdgpu: partial revert VM sync changes
      drm/amdgpu: cleanup IB pool handling a bit
      drm/amdgpu: rename direct to immediate for VM updates
      drm/amdgpu: add new unlocked flag for PTE updates
      drm/amdgpu: use the BAR if possible in amdgpu_device_vram_access v2

Christoph Hellwig (1):
      i915/gvt: remove unused xen bits

Christophe JAILLET (2):
      video: fbdev: w100fb: Fix a potential double free.
      drm/exynos: dsi: Remove bridge node reference in error handling
path in probe function

Chuhong Yuan (3):
      fbdev: s1d13xxxfb: add missed unregister_framebuffer in remove
      video: fbdev: arcfb: add missed free_irq and fix the order of request=
_irq
      video: fbdev: vesafb: add missed release_region

Chunming Zhou (1):
      MAINTAINERS: Remove me from amdgpu maintainers

Colin Ian King (11):
      drm/amdgpu/vcn: fix spelling mistake "fimware" -> "firmware"
      drm/i915: remove redundant assignment to variable err
      drm/rockchip: fix spelling mistake "modifer" -> "modifier"
      drm/i915: remove redundant assignment to variable test_result
      drm/amd/display: remove redundant assignment to variable dp_ref_clk_k=
hz
      drm/amd/display: remove redundant assignment to variable ret
      drm/amdgpu/gmc: Use consistent variable on unlocks
      amdgpu/dc: remove redundant assignment to variable 'option'
      drm/i915/gt: fix spelling mistake "evalution" -> "evaluation"
      drm/amdgpu: remove redundant assignment to variable ret
      drm/nouveau/core/memory: remove redundant assignments to variable ret

Dale Zhao (1):
      drm/amd/display: Correct updating logic of dcn21's pipe VM flags

Dan Carpenter (2):
      drm/i915/selftests: fix error handling in __live_lrc_indirect_ctx_bb(=
)
      drm/amdgpu: off by one in amdgpu_device_attr_create_groups()
error handling

Daniel Kolesa (1):
      drm/amd/display: work around fp code being emitted outside of
DC_FP_START/END

Daniel Vetter (97):
      drm/hisilicon: Drop unused #include
      MAINTAINERS: Better regex for dma_buf|fence|resv
      mm/sl[uo]b: export __kmalloc_track(_node)_caller
      drm/i915: Don't clear drvdata in ->release
      drm: add managed resources tied to drm_device
      drm: Set final_kfree in drm_dev_alloc
      drm/mipi_dbi: Use drmm_add_final_kfree in all drivers
      drm/udl: Use drmm_add_final_kfree
      drm/qxl: Use drmm_add_final_kfree
      drm/i915: Use drmm_add_final_kfree
      drm/cirrus: Use drmm_add_final_kfree
      drm/v3d: Use drmm_add_final_kfree
      drm/tidss: Use drmm_add_final_kfree
      drm/mcde: Use drmm_add_final_kfree
      drm/vgem: Use drmm_add_final_kfree
      drm/vkms: Use drmm_add_final_kfree
      drm/repaper: Use drmm_add_final_kfree
      drm/ingenic: Use drmm_add_final_kfree
      drm/gm12u320: Use drmm_add_final_kfree
      drm/<drivers>: Use drmm_add_final_kfree
      drm: Cleanups after drmm_add_final_kfree rollout
      drm: Handle dev->unique with drmm_
      drm: Use drmm_ for drm_dev_init cleanup
      drm: manage drm_minor cleanup with drmm_
      drm: Manage drm_gem_init with drmm_
      drm: Manage drm_vblank_cleanup with drmm_
      drm: Garbage collect drm_dev_fini
      drm: Manage drm_mode_config_init with drmm_
      drm/bochs: Remove leftover drm_atomic_helper_shutdown
      drm/bochs: Drop explicit drm_mode_config_cleanup
      drm/cirrus: Drop explicit drm_mode_config_cleanup call
      drm/cirrus: Fully embrace devm_
      drm/ingenic: Drop explicit drm_mode_config_cleanup call
      drm/mcde: Drop explicit drm_mode_config_cleanup call
      drm/mcde: More devm_drm_dev_init
      drm/meson: Drop explicit drm_mode_config_cleanup call
      drm/pl111: Drop explicit drm_mode_config_cleanup call
      drm/rcar-du: Drop explicit drm_mode_config_cleanup call
      drm/rockchip: Drop explicit drm_mode_config_cleanup call
      drm/stm: Drop explicit drm_mode_config_cleanup call
      drm/shmob: Drop explicit drm_mode_config_cleanup call
      drm/mtk: Drop explicit drm_mode_config_cleanup call
      drm/tidss: Drop explicit drm_mode_config_cleanup call
      drm/gm12u320: More drmm_
      drm/gm12u320: Use devm_drm_dev_init
      drm/gm12u320: Use helpers for shutdown/suspend/resume
      drm/gm12u320: Simplify upload work
      drm/repaper: Drop explicit drm_mode_config_cleanup call
      drm/mipi-dbi: Move drm_mode_config_init into mipi library
      drm/mipi-dbi: Drop explicit drm_mode_config_cleanup call
      drm/udl: Drop explicit drm_mode_config_cleanup call
      drm/udl: drop drm_driver.release hook
      drm: Add docs for managed resources
      drm/managed: Fix off-by-one in warning
      drm/pci: Move drm_pci_alloc/free under CONFIG_DRM_LEGACY
      drm: delete drm_pci.h
      drm/device: Deprecate dev_private harder
      drm: Add devm_drm_dev_alloc macro
      drm/vboxvideo: drop DRM_MTRR_WC #define
      drm/vboxvideo: Use devm_drm_dev_alloc
      drm/vboxvideo: Stop using drm_device->dev_private
      drm/vboxvideo: use managed pci functions
      drm/vboxvideo: Use devm_gen_pool_create
      drm/v3d: Don't set drm_device->dev_private
      drm/v3d: Use devm_drm_dev_alloc
      drm/v3d: Delete v3d_dev->dev
      drm/v3d: Delete v3d_dev->pdev
      drm/udl: Use devm_drm_dev_alloc
      drm/udl: don't set drm_device->dev_private
      drm/st7735r: Use devm_drm_dev_alloc
      drm/st7586: Use devm_drm_dev_alloc
      drm/repaper: Use devm_drm_dev_alloc
      drm/mi0283qt: Use devm_drm_dev_alloc
      drm/ili9486: Use devm_drm_dev_alloc
      drm/ili9341: Use devm_drm_dev_alloc
      drm/ili9225: Use devm_drm_dev_alloc
      drm/hx8357d: Use devm_drm_dev_alloc
      drm/gm12u320: Use devm_drm_dev_alloc
      drm/gm12u320: Don't use drm_device->dev_private
      drm/tidss: Use devm_drm_dev_alloc
      drm/tidss: Don't use drm_device->dev_private
      drm/tidss: Delete tidss->saved_state
      drm/mcde: Use devm_drm_dev_alloc
      drm/mcde: Don't use drm_device->dev_private
      drm/ingenic: Use devm_drm_dev_alloc
      drm/ingenic: Don't set drm_device->dev_private
      drm/komeda: use devm_drm_dev_alloc
      drm/cirrus: Use devm_drm_dev_alloc
      drm/cirrus: Don't use drm_device->dev_private
      drm/cirrus: Move to drm/tiny
      drm/aspeed: Drop aspeed_gfx->fbdev
      drm/aspeed: Use devm_drm_dev_alloc
      drm/ast: Drop explicit connector register/unregister
      drm/bochs: Remove explicit drm_connector_register
      drm/qxl: Use devm_drm_dev_alloc
      drm/qxl: Don't use drm_device->dev_private
      drm/i915: Use devm_drm_dev_alloc

Daniele Ceraolo Spurio (5):
      drm/i915/guc: drop stage_pool debugfs
      drm/i915/huc: make "support huc" reflect HW capabilities
      drm/i915/debugfs: move uC printers and update debugfs file names
      drm/i915/uc: Move uC debugfs to its own folder under GT
      drm/i915/uc: do not free err log on uc_fini

Dave Airlie (19):
      Merge tag 'drm-intel-next-2020-04-17' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'drm-misc-next-2020-04-14' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-misc-next-2020-04-23' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'amd-drm-next-5.8-2020-04-24' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'amd-drm-next-5.8-2020-04-30' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'drm-misc-next-2020-05-07' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-intel-next-2020-04-30' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'amd-drm-next-5.8-2020-05-12' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'du-next-20200514' of
git://linuxtv.org/pinchartl/media into drm-next
      Merge tag 'drm-misc-next-2020-05-14' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'amd-drm-next-5.8-2020-05-19' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'drm-intel-next-2020-05-15' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'exynos-drm-next-for-v5.8' of
git://git.kernel.org/.../daeinki/drm-exynos into drm-next
      Merge tag 'drm-intel-next-fixes-2020-05-20' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'mediatek-drm-next-5.8' of
https://git.kernel.org/.../chunkuang.hu/linux into drm-next
      Merge branch 'linux-5.8' of git://github.com/skeggsb/linux into drm-n=
ext
      drm/nouveau: use correct conflicting framebuffer API
      Merge tag 'drm-misc-next-fixes-2020-05-27' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'amd-drm-next-5.8-2020-05-27' of
git://people.freedesktop.org/~agd5f/linux into drm-next

David Lu (3):
      dt-bindings: boe, tv101wum-n16: Add compatible for boe tv105wum-nw0.
      drm/panel: support for boe,tv105wum-nw0 dsi video mode panel
      drm/panel: boe-tv101wum-n16: fine tune clock

Dennis Li (2):
      drm/amdgpu: replace DRM prefix with PCI device info for gfx/mmhub
      drm/amdgpu: set error query ready after all IPs late init

Dinghao Liu (4):
      drm/nouveau/debugfs: fix runtime pm imbalance on error
      drm/nouveau: fix runtime pm imbalance on error
      drm/nouveau: fix runtime pm imbalance on error
      drm/nouveau/dispnv50: fix runtime pm imbalance on error

Dmytro Laktyushkin (7):
      drm/amd/display: fix dml pipe merge logic
      drm/amd/display: fix stream setting for diags on silicon
      drm/amd/display: fix virtual signal dsc setup
      drm/amd/display: check if REFCLK_CNTL register is present
      drm/amd/display: fix rn soc bb update
      drm/amd/display: fix and simplify pipe split logic
      drm/amd/display: correct rn NUM_VMID

Douglas Anderson (5):
      panel: simple: Fix size and bpp of BOE NV133FHM-N61
      dt-bindings: display: simple: Add BOE NV133FHM-N62
      panel: simple: Add BOE NV133FHM-N62
      dt-bindings: display: Add hpd-gpios to panel-common bindings
      drm/panel-simple: Support hpd-gpios for delaying prepare()

Emil Velikov (3):
      drm: rework SET_MASTER and DROP_MASTER perm handling
      drm: error out with EBUSY when device has existing master
      drm/exynos-vidi: convert platform driver to use dev_groups

Emily Deng (4):
      drm/amdgpu: Virtual display need to support multiple ctrcs
      drm/amdgpu: Add 4k resolution for virtual display
      drm/amdgpu: Ignore the not supported error from psp
      drm/amdgpu: No need support vcn decode

Emmanuel Vadot (1):
      drm/client: Dual licence the header in GPL-2 and MIT

Enric Balletbo i Serra (4):
      drm: panel: Set connector type for LP120UP1
      drm/bridge: ps8640: Let panel to set the connector type
      drm/bridge: panel: Return always an error pointer in
drm_panel_bridge_add()
      drm/rockchip: cdn-dp-core: Make cdn_dp_core_suspend/resume static

Eric Yang (1):
      drm/amd/display: change default pipe_split policy for DCN1

Evan Quan (34):
      drm/amdgpu: fix non-pointer dereference for non-RAS supported
      drm/amd/powerplay: avoid calling CI specific SMU message implemention
      drm/amd/powerplay: avoid calling SMU7 specific SMU message implementi=
on
      drm/amd/powerpaly: drop unused APIs
      drm/amd/powerplay: avoid calling SMU8 specific SMU message implementi=
on
      drm/amd/powerplay: avoid calling SMU9 specific SMU message implementi=
on
      drm/amd/powerplay: avoid calling SMU10 specific SMU message implement=
ion
      drm/amd/powerplay: avoid calling Vega20 specific SMU message implemen=
tion
      drm/amd/powerplay: unified interfaces for message issuing and
response checking
      drm/amd/powerplay: added mutex protection on msg issuing
      drm/amd/powerplay: error out on forcing clock setting not supported
      drm/amd/powerplay: unload mp1 for Arcturus RAS baco reset
      drm/amdgpu: fix wrong vram lost counter increment V2
      drm/amd/powerplay: revise the way to retrieve the board parameters
      drm/amd/powerplay: bump the NAVI10 smu-driver if version
      drm/amd/powerplay: correct i2c eeprom init/fini sequence
      drm/amd/powerplay: properly set the dpm_enabled state
      drm/amd/powerplay: update Arcturus smu-driver if header
      drm/amdgpu: correct fbdev suspend on gpu reset
      drm/amdgpu: correct cancel_delayed_work_sync on gpu reset
      drm/amdgpu: optimize the gpu reset for XGMI setup V2
      drm/amdgpu: code cleanup around gpu reset
      drm/amdgpu: move kfd suspend after ip_suspend_phase1
      drm/amdgpu: drop redundant cg/pg ungate on runpm enter
      drm/amdgpu: put the audio codec into suspend state before gpu reset V=
3
      drm/amdgpu: disable MGCG/MGLS also on gfx CG ungate
      drm/amdgpu: drop unnecessary cancel_delayed_work_sync on PG ungate
      drm/amd/powerplay: perform PG ungate prior to CG ungate
      drm/amdgpu: enable hibernate support on Navi1X
      drm/amd/powerplay: try to do a graceful shutdown on SW CTF
      drm/amd/powerplay: shutdown on HW CTF
      drm/amd/powerplay: report correct AC/DC event based on ctxid V2
      drm/amd/powerplay: unify the prompts on thermal interrupts
      drm/amdkfd: report the real PCI bus number

Ezequiel Garcia (1):
      drm/vkms: Hold gem object while still in-use

Fabio Estevam (2):
      dt-bindings: display: ltk500hd1829: Remove the reg property
      dt-bindings: display: xpp055c272: Remove the reg property

Felix Kuehling (4):
      drm/amdkfd: Fix comment formatting
      drm/amdgpu: Add missing parameter description in comments
      drm/amdgpu: Use GEM obj reference for KFD BOs
      drm/amdgpu: Sync with VM root BO when switching VM to CPU update mode

Gal Pressman (1):
      dma-buf: Couple of documentation typo fixes

Geert Uytterhoeven (3):
      drm/mipi-dbi: Make mipi_dbi_command_stackbuf() data parameter const
      drm: Fix misspellings of "Analog Devices"
      dt-bindings: display: renesas: du: Document optional reset properties

Guchun Chen (6):
      drm/amdgpu: add uncorrectable error count print in UMC ecc irq cb
      drm/amdgpu: refine ras related message print
      drm/amdgpu: replace DRM prefix with PCI device info for GFX RAS
      drm/amdgpu: fix kernel page fault issue by ras recovery on sGPU
      drm/amdgpu: switch to SMN interface to operate RSMU index mode
      drm/amdgpu: decouple EccErrCnt query and clear operation

Guido G=C3=BCnther (2):
      dt-bindings: display/bridge: Add binding for NWL mipi dsi host contro=
ller
      drm/bridge: Add NWL MIPI DSI host controller support

Gurchetan Singh (4):
      drm/virtio: random virtgpu_drv.h cleanups
      drm/virtio: delete notify after virtio_gpu_cmd_context_create
      drm/virtio: delete notify in virtio_gpu_object_create
      drm/virtio: make virtio_gpu_object_attach void

Gustavo A. R. Silva (2):
      drm/i915: Replace zero-length array with flexible-array
      drm/amdgpu/smu10: Replace one-element array and use struct_size() hel=
per

Gwan-gyeong Mun (18):
      drm: Add DP1.4 VSC SDP Payload related Data Structures
      drm/i915/dp: Add compute routine for DP VSC SDP
      drm/i915/dp: Add compute routine for DP HDR Metadata Infoframe SDP
      drm/i915/dp: Add writing of DP SDPs
      video/hdmi: Add Unpack only function for DRM infoframe
      drm/i915/dp: Read out DP SDPs
      drm: Add logging function for DP VSC SDP
      drm/i915: Include HDMI DRM infoframe in the crtc state dump
      drm/i915: Include DP HDR Metadata Infoframe SDP in the crtc state dum=
p
      drm/i915: Include DP VSC SDP in the crtc state dump
      drm/i915: Program DP SDPs with computed configs
      drm/i915: Add state readout for DP HDR Metadata Infoframe SDP
      drm/i915: Add state readout for DP VSC SDP
      drm/i915: Fix enabled infoframe states of lspcon
      drm/i915: Program DP SDPs on pipe updates
      drm/i915: Stop sending DP SDPs on ddi disable
      drm/i915/dp: Add compute routine for DP PSR VSC SDP
      drm/i915/psr: Use new DP VSC SDP compute routine on PSR

Haiyi Zhou (1):
      drm/amd/display: Change infopacket type programming

Hans de Goede (1):
      drm/fb-helper: Add TODO for making drm_fb_helper_alloc_fbi fill apert=
ures

Harigovindan P (3):
      dt-bindings: display: add visionox rm69299 panel variant
      dt-bindings: documenting compatible string vendor "visionox"
      drm/panel: add support for rm69299 visionox panel

Harry Wentland (4):
      drm/amd/display: Indicate use of TMZ buffers to DC
      drm/amd/display: Add DC Debug mask to disable features for bringup
      drm/amd/display: Fix disable_stutter debug option
      drm/amd/display: Respect PP_STUTTER_MODE but don't override
DC_DISABLE_STUTTER

Hawking Zhang (21):
      drm/amdgpu: remove inproper workaround for vega10
      drm/amdgpu: replace indirect mmio access in non-dc code path
      drm/amdgpu: retire indirect mmio reg support from cgs
      drm/amdgpu: retire RREG32_IDX/WREG32_IDX
      drm/amdgpu: retire AMDGPU_REGS_KIQ flag
      drm/amdgpu: support access regs outside of mmio bar
      drm/amdgpu: retire support_vmr_ring interface
      drm/amdgpu: remove unnecessary tOS version check
      drm/amdgpu: retire unused check_fw_loading status
      drm/amdgpu: add helper function to init asd ucode
      drm/amdgpu: switch to helper function to init asd ucode
      drm/amdgpu: add helper function to init sos ucode
      drm/amdgpu: switch to helper function to init sos ucode
      drm/amdgpu: retire legacy vega10 sos version check
      drm/amdgpu: re-structue members for ip discovery
      drm/amdgpu: skip reservation of discovery tmr region in pre-Navi
      drm/amdgpu: switch to common xgmi ta helpers
      drm/amdgpu: switch to common ras ta helper
      drm/amdgpu: drop unused ras ta helper function
      drm/amdgpu: switch to common rlc_autoload helper
      drm/amdgpu: use node_id and node_size to calcualte dram_base_address

Heiko Stuebner (2):
      dt-bindings: display: panel: Add binding document for Leadtek LTK050H=
3146W
      drm/panel: add panel driver for Leadtek LTK050H3146W

Huacai Chen (1):
      drm/qxl: Use correct notify port address when creating cursor ring

Huang Rui (11):
      drm/ttm: clean up ttm_trace_dma_map/ttm_trace_dma_unmap (v2)
      drm/amdgpu: add tmz feature parameter (v2)
      drm/amdgpu: add amdgpu_tmz data structure
      drm/amdgpu: add function to check tmz capability (v4)
      drm/amdgpu: add tmz bit in frame control packet
      drm/amdgpu: expand the emit tmz interface with trusted flag
      drm/amdgpu: expand the context control interface with trust flag
      drm/amdgpu: job is secure iff CS is secure (v5)
      drm/amdgpu: remove the alignment placeholder for secure buffer
      drm/amdgpu: fix the wrong logic checking when secure buffer is
created (v3)
      drm/amdgpu: Fix per-IB secure flag GFX hang

Igor Matheus Andrade Torrente (1):
      drm: Correct a typo in a function comment

Imre Deak (6):
      drm/i915/icl+: Don't enable DDI IO power on a TypeC port in TBT mode
      drm/i915: Add a retry counter for hotplug detect retries
      drm/i915: Extend hotplug detect retry on TypeC connectors to 5 second=
s
      drm/i915/icl: Fix timeout handling during TypeC AUX power well enabli=
ng
      drm/i915/tgl+: Fix interrupt handling for DP AUX transactions
      drm/i915: Fix AUX power domain toggling across TypeC mode resets

Isabel Zhang (3):
      drm/amd/display: Remove hdcp display state with mst fix
      drm/amd/display: Update stream adjust in dc_stream_adjust_vmin_vmax
      drm/amd/display: Add 4 to 1 MPC split support

Jack Zhang (4):
      drm/amdgpu/sriov add amdgpu_amdkfd_pre_reset in gpu reset
      drm/amdkfd Avoid destroy hqd when GPU is on reset
      drm/amdgpu/sriov add amdgpu_amdkfd_pre_reset in gpu reset
      drm/amdgpu fix incorrect sysfs remove behavior for xgmi

Jaehyun Chung (2):
      drm/amd/display: Update DRAM watermark before checking to update TTU
      drm/amd/display: Add HW rotation cursor changes to dcn10

Jagan Teki (3):
      dt-bindings: display: panel: Convert feiyang,fy07024di26a30d to DT sc=
hema
      dt-bindings: display: panel: Convert sitronix,st7701 to DT schema
      MAINTAINERS: Update feiyang,st7701 panel bindings converted as YAML

James Jones (4):
      drm: Generalized NV Block Linear DRM format mod
      drm/nouveau/kms: Add format mod prop to base/ovly/nvdisp
      drm/nouveau/kms: Check framebuffer size against bo
      drm/nouveau/kms: Support NVIDIA format modifiers

James Zhu (13):
      drm/amdgpu/vcn: fix race condition issue for vcn start
      drm/amdgpu/vcn: fix race condition issue for dpg unpause mode switch
      drm/amdgpu/vcn2.0: stall DPG when WPTR/RPTR reset
      drm/amdgpu/vcn2.5: stall DPG when WPTR/RPTR reset
      drm/amdgpu/vcn: Add firmware share memory support
      drm/amdgpu/vcn2.0: Add firmware w/r ptr reset sync
      drm/amdgpu/vcn2.5: Add firmware w/r ptr reset sync
      drm/amdgpu: enable VCN2.5 DPG mode for Arcturus
      drm/amdgpu/vcn: add shared memory restore after wake up from sleep.
      Revert "drm/amdgpu: Disable gfx off if VCN is busy"
      drm/amdgpu/vcn2.5: wait for tiles off after unpause
      drm/amdgpu/jpeg2.5: Remove JPEG_ENC_MASK from clock ungating
      drm/amdgpu/vcn2.5: Remove old DPG workaround

Jane Jian (1):
      drm/amd/powerplay: skip judging if baco support for Arcturus sriov

Jani Nikula (35):
      drm/i915/ddi: use struct drm_device based logging
      drm/i915/display_power: use struct drm_device based logging
      drm/i915/dp_aux_backlight: use struct drm_device based logging
      drm/i915/dp_mst: use struct drm_device based logging
      drm/i915/dsi: use struct drm_device based logging
      drm/i915/hdmi: use struct drm_device based logging
      drm/i915/dsi: use struct drm_device based logging
      drm/i915/connector: use MISSING_CASE instead of logging
      drm/i915/tv: use struct drm_device based logging
      drm/i915/display: clean up intel_PLL_is_valid()
      drm/i915/display: use struct drm_device based logging
      drm/i915/psr: use struct drm_device based logging
      drm/i915/wopcm: convert to drm device based logging
      drm/i915/audio: use struct drm_device based logging
      drm/i915/panel: use struct drm_device based logging
      drm/i915/tc: use struct drm_device based logging
      drm/i915/dp: use struct drm_device based logging
      drm/i915/crt: use struct drm_device based logging
      drm/i915/debugfs: use struct drm_device based logging
      drm/i915/bw: use struct drm_device based logging
      drm/i915/state: use struct drm_device based logging
      drm/i915/switcheroo: use struct drm_device based logging
      drm/i915/uc: prefer struct drm_device based logging
      drm/i915/error: prefer struct drm_device based logging
      drm/i915/pmu: prefer struct drm_device based logging
      drm/i915/dram: prefer struct drm_device based logging
      drm/i915/uncore: prefer struct drm_device based logging
      drm/i915/stolen: prefer struct drm_device based logging
      drm/i915/gt: prefer struct drm_device based logging
      drm/i915/uc: prefer struct drm_device based logging
      drm/i915: fix Sphinx build duplicate label warning
      drm/i915/audio: error log non-zero audio power refcount after unbind
      drm/i915/hdmi: remove unused intel_hdmi_hdcp2_protocol()
      drm/i915: drop a bunch of superfluous inlines
      drm/i915/audio: fix compressed_bpp check

Jason Yan (23):
      video: fbdev: matroxfb: remove dead code and set but not used variabl=
e
      video: fbdev: mb862xx: remove set but not used variable 'mdr'
      drm/amd/display: code clean up in dce80_hw_sequencer.c
      drm/amdgpu: remove dead code in si_dpm.c
      drm/radeon: remove defined but not used 'dte_data_tahiti_le'
      drm/radeon: remove defined but not used variables in ci_dpm.c
      video: fbdev: aty128fb: remove unused 'sdr_64'
      drm/amd/powerplay: remove defined but not used variables
      drm/amdgpu: remove conversion to bool in amdgpu_device.c
      drm/amd/display: remove conversion to bool in dcn20_mpc.c
      drm/amd/display: remove conversion to bool in dc_link_ddc.c
      drm/ast: remove duplicate assignment of ast_crtc_funcs member
      drm/amd/display: remove duplicate assignment of dcn21_funcs members
      drm/amdgpu/smu10: remove duplicate assignment of smu10_hwmgr_funcs me=
mbers
      drm/amd/display: remove unused variable 'ret' in dm_suspend()
      video: fbdev: i810: use true,false for bool variables
      video: udlfb: use true,false for bool variables
      video: uvesafb: use true,false for bool variables
      fbdev: aty: use true, false for bool variables in atyfb_base.c
      video: fbdev: valkyriefb.c: fix warning comparing pointer to 0
      drm/amd/display: remove variable "result" in
dcn20_patch_unknown_plane_state()
      video: fbdev: pxa168fb: make pxa168fb_init_mode() return void
      drm/amd/amdgpu: remove defined but not used 'crtc_offsets'

Jernej Skrabec (6):
      drm/sun4i: de2: rgb field in de2 format struct is redundant
      drm/sun4i: de2: csc_mode in de2 format struct is mostly redundant
      drm/sun4i: de2: Don't return de2_fmt_info struct
      drm/sun4i: Sort includes in VI and UI layer code
      drm/bridge: dw-hdmi: Add support for RGB limited range
      drm/bridge: dw-hdmi: rework csc related functions

Jerry (Fangzhi) Zuo (3):
      drm/amd/display: Avoid create MST prop after registration
      drm/amd/display: Check DMCU Exists Before Loading
      drm/amd/display: Add dm support for DP 1.4 Compliance edid corruption=
 test

Jiange Zhao (1):
      drm/amdgpu: Add autodump debugfs node for gpu reset v8

Jiansong Chen (1):
      drm/amd/powerplay: limit smu support to Arcturus for onevf

Jiawei (2):
      drm/amdgpu: extend compute job timeout
      drm/amdgpu: disble vblank when unloading sriov driver

Jinze Xu (2):
      drm/amd/display: Workaround to disable YCbCr
      drm/amd/display: Set/Reset avmute when disable/enable stream

Jiri Slaby (1):
      drm/virtio: fix OOB in virtio_gpu_object_create

Jitao Shi (6):
      dt-bindings: display: mediatek: control dpi pins mode to avoid leakag=
e
      drm/mediatek: set dpi pin mode to gpio low to avoid leakage current
      dt-bindings: display: mediatek: add property to control mipi tx
drive current
      dt-bindings: display: mediatek: get mipitx calibration data from nvme=
m
      drm/mediatek: add the mipitx driving control
      drm/mediatek: config mipitx impedance with calibration data

Joe Perches (1):
      drm: drm_vm: Use fallthrough;

Johan Jonker (3):
      dt-bindings: display: convert rockchip vop bindings to yaml
      dt-bindings: display: rockchip-vop: add additional properties
      dt-bindings: display: convert rockchip rk3066 hdmi bindings to yaml

John Clements (18):
      drm/amdgpu: disabled fru eeprom access
      drm/amdgpu: added xgmi ras error reset sequence
      drm/amdgpu: disable ras query and iject during gpu reset
      drm/amdgpu: resolve mGPU RAS query instability
      drm/amdgpu: update RAS related dmesg print
      drm/amdgpu: increased atom cmd timeout
      drm/amdgpu: update psp fw loading sequence
      drm/amdgpu: set mp1 state before reload
      drm/amdgpu: cache smu fw version info
      drm/amdgpu: update RAS error handling
      drm/amdgpu: update RAS TA to Host interface
      drm/amdgpu: update RAS sequence to parse TA flags
      drm/amdgpu: Fix bug in RAS invoke
      drm/amdgpu: Add cmd to control XGMI link sleep
      drm/amdgpu: Add DPM function for XGMI link power down control
      drm/amdgpu: Update RAS XGMI error inject sequence
      drm/amdgpu: Updated XGMI power down control support check
      drm/amdgpu: resolve ras recovery vs smi race condition

John Stultz (1):
      drm: kirin: Revert change to add register connect helper functions

Jonas Karlman (1):
      drm/bridge: dw-hdmi: do not force "none" scan mode

Jonathan Kim (2):
      drm/amdgpu: fix race between pstate and remote buffer map
      drm/amdgpu: sw pstate switch should only be for vega20

Joonas Lahtinen (8):
      Merge drm/drm-next into drm-intel-next-queued
      Merge tag 'topic/phy-compliance-2020-04-08' of
git://anongit.freedesktop.org/drm/drm-misc into drm-intel-next-queued
      drm/i915: Update DRIVER_DATE to 20200417
      Merge tag 'gvt-next-2020-04-22' of
https://github.com/intel/gvt-linux into drm-intel-next-queued
      drm/i915: Update DRIVER_DATE to 20200430
      Merge tag 'gvt-next-2020-05-12' of
https://github.com/intel/gvt-linux into drm-intel-next-queued
      drm/i915: Document locking guidelines
      drm/i915: Update DRIVER_DATE to 20200515

Joseph Gravenor (1):
      drm/amd/display: fix typo

Joseph Greathouse (3):
      drm/amdkfd: Put ASIC revision into HSA capability
      drm/amdkfd: Enable GWS based on FW Support
      drm/amdkfd: Enable over-subscription with >1 GWS queue

Joshua Aberback (4):
      drm/amd/display: Acknowledge wm_optimized_required
      drm/amd/display: Force watermark value propagation
      drm/amd/display: Add DML variable for future asics
      drm/amd/display: Add dummy p-state latency bounding box override

Josip Pavic (1):
      drm/amd/display: prevent loop from occuring in pipe list

Jos=C3=A9 Roberto de Souza (14):
      drm/i915/display/fbc: Make fences a nice-to-have for GEN9+
      drm/i915/dp: Return the right vswing tables
      drm/i915/dp/ehl: Update vswing table for HBR and RBR
      drm/i915/tc/icl: Update TC vswing tables
      drm/i915: Add missing deinitialization cases of load failure
      drm/i915/display: Move out code to return the digital_port of the aux=
 ch
      drm/i915/display: Add intel_legacy_aux_to_power_domain()
      drm/i915/display: Split hsw_power_well_enable() into two
      drm/i915/tc/icl: Implement TC cold sequences
      drm/i915/tc: Skip ref held check for TC legacy aux power wells
      drm/i915/tc/tgl: Implement TC cold sequences
      drm/i915/tc: Catch TC users accessing FIA registers without enable au=
x
      drm/i915/tc: Do not warn when aux power well of static TC ports timeo=
ut
      drm/i915/display: Load DP_TP_CTL/STATUS offset before use it

Jules Irenge (1):
      video: Add missing annotation for cyber2000fb_enable_ddc() and
cyber2000fb_disable_ddc()

Kai Vehmanen (2):
      drm/i915: use forced codec wake on all gen9+ platforms
      drm/i915: do AUD_FREQ_CNTRL state save on all gen9+ platforms

Kai-Heng Feng (1):
      drm/nouveau: Use generic helper to check _PR3 presence

Karol Herbst (3):
      drm/nouveau/device: rework mmio mapping code to get rid of second map
      drm/nouveau/device: detect if changing endianness failed
      drm/nouveau/device: detect vGPUs

Kenny Levinsen (1):
      drm: make drm_file use keyed wakeups

Kent Russell (9):
      drm/amdgpu: Enable reading FRU chip via I2C v3
      drm/amdgpu: Add documentation for memory info
      drm/amdgpu: Add documentation for PCIe accounting
      drm/amdgpu: Add documentation for unique_id
      drm/amdgpu: Expose TA FW version in fw_version file
      drm/amdgpu: Fix FRU data checking
      drm/amdgpu: Re-enable FRU check for most models v5
      Revert "drm/amdgpu: use the BAR if possible in
amdgpu_device_vram_access v2"
      drm/amdgpu: Disable FRU read on Arcturus

Kevin Wang (5):
      drm/amdgpu: clean up unused variable about ring lru
      drm/amdgpu: add amdgpu_virt_get_vf_mode helper function
      drm/amdgpu: optimize amdgpu device attribute code
      drm/amdgpu: cleanup unnecessary virt sriov check in amdgpu attribute
      drm/amdgpu: fix device attribute node create failed with multi gpu

Konrad Dybcio (2):
      dt-bindings: display: Document ASUS Z00T TM5P5 NT35596 panel compatib=
le
      drivers: drm: panel: Add ASUS TM5P5 NT35596 panel driver

Krunoslav Kovac (1):
      drm/amd/display: Internal refactoring to abstract color caps

Laurent Pinchart (6):
      drm: Fix wrong kfree() in managed resource usage example
      dt-bindings: display: bridge: Reject additional properties in ports n=
ode
      dt-bindings: display: bridge: Convert simple-bridge bindings to YAML
      dt-bindings: display: bridge: thc63lvd1024: Convert binding to YAML
      drm: panels: Add MAINTAINERS entry for LVDS panel driver
      drm: plane: Verify that no or all planes have a zpos property

Leo (Hanghong) Ma (1):
      drm/amd/amdgpu: Update update_config() logic

Lewis Huang (1):
      drm/amd/display: temporary clamp the vratio used to 1.0

Likun Gao (4):
      drm/amdgpu/powerplay: get SMC FW size to a flexible way
      drm/amdgpu: check SMU NULL ptr on gfx hw init
      drm/amdgpu: update the method to set kcq queue mask
      drm/amdgpu: add condition to set MP1 state on gpu reset

Linus Walleij (2):
      ARM/fbdev: sa11x0: Switch to use GPIO descriptors
      drm/tegra: Clean up GPIO includes

Lionel Landwerlin (8):
      drm/i915/perf: remove generated code
      drm/i915/perf: remove redundant power configuration register override
      drm/i915/perf: introduce global sseu pinning
      drm/i915/perf: rework aging tail workaround
      drm/i915/perf: move pollin setup to non hw specific code
      drm/i915/perf: add new open param to configure polling of OA buffer
      drm/i915/perf: don't read head/tail pointers outside critical section
      drm/i915: Peel dma-fence-chains for await

Luben Tuikov (4):
      drm/amdgpu: add UAPI to create secure commands (v3)
      drm/amdgpu: implement TMZ accessor (v3)
      drm/amdgpu: Move to a per-IB secure flag (TMZ)
      drm/amdgpu: Fine-grained TMZ support

Lubomir Rintel (3):
      dt-bindings: Add vendor prefix for Chrontel, Inc.
      dt-bindings: display: Add Chrontel CH7033 Video Encoder binding
      drm/bridge: chrontel-ch7033: Add a new driver

Lyude Paul (23):
      drm/amd/amdgpu_dm/mst: Remove useless sideband tracing
      drm/amd/dc: Kill dc_conn_log_hex_linux()
      drm/amd/amdgpu_dm/mst: Remove unneeded edid assignment when
destroying connectors
      drm/amd/amdgpu_dm/mst: Remove ->destroy_connector() callback
      drm/amd/amdgpu_dm/mst: Stop printing extra messages in
dm_dp_add_mst_connector()
      drm/dp_mst: Remove drm_dp_mst_topology_cbs.destroy_connector
      drm/dp_mst: Fix NULL deref in drm_dp_get_one_sb_msg()
      drm/dp_mst: Don't drop NAKs for down responses
      drm/i915/dp_mst: Cast intel_connector->port as drm_dp_mst_port
      drm/dp_mst: Remove drm_dp_mst_has_audio()
      drm/dp_mst: Improve kdocs for drm_dp_check_act_status()
      drm/dp_mst: Reformat drm_dp_check_act_status() a bit
      drm/dp_mst: Increase ACT retry timeout to 3s
      drm/dp_mst: Print errors on ACT timeouts
      drm/i915/dpcd_bl: Unbreak enable_dpcd_backlight modparam
      Revert "drm/dp_mst: Remove single tx msg restriction."
      drm/dp_mst: Kill the second sideband tx slot, save the world
      drm/nouveau/kms/nv50-: Initialize core channel in nouveau_display_cre=
ate()
      drm/nouveau/kms/nv50-: Probe SOR and PIOR caps for DP interlacing sup=
port
      drm/nouveau/kms/gv100-: Add support for interlaced modes
      drm/nouveau/kms/nv50-: Move 8BPC limit for MST into nv50_mstc_get_mod=
es()
      drm/nouveau/kms/nv50-: Share DP SST mode_valid() handling with MST
      drm/vblank: Fix -Wformat compile warnings on some arches

Maarten Lankhorst (1):
      Merge remote-tracking branch 'drm/drm-next' into drm-misc-next

Marek Ol=C5=A1=C3=A1k (4):
      drm/amdgpu: add tiling flags from Mesa
      drm/amdgpu: invalidate L2 before SDMA IBs (v2)
      drm/amdgpu: bump version for invalidate L2 before SDMA IBs
      drm/amdgpu: apply AMDGPU_IB_FLAG_EMIT_MEM_SYNC to compute IBs too (v3=
)

Marek Szyprowski (5):
      drm/bridge: sii9234: silence warning about regulators during
deferred probe
      drm/exynos: gem: Remove dead-code
      drm/exynos: gem: rework scatter-list contiguity check on prime import
      drm/exynos: gem: Get rid of the internal 'pages' array
      drm/exynos: mixer: Fix enabling of the runtime power management

Mario Kleiner (3):
      drm/i915/dp: Add dpcd link_rate quirk for Apple 15" MBP 2017 (v3)
      drm/amd/display: Expose support for xBGR ordered fp16 formats.
      drm/amd/display: Enable fp16 also on DCE-11.0 - DCE-12. (v2)

Mark Pearson (1):
      drm/dp: Lenovo X13 Yoga OLED panel brightness fix

Markus Elfring (3):
      drm/sun4i: tcon: Delete an error message in sun4i_tcon_init_irq()
      drm/ingenic: Delete an error message in ingenic_drm_probe()
      drm/exynos: Delete an error message in three functions

Martin Blumenstingl (1):
      drm/lima: Add optional devfreq and cooling device support

Masahiro Yamada (4):
      drm/radeon: remove unneeded header include path
      drm/radeon: fix build rules of *_reg_safe.h
      drm/radeon: use pattern rule to avoid code duplication in Makefile
      drm/radeon: align short build log

Matt Atwood (2):
      drm/i915/ehl: extended Wa_2006604312 to ehl
      drm/i915/tgl: Wa_14011059788

Matt Roper (7):
      drm/i915/tgl: Add Wa_14010477008:tgl
      drm/i915/tgl: Extend Wa_1409767108:tgl to B0 stepping
      drm/i915/tgl: Initialize multicast register steering for workarounds
      drm/i915/tgl: TBT AUX should use TC power well ops
      drm/i915: Use single set of AUX powerwell ops for gen11+
      drm/i915: Use proper fault mask in interrupt postinstall too
      drm/i915/icp: Add Wa_14010685332

Matthew Auld (3):
      drm/i915/selftests/perf: watch out for stolen objects
      drm/i915/selftests: mark huge_gem_object as not shrinkable
      drm/i915/evict: watch out for unevictable nodes

Maxime Ripard (1):
      Merge drm/drm-next into drm-misc-next

Maya Rashish (2):
      drm/dp_mst: make build_clear_payload_id_table return void
      drm/ttm: Remove reference to the mem_glob member

Melissa Wen (5):
      drm/amd/display: cleanup codestyle type BLOCK_COMMENT_STYLE on dc_lin=
k
      drm/amd/display: codestyle cleanup on dc_link file until detect_dp fu=
nc
      drm/amd/display: code cleanup on dc_link from is_same_edid to get_ddc=
_line
      drm/amd/display: code cleanup of dc_link file on func dc_link_constru=
ct
      drm/vkms: enable cursor by default

Michael J. Ruhl (1):
      drm/i915: Refactor setting dma info to a common helper

Michael Strauss (1):
      drm/amd/display: Check for null fclk voltage when parsing clock table

Michal Orzel (1):
      drm: Replace drm_modeset_lock/unlock_all with
DRM_MODESET_LOCK_ALL_* helpers

Michal Wajdeczko (2):
      drm/i915/huc: Add more errors for I915_PARAM_HUC_STATUS
      drm/i915/huc: Fix HuC register used in debugfs

Michel D=C3=A4nzer (1):
      drm/amdgpu/dc: Use WARN_ON_ONCE for ASSERT

Mika Kahola (1):
      uapi/drm/drm_fourcc.h: Note on platform specificity for format modifi=
ers

Mika Kuoppala (14):
      drm/i915: Report all failed registers for ctx isolation
      drm/i915/selftests: Add context batchbuffers registers to live_lrc_fi=
xed
      drm/i915: Make define for lrc state offset
      drm/i915: Add engine scratch register to live_lrc_fixed
      drm/i915: Add per ctx batchbuffer wa for timestamp
      drm/i915: Add live selftests for indirect ctx batchbuffers
      drm/i915: Use indirect ctx bb to mend CMD_BUF_CCTL
      Revert "drm/i915/tgl: Include ro parts of l3 to invalidate"
      drm/i915/gen12: Fix HDC pipeline flush
      drm/i915/gen12: Flush L3
      drm/i915/gen12: Invalidate aux table entries forcibly
      drm/i915/gen12: Add aux table invalidate for all engines
      drm/i915: Make intel_timeline_init static
      drm/i915/gt: Force pte cacheline to main memory

Monk Liu (19):
      drm/amdgpu: purge ip_discovery headers
      drm/amdgpu: amends feature bits for MM bandwidth mgr
      drm/amdgpu: cleanup all virtualization detection routine
      drm/amdgpu: cleanup idh event/req for NV headers
      drm/amdgpu: introduce new idh_request/event enum
      drm/amdgpu: introduce new request and its function
      drm/amdgpu: use static mmio offset for NV mailbox
      drm/amdgpu: equip new req_init_data handshake
      drm/amdgpu: adjust sequence of ip_discovery init and timeout_setting
      drm/amdgpu: postpone entering fullaccess mode
      drm/amdgpu: ignore TA ucode for SRIOV
      drm/amdgpu: skip cg/pg set for SRIOV
      drm/amdgpu: sriov is forbidden to call disable DPM
      drm/amdgpu: provide RREG32_SOC15_NO_KIQ, will be used later
      drm/amdgpu: clear the messed up checking logic
      drm/amdgpu: enable one vf mode for nv12
      drm/amdgpu: skip sysfs node not belong to one vf mode
      drm/amdgpu: for nv12 always need smu ip
      drm/amdgpu:  extent threshold of waiting FLR_COMPLETE

Mukul Joshi (1):
      drm/amdkfd: Track GPU memory utilization per process

Nathan Chancellor (5):
      drm/i915: Cast remain to unsigned long in eb_relocate_vma
      drm/i915/gt: Avoid uninitialized use of rpcurupei in frequency_show
      drm/amdgpu: Avoid integer overflow in amdgpu_device_suspend_display_a=
udio
      drm/i915: Remove duplicate inline specifier on write_pte
      drm/i915: Mark check_shadow_context_ppgtt as maybe unused

Neil Armstrong (1):
      drm/meson: add mode selection limits against specific SoC revisions

Nicholas Kazlauskas (17):
      drm/amd/display: Don't change mpcc tree for medium updates on DCN20 h=
wseq
      drm/amd/display: Translate cursor position by source rect
      drm/amd/display: Fix incorrect cursor pos on scaled primary plane
      drm/amd/display: Program viewport when source pos changes for DCN20 h=
w seq
      drm/amd/display: Calculate scaling ratios on every medium/full update
      drm/amd/display: Make cursor source translation adjustment optional
      drm/amd/display: Make DMCUB bss/data firmware blob optional
      drm/amd/display: Check ramp !=3D NULL before applying lut1d for degam=
ma
      drm/amd/display: Avoid NULL pointer in set_backlight when ABM is NULL
      drm/amd/display: Use the correct input TF for video formats
      drm/amd/display: Factor in immediate flip support into DLG calculatio=
ns
      drm/amd/display: Fix DMUB meta offset for new load method
      drm/amd/display: Defer cursor update around VUPDATE for all ASIC
      drm/amd/display: Pass command instead of header into DMUB service
      drm/amd/display: Fix vblank and pageflip event handling for FreeSync
      drm/amd/display: Defer cursor lock until after VUPDATE
      drm/amd/display: Avoid pipe split when plane is too small

Nick Desaulniers (1):
      drm/i915: re-disable -Wframe-address

Nikola Cornij (2):
      drm/amd/display: Program DSC before enabling link
      drm/amd/display: Minimize DSC resource re-assignment

Nirmoy Das (5):
      drm/amdgpu: sync ring type and drm hw_ip type
      drm/amdgpu: rework sched_list generation
      drm/amd/powerplay: fix a typo
      drm/mm: optimize rb_hole_addr rbtree search
      drm/amdgpu: cleanup sysfs file handling

Oak Zeng (3):
      drm/amdgpu: Print UTCL2 client ID on a gpuvm fault
      drm/amdkfd: New IOCTL to allocate queue GWS (v2)
      drm/amdgpu: Changed CU reservation golden settings

Oliver Barta (1):
      drm/i915: HDCP: fix Ri prime check done during link check

Ori Messinger (1):
      drm/amdkfd: Report domain with topology

Pankaj Bharadiya (9):
      drm/i915/display/icl_dsi: Prefer drm_WARN_ON over WARN_ON
      drm/i915/display/atomic_plane: Prefer drm_WARN_ON over WARN_ON
      drm/i915/display/ddi: Prefer drm_WARN* over WARN*
      drm/i915/display/display: Prefer drm_WARN_ON over WARN_ON
      drm/i915/display/dpll_mgr: Prefer drm_WARN_ON over WARN_ON
      drm/i915/display/frontbuffer: Prefer drm_WARN_ON over WARN_ON
      drm/i915/display/global_state: Prefer drm_WARN* over WARN*
      drm/i915/display/overlay: Prefer drm_WARN_ON over WARN_ON
      drm/i915/display/vlv_dsi: Prefer drm_WARN_ON over WARN_ON

Pascal Roeleven (2):
      dt-bindings: panel: Add binding for Starry KR070PE2T
      drm: panel: Add Starry KR070PE2T

Pascal Terjan (1):
      drm/i915: Remove unused HAS_FWTABLE macro

Paul Cercueil (2):
      drm/panel: nt39016: Add support for multiple modes
      drm/panel: nt39016: Add support for 50 Hz refresh rate

Paul Hsieh (1):
      drm/amd/display: dmcu wait loop calculation is incorrect in RV

Peter Jones (1):
      Make the "Reducing compressed framebufer size" message be DRM_INFO_ON=
CE()

Philip Yang (1):
      drm/amdkfd: fix restore worker race condition

Prike Liang (5):
      drm/amd/powerplay: implement the is_dpm_running()
      drm/amdgpu: fix gfx hang during suspend with video playback (v2)
      drm/amdgpu: fix the hw hang during perform system reboot and reset
      drm/amd/powerplay: fix resume failed as smu table initialize early ex=
it
      drm/amd/powerplay: update smu12_driver_if.h to align with pmfw

Qiang Yu (15):
      drm/lima: save process info for debug usage
      drm/lima: add max_error_tasks module parameter
      drm/lima: save task info dump when task fail
      drm/lima: add error sysfs to export error task dump
      drm/lima: add trace point for tasks
      drm/lima: use module_platform_driver helper
      drm/lima: print process name and pid when task error
      drm/lima: check vm !=3D NULL in lima_vm_put
      drm/lima: always set page directory when switch vm
      drm/lima: add lima_devfreq_resume/suspend
      drm/lima: power down ip blocks when pmu exit
      drm/lima: add resume/suspend callback for each ip
      drm/lima: separate clk/regulator enable/disable function
      drm/lima: add pm resume/suspend ops
      drm/lima: enable runtime pm

Radhakrishna Sripada (1):
      drm/i915/icl: Update forcewake firmware ranges

Rajneesh Bhardwaj (1):
      drm/amdgpu/gmc: Fix spelling mistake.

Ralph Campbell (3):
      drm/nouveau/svm: map pages after migration
      drm/nouveau/nouveau/hmm: fix nouveau_dmem_chunk allocations
      drm/nouveau/nouveau/hmm: fix migrate zero page to GPU

Randy Dunlap (9):
      fbdev: fbmon: fix -Wextra build warnings
      fbdev: aty: fix -Wextra build warning
      fbdev: matrox: fix -Wextra build warnings
      fbdev: savage: fix -Wextra build warning
      fbdev: pm[23]fb.c: fix -Wextra build warnings and errors
      fbdev: via: fix -Wextra build warning and format warning
      drm: amd/display: fix Kconfig help text
      drm: amdgpu: fix kernel-doc struct warning
      drm: panel: add MODULE_LICENSE to panel-visionox-rm69299.c

Rob Herring (3):
      drm: pl111: Fix module autoloading
      drm: pl111: Simplify vexpress init
      drm: pl111: Move VExpress setup into versatile init

Robin Murphy (2):
      drm/lima: Clean up IRQ warnings
      drm/lima: Clean up redundant pdev pointer

Rodrigo Siqueira (3):
      drm/amd/display: Fix green screen issue after suspend
      drm: Correct DP DSC macro typo
      drm/amd/display: Remove dml_common_def file

Roman Li (1):
      drm/amd/display: fix counter in wait_for_no_pipes_pending

Sam Ravnborg (42):
      dt-bindings: display: grammar fixes in panel/
      drm/dp_mst: add kernel-doc for drm_dp_mst_port.fec_capable
      drm/fb: fix kernel-doc in drm_framebuffer.h
      drm/sched: fix kernel-doc in gpu_scheduler.h
      drm/bridge: fix kernel-doc warning in panel.c
      drm: writeback: document callbacks
      drm/writeback: wire drm_writeback.h to kernel-doc
      drm/vblank: Add intro to documentation
      fbdev: mx3fb: const pointer to ipu_di_signal_cfg
      dt-bindings: display: allow port and ports in panel-lvds
      dt-bindings: display: look for dsi* nodes in dsi-controller
      dt-bindings: display: add te-gpios to panel-common
      dt-bindings: display: convert samsung,s6e63m0 to DT Schema
      dt-bindings: display: convert arm,versatile-tft-panel to DT Schema
      dt-bindings: display: convert boe,himax8279d to DT Schema
      dt-bindings: display: convert ilitek,ili9322 to DT Schema
      dt-bindings: display: convert ilitek,ili9881c to DT Schema
      dt-bindings: display: convert innolux,p097pfg to DT Schema
      dt-bindings: display: convert innolux,p120zdg-bf1 to DT Schema
      dt-bindings: display: convert jdi,lt070me05000 to DT Schema
      dt-bindings: display: convert kingdisplay,kd035g6-54nt to DT Schema
      dt-bindings: display: convert kingdisplay,kd097d04 to DT Schema
      dt-bindings: display: convert simple lg panels to DT Schema
      dt-bindings: display: convert lg,lg4573 to DT Schema
      dt-bindings: display: convert osddisplays,osd101t2587-53ts to DT Sche=
ma
      dt-bindings: display: convert raydium,rm67191 to DT Schema
      dt-bindings: display: convert samsung AMOLED to DT Schema
      dt-bindings: display: convert samsung,s6d16d0 to DT Schema
      dt-bindings: display: convert samsung,ld9040 to DT Schema
      dt-bindings: display: convert toppoly panels to DT Schema
      dt-bindings: display: convert startek,startek-kd050c to DT Schema
      dt-bindings: display: convert sony,acx565akm to DT Schema
      dt-bindings: display: convert sitronix,st7789v to DT Schema
      dt-bindings: display: drop unused simple-panel.txt
      dt-bindings: display: convert sharp,ls043t1le01 to DT Schema
      dt-bindings: display: convert sharp,ls037v7dw01 to DT Schema
      dt-bindings: display: convert sharp,lq150x1lg11 to DT Schema
      dt-bindings: display: convert seiko,43wvf1g to DT Schema
      dt-bindings: display: convert lgphilips,lb035q02 to DT Schema
      dt-bindings: display: convert olimex,lcd-olinuxino to DT Schema
      dt-bindings: display: move DSI panels to panel-simple-dsi
      video: vt8500lcdfb: fix fallthrough warning

Samuel Zou (2):
      drm/ast: Make ast_primary_plane_helper_atomic_update static
      drm/i2c/tda998x: Make tda998x_audio_digital_mute static

Sandeep Raghuraman (1):
      drm/amdgpu: Correctly initialize thermal controller for GPUs
with Powerplay table v0 (e.g Hawaii)

Sean Paul (3):
      drm/mst: Separate sideband packet header parsing from message buildin=
g
      drm/mst: Support simultaneous down replies
      drm/dp_mst: Remove single tx msg restriction.

Sebastian Reichel (3):
      drm/panel: simple: Add support for AUO G190EAN01 panel
      drm/panel: simple: Add support for AUO G156XTN01.0 panel
      drm/panel: simple: Add support for AUO G121EAN01.4 panel

Sergei Lopatin (1):
      drm/amd/powerplay: force the trim of the mclk dpm_levels if OD is ena=
bled

Shirish S (1):
      drm/amd/display: re-order asic declarations

Simon Ser (3):
      drm: add docs about the IN_FORMATS plane property
      drm/amd/display: add basic atomic check for cursor plane
      drm/amd/display: drop cursor position check in atomic test

Souptick Joarder (2):
      drm/gma500: Remove dead code
      video/fbdev/riva: Remove dead code

Stanislav Lisovskiy (15):
      drm/i915: Start passing latency as parameter
      drm/i915: Add YUV444 packed format support for skl+
      drm/i915: Add intel_atomic_get_bw_*_state helpers
      drm/i915: Prepare to extract gen specific functions from
intel_can_enable_sagv
      drm/i915: Add pre/post plane updates for SAGV
      drm/i915: Use bw state for per crtc SAGV evaluation
      drm/i915: Track active_pipes in bw_state
      drm/i915: Rename bw_state to new_bw_state
      drm/i915: Added required new PCode commands
      drm/i915: Introduce skl_plane_wm_level accessor.
      drm/i915: Extract skl SAGV checking
      drm/i915: Make active_pipes check skl specific
      drm/i915: Add TGL+ SAGV support
      drm/i915: Restrict qgv points which don't have enough bandwidth.
      drm/i915: Enable SAGV support for Gen12

Stephen Rothwell (1):
      drm/amdgpu: fix up for amdgpu_tmz.c and removal of drm/drmP.h

Stylon Wang (5):
      drm/amd/display: Refactor color management to take dm plane state
      drm/amd/display: Support plane-level gamut remap in DM
      drm/amd/display: Adjust refactored dm for color management only
      drm/amd/display: Support FP16 pixel format
      drm/amd/display: Fix incorrectly pruned modes with deep color

Sultan Alsawaf (1):
      drm/i915: Don't enable WaIncreaseLatencyIPCEnabled when IPC is disabl=
ed

Sung Lee (10):
      drm/amd/display: Power down hw blocks on boot
      drm/amd/display: Check power_down functions exist before calling
      drm/amd/display: Set meta_chunk_value to 0 in DML if DCC
disabled in DCN2.1
      drm/amd/display: Cast int to float before division
      drm/amd/display: Cap certain DML values for Low Pix Clk on DCN2.1
      drm/amd/display: Do not disable pipe split if mode is not supported
      drm/amd/display: Fail validation if building scaling params fails
      drm/amd/display: Change viewport limit to 12 for DCN2
      drm/amd/display: Update downspread percent to match spreadsheet for D=
CN2.1
      drm/amd/display: Update DCN2.1 DV Code Revision

Swathi Dhanavanthri (3):
      drm/i915/tgl: Add new PCI IDs to TGL
      drm/i915/tgl: Make Wa_14010229206 permanent
      drm/i915/ehl: Restrict w/a 1607087056 for EHL/JSL

Swati Sharma (1):
      drm/i915/color: Extract icl_read_luts()

Takashi Iwai (4):
      video: omapfb: Use scnprintf() for avoiding potential buffer overflow
      video: omap2: Use scnprintf() for avoiding potential buffer overflow
      video: uvesafb: Use scnprintf() for avoiding potential buffer overflo=
w
      drm/nouveau/kms: Fix regression by audio component transition

Tang Bin (1):
      video: fbdev: don't print error message on platform_get_irq() failure

Thierry Reding (1):
      dt-bindings: panel: Document some missing compatible strings

Thomas Zimmermann (47):
      drm/atmel-hlcdc: Use simple encoder
      drm/exynos: Use simple encoder
      drm/fsl-dcu: Use simple encoder
      drm/gma500: Use simple encoder
      drm/hisilicon/kirin: Use simple encoder
      drm/i2c/tda998x: Use simple encoder
      drm/imx: Use simple encoder
      drm/ingenic: Use simple encoder
      drm/mediatek: Use simple encoder
      drm/rcar-du: Use simple encoder
      drm/rockchip: Use simple encoder
      drm/shmobile: Use simple encoder
      drm/sun4i: Use simple encoder
      drm/tegra: Use simple encoder
      drm/tidss: Use simple encoder
      drm/tilcdc: Use simple encoder
      drm/vc4: Use simple encoder
      drm/virtgpu: Use simple encoder
      drm/vkms: Use simple encoder
      drm/zte: Use simple encoder
      drm/ast: Set up fbdev after registering device; remove error checks
      drm/hibmc: Remove error check from fbdev setup
      drm/kirin: Set up fbdev after fully registering device
      drm/ingenic: Remove error check from fbdev setup
      drm/mediatek: Remove error check from fbdev setup
      drm/mgag200: Set up fbdev after registering device; remove error chec=
ks
      drm/tilcdc: Set up fbdev after fully registering device
      drm/udl: Remove error check from fbdev setup
      drm/vboxvideo: Set up fbdev after registering device; remove error ch=
ecks
      drm/fb-helper: Remove return value from drm_fbdev_generic_setup()
      drm/vram-helpers: Set plane fence for display update
      drm/vram-helpers: Merge code into a single file
      Merge drm/drm-next into drm-misc-next
      Merge tag 'topic/phy-compliance-2020-04-08' of
git://anongit.freedesktop.org/drm/drm-misc into drm-misc-next
      drm/ast: Allocate initial CRTC state of the correct size
      MAINTAINERS: Restore alphabetical sorting
      drm/ast: Don't check new mode if CRTC is being disabled
      drm/mgag200: Convert struct drm_device to struct mga_device with help=
er
      drm/mgag200: Remove several references to struct mga_device.dev
      drm/mgag200: Integrate init function into load function
      drm/mgag200: Use managed mode-config initialization
      drm/mgag200: Remove unused fields from struct mga_device
      drm/mgag200: Embed connector instance in struct mga_device
      drm/nouveau/kms: Remove unused fields from struct nouveau_framebuffer
      drm/nouveau/kms: Move struct nouveau_framebuffer.vma to struct
nouveau_fbdev
      drm/nouveau/kms: Remove field nvbo from struct nouveau_framebuffer
      drm/nouveau/kms: Remove struct nouveau_framebuffer

Tian Tao (1):
      drm/hisilicon: Enforce 128-byte stride alignment to fix the
hardware limitation

Tianci.Yin (3):
      drm/amdgpu: add SPM golden settings for Navi10(v2)
      drm/amdgpu: add SPM golden settings for Navi14
      drm/amdgpu: add SPM golden settings for Navi12

Tiecheng Zhou (3):
      drm/amd/powerplay: avoid using pm_en before it is initialized
      Revert "drm/amd/powerplay: avoid using pm_en before it is initialized=
"
      drm/amd/powerplay: avoid using pm_en before it is initialized revised

Tom St Denis (7):
      drm/amd/amdgpu: Add GFX9.1 PWR_MISC_CNTL_STATUS register to headers
      drm/amd/amdgpu: Add missing SMUIO v12 register to headers
      drm/amd/amdgpu: Move PWR_MISC_CNTL_STATUS to its own header
      drm/amd/amdgpu: Fix SMUIO/PWR Confusion (v2)
      drm/amd/amdgpu: Include headers for PWR and SMUIO registers
      drm/amd/amdgpu: add raven1 part to the gfxoff quirk list
      drm/amd/amdgpu: Add missing GRBM bits for GFX 10.1

Tomi Valkeinen (4):
      omapfb: Remove unused writeback code
      drm/panel: panel-simple: fix AUO G101EVN010 connector/panel type
      drm/omap: change default signal polarities and drives
      drm/tidss: remove AM65x PG1 YUV erratum code

Tomohito Esaki (1):
      drm: rcar-du: Set primary plane zpos immutably at initializing

Uma Shankar (2):
      drm/i915/display: Fix mode private_flags comparison at atomic_check
      drm/i915/display: Enable DP Display Audio WA

Umesh Nerlige Ramappa (1):
      drm/i915/perf: Invalidate OA TLB on when closing perf stream

Uwe Kleine-K=C3=B6nig (1):
      video: fbdev: imxfb: ensure balanced regulator usage

Vandita Kulkarni (5):
      drm/i915/dsi: Configure transcoder operation for command mode.
      drm/i915/dsi: Add vblank calculation for command mode
      drm/i915/dsi: Add cmd mode flags in display mode private flags
      drm/i915/dsi: Add check for periodic command mode
      drm/i915/dsi: Use private flags to indicate TE in cmd mode

Ville Syrj=C3=A4l=C3=A4 (62):
      drm: Constify topology id
      drm/edid: Swap some operands in for_each_displayid_db()
      drm/edid: Remove idx=3D=3D1 assumptions from all over the DispID pars=
ing
      drm/edid: Return DispID length from drm_find_displayid_extension()
      drm/edid: Move validate_displayid() drm_find_displayid_extension()
      drm/edid: Don't parse garbage as DispID blocks
      drm/edid: Don't include ext block csum in DispID size
      drm/edid: Clarify validate_displayid()
      drm/edid: Fix DispID tile parsing for override EDID
      drm: Include the encoder itself in possible_clones
      drm/gma500: Sanitize possible_clones
      drm/imx: Remove the bogus possible_clones setup
      drm: Validate encoder->possible_clones
      drm: Validate encoder->possible_crtcs
      drm: Skip drm_mode_config_validate() for !modeset
      drm/i915: Fix crtc nv12 etc. plane bitmasks for DPMS off
      drm/i915: Get rid of silly void* from MST code
      drm: Constify adjusted_mode a bit
      drm/i915/mst: Use .compute_config_late() to compute master transcoder
      drm/i915: Move TRANS_DDI_FUNC_CTL2 programming where it belongs
      drm/i915: Drop usless master_transcoder assignments
      drm/i915: Move icl_get_trans_port_sync_config() into the DDI code
      drm/i915: Use REG_FIELD_PREP() & co. for TRANS_DDI_FUNC_CTL2
      drm/i915: Include port sync state in the state dump
      drm/i915: Store cpu_transcoder_mask in device info
      drm/i915: Implement port sync for SKL+
      drm/i915: Eliminate port sync copy pasta
      drm/i915: Fix port sync code to work with >2 pipes
      drm/i915: Do pipe updates after enables for everyone
      drm/i915: Pass atomic state to encoder hooks
      drm/i915: Move the port sync DP_TP_CTL stuff to the encoder hook
      drm/panel-leadtek-ltk500hd1829: Fix dotclock
      drm/i915: Pass encoder to intel_ddi_enable_pipe_clock()
      drm/i915: Move the TRANS_DDI_FUNC_CTL enable to a later point
      drm/i915: Push TRANS_DDI_FUNC_CTL into the encoder->enable() hook
      drm/i915: Pass encoder all the way to
intel_ddi_transcoder_func_reg_val_get()
      drm/i915: Flatten intel_dp_check_mst_status() a bit
      drm/i915: Push MST link retraining to the hotplug work
      drm/i915: Fix skl+ non-scaled pfit modes
      drm/i915: Flatten a bunch of the pfit functions
      drm/i915: Use drm_rect to store the pfit window pos/size
      drm/i915: s/pipe_config/crtc_state/ in pfit functions
      drm/i915: Pass connector state to pfit calculations
      drm/i915: Have pfit calculations return an error code
      drm/i915: Introduce .set_link_train() vfunc
      drm/i915: Introduce .set_signal_levels() vfunc
      drm/i915: Introduce .set_idle_link_train() vfunc
      drm/i915: Split some long lines
      drm: Nuke mode->hsync
      drm/i915/fbc: Require linear fb stride to be multiple of 512
bytes on gen9/glk
      drm/i915: Remove cnl pre-prod workarounds
      drm/i915: Nuke mode.vrefresh usage
      drm/i915: Rename variables to be consistent with bspec
      drm/i915: Streamline the artihmetic
      drm/i915/mst: Wait for ACT sent before enabling the pipe
      drm/i915: Fix glk watermark calculations
      drm/i915: Turn intel_digital_port_connected() in a vfunc
      drm/i915: Stash hpd status bits under dev_priv
      drm/i915: Use stashed away hpd isr bits in intel_digital_port_connect=
ed()
      drm/i915: Nuke pointless div by 64bit
      drm/i915: Store CS timestamp frequency in Hz
      drm/i915: Extract i915_cs_timestamp_{ns_to_ticks,tick_to_ns}()

Vladimir Stempen (1):
      drm/amd/display: DP training to set properly SCRAMBLING_DISABLE

Wambui Karuga (28):
      drm/tegra: remove checks for debugfs functions return value
      drm/tilcdc: remove check for return value of debugfs functions.
      drm/v3d: make v3d_debugfs_init() return 0
      drm/vc4: remove check of return value of drm_debugfs functions
      drm/arc: make arcgpu_debugfs_init() return 0.
      drm/arm: make hdlcd_debugfs_init() return 0
      drm/etnaviv: remove check for return value of drm_debugfs_create_file=
s()
      drm/msm: remove checks for return value of drm_debugfs_create_files()
      drm/sti: remove use of drm_debugfs functions as return values
      drm/vram-helper: make drm_vram_mm_debugfs_init() return 0
      drm/nouveau: make nouveau_drm_debugfs_init() return 0
      drm/pl111: make pl111_debugfs_init return 0
      drm/omap: remove checks for return value of drm_debugfs functions
      drm/i915: have *_debugfs_init() functions return void.
      drm: make various debugfs_init() functions return 0
      drm/debugfs: remove checks for return value of drm_debugfs functions.
      drm: convert .debugfs_init() hook to return void.
      drm/i915/fbc: convert to drm_device based logging macros.
      drm/i915/fbdev: convert to drm_device based logging.
      drm/i915/hdcp: convert to struct drm_device based logging.
      drm/i915/ggtt: convert to drm_device based logging macros.
      drm/i915/lrc: convert to struct drm_device based logging macros.
      drm/i915/rc6: convert to struct drm_device based logging macros.
      drm/i915/renderstate: use struct drm_device based logging macros.
      drm/i915/ring_submission: use drm_device based logging macros.
      drm/i915/rps: use struct drm_device based logging macros.
      drm/i915/workarounds: convert to drm_device based logging macros.
      drm/vram-helper: remove unneeded #if defined/endif guards.

Wei Yongjun (1):
      drm/mcde: dsi: Fix return value check in mcde_dsi_bind()

Wenjing Liu (2):
      drm/amd/display: determine USB C DP2 mode only when USB DP Alt is ena=
bled
      drm/amd/display: add optc get crc support for timings with ODM/DSC

Wolfram Sang (6):
      drm/amdgpu: convert to use i2c_new_client_device()
      drm/gma500: convert to use i2c_new_client_device()
      drm/i2c/sil164: convert to use i2c_new_client_device()
      drm/i2c/tda998x: convert to use i2c_new_client_device()
      drm/nouveau/therm: convert to use i2c_new_client_device()
      drm/radeon: convert to use i2c_new_client_device()

Wyatt Wood (13):
      drm/amd/display: Add ABM driver implementation
      drm/amd/display: Move backlight pwm enable function call
      drm/amd/display: Implement abm config table copy to dmcub
      drm/amd/display: Use config flag to disable dmcu obj creation
      drm/amd/display: Fix ABM config copy for dmcub
      drm/amd/display: Remove unused defines
      drm/amd/display: Add user backlight level reg write
      drm/amd/display: Move enable fractional pwm call
      drm/amd/display: Remove byte swapping for dmcub abm config table
      drm/amd/display: Add SetBacklight call to abm on dmcub
      drm/amd/display: Unify psr feature flags
      drm/amd/display: Various fixes for PSR on DMCUB
      drm/amd/display: Convert memory from cpu to fw endianness correctly

Xiaodong Yan (3):
      drm/amd/display: blank dp stream before power off receiver
      drm/amd/display: only blank dp stream which will be powered off
      drm/amd/display: blank dp stream before re-train the link

Xiyu Yang (1):
      drm/i915/selftests: Fix i915_address_space refcnt leak

Yan Zhao (3):
      drm/i915/gvt: access shadow ctx via its virtual address directly
      drm/i915/gvt: combine access to consecutive guest context pages
      drm/i915/gvt: skip populate shadow context if guest context not chang=
ed

Yannick Fertre (1):
      drm/stm: ltdc: check number of endpoints

Yifan Zhang (1):
      drm/amd/display: fix the broken logic in dc_link.c

Yintian Tao (6):
      drm/amdgpu: skip access sdma_v5_0 registers under SRIOV (v2)
      drm/amdgpu: restrict debugfs register access under SR-IOV
      drm/amdgpu: resume kiq access debugfs
      drm/amdgpu: request reg_val_offs each kiq read reg
      drm/amdgpu: protect ring overrun
      drm/amdgpu: turn back rlcg write for gfx_v10

Yong Zhao (5):
      drm/amdkfd: Adjust three kfd dmesg printings during initialization
      drm/amdgpu: Adjust the SDMA doorbell info printing
      drm/amdgpu: Print CU information by default during initialization
      drm/amdgpu: Rename amdgpu_gfx_kcq_queue_mask_transform()
      drm/amdkfd: Use a systematic method to calculate queue mask bit

Yongqiang Sun (4):
      drm/amd/display: access ABM from stream resource.
      drm/amd/display: Add panel cntl id for set backlight level.
      drm/amd/display: Add set backlight to hw sequencer.
      drm/amd/display: Move panel_cntl specific register from abm to panel_=
cntl.

YueHaibing (6):
      omapfb/dss: remove unused variable 'venc_config_pal_bdghi'
      drm/gma500: remove unused variable 'hdmi_ids'
      drm/amd/dc: remove unused variable 'video_optimized_pixel_rates'
      drm/amdgpu: remove set but not used variable 'priority'
      drm/panel: remove set but not used variable 'config'
      drm/omap: venc: remove unused variable 'venc_config_pal_bdghi'

Yuxian Dai (2):
      drm/amdgpu/powerplay: using the FCLK DPM table to set the MCLK
      drm/amdgpu/powerplay:avoid to show invalid DPM table info

Zbigniew Kempczy=C5=84ski (1):
      drm/i915/selftests: Add tiled blits selftest

Zhan Liu (2):
      drm/amd/display: Change "error" to "dc_log" at amdgpu_dm dpcd
reading stage
      drm/amd/display: Remove aconnector condition check for dpcd read

Zheng Bin (12):
      drm/panel: ili9322: Remove unneeded semicolon
      drm/rockchip: Remove unneeded semicolon
      drm/amdgpu: Remove unneeded semicolon
      drm/meson: Remove unneeded semicolon
      drm/amdgpu: remove set but not used variable 'priority'
      drm/amdgpu: remove set but not used variable 'direct_poll' in vcn_v2_=
0.c
      drm/amdgpu: remove set but not used variable 'direct_poll' in vcn_v2_=
5.c
      drm/amd/display: remove set but not used variable 'dc'
      drm/amd/display: remove set but not used variable 'pixel_width'
      drm/amd/display: remove set but not used variable 'speakers' in
dce_stream_encoder.c
      drm/amd/display: remove set but not used variable 'speakers' in
dcn10_stream_encoder.c
      drm/nouveau/mmu: Remove unneeded semicolon

Zhenyu Wang (3):
      drm/i915/gvt: move workload destroy out of execlist complete
      drm/i915/gvt: Support PPGTT table load command
      drm/i915/gvt: use context lrc_reg_state for shadow ppgtt override

Zou Wei (3):
      drm/amd/display: Fix unsigned comparison to zero
      drm/udl: Make udl_handle_damage static
      drm/nouveau/acr: Use kmemdup instead of kmalloc and memcpy

allen (2):
      dt-bindings: fix vendor prefix for ITE Tech. Inc.
      dt-bindings: Add binding for IT6505.

chen gong (1):
      drm/amd/powerpay: Disable gfxoff when setting manual mode on
picasso and raven

limingyu (1):
      drm/amdgpu: Init data to avoid oops while reading pp_num_states.

shaoyunl (1):
      amd/amdgpu: Limit rlcg write registers only for nv12

xinhui pan (1):
      drm/amdgpu: implement more ib pools (v2)

yanyan kang (1):
      drm/amd/display: The external monitor will show gray screen
during SUT reboot

 .../display/allwinner,sun6i-a31-mipi-dsi.yaml      |    2 +-
 .../bindings/display/bridge/adi,adv7123.txt        |   50 -
 .../bindings/display/bridge/anx6345.yaml           |    8 +
 .../bindings/display/bridge/chrontel,ch7033.yaml   |   77 +
 .../bindings/display/bridge/dumb-vga-dac.txt       |   50 -
 .../bindings/display/bridge/dw_mipi_dsi.txt        |   32 -
 .../bindings/display/bridge/ite,it6505.yaml        |   91 +
 .../bindings/display/bridge/lvds-codec.yaml        |    8 +
 .../bindings/display/bridge/nwl-dsi.yaml           |  226 ++
 .../devicetree/bindings/display/bridge/ps8640.yaml |    8 +
 .../bindings/display/bridge/simple-bridge.yaml     |   99 +
 .../bindings/display/bridge/snps,dw-mipi-dsi.yaml  |   68 +
 .../bindings/display/bridge/thine,thc63lvd1024.txt |   66 -
 .../display/bridge/thine,thc63lvd1024.yaml         |  121 +
 .../bindings/display/bridge/ti,ths813x.txt         |   51 -
 .../bindings/display/dsi-controller.yaml           |    4 +-
 .../bindings/display/mediatek/mediatek,dpi.txt     |    6 +
 .../bindings/display/mediatek/mediatek,dsi.txt     |   10 +
 .../display/panel/arm,versatile-tft-panel.txt      |   31 -
 .../display/panel/arm,versatile-tft-panel.yaml     |   54 +
 .../display/panel/asus,z00t-tm5p5-nt35596.yaml     |   56 +
 .../bindings/display/panel/boe,himax8279d.txt      |   24 -
 .../bindings/display/panel/boe,himax8279d.yaml     |   59 +
 .../bindings/display/panel/boe,tv101wum-nl6.yaml   |    2 +
 .../bindings/display/panel/display-timings.yaml    |    8 +-
 .../display/panel/feiyang,fy07024di26a30d.txt      |   20 -
 .../display/panel/feiyang,fy07024di26a30d.yaml     |   58 +
 .../bindings/display/panel/ilitek,ili9322.txt      |   49 -
 .../bindings/display/panel/ilitek,ili9322.yaml     |   71 +
 .../bindings/display/panel/ilitek,ili9881c.txt     |   20 -
 .../bindings/display/panel/ilitek,ili9881c.yaml    |   50 +
 .../bindings/display/panel/innolux,p097pfg.txt     |   24 -
 .../bindings/display/panel/innolux,p097pfg.yaml    |   56 +
 .../bindings/display/panel/innolux,p120zdg-bf1.txt |   22 -
 .../display/panel/innolux,p120zdg-bf1.yaml         |   43 +
 .../bindings/display/panel/jdi,lt070me05000.txt    |   31 -
 .../bindings/display/panel/jdi,lt070me05000.yaml   |   69 +
 .../display/panel/kingdisplay,kd035g6-54nt.txt     |   42 -
 .../display/panel/kingdisplay,kd035g6-54nt.yaml    |   65 +
 .../display/panel/kingdisplay,kd097d04.txt         |   22 -
 .../display/panel/leadtek,ltk050h3146w.yaml        |   51 +
 .../display/panel/leadtek,ltk500hd1829.yaml        |    1 -
 .../bindings/display/panel/lg,acx467akm-7.txt      |    7 -
 .../bindings/display/panel/lg,ld070wx3-sl01.txt    |    7 -
 .../bindings/display/panel/lg,lg4573.txt           |   19 -
 .../bindings/display/panel/lg,lg4573.yaml          |   45 +
 .../bindings/display/panel/lg,lh500wx1-sd03.txt    |    7 -
 .../bindings/display/panel/lgphilips,lb035q02.txt  |   33 -
 .../bindings/display/panel/lgphilips,lb035q02.yaml |   59 +
 .../devicetree/bindings/display/panel/lvds.yaml    |   10 +-
 .../display/panel/olimex,lcd-olinuxino.txt         |   42 -
 .../display/panel/olimex,lcd-olinuxino.yaml        |   70 +
 .../display/panel/osddisplays,osd101t2587-53ts.txt |   14 -
 .../bindings/display/panel/panel-common.yaml       |   17 +-
 .../bindings/display/panel/panel-simple-dsi.yaml   |   14 +
 .../bindings/display/panel/panel-simple.yaml       |   22 +-
 .../bindings/display/panel/raydium,rm67191.txt     |   41 -
 .../bindings/display/panel/raydium,rm67191.yaml    |   75 +
 .../display/panel/samsung,amoled-mipi-dsi.yaml     |   65 +
 .../bindings/display/panel/samsung,ld9040.txt      |   66 -
 .../bindings/display/panel/samsung,ld9040.yaml     |  107 +
 .../bindings/display/panel/samsung,s6d16d0.txt     |   30 -
 .../bindings/display/panel/samsung,s6d16d0.yaml    |   56 +
 .../bindings/display/panel/samsung,s6e3ha2.txt     |   31 -
 .../bindings/display/panel/samsung,s6e63j0x03.txt  |   24 -
 .../bindings/display/panel/samsung,s6e63m0.txt     |   33 -
 .../bindings/display/panel/samsung,s6e63m0.yaml    |   60 +
 .../bindings/display/panel/seiko,43wvf1g.txt       |   23 -
 .../bindings/display/panel/seiko,43wvf1g.yaml      |   50 +
 .../bindings/display/panel/sharp,lq150x1lg11.txt   |   36 -
 .../bindings/display/panel/sharp,lq150x1lg11.yaml  |   58 +
 .../bindings/display/panel/sharp,ls037v7dw01.txt   |   43 -
 .../bindings/display/panel/sharp,ls037v7dw01.yaml  |   68 +
 .../bindings/display/panel/sharp,ls043t1le01.txt   |   22 -
 .../bindings/display/panel/sharp,ls043t1le01.yaml  |   51 +
 .../bindings/display/panel/simple-panel.txt        |    1 -
 .../bindings/display/panel/sitronix,st7701.txt     |   30 -
 .../bindings/display/panel/sitronix,st7701.yaml    |   69 +
 .../bindings/display/panel/sitronix,st7789v.txt    |   37 -
 .../bindings/display/panel/sitronix,st7789v.yaml   |   63 +
 .../bindings/display/panel/sony,acx565akm.txt      |   30 -
 .../bindings/display/panel/sony,acx565akm.yaml     |   57 +
 .../display/panel/startek,startek-kd050c.txt       |    4 -
 .../display/panel/startek,startek-kd050c.yaml      |   33 +
 .../devicetree/bindings/display/panel/tpo,td.yaml  |   65 +
 .../bindings/display/panel/tpo,td028ttec1.txt      |   32 -
 .../bindings/display/panel/tpo,td043mtea1.txt      |   33 -
 .../bindings/display/panel/visionox,rm69299.yaml   |   57 +
 .../bindings/display/panel/xinpeng,xpp055c272.yaml |    1 -
 .../devicetree/bindings/display/renesas,du.txt     |   10 +
 .../display/rockchip/rockchip,rk3066-hdmi.txt      |   72 -
 .../display/rockchip/rockchip,rk3066-hdmi.yaml     |  140 +
 .../bindings/display/rockchip/rockchip-vop.txt     |   74 -
 .../bindings/display/rockchip/rockchip-vop.yaml    |  134 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    8 +-
 Documentation/driver-api/dma-buf.rst               |    4 +-
 Documentation/gpu/amdgpu.rst                       |   88 +
 Documentation/gpu/drm-internals.rst                |   12 +
 Documentation/gpu/drm-kms.rst                      |    5 +-
 Documentation/gpu/drm-mm.rst                       |    9 -
 Documentation/gpu/i915.rst                         |   52 +-
 Documentation/gpu/todo.rst                         |   12 -
 MAINTAINERS                                        |   23 +-
 arch/arm/mach-sa1100/shannon.c                     |    9 +
 drivers/char/agp/intel-gtt.c                       |   21 +-
 drivers/dma-buf/Makefile                           |    3 +-
 drivers/dma-buf/dma-buf.c                          |    2 +
 drivers/dma-buf/dma-fence-chain.c                  |   10 +-
 drivers/dma-buf/dma-fence.c                        |    2 +-
 drivers/dma-buf/selftests.h                        |    1 +
 drivers/dma-buf/st-dma-fence-chain.c               |  715 +++++
 drivers/gpu/drm/Kconfig                            |    2 -
 drivers/gpu/drm/Makefile                           |    7 +-
 drivers/gpu/drm/amd/amdgpu/Makefile                |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   82 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |   22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |    7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |    7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c |    3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |   67 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c      |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c            |    8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |    5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            |  160 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h            |    3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |  151 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h        |    6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  422 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_df.h             |    3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |   68 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h      |    1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c        |   61 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c            |   12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h            |    3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   40 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c             |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |   10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c     |  185 ++
 .../amdgpu_fru_eeprom.h}                           |   18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |   55 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |   60 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |    8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |   47 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |    4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |   91 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c            |    6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c            |   15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h            |    5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c           |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h           |    2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |   16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h           |    1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |   11 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             |  623 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h             |   49 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  447 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |   56 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |  169 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h            |    4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |   13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |   62 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h           |    7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c           |    5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_test.c           |    6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h          |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  342 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |   20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c          |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c            |    9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |    7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |  107 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h            |   32 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |  103 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h           |   28 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  120 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |   24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c         |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c        |   28 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c       |  142 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c           |  146 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h           |   10 +-
 drivers/gpu/drm/amd/amdgpu/atom.c                  |    7 +-
 drivers/gpu/drm/amd/amdgpu/cik.c                   |    8 -
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c              |   11 +-
 drivers/gpu/drm/amd/amdgpu/cikd.h                  |    2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |    8 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c             |    8 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |   14 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |   14 +-
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c           |   13 +-
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c               |   54 -
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             | 2905 ++++++++++++++++=
+++-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c              |   35 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              |   69 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |   78 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  209 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c              |   35 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c           |    2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |   28 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |   13 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |    3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |    3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |   16 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c             |    3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c             |    6 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c             |    4 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c            |   14 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h              |    5 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c              |   97 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h              |   46 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.h              |    3 +-
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c             |  302 +-
 drivers/gpu/drm/amd/amdgpu/navi10_sdma_pkt_open.h  |   16 +
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c             |   18 -
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c             |   18 -
 drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c             |    7 -
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c             |   36 +-
 drivers/gpu/drm/amd/amdgpu/nv.c                    |   28 +-
 drivers/gpu/drm/amd/amdgpu/nvd.h                   |   49 +
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c             |  145 +-
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c             |  419 +--
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c             |  172 +-
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c              |  262 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c             |   11 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c             |   11 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |   47 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c             |  143 +-
 drivers/gpu/drm/amd/amdgpu/si.c                    |    8 -
 drivers/gpu/drm/amd/amdgpu/si_dma.c                |   10 +-
 drivers/gpu/drm/amd/amdgpu/si_dpm.c                |   20 -
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |   20 +-
 drivers/gpu/drm/amd/amdgpu/soc15_common.h          |    3 +
 drivers/gpu/drm/amd/amdgpu/soc15d.h                |   26 +-
 drivers/gpu/drm/amd/amdgpu/ta_ras_if.h             |   59 +-
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.c              |  112 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c              |    6 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c              |    6 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c              |   16 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c              |   23 +-
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c              |    3 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              |    3 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c              |    7 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |    9 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c              |   80 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c              |  471 ++--
 drivers/gpu/drm/amd/amdgpu/vi.c                    |   24 -
 drivers/gpu/drm/amd/amdgpu/vid.h                   |    2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |   55 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |    2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |   40 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   47 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |    1 +
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c    |    4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c             |    2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c      |    1 +
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c    |    6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c |    2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   23 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   62 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |    9 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |   11 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h          |    6 +-
 drivers/gpu/drm/amd/display/Kconfig                |    8 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  623 +++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |    1 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    |   27 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |   73 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |   10 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |   42 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  103 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.h    |    3 +-
 drivers/gpu/drm/amd/display/dc/basics/Makefile     |    3 +-
 .../gpu/drm/amd/display/dc/bios/command_table2.c   |   62 +-
 drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c   |   21 +-
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c   |    2 +-
 .../amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c    |    2 +-
 .../dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c       |    3 -
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   35 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |  644 +++--
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c  |    2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |   74 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c |    2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  107 +-
 drivers/gpu/drm/amd/display/dc/core/dc_sink.c      |    1 +
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |   40 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |  100 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       |    4 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h       |    5 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h       |    6 +
 drivers/gpu/drm/amd/display/dc/dc_helper.c         |    6 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h           |   30 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |    2 -
 drivers/gpu/drm/amd/display/dc/dc_types.h          |    5 +
 drivers/gpu/drm/amd/display/dc/dce/Makefile        |    2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c       |  225 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.h       |   30 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |   33 -
 drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h     |   65 +-
 .../gpu/drm/amd/display/dc/dce/dce_link_encoder.c  |   20 +-
 .../gpu/drm/amd/display/dc/dce/dce_link_encoder.h  |    3 +
 .../gpu/drm/amd/display/dc/dce/dce_panel_cntl.c    |  299 ++
 .../gpu/drm/amd/display/dc/dce/dce_panel_cntl.h    |  125 +
 .../drm/amd/display/dc/dce/dce_stream_encoder.c    |    2 -
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c      |  319 +++
 .../dc/{basics/log_helpers.c =3D> dce/dmub_abm.h}    |   25 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c      |   76 +-
 .../drm/amd/display/dc/dce100/dce100_resource.c    |   31 +
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |  111 +-
 .../amd/display/dc/dce110/dce110_hw_sequencer.h    |    7 +-
 .../drm/amd/display/dc/dce110/dce110_opp_csc_v.c   |    3 +-
 .../drm/amd/display/dc/dce110/dce110_resource.c    |   31 +
 .../drm/amd/display/dc/dce112/dce112_resource.c    |   33 +-
 .../drm/amd/display/dc/dce120/dce120_resource.c    |   33 +-
 .../drm/amd/display/dc/dce80/dce80_hw_sequencer.c  |   28 -
 .../gpu/drm/amd/display/dc/dce80/dce80_resource.c  |   31 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c   |    7 -
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c    |    1 -
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c  |   18 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |  205 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h  |    6 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c  |    6 +-
 .../drm/amd/display/dc/dcn10/dcn10_link_encoder.c  |   20 +-
 .../drm/amd/display/dc/dcn10/dcn10_link_encoder.h  |    3 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c   |   15 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.h   |   20 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c  |    6 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h  |    7 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |   97 +-
 .../amd/display/dc/dcn10/dcn10_stream_encoder.c    |    2 -
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.h    |    1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |   24 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c  |    6 +-
 .../drm/amd/display/dc/dcn20/dcn20_link_encoder.c  |   40 +
 .../drm/amd/display/dc/dcn20/dcn20_link_encoder.h  |    4 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c   |    3 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.h   |    3 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c  |   14 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.h  |    7 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |  323 ++-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.h  |    8 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c    |    7 +-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c  |   33 +-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c  |   12 +-
 .../drm/amd/display/dc/dcn21/dcn21_link_encoder.c  |   27 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c  |  197 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile        |    2 -
 .../display/dc/dml/dcn20/display_mode_vba_20v2.c   |   32 +-
 .../display/dc/dml/dcn20/display_rq_dlg_calc_20.h  |    1 -
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.h        |    1 -
 .../amd/display/dc/dml/dcn21/display_mode_vba_21.c |   30 +-
 .../display/dc/dml/dcn21/display_rq_dlg_calc_21.c  |   25 +-
 .../display/dc/dml/dcn21/display_rq_dlg_calc_21.h  |    2 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_lib.h  |    6 +-
 .../drm/amd/display/dc/dml/display_mode_structs.h  |    2 +
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.c  |    2 +
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.h  |    4 +-
 .../amd/display/dc/dml/display_rq_dlg_helpers.h    |    1 -
 .../amd/display/dc/dml/dml1_display_rq_dlg_calc.h  |    2 -
 .../gpu/drm/amd/display/dc/dml/dml_inline_defs.h   |   15 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c        |    2 +-
 drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c     |   89 +
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |    3 +
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h        |   21 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h   |    2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h        |   16 +
 drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h |   67 +
 .../drm/amd/display/dc/inc/hw/timing_generator.h   |    3 +
 drivers/gpu/drm/amd/display/dc/inc/hw/transform.h  |    2 +
 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h  |   16 +
 .../drm/amd/display/dc/inc/hw_sequencer_private.h  |    2 -
 drivers/gpu/drm/amd/display/dc/inc/resource.h      |    5 +-
 drivers/gpu/drm/amd/display/dc/os_types.h          |    2 +-
 .../amd/display/dc/virtual/virtual_link_encoder.c  |    9 +
 .../gpu/drm/amd/display/dmub/{inc =3D> }/dmub_srv.h  |   23 +-
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |   14 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h    |   15 +-
 drivers/gpu/drm/amd/display/dmub/inc/dmub_rb.h     |    6 +-
 drivers/gpu/drm/amd/display/dmub/inc/dmub_types.h  |   11 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c  |   26 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c  |    2 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_reg.c    |    2 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    |   33 +-
 drivers/gpu/drm/amd/display/include/hdcp_types.h   |    7 +
 .../gpu/drm/amd/display/include/logger_interface.h |    4 -
 .../drm/amd/display/modules/color/color_gamma.c    |   33 +-
 .../drm/amd/display/modules/color/color_gamma.h    |    4 +-
 .../drm/amd/display/modules/freesync/freesync.c    |  101 +-
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c    |    5 +-
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h    |   30 +-
 .../drm/amd/display/modules/hdcp/hdcp1_execution.c |    2 +-
 .../drm/amd/display/modules/hdcp/hdcp2_execution.c |    2 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp_log.c    |    8 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp_psp.c    |  482 ++--
 .../gpu/drm/amd/display/modules/inc/mod_freesync.h |    3 +
 drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h |    5 +-
 .../gpu/drm/amd/display/modules/inc/mod_shared.h   |    5 +-
 .../amd/display/modules/info_packet/info_packet.c  |    2 +-
 .../drm/amd/display/modules/power/power_helpers.c  |  103 +-
 .../drm/amd/display/modules/power/power_helpers.h  |    3 +
 drivers/gpu/drm/amd/display/modules/stats/stats.c  |  448 ---
 drivers/gpu/drm/amd/display/modules/vmid/vmid.c    |    7 +-
 drivers/gpu/drm/amd/include/amd_shared.h           |   14 +
 .../amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h    |    4 +
 .../amd/include/asic_reg/nbif/nbif_6_1_offset.h    |    2 +
 .../amd/include/asic_reg/nbio/nbio_7_0_offset.h    |    2 +
 .../amd/include/asic_reg/nbio/nbio_7_4_offset.h    |    2 +
 .../drm/amd/include/asic_reg/pwr/pwr_10_0_offset.h |   27 +
 .../amd/include/asic_reg/pwr/pwr_10_0_sh_mask.h    |   30 +
 .../include/asic_reg/smuio/smuio_12_0_0_offset.h   |   30 +
 .../include/asic_reg/smuio/smuio_12_0_0_sh_mask.h  |   33 +
 drivers/gpu/drm/amd/include/atomfirmware.h         |  114 +-
 drivers/gpu/drm/amd/include/cgs_common.h           |    1 -
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c      |   18 +-
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         |  336 ++-
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       |   49 +-
 .../gpu/drm/amd/powerplay/hwmgr/processpptables.c  |   26 +
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c  |  184 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.h  |    2 +-
 .../amd/powerplay/hwmgr/smu7_clockpowergating.c    |   61 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |  135 +-
 .../gpu/drm/amd/powerplay/hwmgr/smu7_powertune.c   |   40 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c |   17 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c   |  157 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c   |   71 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_baco.c  |    2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |  141 +-
 .../gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c |   32 +-
 .../gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c   |    6 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_baco.c  |    2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c |  149 +-
 .../gpu/drm/amd/powerplay/hwmgr/vega12_thermal.c   |    7 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_baco.c  |    8 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c |  181 +-
 .../gpu/drm/amd/powerplay/hwmgr/vega20_powertune.c |    6 +-
 .../gpu/drm/amd/powerplay/hwmgr/vega20_thermal.c   |    7 +-
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h     |   11 +-
 drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h |    3 +-
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h          |    1 +
 .../amd/powerplay/inc/smu11_driver_if_arcturus.h   |   15 +-
 .../gpu/drm/amd/powerplay/inc/smu12_driver_if.h    |   40 +-
 drivers/gpu/drm/amd/powerplay/inc/smu_types.h      |    1 +
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h      |    5 +-
 drivers/gpu/drm/amd/powerplay/inc/smumgr.h         |    7 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         |  107 +-
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c         |   15 +-
 drivers/gpu/drm/amd/powerplay/smu_internal.h       |    5 +
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c          |  139 +-
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c          |   16 +-
 drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c   |   18 +-
 drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c |   35 +-
 .../gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c  |    1 +
 .../drm/amd/powerplay/smumgr/polaris10_smumgr.c    |   31 +-
 .../gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c    |   42 +-
 drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c |   48 +-
 drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.h |    4 +-
 drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c |   69 +-
 drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c      |   56 +-
 .../gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c    |   15 +-
 .../gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c   |   56 +-
 .../gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c   |   68 +-
 .../gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c   |  106 +-
 .../gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c    |   18 +-
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c         |    4 +-
 drivers/gpu/drm/arc/arcpgu_drv.c                   |    7 +-
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c    |   16 +-
 drivers/gpu/drm/arm/hdlcd_drv.c                    |    7 +-
 drivers/gpu/drm/arm/malidp_drv.c                   |    3 +-
 drivers/gpu/drm/armada/armada_drv.c                |    2 +
 drivers/gpu/drm/aspeed/aspeed_gfx.h                |    3 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c           |    2 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c            |   31 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_out.c            |    2 +-
 drivers/gpu/drm/ast/ast_drv.c                      |    3 +
 drivers/gpu/drm/ast/ast_main.c                     |    5 -
 drivers/gpu/drm/ast/ast_mode.c                     |   25 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   |   12 +-
 drivers/gpu/drm/bochs/bochs.h                      |    1 -
 drivers/gpu/drm/bochs/bochs_drv.c                  |    6 +-
 drivers/gpu/drm/bochs/bochs_kms.c                  |   16 +-
 drivers/gpu/drm/bridge/Kconfig                     |   26 +
 drivers/gpu/drm/bridge/Makefile                    |    2 +
 drivers/gpu/drm/bridge/adv7511/Kconfig             |    2 +-
 drivers/gpu/drm/bridge/adv7511/adv7511_audio.c     |   26 +-
 drivers/gpu/drm/bridge/chrontel-ch7033.c           |  620 +++++
 drivers/gpu/drm/bridge/nwl-dsi.c                   | 1213 ++++++++
 drivers/gpu/drm/bridge/nwl-dsi.h                   |  144 +
 drivers/gpu/drm/bridge/panel.c                     |    7 +-
 drivers/gpu/drm/bridge/parade-ps8640.c             |    2 -
 drivers/gpu/drm/bridge/sii9234.c                   |    3 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |   86 +-
 drivers/gpu/drm/bridge/tc358768.c                  |    4 +-
 drivers/gpu/drm/cirrus/Kconfig                     |   19 -
 drivers/gpu/drm/cirrus/Makefile                    |    2 -
 drivers/gpu/drm/drm_atomic.c                       |    8 +-
 drivers/gpu/drm/drm_auth.c                         |   69 +-
 drivers/gpu/drm/drm_blend.c                        |   16 +-
 drivers/gpu/drm/drm_bufs.c                         |    2 +-
 drivers/gpu/drm/drm_client.c                       |    8 +-
 drivers/gpu/drm/drm_connector.c                    |    6 +-
 drivers/gpu/drm/drm_crtc_internal.h                |    4 +-
 drivers/gpu/drm/drm_debugfs.c                      |   45 +-
 drivers/gpu/drm/drm_dma.c                          |    2 +-
 drivers/gpu/drm/drm_dp_helper.c                    |  271 ++
 drivers/gpu/drm/drm_dp_mst_topology.c              |  402 ++-
 drivers/gpu/drm/drm_drv.c                          |  230 +-
 drivers/gpu/drm/drm_edid.c                         |  111 +-
 drivers/gpu/drm/drm_fb_cma_helper.c                |    2 +-
 drivers/gpu/drm/drm_fb_helper.c                    |   31 +-
 drivers/gpu/drm/drm_file.c                         |    6 +-
 drivers/gpu/drm/drm_framebuffer.c                  |    8 +-
 drivers/gpu/drm/drm_gem.c                          |   23 +-
 drivers/gpu/drm/drm_gem_framebuffer_helper.c       |  224 +-
 drivers/gpu/drm/drm_gem_vram_helper.c              |  124 +-
 drivers/gpu/drm/drm_internal.h                     |    7 +-
 drivers/gpu/drm/drm_ioctl.c                        |    4 +-
 drivers/gpu/drm/drm_managed.c                      |  275 ++
 drivers/gpu/drm/drm_mipi_dbi.c                     |   33 +-
 drivers/gpu/drm/drm_mm.c                           |  133 +-
 drivers/gpu/drm/drm_mode_config.c                  |  110 +-
 drivers/gpu/drm/drm_mode_object.c                  |   10 +-
 drivers/gpu/drm/drm_modes.c                        |   26 -
 drivers/gpu/drm/drm_pci.c                          |    4 +-
 drivers/gpu/drm/drm_plane.c                        |    9 +
 drivers/gpu/drm/drm_vblank.c                       |   98 +-
 drivers/gpu/drm/drm_vm.c                           |    4 +-
 drivers/gpu/drm/drm_vram_helper_common.c           |   94 -
 drivers/gpu/drm/etnaviv/etnaviv_drv.c              |   18 +-
 drivers/gpu/drm/exynos/exynos_dp.c                 |    8 +-
 drivers/gpu/drm/exynos/exynos_drm_dpi.c            |    8 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.c            |    1 -
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |   34 +-
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c          |   28 +-
 drivers/gpu/drm/exynos/exynos_drm_gem.c            |  182 +-
 drivers/gpu/drm/exynos/exynos_drm_gem.h            |   16 +-
 drivers/gpu/drm/exynos/exynos_drm_mic.c            |    2 +-
 drivers/gpu/drm/exynos/exynos_drm_rotator.c        |    4 +-
 drivers/gpu/drm/exynos/exynos_drm_scaler.c         |    4 +-
 drivers/gpu/drm/exynos/exynos_drm_vidi.c           |   34 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |    8 +-
 drivers/gpu/drm/exynos/exynos_mixer.c              |    6 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c          |   14 +-
 drivers/gpu/drm/gma500/cdv_intel_crt.c             |   14 +-
 drivers/gpu/drm/gma500/cdv_intel_dp.c              |   47 +-
 drivers/gpu/drm/gma500/cdv_intel_hdmi.c            |    4 +-
 drivers/gpu/drm/gma500/cdv_intel_lvds.c            |  100 +-
 drivers/gpu/drm/gma500/framebuffer.c               |   16 +-
 drivers/gpu/drm/gma500/mdfld_dsi_dpi.c             |   11 +-
 drivers/gpu/drm/gma500/mdfld_intel_display.c       |   31 -
 drivers/gpu/drm/gma500/mdfld_output.h              |    1 -
 drivers/gpu/drm/gma500/mdfld_tmd_vid.c             |    6 -
 drivers/gpu/drm/gma500/mdfld_tpo_vid.c             |    6 -
 drivers/gpu/drm/gma500/oaktrail_hdmi.c             |   19 +-
 drivers/gpu/drm/gma500/oaktrail_lvds.c             |    5 +-
 drivers/gpu/drm/gma500/psb_intel_drv.h             |    1 -
 drivers/gpu/drm/gma500/psb_intel_lvds.c            |   18 +-
 drivers/gpu/drm/gma500/psb_intel_sdvo.c            |   99 -
 drivers/gpu/drm/gma500/tc35876x-dsi-lvds.c         |   13 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c     |    9 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c    |    8 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c        |    2 +-
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c       |    9 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c    |    1 -
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c    |   43 -
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h    |    1 -
 drivers/gpu/drm/i2c/sil164_drv.c                   |    7 +-
 drivers/gpu/drm/i2c/tda998x_drv.c                  |   23 +-
 drivers/gpu/drm/i915/Kconfig.profile               |   12 +
 drivers/gpu/drm/i915/Makefile                      |   32 +-
 drivers/gpu/drm/i915/display/icl_dsi.c             |  188 +-
 drivers/gpu/drm/i915/display/intel_atomic_plane.c  |   25 +-
 drivers/gpu/drm/i915/display/intel_atomic_plane.h  |    2 +
 drivers/gpu/drm/i915/display/intel_audio.c         |  144 +-
 drivers/gpu/drm/i915/display/intel_bw.c            |  194 +-
 drivers/gpu/drm/i915/display/intel_bw.h            |   27 +
 drivers/gpu/drm/i915/display/intel_color.c         |  121 +-
 drivers/gpu/drm/i915/display/intel_connector.c     |    5 +-
 drivers/gpu/drm/i915/display/intel_crt.c           |   40 +-
 drivers/gpu/drm/i915/display/intel_ddi.c           |  822 ++++--
 drivers/gpu/drm/i915/display/intel_ddi.h           |    9 +-
 drivers/gpu/drm/i915/display/intel_display.c       |  920 +++----
 drivers/gpu/drm/i915/display/intel_display.h       |   11 +-
 .../gpu/drm/i915/display/intel_display_debugfs.c   |  130 +-
 .../gpu/drm/i915/display/intel_display_debugfs.h   |    4 +-
 drivers/gpu/drm/i915/display/intel_display_power.c |  558 ++--
 drivers/gpu/drm/i915/display/intel_display_power.h |    5 +-
 drivers/gpu/drm/i915/display/intel_display_types.h |   50 +-
 drivers/gpu/drm/i915/display/intel_dp.c            | 2023 +++++++++-----
 drivers/gpu/drm/i915/display/intel_dp.h            |   19 +-
 .../gpu/drm/i915/display/intel_dp_aux_backlight.c  |   85 +-
 .../gpu/drm/i915/display/intel_dp_link_training.c  |    9 +-
 .../gpu/drm/i915/display/intel_dp_link_training.h  |    4 +
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |  164 +-
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c      |    8 +-
 drivers/gpu/drm/i915/display/intel_dsb.c           |    6 +-
 drivers/gpu/drm/i915/display/intel_dsi.c           |    9 +-
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c       |   13 +-
 drivers/gpu/drm/i915/display/intel_dvo.c           |    9 +-
 drivers/gpu/drm/i915/display/intel_fbc.c           |   97 +-
 drivers/gpu/drm/i915/display/intel_fbdev.c         |   96 +-
 drivers/gpu/drm/i915/display/intel_frontbuffer.c   |    6 +-
 drivers/gpu/drm/i915/display/intel_global_state.c  |    9 +-
 drivers/gpu/drm/i915/display/intel_gmbus.c         |    3 +-
 drivers/gpu/drm/i915/display/intel_hdcp.c          |   29 +-
 drivers/gpu/drm/i915/display/intel_hdcp.h          |    4 +-
 drivers/gpu/drm/i915/display/intel_hdmi.c          |  302 +-
 drivers/gpu/drm/i915/display/intel_hotplug.c       |   16 +-
 drivers/gpu/drm/i915/display/intel_hotplug.h       |    3 +-
 drivers/gpu/drm/i915/display/intel_lspcon.c        |    2 +-
 drivers/gpu/drm/i915/display/intel_lvds.c          |   38 +-
 drivers/gpu/drm/i915/display/intel_overlay.c       |    8 +-
 drivers/gpu/drm/i915/display/intel_panel.c         |  178 +-
 drivers/gpu/drm/i915/display/intel_panel.h         |   13 +-
 drivers/gpu/drm/i915/display/intel_psr.c           |  105 +-
 drivers/gpu/drm/i915/display/intel_psr.h           |    6 +-
 drivers/gpu/drm/i915/display/intel_sdvo.c          |   22 +-
 drivers/gpu/drm/i915/display/intel_sprite.c        |   25 +-
 drivers/gpu/drm/i915/display/intel_tc.c            |  149 +-
 drivers/gpu/drm/i915/display/intel_tc.h            |    3 +-
 drivers/gpu/drm/i915/display/intel_tv.c            |   15 +-
 drivers/gpu/drm/i915/display/intel_vbt_defs.h      |    4 +-
 drivers/gpu/drm/i915/display/vlv_dsi.c             |   26 +-
 drivers/gpu/drm/i915/gem/i915_gem_clflush.c        |    2 +-
 drivers/gpu/drm/i915/gem/i915_gem_client_blt.c     |    4 +-
 drivers/gpu/drm/i915/gem/i915_gem_context.c        |   89 +-
 drivers/gpu/drm/i915/gem/i915_gem_context.h        |    4 +
 drivers/gpu/drm/i915/gem/i915_gem_domain.c         |    9 +-
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c     |  843 +++---
 drivers/gpu/drm/i915/gem/i915_gem_fence.c          |    4 +-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c           |   34 +
 drivers/gpu/drm/i915/gem/i915_gem_object.c         |    8 +-
 drivers/gpu/drm/i915/gem/i915_gem_object_blt.c     |   26 +-
 drivers/gpu/drm/i915/gem/i915_gem_object_blt.h     |    1 -
 drivers/gpu/drm/i915/gem/i915_gem_object_types.h   |    3 -
 drivers/gpu/drm/i915/gem/i915_gem_pages.c          |    3 +-
 drivers/gpu/drm/i915/gem/i915_gem_phys.c           |    2 -
 drivers/gpu/drm/i915/gem/i915_gem_shrinker.c       |   18 +-
 drivers/gpu/drm/i915/gem/i915_gem_stolen.c         |    4 +-
 drivers/gpu/drm/i915/gem/i915_gem_tiling.c         |   20 +-
 .../gpu/drm/i915/gem/selftests/huge_gem_object.c   |    3 +-
 drivers/gpu/drm/i915/gem/selftests/huge_pages.c    |   95 +-
 .../drm/i915/gem/selftests/i915_gem_client_blt.c   |  566 ++++
 .../drm/i915/gem/selftests/i915_gem_coherency.c    |    2 +
 .../gpu/drm/i915/gem/selftests/i915_gem_context.c  |   52 +-
 .../drm/i915/gem/selftests/i915_gem_execbuffer.c   |  171 ++
 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c |  128 +-
 .../gpu/drm/i915/gem/selftests/i915_gem_object.c   |    2 +-
 drivers/gpu/drm/i915/gem/selftests/igt_gem_utils.c |   26 +-
 drivers/gpu/drm/i915/gt/debugfs_engines.c          |    2 +-
 drivers/gpu/drm/i915/gt/debugfs_gt.c               |   15 +-
 drivers/gpu/drm/i915/gt/debugfs_gt.h               |    9 +-
 drivers/gpu/drm/i915/gt/debugfs_gt_pm.c            |   74 +-
 drivers/gpu/drm/i915/gt/gen8_ppgtt.c               |   15 +-
 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c        |   58 +-
 drivers/gpu/drm/i915/gt/intel_context.c            |    5 +
 drivers/gpu/drm/i915/gt/intel_context_sseu.c       |    3 +-
 drivers/gpu/drm/i915/gt/intel_context_types.h      |   10 +-
 drivers/gpu/drm/i915/gt/intel_engine.h             |   51 +-
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          |  211 +-
 drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c   |    2 +-
 drivers/gpu/drm/i915/gt/intel_engine_pm.c          |   20 +-
 drivers/gpu/drm/i915/gt/intel_engine_pm.h          |    6 +
 drivers/gpu/drm/i915/gt/intel_engine_pool.h        |   34 -
 drivers/gpu/drm/i915/gt/intel_engine_types.h       |   89 +-
 drivers/gpu/drm/i915/gt/intel_ggtt.c               |   59 +-
 .../intel_ggtt_fencing.c}                          |  170 +-
 .../intel_ggtt_fencing.h}                          |   17 +-
 drivers/gpu/drm/i915/gt/intel_gpu_commands.h       |    6 +-
 drivers/gpu/drm/i915/gt/intel_gt.c                 |   69 +-
 ...{intel_engine_pool.c =3D> intel_gt_buffer_pool.c} |  114 +-
 drivers/gpu/drm/i915/gt/intel_gt_buffer_pool.h     |   37 +
 ...e_pool_types.h =3D> intel_gt_buffer_pool_types.h} |   15 +-
 drivers/gpu/drm/i915/gt/intel_gt_clock_utils.c     |  102 +
 drivers/gpu/drm/i915/gt/intel_gt_clock_utils.h     |   27 +
 drivers/gpu/drm/i915/gt/intel_gt_irq.c             |   15 +-
 drivers/gpu/drm/i915/gt/intel_gt_pm.c              |   17 +-
 drivers/gpu/drm/i915/gt/intel_gt_requests.c        |   20 +-
 drivers/gpu/drm/i915/gt/intel_gt_types.h           |   20 +-
 drivers/gpu/drm/i915/gt/intel_gtt.h                |    5 +-
 drivers/gpu/drm/i915/gt/intel_lrc.c                | 1195 +++++---
 drivers/gpu/drm/i915/gt/intel_lrc.h                |    1 +
 drivers/gpu/drm/i915/gt/intel_lrc_reg.h            |    6 +-
 drivers/gpu/drm/i915/gt/intel_rc6.c                |   47 +-
 drivers/gpu/drm/i915/gt/intel_renderstate.c        |   22 +-
 drivers/gpu/drm/i915/gt/intel_reset.c              |   16 +-
 drivers/gpu/drm/i915/gt/intel_ring.h               |    5 +-
 drivers/gpu/drm/i915/gt/intel_ring_submission.c    |   49 +-
 drivers/gpu/drm/i915/gt/intel_rps.c                |  454 ++-
 drivers/gpu/drm/i915/gt/intel_rps.h                |   61 +
 drivers/gpu/drm/i915/gt/intel_rps_types.h          |   14 +-
 drivers/gpu/drm/i915/gt/intel_sseu.c               |   33 +-
 drivers/gpu/drm/i915/gt/intel_timeline.c           |   39 +-
 drivers/gpu/drm/i915/gt/intel_timeline.h           |    7 +-
 drivers/gpu/drm/i915/gt/intel_workarounds.c        |   49 +-
 drivers/gpu/drm/i915/gt/mock_engine.c              |    2 -
 drivers/gpu/drm/i915/gt/selftest_context.c         |   12 +-
 drivers/gpu/drm/i915/gt/selftest_gt_pm.c           |    8 +
 drivers/gpu/drm/i915/gt/selftest_lrc.c             |  719 ++++-
 drivers/gpu/drm/i915/gt/selftest_rc6.c             |   30 +-
 drivers/gpu/drm/i915/gt/selftest_ring_submission.c |    2 +
 drivers/gpu/drm/i915/gt/selftest_rps.c             | 1331 +++++++++
 drivers/gpu/drm/i915/gt/selftest_rps.h             |   17 +
 drivers/gpu/drm/i915/gt/shmem_utils.c              |  173 ++
 drivers/gpu/drm/i915/gt/shmem_utils.h              |   23 +
 drivers/gpu/drm/i915/gt/st_shmem_utils.c           |   63 +
 drivers/gpu/drm/i915/gt/sysfs_engines.c            |   94 +
 drivers/gpu/drm/i915/gt/uc/intel_guc.c             |   46 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc.h             |    7 +
 drivers/gpu/drm/i915/gt/uc/intel_guc_debugfs.c     |   42 +
 drivers/gpu/drm/i915/gt/uc/intel_guc_debugfs.h     |   14 +
 drivers/gpu/drm/i915/gt/uc/intel_guc_fw.c          |   14 -
 drivers/gpu/drm/i915/gt/uc/intel_guc_fw.h          |    1 -
 drivers/gpu/drm/i915/gt/uc/intel_guc_log.c         |   97 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_log.h         |    4 +
 drivers/gpu/drm/i915/gt/uc/intel_guc_log_debugfs.c |  124 +
 drivers/gpu/drm/i915/gt/uc/intel_guc_log_debugfs.h |   15 +
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c  |    4 +-
 drivers/gpu/drm/i915/gt/uc/intel_huc.c             |   53 +-
 drivers/gpu/drm/i915/gt/uc/intel_huc.h             |    2 +
 drivers/gpu/drm/i915/gt/uc/intel_huc_debugfs.c     |   36 +
 drivers/gpu/drm/i915/gt/uc/intel_huc_debugfs.h     |   14 +
 drivers/gpu/drm/i915/gt/uc/intel_huc_fw.c          |   17 -
 drivers/gpu/drm/i915/gt/uc/intel_huc_fw.h          |    1 -
 drivers/gpu/drm/i915/gt/uc/intel_uc.c              |   35 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc.h              |    1 +
 drivers/gpu/drm/i915/gt/uc/intel_uc_debugfs.c      |   30 +
 drivers/gpu/drm/i915/gt/uc/intel_uc_debugfs.h      |   14 +
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c           |   56 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.h           |    3 +-
 drivers/gpu/drm/i915/gvt/aperture_gm.c             |    2 +-
 drivers/gpu/drm/i915/gvt/cmd_parser.c              |   45 +
 drivers/gpu/drm/i915/gvt/execlist.c                |    2 -
 drivers/gpu/drm/i915/gvt/gtt.c                     |   16 +
 drivers/gpu/drm/i915/gvt/gtt.h                     |    1 +
 drivers/gpu/drm/i915/gvt/gvt.c                     |    1 -
 drivers/gpu/drm/i915/gvt/gvt.h                     |    5 +
 drivers/gpu/drm/i915/gvt/handlers.c                |    2 +-
 drivers/gpu/drm/i915/gvt/hypercall.h               |    2 -
 drivers/gpu/drm/i915/gvt/scheduler.c               |  251 +-
 drivers/gpu/drm/i915/gvt/scheduler.h               |    1 +
 drivers/gpu/drm/i915/i915_active.c                 |  137 +-
 drivers/gpu/drm/i915/i915_active.h                 |   14 +-
 drivers/gpu/drm/i915/i915_config.c                 |   15 +
 drivers/gpu/drm/i915/i915_debugfs.c                |  356 +--
 drivers/gpu/drm/i915/i915_debugfs.h                |    4 +-
 drivers/gpu/drm/i915/i915_drv.c                    |  156 +-
 drivers/gpu/drm/i915/i915_drv.h                    |   49 +-
 drivers/gpu/drm/i915/i915_gem.c                    |   20 +-
 drivers/gpu/drm/i915/i915_gem_evict.c              |   33 +-
 drivers/gpu/drm/i915/i915_getparam.c               |    2 +-
 drivers/gpu/drm/i915/i915_gpu_error.c              |   45 +-
 drivers/gpu/drm/i915/i915_gpu_error.h              |    3 +-
 drivers/gpu/drm/i915/i915_irq.c                    |  241 +-
 drivers/gpu/drm/i915/i915_pci.c                    |   41 +-
 drivers/gpu/drm/i915/i915_perf.c                   |  583 ++--
 drivers/gpu/drm/i915/i915_perf_types.h             |   46 +-
 drivers/gpu/drm/i915/i915_pmu.c                    |   41 +-
 drivers/gpu/drm/i915/i915_priolist_types.h         |    7 +-
 drivers/gpu/drm/i915/i915_reg.h                    |  197 +-
 drivers/gpu/drm/i915/i915_request.c                |  156 +-
 drivers/gpu/drm/i915/i915_request.h                |   30 +-
 drivers/gpu/drm/i915/i915_scheduler.c              |   39 +-
 drivers/gpu/drm/i915/i915_scheduler.h              |    3 +-
 drivers/gpu/drm/i915/i915_scheduler_types.h        |    3 +-
 drivers/gpu/drm/i915/i915_selftest.h               |    2 +
 drivers/gpu/drm/i915/i915_sw_fence.c               |   12 +-
 drivers/gpu/drm/i915/i915_sw_fence_work.c          |    5 +-
 drivers/gpu/drm/i915/i915_sw_fence_work.h          |   23 +
 drivers/gpu/drm/i915/i915_switcheroo.c             |    4 +-
 drivers/gpu/drm/i915/i915_utils.c                  |    3 +-
 drivers/gpu/drm/i915/i915_vma.c                    |  131 +-
 drivers/gpu/drm/i915/i915_vma.h                    |    4 +-
 drivers/gpu/drm/i915/intel_device_info.c           |   76 +-
 drivers/gpu/drm/i915/intel_device_info.h           |    5 +-
 drivers/gpu/drm/i915/intel_dram.c                  |    3 +-
 drivers/gpu/drm/i915/intel_pm.c                    |  366 ++-
 drivers/gpu/drm/i915/intel_pm.h                    |    6 +-
 drivers/gpu/drm/i915/intel_sideband.c              |    8 +-
 drivers/gpu/drm/i915/intel_uncore.c                |   60 +-
 drivers/gpu/drm/i915/intel_uncore.h                |    6 +-
 drivers/gpu/drm/i915/intel_wakeref.c               |   12 +-
 drivers/gpu/drm/i915/intel_wakeref.h               |   22 +-
 drivers/gpu/drm/i915/intel_wopcm.c                 |   47 +-
 drivers/gpu/drm/i915/oa/i915_oa_bdw.c              |   90 -
 drivers/gpu/drm/i915/oa/i915_oa_bdw.h              |   16 -
 drivers/gpu/drm/i915/oa/i915_oa_bxt.c              |   88 -
 drivers/gpu/drm/i915/oa/i915_oa_bxt.h              |   16 -
 drivers/gpu/drm/i915/oa/i915_oa_cflgt2.c           |   89 -
 drivers/gpu/drm/i915/oa/i915_oa_cflgt2.h           |   16 -
 drivers/gpu/drm/i915/oa/i915_oa_cflgt3.c           |   89 -
 drivers/gpu/drm/i915/oa/i915_oa_cflgt3.h           |   16 -
 drivers/gpu/drm/i915/oa/i915_oa_chv.c              |   89 -
 drivers/gpu/drm/i915/oa/i915_oa_chv.h              |   16 -
 drivers/gpu/drm/i915/oa/i915_oa_cnl.c              |  101 -
 drivers/gpu/drm/i915/oa/i915_oa_cnl.h              |   16 -
 drivers/gpu/drm/i915/oa/i915_oa_glk.c              |   88 -
 drivers/gpu/drm/i915/oa/i915_oa_glk.h              |   16 -
 drivers/gpu/drm/i915/oa/i915_oa_hsw.c              |  118 -
 drivers/gpu/drm/i915/oa/i915_oa_hsw.h              |   16 -
 drivers/gpu/drm/i915/oa/i915_oa_icl.c              |   98 -
 drivers/gpu/drm/i915/oa/i915_oa_icl.h              |   16 -
 drivers/gpu/drm/i915/oa/i915_oa_kblgt2.c           |   89 -
 drivers/gpu/drm/i915/oa/i915_oa_kblgt2.h           |   16 -
 drivers/gpu/drm/i915/oa/i915_oa_kblgt3.c           |   89 -
 drivers/gpu/drm/i915/oa/i915_oa_kblgt3.h           |   16 -
 drivers/gpu/drm/i915/oa/i915_oa_sklgt2.c           |   88 -
 drivers/gpu/drm/i915/oa/i915_oa_sklgt2.h           |   16 -
 drivers/gpu/drm/i915/oa/i915_oa_sklgt3.c           |   89 -
 drivers/gpu/drm/i915/oa/i915_oa_sklgt3.h           |   16 -
 drivers/gpu/drm/i915/oa/i915_oa_sklgt4.c           |   89 -
 drivers/gpu/drm/i915/oa/i915_oa_sklgt4.h           |   16 -
 drivers/gpu/drm/i915/oa/i915_oa_tgl.c              |  121 -
 drivers/gpu/drm/i915/oa/i915_oa_tgl.h              |   16 -
 drivers/gpu/drm/i915/selftests/i915_active.c       |   12 +-
 drivers/gpu/drm/i915/selftests/i915_gem.c          |    2 -
 drivers/gpu/drm/i915/selftests/i915_gem_evict.c    |   26 +-
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c      |   33 +-
 .../gpu/drm/i915/selftests/i915_live_selftests.h   |    1 +
 .../gpu/drm/i915/selftests/i915_mock_selftests.h   |    1 +
 drivers/gpu/drm/i915/selftests/i915_perf.c         |  104 +-
 .../gpu/drm/i915/selftests/i915_perf_selftests.h   |    1 +
 drivers/gpu/drm/i915/selftests/i915_request.c      |  623 ++++-
 drivers/gpu/drm/i915/selftests/i915_selftest.c     |   29 +
 drivers/gpu/drm/i915/selftests/i915_vma.c          |    2 +-
 drivers/gpu/drm/i915/selftests/igt_spinner.c       |    3 +-
 .../gpu/drm/i915/selftests/intel_memory_region.c   |    5 +-
 drivers/gpu/drm/i915/selftests/librapl.c           |   24 +
 drivers/gpu/drm/i915/selftests/librapl.h           |   13 +
 drivers/gpu/drm/i915/selftests/mock_gem_device.c   |   38 +-
 drivers/gpu/drm/imx/dw_hdmi-imx.c                  |    8 +-
 drivers/gpu/drm/imx/imx-drm-core.c                 |   10 +-
 drivers/gpu/drm/imx/imx-drm.h                      |    1 -
 drivers/gpu/drm/imx/imx-ldb.c                      |    8 +-
 drivers/gpu/drm/imx/imx-tve.c                      |    8 +-
 drivers/gpu/drm/imx/parallel-display.c             |    8 +-
 drivers/gpu/drm/ingenic/ingenic-drm.c              |   43 +-
 drivers/gpu/drm/lima/Kconfig                       |    2 +
 drivers/gpu/drm/lima/Makefile                      |    4 +-
 drivers/gpu/drm/lima/lima_bcast.c                  |   25 +-
 drivers/gpu/drm/lima/lima_bcast.h                  |    2 +
 drivers/gpu/drm/lima/lima_ctx.c                    |    3 +
 drivers/gpu/drm/lima/lima_ctx.h                    |    5 +
 drivers/gpu/drm/lima/lima_devfreq.c                |  257 ++
 drivers/gpu/drm/lima/lima_devfreq.h                |   44 +
 drivers/gpu/drm/lima/lima_device.c                 |  228 +-
 drivers/gpu/drm/lima/lima_device.h                 |   17 +-
 drivers/gpu/drm/lima/lima_dlbu.c                   |   17 +-
 drivers/gpu/drm/lima/lima_dlbu.h                   |    2 +
 drivers/gpu/drm/lima/lima_drv.c                    |  141 +-
 drivers/gpu/drm/lima/lima_drv.h                    |    1 +
 drivers/gpu/drm/lima/lima_dump.h                   |   77 +
 drivers/gpu/drm/lima/lima_gp.c                     |   21 +-
 drivers/gpu/drm/lima/lima_gp.h                     |    2 +
 drivers/gpu/drm/lima/lima_l2_cache.c               |   38 +-
 drivers/gpu/drm/lima/lima_l2_cache.h               |    2 +
 drivers/gpu/drm/lima/lima_mmu.c                    |   49 +-
 drivers/gpu/drm/lima/lima_mmu.h                    |    2 +
 drivers/gpu/drm/lima/lima_pmu.c                    |   77 +-
 drivers/gpu/drm/lima/lima_pmu.h                    |    2 +
 drivers/gpu/drm/lima/lima_pp.c                     |   31 +-
 drivers/gpu/drm/lima/lima_pp.h                     |    4 +
 drivers/gpu/drm/lima/lima_sched.c                  |  193 +-
 drivers/gpu/drm/lima/lima_sched.h                  |   11 +
 drivers/gpu/drm/lima/lima_trace.c                  |    7 +
 drivers/gpu/drm/lima/lima_trace.h                  |   50 +
 drivers/gpu/drm/lima/lima_vm.h                     |    3 +-
 drivers/gpu/drm/mcde/mcde_display.c                |   10 +-
 drivers/gpu/drm/mcde/mcde_drm.h                    |    2 +
 drivers/gpu/drm/mcde/mcde_drv.c                    |   52 +-
 drivers/gpu/drm/mcde/mcde_dsi.c                    |    9 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c                 |   45 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |   13 +-
 drivers/gpu/drm/mediatek/mtk_drm_gem.c             |    3 +
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |   14 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c                |   18 +-
 drivers/gpu/drm/mediatek/mtk_mipi_tx.c             |   54 +
 drivers/gpu/drm/mediatek/mtk_mipi_tx.h             |    4 +
 drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c      |   28 +
 drivers/gpu/drm/meson/meson_drv.c                  |   34 +-
 drivers/gpu/drm/meson/meson_drv.h                  |    6 +
 drivers/gpu/drm/meson/meson_dw_hdmi.c              |    2 +-
 drivers/gpu/drm/meson/meson_plane.c                |    2 +-
 drivers/gpu/drm/meson/meson_vclk.c                 |   16 +-
 drivers/gpu/drm/meson/meson_vclk.h                 |    3 +-
 drivers/gpu/drm/mgag200/mgag200_cursor.c           |    4 +-
 drivers/gpu/drm/mgag200/mgag200_drv.c              |    4 +-
 drivers/gpu/drm/mgag200/mgag200_drv.h              |   15 +-
 drivers/gpu/drm/mgag200/mgag200_i2c.c              |   10 +-
 drivers/gpu/drm/mgag200/mgag200_main.c             |  119 +-
 drivers/gpu/drm/mgag200/mgag200_mode.c             |  127 +-
 drivers/gpu/drm/msm/adreno/a5xx_debugfs.c          |   18 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h              |    2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c           |   14 +-
 drivers/gpu/drm/msm/msm_debugfs.c                  |   23 +-
 drivers/gpu/drm/msm/msm_debugfs.h                  |    2 +-
 drivers/gpu/drm/msm/msm_gpu.h                      |    2 +-
 drivers/gpu/drm/nouveau/Kbuild                     |   10 +-
 drivers/gpu/drm/nouveau/dispnv04/crtc.c            |   19 +-
 drivers/gpu/drm/nouveau/dispnv04/disp.c            |   21 +-
 drivers/gpu/drm/nouveau/dispnv04/overlay.c         |   21 +-
 drivers/gpu/drm/nouveau/dispnv50/base507c.c        |    7 +-
 drivers/gpu/drm/nouveau/dispnv50/core.h            |    7 +
 drivers/gpu/drm/nouveau/dispnv50/core507d.c        |   15 +
 drivers/gpu/drm/nouveau/dispnv50/core827d.c        |    1 +
 drivers/gpu/drm/nouveau/dispnv50/core907d.c        |    1 +
 drivers/gpu/drm/nouveau/dispnv50/core917d.c        |    1 +
 drivers/gpu/drm/nouveau/dispnv50/corec37d.c        |   26 +
 drivers/gpu/drm/nouveau/dispnv50/corec57d.c        |    1 +
 drivers/gpu/drm/nouveau/dispnv50/curs507a.c        |    2 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |  137 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.h            |    5 +
 drivers/gpu/drm/nouveau/dispnv50/headc37d.c        |    5 +-
 drivers/gpu/drm/nouveau/dispnv50/headc57d.c        |    5 +-
 drivers/gpu/drm/nouveau/dispnv50/pior507d.c        |    8 +
 drivers/gpu/drm/nouveau/dispnv50/sor507d.c         |    7 +
 drivers/gpu/drm/nouveau/dispnv50/sor907d.c         |   11 +
 drivers/gpu/drm/nouveau/dispnv50/sorc37d.c         |    9 +
 drivers/gpu/drm/nouveau/dispnv50/wndw.c            |   81 +-
 drivers/gpu/drm/nouveau/dispnv50/wndwc57e.c        |   17 +
 drivers/gpu/drm/nouveau/include/nvif/class.h       |    2 +
 drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h |    2 +
 drivers/gpu/drm/nouveau/nouveau_acpi.c             |   98 +-
 drivers/gpu/drm/nouveau/nouveau_acpi.h             |    4 -
 drivers/gpu/drm/nouveau/nouveau_connector.c        |   48 +-
 drivers/gpu/drm/nouveau/nouveau_connector.h        |    5 +
 drivers/gpu/drm/nouveau/nouveau_debugfs.c          |   11 +-
 drivers/gpu/drm/nouveau/nouveau_debugfs.h          |    8 +-
 drivers/gpu/drm/nouveau/nouveau_display.c          |  212 +-
 drivers/gpu/drm/nouveau/nouveau_display.h          |   31 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c             |  423 ++-
 drivers/gpu/drm/nouveau/nouveau_dmem.h             |    2 +
 drivers/gpu/drm/nouveau/nouveau_dp.c               |   31 +
 drivers/gpu/drm/nouveau/nouveau_drm.c              |   31 +-
 drivers/gpu/drm/nouveau/nouveau_encoder.h          |    8 +
 drivers/gpu/drm/nouveau/nouveau_fbcon.c            |   42 +-
 drivers/gpu/drm/nouveau/nouveau_fbcon.h            |    3 +
 drivers/gpu/drm/nouveau/nouveau_gem.c              |    6 +-
 drivers/gpu/drm/nouveau/nouveau_platform.c         |   11 -
 drivers/gpu/drm/nouveau/nouveau_svm.c              |   59 +-
 drivers/gpu/drm/nouveau/nouveau_svm.h              |    5 +
 drivers/gpu/drm/nouveau/nv50_fbcon.c               |    9 +-
 drivers/gpu/drm/nouveau/nvc0_fbcon.c               |    9 +-
 drivers/gpu/drm/nouveau/nvkm/core/memory.c         |    2 +-
 drivers/gpu/drm/nouveau/nvkm/core/subdev.c         |   11 +
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  |   75 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/Kbuild    |    3 +
 .../gpu/drm/nouveau/nvkm/engine/disp/capsgv100.c   |   60 +
 .../gpu/drm/nouveau/nvkm/engine/disp/hdagf119.c    |   18 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/hdagt215.c    |    2 +-
 .../nvkm/engine/disp/hdagv100.c}                   |   27 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h     |   10 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/rootgv100.c   |    1 +
 .../gpu/drm/nouveau/nvkm/engine/disp/rootnv50.c    |    2 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/rootnv50.h    |    3 +
 .../gpu/drm/nouveau/nvkm/engine/disp/roottu102.c   |    1 +
 .../gpu/drm/nouveau/nvkm/engine/disp/sorgf119.c    |    1 +
 .../gpu/drm/nouveau/nvkm/engine/disp/sorgk104.c    |    1 +
 .../gpu/drm/nouveau/nvkm/engine/disp/sorgm107.c    |    1 +
 .../gpu/drm/nouveau/nvkm/engine/disp/sorgm200.c    |    1 +
 .../gpu/drm/nouveau/nvkm/engine/disp/sorgv100.c    |    1 +
 .../gpu/drm/nouveau/nvkm/engine/disp/sortu102.c    |    1 +
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gk20a.c     |   11 +
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c     |    5 +
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c     |   12 +-
 .../gpu/drm/nouveau/nvkm/subdev/bios/shadowacpi.c  |   65 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/ibus/gf100.c   |    6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/ibus/gf117.c   |    6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/ibus/gk104.c   |    6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/ibus/gk20a.c   |    6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/ibus/gm200.c   |    6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/ibus/gp10b.c   |    6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c      |    2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.h      |    2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/ic.c     |    4 +-
 drivers/gpu/drm/omapdrm/dss/dispc.c                |   33 +-
 drivers/gpu/drm/omapdrm/dss/venc.c                 |   43 -
 drivers/gpu/drm/omapdrm/omap_debugfs.c             |   29 +-
 drivers/gpu/drm/omapdrm/omap_drv.h                 |    2 +-
 drivers/gpu/drm/panel/Kconfig                      |   29 +
 drivers/gpu/drm/panel/Makefile                     |    3 +
 .../gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c   |  367 +++
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c     |   31 +
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c       |    4 +-
 drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c |  691 +++++
 drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c |    2 +-
 drivers/gpu/drm/panel/panel-novatek-nt39016.c      |   46 +-
 drivers/gpu/drm/panel/panel-simple.c               |  247 +-
 drivers/gpu/drm/panel/panel-truly-nt35597.c        |    2 -
 drivers/gpu/drm/panel/panel-visionox-rm69299.c     |  303 ++
 drivers/gpu/drm/pl111/Makefile                     |    1 -
 drivers/gpu/drm/pl111/pl111_debugfs.c              |    8 +-
 drivers/gpu/drm/pl111/pl111_drm.h                  |    2 +-
 drivers/gpu/drm/pl111/pl111_drv.c                  |   13 +-
 drivers/gpu/drm/pl111/pl111_versatile.c            |  148 +-
 drivers/gpu/drm/pl111/pl111_vexpress.c             |  138 -
 drivers/gpu/drm/pl111/pl111_vexpress.h             |   29 -
 drivers/gpu/drm/qxl/qxl_debugfs.c                  |   28 +-
 drivers/gpu/drm/qxl/qxl_display.c                  |   32 +-
 drivers/gpu/drm/qxl/qxl_drv.c                      |   25 +-
 drivers/gpu/drm/qxl/qxl_drv.h                      |   20 +-
 drivers/gpu/drm/qxl/qxl_dumb.c                     |    2 +-
 drivers/gpu/drm/qxl/qxl_gem.c                      |    2 +-
 drivers/gpu/drm/qxl/qxl_ioctl.c                    |   14 +-
 drivers/gpu/drm/qxl/qxl_irq.c                      |    2 +-
 drivers/gpu/drm/qxl/qxl_kms.c                      |   15 +-
 drivers/gpu/drm/qxl/qxl_object.c                   |    2 +-
 drivers/gpu/drm/qxl/qxl_release.c                  |    2 +-
 drivers/gpu/drm/qxl/qxl_ttm.c                      |    8 +-
 drivers/gpu/drm/r128/ati_pcigart.c                 |    3 +-
 drivers/gpu/drm/radeon/Makefile                    |   35 +-
 drivers/gpu/drm/radeon/atom.c                      |    3 +-
 drivers/gpu/drm/radeon/ci_dpm.c                    |   14 -
 drivers/gpu/drm/radeon/radeon_atombios.c           |    4 +-
 drivers/gpu/drm/radeon/radeon_combios.c            |    4 +-
 drivers/gpu/drm/radeon/radeon_drv.c                |    2 +-
 drivers/gpu/drm/radeon/radeon_kms.c                |    4 +-
 drivers/gpu/drm/radeon/si_dpm.c                    |   18 -
 drivers/gpu/drm/rcar-du/rcar_du_drv.c              |    1 -
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c          |   14 +-
 drivers/gpu/drm/rcar-du/rcar_du_kms.c              |    4 +-
 drivers/gpu/drm/rcar-du/rcar_du_plane.c            |   16 +-
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c              |   14 +-
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |    9 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.c             |   13 +-
 drivers/gpu/drm/rockchip/cdn-dp-reg.c              |    6 +-
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c    |    8 +-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        |    8 +-
 drivers/gpu/drm/rockchip/inno_hdmi.c               |    8 +-
 drivers/gpu/drm/rockchip/rk3066_hdmi.c             |    8 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |   14 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h        |    1 +
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c         |   43 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  137 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h        |   17 +
 drivers/gpu/drm/rockchip/rockchip_lvds.c           |   10 +-
 drivers/gpu/drm/rockchip/rockchip_rgb.c            |    8 +-
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c        |   83 +-
 drivers/gpu/drm/shmobile/shmob_drm_crtc.c          |   14 +-
 drivers/gpu/drm/shmobile/shmob_drm_drv.c           |    2 -
 drivers/gpu/drm/shmobile/shmob_drm_kms.c           |    6 +-
 drivers/gpu/drm/sti/sti_compositor.c               |    6 +-
 drivers/gpu/drm/sti/sti_compositor.h               |    4 +-
 drivers/gpu/drm/sti/sti_crtc.c                     |    2 +-
 drivers/gpu/drm/sti/sti_cursor.c                   |   14 +-
 drivers/gpu/drm/sti/sti_drv.c                      |   16 +-
 drivers/gpu/drm/sti/sti_dvo.c                      |   13 +-
 drivers/gpu/drm/sti/sti_gdp.c                      |    7 +-
 drivers/gpu/drm/sti/sti_hda.c                      |   13 +-
 drivers/gpu/drm/sti/sti_hdmi.c                     |   13 +-
 drivers/gpu/drm/sti/sti_hqvdp.c                    |   12 +-
 drivers/gpu/drm/sti/sti_mixer.c                    |   10 +-
 drivers/gpu/drm/sti/sti_mixer.h                    |    2 +-
 drivers/gpu/drm/sti/sti_tvout.c                    |   13 +-
 drivers/gpu/drm/sti/sti_vid.c                      |    8 +-
 drivers/gpu/drm/sti/sti_vid.h                      |    2 +-
 drivers/gpu/drm/stm/drv.c                          |   10 +-
 drivers/gpu/drm/stm/ltdc.c                         |  102 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |   12 +-
 drivers/gpu/drm/sun4i/sun4i_lvds.c                 |   12 +-
 drivers/gpu/drm/sun4i/sun4i_rgb.c                  |   17 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |    4 +-
 drivers/gpu/drm/sun4i/sun4i_tv.c                   |   17 +-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c             |   12 +-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c              |    8 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.c                |  111 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.h                |   10 +-
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c             |   14 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c             |   40 +-
 drivers/gpu/drm/tegra/dc.c                         |   11 +-
 drivers/gpu/drm/tegra/dpaux.c                      |    2 -
 drivers/gpu/drm/tegra/drm.c                        |    8 +-
 drivers/gpu/drm/tegra/drm.h                        |    4 +-
 drivers/gpu/drm/tegra/dsi.c                        |   21 +-
 drivers/gpu/drm/tegra/fb.c                         |    2 +-
 drivers/gpu/drm/tegra/hdmi.c                       |   21 +-
 drivers/gpu/drm/tegra/output.c                     |    6 +-
 drivers/gpu/drm/tegra/rgb.c                        |    8 +-
 drivers/gpu/drm/tegra/sor.c                        |   20 +-
 drivers/gpu/drm/tidss/tidss_crtc.c                 |   16 +-
 drivers/gpu/drm/tidss/tidss_dispc.c                |   11 +-
 drivers/gpu/drm/tidss/tidss_dispc.h                |    6 -
 drivers/gpu/drm/tidss/tidss_drv.c                  |   25 +-
 drivers/gpu/drm/tidss/tidss_drv.h                  |    4 +-
 drivers/gpu/drm/tidss/tidss_encoder.c              |   10 +-
 drivers/gpu/drm/tidss/tidss_irq.c                  |   12 +-
 drivers/gpu/drm/tidss/tidss_kms.c                  |   21 +-
 drivers/gpu/drm/tidss/tidss_kms.h                  |    1 -
 drivers/gpu/drm/tidss/tidss_plane.c                |    6 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                |   20 +-
 drivers/gpu/drm/tilcdc/tilcdc_external.c           |   10 +-
 drivers/gpu/drm/tilcdc/tilcdc_panel.c              |    8 +-
 drivers/gpu/drm/tiny/Kconfig                       |   19 +
 drivers/gpu/drm/tiny/Makefile                      |    1 +
 drivers/gpu/drm/{cirrus =3D> tiny}/cirrus.c          |   82 +-
 drivers/gpu/drm/tiny/gm12u320.c                    |  242 +-
 drivers/gpu/drm/tiny/hx8357d.c                     |   16 +-
 drivers/gpu/drm/tiny/ili9225.c                     |   16 +-
 drivers/gpu/drm/tiny/ili9341.c                     |   16 +-
 drivers/gpu/drm/tiny/ili9486.c                     |   16 +-
 drivers/gpu/drm/tiny/mi0283qt.c                    |   16 +-
 drivers/gpu/drm/tiny/repaper.c                     |   28 +-
 drivers/gpu/drm/tiny/st7586.c                      |   16 +-
 drivers/gpu/drm/tiny/st7735r.c                     |   16 +-
 drivers/gpu/drm/ttm/ttm_bo.c                       |    4 +-
 drivers/gpu/drm/udl/udl_connector.c                |    4 +-
 drivers/gpu/drm/udl/udl_drv.c                      |   45 +-
 drivers/gpu/drm/udl/udl_drv.h                      |    2 -
 drivers/gpu/drm/udl/udl_main.c                     |   10 -
 drivers/gpu/drm/udl/udl_modeset.c                  |   31 +-
 drivers/gpu/drm/v3d/v3d_debugfs.c                  |   20 +-
 drivers/gpu/drm/v3d/v3d_drv.c                      |   53 +-
 drivers/gpu/drm/v3d/v3d_drv.h                      |    9 +-
 drivers/gpu/drm/v3d/v3d_gem.c                      |   17 +-
 drivers/gpu/drm/v3d/v3d_irq.c                      |   16 +-
 drivers/gpu/drm/v3d/v3d_mmu.c                      |   10 +-
 drivers/gpu/drm/v3d/v3d_sched.c                    |   10 +-
 drivers/gpu/drm/vboxvideo/vbox_drv.c               |   32 +-
 drivers/gpu/drm/vboxvideo/vbox_drv.h               |    1 +
 drivers/gpu/drm/vboxvideo/vbox_irq.c               |    2 +-
 drivers/gpu/drm/vboxvideo/vbox_main.c              |   29 +-
 drivers/gpu/drm/vboxvideo/vbox_mode.c              |   10 +-
 drivers/gpu/drm/vboxvideo/vbox_ttm.c               |   12 -
 drivers/gpu/drm/vc4/vc4_debugfs.c                  |   11 +-
 drivers/gpu/drm/vc4/vc4_dpi.c                      |    8 +-
 drivers/gpu/drm/vc4/vc4_drv.h                      |    2 +-
 drivers/gpu/drm/vc4/vc4_dsi.c                      |   15 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |   17 +-
 drivers/gpu/drm/vc4/vc4_vec.c                      |    8 +-
 drivers/gpu/drm/vgem/vgem_drv.c                    |   15 +-
 drivers/gpu/drm/virtio/virtgpu_debugfs.c           |    3 +-
 drivers/gpu/drm/virtio/virtgpu_display.c           |    8 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h               |   36 +-
 drivers/gpu/drm/virtio/virtgpu_gem.c               |   13 +-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c             |    1 -
 drivers/gpu/drm/virtio/virtgpu_object.c            |    7 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c                |    9 +-
 drivers/gpu/drm/vkms/vkms_drv.c                    |   21 +-
 drivers/gpu/drm/vkms/vkms_drv.h                    |    5 -
 drivers/gpu/drm/vkms/vkms_gem.c                    |   11 +-
 drivers/gpu/drm/vkms/vkms_output.c                 |    8 +-
 drivers/gpu/drm/xen/xen_drm_front.c                |    4 +-
 drivers/gpu/drm/zte/zx_hdmi.c                      |    8 +-
 drivers/gpu/drm/zte/zx_tvenc.c                     |    8 +-
 drivers/gpu/drm/zte/zx_vga.c                       |    8 +-
 drivers/video/fbdev/Kconfig                        |    2 +-
 drivers/video/fbdev/arcfb.c                        |   10 +-
 drivers/video/fbdev/atmel_lcdfb.c                  |    1 -
 drivers/video/fbdev/aty/aty128fb.c                 |   14 -
 drivers/video/fbdev/aty/atyfb_base.c               |    6 +-
 drivers/video/fbdev/controlfb.c                    |  825 +++---
 drivers/video/fbdev/core/fbmon.c                   |    2 +-
 drivers/video/fbdev/cyber2000fb.c                  |    2 +
 drivers/video/fbdev/i810/i810_main.c               |   10 +-
 drivers/video/fbdev/imxfb.c                        |   27 +-
 drivers/video/fbdev/matrox/g450_pll.c              |   22 -
 drivers/video/fbdev/matrox/matroxfb_base.h         |    2 +-
 drivers/video/fbdev/mb862xx/mb862xxfb_accel.c      |    2 -
 drivers/video/fbdev/mx3fb.c                        |   20 +-
 drivers/video/fbdev/omap/omapfb_main.c             |   14 +-
 drivers/video/fbdev/omap2/omapfb/dss/dispc.c       |  114 -
 drivers/video/fbdev/omap2/omapfb/dss/dss.h         |   20 -
 drivers/video/fbdev/omap2/omapfb/dss/venc.c        |   43 -
 drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c    |    8 +-
 drivers/video/fbdev/pm2fb.c                        |    2 +-
 drivers/video/fbdev/pm3fb.c                        |    8 +-
 drivers/video/fbdev/pxa168fb.c                     |    5 +-
 drivers/video/fbdev/riva/riva_hw.c                 |   18 -
 drivers/video/fbdev/s1d13xxxfb.c                   |   14 +-
 drivers/video/fbdev/sa1100fb.c                     |   20 +-
 drivers/video/fbdev/sa1100fb.h                     |    3 +
 drivers/video/fbdev/savage/savagefb.h              |    2 +-
 drivers/video/fbdev/ssd1307fb.c                    |  102 +-
 drivers/video/fbdev/udlfb.c                        |    6 +-
 drivers/video/fbdev/uvesafb.c                      |   14 +-
 drivers/video/fbdev/valkyriefb.c                   |    4 +-
 drivers/video/fbdev/vesafb.c                       |   16 +-
 drivers/video/fbdev/via/debug.h                    |    6 +-
 drivers/video/fbdev/via/viafbdev.c                 |    2 +-
 drivers/video/fbdev/vt8500lcdfb.c                  |    1 +
 drivers/video/fbdev/w100fb.c                       |    2 +
 drivers/video/hdmi.c                               |   65 +-
 include/drm/drm_client.h                           |    4 +-
 include/drm/drm_connector.h                        |    4 +-
 include/drm/drm_debugfs.h                          |   16 +-
 include/drm/drm_device.h                           |   24 +-
 include/drm/drm_displayid.h                        |    2 +-
 include/drm/drm_dp_helper.h                        |  177 +-
 include/drm/drm_dp_mst_helper.h                    |   86 +-
 include/drm/drm_drv.h                              |   44 +-
 include/drm/drm_encoder.h                          |    8 +-
 include/drm/drm_fb_helper.h                        |    6 +-
 include/drm/drm_file.h                             |   11 +
 include/drm/drm_framebuffer.h                      |   38 +
 include/drm/drm_gem_framebuffer_helper.h           |   15 +
 include/drm/drm_gem_vram_helper.h                  |    2 +-
 include/drm/drm_legacy.h                           |   15 +
 include/drm/drm_managed.h                          |  109 +
 include/drm/drm_mipi_dbi.h                         |    8 +-
 include/drm/drm_mm.h                               |    1 +
 include/drm/drm_mode_config.h                      |   18 +-
 include/drm/drm_modes.h                            |   11 -
 include/drm/drm_modeset_helper_vtables.h           |   27 +
 include/drm/drm_pci.h                              |   63 -
 include/drm/drm_print.h                            |    6 +
 include/drm/drm_writeback.h                        |    9 +
 include/drm/gpu_scheduler.h                        |    1 +
 include/drm/i915_pciids.h                          |    8 +-
 include/drm/ttm/ttm_bo_driver.h                    |    1 -
 include/drm/ttm/ttm_debug.h                        |   31 -
 include/linux/dma-buf.h                            |   10 +
 include/linux/hdmi.h                               |    2 +
 include/uapi/drm/amdgpu_drm.h                      |   19 +-
 include/uapi/drm/drm_fourcc.h                      |  140 +-
 include/uapi/drm/i915_drm.h                        |   24 +
 include/uapi/linux/kfd_ioctl.h                     |   21 +-
 mm/slob.c                                          |    2 +
 mm/slub.c                                          |    2 +
 1220 files changed, 41929 insertions(+), 21048 deletions(-)
 delete mode 100644
Documentation/devicetree/bindings/display/bridge/adi,adv7123.txt
 create mode 100644
Documentation/devicetree/bindings/display/bridge/chrontel,ch7033.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
 delete mode 100644
Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt
 create mode 100644
Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
 create mode 100644
Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
 create mode 100644
Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
 create mode 100644
Documentation/devicetree/bindings/display/bridge/snps,dw-mipi-dsi.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
 create mode 100644
Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/bridge/ti,ths813x.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.yam=
l
 create mode 100644
Documentation/devicetree/bindings/display/panel/asus,z00t-tm5p5-nt35596.yam=
l
 delete mode 100644
Documentation/devicetree/bindings/display/panel/boe,himax8279d.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/boe,himax8279d.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yam=
l
 delete mode 100644
Documentation/devicetree/bindings/display/panel/ilitek,ili9322.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/ilitek,ili9322.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/innolux,p097pfg.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/innolux,p097pfg.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/innolux,p120zdg-bf1.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/innolux,p120zdg-bf1.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/jdi,lt070me05000.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/jdi,lt070me05000.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.tx=
t
 create mode 100644
Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.ya=
ml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/kingdisplay,kd097d04.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/leadtek,ltk050h3146w.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/lg,acx467akm-7.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/lg,ld070wx3-sl01.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/lg,lg4573.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/lg,lg4573.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/lg,lh500wx1-sd03.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/osddisplays,osd101t2587-53t=
s.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/raydium,rm67191.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/samsung,amoled-mipi-dsi.yam=
l
 delete mode 100644
Documentation/devicetree/bindings/display/panel/samsung,ld9040.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/samsung,ld9040.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/samsung,s6d16d0.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/samsung,s6d16d0.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/samsung,s6e3ha2.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/samsung,s6e63j0x03.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/seiko,43wvf1g.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/seiko,43wvf1g.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/sharp,lq150x1lg11.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/sharp,lq150x1lg11.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/sharp,ls037v7dw01.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/sharp,ls037v7dw01.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/sharp,ls043t1le01.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/sharp,ls043t1le01.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/simple-panel.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/sitronix,st7701.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/sitronix,st7789v.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/sony,acx565akm.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/sony,acx565akm.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/startek,startek-kd050c.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/startek,startek-kd050c.yaml
 create mode 100644 Documentation/devicetree/bindings/display/panel/tpo,td.=
yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/tpo,td043mtea1.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/rockchip/rockchip,rk3066-hdmi.txt
 create mode 100644
Documentation/devicetree/bindings/display/rockchip/rockchip,rk3066-hdmi.yam=
l
 delete mode 100644
Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
 create mode 100644
Documentation/devicetree/bindings/display/rockchip/rockchip-vop.yaml
 create mode 100644 drivers/dma-buf/st-dma-fence-chain.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
 rename drivers/gpu/drm/amd/{display/dc/dml/dml_common_defs.h =3D>
amdgpu/amdgpu_fru_eeprom.h} (78%)
 mode change 100644 =3D> 100755 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
 mode change 100644 =3D> 100755 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
 rename drivers/gpu/drm/amd/display/dc/{basics/log_helpers.c =3D>
dce/dmub_abm.h} (75%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
 rename drivers/gpu/drm/amd/display/dmub/{inc =3D> }/dmub_srv.h (97%)
 delete mode 100644 drivers/gpu/drm/amd/display/modules/stats/stats.c
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/pwr/pwr_10_0_offse=
t.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/pwr/pwr_10_0_sh_ma=
sk.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/bridge/chrontel-ch7033.c
 create mode 100644 drivers/gpu/drm/bridge/nwl-dsi.c
 create mode 100644 drivers/gpu/drm/bridge/nwl-dsi.h
 delete mode 100644 drivers/gpu/drm/cirrus/Kconfig
 delete mode 100644 drivers/gpu/drm/cirrus/Makefile
 create mode 100644 drivers/gpu/drm/drm_managed.c
 delete mode 100644 drivers/gpu/drm/drm_vram_helper_common.c
 create mode 100644 drivers/gpu/drm/i915/gem/selftests/i915_gem_execbuffer.=
c
 delete mode 100644 drivers/gpu/drm/i915/gt/intel_engine_pool.h
 rename drivers/gpu/drm/i915/{i915_gem_fence_reg.c =3D>
gt/intel_ggtt_fencing.c} (88%)
 rename drivers/gpu/drm/i915/{i915_gem_fence_reg.h =3D>
gt/intel_ggtt_fencing.h} (86%)
 rename drivers/gpu/drm/i915/gt/{intel_engine_pool.c =3D>
intel_gt_buffer_pool.c} (53%)
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gt_buffer_pool.h
 rename drivers/gpu/drm/i915/gt/{intel_engine_pool_types.h =3D>
intel_gt_buffer_pool_types.h} (54%)
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gt_clock_utils.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gt_clock_utils.h
 create mode 100644 drivers/gpu/drm/i915/gt/selftest_rps.c
 create mode 100644 drivers/gpu/drm/i915/gt/selftest_rps.h
 create mode 100644 drivers/gpu/drm/i915/gt/shmem_utils.c
 create mode 100644 drivers/gpu/drm/i915/gt/shmem_utils.h
 create mode 100644 drivers/gpu/drm/i915/gt/st_shmem_utils.c
 create mode 100644 drivers/gpu/drm/i915/gt/uc/intel_guc_debugfs.c
 create mode 100644 drivers/gpu/drm/i915/gt/uc/intel_guc_debugfs.h
 create mode 100644 drivers/gpu/drm/i915/gt/uc/intel_guc_log_debugfs.c
 create mode 100644 drivers/gpu/drm/i915/gt/uc/intel_guc_log_debugfs.h
 create mode 100644 drivers/gpu/drm/i915/gt/uc/intel_huc_debugfs.c
 create mode 100644 drivers/gpu/drm/i915/gt/uc/intel_huc_debugfs.h
 create mode 100644 drivers/gpu/drm/i915/gt/uc/intel_uc_debugfs.c
 create mode 100644 drivers/gpu/drm/i915/gt/uc/intel_uc_debugfs.h
 create mode 100644 drivers/gpu/drm/i915/i915_config.c
 delete mode 100644 drivers/gpu/drm/i915/oa/i915_oa_bdw.c
 delete mode 100644 drivers/gpu/drm/i915/oa/i915_oa_bdw.h
 delete mode 100644 drivers/gpu/drm/i915/oa/i915_oa_bxt.c
 delete mode 100644 drivers/gpu/drm/i915/oa/i915_oa_bxt.h
 delete mode 100644 drivers/gpu/drm/i915/oa/i915_oa_cflgt2.c
 delete mode 100644 drivers/gpu/drm/i915/oa/i915_oa_cflgt2.h
 delete mode 100644 drivers/gpu/drm/i915/oa/i915_oa_cflgt3.c
 delete mode 100644 drivers/gpu/drm/i915/oa/i915_oa_cflgt3.h
 delete mode 100644 drivers/gpu/drm/i915/oa/i915_oa_chv.c
 delete mode 100644 drivers/gpu/drm/i915/oa/i915_oa_chv.h
 delete mode 100644 drivers/gpu/drm/i915/oa/i915_oa_cnl.c
 delete mode 100644 drivers/gpu/drm/i915/oa/i915_oa_cnl.h
 delete mode 100644 drivers/gpu/drm/i915/oa/i915_oa_glk.c
 delete mode 100644 drivers/gpu/drm/i915/oa/i915_oa_glk.h
 delete mode 100644 drivers/gpu/drm/i915/oa/i915_oa_hsw.c
 delete mode 100644 drivers/gpu/drm/i915/oa/i915_oa_hsw.h
 delete mode 100644 drivers/gpu/drm/i915/oa/i915_oa_icl.c
 delete mode 100644 drivers/gpu/drm/i915/oa/i915_oa_icl.h
 delete mode 100644 drivers/gpu/drm/i915/oa/i915_oa_kblgt2.c
 delete mode 100644 drivers/gpu/drm/i915/oa/i915_oa_kblgt2.h
 delete mode 100644 drivers/gpu/drm/i915/oa/i915_oa_kblgt3.c
 delete mode 100644 drivers/gpu/drm/i915/oa/i915_oa_kblgt3.h
 delete mode 100644 drivers/gpu/drm/i915/oa/i915_oa_sklgt2.c
 delete mode 100644 drivers/gpu/drm/i915/oa/i915_oa_sklgt2.h
 delete mode 100644 drivers/gpu/drm/i915/oa/i915_oa_sklgt3.c
 delete mode 100644 drivers/gpu/drm/i915/oa/i915_oa_sklgt3.h
 delete mode 100644 drivers/gpu/drm/i915/oa/i915_oa_sklgt4.c
 delete mode 100644 drivers/gpu/drm/i915/oa/i915_oa_sklgt4.h
 delete mode 100644 drivers/gpu/drm/i915/oa/i915_oa_tgl.c
 delete mode 100644 drivers/gpu/drm/i915/oa/i915_oa_tgl.h
 create mode 100644 drivers/gpu/drm/i915/selftests/librapl.c
 create mode 100644 drivers/gpu/drm/i915/selftests/librapl.h
 create mode 100644 drivers/gpu/drm/lima/lima_devfreq.c
 create mode 100644 drivers/gpu/drm/lima/lima_devfreq.h
 create mode 100644 drivers/gpu/drm/lima/lima_dump.h
 create mode 100644 drivers/gpu/drm/lima/lima_trace.c
 create mode 100644 drivers/gpu/drm/lima/lima_trace.h
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/capsgv100.c
 rename drivers/gpu/drm/{amd/display/dc/dml/dml_common_defs.c =3D>
nouveau/nvkm/engine/disp/hdagv100.c} (76%)
 create mode 100644 drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c
 create mode 100644 drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
 create mode 100644 drivers/gpu/drm/panel/panel-visionox-rm69299.c
 delete mode 100644 drivers/gpu/drm/pl111/pl111_vexpress.c
 delete mode 100644 drivers/gpu/drm/pl111/pl111_vexpress.h
 rename drivers/gpu/drm/{cirrus =3D> tiny}/cirrus.c (91%)
 create mode 100644 include/drm/drm_managed.h
 delete mode 100644 include/drm/drm_pci.h
 delete mode 100644 include/drm/ttm/ttm_debug.h
