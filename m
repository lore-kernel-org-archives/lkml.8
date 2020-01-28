Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43369C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8D5214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgA1R0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 12:26:43 -0500
Received: from foss.arm.com ([217.140.110.172]:60968 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgA1R0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 12:26:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 496B9328;
        Tue, 28 Jan 2020 09:26:42 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47B503F52E;
        Tue, 28 Jan 2020 09:26:40 -0800 (PST)
Subject: Re: [PATCH v2 3/6] arm64/kvm: disable access to AMU registers from
 kvm guests
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, sudeep.holla@arm.com, dietmar.eggemann@arm.com
Cc:     peterz@infradead.org, mingo@redhat.com, ggherdovich@suse.cz,
        vincent.guittot@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>
References: <20191218182607.21607-1-ionela.voinescu@arm.com>
 <20191218182607.21607-4-ionela.voinescu@arm.com>
 <bc3f582c-9aed-8052-d0cb-b39c76c8ce73@arm.com>
From:   Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
Message-ID: <0690745f-fa38-f623-30a5-42d0eadfb668@arm.com>
Date:   Tue, 28 Jan 2020 17:26:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <bc3f582c-9aed-8052-d0cb-b39c76c8ce73@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2020 15:33, Valentin Schneider wrote:
> On 18/12/2019 18:26, Ionela Voinescu wrote:
>> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
>> index 6e5d839f42b5..dd20fb185d56 100644
>> --- a/arch/arm64/include/asm/kvm_arm.h
>> +++ b/arch/arm64/include/asm/kvm_arm.h
>> @@ -266,10 +266,11 @@
>>   #define CPTR_EL2_TFP_SHIFT 10
>>   
>>   /* Hyp Coprocessor Trap Register */
>> -#define CPTR_EL2_TCPAC	(1 << 31)
>> -#define CPTR_EL2_TTA	(1 << 20)
>> -#define CPTR_EL2_TFP	(1 << CPTR_EL2_TFP_SHIFT)
>>   #define CPTR_EL2_TZ	(1 << 8)
>> +#define CPTR_EL2_TFP	(1 << CPTR_EL2_TFP_SHIFT)
>> +#define CPTR_EL2_TTA	(1 << 20)
>> +#define CPTR_EL2_TAM	(1 << 30)
>> +#define CPTR_EL2_TCPAC	(1 << 31)
> 
> Nit: why the #define movement? Couldn't that just be added beneath
> CPTR_EL2_TCPAC?
> 
>>   #define CPTR_EL2_RES1	0x000032ff /* known RES1 bits in CPTR_EL2 */
>>   #define CPTR_EL2_DEFAULT	CPTR_EL2_RES1
>>   
>> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
>> index 72fbbd86eb5e..0bca87a2621f 100644
>> --- a/arch/arm64/kvm/hyp/switch.c
>> +++ b/arch/arm64/kvm/hyp/switch.c
>> @@ -90,6 +90,17 @@ static void activate_traps_vhe(struct kvm_vcpu *vcpu)
>>   	val = read_sysreg(cpacr_el1);
>>   	val |= CPACR_EL1_TTA;
>>   	val &= ~CPACR_EL1_ZEN;
>> +
>> +	/*
>> +	 * With VHE enabled, we have HCR_EL2.{E2H,TGE} = {1,1}. Note that in
>> +	 * this case CPACR_EL1 has the same bit layout as CPTR_EL2, and
>> +	 * CPACR_EL1 accessing instructions are redefined to access CPTR_EL2.
>> +	 * Therefore use CPTR_EL2.TAM bit reference to activate AMU register
>> +	 * traps.
>> +	 */
>> +
>> +	val |= CPTR_EL2_TAM;
>> +
> 
> Hmm so this is a bit confusing for me, I've rewritten that part of the
> email too many times (didn't help that I'm far from being a virt guru).
> Rectifications are most welcome.
> 
> 
> First, AFAICT we *don't* have HCR_EL2.TGE set anymore at this point, it's
> cleared just a bit earlier in __activate_traps().
> 
> 
> Then, your comment suggests that when we're running this code, CPACR_EL1
> accesses are rerouted to CPTR_EL2. Annoyingly this isn't mentioned in
> the doc of CPACR_EL1, but D5.6.3 does say
> 
> """
> When ARMv8.1-VHE is implemented, and HCR_EL2.E2H is set to 1, when executing
> at EL2, some EL1 System register access instructions are redefined to access
> the equivalent EL2 register.
> """
> 
> And CPACR_EL1 is part of these, so far so good. Now, the thing is
> the doc for CPACR_EL1 *doesn't* mention any TAM bit - but CPTR_EL2 does.
> I believe what *do* want here is to set CPTR_EL2.TAM (which IIUC we end
> up doing via the rerouting).
> 
> So, providing I didn't get completely lost on the way, I have to ask:
> why do we use CPACR_EL1 here? Couldn't we use CPTR_EL2 directly?

Part of the reason is, CPTR_EL2 has different layout depending on
whether HCR_EL2.E2H == 1. e.g, CPTR_EL2.TTA move from Bit[28] to Bit[20].

So, to keep it simple, CPTR_EL2 is used for non-VHE code with the shifts
as defined by the "CPTR_EL2 when E2H=0"

if E2H == 1, CPTR_EL2 takes the layout of CPACR_EL1 and "overrides" some
of the RES0 bits in CPACR_EL1 with EL2 controls (e.g: TAM, TCPAC).
Thus we use CPACR_EL1 to keep the "shifts" non-conflicting (e.g, ZEN)
and is the right thing to do.

It is a bit confusing, but we are doing the right thing. May be we could 
improve the comment like :

	/*
	 * With VHE (HCR.E2H == 1), CPTR_EL2 has the same layout as
	 * CPACR_EL1, except for some missing controls, such as TAM.
	 * And accesses to CPACR_EL1 are routed to CPTR_EL2.
	 * Also CPTR_EL2.TAM has the same position with or without
	 * HCR.E2H == 1. Therefore, use CPTR_EL2.TAM here for
	 * trapping the AMU accesses.
	 */

Suzuki
