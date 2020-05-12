Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112EBC2D0F7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAD47206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="oFF0FyQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgELQ2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 12:28:40 -0400
Received: from www.zeus03.de ([194.117.254.33]:41728 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbgELQ2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 12:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=grGHXFzOcmEOgtnGT2wFrXPObedM
        YHJ1N6mTKPHghV8=; b=oFF0FyQ64cCW4KDTZ9lJhJmZZEBFpMDOfD8ng8nOW5NK
        q99P2TOIQJuPcOPzQyMahnVX1iStTrBtAmFUM0liQbekANIvuE+oZFxe7nigrrY+
        byv5Z2O0SxLyyCepu2ZFbgvVUrDZxazbqkriknF2P0zs3PNp2Td/7w/1S8fqUMs=
Received: (qmail 3010121 invoked from network); 12 May 2020 18:28:37 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 May 2020 18:28:37 +0200
X-UD-Smtp-Session: l3s3148p1@LSWk9HWlaMggAwDPXw2aAE67cgFBY+HL
Date:   Tue, 12 May 2020 18:28:37 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>,
        Francisco Jerez <currojerez@riseup.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drm: encoder_slave: some updates
Message-ID: <20200512162837.GJ13516@ninjato>
References: <20200316163907.13709-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gBdJBemW82xJqIAr"
Content-Disposition: inline
In-Reply-To: <20200316163907.13709-1-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gBdJBemW82xJqIAr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2020 at 05:39:05PM +0100, Wolfram Sang wrote:
> While converting I2C users to new APIs, I found a refcounting problem in
> the encoder_slave implementation. This series fixes it and converts to
> the new API.
>=20
> Based on linux-next and only build tested.
>=20
> Wolfram Sang (2):
>   drm: encoder_slave: fix refcouting error for modules
>   drm: encoder_slave: use new I2C API
>=20
>  drivers/gpu/drm/drm_encoder_slave.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)

Is there someone I should add to the CC list maybe?


--gBdJBemW82xJqIAr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl66zrUACgkQFA3kzBSg
KbZflg//bG7+tCVZUTjQPn9mXVd8/23ASplOru+lCiIulPme15NvvkFPG6ru6f0E
cAjSQSYH31kFeAcC+bFqayCyQg59jX5g13tGY0mYSE7DSnxHUGQHULkpmEZg07SM
SAHWFWjp69DJJDYUvQ+JGQiljyQutAlp3VeJC4u3jLMnjjp0sOXANSHbo2Dv+as4
PQIYyXVwPM1cfuxNrZZaBuEBHSwsxsrlDFe3aJvgVkV5YzASJQuhM31ifqoMbLyw
xaywOs3z4b/ROGpeRzieOXJDwMyrfQX9ox5N4xmzkF6EhrQGvj7yMTvztNyiknBz
RpT0SsMjIOWpZiNOHU+FydOolTHX6dv78AYWbpoePZCp+hZgCjaghXI34+ka2IpC
qpkrivq9FzRLlNFNU599brLVCh0XEJyiSGXH5HyzcLWFeM7FWYh90tuj72qyLELI
6ttM9ym+WU/OFnmSp1NchQo5vLu2aGsCfNUbfesKIFV2bRrElARAJ88va8rLUPky
69PnQKQsR/Rwvo9WK8grDqAPYxZytP+KpYOLCHeF25GqtuqcSwXLiwjHgYmashd/
R7p055sjueYPos7dKA7sYNMFSQBvWa74b1T4yYj046K3gCviuDa7bf2V+hne6tJx
9za/nuMUOtZoDoHDN6vArwUsVPuUjcdm5nEACuAegaNcWvK4EaE=
=7/dX
-----END PGP SIGNATURE-----

--gBdJBemW82xJqIAr--
