Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30083C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1742A21D95
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506578AbgDPLpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:45:14 -0400
Received: from foss.arm.com ([217.140.110.172]:59306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2634046AbgDPLoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:44:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE53DC14;
        Thu, 16 Apr 2020 04:44:01 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A31B73F73D;
        Thu, 16 Apr 2020 04:44:00 -0700 (PDT)
References: <20200415210512.805-1-valentin.schneider@arm.com> <20200415210512.805-7-valentin.schneider@arm.com> <CAKfTPtA5-S_EyzZMDMr9SuVQmWZNdLXOVSLMAMTD+6Bow4jJBQ@mail.gmail.com> <20200416104725.GM20730@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 6/9] sched: Kill select_task_rq()'s sd_flag parameter
In-reply-to: <20200416104725.GM20730@hirez.programming.kicks-ass.net>
Date:   Thu, 16 Apr 2020 12:43:54 +0100
Message-ID: <jhjwo6f7j0l.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/04/20 11:47, Peter Zijlstra wrote:
> On Thu, Apr 16, 2020 at 09:42:36AM +0200, Vincent Guittot wrote:
>> On Wed, 15 Apr 2020 at 23:05, Valentin Schneider
>> > @@ -6622,13 +6622,25 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>> >   * preempt must be disabled.
>> >   */
>> >  static int
>> > +select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>> >  {
>> > +       int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
>> >         struct sched_domain *tmp, *sd = NULL;
>> >         int cpu = smp_processor_id();
>> >         int new_cpu = prev_cpu;
>> >         int want_affine = 0;
>> > -       int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
>> > +       int sd_flag;
>> > +
>> > +       switch (wake_flags & (WF_TTWU | WF_FORK | WF_EXEC)) {
>>
>> You remove a function parameter, which was directly set with the right
>> flag, but then you add a switch case to recreate this sd_flag
>> internally. Not sure we can say that it's real benefit
>>
>> > +       case WF_TTWU:
>> > +               sd_flag = SD_BALANCE_WAKE;
>> > +               break;
>> > +       case WF_FORK:
>> > +               sd_flag = SD_BALANCE_FORK;
>> > +               break;
>> > +       default:
>> > +               sd_flag = SD_BALANCE_EXEC;
>> > +       }
>
> Agreed, that's a bit yuck, how about something like so instead:
>

Aligning the SD_* and WF_* flags sure makes it simpler, I just wasn't
daring enough to do that. I suppose we'll want some BUILD_BUG_ON() checks
just for good measure.

Also, it doesn't directly solve the switch case of 9/9, but I may get out
of it with some hackery such as what I suggested in my reply to Vincent.

>
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -11,10 +11,12 @@
>   */
>  #ifdef CONFIG_SMP
>
> +/* First nibble of SD_flag is shared with WF_flag */
>  #define SD_BALANCE_NEWIDLE	0x0001	/* Balance when about to become idle */
>  #define SD_BALANCE_EXEC		0x0002	/* Balance on exec */
>  #define SD_BALANCE_FORK		0x0004	/* Balance on fork, clone */
>  #define SD_BALANCE_WAKE		0x0008  /* Balance on wakeup */
> +
>  #define SD_WAKE_AFFINE		0x0010	/* Wake task to waking CPU */
>  #define SD_ASYM_CPUCAPACITY	0x0020  /* Domain members have different CPU capacities */
>  #define SD_SHARE_CPUCAPACITY	0x0040	/* Domain members share CPU capacity */
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6635,16 +6635,8 @@ select_task_rq_fair(struct task_struct *
>       int want_affine = 0;
>       int sd_flag;
>
> -	switch (wake_flags & (WF_TTWU | WF_FORK | WF_EXEC)) {
> -	case WF_TTWU:
> -		sd_flag = SD_BALANCE_WAKE;
> -		break;
> -	case WF_FORK:
> -		sd_flag = SD_BALANCE_FORK;
> -		break;
> -	default:
> -		sd_flag = SD_BALANCE_EXEC;
> -	}
> +	/* SD_flags and WF_flags share the first nibble */
> +	sd_flag = wake_flags & 0xf;
>
>       if (sd_flag & SD_BALANCE_WAKE) {
>               record_wakee(p);
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1685,11 +1685,12 @@ static inline int task_on_rq_migrating(s
>  /*
>   * Wake flags
>   */
> -#define WF_SYNC			0x01		/* Waker goes to sleep after wakeup */
> -#define WF_TTWU                 0x02            /* Regular task wakeup */
> -#define WF_FORK			0x04		/* Child wakeup after fork */
> -#define WF_EXEC			0x08		/* "Fake" wakeup at exec */
> -#define WF_MIGRATED		0x10		/* Internal use, task got migrated */
> +#define WF_EXEC			0x02	/* SD_BALANCE_EXEC */
> +#define WF_FORK			0x04	/* SD_BALANCE_FORK */
> +#define WF_TTWU			0x08	/* SD_BALANCE_WAKE */
> +
> +#define WF_SYNC			0x10	/* Waker goes to sleep after wakeup */
> +#define WF_MIGRATED		0x20	/* Internal use, task got migrated */
>
>  /*
>   * To aid in avoiding the subversion of "niceness" due to uneven distribution
