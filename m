Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23139C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0836E206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgEFGgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 02:36:23 -0400
Received: from foss.arm.com ([217.140.110.172]:56884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgEFGgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 02:36:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB09830E;
        Tue,  5 May 2020 23:36:21 -0700 (PDT)
Received: from [10.163.71.196] (unknown [10.163.71.196])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB4A83F68F;
        Tue,  5 May 2020 23:36:19 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V3 10/16] arm64/cpufeature: Add remaining feature bits in
 ID_AA64PFR0 register
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org
References: <1588426445-24344-1-git-send-email-anshuman.khandual@arm.com>
 <1588426445-24344-11-git-send-email-anshuman.khandual@arm.com>
 <f5e8b407-c731-7ff9-df47-fc54182f2d25@arm.com>
Message-ID: <7116fd7d-eb16-c5c4-c8e4-ffdc71b0983c@arm.com>
Date:   Wed, 6 May 2020 12:05:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f5e8b407-c731-7ff9-df47-fc54182f2d25@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/05/2020 10:29 AM, Suzuki K Poulose wrote:
> On 05/02/2020 02:33 PM, Anshuman Khandual wrote:
>> Enable MPAM and SEL2 features bits in ID_AA64PFR0 register as per ARM DDI
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
>>   arch/arm64/include/asm/sysreg.h | 2 ++
>>   arch/arm64/kernel/cpufeature.c  | 2 ++
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index 40eaf89f1032..c93ea6613f51 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -641,6 +641,8 @@
>>   #define ID_AA64PFR0_CSV2_SHIFT        56
>>   #define ID_AA64PFR0_DIT_SHIFT        48
>>   #define ID_AA64PFR0_AMU_SHIFT        44
>> +#define ID_AA64PFR0_MPAM_SHIFT        40
>> +#define ID_AA64PFR0_SEL2_SHIFT        36
>>   #define ID_AA64PFR0_SVE_SHIFT        32
>>   #define ID_AA64PFR0_RAS_SHIFT        28
>>   #define ID_AA64PFR0_GIC_SHIFT        24
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index dbedcae28061..f5a39e040804 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -217,6 +217,8 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
>>       ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_CSV2_SHIFT, 4, 0),
>>       ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_DIT_SHIFT, 4, 0),
>>       ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_AMU_SHIFT, 4, 0),
>> +    ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_MPAM_SHIFT, 4, 0),
>> +    ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_SEL2_SHIFT, 4, 0),
> 
> Both of them must be hidden. And also need to check the impact of exposing this to the guests, especially MPAM.

Just trying to understand. We should make both MPAM and SEL2, FTR_HIDDEN for
now, in which case they should not be visible to the userspace or guests. But
we would need to check impact of their exposure to guests before they can be
made visible later on. Is that correct ?
