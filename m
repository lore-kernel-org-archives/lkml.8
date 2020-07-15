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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6E9C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D72F22074B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nuj/Shff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgGOFFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 01:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgGOFFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 01:05:48 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCE2C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 22:05:48 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m16so1843526pls.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 22:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e7byfgHw8QS4EFeIqD5PDYqTNizYFOWzHsxHEo0G+W4=;
        b=nuj/ShffpoKXVL9Twu4mnjAAGc6trFyAcytARH/jXA7FlxltODfayDtDpf3tZp1bnZ
         5ypy2TkSdXVby/FZBmOXGUDefNSH0TGR13s3r4SKlgdonIe+fsACRrFKRNNk320EFflm
         AeALOCBkibmcwxa7uwGTJIVolr1eOLLqolSKKkmPOhXbyrGyg6RJoA+RRDaBKXL9fa9k
         qtwjlV1STLsyeJqe/98Rao5M1fvvsBBbhoIanlqO03o5kwLS9IKwqKL4CRDs8HZQ6Yf2
         w0XSLF5CqORruKWR0AQCERc/RXk3488q4N6tCnkMxZaqSaUKj/ofOm91Rf7WArXa8FSK
         sy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e7byfgHw8QS4EFeIqD5PDYqTNizYFOWzHsxHEo0G+W4=;
        b=BZYlMql94WM3lED4aRY8KP5ORPBQOwHLMH/BN9jIWisaAMSdWZyBre2biYTzcg0LSH
         LYYkMNUEwXqvmm49xPWpuIgZH25f3NMqt4+6UeB+4RT11jvlhBxkFEuXWIvjJkNCV+JA
         IqvFa5XkqWxVIAZKMcC9BqLsLWCaf4MDPxMrAvbz9CLHbFhtKJTdUQEMIuKm+8aeYEmF
         dAP79/eaE1Zplc9X2w4sfKCkg4qx4A02G6KS4H8dybOWijUicF77kXWCu5bC2XDUjHNl
         9fedv/RfsqVnyPbIDsJRvOGyzrmCpFqLn5Q8wY1lB2gdrQ2H08Jva/f/d0lqqwGMU0qb
         pEDg==
X-Gm-Message-State: AOAM5319jF3XWjWbL5S2E8NXJH53FL7WvGkK6J29UfD8mQWHvVKpYkKT
        L0tltcYZ/wYyFETuLgbPH4Y=
X-Google-Smtp-Source: ABdhPJyEk74SdinwCEymCOZL8TIvU3lrpB1LNieqQ+aiZb/vLtcI8gc4oa2hwcSXm4m0mHX4JQjJvQ==
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr8520227pjp.228.1594789548231;
        Tue, 14 Jul 2020 22:05:48 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id i21sm747251pfa.18.2020.07.14.22.05.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2020 22:05:47 -0700 (PDT)
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
Subject: [PATCH 2/4] mm/gup: restrict CMA region by using allocation scope API
Date:   Wed, 15 Jul 2020 14:05:27 +0900
Message-Id: <1594789529-6206-2-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594789529-6206-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1594789529-6206-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

We have well defined scope API to exclude CMA region.
Use it rather than manipulating gfp_mask manually. With this change,
we can now use __GFP_MOVABLE for gfp_mask and the ZONE_MOVABLE is also
searched by page allocator. For hugetlb, gfp_mask is redefined since
it has a regular allocation mask filter for migration target.

Note that this can be considered as a fix for the commit 9a4e9f3b2d73
("mm: update get_user_pages_longterm to migrate pages allocated from
CMA region"). However, "Fixes" tag isn't added here since it is just
suboptimal but it doesn't cause any problem.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/hugetlb.h |  2 ++
 mm/gup.c                | 17 ++++++++---------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 6b9508d..2660b04 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -708,6 +708,8 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
 	/* Some callers might want to enfoce node */
 	modified_mask |= (gfp_mask & __GFP_THISNODE);
 
+	modified_mask |= (gfp_mask & __GFP_NOWARN);
+
 	return modified_mask;
 }
 
diff --git a/mm/gup.c b/mm/gup.c
index 5daadae..bbd36a1 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1619,10 +1619,12 @@ static struct page *new_non_cma_page(struct page *page, unsigned long private)
 	 * Trying to allocate a page for migration. Ignore allocation
 	 * failure warnings. We don't force __GFP_THISNODE here because
 	 * this node here is the node where we have CMA reservation and
-	 * in some case these nodes will have really less non movable
+	 * in some case these nodes will have really less non CMA
 	 * allocation memory.
+	 *
+	 * Note that CMA region is prohibited by allocation scope.
 	 */
-	gfp_t gfp_mask = GFP_USER | __GFP_NOWARN;
+	gfp_t gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_NOWARN;
 
 	if (PageHighMem(page))
 		gfp_mask |= __GFP_HIGHMEM;
@@ -1630,6 +1632,8 @@ static struct page *new_non_cma_page(struct page *page, unsigned long private)
 #ifdef CONFIG_HUGETLB_PAGE
 	if (PageHuge(page)) {
 		struct hstate *h = page_hstate(page);
+
+		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
 		/*
 		 * We don't want to dequeue from the pool because pool pages will
 		 * mostly be from the CMA region.
@@ -1644,11 +1648,6 @@ static struct page *new_non_cma_page(struct page *page, unsigned long private)
 		 */
 		gfp_t thp_gfpmask = GFP_TRANSHUGE | __GFP_NOWARN;
 
-		/*
-		 * Remove the movable mask so that we don't allocate from
-		 * CMA area again.
-		 */
-		thp_gfpmask &= ~__GFP_MOVABLE;
 		thp = __alloc_pages_node(nid, thp_gfpmask, HPAGE_PMD_ORDER);
 		if (!thp)
 			return NULL;
@@ -1794,7 +1793,6 @@ static long __gup_longterm_locked(struct task_struct *tsk,
 				     vmas_tmp, NULL, gup_flags);
 
 	if (gup_flags & FOLL_LONGTERM) {
-		memalloc_nocma_restore(flags);
 		if (rc < 0)
 			goto out;
 
@@ -1807,9 +1805,10 @@ static long __gup_longterm_locked(struct task_struct *tsk,
 
 		rc = check_and_migrate_cma_pages(tsk, mm, start, rc, pages,
 						 vmas_tmp, gup_flags);
+out:
+		memalloc_nocma_restore(flags);
 	}
 
-out:
 	if (vmas_tmp != vmas)
 		kfree(vmas_tmp);
 	return rc;
-- 
2.7.4

