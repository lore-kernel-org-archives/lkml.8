Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747E7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50C9B20B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgHRRTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:19:49 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:63725 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728579AbgHRRT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:19:26 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BWHhW1MmJz9vCxp;
        Tue, 18 Aug 2020 19:19:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id lB6oREtWwNEA; Tue, 18 Aug 2020 19:19:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BWHhW0c0Jz9vCxg;
        Tue, 18 Aug 2020 19:19:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E37548B7EC;
        Tue, 18 Aug 2020 19:19:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id p-F82a-CvrwP; Tue, 18 Aug 2020 19:19:24 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B237C8B7D7;
        Tue, 18 Aug 2020 19:19:24 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 912D865CF4; Tue, 18 Aug 2020 17:19:24 +0000 (UTC)
Message-Id: <691895bd31fee89a2d8370befd66ad4eff5b63f2.1597770847.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1597770847.git.christophe.leroy@csgroup.eu>
References: <cover.1597770847.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 12/25] powerpc/signal32: Simplify logging in
 handle_rt_signal32()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 18 Aug 2020 17:19:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If something is bad in the frame, there is no point in
knowing which part of the frame exactly is wrong as it
got allocated as a single block.

Always print the root address of the frame in case of
failed user access, just like handle_signal32().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal_32.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index deb729c8b79d..44a46911ff98 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -754,7 +754,6 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 	struct rt_sigframe __user *rt_sf;
 	struct mcontext __user *frame;
 	struct mcontext __user *tm_frame = NULL;
-	void __user *addr;
 	unsigned long newsp = 0;
 	int sigret;
 	unsigned long tramp;
@@ -767,7 +766,6 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 	/* Set up Signal Frame */
 	/* Put a Real Time Context onto stack */
 	rt_sf = get_sigframe(ksig, tsk, sizeof(*rt_sf), 1);
-	addr = rt_sf;
 	if (!access_ok(rt_sf, sizeof(*rt_sf)))
 		goto badframe;
 
@@ -782,7 +780,6 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 
 	/* Save user registers on the stack */
 	frame = &rt_sf->uc.uc_mcontext;
-	addr = frame;
 	if (vdso32_rt_sigtramp && tsk->mm->context.vdso_base) {
 		sigret = 0;
 		tramp = tsk->mm->context.vdso_base + vdso32_rt_sigtramp;
@@ -818,7 +815,6 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 
 	/* create a stack frame for the caller of the handler */
 	newsp = ((unsigned long)rt_sf) - (__SIGNAL_FRAMESIZE + 16);
-	addr = (void __user *)regs->gpr[1];
 	if (put_user(regs->gpr[1], (u32 __user *)newsp))
 		goto badframe;
 
@@ -835,7 +831,7 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 	return 0;
 
 badframe:
-	signal_fault(tsk, regs, "handle_rt_signal32", addr);
+	signal_fault(tsk, regs, "handle_rt_signal32", rt_sf);
 
 	return 1;
 }
-- 
2.25.0

