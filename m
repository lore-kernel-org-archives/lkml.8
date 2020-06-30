Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EAAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E6C7206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593534418;
	bh=HBFDlrVI3IwkjEQubd8u4VTO99jFn/iXk+OeqTS0Vrs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fuaka4g0hlKjbEgeNZ2sCLzvcs8jWn65G8X3BtND2wRufyAQFrAprTN0yOOjLkN15
	 v9xGP1RGRbYioLyoZ+ZlRI6b9WHnZfwt12CM56JAX2EAdJ1Dtvf45nDF7cni1NH9Pi
	 EYMqgx98mLpVRD9+ZcOLK/U74PQKdSR4w/lFgWnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387859AbgF3Q05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 12:26:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387434AbgF3Q04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:26:56 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 779D0207F9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 16:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593534415;
        bh=HBFDlrVI3IwkjEQubd8u4VTO99jFn/iXk+OeqTS0Vrs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LwsGhl86O9T8w4jU3ZMJWc93UJD3XnHILloasfsEwguZkHE5qSYfs2ctj9OSCprig
         DWExO67eZ8Tincrp0oKr7MckXMlJIgppH/oUElxG8dpdf8lAUazamRtDOT619iGHcx
         gWS2LH+SyuQN8PyfNYvLrbsRaR8KlokEwlo31d3k=
Received: by mail-ot1-f43.google.com with SMTP id 76so4461628otu.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 09:26:55 -0700 (PDT)
X-Gm-Message-State: AOAM5339whJWO6y+U7bNAq0bvZ5IG5h78dNF/VCZs+s8hmsTBIz84RRk
        dNWe4+MN0hip1nznUsFawsaKxpGsIEOyziYPzB4=
X-Google-Smtp-Source: ABdhPJxbvfITvHp7n7T9uYx6THN1L08zYlFMRXAGpSRr/ip3lvNMV6h+OajI+z7y1DF7oZXFunFw2iDkagNrwZ/0gfo=
X-Received: by 2002:a9d:5a12:: with SMTP id v18mr17948123oth.90.1593534414633;
 Tue, 30 Jun 2020 09:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200629140928.858507-8-nivedita@alum.mit.edu> <202006290907.E5EF18A@keescook>
 <CAMj1kXFge5aWL2BY8Y1=m1TonB+SrDq6p7TQWuO5JkzcR2dhjQ@mail.gmail.com>
 <202006290919.93C759C62@keescook> <20200629165603.GD900899@rani.riverdale.lan>
 <20200629173735.l3ssrj7m3q5swfup@google.com> <CAMj1kXHaXzYFkW_H=w36vMb1qPpuZXsnTd_giq4vsh0bw3S3eA@mail.gmail.com>
 <20200629233405.n56yb4xwlgxrt3fn@google.com>
In-Reply-To: <20200629233405.n56yb4xwlgxrt3fn@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 30 Jun 2020 18:26:43 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGTOdNiuU70pFB74UJ6z43AM-UViTSd3=ATV=94W+f1RA@mail.gmail.com>
Message-ID: <CAMj1kXGTOdNiuU70pFB74UJ6z43AM-UViTSd3=ATV=94W+f1RA@mail.gmail.com>
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

On Tue, 30 Jun 2020 at 01:34, Fangrui Song <maskray@google.com> wrote:
>
> On 2020-06-29, Ard Biesheuvel wrote:
> >On Mon, 29 Jun 2020 at 19:37, Fangrui Song <maskray@google.com> wrote:
> >>
> >> On 2020-06-29, Arvind Sankar wrote:
> >> >On Mon, Jun 29, 2020 at 09:20:31AM -0700, Kees Cook wrote:
> >> >> On Mon, Jun 29, 2020 at 06:11:59PM +0200, Ard Biesheuvel wrote:
> >> >> > On Mon, 29 Jun 2020 at 18:09, Kees Cook <keescook@chromium.org> wrote:
> >> >> > >
> >> >> > > On Mon, Jun 29, 2020 at 10:09:28AM -0400, Arvind Sankar wrote:
> >> >> > > > Add a linker script check that there are no runtime relocations, and
> >> >> > > > remove the old one that tries to check via looking for specially-named
> >> >> > > > sections in the object files.
> >> >> > > >
> >> >> > > > Drop the tests for -fPIE compiler option and -pie linker option, as they
> >> >> > > > are available in all supported gcc and binutils versions (as well as
> >> >> > > > clang and lld).
> >> >> > > >
> >> >> > > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> >> >> > > > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> >> >> > > > Reviewed-by: Fangrui Song <maskray@google.com>
> >> >> > > > ---
> >> >> > > >  arch/x86/boot/compressed/Makefile      | 28 +++-----------------------
> >> >> > > >  arch/x86/boot/compressed/vmlinux.lds.S |  8 ++++++++
> >> >> > > >  2 files changed, 11 insertions(+), 25 deletions(-)
> >> >> > >
> >> >> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> >> >> > >
> >> >> > > question below ...
> >> >> > >
> >> >> > > > diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> >> >> > > > index a4a4a59a2628..a78510046eec 100644
> >> >> > > > --- a/arch/x86/boot/compressed/vmlinux.lds.S
> >> >> > > > +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> >> >> > > > @@ -42,6 +42,12 @@ SECTIONS
> >> >> > > >               *(.rodata.*)
> >> >> > > >               _erodata = . ;
> >> >> > > >       }
> >> >> > > > +     .rel.dyn : {
> >> >> > > > +             *(.rel.*)
> >> >> > > > +     }
> >> >> > > > +     .rela.dyn : {
> >> >> > > > +             *(.rela.*)
> >> >> > > > +     }
> >> >> > > >       .got : {
> >> >> > > >               *(.got)
> >> >> > > >       }
> >> >> > >
> >> >> > > Should these be marked (INFO) as well?
> >> >> > >
> >> >> >
> >> >> > Given that sections marked as (INFO) will still be emitted into the
> >> >> > ELF image, it does not really make a difference to do this for zero
> >> >> > sized sections.
> >> >>
> >> >> Oh, I misunderstood -- I though they were _not_ emitted; I see now what
> >> >> you said was not allocated. So, disk space used for the .got.plt case,
> >> >> but not memory space used. Sorry for the confusion!
> >> >>
> >> >> -Kees
> >>
> >> About output section type (INFO):
> >> https://sourceware.org/binutils/docs/ld/Output-Section-Type.html#Output-Section-Type
> >> says "These type names are supported for backward compatibility, and are
> >> rarely used."
> >>
> >> If all input section don't have the SHF_ALLOC flag, the output section
> >> will not have this flag as well. This type is not useful...
> >>
> >> If .got and .got.plt were used, they should be considered dynamic
> >> relocations which should be part of the loadable image. So they should
> >> have the SHF_ALLOC flag. (INFO) will not be applicable anyway.
> >>
> >
> >I don't care deeply either way, but Kees indicated that he would like
> >to get rid of the 24 bytes of .got.plt magic entries that we have no
> >need for.
> >
> >In fact, a lot of this mangling is caused by the fact that the linker
> >is creating a relocatable binary, and assumes that it is a hosted
> >binary that is loaded by a dynamic loader. It would actually be much
> >better if the compiler and linker would take -ffreestanding into
> >account, and suppress GOT entries, PLTs, dynamic program headers for
> >shared libraries altogether.
>
> Linkers (GNU ld and LLD) don't create .got or .got.plt just because the linker
> command line has -pie or -shared.  They create .got or .got.plt if there are
> specific needs.
>
> For .got.plt, if there is (1) any .plt/.iplt entry, (2) any .got.plt based
> relocation (e.g. R_X86_64_GOTPC32 on x86-64), or (3) if _GLOBAL_OFFSET_TABLE_ is
> referenced, .got.plt will be created (both GNU ld and LLD) with usually 3
> entries (for ld.so purposes).
>

This is not the case for AArch64. There, __GLOBAL_OFFSET_TABLE__ is
always emitted, along with the magic .got.plt entries, regardless of
the input.

As for the input objects - why is '#pragma GCC visibility(hidden)' not
the default for -ffreestanding builds? This suppresses any GOT entries
emitted by the compiler, but the only way to get this behavior is
through the #pragma, which is how we ended up with '-include hidden.h'
in a couple of places.

IOW, if the toolchain behavior was not 100% geared towards shared
executables as it is today, we would not need the hacks that we need
to apply to get a relocatable bare metal binary like we need for the
KASLR kernel.


> If (1) is not satisfied, the created .got.plt is just served as an anchor for
> things that want to reference (the distance from GOT base to some point). The
> linker will still reserve 3 words but the words are likely not needed.
>
> I don't think there is a specific need for another option to teach the linker
> (GNU ld or LLD) that this is a kernel link.  For -ffreestanding builds, cc
> -static (ld -no-pie))/-static-pie (-pie) already work quite well.

You mean 'ld -static -pie' right? That seems to work. Is that a recent
invention?
