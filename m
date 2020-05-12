Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26E8C2D0F7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 724F3206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="V/YZAt9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgELQZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 12:25:49 -0400
Received: from www.zeus03.de ([194.117.254.33]:40798 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbgELQZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 12:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=DneXZyNgduTx2SLCBr8A9YLM2Qwt
        eKTZ6HnNLlcUNt4=; b=V/YZAt9kfF1+byG7Ty1CxFTntMrWURjcLXX/5tUetQCZ
        NxvS54NB7Jx6xl6TupFApmFpv8/oy9n24w6wm4IEG6wUF4Ssg78wZa2ZStW3t2ZN
        xsIQHQgzE/NiFH7NErumXzAa/K80ujoeFnZ0BfMp72pcWk7+J7T8EORNU0czwho=
Received: (qmail 3009102 invoked from network); 12 May 2020 18:25:46 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 May 2020 18:25:46 +0200
X-UD-Smtp-Session: l3s3148p1@ufF06nWlYsggAwDPXw2aAE67cgFBY+HL
Date:   Tue, 12 May 2020 18:25:46 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-i2c@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] video: backlight: tosa_lcd: convert to use
 i2c_new_client_device()
Message-ID: <20200512162546.GG13516@ninjato>
References: <20200326210959.13111-1-wsa+renesas@sang-engineering.com>
 <20200326210959.13111-2-wsa+renesas@sang-engineering.com>
 <20200417101446.GB3737@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5UGlQXeG3ziZS81+"
Content-Disposition: inline
In-Reply-To: <20200417101446.GB3737@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5UGlQXeG3ziZS81+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2020 at 11:14:46AM +0100, Lee Jones wrote:
> On Thu, 26 Mar 2020, Wolfram Sang wrote:
>=20
> > Move away from the deprecated API and return the shiny new ERRPTR where
> > useful.
> >=20
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >  drivers/video/backlight/tosa_lcd.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> Applied, thanks.

Thanks! I don't see it in -next, though?


--5UGlQXeG3ziZS81+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl66zgoACgkQFA3kzBSg
KbYypBAAm3XnZir6qWFmr4Qj+5zgB/2ULqZE2wKu+zzkI2XF+aRrZbsYLcKdS/Vr
HFdO63UIyU+G2pm+5lxGpbusoi6UxnMJaYvxhlSLaj0PZIG4UKVnIdfRpeTiSXlG
7kV5Azbjhj1lecmgDd0vNhMMkOBDms8/UqUdjshWLl+Nq8z2z+M7MqndXzoNZIW1
mEkQ2+/Myls16BimytTzH5lSTk2LEjL+8GNfIYSj7HOvb4FHuSLg5oZSNfdIuny7
9Xrhh4C18ZZHlCVpauJu7zpuUcvwhoxUBvU1T8wIHXrVqOBUGSzfBk/3hZ1k2wiw
QtBBJZ2z2/nhYINxJ8YQdD4cwVUvTVft9iXfzNTW3o6gD+YTJnhTwjmRrQcYfZC7
Phs/lID6bgCaZDjBED4xZASvQCiDIG0g7SDQlT5sM2Viydy8y3XJvCYasDWcOaxL
zBg/pRgr3099DtdgHv4qPn5lJwz48DRYWISiiNuJmtSxDuFYavAYe8Cbt7i8KYc6
GF26HlYJh+g1h3E4EzjOmHfgm5s9tPU/Tayxni9OlgjUnPYuuWA8vqBLd6qUbP4Q
LpBt75bPUbNlD+HYzq7LwDiUdfrm/Q4WycK/VSk1Xejh4gfclg9uUjSey+oj52Rq
v7NQALUhYKWB+CHGz0w7WkZwalpZtRNA/j4yhEXEz4d0nTUaA7M=
=+eIt
-----END PGP SIGNATURE-----

--5UGlQXeG3ziZS81+--
