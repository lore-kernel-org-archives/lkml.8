Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE451C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 314682224D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="nuKhZKT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgHFFcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 01:32:33 -0400
Received: from ozlabs.org ([203.11.71.1]:44255 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgHFFcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 01:32:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BMcZN6xgVz9sPC;
        Thu,  6 Aug 2020 15:32:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1596691950;
        bh=2HovLx+4ZKXsUcbswQosVHxHyh/z8bC5HwmMP+O52ws=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=nuKhZKT7SdhVCfPRS29PlgF8KGqa8Jl5TUpGzWocoNBFJg2UI7i3+c6p+Nt/lvFcg
         55NcaIMYrcOne+FfmfkWlOOl++uWtoClywpdNvGd6mIkWmV8XKK7f8ahUY7xTgZ0wB
         8EukT+ma+XCNS62QmD3n2dGispTyt7sJNWk7tfzAU6GSkhzmFSGcDtbyUs8fmz+huR
         m5roCMIzEvT2W7yNsNZeOoRDXCNvnre8Xr24kcAkJug4oD6h7/32HBz+L/KEvc07Bc
         xpH9jt1ErYAdmm+4xQ/gUW/Pw6v2txQIeZrFooGwZN5ky30xfGKwzSzb5qBhQK6flU
         Ph03wS4M5s1bQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     peterz@infradead.org, Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
Subject: Re: [PATCH 1/2] sched/topology: Allow archs to override cpu_smt_mask
In-Reply-To: <20200804124755.GJ2674@hirez.programming.kicks-ass.net>
References: <20200804033307.76111-1-srikar@linux.vnet.ibm.com> <20200804104520.GB2657@hirez.programming.kicks-ass.net> <20200804121007.GJ24375@linux.vnet.ibm.com> <20200804124755.GJ2674@hirez.programming.kicks-ass.net>
Date:   Thu, 06 Aug 2020 15:32:25 +1000
Message-ID: <87ft90z6dy.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

peterz@infradead.org writes:
> On Tue, Aug 04, 2020 at 05:40:07PM +0530, Srikar Dronamraju wrote:
>> * peterz@infradead.org <peterz@infradead.org> [2020-08-04 12:45:20]:
>> 
>> > On Tue, Aug 04, 2020 at 09:03:06AM +0530, Srikar Dronamraju wrote:
>> > > cpu_smt_mask tracks topology_sibling_cpumask. This would be good for
>> > > most architectures. One of the users of cpu_smt_mask(), would be to
>> > > identify idle-cores. On Power9, a pair of cores can be presented by the
>> > > firmware as a big-core for backward compatibility reasons.
>> > > 
>> > > In order to maintain userspace backward compatibility with previous
>> > > versions of processor, (since Power8 had SMT8 cores), Power9 onwards there
>> > > is option to the firmware to advertise a pair of SMT4 cores as a fused
>> > > cores (referred to as the big_core mode in the Linux Kernel). On Power9
>> > > this pair shares the L2 cache as well. However, from the scheduler's point
>> > > of view, a core should be determined by SMT4. The load-balancer already
>> > > does this. Hence allow PowerPc architecture to override the default
>> > > cpu_smt_mask() to point to the SMT4 cores in a big_core mode.
>> > 
>> > I'm utterly confused.
>> > 
>> > Why can't you set your regular siblings mask to the smt4 thing? Who
>> > cares about the compat stuff, I thought that was an LPAR/AIX thing.

To be clear this stuff is all for when we're running on the PowerVM machines,
ie. as LPARs.

That brings with it a bunch of problems, such as existing software that
has been developed/configured for Power8 and expects to see SMT8.

We also allow LPARs to be live migrated from Power8 to Power9 (and back), so
maintaining the illusion of SMT8 is considered a requirement to make that work.

>> There are no technical challenges to set the sibling mask to SMT4.
>> This is for Linux running on PowerVM. When these Power9 boxes are sold /
>> marketed as X core boxes (where X stand for SMT8 cores).  Since on PowerVM
>> world, everything is in SMT8 mode, the device tree properties still mark
>> the system to be running on 8 thread core. There are a number of utilities
>> like ppc64_cpu that directly read from device-tree. They would get core
>> count and thread count which is SMT8 based.
>> 
>> If the sibling_mask is set to small core, then same user when looking at
>
> FWIW, I find the small/big core naming utterly confusing vs the
> big/little naming from ARM. When you say small, I'm thinking of
> asymmetric cores, not SMT4/SMT8.

Yeah I agree the naming is confusing.

Let's call them "SMT4 cores" and "SMT8 cores"?

>> output from lscpu and other utilities that look at sysfs will start seeing
>> 2x number of cores to what he had provisioned and what the utilities from
>> the device-tree show. This can gets users confused.
>
> One will report SMT8 and the other SMT4, right? So only users that
> cannot read will be confused, but if you can't read, confusion is
> guaranteed anyway.

It's partly users, but also software that would see different values depending
on where it looks.

> Also, by exposing the true (SMT4) topology to userspace, userspace
> applications could behave better -- for those few that actually parse
> the topology information.

Agreed, though as you say there aren't that many that actually use the low-level
topology information.

>> So to keep the device-tree properties, utilities depending on device-tree,
>> sysfs and utilities depending on sysfs on the same page, userspace are only
>> exposed as SMT8.
>
> I'm not convinced it makes sense to lie to userspace just to accomodate
> a few users that cannot read.

The problem is we are already lying to userspace, because firmware lies to us.

ie. the firmware on these systems shows us an SMT8 core, and so current kernels
show SMT8 to userspace. I don't think we can realistically change that fact now,
as these systems are already out in the field.

What this patch tries to do is undo some of the mess, and at least give the
scheduler the right information.

cheers
