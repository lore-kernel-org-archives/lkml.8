Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0608CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 07:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D20992071E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 07:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgHZH1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 03:27:47 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:32921 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726716AbgHZH1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 03:27:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U6u0vBE_1598426822;
Received: from localhost(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0U6u0vBE_1598426822)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 26 Aug 2020 15:27:40 +0800
From:   Xunlei Pang <xlpang@linux.alibaba.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     Xunlei Pang <xlpang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] mm: memcg: Fix memcg reclaim soft lockup
Date:   Wed, 26 Aug 2020 15:27:02 +0800
Message-Id: <1598426822-93737-1-git-send-email-xlpang@linux.alibaba.com>
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

Add cond_resched() in such cases at the beginning of shrink_lruvec()
to give up the cpu to others.

Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
---
 mm/vmscan.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 99e1796..349a88e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2449,6 +2449,12 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 	scan_adjusted = (!cgroup_reclaim(sc) && !current_is_kswapd() &&
 			 sc->priority == DEF_PRIORITY);
 
+	/* memcg reclaim may run into no reclaimable lru pages */
+	if (nr[LRU_ACTIVE_FILE] == 0 &&
+	    nr[LRU_INACTIVE_FILE] == 0 &&
+	    nr[LRU_INACTIVE_ANON] == 0)
+		cond_resched();
+
 	blk_start_plug(&plug);
 	while (nr[LRU_INACTIVE_ANON] || nr[LRU_ACTIVE_FILE] ||
 					nr[LRU_INACTIVE_FILE]) {
-- 
1.8.3.1

