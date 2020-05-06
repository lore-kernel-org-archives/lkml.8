Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B974EC47259
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9773E20936
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AoWlyDRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbgEFRRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 13:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729900AbgEFRRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 13:17:18 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CA7C061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 10:17:18 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f15so771962plr.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 10:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/k/x3jvD4hIY8pDNsyuRYJAWCjnjlkQj95o1100b+nU=;
        b=AoWlyDRvgvgfz7OXgRvmqbZq6U8eVGyvK/25YzVKraEel8OmtkOdz2BW5cyKKN+B9T
         lEgbKudq8lqfvZcc0Bi648R42oxIhUjrYoffQ8Pl1H0dbp92fpYcf/ynrRCKVnTxHnc2
         jkJnZkh325ckYdhrmmHLfDG16i0rJSiyd+Zv3Qt4C+5MhFk8kmN7vsaFKHVJhFnVi28I
         BUftmHbmElrqRsxk91bDZkkdM2b6RMZpk2ctFThP4FhABx3J6RNF4W7EfO8FzFbMsf7v
         CCXjr9xbkvksrdNlppx8YSdgFiilZJpQOX2Atv6Tgjvh+0RwwMnHTy8wof2Roe99T5MU
         Cf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/k/x3jvD4hIY8pDNsyuRYJAWCjnjlkQj95o1100b+nU=;
        b=LKoa0aHAj2W6PfDmkhhcIHmakKNhaxGjMxJyl9bx5N7idi8z+KgXb98skhKWV0NEOm
         /sMt6hR/biLKDorI9GlgxLFS0KYEDFdSN7qKFe2Fg1//R283ZNlnrOaJKNhK3uakUyd2
         DuccwxOA8gmCrDIRnUd59v0TbLtAhDZOQJ71HsRiayljaszruRTNwWjLOTanllAFlJEf
         i/TkRM6vyuX3bjM2PmVRqblxYwXPXgO3UVbBaJyHY4u9AiZn/08elntFntV/6RBTS5fm
         Z+qBKHraIFi+5q4vcXJGa19h5sx5BA0voYg1aN/L9+JQM9iREEHYnitw3VvmEwT/CXiT
         9xxg==
X-Gm-Message-State: AGi0PuY5cpur0PpwymywS+ADSBXhRggS/wsxOZY/2pPjnPR8/XxU4u38
        CiqChZ58QG/lG15XBTz5Ddxbnjdocf8xcHjTOLHYbQ==
X-Google-Smtp-Source: APiQypLnpQ9fey9MWfkvN5jK3cTisnhcJeTBQn37c1umPrLJpul/zCxeo6IzqY/pYCZUn/CL8vsxMaNBNscsUYb0zG8=
X-Received: by 2002:a17:902:ac87:: with SMTP id h7mr8736134plr.119.1588785437559;
 Wed, 06 May 2020 10:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200506055245.3013374-1-jiaxun.yang@flygoat.com>
In-Reply-To: <20200506055245.3013374-1-jiaxun.yang@flygoat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 6 May 2020 10:17:06 -0700
Message-ID: <CAKwvOdkmK7QdbZFKCCao9W8cJcOR_M-LyOkL3_Ms7amegv499w@mail.gmail.com>
Subject: Re:
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Maciej W . Rozycki" <macro@linux-mips.org>,
        Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jouni Hogander <jouni.hogander@unikie.com>,
        Kevin Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>,
        Borislav Petkov <bp@suse.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 10:52 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> Subject: [PATCH v6] MIPS: Truncate link address into 32bit for 32bit kernel
> In-Reply-To: <20200413062651.3992652-1-jiaxun.yang@flygoat.com>
>
> LLD failed to link vmlinux with 64bit load address for 32bit ELF
> while bfd will strip 64bit address into 32bit silently.
> To fix LLD build, we should truncate load address provided by platform
> into 32bit for 32bit kernel.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/786
> Link: https://sourceware.org/bugzilla/show_bug.cgi?id=25784
> Reviewed-by: Fangrui Song <maskray@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
> Cc: Maciej W. Rozycki <macro@linux-mips.org>

Cool, this revision looks a bit simpler. Thanks for chasing this.
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
> V2: Take MaskRay's shell magic.
>
> V3: After spent an hour on dealing with special character issue in
> Makefile, I gave up to do shell hacks and write a util in C instead.
> Thanks Maciej for pointing out Makefile variable problem.
>
> v4: Finally we managed to find a Makefile method to do it properly
> thanks to Kees. As it's too far from the initial version, I removed
> Review & Test tag from Nick and Fangrui and Cc instead.
>
> v5: Care vmlinuz as well.
>
> v6: Rename to LIKER_LOAD_ADDRESS
> ---
>  arch/mips/Makefile                 | 13 ++++++++++++-
>  arch/mips/boot/compressed/Makefile |  2 +-
>  arch/mips/kernel/vmlinux.lds.S     |  2 +-
>  3 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index e1c44aed8156..68c0f22fefc0 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -288,12 +288,23 @@ ifdef CONFIG_64BIT
>    endif
>  endif
>
> +# When linking a 32-bit executable the LLVM linker cannot cope with a
> +# 32-bit load address that has been sign-extended to 64 bits.  Simply
> +# remove the upper 32 bits then, as it is safe to do so with other
> +# linkers.
> +ifdef CONFIG_64BIT
> +       load-ld                 = $(load-y)
> +else
> +       load-ld                 = $(subst 0xffffffff,0x,$(load-y))
> +endif
> +
>  KBUILD_AFLAGS  += $(cflags-y)
>  KBUILD_CFLAGS  += $(cflags-y)
> -KBUILD_CPPFLAGS += -DVMLINUX_LOAD_ADDRESS=$(load-y)
> +KBUILD_CPPFLAGS += -DVMLINUX_LOAD_ADDRESS=$(load-y) -DLINKER_LOAD_ADDRESS=$(load-ld)
>  KBUILD_CPPFLAGS += -DDATAOFFSET=$(if $(dataoffset-y),$(dataoffset-y),0)
>
>  bootvars-y     = VMLINUX_LOAD_ADDRESS=$(load-y) \
> +                 LINKER_LOAD_ADDRESS=$(load-ld) \
>                   VMLINUX_ENTRY_ADDRESS=$(entry-y) \
>                   PLATFORM="$(platform-y)" \
>                   ITS_INPUTS="$(its-y)"
> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> index 0df0ee8a298d..3d391256ab7e 100644
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
> @@ -90,7 +90,7 @@ ifneq ($(zload-y),)
>  VMLINUZ_LOAD_ADDRESS := $(zload-y)
>  else
>  VMLINUZ_LOAD_ADDRESS = $(shell $(obj)/calc_vmlinuz_load_addr \
> -               $(obj)/vmlinux.bin $(VMLINUX_LOAD_ADDRESS))
> +               $(obj)/vmlinux.bin $(LINKER_LOAD_ADDRESS))
>  endif
>  UIMAGE_LOADADDR = $(VMLINUZ_LOAD_ADDRESS)
>
> diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
> index a5f00ec73ea6..5226cd8e4bee 100644
> --- a/arch/mips/kernel/vmlinux.lds.S
> +++ b/arch/mips/kernel/vmlinux.lds.S
> @@ -55,7 +55,7 @@ SECTIONS
>         /* . = 0xa800000000300000; */
>         . = 0xffffffff80300000;
>  #endif
> -       . = VMLINUX_LOAD_ADDRESS;
> +       . = LINKER_LOAD_ADDRESS;
>         /* read-only */
>         _text = .;      /* Text and read-only data */
>         .text : {
>
> --

-- 
Thanks,
~Nick Desaulniers
