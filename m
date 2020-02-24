Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E761EC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45BC20828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgBXP5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:57:40 -0500
Received: from foss.arm.com ([217.140.110.172]:39180 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727693AbgBXP5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:57:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68E031FB;
        Mon, 24 Feb 2020 07:57:39 -0800 (PST)
Received: from [10.1.195.59] (ifrit.cambridge.arm.com [10.1.195.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E68813F703;
        Mon, 24 Feb 2020 07:57:37 -0800 (PST)
Subject: Re: [PATCH v3 4/5] sched/pelt: Add a new runnable average signal
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Hillf Danton <hdanton@sina.com>
References: <20200214152729.6059-5-vincent.guittot@linaro.org>
 <20200219125513.8953-1-vincent.guittot@linaro.org>
 <9fe822fc-c311-2b97-ae14-b9269dd99f1e@arm.com>
 <CAKfTPtD4kz07hikCuU2_cm67ntruopN9CdJEP+fg5L4_N=qEgg@mail.gmail.com>
 <d9f78b94-2455-e000-82bd-c00cfb9bbc8e@arm.com>
 <CAKfTPtAQ_09wVM7zjrHDB+gJXpb5OH6CBvfKC7OB_Bo0Hd41vA@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <e4def999-b784-6b26-3748-a2ad57f79c6d@arm.com>
Date:   Mon, 24 Feb 2020 15:57:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtAQ_09wVM7zjrHDB+gJXpb5OH6CBvfKC7OB_Bo0Hd41vA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I somehow lost track of that email, sorry for the delayed response.

On 2/21/20 8:56 AM, Vincent Guittot wrote:
> On Thu, 20 Feb 2020 at 17:11, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>>
>> On 20/02/2020 14:36, Vincent Guittot wrote:
>>> I agree that setting by default to SCHED_CAPACITY_SCALE is too much
>>> for little core.
>>> The problem for little core can be fixed by using the cpu capacity instead
>>>
>>
>> So that's indeed better for big.LITTLE & co. Any reason however for not
>> aligning with the initialization of util_avg ?
> 
> The runnable_avg is the unweighted version of the load_avg so they
> should both be sync at init and SCHED_CAPACITY_SCALE is in fact the
> right value. Using cpu_scale is the same for smp and big core so we
> can use it instead.
> 
> Then, the initial value of util_avg has never reflected some kind of
> realistic value for the utilization of a new task, especially if those
> tasks will become big ones. Runnable_avg now balances this effect to
> say that we don't know what will be the behavior of the new task,
> which might end up using all spare capacity although current
> utilization is low and CPU is not "fully used".

I'd argue that the init values we pick for either runnable_avg or util_avg
are both equally bogus.

> In fact, this is
> exactly the purpose of runnable: highlight that there is maybe no
> spare capacity even if CPU's utilization is low because of external
> event like task migration or having new tasks with most probably wrong
> utilization.
> 
> That being said, there is a bigger problem with the current version of
> this patch, which is that I forgot to use runnable in
> update_sg_wakeup_stats(). I have a patch that fixes this problem.
> 
> Also, I have tested both proposals with hackbench on my octo cores and
> using cpu_scale gives slightly better results than util_avg, which
> probably reflects the case I mentioned above.
> 
> grp     cpu_scale            util_avg               improvement
> 1       1,191(+/-0.77 %)     1,204(+/-1.16 %)       -1.07 %
> 4       1,147(+/-1.14 %)     1,195(+/-0.52 %)       -4.21 %
> 8       1,112(+/-1,52 %)     1,124(+/-1,45 %)       -1.12 %
> 16      1,163(+/-1.72 %)     1,169(+/-1.58 %)       -0,45 %
> 

Interesting, thanks for providing the numbers. I'd be curious to figure out
where the difference really stems from, but in the meantime consider me
convinced ;)
