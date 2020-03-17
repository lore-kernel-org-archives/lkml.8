Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F1DC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 05:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3801D2071C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 05:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJ3POYnd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgCQFmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 01:42:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42411 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgCQFmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 01:42:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id x2so10944502pfn.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 22:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g874qtH2FamHKBLRETQ33+Q4l9Bm0XlV9Wb41fCpvWM=;
        b=LJ3POYndXxfNNC23TaGVu/uEWvPNY4cpJgEZ/oqB5WBwPpeeSkZ1xF5T5nrJGwPHuT
         O8Jw0eyorX7ABjzuvsfmgGR9VqZ+pFuq1Gc3kPj3vO2j66XwBcLDypJL5z+oOMkMXVnA
         MhZg7D2BrLEfXfYt8NhYGU80IEgJ8ftXiGkz+D+h5909/ViBgg2NfzUGB95bcWqtbPAc
         p0qNZP+pVAEefDxC2hsA9hdJlGoe9dJ4qSMZC98V234LPE9ZlFtZ98yWF5tZ7ez54rXh
         de7aa6PAVg5V8xu1mylJkopALqO3EJ8z470hjWhpzfF0bie3T2PaouTDbB7/KZXvKypL
         eMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g874qtH2FamHKBLRETQ33+Q4l9Bm0XlV9Wb41fCpvWM=;
        b=FqYPtBKeWHFazJsoUzqT3NogI2ge6LafLwefxwY2cHHgRav2SCJ3oEmywc8Pu2u4X9
         K3uDJNzIbNStvfynG1AwD/2jDMeMwUWDjmHHDe2u0SL58GoyQUAokIYxlHZUF6xWHaVf
         7ssjGjQDEYH1Fa5mHGozLnTOf2Dsy7/vaYaM5zcmNXVxDDQEpoNzcn8vb8gIHkBkACCp
         iQoYcLC9NKe/sJuPYefCMuLZEal0JcHCmrpaX1plLvaRB1qqGbzDceGWISxFlNw/rddt
         rZIeHQP29podHWG4/c7hx2HhbOkt4pGydKl+amTyMoDJuUHb7zk1uKM73d7LzAV/7nAH
         07Jw==
X-Gm-Message-State: ANhLgQ3O6gnZINpO2GbKISfJDw9w4GFT8zcZNWqxuZT8sIearHyaJbPH
        EgnNgisa3AsYPSnYvVIf41I=
X-Google-Smtp-Source: ADFU+vul+7ldVh+/hL9EQ8m7ReZi9eKpmjJManwnPqIh9bKUGlBytfsTX6J64NxpjaK3Be8/ITV99Q==
X-Received: by 2002:a62:3888:: with SMTP id f130mr3290173pfa.141.1584423755996;
        Mon, 16 Mar 2020 22:42:35 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id i21sm1141757pgn.5.2020.03.16.22.42.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Mar 2020 22:42:35 -0700 (PDT)
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
Subject: [PATCH v3 9/9] mm/swap: count a new anonymous page as a reclaim_state's rotate
Date:   Tue, 17 Mar 2020 14:41:57 +0900
Message-Id: <1584423717-3440-10-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584423717-3440-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1584423717-3440-1-git-send-email-iamjoonsoo.kim@lge.com>
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
index 18b2735..9001d81 100644
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
+	if (PageSwapBacked(page) && evictable) {
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

