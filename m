Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47E4C28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 22:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2CBA20661
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 22:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588544276;
	bh=anakkdM9BpNToECE7VLzdcMwz2rmbUXfEXnDQB+BOTs=;
	h=From:Date:Subject:To:List-ID:From;
	b=NcuB8QVBJLMMP3cqR8+gHMNoe67Fi2DkxMcdJyz2UViclWDnxtV5sLMp8ZzqN5i3C
	 bMkcUir2mZPCiKO84Oz8IepbVBzWNw1cVpXdkqdmheYVb0no/4J1m7FJ31PZUrFlaL
	 5slfo+dua+8B53AE6529cdGk58cSW2ym5qiUy07E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgECWRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 18:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729130AbgECWRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 18:17:55 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F26C061A0E
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 15:17:54 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id s9so2893054lfp.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 15:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=w09dtBp3vIPXVC6ZdSEGSxuX9xGu9zhFGLrWPNc8VWc=;
        b=V5n+3C0blCY8I77+GLBA6l/OGyVKAGP+r/3TzXVajPryoNctqsjWyrjxV1U/uRx2Yh
         Yg6e5Vo0YvOlCcMLd1mhjHP+OSdOSYQEiQBL6ReUGdK38t5PtJkEnQ0XzG1OjHdH9YVH
         Nhr6Z4UrZbmgb5IVZqgXRAcItdxPZ8hP0v5f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=w09dtBp3vIPXVC6ZdSEGSxuX9xGu9zhFGLrWPNc8VWc=;
        b=qSM6Kx1fZsXSPQ254cuakMy+so26w81ZcRvUdbm7sVRVAsqu+sZSTY5Rj1UCxkvEE7
         pMzaFuYDMc5m3fTDK6rKW/x9MzoGAUSAVHQLFx65xiz1xpN7u+hYCdp5aRsU7VLbB9ds
         UywIqPaQTOV174Wxs0sG/IkvdRAJIPYTfB8X3sjfgf/0UmHd+O166a8d1O2kwh8axu7N
         ed5OMjOBd5EklFzELxZKGOW+YYihyii2fNE4ARTzEXmIlyTVK7pAU104vzWJXoMei6g/
         kJ2bPzEHDh+0WRYRtgff4Pb0B13XdyBdgy/3ut64+X3ZEcGmCwgu85OBnL5E/YWEhBfE
         W/3A==
X-Gm-Message-State: AGi0Pub1nkWS6JMFHWXiMq9q++kXj0yzJuDggvx4OuvAehzLuo31qzbX
        FlT8Y2OJ99lFFUZLmGEDKX0w795DLoo=
X-Google-Smtp-Source: APiQypI51A6K4ujA0h2KA5ppyOsnU4GO0YJARcfT2QFDdnP6835QKCrt8UaWR/cCicFInGjGHzZR+A==
X-Received: by 2002:a19:40d2:: with SMTP id n201mr8952116lfa.82.1588544272261;
        Sun, 03 May 2020 15:17:52 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id j24sm6636389ljg.60.2020.05.03.15.17.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 May 2020 15:17:51 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id b24so8092174lfp.7
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 15:17:51 -0700 (PDT)
X-Received: by 2002:ac2:418b:: with SMTP id z11mr9695676lfh.30.1588544270626;
 Sun, 03 May 2020 15:17:50 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 May 2020 15:17:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjRQPn6zQnR2R2M6rupXq8OZTk7z9xJsUbgEADpZFX+NA@mail.gmail.com>
Message-ID: <CAHk-=wjRQPn6zQnR2R2M6rupXq8OZTk7z9xJsUbgEADpZFX+NA@mail.gmail.com>
Subject: Linux 5.7-rc4
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Things continue to look normal for the 5.7 release. If anything, rc4
is a bit smaller than usual (it's the smallest rc4 since we had the
tiny one over the Christmas week), and most of the discussions I was
involved with this week were about future development and cleanups
rather than any issues with the current release (although at least in
some cases they were triggered by fixes that came in this release..)

So things seem calm. Although I do suspect that part of "rc4 was
small" is that it's one of those timing things, and there wasn't a
networking pull this week, for example.

The bulk of the rc5 stuff is drivers (gpu, dma, sound, rdma, hyper-v,
md, i2c, mmc) and filesystems (btrfs and nfs).

And misc small fixlets elsewhere.

Anyway, it doesn't feel like there's anything worrisome going on, so
come on in and test the waters..

                    Linus

---

Adrian Hunter (1):
      mmc: sdhci-pci: Fix eMMC driver strength for BYT-based controllers

Aharon Landau (1):
      RDMA/mlx5: Set GRH fields in query QP on RoCE

Al Viro (2):
      dlmfs_file_write(): fix the bogosity in handling non-zero *ppos
      propagate_one(): mnt_set_mountpoint() needs mount_lock

Alaa Hleihel (1):
      RDMA/mlx4: Initialize ib_spec on the stack

Andreas Gruenbacher (1):
      nfs: Fix potential posix_acl refcnt leak in nfs3_set_acl

Andy Shevchenko (4):
      hyper-v: Use UUID API for exporting the GUID
      hyper-v: Remove internal types from UAPI header
      dmaengine: dmatest: Fix iteration non-stop logic
      dmaengine: dmatest: Fix process hang when reading 'wait' parameter

Aric Cyr (1):
      drm/amd/display: Use cursor locking to prevent flip delays

Arnd Bergmann (2):
      ALSA: opti9xx: shut up gcc-10 range warning
      btrfs: fix gcc-4.8 build warning for struct initializer

Aurabindo Pillai (1):
      drm/amd/display: DispalyPort: Write OUI only if panel supports it

Bijan Mottahedeh (1):
      io_uring: use proper references for fallback_req locking

Chris Wilson (3):
      cpufreq: intel_pstate: Only mention the BIOS disabling turbo mode onc=
e
      drm/i915/gem: Hold obj->vma.lock over for_each_ggtt_vma()
      drm/i915/gt: Check cacheline is valid before acquiring

Christian Borntraeger (1):
      s390/mm: fix page table upgrade vs 2ndary address mode accesses

Christoph Hellwig (1):
      block: remove the bd_openers checks in blk_drop_partitions

Chuck Lever (3):
      xprtrdma: Restore wake-up-all to rpcrdma_cm_event_handler()
      xprtrdma: Fix trace point use-after-free race
      xprtrdma: Fix use of xdr_stream_encode_item_{present, absent}

Colin Ian King (1):
      i40iw: fix null pointer dereference on a null wqe pointer

Damien Le Moal (1):
      riscv: select ARCH_HAS_STRICT_KERNEL_RWX only if MMU

Dan Carpenter (2):
      RDMA/cm: Fix an error check in cm_alloc_id_priv()
      i2c: amd-mp2-pci: Fix Oops in amd_mp2_pci_init() error handling

Daniel Vetter (1):
      dma-buf: Fix SET_NAME ioctl uapi

Dave Jiang (1):
      dmaengine: fix channel index enumeration

David Disseldorp (1):
      scsi: target/iblock: fix WRITE SAME zeroing

David Howells (1):
      Fix use after free in get_tree_bdev()

Dexuan Cui (4):
      Drivers: hv: vmbus: Fix Suspend-to-Idle for Generation-2 VM
      x86/hyperv: Suspend/resume the VP assist page for hibernation
      scsi: core: Allow the state change from SDEV_QUIESCE to SDEV_BLOCK
      PM: hibernate: Freeze kernel threads in software_resume()

Dmitry Osipenko (1):
      dmaengine: tegra-apb: Ensure that clock is enabled during of DMA
synchronization

Dmytro Laktyushkin (2):
      drm/amd/display: check if REFCLK_CNTL register is present
      drm/amd/display: fix rn soc bb update

Douglas Anderson (1):
      mmc: cqhci: Avoid false "cqhci: CQE stuck on" by not open-coding
timeout loop

Eric Biggers (1):
      MAINTAINERS: btrfs: fix git repo URL

Filipe Manana (2):
      btrfs: fix memory leak of transaction when deleting unused block grou=
p
      btrfs: fix partial loss of prealloc extent past i_size after fsync

Gabriel Krisman Bertazi (1):
      dm multipath: use updated MPATHF_QUEUE_IO on mapping for bio-based mp=
ath

Geert Uytterhoeven (1):
      iommu/mediatek: Fix MTK_IOMMU dependencies

Greg Kroah-Hartman (1):
      iommu: Properly export iommu_group_get_for_dev()

Grygorii Strashko (1):
      dmaengine: ti: k3-psil: fix deadlock on error path

Guenter Roeck (1):
      RISC-V: stacktrace: Declare sp_in_global outside ifdef

Gurchetan Singh (1):
      drm/virtio: only destroy created contexts

Hui Wang (1):
      ALSA: hda/realtek - Two front mics on a Lenovo ThinkCenter

Ilie Halip (1):
      riscv: fix vdso build with lld

Iuliana Prodan (5):
      crypto: caam - fix use-after-free KASAN issue for SKCIPHER algorithms
      crypto: caam - fix use-after-free KASAN issue for AEAD algorithms
      crypto: caam - fix use-after-free KASAN issue for HASH algorithms
      crypto: caam - fix use-after-free KASAN issue for RSA algorithms
      crypto: caam - fix the address of the last entry of S/G

Jason Gunthorpe (2):
      RDMA/siw: Fix potential siw_mem refcnt leak in siw_fastreg_mr()
      RDMA/uverbs: Fix a race with disassociate and exit_mmap()

Jason Yan (1):
      mmc: core: make mmc_interrupt_hpi() static

Jens Axboe (3):
      io_uring: statx must grab the file table for valid fd
      io_uring: enable poll retry for any file with ->read_iter / ->write_i=
ter
      io_uring: only force async punt if poll based retry can't handle it

Josef Bacik (1):
      btrfs: drop logs when we've aborted a transaction

Kai Vehmanen (1):
      ALSA: hda/hdmi: fix race in monitor detection during probe

Kai-Heng Feng (1):
      PM: ACPI: Output correct message on target power state

Kefeng Wang (3):
      riscv: sbi: Correct sbi_shutdown() and sbi_clear_ipi() export
      tty: riscv: Using RISCV_SBI_V01 instead of RISCV_SBI
      riscv: sbi: Fix undefined reference to sbi_shutdown

Kevin Hao (1):
      iommu: Fix the memory leak in dev_iommu_free()

Krzysztof Kozlowski (1):
      iommu: spapr_tce: Disable compile testing to fix build on book3s_32 c=
onfig

Leon Romanovsky (4):
      RDMA/cm: Fix missing RDMA_CM_EVENT_REJECTED event after
receiving REJ message
      RDMA/core: Prevent mixed use of FDs between shared ufiles
      RDMA/core: Fix overwriting of uobj in case of error
      RDMA/core: Fix race between destroy and release FD object

Linus Torvalds (1):
      Linux 5.7-rc4

Lu Baolu (1):
      iommu/vt-d: Use right Kconfig option name

Lubomir Rintel (2):
      dmaengine: mmp_tdma: Do not ignore slave config validation errors
      dmaengine: mmp_tdma: Reset channel error on release

Lyude Paul (1):
      drm/dp_mst: Fix drm_dp_send_dpcd_write() return code

Maciej Grochowski (1):
      include/linux/dmaengine: Typos fixes in API documentation

Madhuparna Bhowmik (1):
      dmaengine: pch_dma.c: Avoid data race between probe and irq handler

Marco Elver (1):
      kunit: Add missing newline in summary message

Marek Beh=C3=BAn (1):
      mmc: sdhci-xenon: fix annoying 1.8V regulator warning

Marek Ol=C5=A1=C3=A1k (3):
      drm/amdgpu: add tiling flags from Mesa
      drm/amdgpu: invalidate L2 before SDMA IBs (v2)
      drm/amdgpu: bump version for invalidate L2 before SDMA IBs

Martin Blumenstingl (2):
      mmc: meson-mx-sdio: Set MMC_CAP_WAIT_WHILE_BUSY
      mmc: meson-mx-sdio: remove the broken ->card_busy() op

Martin Wilck (2):
      scsi: qla2xxx: set UNLOADING before waiting for session deletion
      scsi: qla2xxx: check UNLOADING before posting async work

Masahiro Yamada (1):
      dt-bindings: dma: uniphier-xdmac: switch to single reg region

Matt Roper (1):
      drm/i915: Use proper fault mask in interrupt postinstall too

Michael Kelley (1):
      Drivers: hv: Move AEOI determination to architecture dependent code

Mikulas Patocka (1):
      dm writecache: fix data corruption when reloading the target

Milan Broz (1):
      dm integrity: document allow_discard option

NeilBrown (1):
      SUNRPC: defer slow parts of rpc_free_client() to a workqueue.

Nicholas Kazlauskas (1):
      drm/amd/display: Defer cursor update around VUPDATE for all ASIC

Niklas Cassel (1):
      nvme: prevent double free in nvme_alloc_ns() error handling

Nishad Kamdar (1):
      btrfs: discard: Use the correct style for SPDX License Identifier

Olga Kornievskaia (1):
      NFSv4.1: fix handling of backchannel binding in BIND_CONN_TO_SESSION

Paul Moore (1):
      selinux: properly handle multiple messages in selinux_netlink_send()

Pavel Begunkov (3):
      io_uring: fix extra put in sync_file_range()
      io_uring: check non-sync defer_list carefully
      io_uring: punt splice async because of inode mutex

Qu Wenruo (1):
      btrfs: transaction: Avoid deadlock due to bad initialization
timing of fs_info::journal_info

Randy Dunlap (1):
      dma-buf: fix documentation build warnings

Rayagonda Kokatanur (1):
      i2c: iproc: generate stop event for slave writes

Ritesh Harjani (1):
      fibmap: Warn and return an error in case of block > INT_MAX

Rodrigo Siqueira (1):
      drm/amd/display: Fix green screen issue after suspend

Sean Christopherson (1):
      vfio/type1: Fix VA->PA translation for PFNMAP VMAs in vaddr_get_pfn()

Sebastian von Ohr (1):
      dmaengine: xilinx_dma: Add missing check for empty list

Shuah Khan (1):
      selftests: add build/cross-build dependency check script

Sudip Mukherjee (1):
      IB/rdmavt: Always return ERR_PTR from rvt_create_mmap_info()

Sung Lee (1):
      drm/amd/display: Update downspread percent to match spreadsheet for D=
CN2.1

Sunwook Eom (1):
      dm verity fec: fix hash block number in verity_fec_decode

Suravee Suthikulpanit (1):
      iommu/amd: Fix legacy interrupt remapping for x2APIC-enabled system

Takashi Iwai (4):
      ALSA: hda: Match both PCI ID and SSID for driver blacklist
      ALSA: pcm: oss: Place the plugin buffer overflow checks correctly
      ALSA: pcm: oss: Place the plugin buffer overflow checks
correctly (for 5.7)
      ALSA: usb-audio: Correct a typo of NuPrime DAC-10 USB ID

Tang Bin (1):
      iommu/qcom: Fix local_base status check

Tiecheng Zhou (2):
      Revert "drm/amd/powerplay: avoid using pm_en before it is initialized=
"
      drm/amd/powerplay: avoid using pm_en before it is initialized revised

Trond Myklebust (3):
      NFS/pnfs: Ensure that _pnfs_return_layout() waits for
layoutreturn completion
      NFS/pnfs: Fix a credential use-after-free issue in pnfs_roc()
      NFS: Fix a race in __nfs_list_for_each_server()

Vasily Averin (4):
      drm/qxl: qxl_release leak in qxl_draw_dirty_fb()
      drm/qxl: qxl_release leak in qxl_hw_surface_alloc()
      drm/qxl: lost qxl_bo_kunmap_atomic_page in qxl_image_init_helper()
      drm/qxl: qxl_release use after free

Vasily Khoruzhick (1):
      ALSA: line6: Fix POD HD500 audio playback

Veerabhadrarao Badiganti (1):
      mmc: sdhci-msm: Enable host capabilities pertains to R1b response

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/edid: Fix off-by-one in DispID DTD pixel clock

Vincenzo Frascino (1):
      arm64: vdso: Add -fasynchronous-unwind-tables to cflags

Wei Yongjun (1):
      selinux: fix error return code in cond_read_list()

Wolfram Sang (2):
      Revert "i2c: tegra: Synchronize DMA before termination"
      Revert "i2c: tegra: Better handle case where CPU0 is busy for a long =
time"

Wu Bo (1):
      ALSA: hda/hdmi: fix without unlocked before return

Xiao Yang (2):
      selftests/ftrace: Check required filter files before running test
      selftests/ftrace: Check the first record for kprobe_args_type.tc

Xiaodong Yan (1):
      drm/amd/display: blank dp stream before re-train the link

Xiaoguang Wang (1):
      io_uring: use cond_resched() in io_ring_ctx_wait_and_kill()

Xiyu Yang (5):
      SUNRPC: Remove unreachable error condition
      btrfs: fix block group leak when removing fails
      btrfs: fix transaction leak in btrfs_recover_relocation
      NFSv4: Remove unreachable error condition due to rpc_run_task()
      drm/i915/selftests: Fix i915_address_space refcnt leak

Yan Zhao (2):
      vfio: checking of validity of user vaddr in vfio_dma_rw
      vfio: avoid possible overflow in vfio_iommu_type1_pin_pages

YueHaibing (1):
      dmaengine: hisilicon: Fix build error without PCI_MSI

ryan_chen (1):
      i2c: aspeed: Avoid i2c interrupt status clear race condition.
