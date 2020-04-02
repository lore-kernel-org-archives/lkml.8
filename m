Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2851BC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040AE20721
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387427AbgDBCiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 22:38:14 -0400
Received: from foss.arm.com ([217.140.110.172]:36332 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733230AbgDBCiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 22:38:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57FA430E;
        Wed,  1 Apr 2020 19:38:14 -0700 (PDT)
Received: from [10.163.1.8] (unknown [10.163.1.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 481723F71E;
        Wed,  1 Apr 2020 19:38:11 -0700 (PDT)
Subject: Re: [PATCH 2/6] arm64/cpufeature: Add DIT and CSV2 feature bits in
 ID_PFR0 register
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com
References: <1580215149-21492-1-git-send-email-anshuman.khandual@arm.com>
 <1580215149-21492-3-git-send-email-anshuman.khandual@arm.com>
 <fc6a3044-4ca7-8a37-d948-498d0d89a426@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <428968f6-d4ba-7b64-a2b0-59177c6a6be7@arm.com>
Date:   Thu, 2 Apr 2020 08:08:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <fc6a3044-4ca7-8a37-d948-498d0d89a426@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/20/2020 11:37 PM, Suzuki K Poulose wrote:
> Cc: Mark Rutland

Sure, will add this to all the patches here. Also add 'Suggested-by'
tags on all the changes proposed by Mark. Should have already added
that in this version as well, my bad.

> 
> On 01/28/2020 12:39 PM, Anshuman Khandual wrote:
>> Enable DIT and CSV2 feature bits in ID_PFR0 register as per ARM DDI 0487E.a
>> specification. Except RAS and AMU, all other feature bits are now enabled.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
>> ---
>>   arch/arm64/include/asm/sysreg.h | 3 +++
>>   arch/arm64/kernel/cpufeature.c  | 2 ++
>>   2 files changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index 054aab7ebf1b..469d61c8fabf 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -718,6 +718,9 @@
>>   #define ID_ISAR6_DP_SHIFT        4
>>   #define ID_ISAR6_JSCVT_SHIFT        0
>>   +#define ID_PFR0_DIT_SHIFT        24
>> +#define ID_PFR0_CSV2_SHIFT        16
>> +
>>   #define ID_PFR2_SSBS_SHIFT        4
>>   #define ID_PFR2_CSV3_SHIFT        0
>>   diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index c1e837fc8f97..9e4dab15c608 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -341,6 +341,8 @@ static const struct arm64_ftr_bits ftr_id_isar6[] = {
>>   };
>>     static const struct arm64_ftr_bits ftr_id_pfr0[] = {
>> +    ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR0_DIT_SHIFT, 4, 0),
>> +    ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR0_CSV2_SHIFT, 4, 0),
>>       ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 12, 4, 0),        /* State3 */
>>       ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 8, 4, 0),        /* State2 */
>>       ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 4, 4, 0),        /* State1 */
>>
> 
> 
