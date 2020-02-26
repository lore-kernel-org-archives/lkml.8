Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA64FC4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796AD24656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BzH0wBNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgBZWC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 17:02:28 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:45025 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbgBZWCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 17:02:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582754544; x=1614290544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8c/5N2kvrmrBNODCFRL3268dedGpJfrgPqdASr288Ac=;
  b=BzH0wBNsV4vXxFDFJ82Lm9liyQrvGnZ+2HtQ38b1n+GSvnzjfNyxNKAX
   3zilTFwstGONYsLVQv7RhXy6ljy9HiUdjhmI6zsgh5aOT0uHxa9NX3LPd
   glWQohQC4N5HTSNfN2krhTYkocxjeZ1Lf3I93f7zny9MxVEGduMR/oKNn
   oOkBUW3eG/RyoEOwQICCSBcMclE4iEZnz4vi14JMGxYNZ1/uUD+A4l9DK
   /pkjILSdng8do1DpAKJx/vNZKOn9VgCeg4UWn8uWCsbvQmNTlsWCy3Tdc
   B1gdD1osCumo1MWGUm+x2hgLrwmANUp8iJuVRToJW2mWVCov/cjG3eqZ3
   g==;
IronPort-SDR: p0ccIoAaLedBnl2i3j1e4PuDJuSfVBmERSPdC4IZ65JRyxNwskDR3W62O8rTx8yXgARKLhTeTj
 6xWY5lsoF2ZLJq4Zcw1r4s120CohIonIMfkNiT+wLNDfNdRHFK0cZAzQdwlDI2Z40+hgLr8u/1
 YfpoDKE//iGysvzCdEDpj/lxIxIH/HsdrJYrtT1v9jpqbE4mz0g+ViFzu3BKHQkQpkBOMmXeT8
 m/a3BoxWuj5ncECqIBG3GdQPFeq+jNPbGIZcnOlMf1Xw8vA/Ff0x02gi0ZH6CVEQs4p4Z65SEA
 pH0=
X-IronPort-AV: E=Sophos;i="5.70,489,1574092800"; 
   d="scan'208";a="132290729"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2020 06:02:24 +0800
IronPort-SDR: cLwW+Zd7OQuuzDGUH9TQ8u0XOo0squ0sknt/5l+5npb5ZfGXoikpFnbbRsVHq/t47GGykAWCnM
 Ek9AmPNVodTWopsxKVBeyIUT81M67aK3UUZD/XMjLB0cRizQGQn6uBJRp0KXJHmf99je7weyFS
 eL/lFy6NZahiuKjtwJcv9a8XvmwDLlLwS/w68CE+8cOr3DrxYAcsWfs5c2yFJTskPfwScQBSYv
 EPVJAIDJSpKxWvO+JF2n6Xxszury/Di3phC5luPKkzFy8+UN6ro24OL30BSEhQjhnURYabCndN
 pZiwOPvQXB424AKml7RoxG6T
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 13:54:48 -0800
IronPort-SDR: s6Ejgq1nBFxBYHarBsCuzoUVOVE1YbVTs9qxa4sYrd9rkYfee4esjUDTuej4OkwkvfTZt1ghJ0
 Tv5iH9Zgx2gkJLogqRWziy5F14cyj9GrOOphO/XCnzW5xlaVdOC0na4kAi8RmzNStpazyfgM+Q
 vlPeZ2Vd/XMmZ88TDttlVPPHfuLqOW+aF4uMR0nQNucY60PJD4jTY+3JhwvJN+vAI00H4h22wa
 fvMbx9TX11dSEnwTESX1Cjrr0H/2ye/iQr8DOz+IfkOBmG6JKbat2yq+vu/P2A0yU7aPbZ5C8K
 GLw=
WDCIronportException: Internal
Received: from yoda.sdcorp.global.sandisk.com (HELO yoda.int.fusionio.com) ([10.196.158.80])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Feb 2020 14:02:23 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Gary Guo <gary@garyguo.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Mao Han <han_mao@c-sky.com>, Marc Zyngier <maz@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Steven Price <steven.price@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH v10 06/12] RISC-V: Move relocate and few other functions out of __init
Date:   Wed, 26 Feb 2020 14:02:07 -0800
Message-Id: <20200226220213.27423-7-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226220213.27423-1-atish.patra@wdc.com>
References: <20200226220213.27423-1-atish.patra@wdc.com>
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

