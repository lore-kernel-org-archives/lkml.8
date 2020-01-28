Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95474C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B9E214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgA1Qxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 11:53:38 -0500
Received: from foss.arm.com ([217.140.110.172]:60554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgA1Qxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 11:53:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E615A328;
        Tue, 28 Jan 2020 08:53:36 -0800 (PST)
Received: from localhost (unknown [10.1.198.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8709A3F52E;
        Tue, 28 Jan 2020 08:53:36 -0800 (PST)
Date:   Tue, 28 Jan 2020 16:53:35 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com, peterz@infradead.org, mingo@redhat.com,
        ggherdovich@suse.cz, vincent.guittot@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 4/6] Documentation: arm64: document support for the
 AMU extension
Message-ID: <20200128165325.GA16417@arm.com>
References: <20191218182607.21607-1-ionela.voinescu@arm.com>
 <20191218182607.21607-5-ionela.voinescu@arm.com>
 <b63b6f10-22c8-79be-cc97-08484874bd62@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b63b6f10-22c8-79be-cc97-08484874bd62@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 Jan 2020 at 16:47:29 (+0000), Valentin Schneider wrote:
> On 18/12/2019 18:26, Ionela Voinescu wrote:
> > +Basic support
> > +-------------
> > +
> > +The kernel can safely run a mix of CPUs with and without support for the
> > +activity monitors extension. Therefore, when CONFIG_ARM64_AMU_EXTN is
> > +selected we unconditionally enable the capability to allow any late CPU
> > +(secondary or hotplugged) to detect and use the feature.
> > +
> > +When the feature is detected on a CPU, a per-CPU variable (amu_feat) is
> > +set, but this does not guarantee the correct functionality of the
> > +counters, only the presence of the extension.
> > +
> > +Firmware (code running at higher exception levels, e.g. arm-tf) support is
> > +needed to:
> > + - Enable access for lower exception levels (EL2 and EL1) to the AMU
> > +   registers.
> > + - Enable the counters. If not enabled these will read as 0.
> 
> Just to make sure I understand - if AMUs are physically present but not
> enabled by FW, we'll still
> - see them as implemented in ID_AA64PFR0_EL1.AMU

Yes, this feature register only shows the physical presence on the unit
in hardware.

> - see some counters as available with e.g. AMCGCR_ELO.CG0NC > 0
> 

Yes, the same as above, this only shows their physical presence. For
AMUv1 - AMCGCR_ELO.CG0NC: the value of this field is set to 4.
AMCGCR_ELO.CG1NC will show the number of auxiliary counters implemented
in hardware.

> But reading some AMEVCNTR<g><n> will return 0?

Or you won't be able to access them at all. Lacking firmware support
accesses to AMU registers could be trapped in EL3. If access for EL1 and
EL2 is enabled from EL3, it's still possible that the counters
themselves are not enabled - that means they are not enabled to count
the events they are designed to be counting. That's why in this case the
event counter register could read 0.

But if we read 0, it does not necessarily mean that the counter is
disabled. It could also mean that the events is meant to count did not
happen yet.

> 
> > + - Save/restore the counters before/after the CPU is being put/brought up
> > +   from the 'off' power state.
> > +
> > +When using kernels that have this configuration enabled but boot with
> > +broken firmware the user may experience panics or lockups when accessing
> > +the counter registers.
> 
> Yikes
> 
> > Even if these symptoms are not observed, the
> > +values returned by the register reads might not correctly reflect reality.
> > +Most commonly, the counters will read as 0, indicating that they are not
> > +enabled. If proper support is not provided in firmware it's best to disable
> > +CONFIG_ARM64_AMU_EXTN.
> > +
> 
> I haven't seen something that would try to catch this on the kernel side.
> Can we try to detect that (e.g. at least one counter returns > 0) in
> cpu_amu_enable() and thus not write to the CPU-local 'amu_feat'?
> 

I'm reluctant to do this especially given that platforms might choose to
keep some counters disabled while enabling some counters that might not
have counted any events by the time we reach cpu_enable. We would end up
mistakenly disabling the feature. I would rather leave the validation of
the counters to be done at the location and for the purpose of their
use: see patch 6/6 - the use of counters for frequency invariance.

> While we're on the topic of detecting broken stuff, what if some CPUs
> implement some auxiliary counters that some others don't?
> 

I think it should be up to the user of that counter to decide if the
usecase is at CPU level or system level. My intention of this base
support was to keep it simple and allow users of some counters to
decide on their own how to validate and make use of either architected
or auxiliary counters.

For example, in the case of frequency invariance, given a platform that
does not support cpufreq based invariance, I would validate all CPUs for
the use of AMU core and constant counters. If it happens that some CPUs
do not support those counters or they are not enabled, we'd have to
disable frequency invariance at system level.

For some other scenarios only partial support is needed - only a subset
of CPUs need to support the counters for their use to be feasible.

But I believe only the user of the counters can decide, whether this is
happening in architecture code, driver code, generic code.

> > +The fixed counters of AMUv1 are accessible though the following system
> > +register definitions:
> > + - SYS_AMEVCNTR0_CORE_EL0
> > + - SYS_AMEVCNTR0_CONST_EL0
> > + - SYS_AMEVCNTR0_INST_RET_EL0
> > + - SYS_AMEVCNTR0_MEM_STALL_EL0
> > +
> > +Auxiliary platform specific counters can be accessed using
> > +SYS_AMEVCNTR1_EL0(n), where n is a value between 0 and 15.
> > +
> > +Details can be found in: arch/arm64/include/asm/sysreg.h.
> > +
> > diff --git a/Documentation/arm64/booting.rst b/Documentation/arm64/booting.rst
> > index 5d78a6f5b0ae..a3f1a47b6f1c 100644
> > --- a/Documentation/arm64/booting.rst
> > +++ b/Documentation/arm64/booting.rst
> > @@ -248,6 +248,20 @@ Before jumping into the kernel, the following conditions must be met:
> >      - HCR_EL2.APK (bit 40) must be initialised to 0b1
> >      - HCR_EL2.API (bit 41) must be initialised to 0b1
> >  
> > +  For CPUs with Activity Monitors Unit v1 (AMUv1) extension present:
> > +  - If EL3 is present:
> > +    CPTR_EL3.TAM (bit 30) must be initialised to 0b0
> > +    CPTR_EL2.TAM (bit 30) must be initialised to 0b0
> > +    AMCNTENSET0_EL0 must be initialised to 0b1111
> 
> Nit: Or be a superset of the above, right? AIUI v1 only mandates the lower
> 4 bits to be set. Probably doesn't matter that much...
> 

Right! This is more of a guideline: it can be a subset as well, if
platforms don't want some counters enabled. It can set the lower 4 bits
for enablement of all 4 architecture counters for v1, or more for future
versions with more architected counters.

Thanks,
Ionela.


