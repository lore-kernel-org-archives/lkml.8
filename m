Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB583C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC1EC2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410380AbgDOQmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:42:20 -0400
Received: from mail.sssup.it ([193.205.80.98]:20332 "EHLO mail.santannapisa.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404524AbgDOQmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:42:18 -0400
Received: from [151.41.75.232] (account l.abeni@santannapisa.it HELO sweethome)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 147390598; Wed, 15 Apr 2020 18:42:13 +0200
Date:   Wed, 15 Apr 2020 18:42:03 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] sched/deadline: Make DL capacity-aware
Message-ID: <20200415184203.50862783@sweethome>
In-Reply-To: <20200415132004.GF9767@localhost.localdomain>
References: <20200408095012.3819-1-dietmar.eggemann@arm.com>
        <20200408095012.3819-4-dietmar.eggemann@arm.com>
        <20200410125253.GE14300@localhost.localdomain>
        <f0e74500-77d7-a42c-410e-bc5d4d2ecdfb@arm.com>
        <20200415132004.GF9767@localhost.localdomain>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juri,

On Wed, 15 Apr 2020 15:20:04 +0200
Juri Lelli <juri.lelli@redhat.com> wrote:
[...]
> > > I'm thinking that, while dl_task_fits_capacity() works well when
> > > selecting idle cpus, in this case we should consider the fact
> > > that curr might be deadline as well and already consuming some of
> > > the rq capacity.
> > > 
> > > Do you think we should try to take that into account, maybe using
> > > dl_rq->this_bw ?  
> > 
> > So you're saying that cpudl_find(..., later_mask) could return 1 (w/
> > best_cpu (cp->elements[0].cpu) in later_mask).
> > 
> > And that this best_cpu could be a non-fitting CPU for p.
> > 
> > This could happen if cp->free_cpus is empty (no idle CPUs) so we
> > take cpudl_find()'s else path and in case p's deadline <
> > cp->elements[0] deadline.
> > 
> > We could condition the 'return 1' on best_cpu fitting p.
> > 
> > But should we do this for cpudl_find(..., NULL) calls from
> > check_preempt_equal_dl() as well or will this break GEDF?  
> 
> So, even by not returning best_cpu, as above, if it doesn't fit p's bw
> requirement, I think we would be breaking GEDF, which however doesn't
> take asym capacities into account.

Well, gEDF could take asymmetric capacities into account by scheduling
the earliest deadline task on the fastest CPU (and the task with the
second earliest deadline on the second fastest CPU, and so on...)

But this could cause a lot of unneeded migrations (I tried to discuss
this issue in a previous OSPM presentation). My original approach to
work around this issue was to schedule a task on the slowest core on
which the task can fit (some experiments revealed that this heuristic
can approximate the gEDF behaviour without causing too many
migrations)... But this patch is not included on the current patchset,
and will be proposed later, after the most important patches have been
merged.


> OTOH, if we let p migrate to a cpu
> that can't suit it, it will still be missing its deadlines (plus it
> would be causing deadline misses on the task that was running on
> best_cpu).

In theory, if the task is scheduled on a core that is too slow for it
then we must allow faster cores to pull it later (when tasks with
earlier deadlines block). But this might be problematic, because it can
require to migrate a currently scheduled task.


			Luca

> 
> check_preempt_equal_dl() worries me less, as it is there to service
> corner cases (hopefully not so frequent).
> 

