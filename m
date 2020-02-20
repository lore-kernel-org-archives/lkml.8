Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AF2C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2332208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTnuxR+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgBTOwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:52:45 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35066 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgBTOwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:52:45 -0500
Received: by mail-ot1-f68.google.com with SMTP id r16so3906289otd.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 06:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ruUmygpf8QCjfu34nMcSDGM6EDwQPFTRaM8IJBhZen8=;
        b=dTnuxR+eUuIu4S7sDbgxXpdjqVnSFgPzc9ey4H716TSiVverRY7ZqA81CpEiVGUNla
         7itkAfa4vqAXnm0ggu8mgXbjBjIZ6jXyyv/xM9kCk7rvltmryfO9vijwj4Ubt/wSaAQ1
         ylZh/7hdAUPS06Rmz45D/Ud48SjlXASl69EGZV0rF/MtlYriifQYk0JvhOct+xYX76C8
         K3eQBGHzn1yRW9OzSwDhE+h/X1qJph9gtC8x0UrHK0q48Slt3zFCnVSfCLet0GDz5eQT
         Hn4ZFMFVB0uZMDW0AY3eRFyVYN5grE2/OaCdemA7UC3Z28Jx3CIfUPJkQ2+X0PVcJ+fY
         vzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=ruUmygpf8QCjfu34nMcSDGM6EDwQPFTRaM8IJBhZen8=;
        b=jBS/gvLG1ZNF3id5rJvj0f1ob02sl9BNV10ur3sMKUe1cJaFwAZR16UpWK6FKPqORS
         e1hRvRS87xs/ooiDWEMlnyun05fas1SPAgJAeaL6ZBZh6+SEGaarGTAFM/yqlt9Yj7pb
         pFpgKRLKeNcgMiuPZHsYM21aGw8nqprGwtE/YLBzf4xsMIwayd3j6evGqYLdxuzU2G0W
         9jRpOm2KKQd65GIG15izCONinMdf2GHyOU5JSoBp8U4GQxRkmQiJYj4pblxMQtsyFo1U
         FqsQTw6C4WgbmW2PSzW9XRcfIoOML70z5yxinyDUHbpTPSKd9sXgJfgpdbwYz4JCODO6
         qw3A==
X-Gm-Message-State: APjAAAUEdhscO2z/kTDffBnCzJQIEeqx397mclkHeTYltU9+SUoNhx1V
        bDCHHhYF2H0RmkxX/5WnUw==
X-Google-Smtp-Source: APXvYqzyqnENE3eP8zr8E5aDqLDohv0k1LPbBaSUEXxDW7U+hsdlG2ITJkIh2etWhmO0VwZR73qIRw==
X-Received: by 2002:a9d:7548:: with SMTP id b8mr24897663otl.74.1582210364006;
        Thu, 20 Feb 2020 06:52:44 -0800 (PST)
Received: from serve.minyard.net ([47.184.136.59])
        by smtp.gmail.com with ESMTPSA id c7sm1209251otm.63.2020.02.20.06.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 06:52:43 -0800 (PST)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:9129:b2b8:445c:a4ff])
        by serve.minyard.net (Postfix) with ESMTPSA id 1D63718000D;
        Thu, 20 Feb 2020 14:52:43 +0000 (UTC)
Date:   Thu, 20 Feb 2020 08:52:41 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH v2] arm64:kgdb: Fix kernel single-stepping
Message-ID: <20200220145241.GI3704@minyard.net>
Reply-To: minyard@acm.org
References: <20200219152403.3495-1-minyard@acm.org>
 <20200220140650.tryvv3ishkxduujk@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220140650.tryvv3ishkxduujk@holly.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 02:06:50PM +0000, Daniel Thompson wrote:
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
> > 
> > However, I appear to not be the first person who has noticed this.  In
> > the el0-only portion of the kernel_entry macro in entry.S, I found the
> > following comment: "Ensure MDSCR_EL1.SS is clear, since we can unmask
> > debug exceptions when scheduling."  Exactly the same scenario, except
> > coming from a userland single step, not a kernel one.
> > 
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
> > 
> > To fix both these problems, rework the handling of single steps to clear
> > things out upon entry to the kernel from el1, and then to set up single
> > step when returning to el1, and not do the setup in debug-monitors.c.
> > This means that single stepping does not use
> > enable/disable_debug_monitors(); it is no longer necessary to track
> > those flags for single stepping.  This is much like single stepping is
> > handled for el0.  A new flag is added in pt_regs to enable single
> > stepping from el1.  Unfortunately, the old value of PSTATE.SS cannot be
> > used for this because of the hardware bug mentioned earlier.
> > 
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
> > * The exception handling hits a breakpoint and stops.
> > * The user continues from the breakpoint, so the kernel is no longer
> >   expecting a single step.
> > * On the return from the first exception, the single step flag in
> >   pt_regs is still set, so a single step trap happens.
> > * The kernel keels over from an unexpected single step.
> > 
> > There's no easy way to find the pt_regs that has the single step flag
> > set.  So a thread info flag was added so that the single step could be
> > disabled in this case.  Both that flag and the flag in pt_regs must be
> > set to enable a single step.
> > 
> > Signed-off-by: Corey Minyard <cminyard@mvista.com>
> 
> I've pointed the kgdbtest suite at this patch (and run one of the
> historically unstable test cases an extra 100 times just in case).
> 
> kgdbtest hasn't got great coverage, runs the code in qemu and some
> of the strongest tests are still marked XFAIL on arm64 (for reasons
> unrelated to stepping).
> 
> So the best I can say based on the above is that the test suite does not
> observe any regression (but equally no improvement). Nevertheless FWIW:

Thanks for testing this.  This is not a surprise, you would either have
to have a broken processor like the one I'm using, or you would have to
have a migration occur on the instruction being single-stepped, which
would be extremely unlikely.

Since I've already gained some experience here, I'll try to look at
fixing things here for ARM64.

-corey

> 
> 
> Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> 
> Daniel.
