Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C341EC2D0E5
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A254B20838
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgC1K77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 06:59:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55504 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgC1K75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 06:59:57 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jI9Bz-0003aK-A5; Sat, 28 Mar 2020 11:59:55 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A439C1C03A9;
        Sat, 28 Mar 2020 11:59:54 +0100 (CET)
Date:   Sat, 28 Mar 2020 10:59:54 -0000
From:   "tip-bot2 for Al Viro" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: __setup_frame(): consolidate uaccess areas
Cc:     Al Viro <viro@zeniv.linux.org.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158539319427.28353.11035795742218944544.tip-bot2@tip-bot2>
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

Commit-ID:     5c1f178094631e8b9acc67e4a9b6e03abfbc2529
Gitweb:        https://git.kernel.org/tip/5c1f178094631e8b9acc67e4a9b6e03abfbc2529
Author:        Al Viro <viro@zeniv.linux.org.uk>
AuthorDate:    Sat, 15 Feb 2020 21:18:02 -05:00
Committer:     Al Viro <viro@zeniv.linux.org.uk>
CommitterDate: Thu, 26 Mar 2020 14:57:10 -04:00

x86: __setup_frame(): consolidate uaccess areas

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/kernel/signal.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index f4fb00b..38ff834 100644
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
