Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74032C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C27E20760
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgFKJLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 05:11:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:58910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbgFKJLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 05:11:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 04499ACBD;
        Thu, 11 Jun 2020 09:11:06 +0000 (UTC)
Message-ID: <dd44eff2babb57cc9034e8de85162d0a1516e15f.camel@suse.de>
Subject: Re: [PATCH v4 25/27] clk: bcm2835: Allow custom CCF flags for the
 PLLs
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Tim Gover <tim.gover@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 11 Jun 2020 11:11:00 +0200
In-Reply-To: <abfae9fb4bfd76cd83d5ae97499b97b56b5dee58.1591860665.git-series.maxime@cerno.tech>
References: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
         <abfae9fb4bfd76cd83d5ae97499b97b56b5dee58.1591860665.git-series.maxime@cerno.tech>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-fOGfccOwdRSSTyMd7woJ"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fOGfccOwdRSSTyMd7woJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On Thu, 2020-06-11 at 09:32 +0200, Maxime Ripard wrote:
> While some clock types allow for each clock to specify its own custom
> flags, the PLLs can't. We will need this for the PLLB, so let's add it.
>=20
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/clk/bcm/clk-bcm2835.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.=
c
> index 32f5c13be9d1..846ea68b2c73 100644
> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> @@ -421,6 +421,7 @@ struct bcm2835_pll_data {
>  	u32 reference_enable_mask;
>  	/* Bit in CM_LOCK to indicate when the PLL has locked. */
>  	u32 lock_mask;
> +	u32 flags;
> =20
>  	const struct bcm2835_pll_ana_bits *ana;
> =20
> @@ -1310,7 +1311,7 @@ static struct clk_hw *bcm2835_register_pll(struct
> bcm2835_cprman *cprman,
>  	init.num_parents =3D 1;
>  	init.name =3D pll_data->name;
>  	init.ops =3D &bcm2835_pll_clk_ops;
> -	init.flags =3D CLK_IGNORE_UNUSED;
> +	init.flags =3D data->flags | CLK_IGNORE_UNUSED;

This should be 'pll_data->flags'.

With that fixed:

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Regards,
Nicolas


--=-fOGfccOwdRSSTyMd7woJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7h9SQACgkQlfZmHno8
x/5hGAgArrdyadJsxlxAD7oIdzlj8Q+2RKvz1lT4pRALZz06U0yhqAoIB/CswueU
z4TmOiXuOAhOI53ZDdEZSWA4XFO5rmgcSr19N6VWK9pRZ35FSMXE8wHVcqRSiMFH
R25RpkYUzKbhyP9DqazaR8a31a8HCrXwITH/miNGrD4xzos56i7DenXKku74HwcW
bk0UKLJ1iU35NtDGA8U22c4O2UOkqhySKV1ytFB8Td34U0q/nwJmSmRFn0960FZJ
F4oUfqKnqTTKZ7mrqp03iXL/eSip1cbYhJaTc0TQrAeazyPQO3SWa7uZelB1YpKO
XZF4NzdTne7NXjbTrgr4kUXrvotDXg==
=NtVc
-----END PGP SIGNATURE-----

--=-fOGfccOwdRSSTyMd7woJ--

