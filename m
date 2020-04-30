Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85035C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69E1E20757
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgD3LpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 07:45:07 -0400
Received: from foss.arm.com ([217.140.110.172]:53078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgD3LpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:45:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A194931B;
        Thu, 30 Apr 2020 04:45:06 -0700 (PDT)
Received: from [10.57.27.210] (unknown [10.57.27.210])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 851183F305;
        Thu, 30 Apr 2020 04:44:59 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] arm64/crash_core: Export KERNELPACMASK in
 vmcoreinfo
To:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <1587968702-19996-1-git-send-email-amit.kachhap@arm.com>
From:   Amit Kachhap <amit.kachhap@arm.com>
Message-ID: <f7dad36c-6944-f5c9-b835-0992ff0391e5@arm.com>
Date:   Thu, 30 Apr 2020 17:14:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1587968702-19996-1-git-send-email-amit.kachhap@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will/Catalin,

Sorry: Resending with correct To list.

On 4/27/20 11:55 AM, Amit Daniel Kachhap wrote:
> Recently arm64 linux kernel added support for Armv8.3-A Pointer
> Authentication feature. If this feature is enabled in the kernel and the
> hardware supports address authentication then the return addresses are
> signed and stored in the stack to prevent ROP kind of attack. Kdump tool
> will now dump the kernel with signed lr values in the stack.
> 
> Any user analysis tool for this kernel dump may need the kernel pac mask
> information in vmcoreinfo to generate the correct return address for
> stacktrace purpose as well as to resolve the symbol name.
> 
> This patch is similar to commit ec6e822d1a22d0eef ("arm64: expose user PAC
> bit positions via ptrace") which exposes pac mask information via ptrace
> interfaces.

This patch user side changes are accepted by crash-utility maintainer [1]
so I think this is in a good shape to go in.

Thanks,
Amit Daniel

[1]: https://www.redhat.com/archives/crash-utility/2020-April/msg00095.html

> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> ---
> Changes since v1:
> * Rebased to kernel 5.7-rc3.
> * commit log change.
> 
> An implementation of this new KERNELPACMASK vmcoreinfo field used by crash
> tool can be found here[1]. This change is accepted by crash utility
> maintainer [2].
> 
> [1]: https://www.redhat.com/archives/crash-utility/2020-April/msg00095.html
> [2]: https://www.redhat.com/archives/crash-utility/2020-April/msg00099.html
> 
>   arch/arm64/include/asm/compiler.h | 3 +++
>   arch/arm64/kernel/crash_core.c    | 4 ++++
>   2 files changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/compiler.h b/arch/arm64/include/asm/compiler.h
> index eece20d..32d5900 100644
> --- a/arch/arm64/include/asm/compiler.h
> +++ b/arch/arm64/include/asm/compiler.h
> @@ -19,6 +19,9 @@
>   #define __builtin_return_address(val)					\
>   	(void *)(ptrauth_clear_pac((unsigned long)__builtin_return_address(val)))
>   
> +#else  /* !CONFIG_ARM64_PTR_AUTH */
> +#define	ptrauth_user_pac_mask()		0ULL
> +#define	ptrauth_kernel_pac_mask()	0ULL
>   #endif /* CONFIG_ARM64_PTR_AUTH */
>   
>   #endif /* __ASM_COMPILER_H */
> diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
> index ca4c3e1..25cf2ce 100644
> --- a/arch/arm64/kernel/crash_core.c
> +++ b/arch/arm64/kernel/crash_core.c
> @@ -6,6 +6,7 @@
>   
>   #include <linux/crash_core.h>
>   #include <asm/memory.h>
> +#include <asm/pointer_auth.h>
>   
>   void arch_crash_save_vmcoreinfo(void)
>   {
> @@ -16,4 +17,7 @@ void arch_crash_save_vmcoreinfo(void)
>   	vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n",
>   						PHYS_OFFSET);
>   	vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
> +	vmcoreinfo_append_str("NUMBER(KERNELPACMASK)=0x%llx\n",
> +						system_supports_address_auth() ?
> +						ptrauth_kernel_pac_mask() : 0);
>   }
> 
