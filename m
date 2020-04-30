Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D3EC83001
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 06:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AE692082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 06:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgD3GOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 02:14:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50022 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726378AbgD3GOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 02:14:23 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id ACC7827DC09F98769AF6;
        Thu, 30 Apr 2020 14:14:21 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.166.215.55) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 30 Apr 2020 14:14:15 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 3/3] mm/swap: remove redundant check for swap_slot_cache_initialized
Date:   Thu, 30 Apr 2020 14:11:43 +0800
Message-ID: <20200430061143.450-4-thunder.leizhen@huawei.com>
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

Because enable_swap_slots_cache can only become true in
enable_swap_slots_cache(), and depends on swap_slot_cache_initialized is
true before. That means, when enable_swap_slots_cache is true,
swap_slot_cache_initialized is true also.

So the condition:
"swap_slot_cache_enabled && swap_slot_cache_initialized"
can be reduced to "swap_slot_cache_enabled"

And in mathematics:
"!swap_slot_cache_enabled || !swap_slot_cache_initialized"
is equal to "!(swap_slot_cache_enabled && swap_slot_cache_initialized)"

So no functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 mm/swap_slots.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index b40394473a3c..3e6453573a89 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -46,8 +46,7 @@ static void __drain_swap_slots_cache(unsigned int type);
 static void deactivate_swap_slots_cache(void);
 static void reactivate_swap_slots_cache(void);
 
-#define use_swap_slot_cache (swap_slot_cache_active && \
-		swap_slot_cache_enabled && swap_slot_cache_initialized)
+#define use_swap_slot_cache (swap_slot_cache_active && swap_slot_cache_enabled)
 #define SLOTS_CACHE 0x1
 #define SLOTS_CACHE_RET 0x2
 
@@ -94,7 +93,7 @@ static bool check_cache_active(void)
 {
 	long pages;
 
-	if (!swap_slot_cache_enabled || !swap_slot_cache_initialized)
+	if (!swap_slot_cache_enabled)
 		return false;
 
 	pages = get_nr_swap_pages();
-- 
2.26.0.106.g9fadedd


