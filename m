Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9A1C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 284882076C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbgIJIed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:34:33 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:42240 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730165AbgIJISd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:18:33 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id DEEBE1C0B7D; Thu, 10 Sep 2020 10:18:14 +0200 (CEST)
Date:   Thu, 10 Sep 2020 10:18:14 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Murphy <dmurphy@ti.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gene Chen <gene_chen@richtek.com>, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: Re: [PATCH v3 1/2] leds: mt6360: Add LED driver for MT6360
Message-ID: <20200910081814.GB28357@amd>
References: <1599474459-20853-1-git-send-email-gene.chen.richtek@gmail.com>
 <1599474459-20853-2-git-send-email-gene.chen.richtek@gmail.com>
 <CAHp75VdLDvoQicP1nLnjOiit6qjaw9n7+LuJ-J3MtaoHUOa_2g@mail.gmail.com>
 <CAE+NS35FETQ9ASJeYP=Sa8dm7ohRBcdAwUioCAnHPY2TiD4pNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
In-Reply-To: <CAE+NS35FETQ9ASJeYP=Sa8dm7ohRBcdAwUioCAnHPY2TiD4pNA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > +enum {
> > > +       MT6360_LED_ISNK1 =3D 0,
> > > +       MT6360_LED_ISNK2,
> > > +       MT6360_LED_ISNK3,
> > > +       MT6360_LED_ISNK4,
> > > +       MT6360_LED_FLASH1,
> > > +       MT6360_LED_FLASH2,
> >
> > > +       MT6360_MAX_LEDS,
> >
> > No comma for terminator entry.
> >
>=20
> ACK

Actually, that comma is fine. Its absence would be fine, too.

> > > +};
> >
> > ...
> >
> > > +#define MT6360_ISNK_MASK               0x1F
> >
> > GENMASK()

Again, that is fine.

> > > +#define FLED_TORCH_FLAG_MASK           0x0c
> >
> > > +#define FLED_STROBE_FLAG_MASK          0x03
> >
> > GENMASK()
> >
>=20
> ACK

Again, that is fine.

> > > +       return 0;
> > > +}
> > > +
> > > +static const struct of_device_id __maybe_unused mt6360_led_of_id[] =
=3D {
> > > +       { .compatible =3D "mediatek,mt6360-led", },
> >
> > > +       {},
> >
> > No need comma.
>=20
> ACK

It is also no hurting comma.

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl9Z4UUACgkQMOfwapXb+vI8xwCffPv2VNdsHIiN1JW/R8U9rVgS
wgIAn1rrY28DLYQIe3/AWsXVIEaFjfEB
=itTo
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
