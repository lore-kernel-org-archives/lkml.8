Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B3FC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 22:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EB4420767
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 22:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589581163;
	bh=koZIFswSrjwiJ4jG44rNFzFttXBSJwBIimEBEGtqJCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Fa0S/PdcJ1AHLVR8ldV5GfwM7ukJ1+LhUxDsVOU/ryDk/s67SZofLs8L9e7m0bxH7
	 k1rMkmTolxQR/aysmaZVnyCmrpoGXJXgeacRVLlTZcBKpbA5PXyV2+hqhnqECsg2in
	 CIcWEcgtm9sLwSfFhPx91/yvUR6WB3m8u1OPpppI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgEOWTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 18:19:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgEOWTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 18:19:22 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 100B820758;
        Fri, 15 May 2020 22:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589581161;
        bh=koZIFswSrjwiJ4jG44rNFzFttXBSJwBIimEBEGtqJCo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bMySVJyy/6fEWqrYhsHYQG6y7VOifw2FvmM2EMdsk/j8dPTZJXK4rEz+BTfQ3JZgP
         a9NVi1L41C53U2psdXD0N15sWV4BuNNsX+WtA1Rlx6YhokeGN3K8fUY46Z9BtVisBT
         arNe7ZBlh6zXsYk04pDDOK634tsIQimWuRX4iEw8=
Date:   Fri, 15 May 2020 15:19:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] swap: Add percpu cluster_next to reduce lock contention
 on swap cache
Message-Id: <20200515151920.34f147b7b0baa3017cd7a2bb@linux-foundation.org>
In-Reply-To: <20200514070424.16017-1-ying.huang@intel.com>
References: <20200514070424.16017-1-ying.huang@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 May 2020 15:04:24 +0800 Huang Ying <ying.huang@intel.com> wrote:

> In some swap scalability test, it is found that there are heavy lock
> contention on swap cache even if we have split one swap cache radix
> tree per swap device to one swap cache radix tree every 64 MB trunk in
> commit 4b3ef9daa4fc ("mm/swap: split swap cache into 64MB trunks").
> 
> The reason is as follow.  After the swap device becomes fragmented so
> that there's no free swap cluster, the swap device will be scanned
> linearly to find the free swap slots.  swap_info_struct->cluster_next
> is the next scanning base that is shared by all CPUs.  So nearby free
> swap slots will be allocated for different CPUs.  The probability for
> multiple CPUs to operate on the same 64 MB trunk is high.  This causes
> the lock contention on the swap cache.
> 
> To solve the issue, in this patch, for SSD swap device, a percpu
> version next scanning base (cluster_next_cpu) is added.  Every CPU
> will use its own next scanning base.  So the probability for multiple
> CPUs to operate on the same 64 MB trunk is reduced greatly.  Thus the
> lock contention is reduced too.  For HDD, because sequential access is
> more important for IO performance, the original shared next scanning
> base is used.
> 
> To test the patch, we have run 16-process pmbench memory benchmark on
> a 2-socket server machine with 48 cores.  One ram disk is configured
> as the swap device per socket.  The pmbench working-set size is much
> larger than the available memory so that swapping is triggered.  The
> memory read/write ratio is 80/20 and the accessing pattern is random.
> In the original implementation, the lock contention on the swap cache
> is heavy.  The perf profiling data of the lock contention code path is
> as following,
> 
> _raw_spin_lock_irq.add_to_swap_cache.add_to_swap.shrink_page_list:      7.93
> _raw_spin_lock_irqsave.__remove_mapping.shrink_page_list: 		7.03
> _raw_spin_lock_irq.mem_cgroup_commit_charge.do_swap_page: 		3.7
> _raw_spin_lock.swapcache_free_entries.free_swap_slot.__swap_entry_free: 2.9
> _raw_spin_lock_irq.shrink_inactive_list.shrink_lruvec.shrink_node:	1.32
> _raw_spin_lock.free_pcppages_bulk.drain_pages_zone.drain_pages: 	1.01
> _raw_spin_lock_irq.shrink_active_list.shrink_lruvec.shrink_node: 	0.87
> 
> After applying this patch, it becomes,
> 
> _raw_spin_lock_irq.mem_cgroup_commit_charge.do_swap_page:		3.99
> _raw_spin_lock.swapcache_free_entries.free_swap_slot.__swap_entry_free: 3.0
> _raw_spin_lock_irq.shrink_inactive_list.shrink_lruvec.shrink_node:      1.47
> _raw_spin_lock_irq.shrink_active_list.shrink_lruvec.shrink_node: 	1.31
> _raw_spin_lock.free_pcppages_bulk.drain_pages_zone.drain_pages: 	0.88
> _raw_spin_lock.scan_swap_map_slots.get_swap_pages.get_swap_page: 	0.76
> _raw_spin_lock_irq.add_to_swap_cache.add_to_swap.shrink_page_list:      0.53
> 
> The lock contention on the swap cache is almost eliminated.
> 
> And the pmbench score increases 15.9%.  The swapin throughput
> increases 16.2% from 2.84 GB/s to 3.3 GB/s.  While the swapout
> throughput increases 16.1% from 2.87 GB/s to 3.33 GB/s.
> 
> ...
>
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -252,6 +252,7 @@ struct swap_info_struct {
>  	unsigned int inuse_pages;	/* number of those currently in use */
>  	unsigned int cluster_next;	/* likely index for next allocation */
>  	unsigned int cluster_nr;	/* countdown to next cluster search */
> +	unsigned int __percpu *cluster_next_cpu; /*percpu index for next allocation */
>  	struct percpu_cluster __percpu *percpu_cluster; /* per cpu's swap location */
>  	struct rb_root swap_extent_root;/* root of the swap extent rbtree */
>  	struct block_device *bdev;	/* swap device or bdev of swap file */
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 35be7a7271f4..9f1343b066c1 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -746,7 +746,16 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>  	 */
>  
>  	si->flags += SWP_SCANNING;
> -	scan_base = offset = si->cluster_next;
> +	/*
> +	 * Use percpu scan base for SSD to reduce lock contention on
> +	 * cluster and swap cache.  For HDD, sequential access is more
> +	 * important.
> +	 */
> +	if (si->flags & SWP_SOLIDSTATE)
> +		scan_base = this_cpu_read(*si->cluster_next_cpu);
> +	else
> +		scan_base = si->cluster_next;
> +	offset = scan_base;

Do we need to make SSD differ from spinning here?  Do bad things happen
if !SWP_SOLIDSTATE devices use the per-cpu cache?

>  	/* SSD algorithm */
>  	if (si->cluster_info) {
> @@ -835,7 +844,10 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>  	unlock_cluster(ci);
>  
>  	swap_range_alloc(si, offset, 1);
> -	si->cluster_next = offset + 1;
> +	if (si->flags & SWP_SOLIDSTATE)
> +		this_cpu_write(*si->cluster_next_cpu, offset + 1);
> +	else
> +		si->cluster_next = offset + 1;
>  	slots[n_ret++] = swp_entry(si->type, offset);
>  
>  	/* got enough slots or reach max slots? */
> @@ -2828,6 +2840,11 @@ static struct swap_info_struct *alloc_swap_info(void)
>  	p = kvzalloc(struct_size(p, avail_lists, nr_node_ids), GFP_KERNEL);
>  	if (!p)
>  		return ERR_PTR(-ENOMEM);
> +	p->cluster_next_cpu = alloc_percpu(unsigned int);
> +	if (!p->cluster_next_cpu) {
> +		kvfree(p);
> +		return ERR_PTR(-ENOMEM);
> +	}
>  
>  	spin_lock(&swap_lock);
>  	for (type = 0; type < nr_swapfiles; type++) {
> @@ -2962,6 +2979,8 @@ static unsigned long read_swap_header(struct swap_info_struct *p,
>  
>  	p->lowest_bit  = 1;
>  	p->cluster_next = 1;
> +	for_each_possible_cpu(i)
> +		per_cpu(*p->cluster_next_cpu, i) = 1;
>  	p->cluster_nr = 0;
>  
>  	maxpages = max_swapfile_size();
> @@ -3204,6 +3223,10 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  		 * SSD
>  		 */
>  		p->cluster_next = 1 + prandom_u32_max(p->highest_bit);

We shouldn't need to do this now?

> +		for_each_possible_cpu(cpu) {
> +			per_cpu(*p->cluster_next_cpu, cpu) =
> +				1 + prandom_u32_max(p->highest_bit);
> +		}

Would there be any benefit in spreading these out evenly?  Intervals of
(p->highest_bit/num_possible_cpus())?  That would reduce collisions,
but not for very long I guess.

Speaking of which, I wonder if there are failure modes in which all the
CPUs end up getting into sync.

And is it the case that if two or more CPUs have the same (or similar)
per_cpu(*p->cluster_next_cpu, cpu), they'll each end up pointlessly
scanning slots which another CPU has just scanned, thus rather
defeating the purpose of having the cluster_next cache?

IOW, should there be some additional collision avoidance scheme to
prevent a CPU from pointing its cluster_ext into a 64MB trunk which
another CPU is already using?

And should it really be a per-cpu thing?  That's rather arbitrary. 
Perhaps we would get better swap locality by making swap_cluster_next a
per-process (per-mm_struct) thing?

>  		nr_cluster = DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);
>  
>  		cluster_info = kvcalloc(nr_cluster, sizeof(*cluster_info),

