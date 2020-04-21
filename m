Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D035C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40BA4206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgDUOjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:39:10 -0400
Received: from foss.arm.com ([217.140.110.172]:36688 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgDUOjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:39:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05A7031B;
        Tue, 21 Apr 2020 07:39:09 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AF583F68F;
        Tue, 21 Apr 2020 07:39:06 -0700 (PDT)
Date:   Tue, 21 Apr 2020 15:39:04 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/4] sched/rt: Distribute tasks in find_lowest_rq()
Message-ID: <20200421143903.iox2bgmezrd5x6c5@e107158-lin.cambridge.arm.com>
References: <20200414150556.10920-1-qais.yousef@arm.com>
 <jhjh7xlvqqe.mognet@arm.com>
 <20200421121305.ziu3dfqwo7cw6ymu@e107158-lin.cambridge.arm.com>
 <jhjv9ltkmel.mognet@arm.com>
 <dda160a8d78b44dbc310759502a49afc@kernel.org>
 <20200421142243.lea26mnmxnjpynlf@e107158-lin.cambridge.arm.com>
 <1c21b8e7b08e6db7fb97dc46d1246d9a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1c21b8e7b08e6db7fb97dc46d1246d9a@kernel.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/21/20 15:28, Marc Zyngier wrote:
> On 2020-04-21 15:22, Qais Yousef wrote:
> > On 04/21/20 15:09, Marc Zyngier wrote:
> > > On 2020-04-21 14:18, Valentin Schneider wrote:
> > > > On 21/04/20 13:13, Qais Yousef wrote:
> > > 
> > > [...]
> > > 
> > > > > I CCed Marc who's the maintainer of this file who can clarify better
> > > > > if this
> > > > > really breaks anything.
> > > > >
> > > > > If any interrupt expects to be affined to a specific CPU then this
> > > > > must be
> > > > > described in DT/driver. I think the GIC controller is free to
> > > > > distribute them
> > > > > to any cpu otherwise if !force. Which is usually done by
> > > > > irq_balancer anyway
> > > > > in userspace, IIUC.
> > > > >
> > > > > I don't see how cpumask_any_and() break anything here too. I
> > > > > actually think it
> > > > > improves on things by better distribute the irqs on the system by
> > > > > default.
> > > 
> > > That's a pretty bold statement. Unfortunately, it isn't universally
> > > true.
> > > Some workload will be very happy with interrupts spread all over the
> > > map,
> > > and some others will suffer from it because, well, it interrupts
> > > userspace.
> > > 
> > > > As you say, if someone wants smarter IRQ affinity they can do
> > > > irq_balancer
> > > > and whatnot. The default kernel policy for now has been to shove
> > > > everything
> > > > on the lowest-numbered CPU, and I see no valid reason to change that.
> > > 
> > > Exactly. I would like to keep the kernel policy as simple as
> > > possible for
> > > non-managed interrupts (managed interrupts are another kettle of fish
> > > entirely).
> > > Userpace is in control to place things "intelligently", so let's not
> > > try and
> > > make the kernel smarter than it strictly needs to be.
> > 
> > Fair enough. But why is it asking for cpumask_any() in the first place?
> 
> Implementation detail. Turn it into cpumask_first_and() if you want.

Will do.

Thanks

--
Qais Yousef
