Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF460C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 865B220709
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599223593;
	bh=AKON/w8h1U/t9dbEFQGyokWU312ml4V6QAjW/UdmFBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H6c3PVFJlfL8yWsOjcrR2wD6oc5C9J+NiYN83lOQLMM5U8i8cBulZye5UTaTeTPAx
	 /6IKs/N3e+O472JOoEhCkAg5zRVLHRl1iHPrkqwiGWu2IUw+6U1gmCKg47IzrXQuRe
	 N5Aefeij3dK2EDguBADfYHo2EJYhhFBJfgroLPUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbgIDMqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 08:46:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729297AbgIDMqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 08:46:05 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3C6720684;
        Fri,  4 Sep 2020 12:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599223565;
        bh=AKON/w8h1U/t9dbEFQGyokWU312ml4V6QAjW/UdmFBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KWnUxlINSAXzOkAr1Iey+WUBRc/J5MZ+jZ0pL0NOhaIi+tnskOe36lyg0larnctO8
         stHizLuUKfmSTKp2Kbde4JnbMRlk8fuurcJq52FLKTLpgSu7PW4CpsL6XFlaD8AUUA
         ESuGOP971QMsp2nRyEonCbNITB77jqDmP3nhKNOs=
Date:   Fri, 4 Sep 2020 13:45:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 09/10] misc: hisi_hikey_usb: add support for Hikey 970
Message-ID: <20200904124523.GE4625@sirena.org.uk>
References: <cover.1599214329.git.mchehab+huawei@kernel.org>
 <f45f7663b694b16214604b55527f38eb9232f95b.1599214329.git.mchehab+huawei@kernel.org>
 <20200904122303.GC4625@sirena.org.uk>
 <20200904143848.535d4c13@coco.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ffoCPvUAPMgSXi6H"
Content-Disposition: inline
In-Reply-To: <20200904143848.535d4c13@coco.lan>
X-Cookie: Heisenberg might have been here.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ffoCPvUAPMgSXi6H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 04, 2020 at 02:38:48PM +0200, Mauro Carvalho Chehab wrote:
> Em Fri, 4 Sep 2020 13:23:03 +0100
> Mark Brown <broonie@kernel.org> escreveu:
>=20
> > On Fri, Sep 04, 2020 at 12:23:31PM +0200, Mauro Carvalho Chehab wrote:
> >=20
> > > +	regulator =3D devm_regulator_get_optional(&pdev->dev, "hub-vdd");
> > > +	if (IS_ERR(regulator)) {
> > > +		if (PTR_ERR(regulator) =3D=3D -EPROBE_DEFER) {
> > > +			dev_info(&pdev->dev,
> > > +				 "waiting for hub-vdd-supply to be probed\n");
> > > +			return PTR_ERR(regulator);
> > > +		}
> > > +
> > > +		/* let it fall back to regulator dummy */
> > > +		regulator =3D devm_regulator_get(&pdev->dev, "hub-vdd");
> > > +		if (IS_ERR(regulator)) {
> > > +			dev_err(&pdev->dev,
> > > +				"get hub-vdd-supply failed with error %ld\n",
> > > +				PTR_ERR(regulator));
> > > +			return PTR_ERR(regulator);
> > > +		}
> > > +	} =20

> > This seems weird - if the supply is non-optional why is the code trying
> > with devm_regulator_get_optional()?  Just use normal get directly.

> That's meant to avoid problems with EPROBE_DEFER.

Which problems and in what way does it avoid them?

> See, Hikey 970 need to initialize 4 drivers for the regulators:
> SPMI core, SPMI bus controller, MFD and regulator. This can take
> some time. So, a first call to *regulator_get() may return
> EPROBE_DEFER, specially if both regulator drivers and USB HUB
> are builtin.

This is totally normal and works fine with normal regulator_get().

> I ended doing the same as some other DRM drivers do (like adv7535).

I can't find any references to regulator_get_optional()
drivers/gpu/drm/bridge/adv7511/adv7511_drv.c?

--ffoCPvUAPMgSXi6H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9SNuIACgkQJNaLcl1U
h9CF6Qf/V2z9AZt2aQSgx9uPlNndCHEN9oj91pn/v4UIkdaKZ1YRJteTdnaCKRKA
7UzDn2HebaopkhnSTRrqCGCwYlbZBL0y2FrGuImom9O7lTaHE8YwllQhhZD4Xf0N
NOlKMBC/gOmscuDAy9kxdeGckGYalPlnSPr2f//e9/ugO519K6iTPZEktc4xybcU
FBUqwfZOUql0cH86wzDRCc13ZrhEHEbiDl10ufndu3Y9Gjl3vM7vZLek06/D6okn
+ocTbMI9c5rNfUgWry9rhFjajvXO43NJ7x5j1qWIfp8glgQ5o6Pdp1fZL9+iDJer
0qDxXsanKOMVF3LxKp3T1A/VgEZUKQ==
=tTGG
-----END PGP SIGNATURE-----

--ffoCPvUAPMgSXi6H--
