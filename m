Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EB5C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66FC3208C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="KGw6yqBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgFHXIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:08:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:12904 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727884AbgFHXHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:07:24 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058N0rbV022442
        for <linux-kernel@vger.kernel.org>; Mon, 8 Jun 2020 16:07:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=mDshP9vuVcQyuQIdvx0q+egyIEOc0Ox5M3EkLldRRoI=;
 b=KGw6yqBfAlPFSD99oHqjBrASe4wy71dVZvKAE7YxQJoIrqRikVABZYaGWdy/ec9/i4k1
 vqdjmDb0PQ07L+6o7WC6KTIFalada67K2BW2WeReNzTnM1bEFXK9GjnqguRd1Jg4JWpc
 HUZVvbrQaeeZTdFl19mC7Akk2D49doTSnaY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31gtucqn9v-19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 16:07:24 -0700
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 8 Jun 2020 16:07:14 -0700
Received: by devvm1291.vll0.facebook.com (Postfix, from userid 111017)
        id 56B0E1D8FE4E; Mon,  8 Jun 2020 16:07:00 -0700 (PDT)
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
Subject: [PATCH v6 10/19] mm: memcg/slab: deprecate memory.kmem.slabinfo
Date:   Mon, 8 Jun 2020 16:06:45 -0700
Message-ID: <20200608230654.828134-11-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200608230654.828134-1-guro@fb.com>
References: <20200608230654.828134-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_18:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 priorityscore=1501 cotscore=-2147483648 spamscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=724
 clxscore=1015 phishscore=0 mlxscore=0 impostorscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080160
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deprecate memory.kmem.slabinfo.

An empty file will be presented if corresponding config options are
enabled.

The interface is implementation dependent, isn't present in cgroup v2,
and is generally useful only for core mm debugging purposes. In other
words, it doesn't provide any value for the absolute majority of users.

A drgn-based replacement can be found in tools/cgroup/slabinfo.py .
It does support cgroup v1 and v2, mimics memory.kmem.slabinfo output
and also allows to get any additional information without a need
to recompile the kernel.

If a drgn-based solution is too slow for a task, a bpf-based tracing
tool can be used, which can easily keep track of all slab allocations
belonging to a memory cgroup.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/memcontrol.c  |  3 ---
 mm/slab_common.c | 31 ++++---------------------------
 2 files changed, 4 insertions(+), 30 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f0ea0ce6bea5..004a31941a88 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5116,9 +5116,6 @@ static struct cftype mem_cgroup_legacy_files[] =3D =
{
 	(defined(CONFIG_SLAB) || defined(CONFIG_SLUB_DEBUG))
 	{
 		.name =3D "kmem.slabinfo",
-		.seq_start =3D memcg_slab_start,
-		.seq_next =3D memcg_slab_next,
-		.seq_stop =3D memcg_slab_stop,
 		.seq_show =3D memcg_slab_show,
 	},
 #endif
diff --git a/mm/slab_common.c b/mm/slab_common.c
index b578ae29c743..3c89c2adc930 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1523,35 +1523,12 @@ void dump_unreclaimable_slab(void)
 }
=20
 #if defined(CONFIG_MEMCG_KMEM)
-void *memcg_slab_start(struct seq_file *m, loff_t *pos)
-{
-	struct mem_cgroup *memcg =3D mem_cgroup_from_seq(m);
-
-	mutex_lock(&slab_mutex);
-	return seq_list_start(&memcg->kmem_caches, *pos);
-}
-
-void *memcg_slab_next(struct seq_file *m, void *p, loff_t *pos)
-{
-	struct mem_cgroup *memcg =3D mem_cgroup_from_seq(m);
-
-	return seq_list_next(p, &memcg->kmem_caches, pos);
-}
-
-void memcg_slab_stop(struct seq_file *m, void *p)
-{
-	mutex_unlock(&slab_mutex);
-}
-
 int memcg_slab_show(struct seq_file *m, void *p)
 {
-	struct kmem_cache *s =3D list_entry(p, struct kmem_cache,
-					  memcg_params.kmem_caches_node);
-	struct mem_cgroup *memcg =3D mem_cgroup_from_seq(m);
-
-	if (p =3D=3D memcg->kmem_caches.next)
-		print_slabinfo_header(m);
-	cache_show(s, m);
+	/*
+	 * Deprecated.
+	 * Please, take a look at tools/cgroup/slabinfo.py .
+	 */
 	return 0;
 }
 #endif
--=20
2.25.4

