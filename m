Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACE2C2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31AA3206F2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgC0M6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 08:58:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:46202 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgC0M6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 08:58:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7D2E6AC1D;
        Fri, 27 Mar 2020 12:58:22 +0000 (UTC)
Message-ID: <7b3f1bb70dd232a09851789fdaa5d7de957c9294.camel@suse.de>
Subject: Re: [PATCH] ARM: dts: bcm283x: Use firmware PM driver for V3D
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>
Cc:     wahrenst@gmx.net, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 Mar 2020 13:58:20 +0100
In-Reply-To: <20200303173217.3987-1-nsaenzjulienne@suse.de>
References: <20200303173217.3987-1-nsaenzjulienne@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-sr8I0z5hMln8enfhNN+B"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sr8I0z5hMln8enfhNN+B
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-03-03 at 18:32 +0100, Nicolas Saenz Julienne wrote:
> The register based driver turned out to be unstable, specially on RPi3a+
> but not limited to it. While a fix is being worked on, we roll back to
> using firmware based scheme.
>=20
> Fixes: e1dc2b2e1bef ("ARM: bcm283x: Switch V3D over to using the PM drive=
r
> instead of firmware")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---

Applied for-next.

Regards,
Nicolas


--=-sr8I0z5hMln8enfhNN+B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl59+GwACgkQlfZmHno8
x/5IZAf+Jssc7zy9oVNz9NTe7OmnW+X4UFITXiDV15LXlQWZ+vYugWzUMnIsEMI+
sIAy/LJlkVWDb6F0vhl5eUif4e1ESSBQv7oMSSWQPZMff/Te4KC6a4JvrgFaFoke
N+PPj1mfQsFAEdCt3wpBu5DBk2G8C/XQJWdNyitc0N5s2GHjREZdi2m61fLnUgKq
BCRCLAo3HJ9kJYX4qwA0o8e83y0zdVF7/s5BvA4QbINxlRiYejqxQK6mTSc5VOM7
MpCiTYjQVEXFJbDtrc+Pl6RoT9zSt7mJ/iaV7dNweASW0s+qGmJyW11QpRfKRQzl
AKo+l+GxgdBcmWN9rnZ2MY+yqP1ZMA==
=Jnbv
-----END PGP SIGNATURE-----

--=-sr8I0z5hMln8enfhNN+B--

