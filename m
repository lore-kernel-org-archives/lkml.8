Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C15C2D0EE
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4FB420716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbgC1LAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:00:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55577 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbgC1LAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:00:08 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jI9C7-0003c9-4b; Sat, 28 Mar 2020 12:00:03 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C0A3F1C03A9;
        Sat, 28 Mar 2020 11:59:57 +0100 (CET)
Date:   Sat, 28 Mar 2020 10:59:57 -0000
From:   "tip-bot2 for Al Viro" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: switch ia32_setup_sigcontext() to unsafe_put_user()
Cc:     Al Viro <viro@zeniv.linux.org.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158539319742.28353.12586384356823817522.tip-bot2@tip-bot2>
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

Commit-ID:     d2d2728d161cbc52739d823a7fb76f3ba2fb3519
Gitweb:        https://git.kernel.org/tip/d2d2728d161cbc52739d823a7fb76f3ba2fb3519
Author:        Al Viro <viro@zeniv.linux.org.uk>
AuthorDate:    Sat, 15 Feb 2020 17:41:04 -05:00
Committer:     Al Viro <viro@zeniv.linux.org.uk>
CommitterDate: Wed, 18 Mar 2020 20:40:56 -04:00

x86: switch ia32_setup_sigcontext() to unsafe_put_user()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/ia32/ia32_signal.c | 64 ++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 31 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 23e2c55..af673ec 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -158,38 +158,40 @@ static int ia32_setup_sigcontext(struct sigcontext_32 __user *sc,
 				 void __user *fpstate,
 				 struct pt_regs *regs, unsigned int mask)
 {
-	int err = 0;
-
-	put_user_try {
-		put_user_ex(get_user_seg(gs), (unsigned int __user *)&sc->gs);
-		put_user_ex(get_user_seg(fs), (unsigned int __user *)&sc->fs);
-		put_user_ex(get_user_seg(ds), (unsigned int __user *)&sc->ds);
-		put_user_ex(get_user_seg(es), (unsigned int __user *)&sc->es);
-
-		put_user_ex(regs->di, &sc->di);
-		put_user_ex(regs->si, &sc->si);
-		put_user_ex(regs->bp, &sc->bp);
-		put_user_ex(regs->sp, &sc->sp);
-		put_user_ex(regs->bx, &sc->bx);
-		put_user_ex(regs->dx, &sc->dx);
-		put_user_ex(regs->cx, &sc->cx);
-		put_user_ex(regs->ax, &sc->ax);
-		put_user_ex(current->thread.trap_nr, &sc->trapno);
-		put_user_ex(current->thread.error_code, &sc->err);
-		put_user_ex(regs->ip, &sc->ip);
-		put_user_ex(regs->cs, (unsigned int __user *)&sc->cs);
-		put_user_ex(regs->flags, &sc->flags);
-		put_user_ex(regs->sp, &sc->sp_at_signal);
-		put_user_ex(regs->ss, (unsigned int __user *)&sc->ss);
-
-		put_user_ex(ptr_to_compat(fpstate), &sc->fpstate);
-
-		/* non-iBCS2 extensions.. */
-		put_user_ex(mask, &sc->oldmask);
-		put_user_ex(current->thread.cr2, &sc->cr2);
-	} put_user_catch(err);
+	if (!user_access_begin(sc, sizeof(struct sigcontext_32)))
+		return -EFAULT;
 
-	return err;
+	unsafe_put_user(get_user_seg(gs), (unsigned int __user *)&sc->gs, Efault);
+	unsafe_put_user(get_user_seg(fs), (unsigned int __user *)&sc->fs, Efault);
+	unsafe_put_user(get_user_seg(ds), (unsigned int __user *)&sc->ds, Efault);
+	unsafe_put_user(get_user_seg(es), (unsigned int __user *)&sc->es, Efault);
+
+	unsafe_put_user(regs->di, &sc->di, Efault);
+	unsafe_put_user(regs->si, &sc->si, Efault);
+	unsafe_put_user(regs->bp, &sc->bp, Efault);
+	unsafe_put_user(regs->sp, &sc->sp, Efault);
+	unsafe_put_user(regs->bx, &sc->bx, Efault);
+	unsafe_put_user(regs->dx, &sc->dx, Efault);
+	unsafe_put_user(regs->cx, &sc->cx, Efault);
+	unsafe_put_user(regs->ax, &sc->ax, Efault);
+	unsafe_put_user(current->thread.trap_nr, &sc->trapno, Efault);
+	unsafe_put_user(current->thread.error_code, &sc->err, Efault);
+	unsafe_put_user(regs->ip, &sc->ip, Efault);
+	unsafe_put_user(regs->cs, (unsigned int __user *)&sc->cs, Efault);
+	unsafe_put_user(regs->flags, &sc->flags, Efault);
+	unsafe_put_user(regs->sp, &sc->sp_at_signal, Efault);
+	unsafe_put_user(regs->ss, (unsigned int __user *)&sc->ss, Efault);
+
+	unsafe_put_user(ptr_to_compat(fpstate), &sc->fpstate, Efault);
+
+	/* non-iBCS2 extensions.. */
+	unsafe_put_user(mask, &sc->oldmask, Efault);
+	unsafe_put_user(current->thread.cr2, &sc->cr2, Efault);
+	user_access_end();
+	return 0;
+Efault:
+	user_access_end();
+	return -EFAULT;
 }
 
 /*
