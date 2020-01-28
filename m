Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211D9C35246
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 08:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C5D207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 08:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VQ7BdG7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgA1I6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 03:58:38 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:11254 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgA1I6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 03:58:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1580201915; x=1611737915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=wJ/KbDn9ODQ8bIxPN5eYNxHEbIpfqs2V11SCqxFPMk8=;
  b=VQ7BdG7BrTx5J+1gVuCnQdSLQGleekz2IhsyyqTT5sUpUJb0trqVX4ZT
   gwoaqrWVKnNEbOUsZFO73oK7KgKXJdhdYI72oxG7V1Q1uU/uaa2QqJIgp
   96U8QyqiK5R55nAaJ2f19jthcXJmCMR54IcHeuM77TQUrudZIS0Z9IoYQ
   w=;
IronPort-SDR: IM+5GR21Bij2yRlk2CnL1aotoYfk0HwSF95XQieiS3hfDlWstjDngjfmO26eHum30Yz6faK+wC
 YJ9InxiiP96Q==
X-IronPort-AV: E=Sophos;i="5.70,373,1574121600"; 
   d="scan'208";a="14531605"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 28 Jan 2020 08:58:33 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (Postfix) with ESMTPS id 9BB8CA23D5;
        Tue, 28 Jan 2020 08:58:31 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 28 Jan 2020 08:58:31 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.29) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 28 Jan 2020 08:58:23 +0000
From:   <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <sj38.park@gmail.com>,
        <acme@kernel.org>, <amit@kernel.org>, <brendan.d.gregg@gmail.com>,
        <corbet@lwn.net>, <dwmw@amazon.com>, <mgorman@suse.de>,
        <rostedt@goodmis.org>, <kirill@shutemov.name>,
        <brendanhiggins@google.com>, <colin.king@canonical.com>,
        <minchan@kernel.org>, <vdavydov.dev@gmail.com>,
        <vdavydov@parallels.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/9] mm/damon: Implement region based sampling
Date:   Tue, 28 Jan 2020 09:57:35 +0100
Message-ID: <20200128085742.14566-3-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200128085742.14566-1-sjpark@amazon.com>
References: <20200128085742.14566-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.29]
X-ClientProxiedBy: EX13D21UWA001.ant.amazon.com (10.43.160.154) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit implements DAMON's basic access check and region based
sampling mechanisms.

Basic Access Check
------------------

DAMON basically reports what pages are how frequently accessed.  Note
that the frequency is not an absolute number of accesses, but a relative
frequency among the pages of the target workloads.

Users can control the resolution of the reports by setting two time
intervals, ``sampling interval`` and ``aggregation interval``.  In
detail, DAMON checks access to each page per ``sampling interval``,
aggregates the results (counts the number of the accesses to each page),
and reports the aggregated results per ``aggregation interval``.  For
the access check of each page, DAMON uses the Accessed bits of PTEs.

This is thus similar to common periodic access checks based access
tracking mechanisms, which overhead is increasing as the size of the
target process grows.

Region Based Sampling
---------------------

To avoid the unbounded increase of the overhead, DAMON groups a number
of adjacent pages that assumed to have same access frequencies into a
region.  As long as the assumption (pages in a region have same access
frequencies) is kept, only one page in the region is required to be
checked.  Thus, for each ``sampling interval``, DAMON randomly picks one
page in each region and clears its Accessed bit.  After one more
``sampling interval``, DAMON reads the Accessed bit of the page and
increases the access frequency of the region if the bit has set
meanwhile.  Therefore, the monitoring overhead is controllable by
setting the number of regions.

Nonetheless, this scheme cannot preserve the quality of the output if
the assumption is not kept.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon.c | 608 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 608 insertions(+)

diff --git a/mm/damon.c b/mm/damon.c
index 064ec1f6ded9..4144e9da9282 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -9,9 +9,14 @@
 
 #define pr_fmt(fmt) "damon: " fmt
 
+#include <linux/delay.h>
+#include <linux/kthread.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/page_idle.h>
 #include <linux/random.h>
+#include <linux/sched/mm.h>
+#include <linux/sched/task.h>
 #include <linux/slab.h>
 
 #define damon_get_task_struct(t) \
@@ -54,6 +59,36 @@ struct damon_task {
 /* List of damon_task objects */
 static LIST_HEAD(damon_tasks_list);
 
+/*
+ * For each 'sample_interval', DAMON checks whether each region is accessed or
+ * not.  It aggregates and keeps the access information (number of accesses to
+ * each region) for 'aggr_interval' and then flushes it to the result buffer if
+ * an 'aggr_interval' surpassed.
+ *
+ * All time intervals are in micro-seconds.
+ */
+static unsigned long sample_interval = 5 * 1000;
+static unsigned long aggr_interval = 100 * 1000;
+
+static struct timespec64 last_aggregate_time;
+
+static unsigned long min_nr_regions = 10;
+
+/* result buffer */
+#define DAMON_LEN_RBUF	(1024 * 1024 * 4)
+static char damon_rbuf[DAMON_LEN_RBUF];
+static unsigned int damon_rbuf_offset;
+
+/* result file */
+#define LEN_RES_FILE_PATH	256
+static char rfile_path[LEN_RES_FILE_PATH] = "/damon.data";
+
+static struct task_struct *kdamond;
+static bool kdamond_stop;
+
+/* Protects read/write of kdamond and kdamond_stop */
+static DEFINE_SPINLOCK(kdamond_lock);
+
 static struct rnd_state rndseed;
 /* Get a random number in [l, r) */
 #define damon_rand(l, r) (l + prandom_u32_state(&rndseed) % (r - l))
@@ -202,16 +237,589 @@ static unsigned int nr_damon_regions(struct damon_task *t)
 	return ret;
 }
 
+/*
+ * Get the mm_struct of the given task
+ *
+ * Callser should put the mm_struct after use, unless it is NULL.
+ *
+ * Returns the mm_struct of the task on success, NULL on failure
+ */
+static struct mm_struct *damon_get_mm(struct damon_task *t)
+{
+	struct task_struct *task;
+	struct mm_struct *mm;
+
+	task = damon_get_task_struct(t);
+	if (!task)
+		return NULL;
+
+	mm = get_task_mm(task);
+	put_task_struct(task);
+	return mm;
+}
+
+/*
+ * Size-evenly split a region into 'nr_pieces' small regions
+ *
+ * Returns 0 on success, or negative error code otherwise.
+ */
+static int damon_split_region_evenly(struct damon_region *r,
+				unsigned int nr_pieces)
+{
+	unsigned long sz_orig, sz_piece, orig_end;
+	struct damon_region *piece = NULL, *next;
+	unsigned long start;
+
+	if (!r || !nr_pieces)
+		return -EINVAL;
+
+	orig_end = r->vm_end;
+	sz_orig = r->vm_end - r->vm_start;
+	sz_piece = sz_orig / nr_pieces;
+
+	if (!sz_piece)
+		return -EINVAL;
+
+	r->vm_end = r->vm_start + sz_piece;
+	next = damon_next_region(r);
+	for (start = r->vm_end; start + sz_piece <= orig_end;
+			start += sz_piece) {
+		piece = damon_new_region(start, start + sz_piece);
+		damon_add_region(piece, r, next);
+		r = piece;
+	}
+	if (piece)
+		piece->vm_end = orig_end;
+	return 0;
+}
+
+struct region {
+	unsigned long start;
+	unsigned long end;
+};
+
+static unsigned long sz_region(struct region *r)
+{
+	return r->end - r->start;
+}
+
+static void swap_regions(struct region *r1, struct region *r2)
+{
+	struct region tmp;
+
+	tmp = *r1;
+	*r1 = *r2;
+	*r2 = tmp;
+}
+
+/*
+ * Find the three regions in an address space
+ *
+ * vma		the head vma of the target address space
+ * regions	an array of three 'struct region's that results will be saved
+ *
+ * This function receives an address space and finds three regions in it which
+ * separated by the two biggest unmapped regions in the space.
+ *
+ * Returns 0 if success, or negative error code otherwise.
+ */
+static int damon_three_regions_in_vmas(struct vm_area_struct *vma,
+		struct region regions[3])
+{
+	struct region gap = {0,}, first_gap = {0,}, second_gap = {0,};
+	struct vm_area_struct *last_vma = NULL;
+	unsigned long start = 0;
+
+	/* Find two biggest gaps so that first_gap > second_gap > others */
+	for (; vma; vma = vma->vm_next) {
+		if (!last_vma) {
+			start = vma->vm_start;
+			last_vma = vma;
+			continue;
+		}
+		gap.start = last_vma->vm_end;
+		gap.end = vma->vm_start;
+		if (sz_region(&gap) > sz_region(&second_gap)) {
+			swap_regions(&gap, &second_gap);
+			if (sz_region(&second_gap) > sz_region(&first_gap))
+				swap_regions(&second_gap, &first_gap);
+		}
+		last_vma = vma;
+	}
+
+	if (!sz_region(&second_gap) || !sz_region(&first_gap))
+		return -EINVAL;
+
+	/* Sort the two biggest gaps by address */
+	if (first_gap.start > second_gap.start)
+		swap_regions(&first_gap, &second_gap);
+
+	/* Store the result */
+	regions[0].start = start;
+	regions[0].end = first_gap.start;
+	regions[1].start = first_gap.end;
+	regions[1].end = second_gap.start;
+	regions[2].start = second_gap.end;
+	regions[2].end = last_vma->vm_end;
+
+	return 0;
+}
+
+/*
+ * Get the three regions in the given task
+ *
+ * Returns 0 on success, negative error code otherwise.
+ */
+static int damon_three_regions_of(struct damon_task *t,
+				struct region regions[3])
+{
+	struct mm_struct *mm;
+	int ret;
+
+	mm = damon_get_mm(t);
+	if (!mm)
+		return -EINVAL;
+
+	down_read(&mm->mmap_sem);
+	ret = damon_three_regions_in_vmas(mm->mmap, regions);
+	up_read(&mm->mmap_sem);
+
+	mmput(mm);
+	return ret;
+}
+
+/*
+ * Initialize the monitoring target regions for the given task
+ *
+ * t	the given target task
+ *
+ * Because only a number of small portions of the entire address space
+ * is acutally mapped to the memory and accessed, monitoring the unmapped
+ * regions is wasteful.  That said, because we can deal with small noises,
+ * tracking every mapping is not strictly required but could even incur a high
+ * overhead if the mapping frequently changes or the number of mappings is
+ * high.
+ *
+ * For the reason, we convert the complex mappings to three distinct regions
+ * that cover every mapped areas of the address space.  Also the two gaps
+ * between the three regions are the two biggest unmapped areas in the given
+ * address space.  In detail, this function first identifies the start and the
+ * end of the mappings and the two biggest unmapped areas of the address space.
+ * Then, it constructs the three regions as below:
+ *
+ *     [mappings[0]->start, big_two_unmapped_areas[0]->start)
+ *     [big_two_unmapped_areas[0]->end, big_two_unmapped_areas[1]->start)
+ *     [big_two_unmapped_areas[1]->end, mappings[nr_mappings - 1]->end)
+ *
+ * As usual memory map of processes is as below, the gap between the heap and
+ * the uppermost mmap()-ed region, and the gap between the lowermost mmap()-ed
+ * region and the stack will be two biggest unmapped regions.  Because these
+ * gaps are exceptionally huge areas in usual address space, excluding these
+ * two biggest unmapped regions will be sufficient to make a trade-off.
+ *
+ *   <heap>
+ *   <BIG UNMAPPED REGION 1>
+ *   <uppermost mmap()-ed region>
+ *   (other mmap()-ed regions and small unmapped regions)
+ *   <lowermost mmap()-ed region>
+ *   <BIG UNMAPPED REGION 2>
+ *   <stack>
+ */
+static void damon_init_regions_of(struct damon_task *t)
+{
+	struct damon_region *r;
+	struct region regions[3];
+	int i;
+
+	if (damon_three_regions_of(t, regions)) {
+		pr_err("Failed to get three regions of task %lu\n", t->pid);
+		return;
+	}
+
+	/* Set the initial three regions of the task */
+	for (i = 0; i < 3; i++) {
+		r = damon_new_region(regions[i].start, regions[i].end);
+		damon_add_region_tail(r, t);
+	}
+
+	/* Split the middle region into 'min_nr_regions - 2' regions */
+	r = damon_nth_region_of(t, 1);
+	if (damon_split_region_evenly(r, min_nr_regions - 2))
+		pr_warn("Init middle region failed to be split\n");
+}
+
+/* Initialize '->regions_list' of every task */
+static void kdamond_init_regions(void)
+{
+	struct damon_task *t;
+
+	damon_for_each_task(t)
+		damon_init_regions_of(t);
+}
+
+/*
+ * Check whether the given region has accessed since the last check
+ *
+ * mm	'mm_struct' for the given virtual address space
+ * r	the region to be checked
+ */
+static void kdamond_check_access(struct mm_struct *mm, struct damon_region *r)
+{
+	pte_t *pte = NULL;
+	pmd_t *pmd = NULL;
+	spinlock_t *ptl;
+
+	if (follow_pte_pmd(mm, r->sampling_addr, NULL, &pte, &pmd, &ptl))
+		goto mkold;
+
+	/* Read the page table access bit of the page */
+	if (pte && pte_young(*pte))
+		r->nr_accesses++;
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	else if (pmd && pmd_young(*pmd))
+		r->nr_accesses++;
+#endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
+
+	spin_unlock(ptl);
+
+mkold:
+	/* mkold next target */
+	r->sampling_addr = damon_rand(r->vm_start, r->vm_end);
+
+	if (follow_pte_pmd(mm, r->sampling_addr, NULL, &pte, &pmd, &ptl))
+		return;
+
+	if (pte) {
+		if (pte_young(*pte)) {
+			clear_page_idle(pte_page(*pte));
+			set_page_young(pte_page(*pte));
+		}
+		*pte = pte_mkold(*pte);
+	}
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	else if (pmd) {
+		if (pmd_young(*pmd)) {
+			clear_page_idle(pmd_page(*pmd));
+			set_page_young(pte_page(*pte));
+		}
+		*pmd = pmd_mkold(*pmd);
+	}
+#endif
+
+	spin_unlock(ptl);
+}
+
+/*
+ * Check whether a time interval is elapsed
+ *
+ * baseline	the time to check whether the interval has elapsed since
+ * interval	the time interval (microseconds)
+ *
+ * See whether the given time interval has passed since the given baseline
+ * time.  If so, it also updates the baseline to current time for next check.
+ *
+ * Returns true if the time interval has passed, or false otherwise.
+ */
+static bool damon_check_reset_time_interval(struct timespec64 *baseline,
+		unsigned long interval)
+{
+	struct timespec64 now;
+
+	ktime_get_coarse_ts64(&now);
+	if ((timespec64_to_ns(&now) - timespec64_to_ns(baseline)) / 1000 <
+			interval)
+		return false;
+	*baseline = now;
+	return true;
+}
+
+/*
+ * Check whether it is time to flush the aggregated information
+ */
+static bool kdamond_aggregate_interval_passed(void)
+{
+	return damon_check_reset_time_interval(&last_aggregate_time,
+			aggr_interval);
+}
+
+/*
+ * Flush the content in the result buffer to the result file
+ */
+static void damon_flush_rbuffer(void)
+{
+	ssize_t sz;
+	loff_t pos;
+	struct file *rfile;
+
+	while (damon_rbuf_offset) {
+		pos = 0;
+		rfile = filp_open(rfile_path, O_CREAT | O_RDWR | O_APPEND,
+				0644);
+		if (IS_ERR(rfile)) {
+			pr_err("Cannot open the result file %s\n", rfile_path);
+			return;
+		}
+
+		sz = kernel_write(rfile, damon_rbuf, damon_rbuf_offset, &pos);
+		filp_close(rfile, NULL);
+
+		damon_rbuf_offset -= sz;
+	}
+}
+
+/*
+ * Write a data into the result buffer
+ */
+static void damon_write_rbuf(void *data, ssize_t size)
+{
+	if (damon_rbuf_offset + size > DAMON_LEN_RBUF)
+		damon_flush_rbuffer();
+
+	memcpy(&damon_rbuf[damon_rbuf_offset], data, size);
+	damon_rbuf_offset += size;
+}
+
+/*
+ * Flush the aggregated monitoring results to the result buffer
+ *
+ * Stores current tracking results to the result buffer and reset 'nr_accesses'
+ * of each regions.  The format for the result buffer is as below:
+ *
+ *   <time> <number of tasks> <array of task infos>
+ *
+ *   task info: <pid> <number of regions> <array of region infos>
+ *   region info: <start address> <end address> <nr_accesses>
+ */
+static void kdamond_flush_aggregated(void)
+{
+	struct damon_task *t;
+	struct timespec64 now;
+	unsigned int nr;
+
+	ktime_get_coarse_ts64(&now);
+
+	damon_write_rbuf(&now, sizeof(struct timespec64));
+	nr = nr_damon_tasks();
+	damon_write_rbuf(&nr, sizeof(nr));
+
+	damon_for_each_task(t) {
+		struct damon_region *r;
+
+		damon_write_rbuf(&t->pid, sizeof(t->pid));
+		nr = nr_damon_regions(t);
+		damon_write_rbuf(&nr, sizeof(nr));
+		damon_for_each_region(r, t) {
+			damon_write_rbuf(&r->vm_start, sizeof(r->vm_start));
+			damon_write_rbuf(&r->vm_end, sizeof(r->vm_end));
+			damon_write_rbuf(&r->nr_accesses,
+					sizeof(r->nr_accesses));
+			r->nr_accesses = 0;
+		}
+	}
+}
+
+/*
+ * Check whether current monitoring should be stopped
+ *
+ * If users asked to stop, need stop.  Even though no user has asked to stop,
+ * need stop if every target task has dead.
+ *
+ * Returns true if need to stop current monitoring.
+ */
+static bool kdamond_need_stop(void)
+{
+	struct damon_task *t;
+	struct task_struct *task;
+	bool stop;
+
+	spin_lock(&kdamond_lock);
+	stop = kdamond_stop;
+	spin_unlock(&kdamond_lock);
+	if (stop)
+		return true;
+
+	damon_for_each_task(t) {
+		task = damon_get_task_struct(t);
+		if (task) {
+			put_task_struct(task);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+/*
+ * The monitoring daemon that runs as a kernel thread
+ */
+static int kdamond_fn(void *data)
+{
+	struct damon_task *t;
+	struct damon_region *r, *next;
+	struct mm_struct *mm;
+
+	pr_info("kdamond (%d) starts\n", kdamond->pid);
+	kdamond_init_regions();
+	while (!kdamond_need_stop()) {
+		damon_for_each_task(t) {
+			mm = damon_get_mm(t);
+			if (!mm)
+				continue;
+			damon_for_each_region(r, t)
+				kdamond_check_access(mm, r);
+			mmput(mm);
+		}
+
+		if (kdamond_aggregate_interval_passed())
+			kdamond_flush_aggregated();
+
+		usleep_range(sample_interval, sample_interval + 1);
+	}
+	damon_flush_rbuffer();
+	damon_for_each_task(t) {
+		damon_for_each_region_safe(r, next, t)
+			damon_destroy_region(r);
+	}
+	pr_info("kdamond (%d) finishes\n", kdamond->pid);
+	spin_lock(&kdamond_lock);
+	kdamond = NULL;
+	spin_unlock(&kdamond_lock);
+	return 0;
+}
+
+/*
+ * Controller functions
+ */
+
+/*
+ * Start or stop the kdamond
+ *
+ * Returns 0 if success, negative error code otherwise.
+ */
+static int damon_turn_kdamond(bool on)
+{
+	spin_lock(&kdamond_lock);
+	kdamond_stop = !on;
+	if (!kdamond && on) {
+		kdamond = kthread_run(kdamond_fn, NULL, "kdamond");
+		if (!kdamond)
+			goto fail;
+		goto success;
+	}
+	if (kdamond && !on) {
+		spin_unlock(&kdamond_lock);
+		while (true) {
+			spin_lock(&kdamond_lock);
+			if (!kdamond)
+				goto success;
+			spin_unlock(&kdamond_lock);
+
+			usleep_range(sample_interval, sample_interval * 2);
+		}
+	}
+
+	/* tried to turn on while turned on, or turn off while turned off */
+
+fail:
+	spin_unlock(&kdamond_lock);
+	return -EINVAL;
+
+success:
+	spin_unlock(&kdamond_lock);
+	return 0;
+}
+
+static inline bool damon_is_target_pid(unsigned long pid)
+{
+	struct damon_task *t;
+
+	damon_for_each_task(t) {
+		if (t->pid == pid)
+			return true;
+	}
+	return false;
+}
+
+/*
+ * This function should not be called while the kdamond is running.
+ */
+static long damon_set_pids(unsigned long *pids, ssize_t nr_pids)
+{
+	ssize_t i;
+	struct damon_task *t, *next;
+
+	/* Remove unselected tasks */
+	damon_for_each_task_safe(t, next) {
+		for (i = 0; i < nr_pids; i++) {
+			if (pids[i] == t->pid)
+				break;
+		}
+		if (i != nr_pids)
+			continue;
+		damon_destroy_task(t);
+	}
+
+	/* Add new tasks */
+	for (i = 0; i < nr_pids; i++) {
+		if (damon_is_target_pid(pids[i]))
+			continue;
+		t = damon_new_task(pids[i]);
+		if (!t) {
+			pr_err("Failed to alloc damon_task\n");
+			return -ENOMEM;
+		}
+		damon_add_task_tail(t);
+	}
+
+	return 0;
+}
+
+/*
+ * Set attributes for the monitoring
+ *
+ * sample_int		time interval between samplings
+ * aggr_int		time interval between aggregations
+ * min_nr_reg		minimal number of regions
+ * path_to_rfile	path to the monitor result files
+ *
+ * This function should not be called while the kdamond is running.
+ * Every time interval is in micro-seconds.
+ *
+ * Returns 0 on success, negative error code otherwise.
+ */
+static long damon_set_attrs(unsigned long sample_int, unsigned long aggr_int,
+		unsigned long min_nr_reg, char *path_to_rfile)
+{
+	if (strnlen(path_to_rfile, LEN_RES_FILE_PATH) >= LEN_RES_FILE_PATH) {
+		pr_err("too long (>%d) result file path %s\n",
+				LEN_RES_FILE_PATH, path_to_rfile);
+		return -EINVAL;
+	}
+	if (min_nr_reg < 3) {
+		pr_err("min_nr_regions (%lu) should be bigger than 2\n",
+				min_nr_reg);
+		return -EINVAL;
+	}
+
+	sample_interval = sample_int;
+	aggr_interval = aggr_int;
+	min_nr_regions = min_nr_reg;
+	strncpy(rfile_path, path_to_rfile, LEN_RES_FILE_PATH);
+	return 0;
+}
+
 static int __init damon_init(void)
 {
 	pr_info("init\n");
 
 	prandom_seed_state(&rndseed, 42);
+	ktime_get_coarse_ts64(&last_aggregate_time);
 	return 0;
 }
 
 static void __exit damon_exit(void)
 {
+	damon_turn_kdamond(false);
 	pr_info("exit\n");
 }
 
-- 
2.17.1

