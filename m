Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AF1C433E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3C3120888
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Z619Lj0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgFHXHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:07:41 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39276 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727782AbgFHXHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:07:04 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058N56AW019088
        for <linux-kernel@vger.kernel.org>; Mon, 8 Jun 2020 16:07:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=obWZo+sT+nQL9zR0PwE2NJ5Bz0lbnYW9VW54il68KYQ=;
 b=Z619Lj0qFjvtRhVQLnNT4yRX77G1sjofvjWnsFQU21de5Xdv3sAEfl5uIWwK2qh0Apc6
 vA1IG3M9dEbDC9k84AyTPTBXejl9ph2fEbZd0feTrsuNf8AsR7NuemZhy4iDtj1BiOZb
 7GkhmEVRVXzzCKtjYJTeyTHUWJtzEKc437s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31gutgqh24-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 16:07:03 -0700
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 8 Jun 2020 16:07:01 -0700
Received: by devvm1291.vll0.facebook.com (Postfix, from userid 111017)
        id 2658E1D8FE3C; Mon,  8 Jun 2020 16:07:00 -0700 (PDT)
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
Subject: [PATCH v6 01/19] mm: memcg: factor out memcg- and lruvec-level changes out of __mod_lruvec_state()
Date:   Mon, 8 Jun 2020 16:06:36 -0700
Message-ID: <20200608230654.828134-2-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200608230654.828134-1-guro@fb.com>
References: <20200608230654.828134-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_18:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 impostorscore=0 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=942
 mlxscore=0 bulkscore=0 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080160
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To convert memcg and lruvec slab counters to bytes there must be
a way to change these counters without touching node counters.
Factor out __mod_memcg_lruvec_state() out of __mod_lruvec_state().

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/memcontrol.h | 17 +++++++++++++++
 mm/memcontrol.c            | 43 +++++++++++++++++++++-----------------
 2 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index bbf624a7f5a6..93dbc7f9d8b8 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -679,11 +679,23 @@ static inline unsigned long lruvec_page_state_local=
(struct lruvec *lruvec,
 	return x;
 }
=20
+void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item=
 idx,
+			      int val);
 void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			int val);
 void __mod_lruvec_slab_state(void *p, enum node_stat_item idx, int val);
 void mod_memcg_obj_state(void *p, int idx, int val);
=20
+static inline void mod_memcg_lruvec_state(struct lruvec *lruvec,
+					  enum node_stat_item idx, int val)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	__mod_memcg_lruvec_state(lruvec, idx, val);
+	local_irq_restore(flags);
+}
+
 static inline void mod_lruvec_state(struct lruvec *lruvec,
 				    enum node_stat_item idx, int val)
 {
@@ -1057,6 +1069,11 @@ static inline unsigned long lruvec_page_state_loca=
l(struct lruvec *lruvec,
 	return node_page_state(lruvec_pgdat(lruvec), idx);
 }
=20
+static inline void __mod_memcg_lruvec_state(struct lruvec *lruvec,
+					    enum node_stat_item idx, int val)
+{
+}
+
 static inline void __mod_lruvec_state(struct lruvec *lruvec,
 				      enum node_stat_item idx, int val)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index bbda19c13c19..e8a91e98556b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -713,30 +713,13 @@ parent_nodeinfo(struct mem_cgroup_per_node *pn, int=
 nid)
 	return mem_cgroup_nodeinfo(parent, nid);
 }
=20
-/**
- * __mod_lruvec_state - update lruvec memory statistics
- * @lruvec: the lruvec
- * @idx: the stat item
- * @val: delta to add to the counter, can be negative
- *
- * The lruvec is the intersection of the NUMA node and a cgroup. This
- * function updates the all three counters that are affected by a
- * change of state at this level: per-node, per-cgroup, per-lruvec.
- */
-void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
-			int val)
+void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item=
 idx,
+			      int val)
 {
-	pg_data_t *pgdat =3D lruvec_pgdat(lruvec);
 	struct mem_cgroup_per_node *pn;
 	struct mem_cgroup *memcg;
 	long x;
=20
-	/* Update node */
-	__mod_node_page_state(pgdat, idx, val);
-
-	if (mem_cgroup_disabled())
-		return;
-
 	pn =3D container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 	memcg =3D pn->memcg;
=20
@@ -748,6 +731,7 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum n=
ode_stat_item idx,
=20
 	x =3D val + __this_cpu_read(pn->lruvec_stat_cpu->count[idx]);
 	if (unlikely(abs(x) > MEMCG_CHARGE_BATCH)) {
+		pg_data_t *pgdat =3D lruvec_pgdat(lruvec);
 		struct mem_cgroup_per_node *pi;
=20
 		for (pi =3D pn; pi; pi =3D parent_nodeinfo(pi, pgdat->node_id))
@@ -757,6 +741,27 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum =
node_stat_item idx,
 	__this_cpu_write(pn->lruvec_stat_cpu->count[idx], x);
 }
=20
+/**
+ * __mod_lruvec_state - update lruvec memory statistics
+ * @lruvec: the lruvec
+ * @idx: the stat item
+ * @val: delta to add to the counter, can be negative
+ *
+ * The lruvec is the intersection of the NUMA node and a cgroup. This
+ * function updates the all three counters that are affected by a
+ * change of state at this level: per-node, per-cgroup, per-lruvec.
+ */
+void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
+			int val)
+{
+	/* Update node */
+	__mod_node_page_state(lruvec_pgdat(lruvec), idx, val);
+
+	/* Update memcg and lruvec */
+	if (!mem_cgroup_disabled())
+		__mod_memcg_lruvec_state(lruvec, idx, val);
+}
+
 void __mod_lruvec_slab_state(void *p, enum node_stat_item idx, int val)
 {
 	pg_data_t *pgdat =3D page_pgdat(virt_to_page(p));
--=20
2.25.4

