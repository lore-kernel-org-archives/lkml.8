Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACABC33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 20:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D515D20748
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 20:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Z3oxhV5S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbgAQUgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 15:36:24 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:26356 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727519AbgAQUgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 15:36:23 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00HKZf7h023418
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 12:36:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=hDGxqiK9MoilwkNOzptNQtkbF8H3gvrJmRANzCXz/nk=;
 b=Z3oxhV5SUlgdw+m6yhypFCDNhf0B1oAcbVOG8usu7Y3q775O1yW1UWnYr+yuLtWJovtU
 HN4sevBgdJ5B3I7I8HPlMCV6cbPSN8rLODKRaqbzfZvf5X5IOjPUCOT2cQRr4zw9+hE7
 Kroyjv751pF3fCTuCpbFDiuFsELEUM+3y54= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xk0sbvk9k-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 12:36:22 -0800
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Jan 2020 12:36:21 -0800
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 8B7B71D8A5CD9; Fri, 17 Jan 2020 12:36:15 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH] mm: memcg/slab: introduce mem_cgroup_from_obj()
Date:   Fri, 17 Jan 2020 12:36:09 -0800
Message-ID: <20200117203609.3146239-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_05:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=538 lowpriorityscore=0 phishscore=0 mlxscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001170157
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes we need to get a memcg pointer from a charged kernel object.
The right way to get it depends on whether it's a proper slab object
or it's backed by raw pages (e.g. it's a vmalloc alloction). In the
first case the kmem_cache->memcg_params.memcg indirection should be
used; in other cases it's just page->mem_cgroup.

To simplify this task and hide the implementation details let's
introduce a mem_cgroup_from_obj() helper, which takes a pointer
to any kernel object and returns a valid memcg pointer or NULL.

Passing a kernel address rather than a pointer to a page will allow
to use this helper for per-object (rather than per-page) tracked
objects in the future.

The caller is still responsible to ensure that the returned memcg
isn't going away underneath: take the rcu read lock, cgroup mutex etc;
depending on the context.

mem_cgroup_from_kmem() defined in mm/list_lru.c is now obsolete
and can be removed.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/memcontrol.h |  7 +++++++
 mm/list_lru.c              | 12 +-----------
 mm/memcontrol.c            | 32 +++++++++++++++++++++++++++++---
 3 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a7a0a1a5c8d5..292729a1b8c6 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -420,6 +420,8 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *, struct pglist_data *);
 
 struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
 
+struct mem_cgroup *mem_cgroup_from_obj(void *p);
+
 struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
 
 struct mem_cgroup *get_mem_cgroup_from_page(struct page *page);
@@ -912,6 +914,11 @@ static inline bool mm_match_cgroup(struct mm_struct *mm,
 	return true;
 }
 
+static inline struct mem_cgroup *mem_cgroup_from_obj(void *p)
+{
+	return NULL;
+}
+
 static inline struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 {
 	return NULL;
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 0f1f6b06b7f3..8de5e3784ee4 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -57,16 +57,6 @@ list_lru_from_memcg_idx(struct list_lru_node *nlru, int idx)
 	return &nlru->lru;
 }
 
-static __always_inline struct mem_cgroup *mem_cgroup_from_kmem(void *ptr)
-{
-	struct page *page;
-
-	if (!memcg_kmem_enabled())
-		return NULL;
-	page = virt_to_head_page(ptr);
-	return memcg_from_slab_page(page);
-}
-
 static inline struct list_lru_one *
 list_lru_from_kmem(struct list_lru_node *nlru, void *ptr,
 		   struct mem_cgroup **memcg_ptr)
@@ -77,7 +67,7 @@ list_lru_from_kmem(struct list_lru_node *nlru, void *ptr,
 	if (!nlru->memcg_lrus)
 		goto out;
 
-	memcg = mem_cgroup_from_kmem(ptr);
+	memcg = mem_cgroup_from_obj(ptr);
 	if (!memcg)
 		goto out;
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d4394ae4e5be..e768e8d87704 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -757,13 +757,12 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 
 void __mod_lruvec_slab_state(void *p, enum node_stat_item idx, int val)
 {
-	struct page *page = virt_to_head_page(p);
-	pg_data_t *pgdat = page_pgdat(page);
+	pg_data_t *pgdat = page_pgdat(virt_to_page(p));
 	struct mem_cgroup *memcg;
 	struct lruvec *lruvec;
 
 	rcu_read_lock();
-	memcg = memcg_from_slab_page(page);
+	memcg = mem_cgroup_from_obj(p);
 
 	/* Untracked pages have no memcg, no lruvec. Update only the node */
 	if (!memcg || memcg == root_mem_cgroup) {
@@ -2635,6 +2634,33 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg,
 		unlock_page_lru(page, isolated);
 }
 
+/*
+ * Returns a pointer to the memory cgroup to which the kernel object is charged.
+ *
+ * The caller must ensure the memcg lifetime, e.g. by taking rcu_read_lock(),
+ * cgroup_mutex, etc.
+ */
+struct mem_cgroup *mem_cgroup_from_obj(void *p)
+{
+	struct page *page;
+
+	if (mem_cgroup_disabled())
+		return NULL;
+
+	page = virt_to_head_page(p);
+
+	/*
+	 * Slab pages don't have page->mem_cgroup set because corresponding
+	 * kmem caches can be reparented during the lifetime. That's why
+	 * memcg_from_slab_page() should be used instead.
+	 */
+	if (PageSlab(page))
+		return memcg_from_slab_page(page);
+
+	/* All other pages use page->mem_cgroup */
+	return page->mem_cgroup;
+}
+
 #ifdef CONFIG_MEMCG_KMEM
 static int memcg_alloc_cache_id(void)
 {
-- 
2.17.1

