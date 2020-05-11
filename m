Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E59C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F41220746
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbgEKNrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 09:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726438AbgEKNrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:47:14 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45579C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 06:47:13 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:702c:fb99:3097:2049])
        by michel.telenet-ops.be with bizsmtp
        id dRn82200J0GoAb606Rn88S; Mon, 11 May 2020 15:47:10 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jY8lw-0006mX-BH
        for linux-kernel@vger.kernel.org; Mon, 11 May 2020 15:47:08 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jY8lw-0002OR-81
        for linux-kernel@vger.kernel.org; Mon, 11 May 2020 15:47:08 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.7-rc5
Date:   Mon, 11 May 2020 15:47:08 +0200
Message-Id: <20200511134708.9156-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v5.7-rc5[1] compared to v5.6[2].

Summarized:
  - build errors: +1/-7
  - build warnings: +70/-93

JFYI, when comparing v5.7-rc5[1] to v5.7-rc4[3], the summaries are:
  - build errors: +0/-4
  - build warnings: +19/-57

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/2ef96a5bb12be62ef75b5828c0aab838ebb29cb8/ (all 239 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/7111951b8d4973bda27ff663f2cf18b663d15b48/ (all 239 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/0e698dfa282211e414076f9dc7e83c1c288314fd/ (all 239 configs)


*** ERRORS ***

1 error regressions:
  + error: modpost: "__delay" [drivers/net/phy/mdio-cavium.ko] undefined!:  => N/A

7 error improvements:
  - error: "__delay" [drivers/net/phy/mdio-cavium.ko] undefined!: N/A => 
  - error: "devm_ioremap_resource" [drivers/net/ethernet/xilinx/xilinx_emac.ko] undefined!: N/A => 
  - error: "devm_ioremap_resource" [drivers/ptp/ptp_ines.ko] undefined!: N/A => 
  - error: arch/sparc/kernel/head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text': (.head.text+0x5040), (.head.text+0x5100) => 
  - error: arch/sparc/kernel/head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o: (.init.text+0xa4) => 
  - error: arch/sparc/kernel/process_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text': (.fixup+0xc), (.fixup+0x4) => 
  - error: arch/sparc/kernel/signal_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text': (.fixup+0x34), (.fixup+0x4), (.fixup+0x10), (.fixup+0x28), (.fixup+0x1c) => 


*** WARNINGS ***

70 warning regressions:
  + /kisskb/src/block/genhd.c: warning: the frame size of 1688 bytes is larger than 1280 bytes [-Wframe-larger-than=]:  => 1617:1
  + /kisskb/src/block/genhd.c: warning: the frame size of 1720 bytes is larger than 1280 bytes [-Wframe-larger-than=]:  => 1617:1
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c: warning: (near initialization for 'dcn2_0_nv12_soc.clock_limits') [-Wmissing-braces]:  => 451:8
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c: warning: missing braces around initializer [-Wmissing-braces]:  => 451:8
  + /kisskb/src/drivers/gpu/drm/bridge/tc358768.c: warning: the frame size of 2224 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 840:1
  + /kisskb/src/drivers/iio/dac/ad5770r.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]:  => 516:6
  + /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en/health.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]:  => 264:6
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_probe' uses dynamic stack allocation:  => 544:1
  + /kisskb/src/drivers/staging/octeon/ethernet-mem.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]:  => 123:18
  + /kisskb/src/drivers/tty/n_tty.c: warning: format '%zu' expects argument of type 'size_t', but argument 3 has type 'unsigned int' [-Wformat=]:  => 2059:14, 2037:14
  + /kisskb/src/drivers/tty/n_tty.c: warning: format '%zu' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat=]:  => 2037:14
  + /kisskb/src/drivers/tty/n_tty.c: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'unsigned int' [-Wformat=]:  => 2059:14, 2037:14
  + /kisskb/src/drivers/tty/n_tty.c: warning: format '%zu' expects argument of type 'size_t', but argument 6 has type 'unsigned int' [-Wformat=]:  => 2059:14, 2037:14
  + /kisskb/src/drivers/tty/n_tty.c: warning: format '%zu' expects argument of type 'size_t', but argument 7 has type 'unsigned int' [-Wformat=]:  => 2059:14
  + /kisskb/src/drivers/tty/n_tty.c: warning: format '%zu' expects argument of type 'size_t', but argument 8 has type 'unsigned int' [-Wformat=]:  => 2059:14
  + /kisskb/src/drivers/vhost/vdpa.c: warning: 'map_pfn' may be used uninitialized in this function [-Wuninitialized]:  => 576:52
  + /kisskb/src/fs/mpage.c: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 690:1
  + /kisskb/src/fs/namei.c: warning: 'inode' may be used uninitialized in this function [-Wuninitialized]:  => 1805:10
  + /kisskb/src/fs/namei.c: warning: 'seq' may be used uninitialized in this function [-Wuninitialized]:  => 1805:10
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_cgroup_output' uses dynamic stack allocation:  => 7831:1
  + /kisskb/src/kernel/futex.c: warning: 'oldval' may be used uninitialized in this function [-Wuninitialized]:  => 1676:3, 1686:3
  + /kisskb/src/kernel/trace/ftrace.c: warning: 'filtered_pids' may be used uninitialized in this function [-Wuninitialized]:  => 7245:23, 7245:6
  + /kisskb/src/kernel/trace/ftrace.c: warning: 'other_pids' may be used uninitialized in this function [-Wuninitialized]:  => 7262:25, 7262:22
  + /kisskb/src/kernel/trace/ftrace.c: warning: 'seq_ops' may be used uninitialized in this function [-Wuninitialized]:  => 7167:6
  + /kisskb/src/mm/memory.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]:  => 1614:2
  + /kisskb/src/net/mptcp/protocol.c: warning: 'dfrag_collapsed' may be used uninitialized in this function [-Wuninitialized]:  => 606:6
  + modpost: WARNING: modpost: "clear_page" [drivers/md/dm-integrity.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "clear_page" [drivers/md/raid456.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "clear_page" [drivers/scsi/sd_mod.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "clear_page" [fs/btrfs/btrfs.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "clear_page" [fs/fuse/fuse.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "clear_page" [fs/gfs2/gfs2.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "clear_page" [fs/ntfs/ntfs.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "clear_page" [fs/ocfs2/dlm/ocfs2_dlm.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "copy_page" [drivers/block/drbd/drbd.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "copy_page" [drivers/md/dm-integrity.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "copy_page" [fs/btrfs/btrfs.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "copy_page" [fs/cachefiles/cachefiles.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "copy_page" [fs/fuse/fuse.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "copy_page" [fs/nilfs2/nilfs2.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "saved_config" [vmlinux] is COMMON symbol:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "clear_page" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "copy_page" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: lib/test_bitmap.o(.text.unlikely+0x58): Section mismatch in reference from the function bitmap_equal() to the variable .init.rodata:clump_exp:  => N/A
  + modpost: WARNING: modpost: vmlinux.o (.PPC.EMB.apuinfo): unexpected non-allocatable section.:  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text+0x31668): Section mismatch in reference from the function setup_scache() to the function .init.text:loongson3_sc_init():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text+0x36888): Section mismatch in reference from the function mips_sc_init() to the function .init.text:mips_sc_probe_cm3():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x1a0): Section mismatch in reference from the function early_init_mmu() to the function .init.text:radix__early_init_mmu():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x1ac): Section mismatch in reference from the function early_init_mmu() to the function .init.text:hash__early_init_mmu():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x2a74): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x2a78): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x2b0): Section mismatch in reference from the function early_init_mmu() to the function .init.text:radix__early_init_mmu():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x2bc): Section mismatch in reference from the function early_init_mmu() to the function .init.text:hash__early_init_mmu():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x2c7c): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x2c80): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x2cd0): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x2ed8): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x3c64): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x3c74): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x3c78): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x3c88): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x3c90): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x3ca4): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x3f44): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x3f54): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x3f70): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x5e4): Section mismatch in reference from the function .smp_setup_pacas() to the function .init.text:.allocate_paca():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x81c): Section mismatch in reference from the function .smp_setup_pacas() to the function .init.text:.allocate_paca():  => N/A
  + warning: unmet direct dependencies detected for SND_SOC_WM9712:  => N/A

93 warning improvements:
  - /kisskb/src/arch/m68k/include/asm/string.h: warning: '__builtin_memcpy' forming offset 8 is out of the bounds [0, 7] [-Warray-bounds]: 72:25 => 
  - /kisskb/src/arch/powerpc/include/asm/epapr_hcalls.h: warning: array subscript 1 is outside array bounds of 'const char[1]' [-Warray-bounds]: 298:20 => 
  - /kisskb/src/arch/powerpc/include/asm/epapr_hcalls.h: warning: array subscript 2 is outside array bounds of 'const char[1]' [-Warray-bounds]: 299:20 => 
  - /kisskb/src/arch/powerpc/include/asm/epapr_hcalls.h: warning: array subscript 3 is outside array bounds of 'const char[1]' [-Warray-bounds]: 300:20 => 
  - /kisskb/src/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c: warning: (near initialization for 'opts.mipi_dphy') [-Wmissing-braces]: 722:8 => 
  - /kisskb/src/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c: warning: missing braces around initializer [-Wmissing-braces]: 722:8 => 
  - /kisskb/src/drivers/i2c/busses/i2c-sh_mobile.c: warning: 'data' may be used uninitialized in this function [-Wmaybe-uninitialized]: 399:26 => 
  - /kisskb/src/drivers/net/ethernet/i825xx/sun3_82586.c: warning: array subscript 1 is above array bounds of 'volatile struct transmit_cmd_struct *[1]' [-Warray-bounds]: 993:108 => 
  - /kisskb/src/drivers/net/wireless/realtek/rtw88/pci.c: warning: 'rtw_pci_resume' defined but not used [-Wunused-function]: 1296:12 => 
  - /kisskb/src/drivers/net/wireless/realtek/rtw88/pci.c: warning: 'rtw_pci_suspend' defined but not used [-Wunused-function]: 1291:12 => 
  - /kisskb/src/drivers/pwm/pwm-fsl-ftm.c: warning: 'periodcfg' may be used uninitialized in this function [-Wmaybe-uninitialized]: 280:15 => 
  - /kisskb/src/drivers/pwm/pwm-fsl-ftm.c: warning: 'periodcfg.clk_ps' may be used uninitialized in this function [-Wmaybe-uninitialized]: 82:20 => 
  - /kisskb/src/drivers/pwm/pwm-fsl-ftm.c: warning: 'periodcfg.mod_period' may be used uninitialized in this function [-Wmaybe-uninitialized]: 278:3, 84:24 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_dev_init' uses dynamic stack allocation: 491:1 => 
  - /kisskb/src/drivers/usb/gadget/udc/fsl_qe_udc.c: warning: 'udc' may be used uninitialized in this function [-Wmaybe-uninitialized]: 1840:14 => 
  - /kisskb/src/drivers/usb/host/fhci-hcd.c: warning: this statement may fall through [-Wimplicit-fallthrough=]: 398:8 => 
  - /kisskb/src/fs/afs/dynroot.c: warning: 'len' may be used uninitialized in this function [-Wmaybe-uninitialized]: 117:6 => 
  - /kisskb/src/fs/cifs/smb2pdu.c: warning: 'in_data_buf' may be used uninitialized in this function [-Wmaybe-uninitialized]: 2845:19 => 
  - /kisskb/src/fs/mpage.c: warning: the frame size of 1148 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 690:1 => 
  - /kisskb/src/include/linux/regmap.h: warning: 'periodcfg.clk_ps' may be used uninitialized in this function [-Wmaybe-uninitialized]: 75:2 => 
  - /kisskb/src/include/linux/spinlock.h: warning: 'flags' may be used uninitialized in this function [-Wmaybe-uninitialized]: 288:3 => 
  - /kisskb/src/include/linux/spinlock.h: warning: 'flags' may be used uninitialized in this function [-Wuninitialized]: 393:2 => 
  - /kisskb/src/include/linux/unaligned/le_byteshift.h: warning: array subscript is above array bounds [-Warray-bounds]: 26:7 => 
  - /kisskb/src/kernel/padata.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 539:2 => 
  - /kisskb/src/mm/memcontrol.c: warning: 'mem_cgroup_id_get_many' defined but not used [-Wunused-function]: 4864:13 => 
  - /kisskb/src/net/ipv4/tcp_input.c: warning: array subscript is above array bounds [-Warray-bounds]: 4398:49 => 
  - /kisskb/src/security/apparmor/policy_unpack.c: warning: 'pos' may be used uninitialized in this function [-Wmaybe-uninitialized]: 526:9 => 
  - warning: "clear_page" [drivers/md/dm-integrity.ko] has no CRC!: N/A => 
  - warning: "clear_page" [drivers/md/raid456.ko] has no CRC!: N/A => 
  - warning: "clear_page" [drivers/scsi/sd_mod.ko] has no CRC!: N/A => 
  - warning: "clear_page" [fs/btrfs/btrfs.ko] has no CRC!: N/A => 
  - warning: "clear_page" [fs/fuse/fuse.ko] has no CRC!: N/A => 
  - warning: "clear_page" [fs/gfs2/gfs2.ko] has no CRC!: N/A => 
  - warning: "clear_page" [fs/ntfs/ntfs.ko] has no CRC!: N/A => 
  - warning: "clear_page" [fs/ocfs2/dlm/ocfs2_dlm.ko] has no CRC!: N/A => 
  - warning: "copy_page" [drivers/block/drbd/drbd.ko] has no CRC!: N/A => 
  - warning: "copy_page" [drivers/md/dm-integrity.ko] has no CRC!: N/A => 
  - warning: "copy_page" [fs/btrfs/btrfs.ko] has no CRC!: N/A => 
  - warning: "copy_page" [fs/cachefiles/cachefiles.ko] has no CRC!: N/A => 
  - warning: "copy_page" [fs/fuse/fuse.ko] has no CRC!: N/A => 
  - warning: "copy_page" [fs/nilfs2/nilfs2.ko] has no CRC!: N/A => 
  - warning: "saved_config" [vmlinux] is COMMON symbol: N/A => 
  - warning: EXPORT symbol "___rw_read_enter" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "___rw_read_exit" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "___rw_read_try" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "___rw_write_enter" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "__ashldi3" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "__ashrdi3" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "__copy_1page" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "__divdi3" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "__lshrdi3" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "__muldi3" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "__ndelay" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "__udelay" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "_mcount" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "bzero_1page" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "clear_page" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "copy_page" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "empty_zero_page" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: lib/test_bitmap.o(.text.unlikely+0x58): Section mismatch in reference from the function bitmap_equal() to the variable .init.rodata:clump_exp: N/A => 
  - warning: same module names found:: N/A => 
  - warning: unmet direct dependencies detected for SPI_PXA2XX: N/A => 
  - warning: vmlinux.o (.PPC.EMB.apuinfo): unexpected non-allocatable section.: N/A => 
  - warning: vmlinux.o(.text+0x2e1c): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x2fc8): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel(): N/A => 
  - warning: vmlinux.o(.text+0x314c8): Section mismatch in reference from the function setup_scache() to the function .init.text:loongson3_sc_init(): N/A => 
  - warning: vmlinux.o(.text+0x31d4): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x31dc): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x31e4): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x33c8): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel(): N/A => 
  - warning: vmlinux.o(.text+0x36698): Section mismatch in reference from the function mips_sc_init() to the function .init.text:mips_sc_probe_cm3(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x114): Section mismatch in reference from the function .setup_secure_guest() to the function .init.text:.prom_printf(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x160): Section mismatch in reference from the function .setup_secure_guest() to the function .init.text:.prom_printf(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x180): Section mismatch in reference from the function .setup_secure_guest() to the function .init.text:.call_prom(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x1b0): Section mismatch in reference from the function .setup_secure_guest() to the function .init.text:.prom_getprop(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x1c8): Section mismatch in reference from the function .setup_secure_guest() to the function .init.text:.prom_panic(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2b74): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2b78): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2d7c): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2d80): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2dd0): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2fd8): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3d64): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3d74): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3d78): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3d88): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3d90): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3da4): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x4044): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x4054): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x4070): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x874): Section mismatch in reference from the function .smp_setup_pacas() to the function .init.text:.allocate_paca(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0xaac): Section mismatch in reference from the function .smp_setup_pacas() to the function .init.text:.allocate_paca(): N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
