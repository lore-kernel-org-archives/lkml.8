Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E428C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 22:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC02E2065D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 22:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593382239;
	bh=vfB5fQa0FRrMdA2cT3OHWEFytEoFguBE+GVL7BNserQ=;
	h=From:Date:Subject:To:List-ID:From;
	b=A7YOaYvGWLTBzyDzWX8rcEIyI0aF+lgOhV2iH5oIudRafJ+bwZf+ejFS6G4zn/GAC
	 EVm9k/AtPNf11ha6chUT7DicbehZxbk5/ADNB9ewyZDoNVhCi8HFTQg/p6TPYyp3f3
	 EXrm0WFWAVi+oTj89kVIRsoaECT7rQnUm8pdak4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgF1WKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 18:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgF1WKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 18:10:37 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4CFC03E979
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 15:10:36 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id d21so8007803lfb.6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 15:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=vgQf1MG65qyw/jUU0sq12SQn3tj3RE6oOSUL61oihjM=;
        b=EDlexYW9Ok6CKJ+S+e5d9wttw8iwHcYvbq3hrYihRyn5rXLHX9Dzxa0X+MZOCjgYQ2
         E9vYQVLeMbGuJZ384U6y/pkR6vxNxqjClkHzpfoETg4QeleAqoezQcZE1tBfhLzzGTUq
         AR05FJgIwKa39HJxwbW4s2C1s+kqQnNfVDQq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=vgQf1MG65qyw/jUU0sq12SQn3tj3RE6oOSUL61oihjM=;
        b=KNXewuEzhpSHKnhpoqsu9rrf6V9mIQW8HcBsWFSpaB+P8eONH3/du/hFbAcbSj+FCJ
         MrwouEIPbvrnPQMYg1yE6fChgfLTXF8Hbw5JOoI3z9I1pAg3J/FmiJvNKRCmwdn+NE7l
         h5lnExB2lw6h7kX85isq7/l0zeR1T1RYxOdh0ZI7iWfEA2DT2kOdcZ4IGpoEv7Zi9Bzj
         MXUCmaKeYJh2+Sey5UzyertYQ/EibSS3Czs3rM0POLt318VBKWiJAGAv2M3EMXyPpY1Z
         LT8Tyt3BlKA4rrzkO0KvcgFvpHWi99883QznuThRBRgbgHsi1m4IihFcN5kcSmtwZ1rU
         zK3w==
X-Gm-Message-State: AOAM532C5UckQP6g0W0T3n87PLvcymzyg7koBg6KhHmZ79gJQgQ/52jW
        P9YZ/ajUVt1P1J/DthXQIx/7nBpQ0Y4=
X-Google-Smtp-Source: ABdhPJwr9fnx3exBXMVB0mp3+fqIiZemGBQlmaN6jue33fIwQghwR2cla7LGhPvgG48fFBhfdeEvPQ==
X-Received: by 2002:a19:d44:: with SMTP id 65mr7614336lfn.36.1593382233953;
        Sun, 28 Jun 2020 15:10:33 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id n25sm8153993lfe.39.2020.06.28.15.10.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2020 15:10:33 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id f5so55109ljj.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 15:10:33 -0700 (PDT)
X-Received: by 2002:a2e:5c02:: with SMTP id q2mr7087045ljb.285.1593382232165;
 Sun, 28 Jun 2020 15:10:32 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Jun 2020 15:10:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=whNe2Gx=kgK6ucK_Bo0xCXh6g7HLQTHacQqsVZ8G1NPpw@mail.gmail.com>
Message-ID: <CAHk-=whNe2Gx=kgK6ucK_Bo0xCXh6g7HLQTHacQqsVZ8G1NPpw@mail.gmail.com>
Subject: Linux 5.8-rc3
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Well, we had a big merge window, and we have a fairly big rc3 here
too. The calm period for rc2 is clearly over.

That said, I don't think there's anything _particularly_ scary in
here, and the size of this rc is probably simply a direct result of
the fact that 5.8 is a big release. It's too early to say if this will
mean that we'll have a longer rc period as a result, I'll just have to
keep an eye out for how this all progresses.

The stats all look fairly normal: about half is drivers (networking is
a big chunk, but there's really a bit of everything in there: gpu,
sound, usb, you name it).

Outside of drivers, we have the usual suspects: arch updates (x86 and
arm stand out), core networking, but also core kernel and VM updates.
And a fair amount of tooling updates (mostly selftests, but also
objtool and virtio).

Go forth and test,

              Linus

---

Aaron Plattner (1):
      ALSA: hda: Add NVIDIA codec IDs 9a & 9d through a0 to patch table

Adam Ford (2):
      arm64: dts: imx8mm-beacon: Fix voltages on LDO1 and LDO2
      drm/panel-simple: fix connector type for LogicPD Type28 Display

Aditya Pakki (2):
      RDMA/rvt: Fix potential memory leak caused by rvt_alloc_rq
      usb: dwc3: pci: Fix reference count leak in dwc3_pci_resume_work

Aiden Leong (1):
      GUE: Fix a typo

Al Cooper (1):
      xhci: Fix enumeration issue when setting max packet size for FS devic=
es.

Alex Williamson (3):
      vfio/pci: Clear error and request eventfd ctx after releasing
      vfio/type1: Fix migration info capability ID
      vfio/pci: Fix SR-IOV VF handling with MMIO blocking

Alexander Lobakin (11):
      net: ethtool: add missing NETIF_F_GSO_FRAGLIST feature string
      net: ethtool: add missing string for NETIF_F_GSO_TUNNEL_REMCSUM
      net: qed: fix left elements count calculation
      net: qed: fix async event callbacks unregistering
      net: qede: stop adding events on an already destroyed workqueue
      net: qed: fix NVMe login fails over VFs
      net: qed: fix excessive QM ILT lines consumption
      net: qede: fix PTP initialization on recovery
      net: qede: fix use-after-free on recovery and AER handling
      net: qed: reset ILT block sizes before recomputing to fix crashes
      net: qed: fix "maybe uninitialized" warning

Alexander Popov (1):
      arm64: vdso: Don't use gcc plugins for building vgettimeofday.c

Alexander Stein (1):
      spi: dt-bindings: amlogic, meson-gx-spicc: Fix schema for meson-g12a

Alexander Usyskin (1):
      mei: me: add tiger lake point device ids for H platforms.

Anand Moon (2):
      Revert "usb: dwc3: exynos: Add support for Exynos5422 suspend clk"
      Revert "usb: dwc3: exynos: Add support for Exynos5422 suspend clk"

Andre Przywara (1):
      arm: dts: vexpress: Move mcc node back into motherboard node

Andrew Lunn (1):
      net: ethtool: Handle missing cable test TDR parameters

Andrii Nakryiko (3):
      bpf: Fix definition of bpf_ringbuf_output() helper in UAPI comments
      tools/bpftool: Add ringbuf map to a list of known map types
      bpf: bpf_probe_read_kernel_str() has to return amount of data
read on success

Andy Shevchenko (2):
      ARM: bcm2835: Fix integer overflow in
rpi_firmware_print_firmware_revision()
      i2c: designware: Adjust bus speed independently of ACPI

Aneesh Kumar K.V (1):
      powerpc/kvm/book3s64: Fix kernel crash with nested kvm & DEBUG_VIRTUA=
L

Anson Huang (1):
      soc: imx8m: Correct i.MX8MP UID fuse offset

Anton Eidelman (2):
      nvme-multipath: fix deadlock between ana_work and scan_work
      nvme-multipath: fix deadlock due to head->lock

Ard Biesheuvel (4):
      efi/libstub: Fix missing-prototype warning for skip_spaces()
      efi/libstub: arm: Omit arch specific config table matching array on a=
rm64
      efi/libstub: arm: Print CPU boot mode and MMU state at boot
      net: phy: mscc: avoid skcipher API for single block AES encryption

Arjun Roy (1):
      mm/memory.c: properly pte_offset_map_lock/unlock in vm_insert_pages()

Arnd Bergmann (1):
      fpga: zynqmp: fix modular build

Arseny Solokha (1):
      powerpc/fsl_booke/32: Fix build with CONFIG_RANDOMIZE_BASE

Arvind Sankar (2):
      efi/x86: Fix build with gcc 4
      efi/x86: Setup stack correctly for efi_pe_entry

Axel Lin (1):
      regulator: mt6358: Remove BROKEN dependency

Babu Moger (1):
      x86/resctrl: Fix memory bandwidth counter width for AMD

Bartlomiej Zolnierkiewicz (1):
      video: fbdev: uvesafb: fix "noblank" option handling

Bartosz Golaszewski (1):
      regmap: fix the kerneldoc for regmap_test_bits()

Ben Widawsky (1):
      mm/memory_hotplug.c: fix false softlockup during pfn range removal

Bernard Zhao (1):
      drm/amd: fix potential memleak in err branch

Bj=C3=B6rn T=C3=B6pel (1):
      i40e: fix crash when Rx descriptor count is changed

Borislav Petkov (1):
      EDAC/amd64: Read back the scrub rate PCI register on F15h

Brent Lu (1):
      ASoC: SOF: Intel: hda: Clear RIRB status before reading WP

Briana Oursler (1):
      tc-testing: avoid action cookies with odd length.

Charles Keepax (1):
      regmap: Fix memory leak from regmap_register_patch

Chen Yu (1):
      PM: s2idle: Clear _TIF_POLLING_NRFLAG before suspend to idle

Chengguang Xu (1):
      block: release bip in a right way in error path

Chris Down (1):
      mm/memcontrol.c: prevent missed memory.low load tears

Christian Borntraeger (1):
      s390/debug: avoid kernel warning on too large number of pages

Christian Brauner (2):
      nsproxy: restore EINVAL for non-namespace file descriptor
      tests: test for setns() EINVAL regression

Christoffer Nielsen (1):
      ALSA: usb-audio: Add registration quirk for Kingston HyperX Cloud Fli=
ght S

Christoph Hellwig (7):
      dma-direct: re-enable mmap for !CONFIG_MMU
      dma-direct: mark __dma_direct_alloc_pages static
      dma-mapping: DMA_COHERENT_POOL should select GENERIC_ALLOCATOR
      scsi: libata: Fix the ata_scsi_dma_need_drain stub
      x86/hyperv: allocate the hypercall page with only read and execute bi=
ts
      arm64: use PAGE_KERNEL_ROX directly in alloc_insn_page
      mm: remove vmalloc_exec

Christophe JAILLET (2):
      gpu: host1x: Clean up debugfs in error handling path
      PM: sleep: core: mark 2 functions as __init to save some memory

Christophe Leroy (1):
      mm/debug_vm_pgtable: fix build failure with powerpc 8xx

Christopher Swenson (1):
      ALSA: usb-audio: Set 48 kHz rate for Rodecaster

Chuck Lever (6):
      xprtrdma: Prevent dereferencing r_xprt->rx_ep after it is freed
      xprtrdma: Use re_connect_status safely in rpcrdma_xprt_connect()
      xprtrdma: Clean up synopsis of rpcrdma_flush_disconnect()
      xprtrdma: Clean up disconnect
      xprtrdma: Fix handling of RDMA_ERROR replies
      SUNRPC: Properly set the @subbuf parameter of xdr_buf_subsegment()

Chuhong Yuan (1):
      USB: ohci-sm501: Add missed iounmap() in remove

Ciara Loftus (3):
      ixgbe: protect ring accesses with READ- and WRITE_ONCE
      i40e: protect ring accesses with READ- and WRITE_ONCE
      ice: protect ring accesses with WRITE_ONCE

Claudiu Beznea (3):
      net: macb: undo operations in case of failure
      net: macb: call pm_runtime_put_sync on failure path
      net: macb: free resources on failure path of at91ether_open()

Claudiu Manoil (1):
      enetc: Fix HW_VLAN_CTAG_TX|RX toggling

Colin Ian King (2):
      RDMA/mlx5: Remove duplicated assignment to resp.response_length
      qed: add missing error test for DBG_STATUS_NO_MATCHING_FRAMING_MODE

Colton Lewis (1):
      gpu: host1x: Correct trivial kernel-doc inconsistencies

Damien Le Moal (2):
      dm zoned: fix uninitialized pointer dereference
      dm zoned: Fix random zone reclaim selection

Dan Carpenter (5):
      Staging: rtl8723bs: prevent buffer overflow in update_sta_support_rat=
e()
      x86/resctrl: Fix a NULL vs IS_ERR() static checker warning in
rdt_cdp_peer_get()
      vhost_vdpa: Fix potential underflow in vhost_vdpa_mmap()
      virtio-mem: silence a static checker warning
      usb: gadget: udc: Potential Oops in error handling code

Daniel Gomez (1):
      drm: rcar-du: Fix build error

Daniel Mack (1):
      dsa: Allow forwarding of redirected IGMP traffic

Daniel Vetter (1):
      drm/fb-helper: Fix vt restore

Daniel Wagner (1):
      scsi: qla2xxx: Set NVMe status code for failed NVMe FCP request

Dany Madden (1):
      ibmvnic: continue to init in CRQ reset returns H_CLOSED

David Christensen (1):
      tg3: driver sleeps indefinitely when EEH errors exceed eeh_max_freeze=
s

David Hildenbrand (1):
      virtio-mem: add memory via add_memory_driver_managed()

David Howells (5):
      rxrpc: Fix trace string
      rxrpc: Fix handling of rwind from an ACK packet
      rxrpc: Fix afs large storage transmission performance drop
      rxrpc: Fix notification call on completion of discarded calls
      afs: Fix storage of cell names

David Rientjes (4):
      dma-direct: always align allocation size in dma_direct_alloc_pages()
      dma-direct: re-encrypt memory if dma_direct_alloc_pages() fails
      dma-direct: check return value when encrypting or decrypting memory
      dma-direct: add missing set_memory_decrypted() for coherent mapping

David Wilder (4):
      netfilter: iptables: Split ipt_unregister_table() into pre_exit
and exit helpers.
      netfilter: iptables: Add a .pre_exit hook in all iptable_foo.c.
      netfilter: ip6tables: Split ip6t_unregister_table() into
pre_exit and exit helpers.
      netfilter: ip6tables: Add a .pre_exit hook in all ip6table_foo.c.

Davide Caratti (2):
      net/sched: act_gate: fix NULL dereference in tcf_gate_init()
      net/sched: act_gate: fix configuration of the periodic timer

Dejin Zheng (1):
      net: phy: smsc: fix printing too many logs

Denis Efremov (1):
      drm/radeon: fix fb_div check in ni_init_smc_spll_table()

Denis Kirjanov (1):
      tcp: don't ignore ECN CWR on pure ACK

Dennis Dalessandro (2):
      IB/hfi1: Restore kfree in dummy_netdev cleanup
      IB/hfi1: Fix module use count flaw due to leftover module put calls

Doug Berger (3):
      net: bcmgenet: re-remove bcmgenet_hfb_add_filter
      net: bcmgenet: use __be16 for htons(ETH_P_IP)
      net: bcmgenet: use hardware padding of runt frames

Douglas Anderson (1):
      kgdb: Avoid suspicious RCU usage warning

Drew Fustini (2):
      ARM: dts: am335x-pocketbeagle: Fix mmc0 Write Protect
      ARM: dts: am5729: beaglebone-ai: fix rgmii phy-mode

Eddie James (1):
      i2c: fsi: Fix the port number field in status register

Eric Auger (1):
      dma-remap: align the size in dma_common_*_remap()

Eric Biggers (3):
      esp, ah: consolidate the crypto algorithm selections
      esp: select CRYPTO_SEQIV
      esp, ah: modernize the crypto algorithm selections

Eric Dumazet (1):
      net: increment xmit_recursion level in dev_direct_xmit()

Eugenio P=C3=A9rez (7):
      tools/virtio: Add --batch option
      tools/virtio: Add --batch=3Drandom option
      tools/virtio: Add --reset
      tools/virtio: Use __vring_new_virtqueue in virtio_test.c
      tools/virtio: Extract virtqueue initialization in vq_reset
      tools/virtio: Reset index in virtio_test --reset.
      tools/virtio: Use tools/include/list.h instead of stubs

Fabian Vogt (1):
      efi/tpm: Verify event log header before parsing

Fabio Estevam (1):
      Documentation: ABI: usb: chipidea: Update Li Jun's e-mail

Faiz Abbas (1):
      ARM: dts: Move am33xx and am43xx mmc nodes to sdhci-omap driver

Fan Guo (1):
      RDMA/mad: Fix possible memory leak in ib_mad_post_receive_mads()

Felix Fietkau (1):
      MAINTAINERS: update email address for Felix Fietkau

Filipe Manana (9):
      btrfs: fix a block group ref counter leak after failure to
remove block group
      btrfs: fix race between block group removal and block group creation
      btrfs: fix data block group relocation failure due to concurrent scru=
b
      btrfs: fix bytes_may_use underflow when running balance and
scrub in parallel
      btrfs: check if a log root exists before locking the log_mutex on unl=
ink
      btrfs: fix hang on snapshot creation after RWF_NOWAIT write
      btrfs: fix failure of RWF_NOWAIT write into prealloc extent beyond eo=
f
      btrfs: fix RWF_NOWAIT write not failling when we need to cow
      btrfs: fix RWF_NOWAIT writes blocking on extent locks and waiting for=
 IO

Flavio Suligoi (2):
      net: ethernet: neterion: vxge: fix spelling mistake
      net: ethernet: oki-semi: pch_gbe: fix spelling mistake

Florian Fainelli (3):
      net: dsa: bcm_sf2: Fix node reference count
      of: of_mdio: Correct loop scanning logic
      net: phy: Check harder for errors in get_phy_id()

Florian Westphal (1):
      selftests: netfilter: add test case for conntrack helper assignment

Frank Werner-Krippendorf (1):
      wireguard: noise: do not assign initiation time in if condition

Frieder Schrempf (2):
      ARM: dts: imx6ul-kontron: Move watchdog from Kontron i.MX6UL/ULL
board to SoM
      ARM: dts: imx6ul-kontron: Change WDOG_ANY signal from push-pull
to open-drain

Gal Pressman (1):
      RDMA/efa: Set maximum pkeys device attribute

Gao Xiang (1):
      erofs: fix partially uninitialized misuse in z_erofs_onlinepage_fixup

Gaurav Singh (2):
      bpf, xdp, samples: Fix null pointer dereference in *_user code
      ethtool: Fix check in ethtool_rx_flow_rule_create

Geert Uytterhoeven (3):
      spi: spidev_test: Use %u to format unsigned numbers
      spi: rspi: Use requested instead of maximum bit rate
      spi: uapi: spidev: Use TABs for alignment

Geliang Tang (1):
      mptcp: drop sndr_key in mptcp_syn_options

Guo Ren (1):
      riscv: Fixup __vdso_gettimeofday broke dynamic ftrace

Gustavo A. R. Silva (3):
      efi: Replace zero-length array and use struct_size() helper
      dm ioctl: use struct_size() helper in retrieve_deps()
      cifs: misc: Use array_size() in if-statement controlling expression

Hangbin Liu (2):
      xdp: Handle frame_sz in xdp_convert_zc_to_xdp_frame()
      tc-testing: update geneve options match in tunnel_key unit tests

Hans de Goede (2):
      drm: panel-orientation-quirks: Add quirk for Asus T101HA panel
      drm: panel-orientation-quirks: Use generic orientation-data for Acer =
S1003

Harish (1):
      selftests/powerpc: Fix build failure in ebb tests

Heikki Krogerus (1):
      usb: typec: mux: intel_pmc_mux: Fix DP alternate mode entry

Heiner Kallweit (1):
      r8169: fix firmware not resetting tp->ocp_base

Heinrich Schuchardt (1):
      efi/libstub: Descriptions for stub helper functions

Horatiu Vultur (2):
      bridge: uapi: mrp: Fix MRP_PORT_ROLE
      bridge: mrp: Validate when setting the port role

Hou Tao (1):
      dm zoned: assign max_io_len correctly

Huacai Chen (1):
      KVM: MIPS: Fix a build error for !CPU_LOONGSON64

Huaisheng Ye (2):
      dm writecache: correct uncommitted_block when discarding uncommitted =
entry
      dm writecache: skip writecache_wait when using pmem mode

Hugh Dickins (1):
      mm: fix swap cache node allocation mask

Huy Nguyen (1):
      xfrm: Fix double ESP trailer insertion in IPsec crypto offload.

Ido Schimmel (1):
      mlxsw: spectrum: Do not rely on machine endianness

Igor Mammedov (1):
      kvm: lapic: fix broken vcpu hotplug

Ilya Ponetayev (1):
      sch_cake: don't try to reallocate or unshare skb unconditionally

Jack Yu (1):
      ASoC: rt1015: Update rt1015 default register value according to
spec modification.

Jason A. Donenfeld (7):
      Revert "kernel/printk: add kmsg SEEK_CUR handling"
      ACPI: configfs: Disallow loading ACPI tables when locked down
      wireguard: device: avoid circular netns references
      wireguard: receive: account for napi_gro_receive never returning GRO_=
DROP
      socionext: account for napi_gro_receive never returning GRO_DROP
      hns: do not cast return value of napi_gro_receive to null
      wil6210: account for napi_gro_receive never returning GRO_DROP

Jason Wang (1):
      vdpa: fix typos in the comments for __vdpa_alloc_device()

Jean-Philippe Brucker (1):
      arm64: Don't insert a BTI instruction at inner labels

Jens Thoms Toerring (1):
      regmap: fix alignment issue

Jens Wiklander (1):
      MAINTAINERS: change tee mailing list

Jeremy Kerr (1):
      net: usb: ax88179_178a: fix packet alignment padding

Jiping Ma (1):
      arm64: perf: Report the PC value in REGS_ABI_32 mode

Jiri Slaby (1):
      syscalls: Fix offset type of ksys_ftruncate()

Jisheng Zhang (2):
      net: phy: make phy_disable_interrupts() non-static
      net: phy: call phy_disable_interrupts() in phy_init_hw()

Joakim Tjernlund (1):
      cdc-acm: Add DISABLE_ECHO quirk for Microchip/SMSC chip

Johannes Thumshirn (1):
      dm: update original bio sector on Zone Append

Johannes Weiner (2):
      mm: memcontrol: handle div0 crash race condition in memory.low
      mm: workingset: age nonresident information alongside anonymous pages

John van der Kamp (1):
      drm/amdgpu/display: Unlock mutex on error

Joonsoo Kim (2):
      mm/swap: fix for "mm: workingset: age nonresident information
alongside anonymous pages"
      mm/memory: fix IO cost for anonymous page

Julian Wiedmann (2):
      s390/qeth: fix error handling for isolation mode cmds
      s390/qeth: let isolation mode override HW offload restrictions

Junxiao Bi (4):
      ocfs2: avoid inode removal while nfsd is accessing it
      ocfs2: load global_inode_alloc
      ocfs2: fix panic on nfs server over ocfs2
      ocfs2: fix value of OCFS2_INVALID_SLOT

Juri Lelli (2):
      sched/deadline: Initialize ->dl_boosted
      sched/core: Fix PI boosting between RT and DEADLINE tasks

J=C3=A9r=C3=B4me Pouiller (3):
      staging: wfx: fix AC priority
      staging: wfx: drop useless loop
      staging: wfx: fix coherency of hif_scan() prototype

Kai-Heng Feng (3):
      ALSA: hda/realtek: Add mute LED and micmute LED support for HP system=
s
      xhci: Return if xHCI doesn't support LPM
      xhci: Poll for U0 after disabling USB2 LPM

Kees Cook (1):
      x86/cpu: Use pinning mask for CR4 bits needing to be 0

Kieran Bingham (1):
      RDMA/hfi1: Fix trivial mis-spelling of 'descriptor'

Krzysztof Kozlowski (1):
      spi: spi-fsl-dspi: Free DMA memory with matching function

Kurt Kanzenbach (1):
      timekeeping: Fix kerneldoc system_device_crosststamp & al

Laurence Tratt (1):
      ALSA: usb-audio: Add implicit feedback quirk for SSL2+.

Leon Romanovsky (6):
      RDMA/core: Annotate CMA unlock helper routine
      RDMA/mlx5: Add missed RST2INIT and INIT2INIT steps during ECE handsha=
ke
      RDMA/core: Check that type_attrs is not NULL prior access
      RDMA/mlx5: Don't access ib_qp fields in internal destroy QP path
      RDMA/mlx5: Remove ECE limitation from the RAW_PACKET QPs
      RDMA/mlx5: Protect from kernel crash if XRC_TGT doesn't have udata

Li Jun (1):
      usb: typec: tcpci_rt1711h: avoid screaming irq causing boot hangs

Lianbo Jiang (1):
      kexec: do not verify the signature without the lockdown or
mandatory signature

Lingling Xu (1):
      spi: sprd: switch the sequence of setting WDG_LOAD_LOW and _HIGH

Linus Torvalds (1):
      Linux 5.8-rc3

Linus Walleij (2):
      drm: mcde: Fix display initialization problem
      drm: mcde: Fix forgotten user of drm->dev_private

Longfang Liu (1):
      USB: ehci: reopen solution for Synopsys HC bug

Lorenzo Bianconi (1):
      openvswitch: take into account de-fragmentation/gso_size in
execute_check_pkt_len

Lu Baolu (5):
      iommu/vt-d: Make Intel SVM code 64-bit only
      iommu/vt-d: Set U/S bit in first level page table by default
      iommu/vt-d: Enable PCI ACS for platform opt in hint
      iommu/vt-d: Update scalable mode paging structure coherency
      iommu/vt-d: Fix misuse of iommu_domain_identity_map()

Luc Van Oostenryck (1):
      MAINTAINERS: update info for sparse

Macpaul Lin (2):
      ALSA: usb-audio: add quirk for Samsung USBC Headset (AKG)
      usb: host: xhci-mtk: avoid runtime suspend when removing hcd

Mans Rullgard (1):
      i2c: core: check returned size of emulated smbus block read

Maor Gottlieb (1):
      RDMA/mlx5: Fix remote gid value in query QP

Marcelo Ricardo Leitner (1):
      sctp: Don't advertise IPv4 addresses if ipv6only is set on the socket

Marcelo Tosatti (1):
      KVM: x86: allow TSC to differ by NTP correction bounds without TSC sc=
aling

Marco Elver (4):
      kasan: Bump required compiler version
      compiler_types.h: Add __no_sanitize_{address,undefined} to noinstr
      compiler_attributes.h: Support no_sanitize_undefined check with GCC 4
      kasan: Fix required compiler version

Mark Brown (2):
      arm64: Depend on newer binutils when building PAC
      kselftest: arm64: Remove redundant clean target

Mark Zhang (2):
      RDMA/cma: Protect bind_list and listen_list while finding matching cm=
 id
      RDMA/counter: Query a counter before release

Martin (1):
      bareudp: Fixed multiproto mode configuration

Martin Fuzzey (1):
      regulator: da9063: fix LDO9 suspend and warning.

Masami Hiramatsu (2):
      tracing/boot: Fix config dependency for synthedic event
      tracing: Fix event trigger to accept redundant spaces

Masanari Iida (1):
      mm/vmalloc.c: fix a warning while make xmldocs

Mathias Nyman (1):
      xhci: Fix incorrect EP_STATE_MASK

Matt Fleming (1):
      x86/asm/64: Align start of __clear_user() loop to 16-bytes

Matthew Hagan (3):
      ARM: bcm: Select ARM_TIMER_SP804 for ARCH_BCM_NSP
      ARM: dts: NSP: Disable PL330 by default, add dma-coherent property
      ARM: dts: NSP: Correct FA2 mailbox node

Matti Vaittinen (1):
      regulator: Fix pickable ranges mapping

Mauro Carvalho Chehab (1):
      docs: device-mapper: add dm-ebs.rst to an index file

Max Gurtovoy (7):
      RDMA/mlx5: Fix integrity enabled QP creation
      nvme: set initial value for controller's numa node
      nvme-pci: override the value of the controller's numa node
      nvme-pci: initialize tagset numa value to the value of the ctrl
      nvme-tcp: initialize tagset numa value to the value of the ctrl
      nvme-loop: initialize tagset numa value to the value of the ctrl
      nvme-rdma: assign completion vector correctly

Maxime Ripard (1):
      drm/sun4i: mixer: Call of_dma_configure if there's an IOMMU

Mel Gorman (1):
      fs: Do not check if there is a fsnotify watcher on pseudo inodes

Michael Chan (3):
      bnxt_en: Store the running firmware version code.
      bnxt_en: Do not enable legacy TX push on older firmware.
      bnxt_en: Fix statistics counters issue during ifdown with older firmw=
are.

Michal Hocko (1):
      mm: do_swap_page(): fix up the error code

Michal Kalderon (1):
      RDMA/qedr: Fix KASAN: use-after-free in ucma_event_handler+0x532

Michal Kubecek (1):
      ethtool: fix error handling in linkstate_prepare_data()

Mike Marciniszyn (2):
      IB/hfi1: Correct -EBUSY handling in tx code
      IB/hfi1: Add atomic triggered sleep/wakeup

Mikulas Patocka (1):
      dm writecache: add cond_resched to loop in persistent_memory_claim()

Minas Harutyunyan (1):
      usb: dwc2: Postponed gadget registration to the udc class driver

Muchun Song (1):
      mm/memcontrol.c: add missed css_put()

Nathan Chancellor (2):
      ACPI: sysfs: Fix pm_profile_attr type
      media: omap3isp: remove cacheflush.h

Neal Cardwell (2):
      tcp_cubic: fix spurious HYSTART_DELAY exit upon drop in min RTT
      bpf: tcp: bpf_cubic: fix spurious HYSTART_DELAY exit upon drop in min=
 RTT

Nicolin Chen (1):
      drm/tegra: hub: Do not enable orphaned window group

Oded Gabbay (3):
      habanalabs: block scalar load_and_exe on external queue
      habanalabs: rename mmu_write() to mmu_asid_va_write()
      habanalabs: increase GAUDI QMAN ARB WDT timeout

Ofir Bitton (1):
      habanalabs: Correct handling when failing to enqueue CB

Olga Kornievskaia (1):
      NFSv4 fix CLOSE not waiting for direct IO compeletion

Omer Shpigelman (2):
      habanalabs: use PI in MMU cache invalidation
      habanalabs: increase h/w timer when checking idle

Oskar Holmlund (2):
      ARM: dts: Fix am33xx.dtsi USB ranges length
      ARM: dts: Fix am33xx.dtsi ti,sysc-mask wrong softreset flag

Paolo Abeni (2):
      mptcp: cache msk on MP_JOIN init_req
      mptcp: drop MP_JOIN request sock on syn cookies

Paolo Bonzini (1):
      KVM: LAPIC: ensure APIC map is up to date on concurrent update reques=
ts

Patrice Chotard (2):
      spi: stm32-qspi: Fix error path in case of -EPROBE_DEFER
      Revert "ARM: sti: Implement dummy L2 cache's write_sec"

Pavel Begunkov (2):
      io_uring: fix hanging iopoll in case of -EAGAIN
      io_uring: fix current->mm NULL dereference on exit

Peng Fan (1):
      soc: imx8m: fix build warning

Peter Chen (6):
      usb: cdns3: ep0: fix the test mode set incorrectly
      usb: cdns3: trace: using correct dir value
      usb: cdns3: ep0: add spinlock for cdns3_check_new_setup
      usb: cdns3: ep0: fix the test mode set incorrectly
      usb: cdns3: trace: using correct dir value
      usb: cdns3: ep0: add spinlock for cdns3_check_new_setup

Peter Jones (1):
      efi: Make it possible to disable efivar_ssdt entirely

Peter Zijlstra (19):
      x86, kcsan: Remove __no_kcsan_or_inline usage
      kcsan: Remove __no_kcsan_or_inline
      x86, kcsan: Add __no_kcsan to noinstr
      x86/entry, cpumask: Provide non-instrumented variant of cpu_is_offlin=
e()
      x86/entry, ubsan, objtool: Whitelist __ubsan_handle_*()
      x86/entry, bug: Comment the instrumentation_begin() usage for WARN()
      objtool: Clean up elf_write() condition
      objtool: Provide elf_write_{insn,reloc}()
      objtool: Fix noinstr vs KCOV
      objtool: Don't consider vmlinux a C-file
      x86/entry: Fixup bad_iret vs noinstr
      x86/entry: Increase entry_stack size to a full page
      x86/entry: Fix #UD vs WARN more
      locking/atomics: Provide the arch_atomic_ interface to generic code
      rcu: Fixup noinstr warnings
      sched/core: Fix CONFIG_GCC_PLUGIN_RANDSTRUCT build fail
      sched/core: Fix ttwu() race
      sched/core: s/WF_ON_RQ/WQ_ON_CPU/
      smp, irq_work: Continue smp_call_function*() and irq_work*() integrat=
ion

Philipp Fent (1):
      efi/libstub: Fix path separator regression

Pierre-Louis Bossart (8):
      ASoC: soc-devres: add devm_snd_soc_register_dai()
      ASoC: soc-topology: use devm_snd_soc_register_dai()
      ASoC: soc-pcm: fix checks for multi-cpu FE dailinks
      ASoC: Intel: SOF: merge COMETLAKE_LP and COMETLAKE_H
      ASoC: SOF: Intel: add PCI ID for CometLake-S
      ASoC: SOF: Intel: add PCI IDs for ICL-H and TGL-H
      ASoC: hdac_hda: fix memleak with regmap not freed on remove
      ALSA: hda: Intel: add missing PCI IDs for ICL-H, TGL-H and EKL

Qian Cai (1):
      kvm/svm: disable KCSAN for svm_vcpu_run()

Qing Zhang (2):
      spi: tools: Make default_tx/rx and input_tx static
      spi: tools: Add macro definitions to fix build errors

Qiushi Wu (2):
      efi/esrt: Fix reference count leak in esre_create_sysfs_entry.
      ASoC: rockchip: Fix a reference count leak.

Rafael J. Wysocki (1):
      cpuidle: Rearrange s2idle-specific idle state entry code

Rafa=C5=82 Mi=C5=82ecki (1):
      ARM: dts: BCM5301X: Add missing memory "device_type" for Luxul XWC-20=
00

Rahul Lakkireddy (12):
      cxgb4: move handling L2T ARP failures to caller
      cxgb4: move PTP lock and unlock to caller in Tx path
      cxgb4: use unaligned conversion for fetching timestamp
      cxgb4: parse TC-U32 key values and masks natively
      cxgb4: fix endian conversions for L4 ports in filters
      cxgb4: use correct type for all-mask IP address comparison
      cxgb4: fix SGE queue dump destination buffer context
      cxgb4: remove cast when saving IPv4 partial checksum
      cxgb4: move DCB version extern to header file
      cxgb4: fix set but unused variable when DCB is disabled
      cxgb4: update kernel-doc line comments
      cxgb4vf: update kernel-doc line comments

Rajat Jain (1):
      iommu/vt-d: Don't apply gfx quirks to untrusted devices

Randy Dunlap (1):
      lib: fix test_hmm.c reference after free

Rao Shoaib (1):
      rds: transport module should be auto loaded when transport is set

Ravulapati Vishnu vardhan rao (1):
      ASoC: amd: closing specific instance.

Rob Gill (2):
      net: Add MODULE_DESCRIPTION entries to network modules
      netfilter: Add MODULE_DESCRIPTION entries to kernel modules

Robin Gong (3):
      regualtor: pfuze100: correct sw1a/sw2 on pfuze3000
      arm64: dts: imx8mm-evk: correct ldo1/ldo2 voltage range
      arm64: dts: imx8mn-ddr4-evk: correct ldo1/ldo2 voltage range

Roman Bolshakov (1):
      scsi: qla2xxx: Keep initiator ports after RSCN

Roopa Prabhu (1):
      vxlan: fix last fdb index during dump of fdb with nhid

Russell King (3):
      net: phylink: fix ethtool -A with attached PHYs
      net: phylink: ensure manual pause mode configuration takes effect
      netfilter: ipset: fix unaligned atomic access

Sabrina Dubroca (1):
      geneve: allow changing DF behavior after creation

Sagi Grimberg (3):
      nvme: fix possible deadlock when I/O is blocked
      nvme: don't protect ns mutation with ns->head->lock
      nvme-multipath: fix bogus request queue reference put

Sai Prakash Ranjan (2):
      arm64: kpti: Add KRYO{3, 4}XX silver CPU cores to kpti safelist
      arm64: Add KRYO{3,4}XX silver CPU cores to SSB safelist

Sascha Hauer (4):
      net: ethernet: mvneta: Fix Serdes configuration for SoCs without comp=
hy
      net: ethernet: mvneta: Add 2500BaseX support for SoCs without comphy
      net: ethernet: mvneta: Do not error out in non serdes modes
      net: ethernet: mvneta: Add back interface mode validation

Sascha Ortmann (1):
      tracing/boottime: Fix kprobe multiple events

Scott Wood (1):
      sched/core: Check cpus_mask, not cpus_ptr in
__set_cpus_allowed_ptr(), to fix mask corruption

Sean Christopherson (5):
      x86/cpu: Reinitialize IA32_FEAT_CTL MSR on BSP during wakeup
      KVM: VMX: Add helpers to identify interrupt type from intr_info
      KVM: nVMX: Plumb L2 GPA through to PML emulation
      KVM: VMX: Stop context switching MSR_IA32_UMWAIT_CONTROL
      KVM: VMX: Remove vcpu_vmx's defunct copy of host_pkru

Sebastian Andrzej Siewior (1):
      slub: cure list_slab_objects() from double fix

SeongJae Park (1):
      scsi: lpfc: Avoid another null dereference in lpfc_sli4_hba_unset()

Shannon Nelson (3):
      ionic: no link check while resetting queues
      ionic: export features for vlans to use
      ionic: tame the watchdog timer on reconfig

Shay Drory (1):
      IB/mad: Fix use after free when destroying MAD agent

Shengjiu Wang (5):
      ASoC: soc-card: export snd_soc_lookup_component_nolocked
      ASoC: dmaengine_pcm: export soc_component_to_pcm
      ASoC: fsl_asrc_dma: Reuse the dma channel if available in Back-End
      ASoC: fsl_asrc_dma: Fix data copying speed issue with EDMA
      ASoC: fsl_ssi: Fix bclk calculation for mono channel

Shin'ichiro Kawasaki (2):
      dm zoned: Fix metadata zone size check
      dm zoned: Fix reclaim zone selection

Souptick Joarder (1):
      docs: mm/gup: minor documentation update

Srinivas Kandagatla (3):
      ASoC: q6asm: handle EOS correctly
      ASoc: q6afe: add support to get port direction
      ASoC: qcom: common: set correct directions for dailinks

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Add one more OOB control bit

Stafford Horne (1):
      openrisc: fix boot oops when DEBUG_VM is enabled

Stanislav Fomichev (3):
      bpf: Don't return EINVAL from {get,set}sockopt when optlen > PAGE_SIZ=
E
      selftests/bpf: Make sure optvals > PAGE_SIZE are bypassed
      bpf: Document optval > PAGE_SIZE behavior for sockopt hooks

Stefan Schmidt (2):
      docs: net: ieee802154: change link to new project URL
      MAINTAINERS: update ieee802154 project website URL

Steffen Maier (1):
      scsi: zfcp: Fix panic on ERP timeout for previously dismissed ERP act=
ion

Stephane Eranian (1):
      perf/x86/rapl: Fix RAPL config variable bug

Stephen Rothwell (2):
      xfrm: merge fixup for "remove output_finish indirection from
xfrm_state_afinfo"
      make asm-generic/cacheflush.h more standalone

Steve Lee (1):
      ASoC: max98390: Update regmap readable reg and volatile

Steven Rostedt (VMware) (1):
      ring-buffer: Zero out time extend if it is nested and not absolute

Stylon Wang (2):
      drm/amd/display: Enable output_bpc property on all outputs
      drm/amd/display: Fix ineffective setting of max bpc property

Suman Anna (2):
      ARM: dts: dra7: Fix timer nodes properly for timer_sys_ck clocks
      ARM: dts: dra7-evm-common: Fix duplicate mailbox nodes

Sumit Garg (4):
      kdb: Re-factor kdb_printf() message write code
      kdb: Check status of console prior to invoking handlers
      kdb: Make kdb_printf() console handling more robust
      kdb: Switch to use safer dbg_io_ops over console APIs

Sven Schnelle (1):
      s390: fix system call single stepping

Taehee Yoo (4):
      net: core: reduce recursion limit value
      ip6_gre: fix use-after-free in ip6gre_tunnel_lookup()
      ip_tunnel: fix use-after-free in ip_tunnel_lookup()
      hsr: avoid to create proc file after unregister

Takashi Iwai (3):
      ALSA: hda/realtek - Add quirk for MSI GE63 laptop
      ALSA: usb-audio: Fix potential use-after-free of streams
      ALSA: usb-audio: Fix OOB access of mixer element list

Tang Bin (2):
      usb: host: ehci-exynos: Fix error check in exynos_ehci_probe()
      usb: phy: tegra: Fix unnecessary check in tegra_usb_phy_probe()

Tariq Toukan (1):
      net: Do not clear the sock TX queue in sk_set_socket()

Tero Kristo (1):
      soc: ti: omap-prm: use atomic iopoll instead of sleeping one

Thierry Reding (4):
      gpu: host1x: Register child devices
      drm/tegra: hub: Register child devices
      gpu: host1x: Detach driver on unregister
      drm/tegra: Add zpos property for cursor planes

Thomas Falcon (1):
      ibmveth: Fix max MTU limit

Thomas Martitz (1):
      net: bridge: enfore alignment for ethernet address

Tobias Klauser (1):
      tools, bpftool: Add ringbuf map type to map command docs

Todd Kjos (1):
      binder: fix null deref of proc->context

Toke H=C3=B8iland-J=C3=B8rgensen (3):
      devmap: Use bpf_map_area_alloc() for allocating hash buckets
      sch_cake: don't call diffserv parsing code when it is not needed
      sch_cake: fix a few style nits

Tom Rix (1):
      nfs: Fix memory leak of export_path

Tom Seewald (2):
      RDMA/mlx5: Fix -Wformat warning in check_ucmd_data()
      RDMA/siw: Fix pointer-to-int-cast warning in siw_rx_pbl()

Tomas Henzl (1):
      scsi: mptscsih: Fix read sense data size

Tomas Winkler (1):
      mei: me: disable mei interface on Mehlow server platforms

Tomasz Meresi=C5=84ski (1):
      usb: add USB_QUIRK_DELAY_INIT for Logitech C922

Tomi Valkeinen (4):
      ARM: dts: am437x-sk-evm: remove lcd timings
      ARM: dts: am437x-gp-evm: remove lcd timings
      ARM: dts: am437x-epos-evm: remove lcd timings
      drm/panel-simple: fix connector type for newhaven_nhd_43_480272ef_atx=
l

Tony Lindgren (10):
      bus: ti-sysc: Flush posted write on enable and disable
      ARM: dts: omap4-droid4: Fix spi configuration and increase rate
      bus: ti-sysc: Use optional clocks on for enable and wait for softrese=
t bit
      bus: ti-sysc: Ignore clockactivity unless specified as a quirk
      bus: ti-sysc: Fix uninitialized framedonetv_irq
      ARM: OMAP2+: Fix legacy mode dss_reset
      bus: ti-sysc: Increase max softreset wait
      Revert "bus: ti-sysc: Increase max softreset wait"
      ARM: dts: Fix duovero smsc interrupt for suspend
      ARM: dts: Fix omap4 system timer source clocks

Tony Luck (2):
      efivarfs: Update inode modification time for successful writes
      efivarfs: Don't return -EINTR when rate-limiting reads

Trond Myklebust (1):
      pNFS/flexfiles: Fix list corruption if the mirror count changes

Tuomas Tynkkynen (1):
      usbnet: smsc95xx: Fix use-after-free after removal

Vasily Averin (1):
      sunrpc: fixed rollback in rpc_gssd_dummy_populate()

Vasily Gorbik (1):
      s390/kasan: fix early pgm check handler execution

Vasundhara Volam (1):
      bnxt_en: Read VPD info only for PFs

Vincent Chen (3):
      riscv: Add -fPIC option to CFLAGS_vgettimeofday.o
      clk: sifive: allocate sufficient memory for struct __prci_data
      riscv: Add extern declarations for vDSO time-related functions

Vincent Guittot (1):
      sched/cfs: change initial value of runnable_avg

Vitaly Kuznetsov (2):
      Revert "KVM: VMX: Micro-optimize vmexit time when not exposing PMU"
      KVM: x86/mmu: Avoid mixing gpa_t with gfn_t in walk_addr_generic()

Vladimir Oltean (7):
      net: dsa: sja1105: remove debugging code in sja1105_vl_gate
      net: dsa: sja1105: fix checks for VLAN state in redirect action
      net: dsa: sja1105: fix checks for VLAN state in gate action
      net: dsa: sja1105: move sja1105_compose_gating_subschedule at the top
      net: dsa: sja1105: unconditionally free old gating config
      net: dsa: sja1105: recalculate gating subschedule after deleting
tc-gate rules
      net: dsa: sja1105: fix tc-gate schedule with single element

Vlastimil Babka (1):
      mm, compaction: make capture control handling safe wrt interrupts

Waiman Long (3):
      btrfs: use kfree() in btrfs_ioctl_get_subvol_info()
      mm, slab: fix sign conversion problem in memcg_uncharge_slab()
      mm/slab: use memzero_explicit() in kzfree()

Wenhui Sheng (1):
      drm/amdgpu: add fw release for sdma v5_0

Will Deacon (5):
      arm64: vdso: Disable dwarf unwinding through the sigreturn trampoline
      arm64: compat: Allow 32-bit vdso and sigpage to co-exist
      arm64: compat: Always use sigpage for sigreturn trampoline
      arm64: compat: Remove 32-bit sigreturn code from the vDSO
      arm64: vdso: Only pass --no-eh-frame-hdr when linker supports it

Willem de Bruijn (1):
      selftests/net: report etf errors correctly

Xiaoyao Li (1):
      KVM: X86: Fix MSR range of APIC registers in X2APIC mode

Xiyu Yang (3):
      drm/ttm: Fix dma_fence refcnt leak in ttm_bo_vm_fault_reserved
      drm/ttm: Fix dma_fence refcnt leak when adding move fence
      cifs: Fix cached_fid refcnt leak in open_shroot

Xuan Zhuo (1):
      io_uring: fix io_sq_thread no schedule when busy

Yang Shi (1):
      doc: THP CoW fault no longer allocate THP

Yang Yingliang (1):
      net: fix memleak in register_netdevice()

Yangyang Li (2):
      RDMA/hns: Fix a calltrace when registering MR from userspace
      RDMA/hns: Fix an cmd queue issue when resetting

Yick W. Tse (1):
      ALSA: usb-audio: add quirk for Denon DCD-1500RE

Yoshihiro Shimoda (1):
      usb: renesas_usbhs: getting residue from callback_result

Zhang Xiaoxu (4):
      cifs: Fix double add page to memcg when cifs_readpages
      cifs/smb3: Fix data inconsistent when zero file range
      cifs/smb3: Fix data inconsistent when punch hole
      cifs: update ctime and mtime during truncate

Zhenzhong Duan (2):
      spi: spidev: fix a race between spidev_release and spidev_remove
      spi: spidev: fix a potential use-after-free in spidev_release()

Zqiang (1):
      usb: usbtest: fix missing kfree(dev->buf) in usbtest_disconnect

derek.fang (1):
      ASoC: rt5682: Let dai clks be registered whether mclk exists or not

guodeqing (1):
      net: Fix the arp error in some cases

wenxu (4):
      flow_offload: add flow_indr_block_cb_alloc/remove function
      flow_offload: use flow_indr_block_cb_alloc/remove function
      net: flow_offload: fix flow_indr_dev_unregister path
      net/sched: cls_api: fix nooffloaddevcnt warning dmesg log

yu kuai (2):
      ARM: imx5: add missing put_device() call in imx_suspend_alloc_ocram()
      ARM: imx6: add missing put_device() call in imx6q_suspend_init()
