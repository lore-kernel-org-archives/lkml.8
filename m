Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BB4C55186
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 08:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B7882071E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 08:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="wLD5NgQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgDYIn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 04:43:58 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:65258 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbgDYIno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 04:43:44 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 498PhX4fb7z9txnZ;
        Sat, 25 Apr 2020 10:43:40 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=wLD5NgQE; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 24IeR9HxEFg4; Sat, 25 Apr 2020 10:43:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 498PhX3Zvqz9txnG;
        Sat, 25 Apr 2020 10:43:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1587804220; bh=RUmmSE4SKMielW2ISC19QNrNt3/ueQMF3PWOzmpD06c=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=wLD5NgQEU364Oq0Dsh5gyNoJ/h9Px2P6c/GvG3aevhNNgmq2OXNuRRsrxJHjhIjD5
         Bx7BlbweuoMowx2d9TqJX0D3e99+O8TOipNQ2tOlwPqZ2O4GaIfQGpYmTVfpqs63jC
         G89KicXPTB+i72LZn163n5lDO2YxPQ2+vcjrKxPA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 943F28B752;
        Sat, 25 Apr 2020 10:43:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id tBwLwApc7pZa; Sat, 25 Apr 2020 10:43:41 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3F0DA8B769;
        Sat, 25 Apr 2020 10:43:41 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id BC4506587B; Sat, 25 Apr 2020 08:43:40 +0000 (UTC)
Message-Id: <3ba810ea8f667b9bd94973537d58c8f91d955f3e.1587804057.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1587804057.git.christophe.leroy@c-s.fr>
References: <cover.1587804057.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 12/13] powerpc/40x: Avoid using r12 in TLB miss handlers
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, michal.simek@xilinx.com,
        arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sat, 25 Apr 2020 08:43:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's reduce the number of registers used in TLB miss handlers.

We have both r9 and r12 available for any temporary use.

r9 is enough, avoid using r12.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_40x.S | 70 ++++++++++++++++------------------
 1 file changed, 33 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index afa93a36437b..804cbd0899ac 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -254,9 +254,9 @@ _ENTRY(saved_ksp_limit)
 	mtspr	SPRN_SPRG_SCRATCH3, r12
 	mtspr	SPRN_SPRG_SCRATCH4, r9
 	mfcr	r11
-	mfspr	r12, SPRN_PID
+	mfspr	r9, SPRN_PID
 	mtspr	SPRN_SPRG_SCRATCH6, r11
-	mtspr	SPRN_SPRG_SCRATCH5, r12
+	mtspr	SPRN_SPRG_SCRATCH5, r9
 	mfspr	r10, SPRN_DEAR		/* Get faulting address */
 
 	/* If we are faulting a kernel address, we have to use the
@@ -279,12 +279,12 @@ _ENTRY(saved_ksp_limit)
 4:
 	tophys(r11, r11)
 	rlwimi	r11, r10, 12, 20, 29	/* Create L1 (pgdir/pmd) address */
-	lwz	r12, 0(r11)		/* Get L1 entry */
-	andi.	r9, r12, _PMD_PRESENT	/* Check if it points to a PTE page */
+	lwz	r11, 0(r11)		/* Get L1 entry */
+	andi.	r9, r11, _PMD_PRESENT	/* Check if it points to a PTE page */
 	beq	2f			/* Bail if no table */
 
-	rlwimi	r12, r10, 22, 20, 29	/* Compute PTE address */
-	lwz	r11, 0(r12)		/* Get Linux PTE */
+	rlwimi	r11, r10, 22, 20, 29	/* Compute PTE address */
+	lwz	r11, 0(r11)		/* Get Linux PTE */
 #ifdef CONFIG_SWAP
 	li	r9, _PAGE_PRESENT | _PAGE_ACCESSED
 #else
@@ -300,13 +300,13 @@ _ENTRY(saved_ksp_limit)
 	/* Create TLB tag.  This is the faulting address plus a static
 	 * set of bits.  These are size, valid, E, U0.
 	*/
-	li	r12, 0x00c0
-	rlwimi	r10, r12, 0, 20, 31
+	li	r9, 0x00c0
+	rlwimi	r10, r9, 0, 20, 31
 
 	b	finish_tlb_load
 
 2:	/* Check for possible large-page pmd entry */
-	rlwinm.	r9, r12, 2, 22, 24
+	rlwinm.	r9, r11, 2, 22, 24
 	beq	5f
 
 	/* Create TLB tag.  This is the faulting address, plus a static
@@ -314,7 +314,6 @@ _ENTRY(saved_ksp_limit)
 	 */
 	ori	r9, r9, 0x40
 	rlwimi	r10, r9, 0, 20, 31
-	mr	r11, r12
 
 	b	finish_tlb_load
 
@@ -322,9 +321,9 @@ _ENTRY(saved_ksp_limit)
 	/* The bailout.  Restore registers to pre-exception conditions
 	 * and call the heavyweights to help us out.
 	 */
-	mfspr	r12, SPRN_SPRG_SCRATCH5
+	mfspr	r9, SPRN_SPRG_SCRATCH5
 	mfspr	r11, SPRN_SPRG_SCRATCH6
-	mtspr	SPRN_PID, r12
+	mtspr	SPRN_PID, r9
 	mtcr	r11
 	mfspr	r9, SPRN_SPRG_SCRATCH4
 	mfspr	r12, SPRN_SPRG_SCRATCH3
@@ -342,9 +341,9 @@ _ENTRY(saved_ksp_limit)
 	mtspr	SPRN_SPRG_SCRATCH3, r12
 	mtspr	SPRN_SPRG_SCRATCH4, r9
 	mfcr	r11
-	mfspr	r12, SPRN_PID
+	mfspr	r9, SPRN_PID
 	mtspr	SPRN_SPRG_SCRATCH6, r11
-	mtspr	SPRN_SPRG_SCRATCH5, r12
+	mtspr	SPRN_SPRG_SCRATCH5, r9
 	mfspr	r10, SPRN_SRR0		/* Get faulting address */
 
 	/* If we are faulting a kernel address, we have to use the
@@ -367,12 +366,12 @@ _ENTRY(saved_ksp_limit)
 4:
 	tophys(r11, r11)
 	rlwimi	r11, r10, 12, 20, 29	/* Create L1 (pgdir/pmd) address */
-	lwz	r12, 0(r11)		/* Get L1 entry */
-	andi.	r9, r12, _PMD_PRESENT	/* Check if it points to a PTE page */
+	lwz	r11, 0(r11)		/* Get L1 entry */
+	andi.	r9, r11, _PMD_PRESENT	/* Check if it points to a PTE page */
 	beq	2f			/* Bail if no table */
 
-	rlwimi	r12, r10, 22, 20, 29	/* Compute PTE address */
-	lwz	r11, 0(r12)		/* Get Linux PTE */
+	rlwimi	r11, r10, 22, 20, 29	/* Compute PTE address */
+	lwz	r11, 0(r11)		/* Get Linux PTE */
 #ifdef CONFIG_SWAP
 	li	r9, _PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_EXEC
 #else
@@ -388,13 +387,13 @@ _ENTRY(saved_ksp_limit)
 	/* Create TLB tag.  This is the faulting address plus a static
 	 * set of bits.  These are size, valid, E, U0.
 	*/
-	li	r12, 0x00c0
-	rlwimi	r10, r12, 0, 20, 31
+	li	r9, 0x00c0
+	rlwimi	r10, r9, 0, 20, 31
 
 	b	finish_tlb_load
 
 2:	/* Check for possible large-page pmd entry */
-	rlwinm.	r9, r12, 2, 22, 24
+	rlwinm.	r9, r11, 2, 22, 24
 	beq	5f
 
 	/* Create TLB tag.  This is the faulting address, plus a static
@@ -402,7 +401,6 @@ _ENTRY(saved_ksp_limit)
 	 */
 	ori	r9, r9, 0x40
 	rlwimi	r10, r9, 0, 20, 31
-	mr	r11, r12
 
 	b	finish_tlb_load
 
@@ -410,9 +408,9 @@ _ENTRY(saved_ksp_limit)
 	/* The bailout.  Restore registers to pre-exception conditions
 	 * and call the heavyweights to help us out.
 	 */
-	mfspr	r12, SPRN_SPRG_SCRATCH5
+	mfspr	r9, SPRN_SPRG_SCRATCH5
 	mfspr	r11, SPRN_SPRG_SCRATCH6
-	mtspr	SPRN_PID, r12
+	mtspr	SPRN_PID, r9
 	mtcr	r11
 	mfspr	r9, SPRN_SPRG_SCRATCH4
 	mfspr	r12, SPRN_SPRG_SCRATCH3
@@ -528,7 +526,7 @@ WDTException:
 	 * miss get to this point to load the TLB.
 	 * 	r10 - TLB_TAG value
 	 * 	r11 - Linux PTE
-	 *	r12, r9 - available to use
+	 *	r9 - available to use
 	 *	PID - loaded with proper value when we get here
 	 *	Upon exit, we reload everything and RFI.
 	 * Actually, it will fit now, but oh well.....a common place
@@ -537,30 +535,28 @@ WDTException:
 tlb_4xx_index:
 	.long	0
 finish_tlb_load:
-	/* load the next available TLB index.
-	*/
-	lwz	r9, tlb_4xx_index@l(0)
-	addi	r9, r9, 1
-	andi.	r9, r9, (PPC40X_TLB_SIZE-1)
-	stw	r9, tlb_4xx_index@l(0)
-
-6:
 	/*
 	 * Clear out the software-only bits in the PTE to generate the
 	 * TLB_DATA value.  These are the bottom 2 bits of the RPM, the
 	 * top 3 bits of the zone field, and M.
 	 */
-	li	r12, 0x0ce2
-	andc	r11, r11, r12
+	li	r9, 0x0ce2
+	andc	r11, r11, r9
+
+	/* load the next available TLB index. */
+	lwz	r9, tlb_4xx_index@l(0)
+	addi	r9, r9, 1
+	andi.	r9, r9, PPC40X_TLB_SIZE - 1
+	stw	r9, tlb_4xx_index@l(0)
 
 	tlbwe	r11, r9, TLB_DATA		/* Load TLB LO */
 	tlbwe	r10, r9, TLB_TAG		/* Load TLB HI */
 
 	/* Done...restore registers and get out of here.
 	*/
-	mfspr	r12, SPRN_SPRG_SCRATCH5
+	mfspr	r9, SPRN_SPRG_SCRATCH5
 	mfspr	r11, SPRN_SPRG_SCRATCH6
-	mtspr	SPRN_PID, r12
+	mtspr	SPRN_PID, r9
 	mtcr	r11
 	mfspr	r9, SPRN_SPRG_SCRATCH4
 	mfspr	r12, SPRN_SPRG_SCRATCH3
-- 
2.25.0

