Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C0BC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02082072D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbgCCShV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:37:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:54560 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgCCShV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 13:37:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 79D8FAD2B;
        Tue,  3 Mar 2020 18:37:19 +0000 (UTC)
Message-ID: <03fcb1e2bc7f3ff389b6dfbf3964e159a93ae835.camel@suse.de>
Subject: Re: [PATCH] ARM: dts: bcm283x: Use firmware PM driver for V3D
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Cc:     devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        wahrenst@gmx.net
Date:   Tue, 03 Mar 2020 19:37:17 +0100
In-Reply-To: <736f0c59-352b-03b2-f77f-bfc22171b3fb@i2se.com>
References: <20200303173217.3987-1-nsaenzjulienne@suse.de>
         <736f0c59-352b-03b2-f77f-bfc22171b3fb@i2se.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-tHP4KAwhH9LsysulVrwU"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tHP4KAwhH9LsysulVrwU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-03-03 at 19:17 +0100, Stefan Wahren wrote:
> Hi Nicolas,
>=20
> Am 03.03.20 um 18:32 schrieb Nicolas Saenz Julienne:
> > The register based driver turned out to be unstable, specially on RPi3a=
+
> > but not limited to it. While a fix is being worked on, we roll back to
> > using firmware based scheme.
> >=20
> > Fixes: e1dc2b2e1bef ("ARM: bcm283x: Switch V3D over to using the PM dri=
ver
> > instead of firmware")
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >=20
> > See https://github.com/raspberrypi/linux/issues/3046 for more reference=
.
> > Note: I tested this on RPi3b, RPi3a+ and RPi2b.
>=20
> as i already wrote this prevent X to start on current Raspbian on my
> Raspberry Pi 3A+ (multi_v7_defconfig, no u-boot). We must be careful here=
.
>=20
> I will take a look at the debug UART. Maybe there are more helpful
> information.

It seems we're seeing different things, I tested this on raspbian
(multi_v7_defconfig) and on arm64. I'll try again from scratch tomorrow.


--=-tHP4KAwhH9LsysulVrwU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5eo90ACgkQlfZmHno8
x/5ClAf/Y6uayh0bvAB8AF2/oSO5SZiz1HYrfdlv6YrywX0n/5HiTLxo6Lb774cF
mjqltChaF50e0bgMBPtLi6e4AMookHQ3U4c3tuRAQiuFYqjKLSMPAIg3XHNQp4Ou
QE1MRfaEtE9IgUzMWco3DNvWvY3kdpM/72D8irbh99xYLdebH/Z/Q1sNByOrgi9e
uc4hUQKrEKwlKK7T3sPIeM7O2N9tPJ65c4flgEByrqvBUQZK4mEwL5LktvT28yL7
tPWn3xWGf53oJORFG9qQ8M1943FLrn4RrRrwPq5AA+tpO3mhYYsbDt85X5ChfL2J
pWQP1x6BbFFKCbxpemYLIGiMQQcllw==
=LF3R
-----END PGP SIGNATURE-----

--=-tHP4KAwhH9LsysulVrwU--

