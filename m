Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D24EC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 196F820716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbgC1LAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:00:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55584 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgC1LAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:00:09 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jI9C8-0003cD-1H; Sat, 28 Mar 2020 12:00:04 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9C3241C0494;
        Sat, 28 Mar 2020 11:59:58 +0100 (CET)
Date:   Sat, 28 Mar 2020 10:59:58 -0000
From:   "tip-bot2 for Al Viro" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: switch save_v86_state() to unsafe_put_user()
Cc:     Al Viro <viro@zeniv.linux.org.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158539319827.28353.1493443524884765428.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     a37d01ead405e3aa14d72d284721fe46422b3b63
Gitweb:        https://git.kernel.org/tip/a37d01ead405e3aa14d72d284721fe46422b3b63
Author:        Al Viro <viro@zeniv.linux.org.uk>
AuthorDate:    Sat, 15 Feb 2020 13:38:18 -05:00
Committer:     Al Viro <viro@zeniv.linux.org.uk>
CommitterDate: Wed, 18 Mar 2020 20:36:01 -04:00

x86: switch save_v86_state() to unsafe_put_user()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/kernel/vm86_32.c | 61 ++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index 49b37eb..47a8676 100644
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
