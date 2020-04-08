Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F97C2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50F320787
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgDHOXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 10:23:20 -0400
Received: from foss.arm.com ([217.140.110.172]:39236 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbgDHOXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 10:23:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98F3D30E;
        Wed,  8 Apr 2020 07:23:18 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E25F3F68F;
        Wed,  8 Apr 2020 07:23:16 -0700 (PDT)
Date:   Wed, 8 Apr 2020 15:23:14 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
Message-ID: <20200408142313.j6yfv6s3i5pzs5wv@e107158-lin.cambridge.arm.com>
References: <20200408095012.3819-1-dietmar.eggemann@arm.com>
 <20200408095012.3819-3-dietmar.eggemann@arm.com>
 <jhjeesyw96u.mognet@arm.com>
 <20200408153032.447e098d@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200408153032.447e098d@nowhere>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/20 15:30, luca abeni wrote:
> Hi Valentin,
> 
> On Wed, 08 Apr 2020 11:42:14 +0100
> Valentin Schneider <valentin.schneider@arm.com> wrote:
> 
> > On 08/04/20 10:50, Dietmar Eggemann wrote:
> > > +++ b/kernel/sched/sched.h
> > > @@ -304,11 +304,14 @@ void __dl_add(struct dl_bw *dl_b, u64 tsk_bw,
> > > int cpus) __dl_update(dl_b, -((s32)tsk_bw / cpus));
> > >  }
> > >
> > > +static inline unsigned long rd_capacity(int cpu);
> > > +
> > >  static inline
> > > -bool __dl_overflow(struct dl_bw *dl_b, int cpus, u64 old_bw, u64
> > > new_bw) +bool __dl_overflow(struct dl_bw *dl_b, int cpu, u64
> > > old_bw, u64 new_bw) {
> > >       return dl_b->bw != -1 &&
> > > -	       dl_b->bw * cpus < dl_b->total_bw - old_bw + new_bw;
> > > +	       cap_scale(dl_b->bw, rd_capacity(cpu)) <
> > > +	       dl_b->total_bw - old_bw + new_bw;
> > >  }
> > >  
> > 
> > I don't think this is strictly equivalent to what we have now for the
> > SMP case. 'cpus' used to come from dl_bw_cpus(), which is an ugly way
> > of writing
> > 
> >      cpumask_weight(rd->span AND cpu_active_mask);
> > 
> > The rd->cpu_capacity_orig field you added gets set once per domain
> > rebuild, so it also happens in sched_cpu_(de)activate() but is
> > separate from touching cpu_active_mask. AFAICT this mean we can
> > observe a CPU as !active but still see its capacity_orig accounted in
> > a root_domain.
> 
> Sorry, I suspect this is my fault, because the bug comes from my
> original patch.
> When I wrote the original code, I believed that when a CPU is
> deactivated it is also removed from its root domain.
> 
> I now see that I was wrong.

Shouldn't rd->online be equivalent to (rd->span & cpu-active_mask)?

--
Qais Yousef
