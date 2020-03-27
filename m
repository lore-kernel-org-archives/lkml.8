Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CE9C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221422082D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgC0Ccu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:32:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48048 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgC0CcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:32:11 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHen0-003hS5-U2; Fri, 27 Mar 2020 02:32:06 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH v2 14/22] x86: ia32_setup_frame(): consolidate uaccess areas
Date:   Fri, 27 Mar 2020 02:31:57 +0000
Message-Id: <20200327023205.881896-14-viro@ZenIV.linux.org.uk>
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

Currently we have user_access block, followed by __put_user(),
deciding what the restorer will be and finally a put_user_try
block.

Moving the calculation of restorer first allows the rest
(actual copyout work) to coalesce into a single user_access block.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/ia32/ia32_signal.c | 39 ++++++++++++---------------------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 799ca5b31b87..7018c2c325a1 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -236,7 +236,6 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
 {
 	struct sigframe_ia32 __user *frame;
 	void __user *restorer;
-	int err = 0;
 	void __user *fp = NULL;
 
 	/* copy_to_user optimizes that into a single 8 byte store */
@@ -252,21 +251,6 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
 
 	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp);
 
-	if (!access_ok(frame, sizeof(*frame)))
-		return -EFAULT;
-
-	if (__put_user(sig, &frame->sig))
-		return -EFAULT;
-
-	if (!user_access_begin(&frame->sc, sizeof(struct sigcontext_32)))
-		return -EFAULT;
-
-	unsafe_put_sigcontext32(&frame->sc, fp, regs, set, Efault);
-	user_access_end();
-
-	if (__put_user(set->sig[1], &frame->extramask[0]))
-		return -EFAULT;
-
 	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
 		restorer = ksig->ka.sa.sa_restorer;
 	} else {
@@ -278,19 +262,20 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
 			restorer = &frame->retcode;
 	}
 
-	put_user_try {
-		put_user_ex(ptr_to_compat(restorer), &frame->pretcode);
-
-		/*
-		 * These are actually not used anymore, but left because some
-		 * gdb versions depend on them as a marker.
-		 */
-		put_user_ex(*((u64 *)&code), (u64 __user *)frame->retcode);
-	} put_user_catch(err);
-
-	if (err)
+	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
 
+	unsafe_put_user(sig, &frame->sig, Efault);
+	unsafe_put_sigcontext32(&frame->sc, fp, regs, set, Efault);
+	unsafe_put_user(set->sig[1], &frame->extramask[0], Efault);
+	unsafe_put_user(ptr_to_compat(restorer), &frame->pretcode, Efault);
+	/*
+	 * These are actually not used anymore, but left because some
+	 * gdb versions depend on them as a marker.
+	 */
+	unsafe_put_user(*((u64 *)&code), (u64 __user *)frame->retcode, Efault);
+	user_access_end();
+
 	/* Set up registers for signal handler */
 	regs->sp = (unsigned long) frame;
 	regs->ip = (unsigned long) ksig->ka.sa.sa_handler;
-- 
2.11.0

