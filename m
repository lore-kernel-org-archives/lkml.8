Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4F8C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B45C20780
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgDHOax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 10:30:53 -0400
Received: from mail.santannapisa.it ([193.205.80.98]:18167 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgDHOax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 10:30:53 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Apr 2020 10:30:52 EDT
Received: from [151.41.75.232] (account l.abeni@santannapisa.it HELO nowhere)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 147238791; Wed, 08 Apr 2020 15:30:48 +0200
Date:   Wed, 8 Apr 2020 15:30:32 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] sched/deadline: Improve admission control for
 asymmetric CPU capacities
Message-ID: <20200408153032.447e098d@nowhere>
In-Reply-To: <jhjeesyw96u.mognet@arm.com>
References: <20200408095012.3819-1-dietmar.eggemann@arm.com>
        <20200408095012.3819-3-dietmar.eggemann@arm.com>
        <jhjeesyw96u.mognet@arm.com>
Organization: Scuola Superiore S.Anna
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On Wed, 08 Apr 2020 11:42:14 +0100
Valentin Schneider <valentin.schneider@arm.com> wrote:

> On 08/04/20 10:50, Dietmar Eggemann wrote:
> > +++ b/kernel/sched/sched.h
> > @@ -304,11 +304,14 @@ void __dl_add(struct dl_bw *dl_b, u64 tsk_bw,
> > int cpus) __dl_update(dl_b, -((s32)tsk_bw / cpus));
> >  }
> >
> > +static inline unsigned long rd_capacity(int cpu);
> > +
> >  static inline
> > -bool __dl_overflow(struct dl_bw *dl_b, int cpus, u64 old_bw, u64
> > new_bw) +bool __dl_overflow(struct dl_bw *dl_b, int cpu, u64
> > old_bw, u64 new_bw) {
> >       return dl_b->bw != -1 &&
> > -	       dl_b->bw * cpus < dl_b->total_bw - old_bw + new_bw;
> > +	       cap_scale(dl_b->bw, rd_capacity(cpu)) <
> > +	       dl_b->total_bw - old_bw + new_bw;
> >  }
> >  
> 
> I don't think this is strictly equivalent to what we have now for the
> SMP case. 'cpus' used to come from dl_bw_cpus(), which is an ugly way
> of writing
> 
>      cpumask_weight(rd->span AND cpu_active_mask);
> 
> The rd->cpu_capacity_orig field you added gets set once per domain
> rebuild, so it also happens in sched_cpu_(de)activate() but is
> separate from touching cpu_active_mask. AFAICT this mean we can
> observe a CPU as !active but still see its capacity_orig accounted in
> a root_domain.

Sorry, I suspect this is my fault, because the bug comes from my
original patch.
When I wrote the original code, I believed that when a CPU is
deactivated it is also removed from its root domain.

I now see that I was wrong.


			Luca
