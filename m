Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40489C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 01:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19BDE20714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 01:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgCZBvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 21:51:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:36255 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727574AbgCZBvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 21:51:51 -0400
IronPort-SDR: 6YGZ+OnztOR5GDP6cfIy7vG/V4LxI4+OUwT8mbZ+lHyfNYbCQUpEuJ1A5mkGutDjDksrJxwk0+
 xmRQZAJGa/lQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 18:51:51 -0700
IronPort-SDR: RoL9FbxYUrE29Kx3LWqaDonpYvGmVq/WGWi0Daqxn/LD2yrLFhrs2a9SZ3C8R/iTOwA8XgzzFj
 f1CZqqWGBncg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,306,1580803200"; 
   d="scan'208";a="357996141"
Received: from unknown (HELO [10.239.161.118]) ([10.239.161.118])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2020 18:51:48 -0700
Subject: Re: [PATCH] sched/fair: Don't pull task if local group is more loaded
 than busiest group
To:     Phil Auld <pauld@redhat.com>, Aubrey Li <aubrey.li@intel.com>
Cc:     vincent.guittot@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, tim.c.chen@linux.intel.com,
        vpillai@digitalocean.com, joel@joelfernandes.org
References: <1585140388-61802-1-git-send-email-aubrey.li@intel.com>
 <20200325134300.GA30416@lorien.usersys.redhat.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <9272cabe-a777-4e1f-762e-8022f8439c33@linux.intel.com>
Date:   Thu, 26 Mar 2020 09:51:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200325134300.GA30416@lorien.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/25 21:43, Phil Auld wrote:
> Hi Aubrey,
> 
> On Wed, Mar 25, 2020 at 08:46:28PM +0800 Aubrey Li wrote:
>> A huge number of load imbalance was observed when the local group
>> type is group_fully_busy, and the average load of local group is
>> greater than the selected busiest group, so the imbalance calculation
>> returns a negative value actually. Fix this problem by comparing the
>> average load before local group type check.
>>
>> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
>> ---
>>  kernel/sched/fair.c | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index c1217bf..c524369 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -8862,17 +8862,17 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>>  		goto out_balanced;
>>  
>>  	/*
>> +	 * If the local group is more loaded than the selected
>> +	 * busiest group don't try to pull any tasks.
>> +	 */
>> +	if (local->avg_load >= busiest->avg_load)
>> +		goto out_balanced;
>> +
>> +	/*
>>  	 * When groups are overloaded, use the avg_load to ensure fairness
>>  	 * between tasks.
>>  	 */
>>  	if (local->group_type == group_overloaded) {
>> -		/*
>> -		 * If the local group is more loaded than the selected
>> -		 * busiest group don't try to pull any tasks.
>> -		 */
>> -		if (local->avg_load >= busiest->avg_load)
>> -			goto out_balanced;
>> -
>>  		/* XXX broken for overlapping NUMA groups */
>>  		sds.avg_load = (sds.total_load * SCHED_CAPACITY_SCALE) /
>>  				sds.total_capacity;
>> -- 
>> 2.7.4
>>
> 
> I'm not sure about this. I think this patch will undo a good bit of the
> benefit of the load balancer rework.  Avg_load is really most useful
> when things are overloaded. If we go back to looking at it here we may
> fail to balance when needed.
> 
> There are cases where, due to group scheduler load scaling, local average
> may be higher but have spare CPUs still whereas busiest may have extra
> processes which be balanced.
> 
In my case, local group is fully busy, and the selected busiest group is overloaded,
should we compute avg_idle for group_fully_busy as well?

Thanks,
-Aubrey

