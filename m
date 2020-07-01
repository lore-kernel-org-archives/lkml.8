Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1780C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FF542073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2OPBfC4/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ACwZlaaP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgGAIFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:05:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36294 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728677AbgGAIE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:04:56 -0400
Date:   Wed, 01 Jul 2020 08:04:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593590692;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vOZVwkK0SrhcS4WpspBdv4hb9amK7MMXs19hwHXqYyw=;
        b=2OPBfC4/LINuJDCzh/GwOyuul0rnoBy8vPZ/LkjKKRMtma13XjfG0ckLBKsTGaFBpsx7zk
        l+36AFb2SyUtmzhn987Vjp07RZaVB5UJPsGckcDDxiL4368VvIEmttyuOOklk4DOVKFfWn
        nJh/TVVRbW6Rjx1IbyMnbn2D++eMrIouGyJ8q662oZgpfhULf73DHcGhUTkxqnerPYysl4
        nJY8K1KUB5cGdubQwBROUZr/qhnZaAwYPym/un390hNMsLIrpwPP/LoDZLzCYILjyDqUdx
        w9YT+y+lnGWaxh6vGRUx6BgaRae7/weH23w32Rey1/W60A7BTAz2WyivOI5dXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593590692;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vOZVwkK0SrhcS4WpspBdv4hb9amK7MMXs19hwHXqYyw=;
        b=ACwZlaaPyzgUdzKcsKAuGjAn/Dko92u3yhWUeR9skOdacbqogBSlzW+qMArTRYEWBn7Ol9
        IAVLbjlDORrL+IBQ==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry: Move SYSENTER's regs->sp and regs->flags
 fixups into C
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <fe62bef67eda7fac75b8f3dbafccf571dc4ece6b.1593191971.git.luto@kernel.org>
References: <fe62bef67eda7fac75b8f3dbafccf571dc4ece6b.1593191971.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <159359069225.4006.5129768692081976038.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d1721250f3ffed9afba3e1fb729947cec64c5a8a
Gitweb:        https://git.kernel.org/tip/d1721250f3ffed9afba3e1fb729947cec64c5a8a
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Fri, 26 Jun 2020 10:21:12 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 01 Jul 2020 10:00:25 +02:00

x86/entry: Move SYSENTER's regs->sp and regs->flags fixups into C

The SYSENTER asm (32-bit and compat) contains fixups for regs->sp and
regs->flags.  Move the fixups into C and fix some comments while at it.

This is a valid cleanup all by itself, and it also simplifies the
subsequent patch that will fix Xen PV SYSENTER.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/fe62bef67eda7fac75b8f3dbafccf571dc4ece6b.1593191971.git.luto@kernel.org

---
 arch/x86/entry/common.c          | 12 ++++++++++++
 arch/x86/entry/entry_32.S        |  5 ++---
 arch/x86/entry/entry_64_compat.S | 11 +++++------
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index ed8ccc8..f392a8b 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -522,6 +522,18 @@ __visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
 		(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF | X86_EFLAGS_VM)) == 0;
 #endif
 }
+
+/* Returns 0 to return using IRET or 1 to return using SYSEXIT/SYSRETL. */
+__visible noinstr long do_SYSENTER_32(struct pt_regs *regs)
+{
+	/* SYSENTER loses RSP, but the vDSO saved it in RBP. */
+	regs->sp = regs->bp;
+
+	/* SYSENTER clobbers EFLAGS.IF.  Assume it was set in usermode. */
+	regs->flags |= X86_EFLAGS_IF;
+
+	return do_fast_syscall_32(regs);
+}
 #endif
 
 SYSCALL_DEFINE0(ni_syscall)
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 024d7d2..2d0bd5d 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -933,9 +933,8 @@ SYM_FUNC_START(entry_SYSENTER_32)
 
 .Lsysenter_past_esp:
 	pushl	$__USER_DS		/* pt_regs->ss */
-	pushl	%ebp			/* pt_regs->sp (stashed in bp) */
+	pushl	$0			/* pt_regs->sp (placeholder) */
 	pushfl				/* pt_regs->flags (except IF = 0) */
-	orl	$X86_EFLAGS_IF, (%esp)	/* Fix IF */
 	pushl	$__USER_CS		/* pt_regs->cs */
 	pushl	$0			/* pt_regs->ip = 0 (placeholder) */
 	pushl	%eax			/* pt_regs->orig_ax */
@@ -965,7 +964,7 @@ SYM_FUNC_START(entry_SYSENTER_32)
 .Lsysenter_flags_fixed:
 
 	movl	%esp, %eax
-	call	do_fast_syscall_32
+	call	do_SYSENTER_32
 	/* XEN PV guests always use IRET path */
 	ALTERNATIVE "testl %eax, %eax; jz .Lsyscall_32_done", \
 		    "jmp .Lsyscall_32_done", X86_FEATURE_XENPV
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 0f974ae..7b9d815 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -68,16 +68,15 @@ SYM_CODE_START(entry_SYSENTER_compat)
 
 	/* Construct struct pt_regs on stack */
 	pushq	$__USER32_DS		/* pt_regs->ss */
-	pushq	%rbp			/* pt_regs->sp (stashed in bp) */
+	pushq	$0			/* pt_regs->sp = 0 (placeholder) */
 
 	/*
 	 * Push flags.  This is nasty.  First, interrupts are currently
-	 * off, but we need pt_regs->flags to have IF set.  Second, even
-	 * if TF was set when SYSENTER started, it's clear by now.  We fix
-	 * that later using TIF_SINGLESTEP.
+	 * off, but we need pt_regs->flags to have IF set.  Second, if TS
+	 * was set in usermode, it's still set, and we're singlestepping
+	 * through this code.  do_SYSENTER_32() will fix up IF.
 	 */
 	pushfq				/* pt_regs->flags (except IF = 0) */
-	orl	$X86_EFLAGS_IF, (%rsp)	/* Fix saved flags */
 	pushq	$__USER32_CS		/* pt_regs->cs */
 	pushq	$0			/* pt_regs->ip = 0 (placeholder) */
 	pushq	%rax			/* pt_regs->orig_ax */
@@ -135,7 +134,7 @@ SYM_CODE_START(entry_SYSENTER_compat)
 .Lsysenter_flags_fixed:
 
 	movq	%rsp, %rdi
-	call	do_fast_syscall_32
+	call	do_SYSENTER_32
 	/* XEN PV guests always use IRET path */
 	ALTERNATIVE "testl %eax, %eax; jz swapgs_restore_regs_and_return_to_usermode", \
 		    "jmp swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
