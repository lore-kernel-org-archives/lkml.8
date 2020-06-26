Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87323C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 608C320B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="F439n836"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgFZV0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgFZV0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:26:36 -0400
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF36C03E97B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:26:36 -0700 (PDT)
Received: from zyt.lan (unknown [IPv6:2a02:169:3df5::564])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id EE48B5C2468;
        Fri, 26 Jun 2020 23:26:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1593206794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aEOAk1ETAJhOXzZ5wDBRQL7ILtsSbq9e4n7G/DYV2tY=;
        b=F439n836WN6KfvvttAOmcKDj6xCl16KWRxJYkzpiilkRuS7gHA33EusA3X7kXQXHqMMX/R
        gOfadD7Evgdib7av3Fh3Ag1gjieELPOWYEEeHyzzk2OhkHKu+giVEph99F8+hlqn35d0nz
        smDDOMzP/8D3PtQ5AvIVVuTK2sHT07c=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     arnd@arndb.de, ard.biesheuvel@linaro.org, robin.murphy@arm.com,
        yamada.masahiro@socionext.com, ndesaulniers@google.com,
        manojgupta@google.com, jiancai@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, Stefan Agner <stefan@agner.ch>
Subject: [PATCH v3 3/3] ARM: use VFP assembler mnemonics if available
Date:   Fri, 26 Jun 2020 23:26:13 +0200
Message-Id: <31a2320b7a5a27345b01bea2ecf4134f688c3c16.1593205699.git.stefan@agner.ch>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1593205699.git.stefan@agner.ch>
References: <cover.1593205699.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The integrated assembler of Clang 10 and earlier do not allow to access
the VFP registers through the coprocessor load/store instructions:
arch/arm/vfp/vfpmodule.c:342:2: error: invalid operand for instruction
        fmxr(FPEXC, fpexc & ~(FPEXC_EX|FPEXC_DEX|FPEXC_FP2V|FPEXC_VV|FPEXC_TRAP_MASK));
        ^
arch/arm/vfp/vfpinstr.h:79:6: note: expanded from macro 'fmxr'
        asm("mcr p10, 7, %0, " vfpreg(_vfp_) ", cr0, 0 @ fmxr   " #_vfp_ ", %0" \
            ^
<inline asm>:1:6: note: instantiated into assembly here
        mcr p10, 7, r0, cr8, cr0, 0 @ fmxr      FPEXC, r0
            ^

This has been addressed with Clang 11 [0]. However, to support earlier
versions of Clang and for better readability use of VFP assembler
mnemonics still is preferred.

Ideally we would replace this code with the unified assembler language
mnemonics vmrs/vmsr on call sites along with .fpu assembler directives.
The GNU assembler supports the .fpu directive at least since 2.17 (when
documentation has been added). Since Linux requires binutils 2.21 it is
safe to use .fpu directive. However, binutils does not allow to use
FPINST or FPINST2 as an argument to vmrs/vmsr instructions up to
binutils 2.24 (see binutils commit 16d02dc907c5):
arch/arm/vfp/vfphw.S: Assembler messages:
arch/arm/vfp/vfphw.S:162: Error: operand 0 must be FPSID or FPSCR pr FPEXC -- `vmsr FPINST,r6'
arch/arm/vfp/vfphw.S:165: Error: operand 0 must be FPSID or FPSCR pr FPEXC -- `vmsr FPINST2,r8'
arch/arm/vfp/vfphw.S:235: Error: operand 1 must be a VFP extension System Register -- `vmrs r3,FPINST'
arch/arm/vfp/vfphw.S:238: Error: operand 1 must be a VFP extension System Register -- `vmrs r12,FPINST2'

Use as-instr in Kconfig to check if FPINST/FPINST2 can be used. If they
can be used make use of .fpu directives and UAL VFP mnemonics for
register access.

This allows to build vfpmodule.c with Clang and its integrated assembler.

[0] https://reviews.llvm.org/D59733

Link: https://github.com/ClangBuiltLinux/linux/issues/905
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Changes in v3:
- Reworded commit message, adding hint that Clang 11 won't have this
  restriction any longer

Changes in v2:
- Check assembler capabilities in Kconfig instead of Makefile

 arch/arm/Kconfig                 |  2 ++
 arch/arm/Kconfig.assembler       |  6 ++++++
 arch/arm/include/asm/vfp.h       |  2 ++
 arch/arm/include/asm/vfpmacros.h | 12 +++++++++++-
 arch/arm/vfp/vfphw.S             |  1 +
 arch/arm/vfp/vfpinstr.h          | 23 +++++++++++++++++++----
 6 files changed, 41 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/Kconfig.assembler

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2ac74904a3ce..911f55a11c63 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2097,3 +2097,5 @@ source "drivers/firmware/Kconfig"
 if CRYPTO
 source "arch/arm/crypto/Kconfig"
 endif
+
+source "arch/arm/Kconfig.assembler"
diff --git a/arch/arm/Kconfig.assembler b/arch/arm/Kconfig.assembler
new file mode 100644
index 000000000000..5cb31aae1188
--- /dev/null
+++ b/arch/arm/Kconfig.assembler
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config AS_VFP_VMRS_FPINST
+	def_bool $(as-instr,.fpu vfpv2\nvmrs r0$(comma)FPINST)
+	help
+	  Supported by binutils >= 2.24 and LLVM integrated assembler.
diff --git a/arch/arm/include/asm/vfp.h b/arch/arm/include/asm/vfp.h
index 7157d2a30a49..19928bfb4f9c 100644
--- a/arch/arm/include/asm/vfp.h
+++ b/arch/arm/include/asm/vfp.h
@@ -9,6 +9,7 @@
 #ifndef __ASM_VFP_H
 #define __ASM_VFP_H
 
+#ifndef CONFIG_AS_VFP_VMRS_FPINST
 #define FPSID			cr0
 #define FPSCR			cr1
 #define MVFR1			cr6
@@ -16,6 +17,7 @@
 #define FPEXC			cr8
 #define FPINST			cr9
 #define FPINST2			cr10
+#endif
 
 /* FPSID bits */
 #define FPSID_IMPLEMENTER_BIT	(24)
diff --git a/arch/arm/include/asm/vfpmacros.h b/arch/arm/include/asm/vfpmacros.h
index 947ee5395e1f..ba0d4cb5377e 100644
--- a/arch/arm/include/asm/vfpmacros.h
+++ b/arch/arm/include/asm/vfpmacros.h
@@ -8,7 +8,16 @@
 
 #include <asm/vfp.h>
 
-@ Macros to allow building with old toolkits (with no VFP support)
+#ifdef CONFIG_AS_VFP_VMRS_FPINST
+	.macro	VFPFMRX, rd, sysreg, cond
+	vmrs\cond	\rd, \sysreg
+	.endm
+
+	.macro	VFPFMXR, sysreg, rd, cond
+	vmsr\cond	\sysreg, \rd
+	.endm
+#else
+	@ Macros to allow building with old toolkits (with no VFP support)
 	.macro	VFPFMRX, rd, sysreg, cond
 	MRC\cond	p10, 7, \rd, \sysreg, cr0, 0	@ FMRX	\rd, \sysreg
 	.endm
@@ -16,6 +25,7 @@
 	.macro	VFPFMXR, sysreg, rd, cond
 	MCR\cond	p10, 7, \rd, \sysreg, cr0, 0	@ FMXR	\sysreg, \rd
 	.endm
+#endif
 
 	@ read all the working registers back into the VFP
 	.macro	VFPFLDMIA, base, tmp
diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
index 29ed36b99d1d..4fcff9f59947 100644
--- a/arch/arm/vfp/vfphw.S
+++ b/arch/arm/vfp/vfphw.S
@@ -78,6 +78,7 @@
 ENTRY(vfp_support_entry)
 	DBGSTR3	"instr %08x pc %08x state %p", r0, r2, r10
 
+	.fpu	vfpv2
 	ldr	r3, [sp, #S_PSR]	@ Neither lazy restore nor FP exceptions
 	and	r3, r3, #MODE_MASK	@ are supported in kernel mode
 	teq	r3, #USR_MODE
diff --git a/arch/arm/vfp/vfpinstr.h b/arch/arm/vfp/vfpinstr.h
index 38dc154e39ff..3c7938fd40aa 100644
--- a/arch/arm/vfp/vfpinstr.h
+++ b/arch/arm/vfp/vfpinstr.h
@@ -62,10 +62,23 @@
 #define FPSCR_C (1 << 29)
 #define FPSCR_V	(1 << 28)
 
-/*
- * Since we aren't building with -mfpu=vfp, we need to code
- * these instructions using their MRC/MCR equivalents.
- */
+#ifdef CONFIG_AS_VFP_VMRS_FPINST
+
+#define fmrx(_vfp_) ({			\
+	u32 __v;			\
+	asm(".fpu	vfpv2\n"	\
+	    "vmrs	%0, " #_vfp_	\
+	    : "=r" (__v) : : "cc");	\
+	__v;				\
+ })
+
+#define fmxr(_vfp_,_var_)		\
+	asm(".fpu	vfpv2\n"	\
+	    "vmsr	" #_vfp_ ", %0"	\
+	   : : "r" (_var_) : "cc")
+
+#else
+
 #define vfpreg(_vfp_) #_vfp_
 
 #define fmrx(_vfp_) ({			\
@@ -79,6 +92,8 @@
 	asm("mcr p10, 7, %0, " vfpreg(_vfp_) ", cr0, 0 @ fmxr	" #_vfp_ ", %0"	\
 	   : : "r" (_var_) : "cc")
 
+#endif
+
 u32 vfp_single_cpdo(u32 inst, u32 fpscr);
 u32 vfp_single_cprt(u32 inst, u32 fpscr, struct pt_regs *regs);
 
-- 
2.27.0

