Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9053EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 05:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B6B02075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 05:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgE1Fco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 01:32:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:54187 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgE1Fco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 01:32:44 -0400
IronPort-SDR: LJS73g4EG92pLliactKOujehg4ZS5JpcVpX/5Ezug9iZyD8FyQp1iD+apQLdfaQmwiuyqfMoe7
 6IuG6NhFiYAA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 22:32:43 -0700
IronPort-SDR: bsfo8pNe49nYQ0/GNqtd3UEJUSoRZQDa1Pbp2efFOQ3mivCF3w9mSiPALYXhivu/kWEdUkT6Oc
 1E4/2DVdFfOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,443,1583222400"; 
   d="scan'208";a="291877792"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by fmsmga004.fm.intel.com with ESMTP; 27 May 2020 22:32:41 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH -V3] swap: Reduce lock contention on swap cache from swap slots allocation
References: <20200525002648.336325-1-ying.huang@intel.com>
        <20200528013724.flx6pwcmaazpek32@ca-dmjordan1.us.oracle.com>
Date:   Thu, 28 May 2020 13:32:40 +0800
In-Reply-To: <20200528013724.flx6pwcmaazpek32@ca-dmjordan1.us.oracle.com>
        (Daniel Jordan's message of "Wed, 27 May 2020 21:37:24 -0400")
Message-ID: <87h7w0hbev.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jordan <daniel.m.jordan@oracle.com> writes:

> On Mon, May 25, 2020 at 08:26:48AM +0800, Huang Ying wrote:
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 423c234aca15..0abd93d2a4fc 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -615,7 +615,8 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>>  			 * discarding, do discard now and reclaim them
>>  			 */
>>  			swap_do_scheduled_discard(si);
>> -			*scan_base = *offset = si->cluster_next;
>> +			*scan_base = this_cpu_read(*si->cluster_next_cpu);
>> +			*offset = *scan_base;
>>  			goto new_cluster;
>
> Why is this done?  As far as I can tell, the values always get overwritten at
> the end of the function with tmp and tmp isn't derived from them.  Seems
> ebc2a1a69111 moved some logic that used to make sense but doesn't have any
> effect now.

If we fail to allocate from cluster, "scan_base" and "offset" will not
be overridden.  And "cluster_next" or "cluster_next_cpu" may be changed
in swap_do_scheduled_discard(), because the lock is released and
re-acquired there.

The code may not have much value.  And you may think that it's better to
remove it.  But that should be in another patch.

>>  		} else
>>  			return false;
>> @@ -721,6 +722,34 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
>>  	}
>>  }
>>  
>> +static void set_cluster_next(struct swap_info_struct *si, unsigned long next)
>> +{
>> +	unsigned long prev;
>> +
>> +	if (!(si->flags & SWP_SOLIDSTATE)) {
>> +		si->cluster_next = next;
>> +		return;
>> +	}
>> +
>> +	prev = this_cpu_read(*si->cluster_next_cpu);
>> +	/*
>> +	 * Cross the swap address space size aligned trunk, choose
>> +	 * another trunk randomly to avoid lock contention on swap
>> +	 * address space if possible.
>> +	 */
>> +	if ((prev >> SWAP_ADDRESS_SPACE_SHIFT) !=
>> +	    (next >> SWAP_ADDRESS_SPACE_SHIFT)) {
>> +		/* No free swap slots available */
>> +		if (si->highest_bit <= si->lowest_bit)
>> +			return;
>> +		next = si->lowest_bit +
>> +			prandom_u32_max(si->highest_bit - si->lowest_bit + 1);
>> +		next = ALIGN(next, SWAP_ADDRESS_SPACE_PAGES);
>> +		next = max_t(unsigned int, next, si->lowest_bit);
>
> next is always greater than lowest_bit because it's aligned up.  I think the
> intent of the max_t line is to handle when next is aligned outside the valid
> range, so it'd have to be ALIGN_DOWN instead?

Oops.  I misunderstood "ALIGN()" here.  Yes.  we should use ALIGN_DOWN()
instead.  Thanks for pointing this out!

>
> These aside, patch looks good to me.

Thanks for your review!  It really help me to improve the quality of the
patch.  Can I add your "Reviewed-by" in the next version?

Best Regards,
Huang, Ying
