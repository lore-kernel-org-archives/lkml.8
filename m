Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11264C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0347206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgDTPtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:49:35 -0400
Received: from foss.arm.com ([217.140.110.172]:51398 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbgDTPte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:49:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33DC131B;
        Mon, 20 Apr 2020 08:49:34 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19F7E3F73D;
        Mon, 20 Apr 2020 08:49:31 -0700 (PDT)
Date:   Mon, 20 Apr 2020 16:49:29 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        Paul Turner <pjt@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Josh Don <joshdon@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] cpumask: Convert cpumask_any_but() to the new random
 function
Message-ID: <20200420154929.taacfhjyeku4e5bx@e107158-lin.cambridge.arm.com>
References: <20200414150556.10920-1-qais.yousef@arm.com>
 <20200414150556.10920-4-qais.yousef@arm.com>
 <20200414122810.4b83ddd2@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200414122810.4b83ddd2@gandalf.local.home>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/14/20 12:28, Steven Rostedt wrote:
> On Tue, 14 Apr 2020 16:05:55 +0100
> Qais Yousef <qais.yousef@arm.com> wrote:
> 
> > +int cpumask_any_but(const struct cpumask *srcp, unsigned int cpu)
> > +{
> > +	unsigned int i;
> > +
> > +	cpumask_check(cpu);
> > +
> > +	for_each_cpu(i, srcp) {
> > +		i = cpumask_any(srcp);
> 
> Hmm, if the current CPU is the last CPU in the mask, and cpumask_any()
> happens to return it, what happens?

cpumask_any() will wrap.

> 
> > +		if (i != cpu)
> > +			return i;
> 
> We loop again, and wouldn't i being the last CPU in the mask cause this
> loop to exit, and return nr_cpu_ids?

No, because if we happen to start from the last cpu, on the next call, we'll
wrap again to the beginning.

But this implementation is crap indeed. No matter how unlikely, there's no
guarantee that for all the iters cpumask_any() will return a different cpu.
So if there are 3 cpus in the mask, cpumask_any() could potentially always
return 'cpu' if the planets aligned correctly.

I'll open code it instead to guarantee robustness.

Thanks!

--
Qais Yousef
