Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A701C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC38206E9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504838AbgDPKZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 06:25:30 -0400
Received: from foss.arm.com ([217.140.110.172]:58462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504821AbgDPKYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 06:24:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A63C1C14;
        Thu, 16 Apr 2020 03:24:16 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 865253F73D;
        Thu, 16 Apr 2020 03:24:15 -0700 (PDT)
References: <20200415210512.805-1-valentin.schneider@arm.com> <20200415210512.805-7-valentin.schneider@arm.com> <CAKfTPtA5-S_EyzZMDMr9SuVQmWZNdLXOVSLMAMTD+6Bow4jJBQ@mail.gmail.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 6/9] sched: Kill select_task_rq()'s sd_flag parameter
In-reply-to: <CAKfTPtA5-S_EyzZMDMr9SuVQmWZNdLXOVSLMAMTD+6Bow4jJBQ@mail.gmail.com>
Date:   Thu, 16 Apr 2020 11:24:08 +0100
Message-ID: <jhj5zdzpw3b.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Vincent,

Thanks for taking a look at this.

On 16/04/20 08:42, Vincent Guittot wrote:
>> @@ -6622,13 +6622,25 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>>   * preempt must be disabled.
>>   */
>>  static int
>> -select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_flags)
>> +select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>>  {
>> +       int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
>>         struct sched_domain *tmp, *sd = NULL;
>>         int cpu = smp_processor_id();
>>         int new_cpu = prev_cpu;
>>         int want_affine = 0;
>> -       int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
>> +       int sd_flag;
>> +
>> +       switch (wake_flags & (WF_TTWU | WF_FORK | WF_EXEC)) {
>
> You remove a function parameter, which was directly set with the right
> flag, but then you add a switch case to recreate this sd_flag
> internally. Not sure we can say that it's real benefit
>

It is indeed the contentious point of this series (IMO). Still, it has a
few things going for it:

1) only CFS is helped by that extra parameter

2) with patch 9, I need a control flow to pick up the right cached pointer
   anyway; the alternative would be to do something like the unsavoury:

DEFINE_PER_CPU(struct sched_domain __rcu *, sd_balance_flags[3]);
...
update_top_cache_domain()
{
        per_cpu(sd_balance_flags[0], cpu) = highest_flag_domain(cpu, SD_BALANCE_EXEC);
        per_cpu(sd_balance_flags[1], cpu) = highest_flag_domain(cpu, SD_BALANCE_FORK);
        per_cpu(sd_balance_flags[2], cpu) = highest_flag_domain(cpu, SD_BALANCE_WAKE);
}
...
select_task_rq_fair()
{
        // Whatever sort of shady constant time conversion you can think of
        int index = !!(wake_flags & WF_FORK) + 2 * !!(wake_flags & WF_TTWU)
        sd_flag = SD_BALANCE_EXEC << index;
        sd = per_cpu(sd_balance_flags[index], cpu);
}

>> +       case WF_TTWU:
>> +               sd_flag = SD_BALANCE_WAKE;
>> +               break;
>> +       case WF_FORK:
>> +               sd_flag = SD_BALANCE_FORK;
>> +               break;
>> +       default:
>> +               sd_flag = SD_BALANCE_EXEC;
>> +       }
>>
>>         if (sd_flag & SD_BALANCE_WAKE) {
>>                 record_wakee(p);
