Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152A1C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE5002065E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgGPQs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:48:56 -0400
Received: from foss.arm.com ([217.140.110.172]:47596 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgGPQs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 12:48:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83F9630E;
        Thu, 16 Jul 2020 09:48:55 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A5EC3F68F;
        Thu, 16 Jul 2020 09:48:53 -0700 (PDT)
Subject: Re: [SchedulerWakeupLatency] Per-task vruntime wakeup bonus
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Josef Bacik <jbacik@fb.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Parth Shah <parth@linux.ibm.com>
References: <87v9kv2545.derkling@matbug.com> <87h7wd15v2.derkling@matbug.net>
 <87imgrlrqi.derkling@matbug.net> <87mu5sqwkt.derkling@matbug.net>
 <87eer42clt.derkling@matbug.net> <87imfi2qbk.derkling@matbug.net>
 <87blla2pdt.derkling@matbug.net>
 <CAKfTPtBHmP6BOrx6XGqZ7UpCFxWCZz23KWf4DXtAhRGUPfjebA@mail.gmail.com>
 <878sfrywd8.derkling@matbug.net>
 <CAKfTPtAWgWZMx4GA_N0j1jxXRtDDdo9yix7mOBZ_zdsRrqJA8Q@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <46c7f966-6679-bb9e-dabe-bb385298d19b@arm.com>
Date:   Thu, 16 Jul 2020 18:48:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtAWgWZMx4GA_N0j1jxXRtDDdo9yix7mOBZ_zdsRrqJA8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2020 14:59, Vincent Guittot wrote:
> On Fri, 10 Jul 2020 at 21:59, Patrick Bellasi
> <patrick.bellasi@matbug.net> wrote:
>>
>>
>> On Fri, Jul 10, 2020 at 15:21:48 +0200, Vincent Guittot <vincent.guittot@linaro.org> wrote...

[...]

>>> Instead, it should weight the decision in wakeup_preempt_entity() and
>>> wakeup_gran()
>>
>> In those functions we already take the task prio into consideration
>> (ref details at the end of this message).
>>
>> Lower nice value tasks have more chances to preempt current since they
>> will have a smaller wakeup_gran, indeed:
> 
> yes, and this is there to ensure a fair distribution of running time
> and prevent a task to increase significantly its vruntime compare to
> others
> 
> -1 min that se already got more runtime than current
> 0 that se's vruntime will go above current's vruntime after a runtime
> duration of  sched_min_granularity
> and 1 means that se got less runtime than current and its vruntime
> will still be lower than current ones even after a runtime duration of
> sched_min_granularity
> 
> IMHO, latency_nice should impact the decision only for case 0 but not
> the case -1 and 1.
> That being said, we can extend the case 0 a bit to include the
> situation where current's vruntime will become greater than se's
> vruntimes after a runtime duration of  sched_min_granularity like
> below:
> 
>                                                            curr->vruntime
>                                           |<-- wakeup_gran(se) -->|<--
> wakeupgran(curr) -->|
> current range: se->vruntime          +1   |        0              |    -1
> new range:     se->vruntime          +1   |                       0
>                     |   -1
> 

I assume this got messed up by line break somehow:

                                                   curr->vruntime
                                 |<-- wakeup_gran(se) -->|<-- wakeup_gran(curr) -->|
current range: se->vruntime  +1  |        0              |    -1
new range:     se->vruntime  +1  |                       0                         | -1

IMHO, with the current use of wakeup_preempt_entity() I don't see what
will change with that.
We check 'wakeup_preempt_entity() == 1' in check_preempt_wakeup() and 
'wakeup_preempt_entity() < 1' in pick_next_entity().

How should the mapping between se's latency_nice value to the consideration of
wakeup_gran(curr) look like?

[...]
