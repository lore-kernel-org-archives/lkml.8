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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AAFC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF09F214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="hD9uHy9Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgIJUac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 16:30:32 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:31694 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726722AbgIJU1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 16:27:41 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08AKKbba022314
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 13:27:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=cyPxDfqqKL5Uzd94aW7bOSgHl42MxVutfMVoXupZePw=;
 b=hD9uHy9Y9tnltawnBFs2J4mBJfHNp/SpDwtkzvk+khZIwxz9aNPZsfRGnOjc26fGQ7P6
 N/+lvKXtRHbkVQqlBkBW40GoQqt5IfqF/4UnWRVbaRpLf9UwOtiW7EZG3o4zow6a5Qhh
 3bWpEjqgE1GVqhxjd594CrjNncetMvKtje8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33fhxub58u-18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 13:27:39 -0700
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 10 Sep 2020 13:27:07 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id AAEFD3D449B2; Thu, 10 Sep 2020 13:27:03 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1096.prn0.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     =Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>
Smtp-Origin-Cluster: prn0c01
Subject: [PATCH rfc 1/5] mm: memcg/slab: fix racy access to page->mem_cgroup in mem_cgroup_from_obj()
Date:   Thu, 10 Sep 2020 13:26:55 -0700
Message-ID: <20200910202659.1378404-2-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200910202659.1378404-1-guro@fb.com>
References: <20200910202659.1378404-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-10_09:2020-09-10,2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=638 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009100183
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mem_cgroup_from_obj() checks the lowest bit of the page->mem_cgroup
pointer to determine if the page has an attached obj_cgroup vector
instead of a regular memcg pointer. If it's not set, it simple returns
the page->mem_cgroup value as a struct mem_cgroup pointer.

The commit 10befea91b61 ("mm: memcg/slab: use a single set of
kmem_caches for all allocations") changed the moment when this bit
is set: if previously it was set on the allocation of the slab page,
now it can be set well after, when the first accounted object is
allocated on this page.

It opened a race: if page->mem_cgroup is set concurrently after the
first page_has_obj_cgroups(page) check, a pointer to the obj_cgroups
array can be returned as a memory cgroup pointer.

A simple check for page->mem_cgroup pointer for NULL before the
page_has_obj_cgroups() check fixes the race. Indeed, if the pointer
is not NULL, it's either a simple mem_cgroup pointer or a pointer
to obj_cgroup vector. The pointer can be asynchronously changed
from NULL to (obj_cgroup_vec | 0x1UL), but can't be changed
from a valid memcg pointer to objcg vector or back.

If the object passed to mem_cgroup_from_obj() is a slab object
and page->mem_cgroup is NULL, it means that the object is not
accounted, so the function must return NULL.

I've discovered the race looking at the code, so far I haven't seen it
in the wild.

Fixes: 10befea91b61 ("mm: memcg/slab: use a single set of kmem_caches for=
 all allocations")
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 75cd1a1e66c8..093526fec4bf 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2923,6 +2923,17 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
=20
 	page =3D virt_to_head_page(p);
=20
+	/*
+	 * If page->mem_cgroup is set, it's either a simple mem_cgroup pointer
+	 * or a pointer to obj_cgroup vector. In the latter case the lowest
+	 * bit of the pointer is set.
+	 * The page->mem_cgroup pointer can be asynchronously changed
+	 * from NULL to (obj_cgroup_vec | 0x1UL), but can't be changed
+	 * from a valid memcg pointer to objcg vector or back.
+	 */
+	if (!page->mem_cgroup)
+		return NULL;
+
 	/*
 	 * Slab objects are accounted individually, not per-page.
 	 * Memcg membership data for each individual object is saved in
--=20
2.26.2

