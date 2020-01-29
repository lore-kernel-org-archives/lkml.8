Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14622C35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 16:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEBE7207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 16:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgA2Qmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 11:42:45 -0500
Received: from foss.arm.com ([217.140.110.172]:43508 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbgA2Qmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 11:42:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A1D1328;
        Wed, 29 Jan 2020 08:42:44 -0800 (PST)
Received: from localhost (unknown [10.1.198.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD8723F52E;
        Wed, 29 Jan 2020 08:42:43 -0800 (PST)
Date:   Wed, 29 Jan 2020 16:42:42 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, sudeep.holla@arm.com, dietmar.eggemann@arm.com,
        peterz@infradead.org, mingo@redhat.com, ggherdovich@suse.cz,
        vincent.guittot@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] arm64: add support for the AMU extension v1
Message-ID: <20200129164242.GA5251@arm.com>
References: <20191218182607.21607-1-ionela.voinescu@arm.com>
 <20191218182607.21607-2-ionela.voinescu@arm.com>
 <2b62c575-3396-3332-2e39-1c3cce2c4bf0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b62c575-3396-3332-2e39-1c3cce2c4bf0@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Tuesday 28 Jan 2020 at 16:34:24 (+0000), Suzuki Kuruppassery Poulose wrote:
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -156,6 +156,7 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
> >   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_CSV3_SHIFT, 4, 0),
> >   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_CSV2_SHIFT, 4, 0),
> >   	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_DIT_SHIFT, 4, 0),
> > +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_AMU_SHIFT, 4, 0),
> >   	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
> >   				   FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_SVE_SHIFT, 4, 0),
> >   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_RAS_SHIFT, 4, 0),
> > @@ -314,10 +315,11 @@ static const struct arm64_ftr_bits ftr_id_mmfr4[] = {
> >   };
> >   static const struct arm64_ftr_bits ftr_id_pfr0[] = {
> > -	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 12, 4, 0),		/* State3 */
> > -	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 8, 4, 0),		/* State2 */
> > -	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 4, 4, 0),		/* State1 */
> > -	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),		/* State0 */
> > +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR0_AMU_SHIFT, 4, 0),
> 
> Why is this STRICT while the aa64pfr0 field is NON_STRICT ? On the other
> hand, do we need this entry ? Do we plan to support 32bit guests using
> AMU counters ? If we do, we may need to cap this field for the guests.
>

No, we do not need this entry at all. This is an artifact left from
testing which I'll remove. The ID register is already modified to hide
the presence of AMU for both 32bit and 64bit guests (patch 3/6), and
this was supposed to be here just to validate that the capping of this
field for the guest does its job.

> Also, fyi, please note that there may be conflicts with another series from
> Anshuman which cleans up the tables and "naming" the shifts. [1].
> [1] purposefully hides the AMU from ID_PFR0 due to the above reasoning.
> 

Thanks, that's fine.

> > +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR0_STATE3_SHIFT, 4, 0),
> > +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR0_STATE2_SHIFT, 4, 0),
> > +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR0_STATE1_SHIFT, 4, 0),
> > +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR0_STATE0_SHIFT, 4, 0),
> >   	ARM64_FTR_END,
> >   };
> > @@ -1150,6 +1152,59 @@ static bool has_hw_dbm(const struct arm64_cpu_capabilities *cap,
> >   #endif
> > +#ifdef CONFIG_ARM64_AMU_EXTN
> > +
> > +/*
> > + * This per cpu variable only signals that the CPU implementation supports
> > + * the Activity Monitors Unit (AMU) but does not provide information
> > + * regarding all the events that it supports.
> > + * When this amu_feat per CPU variable is true, the user of this feature
> > + * can only rely on the presence of the 4 fixed counters. But this does
> > + * not guarantee that the counters are enabled or access to these counters
> > + * is provided by code executed at higher exception levels.
> > + *
> > + * Also, to ensure the safe use of this per_cpu variable, the following
> > + * accessor is defined to allow a read of amu_feat for the current cpu only
> > + * from the current cpu.
> > + *  - cpu_has_amu_feat()
> > + */
> > +static DEFINE_PER_CPU_READ_MOSTLY(u8, amu_feat);
> > +
> > +inline bool cpu_has_amu_feat(void)
> > +{
> > +	return !!this_cpu_read(amu_feat);
> > +}
> > +
> 
> minor nit: Or you may use a cpumask_t set of CPUs where AMU is
> available. But if you plan to extend this for the future AMU version
> tracking the mask may not be sufficient.
> 

To be honest, I would like not to have to use information about AMU
version for future support, but yes, it would be good to have the
possibility, just in case.


> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2020-January/708287.html
> 
> 
> The rest looks fine to me.
> 
> Suzuki

Thank you very much for the review,
Ionela.

