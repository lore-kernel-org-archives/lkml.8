Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF78EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A66262087E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="pmpCkPRE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgH0Rwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:52:30 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44912 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727034AbgH0RwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 13:52:23 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RHmgUB019297
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:52:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=cTcroAjpBM+ohC44YY25rqXxYtNf61yTmh0X3sxMeu0=;
 b=pmpCkPREelgpOB5j+MekZgN61p0l5Yn8QNw1ItMZ18DEHuNHwNg17oid/Mkf6ij7ATui
 4v/WWP89UWZKWGcYUVSCVMrGOyXLoll3ntb+RfFjNSGYns8VpM53VcWhlr5Ns8iIX4F9
 ZnTiJX0lTcFs3DSyqnckYOOUi8fIy3tDltc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 335up86mjs-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:52:22 -0700
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 27 Aug 2020 10:52:19 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id 38DDD3922487; Thu, 27 Aug 2020 10:52:16 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1096.prn0.facebook.com
To:     <linux-mm@kvack.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        =Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn0c01
Subject: [PATCH RFC 3/4] mm: kmem: prepare remote memcg charging infra for interrupt contexts
Date:   Thu, 27 Aug 2020 10:52:14 -0700
Message-ID: <20200827175215.319780-4-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200827175215.319780-1-guro@fb.com>
References: <20200827175215.319780-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_10:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 suspectscore=1 adultscore=0 mlxlogscore=506 spamscore=0 impostorscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270134
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remote memcg charging API uses current->active_memcg to store the
currently active memory cgroup, which overwrites the memory cgroup
of the current process. It works well for normal contexts, but doesn't
work for interrupt contexts: indeed, if an interrupt occurs during
the execution of a section with an active memcg set, all allocations
inside the interrupt will be charged to the active memcg set (given
that we'll enable accounting for allocations from an interrupt
context). But because the interrupt might have no relation to the
active memcg set outside, it's obviously wrong from the accounting
prospective.

To resolve this problem, let's add a global percpu int_active_memcg
variable, which will be used to store an active memory cgroup which
will be sued from interrupt contexts. set_active_memcg() will
transparently use current->active_memcg or int_active_memcg depending
on the context.

To make the read part simple and transparent for the caller, let's
introduce two new functions:
  - struct mem_cgroup *active_memcg(void),
  - struct mem_cgroup *get_active_memcg(void).

They are returning the active memcg if it's set, hiding all
implementation details: where to get it depending on the current context.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/sched/mm.h | 13 +++++++++--
 mm/memcontrol.c          | 48 ++++++++++++++++++++++++++++------------
 2 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 4c69a4349ac1..030a1cf77b8a 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -304,6 +304,7 @@ static inline void memalloc_nocma_restore(unsigned in=
t flags)
 #endif
=20
 #ifdef CONFIG_MEMCG
+DECLARE_PER_CPU(struct mem_cgroup *, int_active_memcg);
 /**
  * set_active_memcg - Starts the remote memcg charging scope.
  * @memcg: memcg to charge.
@@ -318,8 +319,16 @@ static inline void memalloc_nocma_restore(unsigned i=
nt flags)
 static inline struct mem_cgroup *
 set_active_memcg(struct mem_cgroup *memcg)
 {
-	struct mem_cgroup *old =3D current->active_memcg;
-	current->active_memcg =3D memcg;
+	struct mem_cgroup *old;
+
+	if (in_interrupt()) {
+		old =3D this_cpu_read(int_active_memcg);
+		this_cpu_write(int_active_memcg, memcg);
+	} else {
+		old =3D current->active_memcg;
+		current->active_memcg =3D memcg;
+	}
+
 	return old;
 }
 #else
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5d847257a639..a51a6066079e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -73,6 +73,9 @@ EXPORT_SYMBOL(memory_cgrp_subsys);
=20
 struct mem_cgroup *root_mem_cgroup __read_mostly;
=20
+/* Active memory cgroup to use from an interrupt context */
+DEFINE_PER_CPU(struct mem_cgroup *, int_active_memcg);
+
 /* Socket memory accounting disabled? */
 static bool cgroup_memory_nosocket;
=20
@@ -1069,26 +1072,43 @@ struct mem_cgroup *get_mem_cgroup_from_page(struc=
t page *page)
 }
 EXPORT_SYMBOL(get_mem_cgroup_from_page);
=20
-/**
- * If current->active_memcg is non-NULL, do not fallback to current->mm-=
>memcg.
- */
-static __always_inline struct mem_cgroup *get_mem_cgroup_from_current(vo=
id)
+static __always_inline struct mem_cgroup *active_memcg(void)
 {
-	if (memcg_kmem_bypass())
-		return NULL;
+	if (in_interrupt())
+		return this_cpu_read(int_active_memcg);
+	else
+		return current->active_memcg;
+}
=20
-	if (unlikely(current->active_memcg)) {
-		struct mem_cgroup *memcg;
+static __always_inline struct mem_cgroup *get_active_memcg(void)
+{
+	struct mem_cgroup *memcg;
=20
-		rcu_read_lock();
+	rcu_read_lock();
+	memcg =3D active_memcg();
+	if (memcg) {
 		/* current->active_memcg must hold a ref. */
-		if (WARN_ON_ONCE(!css_tryget(&current->active_memcg->css)))
+		if (WARN_ON_ONCE(!css_tryget(&memcg->css)))
 			memcg =3D root_mem_cgroup;
 		else
 			memcg =3D current->active_memcg;
-		rcu_read_unlock();
-		return memcg;
 	}
+	rcu_read_unlock();
+
+	return memcg;
+}
+
+/**
+ * If active memcg is set, do not fallback to current->mm->memcg.
+ */
+static __always_inline struct mem_cgroup *get_mem_cgroup_from_current(vo=
id)
+{
+	if (memcg_kmem_bypass())
+		return NULL;
+
+	if (unlikely(active_memcg()))
+		return get_active_memcg();
+
 	return get_mem_cgroup_from_mm(current->mm);
 }
=20
@@ -2920,8 +2940,8 @@ __always_inline struct obj_cgroup *get_obj_cgroup_f=
rom_current(void)
 		return NULL;
=20
 	rcu_read_lock();
-	if (unlikely(current->active_memcg))
-		memcg =3D rcu_dereference(current->active_memcg);
+	if (unlikely(active_memcg()))
+		memcg =3D active_memcg();
 	else
 		memcg =3D mem_cgroup_from_task(current);
=20
--=20
2.26.2

