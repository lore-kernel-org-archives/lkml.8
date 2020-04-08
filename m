Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77E1C2BA16
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB0520730
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AbD9ApZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgDHP17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:27:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35144 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbgDHP16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:Content-Type:Content-ID:Content-Description;
        bh=JYgCfd69l5wKlxKLfP58Ep2fYWaDqO+v+grkbu68hn8=; b=AbD9ApZRbwbT+DlbFOG2TcnwOj
        krHOnpAd3CimDisTrcrTY6shPU38Off+tgLCDFJ1Da1W9dJg2Z8uSgn+UjJzK6dNivOCBZ/XJTWD4
        QrDl6zDZ3IJeY/rtE6HzCJcpKZe54GLWdxRD5QlbfaUSrUr60GbLbsT34p+jxeKbe7ep1Bz8rWRHc
        oPmeT/k64k7/u5dhNnrzqGJtpwzxBEHIEBpWbi5jOTES6g78pfpihFpMWnrvXzThGTV/4Ung6m0AH
        MAXVITcaBJxtWmhM3REV1pp7gT9KvUKh7TibTzal41MXgaIOeA0w1DiQGKqSrxHADj0T6ZU/+MTBN
        PO+lX7ZA==;
Received: from [2001:4bb8:180:5765:65b6:f11e:f109:b151] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMCcO-0007zl-8C; Wed, 08 Apr 2020 15:27:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] x86/mm: Cleanup pgprot_4k_2_large and pgprot_large_2_4k
Date:   Wed,  8 Apr 2020 17:27:44 +0200
Message-Id: <20200408152745.1565832-4-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200408152745.1565832-1-hch@lst.de>
References: <20200408152745.1565832-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of lower level helpers that operate on the raw protection
values to make the code a little easier to understand, and to also
avoid extra conversions in a few callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/pgtable_types.h | 26 +++++++++++++-------------
 arch/x86/mm/init_64.c                |  2 +-
 arch/x86/mm/pgtable.c                |  8 ++------
 3 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 75fe903124f8..a3b78d84b26a 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -488,24 +488,24 @@ static inline pgprot_t cachemode2pgprot(enum page_cache_mode pcm)
 {
 	return __pgprot(cachemode2protval(pcm));
 }
-static inline pgprot_t pgprot_4k_2_large(pgprot_t pgprot)
+static inline unsigned long protval_4k_2_large(unsigned long val)
 {
-	pgprotval_t val = pgprot_val(pgprot);
-	pgprot_t new;
-
-	pgprot_val(new) = (val & ~(_PAGE_PAT | _PAGE_PAT_LARGE)) |
+	return (val & ~(_PAGE_PAT | _PAGE_PAT_LARGE)) |
 		((val & _PAGE_PAT) << (_PAGE_BIT_PAT_LARGE - _PAGE_BIT_PAT));
-	return new;
+}
+static inline pgprot_t pgprot_4k_2_large(pgprot_t pgprot)
+{
+	return __pgprot(protval_4k_2_large(pgprot_val(pgprot)));
+}
+static inline unsigned long protval_large_2_4k(unsigned long val)
+{
+	return (val & ~(_PAGE_PAT | _PAGE_PAT_LARGE)) |
+		((val & _PAGE_PAT_LARGE) >>
+		 (_PAGE_BIT_PAT_LARGE - _PAGE_BIT_PAT));
 }
 static inline pgprot_t pgprot_large_2_4k(pgprot_t pgprot)
 {
-	pgprotval_t val = pgprot_val(pgprot);
-	pgprot_t new;
-
-	pgprot_val(new) = (val & ~(_PAGE_PAT | _PAGE_PAT_LARGE)) |
-			  ((val & _PAGE_PAT_LARGE) >>
-			   (_PAGE_BIT_PAT_LARGE - _PAGE_BIT_PAT));
-	return new;
+	return __pgprot(protval_large_2_4k(pgprot_val(pgprot)));
 }
 
 
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 0a14711d3a93..3420377c7fd9 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -367,7 +367,7 @@ static void __init __init_extra_mapping(unsigned long phys, unsigned long size,
 	pgprot_t prot;
 
 	pgprot_val(prot) = pgprot_val(PAGE_KERNEL_LARGE) |
-		pgprot_val(pgprot_4k_2_large(cachemode2pgprot(cache)));
+		protval_4k_2_large(cachemode2protval(cache));
 	BUG_ON((phys & ~PMD_MASK) || (size & ~PMD_MASK));
 	for (; size; phys += PMD_SIZE, size -= PMD_SIZE) {
 		pgd = pgd_offset_k((unsigned long)__va(phys));
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 7bd2c3a52297..edf9cea4871f 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -706,11 +706,9 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
 	if (pud_present(*pud) && !pud_huge(*pud))
 		return 0;
 
-	prot = pgprot_4k_2_large(prot);
-
 	set_pte((pte_t *)pud, pfn_pte(
 		(u64)addr >> PAGE_SHIFT,
-		__pgprot(pgprot_val(prot) | _PAGE_PSE)));
+		__pgprot(protval_4k_2_large(pgprot_val(prot) | _PAGE_PSE))));
 
 	return 1;
 }
@@ -738,11 +736,9 @@ int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
 	if (pmd_present(*pmd) && !pmd_huge(*pmd))
 		return 0;
 
-	prot = pgprot_4k_2_large(prot);
-
 	set_pte((pte_t *)pmd, pfn_pte(
 		(u64)addr >> PAGE_SHIFT,
-		__pgprot(pgprot_val(prot) | _PAGE_PSE)));
+		__pgprot(protval_4k_2_large(pgprot_val(prot)) | _PAGE_PSE)));
 
 	return 1;
 }
-- 
2.25.1

