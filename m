Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E90C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 22:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E3B22065F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 22:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595801278;
	bh=2jUlG5BWdr0v7YC2zD7I0OAnkVdRbaupaLLO/iNUJew=;
	h=From:Date:Subject:To:List-ID:From;
	b=TCavoOTFyCQ/YmnfNDXdO/7vZAFxj2wHsGXB1Drn3YS53GabwVwIr1xKV8xKMMNg5
	 W8gOoP1vK0Pp6SX4QFVHgRfjXOJVnSZMjM7ODvEayBmPooLirGunplLZn3G+CaVB+U
	 v2dr3Hz/5Ci+3I3dptcJ13E/O77CHhhQm3bvORgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgGZWH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 18:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgGZWH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 18:07:56 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9478C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 15:07:55 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 185so4931476ljj.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 15:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=n3WjC1QTi91R3RRLy9qgKVxB59Gmb3Yx1HO0V1e323M=;
        b=LZuzJyBnZnRbfK4PM/CsSAhNMucfuqIiRSacVtw0Fe6PdxqeaBy8VPrpMH5HDHdBYK
         vo7qLOdgvMMKN/+0bGD79w+1kX7IIbpzmsHR4ARHtuBjihHaB5HMV45jTLIyiq6o71tu
         wjqozecM/3tXJsQeV/nDQ+WjDTLim8eJAAU6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=n3WjC1QTi91R3RRLy9qgKVxB59Gmb3Yx1HO0V1e323M=;
        b=oVw5cC2aVoILfrkXF0Mmsx3XEJQ/q0EdUy2eLsLB3+xXXEReo0eeLoWlHnFFmWHINf
         iGZnwG2wGKTnzjI80ZwTz5DbYjn7s4p8zwjl+Tj2YRmr39/iVj83X289dQGzxtmckk1Z
         jiqK7hpgDCanMO0sm76BdOjpm3IFVNSGhc2/OGwLLLqzJz8bsukcZDqDO4xjunrbnFTW
         UUCZDGQ12ydYorNhK510wM1xETJgPS++p+Df1UvLx0ehyOL5JCs8KgL2i2kqU3Nq4MJB
         uRRRzyXVEbfoY7m0IqOMH7ax9x9Y2AHZDXCf9uzga9OoQRCr332Yt29jl8uuZsGuXUwk
         iSlQ==
X-Gm-Message-State: AOAM533NWLsU30P2c8IC+ipo2tBWPTRcKDfrmUPEtUBgbWsMXAVIdIgi
        MuX7FkJZzDUKc7eMsCSe2Req6s/SRQ4=
X-Google-Smtp-Source: ABdhPJxVy1fkUn+vGkNHeoc9aVJC6m6M2sQBuXOm1amDhfqyM04XKVly3fNJlsONYDzEzdss93W1pQ==
X-Received: by 2002:a2e:b8ce:: with SMTP id s14mr1841451ljp.313.1595801273443;
        Sun, 26 Jul 2020 15:07:53 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id v23sm1667737lfa.5.2020.07.26.15.07.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2020 15:07:52 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id d17so15140278ljl.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 15:07:52 -0700 (PDT)
X-Received: by 2002:a2e:9c92:: with SMTP id x18mr8090178lji.70.1595801271620;
 Sun, 26 Jul 2020 15:07:51 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 Jul 2020 15:07:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgcJ-dtTf+kY1Qj0F786gYqShJU19BguJHruQ2J4vZxOw@mail.gmail.com>
Message-ID: <CAHk-=wgcJ-dtTf+kY1Qj0F786gYqShJU19BguJHruQ2J4vZxOw@mail.gmail.com>
Subject: Linux 5.8-rc7
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So the week started very calm, and almost three quarters of the
changes then coming in Friday and now during the weekend.

Which isn't unusual, but the end result this time is that rc7 is
slightly larger than I'd like.

Nothing looks all that worrisome (the only bigger part is some fixes
to the atomisp driver, and that does account for a fair chunk of the
rc7 size, both in commits and diff),.

But it *might* mean that an rc8 is called for. It's not like rc7 is
*big* big. We've had bigger rc7's. Both 5.3 and 5.5 had bigger rc7's,
but only 5.3 ended up with an rc8.

Put another way: it could still go either way.  We'll see how this
upcoming week goes.

In the meantime, please do go out and test.  Ignoring that atomisp
chunk, it's mostly various drivers (networking, habanalabs, misc),
some core networking fixes, and other small random noise. None of it
is big.

Shortlog appended.

               Linus

---

Alessio Bonfiglio (1):
      iwlwifi: Make some Killer Wireless-AC 1550 cards work again

Alexander A. Klimov (1):
      net: ieee802154: adf7242: Replace HTTP links with HTTPS ones

Alexander Lobakin (2):
      qed: suppress "don't support RoCE & iWARP" flooding on HW init
      qed: suppress false-positives interrupt error messages on HW init

Alexandre Belloni (1):
      net: macb: use phy_interface_mode_is_rgmii everywhere

Andrea Righi (1):
      xen-netfront: fix potential deadlock in xennet_remove()

Andrey Konovalov (1):
      MAINTAINERS: add KCOV section

Andy Shevchenko (18):
      media: atomisp: Replace last use of Intel MID APIs
      media: atomisp: move CCK endpoint address to generic header
      media: atomisp: Use proper APIs to find I=C2=B2C client device by ACP=
I HID
      media: atomisp: don't pass struct device_driver as parameter
      media: atomisp: Get rid of struct pci_dev in struct atomisp_device
      media: atomisp: Unify pdev to be pointer to struct pci_device
      media: atomisp: Replace direct access to MMIO with proper helpers
      media: atomisp: Drop global atomisp_dev variable (easy cases)
      media: atomisp: make platform data more readable
      media: atomisp: Don't try to parse unexpected ACPI object type
      media: atomisp: Make pointer to PMIC client global
      media: atomisp: Deduplicate return ret in gmin_i2c_write()
      media: atomisp: Refactor PMIC detection to a separate function
      media: atomisp: Use temporary variable for device in gmin_subdev_add(=
)
      media: atomisp: Provide Gmin subdev as parameter to gmin_subdev_add()
      media: atomisp: Get rid of ACPI specifics in gmin_subdev_add()
      media: atomisp: Clean up non-existing folders from Makefile
      device property: Avoid NULL pointer dereference in
device_get_next_child_node()

Ard Biesheuvel (2):
      efi/efivars: Expose RT service availability via efivars abstraction
      efi: Revert "efi/x86: Fix build with gcc 4"

Arvind Sankar (2):
      efi/x86: Remove unused variables
      efi/x86: Only copy upto the end of setup_header

Atish Patra (5):
      efi/libstub: Fix gcc error around __umoddi3 for 32 bit builds
      efi/libstub: Move the function prototypes to header file
      RISC-V: Set maximum number of mapped pages correctly
      RISC-V: Do not rely on initrd_start/end computed during early dt pars=
ing
      riscv: Parse all memory blocks to remove unusable memory

B K Karthik (1):
      media: atomisp: i2c: atomisp-ov2680.c: fixed a brace coding style iss=
ue.

Baidyanath Kundu (1):
      media: atomisp: Fix __func__ style warnings

Barry Song (1):
      mm/hugetlb: avoid hardcoding while checking if cma is enabled

Bhupesh Sharma (1):
      mm/memcontrol: fix OOPS inside mem_cgroup_get_nr_swap_pages()

Bixuan Cui (1):
      net: neterion: vxge: reduce stack usage in VXGE_COMPLETE_VPATH_TX

Bjorn Helgaas (2):
      virtio-mmio: Reject invalid IRQ 0 command line argument
      Revert "PCI/PM: Assume ports without DLL Link Active train links
in 100 ms"

Boris Burkov (1):
      btrfs: fix mount failure caused by race with umount

Chen-Yu Tsai (1):
      drm: sun4i: hdmi: Fix inverted HPD result

Chengguang Xu (1):
      vfs/xattr: mm/shmem: kernfs: release simple xattr entry in a right wa=
y

Chris Wilson (1):
      sched: Warn if garbage is passed to default_wake_function()

Christophe JAILLET (1):
      hippi: Fix a size used in a 'pci_free_consistent()' in an error
handling path

Chunfeng Yun (1):
      usb: xhci-mtk: fix the failure of bandwidth allocation

Claudiu Manoil (1):
      enetc: Remove the mdio bus on PF probe bailout

Colin Ian King (2):
      media: atomisp: make const arrays static, makes object smaller
      media: atomisp: fix mask and shift operation on ISPSSPM0

Cong Wang (3):
      bonding: check return value of register_netdevice() in bond_newlink()
      geneve: fix an uninitialized value in geneve_changelink()
      qrtr: orphan socket in qrtr_release()

Damien Le Moal (1):
      zonefs: Fix compilation warning

Dan Carpenter (2):
      media: atomisp: Fix error code in ov5693_probe()
      AX.25: Prevent integer overflows in connect and sendmsg

Daniel Baluta (1):
      ASoC: SOF: imx: add min/max channels for SAI/ESAI on i.MX8/i.MX8M

Daniele Albano (1):
      io_uring: always allow drain/link/hardlink/async sqe flags

David Howells (1):
      rxrpc: Fix sendmsg() returning EPIPE due to recvmsg() returning ENODA=
TA

Doug Berger (3):
      net: bcmgenet: test MPD_EN when resuming
      net: bcmgenet: test RBUF_ACPI_EN when resuming
      net: bcmgenet: restore HFB filters on resume

Douglas Anderson (1):
      i2c: i2c-qcom-geni: Fix DMA transfer race

Eddie James (1):
      mmc: sdhci-of-aspeed: Fix clock divider calculation

Egor Pomozov (1):
      net: atlantic: fix PTP on AQC10X

Eric Biggers (1):
      /dev/mem: Add missing memory barriers for devmem_inode

Fabio Estevam (1):
      ASoC: dt-bindings: simple-card: Fix 'make dt_binding_check' warnings

Fangrui Song (1):
      Makefile: Fix GCC_TOOLCHAIN_DIR prefix for Clang cross compilation

Felix Fietkau (2):
      mt76: mt76x02: do not access uninitialized NAPI structs
      mt76: mt7615: fix EEPROM buffer size

Filipe Manana (1):
      btrfs: fix double free on ulist after backref resolution failure

Florian Westphal (1):
      netfilter: nf_tables: fix nat hook table deletion

Forest Crossman (1):
      usb: xhci: Fix ASM2142/ASM3142 DMA addressing

Geert Uytterhoeven (2):
      ASoC: qcom: Drop HAS_DMA dependency to fix link failure
      usb: hso: Fix debug compile warning on sparc32

George Kennedy (1):
      ax88172a: fix ax88172a_unbind() failures

Georgi Djakov (2):
      interconnect: Do not skip aggregation for disabled paths
      interconnect: msm8916: Fix buswidth of pcnoc_s nodes

Gerald Schaefer (1):
      MAINTAINERS: add Matthew for s390 IOMMU

Guillaume Nault (1):
      Documentation: bareudp: update iproute2 sample commands

H. Nikolaus Schaller (1):
      modpost: remove use of non-standard strsep() in HOSTCC code

Hans de Goede (4):
      ASoC: Intel: cht_bsw_rt5672: Change bus format to I2S 2 channel
      ASoC: rt5670: Correct RT5670_LDO_SEL_MASK
      ASoC: rt5670: Add new gpio1_is_ext_spk_en quirk and enable it on
the Lenovo Miix 2 10
      ASoC: rt5670: Fix dac- and adc- vol-tlv values being off by a factor =
of 10

Hauke Mehrtens (1):
      ath10k: Fix NULL pointer dereference in AHB device probe

Helmut Grohne (2):
      tty: xilinx_uartps: Really fix id assignment
      net: dsa: microchip: call phy_remove_link_mode during probe

Herbert Xu (1):
      flow_offload: Move rhashtable inclusion to the source file

Huang Guobin (1):
      net: ag71xx: add missed clk_disable_unprepare in error path of probe

Hugh Dickins (1):
      mm/memcg: fix refcount error while moving and swapping

Hyeongseok Kim (1):
      exfat: fix wrong size update of stream entry by typo

Ian Abbott (4):
      staging: comedi: ni_6527: fix INSN_CONFIG_DIGITAL_TRIG support
      staging: comedi: addi_apci_1032: check INSN_CONFIG_DIGITAL_TRIG shift
      staging: comedi: addi_apci_1500: check INSN_CONFIG_DIGITAL_TRIG shift
      staging: comedi: addi_apci_1564: check INSN_CONFIG_DIGITAL_TRIG shift

Ilya Ponetayev (1):
      exfat: fix name_hash computation on big endian systems

Ioana Ciornei (1):
      dpaa2-eth: check fsl_mc_get_endpoint for IS_ERR_OR_NULL()

J. Bruce Fields (1):
      nfsd4: fix NULL dereference in nfsd/clients display code

Jason Gunthorpe (1):
      RDMA/mlx5: Prevent prefetch from racing with implicit destruction

Jens Axboe (1):
      io_uring: ensure double poll additions work with both request types

Jian Shen (1):
      net: hns3: fix return value error when query MAC link status fail

Jing Xiangfeng (1):
      ASoC: Intel: bytcht_es8316: Add missed put_device()

Jiri Slaby (1):
      iwlwifi: fix crash in iwl_dbg_tlv_alloc_trigger

Joerg Roedel (1):
      x86, vmlinux.lds: Page-align end of ..page_aligned sections

Johan Hovold (2):
      serial: tegra: fix CREAD handling for PIO
      serial: tegra: drop bogus NULL tty-port checks

Johannes Berg (1):
      iwlwifi: mvm: don't call iwl_mvm_free_inactive_queue() under RCU

Johannes Thumshirn (1):
      zonefs: count pages after truncating the iterator

John David Anglin (1):
      parisc: Add atomic64_set_release() define to avoid CPU soft lockups

Jon Hunter (1):
      usb: tegra: Fix allocation for the FPCI context

Joonho Wohn (1):
      ALSA: hda/realtek: Fixed ALC298 sound bug by adding quirk for
Samsung Notebook Pen S

Josh Poimboeuf (2):
      x86/unwind/orc: Fix ORC for newly forked tasks
      x86/stacktrace: Fix reliable check for empty user task stacks

Karsten Graul (12):
      net/smc: handle unexpected response types for confirm link
      net/smc: clear link during SMC client link down processing
      net/smc: fix link lookup for new rdma connections
      net/smc: protect smc ib device initialization
      net/smc: drop out-of-flow llc response messages
      net/smc: move add link processing for new device into llc layer
      net/smc: fix handling of delete link requests
      net/smc: do not call dma sync for unmapped memory
      net/smc: remove freed buffer from list
      net/smc: fix restoring of fallback changes
      net/smc: put slot when connection is killed
      net/smc: fix dmb buffer shortage

Kevin Buettner (1):
      copy_xstate_to_kernel: Fix typo which caused GDB regression

Kirill A. Shutemov (2):
      mm/mmap.c: close race between munmap() and expand_upwards()/downwards=
()
      khugepaged: fix null-pointer dereference due to race

Kuniyuki Iwashima (2):
      udp: Copy has_conns in reuseport_grow().
      udp: Improve load balancing for SO_REUSEPORT.

Laurence Oberman (1):
      qed: Disable "MFW indication via attention" SPAM every 5 minutes

Leon Romanovsky (1):
      RDMA/core: Fix race in rdma_alloc_commit_uobject()

Liam Beguin (1):
      parisc: add support for cmpxchg on u8 pointers

Linus Torvalds (1):
      Linux 5.8-rc7

Liu Jian (3):
      ieee802154: fix one possible memleak in adf7242_probe
      dpaa_eth: Fix one possible memleak in dpaa_eth_probe
      mlxsw: destroy workqueue when trap_register in mlxsw_emad_init

Lorenzo Bianconi (5):
      mt76: add missing lock configuring coverage class
      mt76: mt7615: fix lmac queue debugsfs entry
      mt76: mt7615: fix hw queue mapping
      mt76: overwrite qid for non-bufferable mgmt frames
      mt76: mt7663u: fix memory leaks in mt7663u_probe

Ludovic Desroches (1):
      MAINTAINERS: i2c: at91: handover maintenance to Codrin Ciubotariu

Maor Gottlieb (2):
      RDMA/mlx5: Use xa_lock_irq when access to SRQ table
      RDMA/cm: Protect access to remote_sidr_table

Mark O'Donovan (1):
      ath9k: Fix regression with Atheros 9271

Masahiro Yamada (2):
      efi/libstub/arm64: link stub lib.a conditionally
      kbuild: fix single target builds for external modules

Matthew Gerlach (1):
      fpga: dfl: fix bug in port reset handshake

Matthew Howell (1):
      serial: exar: Fix GPIO configuration for Sealevel cards based on XR17=
V35X

Mauro Carvalho Chehab (15):
      media: atomisp: fix the handling of clock number
      media: atomisp: reorganize the code under gmin_subdev_add()
      media: atomisp: Prepare sensor support for ACPI PM
      media: atomisp: properly parse CLK PMIC on newer devices
      media: atomisp: fix call to g_frame_interval
      media: atomisp: print info if gpio0 and gpio2 were detected
      media: atomisp: split add from find subdev
      media: atomisp: place all gpio parsing together
      media: atomisp: fix help message for ISP2401 selection
      media: atomisp: get rid of some unused static vars
      media: atomisp: remove non-used 32-bits consts at system_local
      media: atomisp: move global stuff into a common header
      media: atomisp: get rid of version-specific system_local.h
      media: atomisp: move system_local consts into a C file
      Revert "media: atomisp: keep the ISP powered on when setting it"

Max Filippov (1):
      xtensa: fix access check in csum_and_copy_from_user

Maxim Kochetkov (1):
      gianfar: Use random MAC address when none is given

Maxime Ripard (1):
      ASoC: core: Remove only the registered component in devm functions

Miaohe Lin (1):
      net: udp: Fix wrong clean up for IS_UDPLITE macro

Michael Chan (1):
      bnxt_en: Fix completion ring sizing with TPA enabled.

Michael J. Ruhl (1):
      io-mapping: indicate mapping failure

Mike Rapoport (1):
      mailmap: add entry for Mike Rapoport

Mikulas Patocka (1):
      dm integrity: fix integrity recalculation that is improperly skipped

Min Li (1):
      docs: ptp.rst: add support for Renesas (IDT) ClockMatrix

Ming Lei (1):
      scsi: core: Run queue in case of I/O resource contention failure

Muchun Song (1):
      mm: memcg/slab: fix memory leak at non-root kmem_cache destroy

Murali Karicheri (4):
      net: hsr: fix incorrect lsdu size in the tag of HSR frames for
small frames
      net: hsr: validate address B before copying to skb
      net: hsr: check for return value of skb_put_padto()
      net: ethernet: ti: add NETIF_F_HW_TC hw feature flag for taprio offlo=
ad

Namjae Jeon (2):
      exfat: fix overflow issue in exfat_cluster_to_sector()
      exfat: fix wrong hint_stat initialization in exfat_find_dir_entry()

Nathan Chancellor (1):
      arm64: vdso32: Fix '--prefix=3D' value for newer versions of clang

Navid Emamdoost (2):
      nfc: s3fwrn5: add missing release on skb in s3fwrn5_recv_frame
      cxgb4: add missing release on skb in uld_send()

Nicolas Boichat (1):
      media: atomisp: Replace trace_printk by pr_info

Nicolas Ferre (1):
      MAINTAINERS: Change Maintainer for some at91 drivers

Nicolin Chen (1):
      MAINTAINERS: Add Shengjiu to reviewer list of sound/soc/fsl

Nikita Danilov (1):
      net: atlantic: disable PTP on AQC111, AQC112

Oded Gabbay (4):
      habanalabs: block WREG_BULK packet on PDMA
      habanalabs: set clock gating per engine
      habanalabs: set 4s timeout for message to device CPU
      habanalabs: prevent possible out-of-bounds array access

Oder Chiou (2):
      ASoC: rt5682: cancel jack_detect_work if hs_jack is set to null
even soundwire mode
      ASoC: rt5682: Report the button event in the headset type only

Oleg Nesterov (1):
      uprobes: Change handle_swbp() to send SIGTRAP with
si_code=3DSI_KERNEL, to fix GDB regression

Paolo Pisati (3):
      selftests: fib_nexthop_multiprefix: fix cleanup() netns deletion
      selftests: net: ip_defrag: modprobe missing nf_defrag_ipv6 support
      selftest: txtimestamp: fix net ns entry logic

Pavel Begunkov (1):
      io_uring: missed req_init_async() for IOSQE_ASYNC

Pawe=C5=82 Gronowski (1):
      drm/amdgpu: Fix NULL dereference in dpm sysfs handlers

Peilin Ye (2):
      AX.25: Fix out-of-bounds read in ax25_connect()
      AX.25: Prevent out-of-bounds read in ax25_sendmsg()

Peter Zijlstra (1):
      sched: Fix race against ptrace_freeze_trace()

Phillip Lougher (1):
      squashfs: fix length field overlap check in metadata reading

Pi-Hsun Shih (1):
      scripts/decode_stacktrace: strip basepath from all paths

Pierre-Louis Bossart (4):
      ASoC: soc-dai: set dai_link dpcm_ flags with a helper
      ASoC: Intel: bdw-rt5677: fix non BE conversion
      ASoC: topology: fix kernel oops on route addition error
      ASoC: topology: fix tlvs in error handling for widget_dmixer

Puyou Lu (2):
      ASoC: wm8974: fix Boost Mixer Aux Switch
      ASoC: wm8974: remove unsupported clock mode

Qiang Yu (1):
      drm/lima: fix wait pp reset timeout

Qiu Wenbo (1):
      drm/amd/powerplay: fix a crash when overclocking Vega M

Qu Wenruo (1):
      btrfs: qgroup: fix data leak caused by race between writeback and tru=
ncate

Randy Dunlap (2):
      rhashtable: drop duplicated word in <linux/rhashtable.h>
      i2c: drop duplicated word in the header file

Ranjani Sridharan (1):
      ASoC: SOF: core: fix null-ptr-deref bug during device removal

Raviteja Narayanam (2):
      Revert "i2c: cadence: Fix the hold bit setting"
      i2c: cadence: Clear HOLD bit at correct time in Rx path

Ravulapati Vishnu vardhan rao (1):
      ASoC: amd: Rectifying Unbalanced pm_runtime_enable! issue

Rob Clark (1):
      iommu/qcom: Use domain rather than dev as tlb cookie

Robbie Ko (1):
      btrfs: fix page leaks after failure to lock page for delalloc

Russell King (2):
      net: dsa: mv88e6xxx: fix in-band AN link establishment
      arm64: dts: clearfog-gt-8k: fix switch link configuration

Rustam Kovhaev (1):
      staging: wlan-ng: properly check endpoint types

Ryan Lee (1):
      ASoC: codecs: max98373: Removed superfluous volume control from
chip default

Serge Semin (1):
      serial: 8250_mtk: Fix high-speed baud rates clamping

Sergey Organov (2):
      net: fec: fix hardware time stamping by external devices
      net: dp83640: fix SIOCSHWTSTAMP to update the struct with actual
configuration

Shannon Nelson (5):
      ionic: use offset for ethtool regs data
      ionic: fix up filter locks and debug msgs
      ionic: update filter id after replay
      ionic: keep rss hash after fw update
      ionic: use mutex to protect queue operations

Shuming Fan (1):
      ASoC: rt286: fix unexpected interrupt happens

Stefano Garzarella (2):
      vsock/virtio: annotate 'the_virtio_vsock' RCU pointer
      scripts/gdb: fix lx-symbols 'gdb.error' while loading modules

Steve French (1):
      Revert "cifs: Fix the target file was deleted when rename failed."

Subash Abhinov Kasiviswanathan (1):
      dev: Defer free of skbs in flush_backlog

Taehee Yoo (2):
      bonding: check error value of register_netdevice() immediately
      netdevsim: fix unbalaced locking in nsim_create()

Takashi Iwai (1):
      ALSA: info: Drop WARN_ON() from buffer NULL sanity check

Tetsuo Handa (3):
      vt: Reject zero-sized screen buffer size.
      binder: Don't use mmput() from shrinker function.
      fbdev: Detect integer underflow at "struct fbcon_ops"->clear_margins.

Thomas Gleixner (1):
      x86/dumpstack: Dump user space code correctly again

Thomas Richter (1):
      s390/cpum_cf,perf: change DFLT_CCERROR counter name

Tom Rix (1):
      mm: initialize return of vm_insert_pages

Tony Lindgren (1):
      clocksource/drivers/timer-ti-dm: Fix suspend and resume for am3 and a=
m4

Tung Nguyen (1):
      tipc: allow to build NACK message in link timeout function

Vadim Pasternak (1):
      mlxsw: core: Fix wrong SFP EEPROM reading for upper pages 1-3

Vasundhara Volam (2):
      bnxt_en: Fix race when modifying pause settings.
      bnxt_en: Init ethtool link settings after reading updated PHY
configuration.

Vinay Kumar Yadav (2):
      crypto/chtls: fix tls alert messages corrupted by tls data
      crypto/chtls: correct net_device reference count

Vincent Chen (1):
      riscv: kasan: use local_tlb_flush_all() to avoid uninitialized
__sbi_rfence

Wang Hai (3):
      net: smc91x: Fix possible memory leak in smc_drv_probe()
      nfc: nci: add missed destroy_workqueue in nci_register_device
      net: ethernet: ave: Fix error returns in ave_init

Wei Yongjun (1):
      ip6_gre: fix null-ptr-deref in ip6gre_init_net()

Weihang Li (1):
      RDMA/hns: Fix wrong assignment of lp_pktn_ini in QPC

Weilong Chen (1):
      rtnetlink: Fix memory(net_device) leak when ->newlink fails

Wolfram Sang (1):
      i2c: rcar: always clear ICSAR to avoid side effects

Xi Wang (1):
      RDMA/hns: Fix wrong PBL offset when VA is not aligned to PAGE_SIZE

Xie He (2):
      drivers/net/wan/x25_asy: Fix to make it work
      drivers/net/wan: lapb: Corrected the usage of skb_cow

Xin Long (2):
      sctp: shrink stream outq only when new outcnt < old outcnt
      sctp: shrink stream outq when fails to do addstream reconf

Xiongfeng Wang (1):
      net-sysfs: add a newline when printing 'tx_timeout' by sysfs

Xu Yilun (1):
      fpga: dfl: pci: reduce the scope of variable 'ret'

Yang Yingliang (1):
      serial: 8250: fix null-ptr-deref in serial8250_start_tx()

Yoshihiro Shimoda (1):
      net: ethernet: ravb: exit if re-initialization fails in tx timeout

Yu-Hsuan Hsu (1):
      ASoC: rockchip: add format and rate constraints on rk3399

Yuchung Cheng (1):
      tcp: allow at most one TLP probe per flight

Yunsheng Lin (3):
      net: hns3: fix for not unmapping TX buffer correctly
      net: hns3: fix for not calculating TX BD send size correctly
      net: hns3: fix error handling for desc filling

Zeng Tao (1):
      vfio/pci: fix racy on error and request eventfd ctx

Zhang Changzhong (2):
      net: bcmgenet: fix error returns in bcmgenet_probe()
      net: bcmgenet: add missed clk_disable_unprepare in bcmgenet_probe

derek.fang (1):
      ASoC: rt5682: Enable Vref2 under using PLL2

guodeqing (1):
      ipvs: fix the connection sync failed in some cases

randerwang (1):
      ASoc: codecs: max98373: remove Idle_bias_on to let codec suspend

wenxu (1):
      net/sched: act_ct: fix restore the qdisc_skb_cb after defrag
