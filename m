Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AE6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DFF9206F1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgFAJwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:52:37 -0400
Received: from foss.arm.com ([217.140.110.172]:35746 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbgFAJw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:52:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CD871FB;
        Mon,  1 Jun 2020 02:52:26 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 512B33F305;
        Mon,  1 Jun 2020 02:52:25 -0700 (PDT)
Date:   Mon, 1 Jun 2020 10:52:23 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Keno Fischer <keno@juliacomputing.com>
Cc:     Kyle Huey <khuey@pernos.co>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: arm64: Register modification during syscall entry/exit stop
Message-ID: <20200601095222.GY5031@arm.com>
References: <CABV8kRzYzBrdzC1_opmmdpW63N2htfOsAUZ+RjiSDsy=SJW6Yg@mail.gmail.com>
 <20200520174149.GB27629@willie-the-truck>
 <CABV8kRzjCCsjVeRsBD7U_Lo0==sBw9EKm=1z7g=60KyJvJLZBQ@mail.gmail.com>
 <CABV8kRxfet2RXXNcUoTKwfVzFWEQfxAkXUX4M5XhkP3nc-0+rQ@mail.gmail.com>
 <20200527095528.GC11111@willie-the-truck>
 <20200527101929.GT5031@arm.com>
 <20200531093320.GA30204@willie-the-truck>
 <CABV8kRyHo+EAWaMUzGA220z=HJRBCpH6UWiYGb84uSL3h8HQHw@mail.gmail.com>
 <20200601091441.GW5031@arm.com>
 <CABV8kRz2ineTcLS29Lh=BW_kJB_X7PoqY-MaMj_pUUziOxrYCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABV8kRz2ineTcLS29Lh=BW_kJB_X7PoqY-MaMj_pUUziOxrYCw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 05:23:01AM -0400, Keno Fischer wrote:
> On Mon, Jun 1, 2020 at 5:14 AM Dave Martin <Dave.Martin@arm.com> wrote:
> > Can you explain why userspace would write a changed value for x7
> > but at the same time need that new to be thrown away?
> 
> The discarding behavior is the primary reason things aren't completely
> broken at the moment. If it read the wrong x7 value and didn't know about
> the Aarch64 quirk, it's often just trying to write that same wrong
> value back during the next stop, so if that's just ignored,
> that's probably fine in 99% of cases, since the value in the
> tracee will be undisturbed.

I guess that's my question: when is x7 "disturbed".

Other than sigreturn, I can't think of a case.

I'm likely missing some aspect of what you're trying to do.

> I don't think there's a sane way to change the aarch64 NT_PRSTATUS
> semantics without just completely removing the x7 behavior, but of course
> people may be relying on that (I think somebody said upthread that strace does?)

Since rt_sigreturn emulation was always broken, can we just say
that the effect of updating any reg other than x0 is unspecified in this
case?

Even fixing the x7 issue won't magically teach your tracer how to
deal with unrecognised data in the signal frame, so new hardware or
a new kernel could cause your tracer to become subtly broken.  Would you
be better off tweaking the real signal frame as desired and doing a real
rt_sigreturn for example, instead of attempting to emulate it?


I'm somewhat playing devil's advocate here...

Cheers
---Dave
