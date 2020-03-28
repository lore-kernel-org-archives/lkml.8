Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A90C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4192820716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgC1LA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:00:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55550 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbgC1LAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:00:06 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jI9C7-0003dp-07; Sat, 28 Mar 2020 12:00:03 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6D8B21C04CD;
        Sat, 28 Mar 2020 12:00:00 +0100 (CET)
Date:   Sat, 28 Mar 2020 10:59:59 -0000
From:   "tip-bot2 for Al Viro" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] vm86: get rid of get_user_ex() use
Cc:     Al Viro <viro@zeniv.linux.org.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158539319999.28353.18405027971529483335.tip-bot2@tip-bot2>
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

Commit-ID:     c63aad695dceb08290be7845052d7d3f1d457416
Gitweb:        https://git.kernel.org/tip/c63aad695dceb08290be7845052d7d3f1d457416
Author:        Al Viro <viro@zeniv.linux.org.uk>
AuthorDate:    Sat, 15 Feb 2020 12:09:14 -05:00
Committer:     Al Viro <viro@zeniv.linux.org.uk>
CommitterDate: Wed, 18 Mar 2020 20:04:00 -04:00

vm86: get rid of get_user_ex() use

Just do a copyin of what we want into a local variable and
be done with that.  We are guaranteed to be on shallow stack
here...

Note that conditional expression for range passed to access_ok()
in mainline had been pointless all along - the only difference
between vm86plus_struct and vm86_struct is that the former has
one extra field in the end and when we get to copyin of that
field (conditional upon 'plus' argument), we use copy_from_user().
Moreover, all fields starting with ->int_revectored are copied
that way, so we only need that check (be it done by access_ok()
or by user_access_begin()) only on the beginning of the structure -
the fields that used to be covered by that get_user_try() block.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/kernel/vm86_32.c | 54 ++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index 91d5545..49b37eb 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -243,6 +243,7 @@ static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus)
 	struct kernel_vm86_regs vm86regs;
 	struct pt_regs *regs = current_pt_regs();
 	unsigned long err = 0;
+	struct vm86_struct v;
 
 	err = security_mmap_addr(0);
 	if (err) {
@@ -278,39 +279,32 @@ static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus)
 	if (vm86->saved_sp0)
 		return -EPERM;
 
-	if (!access_ok(user_vm86, plus ?
-		       sizeof(struct vm86_struct) :
-		       sizeof(struct vm86plus_struct)))
+	if (copy_from_user(&v, user_vm86,
+			offsetof(struct vm86_struct, int_revectored)))
 		return -EFAULT;
 
 	memset(&vm86regs, 0, sizeof(vm86regs));
-	get_user_try {
-		unsigned short seg;
-		get_user_ex(vm86regs.pt.bx, &user_vm86->regs.ebx);
-		get_user_ex(vm86regs.pt.cx, &user_vm86->regs.ecx);
-		get_user_ex(vm86regs.pt.dx, &user_vm86->regs.edx);
-		get_user_ex(vm86regs.pt.si, &user_vm86->regs.esi);
-		get_user_ex(vm86regs.pt.di, &user_vm86->regs.edi);
-		get_user_ex(vm86regs.pt.bp, &user_vm86->regs.ebp);
-		get_user_ex(vm86regs.pt.ax, &user_vm86->regs.eax);
-		get_user_ex(vm86regs.pt.ip, &user_vm86->regs.eip);
-		get_user_ex(seg, &user_vm86->regs.cs);
-		vm86regs.pt.cs = seg;
-		get_user_ex(vm86regs.pt.flags, &user_vm86->regs.eflags);
-		get_user_ex(vm86regs.pt.sp, &user_vm86->regs.esp);
-		get_user_ex(seg, &user_vm86->regs.ss);
-		vm86regs.pt.ss = seg;
-		get_user_ex(vm86regs.es, &user_vm86->regs.es);
-		get_user_ex(vm86regs.ds, &user_vm86->regs.ds);
-		get_user_ex(vm86regs.fs, &user_vm86->regs.fs);
-		get_user_ex(vm86regs.gs, &user_vm86->regs.gs);
-
-		get_user_ex(vm86->flags, &user_vm86->flags);
-		get_user_ex(vm86->screen_bitmap, &user_vm86->screen_bitmap);
-		get_user_ex(vm86->cpu_type, &user_vm86->cpu_type);
-	} get_user_catch(err);
-	if (err)
-		return err;
+
+	vm86regs.pt.bx = v.regs.ebx;
+	vm86regs.pt.cx = v.regs.ecx;
+	vm86regs.pt.dx = v.regs.edx;
+	vm86regs.pt.si = v.regs.esi;
+	vm86regs.pt.di = v.regs.edi;
+	vm86regs.pt.bp = v.regs.ebp;
+	vm86regs.pt.ax = v.regs.eax;
+	vm86regs.pt.ip = v.regs.eip;
+	vm86regs.pt.cs = v.regs.cs;
+	vm86regs.pt.flags = v.regs.eflags;
+	vm86regs.pt.sp = v.regs.esp;
+	vm86regs.pt.ss = v.regs.ss;
+	vm86regs.es = v.regs.es;
+	vm86regs.ds = v.regs.ds;
+	vm86regs.fs = v.regs.fs;
+	vm86regs.gs = v.regs.gs;
+
+	vm86->flags = v.flags;
+	vm86->screen_bitmap = v.screen_bitmap;
+	vm86->cpu_type = v.cpu_type;
 
 	if (copy_from_user(&vm86->int_revectored,
 			   &user_vm86->int_revectored,
