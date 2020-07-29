Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D30C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 13:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1824D2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 13:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="j1LzN7/s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fOth9n7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgG2NGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 09:06:42 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42405 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726449AbgG2NGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 09:06:42 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 289D95C00E5;
        Wed, 29 Jul 2020 09:06:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 29 Jul 2020 09:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=J0gkjEVatecFtNdADLnL+o/V0J0
        cfjnclX8z6uKd3cE=; b=j1LzN7/saHum3d5UzbV3Pe772Zau/6Ca/hrHqHXnnro
        /Y4Qlz6eYLjfzdR/NQ6/N9ArliQyTuRCYFZ9H07X/X8vyLq3yZT4U12JdUFEfQKd
        uN8hFVPWlgWoLQ2He5W/Ay/yCJNa6OQtrpvDYYv+yBzPafJkEF/C4k+FJqZ7GS9M
        Pfmes6SSRXXE10D8vihARbsmPZOD24yQ3D3fVvpetRs5Wvas40oUrT+rFq8I8ZBo
        j+Cf/mZ9lv3I2LU2tRmj9XLA4eICWd3unJKLDJ9wIb2jA2I8XOoxaAMewZSxGftq
        6WbL3/9VdpEqKXiAwRURyVA4r9I9O6bD0KUz+LNXW4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=J0gkjE
        VatecFtNdADLnL+o/V0J0cfjnclX8z6uKd3cE=; b=fOth9n7v8I0wpr7gQbnNiC
        A6XIlQzqjW6PMfbjFQuDWhK85aWtwQtJIi/tGRtCa17Ige0Q2RBgJn4zdym/K54y
        OLdDg3gq8dhWmE2WFw0MxpB9l3x1fVS390rY10TQsqxxv8hwXZRKp7iYWsNSpzNu
        FsyxXxLUV+GZGaQwYB7RXk+xVAZIzI7e2HZ5C5tRYlbyPUOK5OPf7agEYtnerRXW
        bwqPOmupc/3p2o5y0WuLQowkWmBRdAOu+kxaLkSoDBvzyjtACBCRWAA72lczkBn2
        KJETtTgjmmKhcvazE15c/Ry3OMNMP97bY+2y6x9lkMwdjeYQdM0lRgnyj5G4L1ww
        ==
X-ME-Sender: <xms:X3QhXyzO6kdDNevDJ3r77MkUbKK9NdFtXLErP1AiihmJ0O7bz7-S4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrieeggdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:X3QhX-RsuxTIFpLe08SocNfb8802LfOveZD799966dBizHpMCnmyww>
    <xmx:X3QhX0WNMkmIN60Q3wF8iCZTebxzNiYhZARlv6i086X9CvO8hrUeow>
    <xmx:X3QhX4iQ8esGsI6exJWlCsmXGZD0PF9VEtu3iVaQDrFJN6l4GDjL6Q>
    <xmx:YXQhX3-Jj-zE0f-dUtgltmEUYC9qKRnKRYnRucKjOfFaGRdRfd_7mg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0612E3280065;
        Wed, 29 Jul 2020 09:06:38 -0400 (EDT)
Date:   Wed, 29 Jul 2020 15:06:37 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Frank Lee <frank@allwinnertech.com>, robh+dt@kernel.org,
        wens@csie.org, tiny.windzz@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: gpio: =?utf-8?Q?sunxi=EF=BC=9Acreat?=
 =?utf-8?Q?e?= a DT header for Allwinner pin controller
Message-ID: <20200729130637.5md3tr6zg7s4wrmh@gilmour.lan>
References: <20200715115412.2544-1-frank@allwinnertech.com>
 <20200717160727.e6y5htg4sjd7bezi@gilmour.lan>
 <db1908ae-817c-f30d-7b88-f4afa593b258@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5to65lel25fuxowa"
Content-Disposition: inline
In-Reply-To: <db1908ae-817c-f30d-7b88-f4afa593b258@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5to65lel25fuxowa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 25, 2020 at 02:18:39PM -0500, Samuel Holland wrote:
> On 7/17/20 11:07 AM, Maxime Ripard wrote:
> > Hi!
> >=20
> > On Wed, Jul 15, 2020 at 07:54:12PM +0800, Frank Lee wrote:
> >> From: Yangtao Li <frank@allwinnertech.com>
> >>
> >> The sunxi gpio binding defines a few custom cells for its gpio specifi=
er.
> >> Provide bank name for those.
> >>
> >> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> >=20
> > Thanks for working on this, I wanted to do it at some point but it kept
> > getting pushed further into my todo list.
> >=20
> >> ---
> >>  include/dt-bindings/gpio/sunxi-gpio.h | 29 +++++++++++++++++++++++++++
> >>  1 file changed, 29 insertions(+)
> >>  create mode 100644 include/dt-bindings/gpio/sunxi-gpio.h
> >>
> >> diff --git a/include/dt-bindings/gpio/sunxi-gpio.h b/include/dt-bindin=
gs/gpio/sunxi-gpio.h
> >> new file mode 100644
> >> index 000000000000..c692b4360da6
> >> --- /dev/null
> >> +++ b/include/dt-bindings/gpio/sunxi-gpio.h
> >=20
> > So generally we've been using the compatible name as the file name. You
> > should follow that convention too, and since it was added with the A10,
> > using the A10 compatible.
> >=20
> >> @@ -0,0 +1,29 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/*
> >> + * GPIO definitions for Allwinner SoCs
> >> + *
> >> + * Copyright (C) 2020 Yangtao Li <frank@allwinnertech.com>
> >> + */
> >> +
> >> +#ifndef _DT_BINDINGS_SUNXI_GPIO_H
> >> +#define _DT_BINDINGS_SUNXI_GPIO_H
> >> +
> >> +#include <dt-bindings/gpio/gpio.h>
> >> +
> >> +/* pio */
> >> +#define PA	0
> >> +#define PB	1
> >> +#define PC	2
> >> +#define PD	3
> >> +#define PE	4
> >> +#define PF	5
> >> +#define PG	6
> >> +#define PH	7
> >> +#define PI	8
> >> +
> >> +/* r-pio */
> >> +#define PL	0
> >> +#define PM	1
> >> +#define PN	2
> >> +
> >> +#endif /* _DT_BINDINGS_SUNXI_GPIO_H */
> >=20
> > Maybe we can go one step further and use a macro to have something like
> > PIN(A, 12) ?
>=20
> Since we have separate cells for the bank and pin, I don't think it would=
 be
> appropriate to have a single macro generating both.

Yeah, but it's "just" an encoding issue though, it's not a major concern
if it makes our life easier.

> And I'm not sure what the benefit of the macro would be, if all it
> does is forward its arguments. Are you concerned that P[A-M] could
> conflict with something else in the device tree?

There's indeed a bunch of names that are fairly generic and could be
conflicting with others (PD for power domain is the first one that comes
to my mind). Using a prefix would make the GPIO descriptors pretty long,
so it wasn't ideal either. A macro makes it readable without increasing
too much the risks of conflicts

Maxime

--5to65lel25fuxowa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXyF0XQAKCRDj7w1vZxhR
xcSsAQDGVYSaoo497gJJf5z3XW53xRF45upx+3bu6u6vl7GEwgD+Myht5GLp2AUQ
huihjM9siGj14MTdGBFQLXp/C+seegE=
=6RKx
-----END PGP SIGNATURE-----

--5to65lel25fuxowa--
