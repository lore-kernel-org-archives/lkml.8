Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D244C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 01:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2943C2075A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 01:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mPx1Mp2E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732283AbgFWB71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 21:59:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48324 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732139AbgFWB7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 21:59:08 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05N1wTBW003621
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 18:59:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=e2fXapnYHXX7RWAashrUDymK5xV4NycFqBGAYpMBYVs=;
 b=mPx1Mp2EElD0LPxBh21Ehit3GqPU7TUY2xB7gFrM6y81z2aYeyj7tExNV0LoJbaaoMsD
 FaFmgGp4u4fZ8JCgqKOD4FUR1YPDH61rNRCbtobxTHpgt43JcJ3aQM0TYY2GxMFMOLPU
 FQ4DzCkCNwzRRd7S1SRDqwvXRXsBO96aG8M= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 31se4nknfn-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 18:59:06 -0700
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 22 Jun 2020 18:58:54 -0700
Received: by devvm1291.vll0.facebook.com (Postfix, from userid 111017)
        id A9B9426DD038; Mon, 22 Jun 2020 18:58:48 -0700 (PDT)
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
Subject: [PATCH v7 15/19] mm: memcg/slab: deprecate slab_root_caches
Date:   Mon, 22 Jun 2020 18:58:42 -0700
Message-ID: <20200623015846.1141975-16-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200623015846.1141975-1-guro@fb.com>
References: <20200623015846.1141975-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_16:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=736 spamscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 cotscore=-2147483648 adultscore=0 suspectscore=2 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006230012
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there are two lists of kmem_caches:
1) slab_caches, which contains all kmem_caches,
2) slab_root_caches, which contains only root kmem_caches.

And there is some preprocessor magic to have a single list if
CONFIG_MEMCG_KMEM isn't enabled.

It was required earlier because the number of non-root kmem_caches was
proportional to the number of memory cgroups and could reach really big
values.  Now, when it cannot exceed the number of root kmem_caches, there
is really no reason to maintain two lists.

We never iterate over the slab_root_caches list on any hot paths, so it's
perfectly fine to iterate over slab_caches and filter out non-root
kmem_caches.

It allows to remove a lot of config-dependent code and two pointers from
the kmem_cache structure.

Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 mm/slab.c        |  1 -
 mm/slab.h        | 17 -----------------
 mm/slab_common.c | 37 ++++++++-----------------------------
 mm/slub.c        |  1 -
 4 files changed, 8 insertions(+), 48 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 84e218fd0bcf..23f0376f66ba 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1239,7 +1239,6 @@ void __init kmem_cache_init(void)
 				  nr_node_ids * sizeof(struct kmem_cache_node *),
 				  SLAB_HWCACHE_ALIGN, 0, 0);
 	list_add(&kmem_cache->list, &slab_caches);
-	memcg_link_cache(kmem_cache);
 	slab_state =3D PARTIAL;
=20
 	/*
diff --git a/mm/slab.h b/mm/slab.h
index d47430e97ff1..46ac1de9a0b7 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -44,14 +44,12 @@ struct kmem_cache {
  *
  * @memcg_cache: pointer to memcg kmem cache, used by all non-root memor=
y
  *		cgroups.
- * @root_caches_node: list node for slab_root_caches list.
  * @work: work struct used to create the non-root cache.
  */
 struct memcg_cache_params {
 	struct kmem_cache *root_cache;
=20
 	struct kmem_cache *memcg_cache;
-	struct list_head __root_caches_node;
 	struct work_struct work;
 };
 #endif /* CONFIG_SLOB */
@@ -264,11 +262,6 @@ static inline bool kmem_cache_debug_flags(struct kme=
m_cache *s, slab_flags_t fla
 }
=20
 #ifdef CONFIG_MEMCG_KMEM
-
-/* List of all root caches. */
-extern struct list_head		slab_root_caches;
-#define root_caches_node	memcg_params.__root_caches_node
-
 static inline bool is_root_cache(struct kmem_cache *s)
 {
 	return !s->memcg_params.root_cache;
@@ -446,14 +439,8 @@ static inline void memcg_slab_free_hook(struct kmem_=
cache *s, struct page *page,
 }
=20
 extern void slab_init_memcg_params(struct kmem_cache *);
-extern void memcg_link_cache(struct kmem_cache *s);
=20
 #else /* CONFIG_MEMCG_KMEM */
-
-/* If !memcg, all caches are root. */
-#define slab_root_caches	slab_caches
-#define root_caches_node	list
-
 static inline bool is_root_cache(struct kmem_cache *s)
 {
 	return true;
@@ -522,10 +509,6 @@ static inline void slab_init_memcg_params(struct kme=
m_cache *s)
 {
 }
=20
-static inline void memcg_link_cache(struct kmem_cache *s)
-{
-}
-
 #endif /* CONFIG_MEMCG_KMEM */
=20
 static inline struct kmem_cache *virt_to_cache(const void *obj)
diff --git a/mm/slab_common.c b/mm/slab_common.c
index e0a2a904fdd9..0618d3595c08 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -129,9 +129,6 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp=
_t flags, size_t nr,
 }
=20
 #ifdef CONFIG_MEMCG_KMEM
-
-LIST_HEAD(slab_root_caches);
-
 static void memcg_kmem_cache_create_func(struct work_struct *work)
 {
 	struct kmem_cache *cachep =3D container_of(work, struct kmem_cache,
@@ -154,27 +151,11 @@ static void init_memcg_params(struct kmem_cache *s,
 	else
 		slab_init_memcg_params(s);
 }
-
-void memcg_link_cache(struct kmem_cache *s)
-{
-	if (is_root_cache(s))
-		list_add(&s->root_caches_node, &slab_root_caches);
-}
-
-static void memcg_unlink_cache(struct kmem_cache *s)
-{
-	if (is_root_cache(s))
-		list_del(&s->root_caches_node);
-}
 #else
 static inline void init_memcg_params(struct kmem_cache *s,
 				     struct kmem_cache *root_cache)
 {
 }
-
-static inline void memcg_unlink_cache(struct kmem_cache *s)
-{
-}
 #endif /* CONFIG_MEMCG_KMEM */
=20
 /*
@@ -251,7 +232,7 @@ struct kmem_cache *find_mergeable(unsigned int size, =
unsigned int align,
 	if (flags & SLAB_NEVER_MERGE)
 		return NULL;
=20
-	list_for_each_entry_reverse(s, &slab_root_caches, root_caches_node) {
+	list_for_each_entry_reverse(s, &slab_caches, list) {
 		if (slab_unmergeable(s))
 			continue;
=20
@@ -310,7 +291,6 @@ static struct kmem_cache *create_cache(const char *na=
me,
=20
 	s->refcount =3D 1;
 	list_add(&s->list, &slab_caches);
-	memcg_link_cache(s);
 out:
 	if (err)
 		return ERR_PTR(err);
@@ -505,7 +485,6 @@ static int shutdown_cache(struct kmem_cache *s)
 	if (__kmem_cache_shutdown(s) !=3D 0)
 		return -EBUSY;
=20
-	memcg_unlink_cache(s);
 	list_del(&s->list);
=20
 	if (s->flags & SLAB_TYPESAFE_BY_RCU) {
@@ -749,7 +728,6 @@ struct kmem_cache *__init create_kmalloc_cache(const =
char *name,
=20
 	create_boot_cache(s, name, size, flags, useroffset, usersize);
 	list_add(&s->list, &slab_caches);
-	memcg_link_cache(s);
 	s->refcount =3D 1;
 	return s;
 }
@@ -1090,12 +1068,12 @@ static void print_slabinfo_header(struct seq_file=
 *m)
 void *slab_start(struct seq_file *m, loff_t *pos)
 {
 	mutex_lock(&slab_mutex);
-	return seq_list_start(&slab_root_caches, *pos);
+	return seq_list_start(&slab_caches, *pos);
 }
=20
 void *slab_next(struct seq_file *m, void *p, loff_t *pos)
 {
-	return seq_list_next(p, &slab_root_caches, pos);
+	return seq_list_next(p, &slab_caches, pos);
 }
=20
 void slab_stop(struct seq_file *m, void *p)
@@ -1148,11 +1126,12 @@ static void cache_show(struct kmem_cache *s, stru=
ct seq_file *m)
=20
 static int slab_show(struct seq_file *m, void *p)
 {
-	struct kmem_cache *s =3D list_entry(p, struct kmem_cache, root_caches_n=
ode);
+	struct kmem_cache *s =3D list_entry(p, struct kmem_cache, list);
=20
-	if (p =3D=3D slab_root_caches.next)
+	if (p =3D=3D slab_caches.next)
 		print_slabinfo_header(m);
-	cache_show(s, m);
+	if (is_root_cache(s))
+		cache_show(s, m);
 	return 0;
 }
=20
@@ -1254,7 +1233,7 @@ static int memcg_slabinfo_show(struct seq_file *m, =
void *unused)
 	mutex_lock(&slab_mutex);
 	seq_puts(m, "# <name> <css_id[:dead|deact]> <active_objs> <num_objs>");
 	seq_puts(m, " <active_slabs> <num_slabs>\n");
-	list_for_each_entry(s, &slab_root_caches, root_caches_node) {
+	list_for_each_entry(s, &slab_caches, list) {
 		/*
 		 * Skip kmem caches that don't have the memcg cache.
 		 */
diff --git a/mm/slub.c b/mm/slub.c
index 91a1dce932e9..7a5d6861b088 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4364,7 +4364,6 @@ static struct kmem_cache * __init bootstrap(struct =
kmem_cache *static_cache)
 	}
 	slab_init_memcg_params(s);
 	list_add(&s->list, &slab_caches);
-	memcg_link_cache(s);
 	return s;
 }
=20
--=20
2.26.2

