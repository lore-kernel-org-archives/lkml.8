Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044B8C433E7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D817A20720
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpAKl9wZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgGOFF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 01:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgGOFFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 01:05:55 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F7FC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 22:05:55 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k71so2426123pje.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 22:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bm4thXoFSfa1/sQw0dtkD1wfDchbOx50xJxWqo/+1Is=;
        b=DpAKl9wZ94ymn0jXczVpLmfmouKGejMw0H+LWr6u928uaQH089ycktNCP3VFc16BrR
         /tPaEE5K0XO9+pwvIXhiDGrzrGspRGGuhY3a9Mv0TTNCsugn2zoSMs686ZtKPOHOaARu
         VBWd60bWjnM+hFua7jgvgTjOknWW6s9/TC5hbI2um9NlGZmrOLeacOwhDygsEn5htpT6
         +BLZVgrzZeVKGHSNloE33Fu1w6Yr6GvrprqpBAvQLEVhlV6fUSwUHjZ90wSImBSdTZT7
         b0Z897YTUnpXKwLthhf9dKpvUkpdWXEPSElWwRKeb9XMDlvYZfX7p4JEBZd9fyo/vyK6
         tlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bm4thXoFSfa1/sQw0dtkD1wfDchbOx50xJxWqo/+1Is=;
        b=Yn9Xrd1DbygjTRw6l3tntsAhhAZmIlkA6PPOqwDIEhaACz4j2Ye6kRn2RK9WjDqqmG
         oP35kaNR7UYqAOxFXW0AjzptsLNgtsHd62ImUzSE5ONKWJrrWhVkj8E0pk0KVI6BNGL0
         DhA8pp8fC8fMGeVxdIQetqreAZGjmSVmJhluVaUZ5/0CZGkjH14AnARJEkHRlvrGL5Z6
         PX+RQLtct142eVHLJ+W4RlvboyAcU2BMjC8hDW+GDZKSZ0V6ZLt4mPm9jfrBkizZcdJP
         HFWr0TOqCzl9/E6lQMVphzxQXIAffSiPBm4MHOwB0A1354MuiyIsd/SnM0NhLGG9fusK
         PIfg==
X-Gm-Message-State: AOAM530lawEd9fyjvpeY2ND8wNS3bjuI+pF+R6XGYry8S6HgF6cKDZe3
        5b65/jeVi65vjG0/Pwblazg=
X-Google-Smtp-Source: ABdhPJw0C70BIwKGpjkfx8nJpPkB5JKp40Mgim31v9kg4oiAjTmQAM/a78rYMdr6ckToybx3SLrqeg==
X-Received: by 2002:a17:90a:ce96:: with SMTP id g22mr8354681pju.9.1594789555034;
        Tue, 14 Jul 2020 22:05:55 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id i21sm747251pfa.18.2020.07.14.22.05.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2020 22:05:54 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH 4/4] mm/gup: use a standard migration target allocation callback
Date:   Wed, 15 Jul 2020 14:05:29 +0900
Message-Id: <1594789529-6206-4-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594789529-6206-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1594789529-6206-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

There is a well-defined migration target allocation callback. Use it.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/gup.c | 54 ++++++------------------------------------------------
 1 file changed, 6 insertions(+), 48 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 4ba822a..628ca4c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1608,52 +1608,6 @@ static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
 }
 
 #ifdef CONFIG_CMA
-static struct page *new_non_cma_page(struct page *page, unsigned long private)
-{
-	/*
-	 * We want to make sure we allocate the new page from the same node
-	 * as the source page.
-	 */
-	int nid = page_to_nid(page);
-	/*
-	 * Trying to allocate a page for migration. Ignore allocation
-	 * failure warnings. We don't force __GFP_THISNODE here because
-	 * this node here is the node where we have CMA reservation and
-	 * in some case these nodes will have really less non CMA
-	 * allocation memory.
-	 *
-	 * Note that CMA region is prohibited by allocation scope.
-	 */
-	gfp_t gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_NOWARN;
-
-	if (PageHighMem(page))
-		gfp_mask |= __GFP_HIGHMEM;
-
-#ifdef CONFIG_HUGETLB_PAGE
-	if (PageHuge(page)) {
-		struct hstate *h = page_hstate(page);
-
-		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
-		return alloc_huge_page_nodemask(h, nid, NULL, gfp_mask);
-	}
-#endif
-	if (PageTransHuge(page)) {
-		struct page *thp;
-		/*
-		 * ignore allocation failure warnings
-		 */
-		gfp_t thp_gfpmask = GFP_TRANSHUGE | __GFP_NOWARN;
-
-		thp = __alloc_pages_node(nid, thp_gfpmask, HPAGE_PMD_ORDER);
-		if (!thp)
-			return NULL;
-		prep_transhuge_page(thp);
-		return thp;
-	}
-
-	return __alloc_pages_node(nid, gfp_mask, 0);
-}
-
 static long check_and_migrate_cma_pages(struct task_struct *tsk,
 					struct mm_struct *mm,
 					unsigned long start,
@@ -1668,6 +1622,10 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
 	bool migrate_allow = true;
 	LIST_HEAD(cma_page_list);
 	long ret = nr_pages;
+	struct migration_target_control mtc = {
+		.nid = NUMA_NO_NODE,
+		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_NOWARN,
+	};
 
 check_again:
 	for (i = 0; i < nr_pages;) {
@@ -1713,8 +1671,8 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
 		for (i = 0; i < nr_pages; i++)
 			put_page(pages[i]);
 
-		if (migrate_pages(&cma_page_list, new_non_cma_page,
-				  NULL, 0, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
+		if (migrate_pages(&cma_page_list, alloc_migration_target, NULL,
+			(unsigned long)&mtc, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
 			/*
 			 * some of the pages failed migration. Do get_user_pages
 			 * without migration.
-- 
2.7.4

