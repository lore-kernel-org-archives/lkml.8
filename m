Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB86CC4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A300C2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K+DhuU8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgCWUiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:38:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37278 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgCWUiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:38:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id h72so5886551pfe.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 13:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R6pN4SWBJOjZo3UJffcVW9yRBd1JF8EC9ixzWT1pjmw=;
        b=K+DhuU8dlXMKgXJ92kIMOfFFEgaC4sW5aC0ZZwKW68C8DRqrkdB9t53ZSsfe3+fsCK
         khBT8jBv7JTVyjlKAEAHfkrNFpQVkNpyhH1yNklR986TFvQsvnsYXAI8xCIG/29PRxPA
         VJBH3pEifoXdFThCt+1BkEwCzZ0V8Ci8Dmmb52w2WYyuibzN22dEKjdHnXcR67zsSCjz
         1+iVTKSBmqb0wjTlRPpRzrEmA91FYXV6Lw677msLzlQjKHICJtZMr3PZYSfs5pgeWUd5
         9uTYINdyP1UNvvg8oC4Y7CG+FWYk3BROlj4EgchyLBYc1cJu6CLp3cRTQ/Ub4P7KlSXT
         NsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R6pN4SWBJOjZo3UJffcVW9yRBd1JF8EC9ixzWT1pjmw=;
        b=TK7wyHwE2iHvzUAP1EZd3OamrFBMJdb/98BjFny7q35Vn507N4HaSMbbVBznwNUkgj
         +aZc5+kgHldilWchCa33uz34xmIDi1vpbWyUVpp5d7fhiYOaYWrXBWAREYkzjd87kNhP
         H1Tv2/iZQG6uOIkONzlBHynIfMnYVw6g9qnWJl22h7iq54VZPVcpOUtRFK/JcME6eKxp
         /k1EUO3CpNa6Vf0VMlielIvmTQXSh04nLbZYUEaSrZH9h/dg2GF0GnrZKS0ftPu15TzE
         BJufaFnCGZS78sTWgcLtf5lFFlTNSlaWkTCFNtyv473JxU0SNo3Ut23fTbjIVBl28soA
         VfAQ==
X-Gm-Message-State: ANhLgQ2aUL8w7lqlCUTTYwFqaNejbtsiVAUP5g25Qei65M9iUuaVPkzu
        X2zCOTRhbJ3ENF11k/do4KpfXI/jQXqXMETwBcPX4w==
X-Google-Smtp-Source: ADFU+vtvMAzQAcr3Luisi+G3tvS/IXNndOqhddfXMTaSa62ObJ60HWc59xHqhvrrsZzUm71CCwAc9E/aB687q7b5tyc=
X-Received: by 2002:a63:a34d:: with SMTP id v13mr2687909pgn.10.1584995890392;
 Mon, 23 Mar 2020 13:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200323020844.17064-1-masahiroy@kernel.org> <20200323020844.17064-3-masahiroy@kernel.org>
In-Reply-To: <20200323020844.17064-3-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 23 Mar 2020 13:37:57 -0700
Message-ID: <CAKwvOd=at2WhPCmgChSTPm1Du6nD09N=JSUmKU2r86+nVYRrLA@mail.gmail.com>
Subject: Re: [PATCH 2/7] x86: remove always-defined CONFIG_AS_CFI
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
> CONFIG_AS_CFI was introduced by commit e2414910f212 ("[PATCH] x86:
> Detect CFI support in the assembler at runtime"), and extended by
> commit f0f12d85af85 ("x86_64: Check for .cfi_rel_offset in CFI probe").
>
> We raise the minimal supported binutils version from time to time.
> The last bump was commit 1fb12b35e5ff ("kbuild: Raise the minimum
> required binutils version to 2.21").

Yep, looks like 2.21 was released in 2010, while CFI_rel_offset was
added to binutils back in 2003.  LGTM, thanks for the patch (2 less
assembler invocations during a build).
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> I confirmed the code in $(call as-instr,...) can be assembled by the
> binutils 2.21 assembler and also by LLVM integrated assembler.
>
> Remove CONFIG_AS_CFI, which is always defined.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> If this series is OK, we can do follwup cleanups.
> We can hard-code the assembler code, and delete CFI_* macros entirely.
>
>
>  arch/x86/Makefile             | 10 ++--------
>  arch/x86/include/asm/dwarf2.h | 36 -----------------------------------
>  2 files changed, 2 insertions(+), 44 deletions(-)
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 513a55562d75..72f8f744ebd7 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -177,12 +177,6 @@ ifeq ($(ACCUMULATE_OUTGOING_ARGS), 1)
>         KBUILD_CFLAGS += $(call cc-option,-maccumulate-outgoing-args,)
>  endif
>
> -# Stackpointer is addressed different for 32 bit and 64 bit x86
> -sp-$(CONFIG_X86_32) := esp
> -sp-$(CONFIG_X86_64) := rsp
> -
> -# do binutils support CFI?
> -cfi := $(call as-instr,.cfi_startproc\n.cfi_rel_offset $(sp-y)$(comma)0\n.cfi_endproc,-DCONFIG_AS_CFI=1)
>  # is .cfi_signal_frame supported too?
>  cfi-sigframe := $(call as-instr,.cfi_startproc\n.cfi_signal_frame\n.cfi_endproc,-DCONFIG_AS_CFI_SIGNAL_FRAME=1)
>  cfi-sections := $(call as-instr,.cfi_sections .debug_frame,-DCONFIG_AS_CFI_SECTIONS=1)
> @@ -196,8 +190,8 @@ sha1_ni_instr :=$(call as-instr,sha1msg1 %xmm0$(comma)%xmm1,-DCONFIG_AS_SHA1_NI=
>  sha256_ni_instr :=$(call as-instr,sha256msg1 %xmm0$(comma)%xmm1,-DCONFIG_AS_SHA256_NI=1)
>  adx_instr := $(call as-instr,adox %r10$(comma)%r10,-DCONFIG_AS_ADX=1)
>
> -KBUILD_AFLAGS += $(cfi) $(cfi-sigframe) $(cfi-sections) $(asinstr) $(avx_instr) $(avx2_instr) $(avx512_instr) $(sha1_ni_instr) $(sha256_ni_instr) $(adx_instr)
> -KBUILD_CFLAGS += $(cfi) $(cfi-sigframe) $(cfi-sections) $(asinstr) $(avx_instr) $(avx2_instr) $(avx512_instr) $(sha1_ni_instr) $(sha256_ni_instr) $(adx_instr)
> +KBUILD_AFLAGS += $(cfi-sigframe) $(cfi-sections) $(asinstr) $(avx_instr) $(avx2_instr) $(avx512_instr) $(sha1_ni_instr) $(sha256_ni_instr) $(adx_instr)
> +KBUILD_CFLAGS += $(cfi-sigframe) $(cfi-sections) $(asinstr) $(avx_instr) $(avx2_instr) $(avx512_instr) $(sha1_ni_instr) $(sha256_ni_instr) $(adx_instr)
>
>  KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
>
> diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h
> index 5a0502212bc5..90807583cad7 100644
> --- a/arch/x86/include/asm/dwarf2.h
> +++ b/arch/x86/include/asm/dwarf2.h
> @@ -6,15 +6,6 @@
>  #warning "asm/dwarf2.h should be only included in pure assembly files"
>  #endif
>
> -/*
> - * Macros for dwarf2 CFI unwind table entries.
> - * See "as.info" for details on these pseudo ops. Unfortunately
> - * they are only supported in very new binutils, so define them
> - * away for older version.
> - */
> -
> -#ifdef CONFIG_AS_CFI
> -
>  #define CFI_STARTPROC          .cfi_startproc
>  #define CFI_ENDPROC            .cfi_endproc
>  #define CFI_DEF_CFA            .cfi_def_cfa
> @@ -55,31 +46,4 @@
>  #endif
>  #endif
>
> -#else
> -
> -/*
> - * Due to the structure of pre-exisiting code, don't use assembler line
> - * comment character # to ignore the arguments. Instead, use a dummy macro.
> - */
> -.macro cfi_ignore a=0, b=0, c=0, d=0
> -.endm
> -
> -#define CFI_STARTPROC          cfi_ignore
> -#define CFI_ENDPROC            cfi_ignore
> -#define CFI_DEF_CFA            cfi_ignore
> -#define CFI_DEF_CFA_REGISTER   cfi_ignore
> -#define CFI_DEF_CFA_OFFSET     cfi_ignore
> -#define CFI_ADJUST_CFA_OFFSET  cfi_ignore
> -#define CFI_OFFSET             cfi_ignore
> -#define CFI_REL_OFFSET         cfi_ignore
> -#define CFI_REGISTER           cfi_ignore
> -#define CFI_RESTORE            cfi_ignore
> -#define CFI_REMEMBER_STATE     cfi_ignore
> -#define CFI_RESTORE_STATE      cfi_ignore
> -#define CFI_UNDEFINED          cfi_ignore
> -#define CFI_ESCAPE             cfi_ignore
> -#define CFI_SIGNAL_FRAME       cfi_ignore
> -
> -#endif
> -
>  #endif /* _ASM_X86_DWARF2_H */
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200323020844.17064-3-masahiroy%40kernel.org.



-- 
Thanks,
~Nick Desaulniers
