Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEA7C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 11:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863852467E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 11:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgA1LAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 06:00:09 -0500
Received: from foss.arm.com ([217.140.110.172]:55116 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgA1LAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 06:00:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAF1C30E;
        Tue, 28 Jan 2020 03:00:08 -0800 (PST)
Received: from localhost (unknown [10.1.198.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 784D43F52E;
        Tue, 28 Jan 2020 03:00:08 -0800 (PST)
Date:   Tue, 28 Jan 2020 11:00:07 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com, peterz@infradead.org, mingo@redhat.com,
        ggherdovich@suse.cz, vincent.guittot@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] arm64: add support for the AMU extension v1
Message-ID: <20200128110007.GA17411@arm.com>
References: <20191218182607.21607-1-ionela.voinescu@arm.com>
 <20191218182607.21607-2-ionela.voinescu@arm.com>
 <05b1981b-cf4d-d990-5155-6ed3fadcca92@arm.com>
 <20200123183207.GB20475@arm.com>
 <00d852b0-d456-efc3-5bfa-31524168344b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00d852b0-d456-efc3-5bfa-31524168344b@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On Friday 24 Jan 2020 at 12:00:25 (+0000), Valentin Schneider wrote:
> On 23/01/2020 18:32, Ionela Voinescu wrote:
> [...]
> > and later we can use information in
> > AMCGCR_EL0 to get the number of architected counters (n) and
> > AMEVTYPER0<n>_EL0 to find out the type. The same logic would apply to
> > the auxiliary counters.
> > 
> 
> Good, I think that's all we'll really need. I've not gone through the whole
> series (yet!) so I might've missed AMCGCR being used.
>

No, it's not used later in the patches either, specifically because
this is version 1 and we should be able to rely on these first 4
architected counters for all future versions of the AMU implementation.

> >>> @@ -1150,6 +1152,59 @@ static bool has_hw_dbm(const struct arm64_cpu_capabilities *cap,
> >>>  
> >>>  #endif
> >>>  
> >>> +#ifdef CONFIG_ARM64_AMU_EXTN
> >>> +
> >>> +/*
> >>> + * This per cpu variable only signals that the CPU implementation supports
> >>> + * the Activity Monitors Unit (AMU) but does not provide information
> >>> + * regarding all the events that it supports.
> >>> + * When this amu_feat per CPU variable is true, the user of this feature
> >>> + * can only rely on the presence of the 4 fixed counters. But this does
> >>> + * not guarantee that the counters are enabled or access to these counters
> >>> + * is provided by code executed at higher exception levels.
> >>> + *
> >>> + * Also, to ensure the safe use of this per_cpu variable, the following
> >>> + * accessor is defined to allow a read of amu_feat for the current cpu only
> >>> + * from the current cpu.
> >>> + *  - cpu_has_amu_feat()
> >>> + */
> >>> +static DEFINE_PER_CPU_READ_MOSTLY(u8, amu_feat);
> >>> +
> >>
> >> Why not bool?
> >>
> > 
> > I've changed it from bool after a sparse warning about expression using
> > sizeof(bool) and found this is due to sizeof(bool) being compiler
> > dependent. It does not change anything but I thought it might be a good
> > idea to define it as 8-bit unsigned and rely on fixed size.
> > 
> 
> I believe conveying the intent (a truth value) is more important than the
> underlying storage size in this case. It mostly matters when dealing with
> aggregates, but here it's just a free-standing variable.
> 
> We already have a few per-CPU boolean variables in arm64/kernel/fpsimd.c
> and the commits aren't even a year old, so I'd go for ignoring sparse this
> time around.
>

Will do!

Thanks,
Ionela.
