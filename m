Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA74C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5EE20722
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rAl0vrUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgBTQan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:30:43 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36404 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbgBTQam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:30:42 -0500
Received: by mail-oi1-f195.google.com with SMTP id c16so28158282oic.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 08:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y9HQfeZQmR3ITWVRctdqux0hlFnrN0+7nUWBuGoGzbI=;
        b=rAl0vrUdgC6BPCfHywHFImldtnI3m6Nj5ysAz5uBGUmEKyEPKdjcAq4t7lUO2stDK+
         1t3k0thBRBULY6f2rwgUO2JbXJGA0QlMISutM6QHwTyDBTBJlbmBD42BOKB1LWHD9cCb
         lLr8xuRQr6btT8GLq7QtB/mgo10L0lG4LZsXg4XoI0rCuOBHvgdD4fTMHBUmOrNKYVvI
         Y2wkvJ93jpOQUYL2074hW4b9p6uKhmFrj1nT9Ujn/a1+5BWhVVbwa+ul+fLPkqZcp7yX
         fFdEp07Q+lRUC7+7z07jRmsN4cOg07ydrTv4s7yBhE4Guyzi7TlUG+LCHTGLVXck9aFH
         rVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=y9HQfeZQmR3ITWVRctdqux0hlFnrN0+7nUWBuGoGzbI=;
        b=a0DDAQdhdZZUMHd8PPJTRm/3a+4sR3nga5JmfHcDYLVJysPvnlUSGABcFqP1pIVq3x
         dsL98ylbGm6xP8/ql2JKvoDoyTfmiHCMuvwCxy3RHgDWZbLxf3XWspj2m5Vx1CL9+ilU
         Dmx00NlszsdAWbgah5G5r3ZYCLEpSADuph+chcXoq5PUpGcFQCShSh7HTX/X+klrZCN1
         K69iD+37ErdFNZJiA3X3x7v3vWuDOpFFqzW2yfFIQQCwHOaIuPmF5YDAQxCRt3Tu+DQk
         oBYmp3ZtDgF+fpWjuaiuwO9O2vXrN58hoF8zrqDXYIJMu+BhQ+iSGAADIkfS8W1a4AJQ
         obIQ==
X-Gm-Message-State: APjAAAWMdCsZHQBBSo5c9vCyP3BesUzwe2p6kSWXE0rrPqg5JWYcedf0
        fMxnGrmFgfHY5p/lXuVqGuxeHUw=
X-Google-Smtp-Source: APXvYqzJvnK1s6UOpaxFEdvEcJ3Bw6Mh437NhoRzotRpwK6fSKE5IJWYi7CGh3MjxZGTDTSpff+Czw==
X-Received: by 2002:aca:d484:: with SMTP id l126mr2584473oig.114.1582216241151;
        Thu, 20 Feb 2020 08:30:41 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id 9sm1299958otx.75.2020.02.20.08.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:30:40 -0800 (PST)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:9129:b2b8:445c:a4ff])
        by serve.minyard.net (Postfix) with ESMTPSA id D290B18000D;
        Thu, 20 Feb 2020 16:30:39 +0000 (UTC)
Date:   Thu, 20 Feb 2020 10:30:38 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH v2] arm64:kgdb: Fix kernel single-stepping
Message-ID: <20200220163038.GJ3704@minyard.net>
Reply-To: minyard@acm.org
References: <20200219152403.3495-1-minyard@acm.org>
 <20200220142214.GC14459@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220142214.GC14459@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 02:22:14PM +0000, Will Deacon wrote:
> On Wed, Feb 19, 2020 at 09:24:03AM -0600, minyard@acm.org wrote:
> > From: Corey Minyard <cminyard@mvista.com>
> > 
> > I was working on a single-step bug on kgdb on an ARM64 system, and I saw
> > this scenario:
> > 
> > * A single step is setup to return to el1
> > * The ERET return to el1
> > * An interrupt is pending and runs before the instruction
> > * As soon as PSTATE.D (the debug disable bit) is cleared, the single
> >     step happens in that location, not where it should have.
> > 
> > This appears to be due to PSTATE.SS not being cleared when the exception
> > happens.  Per section D.2.12.5 of the ARMv8 reference manual, that
> > appears to be incorrect, it says "As part of exception entry, the PE
> > does all of the following: ...  Sets PSTATE.SS to 0."
> 
> Sorry, but I don't follow you here. If PSTATE.SS is not cleared, why would
> you take the step exception?

I don't follow.  If PSTATE.SS is set and MDSCR_EL1.SS is set, the
processor will take a single-step exception as soon as the debug
exceptions are enabled.  That's what I'm seeing.  The hardware bug is
that PSTATE.SS is not cleared on an exception, and MDSCR_EL1.SS is not
cleared on kernel entry from el1.

I'm not 100% sure that PSTATE.SS is supposed to clear on an exception.
The debug handling documentation in the ARM64 manual is extremely hard
to follow.  But I'm pretty sure about this, as you would see this
problem on every processor and it would be obvious.  You could never
continue from a breakpoint, because the following happens when
continuing from a breakpoint in what I'm seeing:

* gdb disables the breakpoint
* gdb does a single step
* The single step triggers when debug excecption are enabled, not
  after the instruction in question.
* gdb restores the breakpoint and continues
* The breakpoint occurs again because the single step never really
  happened.

> 
> > However, I appear to not be the first person who has noticed this.  In
> > the el0-only portion of the kernel_entry macro in entry.S, I found the
> > following comment: "Ensure MDSCR_EL1.SS is clear, since we can unmask
> > debug exceptions when scheduling."  Exactly the same scenario, except
> > coming from a userland single step, not a kernel one.
> 
> No, I think you might be conflating PSTATE.SS and MDSCR_EL1.SS.

Not exactly.  If the processor clears PSTATE.SS, why would you need to
clear MDSCR_EL1.SS?  You can just ignore it.  But looking at the git
commit where that code was introduced, I can see that wasn't the reason.

> 
> > As I was studying this, though, I realized that the following scenario
> > had an issue:
> > 
> > * Kernel enables MDSCR.SS, MDSCR.KDE, MDSCR.MDE (unnecessary), and
> >   PSTATE.SS to enable a single step in el1, for kgdb or kprobes,
> >   on the current CPU's MDSCR register and the process' PSTATE.SS
> >   register.
> > * Kernel returns from the exception with ERET.
> > * An interrupt or page fault happens on the instruction, causing the
> >   instruction to not be run, but the exception handler runs.
> > * The exception causes the task to migrate to a new core.
> > * The return from the exception runs on a different processor now,
> >   where the MDSCR values are not set up for a single step.
> > * The single step fails to happen.
> > 
> > This is bad for kgdb, of course, but it seems really bad for kprobes if
> > this happens.
> 
> I don't see how this can happen for kprobes. Have you managed to reproduce
> the failure?

Can a migration happen if kprobes sets up a single-step, does the step,
and an interrupt or page fault happens before the single step occurs?
If so, that single-step will never happen.

I would be hard to reproduce.  I think I could force this to happen by
modifying the kernel to force a migration in the single-step code, but
it would be hard without modifying the kernel.

> 
> > To fix both these problems, rework the handling of single steps to clear
> > things out upon entry to the kernel from el1, and then to set up single
> > step when returning to el1, and not do the setup in debug-monitors.c.
> > This means that single stepping does not use
> > enable/disable_debug_monitors(); it is no longer necessary to track
> > those flags for single stepping.  This is much like single stepping is
> > handled for el0.  A new flag is added in pt_regs to enable single
> > stepping from el1.  Unfortunately, the old value of PSTATE.SS cannot be
> > used for this because of the hardware bug mentioned earlier.
> 
> I don't think there's a hardware bug.
> 
> It sound like you're trying to make kernel debugging per-task instead
> of per-cpu, but I don't think that's the right thing to do. What if I /want/
> to debug an interrupt handler? For example, I might have a watchpoint on
> something accessed by timer interrupt.
> 
> > As part of this, there is an interaction between single stepping and the
> > other users of debug monitors with the MDSCR.KDE bit.  That bit has to
> > be set for both hardware breakpoints at el1 and single stepping at el1.
> > A new variable was created to store the cpu-wide value of MDSCR.KDE; the
> > single stepping code makes sure not to clear that bit on kernel entry if
> > it's set in the per-cpu variable.
> > 
> > After fixing this and doing some more testing, I ran into another issue:
> > 
> > * Kernel enables the pt_regs single step
> > * Kernel returns from the exception with ERET.
> > * An interrupt or page fault happens on the instruction, causing the
> >   instruction to not be run, but the exception handler runs.
> 
> This sounds like you've broken debug; we should take the step exception
> in the exception handler. That's the way this is supposed to work.

Ok, here is the disconnect, I think.  If that is the case, then what I'm
seeing is working like it should.  That doesn't work with gdb, though,
gdb expects to be able to single-step and get to the next instruction.
The scenario I mentioned at the top of this email.

Let me look at this a bit more.  I'll look at this on qemu and maybe a
pi.

-corey

> 
> > There's no easy way to find the pt_regs that has the single step flag
> > set.  So a thread info flag was added so that the single step could be
> > disabled in this case.  Both that flag and the flag in pt_regs must be
> > set to enable a single step.
> 
> Honestly, I get the feeling that you don't really understand the code
> you're changing here and it's a tonne of effort to try to untangle what
> you're doing. That's not necessarily your fault because the debug
> architecture is a nightmare to comprehend, but I'm not keen to change it
> unless we have a really good justification. I'm sure kgdb is riddled with
> bugs but, as I said before, the fixes should be in kgdb, not by tearing
> up the low-level debug code (which has the potential to break other users).
> 
> Maybe it would be easier if you tried to fix one problem per patch,
> preferably with a way to reproduce the issue you're seeing each time?
> 
> Will
