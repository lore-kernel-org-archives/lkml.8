Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1176AC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 08:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC072206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 08:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="Eq9ln5/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgGYIIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 04:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgGYIID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 04:08:03 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85124C0619D3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 01:08:03 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id m22so6659189pgv.9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 01:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V3e7B98suvcaIJcRxtAbRV7MtSqXxZMIYgOr8Y/2Cho=;
        b=Eq9ln5/Vrq7DfMiTlCglaTXw34Kc7eYgvg/zVIqgBwBC8l6xT55SAfH/E/xkG5j67i
         48yEV0H52Lu5VNIEKu+gB+2wIpy+MsmgxPvw8FCgyhQX98SesXuia0rcjCftjKeYH6Z5
         JpOOeBHWd/VyFICsrM7d7hRnsKi3LFl4KMnAxTQK9LhrHJlcxfBVB5ykLtTXmZL2BzDL
         xi00wdjC29JvLBqqMFngq3Byg+qsqqgFkB10P4RVrDNlGlPToVD4Rh3zuz25msQwNaLU
         /aBWSDfns4t5S5+ZyZLxDWAyktqlpGmfSgsOHnujyKs0s656pjsjbCiqW6PjPOpJsfQW
         b9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V3e7B98suvcaIJcRxtAbRV7MtSqXxZMIYgOr8Y/2Cho=;
        b=uU8qPsE7JLLScp+CTI+fB6cAMGuJFNK4WW9jI+u/2qxRdzbP0APlh6NGwSalJjWIhF
         vO/uNW93rGTIULD31SJ4OZWY/R3QbZ0QSkwEdR1TyPIuWyC1pe0Hwkm8rhO9zNHyTKTR
         HD5+Qcn67+2LdYqSI860/Z9ioLXTG3J1h1EqUwg9VcOwP1VV9J8hsBq2+c5npjtKBZuv
         vEx2jPNEyBZHFH38XjbfbV4lBlFLa5mOMBzV2zEOg/PEhsUm0xOZoYciM7AtikSdHhNO
         ltPtDwraKS2Mk7w0FzVdvcPZbSVBpINLzAZFMvX6aSNOPMPsw+6aHMMXemY7t7UQAl+t
         37ng==
X-Gm-Message-State: AOAM5320qyMo4eUNtFk6mbHq2J574f4O2N7pIgSUAP/exBq2baPPoMN8
        31hTqSsSjjKTEEVYfTWWHfsP4A==
X-Google-Smtp-Source: ABdhPJwieFWFKBo6dK2nsLGlPvz7ZpBX1E2byH5k1yp9JTkjjhFKRy4UbI4RDxPgUf0YN/PVOi6Xvw==
X-Received: by 2002:a62:ab17:: with SMTP id p23mr12981470pff.177.1595664482856;
        Sat, 25 Jul 2020 01:08:02 -0700 (PDT)
Received: from localhost.localdomain ([103.136.221.71])
        by smtp.gmail.com with ESMTPSA id r4sm7786127pji.37.2020.07.25.01.07.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Jul 2020 01:08:02 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mhocko@kernel.org
Cc:     rientjes@google.com, mgorman@suse.de, walken@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Jianchao Guo <guojianchao@bytedance.com>
Subject: [PATCH v3] mm/hugetlb: add mempolicy check in the reservation routine
Date:   Sat, 25 Jul 2020 16:07:49 +0800
Message-Id: <20200725080749.70470-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the reservation routine, we only check whether the cpuset meets
the memory allocation requirements. But we ignore the mempolicy of
MPOL_BIND case. If someone mmap hugetlb succeeds, but the subsequent
memory allocation may fail due to mempolicy restrictions and receives
the SIGBUS signal. This can be reproduced by the follow steps.

 1) Compile the test case.
    cd tools/testing/selftests/vm/
    gcc map_hugetlb.c -o map_hugetlb

 2) Pre-allocate huge pages. Suppose there are 2 numa nodes in the
    system. Each node will pre-allocate one huge page.
    echo 2 > /proc/sys/vm/nr_hugepages

 3) Run test case(mmap 4MB). We receive the SIGBUS signal.
    numactl --membind=0 ./map_hugetlb 4

With this patch applied, the mmap will fail in the step 3) and throw
"mmap: Cannot allocate memory".

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reported-by: Jianchao Guo <guojianchao@bytedance.com>
Suggested-by: Michal Hocko <mhocko@kernel.org>
---
chagelog in v3:
 1) Do not allocate nodemask on the stack.
 2) Update comment.

changelog in v2:
 1) Reuse policy_nodemask().

 include/linux/mempolicy.h |  1 +
 mm/hugetlb.c              | 23 +++++++++++++++++++----
 mm/mempolicy.c            |  2 +-
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index ea9c15b60a96..6b9640f1c990 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -152,6 +152,7 @@ extern int huge_node(struct vm_area_struct *vma,
 extern bool init_nodemask_of_mempolicy(nodemask_t *mask);
 extern bool mempolicy_nodemask_intersects(struct task_struct *tsk,
 				const nodemask_t *mask);
+extern nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy);
 extern unsigned int mempolicy_slab_node(void);
 
 extern enum zone_type policy_zone;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 589c330df4db..6f8e79e76676 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3463,13 +3463,22 @@ static int __init default_hugepagesz_setup(char *s)
 }
 __setup("default_hugepagesz=", default_hugepagesz_setup);
 
-static unsigned int cpuset_mems_nr(unsigned int *array)
+static unsigned int allowed_mems_nr(struct hstate *h)
 {
 	int node;
 	unsigned int nr = 0;
+	struct mempolicy *mpol = get_task_policy(current);
+	nodemask_t *mpol_allowed;
+	unsigned int *array = h->free_huge_pages_node;
+	gfp_t gfp_mask = htlb_alloc_mask(h);
+
+	mpol_allowed = policy_nodemask(gfp_mask, mpol);
 
-	for_each_node_mask(node, cpuset_current_mems_allowed)
-		nr += array[node];
+	for_each_node_mask(node, cpuset_current_mems_allowed) {
+		if (!mpol_allowed ||
+		    (mpol_allowed && node_isset(node, *mpol_allowed)))
+			nr += array[node];
+	}
 
 	return nr;
 }
@@ -3648,12 +3657,18 @@ static int hugetlb_acct_memory(struct hstate *h, long delta)
 	 * we fall back to check against current free page availability as
 	 * a best attempt and hopefully to minimize the impact of changing
 	 * semantics that cpuset has.
+	 *
+	 * Apart from cpuset, we also have memory policy mechanism that
+	 * also determines from which node the kernel will allocate memory
+	 * in a NUMA system. So similar to cpuset, we also should consider
+	 * the memory policy of the current task. Similar to the description
+	 * above.
 	 */
 	if (delta > 0) {
 		if (gather_surplus_pages(h, delta) < 0)
 			goto out;
 
-		if (delta > cpuset_mems_nr(h->free_huge_pages_node)) {
+		if (delta > allowed_mems_nr(h)) {
 			return_unused_surplus_pages(h, delta);
 			goto out;
 		}
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 93fcfc1f2fa2..fce14c3f4f38 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1873,7 +1873,7 @@ static int apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
  * Return a nodemask representing a mempolicy for filtering nodes for
  * page allocation
  */
-static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
+nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
 {
 	/* Lower zones don't get a nodemask applied for MPOL_BIND */
 	if (unlikely(policy->mode == MPOL_BIND) &&
-- 
2.11.0

