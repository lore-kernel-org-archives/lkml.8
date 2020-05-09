Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39284C47257
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D0B72495A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589012221;
	bh=M+rIJai8vG4s6F0AuFyKKBCsRVTD90BS9BqVDTxwFhA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ES5qHBFlYOr9R/EgZa418pV1A8dwl6HwLQ0+a+Z3hzkhayzsPKT1K0cOHKaxYZytb
	 mBCmO5g9QldbULLuaX2ohnerezaiUt/K1QS4n+tNNvfecY6Z6m0Qy16H0uOfmLw3F/
	 meWbBr/CtQ9vndpRCVLvNtE2p3Ez1M62a5eimSO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgEIIRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 04:17:00 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:63348 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgEIIQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 04:16:59 -0400
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 0498Gf3e008409;
        Sat, 9 May 2020 17:16:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 0498Gf3e008409
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1589012203;
        bh=soO6uzCEBflhcaAUsvN03dAXAWJPI4aKCk23nQk4D8s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kDhkp8ojwwX1lOdOItTUiRunon2J43+2QUFYuxZu2QDMOalyLzBU+/26QaNR7QLzI
         K1pVPQSUBlgfm1hThhkS/0XKeg0gNhJt7bcKe01StsYPjNFSYI9Pf19MPYTTzbPAhm
         u8d/TVIQsWGlUpWr9OAXewOV2dIVqcUiKtaAKNYRxm6TX09ZCKgcC/5cHmfAC8PWsQ
         VKMM1fHnPuS8exK9ZqcxOKcssGdB6MVDyfNm8HYOTsEktNnOfg/5pegO0wkOgkDGy3
         nr1QGLq2czW8jyUV9uZwLuedR4/Vq6QVzadWyPkoWCjlgXA9poKaOts2pm8KK8Df8S
         r3eFpen4oyhlQ==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id z16so1563934uae.11;
        Sat, 09 May 2020 01:16:41 -0700 (PDT)
X-Gm-Message-State: AOAM533IzrxR6eRvV8ux4R4c42Thc9Ggr1H6hFfbzl36S6NQyVkpq5Hy
        P+A6uz+YDgzdwobTmJvoimZyGJPFHkS05OnTc4Y=
X-Google-Smtp-Source: ABdhPJyZmk49SYuIoqnfKQFYQUCGnWeFLQLYuiJMQ5znNNs46rw6l1Qy5IUap249/ccl6aw6JKdK9eLRO1YFA4a5p+E=
X-Received: by 2002:a9f:3e0d:: with SMTP id o13mr27528uai.25.1589012200418;
 Sat, 09 May 2020 01:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200425054659.814774-1-masahiroy@kernel.org> <CAK7LNAQk_fLFCWuFCC0NK3nxVE0bs-n7E+T-dbn14aCZVg_pgQ@mail.gmail.com>
 <20200508214650.GA3482@ls3530.fritz.box>
In-Reply-To: <20200508214650.GA3482@ls3530.fritz.box>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 9 May 2020 17:16:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS0PVA7stUE9nmOuiP=MfPGDp1u-QDzfpk7Juq-JFehVw@mail.gmail.com>
Message-ID: <CAK7LNAS0PVA7stUE9nmOuiP=MfPGDp1u-QDzfpk7Juq-JFehVw@mail.gmail.com>
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

On Sat, May 9, 2020 at 6:46 AM Helge Deller <deller@gmx.de> wrote:
>
> * Masahiro Yamada <masahiroy@kernel.org>:
> > On Sat, Apr 25, 2020 at 2:47 PM Masahiro Yamada <masahiroy@kernel.org> =
wrote:
> > >
> > > 'make ARCH=3Dparisc clean' emits a tons of error messages as follows:
> > >
> > >   $ make ARCH=3Dparisc clean
> > >   gcc: error: unrecognized command line option '-mno-space-regs'
> > >   gcc: error: unrecognized command line option '-mfast-indirect-calls=
'; did you mean '-mforce-indirect-call'?
> > >   gcc: error: unrecognized command line option '-mdisable-fpregs'
> > >   gcc: error: missing argument to '-Wframe-larger-than=3D'
> > >   gcc: error: unrecognized command line option '-mno-space-regs'
> > >   gcc: error: unrecognized command line option '-mfast-indirect-calls=
'; did you mean '-mforce-indirect-call'?
> > >   gcc: error: unrecognized command line option '-mdisable-fpregs'
> > >   gcc: error: missing argument to '-Wframe-larger-than=3D'
> > >     ...
> > >
> > > You can supporess them except '-Wframe-larger-than' by setting correc=
t
> > > CROSS_COMPILE=3D, but we should not require any compiler for cleaning=
.
> > >
> > > This $(shell ...) is evaluated so many times because LIBGCC is export=
ed.
> > > Use the ':=3D' operator to evaluate it just once, and sink the stderr=
.
> > >
> >
> > Applied to linux-kbuild.
>
> That patch breaks then building the boot loader/compressor:
> ...
>   hppa-linux-gnu-ld    -X -e startup --as-needed -T arch/parisc/boot/comp=
ressed/vmlinux.lds arch/parisc/boot/compressed/head.o arch/parisc/boot/comp=
ressed/real2.o arch/parisc/boot/compressed/firmware.o arch/parisc/boot/comp=
ressed/misc.o arch/parisc/boot/compressed/piggy.o -o arch/parisc/boot/compr=
essed/vmlinux
> hppa-linux-gnu-ld: arch/parisc/boot/compressed/misc.o: in function `dec_v=
li':
> (.text+0x104): undefined reference to `__ashldi3'
> hppa-linux-gnu-ld: arch/parisc/boot/compressed/misc.o: in function `lzma_=
len':
> (.text+0x2b0): undefined reference to `$$mulI'
> hppa-linux-gnu-ld: (.text+0x344): undefined reference to `$$mulI'
> hppa-linux-gnu-ld: (.text+0x3f8): undefined reference to `$$mulI'
>
>
> The patch below works, but I wonder if it's possible to avoid
> to examine LIBGCC twice....?
>
> Helge


Sorry for the breakage.

How about moving LIBGCC below ?




diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
index d82787da43cd..6b37aa37a365 100644
--- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -21,8 +21,6 @@ KBUILD_IMAGE :=3D vmlinuz

 NM             =3D sh $(srctree)/arch/parisc/nm
 CHECKFLAGS     +=3D -D__hppa__=3D1
-LIBGCC         :=3D $(shell $(CC) $(KBUILD_CFLAGS)
-print-libgcc-file-name 2>/dev/null)
-export LIBGCC

 ifdef CONFIG_64BIT
 UTS_MACHINE    :=3D parisc64
@@ -114,6 +112,10 @@ KBUILD_CFLAGS      +=3D $(cflags-y)
 kernel-y                       :=3D mm/ kernel/ math-emu/

 core-y +=3D $(addprefix arch/parisc/, $(kernel-y))
+
+LIBGCC :=3D $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name 2>/dev/=
null)
+export LIBGCC
+
 libs-y +=3D arch/parisc/lib/ $(LIBGCC)

 drivers-$(CONFIG_OPROFILE)             +=3D arch/parisc/oprofile/













>
> diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
> index 628cd8bb7ad8..aeea20abbf01 100644
> --- a/arch/parisc/Makefile
> +++ b/arch/parisc/Makefile
> @@ -21,8 +21,7 @@ KBUILD_IMAGE :=3D vmlinuz
>
>  NM             =3D sh $(srctree)/arch/parisc/nm
>  CHECKFLAGS     +=3D -D__hppa__=3D1
> -LIBGCC         =3D $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-nam=
e)
> -export LIBGCC
> +LIBGCC         :=3D $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-na=
me)
>
>  ifdef CONFIG_64BIT
>  UTS_MACHINE    :=3D parisc64
> diff --git a/arch/parisc/boot/compressed/Makefile b/arch/parisc/boot/comp=
ressed/Makefile
> index 1e5879c6a752..b008cf1b5c1e 100644
> --- a/arch/parisc/boot/compressed/Makefile
> +++ b/arch/parisc/boot/compressed/Makefile
> @@ -22,6 +22,8 @@ ifndef CONFIG_64BIT
>  KBUILD_CFLAGS +=3D -mfast-indirect-calls
>  endif
>
> +LIBGCC  :=3D $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
> +
>  OBJECTS +=3D $(obj)/head.o $(obj)/real2.o $(obj)/firmware.o $(obj)/misc.=
o $(obj)/piggy.o
>
>  LDFLAGS_vmlinux :=3D -X -e startup --as-needed -T



--=20
Best Regards
Masahiro Yamada
