Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2CBC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 358A72081A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eq0txyu2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgERBWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 21:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgERBWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 21:22:00 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE50C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 18:21:59 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id s69so4338598pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 18:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iQHut3TWDpS+1BbAQqnoumWntS6DRZLFGDslgYPZ4Rg=;
        b=eq0txyu2Ftx04gtPzCcrZv9oqtdu6gNNNK2so7t2no0Y1RGxazrPHc1+d76NBLgDVD
         1owbvFTrlzmCvDGLeY6SLFzUqsNXhM1+xLwQ3/cR0roYz58oBPMV/9agtNpGn8g9Mxi4
         2ENRKxudLVWFx/bIPXUiszi4FUTOboW2PBN9CqUZRpcGXgz5a/z2FJ/QyXiOmN7JJ/gP
         dirI90dYsXwtA1SdOTvQFFMqqb26CYZC/o4KXNSkwHNvq73P6RduZw8M3VhWBHSjeyPy
         7wvaez7i/5xNGeeiX/CQs010NSjG1W1iGG3qOfwvVarjKpUcaskICjupZ0p5YB7ZgW5X
         /sTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iQHut3TWDpS+1BbAQqnoumWntS6DRZLFGDslgYPZ4Rg=;
        b=npGP6qAqJgAtJyjOfZQ4SJvkN15urjCXxw4hvmsvX8U6g1ospyNwwJe1Xw+Qs02DuE
         JxgtjBe6gU8GFjZRUYXV3ZSn4US55vDLmzw4t2Y5kwzm/c2H78OUiZ5T8vbzVNwEtb3E
         KWBTIQuW1zK41DzzcQDA//CU36lJMaca7KXFenILSuay+0+G0/+aAgb1qZ1lXlv6mMC5
         qDlgfyvps6vtqcF0ar3BiAwFHwyk4r6+iQ7k2vXUfWSoE5r7gN5z5kvIhwLadrq7YMip
         ekSf+mmAuYfT7rRgWqQ+c4Ioci9O7hNLTuY91h5tpXaX4c/VYwJqtng7ifbrEPP6ubW/
         HA2Q==
X-Gm-Message-State: AOAM5312Re6KruC01Qiu5ivGq9g8B/SePJzIxc2dpaDdM1NtwDTd+YL1
        wof3zPanVD622P9O2SuNtel7W/Ur
X-Google-Smtp-Source: ABdhPJwHx2hX6OBiQAwdJsZR3ZinBl6C7YdDZoo1I2M7LaNSjQ0Dt+eaBEgVh+xKlgw27CmAFAVuEQ==
X-Received: by 2002:a17:90a:8c98:: with SMTP id b24mr17146622pjo.226.1589764919331;
        Sun, 17 May 2020 18:21:59 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id fw4sm1544376pjb.31.2020.05.17.18.21.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 May 2020 18:21:58 -0700 (PDT)
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
Subject: [PATCH 06/11] mm/hugetlb: do not modify user provided gfp_mask
Date:   Mon, 18 May 2020 10:20:52 +0900
Message-Id: <1589764857-6800-7-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
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
 mm/hugetlb.c  | 15 ++++++++-------
 mm/internal.h |  2 ++
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 53edd02..5f43b7e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1069,15 +1069,15 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h,
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
@@ -1952,7 +1952,7 @@ static struct page *alloc_migrate_huge_page(struct hstate *h,
 	if (hstate_is_gigantic(h))
 		return NULL;
 
-	page = alloc_fresh_huge_page(h, ac->gfp_mask,
+	page = alloc_fresh_huge_page(h, ac->__gfp_mask,
 				ac->nid, ac->nmask, NULL);
 	if (!page)
 		return NULL;
@@ -1990,9 +1990,10 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 struct page *alloc_huge_page_nodemask(struct hstate *h,
 				struct alloc_control *ac)
 {
-	ac->gfp_mask |= htlb_alloc_mask(h);
+	ac->__gfp_mask = htlb_alloc_mask(h);
+	ac->__gfp_mask |= ac->gfp_mask;
 	if (ac->thisnode && ac->nid != NUMA_NO_NODE)
-		ac->gfp_mask |= __GFP_THISNODE;
+		ac->__gfp_mask |= __GFP_THISNODE;
 
 	spin_lock(&hugetlb_lock);
 	if (h->free_huge_pages - h->resv_huge_pages > 0) {
@@ -2011,7 +2012,7 @@ struct page *alloc_huge_page_nodemask(struct hstate *h,
 	 * will not come from CMA area
 	 */
 	if (ac->skip_cma)
-		ac->gfp_mask &= ~__GFP_MOVABLE;
+		ac->__gfp_mask &= ~__GFP_MOVABLE;
 
 	return alloc_migrate_huge_page(h, ac);
 }
diff --git a/mm/internal.h b/mm/internal.h
index 6b6507e..3239d71 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -620,6 +620,8 @@ struct alloc_control {
 	gfp_t gfp_mask;
 	bool thisnode;
 	bool skip_cma;
+
+	gfp_t __gfp_mask;	/* Used internally in API implementation */
 };
 
 #endif	/* __MM_INTERNAL_H */
-- 
2.7.4

