Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46767C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ACF22072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgHQNPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 09:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728758AbgHQNMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 09:12:18 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F78C061342
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 06:12:17 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by andre.telenet-ops.be with bizsmtp
        id GdC92300h4C55Sk01dC9SG; Mon, 17 Aug 2020 15:12:10 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k7evp-0006ME-G1
        for linux-kernel@vger.kernel.org; Mon, 17 Aug 2020 15:12:09 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k7evp-0005Dl-EJ
        for linux-kernel@vger.kernel.org; Mon, 17 Aug 2020 15:12:09 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.9-rc1
Date:   Mon, 17 Aug 2020 15:12:09 +0200
Message-Id: <20200817131209.20027-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v5.9-rc1[1] compared to v5.8[2].

Summarized:
  - build errors: +1/-12
  - build warnings: +68/-124

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/9123e3a74ec7b934a4a099e98af6a61c2f80bbf5/ (all 192 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/bcf876870b95592b52519ed4aafcf9d95999bc9c/ (all 192 configs)


*** ERRORS ***

1 error regressions:
  + error: modpost: "fw_arg3" [drivers/mtd/parsers/bcm63xxpart.ko] undefined!:  => N/A

12 error improvements:
  - /kisskb/src/arch/powerpc/include/asm/mmu.h: error: unknown type name 'next_tlbcam_idx': 139:22 => 
  - /kisskb/src/arch/sparc/include/asm/trap_block.h: error: 'NR_CPUS' undeclared here (not in a function): 54:39 => 
  - error: arch/sparc/kernel/head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text': (.head.text+0x5100), (.head.text+0x5040) => 
  - error: arch/sparc/kernel/head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o: (.init.text+0xa4) => 
  - error: arch/sparc/kernel/process_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text': (.fixup+0xc), (.fixup+0x4) => 
  - error: arch/sparc/kernel/signal_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text': (.fixup+0x1c), (.fixup+0x34), (.fixup+0x10), (.fixup+0x28), (.fixup+0x4) => 
  - error: modpost: "devm_ioremap" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!: N/A => 
  - error: modpost: "devm_ioremap_resource" [drivers/net/ethernet/xilinx/xilinx_emac.ko] undefined!: N/A => 
  - error: modpost: "devm_of_iomap" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!: N/A => 
  - error: modpost: "devm_platform_ioremap_resource" [drivers/iio/adc/adi-axi-adc.ko] undefined!: N/A => 
  - error: modpost: "devm_platform_ioremap_resource" [drivers/ptp/ptp_ines.ko] undefined!: N/A => 
  - error: modpost: "devm_platform_ioremap_resource" [drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.ko] undefined!: N/A => 


*** WARNINGS ***

68 warning regressions:
  + /kisskb/src/arch/arm/crypto/ghash-ce-glue.c: warning: passing argument 4 of 'pmull_ghash_update_p64' from incompatible pointer type:  => 67:44
  + /kisskb/src/arch/arm/crypto/ghash-ce-glue.c: warning: passing argument 4 of 'pmull_ghash_update_p8' from incompatible pointer type:  => 69:43
  + /kisskb/src/arch/arm/mach-omap1/board-ams-delta.c: warning: 'ams_delta_camera_power' defined but not used [-Wunused-function]:  => 462:12
  + /kisskb/src/drivers/crypto/sa2ul.c: warning: (near initialization for 'ad.enc_eng') [-Wmissing-braces]:  => 939:9, 1845:9, 1585:9, 971:9, 1569:9, 919:9, 957:9, 1858:9, 1601:9
  + /kisskb/src/drivers/crypto/sa2ul.c: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]:  => 1486:33
  + /kisskb/src/drivers/crypto/sa2ul.c: warning: missing braces around initializer [-Wmissing-braces]:  => 1858:9, 1601:9, 1585:9, 1845:9, 939:9, 1569:9, 971:9, 957:9, 919:9
  + /kisskb/src/drivers/gpio/gpio-omap.c: warning: 'omap_gpio_resume' defined but not used [-Wunused-function]:  => 1531:12
  + /kisskb/src/drivers/gpio/gpio-omap.c: warning: 'omap_gpio_suspend' defined but not used [-Wunused-function]:  => 1519:12
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c: warning: (near initialization for 'hw_locks.bits') [-Wmissing-braces]:  => 2527:11, 2342:11
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c: warning: missing braces around initializer [-Wmissing-braces]:  => 2342:11, 2527:11
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c: warning: (near initialization for 'hw_locks.bits') [-Wmissing-braces]:  => 4094:11, 4138:11
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c: warning: missing braces around initializer [-Wmissing-braces]: 2714:8, 2712:8 => 4094:11, 4138:11, 2763:8, 2765:8
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_hw_lock_mgr.c: warning: (near initialization for 'cmd.lock_hw') [-Wmissing-braces]:  => 36:8
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_hw_lock_mgr.c: warning: missing braces around initializer [-Wmissing-braces]:  => 36:8
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: warning: (near initialization for 'hw_locks.bits') [-Wmissing-braces]:  => 1786:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: warning: missing braces around initializer [-Wmissing-braces]:  => 1786:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c: warning: (near initialization for 'hw_locks.bits') [-Wmissing-braces]:  => 1200:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c: warning: missing braces around initializer [-Wmissing-braces]:  => 1200:9
  + /kisskb/src/drivers/gpu/drm/rockchip/cdn-dp-core.c: warning: 'cdn_dp_resume' defined but not used [-Wunused-function]:  => 1124:12
  + /kisskb/src/drivers/gpu/drm/xlnx/zynqmp_dp.c: warning: (near initialization for 'opts.mipi_dphy') [-Wmissing-braces]:  => 667:9
  + /kisskb/src/drivers/gpu/drm/xlnx/zynqmp_dp.c: warning: missing braces around initializer [-Wmissing-braces]:  => 667:9
  + /kisskb/src/drivers/misc/habanalabs/common/habanalabs_ioctl.c: warning: (near initialization for 'cs_counters.cs_counters') [-Wmissing-braces]:  => 282:9
  + /kisskb/src/drivers/misc/habanalabs/common/habanalabs_ioctl.c: warning: missing braces around initializer [-Wmissing-braces]:  => 282:9
  + /kisskb/src/drivers/scsi/ufs/ufshcd-crypto.c: warning: (near initialization for 'cfg.reg_val') [-Wmissing-braces]:  => 103:8, 62:8
  + /kisskb/src/drivers/scsi/ufs/ufshcd-crypto.c: warning: missing braces around initializer [-Wmissing-braces]:  => 62:8, 103:8
  + /kisskb/src/drivers/staging/media/tegra-vde/vde.c: warning: 'tegra_vde_runtime_suspend' defined but not used [-Wunused-function]:  => 916:12
  + /kisskb/src/drivers/tty/serial/sh-sci.c: warning: unused variable 'sport' [-Wunused-variable]:  => 2677:19
  + /kisskb/src/include/linux/dma-mapping.h: warning: conversion from 'long long unsigned int' to 'dma_addr_t' {aka 'unsigned int'} changes value from '18446744073709551615' to '4294967295' [-Woverflow]:  => 139:25
  + /kisskb/src/include/linux/dma-mapping.h: warning: large integer implicitly truncated to unsigned type [-Woverflow]:  => 139:25
  + /kisskb/src/include/vdso/bits.h: warning: left shift count >= width of type [-Wshift-count-overflow]:  => 7:26
  + /kisskb/src/kernel/rcu/tasks.h: warning: 'show_rcu_tasks_classic_gp_kthread' defined but not used [-Wunused-function]:  => 593:13
  + /kisskb/src/lib/xxhash.c: warning: the frame size of 1616 bytes is larger than 1280 bytes [-Wframe-larger-than=]:  => 236:1
  + /kisskb/src/lib/zstd/compress.c: warning: the frame size of 1584 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 1393:1
  + /kisskb/src/sound/soc/tegra/tegra186_dspk.c: warning: 'tegra186_dspk_runtime_resume' defined but not used [-Wunused-function]:  => 86:12
  + /kisskb/src/sound/soc/tegra/tegra186_dspk.c: warning: 'tegra186_dspk_runtime_suspend' defined but not used [-Wunused-function]:  => 74:12
  + /kisskb/src/sound/soc/tegra/tegra210_admaif.c: warning: 'tegra_admaif_runtime_resume' defined but not used [-Wunused-function]:  => 232:12
  + /kisskb/src/sound/soc/tegra/tegra210_admaif.c: warning: 'tegra_admaif_runtime_suspend' defined but not used [-Wunused-function]:  => 222:12
  + /kisskb/src/sound/soc/tegra/tegra210_ahub.c: warning: 'tegra_ahub_runtime_resume' defined but not used [-Wunused-function]:  => 579:12
  + /kisskb/src/sound/soc/tegra/tegra210_ahub.c: warning: 'tegra_ahub_runtime_suspend' defined but not used [-Wunused-function]:  => 567:12
  + /kisskb/src/sound/soc/tegra/tegra210_dmic.c: warning: 'tegra210_dmic_runtime_resume' defined but not used [-Wunused-function]:  => 55:12
  + /kisskb/src/sound/soc/tegra/tegra210_dmic.c: warning: 'tegra210_dmic_runtime_suspend' defined but not used [-Wunused-function]:  => 43:12
  + /kisskb/src/sound/soc/tegra/tegra210_i2s.c: warning: 'tegra210_i2s_runtime_resume' defined but not used [-Wunused-function]:  => 179:12
  + /kisskb/src/sound/soc/tegra/tegra210_i2s.c: warning: 'tegra210_i2s_runtime_suspend' defined but not used [-Wunused-function]:  => 167:12
  + modpost: WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x3570): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x3588): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x35a0): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x35b8): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x35d0): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x35e8): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x3600): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x3618): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x3630): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x3648): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x3660): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x3678): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x3690): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x36a8): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x36c0): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x36d8): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x134): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x14c): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x164): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x17c): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x194): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x1ac): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x1c4): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: lib/test_bitmap.o(.text.unlikely+0x58): Section mismatch in reference from the function bitmap_equal() to the variable .init.rodata:clump_exp:  => N/A

124 warning improvements:
  - .config: warning: override: reassigning to symbol MIPS_CPS_NS16550_SHIFT: 12361, 12347, 12352 => 12462
  - .config: warning: override: reassigning to symbol UML_NET_ETHERTAP: 4314, 4286 => 
  - .config: warning: override: reassigning to symbol UML_NET_MCAST: 4319, 4291 => 
  - .config: warning: override: reassigning to symbol UML_NET_SLIP: 4288, 4316 => 
  - .config: warning: override: reassigning to symbol UML_NET_SLIRP: 4293, 4321 => 
  - /kisskb/src/arch/m68k/include/asm/cmpxchg.h: warning: value computed is not used [-Wunused-value]: 79:22, 122:3, 137:3 => 79:22, 122:3
  - /kisskb/src/arch/mips/include/asm/sibyte/bcm1480_scd.h: warning: "M_SPC_CFG_CLEAR" redefined: 261:0, 261 => 261
  - /kisskb/src/arch/mips/include/asm/sibyte/bcm1480_scd.h: warning: "M_SPC_CFG_ENABLE" redefined: 262, 262:0 => 262
  - /kisskb/src/arch/powerpc/kernel/head_40x.S: Warning: invalid register expression: 623 => 
  - /kisskb/src/arch/s390/boot/mem_detect.c: warning: 'detect_memory' uses dynamic stack allocation: 175:1 => 
  - /kisskb/src/arch/s390/kernel/perf_cpum_cf_diag.c: warning: 'cf_diag_push_sample' uses dynamic stack allocation: 519:1 => 
  - /kisskb/src/arch/s390/kernel/perf_cpum_sf.c: warning: 'perf_push_sample' uses dynamic stack allocation: 1145:1 => 
  - /kisskb/src/arch/sh/kernel/cpu/sh2/../../entry-common.S: Warning: overflow in branch to syscall_exit_work; converted into longer instruction sequence: 385, 388 => 
  - /kisskb/src/arch/sh/kernel/cpu/sh2a/../../entry-common.S: Warning: overflow in branch to syscall_exit_work; converted into longer instruction sequence: 388, 385 => 
  - /kisskb/src/arch/sh/kernel/cpu/sh3/../../entry-common.S: Warning: overflow in branch to syscall_exit_work; converted into longer instruction sequence: 388, 385 => 
  - /kisskb/src/arch/sh/kernel/cpu/sh4/../sh3/../../entry-common.S: Warning: overflow in branch to syscall_exit_work; converted into longer instruction sequence: 388, 385 => 
  - /kisskb/src/arch/sparc/include/asm/cmpxchg_32.h: warning: value computed is not used [-Wunused-value]: 28:22 => 
  - /kisskb/src/arch/um/os-Linux/signal.c: warning: the frame size of 2960 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 95:1 => 
  - /kisskb/src/arch/um/os-Linux/signal.c: warning: the frame size of 2976 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 51:1 => 
  - /kisskb/src/drivers/crypto/chelsio/chtls/chtls_cm.c: warning: 'wait_for_states.constprop' uses dynamic stack allocation: 435:1 => 
  - /kisskb/src/drivers/mailbox/imx-mailbox.c: warning: 'imx_mu_resume_noirq' defined but not used [-Wunused-function]: 611:12 => 
  - /kisskb/src/drivers/mailbox/imx-mailbox.c: warning: 'imx_mu_runtime_resume' defined but not used [-Wunused-function]: 638:12 => 
  - /kisskb/src/drivers/mailbox/imx-mailbox.c: warning: 'imx_mu_runtime_suspend' defined but not used [-Wunused-function]: 629:12 => 
  - /kisskb/src/drivers/mailbox/imx-mailbox.c: warning: 'imx_mu_suspend_noirq' defined but not used [-Wunused-function]: 601:12 => 
  - /kisskb/src/drivers/net/ethernet/aurora/nb8800.h: warning: "TCR_DIE" redefined: 92 => 
  - /kisskb/src/drivers/net/ethernet/marvell/mvpp2/mvpp2.h: warning: overflow in implicit constant conversion [-Woverflow]: 634:2 => 
  - /kisskb/src/drivers/net/ethernet/neterion/vxge/vxge-config.c: warning: 'vxge_hw_device_hw_info_get' uses dynamic stack allocation: 1089:1 => 
  - /kisskb/src/drivers/net/phy/mdio-cavium.h: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 114:37, 113:48 => 
  - /kisskb/src/drivers/net/phy/mdio-octeon.c: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]: 48:3 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_add_vlan_id' uses dynamic stack allocation: 315:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_del_vlan_id' uses dynamic stack allocation: 329:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_probe' uses dynamic stack allocation: 546:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_query_rgid' uses dynamic stack allocation: 214:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_register_dmb' uses dynamic stack allocation: 280:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_signal_ieq' uses dynamic stack allocation: 357:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_unregister_dmb' uses dynamic stack allocation: 301:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'query_info' uses dynamic stack allocation: 83:1 => 
  - /kisskb/src/drivers/sh/clk/cpg.c: warning: passing argument 1 of 'ioread16' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]: 46:18 => 
  - /kisskb/src/drivers/sh/clk/cpg.c: warning: passing argument 1 of 'ioread16' discards 'const' qualifier from pointer target type: 46:18 => 
  - /kisskb/src/drivers/sh/clk/cpg.c: warning: passing argument 1 of 'ioread32' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]: 51:18 => 
  - /kisskb/src/drivers/sh/clk/cpg.c: warning: passing argument 1 of 'ioread32' discards 'const' qualifier from pointer target type: 51:18 => 
  - /kisskb/src/drivers/sh/clk/cpg.c: warning: passing argument 1 of 'ioread8' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]: 41:17 => 
  - /kisskb/src/drivers/sh/clk/cpg.c: warning: passing argument 1 of 'ioread8' discards 'const' qualifier from pointer target type: 41:17 => 
  - /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.39' uses dynamic stack allocation: 498:1 => 
  - /kisskb/src/drivers/target/iscsi/iscsi_target.c: warning: 'iscsit_send_datain' uses dynamic stack allocation: 2874:1 => 
  - /kisskb/src/drivers/tty/serial/sunzilog.c: warning: 'sunzilog_putchar' defined but not used [-Wunused-function]: 1128:13 => 
  - /kisskb/src/drivers/usb/gadget/udc/fsl_qe_udc.c: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]: 836:13, 964:13, 1490:12 => 
  - /kisskb/src/drivers/usb/gadget/udc/fsl_qe_udc.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 837:28, 1491:27, 965:28 => 
  - /kisskb/src/drivers/usb/gadget/udc/fsl_qe_udc.c: warning: this statement may fall through [-Wimplicit-fallthrough=]: 596:5, 580:8, 566:8, 563:8, 542:37 => 
  - /kisskb/src/fs/nfs/super.c: warning: 'nfs_show_stats' uses dynamic stack allocation: 687:1 => 
  - /kisskb/src/include/linux/err.h: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 22:49 => 
  - /kisskb/src/kernel/bpf/syscall.c: warning: 'bpf_prog_get_info_by_fd.isra.24' uses dynamic stack allocation: 3498:1 => 
  - /kisskb/src/kernel/bpf/syscall.c: warning: 'bpf_prog_show_fdinfo' uses dynamic stack allocation: 1810:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_free_coherent' uses dynamic stack allocation: 1493:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_sg_for_cpu' uses dynamic stack allocation: 1607:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_sg_for_device' uses dynamic stack allocation: 1639:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_single_for_cpu' uses dynamic stack allocation: 1554:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_single_for_device' uses dynamic stack allocation: 1574:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_unmap_page' uses dynamic stack allocation: 1341:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_unmap_resource' uses dynamic stack allocation: 1535:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_unmap_sg' uses dynamic stack allocation: 1431:1 => 
  - /kisskb/src/kernel/events/core.c: warning: '___perf_sw_event' uses dynamic stack allocation: 8995:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_aux_event' uses dynamic stack allocation: 8266:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_bpf_output' uses dynamic stack allocation: 8563:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_cgroup_output' uses dynamic stack allocation: 7834:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_comm_output' uses dynamic stack allocation: 7612:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_ksymbol_output' uses dynamic stack allocation: 8474:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_mmap_output' uses dynamic stack allocation: 7975:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_namespaces_output' uses dynamic stack allocation: 7711:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_read_event' uses dynamic stack allocation: 7231:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_switch_output' uses dynamic stack allocation: 8358:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_task_output' uses dynamic stack allocation: 7518:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_log_itrace_start' uses dynamic stack allocation: 8670:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_log_lost_samples' uses dynamic stack allocation: 8299:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_log_throttle' uses dynamic stack allocation: 8429:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_swevent_hrtimer' uses dynamic stack allocation: 10138:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_tp_event' uses dynamic stack allocation: 9309:1 => 
  - /kisskb/src/kernel/events/ring_buffer.c: warning: 'perf_output_begin' uses dynamic stack allocation: 283:1 => 
  - /kisskb/src/kernel/events/ring_buffer.c: warning: 'perf_output_begin_backward' uses dynamic stack allocation: 275:1 => 
  - /kisskb/src/kernel/events/ring_buffer.c: warning: 'perf_output_begin_forward' uses dynamic stack allocation: 269:1 => 
  - /kisskb/src/kernel/rseq.c: warning: '__rseq_handle_notify_resume' uses dynamic stack allocation: 281:1 => 
  - /kisskb/src/kernel/rseq.c: warning: 'rseq_syscall' uses dynamic stack allocation: 300:1 => 
  - /kisskb/src/kernel/smp.c: warning: 'smp_call_function_single' uses dynamic stack allocation: 387:1 => 
  - /kisskb/src/lib/crypto/chacha20poly1305.c: warning: 'chacha20poly1305_crypt_sg_inplace' uses dynamic stack allocation: 335:1 => 
  - /kisskb/src/lib/lz4/lz4hc_compress.c: warning: the frame size of 2144 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 579:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_dynamic_all' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_dynamic_partial.isra.29' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_none.isra.63' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_runtime_all.isra.49' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_runtime_partial.isra.41' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_static_all' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_static_partial.isra.17' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_zero.isra.9' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_dynamic_all' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_dynamic_partial' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_none' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_runtime_all' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_runtime_partial' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_static_all' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_static_partial' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_zero' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/zstd/compress.c: warning: the frame size of 1384 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 1393:1 => 
  - /kisskb/src/mm/slub.c: warning: '___slab_alloc' uses dynamic stack allocation: 2692:1 => 
  - /kisskb/src/mm/slub.c: warning: '__slab_free' uses dynamic stack allocation: 3005:1 => 
  - /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.57' uses dynamic stack allocation: 2230:1 => 
  - /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.56' uses dynamic stack allocation: 1929:1 => 
  - /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.55' uses dynamic stack allocation: 2298:1 => 
  - /kisskb/src/net/bridge/br_device.c: warning: 'br_get_stats64' uses dynamic stack allocation: 228:1 => 
  - /kisskb/src/net/bridge/netfilter/ebtables.c: warning: 'compat_copy_everything_to_user' uses dynamic stack allocation: 1850:1 => 
  - /kisskb/src/samples/seccomp/user-trap.c: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]: 83:2, 50:2 => 
  - modpost: WARNING: modpost: EXPORT symbol "___rw_read_enter" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "___rw_read_exit" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "___rw_read_try" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "___rw_write_enter" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__ashldi3" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__ashrdi3" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__copy_1page" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__divdi3" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__lshrdi3" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__muldi3" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__ndelay" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__udelay" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "bzero_1page" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "empty_zero_page" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
