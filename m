Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4499AC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 23:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1692206F0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 23:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594598180;
	bh=UcYic01l4YWd8Ju7IzdTb88Q+WAMqgtQo/E6z6eIZwI=;
	h=From:Date:Subject:To:List-ID:From;
	b=kFJlUoO3kn8uxwb5NwY58ajRrnNSTpouvDgAXaiqF4py3LiCRs/qyjgT4js5+vLhY
	 mSm1dFVTzQ/1Os00zzbzAmDTp5Xig/3VTRL4K/y+kGMJMveHAqUFy0kh/f1+C9rHM/
	 35jYrzYteIKJql+Ovpgk0zyRFxgG+CLWCIP44Cu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgGLXzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 19:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbgGLXzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 19:55:37 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D1AC061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 16:55:36 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h22so13786046lji.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 16:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=JFh9zzAofG8Vm9S6o+DPp/fY5z0QOvlyu6uFuo/I72k=;
        b=g71r4WZBdrS8vL6J7EZgI4G4414MLDFsjhVG6NeE0HLTn0wxuMKLv/fvyH8hYwp1rj
         66G/d0BQpxOKY85StOs0XYRFHgbsSm2WFn/gbm9VyZWtsD7WlhfC71mZmQkDRHhpzpxY
         HQ77GjEhIYYIjCHKWScgiYlcD5a4RqUbDMA5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=JFh9zzAofG8Vm9S6o+DPp/fY5z0QOvlyu6uFuo/I72k=;
        b=RA8KKzNNvASZ4/JZd8LsBWj076X/KoQ3YrHvD0MHUedCbaVc6d1NBO0TP9Hc4XU44f
         DWtsmkkSPJjbTWAH8WZmZ748QPoCnT3A/2Vx4JNKA2FmL0T+kRLbaaMYQ75Jwg9vpRb8
         1BpiGZHB7CAmB7ZlNzOtr38aNIV/9uHjYKozM3w9gRLQ06XN4CCjgC39ikiyTrlHewzs
         B7q3wElX7JGX5lT6CVWT+8WTFuwzhu7b5fBcPcbgfCUH8QnnXSIFJK7l4BfHh297YvSM
         5PMgy5vMZx38ggiw29DG8GbLR/hKGph1RDfeQZM5nApfq3a1+zPSSptp03pbNcKmfmdV
         vJaA==
X-Gm-Message-State: AOAM5304qWHVj0qTnHyf1JUw2WBJZm7qrAZOoWjsxs8TNxtmCK7G7zkl
        scTRB3wn2n9AV7v+W2OMad4bkZlKjaU=
X-Google-Smtp-Source: ABdhPJyINv2T8FuK/Z5zw/hhEEBqlTaT7TB0Qsp49/f5+PJrIzrtW7GzofKX7ncu6n4/2IKzwyh7ig==
X-Received: by 2002:a05:651c:339:: with SMTP id b25mr46881379ljp.456.1594598134572;
        Sun, 12 Jul 2020 16:55:34 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id m25sm3743066ljj.128.2020.07.12.16.55.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2020 16:55:33 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id x9so3809743ljc.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 16:55:33 -0700 (PDT)
X-Received: by 2002:a2e:999a:: with SMTP id w26mr41832632lji.371.1594598132914;
 Sun, 12 Jul 2020 16:55:32 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Jul 2020 16:55:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgX5+Q_trdMPaaQZmko0Og_eqAYoyMa_8S3ie+1Us6rkw@mail.gmail.com>
Message-ID: <CAHk-=wgX5+Q_trdMPaaQZmko0Og_eqAYoyMa_8S3ie+1Us6rkw@mail.gmail.com>
Subject: Linux 5.8-rc5
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, so rc4 was small, and now a week later, rc5 is large.

It's not _enormous_, but of all the 5.x kernels so far, this is the
rc5 with the most commits. So it's certainly not optimal. It was
actually very quiet the beginning of the week, but things picked up on
Friday. Like they do..

That said, a lot of it is because of the networking fixes that weren't
in rc4, and I'm still not hearing any real panicky sounds from people,
and things on the whole seem to be progressing just fine.

So a large rc5 to go with a large release doesn't sound all that
worrisome, when we had an unusually small rc4 that precedes it and
explains it.

Maybe I'm in denial, but I still think we might hit the usual release
schedule. A few more weeks to go before I need to make that decision,
so it won't be keeping me up at night.

The diffstat for rc5 doesn't look particularly worrisome either. Yes,
there's a (relatively) high number of commits, but they tend to be
small. Nothing makes me go "umm".

In addition to the outright fixes, there's a few cleanups that are
just prep for 5.9. They all look good and simple too.

Anyway, networking (counting both core and drivers) amounts to about a
third of the patch, with the rest being spread all over: arch updates
(arm64, s390, arc), drivers (gpu, sound, md, pin control, gpio),
tooling (perf and selftests). And misc noise all over.

The appended shortlog gives the details, nothing really looks all that
exciting. Which is just as it should be at this time.

Go forth and test.

Thanks,

                 Linus

---

Aaron Ma (1):
      drm/amd/display: add dmcub check on RENOIR

AceLan Kao (1):
      net: usb: qmi_wwan: add support for Quectel EG95 LTE modem

Adrian Hunter (9):
      perf scripts python: export-to-postgresql.py: Fix struct.pack()
int argument
      perf record: Fix duplicated sideband events with Intel PT system
wide tracing
      perf scripts python: exported-sql-viewer.py: Fix unexpanded 'Find' re=
sult
      perf scripts python: exported-sql-viewer.py: Fix zero id in call
graph 'Find' result
      perf scripts python: exported-sql-viewer.py: Fix zero id in call
tree 'Find' result
      perf scripts python: exported-sql-viewer.py: Fix time chart call tree
      perf intel-pt: Fix recording PEBS-via-PT with registers
      perf intel-pt: Fix displaying PEBS-via-PT with registers
      perf intel-pt: Fix PEBS sample for XMM registers

Alex Elder (6):
      net: ipa: always check for stopped channel
      net: ipa: no checksum offload for SDM845 LAN RX
      net: ipa: introduce ipa_cmd_tag_process()
      net: ipa: fix QMI structure definition bugs
      net: ipa: declare struct types in "ipa_gsi.h"
      net: ipa: include declarations in "ipa_gsi.c"

Alexander Lobakin (1):
      net: qed: fix buffer overflow on ethtool -d

Alexander Tsoy (2):
      ALSA: usb-audio: Fix packet size calculation
      ALSA: usb-audio: Replace s/frame/packet/ where appropriate

Alexandru Elisei (1):
      KVM: arm64: Annotate hyp NMI-related functions as __always_inline

Andre Edich (2):
      smsc95xx: check return value of smsc95xx_reset
      smsc95xx: avoid memory leak in smsc95xx_bind

Andreas Gerstmayr (1):
      perf flamegraph: Explicitly set utf-8 encoding

Andreas Gruenbacher (2):
      fs: Add IOCB_NOIO flag for generic_file_read_iter
      gfs2: Rework read and page fault locking

Andrew Jones (1):
      KVM: arm64: pvtime: Ensure task delay accounting is enabled

Andrew Scull (1):
      KVM: arm64: Stop clobbering x0 for HVC_SOFT_RESTART

Andrii Nakryiko (3):
      libbpf: Forward-declare bpf_stats_type for systems with outdated
UAPI headers
      libbpf: Fix CO-RE relocs against .text section
      bpf: Enforce BPF ringbuf size to be the power of 2

Andy Shevchenko (5):
      gpio: pca953x: Synchronize interrupt handler properly
      gpio: pca953x: Override IRQ for one of the expanders on Galileo Gen 2
      gpio: pca953x: Fix direction setting when configure an IRQ
      gpio: pca953x: disable regmap locking for automatic address increment=
ing
      gpio: pca953x: Fix GPIO resource leak on Intel Galileo Gen 2

Ard Biesheuvel (1):
      arm64/alternatives: don't patch up internal branches

Arnaldo Carvalho de Melo (2):
      tools arch: Update arch/x86/lib/memcpy_64.S copy used in 'perf
bench mem memcpy'
      perf report TUI: Remove needless 'dummy' event from menu

Aya Levin (4):
      IB/mlx5: Fix 50G per lane indication
      net/mlx5e: Fix VXLAN configuration restore after function reload
      net/mlx5e: Fix CPU mapping after function reload to avoid aRFS RX cra=
sh
      net/mlx5e: Fix 50G per lane indication

Ben Skeggs (2):
      drm/nouveau/kms/nv50-: bail from nv50_audio_disable() early if
audio not enabled
      drm/nouveau/i2c/g94-: increase NV_PMGR_DP_AUXCTL_TRANSACTREQ timeout

Benjamin Poirier (1):
      ALSA: hda/realtek - Fix Lenovo Thinkpad X1 Carbon 7th quirk subdevice=
 id

Bernard Zhao (1):
      drm/mediatek: Remove unnecessary conversion to bool

Bob Liu (1):
      scsi: iscsi: Change iSCSI workqueue max_active back to 1

Boris Burkov (1):
      btrfs: fix fatal extent_buffer readahead vs releasepage race

Carl Huang (1):
      net: qrtr: free flow in __qrtr_node_release

Cesar Eduardo Barros (1):
      Restore gcc check in mips asm/unroll.h

Chris Wilson (4):
      drm/i915: Skip stale object handle for debugfs per-file-stats
      drm/i915: Drop vm.ref for duplicate vma on construction
      drm/i915: Also drop vm.ref along error paths for vma construction
      drm/i915/gt: Pin the rings before marking active

Christian Borntraeger (1):
      KVM: s390: reduce number of IO pins to 1

Christoph Hellwig (17):
      dma-mapping: Add a new dma_need_sync API
      xsk: Replace the cheap_dma flag with a dma_need_sync flag
      xsk: Remove a double pool->dev assignment in xp_dma_map
      xsk: Use dma_need_sync instead of reimplenting it
      cachefiles: switch to kernel_write
      autofs: switch to kernel_write
      bpfilter: switch to kernel_write
      fs: unexport __kernel_write
      fs: check FMODE_WRITE in __kernel_write
      fs: implement kernel_write using __kernel_write
      fs: remove __vfs_write
      fs: add a __kernel_read helper
      integrity/ima: switch to using __kernel_read
      fs: implement kernel_read using __kernel_read
      fs: remove __vfs_read
      dm: use bio_uninit instead of bio_disassociate_blkg
      btrfs: wire up iter_file_splice_write

Christoph Paasch (1):
      tcp: make sure listeners don't initialize congestion-control state

Claudiu Manoil (1):
      enetc: Fix tx rings bitmap iteration range, irq handling

Codrin Ciubotariu (1):
      net: dsa: microchip: set the correct number of ports

Cong Wang (6):
      net: get rid of lockdep_set_class_and_subclass()
      net: explain the lockdep annotations for dev_uc_unsync()
      genetlink: get rid of family->attrbuf
      cgroup: fix cgroup_sk_alloc() for sk_clone_lock()
      net_sched: fix a memory leak in atm_tc_init()
      cgroup: Fix sock_cgroup_data on big-endian.

Damien Le Moal (2):
      scsi: mpt3sas: Fix unlock imbalance
      dm zoned: Fix zone reclaim trigger

Dan Carpenter (2):
      net: qrtr: Fix an out of bounds read qrtr_endpoint_post()
      xen/xenbus: Fix a double free in xenbus_map_ring_pv()

Dan Williams (2):
      CodingStyle: Inclusive Terminology
      libnvdimm/security: Fix key lookup permissions

David Ahern (2):
      ipv6: fib6_select_path can not use out path for nexthop objects
      ipv6: Fix use of anycast address with loopback

David Rientjes (1):
      dma-mapping: warn when coherent pool is depleted

Davide Caratti (1):
      bnxt_en: fix NULL dereference in case SR-IOV configuration fails

Divya Indi (1):
      IB/sa: Resolv use-after-free in ib_nl_make_request()

Dmitry Bogdanov (1):
      net: atlantic: fix ip dst and ipv6 address filters

Eli Britstein (1):
      net/mlx5e: CT: Fix memory leak in cleanup

Enric Balletbo i Serra (3):
      drm/mediatek: Remove debug messages for function calls
      drm/mediatek: mtk_mt8173_hdmi_phy: Remove unnused const variables
      drm/mediatek: mtk_hdmi: Remove debug messages for function calls

Eran Ben Elisha (2):
      net/mlx5: Fix eeprom support for SFP module
      net/mlx5e: Fix port buffers cell size value

Eric Dumazet (7):
      llc: make sure applications use ARPHRD_ETHER
      netfilter: ipset: call ip_set_free() instead of kfree()
      tcp: md5: add missing memory barriers in
tcp_md5_do_add()/tcp_md5_hash_key()
      tcp: md5: refine tcp_md5_do_add()/tcp_md5_hash_key() barriers
      tcp: md5: do not send silly options in SYNCOOKIES
      tcp: fix SO_RCVLOWAT possible hangs under high mem pressure
      tcp: md5: allow changing MD5 keys in all socket states

Eugeniy Paltsev (2):
      ARC: build: allow users to specify -mcpu
      ARCv2: support loop buffer (LPB) disabling

Filipe Manana (1):
      btrfs: fix reclaim_size counter leak after stealing from global reser=
ve

Florian Fainelli (1):
      arm64: Add missing sentinel to erratum_1463225

Gavin Shan (2):
      drivers/firmware/psci: Fix memory leakage in alloc_init_cpu_groups()
      drivers/firmware/psci: Assign @err directly in hotplug_tests()

Gerald Schaefer (1):
      MAINTAINERS: update email address for Gerald Schaefer

Hamish Martin (1):
      tipc: fix retransmission on unicast links

Hans de Goede (1):
      pinctrl: baytrail: Fix pin being driven low for a while on
gpiod_get(..., GPIOD_OUT_HIGH)

Hector Martin (1):
      ALSA: usb-audio: add quirk for MacroSilicon MS2109

Heiko Carstens (2):
      s390: update defconfigs
      MAINTAINERS: update email address for Heiko Carstens

Helmut Grohne (1):
      net: dsa: microchip: enable ksz9893 via i2c in the ksz9477 driver

Horatiu Vultur (1):
      bridge: mrp: Fix endian conversion and some other warnings

Hsin-Yi Wang (2):
      drm/mediatek: Fix device passed to cmdq
      drm/mediatek: Check plane visibility in atomic_update

Huacai Chen (1):
      KVM: MIPS: Fix build errors for 32bit kernel

Huang Rui (2):
      drm/amdgpu: asd function needs to be unloaded in suspend phase
      drm/amdgpu: add TMR destory function for psp

Huazhong Tan (3):
      net: hns3: check reset pending after FLR prepare
      net: hns3: fix for mishandle of asserting VF reset fail
      net: hns3: add a missing uninit debugfs when unload driver

Hui Wang (1):
      ALSA: hda - let hs_mic be picked ahead of hp_mic

Ido Schimmel (2):
      mlxsw: spectrum_router: Remove inappropriate usage of WARN_ON()
      mlxsw: pci: Fix use-after-free in case of failed devlink reload

Jacky Hu (1):
      pinctrl: amd: fix npins for uart0 in kerncz_groups

Jakub Bogusz (1):
      libbpf: Fix libbpf hashmap on (I)LP32 architectures

Jakub Sitnicki (5):
      flow_dissector: Pull BPF program assignment up to bpf-netns
      bpf, netns: Keep attached programs in bpf_prog_array
      bpf, netns: Keep a list of attached bpf_link's
      selftests/bpf: Test updating flow_dissector link with same program
      bpf, netns: Fix use-after-free in pernet pre_exit callback

Janosch Frank (1):
      s390/mm: fix huge pte soft dirty copying

Jarkko Sakkinen (1):
      Revert commit e918e570415c ("tpm_tis: Remove the HID IFX0102")

Jaroslav Kysela (1):
      AsoC: amd: add missing snd- module prefix to the acp3x-rn driver
kernel module

Jason A. Donenfeld (8):
      net: ip_tunnel: add header_ops for layer 3 devices
      net: ipip: implement header_ops->parse_protocol for AF_PACKET
      wireguard: implement header_ops->parse_protocol for AF_PACKET
      wireguard: queueing: make use of ip_tunnel_parse_protocol
      tun: implement header_ops->parse_protocol for AF_PACKET
      net: vti: implement header_ops->parse_protocol for AF_PACKET
      net: sit: implement header_ops->parse_protocol for AF_PACKET
      net: xfrmi: implement header_ops->parse_protocol for AF_PACKET

Jens Axboe (1):
      io_uring: account user memory freed when exit has been queued

Jesper Dangaard Brouer (1):
      libbpf: Adjust SEC short cut for expected attach type BPF_XDP_DEVMAP

Jian-Hong Pan (3):
      ALSA: hda/realtek - Enable audio jacks of Acer vCopperbox with ALC269=
VC
      ALSA: hda/realtek: Enable headset mic of Acer C20-820 with ALC269VC
      ALSA: hda/realtek: Enable headset mic of Acer Veriton N4660G with ALC=
269VC

Johannes Thumshirn (1):
      scsi: mpt3sas: Fix error returns in BRM_status_show

John Fastabend (4):
      bpf: Do not allow btf_ctx_access with __int128 types
      bpf, sockmap: RCU splat with redirect and strparser error or TLS
      bpf, sockmap: RCU dereferenced psock may be used outside RCU block
      bpf, sockmap: Add ingres skb tests that utilize merge skbs

Josef Bacik (2):
      btrfs: reset tree root pointer after error in init_tree_roots
      btrfs: fix double put of block group with nocow

Kai Vehmanen (2):
      ALSA: hda/hdmi: fix failures at PCM open on Intel ICL and later
      ALSA: hda/hdmi: improve debug traces for stream lookups

Kaike Wan (2):
      IB/hfi1: Do not destroy hfi1_wq when the device is shut down
      IB/hfi1: Do not destroy link_wq when the device is shut down

Kamal Dasu (1):
      mtd: set master partition panic write flag

Kamal Heib (1):
      RDMA/siw: Fix reporting vendor_part_id

Karsten Graul (2):
      net/smc: separate LLC wait queues for flow and messages
      net/smc: fix work request handling

Kees Cook (6):
      kallsyms: Refactor kallsyms_show_value() to take cred
      module: Refactor section attr into bin attribute
      module: Do not expose section addresses to non-CAP_SYSLOG
      kprobes: Do not expose probe addresses to non-CAP_SYSLOG
      bpf: Check correct cred for CAP_SYSLOG in bpf_dump_raw_ok()
      selftests: kmod: Add module address visibility test

Kevin Hao (1):
      arm64: entry: Fix the typo in the comment of el1_dbg()

Leon Romanovsky (2):
      RDMA/mlx5: Fix legacy IPoIB QP initialization
      RDMA/mlx5: Set PD pointers for the error flow unwind

Li Heng (1):
      net: cxgb4: fix return error value in t4_prep_fw

Linus L=C3=BCssing (1):
      bridge: mcast: Fix MLD2 Report IPv6 payload length check

Linus Torvalds (2):
      Raise gcc version requirement to 4.9
      Linux 5.8-rc5

Lorenz Bauer (7):
      bpf: flow_dissector: Check value of unused flags to BPF_PROG_ATTACH
      bpf: flow_dissector: Check value of unused flags to BPF_PROG_DETACH
      bpf: sockmap: Check value of unused args to BPF_PROG_ATTACH
      bpf: sockmap: Require attach_bpf_fd when detaching a program
      selftests: bpf: Pass program and target_fd in flow_dissector_reattach
      selftests: bpf: Pass program to bpf_prog_detach in flow_dissector
      selftests: bpf: Fix detach from sockmap tests

Luca Coelho (2):
      nl80211: don't return err unconditionally in nl80211_start_ap()
      nl80211: fix memory leak when parsing NL80211_ATTR_HE_BSS_COLOR

Luo bin (2):
      hinic: fix passing non negative value to ERR_PTR
      hinic: fix sending mailbox timeout in aeq event work

Maciej =C5=BBenczykowski (1):
      bpf: Restore behaviour of CAP_SYS_ADMIN allowing the loading of
networking bpf programs

Manivannan Sadhasivam (1):
      mmc: owl-mmc: Get rid of of_match_ptr() macro

Marc Zyngier (6):
      KVM: arm64: vgic-v4: Plug race between non-residency and v4.1 doorbel=
l
      KVM: arm64: PMU: Fix per-CPU access in preemptible context
      arm64: Introduce a way to disable the 32bit vdso
      arm64: arch_timer: Allow an workaround descriptor to disable compat v=
dso
      arm64: arch_timer: Disable the compat vdso for cores affected by
ARM64_WORKAROUND_1418040
      arm64: Rework ARM_ERRATUM_1414080 handling

Marcos Paulo de Souza (1):
      btrfs: convert comments to fallthrough annotations

Marek Ol=C5=A1=C3=A1k (1):
      drm/amdgpu: don't do soft recovery if gpu_recovery=3D0

Marek Szyprowski (1):
      scatterlist: protect parameters of the sg_table related macros

Markus Theil (3):
      mac80211: fix control port tx status check
      mac80211: skip mpath lookup also for control port tx
      mac80211: allow rx of mesh eapol frames with default rx key

Martin Blumenstingl (1):
      drm/meson: viu: fix setting the OSD burst length in
VIU_OSD1_FIFO_CTRL_STAT

Martin KaFai Lau (2):
      bpf: net: Avoid copying sk_user_data of reuseport_array during sk_clo=
ne
      bpf: net: Avoid incorrect bpf_sk_reuseport_detach call

Martin Varghese (1):
      net: Added pointer check for dst->ops->neigh_lookup in
dst_neigh_lookup_skb

Matthias Brugger (1):
      drm/mediatek: Delete not used of_device_get_match_data

Max Filippov (2):
      xtensa: fix __sync_fetch_and_{and,or}_4 declarations
      xtensa: update *pos in cpuinfo_op.next

Miaohe Lin (1):
      net: ipv4: Fix wrong type conversion from hint to rt in
ip_route_use_hint()

Michal Kubecek (1):
      ethtool: fix genlmsg_put() failure handling in ethnl_default_dumpit()

Michal Suchanek (1):
      dm writecache: reject asynchronous pmem devices

Mikulas Patocka (1):
      dm: use noio when sending kobject event

Ming Lei (2):
      blk-mq: consider non-idle request as "inflight" in blk_mq_rq_inflight=
()
      dm: do not use waitqueue for request-based DM

Miquel Raynal (1):
      mtd: rawnand: xway: Fix build issue

Nathan Chancellor (2):
      IB/hfi1: Add explicit cast OPA_MTU_8192 to 'enum ib_mtu'
      mips: Remove compiler check in unroll macro

Navid Emamdoost (2):
      gpio: arizona: handle pm_runtime_get_sync failure case
      gpio: arizona: put pm_runtime in case of failure

Neil Armstrong (1):
      mmc: meson-gx: limit segments to 1 when dram-access-quirk is needed

Nicholas Piggin (1):
      powerpc/64s/exception: Fix 0x1500 interrupt handler crash

Nicolas Ferre (6):
      MAINTAINERS: net: macb: add Claudiu as co-maintainer
      net: macb: fix wakeup test in runtime suspend/resume routines
      net: macb: mark device wake capable when "magic-packet" property pres=
ent
      net: macb: fix macb_get/set_wol() when moving to phylink
      net: macb: fix macb_suspend() by removing call to netif_carrier_off()
      net: macb: fix call to pm_runtime in the suspend/resume functions

Niklas Schnelle (1):
      s390/pci: fix enabling a reserved PCI function

Pablo Neira Ayuso (1):
      netfilter: conntrack: refetch conntrack after nf_conntrack_update()

Paolo Abeni (1):
      mptcp: fix DSS map generation on fin retransmission

Paolo Bonzini (4):
      KVM: x86: bit 8 of non-leaf PDPEs is not reserved
      kvm: use more precise cast and do not drop __user
      kselftest: ksft_test_num return type should be unsigned
      KVM: nVMX: fixes for preemption timer migration

Pavel Begunkov (2):
      io_uring: fix missing msg_name assignment
      io_uring: fix not initialised work->flags

Pavel Hofman (1):
      ALSA: usb-audio: Add implicit feedback quirk for RTX6001

Pavel Machek (1):
      mac80211: simplify mesh code

Pengfei Xu (1):
      selftests: tpm: upgrade TPM2 tests from Python 2 to Python 3

Qu Wenruo (1):
      btrfs: discard: add missing put when grabbing block group from unused=
 list

Quentin Monnet (1):
      bpf: Fix formatting in documentation for BPF helpers

Rahul Lakkireddy (1):
      cxgb4: fix all-mask IP address comparison

Ralph Campbell (2):
      drm/nouveau/svm: fix migrate page regression
      drm/nouveau/nouveau: fix page fault on device private memory

Randy Dunlap (8):
      Documentation: networking: arcnet: drop doubled word
      Documentation: networking: ax25: drop doubled word
      Documentation: networking: can_ucan_protocol: drop doubled words
      Documentation: networking: dsa: drop doubled word
      Documentation: networking: ip-sysctl: drop doubled word
      Documentation: networking: ipvs-sysctl: drop doubled word
      Documentation: networking: rxrpc: drop doubled word
      Documentation: update for gcc 4.9 requirement

Rao Shoaib (1):
      rds: If one path needs re-connection, check all and re-connect

Richard Weinberger (1):
      nandsim: Fix return code testing of ns_find_operation()

Rikard Falkeborn (1):
      kbuild: Move -Wtype-limits to W=3D2

Ronnie Sahlberg (1):
      cifs: fix reference leak for tlink

Russell King (1):
      net: mvneta: fix use of state->speed

Sabrina Dubroca (1):
      ipv4: fill fl4_icmp_{type,code} in ping_v4_sendmsg

Sean Christopherson (4):
      vfio-ccw: Fix a build error due to missing include of linux/slab.h
      KVM: x86: Inject #GP if guest attempts to toggle CR4.LA57 in 64-bit m=
ode
      KVM: x86: Mark CR4.TSD as being possibly owned by the guest
      KVM: VMX: Use KVM_POSSIBLE_CR*_GUEST_BITS to initialize guest/host ma=
sks

Sean Tranchetti (1):
      genetlink: remove genl_bind

Sebastian Andrzej Siewior (1):
      net/mlx5e: Do not include rwlock.h directly

Seevalamuthu Mariappan (1):
      mac80211: Fix dropping broadcast packets in 802.11 encap

Shannon Nelson (2):
      ionic: update the queue count on open
      ionic: centralize queue reset code

Shengjiu Wang (2):
      ASoC: fsl_mqs: Don't check clock is NULL before calling clk API
      ASoC: fsl_mqs: Fix unchecked return value for clk_prepare_enable

Shuming Fan (1):
      ASoC: rt5682: fix the pop noise while OMTP type headset plugin

Steve French (3):
      smb3: fix access denied on change notify request to some servers
      smb3: fix unneeded error message on change notify
      cifs: update internal module version number

Steve Schremmer (1):
      scsi: dh: Add Fujitsu device to devinfo and dh lists

Steven Price (1):
      KVM: arm64: Fix kvm_reset_vcpu() return code being incorrect with SVE

Steven Rostedt (Red Hat) (1):
      tools lib traceevent: Add API to read time information from kbuffer

Sudarsana Reddy Kalluru (1):
      qed: Populate nvm-file attributes while reading nvm config partition.

Suzuki K Poulose (1):
      arm64: Documentation: Fix broken table in generated HTML

Taehee Yoo (3):
      hsr: fix interface leak in error path of hsr_dev_finalize()
      net: rmnet: fix lower interface leak
      net: rmnet: do not allow to add multiple bridge interfaces

Thomas Richter (1):
      s390/cpum_sf: prohibit callchain data collection

Tobias Waldekranz (1):
      net: ethernet: fec: prevent tx starvation under high rx load

Toke H=C3=B8iland-J=C3=B8rgensen (2):
      sched: consistently handle layer3 header accesses in the presence of =
VLANs
      vlan: consolidate VLAN parsing code and limit max parsing depth

Tom Rix (3):
      scsi: scsi_transport_spi: Fix function pointer check
      net: sky2: initialize return of gm_phy_read
      drm/radeon: fix double free

Tom Zanussi (1):
      tools lib traceevent: Add proper KBUFFER_TYPE_TIME_STAMP handling

Ursula Braun (3):
      net/smc: fix sleep bug in smc_pnet_find_roce_resource()
      net/smc: switch smcd_dev_list spinlock to mutex
      net/smc: tolerate future SMCD versions

Vasily Gorbik (2):
      s390/maccess: add no DAT mode to kernel_write
      s390/setup: init jump labels before command line parsing

Veerabhadrarao Badiganti (1):
      mmc: sdhci-msm: Override DLL_CONFIG only if the valid value is suppli=
ed

Veerendranath Jakkam (1):
      ieee80211: Add missing and new AKM suite selector definitions

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915/fbc: Fix fence_y_offset handling

Vincent Chen (5):
      kgdb: enable arch to support XML packet.
      riscv: enable the Kconfig prompt of STRICT_KERNEL_RWX
      riscv: Fix "no previous prototype" compile warning in kgdb.c file
      kgdb: Move the extern declaration kgdb_has_hit_break() to generic kgd=
b.h
      riscv: Avoid kgdb.h including gdb_xml.h to solve
unused-const-variable warning

Vineet Gupta (5):
      ARC: entry: fix potential EFA clobber when TIF_SYSCALL_TRACE
      ARC: [arcompact] fix bitrot with 2 levels of interrupt
      ARC: elf: use right ELF_ARCH
      ARCv2: boot log: detect newer/upconing HS3x/HS4x releases
      ARC: build: remove deprecated toggle for arc700 builds

Vinod Koul (1):
      ALSA: compress: fix partial_drain completion state

Vlad Buslov (2):
      net/mxl5e: Verify that rpriv is not NULL
      net/mlx5e: Fix usage of rcu-protected pointer

Vladimir Oltean (1):
      lib: packing: add documentation for pbuflen argument

Vu Pham (1):
      net/mlx5: E-Switch, Fix vlan or qos setting in legacy mode

Wanpeng Li (1):
      KVM: X86: Fix async pf caused null-ptr-deref

Wei Li (2):
      perf report TUI: Fix segmentation fault in perf_evsel__hists_browse()
      arm64: kgdb: Fix single-step exception handling oops

Wei Yongjun (1):
      dm zoned: fix unused but set variable warnings

Will Deacon (2):
      KVM: arm64: Fix definition of PAGE_HYP_DEVICE
      arm64: entry: Tidy up block comments and label numbers

Willem de Bruijn (1):
      ip: Fix SO_MARK in RST, ACK and ICMP packets

Xiaoguang Wang (1):
      io_uring: export cq overflow status to userspace

Xie He (1):
      drivers/net/wan/lapbether: Fixed the value of hard_header_len

Xin Long (1):
      l2tp: remove skb_dst_set() from l2tp_xmit_skb()

Xu Wang (1):
      xtensa: simplify xtensa_pmu_irq_handler

Yang Yingliang (2):
      io_uring: fix memleak in __io_sqe_files_update()
      io_uring: fix memleak in io_sqe_files_register()

Yonghong Song (3):
      bpf: Set the number of exception entries properly for subprograms
      bpf: Fix an incorrect branch elimination by verifier
      bpf: Add tests for PTR_TO_BTF_ID vs. null comparison

Yonglong Liu (1):
      net: hns3: fix use-after-free when doing self test

YueHaibing (1):
      drm/mediatek: Fix Kconfig warning

Yufen Yu (1):
      docs: block: update and fix tiny error for bfq

Zenghui Yu (1):
      drm/hisilicon/hibmc: Move drm_fbdev_generic_setup() down to
avoid the splat

Zheng Bin (1):
      nbd: Fix memory leak in nbd_add_socket

wenxu (1):
      net/sched: act_ct: add miss tcf_lastuse_update.

xidongwang (1):
      ALSA: opl3: fix infoleak in opl3

yangerkun (1):
      cifs: remove the retry in cifs_poxis_lock_set
