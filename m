Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78062C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E0C0221ED
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgIKP2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:28:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbgIKPZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:25:01 -0400
Received: from gaia (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCB282076C;
        Fri, 11 Sep 2020 15:24:58 +0000 (UTC)
Date:   Fri, 11 Sep 2020 16:24:56 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, will@kernel.org,
        Mark Brown <broonie@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4] arm64/cpuinfo: Define HWCAP name arrays per their
 actual bit definitions
Message-ID: <20200911152455.GG12835@gaia>
References: <1599630535-29337-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599630535-29337-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 11:18:55AM +0530, Anshuman Khandual wrote:
> HWCAP name arrays (hwcap_str, compat_hwcap_str, compat_hwcap2_str) that are
> scanned for /proc/cpuinfo are detached from their bit definitions making it
> vulnerable and difficult to correlate. It is also bit problematic because
> during /proc/cpuinfo dump these arrays get traversed sequentially assuming
> they reflect and match actual HWCAP bit sequence, to test various features
> for a given CPU. This redefines name arrays per their HWCAP bit definitions
> . It also warns after detecting any feature which is not expected on arm64.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Dave Martin <Dave.Martin@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on 5.9-rc4
> 
> Mark, since the patch has changed I have dropped your Acked-by: tag. Are you
> happy to give a new one ?
> 
> Changes in V4:
> 
> - Unified all three HWCAP array traversal per Will
> 
> Changes in V3: (https://patchwork.kernel.org/patch/11718113/)
> 
> - Moved name arrays to (arch/arm64/kernel/cpuinfo.c) to prevent a build warning
> - Replaced string values with NULL for all compat features not possible on arm64
> - Changed compat_hwcap_str[] iteration on size as some NULL values are expected
> - Warn once after detecting any feature on arm64 that is not expected
> 
> Changes in V2: (https://patchwork.kernel.org/patch/11533755/)
> 
> - Defined COMPAT_KERNEL_HWCAP[2] and updated the name arrays per Mark
> - Updated the commit message as required
> 
> Changes in V1: (https://patchwork.kernel.org/patch/11532945/)
> 
>  arch/arm64/include/asm/hwcap.h |   9 ++
>  arch/arm64/kernel/cpuinfo.c    | 176 +++++++++++++++++----------------
>  2 files changed, 101 insertions(+), 84 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
> index 22f73fe09030..6493a4c63a2f 100644
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
>  
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index d0076c2159e6..04640f5f9f0f 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -43,94 +43,93 @@ static const char *icache_policy_str[] = {
>  unsigned long __icache_flags;
>  
>  static const char *const hwcap_str[] = {
> -	"fp",
> -	"asimd",
> -	"evtstrm",
> -	"aes",
> -	"pmull",
> -	"sha1",
> -	"sha2",
> -	"crc32",
> -	"atomics",
> -	"fphp",
> -	"asimdhp",
> -	"cpuid",
> -	"asimdrdm",
> -	"jscvt",
> -	"fcma",
> -	"lrcpc",
> -	"dcpop",
> -	"sha3",
> -	"sm3",
> -	"sm4",
> -	"asimddp",
> -	"sha512",
> -	"sve",
> -	"asimdfhm",
> -	"dit",
> -	"uscat",
> -	"ilrcpc",
> -	"flagm",
> -	"ssbs",
> -	"sb",
> -	"paca",
> -	"pacg",
> -	"dcpodp",
> -	"sve2",
> -	"sveaes",
> -	"svepmull",
> -	"svebitperm",
> -	"svesha3",
> -	"svesm4",
> -	"flagm2",
> -	"frint",
> -	"svei8mm",
> -	"svef32mm",
> -	"svef64mm",
> -	"svebf16",
> -	"i8mm",
> -	"bf16",
> -	"dgh",
> -	"rng",
> -	"bti",
> +	[KERNEL_HWCAP_FP]		= "fp",
> +	[KERNEL_HWCAP_ASIMD]		= "asimd",
> +	[KERNEL_HWCAP_EVTSTRM]		= "evtstrm",
> +	[KERNEL_HWCAP_AES]		= "aes",
> +	[KERNEL_HWCAP_PMULL]		= "pmull",
> +	[KERNEL_HWCAP_SHA1]		= "sha1",
> +	[KERNEL_HWCAP_SHA2]		= "sha2",
> +	[KERNEL_HWCAP_CRC32]		= "crc32",
> +	[KERNEL_HWCAP_ATOMICS]		= "atomics",
> +	[KERNEL_HWCAP_FPHP]		= "fphp",
> +	[KERNEL_HWCAP_ASIMDHP]		= "asimdhp",
> +	[KERNEL_HWCAP_CPUID]		= "cpuid",
> +	[KERNEL_HWCAP_ASIMDRDM]		= "asimdrdm",
> +	[KERNEL_HWCAP_JSCVT]		= "jscvt",
> +	[KERNEL_HWCAP_FCMA]		= "fcma",
> +	[KERNEL_HWCAP_LRCPC]		= "lrcpc",
> +	[KERNEL_HWCAP_DCPOP]		= "dcpop",
> +	[KERNEL_HWCAP_SHA3]		= "sha3",
> +	[KERNEL_HWCAP_SM3]		= "sm3",
> +	[KERNEL_HWCAP_SM4]		= "sm4",
> +	[KERNEL_HWCAP_ASIMDDP]		= "asimddp",
> +	[KERNEL_HWCAP_SHA512]		= "sha512",
> +	[KERNEL_HWCAP_SVE]		= "sve",
> +	[KERNEL_HWCAP_ASIMDFHM]		= "asimdfhm",
> +	[KERNEL_HWCAP_DIT]		= "dit",
> +	[KERNEL_HWCAP_USCAT]		= "uscat",
> +	[KERNEL_HWCAP_ILRCPC]		= "ilrcpc",
> +	[KERNEL_HWCAP_FLAGM]		= "flagm",
> +	[KERNEL_HWCAP_SSBS]		= "ssbs",
> +	[KERNEL_HWCAP_SB]		= "sb",
> +	[KERNEL_HWCAP_PACA]		= "paca",
> +	[KERNEL_HWCAP_PACG]		= "pacg",
> +	[KERNEL_HWCAP_DCPODP]		= "dcpodp",
> +	[KERNEL_HWCAP_SVE2]		= "sve2",
> +	[KERNEL_HWCAP_SVEAES]		= "sveaes",
> +	[KERNEL_HWCAP_SVEPMULL]		= "svepmull",
> +	[KERNEL_HWCAP_SVEBITPERM]	= "svebitperm",
> +	[KERNEL_HWCAP_SVESHA3]		= "svesha3",
> +	[KERNEL_HWCAP_SVESM4]		= "svesm4",
> +	[KERNEL_HWCAP_FLAGM2]		= "flagm2",
> +	[KERNEL_HWCAP_FRINT]		= "frint",
> +	[KERNEL_HWCAP_SVEI8MM]		= "svei8mm",
> +	[KERNEL_HWCAP_SVEF32MM]		= "svef32mm",
> +	[KERNEL_HWCAP_SVEF64MM]		= "svef64mm",
> +	[KERNEL_HWCAP_SVEBF16]		= "svebf16",
> +	[KERNEL_HWCAP_I8MM]		= "i8mm",
> +	[KERNEL_HWCAP_BF16]		= "bf16",
> +	[KERNEL_HWCAP_DGH]		= "dgh",
> +	[KERNEL_HWCAP_RNG]		= "rng",
> +	[KERNEL_HWCAP_BTI]		= "bti",
>  	/* reserved for "mte" */
> -	NULL
>  };

With this initialisation, we no longer need the "reserved for mte"
string.

Otherwise, feel free to add:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
