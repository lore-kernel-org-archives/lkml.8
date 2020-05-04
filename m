Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4741C47247
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BFEC206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgEDMFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 08:05:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:48380 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726797AbgEDMFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 08:05:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 83554ADD3;
        Mon,  4 May 2020 12:05:51 +0000 (UTC)
Message-ID: <c9a7e50f88022179ef913fc6dfd066ec44b27988.camel@suse.de>
Subject: Re: [PATCH v2 20/91] clk: bcm: rpi: Discover the firmware clocks
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Maxime Ripard <maxime@cerno.tech>, Eric Anholt <eric@anholt.net>
Cc:     Tim Gover <tim.gover@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 04 May 2020 14:05:47 +0200
In-Reply-To: <1a25b4f079dcdc669d4b29d3658ef0b72be2651e.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
         <1a25b4f079dcdc669d4b29d3658ef0b72be2651e.1587742492.git-series.maxime@cerno.tech>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ieEAbJrdTr7tzv3p9LmQ"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ieEAbJrdTr7tzv3p9LmQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maxime, as always, thanks for the series!
Some extra context, and comments below.

On Fri, 2020-04-24 at 17:34 +0200, Maxime Ripard wrote:
> The RaspberryPi4 firmware actually exposes more clocks than are currently
> handled by the driver and we will need to change some of them directly
> based on the pixel rate for the display related clocks, or the load for t=
he
> GPU.
>=20
> This rate change can have a number of side-effects, including adjusting t=
he
> various PLL voltages or the PLL parents. The firmware will also update
> those clocks by itself for example if the SoC runs too hot.

To complete this:

RPi4's firmware implements DVFS. Clock frequency and SoC voltage are
correlated, if you can determine all clocks are running below a maximum the=
n it
should be safe to lower the voltage. Currently, firmware actively monitors =
arm,
core, h264, v3d, isp and hevc to determine what voltage can be reduced to, =
and
if arm increases any of those clocks behind the firmware's back, when it ha=
s a
lowered voltage, a crash is highly likely.

As pointed out to me by RPi foundation engineers hsm/pixel aren't currently
being monitored, as driving a high resolution display also requires a high =
core
clock, which already sets an acceptable min voltage threshold. But that mig=
ht
change if needed.

Ultimately, from the DVFS, the safe way to change clocks from arm would be =
to
always use the firmware interface, which we're far from doing right now. On=
 the
other hand, AFAIK not all clocks have a firmware counterpart.

Note that we could also have a word with the RPi foundation and see if
disabling DVFS is possible (AFAIK it's not an option right now). Although I
personally prefer to support this upstream, aside from the obvious benefits=
 to
battery powered use cases, not consuming power unnecessarily is always big
plus.

> In order to make Linux play as nice as possible with those constraints, i=
t
> makes sense to rely on the firmware clocks as much as possible.

As I comment above, not as simple as it seems. I suggest, for now, we only
register the clocks we're going to use and that are likely to be affected b=
y
DVFS. hsm being a contender here.

As we'd be settling on a hybrid solution here, which isn't ideal to say the
least, I'd like to gather some opinions on whether pushing towards a fully
firmware based solution is something you'd like to see.

> Fortunately,t he firmware has an interface to discover the clocks it
> exposes.

nit: wrongly placed space

> Let's use it to discover, register the clocks in the clocks framework and
> then expose them through the device tree for consumers to use them.
>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/clk/bcm/clk-raspberrypi.c          | 104 +++++++++++++++++++---

[...]

> +static struct clk_hw *raspberrypi_clk_register(struct raspberrypi_clk *r=
pi,
> +					       unsigned int parent,
> +					       unsigned int id)
> +{
> +	struct raspberrypi_clk_data *data;
> +	struct clk_init_data init =3D {};
> +	int ret;
> +
> +	if (id =3D=3D RPI_FIRMWARE_ARM_CLK_ID) {
> +		struct clk_hw *hw;
> +
> +		hw =3D raspberrypi_register_pllb(rpi);
> +		if (IS_ERR(hw)) {
> +			dev_err(rpi->dev, "Failed to initialize pllb, %ld\n",
> +				PTR_ERR(hw));
> +			return hw;
> +		}
> +
> +		return raspberrypi_register_pllb_arm(rpi);
> +	}

We shouldn't create a special case for pllb. My suggestion here is that we
revert the commit that removed pllb from the mmio driver, in order to maint=
ain a
nice view of the clock tree, and register this as a regular fw-clk.

The only user to this is RPi's the cpufreq driver, which shouldn't mind the
change as long as you maintain the clk lookup creation.

On that topic, now that the clocks are available in DT we could even move
raspberrypi-cpufreq's registration there. But that's out of the scope of th=
is
series.

> +
> +	data =3D devm_kzalloc(rpi->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return ERR_PTR(-ENOMEM);
> +	data->rpi =3D rpi;
> +	data->id =3D id;
> +
> +	init.name =3D devm_kasprintf(rpi->dev, GFP_KERNEL, "fw-clk-%u", id);

I'd really like more descriptive names here, sadly the firmware interface
doesn't provide them, but they are set in stone nonetheless. Something like
'fw-clk-arm' and 'fw-clk-hsm' comes to mind (SCMI does provide naming BTW).

See here for a list of all clocks:
https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface#clo=
cks

> +	init.ops =3D &raspberrypi_firmware_clk_ops;
> +	init.flags =3D CLK_GET_RATE_NOCACHE;
> +
> +	data->hw.init =3D &init;
> +
> +	ret =3D devm_clk_hw_register(rpi->dev, &data->hw);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return &data->hw;
> +}
> +
> +static int raspberrypi_discover_clocks(struct raspberrypi_clk *rpi,
> +				       struct clk_hw_onecell_data *data)
> +{
> +	struct rpi_firmware_get_clocks_response *clks;
> +	int ret;
> +
> +	clks =3D devm_kcalloc(rpi->dev, sizeof(*clks), NUM_FW_CLKS, GFP_KERNEL)=
;
> +	if (!clks)
> +		return -ENOMEM;
> +
> +	ret =3D rpi_firmware_property(rpi->firmware, RPI_FIRMWARE_GET_CLOCKS,
> +				    clks, sizeof(*clks) * NUM_FW_CLKS);
> +	if (ret)
> +		return ret;
> +
> +	while (clks->id) {
> +		struct clk_hw *hw;

Se my comment above WRT registering all clocks.

Regards,
Nicolas


--=-ieEAbJrdTr7tzv3p9LmQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl6wBRsACgkQlfZmHno8
x/5lKAgAgSuCdpTozRnwf4eTgqPosSqclq9h93uvCBl/X/FWDZBuR2OYX9/VaboG
q1eVupIjj6gF8WUDTSnfnn2fhhBY2szQ48N5QV5mB/D4Ib82BFUr99ku/d6eD7+L
v4nqt2x/hVobt83ZRYcqpuRfstmQdWvAwV6Jbh/21ccLtFQHZwKRFRo1SMUOZ7S4
gja02Ew3CiFtgagsL1uJcKw7xkygIDmXTeGP4tGRxWWdVZq/2PaJlXpWpF0HPx9d
V5S/1nwtMSsUJvO7qE4e+x9JtpALlGv+KrDGOb/5PusNly5AfIoRErwji16DxIB6
Ax1abz8s7nfALwDZSdaxNVVJyF3Org==
=R00X
-----END PGP SIGNATURE-----

--=-ieEAbJrdTr7tzv3p9LmQ--

