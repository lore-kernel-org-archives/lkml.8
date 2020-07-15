Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6DCC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29BB20672
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHzdxBJ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbgGOIwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730445AbgGOIwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:52:32 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63CAC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:52:32 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id e64so1388157iof.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=3Z4IpLUKocM3OEmb2Wb4pmzCIIom6GoJeorw5OSNFmA=;
        b=hHzdxBJ1OQGEfhC90QrC2rcV6mefC3VdSTniGM9hIQKPOR8JXTj7WKNBfXh153QO+z
         sFiPrRzfbR5yOnd870qHFxRdAdEYgeagfwrYPFcUmAFA+3yJg2yqc2O9iNUOGWqhZ/7W
         /+RTXMs+zfL+gFZvJLzBprAPHqA+v3Q8eFvUatZCmcRlNjRcjfy7vI6FNIn+nRL+ueS1
         FGA4P96247zfhiVYwY56WyXY5HoY9wvxCmqjOeslQ0oK8cmR4QPsVKVdc3Tq60C81odk
         AFuDLyzF/3vXymk+0OE7K/W//GsO2IRZ/m4z3pmbYQUVY67PaLiWpFhncFKvbwP6oySe
         yEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=3Z4IpLUKocM3OEmb2Wb4pmzCIIom6GoJeorw5OSNFmA=;
        b=O7jLNp8orujJgAY6Gv8Ww06s8UoXWmmx6ZkZpTDa27kC6VWefoavbXfOBZeUtlCUZR
         qIFTenCGaj0KnDVUQbmc/aLG6IM3jd2M2W0bpbiL6o7FIViNQHuESUZDX7D1pWRWl+hg
         oT/MWF+W0ZqyyUCkNtJrPnOVnA+eLptNf7QPL+jaXqvuwQ4cFUuvq0fDCcY6OMcFq396
         ibJd+iJT8yNlNUXDTU2DmHhUApJpy+3YmtDok4Jl+hZVNfp9fFdqfIm2ZZ56VYmD3O6d
         hkbipDjwfCI6nhGqbqqyXS2IivOYg7Gc4p7zwhXT2z2RBn6VZ6WSiv7S+koaHfXOjJIv
         2G9A==
X-Gm-Message-State: AOAM5304XgtC0eHoYcnyd+woMeZETT+LPXUEZuyKUesnzgs6ziI3Gd29
        KHS9djyfWttqV8Rwtmt3ETopBG495C7Ef7sUSbU=
X-Google-Smtp-Source: ABdhPJyp2Jkk8UtUIOJ+t1y4YAmr65LCFaVZo0jz/FKxkcsalM41AmdbHnW8iXebFlCIFGEZZO1+cf9JYfZpLRExKNU=
X-Received: by 2002:a02:ce9a:: with SMTP id y26mr10812220jaq.121.1594803152177;
 Wed, 15 Jul 2020 01:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200714023836.2310569-1-nivedita@alum.mit.edu> <20200715004133.1430068-2-nivedita@alum.mit.edu>
In-Reply-To: <20200715004133.1430068-2-nivedita@alum.mit.edu>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 15 Jul 2020 10:52:20 +0200
Message-ID: <CA+icZUW4YycmdKATQNW+3-rjLS8=jSVWCvQNx13TuZcYXt0YnQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] x86/boot/compressed: Move .got.plt entries out of
 the .got section
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 2:41 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> The .got.plt section contains the part of the GOT which is used by PLT
> entries, and which gets updated lazily by the dynamic loader when
> function calls are dispatched through those PLT entries.
>
> On fully linked binaries such as the kernel proper or the decompressor,
> this never happens, and so in practice, the .got.plt section consists
> only of the first 3 magic entries that are meant to point at the _DYNAMIC
> section and at the fixup routine in the loader. However, since we don't
> use a dynamic loader, those entries are never populated or used.
>
> This means that treating those entries like ordinary GOT entries, and
> updating their values based on the actual placement of the executable in
> memory is completely pointless, and we can just ignore the .got.plt
> section entirely, provided that it has no additional entries beyond
> the first 3 ones.
>
> So add an assertion in the linker script to ensure that this assumption
> holds, and move the contents out of the [_got, _egot) memory range that
> is modified by the GOT fixup routines.
>
> While at it, drop the KEEP(), since it has no effect on the contents
> of output sections that are created by the linker itself.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Acked-by: Arvind Sankar <nivedita@alum.mit.edu>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> From: Ard Biesheuvel <ardb@kernel.org>
> Link: https://lore.kernel.org/r/20200523120021.34996-2-ardb@kernel.org

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

- Sedat -

> ---
>  arch/x86/boot/compressed/vmlinux.lds.S | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index 8f1025d1f681..b17d218ccdf9 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -44,10 +44,13 @@ SECTIONS
>         }
>         .got : {
>                 _got = .;
> -               KEEP(*(.got.plt))
>                 KEEP(*(.got))
>                 _egot = .;
>         }
> +       .got.plt : {
> +               *(.got.plt)
> +       }
> +
>         .data : {
>                 _data = . ;
>                 *(.data)
> @@ -77,3 +80,9 @@ SECTIONS
>
>         DISCARDS
>  }
> +
> +#ifdef CONFIG_X86_64
> +ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT entries detected!")
> +#else
> +ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0xc, "Unexpected GOT/PLT entries detected!")
> +#endif
> --
> 2.26.2
>
