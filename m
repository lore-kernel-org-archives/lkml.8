Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4CFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 03:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8966F20759
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 03:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="m1j4Imhq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgG1Dtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 23:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgG1Dtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 23:49:51 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C95C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 20:49:50 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l12so52989pgt.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 20:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z3SI+30oOVrpwqsXeNOLZYsvl71fQHWoVD8BD0w11Y4=;
        b=m1j4ImhqUvVsJlCysIaLIa+0F0en/dGCbB8Cc/eXZdN2jA/FyigBfIryL7CxgAgnac
         dVpKf59T0JX31gcT3xQzih+jBS/ZWcSWdKtBw+WvIcCQBaxC6PT/JHo3vUrrEwGP4443
         60vtBVvN9mm+YY3UgK0Y0zAxXaC7r7imSweg58Yn4HxmYfROOW93IWKmMq40Zi02XEQ9
         CVqyZQHT/6GmzkVumNtbUAwf9dDN4cMJpybTQnzrF2KlmMQ+sCykF0Q0tfn0Oz+tol0O
         xd4iAkIpLH/nQfCfMloU0Cpb9LDK6vLjJ7tpFAfQEblyFd17oK+MMeYY9ijOXeeVmvE/
         vtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z3SI+30oOVrpwqsXeNOLZYsvl71fQHWoVD8BD0w11Y4=;
        b=YrPttsl4FZ2vHijwumihkJWCcNh7RdsPJIrbj8Kni4koDYLXKLrkUaJ8Wl+mm7Yahg
         AgLlx2DUFsqEOccEZT9BAcvfPr5eE6lF7ouHwHCsa6xOmqjWajxfU3UwZRHy/7AXutAX
         o+wD8+SyCHilWZccHAxzZ+/fpZcUgVP6wPKI6QpTlrbpHifPlYEJ558q30qtBx6xH31Y
         6ZCyQUT9IaFJN8Dj38Ge5pwdTmfLMHAh5KVS0qUgL50AtX2b50qj1Fq877CLgeHyVp50
         GPijjEZZe6ghhvv9VQQjDXBRtHfZPDT4e96I7aQ9czq1JBSdRU9Rqs3UB0NHB8LJXRjj
         cJeA==
X-Gm-Message-State: AOAM532b2J/SSm7N+cdN1GYHrq1MFIIg/54ycM8RuXY1hEVntnpbz7R0
        B7FrprWzVxwVUPLGx6pfwd6Y1g==
X-Google-Smtp-Source: ABdhPJwC18jLGNlBf5fgSrSHm5lWvDB/pjThuDuosU8klfALgU/Lav9js8Gi4STVcOQ7z3JqJ8Xecg==
X-Received: by 2002:a63:29c8:: with SMTP id p191mr23590926pgp.333.1595908190337;
        Mon, 27 Jul 2020 20:49:50 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.221.71])
        by smtp.gmail.com with ESMTPSA id f1sm3872558pjo.1.2020.07.27.20.49.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2020 20:49:49 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mhocko@kernel.org
Cc:     rientjes@google.com, mgorman@suse.de, walken@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Jianchao Guo <guojianchao@bytedance.com>
Subject: [PATCH v4] mm/hugetlb: add mempolicy check in the reservation routine
Date:   Tue, 28 Jul 2020 11:49:38 +0800
Message-Id: <20200728034938.14993-1-songmuchun@bytedance.com>
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
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
changelog in v4:
 1) Fix compilation errors with !CONFIG_NUMA.

changelog in v3:
 1) Do not allocate nodemask on the stack.
 2) Update comment.

changelog in v2:
 1) Reuse policy_nodemask().

 include/linux/mempolicy.h | 14 ++++++++++++++
 mm/hugetlb.c              | 22 ++++++++++++++++++----
 mm/mempolicy.c            |  2 +-
 3 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index ea9c15b60a96..0656ece1ccf1 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -152,6 +152,15 @@ extern int huge_node(struct vm_area_struct *vma,
 extern bool init_nodemask_of_mempolicy(nodemask_t *mask);
 extern bool mempolicy_nodemask_intersects(struct task_struct *tsk,
 				const nodemask_t *mask);
+extern nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy);
+
+static inline nodemask_t *policy_nodemask_current(gfp_t gfp)
+{
+	struct mempolicy *mpol = get_task_policy(current);
+
+	return policy_nodemask(gfp, mpol);
+}
+
 extern unsigned int mempolicy_slab_node(void);
 
 extern enum zone_type policy_zone;
@@ -281,5 +290,10 @@ static inline int mpol_misplaced(struct page *page, struct vm_area_struct *vma,
 static inline void mpol_put_task_policy(struct task_struct *task)
 {
 }
+
+static inline nodemask_t *policy_nodemask_current(gfp_t gfp)
+{
+	return NULL;
+}
 #endif /* CONFIG_NUMA */
 #endif
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 589c330df4db..a34458f6a475 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3463,13 +3463,21 @@ static int __init default_hugepagesz_setup(char *s)
 }
 __setup("default_hugepagesz=", default_hugepagesz_setup);
 
-static unsigned int cpuset_mems_nr(unsigned int *array)
+static unsigned int allowed_mems_nr(struct hstate *h)
 {
 	int node;
 	unsigned int nr = 0;
+	nodemask_t *mpol_allowed;
+	unsigned int *array = h->free_huge_pages_node;
+	gfp_t gfp_mask = htlb_alloc_mask(h);
+
+	mpol_allowed = policy_nodemask_current(gfp_mask);
 
-	for_each_node_mask(node, cpuset_current_mems_allowed)
-		nr += array[node];
+	for_each_node_mask(node, cpuset_current_mems_allowed) {
+		if (!mpol_allowed ||
+		    (mpol_allowed && node_isset(node, *mpol_allowed)))
+			nr += array[node];
+	}
 
 	return nr;
 }
@@ -3648,12 +3656,18 @@ static int hugetlb_acct_memory(struct hstate *h, long delta)
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

