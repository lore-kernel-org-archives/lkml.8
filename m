Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99662C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77822207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593192105;
	bh=1KnbXwE+bmAZRBzxpU4AIX//ta8YBFUr+H6enwpmo9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZfHAdfkCsJqhC50MCeE21Zq1tHONkRQ+TW3tsizmmLfOlAKeHnnIWfO42IiObHAhL
	 ZOdr4pwL4tfRjJceeOzEBvW4WAaWxNNaf3NuPXbln3k0BBTpt/FLLhwSSGMH4vA+MK
	 7vG87NsqW5CMLnNAP/46MUfseqaYR1ZZbQgSlK14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgFZRVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 13:21:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbgFZRVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:21:21 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0862B2065F;
        Fri, 26 Jun 2020 17:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593192081;
        bh=1KnbXwE+bmAZRBzxpU4AIX//ta8YBFUr+H6enwpmo9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zLgIg9+Kc6v2O/9rzSj9PMRNASXVTteANa5UrP1pa3D6xKpUGJrJgsrg3u9RsU/Gi
         EMFFLPqZSQmIsek8lb+Hef3NdDSwrvAEga/juhjxV7fIC0RPMTVcwkJ/1fL34mO7Bh
         eKX99ueb+yhOuuCpUSMcKUvTUlekKgK4DSwHizUU=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 2/6] x86/entry: Move SYSENTER's regs->sp and regs->flags fixups into C
Date:   Fri, 26 Jun 2020 10:21:12 -0700
Message-Id: <fe62bef67eda7fac75b8f3dbafccf571dc4ece6b.1593191971.git.luto@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1593191971.git.luto@kernel.org>
References: <cover.1593191971.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SYSENTER asm (32-bit and compat) contains fixups for regs->sp
and regs->flags.  Move the fixups into C and fix some comments while
we're at it.

IMO this is a valid cleanup all by itself, and it also simplifies
the subsequent patch that will fix Xen PV SYSENTER.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/common.c          | 12 ++++++++++++
 arch/x86/entry/entry_32.S        |  5 ++---
 arch/x86/entry/entry_64_compat.S | 11 +++++------
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index ed8ccc820995..f392a8bcd1c3 100644
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
index 024d7d276cd4..2d0bd5d5f032 100644
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
index 0f974ae01e62..7b9d8150f652 100644
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
-- 
2.25.4

