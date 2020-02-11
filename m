Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9A5C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 06:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B5F2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 06:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzmseVny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgBKGUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 01:20:44 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36732 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbgBKGUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 01:20:40 -0500
Received: by mail-pg1-f196.google.com with SMTP id d9so5167436pgu.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 22:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7LP0sMYBzl+D2JqY2Soygzltfk1AIpMooW3/Su409nk=;
        b=BzmseVnyVt2mzXgZKqt/KT8OSaDMTAG/OG9ViGWylPV390jMQ4NzWavfnpMYOKxJqU
         PJM7DSfyn3hga72bfGoOSLNm2iP3YoxosN9PpoUhJ3afpUx49INK0biaoCpglFvUpWJD
         i+r4jeuek+ERCuQv56g8ZchtqCZiszeL15Y9mpjugEA0upkB0d9DYBt7j562iQpmN1xe
         NlAKq5t1ljSmgYEZ+zAEPOKb6fjPrcXdbVipYtwRDNJ7aV0aexMTqnNoQ3kzzBDZbXjT
         O8/Hd+iY2HR7+UoogRctV5mmz1+bgDj/V73u6oBpdg8bRo5LB7JBtedzkhA9fItnE4B1
         c/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7LP0sMYBzl+D2JqY2Soygzltfk1AIpMooW3/Su409nk=;
        b=tYZ+qy8TexSnjZ8sXDUFafyTed5DgwU9woU/U2KDVnh4GpbaMfDUViOBpJ/166o8+h
         pEO1IMSX5TuYabD/QcKkwsFM1gtlprcjwcUBjZsNle71mr/6YFW3G0kHRYjXeFuBh4T7
         rma2eqBfprbAWhLFJROlIFF2vWmsyR+l0i4muJTQ/cyq76CFK/jxhfYJfTbifcmM4iN1
         bZRI00CGHi2yBkOLavCIeZPbMO6ueju9E2WDtHLlWi42YDnM6gK0zEXawrloOCtivv/j
         N/l05gyYqSGho592pXtpx7/FNUR2TOiJSlIk4yyt3CcJhpGSbfVaX7OHGsPUDSGqPQtB
         d23w==
X-Gm-Message-State: APjAAAUYnRtusfeidAMjJpTMXFFBOj21ghIinE5v248ALhWdaPYK7d5e
        1u/IhIOlLIVKR1Lx3BfoJbM=
X-Google-Smtp-Source: APXvYqwD43b5f6a9ZK7182mcpuONNYGNgb3CyUpqtMDbfH9Kbcehamm0qCBK4GY4On3Rd6TY1b4ssA==
X-Received: by 2002:a05:6a00:5b:: with SMTP id i27mr1781402pfk.112.1581402038202;
        Mon, 10 Feb 2020 22:20:38 -0800 (PST)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id x197sm2578696pfc.1.2020.02.10.22.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Feb 2020 22:20:37 -0800 (PST)
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
Subject: [PATCH 9/9] mm/swap: count a new anonymous page as a reclaim_state's rotate
Date:   Tue, 11 Feb 2020 15:19:53 +0900
Message-Id: <1581401993-20041-10-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581401993-20041-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1581401993-20041-1-git-send-email-iamjoonsoo.kim@lge.com>
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

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/swap.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/mm/swap.c b/mm/swap.c
index 18b2735..c3584af 100644
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
@@ -207,6 +210,19 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
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
 	}
@@ -475,6 +491,14 @@ void lru_cache_add_inactive_or_unevictable(struct page *page,
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
 
@@ -927,6 +951,7 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
 {
 	enum lru_list lru;
 	int was_unevictable = TestClearPageUnevictable(page);
+	unsigned long rotate = (unsigned long)arg;
 
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 
@@ -962,7 +987,7 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
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

