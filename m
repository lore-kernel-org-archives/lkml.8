Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6774EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 456E2206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgGVKxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:53:05 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:43056 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgGVKxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:53:04 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 9A2CE1C0BDA; Wed, 22 Jul 2020 12:53:02 +0200 (CEST)
Date:   Wed, 22 Jul 2020 12:52:47 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Johan Hovold <johan@kernel.org>
Cc:     Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 094/133] USB: serial: iuu_phoenix: fix memory
 corruption
Message-ID: <20200722105247.GA19938@duo.ucw.cz>
References: <20200720152803.732195882@linuxfoundation.org>
 <20200720152808.264804020@linuxfoundation.org>
 <20200721113259.GB17778@duo.ucw.cz>
 <20200721115449.GE3634@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20200721115449.GE3634@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > commit e7b931bee739e8a77ae216e613d3b99342b6dec0 upstream.
> > >=20
> > > The driver would happily overwrite its write buffer with user data in
> > > 256 byte increments due to a removed buffer-space sanity check.
> >=20
> > > +++ b/drivers/usb/serial/iuu_phoenix.c
> > > @@ -697,14 +697,16 @@ static int iuu_uart_write(struct tty_str
> > >  	struct iuu_private *priv =3D usb_get_serial_port_data(port);
> > >  	unsigned long flags;
> > > =20
> > > -	if (count > 256)
> > > -		return -ENOMEM;
> > > -
> > >  	spin_lock_irqsave(&priv->lock, flags);
> > > =20
> > > +	count =3D min(count, 256 - priv->writelen);
> > > +	if (count =3D=3D 0)
> > > +		goto out;
> > > +
> > >  	/* fill the buffer */
> > >  	memcpy(priv->writebuf + priv->writelen, buf, count);
> > >  	priv->writelen +=3D count;
> > > +out:
> > >  	spin_unlock_irqrestore(&priv->lock, flags);
> > > =20
> > >  	return count;
> >=20
> > Ok, so... goto and label is unneccessary, memcpy will do the right
> > thing with count =3D=3D 0.
>=20
> That's generally too subtle. Better to clearly mark the error/exception
> path.

We usually avoid subtle code by introducing comments, not by
introducing extra (and confusing) code that can not be optimized out.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXxgafwAKCRAw5/Bqldv6
8qu/AJ449a0kwPR+rFOa26YCeoKPd5NojQCgoXUShrwTAPQZj8w5iUht1XshuNI=
=r5MQ
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
