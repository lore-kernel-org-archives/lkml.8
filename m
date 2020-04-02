Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817E0C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530CE20719
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733309AbgDBCon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 22:44:43 -0400
Received: from foss.arm.com ([217.140.110.172]:36418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbgDBCom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 22:44:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 268E330E;
        Wed,  1 Apr 2020 19:44:42 -0700 (PDT)
Received: from [10.163.1.8] (unknown [10.163.1.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE6F93F71E;
        Wed,  1 Apr 2020 19:44:39 -0700 (PDT)
Subject: Re: [PATCH 6/6] arm64/cpufeature: Replace all open bits shift
 encodings with macros
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        mark.rutland@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
References: <1580215149-21492-1-git-send-email-anshuman.khandual@arm.com>
 <1580215149-21492-7-git-send-email-anshuman.khandual@arm.com>
 <caea646f-2a74-115b-ab03-fb1325ed101f@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <5d331165-6d3f-55d3-8994-d736d5fdb3ef@arm.com>
Date:   Thu, 2 Apr 2020 08:14:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <caea646f-2a74-115b-ab03-fb1325ed101f@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/21/2020 12:10 AM, Suzuki K Poulose wrote:
> On 01/28/2020 12:39 PM, Anshuman Khandual wrote:
>> There are many open bits shift encodings for various CPU ID registers that
>> are scattered across cpufeature. This replaces them with register specific
>> sensible macro definitions. This should not have any functional change.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
> 
> 
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -263,7 +263,7 @@ static const struct arm64_ftr_bits ftr_ctr[] = {
>>        * make use of *minLine.
>>        * If we have differing I-cache policies, report it as the weakest - VIPT.
>>        */
>> -    ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_EXACT, 14, 2, ICACHE_POLICY_VIPT),    /* L1Ip */
>> +    ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_EXACT, CTR_L1IP_SHIFT, 2, ICACHE_POLICY_VIPT),    /* L1Ip */
>>       ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, CTR_IMINLINE_SHIFT, 4, 0),
>>       ARM64_FTR_END,
>>   };
>> @@ -274,19 +274,19 @@ struct arm64_ftr_reg arm64_ftr_reg_ctrel0 = {
>>   };
>>     static const struct arm64_ftr_bits ftr_it will not be a good idea to id_mmfr0[] = {
>> -    S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 28, 4, 0xf),    /* InnerShr */
>> -    ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 24, 4, 0),    /* FCSE */
>> -    ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, 20, 4, 0),    /* AuxReg */
>> -    ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 16, 4, 0),    /* TCM */
>> -    ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 12, 4, 0),    /* ShareLvl */
>> -    S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 8, 4, 0xf),    /* OuterShr */
>> -    ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 4, 4, 0),    /* PMSA */
>> -    ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),    /* VMSA */
>> +    S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_MMFR0_INNERSHR_SHIFT, 4, 0xf),
>> +    ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_MMFR0_FCSE_SHIFT, 4, 0),
>> +    ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_MMFR0_AUXREG_SHIFT, 4, 0),
>> +    ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_MMFR0_TCM_SHIFT, 4, 0),
>> +    ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_MMFR0_SHARELVL_SHIFT, 4, 0),
>> +    S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_MMFR0_OUTERSHR_SHIFT, 4, 0xf),
>> +    ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_MMFR0_PMSA_SHIFT, 4, 0),
>> +    ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_MMFR0_VMSA_SHIFT, 4, 0),
>>       ARM64_FTR_END,
>>   };
>>     static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
>> -    ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, 36, 28, 0),
>> +    ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64DFR0_DOUBLELOCK_SHIFT, 28, 0),
> 
> This must be a signed feature, as we have the following possible values :
> 
>     0b0000 - Double lock implemented
>     0b1111 - Double lock not implemented.
> 
> So, in case of a conflict we want the safe value as 0b1111.
> 
> Please could you fix this as well ?

Sure but in a separate patch, as would like to prevent mixing any
actual code change from macro replacement.

> 
> 
> This patch as such looks fine to me.
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
