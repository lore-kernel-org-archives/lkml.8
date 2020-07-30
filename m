Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B1AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 15:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C61220829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 15:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbgG3P35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 11:29:57 -0400
Received: from foss.arm.com ([217.140.110.172]:41334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbgG3P35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 11:29:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 633581FB;
        Thu, 30 Jul 2020 08:29:56 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C7053F66E;
        Thu, 30 Jul 2020 08:29:55 -0700 (PDT)
Date:   Thu, 30 Jul 2020 16:29:52 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     peterz@infradead.org, Steven Rostedt <rostedt@goodmis.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>, sfr@canb.auug.org.au
Subject: Re: [tip:sched/fifo 44/45] ERROR: modpost: "sched_setscheduler"
 undefined!
Message-ID: <20200730152952.cyhlug66fos5hubg@e107158-lin.cambridge.arm.com>
References: <202006192249.AYnVBGCH%lkp@intel.com>
 <20200709124505.GT597537@hirez.programming.kicks-ass.net>
 <20200709115818.36a956a4@oasis.local.home>
 <20200720214918.GM5523@worktop.programming.kicks-ass.net>
 <20200720181943.7d8efc65@oasis.local.home>
 <20200721083643.GG119549@hirez.programming.kicks-ass.net>
 <20200721101357.xoa6x4xtzkqoltfk@e107158-lin>
 <4a0da149-5051-8204-6f34-da4d6e42a78a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4a0da149-5051-8204-6f34-da4d6e42a78a@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/29/20 12:23, Dietmar Eggemann wrote:
> On 21/07/2020 12:13, Qais Yousef wrote:
> > On 07/21/20 10:36, peterz@infradead.org wrote:
> >> On Mon, Jul 20, 2020 at 06:19:43PM -0400, Steven Rostedt wrote:
> >>> On Mon, 20 Jul 2020 23:49:18 +0200
> >>> Peter Zijlstra <peterz@infradead.org> wrote:
> >>>
> >>>> Steve, would this work for you, or would you prefer renaming the
> >>>> parameters as well?
> >>>>
> >>>
> >>> Yeah, that's fine. You don't have any sched_fifo_high() ?
> >>
> >> Thanks! and no.
> >>
> >> I'll go write a Changelog and add it to tip/sched/fifo, so that
> >> hopefully, sfr can stop complaining about this build fail ;-)
> >>
> >> I've even argued we should rename fifo_low() to something else, but
> >> failed to come up with a sensible name. The intended case is for when
> >> you want something above normal but don't particularly care about RT at
> >> all.
> >>
> >> The thing is, once you start adding priorities, even low,med,high, we're
> >> back to where we were. And the whole argument is that the kernel cannot
> >> set priorities in any sensible fashion.
> > 
> > Agreed. I am worried about in-kernel users setting random uclamp values too.
> 
> Do we really have to restrict in-kernel user?
> 
> And avoiding module uclamp abuse is covered by 616d91b68cd5 ("sched:
> Remove sched_setscheduler*() EXPORTs").
> 
> > This series should do most of the work but there are more pieces needed on-top.
> > 
> > From what I see we still need to move the sched_setscheduler() from
> > include/linux/sched.h to kernel/sched/sched.h. And sched_setattr() too. The
> > latter has a single user in kernel/trace/trace_selftest.c to create a deadline
> > task. I think that can be easily wrapped with a similar sched_set_dl()
> > function and exported instead.
> 
> But DL does not have the same issue like the FIFO/RR when it comes to
> resource management.
> Not sure if we have to restrict in-kernel user.

FWIW, I have the patches ready and tested for posting.

	http://linux-arm.org/git?p=linux-qy.git;a=shortlog;h=refs/heads/sched-setscheduler-hide

Peter, do you think it's not necessary to go to that level of restriction too?

It'll just avoid surprises IMO by making sched_set{sched, attr}() static. The
wrapper can be flexible to change if needed, but at least we'll know.

I addressed Paul's concern on IRC too.

Thanks

--
Qais Yousef
