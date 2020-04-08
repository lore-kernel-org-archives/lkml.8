Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B136BC2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E52D20769
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgDHQbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 12:31:00 -0400
Received: from foss.arm.com ([217.140.110.172]:41190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbgDHQbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 12:31:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9057F30E;
        Wed,  8 Apr 2020 09:30:59 -0700 (PDT)
Received: from [192.168.1.19] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27A4A3F52E;
        Wed,  8 Apr 2020 09:30:55 -0700 (PDT)
Subject: Re: [PATCH 1/4] sched/topology: Store root domain CPU capacity sum
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200408095012.3819-1-dietmar.eggemann@arm.com>
 <20200408095012.3819-2-dietmar.eggemann@arm.com>
 <CAKfTPtC4_+dTddLdoFMdzUvsXwWyi3bUOXcg9kstC8RzZS_a+A@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <42cc3878-4c57-96ba-3ebd-1b4d4ef87fae@arm.com>
Date:   Wed, 8 Apr 2020 18:30:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtC4_+dTddLdoFMdzUvsXwWyi3bUOXcg9kstC8RzZS_a+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.04.20 14:29, Vincent Guittot wrote:
> On Wed, 8 Apr 2020 at 11:50, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:

[...]

>>  /**
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index 8344757bba6e..74b0c0fa4b1b 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -2052,12 +2052,17 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>>         /* Attach the domains */
>>         rcu_read_lock();
>>         for_each_cpu(i, cpu_map) {
>> +               unsigned long cap = arch_scale_cpu_capacity(i);
> 
> Why do you replace the use of rq->cpu_capacity_orig by
> arch_scale_cpu_capacity(i) ?
> There is nothing about this change in the commit message

True. And I can change this back.

It seems though that the solution is not sufficient because of the
'rd->span &nsub cpu_active_mask' issue discussed under patch 2/4.

But this remind me of another question I have.

Currently we use arch_scale_cpu_capacity() more often (16 times) than
capacity_orig_of()/rq->cpu_capacity_orig .

What's hindering us to remove rq->cpu_capacity_orig and the code around
it and solely rely on arch_scale_cpu_capacity()? I mean the arch
implementation should be fast.
