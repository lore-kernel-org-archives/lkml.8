Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1031C35249
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 12:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E387215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 12:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m+Ndu5zG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgAaM4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 07:56:13 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39030 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728632AbgAaM4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 07:56:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=y4MVG/cFZ6hqIKXIDDSuaf7ZYDHNDFj09hCdHBA/lnU=; b=m+Ndu5zGKIYYf+I9RdjgD2ROEJ
        4xeU1ptugz32KHMnyI+4BTYj6oK5FnlFseO9+pD7vfv4xm7KXqWcdL50Cc0bOrfbw3ONwnE2rBaAk
        h9mS+PLqCDDfnWFsjtUa1rG+kL5sGlwdfBDe16cuyvig4MSLdR7boZmi86y+fKTWSm1h7l+ZjEKEM
        dlKBYcoRFs2/gGa1/HzZjmACXciI8BYV3f0sGN9C3TWc8aPf3k0dTdZbmAa2SChww4w/8eFoh9XIt
        6L22WQri8JZB5BytNLqnOhk8kppRkd9Ul1Vh0lSXwa2e219DZdOO/neBtWyRGtLWZPJKwcTfUA+H5
        uwi84M/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixVq9-0003gU-7f; Fri, 31 Jan 2020 12:56:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4AB4F306E5C;
        Fri, 31 Jan 2020 13:54:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 053312B63481B; Fri, 31 Jan 2020 13:56:01 +0100 (CET)
Message-Id: <20200131125403.938797587@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 31 Jan 2020 13:45:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCH -v2 09/10] m68k,mm: Fully initialize the page-table allocator
References: <20200131124531.623136425@infradead.org>
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
 arch/m68k/mm/init.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/arch/m68k/mm/init.c
+++ b/arch/m68k/mm/init.c
@@ -120,7 +120,7 @@ void free_initmem(void)
 static inline void init_pointer_tables(void)
 {
 #if defined(CONFIG_MMU) && !defined(CONFIG_SUN3) && !defined(CONFIG_COLDFIRE)
-	int i;
+	int i, j;
 
 	/* insert pointer tables allocated so far into the tablelist */
 	init_pointer_table(kernel_pg_dir, TABLE_PGD);
@@ -133,6 +133,17 @@ static inline void init_pointer_tables(v
 
 		pmd_dir = (pmd_t *)pgd_page_vaddr(kernel_pg_dir[i]);
 		init_pointer_table(pmd_dir, TABLE_PMD);
+
+		for (j = 0; j < PTRS_PER_PMD; j++) {
+			pmd_t *pmd = &pmd_dir[j];
+			pte_t *pte_dir;
+
+			if (!pmd_present(*pmd))
+				continue;
+
+			pte_dir = (pte_t *)__pmd_page(*pmd);
+			init_pointer_table(pte_dir, TABLE_PTE);
+		}
 	}
 #endif
 }


