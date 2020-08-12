Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441C9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B6002080C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgHLMGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:06:51 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:19245 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbgHLMGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:06:11 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BRT1q2fXnzB09Zm;
        Wed, 12 Aug 2020 14:06:07 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Cbs9yYywExs1; Wed, 12 Aug 2020 14:06:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BRT1q1s3jzB09Zf;
        Wed, 12 Aug 2020 14:06:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 836C68B826;
        Wed, 12 Aug 2020 14:06:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id zXOsF_Bo41Q5; Wed, 12 Aug 2020 14:06:08 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1AACE8B7FC;
        Wed, 12 Aug 2020 14:06:08 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id F0C5D65C34; Wed, 12 Aug 2020 12:06:07 +0000 (UTC)
Message-Id: <cbba9be0a6a69984b37ba023de38be362fa7bc0d.1597233555.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1597233555.git.christophe.leroy@csgroup.eu>
References: <cover.1597233555.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 16/19] powerpc/signal32: Switch handle_rt_signal32() to
 user_access_begin() logic
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ldv@altlinux.org,
        viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 12 Aug 2020 12:06:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal_32.c | 47 +++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 4ea83578ba9d..d03ba3d8eb68 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -58,8 +58,6 @@
 #define mcontext	mcontext32
 #define ucontext	ucontext32
 
-#define __save_altstack __compat_save_altstack
-
 /*
  * Userspace code may pass a ucontext which doesn't include VSX added
  * at the end.  We need to check for this case.
@@ -797,16 +795,36 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 	/* Set up Signal Frame */
 	/* Put a Real Time Context onto stack */
 	rt_sf = get_sigframe(ksig, tsk, sizeof(*rt_sf), 1);
-	if (!access_ok(rt_sf, sizeof(*rt_sf)))
+	if (!user_write_access_begin(rt_sf, sizeof(*rt_sf)))
 		goto badframe;
 
 	/* Put the siginfo & fill in most of the ucontext */
-	if (copy_siginfo_to_user(&rt_sf->info, &ksig->info)
-	    || __put_user(0, &rt_sf->uc.uc_flags)
-	    || __save_altstack(&rt_sf->uc.uc_stack, regs->gpr[1])
-	    || __put_user(to_user_ptr(&rt_sf->uc.uc_mcontext),
-		    &rt_sf->uc.uc_regs)
-	    || put_sigset_t(&rt_sf->uc.uc_sigmask, oldset))
+	unsafe_put_user(0, &rt_sf->uc.uc_flags, failed);
+#ifdef CONFIG_PPC64
+	unsafe_compat_save_altstack(&rt_sf->uc.uc_stack, regs->gpr[1], failed);
+#else
+	unsafe_save_altstack(&rt_sf->uc.uc_stack, regs->gpr[1], failed);
+#endif
+	unsafe_put_user(to_user_ptr(&rt_sf->uc.uc_mcontext), &rt_sf->uc.uc_regs, failed);
+
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	tm_frame = &rt_sf->uc_transact.uc_mcontext;
+	if (MSR_TM_ACTIVE(msr)) {
+		unsafe_put_user((unsigned long)&rt_sf->uc_transact,
+				&rt_sf->uc.uc_link, failed);
+		unsafe_put_user((unsigned long)tm_frame,
+				&rt_sf->uc_transact.uc_regs, failed);
+	}
+	else
+#endif
+	{
+		unsafe_put_user(0, &rt_sf->uc.uc_link, failed);
+	}
+	user_write_access_end();
+
+	if (put_sigset_t(&rt_sf->uc.uc_sigmask, oldset))
+		goto badframe;
+	if (copy_siginfo_to_user(&rt_sf->info, &ksig->info))
 		goto badframe;
 
 	/* Save user registers on the stack */
@@ -820,21 +838,13 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 	}
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	tm_frame = &rt_sf->uc_transact.uc_mcontext;
 	if (MSR_TM_ACTIVE(msr)) {
-		if (__put_user((unsigned long)&rt_sf->uc_transact,
-			       &rt_sf->uc.uc_link) ||
-		    __put_user((unsigned long)tm_frame,
-			       &rt_sf->uc_transact.uc_regs))
-			goto badframe;
 		if (save_tm_user_regs(regs, frame, tm_frame, sigret, msr))
 			goto badframe;
 	}
 	else
 #endif
 	{
-		if (__put_user(0, &rt_sf->uc.uc_link))
-			goto badframe;
 		if (save_user_regs(regs, frame, tm_frame, sigret, 1))
 			goto badframe;
 	}
@@ -861,6 +871,9 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 	regs->msr |= (MSR_KERNEL & MSR_LE);
 	return 0;
 
+failed:
+	user_write_access_end();
+
 badframe:
 	signal_fault(tsk, regs, "handle_rt_signal32", rt_sf);
 
-- 
2.25.0

