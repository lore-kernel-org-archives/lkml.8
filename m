Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C947DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F20B2468B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NceLJVdk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgA0RjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 12:39:10 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48942 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726145AbgA0RjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 12:39:08 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00RHZRO1009383
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 09:39:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=uw3wz1B91RA7nt6TdvjYf5deKOZUSUdGUffGtryAnA8=;
 b=NceLJVdkkuq4XlinRDuHAyQKpSrwvISz0sJBsadhYPXfi7hyHtSQAKkmysESkIc2PI0l
 HIDI5k6FkbxkVI8ginMjiEOlTLNoz3lykdSLqTNB898pFmWLg8UroHC/BaGNJ7z21g1b
 gpOeuTvbe/ToLFeayfuIS3HyLFQUehr2Qcw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xsw9njqgt-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 09:39:06 -0800
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 27 Jan 2020 09:39:02 -0800
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id B60B11DFEFC90; Mon, 27 Jan 2020 09:35:07 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Yafang Shao <laoar.shao@gmail.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 14/28] mm: memcontrol: decouple reference counting from page accounting
Date:   Mon, 27 Jan 2020 09:34:39 -0800
Message-ID: <20200127173453.2089565-15-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127173453.2089565-1-guro@fb.com>
References: <20200127173453.2089565-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-27_06:2020-01-24,2020-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 impostorscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001270141
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Weiner <hannes@cmpxchg.org>

The reference counting of a memcg is currently coupled directly to how
many 4k pages are charged to it. This doesn't work well with Roman's
new slab controller, which maintains pools of objects and doesn't want
to keep an extra balance sheet for the pages backing those objects.

This unusual refcounting design (reference counts usually track
pointers to an object) is only for historical reasons: memcg used to
not take any css references and simply stalled offlining until all
charges had been reparented and the page counters had dropped to
zero. When we got rid of the reparenting requirement, the simple
mechanical translation was to take a reference for every charge.

More historical context can be found in commit e8ea14cc6ead ("mm:
memcontrol: take a css reference for each charged page"),
commit 64f219938941 ("mm: memcontrol: remove obsolete kmemcg pinning
tricks") and commit b2052564e66d ("mm: memcontrol: continue cache
reclaim from offlined groups").

The new slab controller exposes the limitations in this scheme, so
let's switch it to a more idiomatic reference counting model based on
actual kernel pointers to the memcg:

- The per-cpu stock holds a reference to the memcg its caching

- User pages hold a reference for their page->mem_cgroup. Transparent
  huge pages will no longer acquire tail references in advance, we'll
  get them if needed during the split.

- Kernel pages hold a reference for their page->mem_cgroup

- mem_cgroup_try_charge(), if successful, will return one reference to
  be consumed by page->mem_cgroup during commit, or put during cancel

- Pages allocated in the root cgroup will acquire and release css
  references for simplicity. css_get() and css_put() optimize that.

- The current memcg_charge_slab() already hacked around the per-charge
  references; this change gets rid of that as well.

Roman: I've reformatted commit references in the commit log to make
  checkpatch.pl happy.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Roman Gushchin <guro@fb.com>
---
 mm/memcontrol.c | 45 ++++++++++++++++++++++++++-------------------
 mm/slab.h       |  2 --
 2 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index bf846fb60d9f..b86cfdcf2e1d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2109,13 +2109,17 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 {
 	struct mem_cgroup *old = stock->cached;
 
+	if (!old)
+		return;
+
 	if (stock->nr_pages) {
 		page_counter_uncharge(&old->memory, stock->nr_pages);
 		if (do_memsw_account())
 			page_counter_uncharge(&old->memsw, stock->nr_pages);
-		css_put_many(&old->css, stock->nr_pages);
 		stock->nr_pages = 0;
 	}
+
+	css_put(&old->css);
 	stock->cached = NULL;
 }
 
@@ -2151,6 +2155,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	stock = this_cpu_ptr(&memcg_stock);
 	if (stock->cached != memcg) { /* reset if necessary */
 		drain_stock(stock);
+		css_get(&memcg->css);
 		stock->cached = memcg;
 	}
 	stock->nr_pages += nr_pages;
@@ -2554,12 +2559,10 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	page_counter_charge(&memcg->memory, nr_pages);
 	if (do_memsw_account())
 		page_counter_charge(&memcg->memsw, nr_pages);
-	css_get_many(&memcg->css, nr_pages);
 
 	return 0;
 
 done_restock:
-	css_get_many(&memcg->css, batch);
 	if (batch > nr_pages)
 		refill_stock(memcg, batch - nr_pages);
 
@@ -2596,8 +2599,6 @@ static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
 	page_counter_uncharge(&memcg->memory, nr_pages);
 	if (do_memsw_account())
 		page_counter_uncharge(&memcg->memsw, nr_pages);
-
-	css_put_many(&memcg->css, nr_pages);
 }
 
 static void lock_page_lru(struct page *page, int *isolated)
@@ -2948,6 +2949,7 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
 		if (!ret) {
 			page->mem_cgroup = memcg;
 			__SetPageKmemcg(page);
+			return 0;
 		}
 	}
 	css_put(&memcg->css);
@@ -2970,12 +2972,11 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 	VM_BUG_ON_PAGE(mem_cgroup_is_root(memcg), page);
 	__memcg_kmem_uncharge(memcg, nr_pages);
 	page->mem_cgroup = NULL;
+	css_put(&memcg->css);
 
 	/* slab pages do not have PageKmemcg flag set */
 	if (PageKmemcg(page))
 		__ClearPageKmemcg(page);
-
-	css_put_many(&memcg->css, nr_pages);
 }
 #endif /* CONFIG_MEMCG_KMEM */
 
@@ -2987,15 +2988,18 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
  */
 void mem_cgroup_split_huge_fixup(struct page *head)
 {
+	struct mem_cgroup *memcg = head->mem_cgroup;
 	int i;
 
 	if (mem_cgroup_disabled())
 		return;
 
-	for (i = 1; i < HPAGE_PMD_NR; i++)
-		head[i].mem_cgroup = head->mem_cgroup;
+	for (i = 1; i < HPAGE_PMD_NR; i++) {
+		css_get(&memcg->css);
+		head[i].mem_cgroup = memcg;
+	}
 
-	__mod_memcg_state(head->mem_cgroup, MEMCG_RSS_HUGE, -HPAGE_PMD_NR);
+	__mod_memcg_state(memcg, MEMCG_RSS_HUGE, -HPAGE_PMD_NR);
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
@@ -5401,7 +5405,9 @@ static int mem_cgroup_move_account(struct page *page,
 	 * uncharging, charging, migration, or LRU putback.
 	 */
 
-	/* caller should have done css_get */
+	css_get(&to->css);
+	css_put(&from->css);
+
 	page->mem_cgroup = to;
 
 	spin_unlock_irqrestore(&from->move_lock, flags);
@@ -6420,8 +6426,10 @@ int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
 		memcg = get_mem_cgroup_from_mm(mm);
 
 	ret = try_charge(memcg, gfp_mask, nr_pages);
-
-	css_put(&memcg->css);
+	if (ret) {
+		css_put(&memcg->css);
+		memcg = NULL;
+	}
 out:
 	*memcgp = memcg;
 	return ret;
@@ -6517,6 +6525,8 @@ void mem_cgroup_cancel_charge(struct page *page, struct mem_cgroup *memcg,
 		return;
 
 	cancel_charge(memcg, nr_pages);
+
+	css_put(&memcg->css);
 }
 
 struct uncharge_gather {
@@ -6558,9 +6568,6 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, nr_pages);
 	memcg_check_events(ug->memcg, ug->dummy_page);
 	local_irq_restore(flags);
-
-	if (!mem_cgroup_is_root(ug->memcg))
-		css_put_many(&ug->memcg->css, nr_pages);
 }
 
 static void uncharge_page(struct page *page, struct uncharge_gather *ug)
@@ -6608,6 +6615,7 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 
 	ug->dummy_page = page;
 	page->mem_cgroup = NULL;
+	css_put(&ug->memcg->css);
 }
 
 static void uncharge_list(struct list_head *page_list)
@@ -6714,8 +6722,8 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 	page_counter_charge(&memcg->memory, nr_pages);
 	if (do_memsw_account())
 		page_counter_charge(&memcg->memsw, nr_pages);
-	css_get_many(&memcg->css, nr_pages);
 
+	css_get(&memcg->css);
 	commit_charge(newpage, memcg, false);
 
 	local_irq_save(flags);
@@ -6964,8 +6972,7 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 				     -nr_entries);
 	memcg_check_events(memcg, page);
 
-	if (!mem_cgroup_is_root(memcg))
-		css_put_many(&memcg->css, nr_entries);
+	css_put(&memcg->css);
 }
 
 /**
diff --git a/mm/slab.h b/mm/slab.h
index 517f1f1359e5..7925f7005161 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -373,9 +373,7 @@ static __always_inline int memcg_charge_slab(struct page *page,
 	lruvec = mem_cgroup_lruvec(memcg, page_pgdat(page));
 	mod_lruvec_state(lruvec, cache_vmstat_idx(s), nr_pages << PAGE_SHIFT);
 
-	/* transer try_charge() page references to kmem_cache */
 	percpu_ref_get_many(&s->memcg_params.refcnt, 1 << order);
-	css_put_many(&memcg->css, 1 << order);
 out:
 	css_put(&memcg->css);
 	return ret;
-- 
2.24.1

