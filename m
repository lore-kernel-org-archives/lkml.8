Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559B3C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 23:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A3262083E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 23:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598829646;
	bh=iSZ/1jdHgQ+MqnLtalRQWBUQZBp6XqBvbIVua6GCzqg=;
	h=From:Date:Subject:To:List-ID:From;
	b=Nq3mBPi8DPOkgIdZsuAHky4ilDAxqw+hstk9UAutYh/0O6gloUOEjd752XxSCtNMo
	 JwhLxZVKn6PQCBaWgCvoK5GmLcnsqGHGnVBYtaaebFR7VxTPHnSvyhahDG6zBLGqoZ
	 By+wSBUR3d4E4u8Dl0MLCXvZbKIx3eGTqbaYmxQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgH3XUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 19:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgH3XUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 19:20:38 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98888C061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 16:20:37 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m22so4639498ljj.5
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 16:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3HEDV0VchVehwKbMv98r/qo1hjQ64ivMIGkqxXUVTxM=;
        b=B0TwL/J9BI4dTZaj7R4y3I5pR1LVWEOcmaQujZGXNAqS4rjDJlnLmX4z5mSq6Ut+Xi
         nkkID3bGW6zScJ+WJaNBxyM4YRZgn4MhtxcHDt/g4Bm8oKLKSc64PxN4qb4M8M7lT31L
         06pM4JBXt0sJv8I1CYNCY+tzvt9Qvn8ieriio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3HEDV0VchVehwKbMv98r/qo1hjQ64ivMIGkqxXUVTxM=;
        b=N2hTe6c47Iu+yqvUDFxvJF1ej8Qmk+yYYRhtiIMwsiHFgxWp0OdxvvPMaFOTP3uLnO
         hRRDHC7ZiOAfJ6jshaO8NOc5014OYH8Gwt/iLrhAkO5gPXoBxx4TJTzChprRmrvbPRbi
         RcbnBtT9cLqc8kE7oKjGb2ujW3/243pxfiwLIa2CB0SKAWx3HgwyBwuplzFh7tfA9Jg7
         NQsjZ91T6Koh2Kkf1qzAJbY5roC4nMWkSZMB/lQF5vPnCNDizSN+J6wLvWOo10h49VcV
         ih5nL2e6xl6EUBBfO1LysMsmK1nwkIiXsWgqLC+mzznTTThNUVV6uzV41/cmTCE5hPJb
         dhog==
X-Gm-Message-State: AOAM530iZVpbR0AdBEuzIKfiEwDTo5b4dsFRGlfyaZuWHUMSHB3J9QVX
        XO+Fi80vr4MsHJJVuYtM2BciQiDa8TUH5Q==
X-Google-Smtp-Source: ABdhPJweAqRZWzOrf1tzcij9hP9XpASahV+/1n4VmFCDCLg8krtowFYUMIgIgYGLcJf8VOblnsI/Vg==
X-Received: by 2002:a2e:71a:: with SMTP id 26mr4208647ljh.198.1598829635166;
        Sun, 30 Aug 2020 16:20:35 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id y5sm1532216lff.60.2020.08.30.16.20.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2020 16:20:34 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id w14so4640713ljj.4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 16:20:34 -0700 (PDT)
X-Received: by 2002:a2e:2e04:: with SMTP id u4mr3815851lju.102.1598829633639;
 Sun, 30 Aug 2020 16:20:33 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 30 Aug 2020 16:20:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiD1yujm_WvWLYL7gZsWMvZyWMg1rfU7dWmnYYc3a7Gsg@mail.gmail.com>
Message-ID: <CAHk-=wiD1yujm_WvWLYL7gZsWMvZyWMg1rfU7dWmnYYc3a7Gsg@mail.gmail.com>
Subject: Linux 5.9-rc3
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You all know the drill by now - another week, another rc.

A fair number of small fixes all over here, with a lot of noise spread
out fairly evenly due to the "fallhtough" comment conversion.

But while the fallthrough annotations are some fairly widespread
background noise, we've got the usual driver fixes all over (gpu, usb,
others). And architecture updates (arm64 stands out with both kvm
fixes and DT updates, but there's some x86 and powerpc changes too)

And misc changes elsewhere.

On the whole it's been pretty calm for being rc3. This is actually one
of the smaller rc3's we've had in recent releases, although that's
likely at least partially the usual timing issue (ie no networking
pull this past week).

So go out and test.

             Linus

---

Adrian Huang (1):
      dax: do not print error message for non-persistent memory block devic=
e

Alan Stern (3):
      USB: yurex: Fix bad gfp argument
      USB: quirks: Ignore duplicate endpoint on Sound Devices MixPre-D
      usb: storage: Add unusual_uas entry for Sony PSZ drives

Alex Deucher (1):
      drm/amdgpu: Fix buffer overflow in INFO ioctl

Alexander Monakov (1):
      drm/amd/display: use correct scale for actual_brightness

Alexey Kardashevskiy (1):
      powerpc/perf: Fix crashes with generic_compat_pmu & BHRB

Amit Engel (1):
      nvmet: Disable keep-alive timer when kato is cleared to 0h

Andy Shevchenko (4):
      usb: hcd: Fix use after free in usb_hcd_pci_remove()
      i2c: core: Don't fail PRP0001 enumeration when no ID table exist
      i2c: acpi: Remove dead code, i.e. i2c_acpi_match_device()
      USB: gadget: u_f: Unbreak offset calculation in VLAs

Ard Biesheuvel (1):
      ACPI: ioremap: avoid redundant rounding to OS page size

Ashok Raj (1):
      x86/hotplug: Silence APIC only after all interrupts are migrated

Athira Rajeev (1):
      powerpc/perf: Fix reading of MSR[HV/PR] bits in trace-imc

Badhri Jagan Sridharan (1):
      usb: typec: tcpm: Fix Fix source hard reset response for TDA
2.3.1.1 and TDA 2.3.1.2 failures

Bastien Nocera (2):
      USB: Also match device drivers using the ->match vfunc
      USB: Fix device driver race

Bhawanpreet Lakha (1):
      drm/dp_mst: Don't return error code when crtc is null

Bob Peterson (1):
      gfs2: add some much needed cleanup for log flushes that fail

Boris Burkov (1):
      btrfs: detect nocow for swap after snapshot delete

Brandon Syu (1):
      drm/amd/display: Keep current gain when ABM disable immediately

Brooke Basile (2):
      USB: gadget: u_f: add overflow checks to VLA macros
      USB: gadget: f_ncm: add bounds checks to ncm_unwrap_ntb()

Chaitanya Kulkarni (3):
      nvmet: add ns tear down label for pt-cmd handling
      nvmet: fix oops in pt cmd execution
      nvmet: call blk_mq_free_request() directly

Chao Leng (1):
      nvme: redirect commands on dying queue

Christian Gmeiner (1):
      drm/etnaviv: fix external abort seen on GC600 rev 0x19

Christoph Hellwig (4):
      nvme-pci: fix PRP pool size
      nvme: rename and document nvme_end_request
      nvme: refactor command completion
      nvme: just check the status code type in nvme_is_path_error

Christophe JAILLET (1):
      usb: gadget: f_tcm: Fix some resource leaks in some error paths

Christophe Leroy (1):
      powerpc/32s: Disable VMAP stack which CONFIG_ADB_PMU

Colin Ian King (1):
      habanalabs: fix incorrect check on failed workqueue create

Cyril Roelandt (1):
      USB: Ignore UAS for JMicron JMS567 ATA/ATAPI Bridge

Dan Carpenter (4):
      habanalabs: Fix memory corruption in debugfs
      habanalabs: Fix a loop in gaudi_extract_ecc_info()
      dma-pool: Fix an uninitialized variable bug in atomic_pool_expand()
      afs: Remove erroneous fallthough annotation

Daniel Vetter (1):
      drm/modeset-lock: Take the modeset BKL for legacy drivers

David Sterba (1):
      btrfs: use the correct const function attribute for btrfs_get_num_csu=
ms

Ding Hui (1):
      xhci: Always restore EP_SOFT_CLEAR_TOGGLE even if ep reset failed

Dinghao Liu (1):
      drm/amd/display: Fix memleak in amdgpu_dm_mode_config_init

Dmitry Baryshkov (1):
      drm/msm/a6xx: fix gmu start on newer firmware

Dmitry Monakhov (1):
      bfq: fix blkio cgroup leakage v4

Dmitry Osipenko (1):
      mfd: core: Fix double-free in mfd_remove_devices_fn()

Douglas Anderson (1):
      serial: qcom_geni_serial: Fix recent kdb hang

Evan Quan (4):
      drm/amd/pm: correct Vega10 swctf limit setting
      drm/amd/pm: correct Vega12 swctf limit setting
      drm/amd/pm: correct Vega20 swctf limit setting
      drm/amd/pm: correct the thermal alert temperature limit settings

Evgeny Novikov (1):
      USB: lvtest: return proper error code in probe

Filipe Manana (1):
      btrfs: fix space cache memory leak after transaction abort

Frank van der Linden (1):
      arm64: vdso32: make vdso32 install conditional

Fugang Duan (1):
      tty: serial: imx: add dependence and build for earlycon

Furquan Shaikh (2):
      ACPI: SoC: APD: Check return value of acpi_dev_get_property()
      drivers: gpu: amd: Initialize amdgpu_dm_backlight_caps object to
0 in amdgpu_dm_update_backlight_caps

Geert Uytterhoeven (1):
      MAINTAINERS: Add missing header files to BLOCK LAYER section

George Kennedy (2):
      fbcon: prevent user font height or width change from causing
potential out-of-bounds access
      vt_ioctl: change VT_RESIZEX ioctl to check for error return from
vc_resize()

Giovanni Cabiddu (1):
      crypto: qat - add delay before polling mailbox

Grant Peltier (1):
      hwmon: (pmbus/isl68137) remove READ_TEMPERATURE_1 telemetry for RAA22=
8228

Gustavo A. R. Silva (5):
      treewide: Use fallthrough pseudo-keyword
      lib: Revert use of fallthrough pseudo-keyword in lib/
      iio: dpot-dac: fix code comment in dpot_dac_read_raw()
      media: dib0700: Fix identation issue in dib8096_set_param_override()
      arm64/cpuinfo: Remove unnecessary fallthrough annotation

Hans de Goede (5):
      HID: i2c-hid: Always sleep 60ms after I2C_HID_PWR_ON commands
      usb: typec: ucsi: Fix AB BA lock inversion
      usb: typec: ucsi: Fix 2 unlocked ucsi_run_command calls
      usb: typec: ucsi: Rework ppm_lock handling
      usb: typec: ucsi: Hold con->lock for the entire duration of
ucsi_register_port()

Heikki Krogerus (2):
      tools: usb: move to tools buildsystem
      device property: Fix the secondary firmware node handling in
set_primary_fwnode()

Herbert Xu (2):
      crypto: af_alg - Work around empty control messages without MSG_MORE
      kernel.h: Silence sparse warning in lower_32_bits

Holger Assmann (1):
      serial: stm32: avoid kernel warning on absence of optional IRQ

Hou Pu (2):
      null_blk: fix passing of REQ_FUA flag in null_handle_rq
      nbd: restore default timeout when setting it to zero

Ilya Dryomov (1):
      libceph: add __maybe_unused to DEFINE_CEPH_FEATURE

J. Bruce Fields (1):
      nfsd: fix oops on mixed NFSv4/NFSv3 client access

JC Kuo (2):
      usb: host: xhci-tegra: otg usb2/usb3 port init
      usb: host: xhci-tegra: fix tegra_xusb_get_phy()

Jaehyun Chung (1):
      drm/amd/display: Revert HDCP disable sequence change

James Morse (3):
      KVM: arm64: Add kvm_extable for vaxorcism code
      KVM: arm64: Survive synchronous exceptions caused by AT instructions
      KVM: arm64: Set HCR_EL2.PTW to prevent AT taking synchronous exceptio=
n

Jan Kara (4):
      writeback: Protect inode->i_io_list with inode->i_lock
      writeback: Avoid skipping inode writeback
      writeback: Fix sync livelock due to b_dirty_time processing
      writeback: Drop I_DIRTY_TIME_EXPIRE

Jason Baron (1):
      hwmon: (nct7904) Correct divide by 0

Jason Wang (2):
      vdpa: ifcvf: return err when fail to request config irq
      vdpa: ifcvf: free config irq in ifcvf_free_irq()

Jeff Layton (2):
      ceph: fix inode number handling on arches with 32-bit ino_t
      ceph: don't allow setlease on cephfs

Jens Axboe (9):
      io_uring: don't recurse on tsk->sighand->siglock with signalfd
      io_uring: revert consumed iov_iter bytes on error
      io_uring: fix imbalanced sqo_mm accounting
      io_uring: don't use poll handler if file can't be nonblocking read/wr=
itten
      io_uring: ensure read requests go through -ERESTART* transformation
      io_uring: make offset =3D=3D -1 consistent with preadv2/pwritev2
      io_uring: clear req->result on IOPOLL re-issue
      io_uring: fix IOPOLL -EAGAIN retries
      io_uring: don't bounce block based -EAGAIN retry off task_work

Jiansong Chen (5):
      drm/amd/pm: enable run_btc callback for sienna_cichlid
      drm/amd/pm: set VCN pg per instances
      drm/amdgpu/gfx10: refine mgcg setting
      drm/amdgpu: use MODE1 reset for navy_flounder by default
      drm/amdgpu: disable runtime pm for navy_flounder

Jiri Kosina (1):
      Revert "HID: usbhid: do not sleep when opening device"

Johannes Thumshirn (1):
      btrfs: handle errors from async submission

John Garry (1):
      nvme-pci: Use u32 for nvme_dev.q_depth and nvme_queue.q_depth

John Stultz (1):
      tty: serial: qcom_geni_serial: Drop __init from qcom_geni_console_set=
up

Jonathan Marek (1):
      drm/msm/a6xx: fix frequency not always being restored on GMU resume

Josef Bacik (1):
      btrfs: check the right error variable in btrfs_del_dir_entries_in_log

Kai-Heng Feng (2):
      USB: quirks: Add no-lpm quirk for another Raydium touchscreen
      xhci: Do warm-reset when both CAS and XDEV_RESUME are set

Kalyan Thota (2):
      drm/msm/dpu: Fix reservation failures in modeset
      drm/msm/dpu: Fix scale params in plane validation

Keith Busch (2):
      block: fix get_max_io_size()
      nvme: skip noiob for zoned devices

Krishna Manikandan (1):
      drm/msm: add shutdown support for display platform_driver

Lee Jones (1):
      mfd: mfd-core: Ensure disabled devices are ignored without error

Li Jun (1):
      usb: host: xhci: fix ep context print mismatch in debugfs

Linus Torvalds (2):
      fsldma: fix very broken 32-bit ppc ioread64 functionality
      Linux 5.9-rc3

Logan Gunthorpe (2):
      nvmet-passthru: Reject commands with non-sgl flags set
      nvme: Use spin_lock_irq() when taking the ctrl->lock

Lokesh Vutla (13):
      firmware: ti_sci: Drop the device id to resource type translation
      firmware: ti_sci: Drop unused structure ti_sci_rm_type_map
      firmware: ti_sci: Add support for getting resource with subtype
      dt-bindings: irqchip: ti, sci-intr: Update bindings to drop the
usage of gic as parent
      dt-bindings: irqchip: Convert ti, sci-intr bindings to yaml
      irqchip/ti-sci-intr: Add support for INTR being a parent to INTR
      dt-bindings: irqchip: ti, sci-inta: Update docs to support
different parent.
      dt-bindings: irqchip: Convert ti, sci-inta bindings to yaml
      irqchip/ti-sci-inta: Do not store TISCI device id in platform
device id field
      irqchip/ti-sci-inta: Add support for INTA directly connecting to GIC
      arm64: dts: k3-j721e: ti-sci-inta/intr: Update to latest bindings
      arm64: dts: k3-am65: ti-sci-inta/intr: Update to latest bindings
      arm64: dts: k3-am65: Update the RM resource types

Lucas Stach (1):
      drm/etnaviv: always start/stop scheduler in timeout processing

Lukas Wunner (2):
      serial: pl011: Don't leak amba_ports entry on driver register error
      serial: pl011: Fix oops on -EPROBE_DEFER

M. Vefa Bicakci (1):
      usbip: Implement a match function to fix usbip

Marc Zyngier (2):
      irqchip: Fix probing deferal when using IRQCHIP_PLATFORM_DRIVER helpe=
rs
      irqchip: Revert modular support for drivers using
IRQCHIP_PLATFORM_DRIVER helperse

Marco Elver (1):
      sched: Use __always_inline on is_idle_task()

Marcos Paulo de Souza (1):
      btrfs: reset compression level for lzo on remount

Marek Szyprowski (1):
      drm/exynos: gem: Fix sparse warning

Martijn Coenen (1):
      loop: Set correct device size when using LOOP_CONFIGURE

Martin Wilck (2):
      nvme: multipath: round-robin: fix single non-optimized path case
      nvme: multipath: round-robin: eliminate "fallback" variable

Matthew Wilcox (Oracle) (1):
      block: Fix page_is_mergeable() for compound pages

Max Filippov (1):
      binfmt_flat: revert "binfmt_flat: don't offset the data start"

Michael Ellerman (2):
      video: fbdev: controlfb: Fix build for COMPILE_TEST=3Dy && PPC_PMAC=
=3Dn
      powerpc/64s: Fix crash in load_fp_state() due to fpexc_mode

Mika Kuoppala (1):
      drm/i915: Fix cmd parser desc matching with masks

Ming Lei (5):
      blk-mq: order adding requests to hctx->dispatch and checking SCHED_RE=
START
      block: loop: set discard granularity and alignment for block
device backed loop
      block: respect queue limit of max discard segment
      block: virtio_blk: fix handling single range discard request
      blk-mq: insert request not through ->queue_rq into sw/scheduler queue

Nathan Chancellor (2):
      block/rnbd: Ensure err is always initialized in process_rdma
      vdpa/mlx5: Avoid warnings about shifts on 32-bit platforms

Nicholas Kazlauskas (2):
      drm/amd/display: Reject overlay plane configurations in
multi-display scenarios
      drm/amd/powerplay: Fix hardmins not being sent to SMU for RV

Nicholas Piggin (2):
      lockdep: Only trace IRQ edges
      powerpc/64s: scv entry should set PPR

Oded Gabbay (1):
      habanalabs: set max power according to card type

Ofir Bitton (9):
      habanalabs: unmap PCI bars upon iATU failure
      habanalabs: Validate user address before mapping
      habanalabs: validate packet id during CB parse
      habanalabs: verify user input in cs_ioctl_signal_wait
      habanalabs: set clock gating according to mask
      habanalabs: proper handling of alloc size in coresight
      habanalabs: validate FW file size
      habanalabs: check correct vmalloc return code
      habanalabs: correctly report inbound pci region cfg error

Paul Cercueil (1):
      irqchip/ingenic: Leave parent IRQ unmasked on suspend

Paulo Alcantara (1):
      cifs: fix check of tcon dfs in smb1

Pavel Begunkov (1):
      io-wq: fix hang after cancelling pending hashed work

Peilin Ye (1):
      HID: hiddev: Fix slab-out-of-bounds write in hiddev_ioctl_usage()

Peter Zijlstra (11):
      lockdep: Use raw_cpu_*() for per-cpu variables
      cpuidle: Fixup IRQ state
      sched,idle,rcu: Push rcu_idle deeper into the idle path
      cpuidle: Make CPUIDLE_FLAG_TLB_FLUSHED generic
      cpuidle: Move trace_cpu_idle() into generic code
      x86/entry: Remove unused THUNKs
      locking/lockdep: Cleanup
      nds32: Implement arch_irqs_disabled()
      arm64: Implement arch_irqs_disabled()
      mips: Implement arch_irqs_disabled()
      lockdep,trace: Expose tracepoints

Pratik Rajesh Sampat (1):
      Revert "powerpc/powernv/idle: Replace CPU feature check with PVR chec=
k"

Rafael J. Wysocki (2):
      ACPI: OSL: Prevent acpi_release_memory() from returning too early
      PM: sleep: core: Fix the handling of pending runtime resume requests

Randy Dunlap (4):
      block: blk-mq.c: fix @at_head kernel-doc warning
      crypto: sa2ul - add Kconfig selects to fix build error
      Documentation: fix pm/intel_pstate build warning and wording
      Documentation/powerpc: fix malformed table in syscall64-abi

Ray Jui (1):
      i2c: iproc: Fix shifting 31 bits

Rikard Falkeborn (2):
      HID: cougar: Constify cougar_id_table
      HID: macally: Constify macally_id_table

Rob Clark (6):
      drm/msm/dpu: fix unitialized variable error
      drm/msm/adreno: fix updating ring fence
      drm/msm/gpu: make ringbuffer readonly
      drm/msm: enable vblank during atomic commits
      drm/msm/a6xx: fix crashdec section name typo
      drm/msm/a6xx: add module param to enable debugbus snapshot

Sagi Grimberg (1):
      nvmet: fix a memory leak

Sami Tolvanen (1):
      arm64: use a common .arch preamble for inline assembly

Samson Tam (1):
      drm/amd/display: Fix passive dongle mistaken as active dongle in
EDID emulation

Samuel Thibault (2):
      speakup: Fix wait_for_xmitr for ttyio case
      speakup: only build serialio when ISA is enabled

Sebastian Parschauer (1):
      HID: quirks: Always poll three more Lenovo PixArt mice

Sergey Senozhatsky (1):
      serial: 8250: change lock order in serial8250_do_startup()

Sharat Masetty (1):
      drm: msm: a6xx: use dev_pm_opp_set_bw to scale DDR

Shawn Anastasio (3):
      Revert "powerpc/64s: Remove PROT_SAO support"
      powerpc/64s: Disallow PROT_SAO in LPARs by default
      selftests/powerpc: Update PROT_SAO test to skip ISA 3.1

Shiju Jose (1):
      EDAC/ghes: Fix NULL pointer dereference in ghes_edac_register()

Simon Leiner (2):
      xen/xenbus: Fix granting of vmalloc'd memory
      arm/xen: Add misuse warning to virt_to_gfn

Stefano Garzarella (1):
      vhost-iotlb: fix vhost_iotlb_itree_next() documentation

Steve Wahl (1):
      MAINTAINERS: Add entry for HPE Superdome Flex (UV) maintainers

Sumit Gupta (1):
      cpufreq: replace cpu_logical_map() with read_cpuid_mpir()

Sung Lee (1):
      drm/amd/display: Send DISPLAY_OFF after power down on boot

Sven Schnelle (1):
      s390: don't trace preemption in percpu macros

Tamseel Shams (1):
      serial: samsung: Removes the IRQ not found warning

Tang Bin (1):
      usb: host: ohci-exynos: Fix error handling in exynos_ohci_probe()

Tao Zhou (1):
      drm/amdgpu: add asd fw check before loading asd

Tetsuo Handa (1):
      vt: defer kfree() of vc_screenbuf in vc_do_resize()

Thinh Nguyen (4):
      usb: dwc3: gadget: Don't setup more than requested
      usb: dwc3: gadget: Fix handling ZLP
      usb: dwc3: gadget: Handle ZLP for sg requests
      usb: uas: Add quirk for PNY Pro Elite

Thomas Gleixner (3):
      XEN uses irqdesc::irq_data_common::handler_data to store a per
interrupt XEN data pointer which contains XEN specific information.
      x86/irq: Unbreak interrupt affinity setting
      genirq/matrix: Deal with the sillyness of for_each_cpu() on UP

Tianjia Zhang (1):
      nvme-fc: Fix wrong return value in __nvme_fc_init_request()

Tim Harvey (1):
      hwmon: (gsc-hwmon) Scale temperature to millidegrees

Tom Rix (2):
      USB: cdc-acm: rework notification_buffer resizing
      hwmon: (applesmc) check status earlier.

Tomas Winkler (1):
      mei: hdcp: fix mei_hdcp_verify_mprime() input parameter

Tomi Valkeinen (1):
      drm/omap: fix incorrect lock state

Tong Zhang (1):
      drm/amd/display: should check error using DC_OK

Valmer Huhn (1):
      serial: 8250_exar: Fix number of ports for Commtech PCIe cards

Vasily Gorbik (1):
      s390/vmem: fix vmem_add_range for 4-level paging

Vineeth Pillai (2):
      hv_utils: return error if host timesysnc update is stale
      hv_utils: drain the timesync packets on onchannelcallback

Vinod Koul (1):
      usb: renesas-xhci: remove version check

Viresh Kumar (2):
      cpufreq: No need to verify cpufreq_driver in show_scaling_cur_freq()
      cpufreq: Use WARN_ON_ONCE() for invalid relation

Wang Hai (1):
      SUNRPC: remove duplicate include

Wayne Lin (1):
      drm/amd/display: Retry AUX write when fail occurs

Wei Yongjun (1):
      crypto: ingenic - Drop kfree for memory allocated with devm_kzalloc

Wolfram Sang (1):
      i2c: rcar: in slave mode, clear NACK earlier

Xu Wang (1):
      bsg-lib: convert comma to semicolon

Yufen Yu (2):
      blkcg: fix memleak for iolatency
      md/raid5: make sure stripe_size as power of two

Zqiang (1):
      libnvdimm: KASAN: global-out-of-bounds Read in internal_create_group

qiuguorui1 (1):
      irqchip/stm32-exti: Avoid losing interrupts due to clearing
pending bits by mistake

=E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) (1):
      USB: PHY: JZ4770: Fix static checker warning.
