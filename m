Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F7DC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 07:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20D4D20663
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 07:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgEEHGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 03:06:44 -0400
Received: from foss.arm.com ([217.140.110.172]:32832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgEEHGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 03:06:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C8521FB;
        Tue,  5 May 2020 00:06:43 -0700 (PDT)
Received: from [10.163.71.248] (unknown [10.163.71.248])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8DF63F68F;
        Tue,  5 May 2020 00:06:40 -0700 (PDT)
Subject: Re: [PATCH V3 09/16] arm64/cpufeature: Add remaining feature bits in
 ID_AA64ISAR0 register
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org
References: <1588426445-24344-1-git-send-email-anshuman.khandual@arm.com>
 <1588426445-24344-10-git-send-email-anshuman.khandual@arm.com>
 <0e5274dc-e2e3-646a-076b-ebe195048c5a@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <f50ed4ab-0028-088f-1e49-925af5cfa2f2@arm.com>
Date:   Tue, 5 May 2020 12:36:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0e5274dc-e2e3-646a-076b-ebe195048c5a@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/05/2020 10:24 AM, Suzuki K Poulose wrote:
> On 05/02/2020 02:33 PM, Anshuman Khandual wrote:
>> Enable TLB features bit in ID_AA64ISAR0 register as per ARM DDI 0487F.a
>> specification.
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
>>   arch/arm64/include/asm/sysreg.h | 1 +
>>   arch/arm64/kernel/cpufeature.c  | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index 0f34927f52b9..40eaf89f1032 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -597,6 +597,7 @@
>>     /* id_aa64isar0 */
>>   #define ID_AA64ISAR0_RNDR_SHIFT        60
>> +#define ID_AA64ISAR0_TLB_SHIFT        56
>>   #define ID_AA64ISAR0_TS_SHIFT        52
>>   #define ID_AA64ISAR0_FHM_SHIFT        48
>>   #define ID_AA64ISAR0_DP_SHIFT        44
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index f4e15e355aee..dbedcae28061 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -174,6 +174,7 @@ static bool __system_matches_cap(unsigned int n);
>>    */
>>   static const struct arm64_ftr_bits ftr_id_aa64isar0[] = {
>>       ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_RNDR_SHIFT, 4, 0),
>> +    ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_TLB_SHIFT, 4, 0),
> 
> I don't see any reason why this should be VISIBLE to the userspace.

Okay, will make it FTR_HIDDEN.
