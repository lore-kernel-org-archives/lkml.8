Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD80C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2F1C208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbgEAQMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 12:12:18 -0400
Received: from foss.arm.com ([217.140.110.172]:43370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730082AbgEAQMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 12:12:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68B05C14;
        Fri,  1 May 2020 09:12:16 -0700 (PDT)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D71413F68F;
        Fri,  1 May 2020 09:12:13 -0700 (PDT)
Subject: Re: [PATCH v2 6/6] sched/deadline: Implement fallback mechanism for
 !fit case
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     luca abeni <luca.abeni@santannapisa.it>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
References: <20200427083709.30262-1-dietmar.eggemann@arm.com>
 <20200427083709.30262-7-dietmar.eggemann@arm.com>
 <20200427133438.GA6469@localhost.localdomain>
 <20200427161715.3dd3a148@nowhere>
 <57e4846a-4e54-5450-8167-768f021250f7@arm.com>
 <20200430110042.GD19464@codeaurora.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <ac602537-ab43-943e-9bd6-eca6ed5645c8@arm.com>
Date:   Fri, 1 May 2020 18:12:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430110042.GD19464@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2020 13:00, Pavan Kondeti wrote:
> On Wed, Apr 29, 2020 at 07:39:50PM +0200, Dietmar Eggemann wrote:
>> On 27/04/2020 16:17, luca abeni wrote:

[...]

>>> On Mon, 27 Apr 2020 15:34:38 +0200
>>> Juri Lelli <juri.lelli@redhat.com> wrote:

[...]

>>>> On 27/04/20 10:37, Dietmar Eggemann wrote:
>>>>> From: Luca Abeni <luca.abeni@santannapisa.it>

[...]

>>>>> -		if (!cpumask_empty(later_mask))
>>>>> -			return 1;
>>>>> +		if (cpumask_empty(later_mask))
>>>>> +			cpumask_set_cpu(max_cpu, later_mask);  
>>>>
>>>> Think we touched upon this during v1 review, but I'm (still?)
>>>> wondering if we can do a little better, still considering only free
>>>> cpus.
>>>>
>>>> Can't we get into a situation that some of the (once free) big cpus
>>>> have been occupied by small tasks and now a big task enters the
>>>> system and it only finds small cpus available, were it could have fit
>>>> into bigs if small tasks were put onto small cpus?
>>>>
>>>> I.e., shouldn't we always try to best fit among free cpus?
>>>
>>> Yes; there was an additional patch that tried schedule each task on the
>>> slowest core where it can fit, to address this issue.
>>> But I think it will go in a second round of patches.
>>
>> Yes, we can run into this situation in DL, but also in CFS or RT.
>>
> In CFS case, the misfit task handling in load balancer should help pulling
> the BIG task running on the little CPUs. I get your point that we can run
> into the same scenario with other scheduling class tasks.

Yes, the CPU stopper (i.e. CFS's active load balance) can help here.
IMHO, using the CPU stopper in RT/DL for moving the running task (next
to using best fit rather than just fit CPU) is considered future work.
AFAICS, push/pull is not designed for migration of running tasks.

[...]

>> You did spot the rt-app 'delay' for the small tasks in the test case ;-)
> 
> Thanks for the hint. It was not clear to me why 1 msec delay is given for
> the small tasks in the rt-app json description in the cover letter.
> I get it now :-)

So far Capacity awareness in RT/DL means that as long as there are CPUs
available which fit the task, use one of them. This is already
beneficial for a lot of use cases on CPU asymmetric systems since it
offers more predictable behavior.

I'll add a note to the cover letter in the next version about the reason
of the rt-app 'delay'.
