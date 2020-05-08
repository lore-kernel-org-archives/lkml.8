Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4D0C54E49
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FBAA21655
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="i85kVSAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgEHVrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 17:47:01 -0400
Received: from mout.gmx.net ([212.227.17.22]:43651 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727095AbgEHVrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 17:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588974413;
        bh=9l39QLxBV07/J5gh9iXCiy4mZv1+0EQ1bUM0oRzFTRs=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=i85kVSAFeI9TqAhgaKvN4EXDgiZEwbcJi0rZesppDhlyngMDiMZELSsG03OUovYWb
         wH8+3UFmVB4xEhCRN2hV0qkxm0nnq9OvJPjNzHk9ymovz+Byk28dZx1LpbARM2+IqA
         ItvUz8oM5GPk7cvX7u7sQACVs7EcVujMr5P66nr4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.155.246]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Md6Mt-1iy6ve0MoF-00aFkr; Fri, 08
 May 2020 23:46:53 +0200
Date:   Fri, 8 May 2020 23:46:50 +0200
From:   Helge Deller <deller@gmx.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] parisc: suppress error messages for 'make clean'
Message-ID: <20200508214650.GA3482@ls3530.fritz.box>
References: <20200425054659.814774-1-masahiroy@kernel.org>
 <CAK7LNAQk_fLFCWuFCC0NK3nxVE0bs-n7E+T-dbn14aCZVg_pgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQk_fLFCWuFCC0NK3nxVE0bs-n7E+T-dbn14aCZVg_pgQ@mail.gmail.com>
X-Provags-ID: V03:K1:b4LN4xIqIoKPljC/0GVhOUeX9HKqEyRmw9NmuAtFs/Yoje0ccJ6
 MVEqmYROtfi81dS+rIHz+sD8r1yrS4RiJ8GC2NMNkpBPUum4d4QF5cd+0JyPvT6DkYRW3/y
 77eEVwhkRLS4F3KmpnyoWcXx4ByL18VWFKpbeECGTlj0Z2BQkNjz1eZ6LK074Ho63H+V56M
 jFi78s5HV7+hhmyGj5/vA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q1r0pOGg+RM=:waxsjIwMvlGmvXhJ4l+DV5
 kpXupI03CbJVPslAS8pcu0dLQZwss9xNMpVYYJjlJTGEVxBcbHLZZBveNBw89/O7HwKAjyrUT
 HHqJTmt5kmc/s9nxYME7rm6ozoGrIKLBD7iIOC0NdVrQK75XDp8bJ3nEYkDWjqDGwSgpVeI9X
 HeU7Buzmyfgnipf7zNjugD65byEKu3damdNQkqyRcopt1I/Y+4W6xN5YyfxkZwcg6psoe7OO6
 6KAfhzPaYsILBgE6JDk9jR1Xo/htPr6Wuz0eRL5ljzK82CjkOAomsL2N2neizEfzKNUtDUaz/
 bld7g4YISjD/59IMamQ+vL4y2QitOP3QB27cRP/Cj2dQMqy4HlYOewA3GnGnHihJUzqDOyj+J
 Es7wvsTr32x1VvY5PYs0e0uwvz2E0rpFYw9s96QEnI+UxG2rpLk8Ku5fvpuheXbkubOAdd8QP
 CnblzhkVNZN2bFNxvAeizZ6bF+cF1bncy3iM7bIXMgiSfBjRHVpY63XWugm1vyi0O0rDkV4z0
 wlx7yAInR9HmIfHH+6zaJe3je4yTcJ1F0lLkeIqbdRAKCvZ2usdxhT87O/eH+dWLc9lwT8cJo
 8s7arBHX9hnMNyBynsdlC2Ju63+e/JsTBCvBSGUH8wf0G7OUIfEkCfhhnK9L65qhtGPqaErS8
 +JKdZ8apdHk2OLURzRe2LePEDYqe0LeLaTdrZnk5sKkhd+tORnK7dPKXQ+W22FvKfXnC9lU0Q
 QNtMrzHJX3AP21pdwlSkvBzlRHhTx7SlWRnUpIADZ9gGC8sZJtkWI1RP9vHp0EMUCy8ilIlij
 DfQxMnf3zPQF/cFNwfZwAjEXIWK0KanCbbOL7jz7aorWbsT1ayDlXw+qErO1XOVQOPiVnaPdf
 /d9ggodqFs0gesmnEgiEFWHaQnmZ1G8hAPxrfjuX3VdQzVvWvvjcEiOnJeMqqEcslSAcpTKBf
 qNshvHblkadDVq5BtU2an922+jTwbvw5Kkq3TDXHK5nKXnXVSt/HsIVZqHJ3Gp6OuRHaZDw+g
 q6e2Ypfqe74oneVz543BAhwWWTaXDqsTIFWaZYecesev+JS9uYt/u5gRNyBMVft+vUuxCsHNO
 emqz5Ax+Snf9ST1MFkg0/q4wlZDgYG1MlH5KXYEzptQ+h398KIr178IkNDOck5SrRKp7ygXkq
 kILszuraAzqjNnyj6zH8PJl57YZxyx1reoYpmQiyb8Jgnrhjl52CjT6lWKxyVyuvReBTTpGWN
 uolU2wV37J6sYtR9h
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Masahiro Yamada <masahiroy@kernel.org>:
> On Sat, Apr 25, 2020 at 2:47 PM Masahiro Yamada <masahiroy@kernel.org> w=
rote:
> >
> > 'make ARCH=3Dparisc clean' emits a tons of error messages as follows:
> >
> >   $ make ARCH=3Dparisc clean
> >   gcc: error: unrecognized command line option '-mno-space-regs'
> >   gcc: error: unrecognized command line option '-mfast-indirect-calls'=
; did you mean '-mforce-indirect-call'?
> >   gcc: error: unrecognized command line option '-mdisable-fpregs'
> >   gcc: error: missing argument to '-Wframe-larger-than=3D'
> >   gcc: error: unrecognized command line option '-mno-space-regs'
> >   gcc: error: unrecognized command line option '-mfast-indirect-calls'=
; did you mean '-mforce-indirect-call'?
> >   gcc: error: unrecognized command line option '-mdisable-fpregs'
> >   gcc: error: missing argument to '-Wframe-larger-than=3D'
> >     ...
> >
> > You can supporess them except '-Wframe-larger-than' by setting correct
> > CROSS_COMPILE=3D, but we should not require any compiler for cleaning.
> >
> > This $(shell ...) is evaluated so many times because LIBGCC is exporte=
d.
> > Use the ':=3D' operator to evaluate it just once, and sink the stderr.
> >
>
> Applied to linux-kbuild.

That patch breaks then building the boot loader/compressor:
...
  hppa-linux-gnu-ld    -X -e startup --as-needed -T arch/parisc/boot/compr=
essed/vmlinux.lds arch/parisc/boot/compressed/head.o arch/parisc/boot/comp=
ressed/real2.o arch/parisc/boot/compressed/firmware.o arch/parisc/boot/com=
pressed/misc.o arch/parisc/boot/compressed/piggy.o -o arch/parisc/boot/com=
pressed/vmlinux
hppa-linux-gnu-ld: arch/parisc/boot/compressed/misc.o: in function `dec_vl=
i':
(.text+0x104): undefined reference to `__ashldi3'
hppa-linux-gnu-ld: arch/parisc/boot/compressed/misc.o: in function `lzma_l=
en':
(.text+0x2b0): undefined reference to `$$mulI'
hppa-linux-gnu-ld: (.text+0x344): undefined reference to `$$mulI'
hppa-linux-gnu-ld: (.text+0x3f8): undefined reference to `$$mulI'


The patch below works, but I wonder if it's possible to avoid
to examine LIBGCC twice....?

Helge


diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
index 628cd8bb7ad8..aeea20abbf01 100644
=2D-- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -21,8 +21,7 @@ KBUILD_IMAGE :=3D vmlinuz

 NM		=3D sh $(srctree)/arch/parisc/nm
 CHECKFLAGS	+=3D -D__hppa__=3D1
-LIBGCC		=3D $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
-export LIBGCC
+LIBGCC		:=3D $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)

 ifdef CONFIG_64BIT
 UTS_MACHINE	:=3D parisc64
diff --git a/arch/parisc/boot/compressed/Makefile b/arch/parisc/boot/compr=
essed/Makefile
index 1e5879c6a752..b008cf1b5c1e 100644
=2D-- a/arch/parisc/boot/compressed/Makefile
+++ b/arch/parisc/boot/compressed/Makefile
@@ -22,6 +22,8 @@ ifndef CONFIG_64BIT
 KBUILD_CFLAGS +=3D -mfast-indirect-calls
 endif

+LIBGCC  :=3D $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
+
 OBJECTS +=3D $(obj)/head.o $(obj)/real2.o $(obj)/firmware.o $(obj)/misc.o=
 $(obj)/piggy.o

 LDFLAGS_vmlinux :=3D -X -e startup --as-needed -T
