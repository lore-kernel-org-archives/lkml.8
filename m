Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A04C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F99A21927
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587047546;
	bh=2YXh/XKJI3YxS1o4ALaiH+LPf7d7D4uam3AFzOV80bQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=08r/UaP6d0Ocl0KaM+ynTYXAE+D6ja6Mi0ZRDpcG+8cmxueGmMl/JTqyku1FIYIgP
	 55hPAfeXKmYlITNnJYa7hwfl2wbWd0s5XkbxCorwIrZ+euPJWxLk7nTQEFuWUGZqdZ
	 86U/OeOvJy+/t65qJKpi2TEPRmojKLpYQZxysoXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438861AbgDPOcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:32:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393005AbgDPOEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:04:37 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FE5B2063A;
        Thu, 16 Apr 2020 14:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045876;
        bh=2YXh/XKJI3YxS1o4ALaiH+LPf7d7D4uam3AFzOV80bQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wsNql+K5TJYxNfJ2BkKZPxv5pVE57QGTWKEpi1WnmT83+GOehaIagRtib+9RflqBq
         9GBSjyXHxCWSk5d7R3YiUkuOQGPjSMKPqR6CJ1G1HawJoI7aUp0XBLgwUjHAwQ1Vk7
         9a3axNOyPxwZra1XjQ/ZN466RPdZTgqQmymh1Eik=
Date:   Thu, 16 Apr 2020 15:04:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Steven Price <steven.price@arm.com>
Cc:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Nishanth Menon <nm@ti.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Multiple regulators for one device [was drm/panfrost: add
 devfreq regulator support]
Message-ID: <20200416140434.GL5354@sirena.org.uk>
References: <CAJiuCcegkNGQ7j4jcT1rBpSLqG1c-nb8g0wq+Nbvt-dGj7am2Q@mail.gmail.com>
 <CAJiuCceU662o7QGJ=mmT3pzVWK7uJUN=6+NKQnZ=Cfj9c2nw7A@mail.gmail.com>
 <d6465e7e-8e05-8b7d-16bd-f40877969089@arm.com>
 <CAJiuCccv2XPLY6sjcgvvrG5a8ONYHa_xn9i-YUDKUDK5a0DY=A@mail.gmail.com>
 <CAJiuCcfa9ro1V4nBzfD48cCuHpEsLaNA5P0bb-tQ3hcWUCtpkA@mail.gmail.com>
 <000f26f4-3640-797f-c7f6-4b31a5e2669e@arm.com>
 <CAJiuCccF3tmbmMWNh0nC5WRJ1_iPdj6f1oH1zYMSue_pFrXsPQ@mail.gmail.com>
 <20200414185523.GO5412@sirena.org.uk>
 <CAJiuCce5ekAed6RF8+x_ehruCXW3900wkFNKRXN_Xo_62MPXew@mail.gmail.com>
 <5e15e7ac-1d9c-d614-8fd9-27525c88cafb@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m+jEI8cDoTn6Mu9E"
Content-Disposition: inline
In-Reply-To: <5e15e7ac-1d9c-d614-8fd9-27525c88cafb@arm.com>
X-Cookie: Tempt me with a spoon!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m+jEI8cDoTn6Mu9E
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2020 at 02:42:13PM +0100, Steven Price wrote:
> On 14/04/2020 20:16, Cl=E9ment P=E9ron wrote:

> > That's can be reworked and Panfrost can only probe regulator if there
> > is no opp-table.

> This is what I was thinking about looking at. But it may make sense inste=
ad
> to extend the regulator API to allow multiple regualtor_get() calls for a
> single device. I haven't had time to dig into how difficult this would be.

To repeat what I said before we don't actively stop this, it's just not
something that seems particularly tasteful and the warning does find
actual errors.  I definitely don't think it's a good idea to extend the
API for this.

> Ideally calling regulator_get a second time for the same device would sim=
ply
> return the same struct regulator object (with a reference count increment=
).

One of the goals with the distinct struct regulator is to make sure that
we track all the user's activity together - if we mix multiple users in
there it becomes harder to tell if something is going wrong.

--m+jEI8cDoTn6Mu9E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6YZfEACgkQJNaLcl1U
h9C/nQf/QCLo1rj6iRwBLPShJ84GFlBcvRlBij0IwxL5iMTtg6XkxiDm8/SLBixS
S1Bc/Wf6eNsaPSItFuhdGG7O7X1q8CEH4QRw7mb/GEOBOxkeSmBaYw+KGiatWVE6
wwK6H+GjDONuqkUTxsW5aOWtXdo8DHFsE+wzpJVGaaG3Dha4rnT+U9928gpNArK8
EUXfsezFxHayhWWMkb4Dq/lzlI8iXZDdLypZ8reuR20X+44sHIGlsm6OdAHg+6oM
AGal/xBKzemEoM7wqGDtcaRuEJd9FuRdKz1nAMGh0l9p4gpWljqr1oPeS4zh4D+M
3cENMO5/EQRQvTWYLgxIMLDqhdFmvw==
=8v7v
-----END PGP SIGNATURE-----

--m+jEI8cDoTn6Mu9E--
