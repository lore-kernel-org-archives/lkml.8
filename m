Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD9DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A281520774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592923945;
	bh=N5tTtJIP0Rc3W1tOT9EjsbcmdU+QsA32BbRAKafvgJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iVwkRSikRktqbZbegeps5WsxxNPRtkuwD4JCFIGGBe8RxlQ/u+42tie5ZmZD9JE4D
	 W0/VS8IjZNNzOMmaC5CQ3YOUokVTiUmDOPLmHQwq5I+Ae5DReTqgj4e2+I3p5ZtxoQ
	 GgdQUboI48saxTFRZZOFck2V2wJYsMQwULJUApQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732859AbgFWOwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:52:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732801AbgFWOwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:52:24 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C590020723;
        Tue, 23 Jun 2020 14:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592923943;
        bh=N5tTtJIP0Rc3W1tOT9EjsbcmdU+QsA32BbRAKafvgJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z6N/8+dviHqm4Jkv5AoCSrmlP/51Oc0ovRXdYgAujUzo215r0oQeXQQE89ZEt113V
         NqyVKXNVdr43sbhu9Hv2FljKosgPfoDpLMTXOIYJJGa2E1tF8f/M+kT4pFuIogOj3a
         ZhzWKZiNwD4kndq6VUr4OSl1hZ2siGOruG1gpAls=
Date:   Tue, 23 Jun 2020 15:52:18 +0100
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64/build: Warn on orphan section placement
Message-ID: <20200623145218.GC4336@willie-the-truck>
References: <20200622205815.2988115-1-keescook@chromium.org>
 <20200622205815.2988115-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622205815.2988115-3-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 01:58:15PM -0700, Kees Cook wrote:
> We don't want to depend on the linker's orphan section placement
> heuristics as these can vary between linkers, and may change between
> versions. All sections need to be explicitly named in the linker
> script.
> 
> Explicitly include debug sections when they're present. Add .eh_frame*
> to discard as it seems that these are still generated even though
> -fno-asynchronous-unwind-tables is being specified. Add .plt and
> .data.rel.ro to discards as they are not actually used. Add .got.plt
> to the image as it does appear to be mapped near .data. Finally enable
> orphan section warnings.

Can you elaborate a bit on what .got.plt is being used for, please? I
wonder if there's an interaction with an erratum workaround in the linker
or something.

> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index a0d94d063fa8..3e628983445a 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -29,6 +29,10 @@ LDFLAGS_vmlinux	+= --fix-cortex-a53-843419
>    endif
>  endif
>  
> +# We never want expected sections to be placed heuristically by the
> +# linker. All sections should be explicitly named in the linker script.
> +LDFLAGS_vmlinux += --orphan-handling=warn
> +
>  ifeq ($(CONFIG_ARM64_USE_LSE_ATOMICS), y)
>    ifneq ($(CONFIG_ARM64_LSE_ATOMICS), y)
>  $(warning LSE atomics not supported by binutils)
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 5427f502c3a6..c9ecb3b2007d 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -94,7 +94,8 @@ SECTIONS
>  	/DISCARD/ : {
>  		*(.interp .dynamic)
>  		*(.dynsym .dynstr .hash .gnu.hash)
> -		*(.eh_frame)
> +		*(.plt) *(.data.rel.ro)
> +		*(.eh_frame) *(.init.eh_frame)

Do we need to include .eh_frame_hdr here too?

>  	}
>  
>  	. = KIMAGE_VADDR + TEXT_OFFSET;
> @@ -209,6 +210,7 @@ SECTIONS
>  	_data = .;
>  	_sdata = .;
>  	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_ALIGN)
> +	.got.plt : ALIGN(8) { *(.got.plt) }
>  
>  	/*
>  	 * Data written with the MMU off but read with the MMU on requires
> @@ -244,6 +246,7 @@ SECTIONS
>  	_end = .;
>  
>  	STABS_DEBUG
> +	DWARF_DEBUG

I know you didn't add it, but do we _really_ care about stabs debug? Who
generates that for arm64?

Will
