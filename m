Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9C7C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0932070A
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgC0Cci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:32:38 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48050 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbgC0CcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:32:11 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHen0-003hRd-GW; Fri, 27 Mar 2020 02:32:06 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH v2 10/22] x86: switch setup_sigcontext() to unsafe_put_user()
Date:   Fri, 27 Mar 2020 02:31:53 +0000
Message-Id: <20200327023205.881896-10-viro@ZenIV.linux.org.uk>
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
 arch/x86/include/asm/sighandling.h |  3 --
 arch/x86/kernel/signal.c           | 88 +++++++++++++++++++-------------------
 2 files changed, 45 insertions(+), 46 deletions(-)

diff --git a/arch/x86/include/asm/sighandling.h b/arch/x86/include/asm/sighandling.h
index 2fcbd6f33ef7..35e0b579ffcb 100644
--- a/arch/x86/include/asm/sighandling.h
+++ b/arch/x86/include/asm/sighandling.h
@@ -14,9 +14,6 @@
 			 X86_EFLAGS_CF | X86_EFLAGS_RF)
 
 void signal_fault(struct pt_regs *regs, void __user *frame, char *where);
-int setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
-		     struct pt_regs *regs, unsigned long mask);
-
 
 #ifdef CONFIG_X86_X32_ABI
 asmlinkage long sys32_x32_rt_sigreturn(void);
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 83563e98f0be..3b4ca484cfc2 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -140,63 +140,65 @@ static int restore_sigcontext(struct pt_regs *regs,
 			       IS_ENABLED(CONFIG_X86_32));
 }
 
-int setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
+static int setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
 		     struct pt_regs *regs, unsigned long mask)
 {
-	int err = 0;
-
-	put_user_try {
+	if (!user_access_begin(sc, sizeof(struct sigcontext)))
+		return -EFAULT;
 
 #ifdef CONFIG_X86_32
-		put_user_ex(get_user_gs(regs), (unsigned int __user *)&sc->gs);
-		put_user_ex(regs->fs, (unsigned int __user *)&sc->fs);
-		put_user_ex(regs->es, (unsigned int __user *)&sc->es);
-		put_user_ex(regs->ds, (unsigned int __user *)&sc->ds);
+	unsafe_put_user(get_user_gs(regs),
+				  (unsigned int __user *)&sc->gs, Efault);
+	unsafe_put_user(regs->fs, (unsigned int __user *)&sc->fs, Efault);
+	unsafe_put_user(regs->es, (unsigned int __user *)&sc->es, Efault);
+	unsafe_put_user(regs->ds, (unsigned int __user *)&sc->ds, Efault);
 #endif /* CONFIG_X86_32 */
 
-		put_user_ex(regs->di, &sc->di);
-		put_user_ex(regs->si, &sc->si);
-		put_user_ex(regs->bp, &sc->bp);
-		put_user_ex(regs->sp, &sc->sp);
-		put_user_ex(regs->bx, &sc->bx);
-		put_user_ex(regs->dx, &sc->dx);
-		put_user_ex(regs->cx, &sc->cx);
-		put_user_ex(regs->ax, &sc->ax);
+	unsafe_put_user(regs->di, &sc->di, Efault);
+	unsafe_put_user(regs->si, &sc->si, Efault);
+	unsafe_put_user(regs->bp, &sc->bp, Efault);
+	unsafe_put_user(regs->sp, &sc->sp, Efault);
+	unsafe_put_user(regs->bx, &sc->bx, Efault);
+	unsafe_put_user(regs->dx, &sc->dx, Efault);
+	unsafe_put_user(regs->cx, &sc->cx, Efault);
+	unsafe_put_user(regs->ax, &sc->ax, Efault);
 #ifdef CONFIG_X86_64
-		put_user_ex(regs->r8, &sc->r8);
-		put_user_ex(regs->r9, &sc->r9);
-		put_user_ex(regs->r10, &sc->r10);
-		put_user_ex(regs->r11, &sc->r11);
-		put_user_ex(regs->r12, &sc->r12);
-		put_user_ex(regs->r13, &sc->r13);
-		put_user_ex(regs->r14, &sc->r14);
-		put_user_ex(regs->r15, &sc->r15);
+	unsafe_put_user(regs->r8, &sc->r8, Efault);
+	unsafe_put_user(regs->r9, &sc->r9, Efault);
+	unsafe_put_user(regs->r10, &sc->r10, Efault);
+	unsafe_put_user(regs->r11, &sc->r11, Efault);
+	unsafe_put_user(regs->r12, &sc->r12, Efault);
+	unsafe_put_user(regs->r13, &sc->r13, Efault);
+	unsafe_put_user(regs->r14, &sc->r14, Efault);
+	unsafe_put_user(regs->r15, &sc->r15, Efault);
 #endif /* CONFIG_X86_64 */
 
-		put_user_ex(current->thread.trap_nr, &sc->trapno);
-		put_user_ex(current->thread.error_code, &sc->err);
-		put_user_ex(regs->ip, &sc->ip);
+	unsafe_put_user(current->thread.trap_nr, &sc->trapno, Efault);
+	unsafe_put_user(current->thread.error_code, &sc->err, Efault);
+	unsafe_put_user(regs->ip, &sc->ip, Efault);
 #ifdef CONFIG_X86_32
-		put_user_ex(regs->cs, (unsigned int __user *)&sc->cs);
-		put_user_ex(regs->flags, &sc->flags);
-		put_user_ex(regs->sp, &sc->sp_at_signal);
-		put_user_ex(regs->ss, (unsigned int __user *)&sc->ss);
+	unsafe_put_user(regs->cs, (unsigned int __user *)&sc->cs, Efault);
+	unsafe_put_user(regs->flags, &sc->flags, Efault);
+	unsafe_put_user(regs->sp, &sc->sp_at_signal, Efault);
+	unsafe_put_user(regs->ss, (unsigned int __user *)&sc->ss, Efault);
 #else /* !CONFIG_X86_32 */
-		put_user_ex(regs->flags, &sc->flags);
-		put_user_ex(regs->cs, &sc->cs);
-		put_user_ex(0, &sc->gs);
-		put_user_ex(0, &sc->fs);
-		put_user_ex(regs->ss, &sc->ss);
+	unsafe_put_user(regs->flags, &sc->flags, Efault);
+	unsafe_put_user(regs->cs, &sc->cs, Efault);
+	unsafe_put_user(0, &sc->gs, Efault);
+	unsafe_put_user(0, &sc->fs, Efault);
+	unsafe_put_user(regs->ss, &sc->ss, Efault);
 #endif /* CONFIG_X86_32 */
 
-		put_user_ex(fpstate, (unsigned long __user *)&sc->fpstate);
+	unsafe_put_user(fpstate, (unsigned long __user *)&sc->fpstate, Efault);
 
-		/* non-iBCS2 extensions.. */
-		put_user_ex(mask, &sc->oldmask);
-		put_user_ex(current->thread.cr2, &sc->cr2);
-	} put_user_catch(err);
-
-	return err;
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

