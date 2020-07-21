Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ACCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB0BF2073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGUKOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 06:14:03 -0400
Received: from foss.arm.com ([217.140.110.172]:34528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgGUKOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:14:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 633FF106F;
        Tue, 21 Jul 2020 03:14:02 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 434D13F66E;
        Tue, 21 Jul 2020 03:14:01 -0700 (PDT)
Date:   Tue, 21 Jul 2020 11:13:58 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     peterz@infradead.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>, sfr@canb.auug.org.au
Subject: Re: [tip:sched/fifo 44/45] ERROR: modpost: "sched_setscheduler"
 undefined!
Message-ID: <20200721101357.xoa6x4xtzkqoltfk@e107158-lin>
References: <202006192249.AYnVBGCH%lkp@intel.com>
 <20200709124505.GT597537@hirez.programming.kicks-ass.net>
 <20200709115818.36a956a4@oasis.local.home>
 <20200720214918.GM5523@worktop.programming.kicks-ass.net>
 <20200720181943.7d8efc65@oasis.local.home>
 <20200721083643.GG119549@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200721083643.GG119549@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/21/20 10:36, peterz@infradead.org wrote:
> On Mon, Jul 20, 2020 at 06:19:43PM -0400, Steven Rostedt wrote:
> > On Mon, 20 Jul 2020 23:49:18 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > Steve, would this work for you, or would you prefer renaming the
> > > parameters as well?
> > > 
> > 
> > Yeah, that's fine. You don't have any sched_fifo_high() ?
> 
> Thanks! and no.
> 
> I'll go write a Changelog and add it to tip/sched/fifo, so that
> hopefully, sfr can stop complaining about this build fail ;-)
> 
> I've even argued we should rename fifo_low() to something else, but
> failed to come up with a sensible name. The intended case is for when
> you want something above normal but don't particularly care about RT at
> all.
> 
> The thing is, once you start adding priorities, even low,med,high, we're
> back to where we were. And the whole argument is that the kernel cannot
> set priorities in any sensible fashion.

Agreed. I am worried about in-kernel users setting random uclamp values too.

This series should do most of the work but there are more pieces needed on-top.

From what I see we still need to move the sched_setscheduler() from
include/linux/sched.h to kernel/sched/sched.h. And sched_setattr() too. The
latter has a single user in kernel/trace/trace_selftest.c to create a deadline
task. I think that can be easily wrapped with a similar sched_set_dl()
function and exported instead.

Happy to do the work if you nudge me after you've published this fix on tip or
your queue.

Thanks

--
Qais Yousef
