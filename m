Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F7AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 405952054F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgHQFsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 01:48:02 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:31624 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgHQFr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 01:47:59 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BVNP36Zdkz9tytn;
        Mon, 17 Aug 2020 07:47:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Q31TzKBgDRfA; Mon, 17 Aug 2020 07:47:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BVNP35csXz9tytl;
        Mon, 17 Aug 2020 07:47:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9216E8B772;
        Mon, 17 Aug 2020 07:47:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id szLHl23uqWEw; Mon, 17 Aug 2020 07:47:56 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.104])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6CE298B75B;
        Mon, 17 Aug 2020 07:47:56 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6210965CDD; Mon, 17 Aug 2020 05:47:56 +0000 (UTC)
Message-Id: <03ba6b52344ca7c336df2bc6e3d31d736c804ae2.1597643221.git.christophe.leroy@csgroup.eu>
In-Reply-To: <0eb61cf0dc66d781d47deb2228498cd61d03a754.1597643221.git.christophe.leroy@csgroup.eu>
References: <0eb61cf0dc66d781d47deb2228498cd61d03a754.1597643221.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 2/4] powerpc/process: Remove useless #ifdef CONFIG_ALTIVEC
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 17 Aug 2020 05:47:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_has_feature(CPU_FTR_ALTIVEC) returns false when CONFIG_ALTIVEC is
not set.

There is no need to enclose the test in an #ifdef CONFIG_ALTIVEC.
Remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/process.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index b64d71188715..360415689f8a 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -409,10 +409,8 @@ static int __init init_msr_all_available(void)
 #ifdef CONFIG_PPC_FPU
 	msr_all_available |= MSR_FP;
 #endif
-#ifdef CONFIG_ALTIVEC
 	if (cpu_has_feature(CPU_FTR_ALTIVEC))
 		msr_all_available |= MSR_VEC;
-#endif
 	if (cpu_has_feature(CPU_FTR_VSX))
 		msr_all_available |= MSR_VSX;
 #ifdef CONFIG_SPE
@@ -446,10 +444,8 @@ void giveup_all(struct task_struct *tsk)
 	if (usermsr & MSR_FP)
 		__giveup_fpu(tsk);
 #endif
-#ifdef CONFIG_ALTIVEC
 	if (usermsr & MSR_VEC)
 		__giveup_altivec(tsk);
-#endif
 #ifdef CONFIG_SPE
 	if (usermsr & MSR_SPE)
 		__giveup_spe(tsk);
-- 
2.25.0

