Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58A1C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45DF2082D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgC0CdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:33:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48036 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgC0CcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:32:10 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHemz-003hR9-Q3; Fri, 27 Mar 2020 02:32:05 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH v2 05/22] vm86: get rid of get_user_ex() use
Date:   Fri, 27 Mar 2020 02:31:48 +0000
Message-Id: <20200327023205.881896-5-viro@ZenIV.linux.org.uk>
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
 arch/x86/kernel/vm86_32.c | 54 +++++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index 91d55454e702..49b37eb01e99 100644
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
-- 
2.11.0

