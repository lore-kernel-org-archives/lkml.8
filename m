Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1101BC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDAD720674
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgCIJKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 05:10:09 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:34336 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726071AbgCIJKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 05:10:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04396;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Ts2w.vr_1583745003;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0Ts2w.vr_1583745003)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 09 Mar 2020 17:10:03 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH] mm/swap_slots.c: don't reset the cache slot after use
Date:   Mon,  9 Mar 2020 17:09:40 +0800
Message-Id: <20200309090940.34130-1-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we would clear the cache slot if it is used. While this is not
necessary, since this entry would not be used until refilled.

Leave it untouched and assigned the value directly to entry which makes
the code little more neat.

Also this patch merges the else and if, since this is the only case we
refill and repeat swap cache.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 mm/swap_slots.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index 63a7b4563a57..ff695df3db26 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -309,7 +309,7 @@ int free_swap_slot(swp_entry_t entry)
 
 swp_entry_t get_swap_page(struct page *page)
 {
-	swp_entry_t entry, *pentry;
+	swp_entry_t entry;
 	struct swap_slots_cache *cache;
 
 	entry.val = 0;
@@ -336,13 +336,10 @@ swp_entry_t get_swap_page(struct page *page)
 		if (cache->slots) {
 repeat:
 			if (cache->nr) {
-				pentry = &cache->slots[cache->cur++];
-				entry = *pentry;
-				pentry->val = 0;
+				entry = cache->slots[cache->cur++];
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

