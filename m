Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC4DC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 02:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DBDE20707
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 02:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JfSoCblq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgIBC7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 22:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBC7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 22:59:00 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D72C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 19:59:00 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y6so1580895plk.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 19:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=28qFhVucmi3MOA4EjVAZJj+la1Jhv4eS2/cK3Z3HiOY=;
        b=JfSoCblql0i+xp0AEKJ6Ado4VRkzPHhvozvtPDE6oea9heTe/Qv13NjtA7soBD1I2q
         5ClV6H3baFAV4TFVXNPIjM0dIQJqZCwx6HelgagOzJHkan4Nh82stOScL2Rmd0qA1tLC
         +8kgcNxRDIa0HytZ5vaeKN90PeVbhnkPa/0hQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=28qFhVucmi3MOA4EjVAZJj+la1Jhv4eS2/cK3Z3HiOY=;
        b=FHhINukZrQ6GnYL6kdx7ofqwr6EvGJ32frJz4HB0PalHwgSJTuFC4dSAxnejlmeK6c
         CU0xg/A5PrZX8m7MYLsJrlIvvY4DXLN7sWWF198yR7nTnXjyn16TFqcwwsK7BNHnZa7b
         WcXzdS5hTVEdliR4/Ok2awbxn8v+bFoGQ4N6j7Dn/JVTUnqiMu1noGT1OOStcxp5b9zm
         hHz4RsoEvLmc/a/wtwMWT1RYES8mja5Ifdaodsl/C7VrTQwhhDTuliNlV9rH2KgVMJj8
         b+GXMGk2jozJYxEtwjJAIleQKVfu12WwiD4LtLLgjC8hTxFBePkNOhV2eTCX2EhJml4d
         kosA==
X-Gm-Message-State: AOAM533etuKJFL1Wgi52X+JXfKNCnNbIhMHJKFinr9mjmoaTXkM7FPVt
        7cRVrFeibWBy86K7CyK1DSFmED7Fa79GIg==
X-Google-Smtp-Source: ABdhPJwHg3XhyABkHwBxZuW2xitf7WsgMQ/KpoHJFIq8bDR8n2hKuyuuKABcGtomYH3njASks0dzqA==
X-Received: by 2002:a17:90a:ea97:: with SMTP id h23mr295435pjz.48.1599015539699;
        Tue, 01 Sep 2020 19:58:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e123sm2864217pfh.167.2020.09.01.19.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 19:58:58 -0700 (PDT)
Date:   Tue, 1 Sep 2020 19:58:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Fangrui Song <maskray@google.com>
Subject: Re: [PATCH 2/2] powerpc/vdso32: link vdso64 with linker
Message-ID: <202009011957.83E306094@keescook>
References: <20200901222523.1941988-1-ndesaulniers@google.com>
 <20200901222523.1941988-3-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901222523.1941988-3-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think $subject needs a typo update... vdso32...

On Tue, Sep 01, 2020 at 03:25:23PM -0700, Nick Desaulniers wrote:
> Rather than invoke the compiler as the driver, use the linker. That way
> we can check --orphan-handling=warn support correctly, as cc-ldoption
> was removed in
> commit 055efab3120b ("kbuild: drop support for cc-ldoption").
> 
> Requires dropping the .got section.  I couldn't find how it was used in
> the vdso32.
> 
> Fixes: commit f2af201002a8 ("powerpc/build: vdso linker warning for orphan sections")
> Link: https://lore.kernel.org/lkml/CAKwvOdnn3wxYdJomvnveyD_njwRku3fABWT_bS92duihhywLJQ@mail.gmail.com/
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Not sure removing .got is a good idea or not.  Otherwise I observe the
> following link error:
> powerpc-linux-gnu-ld: warning: orphan section `.got' from `arch/powerpc/kernel/vdso32/sigtramp.o' being placed in section `.got'
> powerpc-linux-gnu-ld: _GLOBAL_OFFSET_TABLE_ not defined in linker created .got
> powerpc-linux-gnu-ld: final link failed: bad value

If it's like the x86 and arm toolchains, I think you'll be required to
keep .got, but you can assert it to a 0 size, e.g.:

	/*
	 * Sections that should stay zero sized, which is safer to
	 * explicitly check instead of blindly discarding.
	 */
	.got : {
		*(.got)
	}
	ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")

(and put that at the end of the linker script)


-Kees

> 
> sigtramp.c doesn't mention anything from the GOT AFAICT, and doesn't
> look like it contains relocations that do, so I'm not sure where
> references to _GLOBAL_OFFSET_TABLE_ are coming from.
> 
>  arch/powerpc/kernel/vdso32/Makefile     | 7 +++++--
>  arch/powerpc/kernel/vdso32/vdso32.lds.S | 3 ++-
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/vdso32/Makefile b/arch/powerpc/kernel/vdso32/Makefile
> index 87ab1152d5ce..611a5951945a 100644
> --- a/arch/powerpc/kernel/vdso32/Makefile
> +++ b/arch/powerpc/kernel/vdso32/Makefile
> @@ -27,6 +27,9 @@ UBSAN_SANITIZE := n
>  ccflags-y := -shared -fno-common -fno-builtin -nostdlib \
>  	-Wl,-soname=linux-vdso32.so.1 -Wl,--hash-style=both
>  asflags-y := -D__VDSO32__ -s
> +ldflags-y := -shared -soname linux-vdso32.so.1 \
> +	$(call ld-option, --eh-frame-hdr) \
> +	$(call ld-option, --orphan-handling=warn) -T
>  
>  obj-y += vdso32_wrapper.o
>  extra-y += vdso32.lds
> @@ -49,8 +52,8 @@ $(obj-vdso32): %.o: %.S FORCE
>  	$(call if_changed_dep,vdso32as)
>  
>  # actual build commands
> -quiet_cmd_vdso32ld = VDSO32L $@
> -      cmd_vdso32ld = $(VDSOCC) $(c_flags) $(CC32FLAGS) -o $@ $(call cc-ldoption, -Wl$(comma)--orphan-handling=warn) -Wl,-T$(filter %.lds,$^) $(filter %.o,$^)
> +quiet_cmd_vdso32ld = LD      $@
> +      cmd_vdso32ld = $(cmd_ld)
>  quiet_cmd_vdso32as = VDSO32A $@
>        cmd_vdso32as = $(VDSOCC) $(a_flags) $(CC32FLAGS) -c -o $@ $<
>  
> diff --git a/arch/powerpc/kernel/vdso32/vdso32.lds.S b/arch/powerpc/kernel/vdso32/vdso32.lds.S
> index 4c985467a668..0ccdebad18b8 100644
> --- a/arch/powerpc/kernel/vdso32/vdso32.lds.S
> +++ b/arch/powerpc/kernel/vdso32/vdso32.lds.S
> @@ -61,7 +61,6 @@ SECTIONS
>  	.fixup		: { *(.fixup) }
>  
>  	.dynamic	: { *(.dynamic) }		:text	:dynamic
> -	.got		: { *(.got) }			:text
>  	.plt		: { *(.plt) }
>  
>  	_end = .;
> @@ -108,7 +107,9 @@ SECTIONS
>  	.debug_varnames  0 : { *(.debug_varnames) }
>  
>  	/DISCARD/	: {
> +		*(.got)
>  		*(.note.GNU-stack)
> +		*(.branch_lt)
>  		*(.data .data.* .gnu.linkonce.d.* .sdata*)
>  		*(.bss .sbss .dynbss .dynsbss)
>  		*(.glink .iplt .plt .rela*)
> -- 
> 2.28.0.402.g5ffc5be6b7-goog
> 

-- 
Kees Cook
