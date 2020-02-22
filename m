Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B5BC35666
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 21:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9AD20684
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 21:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dbBlEBpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgBVVwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 16:52:20 -0500
Received: from mout.gmx.net ([212.227.15.19]:51573 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbgBVVwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 16:52:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582408310;
        bh=w+e/tYWJleQglx7TstgAgNjqwQCAcPJxlFcoV5/d/Ek=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=dbBlEBpKRpYFuePJ6faSf/juatk3GobU+f2x+KWCqycTwPbikRaWtDUv4ueeOhA5T
         Syiu2tqsd9OuhHarxTXS9CCvaOPvacTrIpR2B4DEEPiGg+v1koDKTMtY7CcGcV7GTV
         5/L22eM2W1iALvOtKe6lRF4di4jbx1gGonckNVQc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.104]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnakR-1joHMR0TsT-00jXHs; Sat, 22
 Feb 2020 22:51:50 +0100
Date:   Sat, 22 Feb 2020 22:51:48 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Tudor.Ambarus@microchip.com
Cc:     j.neuschaefer@gmx.net, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: Simplify loop in spi_nor_read_id()
Message-ID: <20200222215148.GH2031@latitude>
References: <20200218151034.24744-1-j.neuschaefer@gmx.net>
 <5604429.rq6fcmI4QA@localhost.localdomain>
 <20200221162248.GG2031@latitude>
 <5932130.I5bQ6OmJFL@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f5QefDQHtn8hx44O"
Content-Disposition: inline
In-Reply-To: <5932130.I5bQ6OmJFL@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:IfjCmwlrKhZRPeRSgwx5oH0LSS7y4f3WiTtPAA8CZTJgyRagCTy
 OAtssI1PPGY7NJtnj/oyYDDXbXPFPiZAbjx00/VvaUG+WQ3ZrLfbKypMzsH3nlUMpBhJquE
 ToUB78bCr2yx54Q91Vl1YWKMAPPRQQdiDLbqCLYu8FcuTOpjP+L4D59V5ZTE+SOBEJnHiRM
 N7q8aZNuRBUNiTmhNqj9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u+LKFOVWOhI=:9edXMQSTT74OquMcKXl6VP
 WLWDq5hfFwysIi9sKLhEFH4H24jPIVfOnBCFK1oOaEUNoJula0WUx+cCMQ2PJn2lu83pcWaix
 KR3JUHOPojKQJfm/cA8wip2yCamgalL6H1y+rSw3T/DgmLEZW2s+0SumPIWbWjSYwwbpFQGLy
 vVvb0Ch5b/eT2Ijd7sO7H0Bxr0Uqss2l8dZkpyXJBVX6R465a27tiGNabIBWPD3ercLpy9rrU
 vBDY3vPAQJr9aSOPa0C9/CneBl2Jpqvlv+3e63ODo6NzA44wp7qUG5PLxpqBT1lDS4B+UhEgJ
 uk0UfDd2y3nUeQpeELZoxtBVXpuv3nPFhque5C4+0woQWPae4Odfp7xzPNqsw2Qowprhpm+pc
 0kAcdDZ31jeIC5u3t/+EgkKuu0Hfav2QcP+BsiA4+uxid/em6kdhNoNOOjjL24QKP4/NkCin7
 +HepCHRgZZjlPpM4gUXB4xNJDAA4YCyy+0lAUBatC1VBpFn+59NyrEytWmkUoxn6YJ8qGZMbE
 dFtSefrn4v5r03JaTOd9aT2uKmUZgZQI+nAEY6mJoybQ3Jrn6raKu+De9rY7YWYiaxw+AC8eg
 CsHc+VDPhIUJId4H6syMjzyU+GwvG0ucffuJIkuZOE3501kH9JpBa3RzLsC/pPliqaRiU/kRA
 fEvrtjgfHHjHwACOFiFhCn2VtL2ZLqbgLMa5ZErZ/v4BSuUusI9qFI/SJcnMJ3yA/tbRH9B+I
 eso2MikKpSH5b51WfjJI3UabEq5ZPArDrFuH2TnVH/acfs1kB9c7a4V5sg+1iZK5CGU6rpmqZ
 gq+I4ojKQz/IatDXsEXgVDuq7T/QDyKkgxsNthycw57NycvnZlVMoYPK5zHxp2951TYgu1ine
 TcFNnuOXOwTZ1cBqP2d0n3qIdfHaWiK478RRPwF5z7F1YcLS/gZCaBK+sVUWKB4N5VhkqaOj6
 B4xql/mI3wi92DdJ1a1bqgP/UH8rZF6ebWooDe3xaRm1VRiMPvowd+qJQOmm7g13Tj1opmhKb
 r0axXCaVqQPeb6zEnqvOsiLK9lzJPQvGr1y+EgWbu0q1vuO5VGWMjlYDoaatAluTggFbZc/zK
 6Q6bY2pw5dvSac7OJLAf5g8r7svpXDcUJBOaHNO8wo4GCX9DArN08RqS5dObGQ9WST8whUMXb
 VuKwqrXkdPkoHCYNVhZ9pCtmBt3/rEg2hCLMgihZ9/KceKq3eGyf1Hjz4dJU03dphL6YH5QHK
 6/s8OGKx9viDDBftR
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f5QefDQHtn8hx44O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2020 at 04:50:37PM +0000, Tudor.Ambarus@microchip.com wrote:
> > > >         const struct flash_info *info;
>=20
> how about getting rid of this local variable? Use in the function somethi=
ng=20
> like:
>=20
>                 if (spi_nor_ids[i].id_len &&
>                     !memcmp(spi_nor_ids[i].id, id, spi_nor_ids[i].id_len)
>                     return &spi_nor_ids[i];

Looks alright. I'll do it.


Jonathan

--f5QefDQHtn8hx44O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl5RomwACgkQCDBEmo7z
X9sidA/+KODzFXuvWxA8h7iWt7fwRHNOLy8V6aH2LXuZO47xrV6uiSZaKlIzTCeB
ujAf9Y3AYVzZyOekRzS1q4+z7HWvETAKtuYgCCcYVH5kGBDFasrkce3FdyZ3UrmC
XwkemdAKKZ2v2OsRrJmZ6pY1OL15Rb3CqcSrUKyyy9gOD6dupWRuIgKaUV1VW9mX
iN6KHKFDY7uQ1vVER+nfmszzlsGom1AdSdeuQtc5i+/34ZzqpyFWEbjOBUEwCqvu
XTBvALkZylx76T/+VttVIlnY66q6SWYJVAXC+uPuDVFXcvHnyEa7yZowRBwPLn0A
d/PyRn8x1Ar1wSAVbKNjVTKYMW4b5p7azNaCG0moZT2G2C53w+iuQDKHYEZYko5P
WkhNl1nUz1B83SyCae/2kQ59ALYsF56Jpbn5u290X5yx2l4LFuv+he6G8mvZnoPV
ikzs6gkTMqdhHgZywnL6rAb0AFL2RmYj8nyyZnqQWjVJXTbBgV1z8rpqCh/8LBkv
PZky2ADuRSqAeZj346s8c8hpsLDigRsuP6MPsT4o2+51b3ULp7oqTBLosm9kWNh9
tmLVoPw43ENPc4ggITB5btYIPN2YtLZKUaTy11loX9uLgnlKHESyE43mjEPZvpe2
nbVla5UTzJNEEGU+aCcEIBDFdsY67cjE+r+5IcHdz7c34TaErEs=
=NxnP
-----END PGP SIGNATURE-----

--f5QefDQHtn8hx44O--
