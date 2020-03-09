Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAC7C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D542253D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbgCIWt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 18:49:29 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:37754 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgCIWt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 18:49:29 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 5B0EC1C0316; Mon,  9 Mar 2020 23:49:27 +0100 (CET)
Date:   Mon, 9 Mar 2020 23:49:27 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Luca Weiss <luca@z3ntu.xyz>, linux-leds@vger.kernel.org,
        Dan Murphy <dmurphy@ti.com>, Heiko Stuebner <heiko@sntech.de>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 3/3] leds: add sgm3140 driver
Message-ID: <20200309224926.GA2917@duo.ucw.cz>
References: <20200309203558.305725-1-luca@z3ntu.xyz>
 <20200309203558.305725-4-luca@z3ntu.xyz>
 <20200309221805.GD2619@valkosipuli.retiisi.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <20200309221805.GD2619@valkosipuli.retiisi.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > +#define FLASH_TIMEOUT_DEFAULT		250000 /* 250ms */
> > +#define FLASH_MAX_TIMEOUT_DEFAULT	300000 /* 300ms */
>=20
> Add U, and you can remove the cast elsewhere.

I'll disagree here. Avoid U, avoid cast. Neither is needed.

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXmbH9gAKCRAw5/Bqldv6
8poqAJ9rNACtL9JpyMpvqirtegESYwcK8QCeN8Z00hKiQr3cmj19Hi3HDqYsp9A=
=T86U
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
