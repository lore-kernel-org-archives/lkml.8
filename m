Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D9BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F006D20787
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbgEZQkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 12:40:10 -0400
Received: from foss.arm.com ([217.140.110.172]:53528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728686AbgEZQkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:40:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6337930E;
        Tue, 26 May 2020 09:40:09 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FFD33F52E;
        Tue, 26 May 2020 09:40:08 -0700 (PDT)
References: <865de121-8190-5d30-ece5-3b097dc74431@kernel.dk>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] sched/fair: don't NUMA balance for kthreads
In-reply-to: <865de121-8190-5d30-ece5-3b097dc74431@kernel.dk>
Date:   Tue, 26 May 2020 17:40:06 +0100
Message-ID: <jhjpnaqtztl.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/05/20 16:38, Jens Axboe wrote:
> Stefano reported a crash with using SQPOLL with io_uring:
>
> BUG: kernel NULL pointer dereference, address: 00000000000003b0
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 800000046c042067 P4D 800000046c042067 PUD 461fcf067 PMD 0
> Oops: 0000 [#1] SMP PTI
> CPU: 2 PID: 1307 Comm: io_uring-sq Not tainted 5.7.0-rc7 #11
> Hardware name: Dell Inc. PowerEdge R430/03XKDV, BIOS 1.2.6 06/08/2015
> RIP: 0010:task_numa_work+0x4f/0x2c0
> Code: 18 4c 8b 25 e3 f0 8e 01 49 8b 9f 00 08 00 00 4d 8b af c8 00 00 00 49 39 c7 0f 85 e8 01 00 00 48 89 6d 00 41 f6 47 24 04 75 67 <48> 8b ab b0 03 00 00 48 85 ed 75 16 8b 3d 6f 68 94 01 e8 aa fb 04
> RSP: 0018:ffffaaa98415be10 EFLAGS: 00010246
> RAX: ffff953ee36b8000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000001 RSI: ffff953ee36b8000 RDI: ffff953ee36b8dc8
> RBP: ffff953ee36b8dc8 R08: 00000000001200db R09: ffff9542e3ad2e08
> R10: ffff9542ecd20070 R11: 0000000000000000 R12: 00000000fffca35b
> R13: 000000012a06a949 R14: ffff9542e3ad2c00 R15: ffff953ee36b8000
> FS:  0000000000000000(0000) GS:ffff953eefc40000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000000003b0 CR3: 000000046bbd0002 CR4: 00000000001606e0
> Call Trace:
>  task_work_run+0x68/0xa0
>  io_sq_thread+0x252/0x3d0
>  ? finish_wait+0x80/0x80
>  kthread+0xf9/0x130
>  ? __ia32_sys_io_uring_enter+0x370/0x370
>  ? kthread_park+0x90/0x90
>  ret_from_fork+0x35/0x40
>
> which is task_numa_work() oopsing on current->mm being NULL. The task
> work is queued by task_tick_numa(), which checks if current->mm is NULL
> at the time of the call. But this state isn't necessarily persistent,
> if the kthread is using use_mm() to temporarily adopt the mm of a task.
>
> Change the task_tick_numa() check to exclude kernel threads in general,
> as it doesn't make sense to attempt ot balance for kthreads anyway.
>

Does it? (this isn't a rethorical question)

Suppose a given kthread ends up doing more accesses to some pages
(via use_mm()) than the other threads that access them, wouldn't it make
sense to take that into account when it comes to NUMA balancing?

AFAIA that's not something that really happens in the wild, and as you
say we don't have a (guaranteed) persistent state to work with in those
cases, so it's more of a pipe dream. With that in mind, I think the
proposed change is fine.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

> Reported-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>
> ---
>
> This should go into 5.7 imho
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 02f323b85b6d..403556fc16d4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2908,7 +2908,7 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
>       /*
>        * We don't care about NUMA placement if we don't have memory.
>        */
> -	if (!curr->mm || (curr->flags & PF_EXITING) || work->next != work)
> +	if ((curr->flags & (PF_EXITING | PF_KTHREAD)) || work->next != work)
>               return;
>
>       /*
