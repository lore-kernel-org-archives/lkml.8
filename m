Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A1DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 00:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5671221835
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 00:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQPxLdQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgGNAqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 20:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgGNAqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 20:46:23 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E85FC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 17:46:23 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id cm21so738719pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 17:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8r/ns8NnPKy/N7dekyAtGhBhg3kPMPGKsLiPQZHspAw=;
        b=ZQPxLdQSGc9aLdz33XfX1RgGKLsU5G2wrmPVsGFyoS3O1KDm0IftWv07HOyAfMV3bP
         SObIsdaSylKu2ynf10yuPVxITQDbBC1DdgS2PCb3T78ZpH8Nv/FeLR11L3cytvei9btw
         vBpxR6lv2HNNL6EN5vVMAPQqYuNYRKgLn62IGap2xK51JrTlcv/wKoBNdR3tT+DZGMVR
         uCUjh5YWY4v0PdDSQGcq31mZMnk9VNglt88HcP15dxIdI5P/v+mDEWWqGHpPs6Ljdfuf
         6KfRXqf9HRtI8mwim5UdbC450t7o4C2pV/18efKoRNdm68uzD5z9SLeSbvsGQMIjkJxu
         oxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8r/ns8NnPKy/N7dekyAtGhBhg3kPMPGKsLiPQZHspAw=;
        b=pU9F4N7T0bJzFxEDWLOHbG/NoCzbZKp0z8hFO2M0f8IVA8zrvLS29qS+fcG1Fh8rAP
         Mg1p74Oonh+0TzQm0shrFwoai+LCL8eSqLlS+ngkILbQPm8EParmhDM3l+cllfxnQ+C3
         pfWIlmHoGwUo82LTAJJ7CVutyeLoQ0i3r9dB2qo1sdkPQW0pgZ03LBo7glznrID9M0Kz
         J6S8aBbr9MdVQYLB0hHGW9EsmpaLQGVGG8iWcni8ZTVzGkyyLTOXRvWtd6jLX7QWDvxk
         MYxfmauHUd9xeB1jpnPsxVsQL+GuL+e7oa4BnN/D7kbzWWlB0d80gmbK3BpeYX7e/ZJO
         KiEA==
X-Gm-Message-State: AOAM533sySj8jgPsJkfzmkRlQmbI70v9Vdm3Zb53HEUtE5Jjc255jMf9
        LID2eUwSQCL+zpBX+LnAuPY=
X-Google-Smtp-Source: ABdhPJxoJWNGsurXWkvbIx0NyIPyzBIdPeemYoJ0GNNN1dKoyCp+IEp5xxA6eXIBYpj3KoARnktZpA==
X-Received: by 2002:a17:902:b589:: with SMTP id a9mr1705217pls.98.1594687583175;
        Mon, 13 Jul 2020 17:46:23 -0700 (PDT)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id c1sm634729pje.9.2020.07.13.17.46.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2020 17:46:22 -0700 (PDT)
Date:   Tue, 14 Jul 2020 09:46:17 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v5 5/9] mm/migrate: make a standard migration target
 allocation function
Message-ID: <20200714004616.GB7891@js1304-desktop>
References: <1594622517-20681-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594622517-20681-6-git-send-email-iamjoonsoo.kim@lge.com>
 <641fa691-ce77-7eae-75e5-452c0a111ae9@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <641fa691-ce77-7eae-75e5-452c0a111ae9@suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 09:53:40AM +0200, Vlastimil Babka wrote:
> On 7/13/20 8:41 AM, js1304@gmail.com wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> Nit: s/make/introduce/ in the subject, is a more common verb in this context.
> 

Thanks for correcting!
Following is fixed version.

Thanks.

----------------->8-------------------
From e8e4533bbc56fff3a77d5bc9a40dda7a9efc83e8 Mon Sep 17 00:00:00 2001
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Date: Wed, 1 Jul 2020 16:19:18 +1000
Subject: [PATCH v5 5/9] mm/migrate: introduce a standard migration target
 allocation function

There are some similar functions for migration target allocation.  Since
there is no fundamental difference, it's better to keep just one rather
than keeping all variants.  This patch implements base migration target
allocation function.  In the following patches, variants will be converted
to use this function.

Changes should be mechanical, but, unfortunately, there are some
differences. First, some callers' nodemask is assgined to NULL since NULL
nodemask will be considered as all available nodes, that is,
&node_states[N_MEMORY]. Second, for hugetlb page allocation, gfp_mask is
redefined as regular hugetlb allocation gfp_mask plus __GFP_THISNODE if
user provided gfp_mask has it. This is because future caller of this
function requires to set this node constaint. Lastly, if provided nodeid
is NUMA_NO_NODE, nodeid is set up to the node where migration source
lives. It helps to remove simple wrappers for setting up the nodeid.

Note that PageHighmem() call in previous function is changed to open-code
"is_highmem_idx()" since it provides more readability.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/hugetlb.h | 15 +++++++++++++++
 include/linux/migrate.h |  9 +++++----
 mm/internal.h           |  7 +++++++
 mm/memory-failure.c     |  7 +++++--
 mm/memory_hotplug.c     | 12 ++++++++----
 mm/migrate.c            | 26 ++++++++++++++++----------
 mm/page_isolation.c     |  7 +++++--
 7 files changed, 61 insertions(+), 22 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index bb93e95..6b9508d 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -701,6 +701,16 @@ static inline gfp_t htlb_alloc_mask(struct hstate *h)
 		return GFP_HIGHUSER;
 }
 
+static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
+{
+	gfp_t modified_mask = htlb_alloc_mask(h);
+
+	/* Some callers might want to enfoce node */
+	modified_mask |= (gfp_mask & __GFP_THISNODE);
+
+	return modified_mask;
+}
+
 static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
 					   struct mm_struct *mm, pte_t *pte)
 {
@@ -888,6 +898,11 @@ static inline gfp_t htlb_alloc_mask(struct hstate *h)
 	return 0;
 }
 
+static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
+{
+	return 0;
+}
+
 static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
 					   struct mm_struct *mm, pte_t *pte)
 {
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 1d70b4a..cc56f0d 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -10,6 +10,8 @@
 typedef struct page *new_page_t(struct page *page, unsigned long private);
 typedef void free_page_t(struct page *page, unsigned long private);
 
+struct migration_target_control;
+
 /*
  * Return values from addresss_space_operations.migratepage():
  * - negative errno on page migration failure;
@@ -39,8 +41,7 @@ extern int migrate_page(struct address_space *mapping,
 			enum migrate_mode mode);
 extern int migrate_pages(struct list_head *l, new_page_t new, free_page_t free,
 		unsigned long private, enum migrate_mode mode, int reason);
-extern struct page *new_page_nodemask(struct page *page,
-		int preferred_nid, nodemask_t *nodemask);
+extern struct page *alloc_migration_target(struct page *page, unsigned long private);
 extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
 extern void putback_movable_page(struct page *page);
 
@@ -59,8 +60,8 @@ static inline int migrate_pages(struct list_head *l, new_page_t new,
 		free_page_t free, unsigned long private, enum migrate_mode mode,
 		int reason)
 	{ return -ENOSYS; }
-static inline struct page *new_page_nodemask(struct page *page,
-		int preferred_nid, nodemask_t *nodemask)
+static inline struct page *alloc_migration_target(struct page *page,
+		unsigned long private)
 	{ return NULL; }
 static inline int isolate_movable_page(struct page *page, isolate_mode_t mode)
 	{ return -EBUSY; }
diff --git a/mm/internal.h b/mm/internal.h
index dd14c53..0beacf3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -614,4 +614,11 @@ static inline bool is_migrate_highatomic_page(struct page *page)
 
 void setup_zone_pageset(struct zone *zone);
 extern struct page *alloc_new_node_page(struct page *page, unsigned long node);
+
+struct migration_target_control {
+	int nid;		/* preferred node id */
+	nodemask_t *nmask;
+	gfp_t gfp_mask;
+};
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index c5e4cee..609d42b6 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1679,9 +1679,12 @@ EXPORT_SYMBOL(unpoison_memory);
 
 static struct page *new_page(struct page *p, unsigned long private)
 {
-	int nid = page_to_nid(p);
+	struct migration_target_control mtc = {
+		.nid = page_to_nid(p),
+		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
+	};
 
-	return new_page_nodemask(p, nid, &node_states[N_MEMORY]);
+	return alloc_migration_target(p, (unsigned long)&mtc);
 }
 
 /*
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index cafe65eb..431b470f 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1267,19 +1267,23 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 
 static struct page *new_node_page(struct page *page, unsigned long private)
 {
-	int nid = page_to_nid(page);
 	nodemask_t nmask = node_states[N_MEMORY];
+	struct migration_target_control mtc = {
+		.nid = page_to_nid(page),
+		.nmask = &nmask,
+		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
+	};
 
 	/*
 	 * try to allocate from a different node but reuse this node if there
 	 * are no other online nodes to be used (e.g. we are offlining a part
 	 * of the only existing node)
 	 */
-	node_clear(nid, nmask);
+	node_clear(mtc.nid, nmask);
 	if (nodes_empty(nmask))
-		node_set(nid, nmask);
+		node_set(mtc.nid, nmask);
 
-	return new_page_nodemask(page, nid, &nmask);
+	return alloc_migration_target(page, (unsigned long)&mtc);
 }
 
 static int
diff --git a/mm/migrate.c b/mm/migrate.c
index faabb2e..8a1ab4f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1531,19 +1531,26 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	return rc;
 }
 
-struct page *new_page_nodemask(struct page *page,
-				int preferred_nid, nodemask_t *nodemask)
+struct page *alloc_migration_target(struct page *page, unsigned long private)
 {
-	gfp_t gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL;
+	struct migration_target_control *mtc;
+	gfp_t gfp_mask;
 	unsigned int order = 0;
 	struct page *new_page = NULL;
+	int nid;
+	int zidx;
+
+	mtc = (struct migration_target_control *)private;
+	gfp_mask = mtc->gfp_mask;
+	nid = mtc->nid;
+	if (nid == NUMA_NO_NODE)
+		nid = page_to_nid(page);
 
 	if (PageHuge(page)) {
 		struct hstate *h = page_hstate(compound_head(page));
 
-		gfp_mask = htlb_alloc_mask(h);
-		return alloc_huge_page_nodemask(h, preferred_nid,
-						nodemask, gfp_mask);
+		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
+		return alloc_huge_page_nodemask(h, nid, mtc->nmask, gfp_mask);
 	}
 
 	if (PageTransHuge(page)) {
@@ -1555,12 +1562,11 @@ struct page *new_page_nodemask(struct page *page,
 		gfp_mask |= GFP_TRANSHUGE;
 		order = HPAGE_PMD_ORDER;
 	}
-
-	if (PageHighMem(page) || (zone_idx(page_zone(page)) == ZONE_MOVABLE))
+	zidx = zone_idx(page_zone(page));
+	if (is_highmem_idx(zidx) || zidx == ZONE_MOVABLE)
 		gfp_mask |= __GFP_HIGHMEM;
 
-	new_page = __alloc_pages_nodemask(gfp_mask, order,
-				preferred_nid, nodemask);
+	new_page = __alloc_pages_nodemask(gfp_mask, order, nid, mtc->nmask);
 
 	if (new_page && PageTransHuge(new_page))
 		prep_transhuge_page(new_page);
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index aec26d9..f25c66e 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -309,7 +309,10 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
 
 struct page *alloc_migrate_target(struct page *page, unsigned long private)
 {
-	int nid = page_to_nid(page);
+	struct migration_target_control mtc = {
+		.nid = page_to_nid(page),
+		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
+	};
 
-	return new_page_nodemask(page, nid, &node_states[N_MEMORY]);
+	return alloc_migration_target(page, (unsigned long)&mtc);
 }
-- 
2.7.4

