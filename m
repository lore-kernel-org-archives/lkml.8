Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5845C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E36D2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="NAMzzxg4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbgBYPiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:38:06 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43055 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729501AbgBYPiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 10:38:06 -0500
Received: by mail-ot1-f68.google.com with SMTP id p8so12396939oth.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 07:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jwm+TSOeImzPHrCD9+lr7kAphC4tuL6RMLlaxgsWLqw=;
        b=NAMzzxg4+soT+611ryWdedqsp05j0VTIolEkKeHONvyN311QDu89YCrHUICEQqTdvn
         M5nooEvKfDPn2IASXdOmA5n22+QBKB8XZDW6Abj9n7gTea3irchcWoJFVw5OA0kJXv8M
         OiUOg2+xDp1m/SmIVM8xXJdxaVUeMxf0N+0hj0UAo2CTclY+95z5ie5j1eW4RpFs3qpL
         shKJzM3XAkjG2kpAvh1pevfSU4byujyD5nrdhMlL0PbU7rqph2LIxx1dxMSin3aD0lb/
         sSVnAAR/gmsTKft1GakaEONG1M3olZrYg+RE0Q//C2Db7mQj6B+YeGlJjOzgEvAuNI7T
         HJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jwm+TSOeImzPHrCD9+lr7kAphC4tuL6RMLlaxgsWLqw=;
        b=BHmWMNJDUbX7wtdd3pXnRoSJIa9bB/9ymHV5e6unlXOKzaP+T7+weV0f+plU41TQQc
         18Q9nwS7gz9tebMd2o5eGA4R87UQsGJxUm/5jrjCOzRDnV0dT3zYSEcObZsFN6tqRCgA
         ciZFlxKBYGMYuvxH6SxBa7NmlgxHOgfAAenBNN0e8wej47XKUKePBmbjjEalkCmyjxfj
         BpsASS4RxfB6b10UfM3uSeOW2eZu3lBDlnmFqVNXo9yosKMtNc+HWYME1mWsZh2Mwlch
         nSrRSF9lACaPhxtTh0CdbSwUAbU+tAZY7+fMVAKV2T+uTbKGPBSQaqy2fvg+oq3KgY7n
         Rm3Q==
X-Gm-Message-State: APjAAAUtgV3MYc4aO68QVvPQx0C0kljy39k4qQEOPFwsJBqY42AJIy+G
        1s/G0MYj3MdbbUD+LLHjgS8PWQ==
X-Google-Smtp-Source: APXvYqzHldmwrTqVl+AAsrIVCTX7Jlh9PnwFXlMGuP+jUutbKK3H1p0bCLeuppv2h2dFsswPzzKHLg==
X-Received: by 2002:a9d:5d09:: with SMTP id b9mr44627552oti.207.1582645084501;
        Tue, 25 Feb 2020 07:38:04 -0800 (PST)
Received: from minyard.net ([2001:470:b8f6:1b:4db:878f:ca6f:b716])
        by smtp.gmail.com with ESMTPSA id l8sm2363087otn.31.2020.02.25.07.38.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Feb 2020 07:38:03 -0800 (PST)
Date:   Tue, 25 Feb 2020 09:38:01 -0600
From:   Corey Minyard <cminyard@mvista.com>
To:     James Morse <james.morse@arm.com>
Cc:     minyard@acm.org, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64:kgdb: Fix kernel single-stepping
Message-ID: <20200225153801.GD3865@minyard.net>
Reply-To: cminyard@mvista.com
References: <20200219152403.3495-1-minyard@acm.org>
 <20200220142214.GC14459@willie-the-truck>
 <20200220163038.GJ3704@minyard.net>
 <20200220213040.GA2919@minyard.net>
 <9e2eac0b-ab60-6316-4976-686a8ab7ac8f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e2eac0b-ab60-6316-4976-686a8ab7ac8f@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 06:07:17PM +0000, James Morse wrote:
> Hi Corey,
> 
> On 20/02/2020 21:30, Corey Minyard wrote:
> > On Thu, Feb 20, 2020 at 10:30:38AM -0600, Corey Minyard wrote:
> >> On Thu, Feb 20, 2020 at 02:22:14PM +0000, Will Deacon wrote:
> >>> On Wed, Feb 19, 2020 at 09:24:03AM -0600, minyard@acm.org wrote:
> >>>> After fixing this and doing some more testing, I ran into another issue:
> >>>>
> >>>> * Kernel enables the pt_regs single step
> >>>> * Kernel returns from the exception with ERET.
> >>>> * An interrupt or page fault happens on the instruction, causing the
> >>>>   instruction to not be run, but the exception handler runs.
> >>>
> >>> This sounds like you've broken debug; we should take the step exception
> >>> in the exception handler. That's the way this is supposed to work.
> >>
> >> Ok, here is the disconnect, I think.  If that is the case, then what I'm
> >> seeing is working like it should.  That doesn't work with gdb, though,
> >> gdb expects to be able to single-step and get to the next instruction.
> >> The scenario I mentioned at the top of this email.
> >>
> >> Let me look at this a bit more.  I'll look at this on qemu and maybe a
> >> pi.
> 
> > Ok, this is the disconnect.  I was assuming that single step would stop
> > at the next instruction after returning from an exception.  qemu works
> > the same way the hardware I have does.  So I'm assuming arm64 doesn't
> > clear PTRACE.SS on an exception, even though that seems to be what the
> > manual says.
> 
> PSTATE.SS isn't an enable bit for single step ... its part of a bigger state-machine.
> (my made-up terminology for it is 'PSTATE.Suppress-Step'...)
> 
> The diagram in the Arm-Arm's D2.12.3 "The software step state machine" may help.
> 
> MDSCR_EL1.SS enables single-step, if PSTATE.D is clear the CPU will now take step
> exceptions instead of pretty much anything else. (active pending state)
> To execute one instruction you need to ERET with SPSR_ELx.SS set. (active, not pending)
> The CPU will execute one instruction, then clear PSTATE.SS. (taking us back to active pending)
> 
> Taking an exception clears PSTATE.SS so that you know you're in active-pending state, and
> will take a step exception once you re-enable debug with PSTATE.D. This lets you step the
> exception handlers.
> (if it was set, you wouldn't see the first instruction in the step handler, if it was
> inherited, you couldn't know if you would see the first instruction or not).
> If you take something other than a step exception, PSTATE.SS will be preserved in SPSR_EL1.SS.
> 
> 
> What I think you are seeing is the step exception once debug is re-enabled, after taking
> an exception you didn't want. This happens because MDSCR_EL1.SS is still set.

Ok, I was familiar with that diagram, but I was trying to fit it into
how the other architectures where I have done this type of work.  This
is a little bizarre to me, but I understand now.  Your explaination was
very helpful, though the code I have is correct either way.

The problem is that kgdb doesn't work right with the current
implementation.  If you continue from a breakpoint, it does not
continue.  It just stops at the same place.  What happens is:

* gdb remove the breakpoint and single steps.
* An exception happens and the single step stops in the kernel entry.
  Thus the state machine goes to inactive.
* gdb re-inserts the breakpoint and continues.
* When the exception returns, the breakpoint is there and is hit again.

You can never continue from a breakpoint without removing it, because
there's alway a timer interrupt pending.  You can't single-step through
instructions (stepi) because it always stops in the kernel entry.  If
you do a normal gdb single step in code it just hangs because it keeps
trying to single step through instructions and keeps stopping in kernel
entry.  So gdb does not expect the behavior that is currently
implemented.

The patch as I have posted it is probably the simplest way to fix it.
It basically makes single-step work like other architectures, and like
the userspace single step works.  I could ifdef it so that the entry
code is only there if kgdb is enabled.  You can single step through
instructions that cause page faults, so it's a little more general.

The other way is to run the single-stepped instruction with interrupts
disabled and emulate any messing with the DAIF bits.  I assume
that's only "MRS <Xt>, DAIF", "MSR DAIF, <Xt>", "MSR DAIFSet, #<imm>",
and "MSR DAIFClr, #<imm>".  Well, I guess ERET also does that, but maybe
that's ok, probably not a big deal.  In this case you can't single step
over instructions that take page faults.  I'm not sure if that's a big
deal or not, but I assume users would do that.  And it's more complex
since you have to emulate those instructions messing with DAIF.

I would like to get this fixed, either way.

Thanks,

-corey

> 
> 
> > You can reproduce this by setting up kgdb on the kernel and hooking up
> > gdb, setting a breakpoint somewhere that has interrupts enabled, then
> > doing a "continue".  It will hit the same breakpoint again and again
> > because the PC doesn't get advanced by the single step and the timer
> > interrupt is always going to be pending.  I can do a more detailed set
> > of instructions with qemu, if you like.
> 
> > I looked at kprobes a bit.  I don't think kprobes will have a problem
> > with this particular issue, it disables interrupts while single
> > stepping and doesn't allow a probe on any instruction that would modify
> > the interrupt settings.  I didn't look at page faults, but I assume that
> > it also won't allow a probe where there can be a page fault.
> 
> Yes, arch_prepare_kprobe() checks search_exception_tables() for locations that we know may
> cause page faults. These are blacklisted.
> 
> 
> Thanks,
> 
> James
