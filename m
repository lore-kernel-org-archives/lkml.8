Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130ABC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6778204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hSk0c1AM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbgF2Srr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbgF2Srm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:47:42 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AB6C030F10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:20:33 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bj10so2056975plb.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bmVfJADPu1Rf4BNpweJIobmBh11XdYvG31saYbh8f2A=;
        b=hSk0c1AMBltSrv0MFlxEGcT9a7odSjKO2OJZOsVk7IVAdXiahqsmRRyTe2RDOpfyoD
         eLWi3Gayo01bsT5h8X0z083tmA258K5YNdwWx5e774rxk5zFYwaRA4kJHRdEdpWKW2x4
         bhw9e5UVXTBAKIauThvNjKld6jnT21xxDT3Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bmVfJADPu1Rf4BNpweJIobmBh11XdYvG31saYbh8f2A=;
        b=PweYMWkFfVrtORlNwQZkG4Hsi5BwysZGURJNnVGYxF2ey+zhm1HqXE/d0+cjKjmmvi
         L9wuVjfNa4eACmVnSObmTi48V6xB32Qjoivt5VJCzoiP5QV+PacFnO8JDHcIsayoMsvb
         nij75FKLIGTlBIbjOasp+t4uI8NRH1DXyCOo2xoTL2D9K51Sr69WWLIjE1M968wjLyBr
         mUxJyRFNmZQJjI+mHkm4lKbM7x2UlnM/hDWIcaR4SJnIb8Kswp1WclTE4D+EJre1y7K8
         AM9auolNxKv8E9w4DWb4x00oHouyfv8WZTDVyfRpx+uBf3/z7zaxobzHv6mV9DKSEjv2
         +53A==
X-Gm-Message-State: AOAM531A6dZ1KOwk8mjmYgrIAGNAA9++gVYEv1y+xC2ekzvasQFR3FUK
        Lw1M1qN7EW1OgFNWoCLYoxu/5Q==
X-Google-Smtp-Source: ABdhPJxdY6T6YIkc52fIDIkfbZFZRf5nOE0zNSJIWoPRUElmwT4gZhLFby0kBqLvZ66cSZdAp4VOiw==
X-Received: by 2002:a17:90a:9292:: with SMTP id n18mr17806395pjo.112.1593447632977;
        Mon, 29 Jun 2020 09:20:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m2sm183486pfb.164.2020.06.29.09.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 09:20:32 -0700 (PDT)
Date:   Mon, 29 Jun 2020 09:20:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
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
Subject: Re: [PATCH v3 7/7] x86/boot: Check that there are no runtime
 relocations
Message-ID: <202006290919.93C759C62@keescook>
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200629140928.858507-8-nivedita@alum.mit.edu>
 <202006290907.E5EF18A@keescook>
 <CAMj1kXFge5aWL2BY8Y1=m1TonB+SrDq6p7TQWuO5JkzcR2dhjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFge5aWL2BY8Y1=m1TonB+SrDq6p7TQWuO5JkzcR2dhjQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 06:11:59PM +0200, Ard Biesheuvel wrote:
> On Mon, 29 Jun 2020 at 18:09, Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Jun 29, 2020 at 10:09:28AM -0400, Arvind Sankar wrote:
> > > Add a linker script check that there are no runtime relocations, and
> > > remove the old one that tries to check via looking for specially-named
> > > sections in the object files.
> > >
> > > Drop the tests for -fPIE compiler option and -pie linker option, as they
> > > are available in all supported gcc and binutils versions (as well as
> > > clang and lld).
> > >
> > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> > > Reviewed-by: Fangrui Song <maskray@google.com>
> > > ---
> > >  arch/x86/boot/compressed/Makefile      | 28 +++-----------------------
> > >  arch/x86/boot/compressed/vmlinux.lds.S |  8 ++++++++
> > >  2 files changed, 11 insertions(+), 25 deletions(-)
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> >
> > question below ...
> >
> > > diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> > > index a4a4a59a2628..a78510046eec 100644
> > > --- a/arch/x86/boot/compressed/vmlinux.lds.S
> > > +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> > > @@ -42,6 +42,12 @@ SECTIONS
> > >               *(.rodata.*)
> > >               _erodata = . ;
> > >       }
> > > +     .rel.dyn : {
> > > +             *(.rel.*)
> > > +     }
> > > +     .rela.dyn : {
> > > +             *(.rela.*)
> > > +     }
> > >       .got : {
> > >               *(.got)
> > >       }
> >
> > Should these be marked (INFO) as well?
> >
> 
> Given that sections marked as (INFO) will still be emitted into the
> ELF image, it does not really make a difference to do this for zero
> sized sections.

Oh, I misunderstood -- I though they were _not_ emitted; I see now what
you said was not allocated. So, disk space used for the .got.plt case,
but not memory space used. Sorry for the confusion!

-Kees

> 
> > > @@ -85,3 +91,5 @@ ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT en
> > >  #else
> > >  ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0xc, "Unexpected GOT/PLT entries detected!")
> > >  #endif
> > > +
> > > +ASSERT(SIZEOF(.rel.dyn) == 0 && SIZEOF(.rela.dyn) == 0, "Unexpected runtime relocations detected!")
> >
> > I think I should be doing this same ASSERT style for other explicit
> > DISCARDS in my orphan series so we'll notice if they change, instead
> > of being silently dropped if they grow.
> >

-- 
Kees Cook
