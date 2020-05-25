Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74F2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4A942071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388867AbgEYIiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 04:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387973AbgEYIiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 04:38:12 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D28C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 01:38:11 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:44fd:9440:53b:cc34])
        by albert.telenet-ops.be with bizsmtp
        id iwe72200R5QlbNy06we78P; Mon, 25 May 2020 10:38:08 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jd8cZ-0007gy-Ib
        for linux-kernel@vger.kernel.org; Mon, 25 May 2020 10:38:07 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jd816-0006Ge-Sv
        for linux-kernel@vger.kernel.org; Mon, 25 May 2020 09:59:24 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.7-rc7
Date:   Mon, 25 May 2020 09:59:24 +0200
Message-Id: <20200525075924.23960-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v5.7-rc7[1] compared to v5.6[2].

Summarized:
  - build errors: +4/-8
  - build warnings: +51/-253

JFYI, when comparing v5.7-rc7[1] to v5.7-rc6[3], the summaries are:
  - build errors: +4/-0
  - build warnings: +0/-0

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/9cb1fd0efd195590b828b9b865421ad345a4a145/ (194 out of 239 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/7111951b8d4973bda27ff663f2cf18b663d15b48/ (all 239 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce/ (194 out of 239 configs)


*** ERRORS ***

4 error regressions:
  + error: modpost: "devm_ioremap" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A
  + error: modpost: "devm_ioremap_resource" [drivers/net/ethernet/xilinx/xilinx_emac.ko] undefined!:  => N/A
  + error: modpost: "devm_ioremap_resource" [drivers/ptp/ptp_ines.ko] undefined!:  => N/A
  + error: modpost: "devm_of_iomap" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A

8 error improvements:
  - error: "__delay" [drivers/net/phy/mdio-cavium.ko] undefined!: N/A => 
  - error: "devm_ioremap_resource" [drivers/net/ethernet/xilinx/xilinx_emac.ko] undefined!: N/A => 
  - error: "devm_ioremap_resource" [drivers/ptp/ptp_ines.ko] undefined!: N/A => 
  - error: arch/sparc/kernel/head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text': (.head.text+0x5100), (.head.text+0x5040) => 
  - error: arch/sparc/kernel/head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o: (.init.text+0xa4) => 
  - error: arch/sparc/kernel/process_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text': (.fixup+0xc), (.fixup+0x4) => 
  - error: arch/sparc/kernel/signal_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text': (.fixup+0x10), (.fixup+0x1c), (.fixup+0x4), (.fixup+0x34), (.fixup+0x28) => 
  - error: page_alloc.c: undefined reference to `node_reclaim_distance': .text+0x3180), .text+0x3148) => 


*** WARNINGS ***

51 warning regressions:
  + /kisskb/src/arch/powerpc/kernel/head_40x.S: Warning: invalid register expression:  => 805
  + /kisskb/src/block/genhd.c: warning: the frame size of 1168 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 1617:1
  + /kisskb/src/block/genhd.c: warning: the frame size of 1192 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 1617:1
  + /kisskb/src/block/genhd.c: warning: the frame size of 1688 bytes is larger than 1280 bytes [-Wframe-larger-than=]:  => 1617:1
  + /kisskb/src/block/genhd.c: warning: the frame size of 1720 bytes is larger than 1280 bytes [-Wframe-larger-than=]:  => 1617:1
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c: warning: (near initialization for 'dcn2_0_nv12_soc.clock_limits') [-Wmissing-braces]:  => 451:8
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c: warning: missing braces around initializer [-Wmissing-braces]:  => 451:8
  + /kisskb/src/drivers/gpu/drm/bridge/tc358768.c: warning: the frame size of 2224 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 840:1
  + /kisskb/src/drivers/net/ethernet/aurora/nb8800.h: warning: "TCR_DIE" redefined: 92 => 92:0, 92
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_probe' uses dynamic stack allocation:  => 546:1
  + /kisskb/src/drivers/sh/clk/cpg.c: warning: passing argument 1 of 'ioread16' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]:  => 46:18
  + /kisskb/src/drivers/sh/clk/cpg.c: warning: passing argument 1 of 'ioread16' discards 'const' qualifier from pointer target type:  => 46:18
  + /kisskb/src/drivers/sh/clk/cpg.c: warning: passing argument 1 of 'ioread32' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]:  => 51:18
  + /kisskb/src/drivers/sh/clk/cpg.c: warning: passing argument 1 of 'ioread32' discards 'const' qualifier from pointer target type:  => 51:18
  + /kisskb/src/drivers/sh/clk/cpg.c: warning: passing argument 1 of 'ioread8' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]:  => 41:17
  + /kisskb/src/drivers/sh/clk/cpg.c: warning: passing argument 1 of 'ioread8' discards 'const' qualifier from pointer target type:  => 41:17
  + /kisskb/src/drivers/tty/n_tty.c: warning: format '%zu' expects argument of type 'size_t', but argument 3 has type 'unsigned int' [-Wformat=]:  => 2059:14, 2037:14
  + /kisskb/src/drivers/tty/n_tty.c: warning: format '%zu' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat=]:  => 2037:14
  + /kisskb/src/drivers/tty/n_tty.c: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'unsigned int' [-Wformat=]:  => 2059:14, 2037:14
  + /kisskb/src/drivers/tty/n_tty.c: warning: format '%zu' expects argument of type 'size_t', but argument 6 has type 'unsigned int' [-Wformat=]:  => 2059:14, 2037:14
  + /kisskb/src/drivers/tty/n_tty.c: warning: format '%zu' expects argument of type 'size_t', but argument 7 has type 'unsigned int' [-Wformat=]:  => 2059:14
  + /kisskb/src/drivers/tty/n_tty.c: warning: format '%zu' expects argument of type 'size_t', but argument 8 has type 'unsigned int' [-Wformat=]:  => 2059:14
  + /kisskb/src/fs/ntfs/aops.c: warning: the frame size of 2192 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 1311:1
  + /kisskb/src/include/linux/err.h: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]:  => 22:49
  + /kisskb/src/include/linux/sh_intc.h: warning: division 'sizeof (void *) / sizeof (void)' does not compute the number of array elements [-Wsizeof-pointer-div]:  => 100:63
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_cgroup_output' uses dynamic stack allocation:  => 7831:1
  + /kisskb/src/lib/zstd/compress.c: warning: the frame size of 1384 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 1393:1
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
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x1a0): Section mismatch in reference from the function early_init_mmu() to the function .init.text:radix__early_init_mmu():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x1ac): Section mismatch in reference from the function early_init_mmu() to the function .init.text:hash__early_init_mmu():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x2b0): Section mismatch in reference from the function early_init_mmu() to the function .init.text:radix__early_init_mmu():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x2bc): Section mismatch in reference from the function early_init_mmu() to the function .init.text:hash__early_init_mmu():  => N/A
  + warning: unmet direct dependencies detected for SND_SOC_WM9712:  => N/A

253 warning improvements:
  - .config: warning: override: reassigning to symbol MIPS_CPS_NS16550_SHIFT: 11987, 11986, 11981, 11983 => 12169, 12164, 12168
  - /kisskb/src/arch/m68k/include/asm/string.h: warning: '__builtin_memcpy' forming offset 8 is out of the bounds [0, 7] [-Warray-bounds]: 72:25 => 
  - /kisskb/src/arch/mips/include/asm/sibyte/bcm1480_scd.h: warning: "M_SPC_CFG_CLEAR" redefined [enabled by default]: 261:0 => 
  - /kisskb/src/arch/mips/include/asm/sibyte/bcm1480_scd.h: warning: "M_SPC_CFG_ENABLE" redefined [enabled by default]: 262:0 => 
  - /kisskb/src/arch/powerpc/include/asm/epapr_hcalls.h: warning: array subscript 1 is outside array bounds of 'const char[1]' [-Warray-bounds]: 298:20 => 
  - /kisskb/src/arch/powerpc/include/asm/epapr_hcalls.h: warning: array subscript 2 is outside array bounds of 'const char[1]' [-Warray-bounds]: 299:20 => 
  - /kisskb/src/arch/powerpc/include/asm/epapr_hcalls.h: warning: array subscript 3 is outside array bounds of 'const char[1]' [-Warray-bounds]: 300:20 => 
  - /kisskb/src/arch/powerpc/include/asm/io-defs.h: warning: 'px_cmd' may be used uninitialized in this function [-Wuninitialized]: 12:1 => 
  - /kisskb/src/arch/powerpc/include/asm/io-defs.h: warning: 'px_is' may be used uninitialized in this function [-Wuninitialized]: 12:1 => 
  - /kisskb/src/arch/sh/kernel/cpu/sh2/../../entry-common.S: Warning: overflow in branch to __restore_all; converted into longer instruction sequence: 85 => 
  - /kisskb/src/arch/sh/kernel/cpu/sh2/../../entry-common.S: Warning: overflow in branch to syscall_call; converted into longer instruction sequence: 204 => 
  - /kisskb/src/arch/sh/kernel/cpu/sh2/../../entry-common.S: Warning: overflow in branch to syscall_trace_entry; converted into longer instruction sequence: 354, 352 => 
  - /kisskb/src/arch/sh/kernel/cpu/sh4a/setup-sh7786.c: warning: 'tmu3_device' defined but not used [-Wunused-variable]: 243:31 => 
  - /kisskb/src/arch/sh/math-emu/math.c: warning: "READ" redefined [enabled by default]: 55:0 => 
  - /kisskb/src/arch/sh/math-emu/math.c: warning: "WRITE" redefined [enabled by default]: 54:0 => 
  - /kisskb/src/arch/sh/math-emu/math.c: warning: 'ieee_fpe_handler' defined but not used [-Wunused-function]: 505:12 => 
  - /kisskb/src/arch/x86/kernel/apic/io_apic.c: warning: 'irq' may be used uninitialized in this function [-Wuninitialized]: 1037:6 => 
  - /kisskb/src/arch/x86/kernel/e820.c: warning: 'gapstart' may be used uninitialized in this function [-Wuninitialized]: 665:16 => 
  - /kisskb/src/drivers/base/regmap/regmap.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 2598:6, 1859:6 => 
  - /kisskb/src/drivers/clk/sunxi-ng/ccu_mux.c: warning: 'best_parent' may be used uninitialized in this function [-Wuninitialized]: 150:22 => 
  - /kisskb/src/drivers/crypto/inside-secure/safexcel_cipher.c: warning: the frame size of 1068 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 521:1 => 
  - /kisskb/src/drivers/crypto/inside-secure/safexcel_cipher.c: warning: the frame size of 1088 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 521:1 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.c: warning: 'PixelPTEReqHeightPTEs' may be used uninitialized in this function [-Wuninitialized]: 1450:37 => 
  - /kisskb/src/drivers/gpu/drm/nouveau/nvkm/subdev/top/gk104.c: warning: 'inst' may be used uninitialized in this function [-Wuninitialized]: 104:1 => 
  - /kisskb/src/drivers/gpu/drm/nouveau/nvkm/subdev/top/gk104.c: warning: 'type' may be used uninitialized in this function [-Wuninitialized]: 104:1 => 
  - /kisskb/src/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c: warning: (near initialization for 'opts.mipi_dphy') [-Wmissing-braces]: 722:8 => 
  - /kisskb/src/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c: warning: missing braces around initializer [-Wmissing-braces]: 722:8 => 
  - /kisskb/src/drivers/hwmon/drivetemp.c: warning: 'temp_raw' may be used uninitialized in this function [-Wuninitialized]: 250:9, 250:20 => 
  - /kisskb/src/drivers/hwmon/f71805f.c: warning: 'address' may be used uninitialized in this function [-Wuninitialized]: 1626:26 => 
  - /kisskb/src/drivers/hwmon/w83627ehf.c: warning: 'address' may be used uninitialized in this function [-Wuninitialized]: 2176:30 => 
  - /kisskb/src/drivers/hwmon/w83627hf.c: warning: 'address' may be used uninitialized in this function [-Wuninitialized]: 1980:27 => 
  - /kisskb/src/drivers/i2c/busses/i2c-mlxcpld.c: warning: 'datalen' may be used uninitialized in this function [-Wuninitialized]: 340:7 => 
  - /kisskb/src/drivers/i2c/busses/i2c-mlxcpld.c: warning: 'val' is used uninitialized in this function [-Wuninitialized]: 209:6 => 
  - /kisskb/src/drivers/i2c/busses/i2c-mlxcpld.c: warning: 'val' may be used uninitialized in this function [-Wuninitialized]: 271:6, 513:11, 337:25 => 
  - /kisskb/src/drivers/i2c/busses/i2c-sh_mobile.c: warning: 'data' may be used uninitialized in this function [-Wmaybe-uninitialized]: 399:26 => 
  - /kisskb/src/drivers/i2c/busses/i2c-sh_mobile.c: warning: 'data' may be used uninitialized in this function [-Wuninitialized]: 399:26 => 
  - /kisskb/src/drivers/iio/adc/ad7606_par.c: warning: unused variable 'st' [-Wunused-variable]: 36:23, 21:23 => 
  - /kisskb/src/drivers/iio/imu/bmi160/bmi160_core.c: warning: 'int_latch_mask' may be used uninitialized in this function [-Wuninitialized]: 599:29 => 
  - /kisskb/src/drivers/iio/imu/bmi160/bmi160_core.c: warning: 'int_map_mask' may be used uninitialized in this function [-Wuninitialized]: 606:29 => 
  - /kisskb/src/drivers/iio/imu/bmi160/bmi160_core.c: warning: 'int_out_ctrl_shift' may be used uninitialized in this function [-Wuninitialized]: 577:47 => 
  - /kisskb/src/drivers/iio/imu/bmi160/bmi160_core.c: warning: 'pin_name' may be used uninitialized in this function [-Wuninitialized]: 618:3 => 
  - /kisskb/src/drivers/infiniband/sw/siw/siw_qp_tx.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 528:23 => 
  - /kisskb/src/drivers/iommu/fsl_pamu_domain.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 90:9 => 
  - /kisskb/src/drivers/iommu/io-pgtable-arm-v7s.c: warning: 'cptep' may be used uninitialized in this function [-Wuninitialized]: 480:7 => 
  - /kisskb/src/drivers/leds/leds-el15203000.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 246:8 => 
  - /kisskb/src/drivers/mfd/htc-pasic3.c: warning: unused variable 'asic' [-Wunused-variable]: 186:22 => 
  - /kisskb/src/drivers/net/arcnet/arc-rimi.c: warning: unused variable 'lp' [-Wunused-variable]: 346:23 => 
  - /kisskb/src/drivers/net/can/cc770/cc770_platform.c: warning: unused variable 'priv' [-Wunused-variable]: 236:21 => 
  - /kisskb/src/drivers/net/ethernet/8390/ax88796.c: warning: unused variable 'ei_local' [-Wunused-variable]: 808:20 => 
  - /kisskb/src/drivers/net/ethernet/aurora/nb8800.h: warning: "TCR_DIE" redefined [enabled by default]: 92:0 => 
  - /kisskb/src/drivers/net/ethernet/freescale/fs_enet/mac-scc.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 139:6 => 
  - /kisskb/src/drivers/net/ethernet/freescale/fsl_pq_mdio.c: warning: unused variable 'priv' [-Wunused-variable]: 518:27 => 
  - /kisskb/src/drivers/net/ethernet/fujitsu/fmvj18x_cs.c: warning: unused variable 'buf' [-Wunused-variable]: 823:17 => 
  - /kisskb/src/drivers/net/ethernet/i825xx/sun3_82586.c: warning: array subscript 1 is above array bounds of 'volatile struct transmit_cmd_struct *[1]' [-Warray-bounds]: 993:108 => 
  - /kisskb/src/drivers/net/ethernet/ibm/ibmvnic.c: warning: 'reset_state' may be used uninitialized in this function [-Wuninitialized]: 2200:20 => 
  - /kisskb/src/drivers/net/ethernet/marvell/mv643xx_eth.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 2971:20 => 
  - /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c: warning: 'rc' may be used uninitialized in this function [-Wuninitialized]: 1900:15 => 
  - /kisskb/src/drivers/net/ethernet/smsc/smc911x.c: warning: unused variable 'lp' [-Wunused-variable]: 2117:24 => 
  - /kisskb/src/drivers/net/ethernet/smsc/smc91c92_cs.c: warning: unused variable 'smc' [-Wunused-variable]: 958:23 => 
  - /kisskb/src/drivers/net/ethernet/smsc/smc91x.c: warning: passing argument 1 of 'insw' makes integer from pointer without a cast [enabled by default]: 482:3 => 
  - /kisskb/src/drivers/net/ethernet/smsc/smc91x.c: warning: passing argument 1 of 'inw' makes integer from pointer without a cast [enabled by default]: 1166:2, 1638:2, 1218:9, 1333:11, 484:3, 788:2, 1643:2, 825:2, 1889:2, 1225:12, 416:2, 1669:2, 792:3, 1925:2, 434:3, 1337:2, 310:2, 685:3, 748:2, 766:2, 1272:4, 1858:2, 723:2, 1217:2, 1334:9, 1268:4, 1335:2, 671:12, 1281:4, 1664:2, 391:2, 711:14, 1338:2, 852:2, 1227:3, 1902:2, 614:2, 1242:4, 1190:2, 1876:2, 462:4, 406:18, 1804:16, 1671:2, 563:14, 326:2, 673:4, 1258:4, 744:2, 1278:4, 718:17 => 
  - /kisskb/src/drivers/net/ethernet/smsc/smc91x.c: warning: passing argument 1 of 'outsw' makes integer from pointer without a cast [enabled by default]: 589:2 => 
  - /kisskb/src/drivers/net/ethernet/smsc/smc91x.c: warning: passing argument 2 of 'outw' makes integer from pointer without a cast [enabled by default]: 1259:4, 753:2, 343:2, 685:3, 1339:2, 719:2, 435:3, 857:2, 266:2, 795:3, 1875:2, 1124:2, 1634:2, 1336:2, 1632:2, 1272:4, 592:2, 1446:2, 250:2, 1660:2, 1790:2, 752:2, 749:2, 325:2, 1631:2, 353:2, 1448:3, 843:2, 385:2, 342:2, 306:2, 789:2, 352:2, 386:2, 1287:2, 745:2, 586:2, 1663:2, 574:2, 384:2, 1192:2, 390:2, 1635:2, 797:3, 1924:2, 1674:2, 463:4, 321:2, 1191:2, 1281:4, 1646:2, 307:2, 614:2, 813:2, 931:2, 1066:2, 1449:3, 1227:3, 1219:2, 1445:2, 852:2, 1796:2, 345:2, 1639:2, 292:2, 777:3, 1673:2, 1268:4, 1016:3, 324:2, 663:2, 1662:2, 1665:2, 607:2, 413:2, 346:2, 830:2, 1888:2, 267:2, 309:2, 1789:2, 825:2, 932:2, 1017:3, 1451:2, 376:2, 341:2, 1659:2, 1645:2, 1257:4, 1167:2, 1817:2, 1242:4, 1189:2, 1901:2, 482:3, 1278:4, 673:4, 722:2, 1637:2, 377:2, 274:2, 775:3, 391:2, 930:2, 573:2, 1067:2, 249:2, 485:3, 305:2, 754:2, [truncated] => 
  - /kisskb/src/drivers/net/ethernet/smsc/smc91x.h: warning: "SMC_inl" redefined [enabled by default]: 417:0 => 
  - /kisskb/src/drivers/net/ethernet/smsc/smc91x.h: warning: "SMC_insl" redefined [enabled by default]: 419:0 => 
  - /kisskb/src/drivers/net/ethernet/smsc/smc91x.h: warning: "SMC_outl" redefined [enabled by default]: 418:0 => 
  - /kisskb/src/drivers/net/ethernet/smsc/smc91x.h: warning: "SMC_outsl" redefined [enabled by default]: 420:0 => 
  - /kisskb/src/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 1022:12 => 
  - /kisskb/src/drivers/net/phy/mdio-cavium.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 138:16, 131:2, 47:2, 54:16, 86:2, 93:16, 24:2, 125:2, 21:16, 39:2 => 
  - /kisskb/src/drivers/net/phy/mdio-octeon.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 77:2, 91:2, 56:2 => 
  - /kisskb/src/drivers/net/tun.c: warning: 'copylen' may be used uninitialized in this function [-Wuninitialized]: 1836:30 => 
  - /kisskb/src/drivers/net/tun.c: warning: 'linear' may be used uninitialized in this function [-Wuninitialized]: 1749:46, 1526:34 => 
  - /kisskb/src/drivers/net/wireless/broadcom/b43/phy_n.c: warning: 'val_addr' may be used uninitialized in this function [-Wuninitialized]: 190:21 => 
  - /kisskb/src/drivers/net/wireless/cisco/airo.c: warning: '*((void *)&stats_rid+12)' may be used uninitialized in this function [-Wuninitialized]: 2253:46 => 
  - /kisskb/src/drivers/net/wireless/cisco/airo.c: warning: '*((void *)&stats_rid+16)' may be used uninitialized in this function [-Wuninitialized]: 2253:69 => 
  - /kisskb/src/drivers/net/wireless/cisco/airo.c: warning: '*((void *)&stats_rid+160)' may be used uninitialized in this function [-Wuninitialized]: 2249:48 => 
  - /kisskb/src/drivers/net/wireless/cisco/airo.c: warning: '*((void *)&stats_rid+164)' may be used uninitialized in this function [-Wuninitialized]: 2249:48 => 
  - /kisskb/src/drivers/net/wireless/cisco/airo.c: warning: '*((void *)&stats_rid+168)' may be used uninitialized in this function [-Wuninitialized]: 2249:72 => 
  - /kisskb/src/drivers/net/wireless/cisco/airo.c: warning: '*((void *)&stats_rid+172)' may be used uninitialized in this function [-Wuninitialized]: 2255:47 => 
  - /kisskb/src/drivers/net/wireless/cisco/airo.c: warning: '*((void *)&stats_rid+176)' may be used uninitialized in this function [-Wuninitialized]: 2247:48 => 
  - /kisskb/src/drivers/net/wireless/cisco/airo.c: warning: '*((void *)&stats_rid+180)' may be used uninitialized in this function [-Wuninitialized]: 2247:48 => 
  - /kisskb/src/drivers/net/wireless/cisco/airo.c: warning: '*((void *)&stats_rid+184)' may be used uninitialized in this function [-Wuninitialized]: 2247:72 => 
  - /kisskb/src/drivers/net/wireless/cisco/airo.c: warning: '*((void *)&stats_rid+20)' may be used uninitialized in this function [-Wuninitialized]: 2254:31 => 
  - /kisskb/src/drivers/net/wireless/cisco/airo.c: warning: '*((void *)&stats_rid+360)' may be used uninitialized in this function [-Wuninitialized]: 2258:24 => 
  - /kisskb/src/drivers/net/wireless/cisco/airo.c: warning: '*((void *)&stats_rid+368)' may be used uninitialized in this function [-Wuninitialized]: 2252:22 => 
  - /kisskb/src/drivers/net/wireless/cisco/airo.c: warning: '*((void *)&stats_rid+372)' may be used uninitialized in this function [-Wuninitialized]: 2251:22 => 
  - /kisskb/src/drivers/net/wireless/cisco/airo.c: warning: '*((void *)&stats_rid+4)' may be used uninitialized in this function [-Wuninitialized]: 2253:46 => 
  - /kisskb/src/drivers/net/wireless/cisco/airo.c: warning: 'cap_rid.softCap' may be used uninitialized in this function [-Wuninitialized]: 2862:37 => 
  - /kisskb/src/drivers/net/wireless/cisco/airo.c: warning: 'cap_rid.softSubVer' may be used uninitialized in this function [-Wuninitialized]: 2865:2 => 
  - /kisskb/src/drivers/net/wireless/cisco/airo.c: warning: 'cap_rid.softVer' may be used uninitialized in this function [-Wuninitialized]: 2865:2 => 
  - /kisskb/src/drivers/net/wireless/cisco/airo.c: warning: 'status_rid.channel' may be used uninitialized in this function [-Wuninitialized]: 5822:5 => 
  - /kisskb/src/drivers/net/wireless/cisco/airo.c: warning: 'status_rid.len' may be used uninitialized in this function [-Wuninitialized]: 7718:5 => 
  - /kisskb/src/drivers/net/wireless/cisco/airo.c: warning: 'status_rid.mode' may be used uninitialized in this function [-Wuninitialized]: 7703:23 => 
  - /kisskb/src/drivers/net/wireless/cisco/airo.c: warning: 'status_rid.noisedBm' may be used uninitialized in this function [-Wuninitialized]: 7719:28 => 
  - /kisskb/src/drivers/net/wireless/cisco/airo.c: warning: 'status_rid.normalizedSignalStrength' may be used uninitialized in this function [-Wuninitialized]: 7711:27 => 
  - /kisskb/src/drivers/net/wireless/cisco/airo.c: warning: 'status_rid.sigQuality' may be used uninitialized in this function [-Wuninitialized]: 7708:20 => 
  - /kisskb/src/drivers/net/wireless/cisco/airo.c: warning: 'status_rid.signalQuality' may be used uninitialized in this function [-Wuninitialized]: 5732:6 => 
  - /kisskb/src/drivers/net/wireless/cisco/airo.c: warning: 'wkr.kindex' may be used uninitialized in this function [-Wuninitialized]: 5175:6 => 
  - /kisskb/src/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c: warning: 'rf_amode' may be used uninitialized in this function [-Wuninitialized]: 3476:23 => 
  - /kisskb/src/drivers/net/wireless/realtek/rtw88/pci.c: warning: 'rtw_pci_resume' defined but not used [-Wunused-function]: 1296:12 => 
  - /kisskb/src/drivers/net/wireless/realtek/rtw88/pci.c: warning: 'rtw_pci_suspend' defined but not used [-Wunused-function]: 1291:12 => 
  - /kisskb/src/drivers/pwm/pwm-fsl-ftm.c: warning: 'periodcfg' may be used uninitialized in this function [-Wmaybe-uninitialized]: 280:15 => 
  - /kisskb/src/drivers/pwm/pwm-fsl-ftm.c: warning: 'periodcfg.clk_ps' may be used uninitialized in this function [-Wmaybe-uninitialized]: 82:20 => 
  - /kisskb/src/drivers/pwm/pwm-fsl-ftm.c: warning: 'periodcfg.mod_period' may be used uninitialized in this function [-Wmaybe-uninitialized]: 278:3, 84:24 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_dev_init' uses dynamic stack allocation: 491:1 => 
  - /kisskb/src/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c: warning: 'client_ioba' may be used uninitialized in this function [-Wuninitialized]: 3305:18 => 
  - /kisskb/src/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c: warning: 'server_ioba' may be used uninitialized in this function [-Wuninitialized]: 3311:18 => 
  - /kisskb/src/drivers/sh/clk/cpg.c: warning: passing argument 1 of 'ioread16' discards 'const' qualifier from pointer target type [enabled by default]: 46:2 => 
  - /kisskb/src/drivers/sh/clk/cpg.c: warning: passing argument 1 of 'ioread32' discards 'const' qualifier from pointer target type [enabled by default]: 51:2 => 
  - /kisskb/src/drivers/sh/clk/cpg.c: warning: passing argument 1 of 'ioread8' discards 'const' qualifier from pointer target type [enabled by default]: 41:2 => 
  - /kisskb/src/drivers/sh/superhyway/superhyway-sysfs.c: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'resource_size_t' [-Wformat]: 34:1 => 
  - /kisskb/src/drivers/soc/qcom/rpmh.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 355:6 => 
  - /kisskb/src/drivers/staging/comedi/drivers/pcl816.c: warning: 'last_chan' may be used uninitialized in this function [-Wuninitialized]: 148:6 => 
  - /kisskb/src/drivers/staging/comedi/drivers/pcl818.c: warning: 'last_chan' may be used uninitialized in this function [-Wuninitialized]: 337:6 => 
  - /kisskb/src/drivers/thermal/broadcom/ns-thermal.c: warning: unused variable 'ns_thermal' [-Wunused-variable]: 78:21 => 
  - /kisskb/src/drivers/tty/serial/8250/8250_core.c: warning: 'i' may be used uninitialized in this function [-Wuninitialized]: 247:18 => 
  - /kisskb/src/drivers/usb/core/devio.c: warning: 'errno' may be used uninitialized in this function [-Wuninitialized]: 625:23 => 
  - /kisskb/src/drivers/usb/gadget/udc/fsl_qe_udc.c: warning: 'udc' may be used uninitialized in this function [-Wmaybe-uninitialized]: 1840:14 => 
  - /kisskb/src/drivers/usb/gadget/udc/fsl_qe_udc.c: warning: 'udc' may be used uninitialized in this function [-Wuninitialized]: 1840:2 => 
  - /kisskb/src/drivers/usb/gadget/udc/fsl_qe_udc.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 1491:4, 1491:27, 837:28, 965:5, 837:5, 965:28 => 965:28, 837:28, 1491:27
  - /kisskb/src/drivers/usb/host/fhci-hcd.c: warning: this statement may fall through [-Wimplicit-fallthrough=]: 398:8 => 
  - /kisskb/src/drivers/usb/usbip/stub_rx.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 587:5 => 
  - /kisskb/src/fs/afs/dynroot.c: warning: 'len' may be used uninitialized in this function [-Wmaybe-uninitialized]: 117:6 => 
  - /kisskb/src/fs/afs/dynroot.c: warning: 'len' may be used uninitialized in this function [-Wuninitialized]: 117:6 => 
  - /kisskb/src/fs/btrfs/ref-verify.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 492:2 => 
  - /kisskb/src/fs/cifs/smb2pdu.c: warning: 'in_data_buf' may be used uninitialized in this function [-Wmaybe-uninitialized]: 2845:19 => 
  - /kisskb/src/fs/cifs/smb2pdu.c: warning: 'in_data_buf' may be used uninitialized in this function [-Wuninitialized]: 2845:19 => 
  - /kisskb/src/fs/ext4/extents.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 5009:23 => 
  - /kisskb/src/fs/ext4/readpage.c: warning: the frame size of 1180 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 416:1 => 
  - /kisskb/src/fs/f2fs/file.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 3257:6 => 
  - /kisskb/src/fs/gfs2/bmap.c: warning: 'height' may be used uninitialized in this function [-Wuninitialized]: 956:18 => 
  - /kisskb/src/fs/gfs2/bmap.c: warning: 'lblock' may be used uninitialized in this function [-Wuninitialized]: 957:8 => 
  - /kisskb/src/fs/gfs2/bmap.c: warning: 'len' may be used uninitialized in this function [-Wuninitialized]: 957:8 => 
  - /kisskb/src/fs/gfs2/lops.c: warning: 'off' may be used uninitialized in this function [-Wuninitialized]: 564:8 => 
  - /kisskb/src/fs/io-wq.c: warning: 'work' may be used uninitialized in this function [-Wuninitialized]: 913:16 => 
  - /kisskb/src/fs/io_uring.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 5856:13 => 
  - /kisskb/src/fs/mpage.c: warning: the frame size of 1108 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 338:1 => 
  - /kisskb/src/fs/mpage.c: warning: the frame size of 1148 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 690:1 => 
  - /kisskb/src/fs/nfs/read.c: warning: value computed is not used [-Wunused-value]: 196:5, 353:2 => 
  - /kisskb/src/fs/nfsd/nfs4xdr.c: warning: 'end' may be used uninitialized in this function [-Wuninitialized]: 2156:42 => 
  - /kisskb/src/fs/nfsd/nfs4xdr.c: warning: 'str' may be used uninitialized in this function [-Wuninitialized]: 2151:9 => 
  - /kisskb/src/fs/ntfs/aops.c: warning: the frame size of 2176 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 1314:1 => 
  - /kisskb/src/fs/ocfs2/alloc.c: warning: 'first_bit' may be used uninitialized in this function [-Wuninitialized]: 7608:17 => 
  - /kisskb/src/fs/ocfs2/file.c: warning: value computed is not used [-Wunused-value]: 2419:3 => 
  - /kisskb/src/fs/splice.c: warning: 'type' may be used uninitialized in this function [-Wuninitialized]: 1416:8, 1390:8 => 
  - /kisskb/src/fs/udf/unicode.c: warning: 'c' may be used uninitialized in this function [-Wuninitialized]: 132:8 => 
  - /kisskb/src/include/linux/list.h: warning: 'head' may be used uninitialized in this function [-Wuninitialized]: 100:12 => 
  - /kisskb/src/include/linux/list.h: warning: 'pdeo' may be used uninitialized in this function [-Wuninitialized]: 72:12 => 
  - /kisskb/src/include/linux/regmap.h: warning: 'periodcfg.clk_ps' may be used uninitialized in this function [-Wmaybe-uninitialized]: 75:2 => 
  - /kisskb/src/include/linux/rhashtable.h: warning: 'next' may be used uninitialized in this function [-Wuninitialized]: 110:10 => 
  - /kisskb/src/include/linux/spinlock.h: warning: 'flags' may be used uninitialized in this function [-Wmaybe-uninitialized]: 288:3 => 
  - /kisskb/src/include/linux/spinlock.h: warning: 'flags' may be used uninitialized in this function [-Wuninitialized]: 393:2 => 
  - /kisskb/src/include/linux/unaligned/le_byteshift.h: warning: array subscript is above array bounds [-Warray-bounds]: 26:7 => 
  - /kisskb/src/include/math-emu/double.h: warning: "__BIG_ENDIAN" is not defined [-Wundef]: 59:21 => 
  - /kisskb/src/include/math-emu/single.h: warning: "__BIG_ENDIAN" is not defined [-Wundef]: 50:21 => 
  - /kisskb/src/include/sound/control.h: warning: 'speaker_vol' may be used uninitialized in this function [-Wuninitialized]: 218:2 => 
  - /kisskb/src/ipc/shm.c: warning: 'file' may be used uninitialized in this function [-Wuninitialized]: 1712:59 => 
  - /kisskb/src/kernel/padata.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 539:2 => 
  - /kisskb/src/kernel/printk/printk.c: warning: 'old' may be used uninitialized in this function [-Wuninitialized]: 204:16 => 
  - /kisskb/src/kernel/sched/core.c: warning: 'cpu' may be used uninitialized in this function [-Wuninitialized]: 2644:12 => 
  - /kisskb/src/kernel/trace/trace_events.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 2040:6 => 
  - /kisskb/src/lib/mpi/mpicoder.c: warning: 'buff' may be used uninitialized in this function [-Wuninitialized]: 352:8 => 
  - /kisskb/src/mm/hugetlb.c: warning: 'page' may be used uninitialized in this function [-Wuninitialized]: 1426:5 => 
  - /kisskb/src/mm/memcontrol.c: warning: 'mem_cgroup_id_get_many' defined but not used [-Wunused-function]: 4864:13 => 
  - /kisskb/src/mm/vmstat.c: warning: 'oldval' may be used uninitialized in this function [-Wuninitialized]: 90:5 => 
  - /kisskb/src/net/bluetooth/hidp/core.c: warning: 'session' may be used uninitialized in this function [-Wuninitialized]: 1386:18 => 
  - /kisskb/src/net/bridge/br_netlink.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 571:6 => 
  - /kisskb/src/net/core/dev.c: warning: 'tail' may be used uninitialized in this function [-Wuninitialized]: 3604:15 => 
  - /kisskb/src/net/core/devlink.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 4626:6 => 
  - /kisskb/src/net/core/gen_stats.c: warning: 'seq' may be used uninitialized in this function [-Wuninitialized]: 156:19 => 
  - /kisskb/src/net/ipv4/tcp_input.c: warning: array subscript is above array bounds [-Warray-bounds]: 4398:49 => 
  - /kisskb/src/net/mac80211/mlme.c: warning: 'pwr_level_cisco' may be used uninitialized in this function [-Wuninitialized]: 1576:3 => 
  - /kisskb/src/net/mac80211/tx.c: warning: 'chanctx_conf' may be used uninitialized in this function [-Wuninitialized]: 2557:27 => 
  - /kisskb/src/net/ncsi/ncsi-manage.c: warning: 'vid' may be used uninitialized in this function [-Wuninitialized]: 673:19 => 
  - /kisskb/src/net/wireless/nl80211.c: warning: 'rdev' may be used uninitialized in this function [-Wuninitialized]: 13124:21 => 
  - /kisskb/src/net/wireless/nl80211.c: warning: 'wdev' may be used uninitialized in this function [-Wuninitialized]: 13154:33 => 
  - /kisskb/src/security/apparmor/policy_unpack.c: warning: 'pos' may be used uninitialized in this function [-Wmaybe-uninitialized]: 526:9 => 
  - /kisskb/src/sound/drivers/serial-u16550.c: warning: 'uart' may be used uninitialized in this function [-Wuninitialized]: 946:6 => 
  - /kisskb/src/sound/hda/hdac_regmap.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 284:16 => 
  - /kisskb/src/sound/soc/codecs/arizona.c: warning: 'aif_rx_state' may be used uninitialized in this function [-Wuninitialized]: 1890:3 => 
  - /kisskb/src/sound/soc/codecs/arizona.c: warning: 'aif_tx_state' may be used uninitialized in this function [-Wuninitialized]: 1887:3 => 
  - /kisskb/src/sound/soc/codecs/da7219-aad.c: warning: 'pll_ctrl' may be used uninitialized in this function [-Wuninitialized]: 317:17 => 
  - /kisskb/src/sound/soc/codecs/rt5665.c: warning: 'val1' may be used uninitialized in this function [-Wuninitialized]: 2660:33 => 
  - /kisskb/src/sound/soc/codecs/rt5665.c: warning: 'val2' may be used uninitialized in this function [-Wuninitialized]: 2663:33 => 
  - /kisskb/src/sound/soc/codecs/wm8960.c: warning: 'i' may be used uninitialized in this function [-Wuninitialized]: 797:68 => 
  - /kisskb/src/sound/soc/codecs/wm8960.c: warning: 'j' may be used uninitialized in this function [-Wuninitialized]: 800:70 => 
  - /kisskb/src/sound/soc/fsl/imx-audmix.c: warning: 'capture_dai_name' may be used uninitialized in this function [-Wuninitialized]: 302:45 => 
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
