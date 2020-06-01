Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7E4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A01BD20772
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgFAJ73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:59:29 -0400
Received: from foss.arm.com ([217.140.110.172]:35832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgFAJ73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:59:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 956831FB;
        Mon,  1 Jun 2020 02:59:28 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 799EB3F305;
        Mon,  1 Jun 2020 02:59:27 -0700 (PDT)
Date:   Mon, 1 Jun 2020 10:59:25 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Keno Fischer <keno@juliacomputing.com>
Cc:     Kyle Huey <khuey@pernos.co>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: arm64: Register modification during syscall entry/exit stop
Message-ID: <20200601095925.GZ5031@arm.com>
References: <20200519081551.GA9980@willie-the-truck>
 <CABV8kRzYzBrdzC1_opmmdpW63N2htfOsAUZ+RjiSDsy=SJW6Yg@mail.gmail.com>
 <20200520174149.GB27629@willie-the-truck>
 <CABV8kRzjCCsjVeRsBD7U_Lo0==sBw9EKm=1z7g=60KyJvJLZBQ@mail.gmail.com>
 <CABV8kRxfet2RXXNcUoTKwfVzFWEQfxAkXUX4M5XhkP3nc-0+rQ@mail.gmail.com>
 <20200527095528.GC11111@willie-the-truck>
 <20200527101929.GT5031@arm.com>
 <CABV8kRwhsPhhqUXS46Rwh-xDEDY2q=KSd-xz1W-pu4Gy4KVp8Q@mail.gmail.com>
 <20200601092329.GX5031@arm.com>
 <CABV8kRzkLiVuqxT3+8c1o8m_OuROtXgfowQcrMVnrxu=CiGB=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABV8kRzkLiVuqxT3+8c1o8m_OuROtXgfowQcrMVnrxu=CiGB=w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 05:40:28AM -0400, Keno Fischer wrote:
> On Mon, Jun 1, 2020 at 5:23 AM Dave Martin <Dave.Martin@arm.com> wrote:
> > > > Can't PTRACE_SYSEMU be emulated by using PTRACE_SYSCALL, cancelling the
> > > > syscall at the syscall enter stop, then modifying the regs at the
> > > > syscall exit stop?
> > >
> > > Yes, it can. The idea behind SYSEMU is to be able to save half the
> > > ptrace traps that would require, in theory making the ptracer
> > > a decent amount faster. That said, the x7 issue is orthogonal to
> > > SYSEMU, you'd have the same issues if you used PTRACE_SYSCALL.
> >
> > Right, I just wondered whether there was some deeper difference between
> > the two approaches.
> 
> You're asking about a new regset vs trying to do it via ptrace option?

I meant SYSEMU versus SYSCALL + cancellation and emulating the syscall
at the syscall exit stop.

i.e., I was trying to understand whether SYSEMU is just a convenience,
or does some magic that can't be reproduced by other means.

> I don't think there's anything a ptrace option can do that a new regset
> that replicates the same registers (I'm gonna propose adding orig_x0,
> while we're at it and changing the x0 semantics a bit, will have
> those details with the patch) wouldn't be able to do . The reason I
> originally thought it might have to be a ptrace option is because
> the register modification currently gets applied in the syscall entry
> code to the actual regs struct, so I thought you might have to know
> to preserve those registers. However, then I realized that you could
> just change the regset accessors to emulate the old behavior, since
> we do already store all the required information (what kind of stop
> we're currently at) in order to be able to answer the ptrace
> informational queries. So doing that it probably just all around
> easier. I guess NT_PRSTATUS might also rot, but I guess strace
> doesn't really have to stop using it, since it doesn't care about
> the x7 value nor does it need to modify it.

I think NT_PRSTATUS probably doesn't need to change.

Having a duplicate regset feels like a worse outcome that having a new
ptrace option.  Undocumentedly different things already happen to the
regs depending on how the tracee stopped, so adding a new special case
doesn't seem to justify creating a new regset.

Cheers
---Dave
