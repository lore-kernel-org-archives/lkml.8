Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349A9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 14:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A8C222CA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 14:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgHGOOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 10:14:30 -0400
Received: from foss.arm.com ([217.140.110.172]:57330 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgHGOO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 10:14:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 399451FB;
        Fri,  7 Aug 2020 07:14:27 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FE113F7D7;
        Fri,  7 Aug 2020 07:14:20 -0700 (PDT)
Subject: Re: CFS flat runqueue proposal fixes/update
To:     Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Paul Turner <pjt@google.com>,
        "vincent.guittot" <vincent.guittot@linaro.org>, kernel-team@fb.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dietmar.eggeman" <dietmar.eggeman@arm.com>
References: <1609106d05a6a4a5938233e993548510f599d7d9.camel@surriel.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <1eaeeb1d-96c7-4819-8e1e-8f190a650030@arm.com>
Date:   Fri, 7 Aug 2020 16:14:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1609106d05a6a4a5938233e993548510f599d7d9.camel@surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik,

On 31/07/2020 09:42, Rik van Riel wrote:
> Hello,
> 
> last year at Linux Plumbers conference, I presented on my work
> of turning the hierarchical CFS runqueue into a flat runqueue,
> and Paul Turner pointed out some corner cases that could not
> work with my design as it was last year.
> 
> Paul pointed out two corner cases, and I have come up with a
> third one myself, but I believe they all revolve around the
> same issue, admission control, and can all be solved with the
> same solution.

[...]

>     Possible solution
> 
> A possible solution to the problems above consists of
> three parts:
> - Instead of accounting all used wall clock CPU time into
>   vruntime immediately, at the task's current hierarchical
>   priority, the vruntime can be accounted for piecemeal, for
>   example in amounts corresponding to "one timeslice at full
>   priority".
> - If there is only one runnable task on the runqueue,
>   all the runtime can be accounted into vruntime in one go.
> - Tasks that cannot account all of their used CPU time
>   into vruntime at once can be removed from the root runqueue,
>   and placed into the cgroup runqueue. A heap of cgroup
>   runqueues with "overloaded" tasks can be attached to the
>   main runqueue, where the left-most task from that heap of
>   heaps gets some vruntime accounted every time we go into
>   pick_next_task.
> - The difference between the vruntime of each task in that
>   heap and the vruntime of the root runqueue can help determine
>   how much vruntime can be accounted to that task at once.
> - If the task, or its runqueue, is no longer the left-most
>   in the heap after getting vruntime accounted, that runqueue
>   and the queue of runqueues can be resorted.
> - Once a task has accounted all of its outstanding delta
>   exec runtime into vruntime, it can be moved back to the
>   main runqueue.
> - This should solve the unequal task weight scenario Paul
>   Turner pointed out last year, because after task t1 goes
>   to sleep and only t2 and t3 remain on the CPU, t2 will
>   get its delta exec runtime converted into vruntime at
>   its new priority (equal to t3).
> - By only accounting delta exec runtime to vruntime for
>   the left-most task in the "overloaded" heap at one time,
>   we guarantee only one task at a time will be added back
>   into the root runqueue.
> - Every time a task is added to the root runqueue, that
>   slows down the rate at which vruntime advances, which
>   in turn reduces the rate at which tasks get added back
>   into the runqueue, and makes it more likely that a currently
>   running task with low hierarchical priority gets booted
>   off into the "overloaded" heap.
> 
> To tackle the thundering herd at task wakeup time, another
> strategy may be needed. One thing we may be able to do
> there is place tasks into the "overloaded" heap immediately
> on wakeup, if the hierarchical priority of the task is so
> low that if the task were to run a minimal timeslice length,
> it would be unable to account that time into its vruntime
> in one go, AND the CPU already has a larger number of tasks
> on it.
> 
> Because the common case on most systems is having just
> 0, 1, or 2 runnable tasks on a CPU, this fancy scheme
> should rarely end up being used, and even when it is the
> overhead should be reasonable because most of the
> overloaded tasks will just sit there until pick_next_task
> gets around to them.
> 
> Does this seem like something worth trying out?
> 
> Did I overlook any other corner cases that would make this
> approach unworkable?
> 
> Did I forget to explain anything that is needed to help
> understand the problem and the proposed solution better?

I imagine that I can see what you want to achieve here ;-)

But it's hard since your v5 RFC
https://lkml.kernel.org/r/20190906191237.27006-1-riel@surriel.com is
pretty old by now.

Do you have a version of the patch-set against tip/sched/core? Quite a
lot has changed (runnable load avg replaced by runnable avg, rq->load is
gone, CFS load balance rework).

IIRC, the 'CFS flat runqueue design' has the advantage to reduce the
overhead in taskgroup heavy environments like systemd. And I recall that
v5 doesn't cover CFS bandwidth control yet.

IMHO it would be extremely helpful to have a current patch-set to
discuss how these other problems can be covered by patches on top.
