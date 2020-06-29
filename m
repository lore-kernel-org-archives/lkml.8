Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1B5C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE8912053B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593457260;
	bh=TMhar6KWkABf9BbZst+X1TRNWA3K/2xbSXA8kziSStk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ix1T61cETDlb9TLeRmw7jZzkH1cEXuzSNT8QAHlid20H+X8ZGyzspvbGhI9T+X+uX
	 ZCd1Wev+HUOc5yHQdYIuY6l54gyNTHMIUitzdXjV1L+LCvyEo2Sm2xKtdr2+LloKkQ
	 IoX8IKcWdvkXzZrALOKGJ/UyfLGBkCo7Dq5rbjLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbgF2TAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:00:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730308AbgF2TAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:00:18 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C549B2558D
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 16:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593447131;
        bh=TMhar6KWkABf9BbZst+X1TRNWA3K/2xbSXA8kziSStk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FHH6K2+zvIYLEkwJ/H2meMRbIB/YsuSP18INQhDDJpi+vxbAKFUfPGzzrArtVzUM8
         h4vTE1pHmREz4bkom937EyeSfGum+iRd1HBhDgDK0mW3Gxy/YokNmHK2OkqEbmIJno
         bOMkmOiQ00bjCunyykj9KQRGs6SG4uyguoNhFve8=
Received: by mail-ot1-f42.google.com with SMTP id n5so16068934otj.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:12:11 -0700 (PDT)
X-Gm-Message-State: AOAM531asHQ86zk96REaO8gsOnkvsRUYf+t5JXzqdtiBlkHgvb4eKD2h
        Qdar5KXbkWm5mAwTQadJhjn+2jRrVSPnsvhqL14=
X-Google-Smtp-Source: ABdhPJxeOSwGqnwk9lJaXB9LTgpJEATgtFqmcE+2KzMMNSYkTEhWHhJIxKFyID5eTusIvRP0to2Udp6qWrncphNV47o=
X-Received: by 2002:a9d:5a12:: with SMTP id v18mr13489971oth.90.1593447131094;
 Mon, 29 Jun 2020 09:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200629140928.858507-8-nivedita@alum.mit.edu> <202006290907.E5EF18A@keescook>
In-Reply-To: <202006290907.E5EF18A@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 29 Jun 2020 18:11:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFge5aWL2BY8Y1=m1TonB+SrDq6p7TQWuO5JkzcR2dhjQ@mail.gmail.com>
Message-ID: <CAMj1kXFge5aWL2BY8Y1=m1TonB+SrDq6p7TQWuO5JkzcR2dhjQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] x86/boot: Check that there are no runtime relocations
To:     Kees Cook <keescook@chromium.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020 at 18:09, Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jun 29, 2020 at 10:09:28AM -0400, Arvind Sankar wrote:
> > Add a linker script check that there are no runtime relocations, and
> > remove the old one that tries to check via looking for specially-named
> > sections in the object files.
> >
> > Drop the tests for -fPIE compiler option and -pie linker option, as they
> > are available in all supported gcc and binutils versions (as well as
> > clang and lld).
> >
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> > Reviewed-by: Fangrui Song <maskray@google.com>
> > ---
> >  arch/x86/boot/compressed/Makefile      | 28 +++-----------------------
> >  arch/x86/boot/compressed/vmlinux.lds.S |  8 ++++++++
> >  2 files changed, 11 insertions(+), 25 deletions(-)
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> question below ...
>
> > diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> > index a4a4a59a2628..a78510046eec 100644
> > --- a/arch/x86/boot/compressed/vmlinux.lds.S
> > +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> > @@ -42,6 +42,12 @@ SECTIONS
> >               *(.rodata.*)
> >               _erodata = . ;
> >       }
> > +     .rel.dyn : {
> > +             *(.rel.*)
> > +     }
> > +     .rela.dyn : {
> > +             *(.rela.*)
> > +     }
> >       .got : {
> >               *(.got)
> >       }
>
> Should these be marked (INFO) as well?
>

Given that sections marked as (INFO) will still be emitted into the
ELF image, it does not really make a difference to do this for zero
sized sections.

> > @@ -85,3 +91,5 @@ ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT en
> >  #else
> >  ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0xc, "Unexpected GOT/PLT entries detected!")
> >  #endif
> > +
> > +ASSERT(SIZEOF(.rel.dyn) == 0 && SIZEOF(.rela.dyn) == 0, "Unexpected runtime relocations detected!")
>
> I think I should be doing this same ASSERT style for other explicit
> DISCARDS in my orphan series so we'll notice if they change, instead
> of being silently dropped if they grow.
>
