Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C3FC4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609FB2073C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TigBIbf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgCWUpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:45:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42618 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgCWUpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:45:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id 22so4505430pfa.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 13:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GfjxddVFwXVhr+lvz5y2NmQxJSLFPqj/SiFXB2tHtT0=;
        b=TigBIbf7q1EqJVTJBD7SAafvjDrgp/bDbud6cX7jAXwbUu+AZTqPS5jSKwQ8ATLnK+
         T/WbrP/hl52AiFJj2ajKrcajplRuWdcfFF3td5lnrdw3AKoGpyjCglRChPkBF08Y2Auh
         gWqobqbw2V3WVXxSGJ4w7Jo49jENZfZq7b5nfRT2oK6nZhoM/XyKeQNnqkuf01yY4ICR
         yVKBvVa8o3DXP7DDQ9h2FmaUV9qQDNhUFV7utKdURX1Hb8Vm7U7loHpSKMZT+IvP5fBZ
         WpRQ1bUov5c8L1E/IM+gfr8Z1AtWVUrnPzDVFDvUtMTZ215900S+z/u4j+0k8HU6Pwsw
         DRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GfjxddVFwXVhr+lvz5y2NmQxJSLFPqj/SiFXB2tHtT0=;
        b=ehUOeBnBhZ1oXaQPPYYXbryo71/jx4sdlbQ8J7iLvQpYNvmyH9pel9JWobTl4sR0tN
         00LdLC/Juut6cLwNHF20ebJ13yHmQwi4NgPDbdF8XKpVqwerBj0EpkrE8kXrERwqCOlY
         D+xGU9CE9EH81SlmW/2V+I9Sz4jSF2reSDAo+hHNo1lViZ48GyfhO63dYGBhPUrItkgz
         JIPgz4FeLo1xveMUM7Ga0zl2MBIjiFfqLdRayhBwzxKLO0EkqpqoaNzMCBykJ2fF/zq8
         IZsMfqTAftE/HsykZhyxj6qrIvPZXC1Ki+wOAYtTXNZr/a+i4Iq99AoE4wrN7QrtNzmL
         uGWw==
X-Gm-Message-State: ANhLgQ21zCzCwuAG7kFHfFRAVayrzGBWC3/M3DDI2w8XIzt7OmoC6YMj
        dfCX1lfRT8PVq+E5QMa0v+3pbbe5dbWqS4dUO+2T0g==
X-Google-Smtp-Source: ADFU+vv+mOycefKtvOW6j2Erc9ggbazUYImeQMvTxTjFQCCzakXOhdg0mlnzKnoxiu/zXpDmhjPegd/nO4w68Rn8JOU=
X-Received: by 2002:a05:6a00:42:: with SMTP id i2mr25856528pfk.108.1584996329288;
 Mon, 23 Mar 2020 13:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200323020844.17064-1-masahiroy@kernel.org> <20200323020844.17064-4-masahiroy@kernel.org>
In-Reply-To: <20200323020844.17064-4-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 23 Mar 2020 13:45:17 -0700
Message-ID: <CAKwvOd=V=HF3RBP5bMwgnAZsPg7nVewZiMQ7F3bh=D6_5ejBaQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] x86: remove always-defined CONFIG_AS_CFI_SIGNAL_FRAME
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Ingo Molnar <mingo@redhat.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 22, 2020 at 7:09 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> CONFIG_AS_CFI_SIGNAL_FRAME was introduced by commit adf1423698f0
> ("[PATCH] i386/x86-64: Work around gcc bug with noreturn functions
> in unwinder").
>
> We raise the minimal supported binutils version from time to time.
> The last bump was commit 1fb12b35e5ff ("kbuild: Raise the minimum
> required binutils version to 2.21").
>
> I confirmed the code in $(call as-instr,...) can be assembled by the
> binutils 2.21 assembler and also by LLVM integrated assembler.
>
> Remove CONFIG_AS_CFI_SIGNAL_FRAME, which is always defined.

grepping for CONFIG_AS_CFI_SIGNAL_FRAME, I see another use in
arch/arc/kernel/unwind.c.  This change will cause inclusion of
additional code there, whereas for binutils produced within the past
ten years, there was not.

>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/x86/Makefile             | 6 ++----
>  arch/x86/include/asm/dwarf2.h | 5 -----
>  2 files changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 72f8f744ebd7..dd275008fc59 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -177,8 +177,6 @@ ifeq ($(ACCUMULATE_OUTGOING_ARGS), 1)
>         KBUILD_CFLAGS += $(call cc-option,-maccumulate-outgoing-args,)
>  endif
>
> -# is .cfi_signal_frame supported too?
> -cfi-sigframe := $(call as-instr,.cfi_startproc\n.cfi_signal_frame\n.cfi_endproc,-DCONFIG_AS_CFI_SIGNAL_FRAME=1)
>  cfi-sections := $(call as-instr,.cfi_sections .debug_frame,-DCONFIG_AS_CFI_SECTIONS=1)
>
>  # does binutils support specific instructions?
> @@ -190,8 +188,8 @@ sha1_ni_instr :=$(call as-instr,sha1msg1 %xmm0$(comma)%xmm1,-DCONFIG_AS_SHA1_NI=
>  sha256_ni_instr :=$(call as-instr,sha256msg1 %xmm0$(comma)%xmm1,-DCONFIG_AS_SHA256_NI=1)
>  adx_instr := $(call as-instr,adox %r10$(comma)%r10,-DCONFIG_AS_ADX=1)
>
> -KBUILD_AFLAGS += $(cfi-sigframe) $(cfi-sections) $(asinstr) $(avx_instr) $(avx2_instr) $(avx512_instr) $(sha1_ni_instr) $(sha256_ni_instr) $(adx_instr)
> -KBUILD_CFLAGS += $(cfi-sigframe) $(cfi-sections) $(asinstr) $(avx_instr) $(avx2_instr) $(avx512_instr) $(sha1_ni_instr) $(sha256_ni_instr) $(adx_instr)
> +KBUILD_AFLAGS += $(cfi-sections) $(asinstr) $(avx_instr) $(avx2_instr) $(avx512_instr) $(sha1_ni_instr) $(sha256_ni_instr) $(adx_instr)
> +KBUILD_CFLAGS += $(cfi-sections) $(asinstr) $(avx_instr) $(avx2_instr) $(avx512_instr) $(sha1_ni_instr) $(sha256_ni_instr) $(adx_instr)
>
>  KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
>
> diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h
> index 90807583cad7..d6697aab5706 100644
> --- a/arch/x86/include/asm/dwarf2.h
> +++ b/arch/x86/include/asm/dwarf2.h
> @@ -20,12 +20,7 @@
>  #define CFI_RESTORE_STATE      .cfi_restore_state
>  #define CFI_UNDEFINED          .cfi_undefined
>  #define CFI_ESCAPE             .cfi_escape
> -
> -#ifdef CONFIG_AS_CFI_SIGNAL_FRAME
>  #define CFI_SIGNAL_FRAME       .cfi_signal_frame

Has no uses in the kernel.

> -#else
> -#define CFI_SIGNAL_FRAME
> -#endif
>
>  #if defined(CONFIG_AS_CFI_SECTIONS)
>  #ifndef BUILD_VDSO
> --
> 2.17.1
>
> --

-- 
Thanks,
~Nick Desaulniers
