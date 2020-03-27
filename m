Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179E6C2D0E7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA6F20774
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgC0CcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:32:19 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48062 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbgC0CcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:32:12 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHen1-003hSV-Er; Fri, 27 Mar 2020 02:32:07 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH v2 18/22] x86: __setup_frame(): consolidate uaccess areas
Date:   Fri, 27 Mar 2020 02:32:01 +0000
Message-Id: <20200327023205.881896-18-viro@ZenIV.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/kernel/signal.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index f4fb00bd2378..38ff834ba0d6 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -302,25 +302,16 @@ __setup_frame(int sig, struct ksignal *ksig, sigset_t *set,
 {
 	struct sigframe __user *frame;
 	void __user *restorer;
-	int err = 0;
 	void __user *fp = NULL;
 
 	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame), &fp);
 
-	if (!access_ok(frame, sizeof(*frame)))
-		return -EFAULT;
-
-	if (__put_user(sig, &frame->sig))
+	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
 
-	if (!user_access_begin(&frame->sc, sizeof(struct sigcontext)))
-		return -EFAULT;
+	unsafe_put_user(sig, &frame->sig, Efault);
 	unsafe_put_sigcontext(&frame->sc, fp, regs, set, Efault);
-	user_access_end();
-
-	if (__put_user(set->sig[1], &frame->extramask[0]))
-		return -EFAULT;
-
+	unsafe_put_user(set->sig[1], &frame->extramask[0], Efault);
 	if (current->mm->context.vdso)
 		restorer = current->mm->context.vdso +
 			vdso_image_32.sym___kernel_sigreturn;
@@ -330,7 +321,7 @@ __setup_frame(int sig, struct ksignal *ksig, sigset_t *set,
 		restorer = ksig->ka.sa.sa_restorer;
 
 	/* Set up to return from userspace.  */
-	err |= __put_user(restorer, &frame->pretcode);
+	unsafe_put_user(restorer, &frame->pretcode, Efault);
 
 	/*
 	 * This is popl %eax ; movl $__NR_sigreturn, %eax ; int $0x80
@@ -339,10 +330,8 @@ __setup_frame(int sig, struct ksignal *ksig, sigset_t *set,
 	 * reasons and because gdb uses it as a signature to notice
 	 * signal handler stack frames.
 	 */
-	err |= __put_user(*((u64 *)&retcode), (u64 *)frame->retcode);
-
-	if (err)
-		return -EFAULT;
+	unsafe_put_user(*((u64 *)&retcode), (u64 *)frame->retcode, Efault);
+	user_access_end();
 
 	/* Set up registers for signal handler */
 	regs->sp = (unsigned long)frame;
-- 
2.11.0

