Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2849C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77C6921D6C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgIKQDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:03:12 -0400
Received: from foss.arm.com ([217.140.110.172]:37906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726580AbgIKQAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:00:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50DA5106F;
        Fri, 11 Sep 2020 06:48:54 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F41E53F73C;
        Fri, 11 Sep 2020 06:48:52 -0700 (PDT)
References: <20200911081745.214686199@infradead.org> <20200911082536.528661716@infradead.org> <jhjr1r85wye.mognet@arm.com> <20200911122922.GJ1362448@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     peterz@infradead.org
Cc:     mingo@kernel.org, vincent.guittot@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bristot@redhat.com, swood@redhat.com,
        Vincent Donnefort <Vincent.Donnefort@arm.com>
Subject: Re: [PATCH 2/2] sched/hotplug: Ensure only per-cpu kthreads run during hotplug
In-reply-to: <20200911122922.GJ1362448@hirez.programming.kicks-ass.net>
Date:   Fri, 11 Sep 2020 14:48:50 +0100
Message-ID: <jhjo8mc5sql.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/09/20 13:29, peterz@infradead.org wrote:
> On Fri, Sep 11, 2020 at 01:17:45PM +0100, Valentin Schneider wrote:
>
>> > @@ -6968,6 +7064,8 @@ int sched_cpu_deactivate(unsigned int cp
>> >        */
>> >       synchronize_rcu();
>> >
>> > +	balance_push_set(cpu, true);
>> > +
>>
>> IIUC this is going to make every subsequent finish_lock_switch()
>> migrate the switched-to task if it isn't a pcpu kthread. So this is going
>> to lead to a dance of
>>
>> switch_to(<task0>) -> switch_to(<stopper>) -> switch_to(<task1>) -> switch_to(<stopper>) ...
>>
>> Wouldn't it be better to batch all those in a migrate_tasks() sibling that
>> skips pcpu kthreads?
>
> That's 'difficult', this is hotplug, performance is not a consideration.
>

Aye aye.

The reason I'm trying to care about this is (don't wince too hard) for that
CPU pause thing [1]. Vincent's been the one doing all the actual work so I
should let him pitch in, but TL;DR if we could "relatively quickly" migrate
all !pcpu tasks after clearing the active bit, we could stop hotplug there
and have our "CPU pause" thing.

[1]: https://lwn.net/Articles/820825/

> Basically we don't have an iterator for the runqueues, so finding these
> tasks is hard.

Mmph right, we'd pretty much have to "enjoy" iterating & skipping pcpu
threads every __pick_migrate_task() call...
