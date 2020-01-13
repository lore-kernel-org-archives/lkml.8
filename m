Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAA7C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C43D2081E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgAMKeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 05:34:23 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:54188 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgAMKeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 05:34:23 -0500
Received: from ramsan ([84.195.182.253])
        by andre.telenet-ops.be with bizsmtp
        id pma92100i5USYZQ01ma9Kv; Mon, 13 Jan 2020 11:34:10 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iqx2v-0000e6-OM
        for linux-kernel@vger.kernel.org; Mon, 13 Jan 2020 11:34:09 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iqx2v-0006Nu-NH
        for linux-kernel@vger.kernel.org; Mon, 13 Jan 2020 11:34:09 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.5-rc6
Date:   Mon, 13 Jan 2020 11:34:09 +0100
Message-Id: <20200113103409.24495-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v5.5-rc6[1] compared to v5.4[2].

Summarized:
  - build errors: +0/-8
  - build warnings: +151/-151

JFYI, when comparing v5.5-rc6[1] to v5.5-rc5[3], the summaries are:
  - build errors: +0/-0
  - build warnings: +34/-0

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/b3a987b0264d3ddbb24293ebff10eddfc472f653/ (all 232 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/219d54332a09e8d8741c1e1982f5eae56099de85/ (all 232 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/c79f46a282390e0f5b306007bf7b11a46d529538/ (all 232 configs)


*** ERRORS ***

8 error improvements:
  - /kisskb/src/drivers/staging/octeon/ethernet-defines.h: error: 'CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE' undeclared (first use in this function): 30:38 => 
  - /kisskb/src/drivers/staging/octeon/ethernet-defines.h: error: 'CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE' undeclared (first use in this function); did you mean 'CONFIG_MDIO_OCTEON_MODULE'?: 30:38 => 
  - /kisskb/src/drivers/staging/octeon/ethernet-rx.c: error: 'CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE' undeclared (first use in this function): 190:6 => 
  - /kisskb/src/drivers/staging/octeon/ethernet-rx.c: error: 'OCTEON_IRQ_WORKQ0' undeclared (first use in this function): 472:25 => 
  - /kisskb/src/drivers/staging/octeon/ethernet-rx.c: error: 'OCTEON_IRQ_WORKQ0' undeclared (first use in this function); did you mean 'OCTEON_IS_MODEL'?: 472:25 => 
  - /kisskb/src/drivers/staging/octeon/ethernet-spi.c: error: 'OCTEON_IRQ_RML' undeclared (first use in this function): 224:12, 198:19 => 
  - /kisskb/src/drivers/staging/octeon/ethernet-spi.c: error: 'OCTEON_IRQ_RML' undeclared (first use in this function); did you mean 'OCTEON_IS_MODEL'?: 224:12, 198:19 => 
  - /kisskb/src/drivers/staging/octeon/ethernet-tx.c: error: 'OCTEON_IRQ_TIMER1' undeclared (first use in this function): 705:18, 716:11 => 


*** WARNINGS ***

151 warning regressions:
  + /kisskb/src/arch/m68k/include/asm/amigahw.h: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 42:50
  + /kisskb/src/arch/m68k/include/asm/cmpxchg.h: warning: value computed is not used [-Wunused-value]:  => 79:22, 122:3, 137:3
  + /kisskb/src/arch/m68k/include/asm/raw_io.h: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]:  => 26:31, 33:35, 20:19, 30:32
  + /kisskb/src/arch/m68k/include/asm/string.h: warning: '__builtin_memcpy' forming offset [3, 4] is out of the bounds [0, 2] of object '__gu_val' with type 'short unsigned int' [-Warray-bounds]:  => 72:25
  + /kisskb/src/arch/mips/include/asm/sibyte/bcm1480_scd.h: warning: "M_SPC_CFG_CLEAR" redefined [enabled by default]:  => 261:0
  + /kisskb/src/arch/mips/include/asm/sibyte/bcm1480_scd.h: warning: "M_SPC_CFG_ENABLE" redefined [enabled by default]:  => 262:0
  + /kisskb/src/arch/s390/boot/mem_detect.c: warning: 'detect_memory' uses dynamic stack allocation [enabled by default]:  => 175:1
  + /kisskb/src/arch/s390/kernel/perf_cpum_cf_diag.c: warning: 'cf_diag_push_sample' uses dynamic stack allocation [enabled by default]:  => 519:1
  + /kisskb/src/arch/s390/kernel/perf_cpum_sf.c: warning: 'perf_push_sample' uses dynamic stack allocation [enabled by default]:  => 1134:1
  + /kisskb/src/arch/s390/kernel/unwind_bc.c: warning: 'ip' may be used uninitialized in this function [-Wuninitialized]:  => 168:12, 164:5
  + /kisskb/src/crypto/sha512_generic.c: warning: the frame size of 1176 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 149:1
  + /kisskb/src/drivers/block/null_blk_main.c: warning: 'new_value' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 291:12, 307:48
  + /kisskb/src/drivers/block/null_blk_main.c: warning: 'new_value' may be used uninitialized in this function [-Wuninitialized]:  => 310:1, 326:1, 324:1, 311:1
  + /kisskb/src/drivers/bus/fsl-mc/fsl-mc-bus.c: warning: (near initialization for 'endpoint1.type') [-Wmissing-braces]:  => 719:9
  + /kisskb/src/drivers/bus/fsl-mc/fsl-mc-bus.c: warning: (near initialization for 'endpoint2.type') [-Wmissing-braces]:  => 720:9
  + /kisskb/src/drivers/bus/fsl-mc/fsl-mc-bus.c: warning: (near initialization for 'endpoint_desc.type') [-Wmissing-braces]:  => 718:9
  + /kisskb/src/drivers/bus/fsl-mc/fsl-mc-bus.c: warning: missing braces around initializer [-Wmissing-braces]:  => 718:9, 720:9, 719:9
  + /kisskb/src/drivers/crypto/chelsio/chtls/chtls_cm.c: warning: 'wait_for_states.constprop.28' uses dynamic stack allocation [enabled by default]:  => 403:1
  + /kisskb/src/drivers/crypto/inside-secure/safexcel_cipher.c: warning: the frame size of 1068 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 477:1
  + /kisskb/src/drivers/crypto/inside-secure/safexcel_cipher.c: warning: the frame size of 1088 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 477:1
  + /kisskb/src/drivers/gpu/drm/nouveau/nvkm/subdev/bus/hwsq.c: warning: 'head_sync' may be used uninitialized in this function [-Wuninitialized]:  => 162:16
  + /kisskb/src/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/memx.c: warning: 'head_sync' may be used uninitialized in this function [-Wuninitialized]:  => 154:40
  + /kisskb/src/drivers/gpu/drm/tegra/dpaux.c: warning: 'status' may be used uninitialized in this function [-Wuninitialized]:  => 751:6, 787:6
  + /kisskb/src/drivers/leds/leds-el15203000.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]:  => 246:8
  + /kisskb/src/drivers/media/platform/fsl-viu.c: warning: "in_be32" redefined:  => 37
  + /kisskb/src/drivers/media/platform/fsl-viu.c: warning: "out_be32" redefined:  => 36
  + /kisskb/src/drivers/mfd/htc-pasic3.c: warning: unused variable 'asic' [-Wunused-variable]:  => 186:22
  + /kisskb/src/drivers/net/arcnet/arc-rimi.c: warning: unused variable 'lp' [-Wunused-variable]:  => 346:23
  + /kisskb/src/drivers/net/can/cc770/cc770_platform.c: warning: unused variable 'priv' [-Wunused-variable]:  => 236:21
  + /kisskb/src/drivers/net/ethernet/8390/ax88796.c: warning: unused variable 'ei_local' [-Wunused-variable]:  => 808:20
  + /kisskb/src/drivers/net/ethernet/freescale/fsl_pq_mdio.c: warning: unused variable 'priv' [-Wunused-variable]:  => 518:27
  + /kisskb/src/drivers/net/ethernet/i825xx/sun3_82586.c: warning: array subscript 1 is above array bounds of 'volatile struct transmit_cmd_struct *[1]' [-Warray-bounds]:  => 993:108
  + /kisskb/src/drivers/net/ethernet/marvell/mv643xx_eth.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]:  => 2971:20
  + /kisskb/src/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c: warning: overflow in implicit constant conversion [-Woverflow]:  => 577:41
  + /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: warning: the frame size of 1200 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 302:1
  + /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/wq.c: warning: format '%ld' expects argument of type 'long int', but argument 5 has type 'size_t' [-Wformat]:  => 92:2
  + /kisskb/src/drivers/net/ethernet/neterion/vxge/vxge-config.c: warning: 'vxge_hw_device_hw_info_get' uses dynamic stack allocation [enabled by default]:  => 1089:1
  + /kisskb/src/drivers/net/ethernet/pensando/ionic/ionic_main.c: warning: 'hb' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 331:6
  + /kisskb/src/drivers/net/ethernet/smsc/smc911x.c: warning: unused variable 'lp' [-Wunused-variable]:  => 2117:24
  + /kisskb/src/drivers/net/ethernet/smsc/smc91c92_cs.c: warning: unused variable 'smc' [-Wunused-variable]:  => 958:23
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_add_vlan_id' uses dynamic stack allocation [enabled by default]:  => 315:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_del_vlan_id' uses dynamic stack allocation [enabled by default]:  => 329:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_dev_init' uses dynamic stack allocation [enabled by default]:  => 491:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_query_rgid' uses dynamic stack allocation [enabled by default]:  => 214:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_register_dmb' uses dynamic stack allocation [enabled by default]:  => 280:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_signal_ieq' uses dynamic stack allocation [enabled by default]:  => 357:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_unregister_dmb' uses dynamic stack allocation [enabled by default]:  => 301:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'query_info' uses dynamic stack allocation [enabled by default]:  => 83:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'register_ieq' uses dynamic stack allocation [enabled by default]:  => 139:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'register_sba' uses dynamic stack allocation [enabled by default]:  => 110:1
  + /kisskb/src/drivers/staging/comedi/drivers/pcl816.c: warning: 'last_chan' may be used uninitialized in this function [-Wuninitialized]:  => 148:6
  + /kisskb/src/drivers/staging/comedi/drivers/pcl818.c: warning: 'last_chan' may be used uninitialized in this function [-Wuninitialized]:  => 337:6
  + /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.35' uses dynamic stack allocation [enabled by default]:  => 498:1
  + /kisskb/src/drivers/target/iscsi/iscsi_target.c: warning: 'iscsit_send_datain' uses dynamic stack allocation [enabled by default]:  => 2875:1
  + /kisskb/src/drivers/thermal/broadcom/ns-thermal.c: warning: unused variable 'ns_thermal' [-Wunused-variable]:  => 78:21
  + /kisskb/src/fs/ext4/extents.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]:  => 5054:23
  + /kisskb/src/fs/proc/inode.c: warning: 'pdeo' may be used uninitialized in this function [-Wuninitialized]:  => 374:12
  + /kisskb/src/fs/ubifs/orphan.c: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'ino_t' [-Wformat]:  => 132:3, 140:3
  + /kisskb/src/include/asm-generic/io.h: warning: 'px_cmd' may be used uninitialized in this function [-Wuninitialized]:  => 225:15
  + /kisskb/src/include/asm-generic/io.h: warning: 'px_is' may be used uninitialized in this function [-Wuninitialized]:  => 225:15
  + /kisskb/src/include/linux/kern_levels.h: warning: format '%ld' expects argument of type 'long int', but argument 5 has type 'size_t {aka unsigned int}' [-Wformat=]:  => 5:18
  + /kisskb/src/include/linux/kern_levels.h: warning: format '%ld' expects argument of type 'long int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Wformat=]:  => 5:18
  + /kisskb/src/include/linux/unaligned/le_byteshift.h: warning: array subscript is above array bounds [-Warray-bounds]:  => 26:7
  + /kisskb/src/kernel/bpf/syscall.c: warning: 'bpf_prog_get_info_by_fd.isra.22' uses dynamic stack allocation [enabled by default]:  => 2748:1
  + /kisskb/src/kernel/bpf/syscall.c: warning: 'bpf_prog_show_fdinfo' uses dynamic stack allocation [enabled by default]:  => 1492:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'bucket_find_contain' uses dynamic stack allocation [enabled by default]:  => 367:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_free_coherent' uses dynamic stack allocation [enabled by default]:  => 1490:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_mapping_error' uses dynamic stack allocation [enabled by default]:  => 1321:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_sg_for_cpu' uses dynamic stack allocation [enabled by default]:  => 1604:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_sg_for_device' uses dynamic stack allocation [enabled by default]:  => 1636:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_single_for_cpu' uses dynamic stack allocation [enabled by default]:  => 1551:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_single_for_device' uses dynamic stack allocation [enabled by default]:  => 1571:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_unmap_page' uses dynamic stack allocation [enabled by default]:  => 1338:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_unmap_resource' uses dynamic stack allocation [enabled by default]:  => 1532:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_unmap_sg' uses dynamic stack allocation [enabled by default]:  => 1428:1
  + /kisskb/src/kernel/rseq.c: warning: 'rseq_ip_fixup' uses dynamic stack allocation [enabled by default]:  => 249:1
  + /kisskb/src/kernel/rseq.c: warning: 'rseq_syscall' uses dynamic stack allocation [enabled by default]:  => 300:1
  + /kisskb/src/kernel/sched/cputime.c: warning: 'val' may be used uninitialized in this function [-Wuninitialized]:  => 1007:6
  + /kisskb/src/kernel/smp.c: warning: 'smp_call_function_single' uses dynamic stack allocation [enabled by default]:  => 316:1
  + /kisskb/src/lib/crypto/chacha20poly1305.c: warning: 'chacha20poly1305_crypt_sg_inplace' uses dynamic stack allocation [enabled by default]:  => 332:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_dynamic_all' uses dynamic stack allocation [enabled by default]:  => 269:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_dynamic_partial.isra.29' uses dynamic stack allocation [enabled by default]:  => 268:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_none.isra.63' uses dynamic stack allocation [enabled by default]:  => 275:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_runtime_all.isra.49' uses dynamic stack allocation [enabled by default]:  => 272:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_runtime_partial.isra.41' uses dynamic stack allocation [enabled by default]:  => 271:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_static_all' uses dynamic stack allocation [enabled by default]:  => 266:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_static_partial.isra.17' uses dynamic stack allocation [enabled by default]:  => 265:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_zero.isra.9' uses dynamic stack allocation [enabled by default]:  => 263:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_dynamic_all' uses dynamic stack allocation [enabled by default]:  => 269:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_dynamic_partial' uses dynamic stack allocation [enabled by default]:  => 268:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_none' uses dynamic stack allocation [enabled by default]:  => 275:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_runtime_all' uses dynamic stack allocation [enabled by default]:  => 272:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_runtime_partial' uses dynamic stack allocation [enabled by default]:  => 271:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_static_all' uses dynamic stack allocation [enabled by default]:  => 266:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_static_partial' uses dynamic stack allocation [enabled by default]:  => 265:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_zero' uses dynamic stack allocation [enabled by default]:  => 263:1
  + /kisskb/src/net/bridge/br_device.c: warning: 'br_get_stats64' uses dynamic stack allocation [enabled by default]:  => 221:1
  + /kisskb/src/net/bridge/netfilter/ebtables.c: warning: 'compat_copy_everything_to_user' uses dynamic stack allocation [enabled by default]:  => 1854:1
  + /kisskb/src/net/sunrpc/stats.c: warning: 'rpc_clnt_show_stats' uses dynamic stack allocation [enabled by default]:  => 276:1
  + /kisskb/src/security/integrity/ima/ima_crypto.c: warning: the frame size of 1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 510:1
  + warning: 14 bad relocations:  => N/A
  + warning: 142 bad relocations:  => N/A
  + warning: 2 bad relocations:  => N/A
  + warning: lib/test_bitmap.o(.text.unlikely+0x58): Section mismatch in reference from the function bitmap_equal() to the variable .init.rodata:clump_exp:  => N/A
  + warning: vmlinux.o(.text+0x313c8): Section mismatch in reference from the function setup_scache() to the function .init.text:loongson3_sc_init():  => N/A
  + warning: vmlinux.o(.text+0x36598): Section mismatch in reference from the function mips_sc_init() to the function .init.text:mips_sc_probe_cm3():  => N/A
  + warning: vmlinux.o(.text+0x6ca9c): Section mismatch in reference from the function .fsl_add_bridge() to the function .init.text:.setup_pci_cmd():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2be4): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2be8): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2dec): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2df0): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2e40): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3048): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3dd4): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3de4): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3de8): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3df8): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3e00): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3e14): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x40b4): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x40c4): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x40e0): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x5d0): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x5f4): Section mismatch in reference from the function .smp_setup_pacas() to the function .init.text:.allocate_paca():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x630): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x650): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x71c): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x760): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x79c): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x7e0): Section mismatch in reference from the function mmp2_add_uart() to the function .init.text:pxa_register_device():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x7ec): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart1:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x7f0): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart3:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x7f4): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart4:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x7f8): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart2:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x838): Section mismatch in reference from the function mmp2_add_sdhost() to the function .init.text:pxa_register_device():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x844): Section mismatch in reference from the function mmp2_add_sdhost() to the variable .init.data:mmp2_device_sdh0:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x848): Section mismatch in reference from the function mmp2_add_sdhost() to the variable .init.data:mmp2_device_sdh2:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x84c): Section mismatch in reference from the function mmp2_add_sdhost() to the variable .init.data:mmp2_device_sdh3:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x850): Section mismatch in reference from the function mmp2_add_sdhost() to the variable .init.data:mmp2_device_sdh1:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x874): Section mismatch in reference from the function .smp_setup_pacas() to the function .init.text:.allocate_paca():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x898): Section mismatch in reference from the function mmp2_add_uart() to the function .init.text:pxa_register_device():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x8a4): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart1:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x8a8): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart3:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x8ac): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart4:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x8b0): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart2:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x8f8): Section mismatch in reference from the function mmp2_add_uart() to the function .init.text:pxa_register_device():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x904): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart1:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x908): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart3:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x90c): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart4:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x910): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart2:  => N/A
  + warning: vmlinux.o(.text.unlikely+0xaac): Section mismatch in reference from the function .smp_setup_pacas() to the function .init.text:.allocate_paca():  => N/A

151 warning improvements:
  - /kisskb/src/arch/mips/include/asm/octeon/cvmx.h: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]: 282:17, 299:23 => 
  - /kisskb/src/arch/parisc/include/asm/cmpxchg.h: warning: value computed is not used [-Wunused-value]: 48:3 => 
  - /kisskb/src/drivers/block/paride/ppc6lnx.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 217:2, 329:11, 131:18, 147:2, 235:4, 575:6, 266:4, 162:2, 144:2, 537:5, 146:2, 145:2, 560:4, 142:3, 201:2, 430:15 => 
  - /kisskb/src/drivers/char/tpm/tpm2-cmd.c: warning: 'blob_handle' may be used uninitialized in this function [-Wmaybe-uninitialized]: 669:2 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../powerplay/renoir_ppt.c: warning: (near initialization for 'metrics.ClockFrequency') [-Wmissing-braces]: 186:2 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../powerplay/renoir_ppt.c: warning: missing braces around initializer [-Wmissing-braces]: 186:2 => 
  - /kisskb/src/drivers/hwmon/sch56xx-common.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 132:2 => 
  - /kisskb/src/drivers/hwmon/smsc47b397.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 111:2 => 
  - /kisskb/src/drivers/iommu/io-pgtable-arm-v7s.c: warning: 'cptep' may be used uninitialized in this function [-Wuninitialized]: 517:2, 482:7 => 482:7
  - /kisskb/src/drivers/md/dm-writecache.c: warning: 'g' may be used uninitialized in this function [-Wuninitialized]: 1613:18 => 
  - /kisskb/src/drivers/md/raid10.c: warning: 'best_pending_slot' may be used uninitialized in this function [-Wuninitialized]: 842:22 => 
  - /kisskb/src/drivers/media/platform/fsl-viu.c: warning: "in_be32" redefined [enabled by default]: 37:0 => 
  - /kisskb/src/drivers/media/platform/fsl-viu.c: warning: "out_be32" redefined [enabled by default]: 36:0 => 
  - /kisskb/src/drivers/misc/altera-stapl/altera-lpt.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 20:2, 26:9 => 
  - /kisskb/src/drivers/net/ethernet/8390/wd.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 289:4, 296:4 => 
  - /kisskb/src/drivers/net/ethernet/i825xx/sun3_82586.c: warning: array subscript is above array bounds [-Warray-bounds]: 993:89 => 
  - /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: warning: the frame size of 1160 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 302:1 => 
  - /kisskb/src/drivers/net/macsec.c: warning: 'assoc_num' may be used uninitialized in this function [-Wuninitialized]: 1918:2, 2060:5, 1995:2 => 
  - /kisskb/src/drivers/net/macsec.c: warning: 'rx_sc' may be used uninitialized in this function [-Wuninitialized]: 1918:2 => 
  - /kisskb/src/drivers/net/macsec.c: warning: 'secy' may be used uninitialized in this function [-Wuninitialized]: 2061:21 => 
  - /kisskb/src/drivers/net/macsec.c: warning: 'tx_sc' may be used uninitialized in this function [-Wuninitialized]: 2060:24, 1995:2 => 
  - /kisskb/src/drivers/net/tun.c: warning: 'linear' may be used uninitialized in this function [-Wuninitialized]: 1526:31, 1526:34, 1749:46 => 1749:46, 1526:34
  - /kisskb/src/drivers/scsi/imm.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 495:2, 471:2, 474:2, 464:2, 466:2, 462:2, 342:15, 468:2, 564:2, 248:2, 306:3, 304:3, 487:2 => 
  - /kisskb/src/drivers/scsi/ppa.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 439:2, 399:2, 379:2, 257:15, 245:3, 436:2 => 
  - /kisskb/src/drivers/staging/octeon/ethernet-mem.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 123:18 => 
  - /kisskb/src/drivers/tty/rocket_int.h: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 73:9, 68:9, 46:2, 54:2 => 
  - /kisskb/src/drivers/video/fbdev/sa1100fb.c: warning: 'sa1100fb_min_dma_period' defined but not used [-Wunused-function]: 975:21 => 
  - /kisskb/src/fs/ext4/inode.c: warning: format '%zd' expects argument of type 'signed size_t', but argument 6 has type 'ssize_t {aka int}' [-Wformat=]: 3621:12 => 
  - /kisskb/src/fs/ext4/page-io.c: warning: format '%zd' expects argument of type 'signed size_t', but argument 6 has type 'ssize_t {aka int}' [-Wformat=]: 155:5 => 
  - /kisskb/src/fs/nfs/nfs3acl.c: warning: value computed is not used [-Wunused-value]: 44:2 => 
  - /kisskb/src/fs/posix_acl.c: warning: value computed is not used [-Wunused-value]: 148:3 => 
  - /kisskb/src/include/linux/via-core.h: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 206:2, 192:2, 198:2 => 
  - /kisskb/src/include/net/sock.h: warning: 'sk' may be used uninitialized in this function [-Wuninitialized]: 1965:19 => 
  - /kisskb/src/kernel/acct.c: warning: value computed is not used [-Wunused-value]: 177:2 => 
  - /kisskb/src/kernel/kexec_file.c: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]: 1324:19, 1307:19 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 280>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 3c0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 780>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U a00>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U f00>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1140>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1820>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2640>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2c80>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3640>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3820>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3aa0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3d20>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3e60>]' may be used uninitialized in this function [-Wuninitialized]: 140:32, 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4460>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U51e0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5640>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5780>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U58c0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5a00>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5b40>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6140>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6320>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U66e0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6960>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7000>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7320>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7500>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7640>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7820>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7c80>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7f00>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8140>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8640>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8780>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U91e0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9320>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9460>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9780>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9820>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9960>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9b40>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9d20>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9e60>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua1e0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub140>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubc80>]' may be used uninitialized in this function [-Wuninitialized]: 140:32, 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc320>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc460>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud140>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud500>]' may be used uninitialized in this function [-Wuninitialized]: 140:32, 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud820>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Udc80>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uddc0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue0a0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue280>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue6e0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34, 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue820>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ueb40>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf140>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf500>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf6e0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/mm/memcontrol.c: warning: value computed is not used [-Wunused-value]: 1161:4 => 
  - /kisskb/src/net/core/filter.c: warning: value computed is not used [-Wunused-value]: 3603:4 => 
  - /kisskb/src/net/core/sysctl_net_core.c: warning: 'proc_dointvec_minmax_bpf_restricted' defined but not used [-Wunused-function]: 292:1 => 
  - /kisskb/src/sound/soc/soc-pcm.c: warning: unused variable 'name' [-Wunused-variable]: 1149:8 => 
  - warning: "clear_page" [drivers/gpu/drm/ttm/ttm.ko] has no CRC!: N/A => 
  - warning: "copy_page" [drivers/gpu/drm/ttm/ttm.ko] has no CRC!: N/A => 
  - warning: "return_address" [vmlinux] is a static EXPORT_SYMBOL_GPL: N/A => 
  - warning: 12 bad relocations: N/A => 
  - warning: 140 bad relocations: N/A => 
  - warning: vmlinux.o(.text+0x6ee98): Section mismatch in reference from the function .fsl_add_bridge() to the function .init.text:.setup_pci_cmd(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2aec): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2af0): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2cf4): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2cf8): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2d18): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2f20): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3cdc): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3cec): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3cf0): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3d00): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3d08): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3d1c): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3f8c): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3f9c): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3fb8): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x538): Section mismatch in reference from the function .smp_setup_pacas() to the function .init.text:.allocate_paca(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x590): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x5f0): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x610): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x6dc): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x6e4): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x75c): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x77c): Section mismatch in reference from the function .smp_setup_pacas() to the function .init.text:.allocate_paca(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x7ac): Section mismatch in reference from the function mmp2_add_uart() to the function .init.text:pxa_register_device(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x7b8): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart1: N/A => 
  - warning: vmlinux.o(.text.unlikely+0x7bc): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart3: N/A => 
  - warning: vmlinux.o(.text.unlikely+0x7c0): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart4: N/A => 
  - warning: vmlinux.o(.text.unlikely+0x7c4): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart2: N/A => 
  - warning: vmlinux.o(.text.unlikely+0x804): Section mismatch in reference from the function mmp2_add_sdhost() to the function .init.text:pxa_register_device(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x810): Section mismatch in reference from the function mmp2_add_sdhost() to the variable .init.data:mmp2_device_sdh0: N/A => 
  - warning: vmlinux.o(.text.unlikely+0x814): Section mismatch in reference from the function mmp2_add_sdhost() to the variable .init.data:mmp2_device_sdh2: N/A => 
  - warning: vmlinux.o(.text.unlikely+0x818): Section mismatch in reference from the function mmp2_add_sdhost() to the variable .init.data:mmp2_device_sdh3: N/A => 
  - warning: vmlinux.o(.text.unlikely+0x81c): Section mismatch in reference from the function mmp2_add_sdhost() to the variable .init.data:mmp2_device_sdh1: N/A => 
  - warning: vmlinux.o(.text.unlikely+0x864): Section mismatch in reference from the function mmp2_add_uart() to the function .init.text:pxa_register_device(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x870): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart1: N/A => 
  - warning: vmlinux.o(.text.unlikely+0x874): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart3: N/A => 
  - warning: vmlinux.o(.text.unlikely+0x878): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart4: N/A => 
  - warning: vmlinux.o(.text.unlikely+0x87c): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart2: N/A => 
  - warning: vmlinux.o(.text.unlikely+0x8c4): Section mismatch in reference from the function mmp2_add_uart() to the function .init.text:pxa_register_device(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x8d0): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart1: N/A => 
  - warning: vmlinux.o(.text.unlikely+0x8d4): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart3: N/A => 
  - warning: vmlinux.o(.text.unlikely+0x8d8): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart4: N/A => 
  - warning: vmlinux.o(.text.unlikely+0x8dc): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart2: N/A => 
  - warning: vmlinux.o(.text.unlikely+0x984): Section mismatch in reference from the function .smp_setup_pacas() to the function .init.text:.allocate_paca(): N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
