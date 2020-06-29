Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA87C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F378420656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZXaKassr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgF2Sxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729806AbgF2Sww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:52 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172A6C031C59
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:37:39 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gc15so1074686pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4MOdfZ/7G/g8IQUDnDAduTn6na/PIZsHRNxYZf5SkEI=;
        b=ZXaKassrth3M0uat5Wpfn6AExUzN2NBI30huoWxTSzmhIcmxqnCHNxjxmSqISmrTL9
         kSyTb3XvRgSlZa2oq8gqXfhkvkms8DqCxi0zics7ibN9LSfPdWuoCAmcbzfTVgVXpzcq
         gWhEp0s6e+n5b846nBIMi/GZ7nj/2Z/pH/srqzey4f+uuA4NXxlvHG5cvZxQ+PdeH4ER
         2XiXHEkb6hlXQ4rUhf6OS//M40Y8CmX4Q8nrFSwmtYi7VzqIxOVKEF0yWfNkL474NXkp
         fwFdF28fltgDbZWBqK0PrECMLc6NC9+K+P+n18cDm6HngOhsvcIZ5oxP1RUzaWuHREi/
         Hhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4MOdfZ/7G/g8IQUDnDAduTn6na/PIZsHRNxYZf5SkEI=;
        b=ZS4CrpuMPhVQvasicMaC4MyleJ8tK189j9NXWzKmAUKjDkKyQ+HdVKLqGOL3XTRh4w
         2pXQNi0YMxj5SB/aJctq/8OyE9fL92XnEyvbb6xSwIMgy6NahqA3wQpgD5aw1MwueEha
         PQMykrYCk7qYS6qmLQ3v/Br4qVx4xddSfvJ+EWjYwOSPyw0xGhQ8/wfEf3zsm1etoAgs
         2Now3x/uaLxxT8pq3QGKbsasmWrXVBEn+LG16Gwb1JqG5zcwn5gE3pmdrSzW529OcZCX
         SmrVQBCB973cFVGQKNRrLHD7zYOpcj8ULkzLcEqK9UG6Orq+H0Skw3H5hjIOYB6Pxjvk
         2ekQ==
X-Gm-Message-State: AOAM532jZnP9lNDe8JXOZ6kYwD+hxkjfa0xJ/S4wTi9ZqiTG8WdvTrvD
        LC9dInxFo0jjoyhkg970lUObRw==
X-Google-Smtp-Source: ABdhPJwzPvAJ8eEZ+SFTsEUT1PtQlthFxztToELgKT+XnOEQ+J3ccuXm8RkwVvzs8zVaSfZ3QJMMEQ==
X-Received: by 2002:a17:90b:1b07:: with SMTP id nu7mr1651323pjb.4.1593452258401;
        Mon, 29 Jun 2020 10:37:38 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id u20sm301960pfk.91.2020.06.29.10.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 10:37:37 -0700 (PDT)
Date:   Mon, 29 Jun 2020 10:37:35 -0700
From:   Fangrui Song <maskray@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
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
Message-ID: <20200629173735.l3ssrj7m3q5swfup@google.com>
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200629140928.858507-8-nivedita@alum.mit.edu>
 <202006290907.E5EF18A@keescook>
 <CAMj1kXFge5aWL2BY8Y1=m1TonB+SrDq6p7TQWuO5JkzcR2dhjQ@mail.gmail.com>
 <202006290919.93C759C62@keescook>
 <20200629165603.GD900899@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200629165603.GD900899@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-29, Arvind Sankar wrote:
>On Mon, Jun 29, 2020 at 09:20:31AM -0700, Kees Cook wrote:
>> On Mon, Jun 29, 2020 at 06:11:59PM +0200, Ard Biesheuvel wrote:
>> > On Mon, 29 Jun 2020 at 18:09, Kees Cook <keescook@chromium.org> wrote:
>> > >
>> > > On Mon, Jun 29, 2020 at 10:09:28AM -0400, Arvind Sankar wrote:
>> > > > Add a linker script check that there are no runtime relocations, and
>> > > > remove the old one that tries to check via looking for specially-named
>> > > > sections in the object files.
>> > > >
>> > > > Drop the tests for -fPIE compiler option and -pie linker option, as they
>> > > > are available in all supported gcc and binutils versions (as well as
>> > > > clang and lld).
>> > > >
>> > > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
>> > > > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
>> > > > Reviewed-by: Fangrui Song <maskray@google.com>
>> > > > ---
>> > > >  arch/x86/boot/compressed/Makefile      | 28 +++-----------------------
>> > > >  arch/x86/boot/compressed/vmlinux.lds.S |  8 ++++++++
>> > > >  2 files changed, 11 insertions(+), 25 deletions(-)
>> > >
>> > > Reviewed-by: Kees Cook <keescook@chromium.org>
>> > >
>> > > question below ...
>> > >
>> > > > diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
>> > > > index a4a4a59a2628..a78510046eec 100644
>> > > > --- a/arch/x86/boot/compressed/vmlinux.lds.S
>> > > > +++ b/arch/x86/boot/compressed/vmlinux.lds.S
>> > > > @@ -42,6 +42,12 @@ SECTIONS
>> > > >               *(.rodata.*)
>> > > >               _erodata = . ;
>> > > >       }
>> > > > +     .rel.dyn : {
>> > > > +             *(.rel.*)
>> > > > +     }
>> > > > +     .rela.dyn : {
>> > > > +             *(.rela.*)
>> > > > +     }
>> > > >       .got : {
>> > > >               *(.got)
>> > > >       }
>> > >
>> > > Should these be marked (INFO) as well?
>> > >
>> >
>> > Given that sections marked as (INFO) will still be emitted into the
>> > ELF image, it does not really make a difference to do this for zero
>> > sized sections.
>>
>> Oh, I misunderstood -- I though they were _not_ emitted; I see now what
>> you said was not allocated. So, disk space used for the .got.plt case,
>> but not memory space used. Sorry for the confusion!
>>
>> -Kees

About output section type (INFO):
https://sourceware.org/binutils/docs/ld/Output-Section-Type.html#Output-Section-Type
says "These type names are supported for backward compatibility, and are
rarely used."

If all input section don't have the SHF_ALLOC flag, the output section
will not have this flag as well. This type is not useful...

If .got and .got.plt were used, they should be considered dynamic
relocations which should be part of the loadable image. So they should
have the SHF_ALLOC flag. (INFO) will not be applicable anyway.

SHT_REL[A] may be allocable or not. Usually .rel[a].dyn and .rel[a].plt
are linker created allocable sections. (INFO) does not make sense for them.

>In the case of the REL[A] and .got sections, they are actually already
>not emitted at all into the ELF file now that they are zero size.
>
>For .got.plt, it is only emitted for 32-bit (with the 3 reserved
>entries), the 64-bit linker seems to get rid of it.
