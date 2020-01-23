Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B3CC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 17:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE60C21569
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 17:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgAWRfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 12:35:00 -0500
Received: from foss.arm.com ([217.140.110.172]:42742 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgAWRe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 12:34:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B97A51FB;
        Thu, 23 Jan 2020 09:34:58 -0800 (PST)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.199.79])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A0653F52E;
        Thu, 23 Jan 2020 09:34:58 -0800 (PST)
Date:   Thu, 23 Jan 2020 17:34:56 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com, peterz@infradead.org, mingo@redhat.com,
        ggherdovich@suse.cz, vincent.guittot@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steve Capper <steve.capper@arm.com>
Subject: Re: [PATCH v2 2/6] arm64: trap to EL1 accesses to AMU counters from
 EL0
Message-ID: <20200123173456.GA20475@arm.com>
References: <20191218182607.21607-1-ionela.voinescu@arm.com>
 <20191218182607.21607-3-ionela.voinescu@arm.com>
 <dcecb179-02f1-0608-6a84-5b2dd0bbcdb3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcecb179-02f1-0608-6a84-5b2dd0bbcdb3@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 Jan 2020 at 17:04:32 (+0000), Valentin Schneider wrote:
> On 18/12/2019 18:26, Ionela Voinescu wrote:
> > +/*
> > + * reset_amuserenr_el0 - reset AMUSERENR_EL0 if AMUv1 present
> > + */
> > +	.macro	reset_amuserenr_el0, tmpreg
> > +	mrs	\tmpreg, id_aa64pfr0_el1	// Check ID_AA64PFR0_EL1
> > +	ubfx	\tmpreg, \tmpreg, #ID_AA64PFR0_AMU_SHIFT, #4
> > +	cbz	\tmpreg, 9000f			// Skip if no AMU present
> > +	msr_s	SYS_AMUSERENR_EL0, xzr		// Disable AMU access from EL0
> > +9000:
> 
> AIUI you can steer away from the obscure numbering scheme and define the
> label using the macro counter:
> 
> 	cbz \tmpreg, .Lskip_\@
> 	[...]
> .Lskip_\@:
> 	.endm
> 

Cool, good to know! Although calling it "obscure numbering scheme" does
make it more appealing to use.

Thanks, I'll change it in the next version :).

Ionela.

> 
> > +	.endm
