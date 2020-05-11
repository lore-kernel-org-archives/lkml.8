Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71437C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44050208DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbgEKL1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:27:06 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:43614 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729843AbgEKL0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:26:00 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49LJXJ5fY1z9ty3j;
        Mon, 11 May 2020 13:25:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id zOU4zQHjH2f6; Mon, 11 May 2020 13:25:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49LJXJ4ZWrz9ty3g;
        Mon, 11 May 2020 13:25:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 58F868B7AE;
        Mon, 11 May 2020 13:25:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id vlB-OeLuW3fz; Mon, 11 May 2020 13:25:59 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 18A998B7AD;
        Mon, 11 May 2020 13:25:59 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id EE97365A09; Mon, 11 May 2020 11:25:58 +0000 (UTC)
Message-Id: <1f0eef3990ebb4e8216a711da8fd695086179179.1589196133.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1589196133.git.christophe.leroy@csgroup.eu>
References: <cover.1589196133.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 32/45] powerpc/8xx: Always pin TLBs at startup.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 11 May 2020 11:25:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At startup, map 32 Mbytes of memory through 4 pages of 8M,
and PIN them inconditionnaly. They need to be pinned because
KASAN is using page tables early and the TLBs might be
dynamically replaced otherwise.

Remove RSV4I flag after installing mappings unless
CONFIG_PIN_TLB_XXXX is selected.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_8xx.S | 31 +++++++++++++++++--------------
 arch/powerpc/mm/nohash/8xx.c   | 19 +------------------
 2 files changed, 18 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index d607f4b53e0f..b0cceee6405c 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -765,6 +765,14 @@ start_here:
 	mtspr	SPRN_MD_RPN, r0
 	lis	r0, (MD_TWAM | MD_RSV4I)@h
 	mtspr	SPRN_MD_CTR, r0
+#endif
+#ifndef CONFIG_PIN_TLB_TEXT
+	li	r0, 0
+	mtspr	SPRN_MI_CTR, r0
+#endif
+#if !defined(CONFIG_PIN_TLB_DATA) && !defined(CONFIG_PIN_TLB_IMMR)
+	lis	r0, MD_TWAM@h
+	mtspr	SPRN_MD_CTR, r0
 #endif
 	tlbia			/* Clear all TLB entries */
 	sync			/* wait for tlbia/tlbie to finish */
@@ -802,10 +810,6 @@ initial_mmu:
 	mtspr	SPRN_MD_CTR, r10	/* remove PINNED DTLB entries */
 
 	tlbia			/* Invalidate all TLB entries */
-#ifdef CONFIG_PIN_TLB_DATA
-	oris	r10, r10, MD_RSV4I@h
-	mtspr	SPRN_MD_CTR, r10	/* Set data TLB control */
-#endif
 
 	lis	r8, MI_APG_INIT@h	/* Set protection modes */
 	ori	r8, r8, MI_APG_INIT@l
@@ -814,33 +818,32 @@ initial_mmu:
 	ori	r8, r8, MD_APG_INIT@l
 	mtspr	SPRN_MD_AP, r8
 
-	/* Now map the lower RAM (up to 32 Mbytes) into the ITLB. */
-#ifdef CONFIG_PIN_TLB_TEXT
+	/* Map the lower RAM (up to 32 Mbytes) into the ITLB and DTLB */
 	lis	r8, MI_RSV4I@h
 	ori	r8, r8, 0x1c00
-#endif
+	oris	r12, r10, MD_RSV4I@h
+	ori	r12, r12, 0x1c00
 	li	r9, 4				/* up to 4 pages of 8M */
 	mtctr	r9
 	lis	r9, KERNELBASE@h		/* Create vaddr for TLB */
 	li	r10, MI_PS8MEG | MI_SVALID	/* Set 8M byte page */
 	li	r11, MI_BOOTINIT		/* Create RPN for address 0 */
-	lis	r12, _einittext@h
-	ori	r12, r12, _einittext@l
 1:
-#ifdef CONFIG_PIN_TLB_TEXT
 	mtspr	SPRN_MI_CTR, r8	/* Set instruction MMU control */
 	addi	r8, r8, 0x100
-#endif
-
 	ori	r0, r9, MI_EVALID		/* Mark it valid */
 	mtspr	SPRN_MI_EPN, r0
 	mtspr	SPRN_MI_TWC, r10
 	mtspr	SPRN_MI_RPN, r11		/* Store TLB entry */
+	mtspr	SPRN_MD_CTR, r12
+	addi	r12, r12, 0x100
+	mtspr	SPRN_MD_EPN, r0
+	mtspr	SPRN_MD_TWC, r10
+	mtspr	SPRN_MD_RPN, r11
 	addis	r9, r9, 0x80
 	addis	r11, r11, 0x80
 
-	cmpl	cr0, r9, r12
-	bdnzf	gt, 1b
+	bdnz	1b
 
 	/* Since the cache is enabled according to the information we
 	 * just loaded into the TLB, invalidate and enable the caches here.
diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
index d54d395c3378..43578a8a8cad 100644
--- a/arch/powerpc/mm/nohash/8xx.c
+++ b/arch/powerpc/mm/nohash/8xx.c
@@ -61,23 +61,6 @@ unsigned long p_block_mapped(phys_addr_t pa)
  */
 void __init MMU_init_hw(void)
 {
-	/* PIN up to the 3 first 8Mb after IMMR in DTLB table */
-	if (IS_ENABLED(CONFIG_PIN_TLB_DATA)) {
-		unsigned long ctr = mfspr(SPRN_MD_CTR) & 0xfe000000;
-		unsigned long flags = 0xf0 | MD_SPS16K | _PAGE_SH | _PAGE_DIRTY;
-		int i = 28;
-		unsigned long addr = 0;
-		unsigned long mem = total_lowmem;
-
-		for (; i < 32 && mem >= LARGE_PAGE_SIZE_8M; i++) {
-			mtspr(SPRN_MD_CTR, ctr | (i << 8));
-			mtspr(SPRN_MD_EPN, (unsigned long)__va(addr) | MD_EVALID);
-			mtspr(SPRN_MD_TWC, MD_PS8MEG | MD_SVALID);
-			mtspr(SPRN_MD_RPN, addr | flags | _PAGE_PRESENT);
-			addr += LARGE_PAGE_SIZE_8M;
-			mem -= LARGE_PAGE_SIZE_8M;
-		}
-	}
 }
 
 static bool immr_is_mapped __initdata;
@@ -225,7 +208,7 @@ void __init setup_initial_memory_limit(phys_addr_t first_memblock_base,
 	BUG_ON(first_memblock_base != 0);
 
 	/* 8xx can only access 32MB at the moment */
-	memblock_set_current_limit(min_t(u64, first_memblock_size, 0x02000000));
+	memblock_set_current_limit(min_t(u64, first_memblock_size, SZ_32M));
 }
 
 /*
-- 
2.25.0

