Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01C1C55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 12:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A970E20656
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 12:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgD0MNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 08:13:39 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:47350 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgD0MNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 08:13:38 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id E1B151C0244; Mon, 27 Apr 2020 14:13:36 +0200 (CEST)
Date:   Mon, 27 Apr 2020 14:13:36 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Colin King <colin.king@canonical.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: trigger: remove redundant assignment to variable
 ret
Message-ID: <20200427121336.GB544@duo.ucw.cz>
References: <20200420221229.99150-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <20200420221229.99150-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2020-04-20 23:12:29, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The variable ret is being assigned with a value that is never read
> and it is being updated later with a new value. The initialization is
> redundant and can be removed.
>=20
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks, applied.
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXqbMcAAKCRAw5/Bqldv6
8o7rAKCm8ntQEIFtZ61dXMpp4NXClLfyAQCfZtfwQz4pO6W+FS3+iyVfQR//BYc=
=omzN
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
