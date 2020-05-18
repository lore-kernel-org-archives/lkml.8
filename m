Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B81C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 545F520787
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgERGhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 02:37:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:57252 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbgERGhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 02:37:21 -0400
IronPort-SDR: 0cDlGCizinvq85BwuErtYEB130F1CbUyOeh74koeqgycWJ6i2GGelcgxgkGrDvxOTcBLUZl9la
 0JJWdbzrslFA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2020 23:37:18 -0700
IronPort-SDR: dpCEn2/CEfdq7JLlGLqBIU3s9FKn27G1l+TMNULeeekN2faht2pXRscQjyKsBGWi5quq+fBzGz
 KVpHNgLokB/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,406,1583222400"; 
   d="scan'208";a="465658851"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by fmsmga006.fm.intel.com with ESMTP; 17 May 2020 23:37:16 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] swap: Add percpu cluster_next to reduce lock contention on swap cache
References: <20200514070424.16017-1-ying.huang@intel.com>
        <20200515235140.xkznql332xmqvuf2@ca-dmjordan1.us.oracle.com>
Date:   Mon, 18 May 2020 14:37:15 +0800
In-Reply-To: <20200515235140.xkznql332xmqvuf2@ca-dmjordan1.us.oracle.com>
        (Daniel Jordan's message of "Fri, 15 May 2020 19:51:40 -0400")
Message-ID: <87zha5kauc.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jordan <daniel.m.jordan@oracle.com> writes:

> On Thu, May 14, 2020 at 03:04:24PM +0800, Huang Ying wrote:
>> And the pmbench score increases 15.9%.
>
> What metric is that, and how long did you run the benchmark for?

I run the benchmark for 1800s.  The metric comes from the following
output of the pmbench,

[1] Benchmark done - took 1800.088 sec for 122910000 page access

That is, the throughput is 122910000 / 1800.088 = 68280.0 (accesses/s).
Then we sum the values from the different processes.

> Given that this thing is probabilistic, did you notice much variance from run
> to run?

The results looks quite stable for me.  The standard deviation of
results run to run is less than 1% for me.

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
>>  
>>  	/* SSD algorithm */
>>  	if (si->cluster_info) {
>
> It's just a nit but SWP_SOLIDSTATE and 'if (si->cluster_info)' are two ways to
> check the same thing and I'd stick with the one that's already there.

Yes.  In effect, (si->flags & SWP_SOLIDSTATE) and (si->cluster_info)
always has same value at least for now.  But I don't think they are
exactly same in semantics.  So I would rather to use their exact
semantics.

>> @@ -2962,6 +2979,8 @@ static unsigned long read_swap_header(struct swap_info_struct *p,
>>  
>>  	p->lowest_bit  = 1;
>>  	p->cluster_next = 1;
>> +	for_each_possible_cpu(i)
>> +		per_cpu(*p->cluster_next_cpu, i) = 1;
>
> These are later overwritten if the device is an SSD which seems to be the only
> case where these are used, so why have this?

Yes.  You are right.  Will remove this in the future versions.

>>  	p->cluster_nr = 0;
>>  
>>  	maxpages = max_swapfile_size();
>> @@ -3204,6 +3223,10 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>>  		 * SSD
>>  		 */
>>  		p->cluster_next = 1 + prandom_u32_max(p->highest_bit);
>> +		for_each_possible_cpu(cpu) {
>> +			per_cpu(*p->cluster_next_cpu, cpu) =
>> +				1 + prandom_u32_max(p->highest_bit);
>> +		}
>
> Is there a reason for adding one?  The history didn't enlighten me about why
> cluster_next does it.

The first swap slot is the swap partition header, you cand find the
corresponding code in syscall swapon function, below comments "Read the
swap header.".

Best Regards,
Huang, Ying
