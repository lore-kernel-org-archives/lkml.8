Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAADC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 05:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E101320829
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 05:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgHNF4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 01:56:32 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:2226 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgHNF4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 01:56:31 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BSXkM4750z9vD37;
        Fri, 14 Aug 2020 07:56:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id lBzcTAIqbjXx; Fri, 14 Aug 2020 07:56:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BSXkM338qz9vD2y;
        Fri, 14 Aug 2020 07:56:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5E3638B775;
        Fri, 14 Aug 2020 07:56:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id LuR78-u6rgOW; Fri, 14 Aug 2020 07:56:28 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2B6288B767;
        Fri, 14 Aug 2020 07:56:28 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C155965C93; Fri, 14 Aug 2020 05:56:27 +0000 (UTC)
Message-Id: <f989eff8296800c427622c0985384148404e4f0b.1597384512.git.christophe.leroy@csgroup.eu>
In-Reply-To: <50098f49877cea0f46730a9df82dcabf84160e4b.1597384512.git.christophe.leroy@csgroup.eu>
References: <50098f49877cea0f46730a9df82dcabf84160e4b.1597384512.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 4/4] powerpc: Rewrite FSL_BOOKE flush_cache_instruction()
 in C
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, hch@infradead.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 14 Aug 2020 05:56:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing prevents flush_cache_instruction() from being writen in C.

Do it to improve readability and maintainability.

This function is only use by low level callers, it is not
intended to be used by module. Don't export it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/misc_32.S      | 22 ----------------------
 arch/powerpc/mm/nohash/fsl_booke.c | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 1bda207459a8..87717966f5cd 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -268,28 +268,6 @@ _ASM_NOKPROBE_SYMBOL(real_writeb)
 
 #endif /* CONFIG_40x */
 
-
-/*
- * Flush instruction cache.
- */
-#ifdef CONFIG_FSL_BOOKE
-_GLOBAL(flush_instruction_cache)
-#ifdef CONFIG_E200
-	mfspr   r3,SPRN_L1CSR0
-	ori     r3,r3,L1CSR0_CFI|L1CSR0_CLFC
-	/* msync; isync recommended here */
-	mtspr   SPRN_L1CSR0,r3
-	isync
-	blr
-#endif
-	mfspr	r3,SPRN_L1CSR1
-	ori	r3,r3,L1CSR1_ICFI|L1CSR1_ICLFR
-	mtspr	SPRN_L1CSR1,r3
-	isync
-	blr
-EXPORT_SYMBOL(flush_instruction_cache)
-#endif
-
 /*
  * Copy a whole page.  We use the dcbz instruction on the destination
  * to reduce memory traffic (it eliminates the unnecessary reads of
diff --git a/arch/powerpc/mm/nohash/fsl_booke.c b/arch/powerpc/mm/nohash/fsl_booke.c
index 0c294827d6e5..36bda962d3b3 100644
--- a/arch/powerpc/mm/nohash/fsl_booke.c
+++ b/arch/powerpc/mm/nohash/fsl_booke.c
@@ -219,6 +219,22 @@ unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
 	return tlbcam_addrs[tlbcam_index - 1].limit - PAGE_OFFSET + 1;
 }
 
+void flush_instruction_cache(void)
+{
+	unsigned long tmp;
+
+	if (IS_ENABLED(CONFIG_E200)) {
+		tmp = mfspr(SPRN_L1CSR0);
+		tmp |= L1CSR0_CFI | L1CSR0_CLFC;
+		mtspr(SPRN_L1CSR0, tmp);
+	} else {
+		tmp = mfspr(SPRN_L1CSR1);
+		tmp |= L1CSR1_ICFI | L1CSR1_ICLFR;
+		mtspr(SPRN_L1CSR1, tmp);
+	}
+	isync();
+}
+
 /*
  * MMU_init_hw does the chip-specific initialization of the MMU hardware.
  */
-- 
2.25.0

