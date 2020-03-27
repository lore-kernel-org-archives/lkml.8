Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006FFC2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89132072F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Q9Z9XrgC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgC0RGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:06:12 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34467 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgC0RGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:06:10 -0400
Received: by mail-lf1-f66.google.com with SMTP id e7so8482930lfq.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 10:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5kQB28Q1srv5R/NFD9NiHhGkcte0ot9iIq76f8JehPk=;
        b=Q9Z9XrgC1agbGS6iVd1s2BTilTO0EpLN+sb0E1/T4r7u8Tvb/ifohsIOQxVZiio+VQ
         SOg+W0ADbWLo87YzursLjwt4RcWg7zpPiDeBYSN+wtK1dxLrdrN0FtDa8DCML9ASlM27
         bsw0DhpdD0wElolWk9Z3X/JGQAkfKOAmpLQ4orKmxSwYv/1DkIGC6Q2T/V6IlhrfUpMk
         nj5Qf/2D2DeyTiKHJnw83cEmIl+yl7R+3GyT9i+laFYnxUy6D5kzUFPjLzN2qJU6GmXw
         9g/+0SmJgLcq7O+XfJ7D3/0ifej4g5dwkW2frwZ04PGgV1XfGtkMwtUQbYujGNL05CDE
         6psw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5kQB28Q1srv5R/NFD9NiHhGkcte0ot9iIq76f8JehPk=;
        b=BMBk8ogIJH50heGELMjGmBiMIT95MrSa3O6qff2Q6pailgTwuH3EwPNe22LzZui7QP
         7BMqgDZZCGGWxKCtkzxZT8IJBi9uMHe5NnhSJZou94FitnNZ7RObCzrjF+xEft1nvGJG
         bTorFQfdPC/+MzH4Tk1z3gM+0kDWivq+Qn+Gz0JY8M/MxMpMHHsddL/lJqf1hZqTriDv
         tKcjK9EJYi5YA6ACswgFD6tQrpaGZByM94w0QIJ4go1kq+G/TWC7AEtjgX+BkE7s3PfV
         +ZDoD/3FyCCspL+4cpb8eZ4HYO6kA5CkY+NKCudhg5BVSBPKZJjCdfvlgT7CUgHPxHGQ
         nFLA==
X-Gm-Message-State: AGi0PubK6Pl+2ZhwBGQT4cIp1So6r52tmWHB/+iOyxTLzPqhBjTTsXxZ
        wDTfFXQjkohiBumD0uAhumIxaA==
X-Google-Smtp-Source: APiQypJTg/7Jr+2YbWa9fzssusziciWK2L5tL//ePdoqgZeZK4AL4xepP8yE4nyjxIGV8HzMS9IywA==
X-Received: by 2002:ac2:4316:: with SMTP id l22mr185811lfh.150.1585328766284;
        Fri, 27 Mar 2020 10:06:06 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id x128sm3240696lff.67.2020.03.27.10.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 10:06:05 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 84E70100D2C; Fri, 27 Mar 2020 20:06:07 +0300 (+03)
To:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 7/7] khugepaged: Introduce 'max_ptes_shared' tunable
Date:   Fri, 27 Mar 2020 20:06:01 +0300
Message-Id: <20200327170601.18563-8-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
References: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

``max_ptes_shared`` speicies how many pages can be shared across multiple
processes. Exeeding the number woul block the collapse::

	/sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_shared

A higher value may increase memory footprint for some workloads.

By default, at least half of pages has to be not shared.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 Documentation/admin-guide/mm/transhuge.rst |  7 ++
 mm/khugepaged.c                            | 52 ++++++++++++--
 tools/testing/selftests/vm/khugepaged.c    | 83 ++++++++++++++++++++++
 3 files changed, 138 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index bd5714547cee..d16e4f2bb70f 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -220,6 +220,13 @@ memory. A lower value can prevent THPs from being
 collapsed, resulting fewer pages being collapsed into
 THPs, and lower memory access performance.
 
+``max_ptes_shared`` speicies how many pages can be shared across multiple
+processes. Exeeding the number woul block the collapse::
+
+	/sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_shared
+
+A higher value may increase memory footprint for some workloads.
+
 Boot parameter
 ==============
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index c8c2c463095c..8e728a602491 100644
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
@@ -546,7 +577,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 {
 	struct page *page = NULL;
 	pte_t *_pte;
-	int none_or_zero = 0, result = 0, referenced = 0;
+	int none_or_zero = 0, shared = 0, result = 0, referenced = 0;
 	bool writable = false;
 	LIST_HEAD(compound_pagelist);
 
@@ -575,6 +606,12 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 
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
@@ -1160,7 +1197,8 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 {
 	pmd_t *pmd;
 	pte_t *pte, *_pte;
-	int ret = 0, none_or_zero = 0, result = 0, referenced = 0;
+	int ret = 0, result = 0, referenced = 0;
+	int none_or_zero = 0, shared = 0;
 	struct page *page = NULL;
 	unsigned long _address;
 	spinlock_t *ptl;
@@ -1210,6 +1248,12 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
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
index 193bde6a1534..3a98d5b2d6d8 100644
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
@@ -786,12 +789,90 @@ static void collapse_fork_compound(void)
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
@@ -820,6 +901,7 @@ int main(void)
 
 	default_settings.khugepaged.max_ptes_none = hpage_pmd_nr - 1;
 	default_settings.khugepaged.max_ptes_swap = hpage_pmd_nr / 8;
+	default_settings.khugepaged.max_ptes_shared = hpage_pmd_nr / 2;
 	default_settings.khugepaged.pages_to_scan = hpage_pmd_nr * 8;
 
 	save_settings();
@@ -836,6 +918,7 @@ int main(void)
 	collapse_full_of_compound();
 	collapse_fork();
 	collapse_fork_compound();
+	collapse_max_ptes_shared();
 
 	restore_settings(0);
 }
-- 
2.26.0

