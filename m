Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E487AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 23:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF5C82084C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 23:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgEZXms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 19:42:48 -0400
Received: from foss.arm.com ([217.140.110.172]:58706 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbgEZXmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 19:42:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 231AB1FB;
        Tue, 26 May 2020 16:42:47 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 426523F52E;
        Tue, 26 May 2020 16:42:46 -0700 (PDT)
References: <865de121-8190-5d30-ece5-3b097dc74431@kernel.dk> <jhjpnaqtztl.mognet@arm.com> <20200526200015.GG325280@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] sched/fair: don't NUMA balance for kthreads
In-reply-to: <20200526200015.GG325280@hirez.programming.kicks-ass.net>
Date:   Wed, 27 May 2020 00:42:40 +0100
Message-ID: <jhjlfletg9b.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/05/20 21:00, Peter Zijlstra wrote:
> On Tue, May 26, 2020 at 05:40:06PM +0100, Valentin Schneider wrote:
>
>> > Change the task_tick_numa() check to exclude kernel threads in general,
>> > as it doesn't make sense to attempt ot balance for kthreads anyway.
>> >
>>
>> Does it? (this isn't a rethorical question)
>>
>> Suppose a given kthread ends up doing more accesses to some pages
>> (via use_mm()) than the other threads that access them, wouldn't it make
>> sense to take that into account when it comes to NUMA balancing?
>
> Well, task_tick_numa() tries and farm off a bunch of actual work to
> task_work_add(), and there's so very little userspace for a kernel
> thread to return to... :-)

Err, true... I did say pipe dreams!

I had only really taken note of the exit / return to userspace
callbacks, but I see io_uring has its own task_work_run() calls, which
(I think) explains how we can end up with a kthread actually running
task_numa_work().

I'm also thinking we really don't want that task_numa_work() to be left
hanging on the task_work list, because that self-looping thing will not
play nice to whatever else has been queued (which AFAICT shouldn't happen
under normal conditions, i.e. !kthreads).
