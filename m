Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F9AC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 819C620DD4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eC6+Gs2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgIGDXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 23:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgIGDXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 23:23:37 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24AAC061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 20:23:37 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id a9so2779916pjg.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 20:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Sr8FcuzZ5QdPVA+MQeU+IQxyFpCevcyxAo43US7olyI=;
        b=eC6+Gs2rd15wPwQZOoAhAw5QYU6koBH7/85d0+pWbeRD0liWwCmuv00r8pWNIWCgYu
         Z9QEjZd9EWzr+UWC1P7u8qLQpenykZt6sfQRgjdJH8P7q4PWH06w1v8BEqdpvEqGif1B
         ErrJf09YxaL7RERh7gbsJ7VO6s6fycMtPd1Ss2hHaqprWcKPTYvFtNA8pkdNe0z+D1bS
         m7fMwQJW66IejO+6tC3/S5ZQECUqrKQEUQwn98A6I2n1fcfAehSEyyIRXoa2hPRyow1V
         6M5D4kCI+m+9Vqn2IIIXXgI3C9KvbdttpXFV+nbV2Zy6s28vtrVfPV5YzCaUv95iIqx1
         yCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=Sr8FcuzZ5QdPVA+MQeU+IQxyFpCevcyxAo43US7olyI=;
        b=HTeQe6JBC/QffjgsEHFhjARNHX8Sc0gKPQOWR+i9ZGgnpQ6S3lXBtSt8OrkWhd7bzJ
         cf+VwuthcRPYERkwS2qRpF/7LajOMPS5zhCfo0PX9P2Kq6Lx9XMtsLIH8BrBul+GjWyz
         B93TvzneIXw1ilBv2Nuep+LS3Iivwl1wjCTKtvV/rtlp7cIWDYu6X0asUcvf0N5riQ0P
         iUGMKgPehyV3f772lAifS+laxCGJWYplrnb8D9UPEvWnLN9YOGJkhCNQibGAKQPVmxdT
         Lkp7EaVk+GE8og2XUrVUWCQGI3HQwktynZu9mNwfEM67tw1HW5luynRLQC5pFlpEdbSw
         xpbw==
X-Gm-Message-State: AOAM5312GTStLTUxSVUyftxI2WVWm4mRUeae7EzBWgCeE4Z7ko7iUT/9
        AdjWwwWxl2OMBL0RpzoWBxZ7Bv7aPGJDIw==
X-Google-Smtp-Source: ABdhPJy/BYOFhfjGLwsJsySlbGWWAof23TaDRaIDk7IsC0ve3CbBRR/MIQNS5OM8/RfvCpI2UwWufg==
X-Received: by 2002:a17:90a:d246:: with SMTP id o6mr11442443pjw.211.1599449013315;
        Sun, 06 Sep 2020 20:23:33 -0700 (PDT)
Received: from Gentoo (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id z23sm2452483pfg.220.2020.09.06.20.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 20:23:32 -0700 (PDT)
Date:   Mon, 7 Sep 2020 08:53:22 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ...and it built and boots without fuss.. Linux 5.9-rc4
Message-ID: <20200907032322.GA3674@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wgdq1XfoECVoZyr5+j+LM7oG31DhEhSoju=DQFBdSvEsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgdq1XfoECVoZyr5+j+LM7oG31DhEhSoju=DQFBdSvEsw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:37 Sun 06 Sep 2020, Linus Torvalds wrote:
>Hey, last weekend I said that rc3 was fairly small, and it was likely
>due to the usual timing fluctuations in pull requests. And guess what?
>Here we are, a week later, and yup - rc4 has all the pieces that were
>missing from rc3, and is larger than usual.
>
>It's not outrageously so, and we've had bigger rc4's, so it while it's
>a bit larger than average, it's all well within the normal range, and
>not something I'll lose any sleep over.
>
>We've got changes all over, with the expected networking fixes perhaps
>standing out, but there's all the usual suspects: drivers (sound,
>nvme, gpu, iommu, mmc etc), filesystems (btrfs, afs, affs(!) and xfs),
>architecture updates (a little bit of this, a little bit of that) and
>documentation and tooling (mainly perf). Plus misc core noise, mainly
>mm.
>
>But most of it looks pretty small, with a couple of bigger blips in
>the diffstat (intel pstate cpufreq driver, mac802.11 data rates, xen
>memory allocation helpers). But even those blips aren't exactly huge,
>they just end up standing out by being more than a few handfuls of
>lines of change.
>
>So I certainly can't claim that things have calmed down, but hopefully
>this was pretty much it. Knock wood.
>
>Go test. Pretty please.
>
>                 Linus
>
>---


Well,something trivial for the eyes!


[    3.634570] EXT4-fs (sda): recovery complete
[    3.651778] EXT4-fs (sda): mounted filesystem with ordered data mode. Opts: (null)
[    3.653932] ext4 filesystem being mounted at /root supports timestamps until 2038 (0x7fffffff)
[    3.654833] VFS: Mounted root (ext4 filesystem) on device 8:0.
[    3.670791] devtmpfs: mounted
[    3.703946] Freeing unused decrypted memory: 2040K
[    3.807007] Freeing unused kernel image (initmem) memory: 1600K
[    3.808081] tsc: Refined TSC clocksource calibration: 2194.919 MHz
[    3.808823] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1fa372fc492, max_idle_ns: 440795285018 ns
[    3.809829] clocksource: Switched to clocksource tsc
[    3.810641] Write protecting the kernel read-only data: 26624k
[    3.816295] Freeing unused kernel image (text/rodata gap) memory: 2040K
[    3.818689] Freeing unused kernel image (rodata/data gap) memory: 908K
[    3.819419] rodata_test: all tests were successful
[    3.820129] Run /sbin/init as init process
[    4.078422] EXT4-fs (sda): re-mounted. Opts: (null)
[    4.079694] ext4 filesystem being remounted at / supports timestamps until 2038 (0x7fffffff)
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Initializing random number generator: OK
Saving random seed: [    5.344011] random: crng init done
OK
Starting network: OK

Welcome to Buildroot_Linux
Bhaskar_Thinkpad_x250 login: root
# uname -a
Linux Bhaskar_Thinkpad_x250 5.9.0-rc4-Gentoo #1 SMP Mon Sep 7 06:56:51 IST 2020 x86_64 GNU/Linux

Thanks,
Bhaskar






>
>Adrian Hunter (1):
>      mmc: sdhci-pci: Fix SDHCI_RESET_ALL for CQHCI for Intel
>GLK-based controllers
>
>Adrien Crivelli (1):
>      ALSA: hda/realtek: Add quirk for Samsung Galaxy Book Ion NT950XCJ-X716A
>
>Al Grant (3):
>      perf cs-etm: Fix corrupt data after perf inject from
>      perf intel-pt: Fix corrupt data after perf inject from
>      perf tools: Correct SNOOPX field offset
>
>Al Viro (1):
>      fix regression in "epoll: Keep a reference on files added to the
>check list"
>
>Alexander A. Klimov (1):
>      auxdisplay: Replace HTTP links with HTTPS ones
>
>Alistair Popple (2):
>      mm/migrate: fixup setting UFFD_WP flag
>      mm/rmap: fixup copying of soft dirty and uffd ptes
>
>Allen Pais (10):
>      ALSA: core: convert tasklets to use new tasklet_setup() API
>      ALSA: firewire: convert tasklets to use new tasklet_setup() API
>      ALSA: pci/asihpi: convert tasklets to use new tasklet_setup() API
>      ALSA: riptide: convert tasklets to use new tasklet_setup() API
>      ALSA: hdsp: convert tasklets to use new tasklet_setup() API
>      ASoC: fsl_esai: convert tasklets to use new tasklet_setup() API
>      ASoC: siu: convert tasklets to use new tasklet_setup() API
>      ASoC: txx9: convert tasklets to use new tasklet_setup() API
>      ALSA: usb-audio: convert tasklets to use new tasklet_setup() API
>      ALSA: ua101: convert tasklets to use new tasklet_setup() API
>
>Amar Singhal (1):
>      cfg80211: Adjust 6 GHz frequency to channel conversion
>
>Andy Lutomirski (2):
>      selftests/x86/test_vsyscall: Improve the process_vm_readv() test
>      x86/debug: Allow a single level of #DB recursion
>
>Arnaldo Carvalho de Melo (3):
>      perf symbols: Add mwait_idle_with_hints.constprop.0 to the list
>of idle symbols
>      perf top/report: Fix infinite loop in the TUI for grouped events
>      perf parse-events: Use uintptr_t when casting numbers to pointers
>
>Arvind Sankar (1):
>      x86/cmdline: Disable jump tables for cmdline.c
>
>Barret Rhoden (1):
>      init: fix error check in clean_path()
>
>Ben Skeggs (3):
>      drm/nouveau/kms/nv50-: add some whitespace before debug message
>      drm/nouveau/kms/nv50-gp1xx: disable notifies again after core update
>      drm/nouveau/kms/nv50-gp1xx: add WAR for EVO push buffer HW bug
>
>Brandon Jiang (1):
>      Documentation: fix typo for abituguru documentation
>
>Brian Foster (2):
>      xfs: finish dfops on every insert range shift iteration
>      xfs: fix off-by-one in inode alloc block reservation calculation
>
>Chris Wilson (2):
>      perf tools: Use %zd for size_t printf formats on 32-bit
>      iommu/vt-d: Handle 36bit addressing for x86-32
>
>Christoph Hellwig (1):
>      block: fix locking in bdev_del_partition
>
>Christophe JAILLET (2):
>      media: mceusb: Avoid GFP_ATOMIC where it is not needed
>      nvmet-fc: Fix a missed _irqsave version of spin_lock in
>'nvmet_fc_fod_op_done()'
>
>Cong Wang (1):
>      net_sched: fix error path in red_init()
>
>Damien Le Moal (1):
>      dm crypt: Initialize crypto wait structures
>
>Dan Carpenter (2):
>      scsi: libcxgbi: Fix a use after free in cxgbi_conn_xmit_pdu()
>      net: gemini: Fix another missing clk_disable_unprepare() in probe
>
>Dan Crawford (1):
>      ALSA: hda - Fix silent audio output and corrupted input on MSI X570-A PRO
>
>Dan Murphy (1):
>      net: dp83867: Fix WoL SecureOn password
>
>Daniel Gorsulowski (1):
>      net: dp83869: Fix RGMII internal delay configuration
>
>Darrick J. Wong (2):
>      xfs: initialize the shortform attr header padding entry
>      xfs: fix xfs_bmap_validate_extent_raw when checking attr fork of rt files
>
>Dave Hansen (1):
>      mm: fix pin vs. gup mismatch with gate pages
>
>Dave Jiang (1):
>      dmaengine: idxd: reset states after device disable or reset
>
>David Ahern (1):
>      perf sched timehist: Fix use of CPU list with summary option
>
>David Howells (8):
>      rxrpc: Keep the ACK serial in a var in rxrpc_input_ack()
>      rxrpc: Fix loss of RTT samples due to interposed ACK
>      rxrpc: Make rxrpc_kernel_get_srtt() indicate validity
>      afs: Remove afs_vlserver->probe.have_result
>      afs: Expose information from afs_vlserver through /proc for debugging
>      afs: Don't use VL probe running state to make decisions outside probe code
>      afs: Fix error handling in VL server rotation
>      mm/khugepaged.c: fix khugepaged's request size in collapse_file
>
>Denis Efremov (2):
>      net: bcmgenet: fix mask check in bcmgenet_validate_flow()
>      kconfig: remove redundant assignment prompt = prompt
>
>Dinghao Liu (7):
>      net: hns: Fix memleak in hns_nic_dev_probe
>      net: systemport: Fix memleak in bcm_sysport_probe
>      NFC: st95hf: Fix memleak in st95hf_in_send_cmd
>      net: arc_emac: Fix memleak in arc_mdio_probe
>      firestream: Fix memleak in fs_open
>      rxrpc: Fix memory leak in rxkad_verify_response()
>      HID: elan: Fix memleak in elan_input_configured
>
>Dmitry Osipenko (1):
>      thermal: core: Fix use-after-free in thermal_zone_device_unregister()
>
>Edward Cree (1):
>      sfc: fix boolreturn.cocci warning and rename function
>
>Edwin Peer (2):
>      bnxt_en: fix HWRM error when querying VF temperature
>      bnxt_en: init RSS table for Minimal-Static VF reservation
>
>Eric Farman (1):
>      s390: fix GENERIC_LOCKBREAK dependency typo in Kconfig
>
>Eric Sandeen (1):
>      xfs: fix boundary test in xfs_attr_shortform_verify
>
>Eugeniu Rosca (1):
>      mm: slub: fix conversion of freelist_corrupted()
>
>Evan Quan (1):
>      drm/amd/pm: avoid false alarm due to confusing
>softwareshutdowntemp setting
>
>Evgeniy Didin (1):
>      ARC: [plat-hsdk]: Switch ethernet phy-mode to rgmii-id
>
>Ezequiel Garcia (1):
>      media: cedrus: Add missing v4l2_ctrl_request_hdl_put()
>
>Fabian Frederick (5):
>      selftests: netfilter: fix header example
>      selftests: netfilter: exit on invalid parameters
>      selftests: netfilter: remove unused variable in make_file()
>      selftests: netfilter: simplify command testing
>      selftests: netfilter: add command usage
>
>Felix Fietkau (4):
>      mac80211: use rate provided via status->rate on
>ieee80211_tx_status_ext for AQL
>      mac80211: factor out code to look up the average packet length
>duration for a rate
>      mac80211: improve AQL aggregation estimation for low data rates
>      mac80211: reduce packet loss event false positives
>
>Florian Fainelli (8):
>      MIPS: mm: BMIPS5000 has inclusive physical caches
>      MIPS: BMIPS: Also call bmips_cpu_setup() for secondary cores
>      MAINTAINERS: GENET: Add missing platform data file
>      MAINTAINERS: B53: Add DT binding file
>      MAINTAINERS: GENET: Add DT binding file
>      MAINTAINERS: GENET: Add UniMAC MDIO controller files
>      MAINTAINERS: Add entry for Broadcom Ethernet PHY drivers
>      MAINTAINERS: Remove self from PHY LIBRARY
>
>Florian Westphal (4):
>      netfilter: conntrack: allow sctp hearbeat after connection re-use
>      netfilter: nf_tables: fix destination register zeroing
>      mptcp: free acked data before waiting for more memory
>      netfilter: conntrack: do not auto-delete clash entries on reply
>
>Francisco Jerez (1):
>      cpufreq: intel_pstate: Fix intel_pstate_get_hwp_max() for turbo disabled
>
>František Kučera (1):
>      ALSA: usb-audio: Add basic capture support for Pioneer DJ DJM-250MK2
>
>Grygorii Strashko (1):
>      net: ethernet: ti: am65-cpsw: fix rmii 100Mbit link mode
>
>Gustavo Pimentel (1):
>      dmaengine: dw-edma: Fix scatter-gather address calculation
>
>Hanjun Guo (1):
>      dmaengine: acpi: Put the CSRT table after using it
>
>Hans Verkuil (1):
>      media: vicodec: add missing v4l2_ctrl_request_hdl_put()
>
>He Zhe (1):
>      mips/oprofile: Fix fallthrough placement
>
>Heiko Carstens (1):
>      s390: update defconfigs
>
>Herbert Xu (1):
>      net: Get rid of consume_skb when tracing is off
>
>Himadri Pandya (1):
>      net: usb: Fix uninit-was-stored issue in asix_read_phy_addr()
>
>Huang Pei (1):
>      MIPS: add missing MSACSR and upper MSA initialization
>
>Huang Ying (1):
>      x86, fakenuma: Fix invalid starting node ID
>
>Ian Rogers (1):
>      perf parse-events: Avoid an uninitialized read when using fake PMUs
>
>Ido Schimmel (2):
>      ipv4: Silence suspicious RCU usage warning
>      ipv6: Fix sysctl max for fib_multipath_hash_policy
>
>Jacopo Mondi (1):
>      media: i2c: imx214: select V4L2_FWNODE
>
>Jakub Kicinski (2):
>      net: disable netpoll on fresh napis
>      bnxt: don't enable NAPI until rings are ready
>
>Jason Gunthorpe (1):
>      include/linux/log2.h: add missing () around n in roundup_pow_of_two()
>
>Jens Axboe (3):
>      block: ensure bdi->io_pages is always initialized
>      io_uring: no read/write-retry on -EAGAIN error and O_NONBLOCK marked file
>      io_uring: fix explicit async read/write mapping for large segments
>
>Jesper Dangaard Brouer (2):
>      selftests/bpf: Fix test_progs-flavor run getting number of tests
>      selftests/bpf: Fix massive output from test_maps
>
>Jessica Yu (1):
>      arm64/module: set trampoline section flags regardless of
>CONFIG_DYNAMIC_FTRACE
>
>Jiansong Chen (1):
>      drm/amd/pm: enable MP0 DPM for sienna_cichlid
>
>Jiaxun Yang (1):
>      MIPS: Loongson64: Do not override watch and ejtag feature
>
>Jin Yao (2):
>      perf parse-events: Set exclude_guest=1 for user-space counting
>      perf stat: Turn off summary for interval mode by default
>
>Jiri Olsa (2):
>      perf report: Disable ordered_events for raw dump
>      perf tools: Add bpf image check to __map__is_kmodule
>
>Jiufei Xue (2):
>      io_uring: fix removing the wrong file in __io_sqe_files_update()
>      io_uring: set table->files[i] to NULL when io_sqe_file_register failed
>
>Joerg Roedel (4):
>      x86/mm/32: Bring back vmalloc faulting on x86_32
>      iommu/amd: Do not force direct mapping when SME is active
>      iommu/amd: Do not use IOMMUv2 functionality when SME is active
>      mm: track page table modifications in __apply_to_page_range()
>
>Johannes Berg (2):
>      nl80211: fix NL80211_ATTR_HE_6GHZ_CAPABILITY usage
>      cfg80211: regulatory: reject invalid hints
>
>Josef Bacik (5):
>      btrfs: drop path before adding new uuid tree entry
>      btrfs: fix potential deadlock in the search ioctl
>      btrfs: allocate scrub workqueues outside of locks
>      btrfs: set the correct lockdep class for new nodes
>      btrfs: set the lockdep class for log tree extent buffers
>
>Joshua Sivec (1):
>      ALSA: usb-audio: Add implicit feedback quirk for UR22C
>
>Jussi Kivilinna (1):
>      batman-adv: bla: use netif_rx_ni when not in interrupt context
>
>Kai Vehmanen (1):
>      ALSA: hda/hdmi: always check pin power status in i915 pin fixup
>
>Kai-Heng Feng (2):
>      ALSA: usb-audio: Disable autosuspend for Lenovo ThinkStation P620
>      drm/radeon: Prefer lower feedback dividers
>
>Kamil Lorenc (1):
>      net: usb: dm9601: Add USB ID of Keenetic Plus DSL
>
>Karsten Graul (1):
>      net/smc: fix toleration of fake add_link messages
>
>Kees Cook (1):
>      docs: Fix function name trailing double-()s
>
>Keith Busch (2):
>      nvme: fix controller instance leak
>      nvme: only use power of two io boundaries
>
>Kevin Wang (1):
>      drm/amd/pm: fix is_dpm_running() run error on 32bit system
>
>Kim Phillips (1):
>      perf record/stat: Explicitly call out event modifiers in the documentation
>
>Kurt Kanzenbach (1):
>      dt-bindings: net: dsa: Fix typo
>
>Landen Chao (1):
>      net: dsa: mt7530: fix advertising unsupported 1000baseT_Half
>
>Laurent Pinchart (1):
>      media: ti-vpe: cal: Fix compilation on 32-bit ARM
>
>Leesoo Ahn (1):
>      pktgen: fix error message with wrong function name
>
>Leon Romanovsky (1):
>      gcov: Disable gcov build with GCC 10
>
>Li Xinhai (1):
>      mm/hugetlb: try preferred node first when alloc gigantic page from cma
>
>Linus Lüssing (1):
>      batman-adv: Fix own OGM check in aggregated OGMs
>
>Linus Torvalds (2):
>      mm: do_wp_page() simplification
>      Linux 5.9-rc4
>
>Louis Peens (1):
>      nfp: flower: fix ABI mismatch between driver and firmware
>
>Lu Baolu (2):
>      iommu/vt-d: Serialize IOMMU GCMD register modifications
>      iommu/vt-d: Fix NULL pointer dereference in dev_iommu_priv_set()
>
>Luc Van Oostenryck (3):
>      Compiler Attributes: remove comment about sparse not supporting
>__has_attribute
>      Compiler Attributes: fix comment concerning GCC 4.6
>      sparse: use static inline for __chk_{user,io}_ptr()
>
>Lukas Bulwahn (3):
>      MAINTAINERS: mention documentation maintainer entry profile
>      Documentation: add riscv entry in list of existing profiles
>      MAINTAINERS: Update QUALCOMM IOMMU after Arm SMMU drivers move
>
>Lyude Paul (1):
>      drm/nouveau/kms/gv100-: Include correct push header in crcc37d.c
>
>Madhuparna Bhowmik (1):
>      drivers/dma/dma-jz4780: Fix race condition between probe and irq handler
>
>Marc Zyngier (2):
>      HID: core: Correctly handle ReportSize being zero
>      HID: core: Sanitize event code and type when mapping input
>
>Marcos Paulo de Souza (1):
>      btrfs: block-group: fix free-space bitmap threshold
>
>Marek Szyprowski (1):
>      dmaengine: pl330: Fix burst length if burst size is smaller than bus width
>
>Marta Rybczynska (1):
>      Documentation/locking/locktypes: fix local_locks documentation
>
>Mathieu Poirier (1):
>      MAINTAINERS: Add entries for CoreSight and Arm SPE tooling
>
>Max Staudt (1):
>      affs: fix basic permission bits to actually work
>
>Miaohe Lin (1):
>      net: Fix some comments
>
>Michael Chan (4):
>      bnxt_en: Fix ethtool -S statitics with XDP or TCs enabled.
>      bnxt_en: Fix possible crash in bnxt_fw_reset_task().
>      bnxt_en: Setup default RSS map in all scenarios.
>      tg3: Fix soft lockup when tg3_reset_task() fails.
>
>Michal Hocko (1):
>      memcg: fix use-after-free in uncharge_batch
>
>Michal Simek (1):
>      dt-bindings: mmc: Add missing description for clk_in/out_sd1
>
>Miguel Ojeda (1):
>      clang-format: Update with the latest for_each macro list
>
>Mike Rapoport (1):
>      arc: fix memory initialization for systems with two memory banks
>
>Mike Snitzer (1):
>      dm mpath: fix racey management of PG initialization
>
>Mikulas Patocka (4):
>      dm writecache: handle DAX to partitions on persistent memory correctly
>      dm integrity: fix error reporting in bitmap mode after creation
>      ext2: don't update mtime on COW faults
>      xfs: don't update mtime on COW faults
>
>Ming Lei (2):
>      block: release disk reference in hd_struct_free_work
>      block: allow for_each_bvec to support zero len bvec
>
>Mingming Cao (1):
>      ibmvnic fix NULL tx_pools and rx_tools issue at do_reset
>
>Mohan Kumar (2):
>      ALSA: hda: Fix 2 channel swapping for Tegra
>      ALSA: hda/tegra: Program WAKEEN register for Tegra
>
>Mrinal Pandey (1):
>      checkpatch: fix the usage of capture group ( ... )
>
>Muchun Song (1):
>      mm/hugetlb: fix a race between hugetlb sysctl handlers
>
>Murali Karicheri (3):
>      net: ethernet: ti: cpsw: fix clean up of vlan mc entries for host port
>      net: ethernet: ti: cpsw_new: fix clean up of vlan mc entries for host port
>      net: ethernet: ti: cpsw_new: fix error handling in
>cpsw_ndo_vlan_rx_kill_vid()
>
>Namhyung Kim (1):
>      perf jevents: Fix suspicious code in fixregex()
>
>Nathan Chancellor (3):
>      net: dsa: sja1105: Do not use address of compatible member in
>sja1105_check_device_id
>      Documentation/llvm: Improve formatting of commands, variables,
>and arguments
>      drm/i915/display: Ensure that ret is always initialized in
>icl_combo_phy_verify_state
>
>Nicholas Miell (1):
>      HID: microsoft: Add rumble support for the 8bitdo SN30 Pro+ controller
>
>Nick Desaulniers (1):
>      MAINTAINERS: add LLVM maintainers
>
>Nicolas Dichtel (1):
>      gtp: add GTPA_LINK info to msg sent to userspace
>
>Niklas Cassel (1):
>      scsi: scsi_debug: Remove superfluous close zone in resp_open_zone()
>
>Nirenjan Krishnan (1):
>      HID: quirks: Set INCREMENT_USAGE_ON_DUPLICATE for all Saitek X52 devices
>
>Or Cohen (1):
>      net/packet: fix overflow in tpacket_rcv
>
>Pablo Neira Ayuso (3):
>      netfilter: nf_tables: add NFTA_SET_USERDATA if not null
>      netfilter: nf_tables: incorrect enum nft_list_attributes definition
>      netfilter: nfnetlink: nfnetlink_unicast() reports EAGAIN instead
>of ENOBUFS
>
>Paul Barker (1):
>      doc: net: dsa: Fix typo in config code sample
>
>Paul Moore (1):
>      netlabel: fix problems with mapping removal
>
>Pavan Chebbi (1):
>      bnxt_en: Don't query FW when netif_running() is false.
>
>Pavel Begunkov (2):
>      io_uring: fix cancel of deferred reqs with ->files
>      io_uring: fix linked deferred ->files cancellation
>
>Peilin Ye (1):
>      media: media/v4l2-core: Fix kernel-infoleak in video_put_user()
>
>Peter Ujfalusi (3):
>      dmaengine: of-dma: Fix of_dma_router_xlate's of_dma_xlate handling
>      dmaengine: ti: k3-udma: Fix the TR initialization for prep_slave_sg
>      dmaengine: ti: k3-udma: Update rchan_oes_offset for am654 SYSFW ABI 3.0
>
>Peter Xu (3):
>      mm/ksm: Remove reuse_ksm_page()
>      mm/gup: Remove enfornced COW mechanism
>      mm: Add PGREUSE counter
>
>Peter Zijlstra (1):
>      x86/entry: Fix AC assertion
>
>Pierre-Louis Bossart (2):
>      ALSA: hda: add dev_dbg log when driver is not selected
>      ALSA: hda: use consistent HDAudio spelling in comments/docs
>
>Potnuri Bharat Teja (1):
>      cxgb4: fix thermal zone device registration
>
>Puranjay Mohan (2):
>      IIO: Documentation: Replace deprecated :c:func: Usage
>      Fpga: Documentation: Replace deprecated :c:func: Usage
>
>Qu Wenruo (1):
>      btrfs: tree-checker: fix the error message for transid error
>
>Rafael J. Wysocki (5):
>      cpufreq: intel_pstate: Refuse to turn off with HWP enabled
>      cpufreq: intel_pstate: Update cached EPP in the active mode
>      cpufreq: intel_pstate: Tweak the EPP sysfs interface
>      cpufreq: intel_pstate: Add ->offline and ->online callbacks
>      cpufreq: intel_pstate: Free memory only when turning off
>
>Ralph Campbell (2):
>      mm/migrate: remove unnecessary is_zone_device_page() check
>      mm/migrate: preserve soft dirty in remove_migration_pte()
>
>Rander Wang (2):
>      ALSA: hda: hdmi - add Rocketlake support
>      ALSA: hda: fix a runtime pm issue in SOF when integrated GPU is disabled
>
>Randy Dunlap (9):
>      ARC: pgalloc.h: delete a duplicated word + other fixes
>      Documentation: sound/cards: fix heading underline lengths for
>https: changes
>      Documentation: laptops: thinkpad-acpi: fix underline length build warning
>      netfilter: delete repeated words
>      microblaze: fix min_low_pfn/max_low_pfn build errors
>      ia64: fix min_low_pfn/max_low_pfn build errors
>      kconfig: streamline_config.pl: check defined(ENV variable) before using it
>      kbuild: Documentation: clean up makefiles.rst
>      MAINTAINERS: IA64: mark Status as Odd Fixes only
>
>Raul E Rangel (1):
>      mmc: sdhci-acpi: Fix HS400 tuning for AMDI0040
>
>Robert Richter (1):
>      MAINTAINERS: update Cavium/Marvell entries
>
>Roger Pau Monne (3):
>      xen/balloon: add header guard
>      memremap: rename MEMORY_DEVICE_DEVDAX to MEMORY_DEVICE_GENERIC
>      xen: add helpers to allocate unpopulated memory
>
>Sagi Grimberg (9):
>      nvme-fabrics: don't check state NVME_CTRL_NEW for request acceptance
>      nvme: have nvme_wait_freeze_timeout return if it timed out
>      nvme-tcp: serialize controller teardown sequences
>      nvme-tcp: fix timeout handler
>      nvme-tcp: fix reset hang if controller died in the middle of a reset
>      nvme-rdma: serialize controller teardown sequences
>      nvme-rdma: fix timeout handler
>      nvme-rdma: fix reset hang if controller died in the middle of a reset
>      nvme: Fix NULL dereference for pci nvme controllers
>
>Sakari Ailus (1):
>      media: max9286: Depend on OF_GPIO
>
>Sandeep Raghuraman (2):
>      drm/amdgpu: Specify get_argument function for ci_smu_funcs
>      drm/amdgpu: Fix bug in reporting voltage for CIK
>
>Sean Paul (2):
>      drm/i915: Fix sha_text population code
>      drm/i915: Clear the repeater bit on HDCP disable
>
>Sean Young (3):
>      media: rc: uevent sysfs file races with rc_unregister_device()
>      media: rc: do not access device via sysfs after rc_unregister_device()
>      media: gpio-ir-tx: spinlock is not needed to disable interrupts
>
>Shannon Nelson (1):
>      ionic: fix txrx work accounting
>
>Shay Bar (1):
>      wireless: fix wrong 160/80+80 MHz setting
>
>Shung-Hsi Yu (1):
>      net: ethernet: mlx4: Fix memory allocation in mlx4_buddy_init()
>
>Shyam Sundar S K (1):
>      amd-xgbe: Add support for new port mode
>
>Sowjanya Komatineni (7):
>      sdhci: tegra: Remove SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK for Tegra210
>      sdhci: tegra: Remove SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK for Tegra186
>      dt-bindings: mmc: tegra: Add tmclk for Tegra210 and later
>      arm64: tegra: Add missing timeout clock to Tegra210 SDMMC
>      arm64: tegra: Add missing timeout clock to Tegra186 SDMMC nodes
>      arm64: tegra: Add missing timeout clock to Tegra194 SDMMC nodes
>      sdhci: tegra: Add missing TMCLK for data timeout
>
>Stefano Brivio (2):
>      netfilter: nft_set_rbtree: Handle outcomes of tree rotations in
>overlap detection
>      netfilter: nft_set_rbtree: Detect partial overlap with start
>endpoint match
>
>Sudeep Holla (1):
>      arm64: Remove exporting cpu_logical_map symbol
>
>Sumanth Korikkar (1):
>      perf test: Fix basic bpf filtering test
>
>Sumera Priyadarsini (2):
>      net: ocelot: Add of_node_put() before return statement
>      net: dsa: mt7530: Add of_node_put() before break and return statements
>
>Suravee Suthikulpanit (2):
>      iommu/amd: Restore IRTE.RemapEn bit after programming IRTE
>      iommu/amd: Use cmpxchg_double() when updating 128-bit IRTE
>
>Sven Eckelmann (1):
>      batman-adv: Avoid uninitialized chaddr when handling DHCP
>
>Takashi Iwai (2):
>      ALSA: pcm: oss: Remove superfluous WARN_ON() for mulaw sanity check
>      ALSA: hda/realtek - Improved routing for Thinkpad X1 7th/8th Gen
>
>Takashi Sakamoto (2):
>      ALSA; firewire-tascam: exclude Tascam FE-8 from detection
>      ALSA: firewire-digi00x: exclude Avid Adrenaline from detection
>
>Tejun Heo (3):
>      blk-iocost: ioc_pd_free() shouldn't assume irq disabled
>      blk-stat: make q->stats->lock irqsafe
>      libata: implement ATA_HORKAGE_MAX_TRIM_128M and apply to Sandisks
>
>Tetsuo Handa (1):
>      tipc: fix shutdown() of connectionless socket
>
>Theodore Dubois (1):
>      devices.txt: fix typo of "ubd" as "udb"
>
>Thomas Bogendoerfer (1):
>      MIPS: SNI: Fix SCSI interrupt
>
>Thomas Gleixner (1):
>      x86/entry: Unbreak 32bit fast syscall
>
>Thomas Richter (2):
>      perf test: Set NULL sentinel in pmu_events table in "Parse and
>process metrics" test
>      perf stat: Fix out of bounds array access in the
>print_counters() evlist method
>
>Tiezhu Yang (3):
>      perf top: Skip side-band event setup if HAVE_LIBBPF_SUPPORT is not set
>      Revert "ALSA: hda: Add support for Loongson 7A1000 controller"
>      MIPS: perf: Fix wrong check condition of Loongson event IDs
>
>Tobias Klauser (4):
>      ipv6: ndisc: adjust ndisc_ifinfo_sysctl_change prototype
>      bpf, sysctl: Let bpf_stats_handler take a kernel pointer buffer
>      ipc: adjust proc_ipc_sem_dointvec definition to match prototype
>      fork: adjust sysctl_max_threads definition to match prototype
>
>Tong Zhang (3):
>      ALSA: ca0106: fix error code handling
>      net: caif: fix error code handling
>      nvme-pci: cancel nvme device request before disabling
>
>Tony Lindgren (1):
>      thermal: ti-soc-thermal: Fix bogus thermal shutdowns for omap4430
>
>Tuong Lien (1):
>      tipc: fix using smp_processor_id() in preemptible
>
>Tzvetomir Stoyanov (VMware) (1):
>      libtraceevent: Fix build warning on 32-bit arches
>
>Ursula Braun (3):
>      net/smc: set rx_off for SMCR explicitly
>      net/smc: reset sndbuf_desc if freed
>      net/smc: fix sock refcounting in case of termination
>
>Vamshi K Sthambamkadi (1):
>      tracing/kprobes, x86/ptrace: Fix regs argument order for i386
>
>Vasundhara Volam (2):
>      bnxt_en: Check for zero dir entries in NVRAM.
>      bnxt_en: Fix PCI AER error recovery flow
>
>Veera Vegivada (1):
>      thermal: qcom-spmi-temp-alarm: Don't suppress negative temp
>
>Vineet Gupta (4):
>      ARC: perf: don't bail setup if pct irq missing in device-tree
>      ARC: HSDK: wireup perf irq
>      ARC: show_regs: fix r12 printing and simplify
>      irqchip/eznps: Fix build error for !ARC700 builds
>
>Vinicius Costa Gomes (1):
>      taprio: Fix using wrong queues in gate mask
>
>Viresh Kumar (1):
>      opp: Don't drop reference for an OPP table that was never parsed
>
>WANG Xuerui (1):
>      MIPS: Loongson64: Remove unnecessary inclusion of boot_param.h
>
>Wei Li (2):
>      perf: arm-spe: Fix check error when synthesizing events
>      perf record: Correct the help info of option "--no-bpf-event"
>
>Wenbin Mei (3):
>      mmc: dt-bindings: Add resets/reset-names for Mediatek MMC bindings
>      mmc: mediatek: add optional module reset property
>      arm64: dts: mt7622: add reset node for mmc device
>
>Xie He (4):
>      drivers/net/wan/lapbether: Added needed_tailroom
>      drivers/net/wan/lapbether: Set network_header before transmitting
>      drivers/net/wan/hdlc_cisco: Add hard_header_len
>      drivers/net/wan/hdlc: Change the default of hard_header_len to 0
>
>Xin Long (1):
>      sctp: not disable bh in the whole sctp_get_port_local()
>
>Xu Wang (1):
>      ata: ahci: use ata_link_info() instead of ata_link_printk()
>
>Xunlei Pang (1):
>      mm: memcg: fix memcg reclaim soft lockup
>
>Yang Shi (1):
>      mm: madvise: fix vma user-after-free
>
>Ye Bin (4):
>      scsi: qedf: Fix null ptr reference in qedf_stag_change_work
>      dm cache metadata: Avoid returning cmd->bm wild pointer on error
>      dm thin metadata:  Avoid returning cmd->bm wild pointer on error
>      dm thin metadata: Fix use-after-free in dm_bm_set_read_only
>
>Yi Li (1):
>      net: hns3: Fix for geneve tx checksum bug
>
>Yonghong Song (1):
>      bpf: Fix a buffer out-of-bound access when filling raw_tp link_info
>
>Yu Kuai (3):
>      dmaengine: at_hdmac: check return value of
>of_find_device_by_node() in at_dma_xlate()
>      dmaengine: at_hdmac: add missing put_device() call in at_dma_xlate()
>      dmaengine: at_hdmac: add missing kfree() call in at_dma_xlate()
>
>YueHaibing (2):
>      net: cdc_ncm: Fix build error
>      perf bench: The do_run_multi_threaded() function must use
>IS_ERR(perf_session__new())
>
>Yunsheng Lin (1):
>      vhost: fix typo in error message
>
>Yuusuke Ashizuka (1):
>      ravb: Fixed to be able to unload modules
>
>Ziye Yang (1):
>      nvmet-tcp: Fix NULL dereference when a connect data comes in h2cdata pdu
>
>zhudi (1):
>      netlink: fix a data race in netlink_rcv_wake()
