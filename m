Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533E7C34035
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353CF24125
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgBRI1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 03:27:40 -0500
Received: from mga07.intel.com ([134.134.136.100]:18962 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbgBRI1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 03:27:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 00:27:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,455,1574150400"; 
   d="scan'208";a="235466721"
Received: from yhuang-dev.sh.intel.com ([10.239.159.151])
  by orsmga003.jf.intel.com with ESMTP; 18 Feb 2020 00:27:35 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Feng Tang <feng.tang@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [RFC -V2 7/8] autonuma, memory tiering: Double hot threshold for write hint page fault
Date:   Tue, 18 Feb 2020 16:26:33 +0800
Message-Id: <20200218082634.1596727-8-ying.huang@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200218082634.1596727-1-ying.huang@intel.com>
References: <20200218082634.1596727-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

The write performance of PMEM is much worse than its read
performance.  So even if a write-mostly pages is colder than a
read-mostly pages, it is usually better to put the write-mostly pages
in DRAM and read-mostly pages in PMEM.

To give write-mostly pages more opportunity to be promoted to DRAM, in
this patch, the hot threshold for write hint page fault is
doubled (easier to be promoted).

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/sched/numa_balancing.h | 1 +
 kernel/sched/fair.c                  | 2 ++
 mm/memory.c                          | 3 +++
 3 files changed, 6 insertions(+)

diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/numa_balancing.h
index 4899ec000245..518b3d6143ba 100644
--- a/include/linux/sched/numa_balancing.h
+++ b/include/linux/sched/numa_balancing.h
@@ -15,6 +15,7 @@
 #define TNF_FAULT_LOCAL	0x08
 #define TNF_MIGRATE_FAIL 0x10
 #define TNF_YOUNG	0x20
+#define TNF_WRITE	0x40
 
 #ifdef CONFIG_NUMA_BALANCING
 extern void task_numa_fault(int last_node, int node, int pages, int flags);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 773f3220efc4..e5f7f4139c82 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1513,6 +1513,8 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 			return false;
 
 		th = msecs_to_jiffies(sysctl_numa_balancing_hot_threshold);
+		if (flags & TNF_WRITE)
+			th *= 2;
 		latency = numa_hint_fault_latency(p, addr);
 		if (latency > th)
 			return false;
diff --git a/mm/memory.c b/mm/memory.c
index 207caa9e61da..595d3cd62f61 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3829,6 +3829,9 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	if (pte_young(old_pte))
 		flags |= TNF_YOUNG;
 
+	if (vmf->flags & FAULT_FLAG_WRITE)
+		flags |= TNF_WRITE;
+
 	page = vm_normal_page(vma, vmf->address, pte);
 	if (!page)
 		goto unmap_out;
-- 
2.24.1

