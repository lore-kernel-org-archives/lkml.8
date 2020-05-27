Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DD5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B40F9207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbgE0PYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:24:11 -0400
Received: from foss.arm.com ([217.140.110.172]:39994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbgE0PYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:24:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3DDD30E;
        Wed, 27 May 2020 08:24:10 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.7.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01D3E3F52E;
        Wed, 27 May 2020 08:24:08 -0700 (PDT)
Date:   Wed, 27 May 2020 16:24:06 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: disable -fsanitize=shadow-call-stack for
 big-endian
Message-ID: <20200527152406.GD59947@C02TD0UTHF1T.local>
References: <20200527134016.753354-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527134016.753354-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 03:39:46PM +0200, Arnd Bergmann wrote:
> clang-11 and earlier do not support -fsanitize=shadow-call-stack
> in combination with -mbig-endian, but the Kconfig check does not
> pass the endianess flag, so building a big-endian kernel with
> this fails at build time:
> 
> clang: error: unsupported option '-fsanitize=shadow-call-stack' for target 'aarch64_be-unknown-linux'
> 
> Change the Kconfig check to let Kconfig figure this out earlier
> and prevent the broken configuration. I assume this is a bug
> in clang that needs to be fixed, but we also have to work
> around existing releases.
> 
> Fixes: 5287569a790d ("arm64: Implement Shadow Call Stack")
> Link: https://bugs.llvm.org/show_bug.cgi?id=46076
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I suspect this is similar to the patchable-function-entry issue, and
this is an oversight that we'd rather fix toolchain side.

Nick, Fangrui, thoughts?

Mark.

> ---
>  arch/arm64/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a82441d6dc36..692e1575a6c8 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1031,7 +1031,9 @@ config ARCH_ENABLE_SPLIT_PMD_PTLOCK
>  
>  # Supported by clang >= 7.0
>  config CC_HAVE_SHADOW_CALL_STACK
> -	def_bool $(cc-option, -fsanitize=shadow-call-stack -ffixed-x18)
> +	bool
> +	default $(cc-option, -fsanitize=shadow-call-stack -ffixed-x18 -mbig-endian) if CPU_BIG_ENDIAN
> +	default $(cc-option, -fsanitize=shadow-call-stack -ffixed-x18 -mlittle-endian) if !CPU_BIG_ENDIAN
>  
>  config SECCOMP
>  	bool "Enable seccomp to safely compute untrusted bytecode"
> -- 
> 2.26.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
