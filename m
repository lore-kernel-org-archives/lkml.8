Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91694C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 03:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F288206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 03:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="S9Ku0r6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgBLDvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 22:51:51 -0500
Received: from ozlabs.org ([203.11.71.1]:51757 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbgBLDvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 22:51:51 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
        id 48HQgN6wPvz9s29; Wed, 12 Feb 2020 14:51:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1581479504;
        bh=DZ9vUOyD6APNdhGUV5sRMQYorkTXrslBxqQ8fUxqHgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S9Ku0r6Ux1UikTOnbcC98sl3kTZKC8RxbOrlfc33FSo2RBSyXUHnfTFeWN7BpCqJ4
         kb/8E8/6xL0p30ah1pU05yTox1CR2yXUAFMH/W8Sg1hkISeOYifKDjaMYinUIHm2es
         CDM+TfqdDlKE5ont+CUwmxw3k/vbx0W169rwKk2c=
Date:   Wed, 12 Feb 2020 13:09:33 +1100
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Rob Herring <robh@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Devicetree Compiler <devicetree-compiler@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] libfdt: place new nodes & properties after the parent's
 ones
Message-ID: <20200212020933.GP22584@umbus.fritz.box>
References: <CGME20200204125854eucas1p19ace564a5f45b9231e0fba8af07009cd@eucas1p1.samsung.com>
 <20200204125844.19955-1-m.szyprowski@samsung.com>
 <20200205054508.GG60221@umbus.fritz.box>
 <bc380fd8-71bb-897e-f060-b51386dec9be@samsung.com>
 <20200210234406.GH22584@umbus.fritz.box>
 <CAL_JsqJLLWnx-K9T5wv_i+FnPwbWpfak4RD_9P1Xz_2-XkYncA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RtGa12sjXv8gVUZO"
Content-Disposition: inline
In-Reply-To: <CAL_JsqJLLWnx-K9T5wv_i+FnPwbWpfak4RD_9P1Xz_2-XkYncA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RtGa12sjXv8gVUZO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2020 at 02:29:22PM -0600, Rob Herring wrote:
> On Mon, Feb 10, 2020 at 5:44 PM David Gibson
> <david@gibson.dropbear.id.au> wrote:
> >
> > On Mon, Feb 10, 2020 at 12:40:19PM +0100, Marek Szyprowski wrote:
> > > Hi David,
> > >
> > > On 05.02.2020 06:45, David Gibson wrote:
> > > > On Tue, Feb 04, 2020 at 01:58:44PM +0100, Marek Szyprowski wrote:
> > > >> While applying dt-overlays using libfdt code, the order of the app=
lied
> > > >> properties and sub-nodes is reversed. This should not be a problem=
 in
> > > >> ideal world (mainline), but this matters for some vendor specific/=
custom
> > > >> dtb files. This can be easily fixed by the little change to libfdt=
 code:
> > > >> any new properties and sub-nodes should be added after the parent'=
s node
> > > >> properties and subnodes.
> > > >>
> > > >> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > > I'm not convinced this is a good idea.
> > > >
> > > > First, anything that relies on the order of properties or subnodes =
in
> > > > a dtb is deeply, fundamentally broken.  That can't even really be a
> > > > problem with a dtb file itself, only with the code processing it.
> > >
> > > I agree about the properties, but generally the order of nodes usually
> > > implies the order of creation of some devices or objects.
> >
> > Huh?  From the device tree client's point of view the devices just
> > exist - the order of creation should not be visible to it.
>=20
> I'm not sure if downstream is different, but upstream this stems from
> Linux initcalls being processed in link order within a given level.
> It's much better than it used to be, but short of randomizing the
> ordering, I'm not sure we'll ever find and fix all these hidden
> dependencies.

Uhh... I don't really see how that relates to device tree encoding
order.  That's another source of non-stable device identifications,
which dtb order can also be, but they're not really connected beyond
that as far as I can tell.

> > > This sometimes
> > > has some side-effects.
> >
> > If those side effects matter, your code is broken.  If you need to
> > apply an order to nodes, you should be looking at 'reg' or other
> > properties.
>=20
> The general preference is to sort by 'reg'. And we try to catch and
> reject any node re-ordering patches.
>=20
> Rob
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RtGa12sjXv8gVUZO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5DXl0ACgkQbDjKyiDZ
s5KLlxAAjyXW7V27xgExlGGyZvAGtP/5zveAVLOJVzYSFYfL0eJCnMGPxZrMgggL
PD/HXI8qocWsHtqzIZJMVr27hLx+3emh62CgaTKEBMzfBFFX7QEH7yCQ0zA/IpqW
Kz1x/hU3ZjYOrq3mbK2ILQJxGjYGX/LoLSFLXblrnQbVaf4Mpebl0f/RpRymh4bV
3kmBMVAZHqhbvP0q/epmdJbD2nf+aEh+aM2f1SL3mw3nkFOPPG1fNTbwufrHvy1V
0KkrlanZdT1n5ktCA6FxZsHX6g/XTxC2M6qjrFLqgRbj1Zp0UXKZu0niu+I4Lq3f
n3CCtev7qndQ26olWYHPip50byZM8g1oefCC5FpInyYRsSMP/ZqH4x5yfWsJBpUJ
q9YWAQGaVTas6UwkeLgmIPRwEDODZqDM8u1L22DPdk5MX4Poe0unAoqPMfRib0Jl
I6w3ylmVEccAsQ9bmzdMxeCnWbECsI1IfCDHe0TFSK0WY/9rJZEIDMv9XZU1YIQY
i3o1omMrnA6uxecoDuRaH6DTDC/3AqXOgmRWeSy9qwvZWvLNalbQfwi3xfCf4F3g
VqUPpObYvoFXt8egkbUIPhe5jjTeHCxyXTw7bKugWTpd91LRfXLemEMcpQUHC1TO
1H1hkCONspu7nHWsMvl8PmaDf1qJoaXm4o27nTHQP32tVi6DrMs=
=HAvE
-----END PGP SIGNATURE-----

--RtGa12sjXv8gVUZO--
