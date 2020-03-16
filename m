Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C9DC2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B016205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="XuIEimow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbgCPMhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:37:23 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:5721 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731217AbgCPMgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:36:19 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48gwlJ3Hvsz9v02l;
        Mon, 16 Mar 2020 13:36:12 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=XuIEimow; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id CAUC3HyXR9ym; Mon, 16 Mar 2020 13:36:12 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48gwlJ2Hjrz9v02j;
        Mon, 16 Mar 2020 13:36:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584362172; bh=iWOn+U7JOwLJNDauXlLGMF/b0VCQfBy5EbGKISCTiPs=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=XuIEimowdBMEl+xgGXl3TC3VZWtzkl29R5/5Xe6G7OiZ/deNk/4Q9/p7Zbg57c0F9
         2oBPpWMem9iMGzYvj4mTCD/3WdIFm4a4K1kkH6F1wmTncpykPIfJwjE1OiPUAMEn1C
         vV3jq16XP0uZVrzYlcmHkPGAdfKWgnQprdWlxmCg=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 43A188B7CB;
        Mon, 16 Mar 2020 13:36:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id o0mNKxGmDu8N; Mon, 16 Mar 2020 13:36:17 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 13A848B7D2;
        Mon, 16 Mar 2020 13:36:17 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 0878365595; Mon, 16 Mar 2020 12:36:16 +0000 (UTC)
Message-Id: <607a53cfe5dcc62ea8ed17e40aafa8fa89493c54.1584360344.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1584360343.git.christophe.leroy@c-s.fr>
References: <cover.1584360343.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 31/46] powerpc/8xx: Add function to update pinned TLBs
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 16 Mar 2020 12:36:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pinned TLBs are not easy to modify when the MMU is enabled.

Create a small function to update a pinned TLB entry with MMU off.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h |  3 ++
 arch/powerpc/kernel/head_8xx.S               | 44 ++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
index a092e6434bda..794bce83c5b0 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
@@ -193,6 +193,9 @@
 
 #include <linux/mmdebug.h>
 
+void mpc8xx_update_tlb(int data, int idx, unsigned long epn,
+		       unsigned long twc, unsigned long rpn);
+
 typedef struct {
 	unsigned int id;
 	unsigned int active;
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 423465b10c82..84b3c7692b37 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -866,6 +866,50 @@ initial_mmu:
 	mtspr	SPRN_DER, r8
 	blr
 
+/*
+ * void mpc8xx_update_tlb(int data, int idx, unsigned long epn,
+ *			  unsigned long twc, unsigned long rpn);
+ */
+_GLOBAL(mpc8xx_update_tlb)
+	lis	r9, (1f - PAGE_OFFSET)@h
+	ori	r9, r9, (1f - PAGE_OFFSET)@l
+	mfmsr	r10
+	mflr	r11
+	li	r12, MSR_KERNEL & ~(MSR_IR | MSR_DR)
+	rlwinm	r0, r10, 0, ~MSR_RI
+	rlwinm	r0, r0, 0, ~MSR_EE
+	mtmsr	r0
+	isync
+	.align	4
+	mtspr	SPRN_SRR0, r9
+	mtspr	SPRN_SRR1, r12
+	rfi
+
+1:	cmpwi	r3, 0
+	beq	2f
+
+	mfspr	r0, SPRN_MD_CTR
+	rlwimi	r0, r4, 8, 0x00001f00
+	mtspr	SPRN_MD_CTR, r0
+
+	mtspr	SPRN_MD_EPN, r5
+	mtspr	SPRN_MD_TWC, r6
+	mtspr	SPRN_MD_RPN, r7
+	b	3f
+
+2:	mfspr	r0, SPRN_MI_CTR
+	rlwimi	r0, r4, 8, 0x00001f00
+	mtspr	SPRN_MI_CTR, r0
+
+	mtspr	SPRN_MI_EPN, r5
+	mtspr	SPRN_MI_TWC, r6
+	mtspr	SPRN_MI_RPN, r7
+
+3:	li	r12, MSR_KERNEL & ~(MSR_IR | MSR_DR | MSR_RI)
+	mtmsr	r12
+	mtspr	SPRN_SRR1, r10
+	mtspr	SPRN_SRR0, r11
+	rfi
 
 /*
  * We put a few things here that have to be page-aligned.
-- 
2.25.0

