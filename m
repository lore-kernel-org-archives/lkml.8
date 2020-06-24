Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD55C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED046206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFg5uFeW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404303AbgFXPCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404188AbgFXPCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:02:04 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99578C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:02:04 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id h22so1270845pjf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AX72C3H9DY0Mb5nGoxeAb59dD5E4L2tnEFRCjP+Wlf0=;
        b=LFg5uFeW+cQFpKjqfrepLPJFXJYZI5jo+KJSD84e95ZgJsJe6vZV1nTxVBtW+wmsb/
         GoCNmNqBUvAZF3rwX5w2UQlJ2qe127xTSeU5ExIGpur6PQ2bbOgyjG+3Y0w+rB+XiX4M
         XGro7t420rVC4lzMJiy9rHwkRgFxGm2CkPxxQzyENzrMCgMaTS8Ca3Ybs6vJORMc1gQ4
         jt4AEMla4ryL4dhP3JzwSo/Yn3MIi6s+JKWSqNsXFIKyJHOCRrnTPgVR/JS5YOh1ATZY
         +4GFNztX8mRXICs+o2eK4Zq5FRSexNGMtVyMMJ4t9dyCJSX7klwef3SSkaxQnGcY5QdX
         n3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AX72C3H9DY0Mb5nGoxeAb59dD5E4L2tnEFRCjP+Wlf0=;
        b=FzxAJijc7DJ12RL0O/wtL5qqiKQl1KHOWQQ97uDKRtHNIt+CVG3ftA4KELPVvouOnN
         QfxVXOFyR6YB7WDclawe6H6NuuwQ8e56gMQ36Bq7KFEKc42C61XX9OtwaiEGo8RaGG1k
         CCjhE1S7rgT9vwswh3JDI5HTSCVaztVpe/ErbgjJwcN5L9Z2Za/vqF6CFfUovFC5R+07
         pPlBNTAEFXaIPFYakp5fSlfn+PxFkHI3/2WjdHrkTTN47qRZHFJ6gc8EsvtAgeFAsOqJ
         y2nuM40+tQdCsLn3NjkD+KWsV9H+hYd8zaSL0YXt14SSHDMIo59Y7ipmr1fWmFd1DOeG
         nyiQ==
X-Gm-Message-State: AOAM531cfDp4vNeAGNKxpeudGzxIdmMBu1qeP4ZPVUKGsBL2i4+hPtJ/
        Uuz6UiFpEpq2wL86tJZErw==
X-Google-Smtp-Source: ABdhPJw2R7lrU6KvkDbo3s5Q4UtioLSg9tloKIF7v1/0wtKvUe0RuwOds+r/GIlyqFv2Fuj2rCcqvw==
X-Received: by 2002:a17:90a:364e:: with SMTP id s72mr6620071pjb.226.1593010924030;
        Wed, 24 Jun 2020 08:02:04 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id i125sm17013705pgd.21.2020.06.24.08.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:02:03 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/15] mm,hwpoison: Kill put_hwpoison_page
Date:   Wed, 24 Jun 2020 15:01:29 +0000
Message-Id: <20200624150137.7052-8-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624150137.7052-1-nao.horiguchi@gmail.com>
References: <20200624150137.7052-1-nao.horiguchi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

After commit 4e41a30c6d50 ("mm: hwpoison: adjust for new thp refcounting"),
put_hwpoison_page got reduced to a put_page.
Let us just use put_page instead.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 include/linux/mm.h  |  1 -
 mm/memory-failure.c | 30 +++++++++++++++---------------
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git v5.8-rc1-mmots-2020-06-20-21-44/include/linux/mm.h v5.8-rc1-mmots-2020-06-20-21-44_patched/include/linux/mm.h
index 050e9cffc2ea..c64ffec363b5 100644
--- v5.8-rc1-mmots-2020-06-20-21-44/include/linux/mm.h
+++ v5.8-rc1-mmots-2020-06-20-21-44_patched/include/linux/mm.h
@@ -2995,7 +2995,6 @@ extern int memory_failure(unsigned long pfn, int flags);
 extern void memory_failure_queue(unsigned long pfn, int flags);
 extern void memory_failure_queue_kick(int cpu);
 extern int unpoison_memory(unsigned long pfn);
-#define put_hwpoison_page(page)	put_page(page)
 extern int sysctl_memory_failure_early_kill;
 extern int sysctl_memory_failure_recovery;
 extern void shake_page(struct page *p, int access);
diff --git v5.8-rc1-mmots-2020-06-20-21-44/mm/memory-failure.c v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/memory-failure.c
index 48feb45047f7..0b7d9769cf29 100644
--- v5.8-rc1-mmots-2020-06-20-21-44/mm/memory-failure.c
+++ v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/memory-failure.c
@@ -1144,7 +1144,7 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 		pr_err("Memory failure: %#lx: just unpoisoned\n", pfn);
 		num_poisoned_pages_dec();
 		unlock_page(head);
-		put_hwpoison_page(head);
+		put_page(head);
 		return 0;
 	}
 
@@ -1336,7 +1336,7 @@ int memory_failure(unsigned long pfn, int flags)
 					pfn);
 			if (TestClearPageHWPoison(p))
 				num_poisoned_pages_dec();
-			put_hwpoison_page(p);
+			put_page(p);
 			return -EBUSY;
 		}
 		unlock_page(p);
@@ -1389,14 +1389,14 @@ int memory_failure(unsigned long pfn, int flags)
 		pr_err("Memory failure: %#lx: just unpoisoned\n", pfn);
 		num_poisoned_pages_dec();
 		unlock_page(p);
-		put_hwpoison_page(p);
+		put_page(p);
 		return 0;
 	}
 	if (hwpoison_filter(p)) {
 		if (TestClearPageHWPoison(p))
 			num_poisoned_pages_dec();
 		unlock_page(p);
-		put_hwpoison_page(p);
+		put_page(p);
 		return 0;
 	}
 
@@ -1630,9 +1630,9 @@ int unpoison_memory(unsigned long pfn)
 	}
 	unlock_page(page);
 
-	put_hwpoison_page(page);
+	put_page(page);
 	if (freeit && !(pfn == my_zero_pfn(0) && page_count(p) == 1))
-		put_hwpoison_page(page);
+		put_page(page);
 
 	return 0;
 }
@@ -1690,7 +1690,7 @@ static int get_any_page(struct page *page, unsigned long pfn, int flags)
 		/*
 		 * Try to free it.
 		 */
-		put_hwpoison_page(page);
+		put_page(page);
 		shake_page(page, 1);
 
 		/*
@@ -1699,7 +1699,7 @@ static int get_any_page(struct page *page, unsigned long pfn, int flags)
 		ret = __get_any_page(page, pfn, 0);
 		if (ret == 1 && !PageLRU(page)) {
 			/* Drop page reference which is from __get_any_page() */
-			put_hwpoison_page(page);
+			put_page(page);
 			pr_info("soft_offline: %#lx: unknown non LRU page type %lx (%pGp)\n",
 				pfn, page->flags, &page->flags);
 			return -EIO;
@@ -1722,7 +1722,7 @@ static int soft_offline_huge_page(struct page *page, int flags)
 	lock_page(hpage);
 	if (PageHWPoison(hpage)) {
 		unlock_page(hpage);
-		put_hwpoison_page(hpage);
+		put_page(hpage);
 		pr_info("soft offline: %#lx hugepage already poisoned\n", pfn);
 		return -EBUSY;
 	}
@@ -1733,7 +1733,7 @@ static int soft_offline_huge_page(struct page *page, int flags)
 	 * get_any_page() and isolate_huge_page() takes a refcount each,
 	 * so need to drop one here.
 	 */
-	put_hwpoison_page(hpage);
+	put_page(hpage);
 	if (!ret) {
 		pr_info("soft offline: %#lx hugepage failed to isolate\n", pfn);
 		return -EBUSY;
@@ -1782,7 +1782,7 @@ static int __soft_offline_page(struct page *page, int flags)
 	wait_on_page_writeback(page);
 	if (PageHWPoison(page)) {
 		unlock_page(page);
-		put_hwpoison_page(page);
+		put_page(page);
 		pr_info("soft offline: %#lx page already poisoned\n", pfn);
 		return -EBUSY;
 	}
@@ -1797,7 +1797,7 @@ static int __soft_offline_page(struct page *page, int flags)
 	 * would need to fix isolation locking first.
 	 */
 	if (ret == 1) {
-		put_hwpoison_page(page);
+		put_page(page);
 		pr_info("soft_offline: %#lx: invalidated\n", pfn);
 		SetPageHWPoison(page);
 		num_poisoned_pages_inc();
@@ -1817,7 +1817,7 @@ static int __soft_offline_page(struct page *page, int flags)
 	 * Drop page reference which is came from get_any_page()
 	 * successful isolate_lru_page() already took another one.
 	 */
-	put_hwpoison_page(page);
+	put_page(page);
 	if (!ret) {
 		LIST_HEAD(pagelist);
 		/*
@@ -1861,7 +1861,7 @@ static int soft_offline_in_use_page(struct page *page, int flags)
 				pr_info("soft offline: %#lx: non anonymous thp\n", page_to_pfn(page));
 			else
 				pr_info("soft offline: %#lx: thp split failed\n", page_to_pfn(page));
-			put_hwpoison_page(page);
+			put_page(page);
 			return -EBUSY;
 		}
 		unlock_page(page);
@@ -1934,7 +1934,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 	if (PageHWPoison(page)) {
 		pr_info("soft offline: %#lx page already poisoned\n", pfn);
 		if (flags & MF_COUNT_INCREASED)
-			put_hwpoison_page(page);
+			put_page(page);
 		return -EBUSY;
 	}
 
-- 
2.17.1

