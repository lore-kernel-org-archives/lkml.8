Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968F2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 17:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 724F720829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 17:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbgG3RYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 13:24:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgG3RYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 13:24:35 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F144020809;
        Thu, 30 Jul 2020 17:24:33 +0000 (UTC)
Date:   Thu, 30 Jul 2020 18:24:31 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] arm64/alternatives: move length validation inside the
 subsection
Message-ID: <20200730172430.GC3128@gaia>
References: <20200729215152.662225-1-samitolvanen@google.com>
 <20200730153701.3892953-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730153701.3892953-1-samitolvanen@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 08:37:01AM -0700, Sami Tolvanen wrote:
> Commit f7b93d42945c ("arm64/alternatives: use subsections for replacement
> sequences") breaks LLVM's integrated assembler, because due to its
> one-pass design, it cannot compute instruction sequence lengths before the
> layout for the subsection has been finalized. This change fixes the build
> by moving the .org directives inside the subsection, so they are processed
> after the subsection layout is known.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1078
> Fixes: f7b93d42945c ("arm64/alternatives: use subsections for replacement sequences")
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
> v1 -> v2:
> - Added the missing Fixes tag and dropped CC: stable@.
> 
> ---
>  arch/arm64/include/asm/alternative.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
> index 12f0eb56a1cc..619db9b4c9d5 100644
> --- a/arch/arm64/include/asm/alternative.h
> +++ b/arch/arm64/include/asm/alternative.h
> @@ -77,9 +77,9 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
>  	"663:\n\t"							\
>  	newinstr "\n"							\
>  	"664:\n\t"							\
> -	".previous\n\t"							\
>  	".org	. - (664b-663b) + (662b-661b)\n\t"			\
> -	".org	. - (662b-661b) + (664b-663b)\n"			\
> +	".org	. - (662b-661b) + (664b-663b)\n\t"			\
> +	".previous\n"							\
>  	".endif\n"

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

There are a few instances of the .org test outside the subsection,
though using in .S files. Are those ok?

-- 
Catalin
