Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAA9C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994EF20716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgC1LAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:00:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55569 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgC1LAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:00:07 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jI9C9-0003cq-0p; Sat, 28 Mar 2020 12:00:05 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7B2001C04CC;
        Sat, 28 Mar 2020 11:59:59 +0100 (CET)
Date:   Sat, 28 Mar 2020 10:59:59 -0000
From:   "tip-bot2 for Al Viro" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: get rid of get_user_ex() in restore_sigcontext()
Cc:     Al Viro <viro@zeniv.linux.org.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158539319916.28353.17090109980614474910.tip-bot2@tip-bot2>
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

Commit-ID:     3add42c29cebb1d5f83c6205c59466a06ccf8da1
Gitweb:        https://git.kernel.org/tip/3add42c29cebb1d5f83c6205c59466a06ccf8da1
Author:        Al Viro <viro@zeniv.linux.org.uk>
AuthorDate:    Sat, 15 Feb 2020 12:56:57 -05:00
Committer:     Al Viro <viro@zeniv.linux.org.uk>
CommitterDate: Wed, 18 Mar 2020 20:22:40 -04:00

x86: get rid of get_user_ex() in restore_sigcontext()

Just do copyin into a local struct and be done with that - we are
on a shallow stack here.

[reworked by tglx, removing the macro horrors while we are touching that]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/kernel/signal.c | 86 ++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 50 deletions(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 53ac66b..83563e9 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -47,24 +47,6 @@
 #include <asm/sigframe.h>
 #include <asm/signal.h>
 
-#define COPY(x)			do {			\
-	get_user_ex(regs->x, &sc->x);			\
-} while (0)
-
-#define GET_SEG(seg)		({			\
-	unsigned short tmp;				\
-	get_user_ex(tmp, &sc->seg);			\
-	tmp;						\
-})
-
-#define COPY_SEG(seg)		do {			\
-	regs->seg = GET_SEG(seg);			\
-} while (0)
-
-#define COPY_SEG_CPL3(seg)	do {			\
-	regs->seg = GET_SEG(seg) | 3;			\
-} while (0)
-
 #ifdef CONFIG_X86_64
 /*
  * If regs->ss will cause an IRET fault, change it.  Otherwise leave it
@@ -92,53 +74,58 @@ static void force_valid_ss(struct pt_regs *regs)
 	    ar != (AR_DPL3 | AR_S | AR_P | AR_TYPE_RWDATA_EXPDOWN))
 		regs->ss = __USER_DS;
 }
+# define CONTEXT_COPY_SIZE	offsetof(struct sigcontext, reserved1)
+#else
+# define CONTEXT_COPY_SIZE	sizeof(struct sigcontext)
 #endif
 
 static int restore_sigcontext(struct pt_regs *regs,
-			      struct sigcontext __user *sc,
+			      struct sigcontext __user *usc,
 			      unsigned long uc_flags)
 {
-	unsigned long buf_val;
-	void __user *buf;
-	unsigned int tmpflags;
-	unsigned int err = 0;
+	struct sigcontext sc;
 
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
 
-	get_user_try {
+	if (copy_from_user(&sc, usc, CONTEXT_COPY_SIZE))
+		return -EFAULT;
 
 #ifdef CONFIG_X86_32
-		set_user_gs(regs, GET_SEG(gs));
-		COPY_SEG(fs);
-		COPY_SEG(es);
-		COPY_SEG(ds);
+	set_user_gs(regs, sc.gs);
+	regs->fs = sc.fs;
+	regs->es = sc.es;
+	regs->ds = sc.ds;
 #endif /* CONFIG_X86_32 */
 
-		COPY(di); COPY(si); COPY(bp); COPY(sp); COPY(bx);
-		COPY(dx); COPY(cx); COPY(ip); COPY(ax);
+	regs->bx = sc.bx;
+	regs->cx = sc.cx;
+	regs->dx = sc.dx;
+	regs->si = sc.si;
+	regs->di = sc.di;
+	regs->bp = sc.bp;
+	regs->ax = sc.ax;
+	regs->sp = sc.sp;
+	regs->ip = sc.ip;
 
 #ifdef CONFIG_X86_64
-		COPY(r8);
-		COPY(r9);
-		COPY(r10);
-		COPY(r11);
-		COPY(r12);
-		COPY(r13);
-		COPY(r14);
-		COPY(r15);
+	regs->r8 = sc.r8;
+	regs->r9 = sc.r9;
+	regs->r10 = sc.r10;
+	regs->r11 = sc.r11;
+	regs->r12 = sc.r12;
+	regs->r13 = sc.r13;
+	regs->r14 = sc.r14;
+	regs->r15 = sc.r15;
 #endif /* CONFIG_X86_64 */
 
-		COPY_SEG_CPL3(cs);
-		COPY_SEG_CPL3(ss);
-
-		get_user_ex(tmpflags, &sc->flags);
-		regs->flags = (regs->flags & ~FIX_EFLAGS) | (tmpflags & FIX_EFLAGS);
-		regs->orig_ax = -1;		/* disable syscall checks */
+	/* Get CS/SS and force CPL3 */
+	regs->cs = sc.cs | 0x03;
+	regs->ss = sc.ss | 0x03;
 
-		get_user_ex(buf_val, &sc->fpstate);
-		buf = (void __user *)buf_val;
-	} get_user_catch(err);
+	regs->flags = (regs->flags & ~FIX_EFLAGS) | (sc.flags & FIX_EFLAGS);
+	/* disable syscall checks */
+	regs->orig_ax = -1;
 
 #ifdef CONFIG_X86_64
 	/*
@@ -149,9 +136,8 @@ static int restore_sigcontext(struct pt_regs *regs,
 		force_valid_ss(regs);
 #endif
 
-	err |= fpu__restore_sig(buf, IS_ENABLED(CONFIG_X86_32));
-
-	return err;
+	return fpu__restore_sig((void __user *)sc.fpstate,
+			       IS_ENABLED(CONFIG_X86_32));
 }
 
 int setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
