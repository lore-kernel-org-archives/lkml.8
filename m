Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D7BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1C432070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="JMcIaecU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F1qFXgkE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgGQQHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:07:35 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47445 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726401AbgGQQHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:07:33 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id E7D4A5C00BF;
        Fri, 17 Jul 2020 12:07:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 17 Jul 2020 12:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=6DLIkOkmfCpJPK8xXRWeO1VQ0hA
        XMrDZ2b/tFUBo/H8=; b=JMcIaecU/8eE79yKZtA21XJkSbpC5qKiVutsO+mB4k2
        yGaSFmcjh8EHenQwxLQEu9yq9nYr635ud2DeCbdZpyfeBrX2AVaoH5eDqGLLfW7R
        Ryvgao9AaWBobtTA18ch6aiB5idcV69a5lP+jG2Lj8+DFpdpZ7YoLykD4OBvb5YZ
        Pd+3kCwbwXbGnbvWLijAmBwdUrS8GkSETlPz/3ukcJ0rG1HGtXEZj6NTKGry3p1R
        FYxXWioeNqg0hf0+ZZ3/TAbGgBQS5MIdwrEFGWWCZgG3iGsbSmY0p1lSJduiUKiy
        7WSgeFxsU3C1HFY93wegig66dv/3O92v4gYYvHwUHEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=6DLIkO
        kmfCpJPK8xXRWeO1VQ0hAXMrDZ2b/tFUBo/H8=; b=F1qFXgkEAWi4iOOi2SpWr4
        in2yF1gUI8JnMt3RNs8KagWOpTF79TOoAWpiAlJRzamEqjIJGk5NBsUP8rM7tS7f
        ZOkubIqgDG7YeWJUxno0zrQEnVh5Q63IqjyiegUTeClDWfubIa2HTrQRzAwg6jdC
        cayv2OyPORtl5AwooCPDomlxlMkLjE0MEeQDXu+cwhClFEPIpCrYZ9K7XLh764mF
        ZC810zBNYlpmug13yBn9R+icgc85BRGmQHd6QSGZAtbujDWCxcscK9tsot8W5y6x
        RsN3U6IyCELUyk600cJ50DCWu1KiOEVrdyp91i9m9hZPmdlLTmhcoJueLKUveGIA
        ==
X-ME-Sender: <xms:wcwRX7-o5KWymJvRTpTFHSeZxeSwRITgZIn8mI8CrbHP2enUFZ2o2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrfeejgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:wcwRX3uPAYwn5A8M5tPDdAK2ZOFcCVVoi2FxHr5kAnV5bqpbVyQ0tA>
    <xmx:wcwRX5DxVuruDEa0zPTRfsHqbacgzkRoz-ekmrarzyr8d_2O3Mn0Kw>
    <xmx:wcwRX3emr7nvu80eQiRE-K1WZxT9z-c4mAS2pqhnKhccBwg-C2P5Cw>
    <xmx:w8wRX1ryLFJGdcZSc2yhqpXi6tXn5IfxBwVqd4Brkqb4Od_Q5dEj0A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 457C8328005A;
        Fri, 17 Jul 2020 12:07:29 -0400 (EDT)
Date:   Fri, 17 Jul 2020 18:07:27 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     robh+dt@kernel.org, wens@csie.org, tiny.windzz@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: gpio: =?utf-8?Q?sunxi=EF=BC=9Acreat?=
 =?utf-8?Q?e?= a DT header for Allwinner pin controller
Message-ID: <20200717160727.e6y5htg4sjd7bezi@gilmour.lan>
References: <20200715115412.2544-1-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="g4g5nqohehjztih7"
Content-Disposition: inline
In-Reply-To: <20200715115412.2544-1-frank@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g4g5nqohehjztih7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Wed, Jul 15, 2020 at 07:54:12PM +0800, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
>=20
> The sunxi gpio binding defines a few custom cells for its gpio specifier.
> Provide bank name for those.
>=20
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>

Thanks for working on this, I wanted to do it at some point but it kept
getting pushed further into my todo list.

> ---
>  include/dt-bindings/gpio/sunxi-gpio.h | 29 +++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 include/dt-bindings/gpio/sunxi-gpio.h
>=20
> diff --git a/include/dt-bindings/gpio/sunxi-gpio.h b/include/dt-bindings/=
gpio/sunxi-gpio.h
> new file mode 100644
> index 000000000000..c692b4360da6
> --- /dev/null
> +++ b/include/dt-bindings/gpio/sunxi-gpio.h

So generally we've been using the compatible name as the file name. You
should follow that convention too, and since it was added with the A10,
using the A10 compatible.

> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * GPIO definitions for Allwinner SoCs
> + *
> + * Copyright (C) 2020 Yangtao Li <frank@allwinnertech.com>
> + */
> +
> +#ifndef _DT_BINDINGS_SUNXI_GPIO_H
> +#define _DT_BINDINGS_SUNXI_GPIO_H
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/* pio */
> +#define PA	0
> +#define PB	1
> +#define PC	2
> +#define PD	3
> +#define PE	4
> +#define PF	5
> +#define PG	6
> +#define PH	7
> +#define PI	8
> +
> +/* r-pio */
> +#define PL	0
> +#define PM	1
> +#define PN	2
> +
> +#endif /* _DT_BINDINGS_SUNXI_GPIO_H */

Maybe we can go one step further and use a macro to have something like
PIN(A, 12) ?

Maxime

--g4g5nqohehjztih7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXxHMvwAKCRDj7w1vZxhR
xZe7AP4nQk5JlNsOhlZTUs0MH0jwyCEnPkq2g+L9nrus/9DyhwEAmd2oehdBu15l
snwOPbBnvRy1RNcmSaPZpc/OO2hwcg0=
=ucxT
-----END PGP SIGNATURE-----

--g4g5nqohehjztih7--
