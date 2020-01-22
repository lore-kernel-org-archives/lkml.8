Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AA2C33CB8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 08:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE062465A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 08:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BOFAiFWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgAVIQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 03:16:33 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:40214 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgAVIQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 03:16:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1579680991; x=1611216991;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=A/5aGnXEkuVacvz+Hwcazo5DnQuInoCW2fn4/kQIEeE=;
  b=BOFAiFWCZg3O0NATUsxAxk9STP51+/mOGbVefBoJQrpOzfyeiA8iSHIA
   1l3oiQKRJ45dYE5jHa6GbH93M8vKJv9bIwhbQkLlyDuyuIhy7Hs2dv5GG
   Pqi95jpDeetJ6n5b7yrPNhH0l7Ig5Og17laBjqoFucLPK6/NQ2Ln7C/TS
   Y=;
IronPort-SDR: DC9pCMpPytZ3AOKyt7rZmQd4Dnc5J0oIcWISONv7tzSYzXyOf/nvGKLRNXof1puQDXDyT4U6qV
 Y/ghBbsDCrVg==
X-IronPort-AV: E=Sophos;i="5.70,348,1574121600"; 
   d="scan'208";a="21677566"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-22cc717f.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 22 Jan 2020 08:16:14 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-22cc717f.us-west-2.amazon.com (Postfix) with ESMTPS id 5A373A1983;
        Wed, 22 Jan 2020 08:16:13 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Wed, 22 Jan 2020 08:16:12 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.253) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 22 Jan 2020 08:16:04 +0000
From:   SeongJae Park <sjpark@amazon.com>
CC:     <akpm@linux-foundation.org>, SeongJae Park <sjpark@amazon.de>,
        <acme@kernel.org>, <brendan.d.gregg@gmail.com>, <corbet@lwn.net>,
        <mgorman@suse.de>, <dwmw@amazon.com>, <amit@kernel.org>,
        <rostedt@goodmis.org>, <sj38.park@gmail.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yunjae Lee <lyj7694@gmail.com>, <vdavydov.dev@gmail.com>,
        <vdavydov@parallels.com>, <colin.king@canonical.com>,
        <minchan@kernel.org>
Subject: Re: [PATCH 2/8] mm/damon: Implement region based sampling
Date:   Wed, 22 Jan 2020 09:15:35 +0100
Message-ID: <20200122081535.23080-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120162757.32375-3-sjpark@amazon.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.253]
X-ClientProxiedBy: EX13D24UWA002.ant.amazon.com (10.43.160.200) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2020 17:27:51 +0100 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> This commit implements DAMON's basic access check and region based
> sampling mechanisms.
> 
> Basic Access Check
> ------------------
> 
> DAMON basically reports what pages are how frequently accessed.  Note
> that the frequency is not an absolute number of accesses, but a relative
> frequency among the pages of the target workloads.
> 
> Users can control the resolution of the reports by setting two time
> intervals, ``sampling interval`` and ``aggregation interval``.  In
> detail, DAMON checks access to each page per ``sampling interval``,
> aggregates the results (counts the number of the accesses to each page),
> and reports the aggregated results per ``aggregation interval``.  For
> the access check of each page, DAMON uses the Accessed bits of PTEs.
> 
> This is thus similar to common periodic access checks based access
> tracking mechanisms, which overhead is increasing as the size of the
> target process grows.
> 
> Region Based Sampling
> ---------------------
> 
> To avoid the unbounded increase of the overhead, DAMON groups a number
> of adjacent pages that assumed to have same access frequencies into a
> region.  As long as the assumption (pages in a region have same access
> frequencies) is kept, only one page in the region is required to be
> checked.  Thus, for each ``sampling interval``, DAMON randomly picks one
> page in each region and clears its Accessed bit.  After one more
> ``sampling interval``, DAMON reads the Accessed bit of the page and
> increases the access frequency of the region if the bit has set
> meanwhile.  Therefore, the monitoring overhead is controllable by
> setting the number of regions.
> 
> Nonetheless, this scheme cannot preserve the quality of the output if
> the assumption is not kept.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  mm/damon.c | 599 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 599 insertions(+)
> 
> diff --git a/mm/damon.c b/mm/damon.c
> index 064ec1f6ded9..2a0c010291f8 100644
> --- a/mm/damon.c
> +++ b/mm/damon.c
> @@ -9,9 +9,14 @@
>  
>  #define pr_fmt(fmt) "damon: " fmt
> [...]
> +
> +/*
> + * Check whether the given region has accessed since the last check
> + *
> + * mm	'mm_struct' for the given virtual address space
> + * r	the region to be checked
> + */
> +static void kdamond_check_access(struct mm_struct *mm, struct damon_region *r)
> +{
> +	pte_t *pte = NULL;
> +	pmd_t *pmd = NULL;
> +	spinlock_t *ptl;
> +
> +	if (follow_pte_pmd(mm, r->sampling_addr, NULL, &pte, &pmd, &ptl))
> +		goto mkold;
> +
> +	/* Read the page table access bit of the page */
> +	if (pte && pte_young(*pte))
> +		r->nr_accesses++;
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	else if (pmd && pmd_young(*pmd))
> +		r->nr_accesses++;
> +#endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
> +
> +	spin_unlock(ptl);
> +
> +mkold:
> +	/* mkold next target */
> +	r->sampling_addr = damon_rand(r->vm_start, r->vm_end);
> +
> +	if (follow_pte_pmd(mm, r->sampling_addr, NULL, &pte, &pmd, &ptl))
> +		return;
> +
> +	if (pte) {
> +		if (pte_young(*pte))
> +			clear_page_idle(pte_page(*pte));

Yunjae has personally pointed me out that this could interfere with reclamation
logic because page_referenced_one() checks the pte Accessed bits.  As the
function also checks PG_Young, we agreed to adjust PG_Young in addition to the
PG_Idle here, as below:

    diff --git a/mm/damon.c b/mm/damon.c
    index 8067ea916f81..55b89a2c0140 100644
    --- a/mm/damon.c
    +++ b/mm/damon.c
    @@ -491,14 +491,18 @@ static void kdamond_check_access(struct mm_struct *mm, struct damon_region *r)
                    return;
    
            if (pte) {
    -               if (pte_young(*pte))
    +               if (pte_young(*pte)) {
                            clear_page_idle(pte_page(*pte));
    +                       set_page_young(pte_page(*pte));
    +               }
                    *pte = pte_mkold(*pte);
            }
     #ifdef CONFIG_TRANSPARENT_HUGEPAGE
            else if (pmd) {
    -               if (pmd_young(*pmd))
    +               if (pmd_young(*pmd)) {
                            clear_page_idle(pmd_page(*pmd));
    +                       set_page_young(pte_page(*pte));
    +               }
                    *pmd = pmd_mkold(*pmd);
            }
     #endif

This change will be merged into this patch by next spin.  Also, adding CC for
page_idle.c related people.


Thanks,
SeongJae Park


> +		*pte = pte_mkold(*pte);
> +	}
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	else if (pmd) {
> +		if (pmd_young(*pmd))
> +			clear_page_idle(pmd_page(*pmd));
> +		*pmd = pmd_mkold(*pmd);
> +	}
> +#endif
> +
> +	spin_unlock(ptl);
> +}
> +
> +/*
> + * Check whether a time interval is elapsed
> + *
> + * baseline	the time to check whether the interval has elapsed since
> + * interval	the time interval (microseconds)
> + *
> + * See whether the given time interval has passed since the given baseline
> + * time.  If so, it also updates the baseline to current time for next check.
> + *
> + * Returns true if the time interval has passed, or false otherwise.
> + */
> +static bool damon_check_reset_time_interval(struct timespec64 *baseline,
> +		unsigned long interval)
> +{
> +	struct timespec64 now;
> +
> +	ktime_get_coarse_ts64(&now);
> +	if ((timespec64_to_ns(&now) - timespec64_to_ns(baseline)) / 1000 <
> +			interval)
> +		return false;
> +	*baseline = now;
> +	return true;
> +}
> +
> +/*
> + * Check whether it is time to flush the aggregated information
> + */
> +static bool kdamond_aggregate_interval_passed(void)
> +{
> +	return damon_check_reset_time_interval(&last_aggregate_time,
> +			aggr_interval);
> +}
> +
> +/*
> + * Flush the content in the result buffer to the result file
> + */
> +static void damon_flush_rbuffer(void)
> +{
> +	ssize_t sz;
> +	loff_t pos;
> +	struct file *rfile;
> +
> +	while (damon_rbuf_offset) {
> +		pos = 0;
> +		rfile = filp_open(rfile_path, O_CREAT | O_RDWR | O_APPEND,
> +				0644);
> +		if (IS_ERR(rfile)) {
> +			pr_err("Cannot open the result file %s\n", rfile_path);
> +			return;
> +		}
> +
> +		sz = kernel_write(rfile, damon_rbuf, damon_rbuf_offset, &pos);
> +		filp_close(rfile, NULL);
> +
> +		damon_rbuf_offset -= sz;
> +	}
> +}
> +
> +/*
> + * Write a data into the result buffer
> + */
> +static void damon_write_rbuf(void *data, ssize_t size)
> +{
> +	if (damon_rbuf_offset + size > DAMON_LEN_RBUF)
> +		damon_flush_rbuffer();
> +
> +	memcpy(&damon_rbuf[damon_rbuf_offset], data, size);
> +	damon_rbuf_offset += size;
> +}
> +
> +/*
> + * Flush the aggregated monitoring results to the result buffer
> + *
> + * Stores current tracking results to the result buffer and reset 'nr_accesses'
> + * of each regions.  The format for the result buffer is as below:
> + *
> + *   <time> <number of tasks> <array of task infos>
> + *
> + *   task info: <pid> <number of regions> <array of region infos>
> + *   region info: <start address> <end address> <nr_accesses>
> + */
> +static void kdamond_flush_aggregated(void)
> +{
> +	struct damon_task *t;
> +	struct timespec64 now;
> +	unsigned int nr;
> +
> +	ktime_get_coarse_ts64(&now);
> +
> +	damon_write_rbuf(&now, sizeof(struct timespec64));
> +	nr = nr_damon_tasks();
> +	damon_write_rbuf(&nr, sizeof(nr));
> +
> +	damon_for_each_task(t) {
> +		struct damon_region *r;
> +
> +		damon_write_rbuf(&t->pid, sizeof(t->pid));
> +		nr = nr_damon_regions(t);
> +		damon_write_rbuf(&nr, sizeof(nr));
> +		damon_for_each_region(r, t) {
> +			damon_write_rbuf(&r->vm_start, sizeof(r->vm_start));
> +			damon_write_rbuf(&r->vm_end, sizeof(r->vm_end));
> +			damon_write_rbuf(&r->nr_accesses,
> +					sizeof(r->nr_accesses));
> +			r->nr_accesses = 0;
> +		}
> +	}
> +}
> +
> +/*
> + * Check whether current monitoring should be stopped
> + *
> + * If users asked to stop, need stop.  Even though no user has asked to stop,
> + * need stop if every target task has dead.
> + *
> + * Returns true if need to stop current monitoring.
> + */
> +static bool kdamond_need_stop(void)
> +{
> +	struct damon_task *t;
> +	struct task_struct *task;
> +	bool stop;
> +
> +	spin_lock(&kdamond_lock);
> +	stop = kdamond_stop;
> +	spin_unlock(&kdamond_lock);
> +	if (stop)
> +		return true;
> +
> +	damon_for_each_task(t) {
> +		task = damon_get_task_struct(t);
> +		if (task) {
> +			put_task_struct(task);
> +			return false;
> +		}
> +	}
> +
> +	return true;
> +}
> +
> +/*
> + * The monitoring daemon that runs as a kernel thread
> + */
> +static int kdamond_fn(void *data)
> +{
> +	struct damon_task *t;
> +	struct damon_region *r, *next;
> +	struct mm_struct *mm;
> +
> +	pr_info("kdamond (%d) starts\n", kdamond->pid);
> +	kdamond_init_regions();
> +	while (!kdamond_need_stop()) {
> +		damon_for_each_task(t) {
> +			mm = damon_get_mm(t);
> +			if (!mm)
> +				continue;
> +			damon_for_each_region(r, t)
> +				kdamond_check_access(mm, r);
> +			mmput(mm);
> +		}
> +
> +		if (kdamond_aggregate_interval_passed())
> +			kdamond_flush_aggregated();
> +
> +		usleep_range(sample_interval, sample_interval + 1);
> +	}
> +	damon_flush_rbuffer();
> +	damon_for_each_task(t) {
> +		damon_for_each_region_safe(r, next, t)
> +			damon_destroy_region(r);
> +	}
> +	pr_info("kdamond (%d) finishes\n", kdamond->pid);
> +	spin_lock(&kdamond_lock);
> +	kdamond = NULL;
> +	spin_unlock(&kdamond_lock);
> +	return 0;
> +}
> +
> +/*
> + * Controller functions
> + */
> +
> +/*
> + * Start or stop the kdamond
> + *
> + * Returns 0 if success, negative error code otherwise.
> + */
> +static int damon_turn_kdamond(bool on)
> +{
> +	spin_lock(&kdamond_lock);
> +	kdamond_stop = !on;
> +	if (!kdamond && on) {
> +		kdamond = kthread_run(kdamond_fn, NULL, "kdamond");
> +		if (!kdamond)
> +			goto fail;
> +		goto success;
> +	}
> +	if (kdamond && !on) {
> +		spin_unlock(&kdamond_lock);
> +		while (true) {
> +			spin_lock(&kdamond_lock);
> +			if (!kdamond)
> +				goto success;
> +			spin_unlock(&kdamond_lock);
> +
> +			usleep_range(sample_interval, sample_interval * 2);
> +		}
> +	}
> +
> +	/* tried to turn on while turned on, or turn off while turned off */
> +
> +fail:
> +	spin_unlock(&kdamond_lock);
> +	return -EINVAL;
> +
> +success:
> +	spin_unlock(&kdamond_lock);
> +	return 0;
> +}
> +
> +static inline bool damon_is_target_pid(unsigned long pid)
> +{
> +	struct damon_task *t;
> +
> +	damon_for_each_task(t) {
> +		if (t->pid == pid)
> +			return true;
> +	}
> +	return false;
> +}
> +
> +/*
> + * This function should not be called while the kdamond is running.
> + */
> +static long damon_set_pids(unsigned long *pids, ssize_t nr_pids)
> +{
> +	ssize_t i;
> +	struct damon_task *t, *next;
> +
> +	/* Remove unselected tasks */
> +	damon_for_each_task_safe(t, next) {
> +		for (i = 0; i < nr_pids; i++) {
> +			if (pids[i] == t->pid)
> +				break;
> +		}
> +		if (i != nr_pids)
> +			continue;
> +		damon_destroy_task(t);
> +	}
> +
> +	/* Add new tasks */
> +	for (i = 0; i < nr_pids; i++) {
> +		if (damon_is_target_pid(pids[i]))
> +			continue;
> +		t = damon_new_task(pids[i]);
> +		if (!t) {
> +			pr_err("Failed to alloc damon_task\n");
> +			return -ENOMEM;
> +		}
> +		damon_add_task_tail(t);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Set attributes for the monitoring
> + *
> + * sample_int		time interval between samplings
> + * aggr_int		time interval between aggregations
> + * min_nr_reg		minimal number of regions
> + * path_to_rfile	path to the monitor result files
> + *
> + * This function should not be called while the kdamond is running.
> + * Every time interval is in micro-seconds.
> + *
> + * Returns 0 on success, negative error code otherwise.
> + */
> +static long damon_set_attrs(unsigned long sample_int, unsigned long aggr_int,
> +		unsigned long min_nr_reg, char *path_to_rfile)
> +{
> +	if (strnlen(path_to_rfile, LEN_RES_FILE_PATH) >= LEN_RES_FILE_PATH) {
> +		pr_err("too long (>%d) result file path %s\n",
> +				LEN_RES_FILE_PATH, path_to_rfile);
> +		return -EINVAL;
> +	}
> +	if (min_nr_reg < 3) {
> +		pr_err("min_nr_regions (%lu) should be bigger than 2\n",
> +				min_nr_reg);
> +		return -EINVAL;
> +	}
> +
> +	sample_interval = sample_int;
> +	aggr_interval = aggr_int;
> +	min_nr_regions = min_nr_reg;
> +	strncpy(rfile_path, path_to_rfile, LEN_RES_FILE_PATH);
> +	return 0;
> +}
> +
>  static int __init damon_init(void)
>  {
>  	pr_info("init\n");
>  
>  	prandom_seed_state(&rndseed, 42);
> +	ktime_get_coarse_ts64(&last_aggregate_time);
>  	return 0;
>  }
>  
>  static void __exit damon_exit(void)
>  {
> +	damon_turn_kdamond(false);
>  	pr_info("exit\n");
>  }
>  
> -- 
> 2.17.1
> 
