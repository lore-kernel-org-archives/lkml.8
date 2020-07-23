Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776E1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 510C120714
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="k2QQsu/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgGWHpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 03:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgGWHpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 03:45:07 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1EDC0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 00:45:07 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id w17so2180949ply.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 00:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GlrEuOnc8m9qfFKEmGd35c8KAaqdG3oG7G+fWZk2PVw=;
        b=k2QQsu/oPzg9h9QS226YCvxxGTqjMuGzTSIL9OemCJtcKgtr9y6fHZwRO3mA1Njiym
         rrPygf6i1qZhelPIDyNsKq8n/4FLglc0Laf0Bqwa1Cb7h2l0h/ov++9bfLrAA9vt2rr4
         QI04xlSoXpNO/Zy3X59z7dEdTz8Cr3KfRIaJ4/Ua+Z1jJqWJulgQsAGrlThol6DcuHXx
         G1IGmSOBt/IAYEp+LlEwOvCveMliiIK//w5r0NhygI1uNoeGpmLwBbjtmxzDZIrVUHTW
         UFqG5oEQS81yjJNXsXmogre95nI8lsWdgmBYVqanG/XAc2i/8TSlZgYgNmHlY9I8BAzU
         J3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GlrEuOnc8m9qfFKEmGd35c8KAaqdG3oG7G+fWZk2PVw=;
        b=lHOKk33hLoXSNAJNpteUlDOUWdG6DEBdMVxL3Mg7gU9wUC9Z+kXxQVOqxhAXn97F4U
         FaCQWBofjcbwIJ004dEf8CzsfRSFyo6ZdvHulk9UTCbBIkZdHes1vAX/x9F7EXN7WzAE
         C2CDqlpFetRgTxWdFW4uz2/ITG2NWL3D+HXR2ql2JkHyn3AOtybW+7Qva6EcWhd/Gc/1
         Dfo3lVABE+VdIwMY/F9awGZpV2Oc+auJwvN8//R+NZ3RmK0arL9QUzzBQcDJ9bINgwTy
         +IFgoq0JbYm5wlVxYFUuOCC/ObeC0i0NPclNb1VzWQHMhFgklu4U+P4jdk8osAYxNxdS
         RSVw==
X-Gm-Message-State: AOAM530J5wROD9Dlu3LO32gw4DWREfNxr0vPhmCwiIsd1k72AGwRkr/G
        jU6hlC3Ko2OyGvZBN8h6sfRnfg==
X-Google-Smtp-Source: ABdhPJzrTrP1vmoeo8u6usfXOm0nqCvSjUfCxJNhmcLL3AoexdxLEKQYKZHRjnbd2vt3RjE6v9ejMw==
X-Received: by 2002:a17:90a:362e:: with SMTP id s43mr3076100pjb.217.1595490307281;
        Thu, 23 Jul 2020 00:45:07 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.220.69])
        by smtp.gmail.com with ESMTPSA id 7sm1908904pgw.85.2020.07.23.00.45.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2020 00:45:06 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Jianchao Guo <guojianchao@bytedance.com>
Subject: [PATCH] mm/hugetlb: add mempolicy check in the reservation routine
Date:   Thu, 23 Jul 2020 15:44:17 +0800
Message-Id: <20200723074417.89467-1-songmuchun@bytedance.com>
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
 mm/hugetlb.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 589c330df4db..e946f41b4dcb 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3463,12 +3463,36 @@ static int __init default_hugepagesz_setup(char *s)
 }
 __setup("default_hugepagesz=", default_hugepagesz_setup);
 
-static unsigned int cpuset_mems_nr(unsigned int *array)
+static nodemask_t *mempolicy_current_bind_nodemask(void)
+{
+	struct mempolicy *mpol;
+	nodemask_t *nodemask;
+
+	mpol = get_task_policy(current);
+	if (mpol->mode == MPOL_BIND)
+		nodemask = &mpol->v.nodes;
+	else
+		nodemask = NULL;
+
+	return nodemask;
+}
+
+static unsigned int allowed_mems_nr(unsigned int *array)
 {
 	int node;
 	unsigned int nr = 0;
+	nodemask_t *mempolicy_allowed, *mems_allowed, nodemask;
+
+	mempolicy_allowed = mempolicy_current_bind_nodemask();
+	if (mempolicy_allowed) {
+		nodes_and(nodemask, cpuset_current_mems_allowed,
+			  *mempolicy_allowed);
+		mems_allowed = &nodemask;
+	} else {
+		mems_allowed = &cpuset_current_mems_allowed;
+	}
 
-	for_each_node_mask(node, cpuset_current_mems_allowed)
+	for_each_node_mask(node, *mems_allowed)
 		nr += array[node];
 
 	return nr;
@@ -3653,7 +3677,7 @@ static int hugetlb_acct_memory(struct hstate *h, long delta)
 		if (gather_surplus_pages(h, delta) < 0)
 			goto out;
 
-		if (delta > cpuset_mems_nr(h->free_huge_pages_node)) {
+		if (delta > allowed_mems_nr(h->free_huge_pages_node)) {
 			return_unused_surplus_pages(h, delta);
 			goto out;
 		}
-- 
2.11.0

