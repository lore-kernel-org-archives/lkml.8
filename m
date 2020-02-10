Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF62C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E5C20838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581352899;
	bh=swgRA1rNS8tBiz0g1uvNqRf9FaXIwO8m18YRqWdGIWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=anOeHUgKM9R//cp2LL+uhNykMC5UYdML+riBncBoTF9jB9ldLnK/NPWRBPkkYGaC9
	 j2IxCpvTz8+lQo1yc1nwL339p+/n1ValACR9kI5CJXvaDb5H1vbVHMYESotwRM1K/u
	 lA5JLB232TJfo5RHOHhsJTX1iLAnVULsl/h6vPOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgBJQlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:41:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:38796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbgBJQli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 11:41:38 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3926920733;
        Mon, 10 Feb 2020 16:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581352898;
        bh=swgRA1rNS8tBiz0g1uvNqRf9FaXIwO8m18YRqWdGIWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xZ9yor3PmK0g2VGI7TH5dURt6qVd/7JoQzVJWSGzhMpbis9o4lzC+9ygWQ0663Ml8
         mNsCjyu4UABSsLLe5Ja4m3XnHu6ZdABdFV/OZcz8udClXlNzbDXjPXG7WWBZAvWWNt
         S1LX2V8l6/MoP4lkNDVfdgj8iQdTmKUYem8h+bsE=
Date:   Mon, 10 Feb 2020 16:41:32 +0000
From:   Will Deacon <will@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, james.morse@arm.com,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 07/11] arm64: efi: restore x18 if it was corrupted
Message-ID: <20200210164131.GB21900@willie-the-truck>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200128184934.77625-1-samitolvanen@google.com>
 <20200128184934.77625-8-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128184934.77625-8-samitolvanen@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 10:49:30AM -0800, Sami Tolvanen wrote:
> If we detect a corrupted x18, restore the register before jumping back
> to potentially SCS instrumented code. This is safe, because the wrapper
> is called with preemption disabled and a separate shadow stack is used
> for interrupt handling.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/arm64/kernel/efi-rt-wrapper.S | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/efi-rt-wrapper.S b/arch/arm64/kernel/efi-rt-wrapper.S
> index 3fc71106cb2b..6ca6c0dc11a1 100644
> --- a/arch/arm64/kernel/efi-rt-wrapper.S
> +++ b/arch/arm64/kernel/efi-rt-wrapper.S
> @@ -34,5 +34,14 @@ ENTRY(__efi_rt_asm_wrapper)
>  	ldp	x29, x30, [sp], #32
>  	b.ne	0f
>  	ret
> -0:	b	efi_handle_corrupted_x18	// tail call
> +0:
> +	/*
> +	 * With CONFIG_SHADOW_CALL_STACK, the kernel uses x18 to store a
> +	 * shadow stack pointer, which we need to restore before returning to
> +	 * potentially instrumented code. This is safe because the wrapper is
> +	 * called with preemption disabled and a separate shadow stack is used
> +	 * for interrupts.
> +	 */
> +	mov	x18, x2
> +	b	efi_handle_corrupted_x18	// tail call
>  ENDPROC(__efi_rt_asm_wrapper)

Acked-by: Will Deacon <will@kernel.org>

Will
