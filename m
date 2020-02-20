Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3175C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C719C208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582208541;
	bh=W1XxzghoGomPsmEhrSpUB0orTne/xvHkP5/NBHjVR6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YhpTc2A7kfExzgBNKIlTrDpTFG9vocTAQ5c7q0oykWRh1StnDAh9RpjGFlXGNubHV
	 1QmimZGZdJXtdvVJY8sD/37GMmgGPz6JRovFC0Wat0Kk9WDrR9hk2Kk9BNUxPVu6wg
	 quMRhWoP2gDR2+N5xloEyv97FgSDjYHjiGIRoOZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgBTOWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:22:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:43658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbgBTOWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:22:20 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD9D3207FD;
        Thu, 20 Feb 2020 14:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582208538;
        bh=W1XxzghoGomPsmEhrSpUB0orTne/xvHkP5/NBHjVR6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aukdObaxSVYsNKMVYAMJUK+bIjeopCk3WB0kVw86qSBO96Nc4OpardnPbvs248AlF
         NiOPdcTB6tZmQIVJmTflhGN5trI+GwEIQST54rJZWCWav+lRPvUyxyWtttoYqASXzr
         bt25A9vCnTQHAB6/MklKtQthxtcU641JIWLBpc5Y=
Date:   Thu, 20 Feb 2020 14:22:14 +0000
From:   Will Deacon <will@kernel.org>
To:     minyard@acm.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH v2] arm64:kgdb: Fix kernel single-stepping
Message-ID: <20200220142214.GC14459@willie-the-truck>
References: <20200219152403.3495-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219152403.3495-1-minyard@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 09:24:03AM -0600, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> I was working on a single-step bug on kgdb on an ARM64 system, and I saw
> this scenario:
> 
> * A single step is setup to return to el1
> * The ERET return to el1
> * An interrupt is pending and runs before the instruction
> * As soon as PSTATE.D (the debug disable bit) is cleared, the single
>     step happens in that location, not where it should have.
> 
> This appears to be due to PSTATE.SS not being cleared when the exception
> happens.  Per section D.2.12.5 of the ARMv8 reference manual, that
> appears to be incorrect, it says "As part of exception entry, the PE
> does all of the following: ...  Sets PSTATE.SS to 0."

Sorry, but I don't follow you here. If PSTATE.SS is not cleared, why would
you take the step exception?

> However, I appear to not be the first person who has noticed this.  In
> the el0-only portion of the kernel_entry macro in entry.S, I found the
> following comment: "Ensure MDSCR_EL1.SS is clear, since we can unmask
> debug exceptions when scheduling."  Exactly the same scenario, except
> coming from a userland single step, not a kernel one.

No, I think you might be conflating PSTATE.SS and MDSCR_EL1.SS.

> As I was studying this, though, I realized that the following scenario
> had an issue:
> 
> * Kernel enables MDSCR.SS, MDSCR.KDE, MDSCR.MDE (unnecessary), and
>   PSTATE.SS to enable a single step in el1, for kgdb or kprobes,
>   on the current CPU's MDSCR register and the process' PSTATE.SS
>   register.
> * Kernel returns from the exception with ERET.
> * An interrupt or page fault happens on the instruction, causing the
>   instruction to not be run, but the exception handler runs.
> * The exception causes the task to migrate to a new core.
> * The return from the exception runs on a different processor now,
>   where the MDSCR values are not set up for a single step.
> * The single step fails to happen.
> 
> This is bad for kgdb, of course, but it seems really bad for kprobes if
> this happens.

I don't see how this can happen for kprobes. Have you managed to reproduce
the failure?

> To fix both these problems, rework the handling of single steps to clear
> things out upon entry to the kernel from el1, and then to set up single
> step when returning to el1, and not do the setup in debug-monitors.c.
> This means that single stepping does not use
> enable/disable_debug_monitors(); it is no longer necessary to track
> those flags for single stepping.  This is much like single stepping is
> handled for el0.  A new flag is added in pt_regs to enable single
> stepping from el1.  Unfortunately, the old value of PSTATE.SS cannot be
> used for this because of the hardware bug mentioned earlier.

I don't think there's a hardware bug.

It sound like you're trying to make kernel debugging per-task instead
of per-cpu, but I don't think that's the right thing to do. What if I /want/
to debug an interrupt handler? For example, I might have a watchpoint on
something accessed by timer interrupt.

> As part of this, there is an interaction between single stepping and the
> other users of debug monitors with the MDSCR.KDE bit.  That bit has to
> be set for both hardware breakpoints at el1 and single stepping at el1.
> A new variable was created to store the cpu-wide value of MDSCR.KDE; the
> single stepping code makes sure not to clear that bit on kernel entry if
> it's set in the per-cpu variable.
> 
> After fixing this and doing some more testing, I ran into another issue:
> 
> * Kernel enables the pt_regs single step
> * Kernel returns from the exception with ERET.
> * An interrupt or page fault happens on the instruction, causing the
>   instruction to not be run, but the exception handler runs.

This sounds like you've broken debug; we should take the step exception
in the exception handler. That's the way this is supposed to work.

> There's no easy way to find the pt_regs that has the single step flag
> set.  So a thread info flag was added so that the single step could be
> disabled in this case.  Both that flag and the flag in pt_regs must be
> set to enable a single step.

Honestly, I get the feeling that you don't really understand the code
you're changing here and it's a tonne of effort to try to untangle what
you're doing. That's not necessarily your fault because the debug
architecture is a nightmare to comprehend, but I'm not keen to change it
unless we have a really good justification. I'm sure kgdb is riddled with
bugs but, as I said before, the fixes should be in kgdb, not by tearing
up the low-level debug code (which has the potential to break other users).

Maybe it would be easier if you tried to fix one problem per patch,
preferably with a way to reproduce the issue you're seeing each time?

Will
