Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFEBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 635982224D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbgHZNsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:48:21 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:35963 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730426AbgHZNrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:47:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U6wHc3g_1598449622;
Received: from localhost(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0U6wHc3g_1598449622)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 26 Aug 2020 21:47:07 +0800
From:   Xunlei Pang <xlpang@linux.alibaba.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     Xunlei Pang <xlpang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2] mm: memcg: Fix memcg reclaim soft lockup
Date:   Wed, 26 Aug 2020 21:47:02 +0800
Message-Id: <1598449622-108748-1-git-send-email-xlpang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've met softlockup with "CONFIG_PREEMPT_NONE=y", when
the target memcg doesn't have any reclaimable memory.

It can be easily reproduced as below:
 watchdog: BUG: soft lockup - CPU#0 stuck for 111s![memcg_test:2204]
 CPU: 0 PID: 2204 Comm: memcg_test Not tainted 5.9.0-rc2+ #12
 Call Trace:
  shrink_lruvec+0x49f/0x640
  shrink_node+0x2a6/0x6f0
  do_try_to_free_pages+0xe9/0x3e0
  try_to_free_mem_cgroup_pages+0xef/0x1f0
  try_charge+0x2c1/0x750
  mem_cgroup_charge+0xd7/0x240
  __add_to_page_cache_locked+0x2fd/0x370
  add_to_page_cache_lru+0x4a/0xc0
  pagecache_get_page+0x10b/0x2f0
  filemap_fault+0x661/0xad0
  ext4_filemap_fault+0x2c/0x40
  __do_fault+0x4d/0xf9
  handle_mm_fault+0x1080/0x1790

It only happens on our 1-vcpu instances, because there's no chance
for oom reaper to run to reclaim the to-be-killed process.

Add cond_resched() at the upper shrink_node_memcgs() to solve this
issue, and any other possible issue like meomry.min protection.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
---
 mm/vmscan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 99e1796..bbdc38b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2617,6 +2617,8 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 
 		mem_cgroup_calculate_protection(target_memcg, memcg);
 
+		cond_resched();
+
 		if (mem_cgroup_below_min(memcg)) {
 			/*
 			 * Hard protection.
-- 
1.8.3.1

