Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED29C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 05:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B04720735
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 05:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3LdV5wX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgCWFxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 01:53:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39583 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgCWFw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 01:52:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id d25so6970937pfn.6
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 22:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pCvoaUjV6nhAY7DdWWanlLnPt8h9gGv1CiTNrzSMHq0=;
        b=U3LdV5wXCT0qE7Tlc2w3UL/P7Be1OjppvOJPQr3URLcp3s6maoXt6VSAAbwJlrXJOP
         vArNITiv22DoQoVuhp8LFfT7tGbfjOZG1x2/05hW1saggT8/72KAzPFK7vCrGQeHCU5/
         IY/+Gy1HerPmFA7wkK9iCGcLCM3aGWVnxQQrwAY+gzB5qatZ6MqsDXmAm3edCee5Ek+H
         cckhgF18DhntoRBIqQayklQ5gkS1QBJodSSkSBS1kwoX0AxVF5ZVNWFWd7mE9dp8XJgk
         1ae5WE+JxH15n5l/hYk0GYkOu9zfqZoEfK95dFZUhbZYWnrleNl2tMROtZURMGtr4ivV
         HSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pCvoaUjV6nhAY7DdWWanlLnPt8h9gGv1CiTNrzSMHq0=;
        b=Itjwp/UNDkz8WtBzVP3fHs241Yk9SfpgkfaYsFOCL/FRGH+NHjVMxw1dnzPlGJiB28
         zODjVC90X/qUtYNsCIQkh6J/i4ruzlEEX//kl/mvW4lHyXOyNRcsz7Zjr5Pqgrwtqp6u
         yBjtjWHyBNdoOG4kkIYKU7efdzM6/rzDVVYBTZuqkLc6zIwAxCppJaDTtuD6UDHGJQ4m
         KXzuMlO4c/GEipCnAm1DTMbPoFRw/vJL7TPhMYGMoi2O1j0ZjGmwWJgaitnNGUN+cvUE
         kuayuzqJOMoQhz53r5hc7F73a3dcXANELABcAo+hjf5/1K2636+/sAWqO8uqikcg+1el
         nuJg==
X-Gm-Message-State: ANhLgQ3WTA1agwci1kbOOu/2zHs1LKU0I4Ds8Wb5X8+yBsTtc49gamaQ
        KBC327gP1skpV522TJlZq5B6gH4KqRo=
X-Google-Smtp-Source: ADFU+vvR5bvOnRT/IaFbBHPKjbjcgVA0kWVQtjZDJWkZb1ag3VSrIrWPM8cPoqRlRUpuGyyoheeSyQ==
X-Received: by 2002:a63:455:: with SMTP id 82mr19485470pge.197.1584942777121;
        Sun, 22 Mar 2020 22:52:57 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id y30sm12563058pff.67.2020.03.22.22.52.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Mar 2020 22:52:56 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v4 8/8] mm/swap: count a new anonymous page as a reclaim_state's rotate
Date:   Mon, 23 Mar 2020 14:52:12 +0900
Message-Id: <1584942732-2184-9-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584942732-2184-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1584942732-2184-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

reclaim_stat's rotate is used for controlling the ratio of scanning page
between file and anonymous LRU. All new anonymous pages are counted
for rotate before the patch, protecting anonymous pages on active LRU, and,
it makes that reclaim on anonymous LRU is less happened than file LRU.

Now, situation is changed. all new anonymous pages are not added
to the active LRU so rotate would be far less than before. It will cause
that reclaim on anonymous LRU happens more and it would result in bad
effect on some system that is optimized for previous setting.

Therefore, this patch counts a new anonymous page as a reclaim_state's
rotate. Although it is non-logical to add this count to
the reclaim_state's rotate in current algorithm, reducing the regression
would be more important.

I found this regression on kernel-build test and it is roughly 2~5%
performance degradation. With this workaround, performance is completely
restored.

v2: fix a bug that reuses the rotate value for previous page

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/swap.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/mm/swap.c b/mm/swap.c
index 442d27e..1f19301 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -187,6 +187,9 @@ int get_kernel_page(unsigned long start, int write, struct page **pages)
 }
 EXPORT_SYMBOL_GPL(get_kernel_page);
 
+static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
+				 void *arg);
+
 static void pagevec_lru_move_fn(struct pagevec *pvec,
 	void (*move_fn)(struct page *page, struct lruvec *lruvec, void *arg),
 	void *arg)
@@ -199,6 +202,7 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 	for (i = 0; i < pagevec_count(pvec); i++) {
 		struct page *page = pvec->pages[i];
 		struct pglist_data *pagepgdat = page_pgdat(page);
+		void *arg_orig = arg;
 
 		if (pagepgdat != pgdat) {
 			if (pgdat)
@@ -207,8 +211,22 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 			spin_lock_irqsave(&pgdat->lru_lock, flags);
 		}
 
+		if (move_fn == __pagevec_lru_add_fn) {
+			struct list_head *entry = &page->lru;
+			unsigned long next = (unsigned long)entry->next;
+			unsigned long rotate = next & 2;
+
+			if (rotate) {
+				VM_BUG_ON(arg);
+
+				next = next & ~2;
+				entry->next = (struct list_head *)next;
+				arg = (void *)rotate;
+			}
+		}
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 		(*move_fn)(page, lruvec, arg);
+		arg = arg_orig;
 	}
 	if (pgdat)
 		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
@@ -475,6 +493,14 @@ void lru_cache_add_inactive_or_unevictable(struct page *page,
 				    hpage_nr_pages(page));
 		count_vm_event(UNEVICTABLE_PGMLOCKED);
 	}
+
+	if (PageSwapBacked(page) && !unevictable) {
+		struct list_head *entry = &page->lru;
+		unsigned long next = (unsigned long)entry->next;
+
+		next = next | 2;
+		entry->next = (struct list_head *)next;
+	}
 	lru_cache_add(page);
 }
 
@@ -927,6 +953,7 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
 {
 	enum lru_list lru;
 	int was_unevictable = TestClearPageUnevictable(page);
+	unsigned long rotate = (unsigned long)arg;
 
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 
@@ -962,7 +989,7 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
 	if (page_evictable(page)) {
 		lru = page_lru(page);
 		update_page_reclaim_stat(lruvec, page_is_file_cache(page),
-					 PageActive(page));
+					 PageActive(page) | rotate);
 		if (was_unevictable)
 			count_vm_event(UNEVICTABLE_PGRESCUED);
 	} else {
-- 
2.7.4

