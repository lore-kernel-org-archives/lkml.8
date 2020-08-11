Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3599AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 12:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1406C2076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 12:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgHKMsR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 08:48:17 -0400
Received: from foss.arm.com ([217.140.110.172]:37270 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbgHKMsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 08:48:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B1E8D6E;
        Tue, 11 Aug 2020 05:48:16 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE0E53F575;
        Tue, 11 Aug 2020 05:48:14 -0700 (PDT)
References: <20200810010009.92758-1-arch0.zheng@gmail.com> <jhjwo26gxlb.mognet@arm.com> <9425382c-2a42-57ca-512d-c93c589dc701@gmail.com> <jhjv9hph3h7.mognet@arm.com> <01fe6a9b-fd3a-9b36-b2fa-6cea58415670@gmail.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Qi Zheng <arch0.zheng@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Remove the duplicate check from group_has_capacity()
In-reply-to: <01fe6a9b-fd3a-9b36-b2fa-6cea58415670@gmail.com>
Date:   Tue, 11 Aug 2020 13:48:09 +0100
Message-ID: <jhjtux9gxh2.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/08/20 12:44, Qi Zheng wrote:
> On 2020/8/11 下午6:38, Valentin Schneider wrote:
>>
>> On 11/08/20 04:39, Qi Zheng wrote:
>>> On 2020/8/11 上午2:33, Valentin Schneider wrote:
>>>>
>>>> On 10/08/20 02:00, Qi Zheng wrote:
>>>>> 1. The group_has_capacity() function is only called in
>>>>>      group_classify().
>>>>> 2. The following inequality has already been checked in
>>>>>      group_is_overloaded() which was also called in
>>>>>      group_classify().
>>>>>
>>>>>         (sgs->group_capacity * imbalance_pct) <
>>>>>                           (sgs->group_runnable * 100)
>>>>>
>>>>
>>>> Consider group_is_overloaded() returns false because of the first
>>>> condition:
>>>>
>>>>           if (sgs->sum_nr_running <= sgs->group_weight)
>>>>                   return false;
>>>>
>>>> then group_has_capacity() would be the first place where the group_runnable
>>>> vs group_capacity comparison would be done.
>>>>
>>>> Now in that specific case we'll actually only check it if
>>>>
>>>>     sgs->sum_nr_running == sgs->group_weight
>>>>
>>>> and the only case where the runnable vs capacity check can fail here is if
>>>> there's significant capacity pressure going on. TBH this capacity pressure
>>>> could be happening even when there are fewer tasks than CPUs, so I'm not
>>>> sure how intentional that corner case is.
>>>
>>> Maybe some cpus in sg->cpumask are no longer active at the == case,
>>> which causes the significant capacity pressure?
>>>
>>
>> That can only happen in that short window between deactivating a CPU and
>> not having rebuilt the sched_domains yet, which sounds quite elusive.
>>
>
> In fact, at the beginning, I added unlikely() here to hint the compiler:
>
> -	if ((sgs->group_capacity * imbalance_pct) <
> -			(sgs->group_runnable * 100))
> +	if (unlikely((sgs->group_capacity * imbalance_pct) <
> +			(sgs->group_runnable * 100)))
>
> The corresponding patch is as follows:
>
>       [PATCH]sched/core: add unlikely in group_has_capacity()
>
> Do you think it is necessary?

The "unlikely" approach has the benefit of keeping all corner cases in
place. I was tempted to say it could still make sense to get rid of the
extra check entirely, given that it has an impact only when:

- sum_nr_running == group_weight
- group capacity has been noticeably reduced

If sum_nr_running < group_weight, we won't evaluate it.
If sum_nr_running > group_weight, we either won't call into
  group_has_capacity() or we'll have checked it already in
  group_overloaded().

That said, it does make very much sense to check it in that ==
case. Vincent might have a different take on this, but right now I'd say
the unlikely approach is the safest one of the two.
