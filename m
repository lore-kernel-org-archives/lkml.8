Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905C5C2D0E7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728422070A
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgC0Ccv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:32:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48044 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbgC0CcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:32:11 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHen1-003hSO-CN; Fri, 27 Mar 2020 02:32:07 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH v2 17/22] x86: setup_sigcontext(): list user_access_{begin,end}() into callers
Date:   Fri, 27 Mar 2020 02:32:00 +0000
Message-Id: <20200327023205.881896-17-viro@ZenIV.linux.org.uk>
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

Similar to ia32_setup_sigcontext() change several commits ago, make it
__always_inline.  In cases when there is a user_access_{begin,end}()
section nearby, just move the call over there.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/kernel/signal.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 8b879fdc214c..f4fb00bd2378 100644
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
-- 
2.11.0

