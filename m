Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A45C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 10:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8108320B80
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 10:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbgE0KTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 06:19:36 -0400
Received: from foss.arm.com ([217.140.110.172]:35684 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbgE0KTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 06:19:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1118B55D;
        Wed, 27 May 2020 03:19:33 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8FEB3F6C4;
        Wed, 27 May 2020 03:19:31 -0700 (PDT)
Date:   Wed, 27 May 2020 11:19:29 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Keno Fischer <keno@juliacomputing.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kyle Huey <khuey@pernos.co>, Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: arm64: Register modification during syscall entry/exit stop
Message-ID: <20200527101929.GT5031@arm.com>
References: <CABV8kRz0mKSc=u1LeonQSLroKJLOKWOWktCoGji2nvEBc=e7=w@mail.gmail.com>
 <20200519081551.GA9980@willie-the-truck>
 <CABV8kRzYzBrdzC1_opmmdpW63N2htfOsAUZ+RjiSDsy=SJW6Yg@mail.gmail.com>
 <20200520174149.GB27629@willie-the-truck>
 <CABV8kRzjCCsjVeRsBD7U_Lo0==sBw9EKm=1z7g=60KyJvJLZBQ@mail.gmail.com>
 <CABV8kRxfet2RXXNcUoTKwfVzFWEQfxAkXUX4M5XhkP3nc-0+rQ@mail.gmail.com>
 <20200527095528.GC11111@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527095528.GC11111@willie-the-truck>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 10:55:29AM +0100, Will Deacon wrote:
> On Sun, May 24, 2020 at 02:56:35AM -0400, Keno Fischer wrote:
> > Just ran into this issue again, with what I think may be most compelling
> > example yet why this is problematic:
> > 
> > The tracee incurred a signal, we PTRACE_SYSEMU'd to the rt_sigreturn,
> > which the tracer tried to emulate by applying the state from the signal frame.
> > However, the PTRACE_SYSEMU stop is a syscall-stop, so the tracer's write
> > to x7 was ignored and x7 retained the value it had in the signal handler,
> > which broke the tracee.
> 
> Yeah, that sounds like a good justification to add a way to stop this. Could
> you send a patch, please?
> 
> Interestingly, I *thought* the current behaviour was needed by strace, but I
> can't find anything there that seems to require it. Oh well, we're stuck
> with it anyway.

The fact that PTRACE_SYSEMU is only implemented for a few arches makes
we wonder whether it was a misguided addition that should not be ported
to new arches... i.e., why does hardly anyone need it?  But I haven't
attempted to understand the history.

Can't PTRACE_SYSEMU be emulated by using PTRACE_SYSCALL, cancelling the
syscall at the syscall enter stop, then modifying the regs at the
syscall exit stop?


If SYSEMU was obviously always broken, perhaps we can withdraw support
for it.  Assuming nobody is crazy enough to try to emulate execve() I
can't see anything other than sigreturn that would be affected by this
issue though.  So maybe SYSEMU isn't broken enough to justify
withdrawal.

Cheers
---Dave
