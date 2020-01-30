Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465A9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 15:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A82A2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 15:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgA3Pda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 10:33:30 -0500
Received: from foss.arm.com ([217.140.110.172]:54476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbgA3Pd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 10:33:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 838EB31B;
        Thu, 30 Jan 2020 07:33:27 -0800 (PST)
Received: from localhost (unknown [10.1.198.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24FC23F68E;
        Thu, 30 Jan 2020 07:33:27 -0800 (PST)
Date:   Thu, 30 Jan 2020 15:33:25 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com, mingo@redhat.com, ggherdovich@suse.cz,
        vincent.guittot@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v2 5/6] TEMP: sched: add interface for counter-based
 frequency invariance
Message-ID: <20200130153325.GA5208@arm.com>
References: <20191218182607.21607-1-ionela.voinescu@arm.com>
 <20191218182607.21607-6-ionela.voinescu@arm.com>
 <20200129193741.GU14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129193741.GU14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 Jan 2020 at 20:37:41 (+0100), Peter Zijlstra wrote:
> On Wed, Dec 18, 2019 at 06:26:06PM +0000, Ionela Voinescu wrote:
> > To be noted that this patch is a temporary one. It introduces the
> > interface added by the patches at [1] to allow update of the frequency
> > invariance scale factor based on counters. If [1] is merged there is
> > not need for this patch.
> > 
> > For platforms that support counters (x86 - APERF/MPERF, arm64 - AMU
> > counters) the frequency invariance correction factor can be obtained
> > using a core counter and a fixed counter to get information on the
> > performance (frequency based only) obtained in a period of time. This
> > will more accurately reflect the actual current frequency of the CPU,
> > compared with the alternative implementation that reflects the request
> > of a performance level from the OS through the cpufreq framework
> > (arch_set_freq_scale).
> > 
> > Therefore, introduce an interface - arch_scale_freq_tick, to be
> > implemented by each architecture and called for each CPU on the tick
> > to update the scale factor based on the delta in the counter values,
> > if counter support is present on the CPU.
> > 
> > Either because reading counters is expensive or because reading
> > counters from remote CPUs is not possible or is expensive, only
> > update the counter based frequency scale factor on the tick for
> > now. A tick based update will definitely be necessary either due to
> > it being the only point of update for certain architectures or in
> > order to cache the counter values for a particular CPU, if a
> > further update from that CPU is not possible.
> > 
> > [1]
> > https://lore.kernel.org/lkml/20191113124654.18122-1-ggherdovich@suse.cz/
> 
> FWIW, those patches just landed in tip/sched/core

Thanks, Peter, I'll drop this one next time around.

Ionela.
