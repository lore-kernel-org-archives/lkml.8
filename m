Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872EAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F197207FB
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgETKaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 06:30:01 -0400
Received: from foss.arm.com ([217.140.110.172]:52518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgETKaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:30:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D4D831B;
        Wed, 20 May 2020 03:30:00 -0700 (PDT)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F6C53F68F;
        Wed, 20 May 2020 03:29:59 -0700 (PDT)
Subject: Re: [PATCH v2] sched/pelt: sync util/runnable_sum with PELT window
 when propagating
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200506155301.14288-1-vincent.guittot@linaro.org>
 <c1beb50b-d385-524b-56e0-eae16d3700df@arm.com>
 <CAKfTPtDLceotUW0ni=QhD9Z8cc7NA5Yz2vBJi+NjAVzYztrm+g@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <7be0258e-9799-f85c-39ce-738d6e6a82bd@arm.com>
Date:   Wed, 20 May 2020 12:29:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtDLceotUW0ni=QhD9Z8cc7NA5Yz2vBJi+NjAVzYztrm+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2020 17:41, Vincent Guittot wrote:
> On Tue, 19 May 2020 at 12:28, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 06/05/2020 17:53, Vincent Guittot wrote:

[...]

>>> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
>>> index b647d04d9c8b..1feff80e7e45 100644
>>> --- a/kernel/sched/pelt.c
>>> +++ b/kernel/sched/pelt.c
>>> @@ -237,6 +237,30 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
>>>       return 1;
>>>  }
>>>
>>> +/*
>>> + * When syncing *_avg with *_sum, we must take into account the current
>>> + * position in the PELT segment otherwise the remaining part of the segment
>>> + * will be considered as idle time whereas it's not yet elapsed and this will
>>> + * generate unwanted oscillation in the range [1002..1024[.
>>> + *
>>> + * The max value of *_sum varies with the position in the time segment and is
>>> + * equals to :
>>> + *
>>> + *   LOAD_AVG_MAX*y + sa->period_contrib
>>> + *
>>> + * which can be simplified into:
>>> + *
>>> + *   LOAD_AVG_MAX - 1024 + sa->period_contrib
>>> + *
>>> + * because LOAD_AVG_MAX*y == LOAD_AVG_MAX-1024
>>
>> Isn't this rather '~' instead of '==', even for y^32 = 0.5 ?
>>
>> 47742 * 0.5^(1/32) ~ 47742 - 1024
> 
> With integer precision and the runnable_avg_yN_inv array, you've got
> exactly 1024

Ah, OK, I forgot about this and that this is related to commit
625ed2bf049d ("sched/cfs: Make util/load_avg more stable").
