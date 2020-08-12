Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0DDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F1B620838
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgHLMHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:07:37 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:32312 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbgHLMF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:05:57 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BRT1Y5Cg6zB09ZV;
        Wed, 12 Aug 2020 14:05:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id VB1jfKqmJQO8; Wed, 12 Aug 2020 14:05:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BRT1Y4JJ7zB09ZQ;
        Wed, 12 Aug 2020 14:05:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E57E08B826;
        Wed, 12 Aug 2020 14:05:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id MxtnbaLnGTzM; Wed, 12 Aug 2020 14:05:54 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AECB08B7FC;
        Wed, 12 Aug 2020 14:05:54 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 907A365C34; Wed, 12 Aug 2020 12:05:54 +0000 (UTC)
Message-Id: <17430b14a0b2a9da8fc24dfaeca79aec0180df5c.1597233555.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1597233555.git.christophe.leroy@csgroup.eu>
References: <cover.1597233555.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 03/19] powerpc/ptrace: Consolidate reg index
 calculation
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ldv@altlinux.org,
        viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 12 Aug 2020 12:05:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today we have:

	#ifdef CONFIG_PPC32
		index = addr >> 2;
		if ((addr & 3) || child->thread.regs == NULL)
	#else
		index = addr >> 3;
		if ((addr & 7))
	#endif

sizeof(long) has value 4 for PPC32 and value 8 for PPC64.

Dividing by 4 is equivalent to >> 2 and dividing by 8 is equivalent
to >> 3.

And 3 and 7 are respectively (sizeof(long) - 1).

Use sizeof(long) to get rid of the #ifdef CONFIG_PPC32 and consolidate
the calculation and checking.

thread.regs have to be not NULL on both PPC32 and PPC64 so adding
that test on PPC64 is harmless.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/ptrace/ptrace.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
index f6e51be47c6e..0b4645a7a1b4 100644
--- a/arch/powerpc/kernel/ptrace/ptrace.c
+++ b/arch/powerpc/kernel/ptrace/ptrace.c
@@ -55,14 +55,8 @@ long arch_ptrace(struct task_struct *child, long request,
 
 		ret = -EIO;
 		/* convert to index and check */
-#ifdef CONFIG_PPC32
-		index = addr >> 2;
-		if ((addr & 3) || (index > PT_FPSCR)
-		    || (child->thread.regs == NULL))
-#else
-		index = addr >> 3;
-		if ((addr & 7) || (index > PT_FPSCR))
-#endif
+		index = addr / sizeof(long);
+		if ((addr & (sizeof(long) - 1)) || (index > PT_FPSCR) || !child->thread.regs)
 			break;
 
 		CHECK_FULL_REGS(child->thread.regs);
@@ -90,14 +84,8 @@ long arch_ptrace(struct task_struct *child, long request,
 
 		ret = -EIO;
 		/* convert to index and check */
-#ifdef CONFIG_PPC32
-		index = addr >> 2;
-		if ((addr & 3) || (index > PT_FPSCR)
-		    || (child->thread.regs == NULL))
-#else
-		index = addr >> 3;
-		if ((addr & 7) || (index > PT_FPSCR))
-#endif
+		index = addr / sizeof(long);
+		if ((addr & (sizeof(long) - 1)) || (index > PT_FPSCR) || !child->thread.regs)
 			break;
 
 		CHECK_FULL_REGS(child->thread.regs);
-- 
2.25.0

