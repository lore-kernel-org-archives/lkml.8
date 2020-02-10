Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380EFC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 05:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5A122525
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 05:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LwEa2cuF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgBJF5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 00:57:06 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45335 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgBJF5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 00:57:05 -0500
Received: by mail-pg1-f195.google.com with SMTP id b9so3289714pgk.12
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 21:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=62RfhKAR/Ri4okXqm018bf0oko/VlUMmOmgrha7NFJc=;
        b=LwEa2cuFrHdjHrRI7KW8PxSw4vR3QJcIM5pqYuIO50oJxfp5EKeNF+BdQyd0585lok
         nsbW+QRPGgZNabsMUiPaYmU4q3y1b1J5bkSm/OJiIixpvfjvqmtmQscPDV0/YZzDaVmG
         uqj5jMlFLzyUtiujvYBmVPoyR4VQ6F0Qr4kNH46UhD0DXS1HqfFSHw7zBH8Gt85wGKjK
         62TvZTkx1avqEU51JWAyfEmtJiAGalyXLm5LLpLZ1XPso6DpPt+ajIhHKniKeydBnHxu
         kN2RGoOCG611kpEKqAuklrfNaPh9IWVxa4nNRo4p+7LhWos4gPCQnwPbWD6NvNRpZJmp
         Ui+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=62RfhKAR/Ri4okXqm018bf0oko/VlUMmOmgrha7NFJc=;
        b=geCwZV6vX1Dt0Xx75jy83D0X70UnXia0DPhR3CeD/hz6256crco/FswGJZBFypyRzP
         3kgJXVduAYuwO6aPHOdUSxEXzX4xEl6JyEHIcfJ4R4HoIBTzb1Wmd61yKfWO5s472Btu
         BqAb9nhGrQlcm2k8c8tbmoJi4OSx3POzLDQPo+GRMWERrRbEQBu+EQaj5PgskBqQJuc0
         0SQk6XUvzIWHb84SOYV5ptsXN3kUZBXAmA2vYnXyPPOO3rgCF5Qgn+PYe+dUTT5GAznZ
         Z9iMk4g6RZi6usmSMCrl7/wt2iglgc7FBfMei1hXx14nCrOpUmXC9rXGzk125cH7WW8K
         uXZg==
X-Gm-Message-State: APjAAAU5kmU1it2OiEs4dg11VC7xYix6nHInOV+mXa6XTRuDJZshwpLe
        rN/bWDRA6O9VCypvM2CRLSdarQ==
X-Google-Smtp-Source: APXvYqyLwM9orE9zwSxvz1FkNdJPgYt9aD06AOmG01Ol6nUGVWGBH7dNYvJ4Qrgg/llhsMnyGvt0Pw==
X-Received: by 2002:a63:e54c:: with SMTP id z12mr12274548pgj.415.1581314225067;
        Sun, 09 Feb 2020 21:57:05 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id s206sm11140234pfs.100.2020.02.09.21.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 21:57:04 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, joe@perches.com, nickhu@andestech.com
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 1/2] riscv: allocate a complete page size for each page table
Date:   Mon, 10 Feb 2020 13:56:53 +0800
Message-Id: <20200210055654.96725-2-zong.li@sifive.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210055654.96725-1-zong.li@sifive.com>
References: <20200210055654.96725-1-zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each page table should be created by allocating a complete page size
for it. Otherwise, the content of the page table would be corrupted
somewhere through memory allocation which allocates the memory at the
middle of the page table for other use.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/mm/kasan_init.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index f0cc86040587..f8eaf7e73a23 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -46,29 +46,34 @@ asmlinkage void __init kasan_early_init(void)
 
 static void __init populate(void *start, void *end)
 {
-	unsigned long i;
+	unsigned long i, offset;
 	unsigned long vaddr = (unsigned long)start & PAGE_MASK;
 	unsigned long vend = PAGE_ALIGN((unsigned long)end);
 	unsigned long n_pages = (vend - vaddr) / PAGE_SIZE;
+	unsigned long n_ptes =
+	    ((n_pages + PTRS_PER_PTE) & -PTRS_PER_PTE) / PTRS_PER_PTE;
 	unsigned long n_pmds =
-		(n_pages % PTRS_PER_PTE) ? n_pages / PTRS_PER_PTE + 1 :
-						n_pages / PTRS_PER_PTE;
+	    ((n_ptes + PTRS_PER_PMD) & -PTRS_PER_PMD) / PTRS_PER_PMD;
+
+	pte_t *pte =
+	    memblock_alloc(n_ptes * PTRS_PER_PTE * sizeof(pte_t), PAGE_SIZE);
+	pmd_t *pmd =
+	    memblock_alloc(n_pmds * PTRS_PER_PMD * sizeof(pmd_t), PAGE_SIZE);
 	pgd_t *pgd = pgd_offset_k(vaddr);
-	pmd_t *pmd = memblock_alloc(n_pmds * sizeof(pmd_t), PAGE_SIZE);
-	pte_t *pte = memblock_alloc(n_pages * sizeof(pte_t), PAGE_SIZE);
 
 	for (i = 0; i < n_pages; i++) {
 		phys_addr_t phys = memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
-
-		set_pte(pte + i, pfn_pte(PHYS_PFN(phys), PAGE_KERNEL));
+		set_pte(&pte[i], pfn_pte(PHYS_PFN(phys), PAGE_KERNEL));
 	}
 
-	for (i = 0; i < n_pmds; ++pgd, i += PTRS_PER_PMD)
-		set_pgd(pgd, pfn_pgd(PFN_DOWN(__pa(((uintptr_t)(pmd + i)))),
+	for (i = 0, offset = 0; i < n_ptes; i++, offset += PTRS_PER_PTE)
+		set_pmd(&pmd[i],
+			pfn_pmd(PFN_DOWN(__pa(&pte[offset])),
 				__pgprot(_PAGE_TABLE)));
 
-	for (i = 0; i < n_pages; ++pmd, i += PTRS_PER_PTE)
-		set_pmd(pmd, pfn_pmd(PFN_DOWN(__pa((uintptr_t)(pte + i))),
+	for (i = 0, offset = 0; i < n_pmds; i++, offset += PTRS_PER_PMD)
+		set_pgd(&pgd[i],
+			pfn_pgd(PFN_DOWN(__pa(&pmd[offset])),
 				__pgprot(_PAGE_TABLE)));
 
 	flush_tlb_all();
-- 
2.25.0

