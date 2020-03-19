Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88D1C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 23:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94EFE2076C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 23:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g01y/QG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgCSXoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 19:44:10 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35382 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgCSXoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 19:44:10 -0400
Received: by mail-pj1-f68.google.com with SMTP id j20so1694887pjz.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 16:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R0+TGEcl33aqQZuHdJpZvB8paDQF2GsWepjBb7GJLN0=;
        b=g01y/QG6zB8hIiuj4wDvdx12dB7i4g2oOiN2aFecZXwj8QAY5tVLL5iH3uhtkQGtIN
         jqOlFcSJx7THcCtImBOQp1HaO+lNQ+y4mrfz+L5YbFg1WV7xn/VHwnxKtcCyGnPAI4bQ
         QoFNLnT5RQOyW5H2iDh8lvr24e7GmW0icEfczV6Zm/Y3OHI1HS+67AZVEl3sVe2+9o8G
         WZqBAoaIyte3bSpt/ez2IaL5dP6H0eBBqL0SyclRJw5tJzQ14gmaCmbRp2u5Y+YSbZs1
         xq1BRnFqNQxqpvsjMirdME/B+it8upp2FMVE2cmR091yQWxNavqNHwWL+gVz4ovunboZ
         lCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R0+TGEcl33aqQZuHdJpZvB8paDQF2GsWepjBb7GJLN0=;
        b=D4uULQZIKlYnGR+YkiJUS7GcWMmO8oYx+ajQEA/WaZTK2YvZRsAulI7xrnvRYYDhF3
         +2AmKgUBMVa77iBMMiYIkjWQ8iOUGTt5N/mjxBJhGPM03eMDkYtSAaxTkYREB8/BRdo3
         1cFDahMFV5dRBp7t/Cv54WCv30629/IBDEwkMZDQoMdnuwAtC84CfXN7CmNY/I83oWax
         mooaOih3AgmnIvQar4SiyQd0XevMwKHfZ+ViZ3IhYkXtbbUq2j/LQTk0pA4ZooNSiNEs
         qNB7j0aqVdYxymu1aiiI+8kd3Eu3yh3gfaw+sW5wMIvARJBuhLwnE0+uZ9tJAHfx8IEm
         cCBQ==
X-Gm-Message-State: ANhLgQ3sHNIpu1pj85W5T1uG+4kQROSWpTaatQueuWpymdpku2t4yLw+
        fYz5jVEPwVI+nCgrwp72iciwKQYFdthdCEUQL5JlSA==
X-Google-Smtp-Source: ADFU+vtliPn0Z54RcDzNcvaqRpfR5R9aZU+uGpjGhHuUBhqLn7elEClsTACLZUjB8MWlbn/itDALZ2t4CjWaipi5Fng=
X-Received: by 2002:a17:902:820a:: with SMTP id x10mr2291998pln.179.1584661448715;
 Thu, 19 Mar 2020 16:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200319214530.2046-1-ilie.halip@gmail.com>
In-Reply-To: <20200319214530.2046-1-ilie.halip@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 19 Mar 2020 16:43:56 -0700
Message-ID: <CAKwvOdneL8F_ZHBAzyb+VoJ+Z1FZp0VW8asGTu=g39TrouqAgA@mail.gmail.com>
Subject: Re: [PATCH] arm64: alternative: fix build with clang integrated assembler
To:     Ilie Halip <ilie.halip@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 2:45 PM Ilie Halip <ilie.halip@gmail.com> wrote:
>
> Building an arm64 defconfig with clang's integrated assembler, this error
> occurs:
>     <instantiation>:2:2: error: unrecognized instruction mnemonic
>      _ASM_EXTABLE 9999b, 9f
>      ^
>     arch/arm64/mm/cache.S:50:1: note: while in macro instantiation
>     user_alt 9f, "dc cvau, x4", "dc civac, x4", 0
>     ^
>
> While GNU as seems fine with case-sensitive macro instantiations, clang
> doesn't, so use the actual macro name (_asm_extable) as in the rest of
> the file.
>
> Also checked that the generated assembly matches the GCC output.
>
> Fixes: 290622efc76e ("arm64: fix "dc cvau" cache operation on errata-affected core")
> Link: https://github.com/ClangBuiltLinux/linux/issues/924
> Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
> ---
>  arch/arm64/include/asm/alternative.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
> index 324e7d5ab37e..5e5dc05d63a0 100644
> --- a/arch/arm64/include/asm/alternative.h
> +++ b/arch/arm64/include/asm/alternative.h
> @@ -221,7 +221,7 @@ alternative_endif
>
>  .macro user_alt, label, oldinstr, newinstr, cond
>  9999:  alternative_insn "\oldinstr", "\newinstr", \cond
> -       _ASM_EXTABLE 9999b, \label
> +       _asm_extable 9999b, \label
>  .endm

Testing a -next defconfig build, if I apply this, apply fixes for
https://github.com/ClangBuiltLinux/linux/issues/913, then disable
CONFIG_KVM, I can assemble (with Clang's integrated assembler) and
boot an aarch64 kernel.  I think that's a first for Clang.  Wow.

For CONFIG_KVM, I see:
arch/arm64/kvm/hyp/entry.S:112:87: error: too many positional arguments
 alternative_insn nop, .inst (0xd500401f | ((0) << 16 | (4) << 5) |
((!!1) << 8)), 4, 1

               ^
which also uses `alternative_insn`, but not `user_alt`, so another bug
for us to look into, filed:
https://github.com/ClangBuiltLinux/linux/issues/939

Looks like `_asm_extable` itself is a macro, defined in
arch/arm64/include/asm/assembler.h on line 125.  It's probably easy to
fix this in clang, but from a consistency with the rest of the file
(arch/arm64/include/asm/alternative.h) this patch should be accepted.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Should be easy to fix in Clang, too. Filed:
https://bugs.llvm.org/show_bug.cgi?id=45257
Thanks for the patch!

-- 
Thanks,
~Nick Desaulniers
