Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B4DC35DF2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 04:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B96E22527
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 04:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LVqXzB6A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgBYEKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 23:10:16 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46006 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbgBYEKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 23:10:16 -0500
Received: by mail-pg1-f194.google.com with SMTP id r77so2828846pgr.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 20:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vusshdc55krHefiBaqz9JgK7J4GXTO3PHrFYufBJIy8=;
        b=LVqXzB6A+JGJPJqEKhZBJWn4eYCob5Nq9+y4QHTqsa3h7PUNHjF/T47O5j1eadLhss
         OAWHrHsfUIRgdGSum6yPmaAHSuaoLnREsztkvFNZovYtniDt/ENe/GoUSeRSJ8ZippC+
         H2a+Hr+tQgMuKTHTIay62rAK0p5X3/cCjQqZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vusshdc55krHefiBaqz9JgK7J4GXTO3PHrFYufBJIy8=;
        b=k9gOwzhvRzBTP3CHCVVllEX2Lvo1ak63gy0jwzMyLH5aqvpWrxpzh/Rz4Svk92+ZFu
         LtQkOHXYrkTpLRS3zxmamKewH9uxPoywhp8J/wRqdjaRP/yiJ/ZOp2F5J6IfXTGPCwog
         Nta7utte9vEwQO3X2Ar2VEBjjzynmfikQRfai/R+eJ134gVXTTxmhgDzRZI+0ENxvhkt
         UKxvGHwiJJlO70hpgiUs3YO1I3n3vThgJc9fT2Ku4RDVRyWrHjVU45LCBniUcmoi/XAO
         2r3cpHxQ2oDXb8MM9VKPjHyWE03w8FVvYkHVZ4cCBE1OokvAYWHNlZX8RuKsX9tzrwIa
         2sxQ==
X-Gm-Message-State: APjAAAWQ+1/PIGylPe2Vg5EiKluH2W1tOby3tJLx3+t3it6wGc8o8y7C
        ncBV3KlYQabj/Vxzb4VYxdwhyQ==
X-Google-Smtp-Source: APXvYqxNGrbGo9L64Qk6lCwyRxDkHThodXQ842cNxQGHqao4AFc0UXuG1doiFDs4qn9IIeFbCD1ZDQ==
X-Received: by 2002:aa7:8804:: with SMTP id c4mr56003796pfo.214.1582603814922;
        Mon, 24 Feb 2020 20:10:14 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z30sm14679470pff.131.2020.02.24.20.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 20:10:14 -0800 (PST)
Date:   Mon, 24 Feb 2020 20:10:12 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michael Matz <matz@suse.de>, Fangrui Song <maskray@google.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 1/2] arch/x86: Use -fno-asynchronous-unwind-tables to
 suppress .eh_frame sections
Message-ID: <202002242009.43E8DFD58@keescook>
References: <CAKwvOdn6cxm9EpB7A9kLasttPwLY2csnhqgNAdkJ6_s2DP1-HA@mail.gmail.com>
 <20200224232129.597160-2-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224232129.597160-2-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 06:21:28PM -0500, Arvind Sankar wrote:
> While discussing a patch to discard .eh_frame from the compressed
> vmlinux using the linker script, Fangrui Song pointed out [1] that these
> sections shouldn't exist in the first place because arch/x86/Makefile
> uses -fno-asynchronous-unwind-tables.
> 
> It turns out this is because the Makefiles used to build the compressed
> kernel redefine KBUILD_CFLAGS, dropping this flag.
> 
> Add the flag to the Makefile for the compressed kernel, as well as the
> EFI stub Makefile to fix this.
> 
> Also add the flag to boot/Makefile and realmode/rm/Makefile so that the
> kernel's boot code (boot/setup.elf) and realmode trampoline
> (realmode/rm/realmode.elf) won't be compiled with .eh_frame sections,
> since their linker scripts also just discard it.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Thanks for sorting this out. I think it's much cleaner than adding it to
DISCARD. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Suggested-By: Fangrui Song <maskray@google.com>
> [1] https://lore.kernel.org/lkml/20200222185806.ywnqhfqmy67akfsa@google.com/
> ---
>  arch/x86/boot/Makefile                | 1 +
>  arch/x86/boot/compressed/Makefile     | 1 +
>  arch/x86/realmode/rm/Makefile         | 1 +
>  drivers/firmware/efi/libstub/Makefile | 3 ++-
>  4 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
> index 012b82fc8617..24f011e0adf1 100644
> --- a/arch/x86/boot/Makefile
> +++ b/arch/x86/boot/Makefile
> @@ -68,6 +68,7 @@ clean-files += cpustr.h
>  KBUILD_CFLAGS	:= $(REALMODE_CFLAGS) -D_SETUP
>  KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
>  KBUILD_CFLAGS	+= $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
> +KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
>  GCOV_PROFILE := n
>  UBSAN_SANITIZE := n
>  
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 26050ae0b27e..c33111341325 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -39,6 +39,7 @@ KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
>  KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
>  KBUILD_CFLAGS += -Wno-pointer-sign
>  KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
> +KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
>  
>  KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
>  GCOV_PROFILE := n
> diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
> index 99b6332ba540..b11ec5d8f8ac 100644
> --- a/arch/x86/realmode/rm/Makefile
> +++ b/arch/x86/realmode/rm/Makefile
> @@ -71,5 +71,6 @@ $(obj)/realmode.relocs: $(obj)/realmode.elf FORCE
>  KBUILD_CFLAGS	:= $(REALMODE_CFLAGS) -D_SETUP -D_WAKEUP \
>  		   -I$(srctree)/arch/x86/boot
>  KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
> +KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
>  GCOV_PROFILE := n
>  UBSAN_SANITIZE := n
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 98a81576213d..a1140c4ee478 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -12,7 +12,8 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ -O2 \
>  				   -mno-mmx -mno-sse -fshort-wchar \
>  				   -Wno-pointer-sign \
>  				   $(call cc-disable-warning, address-of-packed-member) \
> -				   $(call cc-disable-warning, gnu)
> +				   $(call cc-disable-warning, gnu) \
> +				   -fno-asynchronous-unwind-tables
>  
>  # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
>  # disable the stackleak plugin
> -- 
> 2.24.1
> 

-- 
Kees Cook
