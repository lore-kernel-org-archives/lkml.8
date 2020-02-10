Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1B5C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 23:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A1B20708
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 23:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="AIlf9AZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgBJXoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 18:44:14 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:49981 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbgBJXoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 18:44:14 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
        id 48GjDC2Qn6z9sRX; Tue, 11 Feb 2020 10:44:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1581378251;
        bh=7K+kTdpfGU1z4smBOeCkzyWWjYgzO+WnbCkyrDmR7p4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AIlf9AZJ1vQff9JYuBdtBRk/crVFqUYXTGsG9OMcAs5seJrjwoszLY4HRDFIRKm2o
         JW3n0i1P3tSQfMORTkyW1exSiRw0c29BRguD/texL49oDBj4c51t18NkyH2pDVT1wG
         cMOr3hxl0pP6+I6A/FHfxln2cu/ByV7cC41AuQmI=
Date:   Tue, 11 Feb 2020 10:44:06 +1100
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     devicetree-compiler@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] libfdt: place new nodes & properties after the parent's
 ones
Message-ID: <20200210234406.GH22584@umbus.fritz.box>
References: <CGME20200204125854eucas1p19ace564a5f45b9231e0fba8af07009cd@eucas1p1.samsung.com>
 <20200204125844.19955-1-m.szyprowski@samsung.com>
 <20200205054508.GG60221@umbus.fritz.box>
 <bc380fd8-71bb-897e-f060-b51386dec9be@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jaoouwwPWoQSJZYp"
Content-Disposition: inline
In-Reply-To: <bc380fd8-71bb-897e-f060-b51386dec9be@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jaoouwwPWoQSJZYp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2020 at 12:40:19PM +0100, Marek Szyprowski wrote:
> Hi David,
>=20
> On 05.02.2020 06:45, David Gibson wrote:
> > On Tue, Feb 04, 2020 at 01:58:44PM +0100, Marek Szyprowski wrote:
> >> While applying dt-overlays using libfdt code, the order of the applied
> >> properties and sub-nodes is reversed. This should not be a problem in
> >> ideal world (mainline), but this matters for some vendor specific/cust=
om
> >> dtb files. This can be easily fixed by the little change to libfdt cod=
e:
> >> any new properties and sub-nodes should be added after the parent's no=
de
> >> properties and subnodes.
> >>
> >> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > I'm not convinced this is a good idea.
> >
> > First, anything that relies on the order of properties or subnodes in
> > a dtb is deeply, fundamentally broken.  That can't even really be a
> > problem with a dtb file itself, only with the code processing it.
>=20
> I agree about the properties, but generally the order of nodes usually=20
> implies the order of creation of some devices or objects.

Huh?  From the device tree client's point of view the devices just
exist - the order of creation should not be visible to it.

> This sometimes=20
> has some side-effects.

If those side effects matter, your code is broken.  If you need to
apply an order to nodes, you should be looking at 'reg' or other
properties.

> For comparison, the other lib used for fdt manipulation (libufdt)=20
> applies overlays in a such way, that the order of properties and nodes=20
> is not reversed.
>=20
> > I'm also concerned this could have a negative performance impact,
> > since it has to skip over a bunch of existing things before adding the
> > new one.  On the other hand, that may be offset by the fact that it
> > will reduce the amount of stuff that needs to be memmove()ed later on.
>=20
> This code is already slow (especially in the way the uboot's use it for=
=20
> 'fdt apply' command), but in practice I've didn't observe negative=20
> impact on the performance of applying large overlays at all.

I'm going to need numbers, not just "I didn't see anything".

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jaoouwwPWoQSJZYp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5B6sYACgkQbDjKyiDZ
s5IYVg//RmdG0csx2DA45UVzasqMWpkUTEDrr7pTxkDgmdvZOeC41OK5k1IifXT5
75hhxVU72PhzmC+m6ymvtrukzItSIgGKoWYdItS+Nykb7Mfs+fWYoN8uwiBLsVgM
vvdEMzcXyWqDy9+BV0H1kimyj/NJrnMAYmae00aTSR50fDtyNWOU7vgupgOlmVO1
sSIxdL/wzjORwIEE9C/g6cEOYqZcccbzaVP/jRdBpOJjyArKwVYoirQCmypCT6gI
a+btXPSNfnEuNnVnFJOHxvlybqvRhx8jjSFs3Duggb+ffMeTTKee5Yao8jzANVRw
jqiDi3sIBp3pTZzmMGierGpUdQDx6cRDJz6oYNDmJkyLCTpEva3MGiDFwnXZ9AyR
G2P/BDRjw782sDNzOPPMn8IvxMyL7zix/5+SNs9gsxZnQv/WTWj/O/LxhVXEhfSz
UXEhLnPmqD8J9tLLy+3PuQ+CpPxxx5bGNhuJbftXCiYrjSjANpjmDMdSBgm1HVkc
CbuHnPgWzOQ2eIImTN/PhtCTwOAd3Sw94gfYlC2q+9YUO1SGF/WjgAWvvf+uhVzz
Wc4jQ9Vu9XTCAdWHEJgaj5cL93Lj5KJF6zYQbuoYMNClYJbmwoyrcCfYU/LEIlja
m4cd0xAiqJet3wGoAtx19x1Yw44++MUvh/hvJpRmxropuRjXDvk=
=g4vs
-----END PGP SIGNATURE-----

--jaoouwwPWoQSJZYp--
