Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CE0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81497208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593465877;
	bh=ReZPNCCJ/K8FhCzM6IWgUGCUkf/Lpb/MqZLHZJkjp6Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fgFmVqVLJ10MK2bbJLgZmICspG2+hAvXjvftiynx1HoFjlex2MhjibGusO22Lmmyv
	 CUYVBimCDwA5xET9hsANue2q1eCH7chru9rPfY6zAN0qQHh08oRZhVDGd3ZD71QZvn
	 Y3xNV/YdoZ6Kg5GLdOJZAdpV7Kb7b/9E/QuXpPw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390595AbgF2VYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:24:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729486AbgF2SuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:50:16 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D49BD255D1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 18:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593454320;
        bh=ReZPNCCJ/K8FhCzM6IWgUGCUkf/Lpb/MqZLHZJkjp6Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DiNV0rrk4nxNWP2xmZ6XvSg5tLQJUxPmbUHZ7WJ3PeCJNRMmGZo74Si++VJ22FSeB
         7gx19IER85mfjjr+KDi4Oz8Hfx/c/O82rTfc3aesS+JAU1RPDj8+qBXY2FPxTzmpXk
         XgnaC0PFOEg8aPua+51eU3v+iNtkYThYhhIknY0I=
Received: by mail-ot1-f51.google.com with SMTP id 95so5706119otw.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 11:12:00 -0700 (PDT)
X-Gm-Message-State: AOAM5309BYLjEBXTUCGofcaTymrt9Vn0pIdvxBWh8LQ9nT0lFdiw81UG
        PyVhp/UAvbkkThucBjlFKNifjRcqnJp2SsgYBQY=
X-Google-Smtp-Source: ABdhPJxc638TmUfjS/lrdhyJTEOBYRyhNqfLvQ8GpbSLeTU7CkpIsJfGZckRrod124lrqnbaz6n8cz9ebPVaLGai5NE=
X-Received: by 2002:a9d:4a8f:: with SMTP id i15mr15291584otf.77.1593454320102;
 Mon, 29 Jun 2020 11:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200629140928.858507-8-nivedita@alum.mit.edu> <202006290907.E5EF18A@keescook>
 <CAMj1kXFge5aWL2BY8Y1=m1TonB+SrDq6p7TQWuO5JkzcR2dhjQ@mail.gmail.com>
 <202006290919.93C759C62@keescook> <20200629165603.GD900899@rani.riverdale.lan>
 <20200629173735.l3ssrj7m3q5swfup@google.com>
In-Reply-To: <20200629173735.l3ssrj7m3q5swfup@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 29 Jun 2020 20:11:49 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHaXzYFkW_H=w36vMb1qPpuZXsnTd_giq4vsh0bw3S3eA@mail.gmail.com>
Message-ID: <CAMj1kXHaXzYFkW_H=w36vMb1qPpuZXsnTd_giq4vsh0bw3S3eA@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] x86/boot: Check that there are no runtime relocations
To:     Fangrui Song <maskray@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
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

On Mon, 29 Jun 2020 at 19:37, Fangrui Song <maskray@google.com> wrote:
>
> On 2020-06-29, Arvind Sankar wrote:
> >On Mon, Jun 29, 2020 at 09:20:31AM -0700, Kees Cook wrote:
> >> On Mon, Jun 29, 2020 at 06:11:59PM +0200, Ard Biesheuvel wrote:
> >> > On Mon, 29 Jun 2020 at 18:09, Kees Cook <keescook@chromium.org> wrote:
> >> > >
> >> > > On Mon, Jun 29, 2020 at 10:09:28AM -0400, Arvind Sankar wrote:
> >> > > > Add a linker script check that there are no runtime relocations, and
> >> > > > remove the old one that tries to check via looking for specially-named
> >> > > > sections in the object files.
> >> > > >
> >> > > > Drop the tests for -fPIE compiler option and -pie linker option, as they
> >> > > > are available in all supported gcc and binutils versions (as well as
> >> > > > clang and lld).
> >> > > >
> >> > > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> >> > > > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> >> > > > Reviewed-by: Fangrui Song <maskray@google.com>
> >> > > > ---
> >> > > >  arch/x86/boot/compressed/Makefile      | 28 +++-----------------------
> >> > > >  arch/x86/boot/compressed/vmlinux.lds.S |  8 ++++++++
> >> > > >  2 files changed, 11 insertions(+), 25 deletions(-)
> >> > >
> >> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> >> > >
> >> > > question below ...
> >> > >
> >> > > > diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> >> > > > index a4a4a59a2628..a78510046eec 100644
> >> > > > --- a/arch/x86/boot/compressed/vmlinux.lds.S
> >> > > > +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> >> > > > @@ -42,6 +42,12 @@ SECTIONS
> >> > > >               *(.rodata.*)
> >> > > >               _erodata = . ;
> >> > > >       }
> >> > > > +     .rel.dyn : {
> >> > > > +             *(.rel.*)
> >> > > > +     }
> >> > > > +     .rela.dyn : {
> >> > > > +             *(.rela.*)
> >> > > > +     }
> >> > > >       .got : {
> >> > > >               *(.got)
> >> > > >       }
> >> > >
> >> > > Should these be marked (INFO) as well?
> >> > >
> >> >
> >> > Given that sections marked as (INFO) will still be emitted into the
> >> > ELF image, it does not really make a difference to do this for zero
> >> > sized sections.
> >>
> >> Oh, I misunderstood -- I though they were _not_ emitted; I see now what
> >> you said was not allocated. So, disk space used for the .got.plt case,
> >> but not memory space used. Sorry for the confusion!
> >>
> >> -Kees
>
> About output section type (INFO):
> https://sourceware.org/binutils/docs/ld/Output-Section-Type.html#Output-Section-Type
> says "These type names are supported for backward compatibility, and are
> rarely used."
>
> If all input section don't have the SHF_ALLOC flag, the output section
> will not have this flag as well. This type is not useful...
>
> If .got and .got.plt were used, they should be considered dynamic
> relocations which should be part of the loadable image. So they should
> have the SHF_ALLOC flag. (INFO) will not be applicable anyway.
>

I don't care deeply either way, but Kees indicated that he would like
to get rid of the 24 bytes of .got.plt magic entries that we have no
need for.

In fact, a lot of this mangling is caused by the fact that the linker
is creating a relocatable binary, and assumes that it is a hosted
binary that is loaded by a dynamic loader. It would actually be much
better if the compiler and linker would take -ffreestanding into
account, and suppress GOT entries, PLTs, dynamic program headers for
shared libraries altogether.
