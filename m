Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D455C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 23:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4A7A20702
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 23:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592780446;
	bh=M+QEIh4ZAfDSNxm0na+1hZJatcdLVbcAbg9/d5woSHw=;
	h=From:Date:Subject:To:List-ID:From;
	b=e5bC8QODdcnGjcDB0yuMFV63OLKyj/W/2bSQsDzNseYvlu9/9A9Iv+vcZQThB4FXN
	 uXVknPPatW4mQ25vNrukD9OeQi1PwgfAdjR4beUn8/p8YUck3dbkchpvysyvXByJyy
	 pfOKP0kroCBSxX163kFzYF4wu9JBJN8B1xz777JM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbgFUXAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 19:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730946AbgFUXAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 19:00:23 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC6CC061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 16:00:20 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id c21so8516893lfb.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 16:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=e8wYszbIPIWvW/xXxRlEobQ2UcaSEgpe7+hbZ1UKiCM=;
        b=f0J8F0qXUBT6zgNsNpS7ISfYmUmfeLIGFQU+gSLVhPd9JsYfJD4kqMJElO6zJu4//s
         pq2p/pjC427gpQndpDNDG90qVsDwVo9yQjpIpJzwKDIYow+RGytK+bU0TBONg3RlQKF8
         xUOuGyzT9Alt0B783n2UeWDL4k2/WnIx1ke9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=e8wYszbIPIWvW/xXxRlEobQ2UcaSEgpe7+hbZ1UKiCM=;
        b=rbLenHw3pL21ING5lKHT1aXmzfezztx4ZZ9ROYSAndKY0pNqvOjp/6LQME7oz+6cjh
         maQRZ8/Q/dbWy+HWBAeIMwu8tGiz7b0r7XC2JrFqaVHVhHXf1PF7mGFB50hV4MHSNirg
         /v0NCDbPivb9J3mQ/UHEZXgFK9L9VmPVXwSh0jcakv1Guohcpq0sRCsG+yk4uH+zZJ52
         ymSAS69o2xfaRZHlXfNvdm8wK5uvmiazGXU5cTRItJtO87OqBrW1saw7MLuC5WXRMYUe
         7YIweX1foRDzDRFjYjyE9Ux88y3ABQ3Vb2c2lFqo6/NdxXD+4L0DyMYbs4rtqgrIJ5bw
         SqFA==
X-Gm-Message-State: AOAM531pQ5dkhXPfFNnLRNPqybIpRq6j6mb5PmDbtYZZXb0SGVIjhch9
        5RMWzG3D9ECqzlgkFHCDgddLOnXpGhc=
X-Google-Smtp-Source: ABdhPJw71JMKVBIv4O1+poCkue3kREACh2pR0qh12hnkCS0vYWoLvbXJ5i77ZGa4/+8ssumn+FmvmQ==
X-Received: by 2002:a19:83c7:: with SMTP id f190mr8156353lfd.14.1592780418416;
        Sun, 21 Jun 2020 16:00:18 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 24sm3029162lfy.59.2020.06.21.16.00.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jun 2020 16:00:17 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id n24so17140024lji.10
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 16:00:17 -0700 (PDT)
X-Received: by 2002:a2e:8e78:: with SMTP id t24mr6971575ljk.314.1592780416856;
 Sun, 21 Jun 2020 16:00:16 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 21 Jun 2020 16:00:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXm00G4DJ-L2XSPS+TFU_-mcL0qgcMVq62mCzuUZsCwQ@mail.gmail.com>
Message-ID: <CAHk-=whXm00G4DJ-L2XSPS+TFU_-mcL0qgcMVq62mCzuUZsCwQ@mail.gmail.com>
Subject: Linux 5.8-rc2
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So 5.8 may end up- being a big release, but rc2 looks fairly normal.

Despite having one pull request that missed rc1 by five minutes (and
thus getting pulled into rc2) and having a couple of small series of
"post-rc1 cleanup after we're past the conflicts",  and despite being
one of the largest merge windows ever, last week was fairly calm.

So rc2 isn't particularly big or scary, and falls right in the normal range=
.

We'll see how much of that is the usual "catch our breath after the
merge window", and how much of that is just "5.8 looks fairly normal
despite being large".

Shortlog appended, there's nothing that looks alarming to me. It's a
mix of arch fixes, GPU driver fixes, filesystems, selftests and misc
small noise all over.

So whether you're a father or not (and whether you live in one of the
countries that celebrate it today or not), have a happy Father's Day.
And go test, it's not scary. Ok?

                 Linus

---

Aditya Pakki (2):
      test_objagg: Fix potential memory leak in error handling
      rocker: fix incorrect error handling in dma_rings_init

Alaa Hleihel (2):
      net/sched: act_ct: Make tcf_ct_flow_table_restore_skb inline
      netfilter: flowtable: Make nf_flow_table_offload_add/del_cb inline

Alex Deucher (2):
      drm/amdgpu/pm: update comment to clarify Overdrive interfaces
      drm/amdgpu: fix documentation around busy_percentage

Andy Shevchenko (1):
      partitions/ldm: Replace uuid_copy() with import_uuid() where it
makes sense

Aneesh Kumar K.V (1):
      powerpc: Fix kernel crash in show_instructions() w/DEBUG_VIRTUAL

Ard Biesheuvel (1):
      arm64: remove TEXT_OFFSET randomization

Arnaldo Carvalho de Melo (10):
      tools headers API: Update faccessat2 affected files
      tools arch x86 uapi: Synch asm/unistd.h with the kernel sources
      tools headers uapi: Sync linux/stat.h with the kernel sources
      perf beauty: Add support to STATX_MNT_ID in the 'statx' syscall
'mask' argument
      tools headers UAPI: Sync linux/fscrypt.h with the kernel sources
      tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
      tools headers UAPI: Sync kvm.h headers with the kernel sources
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools include UAPI: Sync linux/vhost.h with the kernel sources
      tools headers UAPI: Sync linux/fs.h with the kernel sources

Arnd Bergmann (3):
      drm/i915/pmu: avoid an maybe-uninitialized warning
      drm/i915: work around false-positive maybe-uninitialized warning
      e1000e: fix unused-function warning

Arvind Sankar (2):
      Makefile: Improve compressed debug info support detection
      x86/purgatory: Add -fno-stack-protector

Atish Patra (1):
      RISC-V: Acquire mmap lock before invoking walk_page_range

Baolin Wang (1):
      blk-mq: Remove redundant 'return' statement

Barry Song (1):
      arm64: mm: reserve hugetlb CMA after numa_init

Bartosz Golaszewski (1):
      net: ethernet: mtk-star-emac: simplify interrupt handling

Charles Keepax (1):
      net: macb: Only disable NAPI on the actual error path

Chen Yu (1):
      e1000e: Do not wake up the system via WOL if device wakeup is disable=
d

Chen Zhou (3):
      s390/crypto: use scnprintf() instead of snprintf()
      s390: use scnprintf() in sys_##_prefix##_##_name##_show
      s390/protvirt: use scnprintf() instead of snprintf()

Chris Wilson (10):
      drm/i915/gt: Incorporate the virtual engine into timeslicing
      drm/i915/selftests: Restore to default heartbeat
      drm/i915/gt: Prevent timeslicing into unpreemptable requests
      drm/i915/gt: Incrementally check for rewinding
      drm/i915/gt: Move hsw GT workarounds from init_clock_gating to workar=
ounds
      drm/i915/gt: Move ivb GT workarounds from init_clock_gating to workar=
ounds
      drm/i915/gt: Move vlv GT workarounds from init_clock_gating to workar=
ounds
      drm/i915/gt: Move snb GT workarounds from init_clock_gating to workar=
ounds
      drm/i915/gt: Move ilk GT workarounds from init_clock_gating to workar=
ounds
      drm/i915/gt: Move gen4 GT workarounds from init_clock_gating to
workarounds

Christoph Hellwig (5):
      scsi: libata: Provide an ata_scsi_dma_need_drain stub for !CONFIG_ATA
      scsi: Wire up ata_scsi_dma_need_drain for SAS HBA drivers
      maccess: rename probe_kernel_{read,write} to copy_{from,to}_kernel_no=
fault
      maccess: rename probe_user_{read,write} to copy_{from,to}_user_nofaul=
t
      maccess: rename probe_kernel_address to get_kernel_nofault

Christophe Leroy (3):
      mm/gup: Use huge_ptep_get() in gup_hugepte()
      mm: Allow arches to provide ptep_get()
      powerpc/8xx: Provide ptep_get() with 16k pages

Colin Ian King (1):
      net: axienet: fix spelling mistake in comment "Exteneded" -> "extende=
d"

Coly Li (2):
      bcache: use delayed kworker fo asynchronous devices registration
      bcache: pr_info() format clean up in bcache_device_init()

Cornelia Huck (1):
      s390/virtio: remove unused pm callbacks

Dan Carpenter (1):
      crypto: marvell/octeontx - Fix a potential NULL dereference

Daniel Schaefer (1):
      Documentation/i2c: SMBus start signal is S not A

Dave Martin (2):
      docs/arm64: Fix typo'd #define in sve.rst
      arm64/sve: Eliminate data races on sve_default_vl

David Howells (14):
      afs: Fix non-setting of mtime when writing into mmap
      afs: afs_write_end() should change i_size under the right lock
      afs: Fix EOF corruption
      afs: Concoct ctimes
      afs: Fix truncation issues and mmap writeback size
      afs: Fix the mapping of the UAEOVERFLOW abort code
      afs: Remove yfs_fs_fetch_file_status() as it's not used
      afs: Fix yfs_fs_fetch_status() to honour vnode selector
      afs: Remove afs_operation::abort_code
      afs: Fix use of afs_check_for_remote_deletion()
      afs: afs_vnode_commit_status() doesn't need to check the RPC error
      afs: Fix silly rename
      afs: Fix afs_do_lookup() to call correct fetch-status op variant
      afs: Fix hang on rmmod due to outstanding timer

David Rientjes (1):
      dma-pool: decouple DMA_REMAP from DMA_COHERENT_POOL

Denis Efremov (2):
      drm/amd/display: Use kvfree() to free coeff in build_regamma()
      drm/amd/display: Use kfree() to free rgb_user in
calculate_user_regamma_ramp()

Dinghao Liu (2):
      hwrng: ks-sa - Fix runtime PM imbalance on error
      scsi: ufs-bsg: Fix runtime PM imbalance on error

Dmitry Baryshkov (1):
      pinctrl: qcom: spmi-gpio: fix warning about irq chip reusage

Dmitry V. Levin (1):
      s390: fix syscall_get_error for compat processes

Drew Fustini (1):
      pinctrl: single: fix function name in documentation

Eric Biggers (2):
      ext4: avoid utf8_strncasecmp() with unstable name
      crypto: algboss - don't wait during notifier callback

Eric Dumazet (1):
      tcp: grow window for OOO packets only for SACK flows

Flavio Suligoi (1):
      tools: testing: ftrace: trigger: fix spelling mistake

Gaurav Singh (1):
      perf report: Fix NULL pointer dereference in
hists__fprintf_nr_sample_events()

Geert Uytterhoeven (1):
      dma-pool: fix too large DMA pools on medium memory size systems

Geliang Tang (2):
      mptcp: drop MPTCP_PM_MAX_ADDR
      mptcp: use list_first_entry_or_null

Gene Chen (1):
      mfd: mt6360: Fix register driver NULL pointer by adding driver name

Gustavo A. R. Silva (43):
      firmware: dmi-sysfs: Replace zero-length array with flexible-array me=
mber
      firmware: google: memconsole: Replace zero-length array with
flexible-array member
      firmware: google: vpd: Replace zero-length array with
flexible-array member
      aio: Replace zero-length array with flexible-array
      ARM: tegra: Replace zero-length array with flexible-array
      dmaengine: Replace zero-length array with flexible-array
      can: peak_canfd: Replace zero-length array with flexible-array
      can: Replace zero-length array with flexible-array
      crypto: Replace zero-length array with flexible-array
      drbd: Replace zero-length array with flexible-array
      drm/edid: Replace zero-length array with flexible-array
      cb710: Replace zero-length array with flexible-array
      firewire: ohci: Replace zero-length array with flexible-array
      FS-Cache: Replace zero-length array with flexible-array
      ia64: kernel: unwind_i.h: Replace zero-length array with flexible-arr=
ay
      samples: mei: Replace zero-length array with flexible-array
      ibft: Replace zero-length array with flexible-array
      jffs2: Replace zero-length array with flexible-array
      KVM: Replace zero-length array with flexible-array
      kexec: Replace zero-length array with flexible-array
      keys: encrypted-type: Replace zero-length array with flexible-array
      kprobes: Replace zero-length array with flexible-array
      libata: Replace zero-length array with flexible-array
      tools/testing/nvdimm: Replace zero-length array with flexible-array
      block: Replace zero-length array with flexible-array
      oprofile: Replace zero-length array with flexible-array
      firmware: pcdp: Replace zero-length array with flexible-array
      media: pwc: Replace zero-length array with flexible-array
      rapidio: Replace zero-length array with flexible-array
      RxRPC: Replace zero-length array with flexible-array
      phy: samsung: Replace zero-length array with flexible-array
      sctp: Replace zero-length array with flexible-array
      ima: Replace zero-length array with flexible-array
      ASoC: SOF: Replace zero-length array with flexible-array
      Squashfs: Replace zero-length array with flexible-array
      stm class: Replace zero-length array with flexible-array
      dmaengine: tegra-apb: Replace zero-length array with flexible-array
      tifm: Replace zero-length array with flexible-array
      soc: ti: Replace zero-length array with flexible-array
      tracing/probe: Replace zero-length array with flexible-array
      w1: Replace zero-length array with flexible-array
      overflow.h: Add flex_array_size() helper
      arm64: kexec_file: Use struct_size() in kmalloc()

Haibo Chen (1):
      Revert "pinctrl: freescale: imx: Use 'devm_of_iomap()' to avoid
a resource leak in case of error in 'imx_pinctrl_probe()'"

Heiko Carstens (1):
      s390/numa: let NODES_SHIFT depend on NEED_MULTIPLE_NODES

Heinrich Schuchardt (1):
      crypto: caam - fix typos

Herbert Xu (3):
      crypto: algif_skcipher - Cap recv SG list at ctx->used
      crypto: hisilicon - Cap block size at 2^31
      crypto: ccp - Fix sparse warnings in sev-dev

Hongbo Yao (1):
      perf stat: Fix NULL pointer dereference

Ian Rogers (3):
      perf parse-events: Fix an incompatible pointer
      perf parse-events: Fix an old style declaration
      perf pmu: Remove unused declaration

Ido Schimmel (1):
      mlxsw: spectrum: Adjust headroom buffers for 8x ports

Ilya Dryomov (3):
      libceph: move away from global osd_req_flags
      libceph: don't omit recovery_deletes in target_copy()
      libceph: don't omit used_replica in target_copy()

Imre Deak (2):
      drm/i915/icl: Disable DIP on MST ports with the transcoder clock stil=
l on
      drm/i915/icl+: Fix hotplug interrupt disabling after storm detection

Ira Weiny (9):
      fs/ext4: Narrow scope of DAX check in setflags
      fs/ext4: Disallow verity if inode is DAX
      fs/ext4: Change EXT4_MOUNT_DAX to EXT4_MOUNT_DAX_ALWAYS
      fs/ext4: Update ext4_should_use_dax()
      fs/ext4: Only change S_DAX on inode load
      fs/ext4: Make DAX mount option a tri-state
      fs/ext4: Remove jflag variable
      fs/ext4: Introduce DAX inode flag
      Documentation/dax: Update DAX enablement for ext4

Jan (janneke) Nieuwenhuizen (1):
      ext4: support xattr gnu.* namespace for the Hurd

Jan Kara (1):
      blktrace: Avoid sparse warnings when assigning q->blk_trace

Jason Yan (1):
      block: Fix use-after-free in blkdev_get()

Jeffle Xu (1):
      ext4: fix partial cluster initialization when splitting extent

Jens Axboe (2):
      io_uring: acquire 'mm' for task_work for SQPOLL
      io_uring: reap poll completions while waiting for refs to drop on exi=
t

Jiri Olsa (1):
      kretprobe: Prevent triggering kretprobe from within kprobe_flush_task

Julian Wiedmann (4):
      s390/qdio: fine-tune SLSB update
      s390/qdio: reduce SLSB writes during Input Queue processing
      s390/qdio: clean up usage of qdio_data
      s390/qdio: warn about unexpected SLSB states

Ka-Cheong Poon (1):
      net/rds: NULL pointer de-reference in rds_ib_add_one()

Kai-Heng Feng (1):
      libata: Use per port sync for detach

Kaitao Cheng (1):
      ftrace: Fix maybe-uninitialized compiler warning

Kefeng Wang (2):
      sample-trace-array: Fix sleeping function called from invalid context
      sample-trace-array: Remove trace_array 'sample-instance'

Keyur Patel (1):
      i2c: smbus: Fix spelling mistake in the comments

Khaled Almahallawy (1):
      drm/i915/tc: fix the reset of ln0

Linus Torvalds (2):
      maccess: make get_kernel_nofault() check for minimal type compatibili=
ty
      Linux 5.8-rc2

Loic Poulain (1):
      MAINTAINERS: Add robert and myself as qcom i2c cci maintainers

Lorenz Brun (1):
      drm/amdkfd: Use correct major in devcgroup check

Luc Van Oostenryck (1):
      sparse: use identifiers to define address spaces

Luis Chamberlain (1):
      blktrace: break out of blktrace setup on concurrent calls

Martin (1):
      bareudp: Fixed configuration to avoid having garbage values

Masahiro Yamada (4):
      kbuild: improve cc-option to clean up all temporary files
      kconfig: unify cc-option and as-option
      Revert "Makefile: install modules.builtin even if CONFIG_MODULES=3Dn"
      samples: watch_queue: build sample program for target architecture

Masami Hiramatsu (15):
      selftests/ftrace: Allow ":" in description
      selftests/ftrace: Return unsupported for the unconfigured features
      selftests/ftrace: Add "requires:" list support
      selftests/ftrace: Convert required interface checks into requires lis=
t
      selftests/ftrace: Convert check_filter_file() with requires list
      selftests/ftrace: Support ":tracer" suffix for requires
      selftests/ftrace: Support ":README" suffix for requires
      kprobes: Suppress the suspicious RCU warning on kprobes
      kprobes: Use non RCU traversal APIs on kprobe_tables if possible
      kprobes: Fix to protect kick_kprobe_optimizer() by kprobe_mutex
      kprobes: Remove redundant arch_disarm_kprobe() call
      proc/bootconfig: Fix to use correct quotes for value
      tools/bootconfig: Fix to use correct quotes for value
      tools/bootconfig: Fix to return 0 if succeeded to show the bootconfig
      tools/bootconfig: Add testcase for show-command and quotes test

Masanari Iida (1):
      scripts: Fix typo in headers_install.sh

Mauricio Faria de Oliveira (1):
      bcache: check and adjust logical block size for backing devices

Michael Chan (3):
      bnxt_en: Simplify bnxt_resume().
      bnxt_en: Re-enable SRIOV during resume.
      bnxt_en: Fix AER reset logic on 57500 chips.

Michael Ellerman (1):
      powerpc/syscalls: Use the number when building SPU syscall table

Mike Rapoport (1):
      powerpc/8xx: use pmd_off() to access a PMD entry in pte_update()

Milian Wolff (1):
      perf script: Initialize zstd_data

Nathan Chancellor (1):
      s390/vdso: Use $(LD) instead of $(CC) to link vDSO

Nathan Huckleberry (1):
      riscv/atomic: Fix sign extension for RV64I

Navid Emamdoost (1):
      sata_rcar: handle pm_runtime_get_sync failure cases

Nicholas Piggin (1):
      powerpc/64s: Fix KVM interrupt using wrong save area

Pablo Neira Ayuso (2):
      netfilter: ctnetlink: memleak in filter initialization error path
      netfilter: nf_tables: hook list memleak in flowtable deletion

Pavel Begunkov (7):
      io_uring: fix lazy work init
      io-wq: reorder cancellation pending -> running
      io-wq: add an option to cancel all matched reqs
      io_uring: cancel all task's requests on exit
      io_uring: batch cancel in io_uring_cancel_files()
      io_uring: lazy get task
      io_uring: cancel by ->task not pid

Randy Dunlap (2):
      trace/events/block.h: drop kernel-doc for dropped function parameter
      Documentation: remove SH-5 index entries

Ritesh Harjani (1):
      ext4: mballoc: Use this_cpu_read instead of this_cpu_ptr

Rodrigo Siqueira (1):
      drm/amd/display: Rework dsc to isolate FPU operations

Sami Tolvanen (1):
      recordmcount: support >64k sections

Sandeep Raghuraman (1):
      drm/amdgpu: Replace invalid device ID with a valid device ID

Sasha Levin (1):
      scripts/decode_stacktrace: warn when modpath is needed but is unset

Sergei Shtylyov (1):
      MAINTAINERS: switch to my private email for Renesas Ethernet drivers

Shyam Thombre (1):
      arm64: mm: reset address tag set by kasan sw tagging

Sivaprakash Murugesan (1):
      pinctrl: qcom: ipq6018 Add missing pins in qpic pin group

Stefano Brivio (2):
      netfilter: nft_set_rbtree: Don't account for expired elements on inse=
rtion
      netfilter: nft_set_pipapo: Disable preemption before getting
per-CPU pointer

Stephan M=C3=BCller (1):
      crypto: drbg - always try to free Jitter RNG instance

Steven Rostedt (VMware) (4):
      tracing: Make ftrace packed events have align of 1
      tools lib traceevent: Add append() function helper for appending stri=
ngs
      tools lib traceevent: Handle __attribute__((user)) in field names
      tools lib traceevent: Add handler for __builtin_expect()

Sumanth Korikkar (2):
      perf probe: Fix user attribute access in kprobes
      perf bpf: Fix bpf prologue generation

Sven Auhagen (2):
      mvpp2: ethtool rxtx stats fix
      mvpp2: remove module bugfix

Sven Schnelle (5):
      s390/seccomp: pass syscall arguments via seccomp_data
      s390/ptrace: return -ENOSYS when invalid syscall is supplied
      s390/ptrace: pass invalid syscall numbers to tracing
      s390/ptrace: fix setting syscall number
      selftests/seccomp: s390 shares the syscall and return value register

Theodore Ts'o (1):
      ext4: avoid race conditions when remounting with options that change =
dax

Thomas Falcon (1):
      ibmvnic: Harden device login requests

Tiezhu Yang (1):
      perf build: Fix error message when asking for -fsanitize=3Daddress
without required libraries

Tim Harvey (1):
      lan743x: add MODULE_DEVICE_TABLE for module loading alias

Tom Rix (3):
      selinux: fix double free
      selinux: fix a double free in cond_read_node()/cond_read_list()
      selinux: fix undefined return of cond_evaluate_expr

Vaibhav Gupta (1):
      e1000: use generic power management

Vaibhav Jain (6):
      powerpc: Document details on H_SCM_HEALTH hcall
      seq_buf: Export seq_buf_printf
      powerpc/papr_scm: Fetch nvdimm health information from PHYP
      powerpc/papr_scm: Improve error logging and handling papr_scm_ndctl()
      ndctl/papr_scm,uapi: Add support for PAPR nvdimm specific methods
      powerpc/papr_scm: Implement support for PAPR_PDSM_HEALTH

Vamshi K Sthambamkadi (1):
      tracing/probe: Fix memleak in fetch_op_data operations

Vandita Kulkarni (1):
      drm/i915/display: Fix the encoder type check

Vasundhara Volam (1):
      bnxt_en: Return from timer if interface is not in open state.

Vidya Sagar (1):
      pinctrl: tegra: Use noirq suspend/resume callbacks

Vincenzo Frascino (1):
      s390/vdso: fix vDSO clock_getres()

Vishal Verma (1):
      nvdimm/region: always show the 'align' attribute

Vladimir Oltean (2):
      MAINTAINERS: merge entries for felix and ocelot drivers
      net: dsa: sja1105: fix PTP timestamping with large tc-taprio cycles

Wang Hai (1):
      mld: fix memory leak in ipv6_mc_destroy_dev()

Wang Qing (1):
      qlcnic: Use kobj_to_dev() instead

Wei Yang (1):
      trace: Fix typo in allocate_ftrace_ops()'s comment

Wei Yongjun (1):
      mptcp: fix memory leak in mptcp_subflow_create_socket()

Weiping Zhang (1):
      block: update hctx map when use multiple maps

Will Deacon (5):
      arm64: traps: Dump registers prior to panic() in bad_mode()
      arm64: pgtable: Clear the GP bit for non-executable kernel pages
      arm64: sve: Fix build failure when ARM64_SVE=3Dy and SYSCTL=3Dn
      arm64: bti: Require clang >=3D 10.0.1 for in-kernel BTI support
      arm64: hw_breakpoint: Don't invoke overflow handler on uaccess watchp=
oints

Wolfram Sang (6):
      drm: encoder_slave: fix refcouting error for modules
      drm: encoder_slave: use new I2C API
      x86/platform/intel-mid: convert to use i2c_new_client_device()
      video: backlight: tosa_lcd: convert to use i2c_new_client_device()
      Documentation: media: convert to use i2c_new_client_device()
      i2c: remove deprecated i2c_new_device API

Xiaoguang Wang (3):
      io_uring: don't fail links for EAGAIN error in IOPOLL mode
      io_uring: add memory barrier to synchronize io_kiocb's result
and iopoll_completed
      io_uring: fix possible race condition against REQ_F_NEED_CLEANUP

YangHui (1):
      tracing: Remove unused event variable in tracing_iter_reset

Yash Shah (1):
      RISC-V: Don't allow write+exec only page mapping request in mmap

Ye Bin (1):
      ata/libata: Fix usage of page address by page_address in
ata_scsi_mode_select_xlat function

Zekun Shen (1):
      net: alx: fix race condition in alx_remove

Zheng Bin (2):
      loop: replace kill_bdev with invalidate_bdev
      block: make function 'kill_bdev' static

Zhiqiang Liu (1):
      bcache: fix potential deadlock problem in btree_gc_coalesce

Zou Wei (1):
      s390/zcrypt: use kzalloc

kernel test robot (1):
      pinctrl: mcp23s08: Split to three parts: fix ptr_ret.cocci warnings

yangerkun (1):
      ext4: stop overwrite the errcode in ext4_setup_super

zhangyi (F) (1):
      ext4, jbd2: ensure panic by fix a race between jbd2 abort and
ext4 error handlers
