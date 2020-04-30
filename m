Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA512C83002
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 06:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D67D92082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 06:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgD3GOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 02:14:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50024 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726405AbgD3GOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 02:14:23 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B573F71D57E2D0085191;
        Thu, 30 Apr 2020 14:14:21 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.166.215.55) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 30 Apr 2020 14:14:14 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/3] mm/swap: simplify alloc_swap_slot_cache()
Date:   Thu, 30 Apr 2020 14:11:41 +0800
Message-ID: <20200430061143.450-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200430061143.450-1-thunder.leizhen@huawei.com>
References: <20200430061143.450-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.166.215.55]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both "slots" and "slots_ret" are only need to be freed when cache already
allocated. Make them closer, seems more clear.

No functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 mm/swap_slots.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index 0975adc72253..01609b5f0c55 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -136,9 +136,16 @@ static int alloc_swap_slot_cache(unsigned int cpu)
 
 	mutex_lock(&swap_slots_cache_mutex);
 	cache = &per_cpu(swp_slots, cpu);
-	if (cache->slots || cache->slots_ret)
+	if (cache->slots || cache->slots_ret) {
 		/* cache already allocated */
-		goto out;
+		mutex_unlock(&swap_slots_cache_mutex);
+
+		kvfree(slots);
+		kvfree(slots_ret);
+
+		return 0;
+	}
+
 	if (!cache->lock_initialized) {
 		mutex_init(&cache->alloc_lock);
 		spin_lock_init(&cache->free_lock);
@@ -155,15 +162,8 @@ static int alloc_swap_slot_cache(unsigned int cpu)
 	 */
 	mb();
 	cache->slots = slots;
-	slots = NULL;
 	cache->slots_ret = slots_ret;
-	slots_ret = NULL;
-out:
 	mutex_unlock(&swap_slots_cache_mutex);
-	if (slots)
-		kvfree(slots);
-	if (slots_ret)
-		kvfree(slots_ret);
 	return 0;
 }
 
-- 
2.26.0.106.g9fadedd


