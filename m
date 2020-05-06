Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB6AC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B8B7206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgEFGdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 02:33:37 -0400
Received: from foss.arm.com ([217.140.110.172]:56830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726807AbgEFGdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 02:33:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF6FF30E;
        Tue,  5 May 2020 23:33:35 -0700 (PDT)
Received: from [10.163.71.196] (unknown [10.163.71.196])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C737B3F68F;
        Tue,  5 May 2020 23:33:33 -0700 (PDT)
Subject: Re: [PATCH V3 11/16] arm64/cpufeature: Add remaining feature bits in
 ID_AA64PFR1 register
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org
References: <1588426445-24344-1-git-send-email-anshuman.khandual@arm.com>
 <1588426445-24344-12-git-send-email-anshuman.khandual@arm.com>
 <4c6e9f6e-fffa-8fdf-ad1a-f0c6514c3571@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <197bddfb-d63f-7824-63eb-cc38ae729efe@arm.com>
Date:   Wed, 6 May 2020 12:03:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4c6e9f6e-fffa-8fdf-ad1a-f0c6514c3571@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/05/2020 02:54 PM, Suzuki K Poulose wrote:
> On 05/02/2020 02:34 PM, Anshuman Khandual wrote:
>> Enable the following features bits in ID_AA64PFR1 register as per ARM DDI
>> 0487F.a specification.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>>
>> Suggested-by: Will Deacon <will@kernel.org>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   arch/arm64/include/asm/sysreg.h | 4 ++++
>>   arch/arm64/kernel/cpufeature.c  | 4 ++++
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index c93ea6613f51..f1c0d874220a 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -666,7 +666,11 @@
>>   #define ID_AA64PFR0_EL0_32BIT_64BIT    0x2
>>     /* id_aa64pfr1 */
>> +#define ID_AA64PFR1_MPAMFRAC_SHIFT    16
>> +#define ID_AA64PFR1_RASFRAC_SHIFT    12
>> +#define ID_AA64PFR1_MTE_SHIFT        8
>>   #define ID_AA64PFR1_SSBS_SHIFT        4
>> +#define ID_AA64PFR1_BT_SHIFT        0
>>     #define ID_AA64PFR1_SSBS_PSTATE_NI    0
>>   #define ID_AA64PFR1_SSBS_PSTATE_ONLY    1
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index f5a39e040804..181e09d62147 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -233,7 +233,11 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
>>   };
>>     static const struct arm64_ftr_bits ftr_id_aa64pfr1[] = {
>> +    ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_MPAMFRAC_SHIFT, 4, 0),
>> +    ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_RASFRAC_SHIFT, 4, 0),
> 
> These should be hidden as well.

Will change.

> 
>> +    ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_MTE_SHIFT, 4, 0),
>>       ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_SSBS_SHIFT, 4, ID_AA64PFR1_SSBS_PSTATE_NI),
>> +    ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_BT_SHIFT, 4, 0),
> 
> I would say remove the MTE, BTI fields for now. As they must be VISIBLE, but with the kernel support for these merged. They will be added with their respective series.
Sure, will drop above changes from the series.

> 
> Suzuki
> 
