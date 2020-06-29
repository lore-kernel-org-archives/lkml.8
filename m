Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA317C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A06FA20656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbgF2Svb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:51:31 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:42396 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727986AbgF2SvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:51:00 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49wPzW0x6Rz9tyrM;
        Mon, 29 Jun 2020 13:15:19 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id cKlGC0OSkxdq; Mon, 29 Jun 2020 13:15:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49wPzV70Lcz9tyqw;
        Mon, 29 Jun 2020 13:15:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 42A3D8B7A0;
        Mon, 29 Jun 2020 13:15:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id xebvCT7XwNct; Mon, 29 Jun 2020 13:15:25 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.105])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 00C338B799;
        Mon, 29 Jun 2020 13:15:24 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 0000565B29; Mon, 29 Jun 2020 11:15:24 +0000 (UTC)
Message-Id: <893425e32cd0a003539573b2d115e0ffa98bc26c.1593428200.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1593428200.git.christophe.leroy@csgroup.eu>
References: <cover.1593428200.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 5/6] powerpc/32s: Kernel space starts at TASK_SIZE
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 29 Jun 2020 11:15:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel space starts at TASK_SIZE. Select kernel page table
when address is over TASK_SIZE.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_32.S       | 12 ++++++------
 arch/powerpc/mm/book3s32/hash_low.S |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 705c042309d8..bbef6ce8322b 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -474,7 +474,7 @@ InstructionTLBMiss:
 	/* Get PTE (linux-style) and check access */
 	mfspr	r3,SPRN_IMISS
 #if defined(CONFIG_MODULES) || defined(CONFIG_DEBUG_PAGEALLOC)
-	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
+	lis	r1, TASK_SIZE@h		/* check if kernel address */
 	cmplw	0,r1,r3
 #endif
 	mfspr	r2, SPRN_SPRG_PGDIR
@@ -484,7 +484,7 @@ InstructionTLBMiss:
 	li	r1,_PAGE_PRESENT | _PAGE_EXEC
 #endif
 #if defined(CONFIG_MODULES) || defined(CONFIG_DEBUG_PAGEALLOC)
-	bge-	112f
+	bgt-	112f
 	lis	r2, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
 	addi	r2, r2, (swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
 #endif
@@ -541,7 +541,7 @@ DataLoadTLBMiss:
  */
 	/* Get PTE (linux-style) and check access */
 	mfspr	r3,SPRN_DMISS
-	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
+	lis	r1, TASK_SIZE@h		/* check if kernel address */
 	cmplw	0,r1,r3
 	mfspr	r2, SPRN_SPRG_PGDIR
 #ifdef CONFIG_SWAP
@@ -549,7 +549,7 @@ DataLoadTLBMiss:
 #else
 	li	r1, _PAGE_PRESENT
 #endif
-	bge-	112f
+	bgt-	112f
 	lis	r2, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
 	addi	r2, r2, (swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
 112:	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
@@ -621,7 +621,7 @@ DataStoreTLBMiss:
  */
 	/* Get PTE (linux-style) and check access */
 	mfspr	r3,SPRN_DMISS
-	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
+	lis	r1, TASK_SIZE@h		/* check if kernel address */
 	cmplw	0,r1,r3
 	mfspr	r2, SPRN_SPRG_PGDIR
 #ifdef CONFIG_SWAP
@@ -629,7 +629,7 @@ DataStoreTLBMiss:
 #else
 	li	r1, _PAGE_RW | _PAGE_DIRTY | _PAGE_PRESENT
 #endif
-	bge-	112f
+	bgt-	112f
 	lis	r2, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
 	addi	r2, r2, (swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
 112:	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
diff --git a/arch/powerpc/mm/book3s32/hash_low.S b/arch/powerpc/mm/book3s32/hash_low.S
index 923ad8f374eb..1690d369688b 100644
--- a/arch/powerpc/mm/book3s32/hash_low.S
+++ b/arch/powerpc/mm/book3s32/hash_low.S
@@ -62,7 +62,7 @@ _GLOBAL(hash_page)
 	isync
 #endif
 	/* Get PTE (linux-style) and check access */
-	lis	r0,KERNELBASE@h		/* check if kernel address */
+	lis	r0, TASK_SIZE@h		/* check if kernel address */
 	cmplw	0,r4,r0
 	ori	r3,r3,_PAGE_USER|_PAGE_PRESENT /* test low addresses as user */
 	mfspr	r5, SPRN_SPRG_PGDIR	/* phys page-table root */
-- 
2.25.0

