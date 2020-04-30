Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D716BC83002
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 06:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA54221775
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 06:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgD3GOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 02:14:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50020 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726412AbgD3GO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 02:14:27 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B11352AE2A73BAFF718E;
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
Subject: [PATCH 2/3] mm/swap: simplify enable_swap_slots_cache()
Date:   Thu, 30 Apr 2020 14:11:42 +0800
Message-ID: <20200430061143.450-3-thunder.leizhen@huawei.com>
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

Whether swap_slot_cache_initialized is true or false,
__reenable_swap_slots_cache() is always called. To make this meaning
clear, leave only one call to __reenable_swap_slots_cache(). This also
make it clearer what extra needs be done when swap_slot_cache_initialized
is false.

No functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 mm/swap_slots.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index 01609b5f0c55..b40394473a3c 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -240,21 +240,19 @@ static int free_slot_cache(unsigned int cpu)
 
 int enable_swap_slots_cache(void)
 {
-	int ret = 0;
-
 	mutex_lock(&swap_slots_cache_enable_mutex);
-	if (swap_slot_cache_initialized) {
-		__reenable_swap_slots_cache();
-		goto out_unlock;
-	}
+	if (!swap_slot_cache_initialized) {
+		int ret;
 
-	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "swap_slots_cache",
-				alloc_swap_slot_cache, free_slot_cache);
-	if (WARN_ONCE(ret < 0, "Cache allocation failed (%s), operating "
-			       "without swap slots cache.\n", __func__))
-		goto out_unlock;
+		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "swap_slots_cache",
+					alloc_swap_slot_cache, free_slot_cache);
+		if (WARN_ONCE(ret < 0, "Cache allocation failed (%s), operating "
+				       "without swap slots cache.\n", __func__))
+			goto out_unlock;
+
+		swap_slot_cache_initialized = true;
+	}
 
-	swap_slot_cache_initialized = true;
 	__reenable_swap_slots_cache();
 out_unlock:
 	mutex_unlock(&swap_slots_cache_enable_mutex);
-- 
2.26.0.106.g9fadedd


