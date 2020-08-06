Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0F3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70EB423119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbgHFQs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:48:56 -0400
Received: from foss.arm.com ([217.140.110.172]:45200 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729098AbgHFQmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:42:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D93013D5;
        Thu,  6 Aug 2020 09:19:30 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D14B3F887;
        Thu,  6 Aug 2020 09:19:28 -0700 (PDT)
References: <20200731115502.12954-1-valentin.schneider@arm.com> <20200731115502.12954-4-valentin.schneider@arm.com> <20200806142025.GD2077896@gmail.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com
Subject: Re: [PATCH v4 03/10] sched/topology: Propagate SD_ASYM_CPUCAPACITY upwards
In-reply-to: <20200806142025.GD2077896@gmail.com>
Date:   Thu, 06 Aug 2020 17:19:26 +0100
Message-ID: <jhj5z9viw6p.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/08/20 15:20, Ingo Molnar wrote:
> * Valentin Schneider <valentin.schneider@arm.com> wrote:
>
>> We currently set this flag *only* on domains whose topology level exactly
>> match the level where we detect asymmetry (as returned by
>> asym_cpu_capacity_level()). This is rather problematic.
>>
>> Say there are two clusters in the system, one with a lone big CPU and the
>> other with a mix of big and LITTLE CPUs (as is allowed by DynamIQ):
>>
>> DIE [                ]
>> MC  [             ][ ]
>>      0   1   2   3  4
>>      L   L   B   B  B
>>
>> asym_cpu_capacity_level() will figure out that the MC level is the one
>> where all CPUs can see a CPU of max capacity, and we will thus set
>> SD_ASYM_CPUCAPACITY at MC level for all CPUs.
>>
>> That lone big CPU will degenerate its MC domain, since it would be alone in
>> there, and will end up with just a DIE domain. Since the flag was only set
>> at MC, this CPU ends up not seeing any SD with the flag set, which is
>> broken.
>>
>> Rather than clearing dflags at every topology level, clear it before
>> entering the topology level loop. This will properly propagate upwards
>> flags that are set starting from a certain level.
>>
>> Reviewed-by: Quentin Perret <qperret@google.com>
>> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
>> ---
>>  kernel/sched/topology.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index 865fff3ef20a..42b89668e1e4 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -1985,11 +1985,10 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>>      /* Set up domains for CPUs specified by the cpu_map: */
>>      for_each_cpu(i, cpu_map) {
>>              struct sched_domain_topology_level *tl;
>> +		int dflags = 0;
>>
>>              sd = NULL;
>>              for_each_sd_topology(tl) {
>> -			int dflags = 0;
>> -
>>                      if (tl == tl_asym) {
>>                              dflags |= SD_ASYM_CPUCAPACITY;
>>                              has_asym = true;
>
> I'd suggest ordering all patches with potential side effects at the
> end, to make them easier to bisect.
>
> I.e. I'd reorder this series to do:
>
>  - Obviously correct renamings & cleanups
>
>  - Convert the code over to the new instrumented sd-flags method. This
>    will presumably spew a few warnings for problems the new debugging
>    checks catch in existing topologies.
>
>  - Do all the behavioral changes and fixes like this patch, even if we
>    think that they have no serious side effects.
>
> In that sense it might make sense to order the two ARM patches to the
> later stage as well - but I suppose it's OK to do those two first as
> well.
>

This does sound sensible; I can shuffle this around for v5.

FWIW the reason I had this very patch before the instrumentation is that
IMO it really wants to be propagated and could thus directly be tagged with
SDF_SHARED_PARENT when the instrumentation hits. It's a minor thing, but
having it after the instrumentation means that I'll first have to tag it
without any hierarchical metaflag, and then tag it with SDF_SHARED_PARENT
in the propagation fix.

If that sounds fine by you, I'll do just that.

> Nice series otherwise, these new checks look really useful and already
> caught bugs.
>

Thanks!

> Thanks,
>
>       Ingo
