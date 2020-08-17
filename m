Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44806C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B23A214F1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgHQFsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 01:48:04 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:60189 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgHQFsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 01:48:00 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BVNP56qgxz9tytq;
        Mon, 17 Aug 2020 07:47:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Jvk4mRrGdO44; Mon, 17 Aug 2020 07:47:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BVNP55g2kz9tytl;
        Mon, 17 Aug 2020 07:47:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9BD0D8B772;
        Mon, 17 Aug 2020 07:47:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id KHvHLB61Gfem; Mon, 17 Aug 2020 07:47:58 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.104])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7A0768B75B;
        Mon, 17 Aug 2020 07:47:58 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6ED7365CDD; Mon, 17 Aug 2020 05:47:58 +0000 (UTC)
Message-Id: <69c8b7954ceeccc6b849e52e1fa41b3a0f10f6c1.1597643221.git.christophe.leroy@csgroup.eu>
In-Reply-To: <0eb61cf0dc66d781d47deb2228498cd61d03a754.1597643221.git.christophe.leroy@csgroup.eu>
References: <0eb61cf0dc66d781d47deb2228498cd61d03a754.1597643221.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 4/4] powerpc/process: Remove useless #ifdef CONFIG_PPC_FPU
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 17 Aug 2020 05:47:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a stub for __giveup_fpu() when CONFIG_PPC_FPU is
not selected, as done for CONFIG_SPE and CONFIG_ALTIVEC.

This allows to remove some #ifdef CONFIG_PPC_FPU.

Also change one to IS_ENABLED().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/process.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 7090c99a60d9..8133a6ce3242 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -229,6 +229,8 @@ void enable_kernel_fp(void)
 	}
 }
 EXPORT_SYMBOL(enable_kernel_fp);
+#else
+static inline void __giveup_fpu(struct task_struct *tsk) { }
 #endif /* CONFIG_PPC_FPU */
 
 #ifdef CONFIG_ALTIVEC
@@ -406,9 +408,8 @@ static unsigned long msr_all_available;
 
 static int __init init_msr_all_available(void)
 {
-#ifdef CONFIG_PPC_FPU
-	msr_all_available |= MSR_FP;
-#endif
+	if (IS_ENABLED(CONFIG_PPC_FPU))
+		msr_all_available |= MSR_FP;
 	if (cpu_has_feature(CPU_FTR_ALTIVEC))
 		msr_all_available |= MSR_VEC;
 	if (cpu_has_feature(CPU_FTR_VSX))
@@ -438,10 +439,8 @@ void giveup_all(struct task_struct *tsk)
 
 	WARN_ON((usermsr & MSR_VSX) && !((usermsr & MSR_FP) && (usermsr & MSR_VEC)));
 
-#ifdef CONFIG_PPC_FPU
 	if (usermsr & MSR_FP)
 		__giveup_fpu(tsk);
-#endif
 	if (usermsr & MSR_VEC)
 		__giveup_altivec(tsk);
 	if (usermsr & MSR_SPE)
-- 
2.25.0

