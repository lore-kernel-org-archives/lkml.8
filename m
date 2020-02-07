Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B7BC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1FF20726
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="g+dE/lA7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgBGJwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 04:52:55 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38786 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgBGJwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 04:52:54 -0500
Received: by mail-pj1-f66.google.com with SMTP id j17so701136pjz.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 01:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=62RfhKAR/Ri4okXqm018bf0oko/VlUMmOmgrha7NFJc=;
        b=g+dE/lA71/7lIVK3CjQgSD3qoczW6hh85KWVkYh6PmYLHAZRZpwNA08GJ9z1uqakRe
         SGNXQtG4e79a71zHf/jYu8DFoZotBKdogZsY4pgMg4GGxUsAEBtbuCy4UetRoxw9/MD9
         UG1AUYjs+z0DcAnFfZSD3Jbp+va3NKSgbC3q4BhURcxvi8iuyNJ0KarQ7v7emiyexZfd
         pjKJb48Wf3bbWl42+QV2b+GrQMbRtO2YSiRtz3+i5nyUIWmv5P5eUjbuA0Zf6w23TyD6
         LodLXS0ZIw7aM1/QIkeXp8zXmfQ9A7Fthpe50K1S0C1O9GJNLv4B+qVzDWTGAeh9pf+y
         3paw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=62RfhKAR/Ri4okXqm018bf0oko/VlUMmOmgrha7NFJc=;
        b=hAwgRqF9ezVL2nLt/GYzZjlj31jcfnc0N2G6+SE2lBxcmRF6pQH4HSGx+DK2UmZc9G
         59jNK5o870zs/lB6vrIlm8Bw6e8kEIA1VBwaDRdO+3KzxagjmScZXveK+nIicRD0KhL/
         66sg3nfHm1/VNgQOYMABC8clgnEXmu+UgrKlGWNm5fvduQRgnXnupwUBONDnOn0DpjIF
         hra9hO4Cvj0xR7fi+NyjwcDndLR0E0yX7DeHY/O/W8GunZ9rca5QlAASAustM2DDVY60
         mcBXGu1tjaxMXu2PAndNS5ZrzT3zY/DL9mNppLB1Dyl+ZOsCBIBPNQI51Gyv8jRUjlfM
         6IGQ==
X-Gm-Message-State: APjAAAXmN6MGAT3VFjJf/NXaXxUag7HpBAEoB0CsHhzfLLDLxmZDWFlX
        EW8fE6VOiSL+a5V6I7BHiEqa8A==
X-Google-Smtp-Source: APXvYqyEqxTbUYM7DH8aCdJhHthU3VF26dL8ropAoBOTPzxtNpmqZwz3S31FktC6fcgH3q3mlW/eeQ==
X-Received: by 2002:a17:90a:2ec7:: with SMTP id h7mr2885268pjs.107.1581069173488;
        Fri, 07 Feb 2020 01:52:53 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id s23sm2060934pjq.17.2020.02.07.01.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 01:52:53 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 1/2] riscv: allocate a complete page size for each page table
Date:   Fri,  7 Feb 2020 17:52:44 +0800
Message-Id: <20200207095245.21955-2-zong.li@sifive.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207095245.21955-1-zong.li@sifive.com>
References: <20200207095245.21955-1-zong.li@sifive.com>
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

