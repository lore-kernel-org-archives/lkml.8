Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44A5C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 08:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADA820753
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 08:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgCRId3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 04:33:29 -0400
Received: from foss.arm.com ([217.140.110.172]:46880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgCRId3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 04:33:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DCCD31B;
        Wed, 18 Mar 2020 01:33:28 -0700 (PDT)
Received: from e123083-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC73F3F52E;
        Wed, 18 Mar 2020 01:33:26 -0700 (PDT)
Date:   Wed, 18 Mar 2020 09:33:24 +0100
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH V2] sched: fair: Use the earliest break even
Message-ID: <20200318083324.GB6103@e123083-lin>
References: <20200311202625.13629-1-daniel.lezcano@linaro.org>
 <CAKfTPtAqeHhVCeSgE1DsaGGkM6nY-9oAvGw_6zWvv1bKyE85JQ@mail.gmail.com>
 <e6e8ff94-64f2-6404-e332-2e030fc7e332@linaro.org>
 <20200317075607.GE10914@e105550-lin.cambridge.arm.com>
 <3520b762-08f5-0db8-30cb-372709188bb9@linaro.org>
 <20200317143053.GF10914@e105550-lin.cambridge.arm.com>
 <CAKfTPtD+aWcgjjK35x1LWKCNS_AVGm9sFoBXgqW_qL+oUSPMiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtD+aWcgjjK35x1LWKCNS_AVGm9sFoBXgqW_qL+oUSPMiw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 08:51:04AM +0100, Vincent Guittot wrote:
> On Tue, 17 Mar 2020 at 15:30, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> > On Tue, Mar 17, 2020 at 02:48:51PM +0100, Daniel Lezcano wrote:
> > > On 17/03/2020 08:56, Morten Rasmussen wrote:
> > > > On Thu, Mar 12, 2020 at 11:04:19AM +0100, Daniel Lezcano wrote:
> > > >> On 12/03/2020 09:36, Vincent Guittot wrote:
> > > >>> On Wed, 11 Mar 2020 at 21:28, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> > > >>>>
> > > >>>> In the idle CPU selection process occuring in the slow path via the
> > > >>>> find_idlest_group_cpu() function, we pick up in priority an idle CPU
> > > >>>> with the shallowest idle state otherwise we fall back to the least
> > > >>>> loaded CPU.
> > > >>>
> > > >>> The idea makes sense but this path is only used by fork and exec so
> > > >>> I'm not sure about the real impact
> > > >>
> > > >> I agree the fork / exec path is called much less often than the wake
> > > >> path but it makes more sense for the decision.
> > > >
> > > > Looking at the flow in find_idlest_cpu(), AFAICT,
> > > > find_idlest_group_cpu() is not actually making the final choice of CPU,
> > > > so going through a lot of trouble there looking at idle states is
> > > > pointless. Is there something I don't see?
> > > >
> > > > We fellow sd->child until groups == CPUs which which means that
> > > > find_idlest_group() actually makes the final choice as the final group
> > > > passed to find_idlest_group_cpu() is single-CPU group. The flow has been
> > > > like that for years. Even before you added the initial idle-state
> > > > awareness.
> > > >
> > > > I agree with Vincent, if this should really make a difference it should
> > > > include wake-ups existing tasks too. Although I'm aware it would be a
> > > > more invasive change. As said from the beginning, the idea is fine, but
> > > > the current implementation should not make any measurable difference?
> > >
> > > I'm seeing the wake-ups path so sensitive, I'm not comfortable to do any
> > > changes in it. That is the reason why the patch only changes the slow path.
> >
> > Right. I'm not against being cautious at all. It would be interesting to
> > evaluate how bad it really is. The extra time-stamping business cost is
> > the same, so it really down how much we dare to use the information in
> > the fast-path and change the CPU selection policy. And of course, how
> > much can be gained by the change.
> 
> Hmm... the fast path not even parses all idle CPUs right now so it
> will be difficult to make any comparison. Regarding wakeup path, the
> only place that could make sense IMO is the EAS slow wakeup path
> find_energy_efficient_cpu() which mitigates performance vs energy
> consumption

Agreed, it is not really compatible with the current fast-path policies.
I would start with just hacking it in to evaluate the potential
improvements to have an idea about what is on the table.

As you say, it could live somewhere slightly out the way like the EAS
path, but I'm not sure if actually fits well under EAS. EAS is disabled
for symmetric CPU capacities, which is probably the systems that will
benefit the most. Also, as mentioned already in this thread, I don't see
how the idea brings any energy savings?

Morten
