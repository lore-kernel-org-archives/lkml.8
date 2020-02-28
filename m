Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB22CC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79441246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0HuMjCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgB1LfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 06:35:03 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36199 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgB1LfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 06:35:03 -0500
Received: by mail-pg1-f194.google.com with SMTP id d9so1383766pgu.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 03:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WaTuQUSD3FMKmtCCA0ipNCi0y5rbOoaZk9gisNac/9g=;
        b=c0HuMjCc+aTrgTZ7ztGz5UY2xFznt+qwmoB6AYlPqgnGS6AgQww4emfDwoa7uoDtVK
         IHINFeakoVuNaa8KmBiReuI8Q6/c9kNyJvZkJXgxkvytNtv193Whi3I/ftWKNionoNnP
         xOYiZUiLuIMeuwdPiC47pPYVhs+GC1OQLHamYcl6LE7D7X1fMfIym14wwo6dGQMxHw1S
         Ao+p2ou4rN8gMDZVrs5CQ6Em0Rfs7PvMeThMhWkaUySm3HmUh8shLALPc8yAoD1EyO2q
         dSEbrXe0ZM0Mz/CHx8GnzJH+95XfypzauvI2x3rjPtgTW8oqATxismqGx2DPtBgcl9dV
         0t1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WaTuQUSD3FMKmtCCA0ipNCi0y5rbOoaZk9gisNac/9g=;
        b=UUvDijbvum3jh5kkEciqZ/KbVQ3KFxu5lv8CNySjsm3Aq7V3TDfw64K8tPkzh9iC5/
         DeuIhmWGjDbHX+3NSs9J0tl8p8NuAxmii/7oVBMGFOfFa5v1Qfxk/XsuvxnfCY5vp2qw
         8PX2n76GsDpZgzPHEKd/bBHFXwJRGIuQd5nM3v4DMXoBfVh9HmeMoKLn13tlOPxmZoTc
         YiRIKR9WDG04RqTiYcf8df67Uat7ftzOmtEVpIEY2ZLyCKBfdo7FgaZ06Ja6NhldEdvs
         47+pSUNx7jz0UjkYMm95uybznrNnZpOEfI/wOQ1seg2VtWdqXbtIbvuxpgCbYlu6XgvZ
         sSRA==
X-Gm-Message-State: APjAAAVvlWEasmQiu9QFO4d44E0y7eKWsM8zOzRC0JQ5sAAdu9jZK4rZ
        SpHPgkw4R2t6YFglnoaniQ==
X-Google-Smtp-Source: APXvYqyMqYfx+Gl5paJ1UpKaYGQTelDIg9hDLU17UT8ZUVgANMbncsehzNg7hFkBoLvpxUMcMxDuJA==
X-Received: by 2002:a63:e20d:: with SMTP id q13mr4096480pgh.6.1582889702220;
        Fri, 28 Feb 2020 03:35:02 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d14sm11402168pfq.117.2020.02.28.03.34.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Feb 2020 03:35:01 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-mm@kvack.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCHv5 2/3] mm/gup: fix omission of check on FOLL_LONGTERM in gup fast path
Date:   Fri, 28 Feb 2020 19:32:29 +0800
Message-Id: <1582889550-9101-3-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1582889550-9101-1-git-send-email-kernelfans@gmail.com>
References: <1582889550-9101-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FOLL_LONGTERM suggests a pin which is going to be given to hardware and
can't move. It would truncate CMA permanently and should be excluded.

FOLL_LONGTERM has already been checked in the slow path, but not checked in
the fast path, which means a possible leak of CMA page to longterm pinned
requirement through this crack.

Place a check in try_get_compound_head() in the fast path.

Some note about the check:
Huge page's subpages have the same migrate type due to either
allocation from a free_list[] or alloc_contig_range() with param
MIGRATE_MOVABLE. So it is enough to check on a single subpage
by is_migrate_cma_page(subpage)

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Shuah Khan <shuah@kernel.org>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/gup.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index cd8075e..f0d6804 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -33,9 +33,21 @@ struct follow_page_context {
  * Return the compound head page with ref appropriately incremented,
  * or NULL if that failed.
  */
-static inline struct page *try_get_compound_head(struct page *page, int refs)
+static inline struct page *try_get_compound_head(struct page *page, int refs,
+	unsigned int flags)
 {
-	struct page *head = compound_head(page);
+	struct page *head;
+
+	/*
+	 * Huge page's subpages have the same migrate type due to either
+	 * allocation from a free_list[] or alloc_contig_range() with param
+	 * MIGRATE_MOVABLE. So it is enough to check on a single subpage.
+	 */
+	if (unlikely(flags & FOLL_LONGTERM) &&
+		is_migrate_cma_page(page))
+		return NULL;
+
+	head = compound_head(page);
 
 	if (WARN_ON_ONCE(page_ref_count(head) < 0))
 		return NULL;
@@ -1908,7 +1920,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
 		page = pte_page(pte);
 
-		head = try_get_compound_head(page, 1);
+		head = try_get_compound_head(page, 1, flags);
 		if (!head)
 			goto pte_unmap;
 
@@ -2083,7 +2095,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 	page = head + ((addr & (sz-1)) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
 
-	head = try_get_compound_head(head, refs);
+	head = try_get_compound_head(head, refs, flags);
 	if (!head)
 		return 0;
 
@@ -2142,7 +2154,7 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 	page = pmd_page(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
 
-	head = try_get_compound_head(pmd_page(orig), refs);
+	head = try_get_compound_head(pmd_page(orig), refs, flags);
 	if (!head)
 		return 0;
 
@@ -2174,7 +2186,7 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 	page = pud_page(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
 
-	head = try_get_compound_head(pud_page(orig), refs);
+	head = try_get_compound_head(pud_page(orig), refs, flags);
 	if (!head)
 		return 0;
 
@@ -2203,7 +2215,7 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 	page = pgd_page(orig) + ((addr & ~PGDIR_MASK) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
 
-	head = try_get_compound_head(pgd_page(orig), refs);
+	head = try_get_compound_head(pgd_page(orig), refs, flags);
 	if (!head)
 		return 0;
 
-- 
2.7.5

