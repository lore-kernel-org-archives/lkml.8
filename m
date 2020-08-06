Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DC0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00D54206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbgHFRdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:33:04 -0400
Received: from foss.arm.com ([217.140.110.172]:46002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729889AbgHFRcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:32:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7906D1063;
        Thu,  6 Aug 2020 04:33:17 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE94F3F99C;
        Thu,  6 Aug 2020 04:33:15 -0700 (PDT)
Date:   Thu, 6 Aug 2020 12:33:13 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] arm64: tlb: fix ARM64_TLB_RANGE with LLVM's integrated
 assembler
Message-ID: <20200806113313.GC23785@gaia>
References: <20200805181920.4013059-1-samitolvanen@google.com>
 <95156879-d76e-65cc-1469-ae3096aa95e4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95156879-d76e-65cc-1469-ae3096aa95e4@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 03:17:40PM +0800, Zhenyu Ye wrote:
> On 2020/8/6 2:19, Sami Tolvanen wrote:
> > Commit 7c78f67e9bd9 ("arm64: enable tlbi range instructions") breaks
> > LLVM's integrated assembler, because -Wa,-march is only passed to
> > external assemblers and therefore, the new instructions are not enabled
> > when IAS is used.
> 
> I have looked through the discussion on Github issues. The best way to
> solve this problem is try to pass the "-Wa,-march" parameter to clang
> even when IAS is enabled, which may need the cooperation of compilation
> tool chains :(
> 
> Currently, I think we can solve the problem by passing
> the '-march=armv8.4-a' when using the integrated assembler, just like:
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 55bc8546d9c7..e5ce184e98c2 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -91,8 +91,12 @@ KBUILD_CFLAGS += $(branch-prot-flags-y)
> 
>  ifeq ($(CONFIG_AS_HAS_ARMV8_4), y)
>  # make sure to pass the newest target architecture to -march.
> +ifneq ($(LLVM),)
> +KBUILD_CFLAGS  += -march=armv8.4-a
> +else
>  KBUILD_CFLAGS  += -Wa,-march=armv8.4-a
>  endif
> +endif

No, see my other reply. This only works for .S files. For inline
assembly, passing -march to .c files will make the compiler generate
ARMv8.4 instructions and break the kernel single image that's supposed
to run on ARMv8.0 hardware (even if you don't have any range TLBI
instructions).

-- 
Catalin
