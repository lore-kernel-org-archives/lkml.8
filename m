Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CFAC2BB84
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFFCE207DE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbgIGQb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:31:58 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:5069 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729798AbgIGOWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:22:05 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BlTwX6SJcz9tyLp;
        Mon,  7 Sep 2020 15:42:04 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Zudc7esuDMm9; Mon,  7 Sep 2020 15:42:04 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BlTwX5d1sz9tyLn;
        Mon,  7 Sep 2020 15:42:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 50BDB8B79F;
        Mon,  7 Sep 2020 15:42:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id B_Ys49AQDKLV; Mon,  7 Sep 2020 15:42:10 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 05BA48B77F;
        Mon,  7 Sep 2020 15:42:10 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id CE0C6656F8; Mon,  7 Sep 2020 13:42:09 +0000 (UTC)
Message-Id: <a027d447022a006c9c4958ac734128e577a3c5c1.1599486108.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 1/2] powerpc/32: Fix vmap stack - Do not activate MMU before
 reading task struct
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon,  7 Sep 2020 13:42:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need r1 to be properly set before activating MMU, so
reading task_struct->stack must be done with MMU off.

This means we need an additional register to play with MSR
bits while r11 now points to the stack. For that, move r10
back to CR (As is already done for hash MMU) and use r10.

We still don't have r1 correct yet when we activate MMU.
It is done in following patch.

Fixes: 028474876f47 ("powerpc/32: prepare for CONFIG_VMAP_STACK")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_32.S |  6 ------
 arch/powerpc/kernel/head_32.h | 31 ++++++-------------------------
 2 files changed, 6 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index f3ab94d73936..d967266d62e8 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -274,14 +274,8 @@ __secondary_hold_acknowledge:
 	DO_KVM  0x200
 MachineCheck:
 	EXCEPTION_PROLOG_0
-#ifdef CONFIG_VMAP_STACK
-	li	r11, MSR_KERNEL & ~(MSR_IR | MSR_RI) /* can take DTLB miss */
-	mtmsr	r11
-	isync
-#endif
 #ifdef CONFIG_PPC_CHRP
 	mfspr	r11, SPRN_SPRG_THREAD
-	tovirt_vmstack r11, r11
 	lwz	r11, RTAS_SP(r11)
 	cmpwi	cr1, r11, 0
 	bne	cr1, 7f
diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index 9abec6cd099c..21effebb9277 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -39,24 +39,13 @@
 .endm
 
 .macro EXCEPTION_PROLOG_1 for_rtas=0
-#ifdef CONFIG_VMAP_STACK
-	.ifeq	\for_rtas
-	li	r11, MSR_KERNEL & ~(MSR_IR | MSR_RI) /* can take DTLB miss */
-	mtmsr	r11
-	isync
-	.endif
 	subi	r11, r1, INT_FRAME_SIZE		/* use r1 if kernel */
-#else
-	tophys(r11,r1)			/* use tophys(r1) if kernel */
-	subi	r11, r11, INT_FRAME_SIZE	/* alloc exc. frame */
-#endif
 	beq	1f
 	mfspr	r11,SPRN_SPRG_THREAD
-	tovirt_vmstack r11, r11
 	lwz	r11,TASK_STACK-THREAD(r11)
 	addi	r11, r11, THREAD_SIZE - INT_FRAME_SIZE
-	tophys_novmstack r11, r11
 1:
+	tophys_novmstack r11, r11
 #ifdef CONFIG_VMAP_STACK
 	mtcrf	0x7f, r11
 	bt	32 - THREAD_ALIGN_SHIFT, stack_overflow
@@ -64,12 +53,11 @@
 .endm
 
 .macro EXCEPTION_PROLOG_2 handle_dar_dsisr=0
-#if defined(CONFIG_VMAP_STACK) && defined(CONFIG_PPC_BOOK3S)
-BEGIN_MMU_FTR_SECTION
+#ifdef CONFIG_VMAP_STACK
 	mtcr	r10
-FTR_SECTION_ELSE
-	stw	r10, _CCR(r11)
-ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_HPTE_TABLE)
+	li	r10, MSR_KERNEL & ~(MSR_IR | MSR_RI) /* can take DTLB miss */
+	mtmsr	r10
+	isync
 #else
 	stw	r10,_CCR(r11)		/* save registers */
 #endif
@@ -77,11 +65,9 @@ ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_HPTE_TABLE)
 	stw	r12,GPR12(r11)
 	stw	r9,GPR9(r11)
 	stw	r10,GPR10(r11)
-#if defined(CONFIG_VMAP_STACK) && defined(CONFIG_PPC_BOOK3S)
-BEGIN_MMU_FTR_SECTION
+#ifdef CONFIG_VMAP_STACK
 	mfcr	r10
 	stw	r10, _CCR(r11)
-END_MMU_FTR_SECTION_IFSET(MMU_FTR_HPTE_TABLE)
 #endif
 	mfspr	r12,SPRN_SPRG_SCRATCH1
 	stw	r12,GPR11(r11)
@@ -97,11 +83,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_HPTE_TABLE)
 	stw	r10, _DSISR(r11)
 	.endif
 	lwz	r9, SRR1(r12)
-#if defined(CONFIG_VMAP_STACK) && defined(CONFIG_PPC_BOOK3S)
-BEGIN_MMU_FTR_SECTION
 	andi.	r10, r9, MSR_PR
-END_MMU_FTR_SECTION_IFSET(MMU_FTR_HPTE_TABLE)
-#endif
 	lwz	r12, SRR0(r12)
 #else
 	mfspr	r12,SPRN_SRR0
@@ -328,7 +310,6 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_HPTE_TABLE)
 #ifdef CONFIG_VMAP_STACK
 #ifdef CONFIG_SMP
 	mfspr	r11, SPRN_SPRG_THREAD
-	tovirt(r11, r11)
 	lwz	r11, TASK_CPU - THREAD(r11)
 	slwi	r11, r11, 3
 	addis	r11, r11, emergency_ctx@ha
-- 
2.25.0

