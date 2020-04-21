Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1D2C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97167206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgDUOZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:25:58 -0400
Received: from foss.arm.com ([217.140.110.172]:35814 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbgDUOZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:25:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2656131B;
        Tue, 21 Apr 2020 07:25:56 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A84FA3F68F;
        Tue, 21 Apr 2020 07:25:53 -0700 (PDT)
Date:   Tue, 21 Apr 2020 15:25:51 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        Paul Turner <pjt@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Josh Don <joshdon@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/4] sched/rt: Distribute tasks in find_lowest_rq()
Message-ID: <20200421142551.hadvuw65vshzp6fe@e107158-lin.cambridge.arm.com>
References: <20200414150556.10920-1-qais.yousef@arm.com>
 <jhjh7xlvqqe.mognet@arm.com>
 <20200421121305.ziu3dfqwo7cw6ymu@e107158-lin.cambridge.arm.com>
 <jhjv9ltkmel.mognet@arm.com>
 <CAKfTPtB9gYh_7qV0y_t7HRg7HOpYfkJ96fXCYFFTBmcJxnnXEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtB9gYh_7qV0y_t7HRg7HOpYfkJ96fXCYFFTBmcJxnnXEA@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/21/20 15:28, Vincent Guittot wrote:
> On Tue, 21 Apr 2020 at 15:18, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
> >
> >
> > On 21/04/20 13:13, Qais Yousef wrote:
> > > On 04/14/20 19:58, Valentin Schneider wrote:
> > >>
> > >> I'm a bit wary about such blanket changes. I feel like most places impacted
> > >> by this change don't gain anything by using the random thing. In sched land
> > >> that would be:
> > >
> > > The API has always been clear that cpumask_any return a random cpu within the
> > > mask. And the fact it's a one liner with cpumask_first() directly visible,
> > > a user made the choice to stick to cpumask_any() indicates that that's what
> > > they wanted.
> > >
> > > Probably a lot of them they don't care what cpu is returned and happy with the
> > > random value. I don't see why it has to have an effect. Some could benefit,
> > > like my use case here. Or others truly don't care, then it's fine to return
> > > anything, as requested.
> > >
> >
> > Exactly, *some* (which AFAICT is a minority) might benefit. So why should
> > all the others pay the price for a functionality they do not need?
> >
> > I don't think your change would actually cause a splat somewhere; my point
> > is about changing existing behaviour without having a story for it. The
> > thing said 'pick a "random" cpu', sure, but it never did that, it always
> > picked the first.
> >
> > I've pointed out two examples that want to be cpumask_first(), and I'm
> > absolutely certain there are more than these two out there. What if folks
> > ran some performance test and were completely fine with the _first()
> > behaviour? What tells you randomness won't degrade some cases?
> 
> I tend to agree that any doesn't mean random and using a random cpu
> will create strange behavior
> 
> One example is the irq affinity on b.L system. Right now, the irq are
> always pinned to the same CPU (the 1st one which is most probably a
> Little) but with your change we can imagine that this will change and
> might ever change over 2 consecutives boot if for whatever reason (and
> this happen) the drivers are not probed in the same order . At the end
> you will run some tests with irq on little and other time irq on big.
> And more generally speaking and a SMP system can be impacted because
> the irq will not be pinned to the same CPU with always the same other
> irqs

For me this highlights issues that needs to be addressed. Which I think are
easy enough to address. But I won't push too hard for this.

Thanks

--
Qais Yousef
