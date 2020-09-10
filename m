Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA559C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 12:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 929EF208FE
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 12:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730662AbgIJMgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 08:36:08 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:42638 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730692AbgIJMaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 08:30:01 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 3FBB81C0B9C; Thu, 10 Sep 2020 14:29:59 +0200 (CEST)
Date:   Thu, 10 Sep 2020 14:29:58 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     jacek.anaszewski@gmail.com, robh+dt@kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gene Chen <gene_chen@richtek.com>, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: Re: [PATCH v3 1/2] leds: mt6360: Add LED driver for MT6360
Message-ID: <20200910122958.GF7907@duo.ucw.cz>
References: <1599474459-20853-1-git-send-email-gene.chen.richtek@gmail.com>
 <1599474459-20853-2-git-send-email-gene.chen.richtek@gmail.com>
 <20200908222544.GF1005@bug>
 <CAE+NS34h9qbdHkYDYDnHGgk+9mFNTRpKEMKNEFZ+Secf6JyoZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="b8GWCKCLzrXbuNet"
Content-Disposition: inline
In-Reply-To: <CAE+NS34h9qbdHkYDYDnHGgk+9mFNTRpKEMKNEFZ+Secf6JyoZg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b8GWCKCLzrXbuNet
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > +{
> > > +     struct mt6360_led *led =3D container_of(lcdev, struct mt6360_le=
d, flash.led_cdev);
> > > +     struct mt6360_priv *priv =3D led->priv;
> > > +     u32 enable_mask =3D MT6360_TORCHEN_MASK | MT6360_FLCSEN_MASK(le=
d->led_no);
> > > +     u32 val =3D (level) ? MT6360_FLCSEN_MASK(led->led_no) : 0;
> > > +     u32 prev =3D priv->fled_torch_used, curr;
> > > +     int ret;
> > > +
> > > +     dev_dbg(lcdev->dev, "[%d] brightness %d\n", led->led_no, level);
> > > +     if (priv->fled_strobe_used) {
> > > +             dev_warn(lcdev->dev, "Please disable strobe first [%d]\=
n", priv->fled_strobe_used);
> > > +             return -EINVAL;
> > > +     }
> >
> > So... how does its userland interface look like?
> >
>=20
> 1. set FLED1 brightness
> # echo 1 > /sys/class/leds/white:flash1/flash_brightness
> 2. enable FLED1 strobe
> # echo 1 > /sys/class/leds/white:flash1/flash_strobe
> 3 . turn off FLED1 strobe (just used to gaurantee the strobe mode
> flash leds must be turned off)
> # echo 0 > /sys/class/leds/white:flash1/flash_strobe

I believe I'd preffer only exposing torch functionality in
/sys/class/leds. .. strobe can be supported using v4l2 APIs.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--b8GWCKCLzrXbuNet
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX1ocRgAKCRAw5/Bqldv6
8rt4AJ9KG5MVkOwIvtgD8oMHciHuYgq6xACgr/xJtQFK7Gi7zFnj7BU/D11YyD4=
=WnaO
-----END PGP SIGNATURE-----

--b8GWCKCLzrXbuNet--
