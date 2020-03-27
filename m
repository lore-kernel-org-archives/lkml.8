Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F031C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EAF32082D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgC0CdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:33:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48038 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbgC0CcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:32:10 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHen0-003hRy-Rw; Fri, 27 Mar 2020 02:32:06 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH v2 13/22] x86: ia32_setup_sigcontext(): lift user_access_{begin,end}() into the callers
Date:   Fri, 27 Mar 2020 02:31:56 +0000
Message-Id: <20200327023205.881896-13-viro@ZenIV.linux.org.uk>
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

What's left is just a sequence of stores to userland addresses, with all
error handling, etc. done out of line.  Calling that from user_access block
is safe, but rather than teaching objtool to recognize it as such we can
just make it always_inline - it is small enough and has few enough callers,
for the space savings not to be an issue.

	Rename the sucker to __unsafe_setup_sigcontext32() and provide
unsafe_put_sigcontext32() with usual kind of semantics.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/ia32/ia32_signal.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index a96995aa23da..799ca5b31b87 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -154,13 +154,11 @@ COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
 
 #define get_user_seg(seg)	({ unsigned int v; savesegment(seg, v); v; })
 
-static int ia32_setup_sigcontext(struct sigcontext_32 __user *sc,
-				 void __user *fpstate,
-				 struct pt_regs *regs, unsigned int mask)
+static __always_inline int
+__unsafe_setup_sigcontext32(struct sigcontext_32 __user *sc,
+			    void __user *fpstate,
+			    struct pt_regs *regs, unsigned int mask)
 {
-	if (!user_access_begin(sc, sizeof(struct sigcontext_32)))
-		return -EFAULT;
-
 	unsafe_put_user(get_user_seg(gs), (unsigned int __user *)&sc->gs, Efault);
 	unsafe_put_user(get_user_seg(fs), (unsigned int __user *)&sc->fs, Efault);
 	unsafe_put_user(get_user_seg(ds), (unsigned int __user *)&sc->ds, Efault);
@@ -187,13 +185,18 @@ static int ia32_setup_sigcontext(struct sigcontext_32 __user *sc,
 	/* non-iBCS2 extensions.. */
 	unsafe_put_user(mask, &sc->oldmask, Efault);
 	unsafe_put_user(current->thread.cr2, &sc->cr2, Efault);
-	user_access_end();
 	return 0;
+
 Efault:
-	user_access_end();
 	return -EFAULT;
 }
 
+#define unsafe_put_sigcontext32(sc, fp, regs, set, label)		\
+do {									\
+	if (__unsafe_setup_sigcontext32(sc, fp, regs, set->sig[0]))	\
+		goto label;						\
+} while(0)
+
 /*
  * Determine which stack to use..
  */
@@ -234,7 +237,7 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
 	struct sigframe_ia32 __user *frame;
 	void __user *restorer;
 	int err = 0;
-	void __user *fpstate = NULL;
+	void __user *fp = NULL;
 
 	/* copy_to_user optimizes that into a single 8 byte store */
 	static const struct {
@@ -247,7 +250,7 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
 		0x80cd,		/* int $0x80 */
 	};
 
-	frame = get_sigframe(ksig, regs, sizeof(*frame), &fpstate);
+	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp);
 
 	if (!access_ok(frame, sizeof(*frame)))
 		return -EFAULT;
@@ -255,9 +258,12 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
 	if (__put_user(sig, &frame->sig))
 		return -EFAULT;
 
-	if (ia32_setup_sigcontext(&frame->sc, fpstate, regs, set->sig[0]))
+	if (!user_access_begin(&frame->sc, sizeof(struct sigcontext_32)))
 		return -EFAULT;
 
+	unsafe_put_sigcontext32(&frame->sc, fp, regs, set, Efault);
+	user_access_end();
+
 	if (__put_user(set->sig[1], &frame->extramask[0]))
 		return -EFAULT;
 
@@ -301,6 +307,9 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
 	regs->ss = __USER32_DS;
 
 	return 0;
+Efault:
+	user_access_end();
+	return -EFAULT;
 }
 
 int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
@@ -309,7 +318,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 	struct rt_sigframe_ia32 __user *frame;
 	void __user *restorer;
 	int err = 0;
-	void __user *fpstate = NULL;
+	void __user *fp = NULL;
 
 	/* __copy_to_user optimizes that into a single 8 byte store */
 	static const struct {
@@ -324,7 +333,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 		0,
 	};
 
-	frame = get_sigframe(ksig, regs, sizeof(*frame), &fpstate);
+	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp);
 
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
@@ -355,9 +364,12 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 	unsafe_put_user(*((u64 *)&code), (u64 __user *)frame->retcode, Efault);
 	user_access_end();
 
-	err |= __copy_siginfo_to_user32(&frame->info, &ksig->info, false);
-	err |= ia32_setup_sigcontext(&frame->uc.uc_mcontext, fpstate,
-				     regs, set->sig[0]);
+	if (__copy_siginfo_to_user32(&frame->info, &ksig->info, false))
+		return -EFAULT;
+	if (!user_access_begin(&frame->uc.uc_mcontext, sizeof(struct sigcontext_32)))
+		return -EFAULT;
+	unsafe_put_sigcontext32(&frame->uc.uc_mcontext, fp, regs, set, Efault);
+	user_access_end();
 	err |= __put_user(*(__u64 *)set, (__u64 __user *)&frame->uc.uc_sigmask);
 
 	if (err)
-- 
2.11.0

