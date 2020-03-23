Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF48C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A599920735
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgCWNaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:30:19 -0400
Received: from foss.arm.com ([217.140.110.172]:49042 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728355AbgCWNaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:30:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E36881FB;
        Mon, 23 Mar 2020 06:30:18 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07D413F52E;
        Mon, 23 Mar 2020 06:30:17 -0700 (PDT)
References: <20200320151245.21152-1-mgorman@techsingularity.net> <20200320151245.21152-2-mgorman@techsingularity.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] sched/fair: Track efficiency of select_idle_sibling
In-reply-to: <20200320151245.21152-2-mgorman@techsingularity.net>
Date:   Mon, 23 Mar 2020 13:30:10 +0000
Message-ID: <jhj369zmc65.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mel,

On Fri, Mar 20 2020, Mel Gorman wrote:
> SIS Search: Number of calls to select_idle_sibling
>
> SIS Domain Search: Number of times the domain was searched because the
>       fast path failed.
>
> SIS Scanned: Generally the number of runqueues scanned but the fast
>       path counts as 1 regardless of the values for target, prev
>       and recent.
>
> SIS Domain Scanned: Number of runqueues scanned during a search of the
>       LLC domain.
>
> SIS Failures: Number of SIS calls that failed to find an idle CPU
>

Let me put my changelog pedant hat on; it would be nice to explicitely
separate the 'raw' stats (i.e. those that you are adding to sis()) to
the downstream ones.

AIUI the ones above here are the 'raw' stats (except "SIS Domain
Scanned", I'm not sure I get where this one comes from?), and the ones
below are the downstream, post-processed ones.

> SIS Search Efficiency: A ratio expressed as a percentage of runqueues
>       scanned versus idle CPUs found. A 100% efficiency indicates that
>       the target, prev or recent CPU of a task was idle at wakeup. The
>       lower the efficiency, the more runqueues were scanned before an
>       idle CPU was found.
>
> SIS Domain Search Efficiency: Similar, except only for the slower SIS
>       patch.
>
> SIS Fast Success Rate: Percentage of SIS that used target, prev or
>       recent CPUs.
>
> SIS Success rate: Percentage of scans that found an idle CPU.
>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

With the nits taken into account:

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1dea8554ead0..9d32a81ece08 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6150,6 +6153,15 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>       struct sched_domain *sd;
>       int i, recent_used_cpu;
>
> +	schedstat_inc(this_rq()->sis_search);
> +
> +	/*
> +	 * Checking if prev, target and recent is treated as one scan. A
> +	 * perfect hit on one of those is considered 100% efficiency.
> +	 * Further scanning impairs efficiency.
> +	 */
> +	schedstat_inc(this_rq()->sis_scanned);
> +

You may want to move that sis_scanned increment to below the 'symmetric'
label. Also, you should instrument select_idle_capacity() with
sis_scanned increments, if only for the sake of completeness.

One last thing: each of the new schedstat_inc() callsites use this_rq();
IIRC because of the RELOC_HIDE() hiding underneath there's very little
chance of the compiler caching this. However, this depends on schedstat,
so I suppose that is fine.

>       /*
>        * For asymmetric CPU capacity systems, our domain of interest is
>        * sd_asym_cpucapacity rather than sd_llc.
