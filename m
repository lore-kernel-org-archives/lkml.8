Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AD5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 22:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B3242073E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 22:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P1jN7hrT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgF3WGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 18:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgF3WGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 18:06:44 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444F6C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 15:06:44 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i4so10112740pjd.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 15:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JRbK+0YHHIIsxTnbZ87llwjlpqpRQpEg9t8681tVnaU=;
        b=P1jN7hrTy263FT44RDpDA65u3Rpzfknem+XD+OMM/9oElVw4mULSi4D0lEO0eRmOKF
         Jpl22NVra0Z4yS6qM/4cEqrsqHE11VDz0LW/TJdwENjM1XKwAxuc/zx6jHtYKPYVcPNc
         bJ7DBiyCYCw9FVrxk51YTI/1Jr9v5yYigqgM/V/5y6GrMWXfD1H5uF9L+FlTvRT/dgtf
         J9wm9fmOxRDyaq52BfrTDqEBgkYyr7pErzDIR0IPGZIoHHi/1vmIek/VZuJjyz9UlOxn
         W8TJsKUJJGU5n71KbMM76zZ4x8usO3ozwR7Kp/9dVjoMdwJpAkFF0Wgl3Wv5kKl6u8NI
         el8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JRbK+0YHHIIsxTnbZ87llwjlpqpRQpEg9t8681tVnaU=;
        b=W8QlVARmdLl3goydo3Ldaduklw2+lZtXC9XGhIeN38qUay9yAp8eDsg7w6fi68cgxi
         UsSsk5d1LM3hS0bra2dZImCx8ibQiQI1pEUIkJuIWMjC1OgV0nZnUxK0il4mQVp9Egmi
         Fmo2+4gK5Q0O8WNrgi3aqt0w6DArR8romAbq153TjzRlgsbSWBqEZlIh+XD9onA7CjjM
         tN732zIB6sGvhJHwOyd8sXTbKD3ujvvcv8Gbkmse/N9o9K5r5cjzNUEShlKB4F11wvd1
         IiKjKrZKXkyZ8lYV+wGbauC3E0Z0ZvplfXyenFq46io2R2JksErCQQT+ILrqsvIATU0P
         1htA==
X-Gm-Message-State: AOAM53368wqH/f8njQrI4Kbd6AVsGseUqcBUPlhMEZhL9lx5c9x/HN2u
        pqAexjhhk/S9ebHwTP4eG+SBM4EpnmnJ5Q==
X-Google-Smtp-Source: ABdhPJxDxtDfZTSAkX+NxphzmnffBhNbntenBaLW+fAJ6PwpAxKSAhUSQAvDZVk7p8m8JKlS3dSElw==
X-Received: by 2002:a17:902:c697:: with SMTP id r23mr9815458plx.35.1593554447222;
        Tue, 30 Jun 2020 15:00:47 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:a6ae:11ff:fe11:4abb])
        by smtp.gmail.com with ESMTPSA id s131sm3658364pgc.30.2020.06.30.15.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 15:00:46 -0700 (PDT)
Date:   Tue, 30 Jun 2020 15:00:43 -0700
From:   Fangrui Song <maskray@google.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
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
Subject: Re: [PATCH v3 7/7] x86/boot: Check that there are no runtime
 relocations
Message-ID: <20200630220043.4snabunhgvfdktte@google.com>
References: <20200629140928.858507-8-nivedita@alum.mit.edu>
 <202006290907.E5EF18A@keescook>
 <CAMj1kXFge5aWL2BY8Y1=m1TonB+SrDq6p7TQWuO5JkzcR2dhjQ@mail.gmail.com>
 <202006290919.93C759C62@keescook>
 <20200629165603.GD900899@rani.riverdale.lan>
 <20200629173735.l3ssrj7m3q5swfup@google.com>
 <CAMj1kXHaXzYFkW_H=w36vMb1qPpuZXsnTd_giq4vsh0bw3S3eA@mail.gmail.com>
 <20200629233405.n56yb4xwlgxrt3fn@google.com>
 <CAMj1kXGTOdNiuU70pFB74UJ6z43AM-UViTSd3=ATV=94W+f1RA@mail.gmail.com>
 <20200630175408.GA2301688@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200630175408.GA2301688@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Ard Biesheuvel
> On Tue, 30 Jun 2020 at 01:34, Fangrui Song <maskray@google.com> wrote:
> >
> > On 2020-06-29, Ard Biesheuvel wrote:
> > >On Mon, 29 Jun 2020 at 19:37, Fangrui Song <maskray@google.com> wrote:
> > >>
> > >> On 2020-06-29, Arvind Sankar wrote:
> > >> >On Mon, Jun 29, 2020 at 09:20:31AM -0700, Kees Cook wrote:
> > >> >> On Mon, Jun 29, 2020 at 06:11:59PM +0200, Ard Biesheuvel wrote:
> > >> >> > On Mon, 29 Jun 2020 at 18:09, Kees Cook <keescook@chromium.org> wrote:
> > >> >> > >
> > >> >> > > On Mon, Jun 29, 2020 at 10:09:28AM -0400, Arvind Sankar wrote:
> > >> >> > > > Add a linker script check that there are no runtime relocations, and
> > >> >> > > > remove the old one that tries to check via looking for specially-named
> > >> >> > > > sections in the object files.
> > >> >> > > >
> > >> >> > > > Drop the tests for -fPIE compiler option and -pie linker option, as they
> > >> >> > > > are available in all supported gcc and binutils versions (as well as
> > >> >> > > > clang and lld).
> > >> >> > > >
> > >> >> > > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > >> >> > > > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> > >> >> > > > Reviewed-by: Fangrui Song <maskray@google.com>
> > >> >> > > > ---
> > >> >> > > >  arch/x86/boot/compressed/Makefile      | 28 +++-----------------------
> > >> >> > > >  arch/x86/boot/compressed/vmlinux.lds.S |  8 ++++++++
> > >> >> > > >  2 files changed, 11 insertions(+), 25 deletions(-)
> > >> >> > >
> > >> >> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > >> >> > >
> > >> >> > > question below ...
> > >> >> > >
> > >> >> > > > diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> > >> >> > > > index a4a4a59a2628..a78510046eec 100644
> > >> >> > > > --- a/arch/x86/boot/compressed/vmlinux.lds.S
> > >> >> > > > +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> > >> >> > > > @@ -42,6 +42,12 @@ SECTIONS
> > >> >> > > >               *(.rodata.*)
> > >> >> > > >               _erodata = . ;
> > >> >> > > >       }
> > >> >> > > > +     .rel.dyn : {
> > >> >> > > > +             *(.rel.*)
> > >> >> > > > +     }
> > >> >> > > > +     .rela.dyn : {
> > >> >> > > > +             *(.rela.*)
> > >> >> > > > +     }
> > >> >> > > >       .got : {
> > >> >> > > >               *(.got)
> > >> >> > > >       }
> > >> >> > >
> > >> >> > > Should these be marked (INFO) as well?
> > >> >> > >
> > >> >> >
> > >> >> > Given that sections marked as (INFO) will still be emitted into the
> > >> >> > ELF image, it does not really make a difference to do this for zero
> > >> >> > sized sections.
> > >> >>
> > >> >> Oh, I misunderstood -- I though they were _not_ emitted; I see now what
> > >> >> you said was not allocated. So, disk space used for the .got.plt case,
> > >> >> but not memory space used. Sorry for the confusion!
> > >> >>
> > >> >> -Kees
> > >>
> > >> About output section type (INFO):
> > >> https://sourceware.org/binutils/docs/ld/Output-Section-Type.html#Output-Section-Type
> > >> says "These type names are supported for backward compatibility, and are
> > >> rarely used."
> > >>
> > >> If all input section don't have the SHF_ALLOC flag, the output section
> > >> will not have this flag as well. This type is not useful...
> > >>
> > >> If .got and .got.plt were used, they should be considered dynamic
> > >> relocations which should be part of the loadable image. So they should
> > >> have the SHF_ALLOC flag. (INFO) will not be applicable anyway.
> > >>
> > >
> > >I don't care deeply either way, but Kees indicated that he would like
> > >to get rid of the 24 bytes of .got.plt magic entries that we have no
> > >need for.
> > >
> > >In fact, a lot of this mangling is caused by the fact that the linker
> > >is creating a relocatable binary, and assumes that it is a hosted
> > >binary that is loaded by a dynamic loader. It would actually be much
> > >better if the compiler and linker would take -ffreestanding into
> > >account, and suppress GOT entries, PLTs, dynamic program headers for
> > >shared libraries altogether.
> >
> > Linkers (GNU ld and LLD) don't create .got or .got.plt just because the linker
> > command line has -pie or -shared.  They create .got or .got.plt if there are
> > specific needs.
> >
> > For .got.plt, if there is (1) any .plt/.iplt entry, (2) any .got.plt based
> > relocation (e.g. R_X86_64_GOTPC32 on x86-64), or (3) if _GLOBAL_OFFSET_TABLE_ is
> > referenced, .got.plt will be created (both GNU ld and LLD) with usually 3
> > entries (for ld.so purposes).
> >
> 
> This is not the case for AArch64. There, __GLOBAL_OFFSET_TABLE__ is
> always emitted, along with the magic .got.plt entries, regardless of
> the input.
> 
> As for the input objects - why is '#pragma GCC visibility(hidden)' not
> the default for -ffreestanding builds? This suppresses any GOT entries
> emitted by the compiler, but the only way to get this behavior is
> through the #pragma, which is how we ended up with '-include hidden.h'
> in a couple of places.

A -ffreestanding build may provide a shared object used by other
applications. For example, musl (libc)'s CFLAGS has -ffreestanding.

> IOW, if the toolchain behavior was not 100% geared towards shared
> executables as it is today, we would not need the hacks that we need
> to apply to get a relocatable bare metal binary like we need for the
> KASLR kernel.

My mere concern regarding "geared towards shared objects" is that ELF
assumes symbols of default visibility are preemptible by default.

So unfortunately it is difficult to make -fno-semantic-interposition the
default.

> If (1) is not satisfied, the created .got.plt is just served as an anchor for
> things that want to reference (the distance from GOT base to some point). The
> linker will still reserve 3 words but the words are likely not needed.
>
> I don't think there is a specific need for another option to teach the linker
> (GNU ld or LLD) that this is a kernel link.  For -ffreestanding builds, cc
> -static (ld -no-pie))/-static-pie (-pie) already work quite well.

On 2020-06-30, Arvind Sankar wrote:
>On Tue, Jun 30, 2020 at 06:26:43PM +0200, Ard Biesheuvel wrote:
>> On Tue, 30 Jun 2020 at 01:34, Fangrui Song <maskray@google.com> wrote:
>>
>> > If (1) is not satisfied, the created .got.plt is just served as an anchor for
>> > things that want to reference (the distance from GOT base to some point). The
>> > linker will still reserve 3 words but the words are likely not needed.
>> >
>> > I don't think there is a specific need for another option to teach the linker
>> > (GNU ld or LLD) that this is a kernel link.  For -ffreestanding builds, cc
>> > -static (ld -no-pie))/-static-pie (-pie) already work quite well.
>>
>> You mean 'ld -static -pie' right? That seems to work. Is that a recent
>> invention?
>
>gcc -static-pie is fairly recent [0], but it just influences how the
>linker is invoked AFAIK (at least for gcc) -- in addition to passing
>some linker flags, it will change what startup files get linked in (for
>non-freestanding). It does not even imply -fPIE to the compiler, which
>is confusing as hell. It _would_ be nice if this also told the compiler
>that all symbols (perhaps unless explicitly marked) will be resolved at
>static link time, so there is no need to use the GOT or PLT for globals.
>
>As it stands, the executable can still have relocations, GOT and PLT, it
>just needs to have startup code to handle them (provided by libc
>typically) instead of relying on an external dynamic linker.

If the executable is purely static, it does not need to have PLT. All
calls to a PLT can be redirected to the function itself.  Some range
extension thunks (other terms: stub groups, veneers, etc) may still be
needed if the distance is too large.

There are cases where a GOT cannot be avoided, e.g.

extern char foo[] __attribute__((weak, visibility("hidden")));
char *fun() { return foo; }

If foo is a SHN_ABS, `movq foo@GOTPCREL(%rip), %rax` can't be optimized
by GOTPCRELX (https://sourceware.org/bugzilla/show_bug.cgi?id=25749 binutils>=2.35 will be good)
Many other architectures don't even have a GOT optimization.

>I don't think it's really relevant for the kernel build -- all we get is
>ld -static --no-dynamic-linker, all -static does is prevent searching
>shared libraries, and we already pass --no-dynamic-linker if it's
>supported.
>
>[0] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81498
