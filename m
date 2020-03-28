Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A338FC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8083020936
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgC1LAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:00:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55516 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgC1K76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 06:59:58 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jI9C0-0003bN-P7; Sat, 28 Mar 2020 11:59:56 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5F7191C0470;
        Sat, 28 Mar 2020 11:59:56 +0100 (CET)
Date:   Sat, 28 Mar 2020 10:59:56 -0000
From:   "tip-bot2 for Al Viro" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: ia32_setup_frame(): consolidate uaccess areas
Cc:     Al Viro <viro@zeniv.linux.org.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158539319604.28353.1393436657593143514.tip-bot2@tip-bot2>
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

Commit-ID:     e2390741053e4931841650b5eadac32697aa88aa
Gitweb:        https://git.kernel.org/tip/e2390741053e4931841650b5eadac32697aa88aa
Author:        Al Viro <viro@zeniv.linux.org.uk>
AuthorDate:    Sat, 15 Feb 2020 19:36:40 -05:00
Committer:     Al Viro <viro@zeniv.linux.org.uk>
CommitterDate: Thu, 26 Mar 2020 14:39:38 -04:00

x86: ia32_setup_frame(): consolidate uaccess areas

Currently we have user_access block, followed by __put_user(),
deciding what the restorer will be and finally a put_user_try
block.

Moving the calculation of restorer first allows the rest
(actual copyout work) to coalesce into a single user_access block.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/ia32/ia32_signal.c | 39 +++++++++++-------------------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 799ca5b..7018c2c 100644
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
