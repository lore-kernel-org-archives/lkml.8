Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E8EC11D00
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 00:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CEAF2467B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 00:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AIk9KHsA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbgBUAow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 19:44:52 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:33582 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729573AbgBUAot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 19:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582245888; x=1613781888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8c/5N2kvrmrBNODCFRL3268dedGpJfrgPqdASr288Ac=;
  b=AIk9KHsA60QOM6fATAjc9XK7Eak2t7WfcdmU1n8MBxlIIOsa+jpRQAup
   65T6tJzLCOcpKBf+CBsYOC5zeCBSQWsUJJCN431owT2F6bWdEIzdPR+va
   V3NF2SKlLCzKdziXeFKB4e9vq922CzIvNEPflQ+beoJ1EZt0irtkVqRgn
   U4XCEEhzvS224xIyixk9ST+Oi475QV0otBsgAaKVyV7RME2JxE8HIjRak
   qB9sGqlvoTwGhwvTuhrDQyfNuoIMTUuPYutjX8y5C0PFvbhqWZ+8dzNN2
   /9FJiCCM08noD/2sTTb7Mk+iCJ0YKiGsTB6nqkGLalK1LzKWx1UcXn/mI
   Q==;
IronPort-SDR: BgJDBXuDdDMX1HLOMt6rLLX6UkNTz9PlUW4prcv7doBp+XLfCHfQGfw5mSRzAnRjABmXcmjcw4
 +Sr5QW2iaysdPGG1GOhEO8ppoxc52KqF+bFMMnPgzldFVO6aTSIQ27sNqmE/21iUC5mFUU+9GU
 xtZoLwdsvJeNhyysHxUku/jUV7ZyTwLgwSgekH65ShayO/22HgppTo0cJmE4gNrl/oxEE7VoIq
 wZBWnHmXkNmO6JAkrZmOvwttaYrDL8YP9oC7ehdPSqWtXh3C81PXDklZ1CFJQpS2xp30djYBbZ
 RgE=
X-IronPort-AV: E=Sophos;i="5.70,466,1574092800"; 
   d="scan'208";a="130319936"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2020 08:44:47 +0800
IronPort-SDR: wNrNwpDKYpHqdQ2T9xgFfs2DuQ7znAxzqhfvTBPGl9X26nl16h9bfkZ/aanAxXv7IobuF4d12H
 CSQB6dy3zrABE0voN+zCPXrg65IHsYpuNcrK6o3dnc4fEk04bE29FLKcj3ElGYAbxWWWr1lhBz
 EupdCkb202cz8ozY/dTvdSlHnwe0o7xMpSdTzMUqSbPO1EGcaS7XilDClsLB6OAuFyF6p7mIg4
 0PS7cuCQrHy2UghXkjD9ctaKip170pxkgeDfVhWyKlkBCYayG+9zlQLZnWwjaYM6g22cefKsnY
 e3Uxq16r0Ao4phRBgj70zrkx
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 16:37:22 -0800
IronPort-SDR: ALw4pD7Zrp1hGjJbEHPr+eN2kmwL3Tzzzitj0lsyGXr7KZ4Eak/QU+Txtn+bOAo3Dtmg43HmmK
 4kznmGsWsGY/IU0clAF71Wu6LHEL9sjyLr16BgLUwUSYclCVdcGr/fJynnNhIdvlKKjMAmY4a1
 Ak70OIgXgieHB3ucNvRmyJT/hG0Njt976ZQHWA1PklvE28JdEjOhau1G1xgifeLcy6ktKDcZGG
 DUQaeckvMXn7Uyu3cBejrAX7Hjoq3M38Rwtef4JpWb1KWvn7f9XAndodGKxdfiCIsK08zBaif/
 Ggc=
WDCIronportException: Internal
Received: from yoda.sdcorp.global.sandisk.com (HELO yoda.int.fusionio.com) ([10.196.158.80])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Feb 2020 16:44:47 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Borislav Petkov <bp@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Marc Zyngier <maz@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH v9 06/12] RISC-V: Move relocate and few other functions out of __init
Date:   Thu, 20 Feb 2020 16:44:07 -0800
Message-Id: <20200221004413.12869-7-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221004413.12869-1-atish.patra@wdc.com>
References: <20200221004413.12869-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The secondary hart booting and relocation code are under .init section.
As a result, it will be freed once kernel booting is done. However,
ordered booting protocol and CPU hotplug always requires these functions
to be present to bringup harts after initial kernel boot.

Move the required functions to a different section and make sure that
they are in memory within first 2MB offset as trampoline page directory
only maps first 2MB.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/kernel/head.S        | 153 +++++++++++++++++---------------
 arch/riscv/kernel/vmlinux.lds.S |   5 +-
 2 files changed, 86 insertions(+), 72 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 271860fc2c3f..b85376d84098 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -14,7 +14,7 @@
 #include <asm/hwcap.h>
 #include <asm/image.h>
 
-__INIT
+__HEAD
 ENTRY(_start)
 	/*
 	 * Image header expected by Linux boot-loaders. The image header data
@@ -45,8 +45,85 @@ ENTRY(_start)
 	.ascii RISCV_IMAGE_MAGIC2
 	.word 0
 
-.global _start_kernel
-_start_kernel:
+.align 2
+#ifdef CONFIG_MMU
+relocate:
+	/* Relocate return address */
+	li a1, PAGE_OFFSET
+	la a2, _start
+	sub a1, a1, a2
+	add ra, ra, a1
+
+	/* Point stvec to virtual address of intruction after satp write */
+	la a2, 1f
+	add a2, a2, a1
+	csrw CSR_TVEC, a2
+
+	/* Compute satp for kernel page tables, but don't load it yet */
+	srl a2, a0, PAGE_SHIFT
+	li a1, SATP_MODE
+	or a2, a2, a1
+
+	/*
+	 * Load trampoline page directory, which will cause us to trap to
+	 * stvec if VA != PA, or simply fall through if VA == PA.  We need a
+	 * full fence here because setup_vm() just wrote these PTEs and we need
+	 * to ensure the new translations are in use.
+	 */
+	la a0, trampoline_pg_dir
+	srl a0, a0, PAGE_SHIFT
+	or a0, a0, a1
+	sfence.vma
+	csrw CSR_SATP, a0
+.align 2
+1:
+	/* Set trap vector to spin forever to help debug */
+	la a0, .Lsecondary_park
+	csrw CSR_TVEC, a0
+
+	/* Reload the global pointer */
+.option push
+.option norelax
+	la gp, __global_pointer$
+.option pop
+
+	/*
+	 * Switch to kernel page tables.  A full fence is necessary in order to
+	 * avoid using the trampoline translations, which are only correct for
+	 * the first superpage.  Fetching the fence is guarnteed to work
+	 * because that first superpage is translated the same way.
+	 */
+	csrw CSR_SATP, a2
+	sfence.vma
+
+	ret
+#endif /* CONFIG_MMU */
+#ifdef CONFIG_SMP
+	/* Set trap vector to spin forever to help debug */
+	la a3, .Lsecondary_park
+	csrw CSR_TVEC, a3
+
+	slli a3, a0, LGREG
+	.global secondary_start_common
+secondary_start_common:
+
+#ifdef CONFIG_MMU
+	/* Enable virtual memory and relocate to virtual address */
+	la a0, swapper_pg_dir
+	call relocate
+#endif
+	tail smp_callin
+#endif /* CONFIG_SMP */
+
+.Lsecondary_park:
+	/* We lack SMP support or have too many harts, so park this hart */
+	wfi
+	j .Lsecondary_park
+
+END(_start)
+
+	__INIT
+ENTRY(_start_kernel)
 	/* Mask all interrupts */
 	csrw CSR_IE, zero
 	csrw CSR_IP, zero
@@ -128,59 +205,6 @@ clear_bss_done:
 	call parse_dtb
 	tail start_kernel
 
-#ifdef CONFIG_MMU
-relocate:
-	/* Relocate return address */
-	li a1, PAGE_OFFSET
-	la a2, _start
-	sub a1, a1, a2
-	add ra, ra, a1
-
-	/* Point stvec to virtual address of intruction after satp write */
-	la a2, 1f
-	add a2, a2, a1
-	csrw CSR_TVEC, a2
-
-	/* Compute satp for kernel page tables, but don't load it yet */
-	srl a2, a0, PAGE_SHIFT
-	li a1, SATP_MODE
-	or a2, a2, a1
-
-	/*
-	 * Load trampoline page directory, which will cause us to trap to
-	 * stvec if VA != PA, or simply fall through if VA == PA.  We need a
-	 * full fence here because setup_vm() just wrote these PTEs and we need
-	 * to ensure the new translations are in use.
-	 */
-	la a0, trampoline_pg_dir
-	srl a0, a0, PAGE_SHIFT
-	or a0, a0, a1
-	sfence.vma
-	csrw CSR_SATP, a0
-.align 2
-1:
-	/* Set trap vector to spin forever to help debug */
-	la a0, .Lsecondary_park
-	csrw CSR_TVEC, a0
-
-	/* Reload the global pointer */
-.option push
-.option norelax
-	la gp, __global_pointer$
-.option pop
-
-	/*
-	 * Switch to kernel page tables.  A full fence is necessary in order to
-	 * avoid using the trampoline translations, which are only correct for
-	 * the first superpage.  Fetching the fence is guarnteed to work
-	 * because that first superpage is translated the same way.
-	 */
-	csrw CSR_SATP, a2
-	sfence.vma
-
-	ret
-#endif /* CONFIG_MMU */
-
 .Lsecondary_start:
 #ifdef CONFIG_SMP
 	/* Set trap vector to spin forever to help debug */
@@ -205,16 +229,10 @@ relocate:
 	beqz tp, .Lwait_for_cpu_up
 	fence
 
-#ifdef CONFIG_MMU
-	/* Enable virtual memory and relocate to virtual address */
-	la a0, swapper_pg_dir
-	call relocate
+	tail secondary_start_common
 #endif
 
-	tail smp_callin
-#endif
-
-END(_start)
+END(_start_kernel)
 
 #ifdef CONFIG_RISCV_M_MODE
 ENTRY(reset_regs)
@@ -295,13 +313,6 @@ ENTRY(reset_regs)
 END(reset_regs)
 #endif /* CONFIG_RISCV_M_MODE */
 
-.section ".text", "ax",@progbits
-.align 2
-.Lsecondary_park:
-	/* We lack SMP support or have too many harts, so park this hart */
-	wfi
-	j .Lsecondary_park
-
 __PAGE_ALIGNED_BSS
 	/* Empty zero page */
 	.balign PAGE_SIZE
diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 1e0193ded420..b32640300d07 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -10,6 +10,7 @@
 #include <asm/cache.h>
 #include <asm/thread_info.h>
 
+#include <linux/sizes.h>
 OUTPUT_ARCH(riscv)
 ENTRY(_start)
 
@@ -20,8 +21,10 @@ SECTIONS
 	/* Beginning of code and text segment */
 	. = LOAD_OFFSET;
 	_start = .;
-	__init_begin = .;
 	HEAD_TEXT_SECTION
+	. = ALIGN(PAGE_SIZE);
+
+	__init_begin = .;
 	INIT_TEXT_SECTION(PAGE_SIZE)
 	INIT_DATA_SECTION(16)
 	/* we have to discard exit text and such at runtime, not link time */
-- 
2.25.0

