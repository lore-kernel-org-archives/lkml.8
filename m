Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C049C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7032C206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lR1BCUsf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732308AbgF2TWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730465AbgF2TWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:22:45 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C06C030F37
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:56:06 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z2so13379016qts.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jVlqHQzn01y7nrvyopD8q2AIuA6aQSm3TomDB97NTFc=;
        b=lR1BCUsfkUS71XdEnnVOCmF2jxtwngF92vJX/PeOQsQLmTGoEDhzaHs6wZvenZ7OaC
         hVsnLfapx01e/VzCMZlqnlSQ1vrv6IhYO1SVe4iLR0pJlWEUk5br5l65moUUxmrodr0j
         zX0+ENopxhC3q1hQI5veDb6yA3x37zpjNQhutCraS+KO2dd7/vjLXaPCedITuyoA6q/e
         U4Ld1QPNhRl+8mclEdvItGaUXKG+9CAyFssq4VIj6fP6wqyThTvI4nuVszIGGgb3TPaJ
         gXiafYz/0D0CB7cEYZ1hI5Sxq1O8W0iqO2I30N7Q9iXkQS2c5W4TXqR/M9pdHHLOez1Z
         iHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jVlqHQzn01y7nrvyopD8q2AIuA6aQSm3TomDB97NTFc=;
        b=H2rzASVDqewmcik3vc5E8uourAeybqWDGzZ/LgDA8SrzGNt17i92A6jJS3YT7r1yBp
         Swst99tRPziyBxynuKFAxOAz7O5aUpYbf/NiDiv6+EFcQhw1tpclOg4uPWfuAEgjwqXg
         FdHpcMDj0j7typrBl/DyKCB3r6Z0ejQMLNZ5qsdVQjxOYn0C9wcgvnHRiArNdy42xLl0
         Yc67m3oHSHbm8GGlIZjZy0gRbHLvBo3KK+AjDlH2/c/kiXliPzaTorWOljTcfAWS440c
         gnmOtiqdgDV4fXvGK4nByMaMHXB0iLF4DywxgZ6HMscPIcaWFIAlc3jJQCri4GdZ+zrI
         Ov+A==
X-Gm-Message-State: AOAM532z4D0lVQQ3CT+N477egzS5IIbnWpl7q+moVOY4mKDrkSaLShwq
        FayLw/Nj2+ou91bKJnZcnHs=
X-Google-Smtp-Source: ABdhPJzWFzzJ6iDDqkBeA0BWgRfTY9UlCVlAPAZNW9jLh7TFPmxhVw8K+F0h4fNCTkWAqs5g2T+fBQ==
X-Received: by 2002:aed:2359:: with SMTP id i25mr16769164qtc.194.1593449766079;
        Mon, 29 Jun 2020 09:56:06 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id p25sm361142qki.107.2020.06.29.09.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 09:56:05 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 29 Jun 2020 12:56:03 -0400
To:     Kees Cook <keescook@chromium.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
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
Subject: Re: [PATCH v3 7/7] x86/boot: Check that there are no runtime
 relocations
Message-ID: <20200629165603.GD900899@rani.riverdale.lan>
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200629140928.858507-8-nivedita@alum.mit.edu>
 <202006290907.E5EF18A@keescook>
 <CAMj1kXFge5aWL2BY8Y1=m1TonB+SrDq6p7TQWuO5JkzcR2dhjQ@mail.gmail.com>
 <202006290919.93C759C62@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202006290919.93C759C62@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 09:20:31AM -0700, Kees Cook wrote:
> On Mon, Jun 29, 2020 at 06:11:59PM +0200, Ard Biesheuvel wrote:
> > On Mon, 29 Jun 2020 at 18:09, Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Mon, Jun 29, 2020 at 10:09:28AM -0400, Arvind Sankar wrote:
> > > > Add a linker script check that there are no runtime relocations, and
> > > > remove the old one that tries to check via looking for specially-named
> > > > sections in the object files.
> > > >
> > > > Drop the tests for -fPIE compiler option and -pie linker option, as they
> > > > are available in all supported gcc and binutils versions (as well as
> > > > clang and lld).
> > > >
> > > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> > > > Reviewed-by: Fangrui Song <maskray@google.com>
> > > > ---
> > > >  arch/x86/boot/compressed/Makefile      | 28 +++-----------------------
> > > >  arch/x86/boot/compressed/vmlinux.lds.S |  8 ++++++++
> > > >  2 files changed, 11 insertions(+), 25 deletions(-)
> > >
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > >
> > > question below ...
> > >
> > > > diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> > > > index a4a4a59a2628..a78510046eec 100644
> > > > --- a/arch/x86/boot/compressed/vmlinux.lds.S
> > > > +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> > > > @@ -42,6 +42,12 @@ SECTIONS
> > > >               *(.rodata.*)
> > > >               _erodata = . ;
> > > >       }
> > > > +     .rel.dyn : {
> > > > +             *(.rel.*)
> > > > +     }
> > > > +     .rela.dyn : {
> > > > +             *(.rela.*)
> > > > +     }
> > > >       .got : {
> > > >               *(.got)
> > > >       }
> > >
> > > Should these be marked (INFO) as well?
> > >
> > 
> > Given that sections marked as (INFO) will still be emitted into the
> > ELF image, it does not really make a difference to do this for zero
> > sized sections.
> 
> Oh, I misunderstood -- I though they were _not_ emitted; I see now what
> you said was not allocated. So, disk space used for the .got.plt case,
> but not memory space used. Sorry for the confusion!
> 
> -Kees

In the case of the REL[A] and .got sections, they are actually already
not emitted at all into the ELF file now that they are zero size.

For .got.plt, it is only emitted for 32-bit (with the 3 reserved
entries), the 64-bit linker seems to get rid of it.
