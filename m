Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14010C2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF74F208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgDHPBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:01:52 -0400
Received: from foss.arm.com ([217.140.110.172]:39654 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727906AbgDHPBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:01:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E80431045;
        Wed,  8 Apr 2020 08:01:50 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAF5E3F68F;
        Wed,  8 Apr 2020 08:01:48 -0700 (PDT)
References: <20200408095012.3819-1-dietmar.eggemann@arm.com> <20200408095012.3819-3-dietmar.eggemann@arm.com> <jhjeesyw96u.mognet@arm.com> <20200408153032.447e098d@nowhere>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] sched/deadline: Improve admission control for asymmetric CPU capacities
In-reply-to: <20200408153032.447e098d@nowhere>
Date:   Wed, 08 Apr 2020 16:01:43 +0100
Message-ID: <jhjblo2vx60.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/04/20 14:30, luca abeni wrote:
>>
>> I don't think this is strictly equivalent to what we have now for the
>> SMP case. 'cpus' used to come from dl_bw_cpus(), which is an ugly way
>> of writing
>>
>>      cpumask_weight(rd->span AND cpu_active_mask);
>>
>> The rd->cpu_capacity_orig field you added gets set once per domain
>> rebuild, so it also happens in sched_cpu_(de)activate() but is
>> separate from touching cpu_active_mask. AFAICT this mean we can
>> observe a CPU as !active but still see its capacity_orig accounted in
>> a root_domain.
>
> Sorry, I suspect this is my fault, because the bug comes from my
> original patch.
> When I wrote the original code, I believed that when a CPU is
> deactivated it is also removed from its root domain.
>
> I now see that I was wrong.
>

Well it is indeed the case, but sadly it's not an atomic step - AFAICT with
cpusets we do hold some cpuset lock when calling __dl_overflow() and when
rebuilding the domains, but not when fiddling with the active mask.

I just realized it's even more obvious for dl_cpu_busy(): IIUC it is meant
to prevent the removal of a CPU if it would lead to a DL overflow - it
works now because the active mask is modified before it gets called, but
here it breaks because it's called before the sched_domain rebuild.

Perhaps re-computing the root domain capacity sum at every dl_bw_cpus()
call would be simpler. It's a bit more work, but then we already have a
for_each_cpu_*() loop, and we only rely on the masks being correct.

>
>                       Luca
