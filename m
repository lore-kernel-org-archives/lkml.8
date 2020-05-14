Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEF3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 07:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73257206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 07:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgENHFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 03:05:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:52283 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgENHFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 03:05:08 -0400
IronPort-SDR: yOwaPq8LQYrkcG0HNDsiYD4Ld3+y6wYsdtWBDr02HnkbTQAJBdT2GJlLyc1HR2zZmFhASlKg1g
 5DyjBdrhFpYA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 00:05:07 -0700
IronPort-SDR: 6FVzJxd1jEXGZrJHw+CDmJpWFALfuA+k3nIje0Xr3qyJy3EMB35Gc/KTRKZNG/QA0kFqTnPoAs
 +RMw1oudHNAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,390,1583222400"; 
   d="scan'208";a="409968776"
Received: from unknown (HELO yhuang-mobile.sh.intel.com) ([10.238.6.207])
  by orsmga004.jf.intel.com with ESMTP; 14 May 2020 00:05:02 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH] swap: Add percpu cluster_next to reduce lock contention on swap cache
Date:   Thu, 14 May 2020 15:04:24 +0800
Message-Id: <20200514070424.16017-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some swap scalability test, it is found that there are heavy lock
contention on swap cache even if we have split one swap cache radix
tree per swap device to one swap cache radix tree every 64 MB trunk in
commit 4b3ef9daa4fc ("mm/swap: split swap cache into 64MB trunks").

The reason is as follow.  After the swap device becomes fragmented so
that there's no free swap cluster, the swap device will be scanned
linearly to find the free swap slots.  swap_info_struct->cluster_next
is the next scanning base that is shared by all CPUs.  So nearby free
swap slots will be allocated for different CPUs.  The probability for
multiple CPUs to operate on the same 64 MB trunk is high.  This causes
the lock contention on the swap cache.

To solve the issue, in this patch, for SSD swap device, a percpu
version next scanning base (cluster_next_cpu) is added.  Every CPU
will use its own next scanning base.  So the probability for multiple
CPUs to operate on the same 64 MB trunk is reduced greatly.  Thus the
lock contention is reduced too.  For HDD, because sequential access is
more important for IO performance, the original shared next scanning
base is used.

To test the patch, we have run 16-process pmbench memory benchmark on
a 2-socket server machine with 48 cores.  One ram disk is configured
as the swap device per socket.  The pmbench working-set size is much
larger than the available memory so that swapping is triggered.  The
memory read/write ratio is 80/20 and the accessing pattern is random.
In the original implementation, the lock contention on the swap cache
is heavy.  The perf profiling data of the lock contention code path is
as following,

_raw_spin_lock_irq.add_to_swap_cache.add_to_swap.shrink_page_list:      7.93
_raw_spin_lock_irqsave.__remove_mapping.shrink_page_list: 		7.03
_raw_spin_lock_irq.mem_cgroup_commit_charge.do_swap_page: 		3.7
_raw_spin_lock.swapcache_free_entries.free_swap_slot.__swap_entry_free: 2.9
_raw_spin_lock_irq.shrink_inactive_list.shrink_lruvec.shrink_node:	1.32
_raw_spin_lock.free_pcppages_bulk.drain_pages_zone.drain_pages: 	1.01
_raw_spin_lock_irq.shrink_active_list.shrink_lruvec.shrink_node: 	0.87

After applying this patch, it becomes,

_raw_spin_lock_irq.mem_cgroup_commit_charge.do_swap_page:		3.99
_raw_spin_lock.swapcache_free_entries.free_swap_slot.__swap_entry_free: 3.0
_raw_spin_lock_irq.shrink_inactive_list.shrink_lruvec.shrink_node:      1.47
_raw_spin_lock_irq.shrink_active_list.shrink_lruvec.shrink_node: 	1.31
_raw_spin_lock.free_pcppages_bulk.drain_pages_zone.drain_pages: 	0.88
_raw_spin_lock.scan_swap_map_slots.get_swap_pages.get_swap_page: 	0.76
_raw_spin_lock_irq.add_to_swap_cache.add_to_swap.shrink_page_list:      0.53

The lock contention on the swap cache is almost eliminated.

And the pmbench score increases 15.9%.  The swapin throughput
increases 16.2% from 2.84 GB/s to 3.3 GB/s.  While the swapout
throughput increases 16.1% from 2.87 GB/s to 3.33 GB/s.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Hugh Dickins <hughd@google.com>
---
 include/linux/swap.h |  1 +
 mm/swapfile.c        | 27 +++++++++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index b42fb47d8cbe..e96820fb7472 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -252,6 +252,7 @@ struct swap_info_struct {
 	unsigned int inuse_pages;	/* number of those currently in use */
 	unsigned int cluster_next;	/* likely index for next allocation */
 	unsigned int cluster_nr;	/* countdown to next cluster search */
+	unsigned int __percpu *cluster_next_cpu; /*percpu index for next allocation */
 	struct percpu_cluster __percpu *percpu_cluster; /* per cpu's swap location */
 	struct rb_root swap_extent_root;/* root of the swap extent rbtree */
 	struct block_device *bdev;	/* swap device or bdev of swap file */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 35be7a7271f4..9f1343b066c1 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -746,7 +746,16 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 	 */
 
 	si->flags += SWP_SCANNING;
-	scan_base = offset = si->cluster_next;
+	/*
+	 * Use percpu scan base for SSD to reduce lock contention on
+	 * cluster and swap cache.  For HDD, sequential access is more
+	 * important.
+	 */
+	if (si->flags & SWP_SOLIDSTATE)
+		scan_base = this_cpu_read(*si->cluster_next_cpu);
+	else
+		scan_base = si->cluster_next;
+	offset = scan_base;
 
 	/* SSD algorithm */
 	if (si->cluster_info) {
@@ -835,7 +844,10 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 	unlock_cluster(ci);
 
 	swap_range_alloc(si, offset, 1);
-	si->cluster_next = offset + 1;
+	if (si->flags & SWP_SOLIDSTATE)
+		this_cpu_write(*si->cluster_next_cpu, offset + 1);
+	else
+		si->cluster_next = offset + 1;
 	slots[n_ret++] = swp_entry(si->type, offset);
 
 	/* got enough slots or reach max slots? */
@@ -2828,6 +2840,11 @@ static struct swap_info_struct *alloc_swap_info(void)
 	p = kvzalloc(struct_size(p, avail_lists, nr_node_ids), GFP_KERNEL);
 	if (!p)
 		return ERR_PTR(-ENOMEM);
+	p->cluster_next_cpu = alloc_percpu(unsigned int);
+	if (!p->cluster_next_cpu) {
+		kvfree(p);
+		return ERR_PTR(-ENOMEM);
+	}
 
 	spin_lock(&swap_lock);
 	for (type = 0; type < nr_swapfiles; type++) {
@@ -2962,6 +2979,8 @@ static unsigned long read_swap_header(struct swap_info_struct *p,
 
 	p->lowest_bit  = 1;
 	p->cluster_next = 1;
+	for_each_possible_cpu(i)
+		per_cpu(*p->cluster_next_cpu, i) = 1;
 	p->cluster_nr = 0;
 
 	maxpages = max_swapfile_size();
@@ -3204,6 +3223,10 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		 * SSD
 		 */
 		p->cluster_next = 1 + prandom_u32_max(p->highest_bit);
+		for_each_possible_cpu(cpu) {
+			per_cpu(*p->cluster_next_cpu, cpu) =
+				1 + prandom_u32_max(p->highest_bit);
+		}
 		nr_cluster = DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);
 
 		cluster_info = kvcalloc(nr_cluster, sizeof(*cluster_info),
-- 
2.26.2

