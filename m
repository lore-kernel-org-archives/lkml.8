Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E14DC28CBC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58C8F206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgD3OGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:06:31 -0400
Received: from foss.arm.com ([217.140.110.172]:55612 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728752AbgD3OGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:06:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CB241063;
        Thu, 30 Apr 2020 07:06:18 -0700 (PDT)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCE0E3F68F;
        Thu, 30 Apr 2020 07:06:16 -0700 (PDT)
Subject: Re: [PATCH 2/4] sched: set new prio after checking schedule policy
To:     Hillf Danton <hdanton@sina.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Phil Auld <pauld@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <20200424041832.11364-1-hdanton@sina.com>
 <20200424043650.14940-1-hdanton@sina.com>
 <20200430121301.3460-1-hdanton@sina.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <da5bf72d-1d50-5c5c-3bdb-113ed555dd10@arm.com>
Date:   Thu, 30 Apr 2020 16:06:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430121301.3460-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2020 14:13, Hillf Danton wrote:
> 
> On Tue, 28 Apr 2020 17:32:45 Valentin Schneider wrote:
>>
>>> +	else if (fair_policy(policy)) {
>>> +		if (attr->sched_nice < MIN_NICE ||
>>> +		    attr->sched_nice > MAX_NICE)
>>> +			return -EINVAL;
>>
>> We can't hit this with the syscall route, since we (silently) clamp those
>> values in sched_copy_attr(). setpriority() does the same. There's this
>> comment in sched_copy_attr() that asks whether we should clamp or return an
>> error; seems like the current consensus is on clamping, but then we might
>> want to get rid of that comment :)
>>
> Yes it's quite likely for me to miss the cases covered by that clamp;
> otherwise what is added does not break that consensus.
> 
>>> +		newprio = NICE_TO_PRIO(attr->sched_nice);
>>
>> This is new, however AFAICT it doesn't change anything for CFS (or about to
>> be) tasks since what matters is calling check_class_changed() further down.
> 
> Yes it's only used by rt_effective_prio(). 
> 

Looks like changing a SCHED_NORMAL to a SCHED_BATCH task will create a different
queue_flags value.

# chrt -p $$
pid 2803's current scheduling policy: SCHED_OTHER
pid 2803's current scheduling priority: 0

# chrt -b -p 0 $$

...
[bash 2803] policy=3 oldprio=120 newprio=[99->120] new_effective_prio=[99->120] queue_flags=[0xe->0xa]
[bash 2803] queued=0 running=0
...

But since in this example 'queued=0' it has no further effect here.

Why is SCHED_NORMAL/SCHED_BATCH (fair_policy()) now treated differently than SCHED_IDLE?

# chrt -i -p 0 $$

...
[bash 2803] policy=5 newprio=99 oldprio=120 new_effective_prio=99 queue_flags=0xe
[bash 2803] queued=0 running=0
...
