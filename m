Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B16CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 00:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F2D02074D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 00:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgHYAYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 20:24:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:28306 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgHYAYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 20:24:45 -0400
IronPort-SDR: xqHfWu96puet695bY6JRuINGoux+zwueRLOtfzyjQhsJVksKNCBNvY4Qoi5mOri+fZIEx7FT6c
 muvp/6v+J9eQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="143670253"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="143670253"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:24:45 -0700
IronPort-SDR: MtGg5mOs/IDkLKaqt+QPQJD6f31cfW72KzhVgxXzfncPKSnpMAA/Dt9Nbm4beW7eNzyPpi55wm
 EROedV1onnHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="443428049"
Received: from huiyao-mobl2.ccr.corp.intel.com (HELO yhuang-mobile.ccr.corp.intel.com) ([10.254.214.197])
  by orsmga004.jf.intel.com with ESMTP; 24 Aug 2020 17:24:41 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [RFC -V3 2/5] autonuma, memory tiering: Skip to scan fast memory
Date:   Tue, 25 Aug 2020 08:23:51 +0800
Message-Id: <20200825002354.17038-3-ying.huang@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825002354.17038-1-ying.huang@intel.com>
References: <20200825002354.17038-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the AutoNUMA isn't used to optimize the page placement among
sockets but only among memory types, the hot pages in the fast memory
node couldn't be migrated (promoted) to anywhere.  So it's unnecessary
to scan the pages in the fast memory node via changing their PTE/PMD
mapping to be PROT_NONE.  So that the page faults could be avoided
too.

In the test, if only the memory tiering AutoNUMA mode is enabled, the
number of the AutoNUMA hint faults for the DRAM node is reduced to
almost 0 with the patch.  While the benchmark score doesn't change
visibly.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/node.h |  5 +++++
 mm/huge_memory.c     | 30 +++++++++++++++++++++---------
 mm/mprotect.c        | 13 ++++++++++++-
 3 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/include/linux/node.h b/include/linux/node.h
index f7a539390c81..ac0e7a45edff 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -189,4 +189,9 @@ static inline int next_demotion_node(int node)
 }
 #endif
 
+static inline bool node_is_toptier(int node)
+{
+	return node_state(node, N_CPU);
+}
+
 #endif /* _LINUX_NODE_H_ */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 78c84bee7e29..7d5db965a48c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -33,6 +33,7 @@
 #include <linux/oom.h>
 #include <linux/numa.h>
 #include <linux/page_owner.h>
+#include <linux/sched/sysctl.h>
 
 #include <asm/tlb.h>
 #include <asm/pgalloc.h>
@@ -1821,17 +1822,28 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 	}
 #endif
 
-	/*
-	 * Avoid trapping faults against the zero page. The read-only
-	 * data is likely to be read-cached on the local CPU and
-	 * local/remote hits to the zero page are not interesting.
-	 */
-	if (prot_numa && is_huge_zero_pmd(*pmd))
-		goto unlock;
+	if (prot_numa) {
+		struct page *page;
+		/*
+		 * Avoid trapping faults against the zero page. The read-only
+		 * data is likely to be read-cached on the local CPU and
+		 * local/remote hits to the zero page are not interesting.
+		 */
+		if (is_huge_zero_pmd(*pmd))
+			goto unlock;
 
-	if (prot_numa && pmd_protnone(*pmd))
-		goto unlock;
+		if (pmd_protnone(*pmd))
+			goto unlock;
 
+		page = pmd_page(*pmd);
+		/*
+		 * Skip scanning top tier node if normal numa
+		 * balancing is disabled
+		 */
+		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
+		    node_is_toptier(page_to_nid(page)))
+			goto unlock;
+	}
 	/*
 	 * In case prot_numa, we are under mmap_read_lock(mm). It's critical
 	 * to not clear pmd intermittently to avoid race with MADV_DONTNEED
diff --git a/mm/mprotect.c b/mm/mprotect.c
index ce8b8a5eacbb..8abec0c267fa 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -29,6 +29,7 @@
 #include <linux/uaccess.h>
 #include <linux/mm_inline.h>
 #include <linux/pgtable.h>
+#include <linux/sched/sysctl.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
@@ -83,6 +84,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			 */
 			if (prot_numa) {
 				struct page *page;
+				int nid;
 
 				/* Avoid TLB flush if possible */
 				if (pte_protnone(oldpte))
@@ -109,7 +111,16 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				 * Don't mess with PTEs if page is already on the node
 				 * a single-threaded process is running on.
 				 */
-				if (target_node == page_to_nid(page))
+				nid = page_to_nid(page);
+				if (target_node == nid)
+					continue;
+
+				/*
+				 * Skip scanning top tier node if normal numa
+				 * balancing is disabled
+				 */
+				if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
+				    node_is_toptier(nid))
 					continue;
 			}
 
-- 
2.27.0

