Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD6CC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 03:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 386372080C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 03:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgD0DAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 23:00:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:23386 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbgD0DAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 23:00:36 -0400
IronPort-SDR: a7ct3EM+3j20Im5tCGCrMV3xSpcvdoGy0vGlROG8Zx7vfYSopQqttnwNfqUl51r3uQvRJdi73+
 BnJD3EcwrMHw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2020 20:00:35 -0700
IronPort-SDR: dpPP1rqsPr3sXMDGIVVoEwTMQ6xiPqCrbYC2spUvn0BDsRhrjHKfHEuQJaxHDn8akkaQqcJNy+
 9tKuSW3D/BlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,321,1583222400"; 
   d="scan'208";a="292293649"
Received: from yhex-mobl2.ccr.corp.intel.com (HELO yhuang-mobile.ccr.corp.intel.com) ([10.254.212.42])
  by fmsmga002.fm.intel.com with ESMTP; 26 Apr 2020 20:00:32 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH] swap: Try to scan more free slots even when fragmented
Date:   Mon, 27 Apr 2020 11:00:23 +0800
Message-Id: <20200427030023.264780-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, the scalability of swap code will drop much when the swap device
becomes fragmented, because the swap slots allocation batching stops
working.  To solve the problem, in this patch, we will try to scan a
little more swap slots with restricted effort to batch the swap slots
allocation even if the swap device is fragmented.  Test shows that the
benchmark score can increase up to 37.1% with the patch.  Details are
as follows.

The swap code has a per-cpu cache of swap slots.  These batch swap
space allocations to improve swap subsystem scaling.  In the following
code path,

  add_to_swap()
    get_swap_page()
      refill_swap_slots_cache()
        get_swap_pages()
	  scan_swap_map_slots()

scan_swap_map_slots() and get_swap_pages() can return multiple swap
slots for each call.  These slots will be cached in the per-CPU swap
slots cache, so that several following swap slot requests will be
fulfilled there to avoid the lock contention in the lower level swap
space allocation/freeing code path.

But this only works when there are free swap clusters.  If a swap
device becomes so fragmented that there's no free swap clusters,
scan_swap_map_slots() and get_swap_pages() will return only one swap
slot for each call in the above code path.  Effectively, this falls
back to the situation before the swap slots cache was introduced, the
heavy lock contention on the swap related locks kills the scalability.

Why does it work in this way?  Because the swap device could be large,
and the free swap slot scanning could be quite time consuming, to
avoid taking too much time to scanning free swap slots, the
conservative method was used.

In fact, this can be improved via scanning a little more free slots
with strictly restricted effort.  Which is implemented in this patch.
In scan_swap_map_slots(), after the first free swap slot is gotten, we
will try to scan a little more, but only if we haven't scanned too
many slots (< LATENCY_LIMIT).  That is, the added scanning latency is
strictly restricted.

To test the patch, we have run 16-process pmbench memory benchmark on
a 2-socket server machine with 48 cores.  Multiple ram disks are
configured as the swap devices.  The pmbench working-set size is much
larger than the available memory so that swapping is triggered.  The
memory read/write ratio is 80/20 and the accessing pattern is random,
so the swap space becomes highly fragmented during the test.  In the
original implementation, the lock contention on swap related locks is
very heavy.  The perf profiling data of the lock contention code path
is as following,

_raw_spin_lock.get_swap_pages.get_swap_page.add_to_swap:             21.03
_raw_spin_lock_irq.shrink_inactive_list.shrink_lruvec.shrink_node:    1.92
_raw_spin_lock_irq.shrink_active_list.shrink_lruvec.shrink_node:      1.72
_raw_spin_lock.free_pcppages_bulk.drain_pages_zone.drain_pages:       0.69

While after applying this patch, it becomes,

_raw_spin_lock_irq.shrink_inactive_list.shrink_lruvec.shrink_node:    4.89
_raw_spin_lock_irq.shrink_active_list.shrink_lruvec.shrink_node:      3.85
_raw_spin_lock.free_pcppages_bulk.drain_pages_zone.drain_pages:       1.1
_raw_spin_lock_irqsave.pagevec_lru_move_fn.__lru_cache_add.do_swap_page: 0.88

That is, the lock contention on the swap locks is eliminated.

And the pmbench score increases 37.1%.  The swapin throughput
increases 45.7% from 2.02 GB/s to 2.94 GB/s.  While the swapout
throughput increases 45.3% from 2.04 GB/s to 2.97 GB/s.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Hugh Dickins <hughd@google.com>
---
 mm/swapfile.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index ee9bd89857a2..a0a123e59ce6 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -739,6 +739,7 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 	unsigned long last_in_cluster = 0;
 	int latency_ration = LATENCY_LIMIT;
 	int n_ret = 0;
+	bool scanned_many = false;
 
 	/*
 	 * We try to cluster swap pages by allocating them sequentially
@@ -870,6 +871,25 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 		goto checks;
 	}
 
+	/*
+	 * Even if there's no free clusters available (fragmented),
+	 * try to scan a little more quickly with lock held unless we
+	 * have scanned too many slots already.
+	 */
+	if (!scanned_many) {
+		unsigned long scan_limit;
+
+		if (offset < scan_base)
+			scan_limit = scan_base;
+		else
+			scan_limit = si->highest_bit;
+		for (; offset <= scan_limit && --latency_ration > 0;
+		     offset++) {
+			if (!si->swap_map[offset])
+				goto checks;
+		}
+	}
+
 done:
 	si->flags -= SWP_SCANNING;
 	return n_ret;
@@ -889,6 +909,7 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 		if (unlikely(--latency_ration < 0)) {
 			cond_resched();
 			latency_ration = LATENCY_LIMIT;
+			scanned_many = true;
 		}
 	}
 	offset = si->lowest_bit;
@@ -905,6 +926,7 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 		if (unlikely(--latency_ration < 0)) {
 			cond_resched();
 			latency_ration = LATENCY_LIMIT;
+			scanned_many = true;
 		}
 		offset++;
 	}
-- 
2.25.1

