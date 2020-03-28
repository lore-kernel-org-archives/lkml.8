Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B5AC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42C020723
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgC1LAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:00:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55538 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgC1LAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:00:04 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jI9C5-0003dR-E8; Sat, 28 Mar 2020 12:00:01 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E2C831C0483;
        Sat, 28 Mar 2020 11:59:59 +0100 (CET)
Date:   Sat, 28 Mar 2020 10:59:59 -0000
From:   "tip-bot2 for Al Viro" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: get rid of get_user_ex() in
 ia32_restore_sigcontext()
Cc:     Al Viro <viro@zeniv.linux.org.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158539319958.28353.17824653160739885760.tip-bot2@tip-bot2>
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

Commit-ID:     978727ca331ebd8b479f6a7afd27bb2e6504b2e3
Gitweb:        https://git.kernel.org/tip/978727ca331ebd8b479f6a7afd27bb2e6504b2e3
Author:        Al Viro <viro@zeniv.linux.org.uk>
AuthorDate:    Sat, 15 Feb 2020 12:23:36 -05:00
Committer:     Al Viro <viro@zeniv.linux.org.uk>
CommitterDate: Wed, 18 Mar 2020 20:10:27 -04:00

x86: get rid of get_user_ex() in ia32_restore_sigcontext()

Just do copyin into a local struct and be done with that - we are
on a shallow stack here.

[reworked by tglx, removing the macro horrors while we are touching that]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/ia32/ia32_signal.c | 106 ++++++++++++++---------------------
 1 file changed, 44 insertions(+), 62 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index c72025d..23e2c55 100644
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
@@ -172,6 +152,8 @@ badframe:
  * Set up a signal frame.
  */
 
+#define get_user_seg(seg)	({ unsigned int v; savesegment(seg, v); v; })
+
 static int ia32_setup_sigcontext(struct sigcontext_32 __user *sc,
 				 void __user *fpstate,
 				 struct pt_regs *regs, unsigned int mask)
