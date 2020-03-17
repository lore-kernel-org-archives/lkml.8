Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C74BC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140BB20752
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584458301;
	bh=kPqFh2OC+QYr6S9udTfHPUyXCCUZbCYYP+w4Ykyo5ac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QhJVLMhfngf6CMhk5BiygnMJxBVJ+WKRGsMVcVGsDyyUfCOoO9ckVLS9KXk239A7H
	 EnWXKm8o0osOtPKSZUXUzG2fb0+9gOU6QubVy4cYj0cp53/Z3afS3aIC+urXQojzjo
	 zUygJ02ZGb9e+sPoGEK5tkXT6kl7Nqunl/EiMFUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgCQPSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 11:18:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbgCQPST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 11:18:19 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD79C20714;
        Tue, 17 Mar 2020 15:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584458299;
        bh=kPqFh2OC+QYr6S9udTfHPUyXCCUZbCYYP+w4Ykyo5ac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LUy+OokcgDni5hFal9vNvB6rC6CWzLecLAR9f1XopbpdGlLV9X07U3BWT4J1Jyptv
         +BJnDAuiik5lDTDZCkqpU0RGXJefbmywJuUAg/a8wyiePh7LnOVpvESitpBYCV7A+e
         2DBa1Y8EAPamXkr2ZdZUIVFv/dQQwZOAdMfsZp2Y=
Date:   Tue, 17 Mar 2020 15:18:14 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Hongbo Yao <yaohongbo@huawei.com>,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] arm64: fix the missing ktpi= cmdline check in
 arm64_kernel_unmapped_at_el0()
Message-ID: <20200317151813.GA16579@willie-the-truck>
References: <20200317114708.109283-1-yaohongbo@huawei.com>
 <20200317121050.GH8831@lakrids.cambridge.arm.com>
 <20200317124323.GA16200@willie-the-truck>
 <20200317135719.GH3971@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317135719.GH3971@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 01:57:19PM +0000, Mark Brown wrote:
> On Tue, Mar 17, 2020 at 12:43:24PM +0000, Will Deacon wrote:
> > On Tue, Mar 17, 2020 at 12:10:51PM +0000, Mark Rutland wrote:
> > > On Tue, Mar 17, 2020 at 07:47:08PM +0800, Hongbo Yao wrote:
> 
> > > > Kpti cannot be disabled from the kernel cmdline after the commit
> > > > 09e3c22a("arm64: Use a variable to store non-global mappings decision").
> 
> > > > Bring back the missing check of kpti= command-line option to fix the
> > > > case where the SPE driver complains the missing "kpti-off" even it has
> > > > already been set.
> 
> > > > -	return arm64_use_ng_mappings;
> > > > +	return arm64_use_ng_mappings &&
> > > > +		cpus_have_const_cap(ARM64_UNMAP_KERNEL_AT_EL0);
> > > >  }
> 
> > This probably isn't the right fix, since this will mean that early mappings
> > will be global and we'll have to go through the painful page-table rewrite
> > logic when the cap gets enabled for KASLR-enabled kernels.
> 
> Aren't we looking for a rewrite from non-global to global here (disable
> KPTI where we would otherwise have it), which we don't currently have
> code for?

What I mean is that cpus_have_const_cap() will be false initially, so we'll
put down global mappings early on because PTE_MAYBE_NG will be 0, which
means that we'll have to invoke the rewriting code if we then realise we
want non-global mappings after the caps are finalised.

> > Maybe a better bodge is something like:
> 
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index 0b6715625cf6..ad10f55b7bb9 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -1085,6 +1085,8 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
> >  		if (!__kpti_forced) {
> >  			str = "KASLR";
> >  			__kpti_forced = 1;
> > +		} else if (__kpti_forced < 0) {
> > +			arm64_use_ng_mappings = false;
> >  		}
> >  	}
> 
> That is probably a good idea but I think that runs too late to affect
> the early mappings, they're done based on kaslr_requires_kpti() well
> before we start secondaries.  My first pass not having paged everything
> back in yet is that there needs to be command line parsing in
> kaslr_requires_kpti() but as things stand the command line isn't
> actually ready then...

Yeah, and I think you probably run into chicken and egg problems mapping
the thing. With the change above, it's true that /some/ mappings will
still be nG if you pass kpti=off, but I was hoping that didn't really matter
:)

What was the behaviour prior to your patch? If it used to work without
any nG mappings, then I suppose we should try to restore that behaviour.

Will
