Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7B8C2D0F3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 05:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5F02074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 05:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hv1/8Naq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbgDAFvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 01:51:03 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:40988 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731735AbgDAFvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 01:51:02 -0400
Received: by mail-ot1-f44.google.com with SMTP id f52so24725536otf.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 22:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=JVLOEG8o2vIOrbnjJvcd0HX1ahlK5NmHfBFkDPMtWjk=;
        b=Hv1/8NaqaE8gbrpWMnhkM7IKs0vL1RRKhoYQx77Z+4yXve0WpvmIYYemjOhNcXcssE
         SBRFgd3OZT+VEOqt8PekQy00UzMJ0GaJQVpHyZxOXbUjsrYVSNWZIg+RtnC8HjsmNBIP
         hvFISfWJ8j3GaftphEHtNpXyQx3Kp6BC1AVX2Q2XwX65g9uWPel29oUsdm2YlYbLsdSl
         IA5IOPCX3nfyjRjiQ8KKGyrWrSafG0vWSHDdDmOW3d19xF/xzdHNpVBcAuohpnp1hZVL
         KpZSGY+BQ38WDks236fOjNbAZwsHCS6YlCnSvxBt2A5iDM+UD84PLDRGEpr/Eocej+Vx
         Wu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=JVLOEG8o2vIOrbnjJvcd0HX1ahlK5NmHfBFkDPMtWjk=;
        b=f55/jhenj0Xufc0urjDKAjMNtwJixGO55VkBz8BLGXPBBRTCcC0JFmZkJhivcct3Wa
         GDvNYiHQhQvWkL2R0+qMWU4bQ3KeWtfT3TPG3/nQenhBBlFZbRXY8w0+/nqz1jKSvsKe
         3PyxWXkATcr6aTRYe4e4PJ4P/nnv3wvARv+6ExvhqWel4qOW1JZi3bEXmKe0j1THFoi9
         4LxjsEVqZ/wkvQAlJBLbfDDRloAJZQIu1koiKETKQziEE78Nuqa4isAs0nrn3bljDtNj
         PIZKw/2ZI2SXa4T6gL3xHN/I+QLuTFm7vRDQHxmlD6fw9+q4vpgJlW21K4pKsfCooKM2
         RfAw==
X-Gm-Message-State: ANhLgQ3tTn/zhNshgf7GXblhlrKoaWIIN/vLP+6sJVvWWIxIRxHd3d1H
        Ox4VZ+eOFkeSYHC8GDl0VjvGxuZMTYq6BOchEZ7u3nGkcLU=
X-Google-Smtp-Source: ADFU+vsp2SUQYog5L73xrB62IYCkGyWDPiyswI/VY/r1udnrEY68QN7tkveq5RaTwEt688qBFcqUkdqCZUuCg57LH+o=
X-Received: by 2002:a4a:6f0d:: with SMTP id h13mr15481482ooc.99.1585720255869;
 Tue, 31 Mar 2020 22:50:55 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 1 Apr 2020 15:50:42 +1000
Message-ID: <CAPM=9twza_DeycOEhT+u6Erh0yFTAUe447J6bxWCLq5+QW8ZaA@mail.gmail.com>
Subject: [git pull] drm for 5.7-rc1
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

This is the main drm pull request for 5.7-rc1.

Writing the changelog seemed a bit quieter, but it looks about average.

I've got a separate merge for some VM interactions for TTM huge pages, but =
I'll
send that once this is landed.

It didn't seem to have many major conflicts, but my git trees have a bad ha=
bit
of finding the shared rerere cache and lulling me into thinking it merged f=
ine.

Highlights:
i915 enables Tigerlake by default
i915 and amdgpu have initial OLED backlight support
vmwgfx add support to enable OpenGL 4 userspace
zero length arrays are mostly removed.

Regards,
Dave.

new driver:
tidss - TI Keystone platform display subsystem

core:
- new drm device warn macros
- mode config valid for memory constrained devices
- bridge bus format negotation
- consolidated fake vblank event handling
- dma_alloc related cleanups
- drop get_crtc callback
- dp: DP1.4 EDID corruption test
- EDID CEA detailed timings improvements
- relicense some code to dual GPL2/MIT
- convert core vblank support to per-crtc support
- rework drm_global_mutex
- bridge rework to allow omap_dss custom driver removeal
- remove drm_fb_helper connector interrfaces
- zero-length array removal

scheduler:
- support for modifying the sched list
- revert job distribution optimization
- helper to pick least loaded scheduler
- race condition fix

mst:
- various fixes
- remove register_connector callback

i915:
- uapi to allows userspace specific CS ring buffer sizes
- Tigerlake enablement patches + Tigerlake enabled by default
- new sysfs entries for engine properties
- display/logging refactors
- eDP/DP fixes for DPCD
- Gen7 back to aliasing-ppgtt
- Gen8+ irq refactor
- Avoid globals
- GEM locking fixes and simplifications
- Ice Lake and Elkhart Lake fixes and workarounds
- Baytrail/Haswell instability fix
- GVT - VFIO edid better support

amdgpu:
- Rework VM update handling in preparation for HMM support
- drm load/unload removal fixups
- USB-C PD firmware updates
- HDCP srm support
- Navi/renoir PM watermark fixes
- OLED panel support
- Optimize debugging vram access
- Use BACO for runtime pm
- DC clock programming optimizations and fixes
- PSP fw loading sequence updates
- Drop DRIVER_USE_AGP
- Remove legacy drm load and unload callbacks
- ACP Kconfig fix
- Lots of fixes across the driver

amdkfd:
- runtime pm support
- more gfx config details in amdgpu

radeon:
- drop DRIVER_USE_AGP

vmwgfx:
- Disable DMA when SEV encryption in use
- Shader Model 5 support - needed for GL4 support

msm:
- DPU resource manager refactor
- dpu using atomic global state

mediatek:
- MT8183 DPI support

etnaviv:
- out-of-bounds read fix
- expose feature flags for GC400 STM32MP1 SoC
- runtime suspend entry fix
- dma32 zone fix

hisilicon:
- mode selection fixes

meson:
- YUV420 support

lima:
- add support for heap buffers

tinydrm:
- removal of owner field
- explicit DT dependency removal
- YAML schema conversion

tegra:
- misc cleanups

tidss:
- new driver

virtio:
- better batching of notifications to host
- memory handling reworked
- shmem + gpu context fixes

hibmc:
- add gamma_set support
- improve DPMS support

pl111:
- Integrator IM-PD1 support

sun4i:
- LVDS support for A20 + A33
- DSI panel handling improvements

drm-next-2020-04-01:
drm for 5.7-rc1
The following changes since commit 7111951b8d4973bda27ff663f2cf18b663d15b48=
:

  Linux 5.6 (2020-03-29 15:25:41 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-04-01

for you to fetch changes up to 59e7a8cc2dcf335116d500d684bfb34d1d97a6fe:

  Merge tag 'drm-msm-next-2020-03-22' of
https://gitlab.freedesktop.org/drm/msm into drm-next (2020-03-31
16:34:55 +1000)

----------------------------------------------------------------
drm for 5.7-rc1

----------------------------------------------------------------
Abdiel Janulgue (1):
      drm/i915/phys: unconditionally call release_memory_region

Aditya Swarup (1):
      drm/i915/selftests: Fix uninitialized variable

Akeem G Abodunrin (1):
      drm/mm: Remove redundant assignment in drm_mm_reserve_node

Alex Deucher (36):
      drm/amdgpu: update smu_v11_0_pptable.h
      drm/amdgpu:/navi10: use the ODCAP enum to index the caps array
      drm/amdgpu: add flag for runtime suspend
      drm/amdgpu/smu: properly handle runpm/suspend/reset
      drm/amdgpu/powerplay: fix baco check for vega20
      drm/amdgpu/runpm: enable runpm on baco capable VI+ asics
      drm/amdgpu/display: extend DCN guard in
dal_bios_parser_init_cmd_tbl_helper2
      drm/amdgpu/display: extend DCN guards
      drm/amdgpu/display move get_num_odm_splits() into dc_resource.c
      drm/amdgpu/soc15: fix xclk for raven
      drm/amdgpu/gfx9: disable gfxoff when reading rlc clock
      drm/amdgpu/gfx10: disable gfxoff when reading rlc clock
      drm/amdgpu/discovery: make the discovery code less chatty
      drm/amdgpu/display: clean up hdcp workqueue handling
      drm/amdgpu: rename amdgpu_debugfs_preempt_cleanup
      drm/amdgpu/ttm: move debugfs init into core amdgpu debugfs
      drm/amdgpu/pm: move debugfs init into core amdgpu debugfs
      drm/amdgpu/sa: move debugfs init into core amdgpu debugfs
      drm/amdgpu/fence: move debugfs init into core amdgpu debugfs
      drm/amdgpu/gem: move debugfs init into core amdgpu debugfs
      drm/amdgpu/regs: move debugfs init into core amdgpu debugfs
      drm/amdgpu/firmware: move debugfs init into core amdgpu debugfs
      drm/amdgpu/ring: move debugfs init into core amdgpu debugfs
      drm/amdgpu: don't call drm_connector_register for non-MST ports
      drm/amdgpu/display: move debugfs init into core amdgpu debugfs (v2)
      drm/amd/display: move dpcd debugfs members setup
      drm/amdgpu/display: add a late register connector callback
      drm/amdgpu/display: split dp connector registration (v4)
      drm/amdgpu/display: don't call drm_dp_mst_connector_late_register (v2=
)
      drm/amdgpu: drop legacy drm load and unload callbacks
      drm/amdgpu/smu11: add a helper to set the power source
      drm/amdgpu/swSMU: use the smu11 power source helper for navi1x
      drm/amdgpu/swSMU: set AC/DC mode based on the current system state (v=
2)
      drm/amdgpu/swSMU: handle DC controlled by GPIO for navi1x
      drm/amdgpu/swSMU: handle manual AC/DC notifications
      drm/amdgpu/smu11: add support for SMU AC/DC interrupts

Alvin Lee (3):
      drm/amd/display: Update TX masks correctly
      drm/amd/display: Disable PG on NV12
      drm/amd/display: Update TTU properly

Aly-Tawfik (2):
      drm/amdgpu/display: fix pci revision id fetching
      drm/amdgpu/display: Fix Pollock Variant Detection

Amber Lin (1):
      drm/amdkfd: Add queue information to sysfs

Andrey Grodzovsky (7):
      drm/amdgpu: Add USBC PD FW load interface to PSP.
      drm/amdgpu: Add USBC PD FW load to PSP 11
      drm/amdgpu: Add support for USBC PD FW download
      drm/amdgpu: Wrap clflush_cache_range with x86 ifdef
      drm/amdgpu: Fix GPU reset error.
      drm/amdgpu: Enter low power state if CRTC active.
      drm/amdgpu: Move EEPROM I2C adapter to amdgpu_device

Andrey Lebedev (4):
      drm/sun4i: tcon: Introduce LVDS setup routine setting
      dt-bindings: display: sun4i: New compatibles for A20 tcons
      drm/sun4i: tcon: Separate quirks for tcon0 and tcon1 on A20
      drm/sun4i: tcon: Support LVDS output on Allwinner A20

Andy Shevchenko (5):
      drm/tiny/repaper: Make driver OF-independent
      drm/tiny/repaper: No need to set ->owner for spi_register_driver()
      drm/tiny/st7735r: Make driver OF-independent
      drm/tiny/st7735r: No need to set ->owner for spi_register_driver()
      fbdev: simplefb: Platform data shan't include kernel.h

Anshuman Gupta (11):
      drm/i915: HDCP support on above PORT_E
      drm/i915: Iterate over pipes and skip the disabled one
      drm/i915: Remove (pipe =3D=3D crtc->index) assumption
      drm/i915: Fix broken transcoder err state
      drm/i915: Get first crtc instead of PIPE_A crtc
      drm/i915: Add WARN_ON in intel_get_crtc_for_pipe()
      drm/i915: Fix broken num_entries in skl_ddb_allocation_overlaps
      drm/i915: Fix wrongly populated plane possible_crtcs bit mask
      drm/i915: Fix kbuild test robot build error
      drm/i915/hdcp: Mandate (seq_num_V=3D=3D0) at first RecvId msg
      drm/i915/hdcp: Fix config_stream_type() ret value

Anthony Koo (7):
      drm/amd/display: Split program front end part that occur outside lock
      drm/amd/display: Indicate dsc updates explicitly
      drm/amd/display: Added locking for atomic update stream and update pl=
anes
      drm/amd/display: Update register defines
      drm/amd/display: 3.2.72
      drm/amd/display: Add function pointers for panel related hw functions
      drm/amd/display: make some rn_clk_mgr structs and funcs static

Anusha Srivatsa (1):
      drm/i915/tgl: Extend Wa_1606931601 for all steppings

Aric Cyr (11):
      drm/amd/display: Fix GSL acquire
      drm/amd/display: remove unused variable
      drm/amd/display: 3.2.70
      drm/amd/display: Check engine is not NULL before acquiring
      drm/amd/display: 3.2.71
      drm/amd/display: dal_ddc_i2c_payloads_create can fail causing panic
      drm/amd/display: Only round InfoFrame refresh rates
      drm/amd/display: 3.2.73
      drm/amd/display: 3.2.74
      drm/amd/display: 3.2.75
      drm/amd/display: 3.2.76

Arnd Bergmann (2):
      drm: panel: fix excessive stack usage in td028ttec1_prepare
      drm/drm_panel: fix export of drm_panel_of_backlight, try #3

Bartlomiej Zolnierkiewicz (7):
      video: fbdev: sh_mobile_lcdcfb: fix sparse warnings about using
incorrect types
      video: fbdev: sh_mobile_lcdcfb: add COMPILE_TEST support
      video: fbdev: arcfb: add COMPILE_TEST support
      video: fbdev: w100fb: fix sparse warnings
      video: fbdev: w100fb: add COMPILE_TEST support
      video: fbdev: wm8505fb: fix sparse warnings about using incorrect typ=
es
      video: fbdev: wm8505fb: add COMPILE_TEST support

Benjamin Gaignard (9):
      drm: fix parameters documentation style in drm_dma
      dt-bindings: panel: Convert raydium,rm68200 to json-schema
      dt-bindings: panel: Convert orisetech,otm8009a to json-schema
      drm/dp_mst: Fix W=3D1 warnings
      drm/dp_mst: Check crc4 value while building sideband message
      drm: context: Clean up documentation
      drm: vm: Clean up documentation
      drm: bufs: Clean up documentation
      drm: lock: Clean up documentation

Bhawanpreet Lakha (11):
      drm/amd/display: Pass amdgpu_device instead of psp_context
      drm/amd/display: update psp interface header
      drm/amd/display: Add sysfs interface for set/get srm
      drm/amd/display: Load srm before enabling HDCP
      drm/amd/display: call psp set/get interfaces
      drm/amd/display: Handle revoked receivers
      drm/amd/display: fix backwards byte order in rx_caps.
      drm/amd/display: Fix message for encryption
      drm/amd/display: fix dtm unloading
      drm/amd/display: Fix HDMI repeater authentication
      drm/amd/display: Clear link settings on MST disable connector

Bo YU (1):
      drm/drm_dp_mst:remove set but not used variable 'origlen'

Bogdan Togorean (3):
      drm: bridge: adv7511: Remove DRM_I2C_ADV7533 Kconfig
      drm: bridge: adv7511: Add support for ADV7535
      dt-bindings: drm: bridge: adv7511: Add ADV7535 support

Boris Brezillon (10):
      drm/bridge: Add a drm_bridge_state object
      drm/rcar-du: Plug atomic state hooks to the default implementation
      drm/bridge: analogix: Plug atomic state hooks to the default
implementation
      drm/bridge: Patch atomic hooks to take a drm_bridge_state
      drm/bridge: Add an ->atomic_check() hook
      drm/bridge: Add the necessary bits to support bus format negotiation
      drm/imx: pd: Use bus format/flags provided by the bridge when availab=
le
      drm/panel: simple: Fix the lt089ac29000 bus_format
      drm/bridge: Fix the bridge kernel doc
      drm/bridge: panel: Propagate bus format/flags

Braden Bakker (1):
      drm/amd/display: Add registry for mem pwr control

Brian Masney (1):
      dt-bindings: display: msm: gmu: move sram property to gpu bindings

Calvin Hou (1):
      drm/amd/display: Pass override OUI in to dc_init_data

Caz Yokoyama (1):
      Revert "drm/i915/tgl: Add extra hdc flush workaround"

Charlene Liu (2):
      drm/amd/display: add stream_enc_inst for PSP HDCP inst use
      drm/amd/display: guard DPPHY_Internal_ctrl

Chen Zhou (1):
      drm/amd/powerplay: Use bitwise instead of arithmetic operator for fla=
gs

Chengming Gui (2):
      drm/amdgpu: add lock option for smu_set_soft_freq_range()
      drm/amdgpu: Add debugfs interface to set arbitrary sclk for navi14 (v=
2)

Chia-I Wu (9):
      drm/virtio: fix a wait_event condition
      drm/virtio: remove incorrect ENOSPC check
      drm/virtio: add virtio_gpu_vbuf_ctrl_hdr
      drm/virtio: no need to pass virtio_gpu_ctrl_hdr
      drm/virtio: unlock object array on errors
      drm/virtio: set up virtqueue sgs before locking
      drm/virtio: move locking into virtio_gpu_queue_ctrl_sgs
      drm/virtio: move the check for vqs_ready earlier
      drm/virtio: move virtqueue_notify into virtio_gpu_queue_ctrl_sgs

Chris Wilson (211):
      drm/i915/pmu: Correct the rc6 offset upon enabling
      drm/i915/gt: Clear rc6 residency trackers across suspend
      drm/i915/gem: Take local vma references for the parser
      drm/i915/selftests: Add a mock i915_vma to the mock_ring
      drm/i915/gt: Use the BIT when checking the flags, not the index
      drm/i915/execlists: Leave resetting ring to intel_ring
      drm/i915/gt: Drop rogue space in the middle of GT_TRACE
      drm/i915: Keep track of request among the scheduling lists
      drm/i915/gt: Allow temporary suspension of inflight requests
      drm/i915/execlists: Offline error capture
      drm/i915: Include the debugfs params header for its own definition
      drm/i915: Fix typo in kerneldoc function name
      drm/i915: Satisfy smatch that a loop has at least one iteration
      drm/i915/gt: Report the currently active execlists request
      drm/i915/gt: Be paranoid and reset the GPU before release
      drm/i915/gem: Store mmap_offsets in an rbtree rather than a plain lis=
t
      drm/i915: Don't show the blank process name for internal/simulated er=
rors
      drm/i915: Clear the GGTT_WRITE bit on unbinding the vma
      drm/i915/gt: Include a tell-tale for engine parking
      drm/i915/execlists: Take a reference while capturing the guilty reque=
st
      drm/i915/execlists: Reclaim the hanging virtual request
      drm/i915: Mark the removal of the i915_request from the sched.link
      drm/i915/gem: Convert vm idr to xarray
      drm/i915/gem: Detect overflow in calculating dumb buffer size
      drm/i915/selftests: Show the RC6 residency on parking failure
      drm/i915/gem: Prevent NULL pointer dereference on missing ctx->vm
      drm/i915: Check activity on i915_vma after confirming pin_count=3D=3D=
0
      drm/i915: Wait on vma activity before taking the mutex
      drm: Release filp before global lock
      drm: Avoid drm_global_mutex for simple inc/dec of dev->open_count
      drm/i915/gt: Flush engine parking before release
      drm/i915/gt: Poison GTT scratch pages
      drm/i915/tgl: Re-enable RPS
      drm/i915/display: Squelch kerneldoc complaints
      drm/i915: Stub out i915_gpu_coredump_put
      drm/i915: Remove 'prefault_disable' modparam
      drm/i915: Tighten atomicity of i915_active_acquire vs i915_active_rel=
ease
      drm/i915: Restore the kernel context after verifying the w/a
      drm/i915/gt: Acquire ce->active before ce->pin_count/ce->pin_mutex
      drm/i915: Skip capturing errors from internal contexts
      drm/i915/gt: Reorganise gen8+ interrupt handler
      drm/i915/gt: Tidy repetition in declaring gen8+ interrupts
      drm/i915/gt: Lift set-wedged engine dumping out of user paths
      drm/i915/trace: i915_request.prio is a signed value
      drm/i915/selftests: Lock the drm_mm as we search
      drm/i915/execlist: Mark up racy read of execlists->pending[0]
      drm/i915/gt: Hook up CS_MASTER_ERROR_INTERRUPT
      drm/i915/execlists: Ignore discrepancies in pending[] across resets
      drm/i915/gt: Skip global serialisation of clear_range for bxt vtd
      drm/i915/fbc: __intel_fbc_cleanup_cfb() may be called multiple times
      drm/i915/gem: Tighten checks and acquiring the mmap object
      drm/i915/gt: Rename i915_gem_restore_ggtt_mappings() for its new plac=
ement
      drm/i915: Use the async worker to avoid reclaim tainting the ggtt->mu=
tex
      drm/i915/gem: Require per-engine reset support for non-persistent con=
texts
      drm/i915/gt: Also use async bind for PIN_USER into bsw/bxt ggtt
      drm/i915/selftests: Also wait for the scratch buffer to be bound
      drm/i915/selftests: Disable heartbeat around hang tests
      drm/i915/gt: Skip rmw for masked registers
      drm/i915: Hold reference to previous active fence as we queue
      drm/i915: Initialise basic fence before acquiring seqno
      drm/i915/gt: Warn about the hidden i915_vma_pin in timeline_get_seqno
      drm/i915/audio: Skip the cdclk modeset if no pipes attached
      drm/i915/display: Fix NULL-crtc deref in calc_min_cdclk()
      drm/i915/display: Defer application of initial chv_phy_control
      drm/i915/selftests: Add a simple rollover test for the kernel context
      drm/i915/selftest: Ensure string fits within name[]
      drm/i915/gt: Pull sseu context updates under gt
      drm/i915: Wean off drm_pci_alloc/drm_pci_free
      drm/i915/gt: Fix rc6 on Ivybridge
      drm: Remove PageReserved manipulation from drm_pci_alloc
      drm: Remove the dma_alloc_coherent wrapper for internal usage
      drm/i915/display: Explicitly cleanup initial_plane_config
      drm/i915/display: Be explicit in handling the preallocated vma
      drm/i915: Mark i915.reset as unsigned
      drm/i915: Flush execution tasklets before checking request status
      drm/i915/gt: Set the PP_DIR registers upon enabling ring submission
      drm/i915/gt: Prevent queuing retire workers on the virtual engine
      drm/i915/gt: Protect defer_request() from new waiters
      drm/i915/gt: Protect execlists_hold/unhold from new waiters
      drm/i915: Fix force-probe failure message
      drm/i915/gt: Use the kernel_context to measure the breadcrumb size
      drm/i915/gt: Only ignore already reset requests
      drm/i915/execlists: Always force a context reload when rewinding RING=
_TAIL
      drm/i915/gt: Fix hold/unhold recursion
      drm/i915/execlists: Ignore tracek for nop process_csb
      drm/i915/selftests: Remove erroneous intel_engine_pm_put
      drm/i915/selftests: Disable capturing forced error states
      drm/i915/selftests: Drop live_preempt_hang
      drm/i915/selftests: Trim blitter block size
      drm/i915: Skip CPU synchronisation on dmabuf attachments
      drm/i915/gt: Avoid resetting ring->head outside of its timeline mutex
      drm/i915/selftests: Relax timeout for error-interrupt reset processin=
g
      drm/i915: Disable use of hwsp_cacheline for kernel_context
      drm/i915/gem: Don't leak non-persistent requests on changing engines
      drm/i915: Poison rings after use
      drm/i915/selftests: Sabotague the RING_HEAD
      drm/i915/selftests: Avoid choosing zero for phys_sz
      drm/i915/gt: Expand bad CS completion event debug
      drm/i915/gt: Suppress warnings for unused debugging locals
      drm/i915/selftests: Exercise timeslice rewinding
      drm/i915/selftests: Check for the error interrupt before we wait!
      drm/i915: Avoid potential division-by-zero in computing CS
timestamp period
      drm/i915/gt: Rearrange code to silence compiler
      drm/i915/selftests: Mark the mock ring->vma as being in the GGTT
      drm/i915/selftests: Check for any sign of request starting in
wait_for_submit()
      drm/i915/gt: Fix up missing error propagation for heartbeat pulses
      drm/i915/selftests: Flush tasklet on wait_for_submit()
      drm/i915/gt: Show the cumulative context runtime in engine debug
      drm/i915/gt: Refactor l3cc/mocs availability
      drm/i915: Read rawclk_freq earlier
      drm/i915/selftest: Analyse timestamp behaviour across context switche=
s
      drm/i915/selftests: Mark GPR checking more hostile
      drm/i915/gt: Do not attempt to reprogram IA/ring frequencies for dgfx
      drm/i915/gt: Protect signaler walk with RCU
      drm/i915: Double check bumping after the spinlock
      drm/i915/gem: Break up long lists of object reclaim
      drm/i915: Check that the vma hasn't been closed before we insert it
      drm/i915: Avoid recursing onto active vma from the shrinker
      drm/i915/gt: Push the GPU cancellation to the backend
      drm/i915/display: Fix inverted WARN_ON
      drm/i915/gtt: Downgrade gen7 (ivb, byt, hsw) back to aliasing-ppgtt
      drm/i915/gem: Cleanup shadow batch after I915_EXEC_SECURE
      drm/i915: Drop assertion that active->fence is unchanged
      drm/i915: Flush idle barriers when waiting
      drm/i915: Allow userspace to specify ringsize on construction
      drm/i915/gem: Honour O_NONBLOCK before throttling execbuf submissions
      drm/i915: Skip barriers inside waits
      drm/i915/selftests: Disable heartbeat around manual pulse tests
      drm/i915/gt: Check engine-is-awake on reset later
      drm/i915/gt: Pull marking vm as closed underneath the vm->mutex
      drm/i915/selftests: Verify LRC isolation
      drm/i915/selftests: Check recovery from corrupted LRC
      drm/i915: Protect i915_request_await_start from early waits
      drm/i915/perf: Mark up the racy use of perf->exclusive_stream
      drm/i915/perf: Manually acquire engine-wakeref around use of
kernel_context
      drm/i915/selftests: Wait for the context switch
      drm/i915/selftests: Be a little more lenient for reset workers
      drm/i915/gt: Reset queue_priority_hint after wedging
      drm/i915/gt: Expose engine properties via sysfs
      drm/i915/gt: Expose engine->mmio_base via sysfs
      drm/i915/gt: Expose timeslice duration to sysfs
      drm/i915/gt: Expose busywait duration to sysfs
      drm/i915/gt: Expose reset stop timeout via sysfs
      drm/i915/gt: Expose preempt reset timeout via sysfs
      drm/i915/gt: Expose heartbeat interval via sysfs
      drm/i915/perf: Reintroduce wait on OA configuration completion
      drm/i915/execlists: Check the sentinel is alone in the ELSP
      drm/i915: Fix doclinks
      drm/i915/gem: Consolidate ctx->engines[] release
      drm/i915/gt: Prevent allocation on a banned context
      drm/i915/gem: Check that the context wasn't closed during setup
      drm/i915: Drop vma is-closed assertion on insert
      drm/i915/gt: Drop the timeline->mutex as we wait for retirement
      drm/i915: Drop inspection of execbuf flags during evict
      drm/i915/gem: Extract transient execbuf flags from i915_vma
      drm/i915/gem: Only call eb_lookup_vma once during execbuf ioctl
      drm/i915/gvt: Inlcude intel_gvt.h where needed
      drm/i915: Apply i915_request_skip() on submission
      drm/i915/gt: Propagate change in error status to children on unhold
      drm/i915/gt: Cancel banned contexts after GT reset
      drm/i915: Actually emit the await_start
      drm/i915: Return early for await_start on same timeline
      drm/i915/execlists: Show the "switch priority hint" in dumps
      drm/i915/gvt: cleanup debugfs scan_nonprivbb
      drm/i915/gvt: Wean gvt off dev_priv->engine[]
      drm/i915/gvt: Wean gvt off using dev_priv
      drm/i915: Assert requests within a context are submitted in order
      drm/i915: Always propagate the invocation to i915_schedule
      drm/i915/gem: Limit struct_mutex to eb_reserve
      drm/mm: Break long searches in fragmented address spaces
      drm/i915: Do not poison i915_request.link on removal
      drm/i915/selftests: Apply a heavy handed flush to i915_active
      drm/i915/execlists: Enable timeslice on partial virtual engine dequeu=
e
      drm/i915/gt: Close race between cacheline_retire and free
      drm/i915/gt: Wait for the wa batch to be pinned
      drm: Make drm_pci_agp_init legacy
      drm/i915/gt: Mark up intel_rps.active for racy reads
      drm/i915: Mark racy read of intel_engine_cs.saturated
      drm/i915/execlists: Mark up the racy access to switch_priority_hint
      drm/i915: Mark up unlocked update of i915_request.hwsp_seqno
      drm/i915/gt: Mark up racy check of last list element
      drm/i915/execlists: Mark up read of i915_request.fence.flags
      drm/i915/execlsts: Mark up racy inspection of current
i915_request priority
      drm/i915/gt: Mark up intel_rps.active for racy reads
      drm/i915/gt: Defend against concurrent updates to execlists->active
      drm/i915: Improve the start alignment of bonded pairs
      drm/i915: Defer semaphore priority bumping to a workqueue
      drm/i915: Tweak scheduler's kick_submission()
      drm/i915/gt: Mark up racy reads for intel_context.inflight
      drm/i915: Mark up racy read of active rq->engine
      drm/i915/execlists: Mark up data-races in virtual engines
      drm/i915: Extend i915_request_await_active to use all timelines
      drm/i915/gt: Pull checking rps->pm_events under the irq_lock
      drm/i915/execlists: Track active elements during dequeue
      drm/i915/gem: Mark up the racy read of the mmap_singleton
      drm/i915/gem: Mark up sw-fence notify function
      drm/i915/gem: Take a copy of the engines for context_barrier_task
      drm/i915/gem: Drop relocation slowpath
      drm/i915/selftests: Use igt_random_offset()
      drm/i915/gt: Wait for RCUs frees before asserting idle on unload
      drm/i915/selftest: Add more poison patterns
      drm/mm: Allow drm_mm_initialized() to be used outside of the locks
      drm: Mark up racy check of drm_gem_object.handle_count
      drm/i915/gt: Restrict gen7 w/a batch to Haswell
      drm/i915/gem: Check for a closed context when looking up an engine
      drm/i915: Use explicit flag to mark unreachable intel_context
      drm/i915/gt: Cancel a hung context if already closed
      drm/i915/gt: Treat idling as a RPS downclock event
      drm/i915: Avoid live-lock with i915_vma_parked()
      drm/i915/gt: Select the deepest available parking mode for rc6
      drm/i915/gt: Stage the transfer of the virtual breadcrumb

Christian Gmeiner (7):
      drm/etnaviv: update hardware headers from rnndb
      drm/etnaviv: determine product, customer and eco id
      drm/etnaviv: show identity information in debugfs
      drm/etnaviv: update gc7000 chip identity entry
      drm/etnaviv: update hwdb selection logic
      drm/etnaviv: add hwdb entry for gc400 found in STM32
      drm/etnaviv: rework perfmon query infrastructure

Christian K=C3=B6nig (31):
      drm/ttm: nuke invalidate_caches callback
      drm/amdgpu: explicitly sync VM update to PDs/PTs
      drm/amdgpu: use the VM as job owner
      drm/amdgpu: rework job synchronization v2
      drm/amdgpu: stop using amdgpu_bo_gpu_offset in the VM backend
      drm/amdgpu: drop unnecessary restriction for huge root PDEs
      drm/amdgpu: make sure to never allocate PDs/PTs for invalidations
      drm/amdgpu: fix parentheses in amdgpu_vm_update_ptes
      drm/amdgpu: return EINVAL instead of ENOENT in the VM code
      drm/amdgpu: allow higher level PD invalidations
      drm/amdgpu: simplify and fix amdgpu_sync_resv
      drm/amdgpu: rework synchronization of VM updates v4
      drm/amdgpu: optimize amdgpu_device_vram_access a bit.
      drm/amdgpu: use the BAR if possible in amdgpu_device_vram_access v2
      drm/amdgpu: use amdgpu_device_vram_access in amdgpu_ttm_vram_read
      drm/amdgpu: use amdgpu_device_vram_access in amdgpu_ttm_access_memory=
 v2
      drm/ttm: refine ghost BO resv criteria
      drm/ttm: cleanup ttm_buffer_object_transfer
      drm/ttm: use RCU in ttm_bo_flush_all_fences
      drm/ttm: rework BO delayed delete. v2
      drm/ttm: replace dma_resv object on deleted BOs v3
      drm/ttm: individualize resv objects before calling release_notify
      drm/amdgpu: add VM update fences back to the root PD v2
      dma-buf: add dynamic DMA-buf handling v15
      drm/ttm: remove the backing store if no placement is given
      drm/amdgpu: use allowed_domains for exported DMA-bufs
      drm/amdgpu: add amdgpu_dma_buf_pin/unpin v2
      drm/amdgpu: implement amdgpu_gem_prime_move_notify v2
      dma-buf: drop dynamic_mapping flag
      dma-buf: make move_notify mandatory if importer_ops are provided
      drm/ttm: fix false positive assert

Christophe JAILLET (1):
      dma-buf: Fix a typo in Kconfig

Chuhong Yuan (2):
      video: ssd1307fb: add the missed regulator_disable
      pxa168fb: fix release function mismatch in probe failure

Chun-Kuang Hu (1):
      MAINTAINERS: Update Chun-Kuang Hu's email address

Colin Ian King (8):
      video: hyperv_fb: fix indentation issue
      OMAP: DSS2: remove non-zero check on variable r
      video: fbdev: nvidia: clean up indentation issues and comment block
      drm/i915/gt: remove redundant assignment to variable dw
      drm/tidss: fix spelling mistakes "bufer" and "requsted"
      drm/amdkfd: fix indentation issue
      drm/amd/display: fix indentation issue on a hunk of code
      drm: amd: fix spelling mistake "shoudn't" -> "shouldn't"

Dafna Hirschfeld (1):
      dt-bindings: convert rockchip-drm.txt to rockchip-drm.yaml

Dan Carpenter (8):
      fbdev: potential information leak in do_fb_ioctl()
      drm/amdgpu: return -EFAULT if copy_to_user() fails
      drm/i915/selftests: Fix return in assert_mmap_offset()
      drm: prevent a harmless integer overflow in drm_legacy_sg_alloc()
      drm/amd/display: Fix dmub_psr_destroy()
      drm/amd/display: clean up a condition in dmub_psr_copy_settings()
      drm/amdgpu/display: clean up some indenting
      drm/amd/display: Possible divide by zero in set_speed()

Daniel Kolesa (1):
      amdgpu: Prevent build errors regarding soft/hard-float FP ABI tags

Daniel Stone (1):
      drm: Add getfb2 ioctl

Daniel Vetter (17):
      drm/todo: Add item for the plane->atomic_check confusion
      drm/imx: plane_state->fb iff plane_state->crtc
      drm/rockchip: plane_state->fb iff plane_state->crtc
      drm/vc4: plane_state->fb iff plane_state->crtc
      drm/vkms: plane_state->fb iff plane_state->crtc
      drm/zte: plane_state->fb iff plane_state->crtc
      drm/crc: Actually allow to change the crc source
      drm/auth: Drop master_create/destroy hooks
      drm/fbdev-helper: don't force restores
      drm/client: Rename _force to _locked
      drm: Push drm_global_mutex locking in drm_open
      drm: Nerf drm_global_mutex BKL for good drivers
      drm/print: Delete a few unused shouting macros
      drm/atomic-helper: fix kerneldoc
      drm/amdgpu: Drop DRIVER_USE_AGP
      drm/radeon: Inline drm_get_pci_dev
      drm/pci: Unexport drm_get_pci_dev

Daniele Ceraolo Spurio (13):
      drm/i915: extract engine WA programming to common resume function
      drm/i915: Move ringbuffer WAs to engine workaround list
      drm/i915/debugfs: Pass guc_log struct to i915_guc_log_info
      drm/i915/guc: Kill USES_GUC macro
      drm/i915/guc: Kill USES_GUC_SUBMISSION macro
      drm/i915/uc: Update the FW status on injected fetch error
      drm/i915/uc: autogenerate uC checker functions
      drm/i915/uc: Improve tracking of uC init status
      drm/i915/guc: Apply new uC status tracking to GuC submission as well
      drm/i915/uc: Abort early on uc_init failure
      drm/i915/uc: consolidate firmware cleanup
      drm/i915/ggtt: do not set bits 1-11 in gen12 ptes
      drm/i915/huc: update TGL HuC to v7.0.12

Dave Airlie (21):
      Merge tag 'drm-misc-next-2020-02-10' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-misc-next-2020-02-21' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-intel-next-2020-02-25' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'amd-drm-next-5.7-2020-02-26' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'drm-misc-next-2020-02-27' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge v5.6-rc5 into drm-next
      Merge tag 'drm-misc-next-2020-03-09' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'amd-drm-next-5.7-2020-03-10' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'drm/tegra/for-5.7-rc1' of
git://anongit.freedesktop.org/tegra/linux into drm-next
      Merge tag 'drm-intel-next-2020-03-13' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge branch 'vmwgfx-next' of
git://people.freedesktop.org/~thomash/linux into drm-next
      Merge tag 'drm-misc-next-2020-03-17' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'exynos-drm-next-for-v5.7' of
git://git.kernel.org/.../daeinki/drm-exynos into drm-next
      Merge tag 'amd-drm-next-5.7-2020-03-19' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'mediatek-drm-next-5.7' of
https://github.com/ckhu-mediatek/linux.git-tags into drm-next
      Merge branch 'etnaviv/next' of
https://git.pengutronix.de/git/lst/linux into drm-next
      Merge branch 'feature/staging_sm5' of
git://people.freedesktop.org/~sroland/linux into drm-next
      Merge tag 'amd-drm-next-5.7-2020-03-26' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'drm-intel-next-fixes-2020-03-27' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge v5.6 into drm-next
      Merge tag 'drm-msm-next-2020-03-22' of
https://gitlab.freedesktop.org/drm/msm into drm-next

David Galiffi (2):
      drm/amd/display: Use uint64_t logger_mask instead of uint32_t
      drm/amd/display: Workaround required for link training reliability

Deepak Rawat (16):
      drm/vmwgfx: Also check for SVGA_CAP_DX before reading DX context supp=
ort
      drm/vmwgfx: Sync legacy multisampling device capability
      drm/vmwgfx: Deprecate logic ops commands
      drm/vmwgfx: Use enum to represent graphics context capabilities
      drm/vmwgfx: Sync virtual device headers for new feature
      drm/vmwgfx: Add a new enum for SM5 graphics context capability
      drm/vmwgfx: Read new register for GB memory when available
      drm/vmwgfx: Support SM5 shader type in command buffer
      drm/vmwgfx: Add support for UA view commands
      drm/vmwgfx: Add support for indirect and dispatch commands
      drm/vmwgfx: Rename stream output target binding tracker struct
      drm/vmwgfx: Add support for streamoutput with mob commands
      drm/vmwgfx: Split surface metadata from struct vmw_surface
      drm/vmwgfx: Refactor surface_define to use vmw_surface_metadata
      drm/vmwgfx: Add surface define v4 command
      drm/vmwgfx: Add SM5 param for userspace

Dennis Li (2):
      drm/amdgpu: add codes to clear AccVGPR for arcturus
      drm/amdgpu: fix the coverage issue to clear ArcVPGRs

Derek Basehore (1):
      drm/connector: Split out orientation quirk detection (v2)

Divya Shikre (1):
      drm/amd: Extend ROCt to surface UUID for devices that have them

Dmitry Osipenko (4):
      drm/tegra: dc: Use devm_platform_ioremap_resource
      drm/tegra: dc: Release PM and RGB output when client's registration f=
ails
      drm/tegra: dc: Silence RGB output deferred-probe error
      drm/tegra: hdmi: Silence deferred-probe error

Dmytro Laktyushkin (7):
      drm/amd/display: add odm split logic to scaling calculations
      drm/amd/display: update scaling filters
      drm/amd/display: update dml input population function
      drm/amd/display: remove unused dml variable
      drm/amd/display: correct dml surface size assignment
      drm/amd/display: fix split threshold w/a to work with mpo
      drm/amd/display: add on demand pipe merge logic for dcn2+

Douglas Anderson (9):
      drm/bridge: ti-sn65dsi86: Split the setting of the dp and dsi rates
      drm/bridge: ti-sn65dsi86: zero is never greater than an unsigned int
      drm/bridge: ti-sn65dsi86: Don't use MIPI variables for DP link
      drm/bridge: ti-sn65dsi86: Config number of DP lanes Mo' Betta
      drm/bridge: ti-sn65dsi86: Read num lanes from the DP sink
      drm/bridge: ti-sn65dsi86: Use 18-bit DP if we can
      drm/bridge: ti-sn65dsi86: Group DP link training bits in a function
      drm/bridge: ti-sn65dsi86: Train at faster rates if slower ones fail
      drm/bridge: ti-sn65dsi86: Avoid invalid rates

Drew Davenport (4):
      drm/msm/dpu: Remove unused function arguments
      drm/msm/dpu: Refactor rm iterator
      drm/msm/dpu: Refactor resource manager
      drm/msm/dpu: Track resources in global state

Emily Deng (1):
      drm/amdgpu/sriov: Use kiq to copy the gpu clock

Emmanuel Vadot (2):
      drm/format_helper: Dual licence the file in GPL 2 and MIT
      drm/client: Dual licence the file in GPL-2 and MIT

Enric Balletbo i Serra (1):
      drm/bridge: panel: Fix typo in drm_panel_bridge_add docs

Eric Bernstein (2):
      drm/amd/display: Fix various issues found by compiler warning as erro=
rs
      drm/amd/display: Fix default logger mask definition

Eric Huang (1):
      drm/amdkfd: change SDMA MQD memory type

Eric Yang (1):
      drm/amd/display: fix inputting clk lvl into dml for RN

Etienne Carriere (1):
      drm/stm: dsi: stm mipi dsi doesn't print error on probe deferral

Evan Quan (9):
      drm/amd/powerplay: handle features disablement for baco reset in SMU =
FW
      drm/amd/powerplay: update smu11_driver_if_navi10.h
      drm/amd/powerplay: always refetch the enabled features status on
dpm enablement
      drm/amd/powerplay: correct the way for checking
SMU_FEATURE_BACO_BIT support
      drm/amdgpu: drop the non-sense firmware version check on arcturus
      drm/amdgpu: update psp firmwares loading sequence V2
      drm/amdgpu: add fbdev suspend/resume on gpu reset
      drm/amd/swSMU: add callback to set AC/DC power source (v2)
      drm/amdgpu/swSMU: correct the bootup power source for Navi1X (v2)

Ezequiel Garcia (1):
      drm/panfrost: Prefix interrupt handlers' names

Fabrizio Castro (2):
      dt-bindings: display: Add idk-2121wr binding
      dt-bindings: display: Add idk-1110wr binding

Feifei Xu (1):
      drm/amdgpu/runpm: disable runpm on Vega10

Felix Kuehling (2):
      drm/amdgpu: Improve Vega20 XGMI TLB flush workaround
      drm/amdkfd: Signal eviction fence on process destruction (v2)

Geert Uytterhoeven (5):
      dt-bindings: display: sitronix,st7735r: Convert to DT schema
      dt-bindings: display: sitronix,st7735r: Add Okaya RH128128T
      drm/mipi_dbi: Add support for display offsets
      drm: tiny: st7735r: Prepare for adding support for more displays
      drm: tiny: st7735r: Add support for Okaya RH128128T

George Shen (3):
      drm/amd/display: Move USB-C workaround to after parameter
variables are set
      drm/amd/display: Temporarily disable stutter on MPO transition
      drm/amd/display: Workaround to do HDCP authentication twice on
certain displays

Gerd Hoffmann (22):
      drm/virtio: fix vblank handling
      drm/virtio: ratelimit error logging
      drm/virtio: fix ring free check
      drm/bochs: deinit bugfix
      drm/virtio: simplify virtio_gpu_alloc_cmd
      drm/virtio: resource teardown tweaks
      drm/virtio: move mapping teardown to virtio_gpu_cleanup_object()
      drm/virtio: move virtio_gpu_mem_entry initialization to new function
      drm/qxl: reorder calls in qxl_device_fini().
      drm/qxl: add drm_driver.release callback.
      drm/bochs: add drm_driver.release callback.
      drm/cirrus: add drm_driver.release callback.
      drm/virtio: add drm_driver.release callback.
      drm/virtio: fix virtio_gpu_execbuffer_ioctl locking
      drm/virtio: fix virtio_gpu_cursor_plane_update().
      drm/virtio: fix error check
      drm/virtio: rework notification for better batching
      drm/virtio: notify before waiting
      drm/virtio: batch plane updates (pageflip)
      drm/virtio: batch resource creation
      drm/virtio: batch display query
      drm/virtio: move remaining virtio_gpu_notify calls

Guchun Chen (6):
      drm/amdgpu: limit GDS clearing workaround in cold boot sequence
      drm/amdgpu: correct comment to clear up the confusion
      drm/amdgpu: log on non-zero error conter per IP before GPU reset
      drm/amdgpu: record non-zero error counter info in NBIO before
resetting GPU
      drm/amdgpu: toggle DF-Cstate when accessing UMC ras error
related registers
      drm/amdgpu: update ras capability's query based on mem ecc configurat=
ion

Guido G=C3=BCnther (5):
      drm/etnaviv: Fix typo in comment
      drm/etnaviv: Update idle bits
      drm/etnaviv: Consider all kwnown idle bits in debugfs
      drm/etnaviv: Ignore MC when checking runtime suspend idleness
      drm/etnaviv: Warn when GPU doesn't idle fast enough

Gurchetan Singh (8):
      drm/virtio: use consistent names for drm_files
      drm/virtio: factor out context create hypercall
      drm/virtio: track whether or not a context has been initiated
      drm/virtio: enqueue virtio_gpu_create_context after the first 3D ioct=
l
      drm/virtio: make mmap callback consistent with callbacks
      drm/virtio: add virtio_gpu_is_shmem helper
      drm/virtio: factor out the sg_table from virtio_gpu_object
      drm/virtio: add case for shmem objects in virtio_gpu_cleanup_object(.=
.)

Gustavo A. R. Silva (9):
      drm/qxl: replace zero-length array with flexible-array member
      video: Replace zero-length array with flexible-array member
      drm/etnaviv: Replace zero-length array with flexible-array member
      drm/gma500/intel_bios.h: Replace zero-length array with
flexible-array member
      drm/vc4/vc4_drv.h: Replace zero-length array with flexible-array memb=
er
      drm/bridge/mhl.h: Replace zero-length array with flexible-array membe=
r
      drm/vboxvideo/vboxvideo.h: Replace zero-length array with
flexible-array member
      drm/vmwgfx: Replace zero-length array with flexible-array member
      drm/msm/msm_gem.h: Replace zero-length array with flexible-array memb=
er

H. Nikolaus Schaller (1):
      drm/panel-simple: Fix dotclock for Ortustech COM37H3M

Hans de Goede (5):
      drm/connector: Hookup the new drm_cmdline_mode panel_orientation
member (v2)
      drm/i915/dsi: Remove readback of panel orientation on BYT / CHT
      drm/i915/dp: Use BDB_GENERAL_FEATURES VBT block info for builtin
panel-orientation
      drm/i915: panel: Use intel_panel_compute_brightness() from
pwm_setup_backlight()
      drm/i915: Add invert-brightness quirk for Thundersoft TST178 tablet

Hawking Zhang (17):
      drm/amdgpu: move xgmi init/fini to xgmi_add/remove_device call (v2)
      drm/amdgpu: add dpm helper function for DF Cstate control
      drm/amdgpu: move get_xgmi_relative_phy_addr to amdgpu_xgmi.c
      drm/amdgpu: toggle DF-Cstate to protect DF reg access
      drm/amd/powerplay: update arcturus ppsmc header to 54.15.0
      drm/amd/powerplay: add DFCstate control pptable func for arct
      drm/amdgpu: add reset_ras_error_count function for SDMA
      drm/amdgpu: add reset_ras_error_count function for MMHUB
      drm/amdgpu: add reset_ras_error_count function for GFX
      drm/amdgpu: add reset_ras_error_count function for HDP
      drm/amdgpu: correct ROM_INDEX/DATA offset for VEGA20
      drm/amdgpu: add xgmi ip headers
      drm/amdgpu: add wafl2 ip headers
      drm/amdgpu: add helper funcs to detect PCS error
      drm/amdgpu: enable PCS error report on VG20
      drm/amdgpu: enable PCS error report on arcturus
      drm/amdgpu: check GFX RAS capability before reset counters

Heiko Stuebner (3):
      dt-bindings: display: panel: Add binding document for Elida KD35T133
      drm/panel: add panel driver for Elida KD35T133 panels
      drm/rockchip: rgb: don't count non-existent devices when
determining subdrivers

Hersen Wu (6):
      drm/amd/display: linux enable oled panel support dc part
      drm/amd/display: dmub back door load
      drm/amd/display: DMUB Firmware Load by PSP
      drm/amdgpu/powerplay: nv1x, renior copy dcn clock settings of
watermark to smu during boot up
      drm/amdgpu/display: navi1x copy dcn watermark clock settings to
smu resume from s3 (v2)
      drm/amd/display: update connector->display_info after read edid

Icenowy Zheng (3):
      dt-bindings: vendor-prefix: add Shenzhen Feixin Photoelectics Co., Lt=
d
      dt-bindings: panel: add Feixin K101 IM2BA02 MIPI-DSI panel
      drm/panel: Add Feixin K101 IM2BA02 panel

Ilia Mirkin (1):
      drm/msm: avoid double-attaching hdmi/edp bridges

Imre Deak (14):
      drm/i915: Fix bounds check in intel_get_shared_dpll_id()
      drm/i915: Move DPLL HW readout/sanitize fns to intel_dpll_mgr.c
      drm/i915: Keep the global DPLL state in a DPLL specific struct
      drm/i915: Move the DPLL vfunc inits after the func defines
      drm/i915/hsw: Use the DPLL ID when calculating DPLL clock
      drm/i915: Move DPLL frequency calculation to intel_dpll_mgr.c
      drm/i915/skl: Parametrize the DPLL ref clock instead of open-coding i=
t
      drm/i915/hsw: Rename the get HDMI/DP DPLL funcs to get WRPLL/LCPLL
      drm/i915/hsw: Split out the SPLL parameter calculation
      drm/i915/hsw: Split out the WRPLL, LCPLL, SPLL frequency calculation
      drm/i915/skl, cnl: Split out the WRPLL/LCPLL frequency calculation
      drm/i915/hsw: Use the read-out WRPLL/SPLL state instead of
reading out again
      drm/i915: Unify the DPLL ref clock frequency tracking
      drm/i915: Fix documentation for intel_dpll_get_freq()

Isabel Zhang (4):
      drm/amd/display: Add initialitions for PLL2 clock source
      drm/amd/display: Move mod_hdcp_displays to mod_hdcp struct
      drm/amd/display: Add stay count and bstatus to HDCP log
      drm/amd/display: Remove redundant hdcp display state

Jack Zhang (3):
      drm/amdgpu/sriov Don't send msg when smu suspend
      drm/amdgpu/sriov set driver_table address in VF
      drm/amdgpu/sriov refine vcn_v2_5_early_init func

Jacob He (2):
      drm/amdgpu: Initialize SPM_VMID with 0xf (v2)
      drm/amdgpu: Update SPM_VMID with the job's vmid when application
reserves the vmid

Jaehyun Chung (2):
      drm/amd/display: Monitor patch to delay setting ignore MSA bit
      drm/amd/display: Access patches from stream for ignore MSA monitor pa=
tch

James Hughes (2):
      drm/vc4: Replace wait_for macros to remove use of msleep
      drm/v3d: Replace wait_for macros to remove use of msleep

James Zhu (5):
      drm/amdgpu/vcn2.5: fix DPG mode power off issue on instance 1
      drm/amdgpu/vcn2.5: fix warning
      drm/amdgpu: fix typo for vcn1 idle check
      drm/amdgpu: fix typo for vcn2/jpeg2 idle check
      drm/amdgpu: fix typo for vcn2.5/jpeg2.5 idle check

Jani Nikula (95):
      drm/i915/params: add i915 parameters to debugfs
      drm/i915/params: support bool values for int and uint params
      drm/i915/bios: add intel_bios_max_tmds_encoder()
      drm/i915/bios: add intel_bios_hdmi_level_shift()
      drm/i915/bios: intel_bios_dp_boost_level()
      drm/i915/bios: intel_bios_hdmi_boost_level()
      drm/i915/bios: add intel_bios_dp_max_link_rate()
      drm/i915/bios: add intel_bios_alternate_ddc_pin()
      drm/i915/bios: add intel_bios_port_supports_*()
      drm/i915/bios: check DDI port presence based on child device
      drm/i915: use intel_bios_is_port_present()
      drm/i915/dp: debug log max vswing and pre-emphasis
      drm/i915: drop alpha_support for good in favour of force_probe
      Merge tag 'topic/drm-warn-2020-01-22' of
git://anongit.freedesktop.org/drm/drm-intel into drm-intel-next-queued
      drm/i915: add display engine uncore helpers
      drm: add drm_core_check_all_features() to check for a mask of feature=
s
      drm/debugfs: also take per device driver features into account
      drm/i915/dmc: use intel uncore functions for forcewake register acces=
s
      drm/i915/irq: use intel de functions for forcewake register access
      drm/i915/pm: use intel de functions for forcewake register access
      drm/i915/audio: use intel_de_*() functions for register access
      drm/i915/cdclk: use intel_de_*() functions for register access
      drm/i915/color: use intel_de_*() functions for register access
      drm/i915/crt: use intel_de_*() functions for register access
      drm/i915/dpio_phy: use intel_de_*() functions for register access
      drm/i915/dpll_mgr: use intel_de_*() functions for register access
      drm/i915/dp_mst: use intel_de_*() functions for register access
      drm/i915/dsb: use intel_de_*() functions for register access
      drm/i915/dvo: use intel_de_*() functions for register access
      drm/i915/fbc: use intel_de_*() functions for register access
      drm/i915/fifo_underrun: use intel_de_*() functions for register acces=
s
      drm/i915/gmbus: use intel_de_*() functions for register access
      drm/i915/hdmi: use intel_de_*() functions for register access
      drm/i915/lpe_audio: use intel_de_*() functions for register access
      drm/i915/lvds: use intel_de_*() functions for register access
      drm/i915/overlay: use intel_de_*() functions for register access
      drm/i915/panel: use intel_de_*() functions for register access
      drm/i915/sdvo: use intel_de_*() functions for register access
      drm/i915/tv: use intel_de_*() functions for register access
      drm/i915/vga: use intel_de_*() functions for register access
      drm/i915/pipe_crc: use intel_de_*() functions for register access
      drm/i915/psr: use intel_de_*() functions for register access
      drm/i915/sprite: use intel_de_*() functions for register access
      drm/i915/vdsc: use intel_de_*() functions for register access
      drm/i915/vlv_dsi: use intel_de_*() functions for register access
      drm/i915/vlv_dsi_pll: use intel_de_*() functions for register access
      drm/i915/icl_dsi: use intel_de_*() functions for register access
      drm/i915/combo_phy: use intel_de_*() functions for register access
      drm/i915/ddi: use intel_de_*() functions for register access
      drm/i915/display: use intel_de_*() functions for register access
      drm/i915/display_power: use intel_de_*() functions for register acces=
s
      drm/i915/dp: use intel_de_*() functions for register access
      drm/i915/hdcp: use intel_de_*() functions for register access
      drm/i915/psr: use intel_de_*() functions for register access
      drm/i915/debugfs: remove i915_dpcd file
      drm/i915/debugfs: remove VBT data about DRRS
      drm/i915: move pipe, pch and vblank enable to encoders on DDI platfor=
ms
      drm/i915: move intel_dp_set_m_n() to encoder for DDI platforms
      drm/i915/hdcp: move update pipe code to hdcp
      drm/i915/mst: fix pipe and vblank enable
      drm/i915/psr: pass i915 to psr_global_enabled()
      drm/irq: remove check on dev->dev_private
      drm/i915/hdmi: prefer to_i915() over drm->dev_private to get at i915
      drm/i915: register vga switcheroo later, unregister earlier
      drm/i915: switch i915_driver_probe() to use i915 local variable
      drm/i915: move intel_csr.[ch] under display/
      drm/i915: split out display debugfs to a separate file
      drm/i915/dsc: force full modeset whenever DSC is enabled at probe
      MAINTAINERS: Update drm/i915 bug filing URL
      drm/i915: Update drm/i915 bug filing URL
      drm/i915: split out vlv/chv specific suspend/resume code
      drm/i915: switch vlv_suspend to use intel uncore register accessors
      drm/i915/csr: use intel_de_*() functions for register access
      drm/i915/display: use intel_de_*() functions for register access
      drm/i915/gem: use spinlock_t instead of struct spinlock
      drm/i915: split intel_modeset_driver_remove() to pre/post irq uninsta=
ll
      drm/i915: split i915_driver_modeset_remove() to pre/post irq uninstal=
l
      drm/i915: split i915_driver_modeset_probe() to pre/post irq install
      drm/i915: make dbuf configurations const
      drm/i915: fix header test with GCOV
      drm/i915: stop assigning drm->dev_private pointer
      drm/i915: split intel_modeset_init() to pre/post irq install
      drm/i915: significantly reduce the use of <drm/i915_drm.h>
      drm/i915: split out intel_dram.[ch] from i915_drv.c
      drm/i915/dram: use intel_uncore_*() functions for register access
      drm/i915/drv: use intel_uncore_write() for register access
      drm/i915/crc: move pipe_crc from drm_i915_private to intel_crtc
      drm/i915/dram: hide the dram structs better
      drm/i915: add i915_ioc32.h for compat
      drm/i915: remove unused orig_clock i915 member
      drm/i915: fix documentation build after rename
      drm/i915: move watermark structs more towards usage
      drm/i915/vgpu: improve vgpu abstractions
      drm/i915/gvt: make intel_gvt_active internal to intel_gvt
      drm/i915/gvt: only include intel_gvt.h where needed

Janusz Krzysztofik (1):
      drm/i915: Never allow userptr into the new mapping types

Jerry (Fangzhi) Zuo (2):
      drm: Add support for DP 1.4 Compliance edid corruption test
      drm/amd/display: Fix test pattern color space inconsistency for Linux

Jing Zhou (1):
      drm/amd/display: external monitor abm enabled in modern standby

Jitao Shi (9):
      dt-bindings: display: panel: Add boe tv101wum-n16 panel bindings
      drm/panel: support for boe tv101wum-nl6 wuxga dsi video mode panel
      drm/panel: support for auo, kd101n80-45na wuxga dsi video mode panel
      drm/panel: support for boe, tv101wum-n53 wuxga dsi video mode panel
      drm/panel: support for auo, b101uan08.3 wuxga dsi video mode panel
      Documentation: bridge: Add documentation for ps8640 DT properties
      drm/bridge: Add I2C based driver for ps8640 bridge
      dt-bindings: display: mediatek: update dpi supported chips
      drm/mediatek: add mt8183 dpi clock factor

Joe Perches (4):
      AMD DISPLAY CORE: Use fallthrough;
      AMD POWERPLAY: Use fallthrough;
      drm/amd/powerplay: Move fallthrough; into containing #ifdef/#endif
      AMD KFD: Use fallthrough;

John Clements (6):
      drm/amdgpu: Add Arcturus D342 page retire support
      drm/amdgpu: increase atombios cmd timeout
      drm/amdgpu: update page retirement sequence
      drm/amdgpu: resolve failed error inject msg
      amd/powerplay: arcturus baco reset disable all features
      drm/amdgpu: protect RAS sysfs during GPU reset

Jonas Karlman (2):
      drm/bridge: dw-hdmi: set mtmdsclock for deep color
      drm/bridge: dw-hdmi: add max bpc connector property

Jonathan Kim (1):
      drm/amdgpu: fix amdgpu pmu to use hwc->config instead of hwc->conf

Jonathan Neusch=C3=A4fer (1):
      drm/mcde: Fix Sphinx formatting

Jordan Crouse (3):
      drm/msm/a5xx: Always set an OPP supported hardware value
      dt-bindings: display: msm: Convert GMU bindings to YAML
      drm/msm/a6xx: Use the DMA API for GMU memory objects

Joseph Gravenor (3):
      drm/amd/display: remove invalid dc_is_hw_initialized function
      drm/amd/display: turn off the mst hub before we do detection
      drm/amd/display: add worst case dcc meta pitch to fake plane

Josip Pavic (1):
      drm/amd/display: fix dcc swath size calculations on dcn1

Jos=C3=A9 Roberto de Souza (24):
      drm/i915/dp/tgl+: Update combo phy vswing tables
      drm/i915/vbt: Rename BDB_LVDS_POWER to BDB_LFP_POWER
      drm/i915/psr: Share the computation of idle frames
      drm/mst: Some style improvements in drm_dp_mst_topology_mgr_set_mst()
      drm/i915/dc3co: Do the full calculation of DC3CO exit only once
      drm/i915/dc3co: Avoid full modeset when EXITLINE needs to be changed
      drm/i915: Fix preallocated barrier list append
      drm/i915/display: Set TRANS_DDI_MODE_SELECT to default value
when clearing DDI select
      drm/i915/display/ehl: Add HBR2 and HBR3 voltage swing table
      drm/i915/dc3co: Add description of how it works
      drm/i915/mst: Set intel_dp_set_m_n() for MST slaves
      drm/i915/psr: Force PSR probe only after full initialization
      drm/i915/tgl: Implement Wa_1409804808
      drm/i915/tgl: Implement Wa_1806527549
      drm/i915/tgl: Add note to Wa_1607297627
      drm/i915/tgl: Add note about Wa_1607063988
      drm/i915/tgl: Fix the Wa number of a fix
      drm/i915/tgl: Add note about Wa_1409142259
      drm/i915/tgl: Add Wa number to
WaAllowPMDepthAndInvocationCountAccessFromUMD
      drm/i915/dmc: Use firmware v2.06 for TGL
      drm/i915/gen11: Moving WAs to rcs_engine_wa_init()
      drm/i915/tgl: Move and restrict Wa_1408615072
      drm/i915/display: Deactive FBC in fastsets when disabled by parameter
      drm/i915/tgl: Remove require_force_probe protection

Julia Lawall (3):
      video: sa1100fb: constify copied structure
      fbdev: s1d13xxxfb: use resource_size
      fbdev: cg14fb: use resource_size

Julian Stecklina (2):
      drm/i915/gvt: remove unused vblank_done completion
      drm/i915/gvt: make gvt oblivious of kvmgt data structures

Jyri Sarha (9):
      dt-bindings: display: ti,k2g-dss: Add dt-schema yaml binding
      dt-bindings: display: ti,am65x-dss: Add dt-schema yaml binding
      dt-bindings: display: ti,j721e-dss: Add dt-schema yaml binding
      drm/tidss: New driver for TI Keystone platform Display SubSystem
      MAINTAINERS: add entry for tidss
      drm/bridge: sii902x: Select SND_SOC_HDMI_CODEC if SND_SOC is configur=
ed
      dt-bindings: panel-simple: Add rocktech,rk101ii01d-ct compatible
      drm/panel: simple: Add Rocktech RK101II01D-CT panel
      drm/tidss: dispc: Fix broken plane positioning code

Kai Vehmanen (1):
      drm/i915: Add missing HDMI audio pixel clocks for gen12

Kamlesh Gurudasani (3):
      dt-bindings: add binding for tft displays based on ilitek,ili9486
      drm/tiny: add support for tft displays based on ilitek,ili9486
      drm/tiny: fix sparse warning: incorrect type in assignment
(different base types)

Kees Cook (2):
      drm/i915: Distribute switch variables for initialization
      drm/edid: Distribute switch variables for initialization

Kent Russell (2):
      drm/powerplay: Ratelimit PP_ASSERT warnings
      drm/amdgpu: Fix check for DPM when returning max clock

Kevin Wang (1):
      drm/amdgpu/swsmu: clean up unused header in swsmu

Kieran Bingham (1):
      drm/omapdrm: Fix trivial spelling

Krzysztof Kozlowski (3):
      drm/rockchip: Add missing vmalloc header
      video: Fix Kconfig indentation
      video: exynos: Rename Exynos to lowercase

Laurent Pinchart (58):
      drm/bridge: lvds-codec: Add to_lvds_codec() function
      drm/bridge: lvds-codec: Constify the drm_bridge_funcs structure
      video: hdmi: Change return type of hdmi_avi_infoframe_init() to void
      drm/connector: Add helper to get a connector type name
      drm/edid: Add flag to drm_display_info to identify HDMI sinks
      drm/bridge: Document the drm_encoder.bridge_chain field as private
      drm/bridge: Fix atomic state ops documentation
      drm/bridge: Improve overview documentation
      drm/bridge: Add connector-related bridge operations and data
      drm/bridge: Add interlace_allowed flag to drm_bridge
      drm/bridge: Extend bridge API to disable connector creation
      drm/bridge: dumb-vga-dac: Rename internal symbols to simple-bridge
      drm/bridge: dumb-vga-dac: Rename driver to simple-bridge
      drm/bridge: simple-bridge: Add support for non-VGA bridges
      drm/bridge: simple-bridge: Add support for enable GPIO
      drm/bridge: simple-bridge: Add support for the TI OPA362
      drm/bridge: Add bridge driver for display connectors
      drm/bridge: Add driver for the TI TPD12S015 HDMI level shifter
      drm/bridge: panel: Implement bridge connector operations
      drm/bridge: tfp410: Replace manual connector handling with bridge
      drm/bridge: tfp410: Allow operation without drm_connector
      drm: Add helper to create a connector for a chain of bridges
      drm/omap: dss: Cleanup DSS ports on initialisation failure
      drm/omap: Simplify HDMI mode and infoframe configuration
      drm/omap: Factor out display type to connector type conversion
      drm/omap: Use the drm_panel_bridge API
      drm/omap: dss: Fix output next device lookup in DT
      drm/omap: Add infrastructure to support drm_bridge local to DSS outpu=
ts
      drm/omap: dss: Make omap_dss_device_ops optional
      drm/omap: hdmi: Allocate EDID in the .read_edid() operation
      drm/omap: hdmi4: Rework EDID read to isolate data read
      drm/omap: hdmi5: Rework EDID read to isolate data read
      drm/omap: hdmi4: Register a drm_bridge for EDID read
      drm/omap: hdmi5: Register a drm_bridge for EDID read
      drm/omap: hdmi4: Move mode set, enable and disable operations to brid=
ge
      drm/omap: hdmi5: Move mode set, enable and disable operations to brid=
ge
      drm/omap: hdmi4: Implement drm_bridge .hpd_notify() operation
      drm/omap: dss: Remove .set_hdmi_mode() and .set_infoframe() operation=
s
      drm/omap: venc: Register a drm_bridge
      drm/omap: Create connector for bridges
      drm/omap: Switch the HDMI and VENC outputs to drm_bridge
      drm/omap: Remove HPD, detect and EDID omapdss operations
      drm/omap: hdmi: Remove omap_dss_device operations
      drm/omap: venc: Remove omap_dss_device operations
      drm/omap: hdmi4: Simplify EDID read
      drm/omap: hdmi5: Simplify EDID read
      drm/omap: dpi: Sort includes alphabetically
      drm/omap: dpi: Reorder functions in sections
      drm/omap: dpi: Simplify clock setting API
      drm/omap: dpi: Register a drm_bridge
      drm/omap: sdi: Sort includes alphabetically
      drm/omap: sdi: Register a drm_bridge
      drm/omap: Hardcode omap_connector type to DSI
      drm/omap: dss: Inline the omapdss_display_get() function
      drm/omap: dss: Remove unused omapdss_of_find_connected_device() funct=
ion
      drm/omap: dss: Remove unused omap_dss_device operations
      drm/tidss: Use drm_for_each_bridge_in_chain()
      drm: panel: Set connector type for OrtusTech COM43H4M85ULC panel

Linus Walleij (4):
      drm/pl111: Support Integrator IM-PD1 module
      dt-bindings: Add vendor prefix for Hydis technologies
      drm/panel: Add DT bindings for Novatek NT35510-based panels
      drm/panel: Add driver for Novatek NT35510-based panels

Lionel Landwerlin (2):
      drm/syncobj: Add documentation for timeline syncobj
      drm/i915: add extra slice common debug registers

Lucas De Marchi (2):
      drm/i915: remove ICP_PP_CONTROL
      drm/i915/tgl: Add Wa_1608008084

Lucas Stach (3):
      drm/scheduler: fix inconsistent locking of job_list_lock
      drm/etnaviv: request pages from DMA32 zone when needed
      drm/etnaviv: fix TS cache flushing on GPUs with BLT engine

Lukas Bulwahn (1):
      MAINTAINERS: adjust to reservation.h renaming

Lyude Paul (18):
      drm/i915: Fix eDP DPCD aux max backlight calculations
      drm/i915: Assume 100% brightness when not in DPCD control mode
      drm/i915: Fix DPCD register order in intel_dp_aux_enable_backlight()
      drm/i915: Auto detect DPCD backlight support by default
      Revert "drm/dp_mst: Remove VCPI while disabling topology mgr"
      drm/i915: Don't use VBT for detecting DPCD backlight controls
      drm/dp_mst: Fix indenting in drm_dp_mst_topology_mgr_set_mst()
      drm/dp_mst: Fix clearing payload state on topology disable
      drm/dp_mst: Mention max_payloads in proposed_vcpis/payloads docs
      Revert "drm/i915: Don't use VBT for detecting DPCD backlight controls=
"
      drm/dp: Introduce EDID-based quirks
      drm/i915: Force DPCD backlight mode on X1 Extreme 2nd Gen 4K AMOLED p=
anel
      drm/i915: Force DPCD backlight mode for some Dell CML 2020 panels
      drm/dp_mst: Make drm_dp_mst_dpcd_write() consistent with
drm_dp_dpcd_write()
      drm/dp_mst: Fix drm_dp_check_mstb_guid() return code
      drm/i915/mst: Hookup DRM DP MST late_register/early_unregister callba=
cks
      drm/amdgpu: Stop using the DRIVER debugging flag for vblank
debugging messages
      drm/dp_mst: Convert
drm_dp_mst_topology_mgr.is_waiting_for_dwn_reply to bitfield

Manasi Navare (5):
      drm/i915/dp: Do not set master_trans bit in bitmak if INVALID_TRANSCO=
DER
      drm/i915/dp: Compute port sync crtc states post compute_config()
      drm/i915/dp: Add all tiled and port sync conns to modeset
      drm/edid: Name the detailed monitor range flags
      drm/edid: Add function to parse EDID descriptors for monitor range

Marcel Ziswiler (3):
      dt-bindings: add vendor prefix for logic technologies limited
      dt-bindings: panel-simple: add bindings for logic technologies displa=
ys
      drm/panel: simple: add display timings for logic technologies display=
s

Marek Szyprowski (1):
      drm/panel: ld9040: add MODULE_DEVICE_TABLE with SPI IDs

Marian-Cristian Rotariu (2):
      dt-bindings: display: Add bindings for EDT panel
      drm/panel: simple: Add EDT panel support

Mario Kleiner (2):
      drm/amd/display: Add link_rate quirk for Apple 15" MBP 2017
      drm/amd/display: Fix pageflip event race condition for DCN.

Martin Leung (6):
      drm/amd/display: always apply T7/T9 delay logic
      drm/amd/display: add monitor patch to disable SCDC read/write
      drm/amd/display: Link training TPS1 workaround
      drm/amd/display: Link training TPS1 workaround add back in dpcd
      drm/amd/display: update soc bb for nv14
      drm/amd/display: writing stereo polarity register if swapped

Martin Tsai (1):
      drm/amd/display: differentiate vsc sdp colorimetry use criteria
between MST and SST

Masahiro Yamada (1):
      fbdev: remove object duplication in Makefile

Matt Atwood (3):
      drm/i915: add Wa_14010594013: icl,ehl
      drm/i915/tgl: Add Wa_1606054188:tgl
      drm/i915/tgl: Add Wa_1409085225, Wa_14010229206

Matt Coffin (3):
      drm/amdgpu/powerplay: Refactor SMU message handling for safety
      drm/amdgpu/powerplay: Remove deprecated smc_read_arg
      drm/amdgpu/smu: Add message sending lock

Matt Roper (15):
      drm/i915/gen11: Add additional pcode status values
      drm/i915/ehl: Update port clock voltage level requirements
      drm/i915/tgl: Update cdclk voltage level settings
      drm/i915: Program MBUS with rmw during initialization
      drm/i915/tgl: Program MBUS_ABOX{1,2}_CTL during display init
      drm/i915/tgl: Add Wa_22010178259:tgl
      drm/i915/tgl: Allow DC5/DC6 entry while PG2 is active
      drm/i915/ehl: Check PHY type before reading DPLL frequency
      drm/i915/tgl: Don't treat unslice registers as masked
      drm/i915: Handle all MCR ranges
      drm/i915: Add Wa_1209644611:icl,ehl
      drm/i915: Add Wa_1604278689:icl,ehl
      drm/i915: Add Wa_1406306137:icl,ehl
      drm/i915: Apply Wa_1406680159:icl,ehl as an engine workaround
      drm/i915: Add Wa_1605460711 / Wa_1408767742 to ICL and EHL

Matthew Auld (9):
      drm/i915/userptr: add user_size limit check
      drm/i915/userptr: fix size calculation
      drm/i915/selftests/perf: measure memcpy bw between regions
      drm/i915/selftests: drop igt_ppgtt_exhaust_huge
      drm/i915: remove the other slab_dependencies
      drm/i915: be more solid in checking the alignment
      drm/i915: properly sanity check batch_start_offset
      drm/i915/buddy: avoid double list_add
      drm/i915/selftests: try to rein in alloc_smoke

Maxime Ripard (4):
      Merge tag 'topic/drm-warn-2020-01-22' of
git://anongit.freedesktop.org/drm/drm-intel into drm-misc-next
      Merge v5.6-rc2 into drm-misc-next
      drm/sun4i: tcon: Support LVDS on the A33
      Merge drm/drm-next into drm-misc-next

Melissa Wen (3):
      drm/amd/display: dc_link: code clean up on enable_link_dp function
      drm/amd/display: dc_link: code clean up on detect_dp function
      drm/amd/display: dcn20: remove an unused function

Michael Srba (2):
      dt-bindings: display/panel: add bindings for S6E88A0-AMS452EF01
      drm/panel: Add Samsung s6e88a0-ams452ef01 panel driver

Michael Strauss (2):
      drm/amd/display: Fix RV2 Variant Detection
      drm/amd/display: Disable freesync borderless on Renoir

Michal Wajdeczko (12):
      drm/i915/guc: Simpler CT message size calculation
      drm/i915/guc: Introduce CT_ERROR
      drm/i915/guc: Update CTB helpers to use CT_ERROR
      drm/i915/guc: Use correct name for last CT fence
      drm/i915/guc: Don't GEM_BUG_ON on corrupted G2H CTB
      drm/i915/guc: Don't pass CTB while writing
      drm/i915/guc: Don't pass CTB while reading
      drm/i915/guc: Switch to CT_ERROR in ct_read
      drm/i915/guc: Introduce CT_DEBUG
      drm/i915/guc: Don't GEM_BUG_ON on corrupted H2G CTB
      drm/i915/guc: Introduce guc_is_ready
      drm/i915/guc: Make sure to sanitize CT status

Micha=C5=82 Winiarski (2):
      drm/i915/pmu: Avoid using globals for CPU hotplug state
      drm/i915/pmu: Avoid using globals for PMU events

Mika Kuoppala (5):
      drm/i915: Disable tesselation clock gating on tgl A0
      drm/i915: Implement Wa_1607090982
      drm/i915: Remove lite restore defines
      drm/i915: Use engine wa list for Wa_1607090982
      drm/i915: Add mechanism to submit a context WA on ring submission

Monk Liu (13):
      drm/amdgpu: cleanup some incorrect reg access for SRIOV
      drm/amdgpu: fix memory leak during TDR test(v2)
      drm/amdgpu: fix colliding of preemption
      drm/amdgpu: fix psp ucode not loaded in bare-metal
      drm/amdgpu: fix IB test MCBP bug
      drm/amdgpu: stop using sratch_reg in IB test
      drm/amdgpu: introduce mmsch v2.0 header
      drm/amdgpu: disable jpeg block for SRIOV
      drm/amdgpu: implement initialization part on VCN2.0 for SRIOV
      drm/amdgpu: cleanup ring/ib test for SRIOV vcn2.0 (v2)
      drm/amdgpu: disable clock/power gating for SRIOV
      drm/amdgpu: revise RLCG access path
      drm/amdgpu: don't try to reserve training bo for sriov (v2)

Nathan Chancellor (5):
      fbcon: Adjust indentation in set_con2fb_map
      fbmem: Adjust indentation in fb_prepare_logo and fb_blank
      drm/amd/display: Don't take the address of skip_scdc_overwrite
in dc_link_detect_helper
      drm/amd/display: Remove pointless NULL checks in dmub_psr_copy_settin=
gs
      drm/amdgpu: Remove unnecessary variable shadow in gfx_v9_0_rlcg_wreg

Neil Armstrong (9):
      drm/bridge: dw-hdmi: Plug atomic state hooks to the default implement=
ation
      drm/bridge: synopsys: dw-hdmi: add bus format negociation
      drm/bridge: synopsys: dw-hdmi: allow ycbcr420 modes for >=3D 0x200a
      drm/meson: venc: make drm_display_mode const
      drm/meson: meson_dw_hdmi: add bridge and switch to drm_bridge_funcs
      drm/meson: dw-hdmi: stop enforcing input_bus_format
      drm/meson: venc: add support for YUV420 setup
      drm/meson: vclk: add support for YUV420 setup
      drm/meson: Add YUV420 output support

Nicholas Kazlauskas (11):
      drm/amd/display: Add GPINT handler interface
      drm/amd/display: Wait for clean shutdown in DMCUB reset
      drm/amd/display: Add DMUB tracebuffer debugfs
      drm/amd/display: Don't treat missing command table as failure
      drm/amd/display: Don't map ATOM_ENABLE to ATOM_INIT
      drm/amd/display: Use fb_base/fb_offset if available for translation
      drm/amd/display: Wait for DMCUB to finish loading before
executing commands
      drm/amd/display: Don't ask PSP to load DMCUB for backdoor load
      drm/amd/display: Add DMUB firmware state debugfs
      drm/amd/display: Pass triplebuffer surface flip flags down to plane s=
tate
      drm/amd/display: Explicitly disable triplebuffer flips

Nicolas Boichat (4):
      drm/panel: Fix boe,tv101wum-n53 htotal timing
      drm/panfrost: Improve error reporting in panfrost_gpu_power_on
      drm/panfrost: Add support for multiple regulators
      drm/panfrost: Add support for multiple power domains

Nikola Cornij (4):
      drm/amd/display: Drop unused field from dc_panel_patch
      drm/amd/display: Add 'disable FEC for specific monitor'
infrastructure to DC
      drm/amd/display: Program DSC during timing programming
      drm/amd/display: Remove connect DIG FE to its BE during timing progra=
mming

Nirmoy Das (10):
      drm/amdgpu: cleanup amdgpu_ring_fini
      drm/amdgpu: use amdgpu_ring_test_helper when possible
      drm/amdgpu: set compute queue priority at mqd_init
      drm/scheduler: implement a function to modify sched list
      drm/amdgpu: change hw sched list on ctx priority override
      drm/amdgpu: remove unused functions
      drm/amdgpu: do not set nil entry in compute_prio_sched
      drm/amdgpu: fix switch-case indentation
      drm/sched: implement and export drm_sched_pick_best
      drm/amdgpu: disable gpu_sched load balancer for vcn jobs

Oleg Vasilev (2):
      drm: move DP_MAX_DOWNSTREAM_PORTS from i915 to drm core
      drm: always determine branch device with drm_dp_is_branch()

Pankaj Bharadiya (39):
      drm/print: introduce new struct drm_device based WARN* macros
      drm/i915/display: Make WARN* drm specific where encoder ptr is availa=
ble
      drm/i915/gem: Make WARN* drm specific where drm_priv ptr is available
      drm/i915/gt: Make WARN* drm specific where drm_priv ptr is available
      drm/i915: Make WARN* drm specific where drm_priv ptr is available
      drm/i915: Make WARN* drm specific where uncore or stream ptr is avail=
able
      drm/i915/display/icl_dsi: Make WARN* drm specific where drm_priv
ptr is available
      drm/i915/display/audio: Make WARN* drm specific where drm_priv
ptr is available
      drm/i915/display/crt: Make WARN* drm specific where drm_priv ptr
is available
      drm/i915/display/dpll_mgr: Make WARN* drm specific where
drm_device ptr is available
      drm/i915/display/fbc: Make WARN* drm specific where drm_priv ptr
is available
      drm/i915/fbdev: Make WARN* drm specific where drm_device ptr is avail=
able
      drm/i915/display/hdmi: Make WARN* drm specific where drm_device
ptr is available
      drm/i915/display/overlay: Make WARN* drm specific where drm_priv
ptr is available
      drm/i915/display/panel: Make WARN* drm specific where drm_priv
ptr is available
      drm/i915/display/psr: Make WARN* drm specific where drm_priv ptr
is available
      drm/i915/display/sdvo: Make WARN* drm specific where drm_priv
ptr is available
      drm/i915/display/tc: Make WARN* drm specific where drm_priv ptr
is available
      drm/i915/display: Make WARN* drm specific where drm_device ptr
is available
      drm/i915/display/cdclk: Make WARN* drm specific where drm_priv
ptr is available
      drm/i915/display/ddi: Make WARN* drm specific where drm_device
ptr is available
      drm/i915/display/display: Make WARN* drm specific where
drm_device ptr is available
      drm/i915/display/power: Make WARN* drm specific where drm_priv
ptr is available
      drm/i915/display/dp: Make WARN* drm specific where drm_device
ptr is available
      drm/i915/display/hdcp: Make WARN* drm specific where drm_priv
ptr is available
      drm/i915/gvt: Make WARN* drm specific where drm_priv ptr is available
      drm/i915/gvt: Make WARN* drm specific where vgpu ptr is available
      drm: Remove unused arg from drm_fb_helper_init
      drm/radeon: remove radeon_fb_{add,remove}_connector functions
      drm/amdgpu: Remove drm_fb_helper_{add,remove}_one_connector calls
      drm/i915/display: Remove drm_fb_helper_{add,remove}_one_connector cal=
ls
      drm: Remove drm_fb_helper add, add all and remove connector calls
      drm/fb-helper: Remove drm_fb_helper add, add_all and remove
connector functions
      drm/todo: Update drm_fb_helper tasks
      drm: Register connector instead of calling register_connector callbac=
k
      drm: Remove dp mst register connector callbacks
      drm/dp_mst: Remove register_connector callback
      drm: Add drm_dp_destroy_connector helper and use it
      drm: Remove drm dp mst destroy_connector callbacks

Paul Cercueil (3):
      dt-bindings: vendor-prefixes: Add Shenzhen Frida LCD Co., Ltd.
      dt-bindings: panel-simple: Add compatible for Frida FRD350H54004 LCD
      drm/panel: simple: Add support for the Frida FRD350H54004 panel

Pavel Machek (1):
      drm/msm: fix leaks if initialization fails

Peikang Zhang (5):
      drm/amd/display: dc_get_vmid_use_vector() crashes when get called
      drm/amd/display: Update hubbub description comment
      drm/amd/display: Toggle VSR button cause system crash
      drm/amd/display: System crashes when add_ptb_to_table() gets called
      drm/amd/display: Add visual confirm support for FreeSync 2 ARGB210101=
0

Peter Rosin (1):
      Revert "drm/panel: simple: Add support for Sharp LQ150X1LG11 panels"

Peter Ujfalusi (4):
      dt-bindings: display: bridge: Add documentation for Toshiba tc358768
      drm/bridge: Add tc358768 driver
      drm/omap: dmm_tiler: Use dmaengine_prep_dma_memcpy() for i878 workaro=
und
      drm/omap: dmm_tiler: Remove the dma_async_issue_pending() call

Prathap Kumar Valsan (1):
      drm/i915/gen7: Clear all EU/L3 residual contexts

Prike Liang (4):
      drm/amd/powerplay: suppress nonsupport profile mode overrun message
      drm/amd/powerplay: fix pre-check condition for setting clock range
      drm/amd/powerplay: map mclk to fclk for COMBINATIONAL_BYPASS case
      drm/amd/powerplay: fix the coverity warning about negative check
for an unsigned value

Qiang Yu (5):
      drm/lima: update register info
      drm/lima: add lima_vm_map_bo
      drm/lima: support heap buffer creation
      drm/lima: recover task by enlarging heap buffer
      drm/lima: increase driver version to 1.1

Radhakrishna Sripada (2):
      drm/i915/tgl: Add Wa_1409825376 to tgl
      drm/i915/display: Do not write in removed FBC fence registers

Rafael Antognolli (1):
      drm/i915/tgl: Add Wa_1808121037 to tgl.

Rajat Jain (1):
      drm/i915/acpi: Move the code to populate ACPI device ID into intel_ac=
pi

Rajneesh Bhardwaj (3):
      drm/amdgpu: Fix missing error check in suspend
      drm/amdkfd: show warning when kfd is locked
      drm/amdkfd: refactor runtime pm for baco

Ramalingam C (3):
      drm/i915/hdcp: conversion to struct drm_device based logging macros.
      drm/hdcp: optimizing the srm handling
      drm/hdcp: fix DRM_HDCP_2_KSV_COUNT_2_LSBITS

Randy Dunlap (2):
      drm: unbreak the DRM menu, broken by DRM_EXPORT_FOR_TESTS
      drm: amd/acp: fix broken menu structure

Rich Felker (1):
      matroxfb: add Matrox MGA-G200eW board support

Rob Clark (2):
      drm/msm: devcoredump should dump MSM_SUBMIT_BO_DUMP buffers
      drm/msm/a6xx: Fix CP_MEMPOOL state name

Rob Herring (1):
      dt-bindings: display: Convert a bunch of panels to DT schema

Robert Beckett (1):
      drm/sched: add run job trace

Rodrigo Siqueira (3):
      drm/amd/display: Add AUX backlight register
      drm/amd/display: Add backlight support via AUX
      drm/amd/display: Stop if retimer is not available

Rodrigo Vivi (8):
      Merge drm/drm-next into drm-intel-next-queued
      drm/i915: Update DRIVER_DATE to 20200224
      drm/i915: Update DRIVER_DATE to 20200224
      Merge drm/drm-next into drm-intel-next-queued
      drm/i915: Update DRIVER_DATE to 20200225
      Merge tag 'gvt-next-2020-02-26' of
https://github.com/intel/gvt-linux into drm-intel-next-queued
      Merge tag 'gvt-next-2020-03-10' of
https://github.com/intel/gvt-linux into drm-intel-next-queued
      drm/i915: Update DRIVER_DATE to 20200313

Rohit Khaire (2):
      drm/amdgpu: Don't write GCVM_L2_CNTL* regs on navi12 VF
      drm/amdgpu: Write blocked CP registers using RLC on VF

Roman Li (5):
      drm/amd/display: Fix psr static frames calculation
      drm/amd/display: remove early break in interdependent_lock
      drm/amd/display: Add dmcu f/w loading for NV12
      drm/amd/display: fix typo "to found" -> "to find"
      drm/amd/display: Remove PSR dependency on swizzle mode

Sam Ravnborg (11):
      dt-bindings: restrict properties for sitronix,st7735r
      dt-bindings: one file of all simple DSI panels
      drm/print: clean up RATELIMITED macros
      drm: drop unused drm_crtc callback
      drm: drop unused drm_display_mode.private
      dt-bindings: display: add panel-timing.yaml
      dt-bindings: display: convert display-timings to DT schema
      dt-bindings: display: convert panel-dpi to DT schema
      dt-bindings: display: add data-mapping to panel-dpi
      drm/panel: simple: add panel-dpi support
      dt-bindings: display: fix panel warnings

Samir Dhume (1):
      drm/amdgpu: Rearm IRQ in Navi10 SR-IOV if IRQ lost

Samson Tam (1):
      drm/amd/display: do not force UCLK DPM to stay at highest state
during display off in DCN2

Samuel Holland (5):
      drm/sun4i: dsi: Remove unused drv from driver context
      drm/sun4i: dsi: Use NULL to signify "no panel"
      drm/sun4i: dsi: Allow binding the host without a panel
      drm/sun4i: dsi: Remove incorrect use of runtime PM
      drm/sun4i: dsi: Avoid hotplug race with DRM driver bind

Sebastian Andrzej Siewior (2):
      drm/vmwgfx: Drop preempt_disable() in vmw_fifo_ping_host()
      drm/vmwgfx: Remove a few unused functions

Shirish S (1):
      amdgpu/gmc_v9: save/restore sdpif regs during S3

Souptick Joarder (1):
      video: fbdev: radeon: Remove dead code

Stanislav Lisovskiy (9):
      drm/i915: Fix inconsistance between pfit.enable and scaler freeing
      drm/i915: Remove skl_ddl_allocation struct
      drm/i915: Move dbuf slice update to proper place
      drm/i915: Update dbuf slices only with full modeset
      drm/i915: Introduce parameterized DBUF_CTL
      drm/i915: Manipulate DBuf slices properly
      drm/i915: Correctly map DBUF slices to pipes
      drm/i915: Ensure no conflicts with BIOS when updating Dbuf
      drm/i915: Use intel_plane_data_rate for min_cdclk calculation

Stanley.Yang (3):
      drm/amdgpu: use amdgpu_ras.h in amdgpu_debugfs.c
      drm/amd/display: fix typos for dcn20_funcs and dcn21_funcs struct
      drm/amdgpu: fix warning in ras_debugfs_create_all()

Steven Price (1):
      drm/panfrost: Remove core stack power management

Sung Lee (11):
      drm/amd/display: Do not set optimized_require to false after plane di=
sable
      drm/amd/display: Use dcfclk to populate watermark ranges
      drm/amd/display: Add wm ranges to clk_mgr
      drm/amd/display: DCN2.x Do not program DPPCLK if same value
      drm/amd/display: Revert "DCN2.x Do not program DPPCLK if same value"
      drm/amd/display: Make clock table struct more accessible
      drm/amd/display: Make clock table struct more accessible
      drm/amd/display: Remove DISPCLK Limit Floor for Certain SMU Versions
      drm/amd/display: Set clock optimization required after update clocks
      drm/amd/display: Revert "DCN2.x Do not program DPPCLK if same value"
      drm/amd/display: Program self refresh control register on boot

Swathi Dhanavanthri (1):
      drm/i915/tgl: Make Wa_1606700617 permanent

Swati Sharma (1):
      drm/i915/display: Decrease log level

Takashi Iwai (5):
      drm/amd/display: Fix wrongly passed static prefix
      drm/i915/gt: Use scnprintf() for avoiding potential buffer overflow
      drm/ttm: Use scnprintf() for avoiding potential buffer overflow
      drm: sysfs: Use scnprintf() for avoiding potential buffer overflow
      drm/msm: Use scnprintf() for avoiding potential buffer overflow

Tao Zhou (2):
      drm/amdgpu: add function to creat all ras debugfs node
      drm/amdgpu: call ras_debugfs_create_all in debugfs_init

Thomas Hellstrom (2):
      drm/vmwgfx: Fix the refuse_dma mode when using guest-backed objects
      drm/vmwgfx: Refuse DMA operation when SEV encryption is active

Thomas Hellstr=C3=B6m (VMware) (1):
      drm/vmwgfx: Use vmwgfx version 2.18 to signal SM5 compatibility

Thomas Zimmermann (50):
      drm: Initialize struct drm_crtc_state.no_vblank from device settings
      drm/arc: Remove sending of vblank event
      drm/ast: Don't set struct drm_crtc_state.no_vblank explicitly
      drm/bochs: Remove sending of vblank event
      drm/cirrus: Remove sending of vblank event
      drm/gm12u320: Remove sending of vblank event
      drm/ili9225: Remove sending of vblank event
      drm/mipi-dbi: Remove sending of vblank event
      drm/qxl: Remove sending of vblank event
      drm/repaper: Remove sending of vblank event
      drm/st7586: Remove sending of vblank event
      drm/udl: Don't set struct drm_crtc_state.no_vblank explicitly
      drm/vboxvideo: Remove sending of vblank event
      drm/virtio: Remove sending of vblank event
      drm/xen: Explicitly disable automatic sending of vblank event
      MAINTAINERS: Add Thomas as drm-misc co-maintainer
      drm/vram: Add helpers to validate a display mode's memory requirement=
s
      drm/bochs: Implement struct drm_mode_config_funcs.mode_valid
      drm/hibmc: Implement struct drm_mode_config_funcs.mode_valid
      drm/vboxvideo: Implement struct drm_mode_config_funcs.mode_valid
      drm/bochs: Clear struct drm_connector_funcs.dpms
      drm/udl: Clear struct drm_connector_funcs.dpms
      drm: Remove internal setup of struct drm_device.vblank_disable_immedi=
ate
      drm: Add get_scanout_position() to struct drm_crtc_helper_funcs
      drm: Add get_vblank_timestamp() to struct drm_crtc_funcs
      drm/amdgpu: Convert to struct drm_crtc_helper_funcs.get_scanout_posit=
ion()
      drm/amdgpu: Convert to CRTC VBLANK callbacks
      drm/gma500: Convert to CRTC VBLANK callbacks
      drm/i915: Convert to CRTC VBLANK callbacks
      drm/nouveau: Convert to struct
drm_crtc_helper_funcs.get_scanout_position()
      drm/nouveau: Convert to CRTC VBLANK callbacks
      drm/radeon: Convert to struct drm_crtc_helper_funcs.get_scanout_posit=
ion()
      drm/radeon: Convert to CRTC VBLANK callbacks
      drm/msm: Convert to struct drm_crtc_helper_funcs.get_scanout_position=
()
      drm/msm: Convert to CRTC VBLANK callbacks
      drm/stm: Convert to struct drm_crtc_helper_funcs.get_scanout_position=
()
      drm/stm: Convert to CRTC VBLANK callbacks
      drm/sti: Convert to CRTC VBLANK callbacks
      drm/vc4: Convert to struct drm_crtc_helper_funcs.get_scanout_position=
()
      drm/vc4: Convert to CRTC VBLANK callbacks
      drm/vkms: Convert to CRTC VBLANK callbacks
      drm/vmwgfx: Convert to CRTC VBLANK callbacks
      drm: Clean-up VBLANK-related callbacks in struct drm_driver
      drm: Remove legacy version of get_scanout_position()
      drm/simple-kms: Add drm_simple_encoder_{init,create}()
      drm/ast: Use simple encoder
      drm/mgag200: Use simple encoder
      drm/qxl: Use simple encoder
      drm/simple-kms: Fix documentation for drm_simple_encoder_init()
      drm/vblank: Fix documentation of VBLANK timestamp helper

Tian Tao (6):
      drm/hisilicon: Add new clock/resolution configurations
      drm/hisilicon: Enable the shadowfb for hibmc
      drm/hisilicon: fixed the wrong resolution configurations
      drm/hisilicon: Add the mode_valid function
      drm/hisilicon: Set preferred mode resolution and maximum resolution
      drm/hisilicon: Fixed pcie resource conflict between drm and firmware

Tianci.Yin (1):
      drm/amdgpu: disable 3D pipe 1 on Navi1x

Tiecheng Zhou (1):
      drm/amdgpu/sriov: skip programing some regs with new L1 policy

Tina Zhang (2):
      drm/i915/gvt: Fix drm_WARN issue where vgpu ptr is unavailable
      drm/i915/gvt: Fix dma-buf display blur issue on CFL

Tom St Denis (2):
      drm/amd/amdgpu: Add gfxoff debugfs entry
      drm/amd/amdgpu: Fix GPR read from debugfs (v2)

Tomi Valkeinen (2):
      drm/bridge: tfp410: add pclk limits
      drm/panel: simple: fix osd070t1718_19ts sync drive edge

Tony Cheng (1):
      drm/amd/display: fix workaround for incorrect double buffer
register for DLG ADL and TTU

Torsten Duwe (2):
      drm/bridge: analogix-anx78xx: Fix drm_dp_link helper removal
      drm/bridge: analogix-anx6345: Avoid duplicate -supply suffix

Tvrtko Ursulin (6):
      drm/i915: Align engine->uabi_class/instance with i915_drm.h
      drm/i915/debugfs: Remove i915_energy_uJ
      drm/i915: Track hw reported context runtime
      drm/i915/tgl: WaDisableGPGPUMidThreadPreemption
      drm/i915: Remove debugfs i915_drpc_info and i915_forcewake_domains
      drm/i915/gen12: Disable preemption timeout

Uma Shankar (1):
      drm/i915/display: Fix mode private_flags comparison at atomic_check

Umesh Nerlige Ramappa (2):
      drm/i915/perf: Fix OA context id overlap with idle context id
      drm/i915/perf: Invalidate OA TLB on when closing perf stream

Vandita Kulkarni (2):
      drm/i915/bios: Fix the timing parameters
      drm/i915/dsi: Enable ICL DSI transcoder as part of encoder->enable

Vasily Khoruzhick (5):
      drm/lima: fix recovering from PLBU out of memory
      drm/bridge: anx6345: don't print error message if regulator is not re=
ady
      dt-bindings: Add Guangdong Neweast Optoelectronics CO. LTD vendor pre=
fix
      dt-bindings: display: simple: Add NewEast Optoelectronics
WJFH116008A compatible
      drm/panel: simple: Add NewEast Optoelectronics CO., LTD
WJFH116008A panel support

Ville Syrj=C3=A4l=C3=A4 (96):
      drm/i915: Make a copy of the ggtt view for slave plane
      drm/i915/fbc: Move the plane state check into the fbc functions
      drm/i915/fbc: Nuke fbc_supported()
      drm/i915/fbc: Add fbc tracepoints
      drm/i915: Fix post-fastset modeset check for port sync
      drm/i915: Clear most of crtc state when disabling the crtc
      drm/i915: Prefer to use the pipe to index the ddb entries
      drm/i915: Use PIPE_CONF_CHECK_X() for sync_mode_slaves_mask
      drm/i915: Move encoder variable to tighter scope
      drm/i915/sdvo: Reduce the size of the on stack buffers
      drm/i915: Consolidate HDMI force_dvi handling
      drm/i915/sdvo: Consolidate SDVO HDMI force_dvi handling
      drm/i915: Use intel_attached_encoder()
      drm/i915: Relocate intel_attached_dp()
      drm/i915: Use intel_attached_dp() instead of hand rolling it
      drm/i915: Rename conn_to_dig_port() to intel_attached_dig_port()
      drm/i915/hdcp: Clean up local variables
      drm/i915: Clear old hw.fb & co. from slave plane's state
      drm/i915: Stop looking at plane->state in intel_prepare_plane_fb()
      drm/i915: s/intel_state/state/ in intel_{prepare,cleanup}_plane_fb()
      drm/i915: Balance prepare_fb/cleanup_fb
      drm/i915: Cleanup properly if the implicit fence setup fails
      drm/i915: Fix modeset locks in sanitize_watermarks()
      drm/i915: Prefer intel_connector over drm_connector in hotplug code
      drm/i915: Include the AUX CH name in the debug messages
      drm/i915: Give aux channels a better name
      drm/i915: Polish WM_LINETIME register stuff
      drm/i915: Move linetime wms into the crtc state
      drm/i915: Nuke skl wm.dirty_pipes bitmask
      drm/i915: Move more cdclk state handling into the cdclk code
      drm/i915: Collect more cdclk state under the same roof
      drm/i915: s/need_cd2x_updare/can_cd2x_update/
      drm/i915: s/cdclk_state/cdclk_config/
      drm/i915: Simplify intel_set_cdclk_{pre,post}_plane_update()
calling convention
      drm/i915: Extract intel_cdclk_state
      drm/i915: swap() the entire cdclk state
      drm/i915: s/init_cdclk/init_cdclk_hw/
      drm/i915: Move intel_atomic_state_free() into intel_atomic.c
      drm/i915: Introduce better global state handling
      drm/i915: Convert bandwidth state to global state
      drm/i915: Introduce intel_calc_active_pipes()
      drm/i915: Convert cdclk to global state
      drm/i915: Store active_pipes bitmask in cdclk state
      drm/i915: Introduce intel_connector_hpd_pin()
      drm/i915/crt: Configure connector->polled and encoder->hpd_pin
consistently
      drm/i915: Mark ns2501 as LVDS without a fixed mode
      drm/i915/dvo: Mark TMDS DVO connectors as polled
      drm/i915: Sprinkle missing commas
      drm/i915: Don't use uninitialized 'ret'
      drm/i915: Fix the docs for intel_set_cdclk_post_plane_update()
      drm/edid: Check the number of detailed timing descriptors in the
CEA ext block
      drm/edid: Don't accept any old garbage as a display descriptor
      drm/edid: Introduce is_detailed_timing_descritor()
      drm/edid: Clear out spurious whitespace
      drm/edid: Document why we don't bounds check the DispID CEA
block start/end
      drm/edid: Add a FIXME about DispID CEA data block revision
      drm/i915: Force state->modeset=3Dtrue when distrust_bios_wm=3D=3Dtrue
      drm/i915: Introduce encoder->compute_config_late()
      drm/i915: Add i9xx_lut_8()
      drm/i915/hpd: Replace the loop-within-loop with two independent loops
      drm/i915: Mark all HPD capabled connectors as such
      drm/i915: Parametrize PFIT_PIPE
      drm/i915: Use intel_de_write_fw() for skl+ scaler registers
      drm/i915: Correctly terminate connector iteration
      drm/i915: Set up PIPE_MISC truncate bit on tgl+
      drm/i915: Add glk to intel_detect_preproduction_hw()
      drm/i915: Nuke pre-production GLK HDMI w/a 1139
      drm/i915: Limit display Wa_1405510057 to gen11
      drm/i915: Drop WaDDIIOTimeout:glk
      drm/i915: Fix 90/270 degree rotated RGB565 src coord checks
      drm/i915: Handle some leftover s/intel_crtc/crtc/
      drm/i915: Remove garbage WARNs
      drm/i915: Add missing commas to dbuf tables
      drm/i915: Use a sentinel to terminate the dbuf slice arrays
      drm/i915: Polish CHV .load_luts() a bit
      drm/i915: Don't check uv_wm in skl_plane_wm_equals()
      drm/i915: Don't check for wm changes until we've compute the wms full=
y
      drm/i915: Enable transition watermarks for glk
      drm/i915: Implement display w/a 1140 for glk/cnl
      drm/i915: Polish CHV CGM CSC loading
      drm/i915: Clean up i9xx_load_luts_internal()
      drm/i915: Split i9xx_read_lut_8() to gmch vs. ilk variants
      drm/i915: s/blob_data/lut/
      drm/i915: s/chv_read_cgm_lut/chv_read_cgm_gamma/
      drm/i915: Clean up integer types in color code
      drm/i915: Refactor LUT read functions
      drm/i915: Fix readout of PIPEGCMAX
      drm/i915: Pass the crtc to the low level read_lut() funcs
      drm/i915: Lock gmbus/aux mutexes while changing cdclk
      drm/panel-novatek-nt35510: Fix dotclock
      drm/panel-ilitek-ili9322: Fix dotclocks
      drm/panel-lg-lg4573: Fix dotclock
      drm/panel-sony-acx424akp: Fix dotclocks
      drm/panel-simple: Fix dotclock for Logic PD Type 28
      drm/exynos: Use drm_encoder_mask()
      drm/exynos: Use mode->clock instead of reverse calculating it
from the vrefresh

Vivek Kasireddy (4):
      drm/i915/dsi: Lookup the i2c bus from ACPI NS only if CONFIG_ACPI=3Dy=
 (v2)
      drm/i915/dsi: Ensure that the ACPI adapter lookup overrides the bus n=
um
      drm/i915/ehl: Ensure that the DDI selection MUX is programmed correct=
ly
      drm/i915/hotplug: Use phy to get the hpd_pin instead of the port (v5)

Vladimir Stempen (1):
      drm/amd/display: programming last delta in output transfer
function LUT to a correct value

Wambui Karuga (56):
      drm/rockchip: use DIV_ROUND_UP macro for calculations.
      drm/i915: conversion to new logging macros in i915/i915_vgpu.c
      drm/i915: conversion to new logging macros in i915/intel_csr.c
      drm/i915: conversion to new logging macros in i915/intel_device_info.=
c
      drm/i915: convert to new logging macros in i915/intel_gvt.c
      drm/i915: convert to new logging macros in i915/intel_memory_region.c
      drm/i915/atomic: use struct drm_device logging macros
      drm/i915/bios: convert to struct drm_device logging macros.
      drm/i915/audio: convert to struct drm_device logging macros.
      drm/i915/bw: convert to drm_device based logging macros
      drm/i915/cdclk: use new struct drm_device logging macros
      drm/i915/display: conversion to new struct drm_device logging macros.
      drm/i915/dsi: conversion to struct drm_device log macros.
      drm/i915/power: convert to struct drm_device macros in
display/intel_display_power.c
      drm/i915/dp: conversion to struct drm_device logging macros.
      drm/i915/opregion: conversion to struct drm_device logging macros.
      drm/i915/hdcp: conversion to struct drm_device based logging macros.
      drm/i915/gem: initial conversion to new logging macros using coccinel=
le
      drm/i915/gem: manual conversion to struct drm_device logging macros.
      drm/i915/ggtt: use new drm logging macros in gt/intel_ggtt.c
      drm/i915/reset: conversion to new drm logging macros in gt/intel_rese=
t.c
      drm/i915/engine_cs: use new drm logging macros in gt/intel_engine_cs.=
c
      drm/i915/gt: convert to new logging macros in gt/intel_gt.c
      drm/i915/ring: convert to new logging macros in gt/intel_ring_submiss=
ion.c
      drm/i915/vlv_dsi_pll: conversion to struct drm_device logging macros.
      drm/i915/vlv_dsi: conversion to drm_device based logging macros.
      drm/i915/vga: conversion to drm_device based logging macros.
      drm/i915/vdsc: convert to struct drm_device based logging macros.
      drm/i915/tv: automatic conversion to drm_device based logging macros.
      drm/i915/tc: automatic conversion to drm_device based logging macros.
      drm/i915/sprite: automatic conversion to drm_device based logging mac=
ros
      drm/i915/sdvo: automatic conversion to drm_device based logging macro=
s.
      drm/i915/quirks: automatic conversion to drm_device based logging mac=
ros.
      drm/i915/psr: automatic conversion to drm_device based logging macros=
.
      drm/i915/pipe_crc: automatic conversion to drm_device based
logging macros.
      drm/i915/panel: automatic conversion to drm_device based logging macr=
os.
      drm/i915: conversion to drm_device logging macros when
drm_i915_private is present.
      drm/i915/debugfs: conversion to drm_device based logging macros.
      drm/i915/cmd_parser: conversion to struct drm_device logging macros.
      drm/i915/pci: conversion to drm_device based logging macros.
      drm/i915/dp_link_training: convert to drm_device based logging macros=
.
      drm/i915/atomic: conversion to drm_device based logging macros.
      drm/i915/color: conversion to drm_device based logging macros.
      drm/i915/crt: automatic conversion to drm_device based logging macros=
.
      drm/i915/dpll_mgr: convert to drm_device based logging macros.
      drm/i915/combo_phy: convert to struct drm_device logging macros.
      drm/i915/dsi_vbt: convert to drm_device based logging macros.
      drm/i915/dpio_phy: convert to drm_device based logging macros.
      drm/i915/perf: conversion to struct drm_device based logging macros.
      drm/i915/dsb: convert to drm_device based logging macros.
      drm/i915/fifo_underrun: convert to drm_device based logging.
      drm/i915/gmbus: convert to drm_device based logging,
      drm/i915/hotplug: convert to drm_device based logging.
      drm/i915/lpe_audio: convert to drm_device based logging macros.
      drm/i915/lvds: convert to drm_device based logging macros.
      drm/i915/overlay: convert to drm_device based logging.

Wen Yang (1):
      drm/omap: fix possible object reference leak

Wenjing Liu (12):
      drm/amd/display: decouple global lock out of pipe control lock
      drm/amd/display: no hdcp retry if bksv or ksv list is revoked
      drm/amd/display: update HDCP DTM immediately after hardware programmi=
ng
      drm/amd/display: only include FEC overhead if both asic and
display support FEC
      drm/amd/display: add vsc update support for test pattern request
      drm/amd/display: program DPG_OFFSET_SEGMENT for odm_pipe
      drm/amd/display: fix image corruption with ODM 2:1 DSC 2 slice
      drm/amd/display: determine is mst hdcp based on stream instead
of sink signal
      drm/amd/display: determine rx id list bytes to read based on device c=
ount
      drm/amd/display: fix a minor HDCP logging error
      drm/amd/display: separate FEC capability from fec debug flag
      drm/amd/display: remove magic numbers in hdcp_ddc

Wyatt Wood (10):
      drm/amd/display: Add set psr version message
      drm/amd/display: Remove unused values from psr struct
      drm/amd/display: Hookup psr set version call
      drm/amd/display: Add psr get_state call
      drm/amd/display: Add driver support for enabling PSR on DMCUB
      drm/amd/display: Add driver support for enabling PSR on DMCUB
      drm/amd/display: Add ABM command structs to DMCUB
      drm/amd/display: Set disable_dmcu flag properly per asic
      drm/amd/display: Fallback to dmcub for psr when dmcu is disabled
      drm/amd/display: Allocate scratch space for DMUB CW7

Xiaojie Yuan (1):
      drm/amd/powerplay: add smu if version for navi12

Xinliang Liu (1):
      MAINTAINERS: Update myself email address

Yannick Fertre (2):
      drm/stm: ltdc: add number of interrupts
      drm/stm: ltdc: check crtc state before enabling LIE

Yannick Fertr=C3=A9 (1):
      drm/bridge/synopsys: dsi: missing post disable

Yassine Oudjana (1):
      drm/[radeon|amdgpu]: Remove HAINAN board from max_sclk override check

Yintian Tao (5):
      drm/amdgpu: no need to clean debugfs at amdgpu
      drm/amdgpu: release drm_device after amdgpu_driver_unload_kms
      drm/amdgpu: clean wptr on wb when gpu recovery
      drm/amdgpu: miss PRT case when bo update
      drm/scheduler: fix rare NULL ptr race

Yong Zhao (13):
      drm/amdkfd: Rename queue_count to active_queue_count
      drm/amdkfd: Avoid ambiguity by indicating it's cp queue
      drm/amdkfd: Count active CP queues directly
      drm/amdkfd: Fix a memory leak in queue creation error handling
      drm/amdkfd: Delete excessive printings
      drm/amdkfd: Delete unnecessary unmap queue package submissions
      drm/amdgpu: Increase timout on emulator to tenfold instead of twice
      drm/amdgpu: Add num_banks and num_ranks to gfx config structure
      drm/amdkfd: Make get_tile_config() generic
      drm/amdgpu: Use better names to reflect it is CP MQD buffer
      drm/amdkfd: Add more comments on GFX9 user CP queue MQD workaround
      drm/amdkfd: Use pr_debug to print the message of reaching event limit
      drm/amdkfd: Consolidate duplicated bo alloc flags

Yongqiang Sun (8):
      drm/amd/display: Check hyperV flag in DC.
      drm/amd/display: Limit minimum DPPCLK to 100MHz.
      drm/amd/display: optimize prgoram wm and clks
      drm/amd/display: change number of cursor policy for dml calculation.
      drm/amd/display: Not check wm and clk change flag in optimized bandwi=
dth.
      drm/amd/display: workaround for HDMI hotplug in DPMSOFF state
      drm/amd/display: combine watermark change and clock change for
update clocks.
      drm/amd/display: DPP DTO isn't update properly.

Yu-ting Shen (1):
      drm/amd/display: limit display clock to 100MHz to avoid FIFO error

YueHaibing (4):
      drm/amd/display: Remove set but not unused variable 'stream_status'
      drm/amd/display: remove set but not used variable 'mc_vm_apt_default'
      drm/tidss: Drop pointless static qualifier in dispc_find_csc()
      video: fbdev: pxa168fb: remove unnecessary platform_get_irq

Zhan Liu (1):
      drm/amd/display: Add aconnector condition check for dpcd read

Zhang Xiaoxu (1):
      drm/i915: Fix i915_error_state_store error defination

Zheng Bin (5):
      drm/omap: use true,false for bool variable
      drm/msm/dpu: fix comparing pointer to 0 in dpu_encoder_phys_cmd.c
      drm/msm/dpu: fix comparing pointer to 0 in dpu_encoder_phys_vid.c
      drm/msm/dpu: fix comparing pointer to 0 in dpu_vbif.c
      drm/msm/dpu: fix comparing pointer to 0 in dpu_encoder.c

Zhenyu Wang (3):
      drm/i915/gvt: remove unused type attributes
      drm/i915/gvt: Enable vfio edid for all GVT supported platform
      Merge drm-intel-next-queued into gvt-next

Zhigang Luo (2):
      drm/amdgpu: add CAP fw loading
      Revert "drm/amdgpu: add CAP fw loading"

Zhihui Chen (3):
      drm/hisilicon/hibmc: fix 'xset dpms force off' fail
      drm/hisilicon/hibmc: add DPMS on/off function
      drm/hisilicon/hibmc: add gamma_set function

abdoulaye berthe (1):
      drm/amd/display: set lttpr mode before link settings

changzhu (2):
      drm/amdgpu: add is_raven_kicker judgement for raven1
      Revert "drm/scheduler: improve job distribution with multiple queues"

jianzh (1):
      drm/amdgpu/sriov: Use VF-accessible register for gpu_clock_count

kbuild test robot (1):
      drm/panfrost: default_supplies[] can be static

shaoyunl (1):
      drm/amdgpu/sriov : Don't resume RLCG for SRIOV guest

tongtiangen (1):
      drm/msm/dpu: Remove some set but not used variables

xinhui pan (5):
      drm/ttm: flush the fence on the bo after we individualize the
reservation object
      drm/amdgpu: Do not move root PT bo to relocated list
      drm/amdgpu: Remove kfd eviction fence before release bo (v2)
      drm/amdgpu: Correct the condition of warning while bo release
      drm_amdgpu: Add job fence to resv conditionally

yu kuai (6):
      video: fbdev: radeonfb: remove set but not used variable 'hSyncPol'
      video: fbdev: radeonfb: remove set but not used variable 'vSyncPol'
      video: fbdev: radeonfb: remove set but not used variable '=E2=80=98cS=
ync=E2=80=99'
      video: fbdev: radeonfb: remove set but not used variable 'bytpp'
      video: fbdev: kyrofb: remove set but not used variable 'ulScaleRight'
      video: fbdev: atyfb: remove set but not used variable 'mach64RefFreq'

 .../bindings/display/allwinner,sun4i-a10-tcon.yaml |    6 +
 .../bindings/display/bridge/adi,adv7511.txt        |   23 +-
 .../devicetree/bindings/display/bridge/ps8640.yaml |  112 +
 .../bindings/display/bridge/toshiba,tc358768.yaml  |  159 +
 .../bindings/display/ilitek,ili9486.yaml           |   73 +
 .../bindings/display/mediatek/mediatek,dpi.txt     |    1 +
 .../devicetree/bindings/display/msm/gmu.txt        |  116 -
 .../devicetree/bindings/display/msm/gmu.yaml       |  123 +
 .../devicetree/bindings/display/msm/gpu.txt        |   55 +-
 .../display/panel/advantech,idk-1110wr.yaml        |   69 +
 .../display/panel/advantech,idk-2121wr.yaml        |  122 +
 .../bindings/display/panel/auo,b080uan01.txt       |    7 -
 .../bindings/display/panel/auo,b101aw03.txt        |    7 -
 .../bindings/display/panel/auo,b101ean01.txt       |    7 -
 .../bindings/display/panel/auo,b101xtn01.txt       |    7 -
 .../bindings/display/panel/auo,b116xw03.txt        |    7 -
 .../bindings/display/panel/auo,b133htn01.txt       |    7 -
 .../bindings/display/panel/auo,b133xtn01.txt       |    7 -
 .../bindings/display/panel/auo,g070vvn01.txt       |   29 -
 .../bindings/display/panel/auo,g101evn010.txt      |   12 -
 .../bindings/display/panel/auo,g104sn02.txt        |   12 -
 .../bindings/display/panel/auo,g133han01.txt       |    7 -
 .../bindings/display/panel/auo,g185han01.txt       |    7 -
 .../bindings/display/panel/auo,p320hvn03.txt       |    8 -
 .../bindings/display/panel/auo,t215hvn01.txt       |    7 -
 .../bindings/display/panel/avic,tm070ddh03.txt     |    7 -
 .../bindings/display/panel/boe,hv070wsa-100.txt    |   28 -
 .../bindings/display/panel/boe,nv101wxmn51.txt     |    7 -
 .../bindings/display/panel/boe,tv080wum-nl0.txt    |    7 -
 .../bindings/display/panel/boe,tv101wum-nl6.yaml   |   80 +
 .../display/panel/cdtech,s043wq26h-ct7.txt         |   12 -
 .../display/panel/cdtech,s070wv95-ct16.txt         |   12 -
 .../display/panel/chunghwa,claa070wp03xg.txt       |    7 -
 .../display/panel/chunghwa,claa101wa01a.txt        |    7 -
 .../display/panel/chunghwa,claa101wb03.txt         |    7 -
 .../display/panel/dataimage,scf0700c48ggu18.txt    |    8 -
 .../bindings/display/panel/display-timing.txt      |  124 +-
 .../bindings/display/panel/display-timings.yaml    |   77 +
 .../bindings/display/panel/dlc,dlc1010gig.txt      |   12 -
 .../bindings/display/panel/edt,et-series.txt       |   55 -
 .../bindings/display/panel/elida,kd35t133.yaml     |   49 +
 .../display/panel/evervision,vgg804821.txt         |   12 -
 .../display/panel/feixin,k101-im2ba02.yaml         |   55 +
 .../display/panel/foxlink,fl500wvr00-a0t.txt       |    7 -
 .../bindings/display/panel/friendlyarm,hd702e.txt  |   32 -
 .../display/panel/giantplus,gpg482739qs5.txt       |    7 -
 .../bindings/display/panel/hannstar,hsd070pww1.txt |    7 -
 .../bindings/display/panel/hannstar,hsd100pxn1.txt |    7 -
 .../bindings/display/panel/hit,tx23d38vm0caa.txt   |    7 -
 .../bindings/display/panel/innolux,at043tn24.txt   |    7 -
 .../bindings/display/panel/innolux,at070tn92.txt   |    7 -
 .../bindings/display/panel/innolux,g070y2-l01.txt  |   12 -
 .../bindings/display/panel/innolux,g101ice-l01.txt |    7 -
 .../bindings/display/panel/innolux,g121i1-l01.txt  |    7 -
 .../bindings/display/panel/innolux,g121x1-l03.txt  |    7 -
 .../bindings/display/panel/innolux,n116bge.txt     |    7 -
 .../bindings/display/panel/innolux,n156bge-l21.txt |    7 -
 .../bindings/display/panel/innolux,zj070na-01p.txt |    7 -
 .../bindings/display/panel/koe,tx14d24vm1bpa.txt   |   42 -
 .../bindings/display/panel/koe,tx31d200vm0baa.txt  |   25 -
 .../bindings/display/panel/kyo,tcg121xglp.txt      |    7 -
 .../display/panel/leadtek,ltk500hd1829.yaml        |    2 +-
 .../display/panel/lemaker,bl035-rgb-002.txt        |   12 -
 .../bindings/display/panel/lg,lb070wv8.txt         |    7 -
 .../bindings/display/panel/lg,lp079qx1-sp0v.txt    |    7 -
 .../bindings/display/panel/lg,lp097qx1-spa1.txt    |    7 -
 .../bindings/display/panel/lg,lp120up1.txt         |    7 -
 .../bindings/display/panel/lg,lp129qe.txt          |    7 -
 .../display/panel/mitsubishi,aa070mc01.txt         |    7 -
 .../bindings/display/panel/nec,nl12880b20-05.txt   |    8 -
 .../bindings/display/panel/nec,nl4827hc19-05b.txt  |    7 -
 .../bindings/display/panel/netron-dy,e231732.txt   |    7 -
 .../panel/newhaven,nhd-4.3-480272ef-atxl.txt       |    7 -
 .../display/panel/nlt,nl192108ac18-02d.txt         |    8 -
 .../bindings/display/panel/novatek,nt35510.yaml    |   56 +
 .../devicetree/bindings/display/panel/nvd,9128.txt |    7 -
 .../display/panel/okaya,rs800480t-7x0gp.txt        |    7 -
 .../display/panel/olimex,lcd-olinuxino-43-ts.txt   |    7 -
 .../bindings/display/panel/ontat,yx700wv03.txt     |    7 -
 .../bindings/display/panel/orisetech,otm8009a.txt  |   23 -
 .../bindings/display/panel/orisetech,otm8009a.yaml |   53 +
 .../display/panel/ortustech,com37h3m05dtc.txt      |   12 -
 .../display/panel/ortustech,com37h3m99dtc.txt      |   12 -
 .../display/panel/ortustech,com43h4m85ulc.txt      |    7 -
 .../display/panel/osddisplays,osd070t1718-19ts.txt |   12 -
 .../display/panel/osddisplays,osd101t2045-53ts.txt |   11 -
 .../display/panel/panasonic,vvx10f004b00.txt       |    7 -
 .../display/panel/panasonic,vvx10f034n00.txt       |   20 -
 .../bindings/display/panel/panel-common.yaml       |   15 +-
 .../bindings/display/panel/panel-dpi.txt           |   50 -
 .../bindings/display/panel/panel-dpi.yaml          |   81 +
 .../bindings/display/panel/panel-simple-dsi.yaml   |   67 +
 .../bindings/display/panel/panel-simple.yaml       |  209 ++
 .../bindings/display/panel/panel-timing.yaml       |  227 ++
 .../display/panel/qiaodian,qd43003c0-40.txt        |    7 -
 .../bindings/display/panel/raydium,rm68200.txt     |   25 -
 .../bindings/display/panel/raydium,rm68200.yaml    |   56 +
 .../display/panel/rocktech,rk070er9427.txt         |   25 -
 .../display/panel/samsung,lsn122dl01-c01.txt       |    7 -
 .../bindings/display/panel/samsung,ltn101nt05.txt  |    7 -
 .../display/panel/samsung,ltn140at29-301.txt       |    7 -
 .../display/panel/samsung,s6e88a0-ams452ef01.yaml  |   50 +
 .../bindings/display/panel/sharp,lq035q7db03.txt   |   12 -
 .../bindings/display/panel/sharp,lq070y3dg3b.txt   |   12 -
 .../bindings/display/panel/sharp,lq101k1ly04.txt   |    7 -
 .../bindings/display/panel/sharp,lq123p1jx31.txt   |    7 -
 .../display/panel/shelly,sca07010-bfn-lnn.txt      |    7 -
 .../bindings/display/panel/starry,kr122ea0sra.txt  |    7 -
 .../bindings/display/panel/tianma,tm070jdhg30.txt  |    7 -
 .../bindings/display/panel/tianma,tm070rvhg71.txt  |   29 -
 .../display/panel/toshiba,lt089ac29000.txt         |    8 -
 .../bindings/display/panel/tpk,f07a-0102.txt       |    8 -
 .../bindings/display/panel/tpk,f10a-0102.txt       |    8 -
 .../bindings/display/panel/urt,umsh-8596md.txt     |   16 -
 .../bindings/display/panel/vl050_8048nt_c01.txt    |   12 -
 .../bindings/display/panel/winstar,wf35ltiacd.txt  |   48 -
 .../bindings/display/panel/xinpeng,xpp055c272.yaml |    2 +-
 .../bindings/display/rockchip/rockchip-drm.txt     |   19 -
 .../bindings/display/rockchip/rockchip-drm.yaml    |   40 +
 .../bindings/display/sitronix,st7735r.txt          |   35 -
 .../bindings/display/sitronix,st7735r.yaml         |   78 +
 .../bindings/display/ti/ti,am65x-dss.yaml          |  152 +
 .../bindings/display/ti/ti,j721e-dss.yaml          |  208 ++
 .../devicetree/bindings/display/ti/ti,k2g-dss.yaml |  106 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   10 +
 Documentation/gpu/drm-kms-helpers.rst              |   18 +-
 Documentation/gpu/i915.rst                         |    8 +-
 Documentation/gpu/todo.rst                         |   53 +-
 MAINTAINERS                                        |   44 +-
 arch/arm/configs/davinci_all_defconfig             |    2 +-
 arch/arm/configs/integrator_defconfig              |    2 +-
 arch/arm/configs/multi_v7_defconfig                |    2 +-
 arch/arm/configs/omap2plus_defconfig               |    7 +-
 arch/arm/configs/shmobile_defconfig                |    2 +-
 arch/arm/configs/sunxi_defconfig                   |    2 +-
 arch/arm/configs/versatile_defconfig               |    2 +-
 drivers/dma-buf/Kconfig                            |   12 +-
 drivers/dma-buf/dma-buf.c                          |  110 +-
 drivers/gpu/drm/Kconfig                            |    8 +-
 drivers/gpu/drm/Makefile                           |    4 +-
 drivers/gpu/drm/amd/acp/Kconfig                    |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |   51 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |   13 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c    |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c |   34 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c  |   26 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c  |   26 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  |   24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h  |    2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |   95 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     |   17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            |  169 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |  177 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h        |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  152 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |   16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c        |  124 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c            |   17 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h            |    5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   78 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c             |    5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |    3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |   11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |   17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |    7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c            |    6 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |   35 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c          |    1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h          |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h           |    5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c           |    1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |   51 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |    4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             |   12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h             |    2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  214 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |   14 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |  120 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h            |    2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c     |   98 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h     |    2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |   93 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |   12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h            |    3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c           |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h           |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c           |   51 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h           |   15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  119 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |    2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c            |    1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |   13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h           |    3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  191 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |    5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c         |   29 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c        |   35 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c           |  250 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h           |   12 +-
 drivers/gpu/drm/amd/amdgpu/atom.c                  |    4 +-
 drivers/gpu/drm/amd/amdgpu/atombios_dp.c           |   10 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |    5 +
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c             |    5 +
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |    5 +
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |    5 +
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c           |    6 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |  187 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              |   24 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |  148 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  476 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c              |    5 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h              |    2 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c           |   67 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |  109 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c            |   12 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c            |   29 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c            |   12 +
 drivers/gpu/drm/amd/amdgpu/mmsch_v2_0.h            |  338 ++
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c             |   36 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c             |   15 +-
 drivers/gpu/drm/amd/amdgpu/nv.c                    |    3 +-
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h            |    3 +
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c             |   90 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |   20 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c             |    6 +-
 drivers/gpu/drm/amd/amdgpu/si_dpm.c                |    1 -
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c         |   14 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |   14 +
 drivers/gpu/drm/amd/amdgpu/soc15.h                 |    7 +
 drivers/gpu/drm/amd/amdgpu/soc15_common.h          |    5 +-
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.c              |   23 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c              |  257 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c              |   35 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |    4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |   32 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  152 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |    7 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c            |    2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c       |    2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |   18 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c    |    9 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   11 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |  150 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |   27 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |    5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h          |    1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  310 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   37 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |   91 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |  242 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h |    9 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |   30 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |   49 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |    4 +-
 .../gpu/drm/amd/display/dc/bios/command_table2.c   |    4 +-
 .../amd/display/dc/bios/command_table_helper2.c    |   13 +-
 drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c   |   46 +-
 drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c   |   25 +-
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c   |   26 +-
 .../amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c   |   13 +-
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  |   21 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  162 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |  197 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c  |   60 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |  298 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c |   58 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  200 +-
 drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c |    5 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |   39 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h       |   48 +
 drivers/gpu/drm/amd/display/dc/dc_link.h           |   20 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |    1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h          |    4 +-
 drivers/gpu/drm/amd/display/dc/dce/Makefile        |    2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c       |    2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c      |   16 +
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c    |   23 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c |    2 +-
 .../gpu/drm/amd/display/dc/dce/dce_scl_filters.c   | 2204 ++++++------
 .../drm/amd/display/dc/dce/dce_scl_filters_old.c   |   25 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c      |   92 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h      |   11 +-
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |   58 +-
 .../amd/display/dc/dce110/dce110_hw_sequencer.h    |    4 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c |   13 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c    |  168 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h    |    8 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |  129 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h  |    7 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c  |    4 +
 .../drm/amd/display/dc/dcn10/dcn10_link_encoder.c  |    5 +
 .../drm/amd/display/dc/dcn10/dcn10_link_encoder.h  |    2 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c  |    8 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |    8 +-
 .../amd/display/dc/dcn10/dcn10_stream_encoder.c    |    1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c  |    2 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c   |   78 -
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c   |    2 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c    |   11 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |  125 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h |    7 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c  |    5 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mmhubbub.h  |   20 -
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.c   |    8 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.h   |    9 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |  204 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.h  |   11 +-
 .../amd/display/dc/dcn20/dcn20_stream_encoder.c    |    1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.h  |    7 -
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c    |  138 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.h    |    8 +-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c  |   39 +-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c |   22 +
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.h |    3 +
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c  |    6 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c  |  208 +-
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h         |    1 +
 .../display/dc/dml/dcn20/display_mode_vba_20v2.c   |    8 +
 .../drm/amd/display/dc/dml/display_mode_structs.h  |   12 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.c  |   11 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.h  |    4 -
 drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c   |    2 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c |    2 +-
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |    2 +-
 drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h    |    2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h    |    2 +
 .../drm/amd/display/dc/inc/hw/clk_mgr_internal.h   |    4 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h       |    3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h   |    2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h        |    1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h        |    3 +-
 .../gpu/drm/amd/display/dc/inc/hw/link_encoder.h   |    1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h        |    3 +-
 .../gpu/drm/amd/display/dc/inc/hw/stream_encoder.h |    1 +
 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h  |    6 +-
 .../drm/amd/display/dc/inc/hw_sequencer_private.h  |    7 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h      |    3 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |   72 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h    |   13 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_gpint_cmd.h  |   75 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h    |   51 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c  |   69 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h  |    9 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    |   67 +-
 drivers/gpu/drm/amd/display/include/dal_asic_id.h  |   28 +-
 drivers/gpu/drm/amd/display/include/dpcd_defs.h    |    8 +
 drivers/gpu/drm/amd/display/include/logger_types.h |   63 +-
 .../drm/amd/display/modules/freesync/freesync.c    |    8 +-
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c    |   69 +-
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h    |   60 +-
 .../drm/amd/display/modules/hdcp/hdcp1_execution.c |    6 +-
 .../amd/display/modules/hdcp/hdcp1_transition.c    |   15 +-
 .../drm/amd/display/modules/hdcp/hdcp2_execution.c |   12 +-
 .../amd/display/modules/hdcp/hdcp2_transition.c    |    6 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c    |   36 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp_log.c    |    4 +
 .../gpu/drm/amd/display/modules/hdcp/hdcp_log.h    |   17 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp_psp.c    |  183 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp_psp.h    |   32 +-
 drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h |   10 +-
 .../drm/amd/display/modules/inc/mod_info_packet.h  |    3 +-
 .../amd/display/modules/info_packet/info_packet.c  |   20 +-
 drivers/gpu/drm/amd/display/modules/vmid/vmid.c    |   16 +-
 .../include/asic_reg/wafl/wafl2_4_0_0_sh_mask.h    |   69 +
 .../amd/include/asic_reg/wafl/wafl2_4_0_0_smn.h    |   29 +
 .../amd/include/asic_reg/xgmi/xgmi_4_0_0_sh_mask.h |   69 +
 .../drm/amd/include/asic_reg/xgmi/xgmi_4_0_0_smn.h |   29 +
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h    |   31 +-
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         |  199 +-
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       |   56 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |    6 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |    4 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c |    7 +-
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h     |   12 +-
 drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h |    6 +-
 drivers/gpu/drm/amd/powerplay/inc/pp_debug.h       |    4 +-
 .../drm/amd/powerplay/inc/smu11_driver_if_navi10.h |    3 +-
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h      |   13 +-
 drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h      |    5 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         |   59 +-
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c         |   43 +-
 drivers/gpu/drm/amd/powerplay/smu_internal.h       |   14 +-
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c          |  155 +-
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c          |   88 +-
 .../gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c   |   11 +
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c         |   70 +-
 drivers/gpu/drm/arc/arcpgu_crtc.c                  |   16 -
 drivers/gpu/drm/arc/arcpgu_hdmi.c                  |    2 +-
 drivers/gpu/drm/armada/armada_fbdev.c              |    8 +-
 drivers/gpu/drm/ast/ast_drv.h                      |    6 +-
 drivers/gpu/drm/ast/ast_main.c                     |   24 +-
 drivers/gpu/drm/ast/ast_mode.c                     |   27 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   |    2 +-
 drivers/gpu/drm/bochs/bochs_drv.c                  |    6 +-
 drivers/gpu/drm/bochs/bochs_hw.c                   |   24 +-
 drivers/gpu/drm/bochs/bochs_kms.c                  |   34 +-
 drivers/gpu/drm/bridge/Kconfig                     |   51 +-
 drivers/gpu/drm/bridge/Makefile                    |    6 +-
 drivers/gpu/drm/bridge/adv7511/Kconfig             |   13 +-
 drivers/gpu/drm/bridge/adv7511/Makefile            |    3 +-
 drivers/gpu/drm/bridge/adv7511/adv7511.h           |   40 +-
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |   28 +-
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c |   20 +-
 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c |   13 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |   54 +-
 drivers/gpu/drm/bridge/cdns-dsi.c                  |    6 +-
 drivers/gpu/drm/bridge/display-connector.c         |  295 ++
 drivers/gpu/drm/bridge/dumb-vga-dac.c              |  300 --
 drivers/gpu/drm/bridge/lvds-codec.c                |   21 +-
 .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   |    8 +-
 drivers/gpu/drm/bridge/nxp-ptn3460.c               |    8 +-
 drivers/gpu/drm/bridge/panel.c                     |   23 +-
 drivers/gpu/drm/bridge/parade-ps8622.c             |    8 +-
 drivers/gpu/drm/bridge/parade-ps8640.c             |  349 ++
 drivers/gpu/drm/bridge/sii902x.c                   |    8 +-
 drivers/gpu/drm/bridge/sil-sii8620.c               |    3 +-
 drivers/gpu/drm/bridge/simple-bridge.c             |  342 ++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |  329 +-
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      |   11 +-
 drivers/gpu/drm/bridge/tc358764.c                  |   11 +-
 drivers/gpu/drm/bridge/tc358767.c                  |    9 +-
 drivers/gpu/drm/bridge/tc358768.c                  | 1046 ++++++
 drivers/gpu/drm/bridge/thc63lvd1024.c              |    5 +-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |  267 +-
 drivers/gpu/drm/bridge/ti-tfp410.c                 |  235 +-
 drivers/gpu/drm/bridge/ti-tpd12s015.c              |  211 ++
 drivers/gpu/drm/cirrus/cirrus.c                    |   51 +-
 drivers/gpu/drm/drm_atomic.c                       |  117 +
 drivers/gpu/drm/drm_atomic_helper.c                |   83 +-
 drivers/gpu/drm/drm_atomic_state_helper.c          |  102 +
 drivers/gpu/drm/drm_auth.c                         |    8 -
 drivers/gpu/drm/drm_bridge.c                       |  751 ++++-
 drivers/gpu/drm/drm_bridge_connector.c             |  379 +++
 drivers/gpu/drm/drm_bufs.c                         |   40 +-
 drivers/gpu/drm/drm_client.c                       |    2 +-
 drivers/gpu/drm/drm_client_modeset.c               |   12 +-
 drivers/gpu/drm/drm_connector.c                    |   96 +-
 drivers/gpu/drm/drm_context.c                      |   28 +-
 drivers/gpu/drm/drm_crtc_helper.c                  |    4 -
 drivers/gpu/drm/drm_crtc_internal.h                |    2 +
 drivers/gpu/drm/drm_debugfs.c                      |    3 +-
 drivers/gpu/drm/drm_debugfs_crc.c                  |    2 +-
 drivers/gpu/drm/drm_dma.c                          |   21 +-
 drivers/gpu/drm/drm_dp_helper.c                    |  141 +-
 drivers/gpu/drm/drm_dp_mst_topology.c              |  200 +-
 drivers/gpu/drm/drm_drv.c                          |   20 +-
 drivers/gpu/drm/drm_edid.c                         |  211 +-
 drivers/gpu/drm/drm_fb_helper.c                    |   22 +-
 drivers/gpu/drm/drm_file.c                         |   90 +-
 drivers/gpu/drm/drm_format_helper.c                |    2 +-
 drivers/gpu/drm/drm_framebuffer.c                  |  122 +
 drivers/gpu/drm/drm_gem.c                          |    2 +-
 drivers/gpu/drm/drm_gem_vram_helper.c              |   61 +
 drivers/gpu/drm/drm_hdcp.c                         |  158 +-
 drivers/gpu/drm/drm_internal.h                     |    5 +-
 drivers/gpu/drm/drm_ioctl.c                        |    1 +
 drivers/gpu/drm/drm_irq.c                          |    4 -
 drivers/gpu/drm/drm_lock.c                         |   11 +-
 drivers/gpu/drm/drm_mipi_dbi.c                     |   39 +-
 drivers/gpu/drm/drm_mm.c                           |   10 +-
 drivers/gpu/drm/drm_pci.c                          |   82 +-
 drivers/gpu/drm/drm_scatter.c                      |    3 +
 drivers/gpu/drm/drm_simple_kms_helper.c            |   46 +-
 drivers/gpu/drm/drm_syncobj.c                      |   87 +-
 drivers/gpu/drm/drm_sysfs.c                        |    4 +-
 drivers/gpu/drm/drm_vblank.c                       |  177 +-
 drivers/gpu/drm/drm_vm.c                           |   26 +-
 drivers/gpu/drm/etnaviv/etnaviv_buffer.c           |   60 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.c              |    1 +
 drivers/gpu/drm/etnaviv/etnaviv_drv.h              |    1 +
 drivers/gpu/drm/etnaviv/etnaviv_gem.c              |    4 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem.h              |    2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c              |   52 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h              |    6 +-
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c             |   42 +-
 drivers/gpu/drm/etnaviv/etnaviv_perfmon.c          |   59 +-
 drivers/gpu/drm/etnaviv/state_blt.xml.h            |    2 +
 drivers/gpu/drm/etnaviv/state_hi.xml.h             |   36 +-
 drivers/gpu/drm/exynos/exynos7_drm_decon.c         |    2 +-
 drivers/gpu/drm/exynos/exynos_dp.c                 |    3 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.c            |    5 +-
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |    5 +-
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c          |   10 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |    2 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c          |    2 +-
 drivers/gpu/drm/gma500/cdv_intel_display.c         |    3 +
 drivers/gpu/drm/gma500/framebuffer.c               |    6 +-
 drivers/gpu/drm/gma500/intel_bios.h                |    2 +-
 drivers/gpu/drm/gma500/psb_drv.c                   |    4 -
 drivers/gpu/drm/gma500/psb_drv.h                   |    6 +-
 drivers/gpu/drm/gma500/psb_intel_display.c         |    3 +
 drivers/gpu/drm/gma500/psb_irq.c                   |   12 +-
 drivers/gpu/drm/gma500/psb_irq.h                   |    7 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c     |   79 +
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c    |    9 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_regs.h   |   13 +
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c   |   11 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c        |    1 +
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c       |    2 +-
 drivers/gpu/drm/i2c/tda998x_drv.c                  |   10 +-
 drivers/gpu/drm/i915/Kconfig                       |    7 -
 drivers/gpu/drm/i915/Kconfig.profile               |   25 +-
 drivers/gpu/drm/i915/Makefile                      |   19 +-
 drivers/gpu/drm/i915/display/icl_dsi.c             |  406 ++-
 drivers/gpu/drm/i915/display/intel_acpi.c          |   89 +
 drivers/gpu/drm/i915/display/intel_acpi.h          |    5 +
 drivers/gpu/drm/i915/display/intel_atomic.c        |   57 +-
 drivers/gpu/drm/i915/display/intel_atomic.h        |    5 +-
 drivers/gpu/drm/i915/display/intel_atomic_plane.c  |   97 +-
 drivers/gpu/drm/i915/display/intel_atomic_plane.h  |    8 +-
 drivers/gpu/drm/i915/display/intel_audio.c         |  255 +-
 drivers/gpu/drm/i915/display/intel_bios.c          |  444 ++-
 drivers/gpu/drm/i915/display/intel_bios.h          |   13 +-
 drivers/gpu/drm/i915/display/intel_bw.c            |   63 +-
 drivers/gpu/drm/i915/display/intel_bw.h            |    4 +-
 drivers/gpu/drm/i915/display/intel_cdclk.c         | 1106 +++---
 drivers/gpu/drm/i915/display/intel_cdclk.h         |   73 +-
 drivers/gpu/drm/i915/display/intel_color.c         |  602 ++--
 drivers/gpu/drm/i915/display/intel_combo_phy.c     |  163 +-
 drivers/gpu/drm/i915/display/intel_connector.c     |    5 +-
 drivers/gpu/drm/i915/display/intel_crt.c           |  128 +-
 drivers/gpu/drm/i915/{ =3D> display}/intel_csr.c     |   46 +-
 drivers/gpu/drm/i915/{ =3D> display}/intel_csr.h     |    0
 drivers/gpu/drm/i915/display/intel_ddi.c           | 1385 +++-----
 drivers/gpu/drm/i915/display/intel_ddi.h           |    4 -
 drivers/gpu/drm/i915/display/intel_de.h            |   72 +
 drivers/gpu/drm/i915/display/intel_display.c       | 3546 +++++++++++-----=
----
 drivers/gpu/drm/i915/display/intel_display.h       |   17 +-
 .../gpu/drm/i915/display/intel_display_debugfs.c   | 2134 ++++++++++++
 .../gpu/drm/i915/display/intel_display_debugfs.h   |   20 +
 drivers/gpu/drm/i915/display/intel_display_power.c |  754 +++--
 drivers/gpu/drm/i915/display/intel_display_power.h |    6 +
 drivers/gpu/drm/i915/display/intel_display_types.h |  119 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |  876 +++--
 drivers/gpu/drm/i915/display/intel_dp.h            |    2 -
 .../gpu/drm/i915/display/intel_dp_aux_backlight.c  |  193 +-
 .../gpu/drm/i915/display/intel_dp_link_training.c  |   75 +-
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |   96 +-
 drivers/gpu/drm/i915/display/intel_dpio_phy.c      |  108 +-
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c      | 1521 ++++++---
 drivers/gpu/drm/i915/display/intel_dpll_mgr.h      |   14 +-
 drivers/gpu/drm/i915/display/intel_dsb.c           |   58 +-
 .../gpu/drm/i915/display/intel_dsi_dcs_backlight.c |    6 +-
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c       |  168 +-
 drivers/gpu/drm/i915/display/intel_dvo.c           |   50 +-
 drivers/gpu/drm/i915/display/intel_fbc.c           |  264 +-
 drivers/gpu/drm/i915/display/intel_fbc.h           |   13 +-
 drivers/gpu/drm/i915/display/intel_fbdev.c         |   18 +-
 drivers/gpu/drm/i915/display/intel_fifo_underrun.c |   66 +-
 drivers/gpu/drm/i915/display/intel_global_state.c  |  223 ++
 drivers/gpu/drm/i915/display/intel_global_state.h  |   87 +
 drivers/gpu/drm/i915/display/intel_gmbus.c         |  111 +-
 drivers/gpu/drm/i915/display/intel_hdcp.c          |  527 +--
 drivers/gpu/drm/i915/display/intel_hdcp.h          |    7 +-
 drivers/gpu/drm/i915/display/intel_hdmi.c          |  433 +--
 drivers/gpu/drm/i915/display/intel_hdmi.h          |    2 -
 drivers/gpu/drm/i915/display/intel_hotplug.c       |  203 +-
 drivers/gpu/drm/i915/display/intel_hotplug.h       |    2 -
 drivers/gpu/drm/i915/display/intel_lpe_audio.c     |   39 +-
 drivers/gpu/drm/i915/display/intel_lvds.c          |  108 +-
 drivers/gpu/drm/i915/display/intel_opregion.c      |  223 +-
 drivers/gpu/drm/i915/display/intel_overlay.c       |   69 +-
 drivers/gpu/drm/i915/display/intel_panel.c         |  407 ++-
 drivers/gpu/drm/i915/display/intel_pipe_crc.c      |   51 +-
 drivers/gpu/drm/i915/display/intel_pipe_crc.h      |    4 +-
 drivers/gpu/drm/i915/display/intel_psr.c           |  363 +-
 drivers/gpu/drm/i915/display/intel_quirks.c        |   20 +-
 drivers/gpu/drm/i915/display/intel_sdvo.c          |  114 +-
 drivers/gpu/drm/i915/display/intel_sdvo.h          |    2 -
 drivers/gpu/drm/i915/display/intel_sprite.c        |  465 +--
 drivers/gpu/drm/i915/display/intel_tc.c            |   51 +-
 drivers/gpu/drm/i915/display/intel_tv.c            |  165 +-
 drivers/gpu/drm/i915/display/intel_vbt_defs.h      |    2 +-
 drivers/gpu/drm/i915/display/intel_vdsc.c          |  445 ++-
 drivers/gpu/drm/i915/display/intel_vga.c           |   14 +-
 drivers/gpu/drm/i915/display/vlv_dsi.c             |  494 ++-
 drivers/gpu/drm/i915/display/vlv_dsi_pll.c         |   96 +-
 drivers/gpu/drm/i915/gem/i915_gem_client_blt.c     |    2 +-
 drivers/gpu/drm/i915/gem/i915_gem_context.c        |  504 ++-
 drivers/gpu/drm/i915/gem/i915_gem_context.h        |    9 +-
 drivers/gpu/drm/i915/gem/i915_gem_context_types.h  |   13 +-
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c         |    8 +-
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c     |  789 ++---
 drivers/gpu/drm/i915/gem/i915_gem_internal.c       |    2 -
 drivers/gpu/drm/i915/gem/i915_gem_mman.c           |    5 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.h         |    6 +-
 drivers/gpu/drm/i915/gem/i915_gem_object_blt.c     |   18 +-
 drivers/gpu/drm/i915/gem/i915_gem_object_types.h   |    2 +-
 drivers/gpu/drm/i915/gem/i915_gem_pages.c          |    4 +-
 drivers/gpu/drm/i915/gem/i915_gem_phys.c           |    7 +-
 drivers/gpu/drm/i915/gem/i915_gem_pm.c             |    3 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c          |    3 +-
 drivers/gpu/drm/i915/gem/i915_gem_shrinker.c       |   14 +-
 drivers/gpu/drm/i915/gem/i915_gem_stolen.c         |  136 +-
 drivers/gpu/drm/i915/gem/i915_gem_stolen.h         |    1 -
 drivers/gpu/drm/i915/gem/i915_gem_tiling.c         |    1 -
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c        |   21 +-
 drivers/gpu/drm/i915/gem/selftests/huge_pages.c    |  102 -
 .../gpu/drm/i915/gem/selftests/i915_gem_context.c  |  178 +-
 .../drm/i915/gem/selftests/i915_gem_object_blt.c   |   74 +-
 drivers/gpu/drm/i915/gem/selftests/igt_gem_utils.c |    2 +-
 drivers/gpu/drm/i915/gem/selftests/mock_context.c  |    8 +-
 drivers/gpu/drm/i915/gt/gen7_renderclear.c         |  402 +++
 drivers/gpu/drm/i915/gt/gen7_renderclear.h         |   15 +
 drivers/gpu/drm/i915/gt/gen8_ppgtt.c               |   27 +
 drivers/gpu/drm/i915/gt/hsw_clear_kernel.c         |   61 +
 drivers/gpu/drm/i915/gt/intel_context.c            |   16 +-
 drivers/gpu/drm/i915/gt/intel_context.h            |   25 +
 drivers/gpu/drm/i915/gt/intel_context_param.c      |   63 +
 drivers/gpu/drm/i915/gt/intel_context_param.h      |   14 +
 drivers/gpu/drm/i915/gt/intel_context_sseu.c       |   98 +
 drivers/gpu/drm/i915/gt/intel_context_types.h      |   25 +-
 drivers/gpu/drm/i915/gt/intel_engine.h             |   37 +-
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          |  174 +-
 drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c   |    8 +-
 drivers/gpu/drm/i915/gt/intel_engine_pm.c          |    4 +-
 drivers/gpu/drm/i915/gt/intel_engine_types.h       |   13 +-
 drivers/gpu/drm/i915/gt/intel_engine_user.c        |    3 +-
 drivers/gpu/drm/i915/gt/intel_ggtt.c               |  106 +-
 drivers/gpu/drm/i915/gt/intel_gpu_commands.h       |   17 +-
 drivers/gpu/drm/i915/gt/intel_gt.c                 |   68 +-
 drivers/gpu/drm/i915/gt/intel_gt.h                 |    2 +-
 drivers/gpu/drm/i915/gt/intel_gt_irq.c             |  117 +-
 drivers/gpu/drm/i915/gt/intel_gt_irq.h             |    3 +-
 drivers/gpu/drm/i915/gt/intel_gt_pm.c              |    2 +-
 drivers/gpu/drm/i915/gt/intel_gtt.c                |   65 +-
 drivers/gpu/drm/i915/gt/intel_gtt.h                |   11 +-
 drivers/gpu/drm/i915/gt/intel_llc.c                |    6 +-
 drivers/gpu/drm/i915/gt/intel_lrc.c                |  386 ++-
 drivers/gpu/drm/i915/gt/intel_lrc_reg.h            |    1 +
 drivers/gpu/drm/i915/gt/intel_mocs.c               |   76 +-
 drivers/gpu/drm/i915/gt/intel_rc6.c                |   29 +-
 drivers/gpu/drm/i915/gt/intel_reset.c              |  109 +-
 drivers/gpu/drm/i915/gt/intel_ring.c               |    6 +-
 drivers/gpu/drm/i915/gt/intel_ring_submission.c    |  236 +-
 drivers/gpu/drm/i915/gt/intel_rps.c                |   78 +-
 drivers/gpu/drm/i915/gt/intel_timeline.c           |    6 +-
 drivers/gpu/drm/i915/gt/intel_workarounds.c        |  244 +-
 drivers/gpu/drm/i915/gt/intel_workarounds_types.h  |    4 +-
 drivers/gpu/drm/i915/gt/ivb_clear_kernel.c         |   61 +
 drivers/gpu/drm/i915/gt/mock_engine.c              |    7 +-
 .../gpu/drm/i915/gt/selftest_engine_heartbeat.c    |   30 +-
 drivers/gpu/drm/i915/gt/selftest_hangcheck.c       |    4 +-
 drivers/gpu/drm/i915/gt/selftest_llc.c             |   11 +-
 drivers/gpu/drm/i915/gt/selftest_lrc.c             | 1924 +++++++++--
 drivers/gpu/drm/i915/gt/selftest_mocs.c            |   24 +-
 drivers/gpu/drm/i915/gt/selftest_rc6.c             |   28 +-
 drivers/gpu/drm/i915/gt/selftest_reset.c           |    2 +-
 drivers/gpu/drm/i915/gt/selftest_ring_submission.c |  296 ++
 drivers/gpu/drm/i915/gt/selftest_timeline.c        |  188 +-
 drivers/gpu/drm/i915/gt/selftest_workarounds.c     |    9 +
 drivers/gpu/drm/i915/gt/sysfs_engines.c            |  445 +++
 drivers/gpu/drm/i915/gt/sysfs_engines.h            |   13 +
 drivers/gpu/drm/i915/gt/uc/intel_guc.c             |   30 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc.h             |   23 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c          |  255 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_ct.h          |    7 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c  |   13 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.h  |   19 +-
 drivers/gpu/drm/i915/gt/uc/intel_huc.c             |    7 +-
 drivers/gpu/drm/i915/gt/uc/intel_huc.h             |    8 +-
 drivers/gpu/drm/i915/gt/uc/intel_huc_fw.c          |    2 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc.c              |   69 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc.h              |   62 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c           |   11 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.h           |   18 +-
 drivers/gpu/drm/i915/gvt/aperture_gm.c             |   84 +-
 drivers/gpu/drm/i915/gvt/cfg_space.c               |   27 +-
 drivers/gpu/drm/i915/gvt/cmd_parser.c              |  208 +-
 drivers/gpu/drm/i915/gvt/debugfs.c                 |   45 +-
 drivers/gpu/drm/i915/gvt/display.c                 |   26 +-
 drivers/gpu/drm/i915/gvt/dmabuf.c                  |    8 +-
 drivers/gpu/drm/i915/gvt/edid.c                    |   25 +-
 drivers/gpu/drm/i915/gvt/execlist.c                |  103 +-
 drivers/gpu/drm/i915/gvt/execlist.h                |    5 +-
 drivers/gpu/drm/i915/gvt/fb_decoder.c              |    6 +-
 drivers/gpu/drm/i915/gvt/firmware.c                |   16 +-
 drivers/gpu/drm/i915/gvt/gtt.c                     |   63 +-
 drivers/gpu/drm/i915/gvt/gvt.c                     |   43 +-
 drivers/gpu/drm/i915/gvt/gvt.h                     |   62 +-
 drivers/gpu/drm/i915/gvt/handlers.c                |  211 +-
 drivers/gpu/drm/i915/gvt/interrupt.c               |   21 +-
 drivers/gpu/drm/i915/gvt/kvmgt.c                   |  309 +-
 drivers/gpu/drm/i915/gvt/mmio.c                    |   32 +-
 drivers/gpu/drm/i915/gvt/mmio.h                    |    4 +-
 drivers/gpu/drm/i915/gvt/mmio_context.c            |  127 +-
 drivers/gpu/drm/i915/gvt/mmio_context.h            |    5 +-
 drivers/gpu/drm/i915/gvt/sched_policy.c            |   25 +-
 drivers/gpu/drm/i915/gvt/scheduler.c               |  256 +-
 drivers/gpu/drm/i915/gvt/scheduler.h               |    9 +-
 drivers/gpu/drm/i915/gvt/vgpu.c                    |   18 +-
 drivers/gpu/drm/i915/i915_active.c                 |  139 +-
 drivers/gpu/drm/i915/i915_active.h                 |   11 +-
 drivers/gpu/drm/i915/i915_buddy.c                  |    3 +-
 drivers/gpu/drm/i915/i915_cmd_parser.c             |   29 +-
 drivers/gpu/drm/i915/i915_debugfs.c                | 2560 +-------------
 drivers/gpu/drm/i915/i915_debugfs.h                |    8 +-
 drivers/gpu/drm/i915/i915_debugfs_params.c         |  250 ++
 drivers/gpu/drm/i915/i915_debugfs_params.h         |   14 +
 drivers/gpu/drm/i915/i915_drv.c                    | 1203 +------
 drivers/gpu/drm/i915/i915_drv.h                    |  235 +-
 drivers/gpu/drm/i915/i915_gem.c                    |   19 +-
 drivers/gpu/drm/i915/i915_gem_evict.c              |   17 +-
 drivers/gpu/drm/i915/i915_gem_fence_reg.c          |   16 +-
 drivers/gpu/drm/i915/i915_gem_gtt.c                |    5 +-
 drivers/gpu/drm/i915/i915_gpu_error.c              |   31 +-
 drivers/gpu/drm/i915/i915_gpu_error.h              |    5 +
 drivers/gpu/drm/i915/i915_ioc32.c                  |    7 +-
 drivers/gpu/drm/i915/i915_ioc32.h                  |   17 +
 drivers/gpu/drm/i915/i915_irq.c                    |  287 +-
 drivers/gpu/drm/i915/i915_irq.h                    |    6 +-
 drivers/gpu/drm/i915/i915_params.c                 |   11 +-
 drivers/gpu/drm/i915/i915_params.h                 |   74 +-
 drivers/gpu/drm/i915/i915_pci.c                    |   18 +-
 drivers/gpu/drm/i915/i915_perf.c                   |  103 +-
 drivers/gpu/drm/i915/i915_pmu.c                    |    6 +-
 drivers/gpu/drm/i915/i915_pmu.h                    |    2 +-
 drivers/gpu/drm/i915/i915_reg.h                    |   67 +-
 drivers/gpu/drm/i915/i915_request.c                |  258 +-
 drivers/gpu/drm/i915/i915_request.h                |   14 +-
 drivers/gpu/drm/i915/i915_scheduler.c              |   22 +-
 drivers/gpu/drm/i915/i915_suspend.c                |    2 -
 drivers/gpu/drm/i915/i915_sw_fence.c               |   17 +-
 drivers/gpu/drm/i915/i915_sw_fence.h               |    2 +-
 drivers/gpu/drm/i915/i915_switcheroo.c             |    2 +-
 drivers/gpu/drm/i915/i915_sysfs.c                  |   22 +-
 drivers/gpu/drm/i915/i915_trace.h                  |   66 +-
 drivers/gpu/drm/i915/i915_utils.c                  |    1 -
 drivers/gpu/drm/i915/i915_utils.h                  |   22 +-
 drivers/gpu/drm/i915/i915_vgpu.c                   |   72 +-
 drivers/gpu/drm/i915/i915_vgpu.h                   |   25 +-
 drivers/gpu/drm/i915/i915_vma.c                    |   98 +-
 drivers/gpu/drm/i915/i915_vma.h                    |    2 +
 drivers/gpu/drm/i915/i915_vma_types.h              |   11 -
 drivers/gpu/drm/i915/intel_device_info.c           |   45 +-
 drivers/gpu/drm/i915/intel_device_info.h           |    4 +
 drivers/gpu/drm/i915/intel_dram.c                  |  500 +++
 drivers/gpu/drm/i915/intel_dram.h                  |   14 +
 drivers/gpu/drm/i915/intel_gvt.c                   |   21 +-
 drivers/gpu/drm/i915/intel_memory_region.c         |    4 +-
 drivers/gpu/drm/i915/intel_pch.c                   |   66 +-
 drivers/gpu/drm/i915/intel_pm.c                    |  765 +++--
 drivers/gpu/drm/i915/intel_pm.h                    |    5 +-
 drivers/gpu/drm/i915/intel_sideband.c              |   11 +-
 drivers/gpu/drm/i915/intel_uncore.c                |   54 +-
 drivers/gpu/drm/i915/selftests/i915_active.c       |   78 +-
 drivers/gpu/drm/i915/selftests/i915_buddy.c        |   25 +-
 drivers/gpu/drm/i915/selftests/i915_gem.c          |    6 +-
 .../gpu/drm/i915/selftests/i915_live_selftests.h   |    1 +
 .../gpu/drm/i915/selftests/i915_perf_selftests.h   |    1 +
 drivers/gpu/drm/i915/selftests/igt_spinner.c       |    2 +-
 .../gpu/drm/i915/selftests/intel_memory_region.c   |  203 ++
 drivers/gpu/drm/i915/selftests/mock_gem_device.c   |    1 -
 drivers/gpu/drm/i915/vlv_suspend.c                 |  489 +++
 drivers/gpu/drm/i915/vlv_suspend.h                 |   18 +
 drivers/gpu/drm/imx/imx-ldb.c                      |    2 +-
 drivers/gpu/drm/imx/ipuv3-plane.c                  |    2 +-
 drivers/gpu/drm/imx/parallel-display.c             |  176 +-
 drivers/gpu/drm/ingenic/ingenic-drm.c              |    2 +-
 drivers/gpu/drm/lima/lima_drv.c                    |   16 +-
 drivers/gpu/drm/lima/lima_drv.h                    |    1 +
 drivers/gpu/drm/lima/lima_gem.c                    |  134 +-
 drivers/gpu/drm/lima/lima_gem.h                    |    4 +
 drivers/gpu/drm/lima/lima_gp.c                     |   63 +-
 drivers/gpu/drm/lima/lima_mmu.c                    |    5 +
 drivers/gpu/drm/lima/lima_mmu.h                    |    1 +
 drivers/gpu/drm/lima/lima_regs.h                   |    1 +
 drivers/gpu/drm/lima/lima_sched.c                  |   35 +-
 drivers/gpu/drm/lima/lima_sched.h                  |    6 +
 drivers/gpu/drm/lima/lima_vm.c                     |   46 +-
 drivers/gpu/drm/lima/lima_vm.h                     |    1 +
 drivers/gpu/drm/mcde/mcde_drv.c                    |    9 +-
 drivers/gpu/drm/mcde/mcde_dsi.c                    |    5 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c                 |   20 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |    2 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c                |   10 +-
 drivers/gpu/drm/meson/meson_dw_hdmi.c              |  180 +-
 drivers/gpu/drm/meson/meson_vclk.c                 |   93 +-
 drivers/gpu/drm/meson/meson_vclk.h                 |    7 +-
 drivers/gpu/drm/meson/meson_venc.c                 |   10 +-
 drivers/gpu/drm/meson/meson_venc.h                 |    4 +-
 drivers/gpu/drm/meson/meson_venc_cvbs.c            |    6 +-
 drivers/gpu/drm/mgag200/mgag200_drv.h              |    9 +-
 drivers/gpu/drm/mgag200/mgag200_mode.c             |   86 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |   27 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |  115 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |    6 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h        |    2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |    2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |    2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |  119 +-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c   |    4 +-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |    4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h        |   10 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h    |   10 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   98 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h            |   26 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c             |  620 ++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h             |   71 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c           |    6 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c          |    2 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c          |   82 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c           |   95 -
 drivers/gpu/drm/msm/dsi/dsi_manager.c              |    4 +-
 drivers/gpu/drm/msm/edp/edp.c                      |    4 -
 drivers/gpu/drm/msm/edp/edp_bridge.c               |    2 +-
 drivers/gpu/drm/msm/hdmi/hdmi.c                    |    4 -
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c             |    2 +-
 drivers/gpu/drm/msm/msm_drv.c                      |   16 +-
 drivers/gpu/drm/msm/msm_drv.h                      |    3 +
 drivers/gpu/drm/msm/msm_fbdev.c                    |    6 +-
 drivers/gpu/drm/msm/msm_gem.h                      |   12 +-
 drivers/gpu/drm/msm/msm_gpu.c                      |   28 +-
 drivers/gpu/drm/msm/msm_rd.c                       |    8 +-
 drivers/gpu/drm/nouveau/dispnv04/crtc.c            |    4 +
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |   26 -
 drivers/gpu/drm/nouveau/dispnv50/head.c            |    5 +
 drivers/gpu/drm/nouveau/nouveau_bo.c               |    8 -
 drivers/gpu/drm/nouveau/nouveau_display.c          |   28 +-
 drivers/gpu/drm/nouveau/nouveau_display.h          |   11 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |    5 -
 drivers/gpu/drm/nouveau/nouveau_fbcon.c            |    6 +-
 drivers/gpu/drm/nouveau/nouveau_vga.c              |    2 +-
 drivers/gpu/drm/omapdrm/displays/Kconfig           |   22 -
 drivers/gpu/drm/omapdrm/displays/Makefile          |    4 -
 .../gpu/drm/omapdrm/displays/connector-analog-tv.c |   97 -
 drivers/gpu/drm/omapdrm/displays/connector-hdmi.c  |  183 -
 drivers/gpu/drm/omapdrm/displays/encoder-opa362.c  |  137 -
 .../gpu/drm/omapdrm/displays/encoder-tpd12s015.c   |  217 --
 drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c    |    6 +-
 drivers/gpu/drm/omapdrm/dss/Makefile               |    2 +-
 drivers/gpu/drm/omapdrm/dss/base.c                 |   55 +-
 drivers/gpu/drm/omapdrm/dss/display.c              |    9 -
 drivers/gpu/drm/omapdrm/dss/dpi.c                  |  349 +-
 drivers/gpu/drm/omapdrm/dss/dsi.c                  |    4 +-
 drivers/gpu/drm/omapdrm/dss/dss-of.c               |   28 -
 drivers/gpu/drm/omapdrm/dss/dss.c                  |   46 +-
 drivers/gpu/drm/omapdrm/dss/hdmi.h                 |    4 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4.c                |  313 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4_core.c           |   59 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4_core.h           |    4 +-
 drivers/gpu/drm/omapdrm/dss/hdmi5.c                |  295 +-
 drivers/gpu/drm/omapdrm/dss/hdmi5_core.c           |   48 +-
 drivers/gpu/drm/omapdrm/dss/hdmi5_core.h           |    5 +-
 drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c    |    9 +-
 drivers/gpu/drm/omapdrm/dss/omapdss.h              |   46 +-
 drivers/gpu/drm/omapdrm/dss/output.c               |   53 +-
 drivers/gpu/drm/omapdrm/dss/sdi.c                  |  178 +-
 drivers/gpu/drm/omapdrm/dss/venc.c                 |  269 +-
 drivers/gpu/drm/omapdrm/omap_connector.c           |  247 +-
 drivers/gpu/drm/omapdrm/omap_connector.h           |    3 -
 drivers/gpu/drm/omapdrm/omap_crtc.c                |    2 +-
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c           |    4 +-
 drivers/gpu/drm/omapdrm/omap_drv.c                 |   88 +-
 drivers/gpu/drm/omapdrm/omap_encoder.c             |   83 +-
 drivers/gpu/drm/omapdrm/omap_fbdev.c               |    6 +-
 drivers/gpu/drm/panel/Kconfig                      |   44 +
 drivers/gpu/drm/panel/Makefile                     |    5 +
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c     |  854 +++++
 drivers/gpu/drm/panel/panel-elida-kd35t133.c       |  352 ++
 drivers/gpu/drm/panel/panel-feixin-k101-im2ba02.c  |  526 +++
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c       |   14 +-
 drivers/gpu/drm/panel/panel-lg-lg4573.c            |    2 +-
 drivers/gpu/drm/panel/panel-novatek-nt35510.c      | 1098 ++++++
 drivers/gpu/drm/panel/panel-samsung-ld9040.c       |    6 +
 .../drm/panel/panel-samsung-s6e88a0-ams452ef01.c   |  293 ++
 drivers/gpu/drm/panel/panel-simple.c               |  332 +-
 drivers/gpu/drm/panel/panel-sony-acx424akp.c       |    4 +-
 drivers/gpu/drm/panel/panel-tpo-td028ttec1.c       |   17 +-
 drivers/gpu/drm/panfrost/panfrost_device.c         |  123 +-
 drivers/gpu/drm/panfrost/panfrost_device.h         |   26 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c            |   30 +-
 drivers/gpu/drm/panfrost/panfrost_gpu.c            |   18 +-
 drivers/gpu/drm/panfrost/panfrost_job.c            |    2 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.c            |    6 +-
 drivers/gpu/drm/pl111/pl111_versatile.c            |   73 +
 drivers/gpu/drm/qxl/qxl_cmd.c                      |    2 +-
 drivers/gpu/drm/qxl/qxl_display.c                  |   43 +-
 drivers/gpu/drm/qxl/qxl_drv.c                      |   26 +-
 drivers/gpu/drm/qxl/qxl_kms.c                      |    4 +-
 drivers/gpu/drm/qxl/qxl_ttm.c                      |    6 -
 drivers/gpu/drm/radeon/atombios_crtc.c             |    1 +
 drivers/gpu/drm/radeon/radeon_device.c             |    2 +-
 drivers/gpu/drm/radeon/radeon_display.c            |   25 +-
 drivers/gpu/drm/radeon/radeon_dp_mst.c             |   27 -
 drivers/gpu/drm/radeon/radeon_drv.c                |   18 -
 drivers/gpu/drm/radeon/radeon_fb.c                 |   19 +-
 drivers/gpu/drm/radeon/radeon_kms.c                |   29 +-
 drivers/gpu/drm/radeon/radeon_legacy_crtc.c        |    3 +-
 drivers/gpu/drm/radeon/radeon_mode.h               |    9 +-
 drivers/gpu/drm/radeon/radeon_ttm.c                |    6 -
 drivers/gpu/drm/radeon/si_dpm.c                    |    1 -
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c          |    2 +-
 drivers/gpu/drm/rcar-du/rcar_lvds.c                |   22 +-
 drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c      |    9 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c        |    1 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |    2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h        |    2 +-
 drivers/gpu/drm/rockchip/rockchip_lvds.c           |    2 +-
 drivers/gpu/drm/rockchip/rockchip_rgb.c            |    5 +-
 drivers/gpu/drm/scheduler/gpu_scheduler_trace.h    |   27 +
 drivers/gpu/drm/scheduler/sched_entity.c           |   56 +-
 drivers/gpu/drm/scheduler/sched_main.c             |   86 +-
 drivers/gpu/drm/sti/sti_crtc.c                     |   11 +-
 drivers/gpu/drm/sti/sti_crtc.h                     |    2 -
 drivers/gpu/drm/sti/sti_drv.c                      |    4 -
 drivers/gpu/drm/sti/sti_dvo.c                      |    2 +-
 drivers/gpu/drm/sti/sti_hda.c                      |    2 +-
 drivers/gpu/drm/sti/sti_hdmi.c                     |    2 +-
 drivers/gpu/drm/stm/drv.c                          |    2 -
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c              |    4 +-
 drivers/gpu/drm/stm/ltdc.c                         |  103 +-
 drivers/gpu/drm/stm/ltdc.h                         |    6 +-
 drivers/gpu/drm/sun4i/sun4i_lvds.c                 |    2 +-
 drivers/gpu/drm/sun4i/sun4i_rgb.c                  |    2 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |  104 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.h                 |   14 +
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c             |  129 +-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h             |    2 +-
 drivers/gpu/drm/tegra/dc.c                         |   20 +-
 drivers/gpu/drm/tegra/fb.c                         |    8 +-
 drivers/gpu/drm/tegra/hdmi.c                       |   34 +-
 drivers/gpu/drm/tidss/Kconfig                      |   14 +
 drivers/gpu/drm/tidss/Makefile                     |   12 +
 drivers/gpu/drm/tidss/tidss_crtc.c                 |  432 +++
 drivers/gpu/drm/tidss/tidss_crtc.h                 |   48 +
 drivers/gpu/drm/tidss/tidss_dispc.c                | 2753 +++++++++++++++
 drivers/gpu/drm/tidss/tidss_dispc.h                |  137 +
 drivers/gpu/drm/tidss/tidss_dispc_regs.h           |  243 ++
 drivers/gpu/drm/tidss/tidss_drv.c                  |  285 ++
 drivers/gpu/drm/tidss/tidss_drv.h                  |   39 +
 drivers/gpu/drm/tidss/tidss_encoder.c              |   88 +
 drivers/gpu/drm/tidss/tidss_encoder.h              |   17 +
 drivers/gpu/drm/tidss/tidss_irq.c                  |  146 +
 drivers/gpu/drm/tidss/tidss_irq.h                  |   77 +
 drivers/gpu/drm/tidss/tidss_kms.c                  |  299 ++
 drivers/gpu/drm/tidss/tidss_kms.h                  |   15 +
 drivers/gpu/drm/tidss/tidss_plane.c                |  217 ++
 drivers/gpu/drm/tidss/tidss_plane.h                |   25 +
 drivers/gpu/drm/tidss/tidss_scale_coefs.c          |  202 ++
 drivers/gpu/drm/tidss/tidss_scale_coefs.h          |   22 +
 drivers/gpu/drm/tilcdc/tilcdc_external.c           |    2 +-
 drivers/gpu/drm/tiny/Kconfig                       |   22 +-
 drivers/gpu/drm/tiny/Makefile                      |    1 +
 drivers/gpu/drm/tiny/gm12u320.c                    |    9 -
 drivers/gpu/drm/tiny/ili9225.c                     |    9 -
 drivers/gpu/drm/tiny/ili9486.c                     |  286 ++
 drivers/gpu/drm/tiny/repaper.c                     |   21 +-
 drivers/gpu/drm/tiny/st7586.c                      |    9 -
 drivers/gpu/drm/tiny/st7735r.c                     |   76 +-
 drivers/gpu/drm/ttm/ttm_bo.c                       |  271 +-
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |    3 +-
 drivers/gpu/drm/ttm/ttm_page_alloc_dma.c           |    2 +-
 drivers/gpu/drm/udl/udl_connector.c                |    1 -
 drivers/gpu/drm/udl/udl_modeset.c                  |   11 -
 drivers/gpu/drm/v3d/v3d_drv.h                      |   41 +-
 drivers/gpu/drm/vboxvideo/vbox_mode.c              |   13 +-
 drivers/gpu/drm/vboxvideo/vboxvideo.h              |    2 +-
 drivers/gpu/drm/vc4/vc4_crtc.c                     |   13 +-
 drivers/gpu/drm/vc4/vc4_dpi.c                      |    2 +-
 drivers/gpu/drm/vc4/vc4_drv.c                      |    3 -
 drivers/gpu/drm/vc4/vc4_drv.h                      |   49 +-
 drivers/gpu/drm/vc4/vc4_dsi.c                      |    2 +-
 drivers/gpu/drm/vc4/vc4_plane.c                    |    2 +-
 drivers/gpu/drm/virtio/virtgpu_debugfs.c           |    1 +
 drivers/gpu/drm/virtio/virtgpu_display.c           |   12 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c               |    6 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h               |   36 +-
 drivers/gpu/drm/virtio/virtgpu_gem.c               |    2 +
 drivers/gpu/drm/virtio/virtgpu_ioctl.c             |   90 +-
 drivers/gpu/drm/virtio/virtgpu_kms.c               |   41 +-
 drivers/gpu/drm/virtio/virtgpu_object.c            |  109 +-
 drivers/gpu/drm/virtio/virtgpu_plane.c             |    7 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c                |  369 +-
 drivers/gpu/drm/vkms/vkms_crtc.c                   |    9 +-
 drivers/gpu/drm/vkms/vkms_drv.c                    |    1 -
 drivers/gpu/drm/vkms/vkms_drv.h                    |    4 -
 drivers/gpu/drm/vkms/vkms_plane.c                  |    2 +-
 drivers/gpu/drm/vmwgfx/Makefile                    |    2 +-
 drivers/gpu/drm/vmwgfx/device_include/svga3d_cmd.h |  161 +-
 .../gpu/drm/vmwgfx/device_include/svga3d_devcaps.h |  787 ++---
 drivers/gpu/drm/vmwgfx/device_include/svga3d_dx.h  |  466 ++-
 .../gpu/drm/vmwgfx/device_include/svga3d_limits.h  |   36 +-
 .../drm/vmwgfx/device_include/svga3d_surfacedefs.h |   58 +-
 .../gpu/drm/vmwgfx/device_include/svga3d_types.h   |  347 +-
 drivers/gpu/drm/vmwgfx/device_include/svga_reg.h   |  382 ++-
 drivers/gpu/drm/vmwgfx/device_include/svga_types.h |    1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_binding.c            |  213 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_binding.h            |   33 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c             |    3 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_context.c            |   28 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c            |    6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |   73 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |  172 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |  429 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c               |    2 -
 drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c              |   18 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |  130 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                |    3 +
 drivers/gpu/drm/vmwgfx/vmwgfx_mob.c                |    2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c            |   31 -
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c         |    2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |    3 +
 drivers/gpu/drm/vmwgfx/vmwgfx_so.c                 |   12 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_so.h                 |    7 +
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |   66 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_streamoutput.c       |  387 +++
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c            |  610 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c         |    6 -
 drivers/gpu/drm/xen/xen_drm_front_kms.c            |   19 +
 drivers/gpu/drm/zte/zx_plane.c                     |    4 +-
 drivers/video/backlight/Kconfig                    |    8 +-
 drivers/video/console/Kconfig                      |   76 +-
 drivers/video/fbdev/Kconfig                        |    9 +-
 drivers/video/fbdev/aty/mach64_gx.c                |    3 +-
 drivers/video/fbdev/aty/radeon_base.c              |   26 +-
 drivers/video/fbdev/cg14.c                         |    3 +-
 drivers/video/fbdev/core/Makefile                  |    1 -
 drivers/video/fbdev/core/fbcon.c                   |   27 +-
 drivers/video/fbdev/core/fbmem.c                   |   38 +-
 drivers/video/fbdev/hyperv_fb.c                    |    4 +-
 drivers/video/fbdev/kyro/STG4000OverlayDevice.c    |    3 +-
 drivers/video/fbdev/matrox/matroxfb_base.c         |   15 +
 drivers/video/fbdev/mmp/hw/mmp_ctrl.h              |    2 +-
 drivers/video/fbdev/nvidia/nvidia.c                |   41 +-
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c     |    4 -
 drivers/video/fbdev/pxa168fb.c                     |    5 +-
 drivers/video/fbdev/s1d13xxxfb.c                   |   16 +-
 drivers/video/fbdev/sa1100fb.c                     |    2 +-
 drivers/video/fbdev/sh_mobile_lcdcfb.c             |    4 +-
 drivers/video/fbdev/ssd1307fb.c                    |    4 +-
 drivers/video/fbdev/w100fb.c                       |   18 +-
 drivers/video/fbdev/wm8505fb.c                     |    2 +-
 drivers/video/hdmi.c                               |   11 +-
 include/drm/bridge/dw_hdmi.h                       |    1 +
 include/drm/bridge/mhl.h                           |    4 +-
 include/drm/drm_atomic.h                           |   76 +
 include/drm/drm_atomic_helper.h                    |    8 +
 include/drm/drm_atomic_state_helper.h              |   13 +
 include/drm/drm_bridge.h                           |  405 ++-
 include/drm/drm_bridge_connector.h                 |   18 +
 include/drm/drm_client.h                           |    7 +-
 include/drm/drm_connector.h                        |   46 +-
 include/drm/drm_crtc.h                             |   80 +-
 include/drm/drm_device.h                           |    2 +-
 include/drm/drm_dp_helper.h                        |   26 +-
 include/drm/drm_dp_mst_helper.h                    |   17 +-
 include/drm/drm_drv.h                              |  194 +-
 include/drm/drm_edid.h                             |    5 +
 include/drm/drm_encoder.h                          |    3 +-
 include/drm/drm_fb_helper.h                        |   27 +-
 include/drm/drm_file.h                             |    1 +
 include/drm/drm_gem_vram_helper.h                  |    9 +
 include/drm/drm_hdcp.h                             |    6 +-
 include/drm/drm_legacy.h                           |    6 -
 include/drm/drm_mipi_dbi.h                         |   12 +
 include/drm/drm_mm.h                               |    2 +-
 include/drm/drm_modes.h                            |   11 +-
 include/drm/drm_modeset_helper_vtables.h           |   63 +-
 include/drm/drm_panel.h                            |    3 +-
 include/drm/drm_pci.h                              |   11 -
 include/drm/drm_print.h                            |   78 +-
 include/drm/drm_simple_kms_helper.h                |   11 +-
 include/drm/drm_vblank.h                           |   36 +-
 include/drm/gpu_scheduler.h                        |   13 +-
 include/drm/i915_mei_hdcp_interface.h              |    1 -
 include/drm/ttm/ttm_bo_api.h                       |   11 +-
 include/drm/ttm/ttm_bo_driver.h                    |   15 -
 include/linux/dma-buf.h                            |   97 +-
 include/linux/hdmi.h                               |    2 +-
 include/linux/platform_data/simplefb.h             |    2 +-
 include/uapi/drm/amdgpu_drm.h                      |    5 +-
 include/uapi/drm/drm.h                             |    2 +
 include/uapi/drm/i915_drm.h                        |   21 +
 include/uapi/drm/lima_drm.h                        |    9 +-
 include/uapi/drm/vmwgfx_drm.h                      |   16 +-
 include/video/mmp_disp.h                           |    2 +-
 include/video/samsung_fimd.h                       |    2 +-
 1082 files changed, 57077 insertions(+), 27792 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ps8640=
.yaml
 create mode 100644
Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
 create mode 100644
Documentation/devicetree/bindings/display/ilitek,ili9486.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/msm/gmu.txt
 create mode 100644 Documentation/devicetree/bindings/display/msm/gmu.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/advantech,idk-1110wr.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/auo,b080uan01.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/auo,b101aw03.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/auo,b101ean01.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/auo,b101xtn01.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/auo,b116xw03.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/auo,b133htn01.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/auo,b133xtn01.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/auo,g070vvn01.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/auo,g101evn010.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/auo,g104sn02.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/auo,g133han01.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/auo,g185han01.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/auo,p320hvn03.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/auo,t215hvn01.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/avic,tm070ddh03.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/boe,nv101wxmn51.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/boe,tv080wum-nl0.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/cdtech,s043wq26h-ct7.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/cdtech,s070wv95-ct16.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/chunghwa,claa070wp03xg.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/chunghwa,claa101wa01a.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/chunghwa,claa101wb03.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/dataimage,scf0700c48ggu18.t=
xt
 create mode 100644
Documentation/devicetree/bindings/display/panel/display-timings.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/dlc,dlc1010gig.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/edt,et-series.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/elida,kd35t133.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/evervision,vgg804821.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/feixin,k101-im2ba02.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/foxlink,fl500wvr00-a0t.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/friendlyarm,hd702e.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/giantplus,gpg482739qs5.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/hannstar,hsd070pww1.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/hannstar,hsd100pxn1.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/hit,tx23d38vm0caa.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/innolux,at043tn24.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/innolux,at070tn92.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/innolux,g070y2-l01.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/innolux,g101ice-l01.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/innolux,g121i1-l01.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/innolux,g121x1-l03.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/innolux,n116bge.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/innolux,n156bge-l21.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/innolux,zj070na-01p.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/koe,tx14d24vm1bpa.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/koe,tx31d200vm0baa.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/kyo,tcg121xglp.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/lemaker,bl035-rgb-002.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/lg,lb070wv8.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/lg,lp079qx1-sp0v.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/lg,lp097qx1-spa1.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/lg,lp120up1.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/lg,lp129qe.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/mitsubishi,aa070mc01.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/nec,nl12880b20-05.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/nec,nl4827hc19-05b.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/netron-dy,e231732.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/newhaven,nhd-4.3-480272ef-a=
txl.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/nlt,nl192108ac18-02d.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/panel/nvd,912=
8.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/okaya,rs800480t-7x0gp.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino-43-ts.=
txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/ontat,yx700wv03.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/ortustech,com37h3m05dtc.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/ortustech,com37h3m99dtc.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/ortustech,com43h4m85ulc.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/osddisplays,osd070t1718-19t=
s.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/osddisplays,osd101t2045-53t=
s.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/panasonic,vvx10f004b00.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/panasonic,vvx10f034n00.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/panel-dpi.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/panel-dpi.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/panel-timing.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/qiaodian,qd43003c0-40.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/raydium,rm68200.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/raydium,rm68200.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/rocktech,rk070er9427.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/samsung,lsn122dl01-c01.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/samsung,ltn101nt05.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/samsung,ltn140at29-301.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/samsung,s6e88a0-ams452ef01.=
yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/sharp,lq035q7db03.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/sharp,lq070y3dg3b.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/sharp,lq101k1ly04.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/sharp,lq123p1jx31.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/shelly,sca07010-bfn-lnn.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/starry,kr122ea0sra.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/tianma,tm070jdhg30.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/tianma,tm070rvhg71.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/toshiba,lt089ac29000.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/tpk,f07a-0102.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/tpk,f10a-0102.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/urt,umsh-8596md.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/vl050_8048nt_c01.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/winstar,wf35ltiacd.txt
 delete mode 100644
Documentation/devicetree/bindings/display/rockchip/rockchip-drm.txt
 create mode 100644
Documentation/devicetree/bindings/display/rockchip/rockchip-drm.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/sitronix,st7735r.txt
 create mode 100644
Documentation/devicetree/bindings/display/sitronix,st7735r.yaml
 create mode 100644
Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
 create mode 100644
Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml
 create mode 100644 Documentation/devicetree/bindings/display/ti/ti,k2g-dss=
.yaml
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmsch_v2_0.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dce_scl_filters_old.=
c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/inc/dmub_gpint_cmd.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/wafl/wafl2_4_0_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/wafl/wafl2_4_0_0_s=
mn.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/xgmi/xgmi_4_0_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/xgmi/xgmi_4_0_0_sm=
n.h
 create mode 100644 drivers/gpu/drm/bridge/display-connector.c
 delete mode 100644 drivers/gpu/drm/bridge/dumb-vga-dac.c
 create mode 100644 drivers/gpu/drm/bridge/parade-ps8640.c
 create mode 100644 drivers/gpu/drm/bridge/simple-bridge.c
 create mode 100644 drivers/gpu/drm/bridge/tc358768.c
 create mode 100644 drivers/gpu/drm/bridge/ti-tpd12s015.c
 create mode 100644 drivers/gpu/drm/drm_bridge_connector.c
 rename drivers/gpu/drm/i915/{ =3D> display}/intel_csr.c (94%)
 rename drivers/gpu/drm/i915/{ =3D> display}/intel_csr.h (100%)
 create mode 100644 drivers/gpu/drm/i915/display/intel_de.h
 create mode 100644 drivers/gpu/drm/i915/display/intel_display_debugfs.c
 create mode 100644 drivers/gpu/drm/i915/display/intel_display_debugfs.h
 create mode 100644 drivers/gpu/drm/i915/display/intel_global_state.c
 create mode 100644 drivers/gpu/drm/i915/display/intel_global_state.h
 create mode 100644 drivers/gpu/drm/i915/gt/gen7_renderclear.c
 create mode 100644 drivers/gpu/drm/i915/gt/gen7_renderclear.h
 create mode 100644 drivers/gpu/drm/i915/gt/hsw_clear_kernel.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_context_param.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_context_param.h
 create mode 100644 drivers/gpu/drm/i915/gt/intel_context_sseu.c
 create mode 100644 drivers/gpu/drm/i915/gt/ivb_clear_kernel.c
 create mode 100644 drivers/gpu/drm/i915/gt/selftest_ring_submission.c
 create mode 100644 drivers/gpu/drm/i915/gt/sysfs_engines.c
 create mode 100644 drivers/gpu/drm/i915/gt/sysfs_engines.h
 create mode 100644 drivers/gpu/drm/i915/i915_debugfs_params.c
 create mode 100644 drivers/gpu/drm/i915/i915_debugfs_params.h
 create mode 100644 drivers/gpu/drm/i915/i915_ioc32.h
 create mode 100644 drivers/gpu/drm/i915/intel_dram.c
 create mode 100644 drivers/gpu/drm/i915/intel_dram.h
 create mode 100644 drivers/gpu/drm/i915/vlv_suspend.c
 create mode 100644 drivers/gpu/drm/i915/vlv_suspend.h
 delete mode 100644 drivers/gpu/drm/omapdrm/displays/connector-analog-tv.c
 delete mode 100644 drivers/gpu/drm/omapdrm/displays/connector-hdmi.c
 delete mode 100644 drivers/gpu/drm/omapdrm/displays/encoder-opa362.c
 delete mode 100644 drivers/gpu/drm/omapdrm/displays/encoder-tpd12s015.c
 delete mode 100644 drivers/gpu/drm/omapdrm/dss/dss-of.c
 create mode 100644 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
 create mode 100644 drivers/gpu/drm/panel/panel-elida-kd35t133.c
 create mode 100644 drivers/gpu/drm/panel/panel-feixin-k101-im2ba02.c
 create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt35510.c
 create mode 100644 drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams452ef01.=
c
 create mode 100644 drivers/gpu/drm/tidss/Kconfig
 create mode 100644 drivers/gpu/drm/tidss/Makefile
 create mode 100644 drivers/gpu/drm/tidss/tidss_crtc.c
 create mode 100644 drivers/gpu/drm/tidss/tidss_crtc.h
 create mode 100644 drivers/gpu/drm/tidss/tidss_dispc.c
 create mode 100644 drivers/gpu/drm/tidss/tidss_dispc.h
 create mode 100644 drivers/gpu/drm/tidss/tidss_dispc_regs.h
 create mode 100644 drivers/gpu/drm/tidss/tidss_drv.c
 create mode 100644 drivers/gpu/drm/tidss/tidss_drv.h
 create mode 100644 drivers/gpu/drm/tidss/tidss_encoder.c
 create mode 100644 drivers/gpu/drm/tidss/tidss_encoder.h
 create mode 100644 drivers/gpu/drm/tidss/tidss_irq.c
 create mode 100644 drivers/gpu/drm/tidss/tidss_irq.h
 create mode 100644 drivers/gpu/drm/tidss/tidss_kms.c
 create mode 100644 drivers/gpu/drm/tidss/tidss_kms.h
 create mode 100644 drivers/gpu/drm/tidss/tidss_plane.c
 create mode 100644 drivers/gpu/drm/tidss/tidss_plane.h
 create mode 100644 drivers/gpu/drm/tidss/tidss_scale_coefs.c
 create mode 100644 drivers/gpu/drm/tidss/tidss_scale_coefs.h
 create mode 100644 drivers/gpu/drm/tiny/ili9486.c
 create mode 100644 drivers/gpu/drm/vmwgfx/vmwgfx_streamoutput.c
 create mode 100644 include/drm/drm_bridge_connector.h
