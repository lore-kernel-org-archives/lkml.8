Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651AFC8300B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E4A221707
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XpgKxfAG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgD1To4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728987AbgD1Toz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:44:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99138C03C1AB;
        Tue, 28 Apr 2020 12:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=JHSvmroelv0sK3RJ9jDQ65/3EP5MC9zy/wCmxVX3oH0=; b=XpgKxfAGyw+vcjSHBHLQYS4gFq
        ZASI1jIlY+ptUWLEA8L4MC9pCLzAxFZ2MZPMJoOw7F0o4eZW10bsNHCNTYpNxIor31O8a107iNszE
        ZYMgwajQqxNCn45M8vdu0UZM2TsPrSkn1EtplDisSpfvm5BZpJnmUXDcZJNHowGpCmRMdJ4yzwGE8
        iOwum4I8GFZ7i44lLsYCM1NLQWv1Cct3rV1JwvJDUO9Uf7CbIpDgxBZbMX5nssQt8xVWRRChLKEAv
        cu17lVMbH4a0ED/RcRJR+FtbhaqsrHMGlB/oDFqta1JO1gQ6U8sWLqY274daPDJ10tH+cUuc27KkY
        UJWl/p5g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTW9z-0005ug-1e; Tue, 28 Apr 2020 19:44:51 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH 5/7] m68k: Thread mm_struct throughout page table allocation
Date:   Tue, 28 Apr 2020 12:44:47 -0700
Message-Id: <20200428194449.22615-6-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200428194449.22615-1-willy@infradead.org>
References: <20200428194449.22615-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

An upcoming patch will pass mm_struct to the page table constructor.
Make sure m68k has the appropriate mm_struct at the point it needs to
call the constructor.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/m68k/include/asm/motorola_pgalloc.h | 10 +++++-----
 arch/m68k/mm/motorola.c                  |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/m68k/include/asm/motorola_pgalloc.h b/arch/m68k/include/asm/motorola_pgalloc.h
index c66e42917912..dbac0c597397 100644
--- a/arch/m68k/include/asm/motorola_pgalloc.h
+++ b/arch/m68k/include/asm/motorola_pgalloc.h
@@ -15,12 +15,12 @@ enum m68k_table_types {
 };
 
 extern void init_pointer_table(void *table, int type);
-extern void *get_pointer_table(int type);
+extern void *get_pointer_table(int type, struct mm_struct *mm);
 extern int free_pointer_table(void *table, int type);
 
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 {
-	return get_pointer_table(TABLE_PTE);
+	return get_pointer_table(TABLE_PTE, mm);
 }
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
@@ -30,7 +30,7 @@ static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 
 static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
-	return get_pointer_table(TABLE_PTE);
+	return get_pointer_table(TABLE_PTE, mm);
 }
 
 static inline void pte_free(struct mm_struct *mm, pgtable_t pgtable)
@@ -47,7 +47,7 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pgtable,
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	return get_pointer_table(TABLE_PMD);
+	return get_pointer_table(TABLE_PMD, mm);
 }
 
 static inline int pmd_free(struct mm_struct *mm, pmd_t *pmd)
@@ -69,7 +69,7 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	return get_pointer_table(TABLE_PGD);
+	return get_pointer_table(TABLE_PGD, mm);
 }
 
 
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index fc16190ec2d6..7743480be0cf 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -113,7 +113,7 @@ void __init init_pointer_table(void *table, int type)
 	return;
 }
 
-void *get_pointer_table(int type)
+void *get_pointer_table(int type, struct mm_struct *mm)
 {
 	ptable_desc *dp = ptable_list[type].next;
 	unsigned int mask = list_empty(&ptable_list[type]) ? 0 : PD_MARKBITS(dp);
-- 
2.26.2

