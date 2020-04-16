Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B976C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E1C5206A2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408928AbgDPOzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:55:01 -0400
Received: from foss.arm.com ([217.140.110.172]:34760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408363AbgDPOyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:54:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DF521FB;
        Thu, 16 Apr 2020 07:54:51 -0700 (PDT)
Received: from [10.37.12.32] (unknown [10.37.12.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0AEE3F237;
        Thu, 16 Apr 2020 07:54:48 -0700 (PDT)
Subject: Re: [PATCH 8/8] arm64: cpufeature: Add an overview comment for the
 cpufeature framework
To:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com, maz@kernel.org,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        saiprakash.ranjan@codeaurora.org, dianders@chromium.org,
        kernel-team@android.com
References: <20200414213114.2378-1-will@kernel.org>
 <20200414213114.2378-9-will@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <96dd797d-ccfe-c867-0a70-65eccacde3cd@arm.com>
Date:   Thu, 16 Apr 2020 15:59:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200414213114.2378-9-will@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 04/14/2020 10:31 PM, Will Deacon wrote:
> Now that Suzuki isn't within throwing distance, I thought I'd better add
> a rough overview comment to cpufeature.c so that it doesn't take me days
> to remember how it works next time.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>   arch/arm64/kernel/cpufeature.c | 43 ++++++++++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 680a453ca8c4..421ca99dc8fc 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -3,6 +3,49 @@
>    * Contains CPU feature definitions
>    *
>    * Copyright (C) 2015 ARM Ltd.
> + *
> + * A note for the weary kernel hacker: the code here is confusing and hard to
> + * follow! That's partly because it's solving a nasty problem, but also because
> + * there's a little bit of over-abstraction that tends to obscure what's going
> + * on behind a maze of helper functions and macros.

Thanks for writing this up !

> + *
> + * The basic problem is that hardware folks have started gluing together CPUs
> + * with distinct architectural features; in some cases even creating SoCs where
> + * user-visible instructions are available only on a subset of the available
> + * cores. We try to address this by snapshotting the feature registers of the
> + * boot CPU and comparing these with the feature registers of each secondary
> + * CPU when bringing them up. If there is a mismatch, then we update the
> + * snapshot state to indicate the lowest-common denominator of the feature,
> + * known as the "safe" value. This snapshot state can be queried to view the

I am not sure if the following is implied above.

   1) Against the "snapshot" state, where mismatches triggers updating
      the "snapshot" state to reflect the "safe" value.

   2) Compared against the CPU feature registers of *the boot CPU* for
     "FTR_STRICT" fields and any mismatch triggers TAINT_CPU_OUT_OF_SPEC.
      This makes sure that warning is generated for each OUT_OF_SPEC
      secondary CPU.

> + * "sanitised" value of a feature register.
> + *
> + * The sanitised register values are used to decide which capabilities we
> + * have in the system. These may be in the form of traditional "hwcaps"
> + * advertised to userspace or internal "cpucaps" which are used to configure
> + * things like alternative patching and static keys. While a feature mismatch
> + * may result in a TAINT_CPU_OUT_OF_SPEC kernel taint, a capability mismatch
> + * may prevent a CPU from being onlined at all.
> + *
> + * Some implementation details worth remembering:
> + *
> + * - Mismatched features are *always* sanitised to a "safe" value, which
> + *   usually indicates that the feature is not supported.
> + *
> + * - A mismatched feature marked with FTR_STRICT will cause a "SANITY CHECK"
> + *   warning when onlining an offending CPU and the kernel will be tainted
> + *   with TAINT_CPU_OUT_OF_SPEC.

As mentioned above, this check is against that of the "boot CPU"
register state, which may not be implicit from the statement.

> + *
> + * - Features marked as FTR_VISIBLE have their sanitised value visible to
> + *   userspace. FTR_VISIBLE features in registers that are only visible
> + *   to EL0 by trapping *must* have a corresponding HWCAP so that late
> + *   onlining of CPUs cannot lead to features disappearing at runtime.
> + *

As you mentioned in the other response we could add information about
the guest view, something like :

       - KVM exposes the sanitised value of the feature registers to the
	guests and is not affected by the FTR_VISIBLE. However,
	depending on the individual feature support in the hypervisor,
	some of the fields may be capped/limited.

Cheers
Suzuki
