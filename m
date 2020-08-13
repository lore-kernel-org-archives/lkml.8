Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC259C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B359420791
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgHMKMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 06:12:06 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:25656 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbgHMKME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 06:12:04 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BS2Rh1xm4z9vD3p;
        Thu, 13 Aug 2020 12:12:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id gfMvwydx9Ufd; Thu, 13 Aug 2020 12:12:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BS2Rh0zcSz9vD3l;
        Thu, 13 Aug 2020 12:12:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 751CB8B78A;
        Thu, 13 Aug 2020 12:12:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 5B7LzUwD8WNI; Thu, 13 Aug 2020 12:12:01 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.104])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 590D18B783;
        Thu, 13 Aug 2020 12:12:01 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2BA6465C54; Thu, 13 Aug 2020 10:12:01 +0000 (UTC)
Message-Id: <60a152dcbea2a2c48b771aca6698efdc14116c0f.1597313510.git.christophe.leroy@csgroup.eu>
In-Reply-To: <11a330af231af22874c006302a945388846f8112.1597313510.git.christophe.leroy@csgroup.eu>
References: <11a330af231af22874c006302a945388846f8112.1597313510.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 2/5] powerpc: Untangle flush_instruction_cache()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 13 Aug 2020 10:12:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

flush_instruction_cache() is a mixup of each PPC32 sub-arch.

Untangle it by making one complete function for each sub-arch.

This makes it a lot more readable and maintainable.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/misc_32.S | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index bd870743c06f..a8f6ef513115 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -272,28 +272,31 @@ _ASM_NOKPROBE_SYMBOL(real_writeb)
 /*
  * Flush instruction cache.
  */
-#if !defined(CONFIG_PPC_8xx) && !defined(CONFIG_PPC_BOOK3S_32)
+#ifdef CONFIG_4xx
 _GLOBAL(flush_instruction_cache)
-#if defined(CONFIG_4xx)
 	lis	r3, KERNELBASE@h
 	iccci	0,r3
-#elif defined(CONFIG_FSL_BOOKE)
+	isync
+	blr
+EXPORT_SYMBOL(flush_instruction_cache)
+#endif
+
+#ifdef CONFIG_FSL_BOOKE
+_GLOBAL(flush_instruction_cache)
 #ifdef CONFIG_E200
 	mfspr   r3,SPRN_L1CSR0
 	ori     r3,r3,L1CSR0_CFI|L1CSR0_CLFC
 	/* msync; isync recommended here */
 	mtspr   SPRN_L1CSR0,r3
-	isync
-	blr
-#endif
+#else
 	mfspr	r3,SPRN_L1CSR1
 	ori	r3,r3,L1CSR1_ICFI|L1CSR1_ICLFR
 	mtspr	SPRN_L1CSR1,r3
-#endif /* CONFIG_4xx */
+#endif
 	isync
 	blr
 EXPORT_SYMBOL(flush_instruction_cache)
-#endif /* CONFIG_PPC_8xx || CONFIG_PPC_BOOK3S_32 */
+#endif
 
 /*
  * Copy a whole page.  We use the dcbz instruction on the destination
-- 
2.25.0

