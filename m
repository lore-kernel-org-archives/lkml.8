Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAE4C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1865E20729
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgGTNJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgGTNJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:09:45 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99A9C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 06:09:44 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by michel.telenet-ops.be with bizsmtp
        id 5R9g2300V4C55Sk06R9goA; Mon, 20 Jul 2020 15:09:42 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jxVY4-0000CD-Hm
        for linux-kernel@vger.kernel.org; Mon, 20 Jul 2020 15:09:40 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jxVW5-0001Aw-HZ
        for linux-kernel@vger.kernel.org; Mon, 20 Jul 2020 15:07:37 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.8-rc6
Date:   Mon, 20 Jul 2020 15:07:37 +0200
Message-Id: <20200720130737.4428-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v5.8-rc6[1] compared to v5.7[2].

Summarized:
  - build errors: +7/-1
  - build warnings: +35/-85

JFYI, when comparing v5.8-rc6[1] to v5.8-rc5[3], the summaries are:
  - build errors: +6/-3
  - build warnings: +0/-48

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ba47d845d715a010f7b51f6f89bae32845e6acb7/ (192 out of 194 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162/ (all 194 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/11ba468877bb23f28956a35e896356252d63c983/ (192 out of 194 configs)


*** ERRORS ***

7 error regressions:
  + error: arch/sparc/kernel/head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text':  => (.head.text+0x5040), (.head.text+0x5100)
  + error: arch/sparc/kernel/head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o:  => (.init.text+0xa4)
  + error: arch/sparc/kernel/process_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0xc), (.fixup+0x4)
  + error: arch/sparc/kernel/signal_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0x34), (.fixup+0x4), (.fixup+0x10), (.fixup+0x28), (.fixup+0x1c)
  + error: modpost: "devm_platform_ioremap_resource" [drivers/iio/adc/adi-axi-adc.ko] undefined!:  => N/A
  + error: modpost: "devm_platform_ioremap_resource" [drivers/ptp/ptp_ines.ko] undefined!:  => N/A
  + error: modpost: "devm_platform_ioremap_resource" [drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.ko] undefined!:  => N/A

1 error improvements:
  - error: modpost: "devm_ioremap_resource" [drivers/ptp/ptp_ines.ko] undefined!: N/A => 


*** WARNINGS ***

35 warning regressions:
  + /kisskb/src/block/genhd.c: warning: the frame size of 1160 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 1623:1
  + /kisskb/src/drivers/mailbox/imx-mailbox.c: warning: 'imx_mu_resume_noirq' defined but not used [-Wunused-function]:  => 611:12
  + /kisskb/src/drivers/mailbox/imx-mailbox.c: warning: 'imx_mu_runtime_resume' defined but not used [-Wunused-function]:  => 638:12
  + /kisskb/src/drivers/mailbox/imx-mailbox.c: warning: 'imx_mu_runtime_suspend' defined but not used [-Wunused-function]:  => 629:12
  + /kisskb/src/drivers/mailbox/imx-mailbox.c: warning: 'imx_mu_suspend_noirq' defined but not used [-Wunused-function]:  => 601:12
  + /kisskb/src/drivers/net/ethernet/intel/ice/ice_flow.h: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]:  => 197:33
  + /kisskb/src/drivers/net/ethernet/intel/ice/ice_flow.h: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]:  => 198:32
  + /kisskb/src/drivers/scsi/dc395x.c: warning: value computed is not used [-Wunused-value]:  => 155:36
  + /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.39' uses dynamic stack allocation:  => 498:1
  + /kisskb/src/include/linux/compiler_attributes.h: warning: statement will never be executed [-Wswitch-unreachable]:  => 201:41
  + /kisskb/src/kernel/bpf/syscall.c: warning: 'bpf_prog_get_info_by_fd.isra.24' uses dynamic stack allocation:  => 3498:1
  + /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.57' uses dynamic stack allocation:  => 2230:1
  + /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.56' uses dynamic stack allocation:  => 1929:1
  + /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.55' uses dynamic stack allocation:  => 2298:1
  + /kisskb/src/net/smc/smc_llc.c: warning: (near initialization for 'add_llc.hd') [-Wmissing-braces]:  => 1164:9
  + /kisskb/src/net/smc/smc_llc.c: warning: (near initialization for 'del_llc.hd') [-Wmissing-braces]:  => 1197:9
  + /kisskb/src/net/smc/smc_llc.c: warning: (near initialization for 'delllc.hd') [-Wmissing-braces]:  => 1269:9
  + /kisskb/src/net/smc/smc_llc.c: warning: missing braces around initializer [-Wmissing-braces]:  => 1197:9, 1269:9, 1164:9
  + /kisskb/src/samples/seccomp/user-trap.c: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]:  => 50:2, 83:2
  + modpost: WARNING: modpost: EXPORT symbol "___rw_read_enter" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "___rw_read_exit" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "___rw_read_try" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "___rw_write_enter" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__ashldi3" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__ashrdi3" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__copy_1page" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__divdi3" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__lshrdi3" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__muldi3" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__ndelay" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__udelay" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "bzero_1page" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "empty_zero_page" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + warning: 136 bad relocations:  => N/A
  + warning: 148 bad relocations:  => N/A

85 warning improvements:
  - /kisskb/src/arch/m68k/include/asm/amigahw.h: warning: this statement may fall through [-Wimplicit-fallthrough=]: 42:50 => 
  - /kisskb/src/block/genhd.c: warning: the frame size of 1192 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 1617:1 => 
  - /kisskb/src/drivers/android/binderfs.c: warning: (near initialization for 'device_info.name') [-Wmissing-braces]: 653:9 => 
  - /kisskb/src/drivers/android/binderfs.c: warning: missing braces around initializer [-Wmissing-braces]: 653:9 => 
  - /kisskb/src/drivers/base/component.c: warning: format '%zu' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat=]: 195:24 => 
  - /kisskb/src/drivers/base/regmap/regcache.c: warning: format '%zu' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat=]: 715:20 => 
  - /kisskb/src/drivers/base/regmap/regmap.c: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'unsigned int' [-Wformat=]: 1533:22 => 
  - /kisskb/src/drivers/dma-buf/dma-buf.c: warning: format '%zu' expects argument of type 'size_t', but argument 3 has type 'unsigned int' [-Wformat=]: 404:26 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c: warning: (near initialization for 'encoder_control.header') [-Wmissing-braces]: 116:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c: warning: (near initialization for 'pixel_clock.header') [-Wmissing-braces]: 342:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c: warning: missing braces around initializer [-Wmissing-braces]: 342:9, 116:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hubp.c: warning: (near initialization for 'PLAT_54186_wa.header') [-Wmissing-braces]: 781:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hubp.c: warning: missing braces around initializer [-Wmissing-braces]: 368:9, 781:9 => 368:9
  - /kisskb/src/drivers/gpu/drm/bridge/tc358768.c: warning: the frame size of 2224 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 840:1 => 
  - /kisskb/src/drivers/gpu/drm/drm_atomic_uapi.c: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'unsigned int' [-Wformat=]: 131:21 => 
  - /kisskb/src/drivers/gpu/drm/drm_dp_dual_mode_helper.c: warning: format '%zd' expects argument of type 'signed size_t', but argument 4 has type 'ssize_t {aka int}' [-Wformat=]: 222:16 => 
  - /kisskb/src/drivers/gpu/drm/drm_dp_dual_mode_helper.c: warning: format '%zd' expects argument of type 'signed size_t', but argument 5 has type 'ssize_t {aka int}' [-Wformat=]: 203:16 => 
  - /kisskb/src/drivers/gpu/drm/drm_dp_helper.c: warning: format '%zu' expects argument of type 'size_t', but argument 3 has type 'unsigned int' [-Wformat=]: 844:18 => 
  - /kisskb/src/drivers/gpu/drm/drm_dp_helper.c: warning: format '%zu' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat=]: 790:18, 757:18 => 
  - /kisskb/src/drivers/gpu/drm/drm_dp_mst_topology.c: warning: (near initialization for 'desc.ident') [-Wmissing-braces]: 5502:9 => 
  - /kisskb/src/drivers/gpu/drm/drm_dp_mst_topology.c: warning: missing braces around initializer [-Wmissing-braces]: 5502:9 => 
  - /kisskb/src/drivers/gpu/drm/drm_gem_cma_helper.c: warning: format '%zu' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat=]: 108:21, 503:18 => 
  - /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.34' uses dynamic stack allocation: 498:1 => 
  - /kisskb/src/drivers/tty/n_tty.c: warning: format '%zu' expects argument of type 'size_t', but argument 3 has type 'unsigned int' [-Wformat=]: 2059:14, 2037:14 => 
  - /kisskb/src/drivers/tty/n_tty.c: warning: format '%zu' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat=]: 2037:14 => 
  - /kisskb/src/drivers/tty/n_tty.c: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'unsigned int' [-Wformat=]: 2037:14, 2059:14 => 
  - /kisskb/src/drivers/tty/n_tty.c: warning: format '%zu' expects argument of type 'size_t', but argument 6 has type 'unsigned int' [-Wformat=]: 2037:14, 2059:14 => 
  - /kisskb/src/drivers/tty/n_tty.c: warning: format '%zu' expects argument of type 'size_t', but argument 7 has type 'unsigned int' [-Wformat=]: 2059:14 => 
  - /kisskb/src/drivers/tty/n_tty.c: warning: format '%zu' expects argument of type 'size_t', but argument 8 has type 'unsigned int' [-Wformat=]: 2059:14 => 
  - /kisskb/src/drivers/usb/host/ehci-q.c: warning: format '%zu' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat=]: 376:2 => 
  - /kisskb/src/drivers/usb/host/ehci-q.c: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'unsigned int' [-Wformat=]: 376:2 => 
  - /kisskb/src/fs/buffer.c: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'unsigned int' [-Wformat=]: 237:10 => 
  - /kisskb/src/fs/ext4/xattr.c: warning: format '%zu' expects argument of type 'size_t', but argument 6 has type 'unsigned int' [-Wformat=]: 482:8 => 
  - /kisskb/src/include/drm/drm_print.h: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'unsigned int' [-Wformat=]: 120:24 => 
  - /kisskb/src/include/linux/dev_printk.h: warning: format '%zu' expects argument of type 'size_t', but argument 8 has type 'unsigned int' [-Wformat=]: 232:23 => 
  - /kisskb/src/include/linux/kern_levels.h: warning: format '%zd' expects argument of type 'signed size_t', but argument 3 has type 'size_t {aka const unsigned int}' [-Wformat=]: 5:18 => 
  - /kisskb/src/include/linux/kern_levels.h: warning: format '%zd' expects argument of type 'signed size_t', but argument 3 has type 'size_t {aka unsigned int}' [-Wformat=]: 5:18 => 
  - /kisskb/src/include/linux/kern_levels.h: warning: format '%zu' expects argument of type 'size_t', but argument 2 has type 'unsigned int' [-Wformat=]: 5:18 => 
  - /kisskb/src/include/linux/kern_levels.h: warning: format '%zu' expects argument of type 'size_t', but argument 3 has type 'unsigned int' [-Wformat=]: 5:18 => 
  - /kisskb/src/include/linux/kern_levels.h: warning: format '%zu' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat=]: 5:18 => 
  - /kisskb/src/include/linux/kern_levels.h: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'unsigned int' [-Wformat=]: 5:18 => 
  - /kisskb/src/include/linux/kern_levels.h: warning: format '%zu' expects argument of type 'size_t', but argument 6 has type 'unsigned int' [-Wformat=]: 5:18 => 
  - /kisskb/src/include/linux/kernel.h: warning: comparison of distinct pointer types lacks a cast: 842:29 => 
  - /kisskb/src/include/linux/overflow.h: warning: comparison of distinct pointer types lacks a cast: 59:15, 60:15 => 
  - /kisskb/src/init/main.c: warning: format '%zu' expects argument of type 'size_t', but argument 3 has type '__kernel_size_t {aka unsigned int}' [-Wformat=]: 1082:37 => 
  - /kisskb/src/init/main.c: warning: format '%zu' expects argument of type 'size_t', but argument 3 has type 'unsigned int' [-Wformat=]: 611:35, 1280:35, 615:35 => 
  - /kisskb/src/kernel/bpf/syscall.c: warning: 'bpf_prog_get_info_by_fd.isra.23' uses dynamic stack allocation: 3269:1 => 
  - /kisskb/src/kernel/dma/direct.c: warning: format '%zu' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat=]: 407:9 => 
  - /kisskb/src/lib/test_kasan.c: warning: 'kasan_alloca_oob_left' uses dynamic stack allocation: 547:1 => 
  - /kisskb/src/lib/test_kasan.c: warning: 'kasan_alloca_oob_right' uses dynamic stack allocation: 557:1 => 
  - /kisskb/src/mm/dmapool.c: warning: format '%zu' expects argument of type 'size_t', but argument 6 has type 'unsigned int' [-Wformat=]: 93:46 => 
  - /kisskb/src/mm/dmapool.c: warning: format '%zu' expects argument of type 'size_t', but argument 7 has type 'unsigned int' [-Wformat=]: 93:51 => 
  - /kisskb/src/mm/percpu.c: warning: format '%zu' expects argument of type 'size_t', but argument 3 has type 'unsigned int' [-Wformat=]: 2297:35, 2166:27, 1334:35, 2315:35, 1321:35, 1306:35, 1328:35, 2309:35, 2303:35 => 
  - /kisskb/src/mm/percpu.c: warning: format '%zu' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat=]: 2166:32 => 
  - /kisskb/src/mm/percpu.c: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'unsigned int' [-Wformat=]: 1593:17, 2166:37 => 
  - /kisskb/src/mm/percpu.c: warning: format '%zu' expects argument of type 'size_t', but argument 6 has type 'unsigned int' [-Wformat=]: 1593:17, 2166:42 => 
  - /kisskb/src/mm/percpu.c: warning: format '%zu' expects argument of type 'size_t', but argument 7 has type 'unsigned int' [-Wformat=]: 2166:52 => 
  - /kisskb/src/mm/percpu.c: warning: format '%zu' expects argument of type 'size_t', but argument 8 has type 'unsigned int' [-Wformat=]: 2166:56 => 
  - /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.42' uses dynamic stack allocation: 2203:1 => 
  - /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.41' uses dynamic stack allocation: 1910:1 => 
  - /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.40' uses dynamic stack allocation: 2271:1 => 
  - /kisskb/src/net/sunrpc/svc.c: warning: format '%zd' expects argument of type 'signed size_t', but argument 3 has type 'size_t {aka unsigned int}' [-Wformat=]: 1440:33 => 
  - /kisskb/src/net/sunrpc/xprtsock.c: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'unsigned int' [-Wformat=]: 2501:16 => 
  - /kisskb/src/security/integrity/ima/ima_crypto.c: warning: the frame size of 1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 510:1 => 
  - modpost: WARNING: modpost: "clear_page" [drivers/md/dm-integrity.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "clear_page" [drivers/md/raid456.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "clear_page" [drivers/scsi/sd_mod.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "clear_page" [fs/btrfs/btrfs.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "clear_page" [fs/fuse/fuse.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "clear_page" [fs/gfs2/gfs2.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "clear_page" [fs/ntfs/ntfs.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "clear_page" [fs/ocfs2/dlm/ocfs2_dlm.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "copy_page" [drivers/block/drbd/drbd.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "copy_page" [drivers/md/dm-integrity.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "copy_page" [fs/btrfs/btrfs.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "copy_page" [fs/cachefiles/cachefiles.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "copy_page" [fs/fuse/fuse.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "copy_page" [fs/nilfs2/nilfs2.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: lib/test_bitmap.o(.text.unlikely+0x58): Section mismatch in reference from the function bitmap_equal() to the variable .init.rodata:clump_exp: N/A => 
  - modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x1a0): Section mismatch in reference from the function early_init_mmu() to the function .init.text:radix__early_init_mmu(): N/A => 
  - modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x1ac): Section mismatch in reference from the function early_init_mmu() to the function .init.text:hash__early_init_mmu(): N/A => 
  - modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x2b0): Section mismatch in reference from the function early_init_mmu() to the function .init.text:radix__early_init_mmu(): N/A => 
  - modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x2bc): Section mismatch in reference from the function early_init_mmu() to the function .init.text:hash__early_init_mmu(): N/A => 
  - warning: 12 bad relocations: N/A => 
  - warning: unmet direct dependencies detected for SND_SOC_WM9712: N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
