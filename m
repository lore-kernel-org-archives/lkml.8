Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A19C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D27B12173E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgHFTvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:51:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:64329 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgHFTvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:51:07 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BMndF4Cq3zB09ZQ;
        Thu,  6 Aug 2020 14:20:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id viDHCb0dqpmM; Thu,  6 Aug 2020 14:20:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BMndF3FnXzB09ZL;
        Thu,  6 Aug 2020 14:20:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3A0C88B80D;
        Thu,  6 Aug 2020 14:20:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id eafrqRz1HQM5; Thu,  6 Aug 2020 14:20:35 +0200 (CEST)
Received: from po16052vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.102])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D6ACF8B7FC;
        Thu,  6 Aug 2020 14:20:34 +0200 (CEST)
Received: by po16052vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C00ED65BEB; Thu,  6 Aug 2020 12:20:34 +0000 (UTC)
Message-Id: <d5641ada199b8dd2af16ad00a66084cf974f2704.1596716418.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 1/2] powerpc/fpu: Drop cvt_fd() and cvt_df()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  6 Aug 2020 12:20:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those two functions have been unused since commit identified below.
Drop them.

Fixes: 31bfdb036f12 ("powerpc: Use instruction emulation infrastructure to handle alignment faults")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/processor.h |  2 --
 arch/powerpc/kernel/fpu.S            | 15 ---------------
 2 files changed, 17 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 5c20b6d509ae..9ebcb2f095db 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -425,8 +425,6 @@ extern void flush_instruction_cache(void);
 extern void hard_reset_now(void);
 extern void poweroff_now(void);
 extern int fix_alignment(struct pt_regs *);
-extern void cvt_fd(float *from, double *to);
-extern void cvt_df(double *from, float *to);
 extern void _nmask_and_or_msr(unsigned long nmask, unsigned long or_val);
 
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
index 4ae39db70044..825893d4cb59 100644
--- a/arch/powerpc/kernel/fpu.S
+++ b/arch/powerpc/kernel/fpu.S
@@ -134,18 +134,3 @@ _GLOBAL(save_fpu)
 	mffs	fr0
 	stfd	fr0,FPSTATE_FPSCR(r6)
 	blr
-
-/*
- * These are used in the alignment trap handler when emulating
- * single-precision loads and stores.
- */
-
-_GLOBAL(cvt_fd)
-	lfs	0,0(r3)
-	stfd	0,0(r4)
-	blr
-
-_GLOBAL(cvt_df)
-	lfd	0,0(r3)
-	stfs	0,0(r4)
-	blr
-- 
2.25.0

