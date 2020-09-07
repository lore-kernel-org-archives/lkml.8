Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E93C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AF8720738
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbgIGSVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 14:21:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:54328 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728867AbgIGSV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 14:21:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 41EB1ABC4;
        Mon,  7 Sep 2020 18:21:28 +0000 (UTC)
Message-ID: <d2a344c2ffd38152d206d8c49ff519d4cc0ebbb3.camel@suse.de>
Subject: Re: [PATCH v5 00/80] drm/vc4: Support BCM2711 Display Pipeline
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Maxime Ripard <maxime@cerno.tech>, Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>, devicetree@vger.kernel.org,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Mon, 07 Sep 2020 20:21:25 +0200
In-Reply-To: <20200907162232.kfkskjuytfr7dyef@gilmour.lan>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
         <20200907162232.kfkskjuytfr7dyef@gilmour.lan>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-6L8guC3lDLUqPbUr6fSR"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6L8guC3lDLUqPbUr6fSR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On Mon, 2020-09-07 at 18:22 +0200, Maxime Ripard wrote:
> Hi,
>=20
> On Thu, Sep 03, 2020 at 10:00:32AM +0200, Maxime Ripard wrote:
> > Hi everyone,
> >=20
> > Here's a (pretty long) series to introduce support in the VC4 DRM drive=
r
> > for the display pipeline found in the BCM2711 (and thus the RaspberryPi=
 4).
> >=20
> > The main differences are that there's two HDMI controllers and that the=
re's
> > more pixelvalve now. Those pixelvalve come with a mux in the HVS that s=
till
> > have only 3 FIFOs. Both of those differences are breaking a bunch of
> > expectations in the driver, so we first need a good bunch of cleanup an=
d
> > reworks to introduce support for the new controllers.
> >=20
> > Similarly, the HDMI controller has all its registers shuffled and split=
 in
> > multiple controllers now, so we need a bunch of changes to support this=
 as
> > well.
> >=20
> > Only the HDMI support is enabled for now (even though the DPI and DSI
> > outputs have been tested too).
>=20
> I've applied the patches 1-79 to drm-misc. I guess the final DT patch
> should go through the arm-soc tree?

I'll take care of it tomorrow.

Regards,
Nicolas


--=-6L8guC3lDLUqPbUr6fSR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl9WeiUACgkQlfZmHno8
x/4UyAf/dt+SI/8MNNE3iGPcEq4wiASX9vH8Hmce1FWMw6HaJbqDiyKW8RCr2rM5
XnDk/ekvzlwycIOkqwbnBOgETHs8Tn885jjA3i3gV9g62dB7ZCnyNRguRLoGftFO
iELFYgoiAtlJtR2r2eDeYZOaSLSoxMILSBF3CTEmldCleaSdBDrCIog3vHvXVpFa
1SPcP2e6j/pH4D0RhuabxSAN20WBJ9rHkwR5kL1+rbsKHIJufPnKdYC+q2xrSy3q
fF11Vx6oD1KNHIC0Eq0UmCCh4PVDbXMmV39S4OzbeuS9x8tgcRs8V3pA7cN5I2c3
5Fg3C7xN5Wp8cHaXm66xIZ0dVS4mCg==
=1K25
-----END PGP SIGNATURE-----

--=-6L8guC3lDLUqPbUr6fSR--

