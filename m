Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A58C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 617CB2078C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591787295;
	bh=GtO9Z2fQWlJlkwPZR0qQDLQqjFBevy/f60LY5/mvLmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DH7tEh3Oo8jRTmU2DTlEx2aCuDUD5jAxPow+Dkl/9Ng6v4XW9PKh9uqSuC8qq42or
	 WZ6G3PtgXWAxKOWo9WP3B1ucmjxwWWkWt4IzjX60BP3BnDP4t8EQM9yPBYRBO8003N
	 3+AHnRpauh4vxAl12S9jw5X7BcXZqAFs0wLDPQlI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgFJLIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:08:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:32788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728298AbgFJLIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:08:13 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00743206F4;
        Wed, 10 Jun 2020 11:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591787292;
        bh=GtO9Z2fQWlJlkwPZR0qQDLQqjFBevy/f60LY5/mvLmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VJHvBXUl3ioJQiOAgUHpbiHUtJJxPObvJMIxTw/d/ldKSZPhNT1QaomsR+8T4Jhpn
         cRaqRJcP+xPhei12Q16vTObYenaC3BQ7x7Zi+HJKOBJaZ71I4AMblN3ZqRsNA74xsL
         JMFQBid0MQQQ7fFiBfOj6Wdy1+MR0M3mhVHe9qUc=
Date:   Wed, 10 Jun 2020 12:08:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: renesas,sh-msiof: Add r8a7742
 support
Message-ID: <20200610110810.GD5005@sirena.org.uk>
References: <1591736054-568-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1591736054-568-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wLAMOaPNJ0fu1fTG"
Content-Disposition: inline
In-Reply-To: <1591736054-568-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Cookie: fortune: No such file or directory
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2020 at 09:54:13PM +0100, Lad Prabhakar wrote:
> Document RZ/G1H (R8A7742) SoC bindings.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renes=
as.com>
> ---
>  Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml | 1 +
>  1 file changed, 1 insertion(+)

To repeat my previous feedback I'd expect a driver update as well.

--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7gvxkACgkQJNaLcl1U
h9D32Qf/X5Q/azyJ8kwxCwKPK7q2OsgAoWrCGEXmWtrCzKN9lNlsJKGNPM9ctmS1
4cNWCrs7jQjyPhH1QI9chm/tmAGT+Xe1DDGipVvyW/2fWRm11l48Vv6lIO5plSGA
QyJ9tQHmH0Dk51aIZuxvYWIL4k+4bK3cJfQ0MbuGK+fQFX2RDV2GTca4I4FTiSY8
lq82HJzpI+39pYY6KnHyyZCy8rDchZT7pQLJ15lI/6cyoLmb248nR2dobAuyvFKS
3ZFp+DVJhXtPlULNdgrHfoQEzZHiSrwhIy1lmhOIZYOTlGTgv5kF/BaLZE/RjlVb
sIrgNDH/TrF6mXyMm4rkw1DVN3ILag==
=qYRC
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--
