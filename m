Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF0AC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 00:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01CD92080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 00:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599439086;
	bh=OP4q1JOfz5W6fxNQjARmUecidG8x6ubR9AWpyvnybfw=;
	h=From:Date:Subject:To:List-ID:From;
	b=cDsmfUsG8x95JfUsLospc/0/nnqZfu+A3sxmORo9MePYTVelNO11mLyQ3Do7/Emtl
	 eudJjyraMtKtavB4KWJCXAkR1GILvMLP+/msJBHIqTJRApmJsrPYV6R3S/tFlL2s+f
	 bXnN5KWG/a9dDIi4Wh+2qGyDaS4IHfaqQPS2mP2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgIGAiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 20:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgIGAh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 20:37:59 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C6BC061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 17:37:58 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id v23so14118277ljd.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 17:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3EMsGE5m9whwtcq/jmJnhBkBlo+2QYu7Gj+EHYBSzNA=;
        b=Oz2fAgevyPm50MG7jzmLK4nSx+PZBJljBpQS0oEBesVVyYW/VFf0lGJph192Kafbr8
         IOtGKQfVp8qH5B9/wR0nqCmRsdziw5Y8GSKxQ8kDgTsrQGLtZjwkcr9k/hcNjo7djDbC
         7LrN3xHPqHruOB+Uq4FYRVbMwoidvnSH5u8K8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3EMsGE5m9whwtcq/jmJnhBkBlo+2QYu7Gj+EHYBSzNA=;
        b=F663qGMoXPR1pHc2Q04fl6xnferktc83oLW7Yzb61jAKEarwmtPZsRD0VRtc+iVHZJ
         pOeK3jCuSLFnfhPTGOiUCNYIWjeW86QaoLHTkO5vk3oez2qs3+iBydQfRrk8hbTVtIp/
         2gU7kTipWY1Tz9yHLrJvmy179gmIr0OGrubLrX9da1mKzsSAztIURYwL3yuwvlU8yGly
         8l81lrx5j42FSRendb9uTgRZZLim/wx0mj3i+Y0zdhe0cwbXzKI4dkKsWZd/o0Ai6gNr
         5qnN9XIXDBdEEksTg31AmQpSCsduFaxBDSUBSzZmp6Gf68FKLTKiArJNHYlBcR6R46W3
         TyGw==
X-Gm-Message-State: AOAM533J9DZIhDZ+BGGj2IkDN18gLrJ1hJQliLJKeeNLOvTkklurnlWH
        aaUvbp9XeZSFc4sn0yaDBQ5nleBD7kKCbQ==
X-Google-Smtp-Source: ABdhPJw5aVl+FwVqWlddd09IDNgJNc4GJoCFjWFZuw0iYlyz5w0Ehclk3+VldgjpjTPQE99Nsd+XuQ==
X-Received: by 2002:a05:651c:151:: with SMTP id c17mr9908155ljd.467.1599439074219;
        Sun, 06 Sep 2020 17:37:54 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id c10sm5627274lfc.4.2020.09.06.17.37.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 17:37:53 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id a22so7672547ljp.13
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 17:37:53 -0700 (PDT)
X-Received: by 2002:a2e:7819:: with SMTP id t25mr1031153ljc.371.1599439072610;
 Sun, 06 Sep 2020 17:37:52 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Sep 2020 17:37:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgdq1XfoECVoZyr5+j+LM7oG31DhEhSoju=DQFBdSvEsw@mail.gmail.com>
Message-ID: <CAHk-=wgdq1XfoECVoZyr5+j+LM7oG31DhEhSoju=DQFBdSvEsw@mail.gmail.com>
Subject: Linux 5.9-rc4
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, last weekend I said that rc3 was fairly small, and it was likely
due to the usual timing fluctuations in pull requests. And guess what?
Here we are, a week later, and yup - rc4 has all the pieces that were
missing from rc3, and is larger than usual.

It's not outrageously so, and we've had bigger rc4's, so it while it's
a bit larger than average, it's all well within the normal range, and
not something I'll lose any sleep over.

We've got changes all over, with the expected networking fixes perhaps
standing out, but there's all the usual suspects: drivers (sound,
nvme, gpu, iommu, mmc etc), filesystems (btrfs, afs, affs(!) and xfs),
architecture updates (a little bit of this, a little bit of that) and
documentation and tooling (mainly perf). Plus misc core noise, mainly
mm.

But most of it looks pretty small, with a couple of bigger blips in
the diffstat (intel pstate cpufreq driver, mac802.11 data rates, xen
memory allocation helpers). But even those blips aren't exactly huge,
they just end up standing out by being more than a few handfuls of
lines of change.

So I certainly can't claim that things have calmed down, but hopefully
this was pretty much it. Knock wood.

Go test. Pretty please.

                 Linus

---

Adrian Hunter (1):
      mmc: sdhci-pci: Fix SDHCI_RESET_ALL for CQHCI for Intel
GLK-based controllers

Adrien Crivelli (1):
      ALSA: hda/realtek: Add quirk for Samsung Galaxy Book Ion NT950XCJ-X71=
6A

Al Grant (3):
      perf cs-etm: Fix corrupt data after perf inject from
      perf intel-pt: Fix corrupt data after perf inject from
      perf tools: Correct SNOOPX field offset

Al Viro (1):
      fix regression in "epoll: Keep a reference on files added to the
check list"

Alexander A. Klimov (1):
      auxdisplay: Replace HTTP links with HTTPS ones

Alistair Popple (2):
      mm/migrate: fixup setting UFFD_WP flag
      mm/rmap: fixup copying of soft dirty and uffd ptes

Allen Pais (10):
      ALSA: core: convert tasklets to use new tasklet_setup() API
      ALSA: firewire: convert tasklets to use new tasklet_setup() API
      ALSA: pci/asihpi: convert tasklets to use new tasklet_setup() API
      ALSA: riptide: convert tasklets to use new tasklet_setup() API
      ALSA: hdsp: convert tasklets to use new tasklet_setup() API
      ASoC: fsl_esai: convert tasklets to use new tasklet_setup() API
      ASoC: siu: convert tasklets to use new tasklet_setup() API
      ASoC: txx9: convert tasklets to use new tasklet_setup() API
      ALSA: usb-audio: convert tasklets to use new tasklet_setup() API
      ALSA: ua101: convert tasklets to use new tasklet_setup() API

Amar Singhal (1):
      cfg80211: Adjust 6 GHz frequency to channel conversion

Andy Lutomirski (2):
      selftests/x86/test_vsyscall: Improve the process_vm_readv() test
      x86/debug: Allow a single level of #DB recursion

Arnaldo Carvalho de Melo (3):
      perf symbols: Add mwait_idle_with_hints.constprop.0 to the list
of idle symbols
      perf top/report: Fix infinite loop in the TUI for grouped events
      perf parse-events: Use uintptr_t when casting numbers to pointers

Arvind Sankar (1):
      x86/cmdline: Disable jump tables for cmdline.c

Barret Rhoden (1):
      init: fix error check in clean_path()

Ben Skeggs (3):
      drm/nouveau/kms/nv50-: add some whitespace before debug message
      drm/nouveau/kms/nv50-gp1xx: disable notifies again after core update
      drm/nouveau/kms/nv50-gp1xx: add WAR for EVO push buffer HW bug

Brandon Jiang (1):
      Documentation: fix typo for abituguru documentation

Brian Foster (2):
      xfs: finish dfops on every insert range shift iteration
      xfs: fix off-by-one in inode alloc block reservation calculation

Chris Wilson (2):
      perf tools: Use %zd for size_t printf formats on 32-bit
      iommu/vt-d: Handle 36bit addressing for x86-32

Christoph Hellwig (1):
      block: fix locking in bdev_del_partition

Christophe JAILLET (2):
      media: mceusb: Avoid GFP_ATOMIC where it is not needed
      nvmet-fc: Fix a missed _irqsave version of spin_lock in
'nvmet_fc_fod_op_done()'

Cong Wang (1):
      net_sched: fix error path in red_init()

Damien Le Moal (1):
      dm crypt: Initialize crypto wait structures

Dan Carpenter (2):
      scsi: libcxgbi: Fix a use after free in cxgbi_conn_xmit_pdu()
      net: gemini: Fix another missing clk_disable_unprepare() in probe

Dan Crawford (1):
      ALSA: hda - Fix silent audio output and corrupted input on MSI X570-A=
 PRO

Dan Murphy (1):
      net: dp83867: Fix WoL SecureOn password

Daniel Gorsulowski (1):
      net: dp83869: Fix RGMII internal delay configuration

Darrick J. Wong (2):
      xfs: initialize the shortform attr header padding entry
      xfs: fix xfs_bmap_validate_extent_raw when checking attr fork of rt f=
iles

Dave Hansen (1):
      mm: fix pin vs. gup mismatch with gate pages

Dave Jiang (1):
      dmaengine: idxd: reset states after device disable or reset

David Ahern (1):
      perf sched timehist: Fix use of CPU list with summary option

David Howells (8):
      rxrpc: Keep the ACK serial in a var in rxrpc_input_ack()
      rxrpc: Fix loss of RTT samples due to interposed ACK
      rxrpc: Make rxrpc_kernel_get_srtt() indicate validity
      afs: Remove afs_vlserver->probe.have_result
      afs: Expose information from afs_vlserver through /proc for debugging
      afs: Don't use VL probe running state to make decisions outside probe=
 code
      afs: Fix error handling in VL server rotation
      mm/khugepaged.c: fix khugepaged's request size in collapse_file

Denis Efremov (2):
      net: bcmgenet: fix mask check in bcmgenet_validate_flow()
      kconfig: remove redundant assignment prompt =3D prompt

Dinghao Liu (7):
      net: hns: Fix memleak in hns_nic_dev_probe
      net: systemport: Fix memleak in bcm_sysport_probe
      NFC: st95hf: Fix memleak in st95hf_in_send_cmd
      net: arc_emac: Fix memleak in arc_mdio_probe
      firestream: Fix memleak in fs_open
      rxrpc: Fix memory leak in rxkad_verify_response()
      HID: elan: Fix memleak in elan_input_configured

Dmitry Osipenko (1):
      thermal: core: Fix use-after-free in thermal_zone_device_unregister()

Edward Cree (1):
      sfc: fix boolreturn.cocci warning and rename function

Edwin Peer (2):
      bnxt_en: fix HWRM error when querying VF temperature
      bnxt_en: init RSS table for Minimal-Static VF reservation

Eric Farman (1):
      s390: fix GENERIC_LOCKBREAK dependency typo in Kconfig

Eric Sandeen (1):
      xfs: fix boundary test in xfs_attr_shortform_verify

Eugeniu Rosca (1):
      mm: slub: fix conversion of freelist_corrupted()

Evan Quan (1):
      drm/amd/pm: avoid false alarm due to confusing
softwareshutdowntemp setting

Evgeniy Didin (1):
      ARC: [plat-hsdk]: Switch ethernet phy-mode to rgmii-id

Ezequiel Garcia (1):
      media: cedrus: Add missing v4l2_ctrl_request_hdl_put()

Fabian Frederick (5):
      selftests: netfilter: fix header example
      selftests: netfilter: exit on invalid parameters
      selftests: netfilter: remove unused variable in make_file()
      selftests: netfilter: simplify command testing
      selftests: netfilter: add command usage

Felix Fietkau (4):
      mac80211: use rate provided via status->rate on
ieee80211_tx_status_ext for AQL
      mac80211: factor out code to look up the average packet length
duration for a rate
      mac80211: improve AQL aggregation estimation for low data rates
      mac80211: reduce packet loss event false positives

Florian Fainelli (8):
      MIPS: mm: BMIPS5000 has inclusive physical caches
      MIPS: BMIPS: Also call bmips_cpu_setup() for secondary cores
      MAINTAINERS: GENET: Add missing platform data file
      MAINTAINERS: B53: Add DT binding file
      MAINTAINERS: GENET: Add DT binding file
      MAINTAINERS: GENET: Add UniMAC MDIO controller files
      MAINTAINERS: Add entry for Broadcom Ethernet PHY drivers
      MAINTAINERS: Remove self from PHY LIBRARY

Florian Westphal (4):
      netfilter: conntrack: allow sctp hearbeat after connection re-use
      netfilter: nf_tables: fix destination register zeroing
      mptcp: free acked data before waiting for more memory
      netfilter: conntrack: do not auto-delete clash entries on reply

Francisco Jerez (1):
      cpufreq: intel_pstate: Fix intel_pstate_get_hwp_max() for turbo disab=
led

Franti=C5=A1ek Ku=C4=8Dera (1):
      ALSA: usb-audio: Add basic capture support for Pioneer DJ DJM-250MK2

Grygorii Strashko (1):
      net: ethernet: ti: am65-cpsw: fix rmii 100Mbit link mode

Gustavo Pimentel (1):
      dmaengine: dw-edma: Fix scatter-gather address calculation

Hanjun Guo (1):
      dmaengine: acpi: Put the CSRT table after using it

Hans Verkuil (1):
      media: vicodec: add missing v4l2_ctrl_request_hdl_put()

He Zhe (1):
      mips/oprofile: Fix fallthrough placement

Heiko Carstens (1):
      s390: update defconfigs

Herbert Xu (1):
      net: Get rid of consume_skb when tracing is off

Himadri Pandya (1):
      net: usb: Fix uninit-was-stored issue in asix_read_phy_addr()

Huang Pei (1):
      MIPS: add missing MSACSR and upper MSA initialization

Huang Ying (1):
      x86, fakenuma: Fix invalid starting node ID

Ian Rogers (1):
      perf parse-events: Avoid an uninitialized read when using fake PMUs

Ido Schimmel (2):
      ipv4: Silence suspicious RCU usage warning
      ipv6: Fix sysctl max for fib_multipath_hash_policy

Jacopo Mondi (1):
      media: i2c: imx214: select V4L2_FWNODE

Jakub Kicinski (2):
      net: disable netpoll on fresh napis
      bnxt: don't enable NAPI until rings are ready

Jason Gunthorpe (1):
      include/linux/log2.h: add missing () around n in roundup_pow_of_two()

Jens Axboe (3):
      block: ensure bdi->io_pages is always initialized
      io_uring: no read/write-retry on -EAGAIN error and O_NONBLOCK marked =
file
      io_uring: fix explicit async read/write mapping for large segments

Jesper Dangaard Brouer (2):
      selftests/bpf: Fix test_progs-flavor run getting number of tests
      selftests/bpf: Fix massive output from test_maps

Jessica Yu (1):
      arm64/module: set trampoline section flags regardless of
CONFIG_DYNAMIC_FTRACE

Jiansong Chen (1):
      drm/amd/pm: enable MP0 DPM for sienna_cichlid

Jiaxun Yang (1):
      MIPS: Loongson64: Do not override watch and ejtag feature

Jin Yao (2):
      perf parse-events: Set exclude_guest=3D1 for user-space counting
      perf stat: Turn off summary for interval mode by default

Jiri Olsa (2):
      perf report: Disable ordered_events for raw dump
      perf tools: Add bpf image check to __map__is_kmodule

Jiufei Xue (2):
      io_uring: fix removing the wrong file in __io_sqe_files_update()
      io_uring: set table->files[i] to NULL when io_sqe_file_register faile=
d

Joerg Roedel (4):
      x86/mm/32: Bring back vmalloc faulting on x86_32
      iommu/amd: Do not force direct mapping when SME is active
      iommu/amd: Do not use IOMMUv2 functionality when SME is active
      mm: track page table modifications in __apply_to_page_range()

Johannes Berg (2):
      nl80211: fix NL80211_ATTR_HE_6GHZ_CAPABILITY usage
      cfg80211: regulatory: reject invalid hints

Josef Bacik (5):
      btrfs: drop path before adding new uuid tree entry
      btrfs: fix potential deadlock in the search ioctl
      btrfs: allocate scrub workqueues outside of locks
      btrfs: set the correct lockdep class for new nodes
      btrfs: set the lockdep class for log tree extent buffers

Joshua Sivec (1):
      ALSA: usb-audio: Add implicit feedback quirk for UR22C

Jussi Kivilinna (1):
      batman-adv: bla: use netif_rx_ni when not in interrupt context

Kai Vehmanen (1):
      ALSA: hda/hdmi: always check pin power status in i915 pin fixup

Kai-Heng Feng (2):
      ALSA: usb-audio: Disable autosuspend for Lenovo ThinkStation P620
      drm/radeon: Prefer lower feedback dividers

Kamil Lorenc (1):
      net: usb: dm9601: Add USB ID of Keenetic Plus DSL

Karsten Graul (1):
      net/smc: fix toleration of fake add_link messages

Kees Cook (1):
      docs: Fix function name trailing double-()s

Keith Busch (2):
      nvme: fix controller instance leak
      nvme: only use power of two io boundaries

Kevin Wang (1):
      drm/amd/pm: fix is_dpm_running() run error on 32bit system

Kim Phillips (1):
      perf record/stat: Explicitly call out event modifiers in the document=
ation

Kurt Kanzenbach (1):
      dt-bindings: net: dsa: Fix typo

Landen Chao (1):
      net: dsa: mt7530: fix advertising unsupported 1000baseT_Half

Laurent Pinchart (1):
      media: ti-vpe: cal: Fix compilation on 32-bit ARM

Leesoo Ahn (1):
      pktgen: fix error message with wrong function name

Leon Romanovsky (1):
      gcov: Disable gcov build with GCC 10

Li Xinhai (1):
      mm/hugetlb: try preferred node first when alloc gigantic page from cm=
a

Linus L=C3=BCssing (1):
      batman-adv: Fix own OGM check in aggregated OGMs

Linus Torvalds (2):
      mm: do_wp_page() simplification
      Linux 5.9-rc4

Louis Peens (1):
      nfp: flower: fix ABI mismatch between driver and firmware

Lu Baolu (2):
      iommu/vt-d: Serialize IOMMU GCMD register modifications
      iommu/vt-d: Fix NULL pointer dereference in dev_iommu_priv_set()

Luc Van Oostenryck (3):
      Compiler Attributes: remove comment about sparse not supporting
__has_attribute
      Compiler Attributes: fix comment concerning GCC 4.6
      sparse: use static inline for __chk_{user,io}_ptr()

Lukas Bulwahn (3):
      MAINTAINERS: mention documentation maintainer entry profile
      Documentation: add riscv entry in list of existing profiles
      MAINTAINERS: Update QUALCOMM IOMMU after Arm SMMU drivers move

Lyude Paul (1):
      drm/nouveau/kms/gv100-: Include correct push header in crcc37d.c

Madhuparna Bhowmik (1):
      drivers/dma/dma-jz4780: Fix race condition between probe and irq hand=
ler

Marc Zyngier (2):
      HID: core: Correctly handle ReportSize being zero
      HID: core: Sanitize event code and type when mapping input

Marcos Paulo de Souza (1):
      btrfs: block-group: fix free-space bitmap threshold

Marek Szyprowski (1):
      dmaengine: pl330: Fix burst length if burst size is smaller than bus =
width

Marta Rybczynska (1):
      Documentation/locking/locktypes: fix local_locks documentation

Mathieu Poirier (1):
      MAINTAINERS: Add entries for CoreSight and Arm SPE tooling

Max Staudt (1):
      affs: fix basic permission bits to actually work

Miaohe Lin (1):
      net: Fix some comments

Michael Chan (4):
      bnxt_en: Fix ethtool -S statitics with XDP or TCs enabled.
      bnxt_en: Fix possible crash in bnxt_fw_reset_task().
      bnxt_en: Setup default RSS map in all scenarios.
      tg3: Fix soft lockup when tg3_reset_task() fails.

Michal Hocko (1):
      memcg: fix use-after-free in uncharge_batch

Michal Simek (1):
      dt-bindings: mmc: Add missing description for clk_in/out_sd1

Miguel Ojeda (1):
      clang-format: Update with the latest for_each macro list

Mike Rapoport (1):
      arc: fix memory initialization for systems with two memory banks

Mike Snitzer (1):
      dm mpath: fix racey management of PG initialization

Mikulas Patocka (4):
      dm writecache: handle DAX to partitions on persistent memory correctl=
y
      dm integrity: fix error reporting in bitmap mode after creation
      ext2: don't update mtime on COW faults
      xfs: don't update mtime on COW faults

Ming Lei (2):
      block: release disk reference in hd_struct_free_work
      block: allow for_each_bvec to support zero len bvec

Mingming Cao (1):
      ibmvnic fix NULL tx_pools and rx_tools issue at do_reset

Mohan Kumar (2):
      ALSA: hda: Fix 2 channel swapping for Tegra
      ALSA: hda/tegra: Program WAKEEN register for Tegra

Mrinal Pandey (1):
      checkpatch: fix the usage of capture group ( ... )

Muchun Song (1):
      mm/hugetlb: fix a race between hugetlb sysctl handlers

Murali Karicheri (3):
      net: ethernet: ti: cpsw: fix clean up of vlan mc entries for host por=
t
      net: ethernet: ti: cpsw_new: fix clean up of vlan mc entries for host=
 port
      net: ethernet: ti: cpsw_new: fix error handling in
cpsw_ndo_vlan_rx_kill_vid()

Namhyung Kim (1):
      perf jevents: Fix suspicious code in fixregex()

Nathan Chancellor (3):
      net: dsa: sja1105: Do not use address of compatible member in
sja1105_check_device_id
      Documentation/llvm: Improve formatting of commands, variables,
and arguments
      drm/i915/display: Ensure that ret is always initialized in
icl_combo_phy_verify_state

Nicholas Miell (1):
      HID: microsoft: Add rumble support for the 8bitdo SN30 Pro+ controlle=
r

Nick Desaulniers (1):
      MAINTAINERS: add LLVM maintainers

Nicolas Dichtel (1):
      gtp: add GTPA_LINK info to msg sent to userspace

Niklas Cassel (1):
      scsi: scsi_debug: Remove superfluous close zone in resp_open_zone()

Nirenjan Krishnan (1):
      HID: quirks: Set INCREMENT_USAGE_ON_DUPLICATE for all Saitek X52 devi=
ces

Or Cohen (1):
      net/packet: fix overflow in tpacket_rcv

Pablo Neira Ayuso (3):
      netfilter: nf_tables: add NFTA_SET_USERDATA if not null
      netfilter: nf_tables: incorrect enum nft_list_attributes definition
      netfilter: nfnetlink: nfnetlink_unicast() reports EAGAIN instead
of ENOBUFS

Paul Barker (1):
      doc: net: dsa: Fix typo in config code sample

Paul Moore (1):
      netlabel: fix problems with mapping removal

Pavan Chebbi (1):
      bnxt_en: Don't query FW when netif_running() is false.

Pavel Begunkov (2):
      io_uring: fix cancel of deferred reqs with ->files
      io_uring: fix linked deferred ->files cancellation

Peilin Ye (1):
      media: media/v4l2-core: Fix kernel-infoleak in video_put_user()

Peter Ujfalusi (3):
      dmaengine: of-dma: Fix of_dma_router_xlate's of_dma_xlate handling
      dmaengine: ti: k3-udma: Fix the TR initialization for prep_slave_sg
      dmaengine: ti: k3-udma: Update rchan_oes_offset for am654 SYSFW ABI 3=
.0

Peter Xu (3):
      mm/ksm: Remove reuse_ksm_page()
      mm/gup: Remove enfornced COW mechanism
      mm: Add PGREUSE counter

Peter Zijlstra (1):
      x86/entry: Fix AC assertion

Pierre-Louis Bossart (2):
      ALSA: hda: add dev_dbg log when driver is not selected
      ALSA: hda: use consistent HDAudio spelling in comments/docs

Potnuri Bharat Teja (1):
      cxgb4: fix thermal zone device registration

Puranjay Mohan (2):
      IIO: Documentation: Replace deprecated :c:func: Usage
      Fpga: Documentation: Replace deprecated :c:func: Usage

Qu Wenruo (1):
      btrfs: tree-checker: fix the error message for transid error

Rafael J. Wysocki (5):
      cpufreq: intel_pstate: Refuse to turn off with HWP enabled
      cpufreq: intel_pstate: Update cached EPP in the active mode
      cpufreq: intel_pstate: Tweak the EPP sysfs interface
      cpufreq: intel_pstate: Add ->offline and ->online callbacks
      cpufreq: intel_pstate: Free memory only when turning off

Ralph Campbell (2):
      mm/migrate: remove unnecessary is_zone_device_page() check
      mm/migrate: preserve soft dirty in remove_migration_pte()

Rander Wang (2):
      ALSA: hda: hdmi - add Rocketlake support
      ALSA: hda: fix a runtime pm issue in SOF when integrated GPU is disab=
led

Randy Dunlap (9):
      ARC: pgalloc.h: delete a duplicated word + other fixes
      Documentation: sound/cards: fix heading underline lengths for
https: changes
      Documentation: laptops: thinkpad-acpi: fix underline length build war=
ning
      netfilter: delete repeated words
      microblaze: fix min_low_pfn/max_low_pfn build errors
      ia64: fix min_low_pfn/max_low_pfn build errors
      kconfig: streamline_config.pl: check defined(ENV variable) before usi=
ng it
      kbuild: Documentation: clean up makefiles.rst
      MAINTAINERS: IA64: mark Status as Odd Fixes only

Raul E Rangel (1):
      mmc: sdhci-acpi: Fix HS400 tuning for AMDI0040

Robert Richter (1):
      MAINTAINERS: update Cavium/Marvell entries

Roger Pau Monne (3):
      xen/balloon: add header guard
      memremap: rename MEMORY_DEVICE_DEVDAX to MEMORY_DEVICE_GENERIC
      xen: add helpers to allocate unpopulated memory

Sagi Grimberg (9):
      nvme-fabrics: don't check state NVME_CTRL_NEW for request acceptance
      nvme: have nvme_wait_freeze_timeout return if it timed out
      nvme-tcp: serialize controller teardown sequences
      nvme-tcp: fix timeout handler
      nvme-tcp: fix reset hang if controller died in the middle of a reset
      nvme-rdma: serialize controller teardown sequences
      nvme-rdma: fix timeout handler
      nvme-rdma: fix reset hang if controller died in the middle of a reset
      nvme: Fix NULL dereference for pci nvme controllers

Sakari Ailus (1):
      media: max9286: Depend on OF_GPIO

Sandeep Raghuraman (2):
      drm/amdgpu: Specify get_argument function for ci_smu_funcs
      drm/amdgpu: Fix bug in reporting voltage for CIK

Sean Paul (2):
      drm/i915: Fix sha_text population code
      drm/i915: Clear the repeater bit on HDCP disable

Sean Young (3):
      media: rc: uevent sysfs file races with rc_unregister_device()
      media: rc: do not access device via sysfs after rc_unregister_device(=
)
      media: gpio-ir-tx: spinlock is not needed to disable interrupts

Shannon Nelson (1):
      ionic: fix txrx work accounting

Shay Bar (1):
      wireless: fix wrong 160/80+80 MHz setting

Shung-Hsi Yu (1):
      net: ethernet: mlx4: Fix memory allocation in mlx4_buddy_init()

Shyam Sundar S K (1):
      amd-xgbe: Add support for new port mode

Sowjanya Komatineni (7):
      sdhci: tegra: Remove SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK for Tegra210
      sdhci: tegra: Remove SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK for Tegra186
      dt-bindings: mmc: tegra: Add tmclk for Tegra210 and later
      arm64: tegra: Add missing timeout clock to Tegra210 SDMMC
      arm64: tegra: Add missing timeout clock to Tegra186 SDMMC nodes
      arm64: tegra: Add missing timeout clock to Tegra194 SDMMC nodes
      sdhci: tegra: Add missing TMCLK for data timeout

Stefano Brivio (2):
      netfilter: nft_set_rbtree: Handle outcomes of tree rotations in
overlap detection
      netfilter: nft_set_rbtree: Detect partial overlap with start
endpoint match

Sudeep Holla (1):
      arm64: Remove exporting cpu_logical_map symbol

Sumanth Korikkar (1):
      perf test: Fix basic bpf filtering test

Sumera Priyadarsini (2):
      net: ocelot: Add of_node_put() before return statement
      net: dsa: mt7530: Add of_node_put() before break and return statement=
s

Suravee Suthikulpanit (2):
      iommu/amd: Restore IRTE.RemapEn bit after programming IRTE
      iommu/amd: Use cmpxchg_double() when updating 128-bit IRTE

Sven Eckelmann (1):
      batman-adv: Avoid uninitialized chaddr when handling DHCP

Takashi Iwai (2):
      ALSA: pcm: oss: Remove superfluous WARN_ON() for mulaw sanity check
      ALSA: hda/realtek - Improved routing for Thinkpad X1 7th/8th Gen

Takashi Sakamoto (2):
      ALSA; firewire-tascam: exclude Tascam FE-8 from detection
      ALSA: firewire-digi00x: exclude Avid Adrenaline from detection

Tejun Heo (3):
      blk-iocost: ioc_pd_free() shouldn't assume irq disabled
      blk-stat: make q->stats->lock irqsafe
      libata: implement ATA_HORKAGE_MAX_TRIM_128M and apply to Sandisks

Tetsuo Handa (1):
      tipc: fix shutdown() of connectionless socket

Theodore Dubois (1):
      devices.txt: fix typo of "ubd" as "udb"

Thomas Bogendoerfer (1):
      MIPS: SNI: Fix SCSI interrupt

Thomas Gleixner (1):
      x86/entry: Unbreak 32bit fast syscall

Thomas Richter (2):
      perf test: Set NULL sentinel in pmu_events table in "Parse and
process metrics" test
      perf stat: Fix out of bounds array access in the
print_counters() evlist method

Tiezhu Yang (3):
      perf top: Skip side-band event setup if HAVE_LIBBPF_SUPPORT is not se=
t
      Revert "ALSA: hda: Add support for Loongson 7A1000 controller"
      MIPS: perf: Fix wrong check condition of Loongson event IDs

Tobias Klauser (4):
      ipv6: ndisc: adjust ndisc_ifinfo_sysctl_change prototype
      bpf, sysctl: Let bpf_stats_handler take a kernel pointer buffer
      ipc: adjust proc_ipc_sem_dointvec definition to match prototype
      fork: adjust sysctl_max_threads definition to match prototype

Tong Zhang (3):
      ALSA: ca0106: fix error code handling
      net: caif: fix error code handling
      nvme-pci: cancel nvme device request before disabling

Tony Lindgren (1):
      thermal: ti-soc-thermal: Fix bogus thermal shutdowns for omap4430

Tuong Lien (1):
      tipc: fix using smp_processor_id() in preemptible

Tzvetomir Stoyanov (VMware) (1):
      libtraceevent: Fix build warning on 32-bit arches

Ursula Braun (3):
      net/smc: set rx_off for SMCR explicitly
      net/smc: reset sndbuf_desc if freed
      net/smc: fix sock refcounting in case of termination

Vamshi K Sthambamkadi (1):
      tracing/kprobes, x86/ptrace: Fix regs argument order for i386

Vasundhara Volam (2):
      bnxt_en: Check for zero dir entries in NVRAM.
      bnxt_en: Fix PCI AER error recovery flow

Veera Vegivada (1):
      thermal: qcom-spmi-temp-alarm: Don't suppress negative temp

Vineet Gupta (4):
      ARC: perf: don't bail setup if pct irq missing in device-tree
      ARC: HSDK: wireup perf irq
      ARC: show_regs: fix r12 printing and simplify
      irqchip/eznps: Fix build error for !ARC700 builds

Vinicius Costa Gomes (1):
      taprio: Fix using wrong queues in gate mask

Viresh Kumar (1):
      opp: Don't drop reference for an OPP table that was never parsed

WANG Xuerui (1):
      MIPS: Loongson64: Remove unnecessary inclusion of boot_param.h

Wei Li (2):
      perf: arm-spe: Fix check error when synthesizing events
      perf record: Correct the help info of option "--no-bpf-event"

Wenbin Mei (3):
      mmc: dt-bindings: Add resets/reset-names for Mediatek MMC bindings
      mmc: mediatek: add optional module reset property
      arm64: dts: mt7622: add reset node for mmc device

Xie He (4):
      drivers/net/wan/lapbether: Added needed_tailroom
      drivers/net/wan/lapbether: Set network_header before transmitting
      drivers/net/wan/hdlc_cisco: Add hard_header_len
      drivers/net/wan/hdlc: Change the default of hard_header_len to 0

Xin Long (1):
      sctp: not disable bh in the whole sctp_get_port_local()

Xu Wang (1):
      ata: ahci: use ata_link_info() instead of ata_link_printk()

Xunlei Pang (1):
      mm: memcg: fix memcg reclaim soft lockup

Yang Shi (1):
      mm: madvise: fix vma user-after-free

Ye Bin (4):
      scsi: qedf: Fix null ptr reference in qedf_stag_change_work
      dm cache metadata: Avoid returning cmd->bm wild pointer on error
      dm thin metadata:  Avoid returning cmd->bm wild pointer on error
      dm thin metadata: Fix use-after-free in dm_bm_set_read_only

Yi Li (1):
      net: hns3: Fix for geneve tx checksum bug

Yonghong Song (1):
      bpf: Fix a buffer out-of-bound access when filling raw_tp link_info

Yu Kuai (3):
      dmaengine: at_hdmac: check return value of
of_find_device_by_node() in at_dma_xlate()
      dmaengine: at_hdmac: add missing put_device() call in at_dma_xlate()
      dmaengine: at_hdmac: add missing kfree() call in at_dma_xlate()

YueHaibing (2):
      net: cdc_ncm: Fix build error
      perf bench: The do_run_multi_threaded() function must use
IS_ERR(perf_session__new())

Yunsheng Lin (1):
      vhost: fix typo in error message

Yuusuke Ashizuka (1):
      ravb: Fixed to be able to unload modules

Ziye Yang (1):
      nvmet-tcp: Fix NULL dereference when a connect data comes in h2cdata =
pdu

zhudi (1):
      netlink: fix a data race in netlink_rcv_wake()
