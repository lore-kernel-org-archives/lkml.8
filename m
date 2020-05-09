Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625D7C47257
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 17:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 455E820A8B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 17:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="MEfS6hr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgEIRjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 13:39:41 -0400
Received: from mout.gmx.net ([212.227.15.18]:55435 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbgEIRjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 13:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589045967;
        bh=5Na8YxJhPBBVFX7/f9ixlEVkKOYhJWLOj2uO2rcfXaM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=MEfS6hr+BLhvGyv6eKPdXolY1UMlZVpRUU2ew5PCjCXBFRcmlwPIVVPj3C5XQ4DwH
         Nzstf3iKsZ0BOPbfRchXuR80mRLU/Pjs1edaz/WXo/VKancWfTdyrO3xZw9Jc/l58V
         ofvpzQsXW/diNy/ChUUL9Vzir5LyShgusI/gqTsI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.180.101]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUXpK-1jgAbn2AcK-00QVD4; Sat, 09
 May 2020 19:39:27 +0200
Date:   Sat, 9 May 2020 19:39:25 +0200
From:   Helge Deller <deller@gmx.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Helge Deller <deller@gmx.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] parisc: suppress error messages for 'make clean'
Message-ID: <20200509173925.GA30635@ls3530.fritz.box>
References: <20200425054659.814774-1-masahiroy@kernel.org>
 <CAK7LNAQk_fLFCWuFCC0NK3nxVE0bs-n7E+T-dbn14aCZVg_pgQ@mail.gmail.com>
 <20200508214650.GA3482@ls3530.fritz.box>
 <CAK7LNAS0PVA7stUE9nmOuiP=MfPGDp1u-QDzfpk7Juq-JFehVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAS0PVA7stUE9nmOuiP=MfPGDp1u-QDzfpk7Juq-JFehVw@mail.gmail.com>
X-Provags-ID: V03:K1:tGaT+acMXMXyn+KuOYDABqomMWlLft370X1ncEndOP1JFXu86Wk
 PH3OEs0PuRcCRPF5U+zz5/fzbnoAvKbj880QmenyImeDvcz1h9sRTRi5wiVXh6oBhOrpXGZ
 ws5LjJksw7mFkJt4SF8jtX/ZZHIPJeJ2Vz1hO02d26oZqqEnl6UkJR373q7KkXPhTnHKBKv
 6Uwsy71W0ojEwMswKC/6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B84dymr/0Fo=:C+HdP9OqoUNac0GfuV3FTD
 /0aib+vEZMQ/+Wja7cqH7jYIZ4o3cOSwTkWPX0X+RuCy+RA8LvqWpdK9wor4w4MUBy1XsKw7O
 q3k7edDrDDH4NXdFTF/vkROIrhKz/mVwuMlpe5Aod67xW9OfEEDi2hSEav6VUo991jnfd5ZR4
 8NRc6m7djBD9xjlrlGprU6RBoRm8BwhJ9wXXueqWil+PWN8S07IpMnY4XaKALp4eB0BCRZfRW
 fXqnXZ7/PArXgkh6cENpW/TITIKEoZFqfggfX75CpF21nllPsxNZFkXEaE+OiebujPrKCEQjV
 noZhdHkOZqIPmpolvjik5vMFx7RWi3P7cG07p214b6KRpJWtIE1nIdvSskT5GsVfiy0ilv/oG
 YqBUB5UpGdI/K5V15YdEvvDMuKfYBTn8+f8PuRXxsuNmCuCz3nHEXXZpvfcptEA7BSPTzBMZl
 gJnL66asI9jqAMOtYKQbCmk2NljKHVNb5kNb4yPJTQkBMISycnMVWKQ/N3SJNxnIznSH2+PeB
 DZSupbKDPYUXVv8DvOKe0GbVa6ZIz5pCsxUcWrPhdwn+hGTrLhiiJGvGHhJ1AchgFJE62FDUN
 w3PC9JjwmXGZwHB7EWx2btwcMnb4J6l2RLx7uyoOXvOlGdoyLpzN3ngyzG7p1PbIW8qrnNj9W
 zhiWzUtndxD6yN+6b7Irpfjf2+6dtJ4gfpLkAFIdLZp5GsYYZl/zQAjAZ0dTKYG0aaGDErehx
 VuEhDIExi3nA/UeOhx2JnMGV+AGD3/+P6fIhikXU6V6+VVbGmh2yFUVv+CcSmFwN5BRXWCkae
 CTMsLNVlLGw0tMqrkFomXLtFp/rCDdoqCCmhzae7wN5KVK6EZ3K1woTEK5L47uTNfGSkq/Ema
 QnXiMF7xdDxviEg/b/HRBWGyd1O9J46iG5JiLhOMlMrgq9GzdrtRpMCixcI5Ce5rF4mL6z/m6
 Qxcr/yEM6loyEWbcUyUF1KYH7Jg26Zgc1uOH3m5Gzl0YeDa7Ncim+KORDO3BC3iwyzBQZvS4q
 FF1OK/l/MYmBULco7vlirj/W2irAj4zSWYal8RPtJnrG8xg2XDw60pffH6YMqiE4i2q+JKK7W
 VlHKxNrq3uzhG5lIudVHESTNH3oS4bk4LlsrFNE6ZJYu4yVNPQkPq+AASSusGLJZpFDWBECYu
 LFuYNeKq6RR1IfzLhVVoGAaBr4LhKokJKRZ6rj8K1Udz+Qq6WXCDZdtsUdIl8TckSp13SvZOO
 ZuQtCadka9hPGL+E/
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Masahiro Yamada <masahiroy@kernel.org>:
> Hi Helge,
>
> On Sat, May 9, 2020 at 6:46 AM Helge Deller <deller@gmx.de> wrote:
> >
> > * Masahiro Yamada <masahiroy@kernel.org>:
> > > On Sat, Apr 25, 2020 at 2:47 PM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
> > > >
> > > > 'make ARCH=3Dparisc clean' emits a tons of error messages as follo=
ws:
> > > >
> > > >   $ make ARCH=3Dparisc clean
> > > >   gcc: error: unrecognized command line option '-mno-space-regs'
> > > >   gcc: error: unrecognized command line option '-mfast-indirect-ca=
lls'; did you mean '-mforce-indirect-call'?
> > > >   gcc: error: unrecognized command line option '-mdisable-fpregs'
> > > >   gcc: error: missing argument to '-Wframe-larger-than=3D'
> > > >   gcc: error: unrecognized command line option '-mno-space-regs'
> > > >   gcc: error: unrecognized command line option '-mfast-indirect-ca=
lls'; did you mean '-mforce-indirect-call'?
> > > >   gcc: error: unrecognized command line option '-mdisable-fpregs'
> > > >   gcc: error: missing argument to '-Wframe-larger-than=3D'
> > > >     ...
> > > >
> > > > You can supporess them except '-Wframe-larger-than' by setting cor=
rect
> > > > CROSS_COMPILE=3D, but we should not require any compiler for clean=
ing.
> > > >
> > > > This $(shell ...) is evaluated so many times because LIBGCC is exp=
orted.
> > > > Use the ':=3D' operator to evaluate it just once, and sink the std=
err.
> > > >
> > >
> > > Applied to linux-kbuild.
> >
> > That patch breaks then building the boot loader/compressor:
> > ...
> >   hppa-linux-gnu-ld    -X -e startup --as-needed -T arch/parisc/boot/c=
ompressed/vmlinux.lds arch/parisc/boot/compressed/head.o arch/parisc/boot/=
compressed/real2.o arch/parisc/boot/compressed/firmware.o arch/parisc/boot=
/compressed/misc.o arch/parisc/boot/compressed/piggy.o -o arch/parisc/boot=
/compressed/vmlinux
> > hppa-linux-gnu-ld: arch/parisc/boot/compressed/misc.o: in function `de=
c_vli':
> > (.text+0x104): undefined reference to `__ashldi3'
> > hppa-linux-gnu-ld: arch/parisc/boot/compressed/misc.o: in function `lz=
ma_len':
> > (.text+0x2b0): undefined reference to `$$mulI'
> > hppa-linux-gnu-ld: (.text+0x344): undefined reference to `$$mulI'
> > hppa-linux-gnu-ld: (.text+0x3f8): undefined reference to `$$mulI'
> >
> >
> > The patch below works, but I wonder if it's possible to avoid
> > to examine LIBGCC twice....?
> >
> > Helge
>
>
> Sorry for the breakage.
>
> How about moving LIBGCC below ?

Good idea.
The patch below does work for me.
We do not need $KBUILD_CFLAGS to get the libgcc.a filename,
so we do not need to pipe the output to /dev/null either.
Can you try if that works, and if yes, can you apply it?

Helge


diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
index 628cd8bb7ad8..fadbbd010337 100644
=2D-- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -21,8 +21,6 @@ KBUILD_IMAGE :=3D vmlinuz

 NM		=3D sh $(srctree)/arch/parisc/nm
 CHECKFLAGS	+=3D -D__hppa__=3D1
-LIBGCC		=3D $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
-export LIBGCC

 ifdef CONFIG_64BIT
 UTS_MACHINE	:=3D parisc64
@@ -110,6 +108,8 @@ cflags-$(CONFIG_PA8X00)		+=3D -march=3D2.0 -mschedule=
=3D8000
 head-y			:=3D arch/parisc/kernel/head.o

 KBUILD_CFLAGS	+=3D $(cflags-y)
+LIBGCC		:=3D $(shell $(CC) -print-libgcc-file-name)
+export LIBGCC

 kernel-y			:=3D mm/ kernel/ math-emu/

