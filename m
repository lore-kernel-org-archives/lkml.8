Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DC4C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E17A5206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgEFMDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 08:03:23 -0400
Received: from foss.arm.com ([217.140.110.172]:34950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727805AbgEFMDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 08:03:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAC661FB;
        Wed,  6 May 2020 05:03:21 -0700 (PDT)
Received: from [10.57.31.214] (unknown [10.57.31.214])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 446353F71F;
        Wed,  6 May 2020 05:03:19 -0700 (PDT)
From:   Amit Kachhap <amit.kachhap@arm.com>
Subject: Re: [PATCH v2 1/2] arm64/crash_core: Export KERNELPACMASK in
 vmcoreinfo
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <1587968702-19996-1-git-send-email-amit.kachhap@arm.com>
 <20200504171741.GD1833@willie-the-truck>
Message-ID: <bc5e6fc5-15f4-40bb-4466-816de5912893@arm.com>
Date:   Wed, 6 May 2020 17:32:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200504171741.GD1833@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 5/4/20 10:47 PM, Will Deacon wrote:
> On Mon, Apr 27, 2020 at 11:55:01AM +0530, Amit Daniel Kachhap wrote:
>> Recently arm64 linux kernel added support for Armv8.3-A Pointer
>> Authentication feature. If this feature is enabled in the kernel and the
>> hardware supports address authentication then the return addresses are
>> signed and stored in the stack to prevent ROP kind of attack. Kdump tool
>> will now dump the kernel with signed lr values in the stack.
>>
>> Any user analysis tool for this kernel dump may need the kernel pac mask
>> information in vmcoreinfo to generate the correct return address for
>> stacktrace purpose as well as to resolve the symbol name.
>>
>> This patch is similar to commit ec6e822d1a22d0eef ("arm64: expose user PAC
>> bit positions via ptrace") which exposes pac mask information via ptrace
>> interfaces.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
>> ---
>> Changes since v1:
>> * Rebased to kernel 5.7-rc3.
>> * commit log change.
>>
>> An implementation of this new KERNELPACMASK vmcoreinfo field used by crash
>> tool can be found here[1]. This change is accepted by crash utility
>> maintainer [2].
>>
>> [1]: https://www.redhat.com/archives/crash-utility/2020-April/msg00095.html
>> [2]: https://www.redhat.com/archives/crash-utility/2020-April/msg00099.html
>>
>>   arch/arm64/include/asm/compiler.h | 3 +++
>>   arch/arm64/kernel/crash_core.c    | 4 ++++
>>   2 files changed, 7 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/compiler.h b/arch/arm64/include/asm/compiler.h
>> index eece20d..32d5900 100644
>> --- a/arch/arm64/include/asm/compiler.h
>> +++ b/arch/arm64/include/asm/compiler.h
>> @@ -19,6 +19,9 @@
>>   #define __builtin_return_address(val)					\
>>   	(void *)(ptrauth_clear_pac((unsigned long)__builtin_return_address(val)))
>>   
>> +#else  /* !CONFIG_ARM64_PTR_AUTH */
>> +#define	ptrauth_user_pac_mask()		0ULL
>> +#define	ptrauth_kernel_pac_mask()	0ULL
> 
> This doesn't look quite right to me, since you still have to take into
> account the case where CONFIG_ARM64_PTR_AUTH=y but the feature is not
> available at runtime:

Yes agree with you here. However the config gaurd is saving some extra
computation for __builtin_return_address. There are some compiler
support being added in __builtin_extract_return_address to mask the PAC.
Hopefully that will improve this code. In the meantime let it be like this.

I can remove this else case and as other users of
ptrauth_{kernel,user}_pac_mask(ptrace.c) protect it with a config gaurd
there.

> 
>> @@ -16,4 +17,7 @@ void arch_crash_save_vmcoreinfo(void)
>>   	vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n",
>>   						PHYS_OFFSET);
>>   	vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
>> +	vmcoreinfo_append_str("NUMBER(KERNELPACMASK)=0x%llx\n",
>> +						system_supports_address_auth() ?
>> +						ptrauth_kernel_pac_mask() : 0);
> 
> In which case, would it make more sense to define
> ptrauth_{kernel,user}_pac_mask() unconditionally? In fact, I'd probably
> just remove the guards completely from asm/compiler.h because I think
> they're misleading.

As answered above. Let me know your opinion. Although I don't have 
strong reservation in keeping the config gaurd.

Thanks,
Amit Daniel

> 
> Will
> 
> --->8
> 
> diff --git a/arch/arm64/include/asm/compiler.h b/arch/arm64/include/asm/compiler.h
> index eece20d2c55f..51a7ce87cdfe 100644
> --- a/arch/arm64/include/asm/compiler.h
> +++ b/arch/arm64/include/asm/compiler.h
> @@ -2,8 +2,6 @@
>   #ifndef __ASM_COMPILER_H
>   #define __ASM_COMPILER_H
>   
> -#if defined(CONFIG_ARM64_PTR_AUTH)
> -
>   /*
>    * The EL0/EL1 pointer bits used by a pointer authentication code.
>    * This is dependent on TBI0/TBI1 being enabled, or bits 63:56 would also apply.
> @@ -19,6 +17,4 @@
>   #define __builtin_return_address(val)					\
>   	(void *)(ptrauth_clear_pac((unsigned long)__builtin_return_address(val)))
>   
> -#endif /* CONFIG_ARM64_PTR_AUTH */
> -
>   #endif /* __ASM_COMPILER_H */
> 
