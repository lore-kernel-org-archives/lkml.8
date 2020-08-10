Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A84C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5B3F20716
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgHJV1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:27:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:25814 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgHJV1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 17:27:41 -0400
IronPort-SDR: 8oUGyimJMbuFC8gpdDszdjxqANLq0oVE6Kb9WlWl8CMd9/Jk6PvxWkVPuH+a71ej8Mh7yc2jOI
 aA5sERwKUotg==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="171665939"
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="171665939"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 14:27:40 -0700
IronPort-SDR: QCyTk16bpwZ0j5tM4WJCiuQNprw0xU5p8DXM8SW/QWzpGUjfgrwoCQQiTXrjBETKmIDzi1re6P
 zVYrdiPhYewA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="469196751"
Received: from ssp-icl-u-210.jf.intel.com ([10.54.55.52])
  by orsmga005.jf.intel.com with ESMTP; 10 Aug 2020 14:27:40 -0700
From:   Kan Liang <kan.liang@linux.intel.com>
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V6 01/16] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
Date:   Mon, 10 Aug 2020 14:24:21 -0700
Message-Id: <20200810212436.8026-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200810212436.8026-1-kan.liang@linux.intel.com>
References: <20200810212436.8026-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current perf can report both virtual addresses and physical addresses,
but not the page size. Without the page size information of the utilized
page, users cannot decide whether to promote/demote large pages to
optimize memory usage.

Add a new sample type for the data page size.

Current perf already has a facility to collect data virtual addresses.
A page walker is required to walk the pages tables and calculate the
page size from a given virtual address.

On some platforms, e.g., X86, the page walker is invoked in an NMI
handler. So the page walker must be IRQ-safe and low overhead. Besides,
the page walker should work for both user and kernel virtual address.
The existing generic page walker, e.g., walk_page_range_novma(), is a
little bit complex and doesn't guarantee the IRQ-safe. The follow_page()
is only for user-virtual address.

Add a new function perf_get_page_size() to walk the page tables and
calculate the page size. In the function:
- Interrupts have to be disabled to prevent any teardown of the page
  tables.
- The size of a normal page is from the pre-defined page size macros.
- The size of a compound page is retrieved from the helper function,
  page_size().

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 include/linux/perf_event.h      |   1 +
 include/uapi/linux/perf_event.h |   4 +-
 kernel/events/core.c            | 121 ++++++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 3737e653f47e..5de95f36d7a8 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1035,6 +1035,7 @@ struct perf_sample_data {
 
 	u64				phys_addr;
 	u64				cgroup;
+	u64				data_page_size;
 } ____cacheline_aligned;
 
 /* default value for data source */
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 52ca2093831c..32484accc7a3 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -143,8 +143,9 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
 	PERF_SAMPLE_AUX				= 1U << 20,
 	PERF_SAMPLE_CGROUP			= 1U << 21,
+	PERF_SAMPLE_DATA_PAGE_SIZE		= 1U << 22,
 
-	PERF_SAMPLE_MAX = 1U << 22,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 23,		/* non-ABI */
 
 	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
@@ -879,6 +880,7 @@ enum perf_event_type {
 	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
 	 *	{ u64			size;
 	 *	  char			data[size]; } && PERF_SAMPLE_AUX
+	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			= 9,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0fbf17ff7cc5..00becacfd15e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -51,6 +51,7 @@
 #include <linux/proc_ns.h>
 #include <linux/mount.h>
 #include <linux/min_heap.h>
+#include <linux/highmem.h>
 
 #include "internal.h"
 
@@ -1895,6 +1896,9 @@ static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
 	if (sample_type & PERF_SAMPLE_CGROUP)
 		size += sizeof(data->cgroup);
 
+	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
+		size += sizeof(data->data_page_size);
+
 	event->header_size = size;
 }
 
@@ -6939,6 +6943,9 @@ void perf_output_sample(struct perf_output_handle *handle,
 	if (sample_type & PERF_SAMPLE_CGROUP)
 		perf_output_put(handle, data->cgroup);
 
+	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
+		perf_output_put(handle, data->data_page_size);
+
 	if (sample_type & PERF_SAMPLE_AUX) {
 		perf_output_put(handle, data->aux_size);
 
@@ -6996,6 +7003,117 @@ static u64 perf_virt_to_phys(u64 virt)
 	return phys_addr;
 }
 
+#ifdef CONFIG_MMU
+
+static u64 __perf_get_page_size(struct mm_struct *mm, unsigned long addr)
+{
+	struct page *page;
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	pgd = pgd_offset(mm, addr);
+	if (pgd_none(*pgd))
+		return 0;
+
+	p4d = p4d_offset(pgd, addr);
+	if (!p4d_present(*p4d))
+		return 0;
+
+#if (defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE))
+	if (p4d_leaf(*p4d)) {
+		page = p4d_page(*p4d);
+
+		if (PageCompound(page))
+			return page_size(compound_head(page));
+
+		return P4D_SIZE;
+	}
+#endif
+
+	pud = pud_offset(p4d, addr);
+	if (!pud_present(*pud))
+		return 0;
+
+#if (defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE))
+	if (pud_leaf(*pud)) {
+		page = pud_page(*pud);
+
+		if (PageCompound(page))
+			return page_size(compound_head(page));
+
+		return PUD_SIZE;
+	}
+#endif
+
+	pmd = pmd_offset(pud, addr);
+	if (!pmd_present(*pmd))
+		return 0;
+
+#if (defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE))
+	if (pmd_leaf(*pmd)) {
+		page = pmd_page(*pmd);
+
+		if (PageCompound(page))
+			return page_size(compound_head(page));
+
+		return PMD_SIZE;
+	}
+#endif
+
+	pte = pte_offset_map(pmd, addr);
+	if (!pte_present(*pte)) {
+		pte_unmap(pte);
+		return 0;
+	}
+
+	pte_unmap(pte);
+	return PAGE_SIZE;
+}
+
+#else
+
+static u64 __perf_get_page_size(struct mm_struct *mm, unsigned long addr)
+{
+	return 0;
+}
+
+#endif
+
+/* Return the page size of a given virtual address. */
+static u64 perf_get_page_size(unsigned long addr)
+{
+	struct mm_struct *mm;
+	unsigned long flags;
+	u64 size;
+
+	if (!addr)
+		return 0;
+
+	/*
+	 * Software page-table walkers must disable IRQs,
+	 * which prevents any tear down of the page tables.
+	 */
+	local_irq_save(flags);
+
+	mm = current->mm;
+	if (!mm) {
+		/*
+		 * For kernel threads and the like, use init_mm so that
+		 * we can find kernel memory.
+		 */
+		mm = &init_mm;
+	}
+
+	size = __perf_get_page_size(mm, addr);
+
+	local_irq_restore(flags);
+
+	return size;
+}
+
 static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
 
 struct perf_callchain_entry *
@@ -7151,6 +7269,9 @@ void perf_prepare_sample(struct perf_event_header *header,
 	}
 #endif
 
+	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
+		data->data_page_size = perf_get_page_size(data->addr);
+
 	if (sample_type & PERF_SAMPLE_AUX) {
 		u64 size;
 
-- 
2.17.1

