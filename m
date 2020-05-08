Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE14C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 04:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 169C9206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 04:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgEHE00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 00:26:26 -0400
Received: from foss.arm.com ([217.140.110.172]:43296 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgEHE0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 00:26:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06A7530E;
        Thu,  7 May 2020 21:26:25 -0700 (PDT)
Received: from [10.163.73.155] (unknown [10.163.73.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8DAA3F68F;
        Thu,  7 May 2020 21:26:22 -0700 (PDT)
Subject: Re: [PATCH V3 02/16] arm64/cpufeature: Drop TraceFilt feature
 exposure from ID_DFR0 register
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
References: <1588426445-24344-1-git-send-email-anshuman.khandual@arm.com>
 <1588426445-24344-3-git-send-email-anshuman.khandual@arm.com>
 <20200504202453.GA5012@willie-the-truck>
 <56cd3062-a0c2-6cdf-b7c6-c2b7bf56d23b@arm.com>
 <20200505104250.GA19710@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <26002f7f-865c-bcdb-8394-c8565bebeb5c@arm.com>
Date:   Fri, 8 May 2020 09:55:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200505104250.GA19710@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/05/2020 04:12 PM, Will Deacon wrote:
> On Tue, May 05, 2020 at 12:20:41PM +0530, Anshuman Khandual wrote:
>> On 05/05/2020 01:54 AM, Will Deacon wrote:
>>> On Sat, May 02, 2020 at 07:03:51PM +0530, Anshuman Khandual wrote:
>>>> ID_DFR0 based TraceFilt feature should not be exposed to guests. Hence lets
>>>> drop it.
>>>>
>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>> Cc: Will Deacon <will@kernel.org>
>>>> Cc: Marc Zyngier <maz@kernel.org>
>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>> Cc: James Morse <james.morse@arm.com>
>>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>>
>>>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
>>>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> ---
>>>>  arch/arm64/kernel/cpufeature.c | 1 -
>>>>  1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>>>> index 6d032fbe416f..51386dade423 100644
>>>> --- a/arch/arm64/kernel/cpufeature.c
>>>> +++ b/arch/arm64/kernel/cpufeature.c
>>>> @@ -435,7 +435,6 @@ static const struct arm64_ftr_bits ftr_id_pfr1[] = {
>>>>  };
>>>>  
>>>>  static const struct arm64_ftr_bits ftr_id_dfr0[] = {
>>>> -	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 28, 4, 0),
>>>
>>> Hmm, this still confuses me. Is this not now FTR_NONSTRICT? Why is that ok?
>>
>> Mark had mentioned about it earlier (https://patchwork.kernel.org/patch/11287805/)
>> Did I misinterpret the first part ? Could not figure "capping the emulated debug
>> features" part. Probably, Mark could give some more details.
>>
>> From the earlier discussion:
>>
>> * ID_DFR0 fields need more thought; we should limit what we expose here.
>>   I don't think it's valid for us to expose TraceFilt, and I suspect we
>>   need to add capping for debug features we currently emulate.
> 
> Sorry, I for confused (again) by the cpufeature code :) I'm going to add
> the following to my comment:
> 
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index c1d44d127baa..9b05843d67af 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -53,6 +53,11 @@
>   *   arbitrary physical CPUs, but some features not present on the host are
>   *   also advertised and emulated. Look at sys_reg_descs[] for the gory
>   *   details.
> + *
> + * - If the arm64_ftr_bits[] for a register has a missing field, then this
> + *   field is treated as STRICT RES0, including for read_sanitised_ftr_reg().
> + *   This is stronger than FTR_HIDDEN and can be used to hide features from
> + *   KVM guests.
>   */
>  
>  #define pr_fmt(fmt) "CPU features: " fmt
> 

Wondering if you will take this comment via a separate patch/branch or
should I fold it here instead.

> 
> However, I think we really want to get rid of ftr_generic_32bits[] entirely
> and spell out all of the register fields, even just using comments for the
> fields we're omitting:

Should we do that later or in this series itself ?

> 
> 
> @@ -425,7 +430,7 @@ static const struct arm64_ftr_bits ftr_id_pfr1[] = {
>  };
>  
>  static const struct arm64_ftr_bits ftr_id_dfr0[] = {
> -	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 28, 4, 0),
> +	/* 31:28	TraceFilt */
>  	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 24, 4, 0xf),	/* PerfMon */
>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 20, 4, 0),
>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 16, 4, 0),
> 
> 
> Longer term, I think we'll probably want to handle these within
> ARM64_FTR_BITS, as we may end up with features that we want to hide from
> KVM guests but not from the host kernel.

Sure, but for now will fold the above changes here.
