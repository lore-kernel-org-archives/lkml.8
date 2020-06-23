Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9101BC433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 01:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 716FE20768
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 01:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="hIMlEiVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732147AbgFWB7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 21:59:07 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:22758 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732042AbgFWB65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 21:58:57 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05N1sqBD021161
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 18:58:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ivt/D0vc3oMHwNluUc1Nq40iWqoqzSlS0A4SlHhKIYs=;
 b=hIMlEiVstDufzi/SwdYNUY3Nf9QknsKn22/oWWaGTS5yyRu3zIFjvAWDXkQt+f+A4BZO
 5Iy3kqoPElnjc5C4hsD0RRTaGFqPqFHS3hSbKKCIqqH5xPfbtavc+2v9FIIs2G+1Emzj
 8Q2sNocufbBg8yKlEQm25f4+NP/uGxZFuj4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31sg9fk9ra-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 18:58:55 -0700
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 22 Jun 2020 18:58:53 -0700
Received: by devvm1291.vll0.facebook.com (Postfix, from userid 111017)
        id 4DC3326DD020; Mon, 22 Jun 2020 18:58:48 -0700 (PDT)
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
Subject: [PATCH v7 04/19] mm: slub: implement SLUB version of obj_to_index()
Date:   Mon, 22 Jun 2020 18:58:31 -0700
Message-ID: <20200623015846.1141975-5-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200623015846.1141975-1-guro@fb.com>
References: <20200623015846.1141975-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_16:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 cotscore=-2147483648 suspectscore=2 mlxlogscore=958 mlxscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006230012
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit implements SLUB version of the obj_to_index() function, which
will be required to calculate the offset of obj_cgroup in the obj_cgroups
vector to store/obtain the objcg ownership data.

To make it faster, let's repeat the SLAB's trick introduced by commit
6a2d7a955d8d ("SLAB: use a multiply instead of a divide in
obj_to_index()") and avoid an expensive division.

Vlastimil Babka noticed, that SLUB does have already a similar function
called slab_index(), which is defined only if SLUB_DEBUG is enabled.  The
function does a similar math, but with a division, and it also takes a
page address instead of a page pointer.

Let's remove slab_index() and replace it with the new helper
__obj_to_index(), which takes a page address.  obj_to_index() will be a
simple wrapper taking a page pointer and passing page_address(page) into
__obj_to_index().

Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/slub_def.h | 16 ++++++++++++++++
 mm/slub.c                | 15 +++++----------
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index d2153789bd9f..30e91c83d401 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -8,6 +8,7 @@
  * (C) 2007 SGI, Christoph Lameter
  */
 #include <linux/kobject.h>
+#include <linux/reciprocal_div.h>
=20
 enum stat_item {
 	ALLOC_FASTPATH,		/* Allocation from cpu slab */
@@ -86,6 +87,7 @@ struct kmem_cache {
 	unsigned long min_partial;
 	unsigned int size;	/* The size of an object including metadata */
 	unsigned int object_size;/* The size of an object without metadata */
+	struct reciprocal_value reciprocal_size;
 	unsigned int offset;	/* Free pointer offset */
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 	/* Number of per cpu partial objects to keep around */
@@ -182,4 +184,18 @@ static inline void *nearest_obj(struct kmem_cache *c=
ache, struct page *page,
 	return result;
 }
=20
+/* Determine object index from a given position */
+static inline unsigned int __obj_to_index(const struct kmem_cache *cache=
,
+					  void *addr, void *obj)
+{
+	return reciprocal_divide(kasan_reset_tag(obj) - addr,
+				 cache->reciprocal_size);
+}
+
+static inline unsigned int obj_to_index(const struct kmem_cache *cache,
+					const struct page *page, void *obj)
+{
+	return __obj_to_index(cache, page_address(page), obj);
+}
+
 #endif /* _LINUX_SLUB_DEF_H */
diff --git a/mm/slub.c b/mm/slub.c
index c79d33cbe815..aa8d18824e62 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -317,12 +317,6 @@ static inline void set_freepointer(struct kmem_cache=
 *s, void *object, void *fp)
 		__p < (__addr) + (__objects) * (__s)->size; \
 		__p +=3D (__s)->size)
=20
-/* Determine object index from a given position */
-static inline unsigned int slab_index(void *p, struct kmem_cache *s, voi=
d *addr)
-{
-	return (kasan_reset_tag(p) - addr) / s->size;
-}
-
 static inline unsigned int order_objects(unsigned int order, unsigned in=
t size)
 {
 	return ((unsigned int)PAGE_SIZE << order) / size;
@@ -465,7 +459,7 @@ static unsigned long *get_map(struct kmem_cache *s, s=
truct page *page)
 	bitmap_zero(object_map, page->objects);
=20
 	for (p =3D page->freelist; p; p =3D get_freepointer(s, p))
-		set_bit(slab_index(p, s, addr), object_map);
+		set_bit(__obj_to_index(s, addr, p), object_map);
=20
 	return object_map;
 }
@@ -3758,6 +3752,7 @@ static int calculate_sizes(struct kmem_cache *s, in=
t forced_order)
 	 */
 	size =3D ALIGN(size, s->align);
 	s->size =3D size;
+	s->reciprocal_size =3D reciprocal_value(size);
 	if (forced_order >=3D 0)
 		order =3D forced_order;
 	else
@@ -3862,7 +3857,7 @@ static void list_slab_objects(struct kmem_cache *s,=
 struct page *page,
 	map =3D get_map(s, page);
 	for_each_object(p, s, addr, page->objects) {
=20
-		if (!test_bit(slab_index(p, s, addr), map)) {
+		if (!test_bit(__obj_to_index(s, addr, p), map)) {
 			pr_err("INFO: Object 0x%p @offset=3D%tu\n", p, p - addr);
 			print_tracking(s, p);
 		}
@@ -4578,7 +4573,7 @@ static void validate_slab(struct kmem_cache *s, str=
uct page *page)
 	/* Now we know that a valid freelist exists */
 	map =3D get_map(s, page);
 	for_each_object(p, s, addr, page->objects) {
-		u8 val =3D test_bit(slab_index(p, s, addr), map) ?
+		u8 val =3D test_bit(__obj_to_index(s, addr, p), map) ?
 			 SLUB_RED_INACTIVE : SLUB_RED_ACTIVE;
=20
 		if (!check_object(s, page, p, val))
@@ -4769,7 +4764,7 @@ static void process_slab(struct loc_track *t, struc=
t kmem_cache *s,
=20
 	map =3D get_map(s, page);
 	for_each_object(p, s, addr, page->objects)
-		if (!test_bit(slab_index(p, s, addr), map))
+		if (!test_bit(__obj_to_index(s, addr, p), map))
 			add_location(t, s, get_track(s, p, alloc));
 	put_map(map);
 }
--=20
2.26.2

