Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F3AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 06:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB99320708
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 06:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgHNGyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 02:54:53 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:22476 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbgHNGyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 02:54:53 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BSZ1j1yYnz9vCyN;
        Fri, 14 Aug 2020 08:54:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id qGKPnju1W714; Fri, 14 Aug 2020 08:54:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BSZ1j0Zcfz9vCyL;
        Fri, 14 Aug 2020 08:54:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 107E78B775;
        Fri, 14 Aug 2020 08:54:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id hUoAsqHWv_6E; Fri, 14 Aug 2020 08:54:49 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C09D08B767;
        Fri, 14 Aug 2020 08:54:49 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 9A99E65C93; Fri, 14 Aug 2020 06:54:49 +0000 (UTC)
Message-Id: <c2d2b8dfb8dd677026b26dffc8d31070c38a6b89.1597388079.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2] powerpc: Drop _nmask_and_or_msr()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 14 Aug 2020 06:54:49 +0000 (UTC)
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
v2: Removed the prototype in asm/processor.h
---
 arch/powerpc/include/asm/processor.h              |  1 -
 arch/powerpc/kernel/misc_32.S                     | 13 -------------
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |  3 ++-
 arch/powerpc/platforms/embedded6xx/storcenter.c   |  3 ++-
 4 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index ed0d633ab5aa..5f6b3ee84dd1 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -441,7 +441,6 @@ extern void poweroff_now(void);
 extern int fix_alignment(struct pt_regs *);
 extern void cvt_fd(float *from, double *to);
 extern void cvt_df(double *from, float *to);
-extern void _nmask_and_or_msr(unsigned long nmask, unsigned long or_val);
 
 #ifdef CONFIG_PPC64
 /*
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

