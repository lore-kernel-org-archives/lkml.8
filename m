Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345E6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 162A720756
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgERNci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 09:32:38 -0400
Received: from foss.arm.com ([217.140.110.172]:40716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbgERNci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:32:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4178C101E;
        Mon, 18 May 2020 06:32:37 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.29.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D82EF3F305;
        Mon, 18 May 2020 06:32:34 -0700 (PDT)
Date:   Mon, 18 May 2020 14:32:31 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@am.com>,
        Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@android.com
Subject: Re: [PATCH 4/6] scs: Move scs_overflow_check() out of architecture
 code
Message-ID: <20200518133231.GC2787@C02TD0UTHF1T.local>
References: <20200515172756.27185-1-will@kernel.org>
 <20200515172756.27185-5-will@kernel.org>
 <20200518121210.GD1957@C02TD0UTHF1T.local>
 <20200518132346.GD32394@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518132346.GD32394@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 02:23:47PM +0100, Will Deacon wrote:
> On Mon, May 18, 2020 at 01:12:10PM +0100, Mark Rutland wrote:
> > On Fri, May 15, 2020 at 06:27:54PM +0100, Will Deacon wrote:
> > > There is nothing architecture-specific about scs_overflow_check() as
> > > it's just a trivial wrapper around scs_corrupted().
> > > 
> > > For parity with task_stack_end_corrupted(), rename scs_corrupted() to
> > > task_scs_end_corrupted() and call it from schedule_debug() when
> > > CONFIG_SCHED_STACK_END_CHECK_is enabled. Finally, remove the unused
> > > scs_overflow_check() function entirely.
> > > 
> > > This has absolutely no impact on architectures that do not support SCS
> > > (currently arm64 only).
> > > 
> > > Signed-off-by: Will Deacon <will@kernel.org>
> > 
> > Pulling this out of arch code seems sane to me, and the arch-specific
> > chanes look sound. However, I have a concern with the changes within the
> > scheduler context-switch.
> > 
> > > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > > index a35d3318492c..56be4cbf771f 100644
> > > --- a/arch/arm64/kernel/process.c
> > > +++ b/arch/arm64/kernel/process.c
> > > @@ -52,7 +52,6 @@
> > >  #include <asm/mmu_context.h>
> > >  #include <asm/processor.h>
> > >  #include <asm/pointer_auth.h>
> > > -#include <asm/scs.h>
> > >  #include <asm/stacktrace.h>
> > >  
> > >  #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_TASK)
> > > @@ -516,7 +515,6 @@ __notrace_funcgraph struct task_struct *__switch_to(struct task_struct *prev,
> > >  	entry_task_switch(next);
> > >  	uao_thread_switch(next);
> > >  	ssbs_thread_switch(next);
> > > -	scs_overflow_check(next);
> > 
> > Prior to this patch, we'd never switch to a task whose SCS had already
> > been corrupted.
> > 
> > With this patch, we only check that when switching away from a task, and
> > only when CONFIG_SCHED_STACK_END_CHECK is selected, which at first
> > glance seems to weaken that.
> 
> Yes, ignoring vmap'd stacks, this patch brings the SCS checking in-line with
> the main stack checking when CONFIG_SCHED_STACK_END_CHECK=y.
> 
> > Arguably:
> > 
> > * If the next task's SCS was corrupted by that task while it was
> >   running, we had already lost at that point.
> 
> With this change, we'll at least catch this one sooner, and that might be
> useful if a bug has caused us to overflow the SCS but not the main stack.

Sure, but only if CONFIG_SCHED_STACK_END_CHECK is selected.

> > * If the next task's SCS was corrupted by another task, then that could
> >   also happen immediately after the check (though timing to avoid the
> >   check but affect the process could be harder).
> 
> We're only checking the magic end value, so the cross-task case is basically
> if you overrun your own SCS as above, but then continue to overrun entire
> SCSs for other tasks as well. It's probably not very useful in that case.
> 
> > ... and a VMAP'd SCS would be much nicer in this regard.
> > 
> > Do we think this is weakening the check, or do we think it wasn't all
> > that helpful to begin with?
> 
> I see it as a debug check to catch SCS overflow, rather than a hardening
> feature, and I agree that using something like vmap stack for the SCS would
> be better because we could have a guard page instead.

Fair enough. Could we put something into the commit message that more
explicitly calls out debug-not-hardening? I agree that under that model
this patch looks fine, and with something to that effect:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> This is something I would like to revisit, but we need more
> information from Sami about why Android rejected the larger allocation
> size, since I don't think there's an awful lot of point merging this
> series if Android doesn't pick it up.

Indeed. I'd certainly prefer the robustness of a VMAP'd SCS if we can do
that.

Mark.
