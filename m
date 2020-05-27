Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493B5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A031207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388650AbgE0Npi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:45:38 -0400
Received: from foss.arm.com ([217.140.110.172]:38740 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387581AbgE0Nph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:45:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBFFB55D;
        Wed, 27 May 2020 06:45:36 -0700 (PDT)
Received: from [10.57.2.168] (unknown [10.57.2.168])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0FB23F6C4;
        Wed, 27 May 2020 06:45:34 -0700 (PDT)
Subject: Re: [PATCH] arm64: vdso32: force vdso32 to be compiled as -marm
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Stephen Boyd <swboyd@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20200526173117.155339-1-ndesaulniers@google.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <2f58c2a4-0f37-d507-7767-00161c6b5d98@arm.com>
Date:   Wed, 27 May 2020 14:45:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200526173117.155339-1-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-26 18:31, Nick Desaulniers wrote:
> Custom toolchains that modify the default target to -mthumb cannot
> compile the arm64 compat vdso32, as
> arch/arm64/include/asm/vdso/compat_gettimeofday.h
> contains assembly that's invalid in -mthumb.  Force the use of -marm,
> always.

FWIW, this seems suspicious - the only assembly instructions I see there 
are SWI(SVC), MRRC, and a MOV, all of which exist in Thumb for the 
-march=armv7a baseline that we set.

On a hunch, I've just bodged "VDSO_CFLAGS += -mthumb" into my tree and 
built a Thumb VDSO quite happily with Ubuntu 19.04's 
gcc-arm-linux-gnueabihf. What was the actual failure you saw?

Robin.

> Link: https://bugs.chromium.org/p/chromium/issues/detail?id=1084372
> Cc: Stephen Boyd <swboyd@google.com>
> Reported-by: Luis Lozano <llozano@google.com>
> Tested-by: Manoj Gupta <manojgupta@google.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Surgeon General's Warning: changing the compiler defaults is not
> recommended and can lead to spooky bugs that are hard to reproduce
> upstream.
> 
>   arch/arm64/kernel/vdso32/Makefile | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
> index 3964738ebbde..c449a293d81e 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -104,6 +104,8 @@ VDSO_CFLAGS += -D__uint128_t='void*'
>   # (on GCC 4.8 or older, there is unfortunately no way to silence this warning)
>   VDSO_CFLAGS += $(call cc32-disable-warning,shift-count-overflow)
>   VDSO_CFLAGS += -Wno-int-to-pointer-cast
> +# Force vdso to be compiled in ARM mode, not THUMB.
> +VDSO_CFLAGS += -marm
>   
>   VDSO_AFLAGS := $(VDSO_CAFLAGS)
>   VDSO_AFLAGS += -D__ASSEMBLY__
> 
