Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C08C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A596220786
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O8CsQx6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbgF2XeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgF2XeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 19:34:11 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2BFC061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 16:34:11 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j1so8570334pfe.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 16:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5f9mb9YPg6OjmB0FalT+YWZSWHeNIR0BJDsRMM1Osec=;
        b=O8CsQx6qD+q+i2lCb4Lm+fVOjUs/zhm/FLSGZ8kwuEg6A7849JLvQaOHIl0VClYNeG
         bQXr4hJswTks8L6pZKLEg6mgNgUXTucmcMiVZNNBOw5WOXauG12mA9/qcJU286yci8dR
         Zfz5KpRx3WH7ajFJW3YR8Oa+YuhlQw5D5FO3DXQioWuMDvO2pwMhmjiC2BH2wsovBHRn
         C1HHUYqVV38wwJXnhBlm423GkzRAAPcrzC+k4FivpNMeYvNcfjOr8hZsnDRJywpJLeR+
         gRg9+gXUhMjS/ib9G/6EXc6+ywvSrlWu3Tt5v2deOampxw4oC+7VTtcqEJYoYUoiD6v5
         pNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5f9mb9YPg6OjmB0FalT+YWZSWHeNIR0BJDsRMM1Osec=;
        b=jMArUqwURBCOModdnc8UK9y6LF2zClwMJp+t7gZwIVZfI622YgWfd0pFZHrsUzz6mm
         HVqVyrRHswz5Ar48IP/KtsEbFfmwMOnRfnJagbbAu2AdWV7Wzr2WO08tGan2GxvXECX9
         Bs4kq6qUC1tqjLEFm8mQtlpxdlwQnfMCtGtsC6tgTJr14nzBXyDTELWrVwzbhgAWg5BZ
         PZN+fKk8On/fjNPNXIRpEZuQqNFSjx+M8sL5DTS7wuQZo49GkeQvOkA1RH3h1rINBbqY
         lVsG9HLHIWH1CvXeTxskgZREs6XiqF99IBdAcEC7BgH0RAu0s+yHq3z/dNc5tc/3LqvT
         Uhxg==
X-Gm-Message-State: AOAM533ozLUtPYDOuYVDOXAPG/4edC4if7AAVd3LUCzu22K7nu0+t4Ar
        v6xtHzN9ye7yIwFkr+hOhMBFsg==
X-Google-Smtp-Source: ABdhPJwUURP0vqFZmSab8huvpJnEKa1COgKGuzm6PJGDvlTnrrCaSMtwXTEJUhaQ5jKPvemdtE+wOA==
X-Received: by 2002:a63:5a17:: with SMTP id o23mr12507469pgb.218.1593473650486;
        Mon, 29 Jun 2020 16:34:10 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id d16sm645765pfo.156.2020.06.29.16.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 16:34:09 -0700 (PDT)
Date:   Mon, 29 Jun 2020 16:34:05 -0700
From:   Fangrui Song <maskray@google.com>
To:     Ard Biesheuvel <ardb@kernel.org>
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
Subject: Re: [PATCH v3 7/7] x86/boot: Check that there are no runtime
 relocations
Message-ID: <20200629233405.n56yb4xwlgxrt3fn@google.com>
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200629140928.858507-8-nivedita@alum.mit.edu>
 <202006290907.E5EF18A@keescook>
 <CAMj1kXFge5aWL2BY8Y1=m1TonB+SrDq6p7TQWuO5JkzcR2dhjQ@mail.gmail.com>
 <202006290919.93C759C62@keescook>
 <20200629165603.GD900899@rani.riverdale.lan>
 <20200629173735.l3ssrj7m3q5swfup@google.com>
 <CAMj1kXHaXzYFkW_H=w36vMb1qPpuZXsnTd_giq4vsh0bw3S3eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMj1kXHaXzYFkW_H=w36vMb1qPpuZXsnTd_giq4vsh0bw3S3eA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-29, Ard Biesheuvel wrote:
>On Mon, 29 Jun 2020 at 19:37, Fangrui Song <maskray@google.com> wrote:
>>
>> On 2020-06-29, Arvind Sankar wrote:
>> >On Mon, Jun 29, 2020 at 09:20:31AM -0700, Kees Cook wrote:
>> >> On Mon, Jun 29, 2020 at 06:11:59PM +0200, Ard Biesheuvel wrote:
>> >> > On Mon, 29 Jun 2020 at 18:09, Kees Cook <keescook@chromium.org> wrote:
>> >> > >
>> >> > > On Mon, Jun 29, 2020 at 10:09:28AM -0400, Arvind Sankar wrote:
>> >> > > > Add a linker script check that there are no runtime relocations, and
>> >> > > > remove the old one that tries to check via looking for specially-named
>> >> > > > sections in the object files.
>> >> > > >
>> >> > > > Drop the tests for -fPIE compiler option and -pie linker option, as they
>> >> > > > are available in all supported gcc and binutils versions (as well as
>> >> > > > clang and lld).
>> >> > > >
>> >> > > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
>> >> > > > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
>> >> > > > Reviewed-by: Fangrui Song <maskray@google.com>
>> >> > > > ---
>> >> > > >  arch/x86/boot/compressed/Makefile      | 28 +++-----------------------
>> >> > > >  arch/x86/boot/compressed/vmlinux.lds.S |  8 ++++++++
>> >> > > >  2 files changed, 11 insertions(+), 25 deletions(-)
>> >> > >
>> >> > > Reviewed-by: Kees Cook <keescook@chromium.org>
>> >> > >
>> >> > > question below ...
>> >> > >
>> >> > > > diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
>> >> > > > index a4a4a59a2628..a78510046eec 100644
>> >> > > > --- a/arch/x86/boot/compressed/vmlinux.lds.S
>> >> > > > +++ b/arch/x86/boot/compressed/vmlinux.lds.S
>> >> > > > @@ -42,6 +42,12 @@ SECTIONS
>> >> > > >               *(.rodata.*)
>> >> > > >               _erodata = . ;
>> >> > > >       }
>> >> > > > +     .rel.dyn : {
>> >> > > > +             *(.rel.*)
>> >> > > > +     }
>> >> > > > +     .rela.dyn : {
>> >> > > > +             *(.rela.*)
>> >> > > > +     }
>> >> > > >       .got : {
>> >> > > >               *(.got)
>> >> > > >       }
>> >> > >
>> >> > > Should these be marked (INFO) as well?
>> >> > >
>> >> >
>> >> > Given that sections marked as (INFO) will still be emitted into the
>> >> > ELF image, it does not really make a difference to do this for zero
>> >> > sized sections.
>> >>
>> >> Oh, I misunderstood -- I though they were _not_ emitted; I see now what
>> >> you said was not allocated. So, disk space used for the .got.plt case,
>> >> but not memory space used. Sorry for the confusion!
>> >>
>> >> -Kees
>>
>> About output section type (INFO):
>> https://sourceware.org/binutils/docs/ld/Output-Section-Type.html#Output-Section-Type
>> says "These type names are supported for backward compatibility, and are
>> rarely used."
>>
>> If all input section don't have the SHF_ALLOC flag, the output section
>> will not have this flag as well. This type is not useful...
>>
>> If .got and .got.plt were used, they should be considered dynamic
>> relocations which should be part of the loadable image. So they should
>> have the SHF_ALLOC flag. (INFO) will not be applicable anyway.
>>
>
>I don't care deeply either way, but Kees indicated that he would like
>to get rid of the 24 bytes of .got.plt magic entries that we have no
>need for.
>
>In fact, a lot of this mangling is caused by the fact that the linker
>is creating a relocatable binary, and assumes that it is a hosted
>binary that is loaded by a dynamic loader. It would actually be much
>better if the compiler and linker would take -ffreestanding into
>account, and suppress GOT entries, PLTs, dynamic program headers for
>shared libraries altogether.

Linkers (GNU ld and LLD) don't create .got or .got.plt just because the linker
command line has -pie or -shared.  They create .got or .got.plt if there are
specific needs.

For .got.plt, if there is (1) any .plt/.iplt entry, (2) any .got.plt based
relocation (e.g. R_X86_64_GOTPC32 on x86-64), or (3) if _GLOBAL_OFFSET_TABLE_ is
referenced, .got.plt will be created (both GNU ld and LLD) with usually 3
entries (for ld.so purposes).

If (1) is not satisfied, the created .got.plt is just served as an anchor for
things that want to reference (the distance from GOT base to some point). The
linker will still reserve 3 words but the words are likely not needed.

I don't think there is a specific need for another option to teach the linker
(GNU ld or LLD) that this is a kernel link.  For -ffreestanding builds, cc
-static (ld -no-pie))/-static-pie (-pie) already work quite well.
