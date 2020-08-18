Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCAFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AB0020658
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgHRRUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:20:55 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:63725 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728590AbgHRRTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:19:30 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BWHhZ2D5hz9vCxs;
        Tue, 18 Aug 2020 19:19:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id hsmR4IP4iZ9M; Tue, 18 Aug 2020 19:19:26 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BWHhZ1Ngkz9vCxg;
        Tue, 18 Aug 2020 19:19:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 12F4E8B7EC;
        Tue, 18 Aug 2020 19:19:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id sXJh-3FR1IrY; Tue, 18 Aug 2020 19:19:27 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C84038B7D7;
        Tue, 18 Aug 2020 19:19:27 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id A521065CF4; Tue, 18 Aug 2020 17:19:27 +0000 (UTC)
Message-Id: <df0bc8c3b8fa96390c46f611df79b2a94ac21844.1597770847.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1597770847.git.christophe.leroy@csgroup.eu>
References: <cover.1597770847.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 15/25] powerpc/signal32: Misc changes to make
 handle_[rt_]_signal32() more similar
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 18 Aug 2020 17:19:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miscellaneous changes to clean and make handle_signal32() and
handle_rt_signal32() even more similar.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal_32.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index d0fcb3de66aa..ab8c8cb98b15 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -764,8 +764,11 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 #endif
 
 	/* Set up Signal Frame */
-	/* Put a Real Time Context onto stack */
 	frame = get_sigframe(ksig, tsk, sizeof(*frame), 1);
+	mctx = &frame->uc.uc_mcontext;
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	tm_mctx = &frame->uc_transact.uc_mcontext;
+#endif
 	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
 
@@ -778,7 +781,6 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 		goto badframe;
 
 	/* Save user registers on the stack */
-	mctx = &frame->uc.uc_mcontext;
 	if (vdso32_rt_sigtramp && tsk->mm->context.vdso_base) {
 		sigret = 0;
 		tramp = tsk->mm->context.vdso_base + vdso32_rt_sigtramp;
@@ -788,7 +790,6 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 	}
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	tm_mctx = &frame->uc_transact.uc_mcontext;
 	if (MSR_TM_ACTIVE(msr)) {
 		if (__put_user((unsigned long)&frame->uc_transact,
 			       &frame->uc.uc_link) ||
@@ -843,6 +844,7 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
 {
 	struct sigcontext __user *sc;
 	struct sigframe __user *frame;
+	struct mcontext __user *mctx;
 	struct mcontext __user *tm_mctx = NULL;
 	unsigned long newsp = 0;
 	int sigret;
@@ -855,6 +857,10 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
 
 	/* Set up Signal Frame */
 	frame = get_sigframe(ksig, tsk, sizeof(*frame), 1);
+	mctx = &frame->mctx;
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	tm_mctx = &frame->mctx_transact;
+#endif
 	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
 	sc = (struct sigcontext __user *) &frame->sctx;
@@ -869,7 +875,7 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
 #else
 	    || __put_user(oldset->sig[1], &sc->_unused[3])
 #endif
-	    || __put_user(to_user_ptr(&frame->mctx), &sc->regs)
+	    || __put_user(to_user_ptr(mctx), &sc->regs)
 	    || __put_user(ksig->sig, &sc->signal))
 		goto badframe;
 
@@ -878,20 +884,18 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
 		tramp = tsk->mm->context.vdso_base + vdso32_sigtramp;
 	} else {
 		sigret = __NR_sigreturn;
-		tramp = (unsigned long) frame->mctx.tramp;
+		tramp = (unsigned long)mctx->tramp;
 	}
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	tm_mctx = &frame->mctx_transact;
 	if (MSR_TM_ACTIVE(msr)) {
-		if (save_tm_user_regs(regs, &frame->mctx, &frame->mctx_transact,
-				      sigret, msr))
+		if (save_tm_user_regs(regs, mctx, tm_mctx, sigret, msr))
 			goto badframe;
 	}
 	else
 #endif
 	{
-		if (save_user_regs(regs, &frame->mctx, tm_mctx, sigret, 1))
+		if (save_user_regs(regs, mctx, tm_mctx, sigret, 1))
 			goto badframe;
 	}
 
@@ -909,7 +913,7 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
 	regs->gpr[1] = newsp;
 	regs->gpr[3] = ksig->sig;
 	regs->gpr[4] = (unsigned long) sc;
-	regs->nip = (unsigned long) (unsigned long)ksig->ka.sa.sa_handler;
+	regs->nip = (unsigned long)ksig->ka.sa.sa_handler;
 	/* enter the signal handler in big-endian mode */
 	regs->msr &= ~MSR_LE;
 	return 0;
-- 
2.25.0

