Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B31C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867D120730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="UpqStN6a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgDGPuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:50:25 -0400
Received: from mout.gmx.net ([212.227.17.20]:34111 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbgDGPuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586274608;
        bh=BZI6U+33BCxOnCVdE28ab0//2fZpUYxRTZDmA4+ws5g=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=UpqStN6aLNBRWEpwqx88cN0FCsrqwqi0Oiw0dleghRLlIfGQwmfitkvVMSsigu1S+
         kFU2/kmfQ2uyGSwjYrhcoQDXdmX83YwIYKTbhVgFdfWNO0EnKo+H4woEARhzWzfU+Z
         v4os6Ofs+mJUnp8/2/Pw9DBfnzQ5e1iK99zUwUuo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from lenovo-laptop ([82.19.195.159]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MjS54-1itdXO0tFi-00kt6E; Tue, 07
 Apr 2020 17:50:08 +0200
Date:   Tue, 7 Apr 2020 16:50:05 +0100
From:   Alex Dewar <alex.dewar@gmx.co.uk>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Coccinelle: zalloc_simple: Fix patch mode for
 dma_alloc_coherent()
Message-ID: <20200407155005.rdyiu7xqss57rzhq@lenovo-laptop>
References: <20200403173011.65511-1-alex.dewar@gmx.co.uk>
 <alpine.DEB.2.21.2004062115000.10239@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2004062115000.10239@hadrien>
X-Provags-ID: V03:K1:3+/uYKcyqckCD21z5Oc92ud+jA0kA+TrKGQMzrR1eI7TLUaCYYA
 a7C1GCnuuU6+6Zqbu5xXJMNgU5wz4nW5X9OCgSCxt0Xs0S+CxLUghMWapkau4+FswwcbJ5C
 2MrWCZyxW+fpYQEy9l/H9+X54ehU9CxG3OjiJbQI8mKoMqVTVMcpZ8ftpyNzywyjiSrUyTD
 lMeVN5SdL57AXev69FA0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I4ElZ7o+piY=:PCIQOsUg9Jbxqznmt7mwxt
 +y8wZWkXIgHmHGg9aWshaEsrSyjTLCf+ssCrqG3C3alMVCsSO+SNrH7jzivlborXIA5r+zQTl
 OCvXK+ZO0G6wKiehVVHK97PGLFtx4uEPUVg2ePyBEekxJAHucyaTRfgdwogLLMvyRbeRphMwG
 HxiYv4sqMlXXTnW97aLwZR8cE0Bat0Knm7hJXoskqhFELyCtYTJyUO0MQDT3PfvP31pLT+cyI
 VYZmB9XCUTaKtDpq8Ln+iQa5/QIqhLI0BH6XVua1z4TTC84uR9Aiexz22OYUxSxrSA/mRI8gi
 8WsrdCMElSZZlT0GGldrjcXlBGfroqbB8XAPcbKIAssig64CZlseJ6pCZeLWT98AipYgIhk3/
 X59jvXPzKIjg0d7qmAd7OJfQUSCG8zWZjO5omIg7NOsZjm2k91ohTNHHyPDHs5QeCBcIh28X2
 U/PsYLsxTZHO5FsexY0VOpRc1WsA5zMEOFspryedKHMnqZA0Ur085SW5vL5ojYAtmg7nk1V09
 G9bNYYHoW9J5F+5d6sl1x50Nk4eMFnKch3jSypNrdMUsMpo6rLRAVjl1ebaWPfrUtD8VhTODo
 xhPunwOESSqn+LYUPzrdPxKTaNYkjgfBwaUGrcSryLd7X1oBjpKbp5s/guQoiaQYs2CCcpkR9
 yzEnu5MjAxvrxAGhZ/ApSiu20i0UnhivwalRqI77WWOZM0q9rWcBDDZ+26ola10A0Cd7i55Fg
 cexHNv94w0th7Va26mXq2yCV9vsLIgSHP5fhdXmp8nG/GBeYXgPrZLiNuawK/0USfvCM0SQ6W
 t0qt5dOmY1X+r34ZkOgxShTkSiLbrO5luh/RT9cfliFRwchSpxHWJnLACud4a4bKs++AwPu+s
 8QpbhpF7DSzKfu52nOPB7b/SgKFXiMI2TEoEgM8d++/XeJQ+H1hiASns9Aus/hXu/CBulVew+
 Glg//8y9N3JKKQNIND41iSCncjwTrV+++IFU33k3ErASPlo17VkAX0Xsn3kmBOAm9XaklDbCq
 E8DVbBeyy4cE58uwgyvUlEd9V3TjQXrPQha4vh49z512Pw3zYrVhVyp+OzmZUlr6GkIdv1asw
 uqddE3uxyZGOQGFgTgBcbE3sZPyObcjq1fJjqIpGfhMjVlGVuz/UOqU90deY09cbdSR3Df2f5
 isWIml7zPwIJltIxEC35ftebcmtafSZitf1JFdvdwqU54BsXZoBjuqPLlEYZelQasa7U6u8jh
 MNYYbaMeYQ9CDYf+B
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 09:15:29PM +0200, Julia Lawall wrote:
>
>
> On Fri, 3 Apr 2020, Alex Dewar wrote:
>
> > Commit dfd32cad146e ("dma-mapping: remove dma_zalloc_coherent()"), in
> > removing dma_zalloc_coherent() treewide, inadvertently removed the pat=
ch
> > rule for dma_alloc_coherent(), leaving Coccinelle unable to auto-gener=
ate
> > patches for this case. Fix this.
> >
> > Fixes: dfd32cad146e ("dma-mapping: remove dma_zalloc_coherent()")
> > CC: Luis Chamberlain <mcgrof@kernel.org>
> > Signed-off-by: Alex Dewar <alex.dewar@gmx.co.uk>
> > ---
> >  scripts/coccinelle/api/alloc/zalloc-simple.cocci | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/scripts/coccinelle/api/alloc/zalloc-simple.cocci b/script=
s/coccinelle/api/alloc/zalloc-simple.cocci
> > index 26cda3f48f01..c53aab7fe096 100644
> > --- a/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> > +++ b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> > @@ -70,6 +70,15 @@ statement S;
> >  - x =3D (T)vmalloc(E1);
> >  + x =3D (T)vzalloc(E1);
> >  |
> > +- x =3D dma_alloc_coherent(E2,E1,E3,E4);
> > ++ x =3D dma_alloc_coherent(E2,E1,E3,E4);
>
> Hi,
>
> I don't understand the above case.  The before and after code seem to be
> the same?
>
> julia

Hi,

I just wanted to flag up unnecessary calls to memset() after
dma_alloc_coherent() and I wasn't sure how to best express that, though
I'm sure there's a much cleaner way. At the moment the cocci file only
gives warnings for this case, but it would be nice to be able to
autogenerate patches too.

Best,
Alex

>
>
> > +|
> > +- x =3D (T *)dma_alloc_coherent(E2,E1,E3,E4);
> > ++ x =3D dma_alloc_coherent(E2,E1,E3,E4);
> > +|
> > +- x =3D (T)dma_alloc_coherent(E2,E1,E3,E4);
> > ++ x =3D (T)dma_alloc_coherent(E2,E1,E3,E4);
> > +|
> >  - x =3D kmalloc_node(E1,E2,E3);
> >  + x =3D kzalloc_node(E1,E2,E3);
> >  |
> > --
> > 2.26.0
> >
> >
