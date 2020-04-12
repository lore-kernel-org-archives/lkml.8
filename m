Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86662C2BB86
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 09:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D35206DA
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 09:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNK0ACOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgDLJPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 05:15:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42420 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgDLJPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 05:15:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id v2so2337961plp.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 02:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=w2t8ynRQtZD2Msdal+FOK6sOorbXy2D4HYAx3w0ig3U=;
        b=aNK0ACOhQllXZs0VCPl/RMrScHbzox0I19JvSeLQkHr7cpAsFZnk3sBTNvhRXQT0Pq
         4HysbmsQIS2ozo2sw7IYekVT95jU1y+TgqISvlP9DVTbXt/SS0Ss9sSz7XsCje0E9jwP
         xYyxnboszWw+e6PoqCI63DdeQnN9N2YptazidMhuQEESF5CHTEkZArOdEm1ZMmeLgeuC
         Kv+2vlziBOv8Mxs+PlBL4cm6fzki8dKT2FVk2bW8cZL/sRDdXAY7lFteobPEKCnEqxDU
         3qI+nZg+LS49bgfB8aRbNhcPrfUmHsoquLvxsXIN7bmiExdnBu4x4OemnG453UIcMwTy
         02hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition:user-agent;
        bh=w2t8ynRQtZD2Msdal+FOK6sOorbXy2D4HYAx3w0ig3U=;
        b=oYrgHJI+TzEJTDyJxErBMJSmUkpUC0z7rbmikgBxJhS7wI44POMd0VnMMBAlaY25rV
         D7u5l8hvHQat/nsP9DG50Vpz2iKS/21AfEP18OTje4hGzPDU8DpPLNyjP1mj/DuAiKGr
         S8yq886S7uv8JQptC9dsJupYtbGlXe47Mw8awiY6o51x9s6tL5KfE+EfUZkeQAQh5ady
         667ODrj1QGfMucIQJEjPxWMu4mff9MWewpyrBq6CpGQRWlSsBcVWQ2cftU9yI/7budAK
         jXN2YWvUjHRzmJmTRZ+qUoKM8zH1JYz8mdapwvrCBVYIWxzg5UeCKDNQDyGVn61S8Fnn
         V/Sg==
X-Gm-Message-State: AGi0PuYceOpvCC4/LtCICIbPgQ50lHLoOxixUAApGaTzg0BrfO6RX7lo
        B+JWAV3ZUFt2432PyC+HArQ=
X-Google-Smtp-Source: APiQypLyQhpHzaamG8hC/k4msCztQyfU7Dz0cXUrQ8pk66EhcehcJxHjyyj3q+lZbH3P576DWP5BTw==
X-Received: by 2002:a17:90a:fe18:: with SMTP id ck24mr16235456pjb.57.1586682915585;
        Sun, 12 Apr 2020 02:15:15 -0700 (PDT)
Received: from open-light-1.localdomain ([66.98.113.28])
        by smtp.gmail.com with ESMTPSA id y131sm5858792pfb.78.2020.04.12.02.15.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2020 02:15:14 -0700 (PDT)
From:   liliangleo <liliang.opensource@gmail.com>
X-Google-Original-From: liliangleo <liliangleo@didiglobal.com>
Date:   Sun, 12 Apr 2020 05:09:49 -0400
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: [RFC PATCH 4/4] mm: Add PG_zero support
Message-ID: <20200412090945.GA19582@open-light-1.localdomain>
Mail-Followup-To: Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero out the page content usually happens when allocating pages,
this is a time consuming operation, it makes pin and mlock
operation very slowly, especially for a large batch of memory.

This patch introduce a new feature for zero out pages before page
allocation, it can help to speed up page allocation.

The idea is very simple, zero out free pages when the system is
not busy and mark the page with PG_zero, when allocating a page,
if the page need to be filled with zero, check the flag in the
struct page, if it's marked as PG_zero, zero out can be skipped,
it can save cpu time and speed up page allocation.

This serial is based on the feature 'free page reporting' which
introduced by Alexander Duyck

We can benefit from this feature in the flowing case:
    1. User space mlock a large chunk of memory
    2. VFIO pin pages for DMA
    3. Allocating transparent huge page
    4. Speed up page fault process

My original intention for adding this feature is to shorten
VM creation time when VFIO device is attached, it works good
and the VM creation time is reduced obviously.

Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: David Hildenbrand <david@redhat.com>  
Cc: Michal Hocko <mhocko@kernel.org> 
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: liliangleo <liliangleo@didiglobal.com>
---
 include/linux/highmem.h        |  31 ++++++++-
 include/linux/page-flags.h     |  18 ++++-
 include/trace/events/mmflags.h |   7 ++
 mm/Kconfig                     |  10 +++
 mm/Makefile                    |   1 +
 mm/huge_memory.c               |   3 +-
 mm/page_alloc.c                |   2 +
 mm/zero_page.c                 | 151 +++++++++++++++++++++++++++++++++++++++++
 mm/zero_page.h                 |  13 ++++
 9 files changed, 231 insertions(+), 5 deletions(-)
 create mode 100644 mm/zero_page.c
 create mode 100644 mm/zero_page.h

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index ea5cdbd8c2c3..0308837adc19 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -157,7 +157,13 @@ do {                                                            \
 #ifndef clear_user_highpage
 static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
 {
-	void *addr = kmap_atomic(page);
+	void *addr;
+
+#ifdef CONFIG_ZERO_PAGE
+	if (TestClearPageZero(page))
+		return;
+#endif
+	addr = kmap_atomic(page);
 	clear_user_page(addr, vaddr, page);
 	kunmap_atomic(addr);
 }
@@ -208,9 +214,30 @@ alloc_zeroed_user_highpage_movable(struct vm_area_struct *vma,
 	return __alloc_zeroed_user_highpage(__GFP_MOVABLE, vma, vaddr);
 }
 
+#ifdef CONFIG_ZERO_PAGE
+static inline void __clear_highpage(struct page *page)
+{
+	void *kaddr;
+
+	if (PageZero(page))
+		return;
+
+	kaddr = kmap_atomic(page);
+	clear_page(kaddr);
+	SetPageZero(page);
+	kunmap_atomic(kaddr);
+}
+#endif
+
 static inline void clear_highpage(struct page *page)
 {
-	void *kaddr = kmap_atomic(page);
+	void *kaddr;
+
+#ifdef CONFIG_ZERO_PAGE
+	if (TestClearPageZero(page))
+		return;
+#endif
+	kaddr = kmap_atomic(page);
 	clear_page(kaddr);
 	kunmap_atomic(kaddr);
 }
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 222f6f7b2bb3..ace247c5d3ec 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -136,6 +136,10 @@ enum pageflags {
 	PG_young,
 	PG_idle,
 #endif
+#ifdef CONFIG_ZERO_PAGE
+	PG_zero,
+#endif
+
 	__NR_PAGEFLAGS,
 
 	/* Filesystems */
@@ -447,6 +451,16 @@ PAGEFLAG(Idle, idle, PF_ANY)
  */
 __PAGEFLAG(Reported, reported, PF_NO_COMPOUND)
 
+#ifdef CONFIG_ZERO_PAGE
+PAGEFLAG(Zero, zero, PF_ANY)
+TESTSCFLAG(Zero, zero, PF_ANY)
+#define __PG_ZERO (1UL << PG_zero)
+#else
+PAGEFLAG_FALSE(Zero)
+#define __PG_ZERO 0
+#endif
+
+
 /*
  * On an anonymous page mapped into a user virtual memory area,
  * page->mapping points to its anon_vma, not to a struct address_space;
@@ -843,7 +857,7 @@ static inline void ClearPageSlabPfmemalloc(struct page *page)
 	 1UL << PG_private	| 1UL << PG_private_2	|	\
 	 1UL << PG_writeback	| 1UL << PG_reserved	|	\
 	 1UL << PG_slab		| 1UL << PG_active 	|	\
-	 1UL << PG_unevictable	| __PG_MLOCKED)
+	 1UL << PG_unevictable	| __PG_MLOCKED | __PG_ZERO)
 
 /*
  * Flags checked when a page is prepped for return by the page allocator.
@@ -854,7 +868,7 @@ static inline void ClearPageSlabPfmemalloc(struct page *page)
  * alloc-free cycle to prevent from reusing the page.
  */
 #define PAGE_FLAGS_CHECK_AT_PREP	\
-	(((1UL << NR_PAGEFLAGS) - 1) & ~__PG_HWPOISON)
+	(((1UL << NR_PAGEFLAGS) - 1) & ~(__PG_HWPOISON | __PG_ZERO))
 
 #define PAGE_FLAGS_PRIVATE				\
 	(1UL << PG_private | 1UL << PG_private_2)
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 5fb752034386..7be4153bed2c 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -73,6 +73,12 @@
 #define IF_HAVE_PG_HWPOISON(flag,string)
 #endif
 
+#ifdef CONFIG_ZERO_PAGE
+#define IF_HAVE_PG_ZERO(flag,string) ,{1UL << flag, string}
+#else
+#define IF_HAVE_PG_ZERO(flag,string)
+#endif
+
 #if defined(CONFIG_IDLE_PAGE_TRACKING) && defined(CONFIG_64BIT)
 #define IF_HAVE_PG_IDLE(flag,string) ,{1UL << flag, string}
 #else
@@ -104,6 +110,7 @@
 IF_HAVE_PG_MLOCK(PG_mlocked,		"mlocked"	)		\
 IF_HAVE_PG_UNCACHED(PG_uncached,	"uncached"	)		\
 IF_HAVE_PG_HWPOISON(PG_hwpoison,	"hwpoison"	)		\
+IF_HAVE_PG_ZERO(PG_zero,		"zero"		)		\
 IF_HAVE_PG_IDLE(PG_young,		"young"		)		\
 IF_HAVE_PG_IDLE(PG_idle,		"idle"		)
 
diff --git a/mm/Kconfig b/mm/Kconfig
index c1acc34c1c35..3806bdbff4c9 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -252,6 +252,16 @@ config PAGE_REPORTING
 	  those pages to another entity, such as a hypervisor, so that the
 	  memory can be freed within the host for other uses.
 
+#
+# support for zero free page
+config ZERO_PAGE
+	bool "Zero free page"
+	def_bool y
+	depends on PAGE_REPORTING
+	help
+	  Zero page allows zero out free pages in freelist based on free
+	  page reporting
+
 #
 # support for page migration
 #
diff --git a/mm/Makefile b/mm/Makefile
index fccd3756b25f..ee23147a623f 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -112,3 +112,4 @@ obj-$(CONFIG_MEMFD_CREATE) += memfd.o
 obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
 obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
 obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
+obj-$(CONFIG_ZERO_PAGE) += zero_page.o
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6ecd1045113b..a28707aea3c5 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2542,7 +2542,8 @@ static void __split_huge_page_tail(struct page *head, int tail,
 			 (1L << PG_workingset) |
 			 (1L << PG_locked) |
 			 (1L << PG_unevictable) |
-			 (1L << PG_dirty)));
+			 (1L << PG_dirty) |
+			 __PG_ZERO));
 
 	/* ->mapping in first tail page is compound_mapcount */
 	VM_BUG_ON_PAGE(tail > 2 && page_tail->mapping != TAIL_MAPPING,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 69827d4fa052..3e9601d0b944 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -75,6 +75,7 @@
 #include "internal.h"
 #include "shuffle.h"
 #include "page_reporting.h"
+#include "zero_page.h"
 
 /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
 static DEFINE_MUTEX(pcp_batch_high_lock);
@@ -1179,6 +1180,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 
 	trace_mm_page_free(page, order);
 
+	clear_zero_page_flag(page, order);
 	/*
 	 * Check tail pages before head page information is cleared to
 	 * avoid checking PageCompound for order-0 pages.
diff --git a/mm/zero_page.c b/mm/zero_page.c
new file mode 100644
index 000000000000..f3b3d58f0ef2
--- /dev/null
+++ b/mm/zero_page.c
@@ -0,0 +1,151 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ *  Copyright (C) 2020  Didi chuxing.
+ *
+ *  Authors: Liang Li <liliangleo@didiglobal.com>
+ *
+ *  This work is licensed under the terms of the GNU GPL, version 2. See
+ *  the COPYING file in the top-level directory.
+ */
+
+#include <linux/mm.h>
+#include <linux/highmem.h>
+#include <linux/rmap.h>
+#include <linux/mm_inline.h>
+#include <linux/page_reporting.h>
+#include "internal.h"
+#include "zero_page.h"
+
+#define ZERO_PAGE_STOP	0
+#define ZERO_PAGE_RUN	1
+
+static unsigned long zeropage_enable __read_mostly;
+static DEFINE_MUTEX(kzeropaged_mutex);
+static struct page_reporting_dev_info zero_page_dev_info;
+
+inline void clear_zero_page_flag(struct page *page, int order)
+{
+	int i;
+
+	for (i = 0; i < (1 << order); i++)
+		ClearPageZero(page + i);
+}
+
+static int zero_free_pages(struct page_reporting_dev_info *pr_dev_info,
+			   struct scatterlist *sgl, unsigned int nents)
+{
+	struct scatterlist *sg = sgl;
+
+	might_sleep();
+	do {
+		struct page *page = sg_page(sg);
+		unsigned int order = get_order(sg->length);
+		int i;
+
+		VM_BUG_ON(PageBuddy(page) || page_order(page));
+
+		for (i = 0; i < (1 << order); i++) {
+			cond_resched();
+			__clear_highpage(page + i);
+		}
+	} while ((sg = sg_next(sg)));
+
+	return 0;
+}
+
+static int start_kzeropaged(void)
+{
+	int err = 0;
+
+	if (zeropage_enable) {
+		zero_page_dev_info.report = zero_free_pages;
+		err = page_reporting_register(&zero_page_dev_info);
+		pr_info("Zero page enabled\n");
+	} else {
+		page_reporting_unregister(&zero_page_dev_info);
+		pr_info("Zero page disabled\n");
+	}
+
+	return err;
+}
+
+static ssize_t enabled_show(struct kobject *kobj,
+			    struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%lu\n", zeropage_enable);
+}
+
+static ssize_t enabled_store(struct kobject *kobj,
+			     struct kobj_attribute *attr,
+			     const char *buf, size_t count)
+{
+	ssize_t ret = 0;
+	unsigned long flags;
+	int err;
+
+	err = kstrtoul(buf, 10, &flags);
+	if (err || flags > UINT_MAX)
+		return -EINVAL;
+	if (flags > ZERO_PAGE_RUN)
+		return -EINVAL;
+
+	if (zeropage_enable != flags) {
+		mutex_lock(&kzeropaged_mutex);
+		zeropage_enable = flags;
+		ret = start_kzeropaged();
+		mutex_unlock(&kzeropaged_mutex);
+	}
+
+	return count;
+}
+
+static struct kobj_attribute enabled_attr =
+	__ATTR(enabled, 0644, enabled_show, enabled_store);
+
+static struct attribute *zeropage_attr[] = {
+	&enabled_attr.attr,
+	NULL,
+};
+
+static struct attribute_group zeropage_attr_group = {
+	.attrs = zeropage_attr,
+};
+
+static int __init zeropage_init_sysfs(struct kobject **zeropage_kobj)
+{
+	int err;
+
+	*zeropage_kobj = kobject_create_and_add("zero_page", mm_kobj);
+	if (unlikely(!*zeropage_kobj)) {
+		pr_err("zeropage: failed to create zeropage kobject\n");
+		return -ENOMEM;
+	}
+
+	err = sysfs_create_group(*zeropage_kobj, &zeropage_attr_group);
+	if (err) {
+		pr_err("zeropage: failed to register zeropage group\n");
+		goto delete_obj;
+	}
+
+	return 0;
+
+delete_obj:
+	kobject_put(*zeropage_kobj);
+	return err;
+}
+
+static int __init zeropage_init(void)
+{
+	int err;
+	struct kobject *zeropage_kobj;
+
+	err = zeropage_init_sysfs(&zeropage_kobj);
+	if (err)
+		return err;
+
+	start_kzeropaged();
+
+	return 0;
+}
+subsys_initcall(zeropage_init);
diff --git a/mm/zero_page.h b/mm/zero_page.h
new file mode 100644
index 000000000000..bfa3c9fe94d3
--- /dev/null
+++ b/mm/zero_page.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_ZERO_PAGE_H
+#define _LINUX_ZERO_PAGE_H
+
+#ifdef CONFIG_ZERO_PAGE
+extern inline void clear_zero_page_flag(struct page *page, int order);
+#else
+inline void clear_zero_page_flag(struct page *page, int order)
+{
+}
+#endif
+#endif /*_LINUX_ZERO_NG_H */
+
-- 
2.14.1

