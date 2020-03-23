Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39599C4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 18:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B84E2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 18:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgCWSjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:39:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46768 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbgCWSiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 14:38:25 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGRxv-00136w-6C; Mon, 23 Mar 2020 18:38:23 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 17/22] x86: setup_sigcontext(): list user_access_{begin,end}() into callers
Date:   Mon, 23 Mar 2020 18:38:14 +0000
Message-Id: <20200323183819.250124-17-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
References: <20200323183620.GD23230@ZenIV.linux.org.uk>
 <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
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
 arch/x86/kernel/signal.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 8b879fdc214c..a5a898c3c574 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -140,12 +140,9 @@ static int restore_sigcontext(struct pt_regs *regs,
 			       IS_ENABLED(CONFIG_X86_32));
 }
 
-static int setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
+static __always_inline int setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
 		     struct pt_regs *regs, unsigned long mask)
 {
-	if (!user_access_begin(sc, sizeof(struct sigcontext)))
-		return -EFAULT;
-
 #ifdef CONFIG_X86_32
 	unsafe_put_user(get_user_gs(regs),
 				  (unsigned int __user *)&sc->gs, Efault);
@@ -194,10 +191,8 @@ static int setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
 	/* non-iBCS2 extensions.. */
 	unsafe_put_user(mask, &sc->oldmask, Efault);
 	unsafe_put_user(current->thread.cr2, &sc->cr2, Efault);
-	user_access_end();
 	return 0;
 Efault:
-	user_access_end();
 	return -EFAULT;
 }
 
@@ -311,8 +306,11 @@ __setup_frame(int sig, struct ksignal *ksig, sigset_t *set,
 	if (__put_user(sig, &frame->sig))
 		return -EFAULT;
 
-	if (setup_sigcontext(&frame->sc, fpstate, regs, set->sig[0]))
+	if (!user_access_begin(&frame->sc, sizeof(struct sigcontext)))
 		return -EFAULT;
+	if (setup_sigcontext(&frame->sc, fpstate, regs, set->sig[0]))
+		goto Efault;
+	user_access_end();
 
 	if (__put_user(set->sig[1], &frame->extramask[0]))
 		return -EFAULT;
@@ -353,6 +351,10 @@ __setup_frame(int sig, struct ksignal *ksig, sigset_t *set,
 	regs->cs = __USER_CS;
 
 	return 0;
+
+Efault:
+	user_access_end();
+	return -EFAULT;
 }
 
 static int __setup_rt_frame(int sig, struct ksignal *ksig,
@@ -395,13 +397,13 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	 * signal handler stack frames.
 	 */
 	unsafe_put_user(*((u64 *)&rt_retcode), (u64 *)frame->retcode, Efault);
+	if (setup_sigcontext(&frame->uc.uc_mcontext, fpstate,
+				regs, set->sig[0]))
+		goto Efault;
 	user_access_end();
 	
 	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
-	err |= setup_sigcontext(&frame->uc.uc_mcontext, fpstate,
-				regs, set->sig[0]);
 	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
-
 	if (err)
 		return -EFAULT;
 
@@ -472,9 +474,9 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	/* Set up to return from userspace.  If provided, use a stub
 	   already in userspace.  */
 	unsafe_put_user(ksig->ka.sa.sa_restorer, &frame->pretcode, Efault);
+	if (setup_sigcontext(&frame->uc.uc_mcontext, fp, regs, set->sig[0]))
+		goto Efault;
 	user_access_end();
-
-	err |= setup_sigcontext(&frame->uc.uc_mcontext, fp, regs, set->sig[0]);
 	err |= __put_user(set->sig[0], &frame->uc.uc_sigmask.sig[0]);
 
 	if (err)
@@ -559,10 +561,10 @@ static int x32_setup_rt_frame(struct ksignal *ksig,
 	unsafe_put_user(0, &frame->uc.uc__pad0, Efault);
 	restorer = ksig->ka.sa.sa_restorer;
 	unsafe_put_user(restorer, (unsigned long __user *)&frame->pretcode, Efault);
+	if (setup_sigcontext(&frame->uc.uc_mcontext, fpstate,
+				regs, set->sig[0]))
+		goto Efault;
 	user_access_end();
-
-	err |= setup_sigcontext(&frame->uc.uc_mcontext, fpstate,
-				regs, set->sig[0]);
 	err |= __put_user(*(__u64 *)set, (__u64 __user *)&frame->uc.uc_sigmask);
 
 	if (err)
-- 
2.11.0

