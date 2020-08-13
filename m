Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6CAC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03BDA20781
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgHMKHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 06:07:07 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:34358 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgHMKHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 06:07:07 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BS2Kz4fXdz9vD3l;
        Thu, 13 Aug 2020 12:07:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id mnuPzuFrF4Xy; Thu, 13 Aug 2020 12:07:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BS2Kz33Syz9vD3k;
        Thu, 13 Aug 2020 12:07:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B27D78B783;
        Thu, 13 Aug 2020 12:07:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id zRQx4L-iWWFF; Thu, 13 Aug 2020 12:07:04 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.104])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6F1D28B78A;
        Thu, 13 Aug 2020 12:07:04 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 242C865C54; Thu, 13 Aug 2020 10:07:04 +0000 (UTC)
Message-Id: <62e7a70f38c5c17c7d0eb5daf3656e346b01aa8b.1597313191.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc: Drop _nmask_and_or_msr()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 13 Aug 2020 10:07:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_nmask_and_or_msr() is only used at two places to set MSR_IP.

The SYNC is unnecessary as the users are not PowerPC 601.

Can be easily writen in C.

Do it, and drop _nmask_and_or_msr()

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/misc_32.S                     | 13 -------------
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |  3 ++-
 arch/powerpc/platforms/embedded6xx/storcenter.c   |  3 ++-
 3 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index b24f866fef81..8d9cb5df580e 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -215,19 +215,6 @@ _GLOBAL(low_choose_7447a_dfs)
 
 #endif /* CONFIG_CPU_FREQ_PMAC && CONFIG_PPC_BOOK3S_32 */
 
-/*
- * complement mask on the msr then "or" some values on.
- *     _nmask_and_or_msr(nmask, value_to_or)
- */
-_GLOBAL(_nmask_and_or_msr)
-	mfmsr	r0		/* Get current msr */
-	andc	r0,r0,r3	/* And off the bits set in r3 (first parm) */
-	or	r0,r0,r4	/* Or on the bits in r4 (second parm) */
-	SYNC			/* Some chip revs have problems here... */
-	mtmsr	r0		/* Update machine state */
-	isync
-	blr			/* Done */
-
 #ifdef CONFIG_40x
 
 /*
diff --git a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
index 15437abe1f6d..b95c3380d2b5 100644
--- a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -147,7 +147,8 @@ static void __noreturn mpc7448_hpc2_restart(char *cmd)
 	local_irq_disable();
 
 	/* Set exception prefix high - to the firmware */
-	_nmask_and_or_msr(0, MSR_IP);
+	mtmsr(mfmsr() | MSR_IP);
+	isync();
 
 	for (;;) ;		/* Spin until reset happens */
 }
diff --git a/arch/powerpc/platforms/embedded6xx/storcenter.c b/arch/powerpc/platforms/embedded6xx/storcenter.c
index ed1914dd34bb..e346ddcef45e 100644
--- a/arch/powerpc/platforms/embedded6xx/storcenter.c
+++ b/arch/powerpc/platforms/embedded6xx/storcenter.c
@@ -101,7 +101,8 @@ static void __noreturn storcenter_restart(char *cmd)
 	local_irq_disable();
 
 	/* Set exception prefix high - to the firmware */
-	_nmask_and_or_msr(0, MSR_IP);
+	mtmsr(mfmsr() | MSR_IP);
+	isync();
 
 	/* Wait for reset to happen */
 	for (;;) ;
-- 
2.25.0

