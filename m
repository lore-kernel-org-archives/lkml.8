Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA17C2D0E7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE99D215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgC0CcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:32:13 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48028 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgC0CcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:32:11 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHen0-003hRk-Ku; Fri, 27 Mar 2020 02:32:06 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH v2 11/22] x86: switch ia32_setup_sigcontext() to unsafe_put_user()
Date:   Fri, 27 Mar 2020 02:31:54 +0000
Message-Id: <20200327023205.881896-11-viro@ZenIV.linux.org.uk>
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
 arch/x86/ia32/ia32_signal.c | 64 +++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 31 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 23e2c55d8a59..af673ec23a2d 100644
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
-- 
2.11.0

