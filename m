Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D6CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 625E722CAF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JasDQCuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbgHFStz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729064AbgHFStv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:49:51 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95365C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 11:49:51 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id r11so17686933pfl.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 11:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gsGWqW4ZaiFQhMVFrKJuaHZLM1FtGshPHyEY7H8wkmw=;
        b=JasDQCuzAi9JU34kUOcms8Rny8c5MOxnv8J5r/VdpwC8f1DZMyerK9OxUP3OxbhyF4
         4Xaqnj6vkNHY2rR/0/sZpx7QtyK7+SfqCcbKDowrZavKpRD0mxp8K0YqYG6MLv2KtvWp
         ku0CmQ5+s5hHzzFlADCqvSe7l03TKxFrZBNQPaVydA1O7A3OWH5WLtVnhqdLIM6kht+0
         veP1qChzI0rGksZXi8gnw+7JV1EuwSZuTI5IzwqGhz8UyhN9cribOrezzzpZA8szw/x5
         YWf161hzfuMOpYLq0Qzreg9KIgHmlaebdUh+Uh+7UE8uVFnEf8d/h0o/gEIptVmh8qIp
         yhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gsGWqW4ZaiFQhMVFrKJuaHZLM1FtGshPHyEY7H8wkmw=;
        b=VAWFkBtrBQhG2eZ4JLJA4+u8Vt0jHE6r/LKuY8+G6t1wmjxb+zOw35ZQjv49bbd3Pi
         tyjNSz/T6vtWTwLNHPd2tze+DOIPxqEk9gb1wV8aCYgXrVPq7M1BjvRJjroQFBq48wOF
         8AJSbi97fLDiGcyb03qXzm6d0kS8b6U9qaUh6MjZQ5OHdnTivb9+XPNyag5EEFayGa1a
         lAf3VqYfP/OmZQWQmwOA4/Jpvm0yc+6Y7cuT3u0R376gnduqK98gaZNnAzmd4wsqABx0
         UuiYn6F7jxkxHJNGzrbw2dqmUSG29L6uI9Y0ykfhMsJgaRXhzti6OuhRmRUudKL6x2hi
         G/4g==
X-Gm-Message-State: AOAM531r4f90qHKaZP0xfvjLSLBVoBC9IfCJd3uZkihiT816DX2k1uZV
        BDpXcom5rmIv8nZGTykRNA==
X-Google-Smtp-Source: ABdhPJx7ZnxiVWey9oH5CdH2kdR14A4rtMbx2qpf9s3VDDyV31G6qsQ00AoP5BHlqeGfpyNKncwFLg==
X-Received: by 2002:aa7:8182:: with SMTP id g2mr9240754pfi.261.1596739791120;
        Thu, 06 Aug 2020 11:49:51 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id u24sm9096730pfm.20.2020.08.06.11.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 11:49:50 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, cai@lca.pw, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 07/12] mm,hwpoison: Rework soft offline for free pages
Date:   Thu,  6 Aug 2020 18:49:18 +0000
Message-Id: <20200806184923.7007-8-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806184923.7007-1-nao.horiguchi@gmail.com>
References: <20200806184923.7007-1-nao.horiguchi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

When trying to soft-offline a free page, we need to first take it off
the buddy allocator.
Once we know is out of reach, we can safely flag it as poisoned.

take_page_off_buddy will be used to take a page meant to be poisoned
off the buddy allocator.
take_page_off_buddy calls break_down_buddy_pages, which splits a
higher-order page in case our page belongs to one.

Once the page is under our control, we call page_handle_poison to set it
as poisoned and grab a refcount on it.

Signed-off-by: Oscar Salvador <osalvador@suse.com>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
ChangeLog v4 -> v5:
- fix comile error

ChangeLog v2 -> v3:
- use add_to_free_list() instead of add_to_free_area()
- use del_page_from_free_list() instead of del_page_from_free_area()
- add fast return
- move extern definition to header file as warned by checkpatch.pl
---
 include/linux/page-flags.h |  1 +
 mm/memory-failure.c        | 18 ++++++----
 mm/page_alloc.c            | 68 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 6 deletions(-)

diff --git v5.8-rc7-mmotm-2020-07-27-18-18/include/linux/page-flags.h v5.8-rc7-mmotm-2020-07-27-18-18_patched/include/linux/page-flags.h
index 6be1aa559b1e..9fa5d4e2d69a 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/include/linux/page-flags.h
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/include/linux/page-flags.h
@@ -423,6 +423,7 @@ PAGEFLAG(HWPoison, hwpoison, PF_ANY)
 TESTSCFLAG(HWPoison, hwpoison, PF_ANY)
 #define __PG_HWPOISON (1UL << PG_hwpoison)
 extern bool set_hwpoison_free_buddy_page(struct page *page);
+extern bool take_page_off_buddy(struct page *page);
 #else
 PAGEFLAG_FALSE(HWPoison)
 static inline bool set_hwpoison_free_buddy_page(struct page *page)
diff --git v5.8-rc7-mmotm-2020-07-27-18-18/mm/memory-failure.c v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/memory-failure.c
index 276c1588f82a..0e619012e050 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/mm/memory-failure.c
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/memory-failure.c
@@ -65,6 +65,13 @@ int sysctl_memory_failure_recovery __read_mostly = 1;
 
 atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
 
+static void page_handle_poison(struct page *page)
+{
+	SetPageHWPoison(page);
+	page_ref_inc(page);
+	num_poisoned_pages_inc();
+}
+
 #if defined(CONFIG_HWPOISON_INJECT) || defined(CONFIG_HWPOISON_INJECT_MODULE)
 
 u32 hwpoison_filter_enable = 0;
@@ -1879,14 +1886,13 @@ static int soft_offline_in_use_page(struct page *page, int flags)
 
 static int soft_offline_free_page(struct page *page)
 {
-	int rc = dissolve_free_huge_page(page);
+	int rc = -EBUSY;
 
-	if (!rc) {
-		if (set_hwpoison_free_buddy_page(page))
-			num_poisoned_pages_inc();
-		else
-			rc = -EBUSY;
+	if (!dissolve_free_huge_page(page) && take_page_off_buddy(page)) {
+		page_handle_poison(page);
+		rc = 0;
 	}
+
 	return rc;
 }
 
diff --git v5.8-rc7-mmotm-2020-07-27-18-18/mm/page_alloc.c v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/page_alloc.c
index efe2e94c45f5..aab89f7db4ac 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/mm/page_alloc.c
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/page_alloc.c
@@ -8776,6 +8776,74 @@ bool is_free_buddy_page(struct page *page)
 }
 
 #ifdef CONFIG_MEMORY_FAILURE
+/*
+ * Break down a higher-order page in sub-pages, and keep our target out of
+ * buddy allocator.
+ */
+static void break_down_buddy_pages(struct zone *zone, struct page *page,
+				   struct page *target, int low, int high,
+				   int migratetype)
+{
+	unsigned long size = 1 << high;
+	struct page *current_buddy, *next_page;
+
+	while (high > low) {
+		high--;
+		size >>= 1;
+
+		if (target >= &page[size]) {
+			next_page = page + size;
+			current_buddy = page;
+		} else {
+			next_page = page;
+			current_buddy = page + size;
+		}
+
+		if (set_page_guard(zone, current_buddy, high, migratetype))
+			continue;
+
+		if (current_buddy != target) {
+			add_to_free_list(current_buddy, zone, high, migratetype);
+			set_page_order(current_buddy, high);
+			page = next_page;
+		}
+	}
+}
+
+/*
+ * Take a page that will be marked as poisoned off the buddy allocator.
+ */
+bool take_page_off_buddy(struct page *page)
+{
+	struct zone *zone = page_zone(page);
+	unsigned long pfn = page_to_pfn(page);
+	unsigned long flags;
+	unsigned int order;
+	bool ret = false;
+
+	spin_lock_irqsave(&zone->lock, flags);
+	for (order = 0; order < MAX_ORDER; order++) {
+		struct page *page_head = page - (pfn & ((1 << order) - 1));
+		int buddy_order = page_order(page_head);
+
+		if (PageBuddy(page_head) && buddy_order >= order) {
+			unsigned long pfn_head = page_to_pfn(page_head);
+			int migratetype = get_pfnblock_migratetype(page_head,
+								   pfn_head);
+
+			del_page_from_free_list(page_head, zone, buddy_order);
+			break_down_buddy_pages(zone, page_head, page, 0,
+						buddy_order, migratetype);
+			ret = true;
+			break;
+		}
+		if (page_count(page_head) > 0)
+			break;
+	}
+	spin_unlock_irqrestore(&zone->lock, flags);
+	return ret;
+}
+
 /*
  * Set PG_hwpoison flag if a given page is confirmed to be a free page.  This
  * test is performed under the zone lock to prevent a race against page
-- 
2.17.1

