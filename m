Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3159CC47255
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 01:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08590208CA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 01:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589073652;
	bh=yuhY8ZjGbauzccaJgTI87W7rHwrVo+xYLPHAqEOxMr4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=w7OE1BUbgeoKL1uqhL+/V7UdCnWSVq3Dv3yEIZWhOWovKIXDfT9OlgRUh0Xk562MY
	 JG+wsOLKxcnjuz78ga8j4/xI7Hgc2j5saTPt89GKWJG3scRZHT/+uM/K2bZQS2L4m7
	 lakGNmcbUfXUvgI6jZ+Jtjc4Bv8MNDFU3HyuPbYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgEJBUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 21:20:44 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:20104 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgEJBUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 21:20:43 -0400
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 04A1KTJg029404;
        Sun, 10 May 2020 10:20:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 04A1KTJg029404
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1589073630;
        bh=/o5t3N4nMCBeluLyxjzOGU1bJMasGO1YdQigiiF8QSg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LhJxcuWSpqZV+0b2s9LjbKcpa3KCewpa0ZtiIm305FIWBm8qMcg/FN0YHBejZL31z
         19D8uu3h81Wvg49XZOHpAsJMlFi3yJ+vu09GYJ64Q4MeOpv7lGIivrIeLM/9HNSau8
         aY9bzx4LFUgvNmiVuItgQIL5ycu0l3xRVAuhHL7lhlKy0LFoP1rZDP8ORjRsN+dwoH
         WhBYxBOc0iSZnC6ucm6HP2KciA7nFdKgMkPyFI/IO9tHumd1+LoJ3ZfDOhubqO+Qer
         3Mrjm8GXOZDRy04y1hOysxXym/wnuZdQ5dvUIRcqSEJLt5Of/8lmlxoo8Ms9yJVsFc
         DnluCnq2MklHw==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id y185so3457835vsy.8;
        Sat, 09 May 2020 18:20:30 -0700 (PDT)
X-Gm-Message-State: AGi0PuYhnBePm8Ic2oI0KRncUkGh78z6/2xk7RRCiwTC4was6Ya8/HwU
        9chMF5CCJZQ6pfJpIcoDKktI+NvYLXzCtp8IQNk=
X-Google-Smtp-Source: APiQypLI4XtAyN6x18j9F00x1BSzsYqxZkl3Aq/n3v8RTjvY/kJkP/Jnl23wX0eWjIfKluY1FwXQ3PHdhmaQXFj7mfM=
X-Received: by 2002:a67:db0d:: with SMTP id z13mr6905350vsj.155.1589073628910;
 Sat, 09 May 2020 18:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200425054659.814774-1-masahiroy@kernel.org> <CAK7LNAQk_fLFCWuFCC0NK3nxVE0bs-n7E+T-dbn14aCZVg_pgQ@mail.gmail.com>
 <20200508214650.GA3482@ls3530.fritz.box> <CAK7LNAS0PVA7stUE9nmOuiP=MfPGDp1u-QDzfpk7Juq-JFehVw@mail.gmail.com>
 <20200509173925.GA30635@ls3530.fritz.box>
In-Reply-To: <20200509173925.GA30635@ls3530.fritz.box>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 10 May 2020 10:19:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR+jEzqqFJbCzfEbdnt-H4ZRpfLFA30ODfhhH=QXSk5nQ@mail.gmail.com>
Message-ID: <CAK7LNAR+jEzqqFJbCzfEbdnt-H4ZRpfLFA30ODfhhH=QXSk5nQ@mail.gmail.com>
Subject: Re: [PATCH] parisc: suppress error messages for 'make clean'
To:     Helge Deller <deller@gmx.de>
Cc:     "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helge,

On Sun, May 10, 2020 at 2:39 AM Helge Deller <deller@gmx.de> wrote:
>
> * Masahiro Yamada <masahiroy@kernel.org>:
> > Hi Helge,
> >
> > On Sat, May 9, 2020 at 6:46 AM Helge Deller <deller@gmx.de> wrote:
> > >
> > > * Masahiro Yamada <masahiroy@kernel.org>:
> > > > On Sat, Apr 25, 2020 at 2:47 PM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
> > > > >
> > > > > 'make ARCH=3Dparisc clean' emits a tons of error messages as foll=
ows:
> > > > >
> > > > >   $ make ARCH=3Dparisc clean
> > > > >   gcc: error: unrecognized command line option '-mno-space-regs'
> > > > >   gcc: error: unrecognized command line option '-mfast-indirect-c=
alls'; did you mean '-mforce-indirect-call'?
> > > > >   gcc: error: unrecognized command line option '-mdisable-fpregs'
> > > > >   gcc: error: missing argument to '-Wframe-larger-than=3D'
> > > > >   gcc: error: unrecognized command line option '-mno-space-regs'
> > > > >   gcc: error: unrecognized command line option '-mfast-indirect-c=
alls'; did you mean '-mforce-indirect-call'?
> > > > >   gcc: error: unrecognized command line option '-mdisable-fpregs'
> > > > >   gcc: error: missing argument to '-Wframe-larger-than=3D'
> > > > >     ...
> > > > >
> > > > > You can supporess them except '-Wframe-larger-than' by setting co=
rrect
> > > > > CROSS_COMPILE=3D, but we should not require any compiler for clea=
ning.
> > > > >
> > > > > This $(shell ...) is evaluated so many times because LIBGCC is ex=
ported.
> > > > > Use the ':=3D' operator to evaluate it just once, and sink the st=
derr.
> > > > >
> > > >
> > > > Applied to linux-kbuild.
> > >
> > > That patch breaks then building the boot loader/compressor:
> > > ...
> > >   hppa-linux-gnu-ld    -X -e startup --as-needed -T arch/parisc/boot/=
compressed/vmlinux.lds arch/parisc/boot/compressed/head.o arch/parisc/boot/=
compressed/real2.o arch/parisc/boot/compressed/firmware.o arch/parisc/boot/=
compressed/misc.o arch/parisc/boot/compressed/piggy.o -o arch/parisc/boot/c=
ompressed/vmlinux
> > > hppa-linux-gnu-ld: arch/parisc/boot/compressed/misc.o: in function `d=
ec_vli':
> > > (.text+0x104): undefined reference to `__ashldi3'
> > > hppa-linux-gnu-ld: arch/parisc/boot/compressed/misc.o: in function `l=
zma_len':
> > > (.text+0x2b0): undefined reference to `$$mulI'
> > > hppa-linux-gnu-ld: (.text+0x344): undefined reference to `$$mulI'
> > > hppa-linux-gnu-ld: (.text+0x3f8): undefined reference to `$$mulI'
> > >
> > >
> > > The patch below works, but I wonder if it's possible to avoid
> > > to examine LIBGCC twice....?
> > >
> > > Helge
> >
> >
> > Sorry for the breakage.
> >
> > How about moving LIBGCC below ?
>
> Good idea.
> The patch below does work for me.
> We do not need $KBUILD_CFLAGS to get the libgcc.a filename,


I not not sure about this change.


Generally speaking, the path to libgcc.a is affected
by compiler flags, especially, bit size flags,
endian flags, etc.


For example, my distro gcc is biarch for i386/x86_64.

$ gcc -print-libgcc-file-name
/usr/lib/gcc/x86_64-linux-gnu/9/libgcc.a
$ gcc -m64 -print-libgcc-file-name
/usr/lib/gcc/x86_64-linux-gnu/9/libgcc.a
$ gcc -m32 -print-libgcc-file-name
/usr/lib/gcc/x86_64-linux-gnu/9/32/libgcc.a




One real example in Linux is arch/arc/Makefile.
ARC supports both big endian and little endian.

If you drop cflags-y from line 59
of arch/arc/Makefile, vmlinux fails to link
due to endian mismatch.


I am not familiar with parisc.
Also, as it turned out,
this change is not so trivial.

I think the best approach is to leave this up to you
since you are the parisc maintainer.

I will drop this patch from my kbuild tree,
then you will apply what you think is best
to your tree.

What do you think?




> so we do not need to pipe the output to /dev/null either.
> Can you try if that works, and if yes, can you apply it?
>
> Helge
>
>
> diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
> index 628cd8bb7ad8..fadbbd010337 100644
> --- a/arch/parisc/Makefile
> +++ b/arch/parisc/Makefile
> @@ -21,8 +21,6 @@ KBUILD_IMAGE :=3D vmlinuz
>
>  NM             =3D sh $(srctree)/arch/parisc/nm
>  CHECKFLAGS     +=3D -D__hppa__=3D1
> -LIBGCC         =3D $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-nam=
e)
> -export LIBGCC
>
>  ifdef CONFIG_64BIT
>  UTS_MACHINE    :=3D parisc64
> @@ -110,6 +108,8 @@ cflags-$(CONFIG_PA8X00)             +=3D -march=3D2.0=
 -mschedule=3D8000
>  head-y                 :=3D arch/parisc/kernel/head.o
>
>  KBUILD_CFLAGS  +=3D $(cflags-y)
> +LIBGCC         :=3D $(shell $(CC) -print-libgcc-file-name)
> +export LIBGCC
>
>  kernel-y                       :=3D mm/ kernel/ math-emu/
>


--=20
Best Regards
Masahiro Yamada
