Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D09C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 05:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C5BA20708
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 05:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgHNF43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 01:56:29 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:64419 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbgHNF43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 01:56:29 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BSXkL3hHWz9vD35;
        Fri, 14 Aug 2020 07:56:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 39fcw5CulY1A; Fri, 14 Aug 2020 07:56:26 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BSXkL2pDvz9vD2y;
        Fri, 14 Aug 2020 07:56:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 54C328B775;
        Fri, 14 Aug 2020 07:56:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id u7SJ9gmfX6zo; Fri, 14 Aug 2020 07:56:27 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1AD118B767;
        Fri, 14 Aug 2020 07:56:27 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B950565C93; Fri, 14 Aug 2020 05:56:26 +0000 (UTC)
Message-Id: <93d93fc69b4b3ad3ceba2fc0756333c0c0245bb7.1597384512.git.christophe.leroy@csgroup.eu>
In-Reply-To: <50098f49877cea0f46730a9df82dcabf84160e4b.1597384512.git.christophe.leroy@csgroup.eu>
References: <50098f49877cea0f46730a9df82dcabf84160e4b.1597384512.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 3/4] powerpc: Rewrite 4xx flush_cache_instruction() in C
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, hch@infradead.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 14 Aug 2020 05:56:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing prevents flush_cache_instruction() from being writen in C.

Do it to improve readability and maintainability.

This function is very small and isn't called from assembly,
make it static inline in asm/cacheflush.h

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Written as a static inline instead of adding a new C file for this function alone.
---
 arch/powerpc/include/asm/cacheflush.h | 8 ++++++++
 arch/powerpc/kernel/misc_32.S         | 7 +------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
index 481877879fec..138e46d8c04e 100644
--- a/arch/powerpc/include/asm/cacheflush.h
+++ b/arch/powerpc/include/asm/cacheflush.h
@@ -98,7 +98,15 @@ static inline void invalidate_dcache_range(unsigned long start,
 	mb();	/* sync */
 }
 
+#ifdef CONFIG_4xx
+static inline void flush_instruction_cache(void)
+{
+	iccci((void *)KERNELBASE);
+	isync();
+}
+#else
 void flush_instruction_cache(void);
+#endif
 
 #include <asm-generic/cacheflush.h>
 
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 5c074c2ff5b5..1bda207459a8 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -272,12 +272,8 @@ _ASM_NOKPROBE_SYMBOL(real_writeb)
 /*
  * Flush instruction cache.
  */
-#if !defined(CONFIG_PPC_8xx) && !defined(CONFIG_PPC_BOOK3S_32)
+#ifdef CONFIG_FSL_BOOKE
 _GLOBAL(flush_instruction_cache)
-#if defined(CONFIG_4xx)
-	lis	r3, KERNELBASE@h
-	iccci	0,r3
-#elif defined(CONFIG_FSL_BOOKE)
 #ifdef CONFIG_E200
 	mfspr   r3,SPRN_L1CSR0
 	ori     r3,r3,L1CSR0_CFI|L1CSR0_CLFC
@@ -289,7 +285,6 @@ _GLOBAL(flush_instruction_cache)
 	mfspr	r3,SPRN_L1CSR1
 	ori	r3,r3,L1CSR1_ICFI|L1CSR1_ICLFR
 	mtspr	SPRN_L1CSR1,r3
-#endif /* CONFIG_4xx */
 	isync
 	blr
 EXPORT_SYMBOL(flush_instruction_cache)
-- 
2.25.0

