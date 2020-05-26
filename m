Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35823C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C48920C56
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="rOQ8kAGM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390929AbgEZVmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 17:42:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52622 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390445AbgEZVmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 17:42:45 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04QLcXYd015428
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:42:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=iRL+uSyt6foI7ReBZ2mz0Zh7nw7JAMHZmsXeznh0goI=;
 b=rOQ8kAGMh+0TaF2S32UgYtTzRP37vXtzqkHZUlkHDS8/FfpGKQMNZqeDuYrcOHR8WOQy
 3yRhZsYUoOKmUsZj6Qy3/U9XhUb5XsqEdOzKQjwCWaP86M6tSbWpuSikdKFmQS4XLOKm
 ObP+Xn7iCf08ml/mNQEwIR+KvVXsPmlFa00= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3171nhmx1g-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:42:43 -0700
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 26 May 2020 14:42:42 -0700
Received: by devvm1291.vll0.facebook.com (Postfix, from userid 111017)
        id 51A4315EA7D0; Tue, 26 May 2020 14:42:33 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1291.vll0.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: vll0c01
Subject: [PATCH v4 05/19] mm: memcontrol: decouple reference counting from page accounting
Date:   Tue, 26 May 2020 14:42:13 -0700
Message-ID: <20200526214227.989341-6-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200526214227.989341-1-guro@fb.com>
References: <20200526214227.989341-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-26_02:2020-05-26,2020-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 cotscore=-2147483648 priorityscore=1501 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260166
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

- Pages allocated in the root cgroup will acquire and release css
  references for simplicity. css_get() and css_put() optimize that.

- The current memcg_charge_slab() already hacked around the per-charge
  references; this change gets rid of that as well.

Roman:
1) Rebased on top of the current mm tree: added css_get() in
   mem_cgroup_charge(), dropped mem_cgroup_try_charge() part
2) I've reformatted commit references in the commit log to make
   checkpatch.pl happy.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Roman Gushchin <guro@fb.com>
---
 mm/memcontrol.c | 37 +++++++++++++++++++++----------------
 mm/slab.h       |  2 --
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b53dee2bb395..69705b2fa03f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2094,13 +2094,17 @@ static void drain_stock(struct memcg_stock_pcp *s=
tock)
 {
 	struct mem_cgroup *old =3D stock->cached;
=20
+	if (!old)
+		return;
+
 	if (stock->nr_pages) {
 		page_counter_uncharge(&old->memory, stock->nr_pages);
 		if (do_memsw_account())
 			page_counter_uncharge(&old->memsw, stock->nr_pages);
-		css_put_many(&old->css, stock->nr_pages);
 		stock->nr_pages =3D 0;
 	}
+
+	css_put(&old->css);
 	stock->cached =3D NULL;
 }
=20
@@ -2136,6 +2140,7 @@ static void refill_stock(struct mem_cgroup *memcg, =
unsigned int nr_pages)
 	stock =3D this_cpu_ptr(&memcg_stock);
 	if (stock->cached !=3D memcg) { /* reset if necessary */
 		drain_stock(stock);
+		css_get(&memcg->css);
 		stock->cached =3D memcg;
 	}
 	stock->nr_pages +=3D nr_pages;
@@ -2566,12 +2571,10 @@ static int try_charge(struct mem_cgroup *memcg, g=
fp_t gfp_mask,
 	page_counter_charge(&memcg->memory, nr_pages);
 	if (do_memsw_account())
 		page_counter_charge(&memcg->memsw, nr_pages);
-	css_get_many(&memcg->css, nr_pages);
=20
 	return 0;
=20
 done_restock:
-	css_get_many(&memcg->css, batch);
 	if (batch > nr_pages)
 		refill_stock(memcg, batch - nr_pages);
=20
@@ -2608,8 +2611,6 @@ static void cancel_charge(struct mem_cgroup *memcg,=
 unsigned int nr_pages)
 	page_counter_uncharge(&memcg->memory, nr_pages);
 	if (do_memsw_account())
 		page_counter_uncharge(&memcg->memsw, nr_pages);
-
-	css_put_many(&memcg->css, nr_pages);
 }
=20
 static void commit_charge(struct page *page, struct mem_cgroup *memcg)
@@ -2909,6 +2910,7 @@ int __memcg_kmem_charge_page(struct page *page, gfp=
_t gfp, int order)
 		if (!ret) {
 			page->mem_cgroup =3D memcg;
 			__SetPageKmemcg(page);
+			return 0;
 		}
 	}
 	css_put(&memcg->css);
@@ -2931,12 +2933,11 @@ void __memcg_kmem_uncharge_page(struct page *page=
, int order)
 	VM_BUG_ON_PAGE(mem_cgroup_is_root(memcg), page);
 	__memcg_kmem_uncharge(memcg, nr_pages);
 	page->mem_cgroup =3D NULL;
+	css_put(&memcg->css);
=20
 	/* slab pages do not have PageKmemcg flag set */
 	if (PageKmemcg(page))
 		__ClearPageKmemcg(page);
-
-	css_put_many(&memcg->css, nr_pages);
 }
 #endif /* CONFIG_MEMCG_KMEM */
=20
@@ -2948,13 +2949,16 @@ void __memcg_kmem_uncharge_page(struct page *page=
, int order)
  */
 void mem_cgroup_split_huge_fixup(struct page *head)
 {
+	struct mem_cgroup *memcg =3D head->mem_cgroup;
 	int i;
=20
 	if (mem_cgroup_disabled())
 		return;
=20
-	for (i =3D 1; i < HPAGE_PMD_NR; i++)
-		head[i].mem_cgroup =3D head->mem_cgroup;
+	for (i =3D 1; i < HPAGE_PMD_NR; i++) {
+		css_get(&memcg->css);
+		head[i].mem_cgroup =3D memcg;
+	}
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
=20
@@ -5398,7 +5402,10 @@ static int mem_cgroup_move_account(struct page *pa=
ge,
 	 */
 	smp_mb();
=20
-	page->mem_cgroup =3D to; 	/* caller should have done css_get */
+	css_get(&to->css);
+	css_put(&from->css);
+
+	page->mem_cgroup =3D to;
=20
 	__unlock_page_memcg(from);
=20
@@ -6483,6 +6490,7 @@ int mem_cgroup_charge(struct page *page, struct mm_=
struct *mm, gfp_t gfp_mask)
 	if (ret)
 		goto out_put;
=20
+	css_get(&memcg->css);
 	commit_charge(page, memcg);
=20
 	local_irq_disable();
@@ -6537,9 +6545,6 @@ static void uncharge_batch(const struct uncharge_ga=
ther *ug)
 	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_pages)=
;
 	memcg_check_events(ug->memcg, ug->dummy_page);
 	local_irq_restore(flags);
-
-	if (!mem_cgroup_is_root(ug->memcg))
-		css_put_many(&ug->memcg->css, ug->nr_pages);
 }
=20
 static void uncharge_page(struct page *page, struct uncharge_gather *ug)
@@ -6577,6 +6582,7 @@ static void uncharge_page(struct page *page, struct=
 uncharge_gather *ug)
=20
 	ug->dummy_page =3D page;
 	page->mem_cgroup =3D NULL;
+	css_put(&ug->memcg->css);
 }
=20
 static void uncharge_list(struct list_head *page_list)
@@ -6682,8 +6688,8 @@ void mem_cgroup_migrate(struct page *oldpage, struc=
t page *newpage)
 	page_counter_charge(&memcg->memory, nr_pages);
 	if (do_memsw_account())
 		page_counter_charge(&memcg->memsw, nr_pages);
-	css_get_many(&memcg->css, nr_pages);
=20
+	css_get(&memcg->css);
 	commit_charge(newpage, memcg);
=20
 	local_irq_save(flags);
@@ -6920,8 +6926,7 @@ void mem_cgroup_swapout(struct page *page, swp_entr=
y_t entry)
 	mem_cgroup_charge_statistics(memcg, page, -nr_entries);
 	memcg_check_events(memcg, page);
=20
-	if (!mem_cgroup_is_root(memcg))
-		css_put_many(&memcg->css, nr_entries);
+	css_put(&memcg->css);
 }
=20
 /**
diff --git a/mm/slab.h b/mm/slab.h
index 633eedb6bad1..8a574d9361c1 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -373,9 +373,7 @@ static __always_inline int memcg_charge_slab(struct p=
age *page,
 	lruvec =3D mem_cgroup_lruvec(memcg, page_pgdat(page));
 	mod_lruvec_state(lruvec, cache_vmstat_idx(s), nr_pages << PAGE_SHIFT);
=20
-	/* transer try_charge() page references to kmem_cache */
 	percpu_ref_get_many(&s->memcg_params.refcnt, nr_pages);
-	css_put_many(&memcg->css, nr_pages);
 out:
 	css_put(&memcg->css);
 	return ret;
--=20
2.25.4

