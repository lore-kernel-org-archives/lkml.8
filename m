Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F436C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 12:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B96F0206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 12:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="DOiRv5WB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgIBMOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 08:14:38 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34789 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbgIBMOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 08:14:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BhNCS0clSz9sV7;
        Wed,  2 Sep 2020 22:14:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1599048853;
        bh=u4WWAXM88hVefxFyxLfz+DGbiZnudGHqADUN9wCOsFU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DOiRv5WBfhOoyHB+Y9LK9XXtcPB9y5yFTRG7u9ZOpuMnDA7AWyKODxqemDp89GGGj
         XEdHJoQDfsvbyzi+3WWbI9IC1Ljy5pclYq7m/2HFJxZawHGKVlm51XmvN52tdDl1jq
         x+eojCI4PkO1UwVgrH4xJO0Jr5C/KBxgycw2G+saZLxXjNOvGE1FVr283fy8iAATx4
         VBwGf2TpnHC/UguioMM6/CIjSHh7Tk5e0oUwjwf6XeRyh4DmTHDSkSxa2qiCefrsh2
         nyobTnnNu6Tposg0HzMWWUw50/pC3VfcLNbEUxakrx3srHhNIdrocQ5F5VDdoMYKAz
         ASLXceFnxXbnQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 1/2] powerpc/vdso64: link vdso64 with linker
In-Reply-To: <20200901222523.1941988-2-ndesaulniers@google.com>
References: <20200901222523.1941988-1-ndesaulniers@google.com> <20200901222523.1941988-2-ndesaulniers@google.com>
Date:   Wed, 02 Sep 2020 22:14:05 +1000
Message-ID: <87blio1ilu.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Desaulniers <ndesaulniers@google.com> writes:
> Rather than invoke the compiler as the driver, use the linker. That way
> we can check --orphan-handling=warn support correctly, as cc-ldoption
> was removed in
> commit 055efab3120b ("kbuild: drop support for cc-ldoption").

Ouch.

Seems make is quite happy to $(call deadbeef, ...) and not print a
warning, which I guess is probably a feature.

> Painstakingly compared the output between `objdump -a` before and after
> this change. Now function symbols have the correct type of FUNC rather
> than NONE, and the entry is slightly different (which doesn't matter for
> the vdso). Binary size is the same.
>
> Fixes: commit f2af201002a8 ("powerpc/build: vdso linker warning for orphan sections")

I think I'll just revert that for v5.9 ?

cheers

> Link: https://lore.kernel.org/lkml/CAKwvOdnn3wxYdJomvnveyD_njwRku3fABWT_bS92duihhywLJQ@mail.gmail.com/
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/powerpc/include/asm/vdso.h         | 17 ++---------------
>  arch/powerpc/kernel/vdso64/Makefile     |  8 ++++++--
>  arch/powerpc/kernel/vdso64/vdso64.lds.S |  1 -
>  3 files changed, 8 insertions(+), 18 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/vdso.h b/arch/powerpc/include/asm/vdso.h
> index 2ff884853f97..11b2ecf49f79 100644
> --- a/arch/powerpc/include/asm/vdso.h
> +++ b/arch/powerpc/include/asm/vdso.h
> @@ -24,19 +24,7 @@ int vdso_getcpu_init(void);
>  
>  #else /* __ASSEMBLY__ */
>  
> -#ifdef __VDSO64__
> -#define V_FUNCTION_BEGIN(name)		\
> -	.globl name;			\
> -	name:				\
> -
> -#define V_FUNCTION_END(name)		\
> -	.size name,.-name;
> -
> -#define V_LOCAL_FUNC(name) (name)
> -#endif /* __VDSO64__ */
> -
> -#ifdef __VDSO32__
> -
> +#if defined(__VDSO32__) || defined (__VDSO64__)
>  #define V_FUNCTION_BEGIN(name)		\
>  	.globl name;			\
>  	.type name,@function; 		\
> @@ -46,8 +34,7 @@ int vdso_getcpu_init(void);
>  	.size name,.-name;
>  
>  #define V_LOCAL_FUNC(name) (name)
> -
> -#endif /* __VDSO32__ */
> +#endif /* __VDSO{32|64}__ */
>  
>  #endif /* __ASSEMBLY__ */
>  
> diff --git a/arch/powerpc/kernel/vdso64/Makefile b/arch/powerpc/kernel/vdso64/Makefile
> index 38c317f25141..7ea3ce537d0a 100644
> --- a/arch/powerpc/kernel/vdso64/Makefile
> +++ b/arch/powerpc/kernel/vdso64/Makefile
> @@ -32,9 +32,13 @@ $(obj)/%.so: OBJCOPYFLAGS := -S
>  $(obj)/%.so: $(obj)/%.so.dbg FORCE
>  	$(call if_changed,objcopy)
>  
> +ldflags-y := -shared -soname linux-vdso64.so.1 \
> +	$(call ld-option, --eh-frame-hdr) \
> +	$(call ld-option, --orphan-handling=warn) -T
> +
>  # actual build commands
> -quiet_cmd_vdso64ld = VDSO64L $@
> -      cmd_vdso64ld = $(CC) $(c_flags) -o $@ -Wl,-T$(filter %.lds,$^) $(filter %.o,$^) $(call cc-ldoption, -Wl$(comma)--orphan-handling=warn)
> +quiet_cmd_vdso64ld = LD      $@
> +      cmd_vdso64ld = $(cmd_ld)
>  
>  # install commands for the unstripped file
>  quiet_cmd_vdso_install = INSTALL $@
> diff --git a/arch/powerpc/kernel/vdso64/vdso64.lds.S b/arch/powerpc/kernel/vdso64/vdso64.lds.S
> index 4e3a8d4ee614..58c33b704b6a 100644
> --- a/arch/powerpc/kernel/vdso64/vdso64.lds.S
> +++ b/arch/powerpc/kernel/vdso64/vdso64.lds.S
> @@ -11,7 +11,6 @@ OUTPUT_FORMAT("elf64-powerpcle", "elf64-powerpcle", "elf64-powerpcle")
>  OUTPUT_FORMAT("elf64-powerpc", "elf64-powerpc", "elf64-powerpc")
>  #endif
>  OUTPUT_ARCH(powerpc:common64)
> -ENTRY(_start)
>  
>  SECTIONS
>  {
> -- 
> 2.28.0.402.g5ffc5be6b7-goog
