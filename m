Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FA3C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 09:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6F5215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 09:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgAaJyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 04:54:15 -0500
Received: from foss.arm.com ([217.140.110.172]:33594 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbgAaJyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 04:54:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21ACA31B;
        Fri, 31 Jan 2020 01:54:14 -0800 (PST)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.198.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B88FC3F68E;
        Fri, 31 Jan 2020 01:54:13 -0800 (PST)
Date:   Fri, 31 Jan 2020 09:54:12 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, sudeep.holla@arm.com, dietmar.eggemann@arm.com,
        peterz@infradead.org, mingo@redhat.com, ggherdovich@suse.cz,
        vincent.guittot@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 4/6] Documentation: arm64: document support for the
 AMU extension
Message-ID: <20200131095412.GA17655@arm.com>
References: <20191218182607.21607-1-ionela.voinescu@arm.com>
 <20191218182607.21607-5-ionela.voinescu@arm.com>
 <c9f80a08-7f0d-59e9-eb90-466b1314e1f1@arm.com>
 <20200130164542.GC5208@arm.com>
 <20200130182653.GA123407@ewhatever.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130182653.GA123407@ewhatever.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 Jan 2020 at 18:26:53 (+0000), Suzuki K Poulose wrote:
[..]
> > > > +Firmware (code running at higher exception levels, e.g. arm-tf) support is
> > > > +needed to:
> > > > + - Enable access for lower exception levels (EL2 and EL1) to the AMU
> > > > +   registers.
> > > > + - Enable the counters. If not enabled these will read as 0.
> > > > + - Save/restore the counters before/after the CPU is being put/brought up
> > > > +   from the 'off' power state.
> > > > +
> > > > +When using kernels that have this configuration enabled but boot with
> > > > +broken firmware the user may experience panics or lockups when accessing
> > > > +the counter registers. Even if these symptoms are not observed, the
> > > > +values returned by the register reads might not correctly reflect reality.
> > > > +Most commonly, the counters will read as 0, indicating that they are not
> > > > +enabled. If proper support is not provided in firmware it's best to disable
> > > > +CONFIG_ARM64_AMU_EXTN.
> > > 
> > > For the sake of one kernel runs everywhere, do we need some other
> > > mechanism to disable the AMU. e.g kernel parameter to disable amu
> > > at runtime ?
> > >
> > 
> > The reason I've not added this is twofold:
> >  - Even if we add this, it should be in order to disable the use of the
> >    counters for a certain purpose, in this case  frequency invariance.
> >    On its own AMU provides the counters but it does not mandate their
> >    use.
> >  - I could add something to disable the use of the core and cycle
> >    counters for frequency invariance at runtime, but I doubt that
> >    anyone would use it. Logically it makes sense to use the counters
> >    order to have a more accurate view of the performance that the CPUs
> >    are actually providing. Therefore, until anyone asks for this, I
> >    thought it's better to keep it simple and not add extra switches,
> >    until there is a use for them.
> > 
> > Does it make sense?
> 
> The comment is about addressing someone who must run an "AMU" enabled
> kernel ("one kernel") on a system with potentially "broken firmware",
> where there is no option to use the system as you mention above,
> the firmware could panic. How common is the "broken firmware" ?
> Right now there is no way to ensure "firmware" is sane and if
> someone detects that firmware is broken, there is no way to
> disable the AMU if they are running a standard distro kernel.
> A kernel parameter could prevent the AMU capability from
> being detected on a broken system and thus make it usable
> (without the AMU of course). Now, if the "broken firmware"
> is extremely rare, we could simply ignore this case and
> ignore the suggestion.
> 
> Suzuki
> 
>

Sorry Suzuki, I initially interpreted the question independently from
the context and only thought about cases where they are working
correctly but users might want to disable the use of them.

In this case, I don't see any harm in adding a command line parameter
to disable the use of the unit, even if it's only to support firmware
that does not support AMU at all, rather than the implementation being
broken.

I'm not really sure how common bad firmware would be. I suppose that
firmware as bad as to cause firmware panics and lockups would be quite
rare, but scenarios where firmware might not properly support AMU and
result in kernel lockups could be more often, and this would handle
both.

Thank you,
Ionela.
