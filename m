Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D78C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA15F215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgC0CcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:32:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48008 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbgC0CcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:32:09 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHen0-003hRL-2y; Fri, 27 Mar 2020 02:32:06 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH v2 07/22] x86: get rid of get_user_ex() in restore_sigcontext()
Date:   Fri, 27 Mar 2020 02:31:50 +0000
Message-Id: <20200327023205.881896-7-viro@ZenIV.linux.org.uk>
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

Just do copyin into a local struct and be done with that - we are
on a shallow stack here.

[reworked by tglx, removing the macro horrors while we are touching that]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/kernel/signal.c | 86 ++++++++++++++++++++----------------------------
 1 file changed, 36 insertions(+), 50 deletions(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 53ac66b3fd9b..83563e98f0be 100644
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
-- 
2.11.0

