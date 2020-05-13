Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AF6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2B49207D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389165AbgEMPEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:04:15 -0400
Received: from foss.arm.com ([217.140.110.172]:48814 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728881AbgEMPEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:04:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B69831B;
        Wed, 13 May 2020 08:04:11 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4CBA3F305;
        Wed, 13 May 2020 08:04:09 -0700 (PDT)
Date:   Wed, 13 May 2020 16:04:07 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH V2] arm64/cpuinfo: Move HWCAP name arrays alongside their
 bit definitions
Message-ID: <20200513150405.GS21779@arm.com>
References: <1588858150-26823-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588858150-26823-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 06:59:10PM +0530, Anshuman Khandual wrote:
> All HWCAP name arrays (i.e hwcap_str, compat_hwcap_str, compat_hwcap2_str)
> that are scanned for /proc/cpuinfo output are detached from their bit fild
> definitions making it difficult to corelate. This is also bit problematic
> because during /proc/cpuinfo dump these arrays get traversed sequentially
> assuming that they reflect and match HWCAP bit sequence, to test various
> features for a given CPU.
> 
> This moves all HWCAP name arrays near their bit definitions. But first it
> defines all missing COMPAT_HWCAP_XXX that are present in the name string.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> ---
> This applies on 5.7-rc4
> 
> Changes in V2:
> 
> - Defined COMPAT_KERNEL_HWCAP[2] and updated the name arrays per Mark
> - Updated the commit message as required
> 
> Changes in V1: (https://patchwork.kernel.org/patch/11532945/)
> 
>  arch/arm64/include/asm/hwcap.h | 101 +++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/cpuinfo.c    |  90 -----------------------------
>  2 files changed, 101 insertions(+), 90 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
> index 0f00265248b5..589ac02e1ddd 100644
> --- a/arch/arm64/include/asm/hwcap.h
> +++ b/arch/arm64/include/asm/hwcap.h
> @@ -8,18 +8,27 @@
>  #include <uapi/asm/hwcap.h>
>  #include <asm/cpufeature.h>
>  
> +#define COMPAT_HWCAP_SWP	(1 << 0)
>  #define COMPAT_HWCAP_HALF	(1 << 1)
>  #define COMPAT_HWCAP_THUMB	(1 << 2)
> +#define COMPAT_HWCAP_26BIT	(1 << 3)
>  #define COMPAT_HWCAP_FAST_MULT	(1 << 4)
> +#define COMPAT_HWCAP_FPA	(1 << 5)
>  #define COMPAT_HWCAP_VFP	(1 << 6)
>  #define COMPAT_HWCAP_EDSP	(1 << 7)
> +#define COMPAT_HWCAP_JAVA	(1 << 8)
> +#define COMPAT_HWCAP_IWMMXT	(1 << 9)
> +#define COMPAT_HWCAP_CRUNCH	(1 << 10)
> +#define COMPAT_HWCAP_THUMBEE	(1 << 11)
>  #define COMPAT_HWCAP_NEON	(1 << 12)
>  #define COMPAT_HWCAP_VFPv3	(1 << 13)
> +#define COMPAT_HWCAP_VFPV3D16	(1 << 14)
>  #define COMPAT_HWCAP_TLS	(1 << 15)
>  #define COMPAT_HWCAP_VFPv4	(1 << 16)
>  #define COMPAT_HWCAP_IDIVA	(1 << 17)
>  #define COMPAT_HWCAP_IDIVT	(1 << 18)
>  #define COMPAT_HWCAP_IDIV	(COMPAT_HWCAP_IDIVA|COMPAT_HWCAP_IDIVT)
> +#define COMPAT_HWCAP_VFPD32	(1 << 19)
>  #define COMPAT_HWCAP_LPAE	(1 << 20)
>  #define COMPAT_HWCAP_EVTSTRM	(1 << 21)

With the possible exception of SWP (does the swp emulation allow us to
report this as supported?), I think all these weren't mentioned because
they aren't included in ARMv8 and so can never be reported.

If we find ourselves reporting them, there's a bug somewhere.

So, can we just default all obsolete string entries to NULL?

When generating the cpuinfo strings we could WARN and just emit an empty
string for that hwcap.

Cheers
---Dave

[...]

> +#ifdef CONFIG_COMPAT
> +#define COMPAT_KERNEL_HWCAP(x)	const_ilog2(COMPAT_HWCAP_ ## x)
> +static const char *const compat_hwcap_str[] = {
> +	[COMPAT_KERNEL_HWCAP(SWP)]	= "swp",
> +	[COMPAT_KERNEL_HWCAP(HALF)]	= "half",
> +	[COMPAT_KERNEL_HWCAP(THUMB)]	= "thumb",
> +	[COMPAT_KERNEL_HWCAP(26BIT)]	= "26bit",
> +	[COMPAT_KERNEL_HWCAP(FAST_MULT)] = "fastmult",
> +	[COMPAT_KERNEL_HWCAP(FPA)]	= "fpa",
> +	[COMPAT_KERNEL_HWCAP(VFP)]	= "vfp",
> +	[COMPAT_KERNEL_HWCAP(EDSP)]	= "edsp",
> +	[COMPAT_KERNEL_HWCAP(JAVA)]	= "java",
> +	[COMPAT_KERNEL_HWCAP(IWMMXT)]	= "iwmmxt",
> +	[COMPAT_KERNEL_HWCAP(CRUNCH)]	= "crunch",
> +	[COMPAT_KERNEL_HWCAP(THUMBEE)]	= "thumbee",
> +	[COMPAT_KERNEL_HWCAP(NEON)]	= "neon",
> +	[COMPAT_KERNEL_HWCAP(VFPv3)]	= "vfpv3",
> +	[COMPAT_KERNEL_HWCAP(VFPV3D16)]	= "vfpv3d16",
> +	[COMPAT_KERNEL_HWCAP(TLS)]	= "tls",
> +	[COMPAT_KERNEL_HWCAP(VFPv4)]	= "vfpv4",
> +	[COMPAT_KERNEL_HWCAP(IDIVA)]	= "idiva",
> +	[COMPAT_KERNEL_HWCAP(IDIVT)]	= "idivt",
> +	[COMPAT_KERNEL_HWCAP(VFPD32)]	= "vfpd32",
> +	[COMPAT_KERNEL_HWCAP(LPAE)]	= "lpae",
> +	[COMPAT_KERNEL_HWCAP(EVTSTRM)]	= "evtstrm",
> +	NULL
> +};
> +
> +#define COMPAT_KERNEL_HWCAP2(x)	const_ilog2(COMPAT_HWCAP2_ ## x)
> +static const char *const compat_hwcap2_str[] = {
> +	[COMPAT_KERNEL_HWCAP2(AES)]	= "aes",
> +	[COMPAT_KERNEL_HWCAP2(PMULL)]	= "pmull",
> +	[COMPAT_KERNEL_HWCAP2(SHA1)]	= "sha1",
> +	[COMPAT_KERNEL_HWCAP2(SHA2)]	= "sha2",
> +	[COMPAT_KERNEL_HWCAP2(CRC32)]	= "crc32",
> +	NULL,
> +};
> +#endif /* CONFIG_COMPAT */
> +

[...]
