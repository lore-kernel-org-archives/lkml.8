Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354CAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1939D20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgHLMHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:07:04 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:17227 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727871AbgHLMGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:06:10 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BRT1p0cFzzB09Zk;
        Wed, 12 Aug 2020 14:06:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id k15iqKqwlVLT; Wed, 12 Aug 2020 14:06:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BRT1n6y18zB09Zf;
        Wed, 12 Aug 2020 14:06:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 529CC8B828;
        Wed, 12 Aug 2020 14:06:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id H8M1a8aIIpFr; Wed, 12 Aug 2020 14:06:07 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1E6118B7FC;
        Wed, 12 Aug 2020 14:06:07 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id EA3E365C34; Wed, 12 Aug 2020 12:06:06 +0000 (UTC)
Message-Id: <fc36912524b7960933e86625746970a5c2426dcf.1597233555.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1597233555.git.christophe.leroy@csgroup.eu>
References: <cover.1597233555.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 15/19] powerpc/signal32: Switch handle_signal32() to
 user_access_begin() logic
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ldv@altlinux.org,
        viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 12 Aug 2020 12:06:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal_32.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 0d076c2a9f6c..4ea83578ba9d 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -1241,23 +1241,23 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
 
 	/* Set up Signal Frame */
 	frame = get_sigframe(ksig, tsk, sizeof(*frame), 1);
-	if (!access_ok(frame, sizeof(*frame)))
+	if (!user_write_access_begin(frame, sizeof(*frame)))
 		goto badframe;
 	sc = (struct sigcontext __user *) &frame->sctx;
 
 #if _NSIG != 64
 #error "Please adjust handle_signal()"
 #endif
-	if (__put_user(to_user_ptr(ksig->ka.sa.sa_handler), &sc->handler)
-	    || __put_user(oldset->sig[0], &sc->oldmask)
+	unsafe_put_user(to_user_ptr(ksig->ka.sa.sa_handler), &sc->handler, failed);
+	unsafe_put_user(oldset->sig[0], &sc->oldmask, failed);
 #ifdef CONFIG_PPC64
-	    || __put_user((oldset->sig[0] >> 32), &sc->_unused[3])
+	unsafe_put_user((oldset->sig[0] >> 32), &sc->_unused[3], failed);
 #else
-	    || __put_user(oldset->sig[1], &sc->_unused[3])
+	unsafe_put_user(oldset->sig[1], &sc->_unused[3], failed);
 #endif
-	    || __put_user(to_user_ptr(&frame->mctx), &sc->regs)
-	    || __put_user(ksig->sig, &sc->signal))
-		goto badframe;
+	unsafe_put_user(to_user_ptr(&frame->mctx), &sc->regs, failed);
+	unsafe_put_user(ksig->sig, &sc->signal, failed);
+	user_write_access_end();
 
 	if (vdso32_sigtramp && tsk->mm->context.vdso_base) {
 		sigret = 0;
@@ -1300,6 +1300,9 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
 	regs->msr &= ~MSR_LE;
 	return 0;
 
+failed:
+	user_write_access_end();
+
 badframe:
 	signal_fault(tsk, regs, "handle_signal32", frame);
 
-- 
2.25.0

