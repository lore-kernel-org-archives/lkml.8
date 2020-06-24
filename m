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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5E4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90368206EB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RirjVn7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404236AbgFXPCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404225AbgFXPCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:02:16 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C893EC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:02:16 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e8so1548237pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wemqwQ1fREh2JQiEeDLgUYZf8kZ33feb3ynoN9bhMsM=;
        b=RirjVn7v29G812b9rUw+VgI8Ua6kOb8Jr6ZOXICjDbQZeonzIS2UoWkCEQAI5yDd+F
         NyopQadvFl9mqn+qPcaFHJcUACIyDlmJb+MQBRNihqMlvpztvaZXMI1vUpyC7Y5DO8OS
         1rTpDL34JTHvbBlGDgGaN9dvj+6y0oD3LXSCRW5HDn2jOT5L67PitxwDKfoctqNJsnSF
         Wt7q+fPbNGciparr7btfdoaQI59tMQFA1zHLSoPRZZB4IRJTpuKcEgKMiCwBNLl6sldU
         LTSM1+Fj/phtoyX8laylAC7CAp6qW503gHNfvt8O0o2DUwK+D0Fyz6CLVwIwk2Vv8puW
         jGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wemqwQ1fREh2JQiEeDLgUYZf8kZ33feb3ynoN9bhMsM=;
        b=K+6sEUrF//Ti88cRvJMtHwenGcIxaXQI06muHwGqPOk7i5Q77CToZDDoPEr9sG44Wv
         /jP77T+Cgk0MCmClTn3u0EiV4WrSnHvezv32pCEgFVU9BNSUCqegh2FXFM01bvLN7bOs
         PE5Hg7cYSIuUUmHD+kzWO3m9DlkzOOADq/DhkWcZl0JF5UW0H4Q2VHETPMO5nPC6H2TX
         3dnNMxtEHTRO+8SsibzIAH4kWRnnZYq7chVQU1zFOnRaLCBRf3hd6PZAuI7wkkF0JFHF
         3Q+iviN3gpIZ/ZJf5WV5/H5VplzTCBTb15jwzYvDwpjsLqCfwEhNlRkFWtC/iQSvLBpP
         AKGA==
X-Gm-Message-State: AOAM533SAYyv2jk+6i6x0DjLfmHGmFt/eVy/1oPT9s6vSkWywc8O5weR
        tIhcR/f7uQ/Xze5brquGqw==
X-Google-Smtp-Source: ABdhPJySf0N9YCkY0AXDYfVlBg+AcGHmUzuKDEj3LCHQGl686X2BH03jtPIyL7vSty+G9GsBNxEYyA==
X-Received: by 2002:aa7:972d:: with SMTP id k13mr30001279pfg.113.1593010936217;
        Wed, 24 Jun 2020 08:02:16 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id i125sm17013705pgd.21.2020.06.24.08.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:02:15 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/15] mm,hwpoison: Rework soft offline for free pages
Date:   Wed, 24 Jun 2020 15:01:33 +0000
Message-Id: <20200624150137.7052-12-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624150137.7052-1-nao.horiguchi@gmail.com>
References: <20200624150137.7052-1-nao.horiguchi@gmail.com>
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

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
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

diff --git v5.8-rc1-mmots-2020-06-20-21-44/include/linux/page-flags.h v5.8-rc1-mmots-2020-06-20-21-44_patched/include/linux/page-flags.h
index 6be1aa559b1e..9fa5d4e2d69a 100644
--- v5.8-rc1-mmots-2020-06-20-21-44/include/linux/page-flags.h
+++ v5.8-rc1-mmots-2020-06-20-21-44_patched/include/linux/page-flags.h
@@ -423,6 +423,7 @@ PAGEFLAG(HWPoison, hwpoison, PF_ANY)
 TESTSCFLAG(HWPoison, hwpoison, PF_ANY)
 #define __PG_HWPOISON (1UL << PG_hwpoison)
 extern bool set_hwpoison_free_buddy_page(struct page *page);
+extern bool take_page_off_buddy(struct page *page);
 #else
 PAGEFLAG_FALSE(HWPoison)
 static inline bool set_hwpoison_free_buddy_page(struct page *page)
diff --git v5.8-rc1-mmots-2020-06-20-21-44/mm/memory-failure.c v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/memory-failure.c
index 2e244d5b83e0..d79e756a97be 100644
--- v5.8-rc1-mmots-2020-06-20-21-44/mm/memory-failure.c
+++ v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/memory-failure.c
@@ -78,6 +78,13 @@ EXPORT_SYMBOL_GPL(hwpoison_filter_dev_minor);
 EXPORT_SYMBOL_GPL(hwpoison_filter_flags_mask);
 EXPORT_SYMBOL_GPL(hwpoison_filter_flags_value);
 
+static void page_handle_poison(struct page *page)
+{
+	SetPageHWPoison(page);
+	page_ref_inc(page);
+	num_poisoned_pages_inc();
+}
+
 static int hwpoison_filter_dev(struct page *p)
 {
 	struct address_space *mapping;
@@ -1876,14 +1883,13 @@ static int soft_offline_in_use_page(struct page *page)
 
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
 
diff --git v5.8-rc1-mmots-2020-06-20-21-44/mm/page_alloc.c v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/page_alloc.c
index 31c32fe0ecfb..3b145bceb477 100644
--- v5.8-rc1-mmots-2020-06-20-21-44/mm/page_alloc.c
+++ v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/page_alloc.c
@@ -8781,6 +8781,74 @@ bool is_free_buddy_page(struct page *page)
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

