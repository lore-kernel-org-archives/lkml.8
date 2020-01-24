Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A22C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894742072C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="i+5jKj/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390477AbgAXREA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 12:04:00 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:23284 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388114AbgAXRD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 12:03:58 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48458B3zK3z9v0MK;
        Fri, 24 Jan 2020 18:03:54 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=i+5jKj/E; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id yuzFQHyUGURI; Fri, 24 Jan 2020 18:03:54 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48458B20zmz9v0M9;
        Fri, 24 Jan 2020 18:03:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579885434; bh=chTY8KOFUdIW7lrDskHq6oZgb87BRhKjCjqVWyCr550=;
        h=From:Subject:To:Cc:Date:From;
        b=i+5jKj/EniZeoFRcmhj3btWHWMdpbFpPgINGN8F1DUl0i1pRfp7huAoLi3+9e7UOH
         a5mGv2ZlvdkFcihJ8xptbeoPh+HUxw3i9VqpchkPcaG3p3pWdoeGHYIHAh3//+FNMz
         lr9Kz3DLYq4LAYX85jYEdzkoXG59ebs7GK4MXIw8=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6796E8B84A;
        Fri, 24 Jan 2020 18:03:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id eX3X1B3hY19z; Fri, 24 Jan 2020 18:03:54 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 46DA18B86C;
        Fri, 24 Jan 2020 18:03:49 +0100 (CET)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2D1FB651F7; Fri, 24 Jan 2020 17:03:49 +0000 (UTC)
Message-Id: <c9b86c174b96a0d4aac9b9036d7fcfb459214e52.1579885400.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc/32: Warn and return ENOSYS on syscalls from kernel
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 24 Jan 2020 17:03:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit b86fb88855ea ("powerpc/32: implement fast entry for
syscalls on non BOOKE") and commit 1a4b739bbb4f ("powerpc/32:
implement fast entry for syscalls on BOOKE"), syscalls from
kernel are unexpected and can have catastrophic consequences
as it will destroy the kernel stack.

Test MSR_PR on syscall entry. In case syscall is from kernel,
emit a warning and return ENOSYS error.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: Rebased on powerpc/next-test, ie on top of VMAP_STACK series
---
 arch/powerpc/kernel/entry_32.S   | 26 ++++++++++++++++++++++++++
 arch/powerpc/kernel/head_32.h    | 18 +++++++++++-------
 arch/powerpc/kernel/head_booke.h |  5 ++++-
 3 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 3795654d15d1..73b80143ffac 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -574,6 +574,32 @@ syscall_exit_work:
 	bl	do_syscall_trace_leave
 	b	ret_from_except_full
 
+	/*
+	 * System call was called from kernel. We get here with SRR1 in r9.
+	 * Mark the exception as recoverable once we have retrieved SRR0,
+	 * trap a warning and return ENOSYS with CR[SO] set.
+	 */
+	.globl	ret_from_kernel_syscall
+ret_from_kernel_syscall:
+	mfspr	r11, SPRN_SRR0
+#if !defined(CONFIG_4xx) && !defined(CONFIG_BOOKE)
+	LOAD_REG_IMMEDIATE(r12, MSR_KERNEL & ~(MSR_IR|MSR_DR))
+	MTMSRD(r12)
+#endif
+
+0:	trap
+	EMIT_BUG_ENTRY 0b,__FILE__,__LINE__, BUGFLAG_WARNING
+
+	li	r3, ENOSYS
+	crset	so
+#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PERF_EVENTS)
+	mtspr	SPRN_NRI, r0
+#endif
+	mtspr	SPRN_SRR1, r9
+	mtspr	SPRN_SRR0, r11
+	SYNC
+	RFI
+
 /*
  * The fork/clone functions need to copy the full register set into
  * the child process. Therefore we need to save all the nonvolatile
diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index a6a5fbbf8504..5f3cfc9ef1b6 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -112,13 +112,17 @@
 .macro SYSCALL_ENTRY trapno
 	mfspr	r12,SPRN_SPRG_THREAD
 #ifdef CONFIG_VMAP_STACK
-	mfspr	r9, SPRN_SRR0
-	mfspr	r11, SPRN_SRR1
-	stw	r9, SRR0(r12)
-	stw	r11, SRR1(r12)
+	mfspr	r11, SPRN_SRR0
+	mfspr	r9, SPRN_SRR1
+	stw	r11, SRR0(r12)
+	stw	r9, SRR1(r12)
+#else
+	mfspr	r9, SPRN_SRR1
 #endif
 	mfcr	r10
+	andi.	r11, r9, MSR_PR
 	lwz	r11,TASK_STACK-THREAD(r12)
+	beq-	99f
 	rlwinm	r10,r10,0,4,2	/* Clear SO bit in CR */
 	addi	r11, r11, THREAD_SIZE - INT_FRAME_SIZE
 #ifdef CONFIG_VMAP_STACK
@@ -128,15 +132,14 @@
 #endif
 	tovirt_vmstack r12, r12
 	tophys_novmstack r11, r11
-	mflr	r9
 	stw	r10,_CCR(r11)		/* save registers */
-	stw	r9, _LINK(r11)
+	mflr	r10
+	stw	r10, _LINK(r11)
 #ifdef CONFIG_VMAP_STACK
 	lwz	r10, SRR0(r12)
 	lwz	r9, SRR1(r12)
 #else
 	mfspr	r10,SPRN_SRR0
-	mfspr	r9,SPRN_SRR1
 #endif
 	stw	r1,GPR1(r11)
 	stw	r1,0(r11)
@@ -209,6 +212,7 @@
 	mtspr	SPRN_SRR0,r11
 	SYNC
 	RFI				/* jump to handler, enable MMU */
+99:	b	ret_from_kernel_syscall
 .endm
 
 .macro save_dar_dsisr_on_stack reg1, reg2, sp
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index 37fc84ed90e3..bd2e5ed8dd50 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -104,16 +104,18 @@ FTR_SECTION_ELSE
 #ifdef CONFIG_KVM_BOOKE_HV
 ALT_FTR_SECTION_END_IFSET(CPU_FTR_EMB_HV)
 #endif
+	mfspr	r9, SPRN_SRR1
 	BOOKE_CLEAR_BTB(r11)
+	andi.	r11, r9, MSR_PR
 	lwz	r11, TASK_STACK - THREAD(r10)
 	rlwinm	r12,r12,0,4,2	/* Clear SO bit in CR */
+	beq-	99f
 	ALLOC_STACK_FRAME(r11, THREAD_SIZE - INT_FRAME_SIZE)
 	stw	r12, _CCR(r11)		/* save various registers */
 	mflr	r12
 	stw	r12,_LINK(r11)
 	mfspr	r12,SPRN_SRR0
 	stw	r1, GPR1(r11)
-	mfspr	r9,SPRN_SRR1
 	stw	r1, 0(r11)
 	mr	r1, r11
 	stw	r12,_NIP(r11)
@@ -176,6 +178,7 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_EMB_HV)
 	mtspr	SPRN_SRR0,r11
 	SYNC
 	RFI				/* jump to handler, enable MMU */
+99:	b	ret_from_kernel_syscall
 .endm
 
 /* To handle the additional exception priority levels on 40x and Book-E
-- 
2.25.0

