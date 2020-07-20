Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BCAC433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 04:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9E0220758
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 04:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlNVwPf+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgGTE4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 00:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgGTE4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 00:56:50 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35294C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 21:56:50 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 1so8445517pfn.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 21:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bYXHL6tBkIar+w8mWcyE6FXql8F7mBZJXR0egF1QDH8=;
        b=OlNVwPf+HMgvwAVg65akrh38rFGIXJkh4W7fjrmb8Q6+eGdEkN7iRxqnWHHBugAyui
         UiKvFQPSNuv2CfU/eTXBR8QMxczNJuqPQHxajXZDoUuC247S1SIs5G3bTfAblK+DB/5Y
         V5L9IUuxNKj9e89BVTirtanIOsh2ugtXQMWxJZM5t/i5F8gLIc6jFw3lUcyK0rEj4epO
         uoAE/+m5iWV4EkL19wDu7+4aYDARDNpEK/4AdJ6tHX/KDSXGTZveivM5gRufKW/QT9Iw
         0t6e1SamXsDG8u3+w+xuaxApEod6iVdG/fqM0MHxautVDAns595npEuiXd4C5K4C513R
         DmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bYXHL6tBkIar+w8mWcyE6FXql8F7mBZJXR0egF1QDH8=;
        b=BIzQUMWyb82CcD+A034y0CMk8UvnuInpbdwAE0e51sZK72Za1TefSNp9g37ff6SWAv
         8dJ6a2/DzJZQa08EdFNSdmwNieg37hcjWtgXMF4lkwaBSl3Qs9l9PWO50AgT8kZ4mZZe
         lS8vOBw36HwgSWeFDeF1pVulwmswnkVUp5Mfaez9NJ4PfVzsfksMDfBtAXK1yrCDLS/5
         KvlHO9MfqYWAmMMHKgWEhEItKh50A6WebmmJMDkkR8USGjPHZdWDi28FuKRG7RQgNCwR
         u3vSAm1oltwvdZQ82lA5tPQVcGokS2Cq0e0ZtUalCs1rHFPT2ELsySL1GMxZtCgydBHX
         /eow==
X-Gm-Message-State: AOAM532RD7NtLjPH5RQNlxL2B0TkUtD3U7SWvgK/vCiWJ0vb4cjKopOk
        b2lji32wkxcYCo2r9ACMcRs=
X-Google-Smtp-Source: ABdhPJwlx0yapsh6n0sVA8bpe1PYfFq2VO7v9/ovvTdDCF0wsJHOdujATw4X8LrzvQ6DzKdU6JQe+g==
X-Received: by 2002:aa7:9e89:: with SMTP id p9mr18826525pfq.110.1595221009631;
        Sun, 19 Jul 2020 21:56:49 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id w2sm10177532pjt.19.2020.07.19.21.56.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jul 2020 21:56:49 -0700 (PDT)
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
Subject: [PATCH v2 4/4] mm/gup: use a standard migration target allocation callback
Date:   Mon, 20 Jul 2020 13:56:18 +0900
Message-Id: <1595220978-9890-4-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595220978-9890-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1595220978-9890-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

There is a well-defined migration target allocation callback. Use it.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Michal Hocko <mhocko@suse.com>
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

