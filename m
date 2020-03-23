Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036F4C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 18:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8BC20719
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 18:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgCWSik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:38:40 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46784 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbgCWSiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 14:38:25 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGRxv-00137T-QW; Mon, 23 Mar 2020 18:38:23 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 21/22] x86: unsafe_put_... macros for sigcontext and sigmask
Date:   Mon, 23 Mar 2020 18:38:18 +0000
Message-Id: <20200323183819.250124-21-viro@ZenIV.linux.org.uk>
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

regularizes things a bit

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/kernel/signal.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 50679e8f42d7..52edadca5723 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -196,6 +196,17 @@ static __always_inline int setup_sigcontext(struct sigcontext __user *sc, void _
 	return -EFAULT;
 }
 
+#define unsafe_put_sigcontext(sc, fpstate, regs, set, label)	\
+do {								\
+	if (setup_sigcontext(sc, fpstate, regs, set->sig[0]))	\
+		goto label;					\
+} while(0);
+
+#define unsafe_put_sigmask(set, frame, label) \
+	unsafe_put_user(*(__u64 *)(set), \
+			(__u64 __user *)&(frame)->uc.uc_sigmask, \
+			label)
+
 /*
  * Set up a signal frame.
  */
@@ -303,8 +314,7 @@ __setup_frame(int sig, struct ksignal *ksig, sigset_t *set,
 		return -EFAULT;
 
 	unsafe_put_user(sig, &frame->sig, Efault);
-	if (setup_sigcontext(&frame->sc, fpstate, regs, set->sig[0]))
-		goto Efault;
+	unsafe_put_sigcontext(&frame->sc, fpstate, regs, set, Efault);
 	unsafe_put_user(set->sig[1], &frame->extramask[0], Efault);
 	if (current->mm->context.vdso)
 		restorer = current->mm->context.vdso +
@@ -351,9 +361,9 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 {
 	struct rt_sigframe __user *frame;
 	void __user *restorer;
-	void __user *fpstate = NULL;
+	void __user *fp = NULL;
 
-	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame), &fpstate);
+	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame), &fp);
 
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
@@ -385,11 +395,8 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	 * signal handler stack frames.
 	 */
 	unsafe_put_user(*((u64 *)&rt_retcode), (u64 *)frame->retcode, Efault);
-	if (setup_sigcontext(&frame->uc.uc_mcontext, fpstate,
-				regs, set->sig[0]))
-		goto Efault;
-	unsafe_put_user(*(__u64 *)set,
-			(__u64 __user *)&frame->uc.uc_sigmask, Efault);
+	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set, Efault);
+	unsafe_put_sigmask(set, frame, Efault);
 	user_access_end();
 	
 	if (copy_siginfo_to_user(&frame->info, &ksig->info))
@@ -453,9 +460,8 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	/* Set up to return from userspace.  If provided, use a stub
 	   already in userspace.  */
 	unsafe_put_user(ksig->ka.sa.sa_restorer, &frame->pretcode, Efault);
-	if (setup_sigcontext(&frame->uc.uc_mcontext, fp, regs, set->sig[0]))
-		goto Efault;
-	unsafe_put_user(set->sig[0], &frame->uc.uc_sigmask.sig[0], Efault);
+	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set, Efault);
+	unsafe_put_sigmask(set, frame, Efault);
 	user_access_end();
 
 	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
@@ -514,12 +520,12 @@ static int x32_setup_rt_frame(struct ksignal *ksig,
 	struct rt_sigframe_x32 __user *frame;
 	unsigned long uc_flags;
 	void __user *restorer;
-	void __user *fpstate = NULL;
+	void __user *fp = NULL;
 
 	if (!(ksig->ka.sa.sa_flags & SA_RESTORER))
 		return -EFAULT;
 
-	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame), &fpstate);
+	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame), &fp);
 
 	uc_flags = frame_uc_flags(regs);
 
@@ -533,10 +539,8 @@ static int x32_setup_rt_frame(struct ksignal *ksig,
 	unsafe_put_user(0, &frame->uc.uc__pad0, Efault);
 	restorer = ksig->ka.sa.sa_restorer;
 	unsafe_put_user(restorer, (unsigned long __user *)&frame->pretcode, Efault);
-	if (setup_sigcontext(&frame->uc.uc_mcontext, fpstate,
-				regs, set->sig[0]))
-		goto Efault;
-	unsafe_put_user(*(__u64 *)set, (__u64 __user *)&frame->uc.uc_sigmask, Efault);
+	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set, Efault);
+	unsafe_put_sigmask(set, frame, Efault);
 	user_access_end();
 
 	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
-- 
2.11.0

