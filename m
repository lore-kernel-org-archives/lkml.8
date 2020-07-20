Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04B8C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 04:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 778B3208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 04:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFpbckre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgGTE4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 00:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgGTE4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 00:56:43 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52196C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 21:56:43 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a9so3928288pjd.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 21:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6T4ckSsZ++LqrnzC/uPhVjgqnIBWQvL35D2sUMWK8Tg=;
        b=oFpbckrehHKNjQ5nru1ES2yGLxqqSLK5L5lJmzdiGFfSEJGJNJdAKSV2GVZdBdCYXX
         Tya5ytu7LuHZ2+kAWDgTNVPWMpLPOanDHTGHKbbsFhxvn+1vZ/LaKKuSN5NKdp2h+HTW
         BF82C5v7weukHbzgqHPKdYrubSNkA8Zi/4gqBpvFMjtyFfc/P2fNtrGvMut1LcS4Ot9V
         6AH7kYnCxec23v+adA0H+FqzjmQiyLFtC2lTtzha4RmHYUudOQhYoYC3NHZt4o6kpK5h
         SGVhYAjg4pSuIuOUEZaZnu5TEt0nNHLgumpUhPpbi0mUa2whimYd4dr4+jTGtCJDZDXP
         GnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6T4ckSsZ++LqrnzC/uPhVjgqnIBWQvL35D2sUMWK8Tg=;
        b=qqKMVSADvR8GS/q0VH4UJUQsHWWzCWWZQ3dWmnUufglfWubiDK0XPRj6f106h60dAu
         F8n10jWkDLR6PAyyHlDetMC+CrpiF0Hh72MbxAtOIjaZdcDLbL/jFMuG0BKCd4EEYxzx
         UvYrLG6qan7VeoX1fQe3+gb9cvfv9KwEIZ0jNtsoDJ98nd6moPgWHBkP1pVEiMDSKdYg
         SOBtrNyaS+iGYN6kjiniqimbbepYQS7RZq55Cxh/YkYaA2LgzKwEFHXF+FCenyNccgfd
         KaQMqnCQwaOeT6bc9VtCDy1ZJF5jEvFobUGTOdFd4YOJgp+7jI2MyarNBKQu9QRIOxwJ
         yWAw==
X-Gm-Message-State: AOAM532nIH+JXYOxOW0+k2bSygFVQv0SG6UwV4aeWMhbQp6FhQ+qrIMz
        8BQ9M3rjy0eA2JvWn8ugpg4=
X-Google-Smtp-Source: ABdhPJwdjWvXbkGWr5ACNkkfZ7eSlgvM1o6o25cnPfXKv31seCcjpQZVE1lH3ZNZnGLDQU3hgAKTtA==
X-Received: by 2002:a17:902:d90e:: with SMTP id c14mr17249926plz.335.1595221002831;
        Sun, 19 Jul 2020 21:56:42 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id w2sm10177532pjt.19.2020.07.19.21.56.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jul 2020 21:56:42 -0700 (PDT)
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
Subject: [PATCH v2 2/4] mm/gup: restrict CMA region by using allocation scope API
Date:   Mon, 20 Jul 2020 13:56:16 +0900
Message-Id: <1595220978-9890-2-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595220978-9890-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1595220978-9890-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

We have well defined scope API to exclude CMA region.
Use it rather than manipulating gfp_mask manually. With this change,
we can now restore __GFP_MOVABLE for gfp_mask like as usual migration
target allocation. It would result in that the ZONE_MOVABLE is also
searched by page allocator. For hugetlb, gfp_mask is redefined since
it has a regular allocation mask filter for migration target.
__GPF_NOWARN is added to hugetlb gfp_mask filter since a new user for
gfp_mask filter, gup, want to be silent when allocation fails.

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

