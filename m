Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25E3C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81BD821655
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgCKFyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 01:54:08 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:49243 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726160AbgCKFyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 01:54:07 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TsHGOr6_1583906041;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0TsHGOr6_1583906041)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 11 Mar 2020 13:54:02 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: [Patch v2] mm/swap_slots.c: assign|reset cache slot by value directly
Date:   Wed, 11 Mar 2020 13:53:52 +0800
Message-Id: <20200311055352.50574-1-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we use a tmp pointer, pentry, to transfer and reset swap cache
slot, which is a little redundant. Swap cache slot stores the entry
value directly, assign and reset it by value would be straight forward.

Also this patch merges the else and if, since this is the only case we
refill and repeat swap cache.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
CC: Tim Chen <tim.c.chen@linux.intel.com>

---
v2: keep the reset step after use, but remove the tmp pointer
---
 mm/swap_slots.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index 63a7b4563a57..0975adc72253 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -309,7 +309,7 @@ int free_swap_slot(swp_entry_t entry)
 
 swp_entry_t get_swap_page(struct page *page)
 {
-	swp_entry_t entry, *pentry;
+	swp_entry_t entry;
 	struct swap_slots_cache *cache;
 
 	entry.val = 0;
@@ -336,13 +336,11 @@ swp_entry_t get_swap_page(struct page *page)
 		if (cache->slots) {
 repeat:
 			if (cache->nr) {
-				pentry = &cache->slots[cache->cur++];
-				entry = *pentry;
-				pentry->val = 0;
+				entry = cache->slots[cache->cur];
+				cache->slots[cache->cur++].val = 0;
 				cache->nr--;
-			} else {
-				if (refill_swap_slots_cache(cache))
-					goto repeat;
+			} else if (refill_swap_slots_cache(cache)) {
+				goto repeat;
 			}
 		}
 		mutex_unlock(&cache->alloc_lock);
-- 
2.20.1 (Apple Git-117)

