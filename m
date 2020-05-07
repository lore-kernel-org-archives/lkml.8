Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FA2C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3F5020870
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgEGLRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 07:17:34 -0400
Received: from foss.arm.com ([217.140.110.172]:56716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgEGLRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 07:17:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 758961FB;
        Thu,  7 May 2020 04:17:32 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.26.168])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87C063F68F;
        Thu,  7 May 2020 04:17:30 -0700 (PDT)
Date:   Thu, 7 May 2020 12:17:27 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/cpuinfo: Move HWCAP name arrays alongside their
 bit definitions
Message-ID: <20200507111727.GB5726@C02TD0UTHF1T.local>
References: <1588845390-2032-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588845390-2032-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 03:26:30PM +0530, Anshuman Khandual wrote:
> All HWCAP name arrays (i.e hwcap_str, compat_hwcap_str, compat_hwcap2_str)
> that are scanned for /proc/cpuinfo output are detached from their bit fild
> definitions making it difficult to corelate. This is also bit problematic
> because during /proc/cpuinfo dump these arrays get traversed sequentially
> assuming that they reflect and match HWCAP bit sequence, to test various
> features for a given CPU.

Making this relationship explicit is certianly a good idea!

> This moves all HWCAP name arrays near their bit definitions. But first it
> defines all missing COMPAT_HWCAP_XXX that are present in the name string.
> Also defines all COMPAT_KERNEL_HWCAP macros to be used for the HWCAP name
> string indexing.

I think we don't need all the indirection here, and can simplify things
a bit. Comments on that below.

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
> ---
> In longer term we might want to generate these HWCAP macros with scripting,
> and this is a step in that direction. This applies on 5.7-rc4.

Having attempted to build scripting for this in the past, it turns out
to be a bigger job than it seems initially, and I agree it'd make sense
to take a change like this without scripting as a first step.

>  arch/arm64/include/asm/hwcap.h | 132 +++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/cpuinfo.c    |  90 ----------------------
>  2 files changed, 132 insertions(+), 90 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
> index 0f00265248b5..cb99b5f75e5d 100644
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
> @@ -95,6 +104,129 @@
>  #define KERNEL_HWCAP_DGH		__khwcap2_feature(DGH)
>  #define KERNEL_HWCAP_RNG		__khwcap2_feature(RNG)
>  
> +#ifdef CONFIG_COMPAT
> +#define __compat_khwcap_feature(x)	const_ilog2(COMPAT_HWCAP_ ## x)

For now I reckon this can be:

#define COMPAT_KERNEL_HWCAP(x)		const_ilog2(COMPAT_HWCAP_##x)

> +#define COMPAT_KERNEL_HWCAP_SWP		__compat_khwcap_feature(SWP)
> +#define COMPAT_KERNEL_HWCAP_HALF	__compat_khwcap_feature(HALF)
> +#define COMPAT_KERNEL_HWCAP_THUMB	__compat_khwcap_feature(THUMB)
> +#define COMPAT_KERNEL_HWCAP_26BIT	__compat_khwcap_feature(26BIT)
> +#define COMPAT_KERNEL_HWCAP_FAST_MULT	__compat_khwcap_feature(FAST_MULT)
> +#define COMPAT_KERNEL_HWCAP_FPA		__compat_khwcap_feature(FPA)
> +#define COMPAT_KERNEL_HWCAP_VFP		__compat_khwcap_feature(VFP)
> +#define COMPAT_KERNEL_HWCAP_EDSP	__compat_khwcap_feature(EDSP)
> +#define COMPAT_KERNEL_HWCAP_JAVA	__compat_khwcap_feature(JAVA)
> +#define COMPAT_KERNEL_HWCAP_IWMMXT	__compat_khwcap_feature(IWMMXT)
> +#define COMPAT_KERNEL_HWCAP_CRUNCH	__compat_khwcap_feature(CRUNCH)
> +#define COMPAT_KERNEL_HWCAP_THUMBEE	__compat_khwcap_feature(THUMBEE)
> +#define COMPAT_KERNEL_HWCAP_NEON	__compat_khwcap_feature(NEON)
> +#define COMPAT_KERNEL_HWCAP_VFPv3	__compat_khwcap_feature(VFPv3)
> +#define COMPAT_KERNEL_HWCAP_VFPV3D16	__compat_khwcap_feature(VFPV3D16)
> +#define COMPAT_KERNEL_HWCAP_TLS		__compat_khwcap_feature(TLS)
> +#define COMPAT_KERNEL_HWCAP_VFPv4	__compat_khwcap_feature(VFPv4)
> +#define COMPAT_KERNEL_HWCAP_IDIVA	__compat_khwcap_feature(IDIVA)
> +#define COMPAT_KERNEL_HWCAP_IDIVT	__compat_khwcap_feature(IDIVT)
> +#define COMPAT_KERNEL_HWCAP_VFPD32	__compat_khwcap_feature(VFPD32)
> +#define COMPAT_KERNEL_HWCAP_LPAE	__compat_khwcap_feature(LPAE)
> +#define COMPAT_KERNEL_HWCAP_EVTSTRM	__compat_khwcap_feature(EVTSTRM)

... so we don't need any of the above, as e.g. we can just do:

	[COMPAT_KERNEL_HWCAP(SWP)] = "swp",

... at the points of usage.

> +#define __compat_khwcap2_feature(x)	const_ilog2(COMPAT_HWCAP2_ ## x)
> +#define COMPAT_KERNEL_HWCAP_AES		__compat_khwcap2_feature(AES)
> +#define COMPAT_KERNEL_HWCAP_PMULL	__compat_khwcap2_feature(PMULL)
> +#define COMPAT_KERNEL_HWCAP_SHA1	__compat_khwcap2_feature(SHA1)
> +#define COMPAT_KERNEL_HWCAP_SHA2	__compat_khwcap2_feature(SHA2)
> +#define COMPAT_KERNEL_HWCAP_CRC32	__compat_khwcap2_feature(CRC32)

Likewise here with:

#define COMPAT_KERNEL_HWCAP2(x)		const_ilog2(COMPAT_HWCAP2_##x)

With that, and the usage in the arrays changed to match:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
