Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099DCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D65D3206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbgGAMAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:00:18 -0400
Received: from foss.arm.com ([217.140.110.172]:33884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730133AbgGAMAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:00:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EF9630E;
        Wed,  1 Jul 2020 05:00:17 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B86583F73C;
        Wed,  1 Jul 2020 05:00:15 -0700 (PDT)
Subject: Re: [PATCH v6 2/2] arm64/crash_core: Export TCR_EL1.T1SZ in
 vmcoreinfo
To:     Bhupesh Sharma <bhsharma@redhat.com>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc:     bhupesh.linux@gmail.com, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Anderson <anderson@redhat.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
References: <1589395957-24628-1-git-send-email-bhsharma@redhat.com>
 <1589395957-24628-3-git-send-email-bhsharma@redhat.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <7abd195f-2091-0ef9-2e0b-4a8bf2cf820e@arm.com>
Date:   Wed, 1 Jul 2020 12:59:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1589395957-24628-3-git-send-email-bhsharma@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,

On 13/05/2020 19:52, Bhupesh Sharma wrote:
> vabits_actual variable on arm64 indicates the actual VA space size,
> and allows a single binary to support both 48-bit and 52-bit VA
> spaces.

I'd prefer the commit message not to refer to this 'vabits_actual' thing at all. By the
time a git-archaeologist comes to read this, it may be long gone.

Ideally this would refer to: TCR_EL1.TxSZ, which controls the VA space size,
and can be configured by a single kernel image to support either 48-bit or 52-bit VA space.


> If the ARMv8.2-LVA optional feature is present, and we are running
> with a 64KB page size; then it is possible to use 52-bits of address
> space for both userspace and kernel addresses. However, any kernel
> binary that supports 52-bit must also be able to fall back to 48-bit
> at early boot time if the hardware feature is not present.
> 
> Since TCR_EL1.T1SZ indicates the size offset of the memory region
> addressed by TTBR1_EL1 (and hence can be used for determining the
> vabits_actual value) it makes more sense to export the same in
> vmcoreinfo rather than vabits_actual variable, as the name of the
> variable can change in future kernel versions, but the architectural
> constructs like TCR_EL1.T1SZ can be used better to indicate intended
> specific fields to user-space.
> 
> User-space utilities like makedumpfile and crash-utility, need to
> read this value from vmcoreinfo for determining if a virtual
> address lies in the linear map range.
> 
> While at it also add documentation for TCR_EL1.T1SZ variable being
> added to vmcoreinfo.
> 
> It indicates the size offset of the memory region addressed by TTBR1_EL1

> diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
> index 1f646b07e3e9..314391a156ee 100644
> --- a/arch/arm64/kernel/crash_core.c
> +++ b/arch/arm64/kernel/crash_core.c
> @@ -7,6 +7,14 @@
>  #include <linux/crash_core.h>
>  #include <asm/cpufeature.h>
>  #include <asm/memory.h>
> +#include <asm/pgtable-hwdef.h>
> +
> +static inline u64 get_tcr_el1_t1sz(void);
> +
> +static inline u64 get_tcr_el1_t1sz(void)
> +{
> +	return (read_sysreg(tcr_el1) & TCR_T1SZ_MASK) >> TCR_T1SZ_OFFSET;
> +}
>  
>  void arch_crash_save_vmcoreinfo(void)
>  {
> @@ -16,6 +24,8 @@ void arch_crash_save_vmcoreinfo(void)
>  						kimage_voffset);
>  	vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n",
>  						PHYS_OFFSET);
> +	vmcoreinfo_append_str("NUMBER(TCR_EL1_T1SZ)=0x%llx\n",
> +						get_tcr_el1_t1sz());
>  	vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
>  	vmcoreinfo_append_str("NUMBER(KERNELPACMASK)=0x%llx\n",
>  						system_supports_address_auth() ?

(I think second guessing the kernel memory map is a sisyphean effort), but this register
isn't going to disappear, or change its meaning!:

Reviewed-by: James Morse <james.morse@arm.com>

You may need to re-post this to get the maintainer's attention as its normally safe to
assume patches posted before rc1 no longer apply. (in this case, this one does)


Thanks,

James
