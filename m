Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5F9C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE452082D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgC0CdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:33:07 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48034 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbgC0CcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:32:10 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHen0-003hRX-BS; Fri, 27 Mar 2020 02:32:06 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH v2 09/22] x86: switch save_v86_state() to unsafe_put_user()
Date:   Fri, 27 Mar 2020 02:31:52 +0000
Message-Id: <20200327023205.881896-9-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327023205.881896-1-viro@ZenIV.linux.org.uk>
References: <20200327023007.GS23230@ZenIV.linux.org.uk>
 <20200327023205.881896-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/kernel/vm86_32.c | 61 +++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index 49b37eb01e99..47a8676c7395 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -98,7 +98,6 @@ void save_v86_state(struct kernel_vm86_regs *regs, int retval)
 	struct task_struct *tsk = current;
 	struct vm86plus_struct __user *user;
 	struct vm86 *vm86 = current->thread.vm86;
-	long err = 0;
 
 	/*
 	 * This gets called from entry.S with interrupts disabled, but
@@ -114,37 +113,30 @@ void save_v86_state(struct kernel_vm86_regs *regs, int retval)
 	set_flags(regs->pt.flags, VEFLAGS, X86_EFLAGS_VIF | vm86->veflags_mask);
 	user = vm86->user_vm86;
 
-	if (!access_ok(user, vm86->vm86plus.is_vm86pus ?
+	if (!user_access_begin(user, vm86->vm86plus.is_vm86pus ?
 		       sizeof(struct vm86plus_struct) :
-		       sizeof(struct vm86_struct))) {
-		pr_alert("could not access userspace vm86 info\n");
-		do_exit(SIGSEGV);
-	}
-
-	put_user_try {
-		put_user_ex(regs->pt.bx, &user->regs.ebx);
-		put_user_ex(regs->pt.cx, &user->regs.ecx);
-		put_user_ex(regs->pt.dx, &user->regs.edx);
-		put_user_ex(regs->pt.si, &user->regs.esi);
-		put_user_ex(regs->pt.di, &user->regs.edi);
-		put_user_ex(regs->pt.bp, &user->regs.ebp);
-		put_user_ex(regs->pt.ax, &user->regs.eax);
-		put_user_ex(regs->pt.ip, &user->regs.eip);
-		put_user_ex(regs->pt.cs, &user->regs.cs);
-		put_user_ex(regs->pt.flags, &user->regs.eflags);
-		put_user_ex(regs->pt.sp, &user->regs.esp);
-		put_user_ex(regs->pt.ss, &user->regs.ss);
-		put_user_ex(regs->es, &user->regs.es);
-		put_user_ex(regs->ds, &user->regs.ds);
-		put_user_ex(regs->fs, &user->regs.fs);
-		put_user_ex(regs->gs, &user->regs.gs);
-
-		put_user_ex(vm86->screen_bitmap, &user->screen_bitmap);
-	} put_user_catch(err);
-	if (err) {
-		pr_alert("could not access userspace vm86 info\n");
-		do_exit(SIGSEGV);
-	}
+		       sizeof(struct vm86_struct)))
+		goto Efault;
+
+	unsafe_put_user(regs->pt.bx, &user->regs.ebx, Efault_end);
+	unsafe_put_user(regs->pt.cx, &user->regs.ecx, Efault_end);
+	unsafe_put_user(regs->pt.dx, &user->regs.edx, Efault_end);
+	unsafe_put_user(regs->pt.si, &user->regs.esi, Efault_end);
+	unsafe_put_user(regs->pt.di, &user->regs.edi, Efault_end);
+	unsafe_put_user(regs->pt.bp, &user->regs.ebp, Efault_end);
+	unsafe_put_user(regs->pt.ax, &user->regs.eax, Efault_end);
+	unsafe_put_user(regs->pt.ip, &user->regs.eip, Efault_end);
+	unsafe_put_user(regs->pt.cs, &user->regs.cs, Efault_end);
+	unsafe_put_user(regs->pt.flags, &user->regs.eflags, Efault_end);
+	unsafe_put_user(regs->pt.sp, &user->regs.esp, Efault_end);
+	unsafe_put_user(regs->pt.ss, &user->regs.ss, Efault_end);
+	unsafe_put_user(regs->es, &user->regs.es, Efault_end);
+	unsafe_put_user(regs->ds, &user->regs.ds, Efault_end);
+	unsafe_put_user(regs->fs, &user->regs.fs, Efault_end);
+	unsafe_put_user(regs->gs, &user->regs.gs, Efault_end);
+	unsafe_put_user(vm86->screen_bitmap, &user->screen_bitmap, Efault_end);
+
+	user_access_end();
 
 	preempt_disable();
 	tsk->thread.sp0 = vm86->saved_sp0;
@@ -159,6 +151,13 @@ void save_v86_state(struct kernel_vm86_regs *regs, int retval)
 	lazy_load_gs(vm86->regs32.gs);
 
 	regs->pt.ax = retval;
+	return;
+
+Efault_end:
+	user_access_end();
+Efault:
+	pr_alert("could not access userspace vm86 info\n");
+	do_exit(SIGSEGV);
 }
 
 static void mark_screen_rdonly(struct mm_struct *mm)
-- 
2.11.0

