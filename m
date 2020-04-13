Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6542C352BE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 12:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7B3C20776
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 12:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbgDMMwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 08:52:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:29931 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728767AbgDMMwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 08:52:30 -0400
IronPort-SDR: +Au6w+1OP9G73WQktfAMvO+wBRGi3tnw3ppAutVwlVl0GgASE2bX/k97KwMA8debm25yMzq0Ij
 kU119Q8wuDJg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 05:52:28 -0700
IronPort-SDR: 9ylfgkNUYdkUzHqDLgCDh2/YdJWB5XdzWrT8G6ZxpXQhsyg2KYC6Jxjnu+Z7FcUmn2Sone+GHJ
 zjNqrDViq0rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="399597447"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 13 Apr 2020 05:52:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 1228A308; Mon, 13 Apr 2020 15:52:22 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3, RESEND 8/8] khugepaged: Introduce 'max_ptes_shared' tunable
Date:   Mon, 13 Apr 2020 15:52:20 +0300
Message-Id: <20200413125220.663-9-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200413125220.663-1-kirill.shutemov@linux.intel.com>
References: <20200413125220.663-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'max_ptes_shared' specifies how many pages can be shared across multiple
processes. Exceeding the number would block the collapse::

	/sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_shared

A higher value may increase memory footprint for some workloads.

By default, at least half of pages has to be not shared.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 Documentation/admin-guide/mm/transhuge.rst |  7 ++
 include/trace/events/huge_memory.h         |  3 +-
 mm/khugepaged.c                            | 52 ++++++++++++--
 tools/testing/selftests/vm/khugepaged.c    | 83 ++++++++++++++++++++++
 4 files changed, 140 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index bd5714547cee..a10f6a50d48f 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -220,6 +220,13 @@ memory. A lower value can prevent THPs from being
 collapsed, resulting fewer pages being collapsed into
 THPs, and lower memory access performance.
 
+``max_ptes_shared`` specifies how many pages can be shared across multiple
+processes. Exceeding the number would block the collapse::
+
+	/sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_shared
+
+A higher value may increase memory footprint for some workloads.
+
 Boot parameter
 ==============
 
diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index d82a0f4e824d..53532f5925c3 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -12,6 +12,8 @@
 	EM( SCAN_SUCCEED,		"succeeded")			\
 	EM( SCAN_PMD_NULL,		"pmd_null")			\
 	EM( SCAN_EXCEED_NONE_PTE,	"exceed_none_pte")		\
+	EM( SCAN_EXCEED_SWAP_PTE,	"exceed_swap_pte")		\
+	EM( SCAN_EXCEED_SHARED_PTE,	"exceed_shared_pte")		\
 	EM( SCAN_PTE_NON_PRESENT,	"pte_non_present")		\
 	EM( SCAN_PAGE_RO,		"no_writable_page")		\
 	EM( SCAN_LACK_REFERENCED_PAGE,	"lack_referenced_page")		\
@@ -30,7 +32,6 @@
 	EM( SCAN_DEL_PAGE_LRU,		"could_not_delete_page_from_lru")\
 	EM( SCAN_ALLOC_HUGE_PAGE_FAIL,	"alloc_huge_page_failed")	\
 	EM( SCAN_CGROUP_CHARGE_FAIL,	"ccgroup_charge_failed")	\
-	EM( SCAN_EXCEED_SWAP_PTE,	"exceed_swap_pte")		\
 	EM( SCAN_TRUNCATED,		"truncated")			\
 	EMe(SCAN_PAGE_HAS_PRIVATE,	"page_has_private")		\
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 11d500396d85..0730014620e2 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -28,6 +28,8 @@ enum scan_result {
 	SCAN_SUCCEED,
 	SCAN_PMD_NULL,
 	SCAN_EXCEED_NONE_PTE,
+	SCAN_EXCEED_SWAP_PTE,
+	SCAN_EXCEED_SHARED_PTE,
 	SCAN_PTE_NON_PRESENT,
 	SCAN_PAGE_RO,
 	SCAN_LACK_REFERENCED_PAGE,
@@ -46,7 +48,6 @@ enum scan_result {
 	SCAN_DEL_PAGE_LRU,
 	SCAN_ALLOC_HUGE_PAGE_FAIL,
 	SCAN_CGROUP_CHARGE_FAIL,
-	SCAN_EXCEED_SWAP_PTE,
 	SCAN_TRUNCATED,
 	SCAN_PAGE_HAS_PRIVATE,
 };
@@ -71,6 +72,7 @@ static DECLARE_WAIT_QUEUE_HEAD(khugepaged_wait);
  */
 static unsigned int khugepaged_max_ptes_none __read_mostly;
 static unsigned int khugepaged_max_ptes_swap __read_mostly;
+static unsigned int khugepaged_max_ptes_shared __read_mostly;
 
 #define MM_SLOTS_HASH_BITS 10
 static __read_mostly DEFINE_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
@@ -290,15 +292,43 @@ static struct kobj_attribute khugepaged_max_ptes_swap_attr =
 	__ATTR(max_ptes_swap, 0644, khugepaged_max_ptes_swap_show,
 	       khugepaged_max_ptes_swap_store);
 
+static ssize_t khugepaged_max_ptes_shared_show(struct kobject *kobj,
+					     struct kobj_attribute *attr,
+					     char *buf)
+{
+	return sprintf(buf, "%u\n", khugepaged_max_ptes_shared);
+}
+
+static ssize_t khugepaged_max_ptes_shared_store(struct kobject *kobj,
+					      struct kobj_attribute *attr,
+					      const char *buf, size_t count)
+{
+	int err;
+	unsigned long max_ptes_shared;
+
+	err  = kstrtoul(buf, 10, &max_ptes_shared);
+	if (err || max_ptes_shared > HPAGE_PMD_NR-1)
+		return -EINVAL;
+
+	khugepaged_max_ptes_shared = max_ptes_shared;
+
+	return count;
+}
+
+static struct kobj_attribute khugepaged_max_ptes_shared_attr =
+	__ATTR(max_ptes_shared, 0644, khugepaged_max_ptes_shared_show,
+	       khugepaged_max_ptes_shared_store);
+
 static struct attribute *khugepaged_attr[] = {
 	&khugepaged_defrag_attr.attr,
 	&khugepaged_max_ptes_none_attr.attr,
+	&khugepaged_max_ptes_swap_attr.attr,
+	&khugepaged_max_ptes_shared_attr.attr,
 	&pages_to_scan_attr.attr,
 	&pages_collapsed_attr.attr,
 	&full_scans_attr.attr,
 	&scan_sleep_millisecs_attr.attr,
 	&alloc_sleep_millisecs_attr.attr,
-	&khugepaged_max_ptes_swap_attr.attr,
 	NULL,
 };
 
@@ -360,6 +390,7 @@ int __init khugepaged_init(void)
 	khugepaged_pages_to_scan = HPAGE_PMD_NR * 8;
 	khugepaged_max_ptes_none = HPAGE_PMD_NR - 1;
 	khugepaged_max_ptes_swap = HPAGE_PMD_NR / 8;
+	khugepaged_max_ptes_shared = HPAGE_PMD_NR / 2;
 
 	return 0;
 }
@@ -567,7 +598,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 {
 	struct page *page = NULL;
 	pte_t *_pte;
-	int none_or_zero = 0, result = 0, referenced = 0;
+	int none_or_zero = 0, shared = 0, result = 0, referenced = 0;
 	bool writable = false;
 
 	for (_pte = pte; _pte < pte+HPAGE_PMD_NR;
@@ -595,6 +626,12 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 
 		VM_BUG_ON_PAGE(!PageAnon(page), page);
 
+		if (page_mapcount(page) > 1 &&
+				++shared > khugepaged_max_ptes_shared) {
+			result = SCAN_EXCEED_SHARED_PTE;
+			goto out;
+		}
+
 		if (PageCompound(page)) {
 			struct page *p;
 			page = compound_head(page);
@@ -1178,7 +1215,8 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 {
 	pmd_t *pmd;
 	pte_t *pte, *_pte;
-	int ret = 0, none_or_zero = 0, result = 0, referenced = 0;
+	int ret = 0, result = 0, referenced = 0;
+	int none_or_zero = 0, shared = 0;
 	struct page *page = NULL;
 	unsigned long _address;
 	spinlock_t *ptl;
@@ -1228,6 +1266,12 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 			goto out_unmap;
 		}
 
+		if (page_mapcount(page) > 1 &&
+				++shared > khugepaged_max_ptes_shared) {
+			result = SCAN_EXCEED_SHARED_PTE;
+			goto out_unmap;
+		}
+
 		page = compound_head(page);
 
 		/*
diff --git a/tools/testing/selftests/vm/khugepaged.c b/tools/testing/selftests/vm/khugepaged.c
index 34d945e71e2e..7c7283cc7dcc 100644
--- a/tools/testing/selftests/vm/khugepaged.c
+++ b/tools/testing/selftests/vm/khugepaged.c
@@ -77,6 +77,7 @@ struct khugepaged_settings {
 	unsigned int scan_sleep_millisecs;
 	unsigned int max_ptes_none;
 	unsigned int max_ptes_swap;
+	unsigned int max_ptes_shared;
 	unsigned long pages_to_scan;
 };
 
@@ -276,6 +277,7 @@ static void write_settings(struct settings *settings)
 			khugepaged->scan_sleep_millisecs);
 	write_num("khugepaged/max_ptes_none", khugepaged->max_ptes_none);
 	write_num("khugepaged/max_ptes_swap", khugepaged->max_ptes_swap);
+	write_num("khugepaged/max_ptes_shared", khugepaged->max_ptes_shared);
 	write_num("khugepaged/pages_to_scan", khugepaged->pages_to_scan);
 }
 
@@ -312,6 +314,7 @@ static void save_settings(void)
 			read_num("khugepaged/scan_sleep_millisecs"),
 		.max_ptes_none = read_num("khugepaged/max_ptes_none"),
 		.max_ptes_swap = read_num("khugepaged/max_ptes_swap"),
+		.max_ptes_shared = read_num("khugepaged/max_ptes_shared"),
 		.pages_to_scan = read_num("khugepaged/pages_to_scan"),
 	};
 	success("OK");
@@ -843,12 +846,90 @@ static void collapse_fork_compound(void)
 			fail("Fail");
 		fill_memory(p, 0, page_size);
 
+		write_num("khugepaged/max_ptes_shared", hpage_pmd_nr - 1);
 		if (wait_for_scan("Collapse PTE table full of compound pages in child", p))
 			fail("Timeout");
 		else if (check_huge(p))
 			success("OK");
 		else
 			fail("Fail");
+		write_num("khugepaged/max_ptes_shared",
+				default_settings.khugepaged.max_ptes_shared);
+
+		validate_memory(p, 0, hpage_pmd_size);
+		munmap(p, hpage_pmd_size);
+		exit(exit_status);
+	}
+
+	wait(&wstatus);
+	exit_status += WEXITSTATUS(wstatus);
+
+	printf("Check if parent still has huge page...");
+	if (check_huge(p))
+		success("OK");
+	else
+		fail("Fail");
+	validate_memory(p, 0, hpage_pmd_size);
+	munmap(p, hpage_pmd_size);
+}
+
+static void collapse_max_ptes_shared()
+{
+	int max_ptes_shared = read_num("khugepaged/max_ptes_shared");
+	int wstatus;
+	void *p;
+
+	p = alloc_mapping();
+
+	printf("Allocate huge page...");
+	madvise(p, hpage_pmd_size, MADV_HUGEPAGE);
+	fill_memory(p, 0, hpage_pmd_size);
+	if (check_huge(p))
+		success("OK");
+	else
+		fail("Fail");
+
+	printf("Share huge page over fork()...");
+	if (!fork()) {
+		/* Do not touch settings on child exit */
+		skip_settings_restore = true;
+		exit_status = 0;
+
+		if (check_huge(p))
+			success("OK");
+		else
+			fail("Fail");
+
+		printf("Trigger CoW in %d of %d...",
+				hpage_pmd_nr - max_ptes_shared - 1, hpage_pmd_nr);
+		fill_memory(p, 0, (hpage_pmd_nr - max_ptes_shared - 1) * page_size);
+		if (!check_huge(p))
+			success("OK");
+		else
+			fail("Fail");
+
+		if (wait_for_scan("Do not collapse with max_ptes_shared exeeded", p))
+			fail("Timeout");
+		else if (!check_huge(p))
+			success("OK");
+		else
+			fail("Fail");
+
+		printf("Trigger CoW in %d of %d...",
+				hpage_pmd_nr - max_ptes_shared, hpage_pmd_nr);
+		fill_memory(p, 0, (hpage_pmd_nr - max_ptes_shared) * page_size);
+		if (!check_huge(p))
+			success("OK");
+		else
+			fail("Fail");
+
+
+		if (wait_for_scan("Collapse with max_ptes_shared PTEs shared", p))
+			fail("Timeout");
+		else if (check_huge(p))
+			success("OK");
+		else
+			fail("Fail");
 
 		validate_memory(p, 0, hpage_pmd_size);
 		munmap(p, hpage_pmd_size);
@@ -877,6 +958,7 @@ int main(void)
 
 	default_settings.khugepaged.max_ptes_none = hpage_pmd_nr - 1;
 	default_settings.khugepaged.max_ptes_swap = hpage_pmd_nr / 8;
+	default_settings.khugepaged.max_ptes_shared = hpage_pmd_nr / 2;
 	default_settings.khugepaged.pages_to_scan = hpage_pmd_nr * 8;
 
 	save_settings();
@@ -894,6 +976,7 @@ int main(void)
 	collapse_compound_extreme();
 	collapse_fork();
 	collapse_fork_compound();
+	collapse_max_ptes_shared();
 
 	restore_settings(0);
 }
-- 
2.26.0

