Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C6EC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86BB720737
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="y29o8C04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgGXKEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgGXKEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 06:04:33 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656CDC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 03:04:32 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t15so4965782pjq.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 03:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PDq08UfcHyj6+6rEhdFsfeotLZI6cWTIuXXHWydk68A=;
        b=y29o8C04GZJUhOPGiSlAir+gPNlvD/rgNnU8oWAbzZbsABkpbazzs6kC4f7iYqWzGb
         EAWp3sEUh6RVdqR32pc5OPVqaeyrnNNqjICK1rhe8boLDk4FoRIYvzbUwyOraBN2GoIm
         eTBjD3gw3weUBPKa1I6ck3K2sKs/P3hES8xTGNMVZ8g446CHMLm6F99ADzMKDvg6RZj9
         H44vdj2iq3UDmJDWww0pRvITeR3vdlGqeYoxQAypDjmhBYcLAGaD1mn0odB+rS6a/O5u
         tuFjTCOXOEXQuZw/QBx08qMX2gEnfLxTwd0hLLHwt7sAMqRLnCP1nXVLkxdNcSjdEQjT
         /64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PDq08UfcHyj6+6rEhdFsfeotLZI6cWTIuXXHWydk68A=;
        b=ZoWnA2Rbo+NacPYdyEIeJEdAKdyQfEwd2kMURCdkZ4Z06Bu0LmGGKfLIXmqnD7U+OB
         rhW5agcQ4maOqQkqRkxTaX4QAj5nBCLUE/EXOdT7Dk78e57Y4hn1idp1OdvzvpJUCX+E
         6GbB0NXosZpzwl1Fv8xznYRzEyl3mDF3W6Qeyyiayr93F/DUBxlHCXSsLrkQj00QY/Um
         BneKmvlKxpkeKUL9GfbajmPBbv17lB0gRNkLQthfykr42qMSIMv0xG8s46Z9P78rFL5C
         ENNx70DwmY2FmPSmqbe/17wTOFl45rDNsF/tpP6Cpxy6HvIKzszGVuf9z7r8WTFNzuUY
         iApg==
X-Gm-Message-State: AOAM533lev54uF5ALe3q/wZZBy45obKEt1X2z2St8bckOGJ3gB5RCpWF
        sxymhK2QBXSMWfDdsICVbPEf9w==
X-Google-Smtp-Source: ABdhPJx+6H4KwZnetYtN53HnKs879xDwLlf0ryIlWuRVoZYZ5MvYAweCLwibCKAjyRmw1QGwVq4B+Q==
X-Received: by 2002:a17:902:6842:: with SMTP id f2mr7810015pln.281.1595585071925;
        Fri, 24 Jul 2020 03:04:31 -0700 (PDT)
Received: from localhost.localdomain ([103.136.221.72])
        by smtp.gmail.com with ESMTPSA id h6sm5802866pfo.123.2020.07.24.03.04.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jul 2020 03:04:31 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mhocko@kernel.org
Cc:     rientjes@google.com, mgorman@suse.de, walken@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Jianchao Guo <guojianchao@bytedance.com>
Subject: [PATCH v2] mm/hugetlb: add mempolicy check in the reservation routine
Date:   Fri, 24 Jul 2020 18:03:06 +0800
Message-Id: <20200724100306.33457-1-songmuchun@bytedance.com>
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

Reported-by: Jianchao Guo <guojianchao@bytedance.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---

changelog in v2:
 1) Reuse policy_nodemask().

 include/linux/mempolicy.h |  1 +
 mm/hugetlb.c              | 19 ++++++++++++++++---
 mm/mempolicy.c            |  2 +-
 3 files changed, 18 insertions(+), 4 deletions(-)

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
index 589c330df4db..a753fe8591b4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3463,12 +3463,25 @@ static int __init default_hugepagesz_setup(char *s)
 }
 __setup("default_hugepagesz=", default_hugepagesz_setup);
 
-static unsigned int cpuset_mems_nr(unsigned int *array)
+static unsigned int allowed_mems_nr(struct hstate *h)
 {
 	int node;
 	unsigned int nr = 0;
+	struct mempolicy *mpol = get_task_policy(current);
+	nodemask_t *mpol_allowed, *mems_allowed, nodemask;
+	unsigned int *array = h->free_huge_pages_node;
+	gfp_t gfp_mask = htlb_alloc_mask(h);
+
+	mpol_allowed = policy_nodemask(gfp_mask, mpol);
+	if (mpol_allowed) {
+		nodes_and(nodemask, cpuset_current_mems_allowed,
+			  *mpol_allowed);
+		mems_allowed = &nodemask;
+	} else {
+		mems_allowed = &cpuset_current_mems_allowed;
+	}
 
-	for_each_node_mask(node, cpuset_current_mems_allowed)
+	for_each_node_mask(node, *mems_allowed)
 		nr += array[node];
 
 	return nr;
@@ -3653,7 +3666,7 @@ static int hugetlb_acct_memory(struct hstate *h, long delta)
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

