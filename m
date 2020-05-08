Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA72C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 05:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87082208D6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 05:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgEHFAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 01:00:12 -0400
Received: from foss.arm.com ([217.140.110.172]:43442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgEHFAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 01:00:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B83F530E;
        Thu,  7 May 2020 22:00:11 -0700 (PDT)
Received: from [10.163.73.155] (unknown [10.163.73.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 946313F71F;
        Thu,  7 May 2020 22:00:09 -0700 (PDT)
Subject: Re: [PATCH V3 03/16] arm64/cpufeature: Make doublelock a signed
 feature in ID_AA64DFR0
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
References: <1588426445-24344-1-git-send-email-anshuman.khandual@arm.com>
 <1588426445-24344-4-git-send-email-anshuman.khandual@arm.com>
 <20200505111045.GE19710@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <5cfe374b-d4fa-e17a-9fce-4334356caa19@arm.com>
Date:   Fri, 8 May 2020 10:29:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200505111045.GE19710@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/05/2020 04:40 PM, Will Deacon wrote:
> On Sat, May 02, 2020 at 07:03:52PM +0530, Anshuman Khandual wrote:
>> Double lock feature can have the following possible values.
>>
>> 0b0000 - Double lock implemented
>> 0b1111 - Double lock not implemented
>>
>> But in case of a conflict the safe value should be 0b1111. Hence this must
>> be a signed feature instead. Also change FTR_EXACT to FTR_LOWER_SAFE.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>>
>> Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/kernel/cpufeature.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 51386dade423..cba43e4a5c79 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -338,7 +338,7 @@ static const struct arm64_ftr_bits ftr_id_mmfr0[] = {
>>  };
>>  
>>  static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
>> -	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, 36, 28, 0),
>> +	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 36, 28, 0),
> 
> Wait, isn't this buggered today? Shouldn't that 28 be a 4? I think we really

Ahh, right. Will fix it.

> need to:
> 
> 	1. Make it impossible to describe overlapping fields, incomplete
> 	   registers etc (ideally at build-time)

AFICS the _SHIFT defines for a given register must be placed sequentially
with dummy place holders (4 bit wide) for any missing fields. In that case
we could just call BUILD_BUG_ON() for any possible breakage or overlap. But
wondering how and where to loop over these SHIFT values for these registers.

Another way (not build time though) will be to scan through ftr_id_xxx[],
fetch individual arm64_ftr_bits (assuming there are dummy entries for non
existing fields) and assert that arm6r_ftr_bits[shift, width] validates
against the previous arm6r_ftr_bits[shift, width] in an increasing manner.

Either of these methods will require some more thoughts.

> 
> 	2. Have a macro that for 4-bit fields so you don't have to type '4'
> 	   all the time

Except for ftr_single32[], all other arm64_ftr_bits entries have the exact
same shift value (i.e 4). ARM64_FTR_WIDTH sounds good ?

> 
> Suzuki, any ideas how we can make this a bit more robust?
> 
> Will
>
