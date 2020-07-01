Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB52C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0B4D2073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgGAIEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:04:12 -0400
Received: from foss.arm.com ([217.140.110.172]:41924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728258AbgGAIEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:04:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62B9B31B;
        Wed,  1 Jul 2020 01:04:07 -0700 (PDT)
Received: from [10.57.4.20] (unknown [10.57.4.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2AD43F68F;
        Wed,  1 Jul 2020 01:04:03 -0700 (PDT)
Subject: Re: [PATCH v6 2/2] arm64/crash_core: Export TCR_EL1.T1SZ in
 vmcoreinfo
To:     Bhupesh Sharma <bhsharma@redhat.com>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        Dave Anderson <anderson@redhat.com>, bhupesh.linux@gmail.com,
        Will Deacon <will@kernel.org>
References: <1589395957-24628-1-git-send-email-bhsharma@redhat.com>
 <1589395957-24628-3-git-send-email-bhsharma@redhat.com>
From:   Amit Kachhap <amit.kachhap@arm.com>
Message-ID: <9b44a21d-93e0-8e5d-019c-fd360bf0504b@arm.com>
Date:   Wed, 1 Jul 2020 13:34:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1589395957-24628-3-git-send-email-bhsharma@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,

On 5/14/20 12:22 AM, Bhupesh Sharma wrote:
> vabits_actual variable on arm64 indicates the actual VA space size,
> and allows a single binary to support both 48-bit and 52-bit VA
> spaces.
> 
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
> 
> Cc: James Morse <james.morse@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Steve Capper <steve.capper@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Dave Anderson <anderson@redhat.com>
> Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kexec@lists.infradead.org
> Tested-by: John Donnelly <john.p.donnelly@oracle.com>
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>

I tested this for both 48 and 52 VA. The dump log looks fine with the 
crash tool link provided by you so,

Tested-by: Amit Daniel Kachhap <amit.kachhap@arm.com>

Also the code changes/documentation looks fine to me with a minor 
comments below,

Reviewed-by: Amit Daniel Kachhap <amit.kachhap@arm.com>

> ---
>   Documentation/admin-guide/kdump/vmcoreinfo.rst | 11 +++++++++++
>   arch/arm64/include/asm/pgtable-hwdef.h         |  1 +
>   arch/arm64/kernel/crash_core.c                 | 10 ++++++++++
>   3 files changed, 22 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> index 2a632020f809..2baad0bfb09d 100644
> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> @@ -404,6 +404,17 @@ KERNELPACMASK
>   The mask to extract the Pointer Authentication Code from a kernel virtual
>   address.
>   
> +TCR_EL1.T1SZ
> +------------
> +
> +Indicates the size offset of the memory region addressed by TTBR1_EL1.
> +The region size is 2^(64-T1SZ) bytes.
> +
> +TTBR1_EL1 is the table base address register specified by ARMv8-A
> +architecture which is used to lookup the page-tables for the Virtual
> +addresses in the higher VA range (refer to ARMv8 ARM document for
> +more details).
> +
>   arm
>   ===
>   
> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index 6bf5e650da78..a1861af97ac9 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -216,6 +216,7 @@
>   #define TCR_TxSZ(x)		(TCR_T0SZ(x) | TCR_T1SZ(x))
>   #define TCR_TxSZ_WIDTH		6
>   #define TCR_T0SZ_MASK		(((UL(1) << TCR_TxSZ_WIDTH) - 1) << TCR_T0SZ_OFFSET)
> +#define TCR_T1SZ_MASK		(((UL(1) << TCR_TxSZ_WIDTH) - 1) << TCR_T1SZ_OFFSET)
>   
>   #define TCR_EPD0_SHIFT		7
>   #define TCR_EPD0_MASK		(UL(1) << TCR_EPD0_SHIFT)
> diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
> index 1f646b07e3e9..314391a156ee 100644
> --- a/arch/arm64/kernel/crash_core.c
> +++ b/arch/arm64/kernel/crash_core.c
> @@ -7,6 +7,14 @@
>   #include <linux/crash_core.h>
>   #include <asm/cpufeature.h>
>   #include <asm/memory.h>
> +#include <asm/pgtable-hwdef.h>

Nit: May be you forgot to include <asm/sysreg.h> here as suggested by 
James in v5.

Cheers,
Amit

> +
> +static inline u64 get_tcr_el1_t1sz(void);
> +
> +static inline u64 get_tcr_el1_t1sz(void)
> +{
> +	return (read_sysreg(tcr_el1) & TCR_T1SZ_MASK) >> TCR_T1SZ_OFFSET;
> +}
>   
>   void arch_crash_save_vmcoreinfo(void)
>   {
> @@ -16,6 +24,8 @@ void arch_crash_save_vmcoreinfo(void)
>   						kimage_voffset);
>   	vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n",
>   						PHYS_OFFSET);
> +	vmcoreinfo_append_str("NUMBER(TCR_EL1_T1SZ)=0x%llx\n",
> +						get_tcr_el1_t1sz());
>   	vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
>   	vmcoreinfo_append_str("NUMBER(KERNELPACMASK)=0x%llx\n",
>   						system_supports_address_auth() ?
> 
