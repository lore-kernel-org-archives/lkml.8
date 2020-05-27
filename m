Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1A0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B6BB2078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tzBJKgcr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgE0GqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728922AbgE0GqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:46:06 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479C3C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:46:06 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so9771502plo.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9LDEnEE9QhDOeHTlIwa2z+W01UqV86cX8ZD9BLZd34E=;
        b=tzBJKgcr4nmONT9GXvy3mUmwBAk7zW5rre+qsQaDU0KgFF+MSzPR0tY2StMtSxM8WF
         TB8QMQvFVRgZ+i4XBxLLwZSVZMNEQr9dn6oIi3RzEMPoeZ+kVDoOYRfMpxOsFeCgvAMf
         1jX0j5b3wi6f5UomplwO630ZCNrwYw+IfyepnSK09vrE66SYxTrbNnJVkmujtYcX/VMG
         KEIzt93mt1e+uRjIXWjebqnnJwgrI1PtfwQoekkoVkvkL7lVFreYh5DdlZzNZj+TRSn0
         LC9/8eTwuN3zeWwiAzXOP3eUPS+96CX7esqKsPvGqeKWXE/XP8Yn60MgLJgA5weo74l9
         kSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9LDEnEE9QhDOeHTlIwa2z+W01UqV86cX8ZD9BLZd34E=;
        b=eu5rQvB2kFaFDoqGdtnQJgCnAHxIImDihKOiwWmQp/MANde08TKJ9yuZyI8M2WJ7+X
         FpAN7yjMTt/r5MiWGtEN9bn8NW8cfd37s7vgMCbbNWz8O6J2qMM51vDDhXbw9c+6je3p
         79kshO7V+tdASFbV77leW9rd2eRcfS1fTRhVMubyR7ZDe+OkdPSgkYNqUV4DW8GntOb9
         vyNBNH+ZM0+hpbw5Zycbgxn8IvDwTa6xI+fV2nUBooTOHRP3qIhj2QAPMP6bfXLBZHHr
         RS6DfuBL+arVZTJnV5SVZyNhsdm3TgEekEp0xgwvn11Ia1fwseFYrHTyFN2elWrqjrz/
         6SMw==
X-Gm-Message-State: AOAM533JoSwDV/4nec3/xuSyK71iYFXTU+S8PkFMMCgdqBI1CRodriDm
        PDCmx3DwfxwRZAzw2FLJFSo=
X-Google-Smtp-Source: ABdhPJzB71n34Heyi5DLHTm42TG3LW+iWREnYIWRmMlUWSq6mcItE+jZ9jeojZ/7igAhJQrkS4cWcA==
X-Received: by 2002:a17:902:422:: with SMTP id 31mr4705136ple.310.1590561965761;
        Tue, 26 May 2020 23:46:05 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id r13sm443883pgv.50.2020.05.26.23.46.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 23:46:05 -0700 (PDT)
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
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v2 07/12] mm/hugetlb: do not modify user provided gfp_mask
Date:   Wed, 27 May 2020 15:44:58 +0900
Message-Id: <1590561903-13186-8-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

It's not good practice to modify user input. Instead of using it to
build correct gfp_mask for APIs, this patch introduces another gfp_mask
field, __gfp_mask, for internal usage.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/hugetlb.c  | 19 ++++++++++---------
 mm/internal.h |  2 ++
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e465582..4757e72 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1068,15 +1068,15 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h,
 	struct zoneref *z;
 	int node = NUMA_NO_NODE;
 
-	zonelist = node_zonelist(ac->nid, ac->gfp_mask);
+	zonelist = node_zonelist(ac->nid, ac->__gfp_mask);
 
 retry_cpuset:
 	cpuset_mems_cookie = read_mems_allowed_begin();
 	for_each_zone_zonelist_nodemask(zone, z, zonelist,
-			gfp_zone(ac->gfp_mask), ac->nmask) {
+			gfp_zone(ac->__gfp_mask), ac->nmask) {
 		struct page *page;
 
-		if (!cpuset_zone_allowed(zone, ac->gfp_mask))
+		if (!cpuset_zone_allowed(zone, ac->__gfp_mask))
 			continue;
 		/*
 		 * no need to ask again on the same node. Pool is node rather than
@@ -1127,8 +1127,8 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 	if (avoid_reserve && h->free_huge_pages - h->resv_huge_pages == 0)
 		goto err;
 
-	ac.gfp_mask = htlb_alloc_mask(h);
-	ac.nid = huge_node(vma, address, ac.gfp_mask, &mpol, &ac.nmask);
+	ac.__gfp_mask = htlb_alloc_mask(h);
+	ac.nid = huge_node(vma, address, ac.__gfp_mask, &mpol, &ac.nmask);
 
 	page = dequeue_huge_page_nodemask(h, &ac);
 	if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
@@ -1951,7 +1951,7 @@ static struct page *alloc_migrate_huge_page(struct hstate *h,
 	if (hstate_is_gigantic(h))
 		return NULL;
 
-	page = alloc_fresh_huge_page(h, ac->gfp_mask,
+	page = alloc_fresh_huge_page(h, ac->__gfp_mask,
 				ac->nid, ac->nmask, NULL);
 	if (!page)
 		return NULL;
@@ -1989,9 +1989,10 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 struct page *alloc_huge_page_nodemask(struct hstate *h,
 				struct alloc_control *ac)
 {
-	ac->gfp_mask |= htlb_alloc_mask(h);
+	ac->__gfp_mask = htlb_alloc_mask(h);
+	ac->__gfp_mask |= ac->gfp_mask;
 	if (ac->nid == NUMA_NO_NODE)
-		ac->gfp_mask &= ~__GFP_THISNODE;
+		ac->__gfp_mask &= ~__GFP_THISNODE;
 
 	spin_lock(&hugetlb_lock);
 	if (h->free_huge_pages - h->resv_huge_pages > 0) {
@@ -2010,7 +2011,7 @@ struct page *alloc_huge_page_nodemask(struct hstate *h,
 	 * will not come from CMA area
 	 */
 	if (ac->skip_cma)
-		ac->gfp_mask &= ~__GFP_MOVABLE;
+		ac->__gfp_mask &= ~__GFP_MOVABLE;
 
 	return alloc_migrate_huge_page(h, ac);
 }
diff --git a/mm/internal.h b/mm/internal.h
index 159cfd6..2dc0268 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -619,6 +619,8 @@ struct alloc_control {
 	nodemask_t *nmask;
 	gfp_t gfp_mask;
 	bool skip_cma;
+
+	gfp_t __gfp_mask;	/* Used internally in API implementation */
 };
 
 #endif	/* __MM_INTERNAL_H */
-- 
2.7.4

