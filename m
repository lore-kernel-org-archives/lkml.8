Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98019C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 726B2206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbgELK4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 06:56:20 -0400
Received: from foss.arm.com ([217.140.110.172]:52338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgELK4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 06:56:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A26A530E;
        Tue, 12 May 2020 03:56:19 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.28.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD7243F71E;
        Tue, 12 May 2020 03:56:17 -0700 (PDT)
Date:   Tue, 12 May 2020 11:56:14 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH] arm64/cpufeature: Add ID_AA64MMFR0_PARANGE_MASK
Message-ID: <20200512105614.GC60359@C02TD0UTHF1T.local>
References: <1589249606-27177-1-git-send-email-anshuman.khandual@arm.com>
 <20200512105343.GB60359@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512105343.GB60359@C02TD0UTHF1T.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 11:53:43AM +0100, Mark Rutland wrote:
> >
> >  	/* Clamp the IPA limit to the PA size supported by the kernel */
> >  	ipa_max = (pa_max > PHYS_MASK_SHIFT) ? PHYS_MASK_SHIFT : pa_max;
> > @@ -411,7 +411,8 @@ int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long type)
> >  		phys_shift = KVM_PHYS_SHIFT;
> >  	}
> >  
> > -	parange = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1) & 7;
> > +	parange = id_aa64mmfr0_parange(read_sanitised_ftr_reg
> > +						(SYS_ID_AA64MMFR0_EL1));
> 
> Can't we add a system_ipa_range() helper, and avoid more boilerplate in
> each of these?
> 
> e.g.
> 
> int system_ipa_range(void)
> {
> 	u64 mmfr0;
> 	int parange;
> 
> 	mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
> 	parange = cpuid_feature_extract_unsigned_field(mmfr0,
> 		ID_AA64MMFR0_PARANGE_SHIFT);
> 	
> 	return parange;
> }

As Per MarcZ's comments, that should be system_pa_range() rather than
system_ipa_range().

Mark.
