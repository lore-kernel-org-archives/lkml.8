Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8882C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 05:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 786E420757
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 05:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgEVF6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 01:58:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:43232 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgEVF6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 01:58:43 -0400
IronPort-SDR: o9/cl5+7WQDF8B2+B+6LXdOmKufFGpVwlfMoOlYZ52vVTqr27QuDWJZexwwRa2BJqZiPIYlv6K
 lEuUXOyeMQJg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 22:58:43 -0700
IronPort-SDR: FnnWhX2QZNStnp4GwA81W75zcQbEaKamW4ev5n8+EPijJ9cfzSYmwGD/2I7th8MrZ9l78uH74g
 cvux58dsWFxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,420,1583222400"; 
   d="scan'208";a="440746731"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga005.jf.intel.com with ESMTP; 21 May 2020 22:58:40 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH -V2] swap: Reduce lock contention on swap cache from swap slots allocation
References: <20200520031502.175659-1-ying.huang@intel.com>
        <20200521133532.psckytr456eevs5j@ca-dmjordan1.us.oracle.com>
Date:   Fri, 22 May 2020 13:58:40 +0800
In-Reply-To: <20200521133532.psckytr456eevs5j@ca-dmjordan1.us.oracle.com>
        (Daniel Jordan's message of "Thu, 21 May 2020 09:35:32 -0400")
Message-ID: <877dx4ik8f.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jordan <daniel.m.jordan@oracle.com> writes:

> On Wed, May 20, 2020 at 11:15:02AM +0800, Huang Ying wrote:
>> @@ -2827,6 +2865,11 @@ static struct swap_info_struct *alloc_swap_info(void)
>>  	p = kvzalloc(struct_size(p, avail_lists, nr_node_ids), GFP_KERNEL);
>>  	if (!p)
>>  		return ERR_PTR(-ENOMEM);
>> +	p->cluster_next_cpu = alloc_percpu(unsigned int);
>> +	if (!p->cluster_next_cpu) {
>> +		kvfree(p);
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>
> There should be free_percpu()s at two places after this, but I think the
> allocation really belongs right...
>
>> @@ -3202,7 +3245,10 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>>  		 * select a random position to start with to help wear leveling
>>  		 * SSD
>>  		 */
>> -		p->cluster_next = 1 + prandom_u32_max(p->highest_bit);
>
> ...here because then it's only allocated when it's actually used.

Good catch!  And yes, this is the better place to allocate memory.  I
will fix this in the new version!  Thanks a lot!

Best Regards,
Huang, Ying

>> +		for_each_possible_cpu(cpu) {
>> +			per_cpu(*p->cluster_next_cpu, cpu) =
>> +				1 + prandom_u32_max(p->highest_bit);
>> +		}
>>  		nr_cluster = DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);
>>  
>>  		cluster_info = kvcalloc(nr_cluster, sizeof(*cluster_info),
>> -- 
>> 2.26.2
>> 
>> 
