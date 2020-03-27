Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AE4C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FB32082D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgC0CdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:33:20 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48014 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbgC0CcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:32:09 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHemz-003hRF-VL; Fri, 27 Mar 2020 02:32:06 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH v2 06/22] x86: get rid of get_user_ex() in ia32_restore_sigcontext()
Date:   Fri, 27 Mar 2020 02:31:49 +0000
Message-Id: <20200327023205.881896-6-viro@ZenIV.linux.org.uk>
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
 arch/x86/ia32/ia32_signal.c | 106 ++++++++++++++++++--------------------------
 1 file changed, 44 insertions(+), 62 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index c72025d615f8..23e2c55d8a59 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -36,70 +36,56 @@
 #include <asm/sighandling.h>
 #include <asm/smap.h>
 
+static inline void reload_segments(struct sigcontext_32 *sc)
+{
+	unsigned int cur;
+
+	savesegment(gs, cur);
+	if ((sc->gs | 0x03) != cur)
+		load_gs_index(sc->gs | 0x03);
+	savesegment(fs, cur);
+	if ((sc->fs | 0x03) != cur)
+		loadsegment(fs, sc->fs | 0x03);
+	savesegment(ds, cur);
+	if ((sc->ds | 0x03) != cur)
+		loadsegment(ds, sc->ds | 0x03);
+	savesegment(es, cur);
+	if ((sc->es | 0x03) != cur)
+		loadsegment(es, sc->es | 0x03);
+}
+
 /*
  * Do a signal return; undo the signal stack.
  */
-#define loadsegment_gs(v)	load_gs_index(v)
-#define loadsegment_fs(v)	loadsegment(fs, v)
-#define loadsegment_ds(v)	loadsegment(ds, v)
-#define loadsegment_es(v)	loadsegment(es, v)
-
-#define get_user_seg(seg)	({ unsigned int v; savesegment(seg, v); v; })
-#define set_user_seg(seg, v)	loadsegment_##seg(v)
-
-#define COPY(x)			{		\
-	get_user_ex(regs->x, &sc->x);		\
-}
-
-#define GET_SEG(seg)		({			\
-	unsigned short tmp;				\
-	get_user_ex(tmp, &sc->seg);			\
-	tmp;						\
-})
-
-#define COPY_SEG_CPL3(seg)	do {			\
-	regs->seg = GET_SEG(seg) | 3;			\
-} while (0)
-
-#define RELOAD_SEG(seg)		{		\
-	unsigned int pre = (seg) | 3;		\
-	unsigned int cur = get_user_seg(seg);	\
-	if (pre != cur)				\
-		set_user_seg(seg, pre);		\
-}
-
 static int ia32_restore_sigcontext(struct pt_regs *regs,
-				   struct sigcontext_32 __user *sc)
+				   struct sigcontext_32 __user *usc)
 {
-	unsigned int tmpflags, err = 0;
-	u16 gs, fs, es, ds;
-	void __user *buf;
-	u32 tmp;
+	struct sigcontext_32 sc;
 
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
 
-	get_user_try {
-		gs = GET_SEG(gs);
-		fs = GET_SEG(fs);
-		ds = GET_SEG(ds);
-		es = GET_SEG(es);
-
-		COPY(di); COPY(si); COPY(bp); COPY(sp); COPY(bx);
-		COPY(dx); COPY(cx); COPY(ip); COPY(ax);
-		/* Don't touch extended registers */
-
-		COPY_SEG_CPL3(cs);
-		COPY_SEG_CPL3(ss);
-
-		get_user_ex(tmpflags, &sc->flags);
-		regs->flags = (regs->flags & ~FIX_EFLAGS) | (tmpflags & FIX_EFLAGS);
-		/* disable syscall checks */
-		regs->orig_ax = -1;
+	if (unlikely(copy_from_user(&sc, usc, sizeof(sc))))
+		return -EFAULT;
 
-		get_user_ex(tmp, &sc->fpstate);
-		buf = compat_ptr(tmp);
-	} get_user_catch(err);
+	/* Get only the ia32 registers. */
+	regs->bx = sc.bx;
+	regs->cx = sc.cx;
+	regs->dx = sc.dx;
+	regs->si = sc.si;
+	regs->di = sc.di;
+	regs->bp = sc.bp;
+	regs->ax = sc.ax;
+	regs->sp = sc.sp;
+	regs->ip = sc.ip;
+
+	/* Get CS/SS and force CPL3 */
+	regs->cs = sc.cs | 0x03;
+	regs->ss = sc.ss | 0x03;
+
+	regs->flags = (regs->flags & ~FIX_EFLAGS) | (sc.flags & FIX_EFLAGS);
+	/* disable syscall checks */
+	regs->orig_ax = -1;
 
 	/*
 	 * Reload fs and gs if they have changed in the signal
@@ -107,14 +93,8 @@ static int ia32_restore_sigcontext(struct pt_regs *regs,
 	 * the handler, but does not clobber them at least in the
 	 * normal case.
 	 */
-	RELOAD_SEG(gs);
-	RELOAD_SEG(fs);
-	RELOAD_SEG(ds);
-	RELOAD_SEG(es);
-
-	err |= fpu__restore_sig(buf, 1);
-
-	return err;
+	reload_segments(&sc);
+	return fpu__restore_sig(compat_ptr(sc.fpstate), 1);
 }
 
 COMPAT_SYSCALL_DEFINE0(sigreturn)
@@ -172,6 +152,8 @@ COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
  * Set up a signal frame.
  */
 
+#define get_user_seg(seg)	({ unsigned int v; savesegment(seg, v); v; })
+
 static int ia32_setup_sigcontext(struct sigcontext_32 __user *sc,
 				 void __user *fpstate,
 				 struct pt_regs *regs, unsigned int mask)
-- 
2.11.0

