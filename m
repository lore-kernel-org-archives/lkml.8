Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCEFC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC5224654
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgBRQvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 11:51:01 -0500
Received: from foss.arm.com ([217.140.110.172]:55716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbgBRQvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 11:51:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DB5D30E;
        Tue, 18 Feb 2020 08:51:00 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CB1D3F703;
        Tue, 18 Feb 2020 08:50:58 -0800 (PST)
Subject: Re: [PATCH v2 2/5] sched/numa: Replace runnable_load_avg by load_avg
To:     Mel Gorman <mgorman@suse.de>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-kernel@vger.kernel.org, pauld@redhat.com,
        parth@linux.ibm.com, hdanton@sina.com
References: <20200214152729.6059-1-vincent.guittot@linaro.org>
 <20200214152729.6059-3-vincent.guittot@linaro.org>
 <b67ae78b-17ba-8f3f-9052-fecefb848e3d@arm.com>
 <20200218153801.GF3420@suse.de>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <e28bb567-dade-877b-f338-ce87e28cc02d@arm.com>
Date:   Tue, 18 Feb 2020 16:50:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218153801.GF3420@suse.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2020 15:38, Mel Gorman wrote:
>>
>> Could we reuse group_type instead? The definitions are the same modulo
>> s/group/node/.
>>
> 
> I kept the naming because there is the remote possibility that NUMA
> balancing will deviate in some fashion. Right now, it's harmless.
> 

Since it's just a subset ATM I'd go for the reuse and change that later if
shown a split is required, but fair enough.

> I didn't merge that part of the first version of my series. I was
> waiting to see how the implementation for allowing a small degree of
> imbalance looks like. If it's entirely confined in adjust_numa_balance
                                                     ^^^^^^^^^^^^^^^^^^^
Apologies if that's a newbie question, but I'm not familiar with that one.
Would that be added in your reconciliation series? I've only had a brief
look at it yet (it's next on the chopping block).

> then I'll create the common helper at the same time. For now, I left the
> possibility open that numa_classify would use something different than
> group_is_overloaded or group_has_capacity even if I find that hard to
> imagine at the moment.
> 
>> What I'm naively thinking here is that we could have either move the whole
>> thing to just sg_lb_stats (AFAICT the fields of numa_stats are a subset of it),
>> or if we really care about the stack we could tweak the ordering to ensure
>> we can cast one into the other (not too enticed by that one though).
>>
> 
> Yikes, no I'd rather not do that. Basically all I did before was create
> a common helper like __lb_has_capacity that only took basic types as
> parameters. group_has_capacity and numa_has_capacity were simple wrappers
> that read the correct fields from their respective stats structures.
> 

That's more sensible indeed. It'd definitely be nice to actually reconcile
the two balancers with these common helpers, though I guess it doesn't
*have* to happen with this very patch.
