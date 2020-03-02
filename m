Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E865DC3F2DF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63CC2465E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbgCBLBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 06:01:08 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:33971 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726871AbgCBLBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 06:01:05 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TrQzvPm_1583146860;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TrQzvPm_1583146860)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 02 Mar 2020 19:01:01 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v9 16/20] mm/swap: only change the lru_lock iff page's lruvec is different
Date:   Mon,  2 Mar 2020 19:00:26 +0800
Message-Id: <1583146830-169516-17-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we introduced relock_page_lruvec, we could use it in more place
to reduce spin_locks.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Hugh Dickins <hughd@google.com>
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
---
 mm/swap.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 50c856246f84..74e03589adde 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -197,13 +197,15 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 		if (isolation && !TestClearPageLRU(page))
 			continue;
 
-		lruvec = lock_page_lruvec_irqsave(page, &flags);
+		lruvec = relock_page_lruvec_irqsave(page, lruvec, &flags);
 		(*move_fn)(page, lruvec, arg);
-		unlock_page_lruvec_irqrestore(lruvec, flags);
 
 		if (isolation)
 			SetPageLRU(page);
 	}
+	if (lruvec)
+		unlock_page_lruvec_irqrestore(lruvec, flags);
+
 	release_pages(pvec->pages, pvec->nr);
 	pagevec_reinit(pvec);
 }
@@ -821,14 +823,11 @@ void release_pages(struct page **pages, int nr)
 		}
 
 		if (TestClearPageLRU(page)) {
-			struct lruvec *new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+			struct lruvec *pre_lruvec = lruvec;
 
-			if (new_lruvec != lruvec) {
-				if (lruvec)
-					unlock_page_lruvec_irqrestore(lruvec, flags);
+			lruvec = relock_page_lruvec_irqsave(page, lruvec, &flags);
+			if (pre_lruvec != lruvec)
 				lock_batch = 0;
-				lruvec = lock_page_lruvec_irqsave(page, &flags);
-			}
 
 			del_page_from_lru_list(page, lruvec, page_off_lru(page));
 		}
-- 
1.8.3.1

