Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D40C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820D52070A
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgC0Ccb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:32:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48058 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbgC0CcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:32:11 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHen1-003hSh-K9; Fri, 27 Mar 2020 02:32:07 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH v2 20/22] x86: x32_setup_rt_frame(): consolidate uaccess areas
Date:   Fri, 27 Mar 2020 02:32:03 +0000
Message-Id: <20200327023205.881896-20-viro@ZenIV.linux.org.uk>
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
 arch/x86/kernel/signal.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index e37d5a1bb713..38b359325291 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -517,7 +517,6 @@ static int x32_setup_rt_frame(struct ksignal *ksig,
 	struct rt_sigframe_x32 __user *frame;
 	unsigned long uc_flags;
 	void __user *restorer;
-	int err = 0;
 	void __user *fp = NULL;
 
 	if (!(ksig->ka.sa.sa_flags & SA_RESTORER))
@@ -525,14 +524,6 @@ static int x32_setup_rt_frame(struct ksignal *ksig,
 
 	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame), &fp);
 
-	if (!access_ok(frame, sizeof(*frame)))
-		return -EFAULT;
-
-	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
-		if (__copy_siginfo_to_user32(&frame->info, &ksig->info, true))
-			return -EFAULT;
-	}
-
 	uc_flags = frame_uc_flags(regs);
 
 	if (!user_access_begin(frame, sizeof(*frame)))
@@ -546,11 +537,13 @@ static int x32_setup_rt_frame(struct ksignal *ksig,
 	restorer = ksig->ka.sa.sa_restorer;
 	unsafe_put_user(restorer, (unsigned long __user *)&frame->pretcode, Efault);
 	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set, Efault);
+	unsafe_put_user(*(__u64 *)set, (__u64 __user *)&frame->uc.uc_sigmask, Efault);
 	user_access_end();
-	err |= __put_user(*(__u64 *)set, (__u64 __user *)&frame->uc.uc_sigmask);
 
-	if (err)
-		return -EFAULT;
+	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
+		if (__copy_siginfo_to_user32(&frame->info, &ksig->info, true))
+			return -EFAULT;
+	}
 
 	/* Set up registers for signal handler */
 	regs->sp = (unsigned long) frame;
-- 
2.11.0

