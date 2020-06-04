Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19F4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8D66206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgFDNSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 09:18:02 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:51568 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbgFDNSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 09:18:01 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 95FF41C0BD2; Thu,  4 Jun 2020 15:17:59 +0200 (CEST)
Date:   Thu, 4 Jun 2020 15:17:44 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, Rob Herring <robh@kernel.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: leds: fix macro names for pca955x
Message-ID: <20200604131744.GB7222@duo.ucw.cz>
References: <20200603091516.31907-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline
In-Reply-To: <20200603091516.31907-1-f.suligoi@asem.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2020-06-03 11:15:16, Flavio Suligoi wrote:
> The documentation reports the wrong macro names
> related to the pca9532 instead of the pca955x
>=20
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> Acked-by: Rob Herring <robh@kernel.org>

Thanks, applied.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXtj0eAAKCRAw5/Bqldv6
8vkJAJ9sKSBTC355Gt6RY0F4iPk8CNjcKQCfTkmUqMlgMHh8db7PoMQPEEr97Os=
=RVZc
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
