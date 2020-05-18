Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4621DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 05:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2463D20787
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 05:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgERFwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 01:52:07 -0400
Received: from mga12.intel.com ([192.55.52.136]:42559 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbgERFwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 01:52:07 -0400
IronPort-SDR: PNiEZRthnm2EDBLk/CRIybnlAPIsip25/HIwc+JqYdO/qAwHnl/i/eWIpHGNUqpYYk1DdbCO5i
 zaAGd1slBSng==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2020 22:52:06 -0700
IronPort-SDR: D+dSoUyhUmyFRV/IPzHh1VOXow0IEGUBkZ8+MRit/jpG6AHogWlcqqkiSG1HL0CzTbgdZV1tUE
 KTuzngh4H5HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,406,1583222400"; 
   d="scan'208";a="439092916"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga005.jf.intel.com with ESMTP; 17 May 2020 22:52:04 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] swap: Add percpu cluster_next to reduce lock contention on swap cache
References: <20200514070424.16017-1-ying.huang@intel.com>
        <20200515151920.34f147b7b0baa3017cd7a2bb@linux-foundation.org>
Date:   Mon, 18 May 2020 13:52:03 +0800
In-Reply-To: <20200515151920.34f147b7b0baa3017cd7a2bb@linux-foundation.org>
        (Andrew Morton's message of "Fri, 15 May 2020 15:19:20 -0700")
Message-ID: <874ksdlri4.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew,

Andrew Morton <akpm@linux-foundation.org> writes:

> On Thu, 14 May 2020 15:04:24 +0800 Huang Ying <ying.huang@intel.com> wrote:
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 35be7a7271f4..9f1343b066c1 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -746,7 +746,16 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>>  	 */
>>  
>>  	si->flags += SWP_SCANNING;
>> -	scan_base = offset = si->cluster_next;
>> +	/*
>> +	 * Use percpu scan base for SSD to reduce lock contention on
>> +	 * cluster and swap cache.  For HDD, sequential access is more
>> +	 * important.
>> +	 */
>> +	if (si->flags & SWP_SOLIDSTATE)
>> +		scan_base = this_cpu_read(*si->cluster_next_cpu);
>> +	else
>> +		scan_base = si->cluster_next;
>> +	offset = scan_base;
>
> Do we need to make SSD differ from spinning here?  Do bad things happen
> if !SWP_SOLIDSTATE devices use the per-cpu cache?

I think the swapout throughput may be affected.  Because HDD seek is
necessary to swapout for multiple CPUs, if per-cpu cluster_next is used.
But I just realized that per-cpu swap slots cache will cause seek too.
If we really care about the performance to use HDD as swap, maybe we
should disable per-cpu swap slots cache for HDD too?

>>  	/* SSD algorithm */
>>  	if (si->cluster_info) {
>> @@ -835,7 +844,10 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>>  	unlock_cluster(ci);
>>  
>>  	swap_range_alloc(si, offset, 1);
>> -	si->cluster_next = offset + 1;
>> +	if (si->flags & SWP_SOLIDSTATE)
>> +		this_cpu_write(*si->cluster_next_cpu, offset + 1);
>> +	else
>> +		si->cluster_next = offset + 1;
>>  	slots[n_ret++] = swp_entry(si->type, offset);
>>  
>>  	/* got enough slots or reach max slots? */
>> @@ -2828,6 +2840,11 @@ static struct swap_info_struct *alloc_swap_info(void)
>>  	p = kvzalloc(struct_size(p, avail_lists, nr_node_ids), GFP_KERNEL);
>>  	if (!p)
>>  		return ERR_PTR(-ENOMEM);
>> +	p->cluster_next_cpu = alloc_percpu(unsigned int);
>> +	if (!p->cluster_next_cpu) {
>> +		kvfree(p);
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>>  
>>  	spin_lock(&swap_lock);
>>  	for (type = 0; type < nr_swapfiles; type++) {
>> @@ -2962,6 +2979,8 @@ static unsigned long read_swap_header(struct swap_info_struct *p,
>>  
>>  	p->lowest_bit  = 1;
>>  	p->cluster_next = 1;
>> +	for_each_possible_cpu(i)
>> +		per_cpu(*p->cluster_next_cpu, i) = 1;
>>  	p->cluster_nr = 0;
>>  
>>  	maxpages = max_swapfile_size();
>> @@ -3204,6 +3223,10 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>>  		 * SSD
>>  		 */
>>  		p->cluster_next = 1 + prandom_u32_max(p->highest_bit);
>
> We shouldn't need to do this now?

Yes.  Thanks for pointing this out.  Will delete this in the future
version.

>> +		for_each_possible_cpu(cpu) {
>> +			per_cpu(*p->cluster_next_cpu, cpu) =
>> +				1 + prandom_u32_max(p->highest_bit);
>> +		}
>
> Would there be any benefit in spreading these out evenly?  Intervals of
> (p->highest_bit/num_possible_cpus())?  That would reduce collisions,
> but not for very long I guess.

These may be spread more evenly with
(p->highest_bit/num_possible_cpus()).  I just worry about the possible
situation that num_possible_cpus() >> num_online_cpus().  Where current
method works better?

> Speaking of which, I wonder if there are failure modes in which all the
> CPUs end up getting into sync.
>
> And is it the case that if two or more CPUs have the same (or similar)
> per_cpu(*p->cluster_next_cpu, cpu), they'll each end up pointlessly
> scanning slots which another CPU has just scanned, thus rather
> defeating the purpose of having the cluster_next cache?
>
> IOW, should there be some additional collision avoidance scheme to
> prevent a CPU from pointing its cluster_ext into a 64MB trunk which
> another CPU is already using?

Yes.  That sounds reasonable.  How about something as below,

When per-cpu cluster_next is assigned, if the new value is in a
different 64MB (or larger) trunk of the old value, we will assign a
random value between p->lowest_bit and p->highest_bit to per-cpu
cluster_next.

This can reduce the possibility of collision to be almost 0 if there's
enough free swap slots.  And this is easy to be implemented, especially
considering the following situation,

  (p->highest_bit - p->lowest_bit) / 64MB < num_online_cpus()

> And should it really be a per-cpu thing?  That's rather arbitrary. 
> Perhaps we would get better swap locality by making swap_cluster_next a
> per-process (per-mm_struct) thing?

I think per-cpu is enough.  Because this is a scalability issue, as long
as we work on different 64MB trunks on different CPUs, the scalability
will be good.  I don't find there's any value to use differnt 64MB
trunks on a single CPU.

Best Regards,
Huang, Ying
