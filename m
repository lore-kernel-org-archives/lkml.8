Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B9EC33CB7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9D8207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I5bHV9jX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgA2KpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 05:45:19 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48212 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgA2KpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 05:45:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rTxt4FphL53Y4h3JaY+82PJXfecw+fNjkxlfqbGvTag=; b=I5bHV9jX+P4Pnw44FeNDchBR5j
        nr6rDGfNbe1OtEqk91kppqMSFoYpL3LxsW3iD/S4cUJGnj2K/Ub9xlHzFZZnsT0Lmpr00Y/T7tHu6
        tRFuULJ5yonlaG4q+h35649kXTz5VM+XrAAgrhWwQieQ19qC/HHP3micQ67Ll4wSqROo3i/N4ewdx
        DM4kb6WtWnYW/CXZgcQzMTiUjLierx0QlrsqHs4BHJzhWwXI2Evi3VPsBieEr45kwyCVrNcAu02hP
        XQllDIrGFq/7WHm5l26+9EpRTU0dH5m9agpwstu8i8tcDEdn4LiGLePVL6ykagjLU7jwX74O6otWY
        ByY96J7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwkqO-0001OK-8O; Wed, 29 Jan 2020 10:45:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E3055306637;
        Wed, 29 Jan 2020 11:43:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 93F722B2E7F42; Wed, 29 Jan 2020 11:45:07 +0100 (CET)
Message-Id: <20200129104345.548344561@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 29 Jan 2020 11:39:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 5/5] m68k,mm: Fully initialize the page-table allocator
References: <20200129103941.304769381@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also iterate the PMD tables to populate the PTE table allocator. This
also fully replaces the previous zero_pgtable hack.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/m68k/mm/init.c |   23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

--- a/arch/m68k/mm/init.c
+++ b/arch/m68k/mm/init.c
@@ -124,15 +124,30 @@ void free_initmem(void)
 static inline void init_pointer_tables(void)
 {
 #if defined(CONFIG_MMU) && !defined(CONFIG_SUN3) && !defined(CONFIG_COLDFIRE)
-	int i;
+	int i, j;
 
 	/* insert pointer tables allocated so far into the tablelist */
 	init_pointer_table((unsigned long)kernel_pg_dir, 0);
 	for (i = 0; i < PTRS_PER_PGD; i++) {
-		pud_t *pud = (pud_t *)(&kernel_pg_dir[i]);
+		pud_t *pud = (pud_t *)&kernel_pg_dir[i];
+		pmd_t *pmd_dir;
 
-		if (pud_present(*pud))
-			init_pointer_table(pgd_page_vaddr(kernel_pg_dir[i]), 0);
+		if (!pud_present(*pud))
+			continue;
+
+		pmd_dir = (pmd_t *)pgd_page_vaddr(kernel_pg_dir[i]);
+		init_pointer_table((unsigned long)pmd_dir, 0);
+
+		for (j = 0; j < PTRS_PER_PMD; j++) {
+			pmd_t *pmd = &pmd_dir[j];
+			pte_t *pte_dir;
+
+			if (!pmd_present(*pmd))
+				continue;
+
+			pte_dir = (pte_t *)__pmd_page(*pmd);
+			init_pointer_table((unsigned long)pte_dir, 1);
+		}
 	}
 #endif
 }


