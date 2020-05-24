Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14B9C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 01:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B648F20787
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 01:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgEXBKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 21:10:16 -0400
Received: from foss.arm.com ([217.140.110.172]:58198 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbgEXBKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 21:10:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3E0230E;
        Sat, 23 May 2020 18:10:14 -0700 (PDT)
Received: from [10.163.75.81] (unknown [10.163.75.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E24C23F52E;
        Sat, 23 May 2020 18:10:12 -0700 (PDT)
Subject: Re: [PATCH V4 13/17] arm64/cpufeature: Add remaining feature bits in
 ID_AA64MMFR1 register
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org
References: <1589881254-10082-1-git-send-email-anshuman.khandual@arm.com>
 <1589881254-10082-14-git-send-email-anshuman.khandual@arm.com>
 <6ad2dde0-455f-90a6-7b76-eda4fe8d6efe@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <ca5e8fe6-b36f-dc22-bc6f-b96a845a399d@arm.com>
Date:   Sun, 24 May 2020 06:39:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6ad2dde0-455f-90a6-7b76-eda4fe8d6efe@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/19/2020 07:14 PM, Suzuki K Poulose wrote:
> On 05/19/2020 10:40 AM, Anshuman Khandual wrote:
>> Enable ETS, TWED, XNX and SPECSEI features bits in ID_AA64MMFR1 register as
>> per ARM DDI 0487F.a specification.
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
>> index 95fdfc5e9bd0..f9dd2c5ab074 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -734,6 +734,10 @@
>>   #endif
>>     /* id_aa64mmfr1 */
>> +#define ID_AA64MMFR1_ETS_SHIFT        36
>> +#define ID_AA64MMFR1_TWED_SHIFT        32
>> +#define ID_AA64MMFR1_XNX_SHIFT        28
>> +#define ID_AA64MMFR1_SPECSEI_SHIFT    24
>>   #define ID_AA64MMFR1_PAN_SHIFT        20
>>   #define ID_AA64MMFR1_LOR_SHIFT        16
>>   #define ID_AA64MMFR1_HPD_SHIFT        12
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 7ce19f97ba73..1f10ff7df705 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -299,6 +299,10 @@ static const struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
>>   };
>>     static const struct arm64_ftr_bits ftr_id_aa64mmfr1[] = {
>> +    ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_ETS_SHIFT, 4, 0),
>> +    ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_TWED_SHIFT, 4, 0),
>> +    ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_XNX_SHIFT, 4, 0),
>> +    ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_SPECSEI_SHIFT, 4, 0),
> 
> SpecSEI must be HIGHER_SAFE, like we did for MMFR4 ?

Sure, will change.
