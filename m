Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C2AC2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE1620678
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="LTuBE0ye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbgDGPiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:38:03 -0400
Received: from mout.gmx.net ([212.227.17.21]:43569 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729461AbgDGPiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586273864;
        bh=g2uJ6o2iY2X8ADAqYJvN/8HKJqod4CmmvCO7oBx7mW8=;
        h=X-UI-Sender-Class:In-Reply-To:Date:Subject:From:To:Cc;
        b=LTuBE0yeI9zXcZ7sK/jkGRXRJwyeQknRnQyCCmvWtW59MowiDCBZP7HGMVedDIwHQ
         gQj9b35mpjmzxN3Rew40xOJiyzftLRzXbqr2CVWh1bIuQ6ANWMLGHQ+qDsnwjeeKCN
         JldOeKJp53RzsvWdxYIpskuxnApxzxaPQ9KA+38I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost ([82.19.195.159]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5wLT-1jOqAm3vYJ-007Vxa; Tue, 07
 Apr 2020 17:37:44 +0200
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Originaldate: Mon Apr 6, 2020 at 9:15 PM
Originalfrom: "Julia Lawall" <julia.lawall@inria.fr>
Original: =?utf-8?q?=0D=0A=0D=0AOn_Fri,_3_Apr_2020,_Alex_Dewar_wrote:
 =0D=0A=0D=0A>_?= =?utf-8?q?Commit_dfd32cad146e_("dma-mapping:_remove_dma
 =5Fzalloc=5Fcohere?= =?utf-8?q?nt()"),_in=0D=0A>_removing_dma=5Fzalloc
 =5Fcoherent()_treewide,_?= =?utf-8?q?inadvertently_removed_the_patch
 =0D=0A>_rule_for_dma=5Falloc=5Fc?=
 =?utf-8?q?oherent(),_leaving_Coccinelle_unable_to_auto-generate=0D=0A>_pa?=
 =?utf-8?q?tches_for_this_case._Fix_this.=0D=0A>=0D=0A>_Fixes:_dfd32cad146?=
 =?utf-8?q?e_("dma-mapping:_remove_dma=5Fzalloc=5Fcoherent()")=0D=0A>_CC:_?=
 =?utf-8?q?Luis_Chamberlain_<mcgrof@kernel.org>=0D=0A>_Signed-off-by:_Alex?=
 =?utf-8?q?_Dewar_<alex.dewar@gmx.co.uk>=0D=0A>_---=0D=0A>__scripts/coccin?=
 =?utf-8?q?elle/api/alloc/zalloc-simple.cocci_|_9_+++++++++=0D=0A>__1_file?=
 =?utf-8?q?_changed,_9_insertions(+)=0D=0A>=0D=0A>_diff_--git_a/scripts/co?=
 =?utf-8?q?ccinelle/api/alloc/zalloc-simple.cocci_b/scripts/coccinelle/api?=
 =?utf-8?q?/alloc/zalloc-simple.cocci=0D=0A>_index_26cda3f48f01..c53aab7fe?=
 =?utf-8?q?096_100644=0D=0A>_---_a/scripts/coccinelle/api/alloc/zalloc-sim?=
 =?utf-8?q?ple.cocci=0D=0A>_+++_b/scripts/coccinelle/api/alloc/zalloc-simp?=
 =?utf-8?q?le.cocci=0D=0A>_@@_-70,6_+70,15_@@_statement_S;=0D=0A>__-_x_=3D?=
 =?utf-8?q?_(T)vmalloc(E1);=0D=0A>__+_x_=3D_(T)vzalloc(E1);=0D=0A>__|=0D?=
 =?utf-8?q?=0A>_+-_x_=3D_dma=5Falloc=5Fcoherent(E2,E1,E3,E4);=0D=0A>_++_x_?=
 =?utf-8?q?=3D_dma=5Falloc=5Fcoherent(E2,E1,E3,E4);=0D=0A=0D=0AHi,=0D=0A?=
 =?utf-8?q?=0D=0AI_don't_understand_the_above_case.__The_before_and_after_?=
 =?utf-8?q?code_seem_to_be=0D=0Athe_same=3F=0D=0A=0D=0Ajulia=0D=0A=0D=0A?=
 =?utf-8?q?=0D=0A>_+|=0D=0A>_+-_x_=3D_(T_*)dma=5Falloc=5Fcoherent(E2,E1,E3?=
 =?utf-8?q?,E4);=0D=0A>_++_x_=3D_dma=5Falloc=5Fcoherent(E2,E1,E3,E4);=0D?=
 =?utf-8?q?=0A>_+|=0D=0A>_+-_x_=3D_(T)dma=5Falloc=5Fcoherent(E2,E1,E3,E4);?=
 =?utf-8?q?=0D=0A>_++_x_=3D_(T)dma=5Falloc=5Fcoherent(E2,E1,E3,E4);=0D=0A>?=
 =?utf-8?q?_+|=0D=0A>__-_x_=3D_kmalloc=5Fnode(E1,E2,E3);=0D=0A>__+_x_=3D_k?=
 =?utf-8?q?zalloc=5Fnode(E1,E2,E3);=0D=0A>__|=0D=0A>_--=0D=0A>_2.26.0=0D?=
 =?utf-8?q?=0A>=0D=0A>=0D=0A?=
In-Reply-To: <alpine.DEB.2.21.2004062115000.10239@hadrien>
Date:   Tue, 07 Apr 2020 16:37:42 +0100
Subject: Re: [PATCH] Coccinelle: zalloc_simple: Fix patch mode for
 dma_alloc_coherent()
From:   "Alex Dewar" <alex.dewar@gmx.co.uk>
To:     "Julia Lawall" <julia.lawall@inria.fr>
Cc:     "Luis Chamberlain" <mcgrof@kernel.org>,
        "Gilles Muller" <Gilles.Muller@lip6.fr>,
        "Nicolas Palix" <nicolas.palix@imag.fr>,
        "Michal Marek" <michal.lkml@markovi.net>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Kate Stewart" <kstewart@linuxfoundation.org>,
        "Allison Randal" <allison@lohutok.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <cocci@systeme.lip6.fr>, <linux-kernel@vger.kernel.org>
Message-Id: <C1V35KAVQM0U.2UPMSFF20IXI8@lenovo-laptop>
X-Provags-ID: V03:K1:6b18JbwaHNn7jbe+QGULh8dTApEYAid0aFKUl+XIYCkcAkpckze
 HZp71qo2DkPHAkf2WRSyPrbGhq4fg8PHZaBFhf8PHHU/f6qKHnvTcV4gKB1BwZa8miWAQwf
 G5WxGkDHB9krDp2LnN4WUeC/etgb6zgennz56YliHjoQXvEshvKugJ/pDA/DKy105SFCWWx
 NawvEpEjuC0LafzQygUXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cJyULs5tUro=:TKYfUOyY7wir/uuWmvZgBc
 tBIoyz6bqwBR3bQcdTowYpiggVbXMrehSDzYRhJZayfNz2cKzHIA2JDxOTBpHT1OQmsSvVJWP
 SYjzSaRA+Tqtff2sXBDJP9SiBCFl1Lhvf/ZFePMzFCqpFvEKeTmlb6Bv0DpuuNPf7sMMkh0UM
 3mO+ppoQC3i83ATmCjRLakE4B8TU9K7TJVE5giqyIhaFEAbmlYFJB8jLaydXBs9Q/Q60+k2AD
 G6cYjau4QIsIXMK2vqKshtnz/7S4L1TGWsWT0aT2Q1Dtc1Q8K9E4gWWN8nRdSqozR3D4hBTOj
 /V36tSzOYBLW6kpRc5gJfs2CrOazeu/ZdHnhGIWL3wI9xQM3cExFWAOndYKrYCjFGFQJ4I7pl
 58B/6VB13hx1br/1w2qL4ogqbM3hBuN08TY1vc79U4s1/JggWWhlVKUzlbvLs8vx1plkS7NN4
 VG2eoJwjncOFVbTPD/fsct46d47Sga+n6VppAPhRcWzECyLTfDsqxAcg546Je0WxF/GQ61lVr
 gFPc4e7PT/yFmxxoIpHJdvBGf0qo5Lqo0LV6Vf0NEGD3mT6czEIJCjGNQpFFSU7KhJxOLyh8M
 jUV2x9I1EMr95XAJFc5etZxRu2cK4TzAjupTC2KCIhG8V8qqsDXtKXT2ynORcVc55JUxRqTlk
 kjZOYNeY4zqA1xXz9WG+tBIz9GmhiZjjdmKJNWQoDUsIxC3Uo7COleAjeiw9W+IFJvtHekWaE
 gWPWY+2rVQdhH6RuQNpkw5vPIJt9M8NRuwbzRMXW9LYQ/9qv9dz3rfqsyMpjhsrySVDHmxRRT
 YPKanFHttiXpkgaKMnIz3PK6uo4blI0qNP8RNkuIeD56Z1e5IvKk9cEdhkGsiB8VCuYEooQ/O
 B0c4LGPiHsn9qAxidFdpLBYJpikgzayIeavr217qZ2ePe4/ge2d/LMxxurvq5BBRRvO1M/vat
 clxM7Viehp28NBhbL0F2OSJBavxfC9f+3EioeUryzwZDKmLQeEN5+cg+ieKx9jJoGoFRzCMX4
 WahCS8/TDgM9s7sP1l7RfdjuWT8TrTwavxqpq9Fd/aOiOLemPUy+ya2j5fmTQbuZTEk63ILO4
 f0JSJYNI4hmM0FyIl6kF1GneuRIt0Hf0Nvrxr4F4Evo2jwH2v3L1xY31U79BNRkrBT/aPENBm
 sCUOlbquTFDIGDUfCu4JM9Dv3+3PTRgVC9CXtkWzKEUd9HgHGCSqL1eoYm8mQJJzQAjz/pNOP
 ESx4teoSEDyTtlSvh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Apr 6, 2020 at 9:15 PM, Julia Lawall wrote:
>
>=20
>
>=20
> On Fri, 3 Apr 2020, Alex Dewar wrote:
>
>=20
> > Commit dfd32cad146e ("dma-mapping: remove dma_zalloc_coherent()"), in
> > removing dma_zalloc_coherent() treewide, inadvertently removed the patc=
h
> > rule for dma_alloc_coherent(), leaving Coccinelle unable to auto-genera=
te
> > patches for this case. Fix this.
> >
> > Fixes: dfd32cad146e ("dma-mapping: remove dma_zalloc_coherent()")
> > CC: Luis Chamberlain <mcgrof@kernel.org>
> > Signed-off-by: Alex Dewar <alex.dewar@gmx.co.uk>
> > ---
> >  scripts/coccinelle/api/alloc/zalloc-simple.cocci | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/scripts/coccinelle/api/alloc/zalloc-simple.cocci b/scripts=
/coccinelle/api/alloc/zalloc-simple.cocci
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
>=20
> Hi,
>
>=20
> I don't understand the above case. The before and after code seem to be
> the same?
>
>=20
> julia
>
>=20
>
>=20
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
>
>=20
>
>=20

