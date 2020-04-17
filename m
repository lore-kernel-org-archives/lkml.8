Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9127CC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 720FC21D91
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G25zyJyL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgDQKBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgDQKBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:01:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E52C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 03:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/sCrLJsk9M0RFgQwNkauJ/Dtc5/K6rCJg0npReZJ/ZM=; b=G25zyJyLZs4ijof9NKQ93s/RtD
        tp1CABmZSWsvURGWx1WS3YUul4JFfkwKfPlMdOUMLdf0WJVJTQmYH7kEnhXsJQOx0kyS3h3w+4g5E
        s+xd6331OtUvGqwz0rttWZMMrZR+P8JR5WVKgcxW9SWh1X+w7ZXxIONjudPt4TumeaAQPaOiHvfJf
        hqJFmA4o3d/ICe7K81YdhfKX/Cu65J5gdmf91MuW2YmlJLqzGWkPWtZYiYRHVPbv0K/7xLORS8GtG
        SAJt6bXYa7kxdX69qaFDx4rwpwhNl0i+c4WbpER2GL+jX2fzS/+iDQNUr+t6P36U7llVMhvrYMKxh
        yu548iOQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPNne-000501-Rg; Fri, 17 Apr 2020 10:00:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 816003010BC;
        Fri, 17 Apr 2020 12:00:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6AB682B120750; Fri, 17 Apr 2020 12:00:39 +0200 (CEST)
Date:   Fri, 17 Apr 2020 12:00:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 04/12] scs: disable when function graph tracing is
 enabled
Message-ID: <20200417100039.GS20730@hirez.programming.kicks-ass.net>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200416161245.148813-1-samitolvanen@google.com>
 <20200416161245.148813-5-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416161245.148813-5-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 09:12:37AM -0700, Sami Tolvanen wrote:
> The graph tracer hooks returns by modifying frame records on the
> (regular) stack, but with SCS the return address is taken from the
> shadow stack, and the value in the frame record has no effect. As we
> don't currently have a mechanism to determine the corresponding slot
> on the shadow stack (and to pass this through the ftrace
> infrastructure), for now let's disable SCS when the graph tracer is
> enabled.
> 
> With SCS the return address is taken from the shadow stack and the
> value in the frame record has no effect. The mcount based graph tracer
> hooks returns by modifying frame records on the (regular) stack, and
> thus is not compatible. The patchable-function-entry graph tracer
> used for DYNAMIC_FTRACE_WITH_REGS modifies the LR before it is saved
> to the shadow stack, and is compatible.
> 
> Modifying the mcount based graph tracer to work with SCS would require
> a mechanism to determine the corresponding slot on the shadow stack
> (and to pass this through the ftrace infrastructure), and we expect
> that everyone will eventually move to the patchable-function-entry
> based graph tracer anyway, so for now let's disable SCS when the
> mcount-based graph tracer is enabled.
> 
> SCS and patchable-function-entry are both supported from LLVM 10.x.

SCS would actually provide another way to do return hooking. An arguably
much saner model at that.

The 'normal' way is to (temporary) replace the on-stack return value,
and then replace it back in the return handler. This is because we can't
simply push a fake return on the stack, because that would wreck the
expected stack layout of the regular function.

But there is nothing that would stop us from pushing an extra entry on
the SCS. It would in fact be a much cleaner solution. The entry hook
sticks an extra entry on the SCS, the function ignores what's on the
normal stack and pops from the SCS, we return to the exit handler, which
in turn pops from the SCS stack at which point we're back to regular.

The only 'funny' is that the exit handler itself should not push to the
SCS, or we should frob the return-to-exit-handler such that it lands
after the push.

> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> ---
>  arch/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 691a552c2cc3..c53cb9025ad2 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -542,6 +542,7 @@ config ARCH_SUPPORTS_SHADOW_CALL_STACK
>  
>  config SHADOW_CALL_STACK
>  	bool "Clang Shadow Call Stack"
> +	depends on DYNAMIC_FTRACE_WITH_REGS || !FUNCTION_GRAPH_TRACER
>  	depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
>  	help
>  	  This option enables Clang's Shadow Call Stack, which uses a

AFAICT you also need to kill KRETPROBES, which plays similar games. And
doesn't BPF also do stuff like this?
