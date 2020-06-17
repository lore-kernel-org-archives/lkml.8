Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52820C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 15:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B0E2208B8
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 15:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgFQPeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 11:34:21 -0400
Received: from foss.arm.com ([217.140.110.172]:59784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgFQPeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 11:34:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55BD131B;
        Wed, 17 Jun 2020 08:34:20 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9374A3F73C;
        Wed, 17 Jun 2020 08:34:18 -0700 (PDT)
Subject: Re: [RFC PATCH 2/2] arm64: kvm: Introduce MTE VCPU feature
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        James Morse <James.Morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200617123844.29960-1-steven.price@arm.com>
 <20200617123844.29960-3-steven.price@arm.com> <20200617143809.GF5388@gaia>
From:   Steven Price <steven.price@arm.com>
Message-ID: <9d4ef6cf-2333-83b8-c555-e70b99b95b28@arm.com>
Date:   Wed, 17 Jun 2020 16:34:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200617143809.GF5388@gaia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2020 15:38, Catalin Marinas wrote:
> On Wed, Jun 17, 2020 at 01:38:44PM +0100, Steven Price wrote:
>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>> index e3b9ee268823..040a7fffaa93 100644
>> --- a/virt/kvm/arm/mmu.c
>> +++ b/virt/kvm/arm/mmu.c
>> @@ -1783,6 +1783,17 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>   			vma_pagesize = PMD_SIZE;
>>   	}
>>   
>> +	if (system_supports_mte() && kvm->arch.vcpu_has_mte) {
>> +		/*
>> +		 * VM will be able to see the page's tags, so we must ensure
>> +		 * they have been initialised.
>> +		 */
>> +		struct page *page = pfn_to_page(pfn);
>> +
>> +		if (!test_and_set_bit(PG_mte_tagged, &page->flags))
>> +			mte_clear_page_tags(page_address(page), page_size(page));
>> +	}
> 
> Are all the guest pages always mapped via a Stage 2 fault? It may be
> better if we did that via kvm_set_spte_hva().
> 

I was under the impression that pages are always faulted into the stage 
2, but I have to admit I'm not 100% sure about that.

kvm_set_spte_hva() may be more appropriate, although on first look I 
don't understand how that function deals with huge pages. Is it actually 
called for normal mappings or only for changes due to the likes of KSM?

Steve
