Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7F2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FD9A207CB
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389882AbgEYKmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 06:42:05 -0400
Received: from foss.arm.com ([217.140.110.172]:38530 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389484AbgEYKmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 06:42:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F6571FB;
        Mon, 25 May 2020 03:42:04 -0700 (PDT)
Received: from [192.168.0.21] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 063E93F305;
        Mon, 25 May 2020 03:42:02 -0700 (PDT)
Subject: Re: [PATCH V4 15/17] arm64/cpufeature: Add remaining feature bits in
 ID_AA64DFR0 register
To:     anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org
References: <1589881254-10082-1-git-send-email-anshuman.khandual@arm.com>
 <1589881254-10082-16-git-send-email-anshuman.khandual@arm.com>
 <5bad1e13-e498-b33e-5305-336d855c2c8b@arm.com>
 <9e452a85-2ccf-50e6-d807-3f9e528b4072@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <eca9b415-c707-8d2c-7832-0bd129668e37@arm.com>
Date:   Mon, 25 May 2020 11:46:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <9e452a85-2ccf-50e6-d807-3f9e528b4072@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/24/2020 02:08 AM, Anshuman Khandual wrote:
> 
> 
> On 05/20/2020 07:27 PM, Suzuki K Poulose wrote:
>> On 05/19/2020 10:40 AM, Anshuman Khandual wrote:
>>> Enable MTPMU and TRACEFILT features bits in ID_AA64DFR0 register as per ARM
>>> DDI 0487F.a specification.
>>>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-kernel@vger.kernel.org
>>>
>>> Suggested-by: Will Deacon <will@kernel.org>
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>>    arch/arm64/include/asm/sysreg.h | 2 ++
>>>    arch/arm64/kernel/cpufeature.c  | 2 ++
>>>    2 files changed, 4 insertions(+)
>>>
>>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>>> index a572069ccf6e..4bcd21cc2d68 100644
>>> --- a/arch/arm64/include/asm/sysreg.h
>>> +++ b/arch/arm64/include/asm/sysreg.h
>>> @@ -766,6 +766,8 @@
>>>    #define ID_AA64MMFR2_CNP_SHIFT        0
>>>      /* id_aa64dfr0 */
>>> +#define ID_AA64DFR0_MTPMU_SHIFT        48
>>> +#define ID_AA64DFR0_TRACEFILT_SHIFT    40
>>>    #define ID_AA64DFR0_PMSVER_SHIFT    32
>>>    #define ID_AA64DFR0_CTX_CMPS_SHIFT    28
>>>    #define ID_AA64DFR0_WRPS_SHIFT        20
>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>>> index 6338151f263c..986974be0178 100644
>>> --- a/arch/arm64/kernel/cpufeature.c
>>> +++ b/arch/arm64/kernel/cpufeature.c
>>> @@ -366,6 +366,8 @@ static const struct arm64_ftr_bits ftr_id_mmfr0[] = {
>>>    };
>>>      static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
>>> +    S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_MTPMU_SHIFT, 4, 0),
>>> +    ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_TRACEFILT_SHIFT, 4, 0),
>>
>> We maske both the fields for KVM in AArch32 ID registers. We should do the same here.
> 
> MTPMU is defined for AArch32 ID register ID_DFR1_EL1, even though the
> entire register is hidden from KVM with ID_HIDDEN().
> 
> static const struct arm64_ftr_bits ftr_id_dfr1[] = {
>          S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_DFR1_MTPMU_SHIFT, 4, 0),
>          ARM64_FTR_END,
> };
> 
> Should the ID_AA64DFR0_EL1 be hidden from KVM as well. But it has many
> other existing features apart from MTPMU and TRACEFILT which are being
> added here.

No, you must mask out those two fields in the emulation. Other fields 
are still relevant for guests (e.g, PMU). See, ptr-auth for e.g.

Suzuki
