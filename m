Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2BCC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF97920791
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgHMKMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 06:12:06 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:5227 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgHMKMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 06:12:03 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BS2Rg4pnkz9vD3m;
        Thu, 13 Aug 2020 12:11:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id XtOu-NNTzoQR; Thu, 13 Aug 2020 12:11:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BS2Rg2Nx9z9vD3l;
        Thu, 13 Aug 2020 12:11:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9D9538B783;
        Thu, 13 Aug 2020 12:12:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id gJ2HvN7P3JkR; Thu, 13 Aug 2020 12:12:00 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.104])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5146C8B78A;
        Thu, 13 Aug 2020 12:12:00 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 1E9E865C54; Thu, 13 Aug 2020 10:12:00 +0000 (UTC)
Message-Id: <11a330af231af22874c006302a945388846f8112.1597313510.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 1/5] powerpc: Remove flush_instruction_cache for book3s/32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 13 Aug 2020 10:12:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only callers of flush_instruction_cache() are:

arch/powerpc/kernel/swsusp_booke.S:	bl flush_instruction_cache
arch/powerpc/mm/nohash/40x.c:	flush_instruction_cache();
arch/powerpc/mm/nohash/44x.c:	flush_instruction_cache();
arch/powerpc/mm/nohash/fsl_booke.c:	flush_instruction_cache();
arch/powerpc/platforms/44x/machine_check.c:			flush_instruction_cache();
arch/powerpc/platforms/44x/machine_check.c:		flush_instruction_cache();

This function is not used by book3s/32, drop it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/misc_32.S | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index b24f866fef81..bd870743c06f 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -271,9 +271,8 @@ _ASM_NOKPROBE_SYMBOL(real_writeb)
 
 /*
  * Flush instruction cache.
- * This is a no-op on the 601.
  */
-#ifndef CONFIG_PPC_8xx
+#if !defined(CONFIG_PPC_8xx) && !defined(CONFIG_PPC_BOOK3S_32)
 _GLOBAL(flush_instruction_cache)
 #if defined(CONFIG_4xx)
 	lis	r3, KERNELBASE@h
@@ -290,18 +289,11 @@ _GLOBAL(flush_instruction_cache)
 	mfspr	r3,SPRN_L1CSR1
 	ori	r3,r3,L1CSR1_ICFI|L1CSR1_ICLFR
 	mtspr	SPRN_L1CSR1,r3
-#elif defined(CONFIG_PPC_BOOK3S_601)
-	blr			/* for 601, do nothing */
-#else
-	/* 603/604 processor - use invalidate-all bit in HID0 */
-	mfspr	r3,SPRN_HID0
-	ori	r3,r3,HID0_ICFI
-	mtspr	SPRN_HID0,r3
 #endif /* CONFIG_4xx */
 	isync
 	blr
 EXPORT_SYMBOL(flush_instruction_cache)
-#endif /* CONFIG_PPC_8xx */
+#endif /* CONFIG_PPC_8xx || CONFIG_PPC_BOOK3S_32 */
 
 /*
  * Copy a whole page.  We use the dcbz instruction on the destination
-- 
2.25.0

