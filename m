Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE5AC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B2F20723
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgC1LAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:00:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55506 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgC1K76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 06:59:58 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jI9Bz-0003aY-J5; Sat, 28 Mar 2020 11:59:55 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 21C2D1C0470;
        Sat, 28 Mar 2020 11:59:55 +0100 (CET)
Date:   Sat, 28 Mar 2020 10:59:54 -0000
From:   "tip-bot2 for Al Viro" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: setup_sigcontext(): list
 user_access_{begin,end}() into callers
Cc:     Al Viro <viro@zeniv.linux.org.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158539319474.28353.12890016664132767553.tip-bot2@tip-bot2>
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

Commit-ID:     b00d8f8f0b2b39223c3fd6713d318aba95420264
Gitweb:        https://git.kernel.org/tip/b00d8f8f0b2b39223c3fd6713d318aba95420264
Author:        Al Viro <viro@zeniv.linux.org.uk>
AuthorDate:    Sat, 15 Feb 2020 21:12:26 -05:00
Committer:     Al Viro <viro@zeniv.linux.org.uk>
CommitterDate: Thu, 26 Mar 2020 14:56:59 -04:00

x86: setup_sigcontext(): list user_access_{begin,end}() into callers

Similar to ia32_setup_sigcontext() change several commits ago, make it
__always_inline.  In cases when there is a user_access_{begin,end}()
section nearby, just move the call over there.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/kernel/signal.c | 45 ++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 8b879fd..f4fb00b 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -140,12 +140,10 @@ static int restore_sigcontext(struct pt_regs *regs,
 			       IS_ENABLED(CONFIG_X86_32));
 }
 
-static int setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
+static __always_inline int
+__unsafe_setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
 		     struct pt_regs *regs, unsigned long mask)
 {
-	if (!user_access_begin(sc, sizeof(struct sigcontext)))
-		return -EFAULT;
-
 #ifdef CONFIG_X86_32
 	unsafe_put_user(get_user_gs(regs),
 				  (unsigned int __user *)&sc->gs, Efault);
@@ -194,13 +192,17 @@ static int setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
 	/* non-iBCS2 extensions.. */
 	unsafe_put_user(mask, &sc->oldmask, Efault);
 	unsafe_put_user(current->thread.cr2, &sc->cr2, Efault);
-	user_access_end();
 	return 0;
 Efault:
-	user_access_end();
 	return -EFAULT;
 }
 
+#define unsafe_put_sigcontext(sc, fp, regs, set, label)			\
+do {									\
+	if (__unsafe_setup_sigcontext(sc, fp, regs, set->sig[0]))	\
+		goto label;						\
+} while(0);
+
 /*
  * Set up a signal frame.
  */
@@ -301,9 +303,9 @@ __setup_frame(int sig, struct ksignal *ksig, sigset_t *set,
 	struct sigframe __user *frame;
 	void __user *restorer;
 	int err = 0;
-	void __user *fpstate = NULL;
+	void __user *fp = NULL;
 
-	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame), &fpstate);
+	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame), &fp);
 
 	if (!access_ok(frame, sizeof(*frame)))
 		return -EFAULT;
@@ -311,8 +313,10 @@ __setup_frame(int sig, struct ksignal *ksig, sigset_t *set,
 	if (__put_user(sig, &frame->sig))
 		return -EFAULT;
 
-	if (setup_sigcontext(&frame->sc, fpstate, regs, set->sig[0]))
+	if (!user_access_begin(&frame->sc, sizeof(struct sigcontext)))
 		return -EFAULT;
+	unsafe_put_sigcontext(&frame->sc, fp, regs, set, Efault);
+	user_access_end();
 
 	if (__put_user(set->sig[1], &frame->extramask[0]))
 		return -EFAULT;
@@ -353,6 +357,10 @@ __setup_frame(int sig, struct ksignal *ksig, sigset_t *set,
 	regs->cs = __USER_CS;
 
 	return 0;
+
+Efault:
+	user_access_end();
+	return -EFAULT;
 }
 
 static int __setup_rt_frame(int sig, struct ksignal *ksig,
@@ -361,9 +369,9 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	struct rt_sigframe __user *frame;
 	void __user *restorer;
 	int err = 0;
-	void __user *fpstate = NULL;
+	void __user *fp = NULL;
 
-	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame), &fpstate);
+	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame), &fp);
 
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
@@ -395,13 +403,11 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	 * signal handler stack frames.
 	 */
 	unsafe_put_user(*((u64 *)&rt_retcode), (u64 *)frame->retcode, Efault);
+	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set, Efault);
 	user_access_end();
 	
 	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
-	err |= setup_sigcontext(&frame->uc.uc_mcontext, fpstate,
-				regs, set->sig[0]);
 	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
-
 	if (err)
 		return -EFAULT;
 
@@ -472,9 +478,8 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	/* Set up to return from userspace.  If provided, use a stub
 	   already in userspace.  */
 	unsafe_put_user(ksig->ka.sa.sa_restorer, &frame->pretcode, Efault);
+	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set, Efault);
 	user_access_end();
-
-	err |= setup_sigcontext(&frame->uc.uc_mcontext, fp, regs, set->sig[0]);
 	err |= __put_user(set->sig[0], &frame->uc.uc_sigmask.sig[0]);
 
 	if (err)
@@ -532,12 +537,12 @@ static int x32_setup_rt_frame(struct ksignal *ksig,
 	unsigned long uc_flags;
 	void __user *restorer;
 	int err = 0;
-	void __user *fpstate = NULL;
+	void __user *fp = NULL;
 
 	if (!(ksig->ka.sa.sa_flags & SA_RESTORER))
 		return -EFAULT;
 
-	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame), &fpstate);
+	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame), &fp);
 
 	if (!access_ok(frame, sizeof(*frame)))
 		return -EFAULT;
@@ -559,10 +564,8 @@ static int x32_setup_rt_frame(struct ksignal *ksig,
 	unsafe_put_user(0, &frame->uc.uc__pad0, Efault);
 	restorer = ksig->ka.sa.sa_restorer;
 	unsafe_put_user(restorer, (unsigned long __user *)&frame->pretcode, Efault);
+	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set, Efault);
 	user_access_end();
-
-	err |= setup_sigcontext(&frame->uc.uc_mcontext, fpstate,
-				regs, set->sig[0]);
 	err |= __put_user(*(__u64 *)set, (__u64 __user *)&frame->uc.uc_sigmask);
 
 	if (err)
