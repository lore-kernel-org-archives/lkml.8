Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A653C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F302084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="D0VZpxSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgCFK6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:58:02 -0500
Received: from mout.gmx.net ([212.227.17.20]:45477 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgCFK6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 05:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583492249;
        bh=NWfPkNk1bKQ/QpI/ePUTvyhDDQ+lRDCN2EPg0b6RTZI=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=D0VZpxSR3wu5NJsU95QdggYaMrWpY6BCZyb/6yyE/4BI3hyshLdfq5kPAzkISEhff
         nsKiH4iNAHM2t2G+ltKcktm1fnyr8469BX8qxy9tBUhozm8FMVTkAnZik9WvtC4K7E
         xGOSzTpYdXX0ob0YeHh1rKl4dst2PVNu1Kz3JecE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.201]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiJVG-1joTEN1gCE-00fSVa; Fri, 06
 Mar 2020 11:57:29 +0100
Date:   Fri, 6 Mar 2020 11:57:26 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] docs: Move Intel Many Integrated Core documentation
 (mic) under misc-devices
Message-ID: <20200306105726.GB2376@latitude>
References: <20200305214747.20908-1-j.neuschaefer@gmx.net>
 <CAHp75VdsP5+CGFa+rJ4goEPP1mtmCwPQSkZJ0W78CkbigJ0tQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <CAHp75VdsP5+CGFa+rJ4goEPP1mtmCwPQSkZJ0W78CkbigJ0tQw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:CR4HdQMn1zo08WkSRYyFfIuU5U7uI97U21NUGJPEk8a3BQyjPiM
 RG68wEcmhu+lEmRMHaxwW3Jb8VsTK5y4mTpdVGfJFlpNS2n/EjXGX5SYFHydHE1NcVL1jqG
 Gvq/Gf2bTN/49M0ob+XiZxBOum6Wi765nNHzCiUhb8pGBlHmYKS4DQmQv0OMb2MLx9fYm2J
 HpFDKSgIi7Jr3YgvOIy1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ap5seDaLGLM=:EusXphVV7mQ7/r3c50hA6A
 dPyhLzaMNnSkI3URt1E9wbqWNaLy3k6Ig3uwPYczypUeT/FnOdHtwf/FDfsuqLija8ybM9Rbi
 qMXNZB6nUCeFvW3eJryMIZZRl3d1Oo6HD1hE/c348uoau2RGySCwRKXvIRkQMBK3yZkE8ePR9
 8664Rh33FeFEUyGkVRIbBIqLULV2nrN4x3cvWJ961peGChOA6sKCICSLW0yjQfyFMjCoQhypd
 IxLyC2WeVJ2VKD/3Cr+98mGFW03waZAvwPgEBEEtiR8i1tbz420kcxSr77Jwxpi/QwEM1T1qw
 jUGIVlTJYMf46C3/ezse4T6N+vLGZpP5uAb3kJPgOYYlm9ESqPLM6EjHZMolKZoCabgr2hIJA
 I7rcKcpfw71cfOSLK8kjZ84kaex0K/Fll9X3WeSpHE4wjLsqfi+TDtlcLpmOgS04WpUeKuaHs
 rlWsoNdkfqAeW2pQ9eBM42pHrZ81UkJ7CzGCB06lzbdcsTsMVrY61IEkYoNGi3gXl7/tnBhAk
 NH3u93SpZMIunlShlgzbt6t2y5qRrvoPQC85G/bl/uk5jQrNKJqf3sCTw7L+oWPFuznO4cAcG
 zg/pC6b0NpuukLeNdhIng77rIWHVb9UqGqB4B3j1jVOThyt1CMA723xi3oDMb1a0oTkzTkJa8
 IYAshcQlAyD1S1EWeTw4Ae/gzcT4oGh7JYvNWOJvnD73WyD5usF6rimZOia78SsEoDCTei2S8
 Mu/2mrxinV+QQc/CneCP1sgVK060zmx8wx9aZJKbN49YSibRokJjgwjl5vta0yAVtd+mZRtq9
 lG8+92ogqlK55HqsDJT/jP9AQ2+sSHzg0hQI220eT0K4JBRVIOnDHBntGe5m9GUQ/FqJGoICk
 fT8fOnhkXQgYwbf9PnlOTO3bnxVMoxvp5NSvCtFMpUTA0zfRBRSoni8y9MoOIptIiAk4IM8VZ
 U0/xc74whyUcFgHt3LQfoM69iClhSN7Q8ylSlNlVaGePsm4AMki67qpnUnILk1kfAILQIQaAT
 2o6jFjix34QhnE9zw9iqU9fQHzg5YBuDke7oOf1rQWo+oIC+aBHaYGLQnNh9vRTtJzIvqQJm0
 lSlP+FmJgIg1lswxoHFkVR2TKprdNAC8GsbjcE21eHS/XbshsU3wYqC1VUHJbB+Wam10ig9A2
 btebfl4dC5XO618GU3LFJrK9TAXbVrRfXuqeoU/rY8KRSHhoqZRCRw8lXqnI1JqxH8vLWCXh0
 yWcammx+9oSvPsaox
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2020 at 11:39:04AM +0200, Andy Shevchenko wrote:
> On Thu, Mar 5, 2020 at 11:51 PM Jonathan Neusch=C3=A4fer
> <j.neuschaefer@gmx.net> wrote:
> >
> > It doesn't need to be a top-level chapter.
>=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5b229788d425..cb2f714b3191 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8578,7 +8578,7 @@ F:        include/uapi/linux/scif_ioctl.h
> >  F:     drivers/misc/mic/
> >  F:     drivers/dma/mic_x100_dma.c
> >  F:     drivers/dma/mic_x100_dma.h
> > -F:     Documentation/mic/
> > +F:     Documentation/misc-devices/mic/
> >
> >  INTEL PMC CORE DRIVER
> >  M:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
>=20
> Had you had a chance to run parse-maintainers.pl and see if the change
> is in order?

Since my patch doesn't change the required order, I didn't pay attention
to it.

> I think the order is broken and perhaps fixing it at the same time
> would be nice.

Indeed. I'll respin with the order fixed.


Jonathan Neusch=C3=A4fer

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl5iLI8ACgkQCDBEmo7z
X9tPeRAAktMcEWCMjHG8uAGK2x38tPfY8O8yXvX7quVUk/aii+Qog8X6qhG4sr1u
j1+sFqSxOXrgsghgPCVhMXGG1w00eHBucsRM5hyVMQUkDeE/5OpG2/smmY6QMZ57
Btx2tEOdugP6kBDl7o50kUtJemh4Lvc2NNBVw0k+pDHx7rSMzPOXfmDeioWjrGyT
sF6ZwyYCOY/PRUgC2M8cbGqHianyUeplW1cz4CwhajWUSUsrkKTXRdD+2PEpiWfU
8ZsE1kMSCNn4vRoEzC3Vl1XnOI57ToQDzUAmUV3nCeom0KZLxbkdVggh+R8Tml/i
e6tNqQrSmHv3KqIypviO4RyV0ZlX1DYhYqCXEliI2WHu7Tgz7LElEyUpo0rFeel9
vXTVDkZqHVOhTZBKa8Vhlz9H9dAaFac9YFKML9+H6ccg85GZP3YOM9SMGb+4DnPh
eWRRfOfQAtRkgvjyFo7OHszGZm15nMeKzUhaRfr8gfhuaHhF+jXpPR4Z35hF8LVC
D5u68/w5u1d2FpcqPGr9IbptGahBxYuII2XCU5yLBanS26Sk7AyNGD6qquuqAeMp
Q+1zBlcJPDtmOhIFkIdhZfUkcpdrVUxDUMRdaindEkGjoQR6g1OKkgUCUWHeGHAV
iWAAfGX9XE4cQqNzBoQo+Jt1wa3Yl1SxTk74I/2Uy1TpraGGzss=
=EnEi
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
