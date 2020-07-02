Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248F4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0439B20899
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbgGBObM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:31:12 -0400
Received: from foss.arm.com ([217.140.110.172]:57838 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728179AbgGBObL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:31:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3B2A31B;
        Thu,  2 Jul 2020 07:31:10 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB6913F68F;
        Thu,  2 Jul 2020 07:31:09 -0700 (PDT)
References: <20200701190656.10126-1-valentin.schneider@arm.com> <20200701190656.10126-3-valentin.schneider@arm.com> <20200702121536.GA765585@google.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com
Subject: Re: [PATCH v3 2/7] sched/topology: Define and assign sched_domain flag metadata
In-reply-to: <20200702121536.GA765585@google.com>
Date:   Thu, 02 Jul 2020 15:31:07 +0100
Message-ID: <jhjk0zm7zv8.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Quentin,

Thanks for having a look!

On 02/07/20 13:15, Quentin Perret wrote:
> Hey Valentin,
>
> On Wednesday 01 Jul 2020 at 20:06:50 (+0100), Valentin Schneider wrote:
>> +/*
>> + * Domain members have different CPU capacities
>> + *
>> + * SHARED_PARENT: Set from the topmost domain down to the first domain where
>> + * asymmetry is detected.
>> + */
>> +SD_FLAG(SD_ASYM_CPUCAPACITY,    5, SDF_SHARED_PARENT)
>
> Probably not a huge deal, but I don't think this is _exactly_ how
> SD_ASYM_CPUCAPACITY was defined originally, nor how the topology
> detection code deals with it (IIRC).
>
> That is, IIRC Morten defined SD_ASYM_CPUCAPACITY as the _lowest_ domain
> at which all CPU capacities are visible. On all real systems I can think
> of, this domain also happens to be the topmost domain, so that might not
> be a huge deal and we can probably change that definition to the one you
> suggest. But we should perhaps make the matching changes to
> asym_cpu_capacity_level()/build_sched_domains() if we're going down that
> path?
>

You're spot on, I was trying to sweep some of it under the carpet...

There an "interesting" quirk of asym_cpu_capacity_level() in that it does
something slightly different than what it says on the tin: it detects
the lowest topology level where *the biggest* CPU capacity is visible by
all CPUs. That works just fine on big.LITTLE, but there are questionable
DynamIQ topologies that could hit some issues.

Consider:

DIE [                   ]
MC  [             ][    ] <- sd_asym_cpucapacity
     0   1   2   3  4  5
     L   L   B   B  B  B

asym_cpu_capacity_level() would pick MC as the asymmetric topology level,
and you can argue either way: it should be DIE, because that's where CPUs 4
and 5 can see a LITTLE, or it should be MC, at least for CPUs 0-3 because
there they see all CPU capacities.

I have a plan on how to fix that, but I haven't been made aware of any
"real" topology that would seriously break there. The moment one does, this
will surface up to the top of my todo-list.

In the meantime, we can make it match the SDF_SHARED_PARENT semantics, and
this actually fixes an issue with solo big CPU clusters (which I
anecdotally found out while first writing this series, and forgot to
include):

--->8
From: Valentin Schneider <valentin.schneider@arm.com>
Date: Wed, 16 Oct 2019 18:12:12 +0100
Subject: [PATCH 1/1] sched/topology: Propagate SD_ASYM_CPUCAPACITY upwards

We currently set this flag *only* on domains whose topology level exactly
match the level where we detect asymmetry (as returned by
asym_cpu_capacity_level()). This is rather problematic.

Say there are two clusters in the system, one with a lone big CPU and the
other with a mix of big and LITTLE CPUs:

DIE [                ]
MC  [             ][ ]
     0   1   2   3  4
     L   L   B   B  B

asym_cpu_capacity_level() will figure out that the MC level is the one
where all CPUs can see a CPU of max capacity, and we will thus set
SD_ASYM_CPUCAPACITY at MC level for all CPUs.

That lone big CPU will degenerate its MC domain, since it would be alone in
there, and will end up with just a DIE domain. Since the flag was only set
at MC, this CPU ends up not seeing any SD with the flag set, which is
broken.

Rather than clearing dflags at every topology level, clear it before
entering the topology level loop. This will properly propagate upwards
flags that are set starting from a certain level.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/topology.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index b5667a273bf6..549268249645 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1965,11 +1965,10 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
        /* Set up domains for CPUs specified by the cpu_map: */
        for_each_cpu(i, cpu_map) {
                struct sched_domain_topology_level *tl;
+		int dflags = 0;

                sd = NULL;
                for_each_sd_topology(tl) {
-			int dflags = 0;
-
                        if (tl == tl_asym) {
                                dflags |= SD_ASYM_CPUCAPACITY;
                                has_asym = true;
--
2.27.0
