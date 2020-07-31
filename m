Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2D3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 520472087C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BV/tk3/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387454AbgGaMWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733215AbgGaMVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:21:46 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E05C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:21:46 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id c6so7213355pje.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lA5hCOOxKd5KS4DNVLZggsB4V0UYIUqby39pIHtSFTI=;
        b=BV/tk3/NZFWzExZRn1SNk7tn+RX5lXq4zgJHfljF+UZyR8OYlwQ6WhxoZ2W4CbKbU9
         aIC0N8TApCCxG61ReuM8kE5yjMT7KNnfYMx3zoSmZxZCZt/y3QDWDInmmzoSmIAmAjxY
         6beapW4QD1fMhzKwMQ/2kLJ+eDDX8ZweLWlU/LlkV30myri1cY89pl7W3pKotHX68L6s
         GTrw4xXg/cjTVRKp9/93GQ0ai6jIJhaNZwa5sDf433kChNZ2op392ccZjb4iwj3lmEQK
         ubOWHqeU+keYtczKSwizHhN5/KVI7+NY7YDtvkslJ0x4PZ252mwfywCjEVDfVb7zRggu
         pguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lA5hCOOxKd5KS4DNVLZggsB4V0UYIUqby39pIHtSFTI=;
        b=ko7vxm3IhjZMLjukFAzl8GIgixOBAXG4YvSZSYUZpYhqtPPUId3GOc2aKP5Wlnpclq
         l6ENboKrcvjYYtQZvexUnJDTXonGCH1kOW4ZMRbDIgD9bwRKKM35g5Ep4eRSbwuD9ZMg
         ATh981llRoDcwip7ecEWG0L9AxKp0aMZCNvLeX7TwOeBVn6TVj4Pt2MMJ0GwvRYlkaC+
         TvnOBsZkqa2HiIpmk3kjZo70I/GN7htK/ZKIDTJogjkbGge9sBtLB4T0Y4zBc3/F5Js8
         YrnpFAHNUJt/AZmIRqwIpopsGfRldYlAee+hg2uHVf46mRCmhhJFAUfCq3ZsnNStNyv+
         Ed+A==
X-Gm-Message-State: AOAM531p35Qw4TXrmzZxW8rpvmx0kC8gtldzlZgg9VIKo/cbq6qZrBqw
        NafCcaudFmI7SeDodHLsgg==
X-Google-Smtp-Source: ABdhPJzctlZ9GdEehG92Jq22YQZVUDBLiYJqCJBNzg8O5fTbCmw7g1Trml4YTGAM11PZWaU48zurcA==
X-Received: by 2002:a65:644d:: with SMTP id s13mr3554079pgv.103.1596198105836;
        Fri, 31 Jul 2020 05:21:45 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id m19sm3675692pjv.34.2020.07.31.05.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 05:21:45 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, cai@lca.pw, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/16] mm,hwpoison: remove flag argument from soft offline functions
Date:   Fri, 31 Jul 2020 12:21:05 +0000
Message-Id: <20200731122112.11263-10-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731122112.11263-1-nao.horiguchi@gmail.com>
References: <20200731122112.11263-1-nao.horiguchi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

The argument @flag no longer affects the behavior of soft_offline_page()
and its variants, so let's remove them.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 drivers/base/memory.c |  2 +-
 include/linux/mm.h    |  2 +-
 mm/madvise.c          |  2 +-
 mm/memory-failure.c   | 27 +++++++++++++--------------
 4 files changed, 16 insertions(+), 17 deletions(-)

diff --git v5.8-rc7-mmotm-2020-07-27-18-18/drivers/base/memory.c v5.8-rc7-mmotm-2020-07-27-18-18_patched/drivers/base/memory.c
index 4db3c660de83..3e6d27c9dff6 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/drivers/base/memory.c
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/drivers/base/memory.c
@@ -463,7 +463,7 @@ static ssize_t soft_offline_page_store(struct device *dev,
 	if (kstrtoull(buf, 0, &pfn) < 0)
 		return -EINVAL;
 	pfn >>= PAGE_SHIFT;
-	ret = soft_offline_page(pfn, 0);
+	ret = soft_offline_page(pfn);
 	return ret == 0 ? count : ret;
 }
 
diff --git v5.8-rc7-mmotm-2020-07-27-18-18/include/linux/mm.h v5.8-rc7-mmotm-2020-07-27-18-18_patched/include/linux/mm.h
index c09111e8eac8..ecb3c7191fb7 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/include/linux/mm.h
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/include/linux/mm.h
@@ -2988,7 +2988,7 @@ extern int sysctl_memory_failure_early_kill;
 extern int sysctl_memory_failure_recovery;
 extern void shake_page(struct page *p, int access);
 extern atomic_long_t num_poisoned_pages __read_mostly;
-extern int soft_offline_page(unsigned long pfn, int flags);
+extern int soft_offline_page(unsigned long pfn);
 
 
 /*
diff --git v5.8-rc7-mmotm-2020-07-27-18-18/mm/madvise.c v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/madvise.c
index 2c50c2c5673b..3eee78abdbec 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/mm/madvise.c
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/madvise.c
@@ -925,7 +925,7 @@ static int madvise_inject_error(int behavior,
 		if (behavior == MADV_SOFT_OFFLINE) {
 			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
 				pfn, start);
-			ret = soft_offline_page(pfn, 0);
+			ret = soft_offline_page(pfn);
 		} else {
 			pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
 				pfn, start);
diff --git v5.8-rc7-mmotm-2020-07-27-18-18/mm/memory-failure.c v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/memory-failure.c
index 9768ab5f51ef..7c0a2f8cfe0c 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/mm/memory-failure.c
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/memory-failure.c
@@ -1502,7 +1502,7 @@ static void memory_failure_work_func(struct work_struct *work)
 		if (!gotten)
 			break;
 		if (entry.flags & MF_SOFT_OFFLINE)
-			soft_offline_page(entry.pfn, entry.flags);
+			soft_offline_page(entry.pfn);
 		else
 			memory_failure(entry.pfn, entry.flags);
 	}
@@ -1641,7 +1641,7 @@ EXPORT_SYMBOL(unpoison_memory);
  * that is not free, and 1 for any other page type.
  * For 1 the page is returned with increased page count, otherwise not.
  */
-static int __get_any_page(struct page *p, unsigned long pfn, int flags)
+static int __get_any_page(struct page *p, unsigned long pfn)
 {
 	int ret;
 
@@ -1668,9 +1668,9 @@ static int __get_any_page(struct page *p, unsigned long pfn, int flags)
 	return ret;
 }
 
-static int get_any_page(struct page *page, unsigned long pfn, int flags)
+static int get_any_page(struct page *page, unsigned long pfn)
 {
-	int ret = __get_any_page(page, pfn, flags);
+	int ret = __get_any_page(page, pfn);
 
 	if (ret == 1 && !PageHuge(page) &&
 	    !PageLRU(page) && !__PageMovable(page)) {
@@ -1683,7 +1683,7 @@ static int get_any_page(struct page *page, unsigned long pfn, int flags)
 		/*
 		 * Did it turn free?
 		 */
-		ret = __get_any_page(page, pfn, 0);
+		ret = __get_any_page(page, pfn);
 		if (ret == 1 && !PageLRU(page)) {
 			/* Drop page reference which is from __get_any_page() */
 			put_page(page);
@@ -1695,7 +1695,7 @@ static int get_any_page(struct page *page, unsigned long pfn, int flags)
 	return ret;
 }
 
-static int soft_offline_huge_page(struct page *page, int flags)
+static int soft_offline_huge_page(struct page *page)
 {
 	int ret;
 	unsigned long pfn = page_to_pfn(page);
@@ -1754,7 +1754,7 @@ static int soft_offline_huge_page(struct page *page, int flags)
 	return ret;
 }
 
-static int __soft_offline_page(struct page *page, int flags)
+static int __soft_offline_page(struct page *page)
 {
 	int ret;
 	unsigned long pfn = page_to_pfn(page);
@@ -1838,7 +1838,7 @@ static int __soft_offline_page(struct page *page, int flags)
 	return ret;
 }
 
-static int soft_offline_in_use_page(struct page *page, int flags)
+static int soft_offline_in_use_page(struct page *page)
 {
 	int ret;
 	int mt;
@@ -1868,9 +1868,9 @@ static int soft_offline_in_use_page(struct page *page, int flags)
 	mt = get_pageblock_migratetype(page);
 	set_pageblock_migratetype(page, MIGRATE_ISOLATE);
 	if (PageHuge(page))
-		ret = soft_offline_huge_page(page, flags);
+		ret = soft_offline_huge_page(page);
 	else
-		ret = __soft_offline_page(page, flags);
+		ret = __soft_offline_page(page);
 	set_pageblock_migratetype(page, mt);
 	return ret;
 }
@@ -1891,7 +1891,6 @@ static int soft_offline_free_page(struct page *page)
 /**
  * soft_offline_page - Soft offline a page.
  * @pfn: pfn to soft-offline
- * @flags: flags. Same as memory_failure().
  *
  * Returns 0 on success, otherwise negated errno.
  *
@@ -1910,7 +1909,7 @@ static int soft_offline_free_page(struct page *page)
  * This is not a 100% solution for all memory, but tries to be
  * ``good enough'' for the majority of memory.
  */
-int soft_offline_page(unsigned long pfn, int flags)
+int soft_offline_page(unsigned long pfn)
 {
 	int ret;
 	struct page *page;
@@ -1928,11 +1927,11 @@ int soft_offline_page(unsigned long pfn, int flags)
 	}
 
 	get_online_mems();
-	ret = get_any_page(page, pfn, flags);
+	ret = get_any_page(page, pfn);
 	put_online_mems();
 
 	if (ret > 0)
-		ret = soft_offline_in_use_page(page, flags);
+		ret = soft_offline_in_use_page(page);
 	else if (ret == 0)
 		ret = soft_offline_free_page(page);
 
-- 
2.17.1

