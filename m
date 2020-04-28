Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8123C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B71772053B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgD1ImD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:42:03 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:35332 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgD1ImC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:42:02 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 872151C0263; Tue, 28 Apr 2020 10:42:00 +0200 (CEST)
Date:   Tue, 28 Apr 2020 10:41:59 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v20 03/17] leds: multicolor: Introduce a multicolor class
 definition
Message-ID: <20200428084159.GB20640@amd>
References: <20200423155524.13971-1-dmurphy@ti.com>
 <20200423155524.13971-4-dmurphy@ti.com>
 <20200425202306.GA23926@amd>
 <80e20291-0ff2-87e6-8f93-2f37f588b148@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline
In-Reply-To: <80e20291-0ff2-87e6-8f93-2f37f588b148@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>+cat /sys/class/leds/multicolor:status/multi_led_index
> >>+green blue red
> >Hmm. We should really make sure LEDs are ordered as "red green
> >blue". Yes, userspace should support any order, but...
>=20
> Ordering is not guaranteed since it is based on the DT ordering. I don't
> think we can mandate that these LEDs be put in order in the DT.
>=20
> Besides the framework and the device driver do not care what color is whe=
re
> only the user space needs to care.=A0 The FW and device driver only care =
about
> the brightness, intensity and channel.

Ok, lets keep it like this.

> >>+		offset +=3D nrchars;
> >>+	}
> >This checks for "not enough" intensities. Do we need check for "too
> >many" intensities?
>=20
> We ignore anything greater then mcled_cdev->num_colors.=A0 So if this is =
set
> to 3 we only read the first 3 values.
>=20
> So we cannot read more then what is set by the DT.

Please make it return an error if extra values are passed in.

> >>+static ssize_t multi_led_intensity_show(struct device *dev,
> >>+			      struct device_attribute *intensity_attr,
> >>+			      char *buf)
> >>+{
> >>+	struct led_classdev *led_cdev =3D dev_get_drvdata(dev);
> >>+	struct led_classdev_mc *mcled_cdev =3D lcdev_to_mccdev(led_cdev);
> >>+	int len =3D 0;
> >>+	int i;
> >>+
> >>+	for (i =3D 0; i < mcled_cdev->num_colors; i++)
> >>+		len +=3D sprintf(buf + len, "%d ",
> >>+			    mcled_cdev->multicolor_info[i].color_led_intensity);
> >>+
> >>+	len +=3D sprintf(buf + len, "%s", "\n");
> >This will result in extra " " before end of line.
> >
> >Please don't use "%s", "\n" to add single character. "\n" would be enoug=
h.
> Ack changed to just sprintf(buf + len, "\n");

Also note the extra space before end of line.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl6n7FcACgkQMOfwapXb+vKdZACeLXsQXKtIiAtVWXrLbVqG9bx9
HyMAoIjtZeQ2xZ/fsOYK/KPl/KmmnrSC
=HSyV
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
