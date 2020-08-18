Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3EDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E30B320786
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgHRRUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:20:32 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:27247 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728614AbgHRRTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:19:35 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BWHhf34BCz9vCxx;
        Tue, 18 Aug 2020 19:19:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id RF92PzeOvD8m; Tue, 18 Aug 2020 19:19:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BWHhf2DZ1z9vCxg;
        Tue, 18 Aug 2020 19:19:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2D7298B7EC;
        Tue, 18 Aug 2020 19:19:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0CYmYbAE1Ec5; Tue, 18 Aug 2020 19:19:32 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E4D318B7D7;
        Tue, 18 Aug 2020 19:19:31 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C2CD665CF4; Tue, 18 Aug 2020 17:19:31 +0000 (UTC)
Message-Id: <f3c36d687e4228f58d5c207a4036aa9ddcc7420a.1597770847.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1597770847.git.christophe.leroy@csgroup.eu>
References: <cover.1597770847.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 19/25] powerpc/signal32: Remove ifdefery in middle of
 if/else
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 18 Aug 2020 17:19:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSR_TM_ACTIVE() is always defined and returns always 0 when
CONFIG_PPC_TRANSACTIONAL_MEM is not selected, so the awful
ifdefery in the middle of an if/else can be removed.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal_32.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 93c2d6304831..310d3b8d9ad5 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -447,6 +447,12 @@ static int save_tm_user_regs(struct pt_regs *regs, struct mcontext __user *frame
 
 	return 0;
 }
+#else
+static int save_tm_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
+			     struct mcontext __user *tm_frame, unsigned long msr)
+{
+	return 0;
+}
 #endif
 
 /*
@@ -732,10 +738,8 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 	unsigned long newsp = 0;
 	unsigned long tramp;
 	struct pt_regs *regs = tsk->thread.regs;
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	/* Save the thread's msr before get_tm_stackpointer() changes it */
 	unsigned long msr = regs->msr;
-#endif
 
 	/* Set up Signal Frame */
 	frame = get_sigframe(ksig, tsk, sizeof(*frame), 1);
@@ -786,14 +790,10 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 	if (tramp == (unsigned long)mctx->mc_pad)
 		flush_icache_range(tramp, tramp + 2 * sizeof(unsigned long));
 
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	if (MSR_TM_ACTIVE(msr)) {
 		if (save_tm_user_regs(regs, mctx, tm_mctx, msr))
 			goto badframe;
-	}
-	else
-#endif
-	{
+	} else {
 		if (save_user_regs(regs, mctx, tm_mctx, 1))
 			goto badframe;
 	}
@@ -842,10 +842,8 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
 	unsigned long newsp = 0;
 	unsigned long tramp;
 	struct pt_regs *regs = tsk->thread.regs;
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	/* Save the thread's msr before get_tm_stackpointer() changes it */
 	unsigned long msr = regs->msr;
-#endif
 
 	/* Set up Signal Frame */
 	frame = get_sigframe(ksig, tsk, sizeof(*frame), 1);
@@ -883,14 +881,10 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
 	if (tramp == (unsigned long)mctx->mc_pad)
 		flush_icache_range(tramp, tramp + 2 * sizeof(unsigned long));
 
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	if (MSR_TM_ACTIVE(msr)) {
 		if (save_tm_user_regs(regs, mctx, tm_mctx, msr))
 			goto badframe;
-	}
-	else
-#endif
-	{
+	} else {
 		if (save_user_regs(regs, mctx, tm_mctx, 1))
 			goto badframe;
 	}
-- 
2.25.0

