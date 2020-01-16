Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91F0C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B735D24699
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579197224;
	bh=eZc1L4+pca2HQRZ4NlFHXHq40yJapRdOmzlFzQ/cknQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ze/0llqHOBWcm40LAvXHwVHKrqzK6QIImnV8AVn7s7FbsRHgCbDlgScJAM+Q6YM5G
	 NNUUv6xKcwcOUMEgBLEGbE8plnK5aVxReM7Dna5E5jvWf1OYGRyBYjGzNRdg573iDD
	 vIT6XbW4H4qkY0yAP5JUeUxqbGVx9qLzbIhx8QNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394453AbgAPRxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:53:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:36294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406021AbgAPRo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:44:58 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D46112477B;
        Thu, 16 Jan 2020 17:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196697;
        bh=eZc1L4+pca2HQRZ4NlFHXHq40yJapRdOmzlFzQ/cknQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zlHbDbVJTAEzMxf/SUtdxJAXgWWsPwuJLkj5y/dsFpdWk6r25yTkB4U8bYfo9zX64
         84fLlEQVbP4jGLbiOgOA8O5xtVXhKMTROUWezOITnG+sEvonw9zZ2G1XCxQxKBbcNo
         IIkiMjs9fllhsIEfoPhk17Sc1+ru8i2vFwMMaDwY=
Date:   Thu, 16 Jan 2020 17:44:51 +0000
From:   Will Deacon <will@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
Subject: Re: [PATCH v6 11/15] arm64: efi: restore x18 if it was corrupted
Message-ID: <20200116174450.GD21396@willie-the-truck>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191206221351.38241-1-samitolvanen@google.com>
 <20191206221351.38241-12-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206221351.38241-12-samitolvanen@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 02:13:47PM -0800, Sami Tolvanen wrote:
> If we detect a corrupted x18 and SCS is enabled, restore the register
> before jumping back to instrumented code. This is safe, because the
> wrapper is called with preemption disabled and a separate shadow stack
> is used for interrupt handling.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/arm64/kernel/efi-rt-wrapper.S | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/efi-rt-wrapper.S b/arch/arm64/kernel/efi-rt-wrapper.S
> index 3fc71106cb2b..62f0260f5c17 100644
> --- a/arch/arm64/kernel/efi-rt-wrapper.S
> +++ b/arch/arm64/kernel/efi-rt-wrapper.S
> @@ -34,5 +34,14 @@ ENTRY(__efi_rt_asm_wrapper)
>  	ldp	x29, x30, [sp], #32
>  	b.ne	0f
>  	ret
> -0:	b	efi_handle_corrupted_x18	// tail call
> +0:
> +#ifdef CONFIG_SHADOW_CALL_STACK
> +	/*
> +	 * Restore x18 before returning to instrumented code. This is
> +	 * safe because the wrapper is called with preemption disabled and
> +	 * a separate shadow stack is used for interrupts.
> +	 */
> +	mov	x18, x2
> +#endif

Why not restore it regardless of CONFIG_SHADOW_CALL_STACK?

Will
