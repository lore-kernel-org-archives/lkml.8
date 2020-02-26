Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFBDC4BA09
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B654821927
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="UiD7psft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbgBZC6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 21:58:18 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44900 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgBZC6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 21:58:18 -0500
Received: by mail-oi1-f193.google.com with SMTP id d62so1516507oia.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 18:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CbuwFF5t8811xFGlJ3wPhcPXhUbAmzLmXFiXZfNxi14=;
        b=UiD7psftlnvM7/CrnvMbY+oxjYjWV/3WgpDwKL6XiPJHLCPvx5w0cEuDYvMZQb2PAW
         +YP1JqL2xhGy29nasNJXutKlApQwsGhQIhi9TTz4/XbxNrTyXZ+gmWbVyFsJ8tLiSE0Z
         xGiz9mjk8C4a7duGynDKaKDeTNmKB+4vCwdZY61XBnAokIvDsrRWqhrovY6lVrBEeGeh
         Mb5PxGgGu7WlV9p3h82Ou/eFbRi9q5AM7SYBSnDtO7ZKOg7kteZrIz0firoRP6QOtJR9
         56QZiKAuKjWNEOr7iOGizfSgJQbr7vnqEOPwoMuNeOIeCpH3sJ2n36gFky/dQ2OqdN1K
         s7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CbuwFF5t8811xFGlJ3wPhcPXhUbAmzLmXFiXZfNxi14=;
        b=U9zG5w0YSEOTB+F94eRZWhgGhrmgrmReexPWYhDwFGtG51jQe11i10d3EZTx7U8iUl
         mfTs99Nv82wapoDgSujxw5b0/nTCTQpGw7QqIfpEu/HaOpZQ6lO15e/lmIr5TLdtycND
         QEjE3NWOE4/D6AI6T7CTuF4y6J7Y42ez4nE1Tz0BZQhVx1iE7+RofirIaWKh7c1mRsJS
         TSba6AHVtjabI6Wi1QfALRENVDez6ASoHCgd0ydUJRkFLYn79k6TNuxtYUMlwq+n/Pec
         ULz+UxseuV73zaobPE9rz7OlGNOt6PJnMVYfC8mxb3LTlE3rsw17ondkaYBDaKx0l3h9
         lkag==
X-Gm-Message-State: APjAAAUK6BMNvmaQQSv+w2BRvCT3kqeM+q9MGTfh1WgZNqgsmS2Em+vi
        RUeUSTS/Re26qgRd41Ia2xGLPYBpWVgZJg==
X-Google-Smtp-Source: APXvYqz1VwVTGiTHcGf2/hEbBoahceAy1GPlwTUFhVfpk/z8pArs0PuyTvas7QL3iLmNhq2hw8QIGA==
X-Received: by 2002:a05:6808:312:: with SMTP id i18mr1589326oie.44.1582685893149;
        Tue, 25 Feb 2020 18:58:13 -0800 (PST)
Received: from minyard.net ([2001:470:b8f6:1b:4db:878f:ca6f:b716])
        by smtp.gmail.com with ESMTPSA id p83sm246701oia.51.2020.02.25.18.58.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Feb 2020 18:58:12 -0800 (PST)
Date:   Tue, 25 Feb 2020 20:58:10 -0600
From:   Corey Minyard <cminyard@mvista.com>
To:     James Morse <james.morse@arm.com>
Cc:     minyard@acm.org, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64:kgdb: Fix kernel single-stepping
Message-ID: <20200226025810.GE3865@minyard.net>
Reply-To: cminyard@mvista.com
References: <20200219152403.3495-1-minyard@acm.org>
 <20200220142214.GC14459@willie-the-truck>
 <20200220163038.GJ3704@minyard.net>
 <20200220213040.GA2919@minyard.net>
 <9e2eac0b-ab60-6316-4976-686a8ab7ac8f@arm.com>
 <20200225153801.GD3865@minyard.net>
 <52fbb8a7-9dc9-508a-80f6-36ba42d5dacb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52fbb8a7-9dc9-508a-80f6-36ba42d5dacb@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello James,

On Tue, Feb 25, 2020 at 05:55:44PM +0000, James Morse wrote:
> Hi Corey,
> 
> On 25/02/2020 15:38, Corey Minyard wrote:
> > On Mon, Feb 24, 2020 at 06:07:17PM +0000, James Morse wrote:
> >> On 20/02/2020 21:30, Corey Minyard wrote:
> >>> Ok, this is the disconnect.  I was assuming that single step would stop
> >>> at the next instruction after returning from an exception.  qemu works
> >>> the same way the hardware I have does.  So I'm assuming arm64 doesn't
> >>> clear PTRACE.SS on an exception, even though that seems to be what the
> >>> manual says.
> >>
> >> PSTATE.SS isn't an enable bit for single step ... its part of a bigger state-machine.
> >> (my made-up terminology for it is 'PSTATE.Suppress-Step'...)
> >>
> >> The diagram in the Arm-Arm's D2.12.3 "The software step state machine" may help.
> >>
> >> MDSCR_EL1.SS enables single-step, if PSTATE.D is clear the CPU will now take step
> >> exceptions instead of pretty much anything else. (active pending state)
> >> To execute one instruction you need to ERET with SPSR_ELx.SS set. (active, not pending)
> >> The CPU will execute one instruction, then clear PSTATE.SS. (taking us back to active pending)
> >>
> >> Taking an exception clears PSTATE.SS so that you know you're in active-pending state, and
> >> will take a step exception once you re-enable debug with PSTATE.D. This lets you step the
> >> exception handlers.
> >> (if it was set, you wouldn't see the first instruction in the step handler, if it was
> >> inherited, you couldn't know if you would see the first instruction or not).
> >> If you take something other than a step exception, PSTATE.SS will be preserved in SPSR_EL1.SS.
> >>
> >>
> >> What I think you are seeing is the step exception once debug is re-enabled, after taking
> >> an exception you didn't want. This happens because MDSCR_EL1.SS is still set.
> 
> 
> > Ok, I was familiar with that diagram, but I was trying to fit it into
> > how the other architectures where I have done this type of work.  This
> > is a little bizarre to me, but I understand now.  Your explaination was
> > very helpful, though the code I have is correct either way.
> 
> | +/*
> | + * The task that is currently being single-stepped.  There can be only
> | + * one.
> | + */
> | +struct task_struct *single_step_task;
> 
> ? I think this would break kprobes and perf's use of single-step on SMP systems.

It shouldn't.  The task will never change in that case, interrupts are
disabled as the instruction runs.

> 
> 
> > The problem is that kgdb doesn't work right with the current
> > implementation.  If you continue from a breakpoint, it does not
> > continue.  It just stops at the same place.  What happens is:
> > 
> > * gdb remove the breakpoint and single steps.
> > * An exception happens and the single step stops in the kernel entry.
> >   Thus the state machine goes to inactive.
> 
> (e.g. the original instruction caused a page fault)
> 
> 
> > * gdb re-inserts the breakpoint and continues.
> 
> > * When the exception returns, the breakpoint is there and is hit again.
> 
> Yes, because the original instruction hadn't run, it caused a page fault. This time its
> more likely to succeed.
> 
> perf's use of arm64's breakpoints is quite happy with this. It means if you hit a
> breakpoint in the fault handler, you see those too. If an instruction causes a page-fault,
> you may see it twice, but that is because the CPU tried to execute it twice.

That's true, but gdb runs at human speed.  There will always be a timer
interrupt pending.

> 
> (I agree the irq case is probably just annoying for kgdb)
> 
> 
> > You can never continue from a breakpoint without removing it, because
> > there's alway a timer interrupt pending.
> 
> Are you driving the single-step hardware directly here, or using the behaviour from
> breakpoint_handler() and reinstall_suspended_bps()?
> 
> These disable breakpoints and step the original instruction, then re-enable breakpoints.
> This is because breakpoints fire before the instruction runs, and single-step doesn't
> suppress breakpoints. This has to happen regardless of asynchronous exceptions.
> 
> 
> > You can't single-step through
> > instructions (stepi) because it always stops in the kernel entry.  If
> > you do a normal gdb single step in code it just hangs because it keeps
> > trying to single step through instructions and keeps stopping in kernel
> > entry.  So gdb does not expect the behavior that is currently
> > implemented.
> 
> Is it fair to say that the user driving kgdb is very-slow compared to IRQs firing?
> This isn't true for the other consumers of single-step (kprobes, perf).

Yes.  You hit a breakpoint, the user does whatever then does a continue
or single-step.  Which is, of course, not true of the other single-step
users, as you say.

> 
> 
> > The patch as I have posted it is probably the simplest way to fix it.
> > It basically makes single-step work like other architectures, and like
> > the userspace single step works.  I could ifdef it so that the entry
> > code is only there if kgdb is enabled.  You can single step through
> > instructions that cause page faults, so it's a little more general.
> 
> > The other way is to run the single-stepped instruction with interrupts
> > disabled and emulate any messing with the DAIF bits.  I assume
> > that's only "MRS <Xt>, DAIF", "MSR DAIF, <Xt>", "MSR DAIFSet, #<imm>",
> > and "MSR DAIFClr, #<imm>". 
> 
> > Well, I guess ERET also does that, but maybe
> > that's ok, probably not a big deal.
> 
> (tangent: you can't step ERET!)
> 
> 
> > In this case you can't single step over instructions that take page faults.
> 
> This works for perf. It doesn't for kprobes, which is why kprobes blacklists those sites.
> 
> 
> > I'm not sure if that's a big
> > deal or not, but I assume users would do that.  And it's more complex
> > since you have to emulate those instructions messing with DAIF.
> > 
> > I would like to get this fixed, either way.
> 
> If the problem is IRQs preventing the very-slow user making forward-progress, it may be
> possible for kgdb to ask the irqchip code to mute all IRQs on this CPU while it is
> stepping. The PMR mechanism we use for pNMI could do this for the GIC. (Caveat: I don't
> know anything about the GIC). For the pi ... no idea.
> 
> This doesn't stop you seeing instructions that fault from taking a fault, or taking the
> breakpoint twice when the CPU tries to run the instruction twice. This is just the debug
> hardware showing you what happened.

I'm not sure messing around with the GIC is really the right solution.
But, it's an interesting idea.

I'm not sure how to proceed from here, though.

-corey

> 
> 
> Thanks,
> 
> James
