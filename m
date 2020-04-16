Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED21C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 993A1206E9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504872AbgDPK1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 06:27:09 -0400
Received: from foss.arm.com ([217.140.110.172]:58474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504822AbgDPKYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 06:24:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A030B1063;
        Thu, 16 Apr 2020 03:24:23 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D69EC3F73D;
        Thu, 16 Apr 2020 03:24:22 -0700 (PDT)
References: <20200415210512.805-1-valentin.schneider@arm.com> <20200415210512.805-10-valentin.schneider@arm.com> <CAKfTPtBDGzrvG=YhjBZBEgfx5EtM-rTC-dWX5phqh4bOY5XqgA@mail.gmail.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v3 9/9] sched/topology: Define and use shortcut pointers for wakeup sd_flag scan
In-reply-to: <CAKfTPtBDGzrvG=YhjBZBEgfx5EtM-rTC-dWX5phqh4bOY5XqgA@mail.gmail.com>
Date:   Thu, 16 Apr 2020 11:24:20 +0100
Message-ID: <jhj4ktjpw2z.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/04/20 08:46, Vincent Guittot wrote:
>> @@ -6657,7 +6646,19 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>>
>>         rcu_read_lock();
>>
>> -       sd = highest_flag_domain(cpu, sd_flag);
>> +       switch (wake_flags & (WF_TTWU | WF_FORK | WF_EXEC)) {
>> +       case WF_TTWU:
>> +               sd_flag = SD_BALANCE_WAKE;
>> +               sd = rcu_dereference(per_cpu(sd_balance_wake, cpu));
>
> It's worth having a direct pointer for the fast path which we always
> try to keep short but the other paths are already slow and will not
> get any benefit of this per cpu pointer.
> We should keep the loop for the slow paths
>

Which fast/slow paths are you referring to here? want_affine vs
!want_affine? If so, do you then mean that we should do the switch case
only when !want_affine, and otherwise look for the domain via the
for_each_domain() loop?

>> +               break;
>> +       case WF_FORK:
>> +               sd_flag = SD_BALANCE_FORK;
>> +               sd = rcu_dereference(per_cpu(sd_balance_fork, cpu));
>> +               break;
>> +       default:
>> +               sd_flag = SD_BALANCE_EXEC;
>> +               sd = rcu_dereference(per_cpu(sd_balance_exec, cpu));
>> +       }
>>
>>         /*
>>          * If !want_affine, we just look for the highest domain where
