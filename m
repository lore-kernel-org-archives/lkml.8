Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6CDC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA41A214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="OdPSSXBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgIJUsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 16:48:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:5010 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725992AbgIJU1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 16:27:14 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08AKK5dP026405
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 13:27:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=nr+CLhhN+2HgzncJdYQx+0jf1+z+pRfq+bAtFH0myb8=;
 b=OdPSSXBKGgp2q1eC20Kdj4CCneYPxpDtqyammQniEF8YPG++HLphpZd0UFqvjVCSV+jj
 9BlFna7Lq3dKZZdXN5EC/CEIbXaaZzP5YUlV0vu+WPYHljyvX30t2ysLI1+FMzzjvLMa
 2OcPrQtaExV9YvbgAc9JAfVjbuYm51DnuBQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33fqw11a7j-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 13:27:10 -0700
Received: from intmgw002.06.prn3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 10 Sep 2020 13:27:09 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id BB3623D449B8; Thu, 10 Sep 2020 13:27:03 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1096.prn0.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     =Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn0c01
Subject: [PATCH rfc 4/5] mm: introduce page memcg flags
Date:   Thu, 10 Sep 2020 13:26:58 -0700
Message-ID: <20200910202659.1378404-5-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200910202659.1378404-1-guro@fb.com>
References: <20200910202659.1378404-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-10_09:2020-09-10,2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=325
 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009100183
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lowest bit in page->memcg_data is used to distinguish between
struct memory_cgroup pointer and a pointer to a objcgs array.
All checks and modifications of this bit are open-coded.

Let's formalize it using page memcg flags, defined in page_memcg_flags
enum and replace all open-coded accesses with test_bit()/__set_bit().

Few additional flags might be added later. Flags are intended to be
mutually exclusive.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 48d4c2c1ce81..7ab5f92bb686 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -340,23 +340,25 @@ struct mem_cgroup {
=20
 extern struct mem_cgroup *root_mem_cgroup;
=20
+enum page_memcg_flags {
+	/* page->memcg_data is a pointer to a objcgs vector */
+	PG_MEMCG_OBJ_CGROUPS,
+};
+
 static inline struct mem_cgroup *page_mem_cgroup(struct page *page)
 {
+	unsigned long memcg_data =3D page->memcg_data;
+
 	VM_BUG_ON_PAGE(PageSlab(page), page);
-	return (struct mem_cgroup *)page->memcg_data;
+
+	return (struct mem_cgroup *)memcg_data;
 }
=20
 static inline struct mem_cgroup *page_mem_cgroup_check(struct page *page=
)
 {
 	unsigned long memcg_data =3D page->memcg_data;
=20
-	/*
-	 * The lowest bit set means that memcg isn't a valid
-	 * memcg pointer, but a obj_cgroups pointer.
-	 * In this case the page is shared and doesn't belong
-	 * to any specific memory cgroup.
-	 */
-	if (memcg_data & 0x1UL)
+	if (test_bit(PG_MEMCG_OBJ_CGROUPS, &memcg_data))
 		return NULL;
=20
 	return (struct mem_cgroup *)memcg_data;
@@ -378,14 +380,20 @@ static inline void clear_page_mem_cgroup(struct pag=
e *page)
 #ifdef CONFIG_MEMCG_KMEM
 static inline struct obj_cgroup **page_obj_cgroups(struct page *page)
 {
-	return (struct obj_cgroup **)(page->memcg_data & ~0x1UL);
+	unsigned long memcg_data =3D page->memcg_data;
+
+	VM_BUG_ON_PAGE(memcg_data && !test_bit(PG_MEMCG_OBJ_CGROUPS,
+					       &memcg_data), page);
+	__clear_bit(PG_MEMCG_OBJ_CGROUPS, &memcg_data);
+
+	return (struct obj_cgroup **)memcg_data;
 }
=20
 static inline struct obj_cgroup **page_obj_cgroups_check(struct page *pa=
ge)
 {
 	unsigned long memcg_data =3D page->memcg_data;
=20
-	if (memcg_data && (memcg_data & 0x1UL))
+	if (memcg_data && test_bit(PG_MEMCG_OBJ_CGROUPS, &memcg_data))
 		return (struct obj_cgroup **)memcg_data;
=20
 	return NULL;
@@ -394,7 +402,11 @@ static inline struct obj_cgroup **page_obj_cgroups_c=
heck(struct page *page)
 static inline bool set_page_obj_cgroups(struct page *page,
 					struct obj_cgroup **objcgs)
 {
-	return !cmpxchg(&page->memcg_data, 0, (unsigned long)objcgs | 0x1UL);
+	unsigned long memcg_data =3D (unsigned long)objcgs;
+
+	__set_bit(PG_MEMCG_OBJ_CGROUPS, &memcg_data);
+
+	return !cmpxchg(&page->memcg_data, 0, memcg_data);
 }
=20
 static inline void clear_page_obj_cgroups(struct page *page)
--=20
2.26.2

