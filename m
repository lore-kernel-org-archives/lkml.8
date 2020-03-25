Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963B2C2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF9D206F6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgCYRyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:54:06 -0400
Received: from foss.arm.com ([217.140.110.172]:51654 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgCYRyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:54:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF43930E;
        Wed, 25 Mar 2020 10:54:05 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEAF03F52E;
        Wed, 25 Mar 2020 10:54:04 -0700 (PDT)
References: <20200324125533.17447-1-valentin.schneider@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        mgorman@techsingularity.net
Subject: Re: [PATCH] sched/topology: Fix overlapping sched_group build
Message-ID: <jhjeetgiamv.mognet@arm.com>
In-reply-to: <20200324125533.17447-1-valentin.schneider@arm.com>
Date:   Wed, 25 Mar 2020 17:53:56 +0000
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Mar 24 2020, Valentin Schneider wrote:
>  kernel/sched/topology.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 8344757bba6e..7033b27e5162 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -866,7 +866,7 @@ build_balance_mask(struct sched_domain *sd, struct sched_group *sg, struct cpuma
>                       continue;
>
>               /* If we would not end up here, we can't continue from here */
> -		if (!cpumask_equal(sg_span, sched_domain_span(sibling->child)))
> +		if (!cpumask_subset(sg_span, sched_domain_span(sibling->child)))

So this is one source of issues; what I've done here is a bit stupid
since we include CPUs that *cannot* end up there. What I should've done
is something like:

  cpumask_and(tmp, sched_domain_span(sibling->child), sched_domain_span(sd));
  if (!cpumask_equal(sg_span, tmp))
      ...

But even with that I just unfold even more horrors: this breaks the
overlapping sched_group_capacity (see 1676330ecfa8 ("sched/topology: Fix
overlapping sched_group_capacity")).

For instance, here I would have

  CPU0-domain2-group4: span=4-5
  CPU4-domain2-group4: span=4-7 mask=4-5

Both groups are at the same topology level and have the same first CPU,
so they point to the same sched_group_capacity structure - but they
don't have the same span. They would without my "fix", but then the
group spans are back to being wrong. I'm starting to think this is
doomed, at least in the current state of things :/
