Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB65C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BF6A2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgFRKoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:44:02 -0400
Received: from foss.arm.com ([217.140.110.172]:47784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbgFRKoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 06:44:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85A7E1045;
        Thu, 18 Jun 2020 03:44:00 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 432363F6CF;
        Thu, 18 Jun 2020 03:43:57 -0700 (PDT)
Subject: Re: [RFC PATCH 1/2] arm64: kvm: Save/restore MTE registers
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
 <20200617123844.29960-2-steven.price@arm.com> <20200617140546.GE5388@gaia>
From:   Steven Price <steven.price@arm.com>
Message-ID: <313f5656-b306-72bb-5804-40d20a2cba1e@arm.com>
Date:   Thu, 18 Jun 2020 11:43:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200617140546.GE5388@gaia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2020 15:05, Catalin Marinas wrote:
> On Wed, Jun 17, 2020 at 01:38:43PM +0100, Steven Price wrote:
>> diff --git a/arch/arm64/kvm/hyp/sysreg-sr.c b/arch/arm64/kvm/hyp/sysreg-sr.c
>> index 75b1925763f1..6ecee1528566 100644
>> --- a/arch/arm64/kvm/hyp/sysreg-sr.c
>> +++ b/arch/arm64/kvm/hyp/sysreg-sr.c
>> @@ -26,6 +26,12 @@
>>   static void __hyp_text __sysreg_save_common_state(struct kvm_cpu_context *ctxt)
>>   {
>>   	ctxt->sys_regs[MDSCR_EL1]	= read_sysreg(mdscr_el1);
>> +	if (system_supports_mte()) {
>> +		ctxt->sys_regs[RGSR_EL1] = read_sysreg_s(SYS_RGSR_EL1);
>> +		ctxt->sys_regs[GCR_EL1] = read_sysreg_s(SYS_GCR_EL1);
>> +		ctxt->sys_regs[TFSRE0_EL1] = read_sysreg_s(SYS_TFSRE0_EL1);
>> +		ctxt->sys_regs[TFSR_EL1] = read_sysreg_s(SYS_TFSR_EL1);
>> +	}
> 
> TFSR_EL1 is not a common register as we have the TFSR_EL2 as well. So
> you'd have to access it as read_sysreg_el1(SYS_TFSR) so that, in the VHE
> case, it generates TFSR_EL12, otherwise you just save the host register.

Ah, thanks for pointing that out - I'd got myself confused with the 
whole VHE _EL12 registers. I'd managed to miss that TFSR is banked.

> Also, since TFSR*_EL1 can be set asynchronously, I think we need to set
> the SCTLR_EL2.ITFSB bit so that the register update is synchronised on
> entry to EL2. With VHE we get this automatically as part of
> SCTLR_EL1_SET but it turns out that we have another SCTLR_ELx_FLAGS
> macro for the non-VHE case (why not calling this SCTLR_EL2_* I have no
> idea).

I hadn't noticed that there was a different set for the non-VHE case 
which was missing ITFSB - I'll update that.

Thanks,

Steve

>>   	/*
>>   	 * The host arm64 Linux uses sp_el0 to point to 'current' and it must
>> @@ -99,6 +105,12 @@ NOKPROBE_SYMBOL(sysreg_save_guest_state_vhe);
>>   static void __hyp_text __sysreg_restore_common_state(struct kvm_cpu_context *ctxt)
>>   {
>>   	write_sysreg(ctxt->sys_regs[MDSCR_EL1],	  mdscr_el1);
>> +	if (system_supports_mte()) {
>> +		write_sysreg_s(ctxt->sys_regs[RGSR_EL1], SYS_RGSR_EL1);
>> +		write_sysreg_s(ctxt->sys_regs[GCR_EL1], SYS_GCR_EL1);
>> +		write_sysreg_s(ctxt->sys_regs[TFSRE0_EL1], SYS_TFSRE0_EL1);
>> +		write_sysreg_s(ctxt->sys_regs[TFSR_EL1], SYS_TFSR_EL1);
>> +	}
> 
> Similarly here, you override the TFSR_EL2 with VHE enabled.
> 

