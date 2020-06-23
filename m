Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5420C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CE08206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="j99YlFBX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387651AbgFWRmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:42:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:2840 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387827AbgFWRlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:41:02 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05NHef5I020485
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 10:41:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=pNPRuF5LajF9VNFx2UDWcECUyJwt02enUzuyXlWJX/A=;
 b=j99YlFBX7AwSIrs0so1LGPqKHw5zBkZJDpImSx1nAFcKrizWIe1obddWdT+gM9edEwDy
 Rf45HbRc0NzrOpeYtEtsiAwmS9+g3swU2BfvCSk8+YRXeK8lEks43aLMGfEagNIM6Z0S
 HuaAYN03i3oJx2HlbpRvQ8m6UbDJqQPjFIg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31uk21h634-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 10:41:01 -0700
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Jun 2020 10:40:45 -0700
Received: by devvm1291.vll0.facebook.com (Postfix, from userid 111017)
        id 98D27273E5D4; Tue, 23 Jun 2020 10:40:41 -0700 (PDT)
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
Subject: [PATCH v7 01/19] mm: memcg: factor out memcg- and lruvec-level changes out of __mod_lruvec_state()
Date:   Tue, 23 Jun 2020 10:40:19 -0700
Message-ID: <20200623174037.3951353-2-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200623174037.3951353-1-guro@fb.com>
References: <20200623174037.3951353-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_11:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006120000 definitions=main-2006230124
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To convert memcg and lruvec slab counters to bytes there must be a way to
change these counters without touching node counters.  Factor out
__mod_memcg_lruvec_state() out of __mod_lruvec_state().

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h | 17 +++++++++++++++
 mm/memcontrol.c            | 43 +++++++++++++++++++++-----------------
 2 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e77197a62809..b250f8197710 100644
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
index 19622328e4b5..13ab84c7e4ac 100644
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
2.26.2

