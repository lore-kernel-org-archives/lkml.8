Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05109C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEB6A2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439452AbgDNLkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 07:40:45 -0400
Received: from foss.arm.com ([217.140.110.172]:53594 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729851AbgDNLkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 07:40:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9D7E1FB;
        Tue, 14 Apr 2020 04:40:36 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD4743F6C4;
        Tue, 14 Apr 2020 04:40:34 -0700 (PDT)
Date:   Tue, 14 Apr 2020 12:40:32 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        luca abeni <luca.abeni@santannapisa.it>,
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] sched/deadline: Improve admission control for
 asymmetric CPU capacities
Message-ID: <20200414114032.wigdlnegism6qqns@e107158-lin.cambridge.arm.com>
References: <20200408095012.3819-1-dietmar.eggemann@arm.com>
 <20200408095012.3819-3-dietmar.eggemann@arm.com>
 <jhjeesyw96u.mognet@arm.com>
 <20200408153032.447e098d@nowhere>
 <jhjblo2vx60.mognet@arm.com>
 <31620965-e1e7-6854-ad46-8192ee4b41af@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <31620965-e1e7-6854-ad46-8192ee4b41af@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/20 19:29, Dietmar Eggemann wrote:

[...]

> Maybe we can do a hybrid. We have rd->span and rd->sum_cpu_capacity and
> with the help of an extra per-cpu cpumask we could just
> 
> DEFINE_PER_CPU(cpumask_var_t, dl_bw_mask);
> 
> dl_bw_cpus(int i) {
> 
>     struct cpumask *cpus = this_cpu_cpumask_var_ptr(dl_bw_mask);
>     ...
>     cpumask_and(cpus, rd->span, cpu_active_mask);
> 
>     return cpumask_weight(cpus);
> }
> 
> and
> 
> dl_bw_capacity(int i) {
> 
>     struct cpumask *cpus = this_cpu_cpumask_var_ptr(dl_bw_mask);
>     ...
>     cpumask_and(cpus, rd->span, cpu_active_mask);
>     if (cpumask_equal(cpus, rd->span))
>         return rd->sum_cpu_capacity;
> 
>     for_each_cpu(i, cpus)
>         cap += capacity_orig_of(i);
> 
>     return cap;
> }
> 
> So only in cases in which rd->span and cpu_active_mask differ we would
> have to sum up again.

I haven't followed this discussion closely, so I could be missing something
here.

In sched_cpu_dying() we call set_rq_offline() which clears the cpu in
rq->rd->online.

So the way I read the code

	rd->online = cpumask_and(rd->span, cpu_active_mask)

But I could have easily missed some detail.

Regardless, it seems to me that DL is working around something not right in the
definition of rd->span or using the wrong variable.

My 2p :-). I have to go back and read the discussion in more detail.

Thanks

--
Qais Yousef
