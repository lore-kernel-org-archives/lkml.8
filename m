Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D69C352A3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 01:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F972217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 01:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BBaflOQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgBLBv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 20:51:57 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:60376 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbgBLBv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 20:51:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581472316; x=1613008316;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=in+am6V5cB5vIxYi0RDDoJhhDT9YUsFBQJfrnYzjyic=;
  b=BBaflOQv0n01+ZQ2ntpqk4inTIeDqTm3TU1Y/mE73NmBVBTfmZe0o8WG
   AA/nSMz9ogQJv2+DajO5yGsVNFHahIx9Ti9BRXW6HWMSCmS825CATMHnH
   Svrh3r4YvhyuWO/xiuyhy8LFOXqOcSv3YNG40Qfb3the6AUAwKKFJZVMo
   AoMkx6Rf7uDESVKahMUgkP6XRnK6iscXkIpuOW+HYg1ob2OrDpWlWX6su
   9Jph062cZ0+pPaWmQ0prDO6WJdahPHt913/ra/BLM40Ac4oXPNCcZ/SrH
   ppo69baXXa8Ws/+JeY31y+15eeoX6t5hv2q14HLjXj5bFQlRANjZR4Jlc
   A==;
IronPort-SDR: Q3bl2+6VvtEcxaey97UNUUM02wesPiCHS/6Jt08SVs6/PbnAAxhLFcomnVDNCNtivhKwbT7LpD
 eUoP+uKkf9zGPKP2SHyA4AzeNqxiiysMyxOz1MGhGj1zNfvFjuP0TE8hlln1yY2ZWYLG6CMPLd
 rBh4zxZp2fbJmX0gs7MWNWO2RiC795qaqCb5fJNRmZxb2ZKAyZhQeTOi/3Mp2eiHNKknV1Pcyw
 p/nHhZDaKpeT9FaSKauld7eD8WPT2djfznxQRpehKvoZw4WguwwvQmkz6693DMVz99tUKNKFAK
 t70=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="237648948"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 09:51:55 +0800
IronPort-SDR: Y9do8mfZGov7nc9dfkKyP8VipV+AKkFah6Xr/3wwDZkcoi1lvbl5b7iHUldXPej0ttc75Tv9so
 zH5lmGzHBuJtty6DN0YXqAb2PCRgcbms8IdiAmTyxuSpL1y4ZXimeNTh9Z404jzRpU1wjliUtd
 VWxl6+s/Bt8TXkNEokoondD3lZk756a5HdrH+tiJxpoZ17cTcDtIi2Jzmb+uYBTHi4xB0Iukq+
 D57zMHx1TU7R0DA+Rwk3bhKvsXT14a6HmHHU2KGd8NLjKq2WOAox038fe3qT6vwTHf0rEbLqY0
 xvAHiO8nFXiemxeJKl54vZxE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 17:44:45 -0800
IronPort-SDR: opbXy4mSsm4DAWNqPVi6m7QjC3sARWoITBtt3fU/+yhyuHcKphGIHbPZjMbdIT2SJDl5yHGuV2
 2xiGINWbo/GFxvHa7nzt6qEAzQPNRJu+mJrhViMRavAytA6eWhHlo1iUiR9n922KOX/QOIEoHu
 LBshM86C+l5P76PUAL7RvBbsaH/ZH4BP1DDZmn8xDgQXx6sNJ/zURe6IxOvCs6VpfbLYcx0XjG
 UhlYLju0ofKPJEtbMWkgSVCEgGU3okzgrzBTgvEJA/5ibiMNx4p480Kfb22/L5GElQ9+i8oJqb
 rO8=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2020 17:51:55 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup@brainfault.org>, Borislav Petkov <bp@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Marc Zyngier <maz@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH v8 06/11] RISC-V: Move relocate and few other functions out of __init
Date:   Tue, 11 Feb 2020 17:48:17 -0800
Message-Id: <20200212014822.28684-7-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200212014822.28684-1-atish.patra@wdc.com>
References: <20200212014822.28684-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The secondary hart booting and relocation code are under .init section.
As a result, it will be freed once kernel booting is done. However,
ordered booting protocol and CPU hotplug always requires these sections
to be present to bringup harts after initial kernel boot.

Move the required sections to a different section and make sure that
they are in memory within first 2MB offset as trampoline page directory
only maps first 2MB.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/head.S        | 153 +++++++++++++++++---------------
 arch/riscv/kernel/vmlinux.lds.S |   5 +-
 2 files changed, 86 insertions(+), 72 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index a4242be66966..c1be597d22a1 100644
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
@@ -125,59 +202,6 @@ clear_bss_done:
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
@@ -202,16 +226,10 @@ relocate:
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
@@ -292,13 +310,6 @@ ENTRY(reset_regs)
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
index 12f42f96d46e..18c397953bfc 100644
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
2.24.0

