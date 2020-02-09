Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A2FC35250
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 07:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CF320733
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 07:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbgBIHmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 02:42:40 -0500
Received: from mga05.intel.com ([192.55.52.43]:36277 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgBIHmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 02:42:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2020 23:42:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,420,1574150400"; 
   d="scan'208";a="225830659"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga008.jf.intel.com with ESMTP; 08 Feb 2020 23:42:37 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        shakeelb@google.com, yang.shi@linux.alibaba.com,
        mgorman@techsingularity.net,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [RFC Patch] mm/vmscan.c: not inherit classzone_idx from previous reclaim
Date:   Sun,  9 Feb 2020 15:41:45 +0800
Message-Id: <20200209074145.31389-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before commit e716f2eb24de ("mm, vmscan: prevent kswapd sleeping
prematurely due to mismatched classzone_idx"), classzone_idx could have
two possibilities on a new loop based on whether there is a wakeup
during reclaiming:

  * 0 if no wakeup
  * the classzone_idx request by wakeup

As described in the changelog, this commit is willing to change the
first case to (MAX_NR_ZONES - 1) to avoid some premature sleep. But it
does not achieve the goal.

There are two versions of kswapd_classzone_idx() since this change:

  * commit e716f2eb24de ("mm, vmscan: prevent kswapd sleeping
    prematurely due to mismatched classzone_idx")
  * commit dffcac2cb88e ("mm/vmscan.c: prevent useless kswapd loops")

Both of them would return the classzone_idx we passed as the 2nd
parameter when (pgdat->kswapd_classzone_idx == MAX_NR_ZONES). This
means if there is no wakeup during reclaiming, we would use
classzone_idx in previous round to sleep.

This patch fixes the logic by using (MAX_NR_ZONES - 1) for the first
case.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/vmscan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index e7b647f70407..ea2f0abef1d4 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3879,7 +3879,7 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
 static int kswapd(void *p)
 {
 	unsigned int alloc_order, reclaim_order;
-	unsigned int classzone_idx = MAX_NR_ZONES - 1;
+	unsigned int classzone_idx;
 	pg_data_t *pgdat = (pg_data_t*)p;
 	struct task_struct *tsk = current;
 	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
@@ -3908,7 +3908,7 @@ static int kswapd(void *p)
 		bool ret;
 
 		alloc_order = reclaim_order = pgdat->kswapd_order;
-		classzone_idx = kswapd_classzone_idx(pgdat, classzone_idx);
+		classzone_idx = kswapd_classzone_idx(pgdat, MAX_NR_ZONES - 1);
 
 kswapd_try_sleep:
 		kswapd_try_to_sleep(pgdat, alloc_order, reclaim_order,
-- 
2.17.1

