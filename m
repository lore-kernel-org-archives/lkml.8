Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32594C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1208A2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbgBYOd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:33:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:43716 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729048AbgBYOd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:33:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BCCD8B14B;
        Tue, 25 Feb 2020 14:33:25 +0000 (UTC)
Message-ID: <5754451af3663ba39e8358dd15e586ee1485f86a.camel@suse.de>
Subject: Re: [PATCH 16/89] clk: bcm: rpi: Add clock id to data
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Maxime Ripard <maxime@cerno.tech>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Eric Anholt <eric@anholt.net>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 25 Feb 2020 15:33:23 +0100
In-Reply-To: <20200225095433.tyxamibqyrgw5355@gilmour.lan>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
         <3028e04887c7b8a6ffc150c016aa63281461b434.1582533919.git-series.maxime@cerno.tech>
         <67855a10-f7cb-b6b3-7b9f-d9c9baa5f105@i2se.com>
         <20200225095433.tyxamibqyrgw5355@gilmour.lan>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-k9G+OdjwEzh2rr0BSMKX"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-k9G+OdjwEzh2rr0BSMKX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On Tue, 2020-02-25 at 10:54 +0100, Maxime Ripard wrote:
> Hi Stefan,
>=20
> On Mon, Feb 24, 2020 at 08:25:46PM +0100, Stefan Wahren wrote:
> > Hi Maxime,
> >=20
> > Am 24.02.20 um 10:06 schrieb Maxime Ripard:
> > > The driver has really only supported one clock so far and has hardcod=
ed
> > > the
> > > ID used in communications with the firmware in all the functions
> > > implementing the clock framework hooks. Let's store that in the clock=
 data
> > > structure so that we can support more clocks later on.
> >=20
> > thank you for this series. I looked through it but i couldn't find an
> > explanation why we need to expose firmware clocks via DT instead of
> > extending clk-bcm2835. The whole pllb / clk-raspberrypi stuff was an
> > exception to get cpufreq working. I prefer to keep it an exception.
>=20
> Thanks for pointing this out, I indeed forgot to address it in my
> cover letter or my commit log.
>=20
> I'm not quite sure what the situation was with the previous
> RaspberryPi, but the RPi4 firmware does a bunch of things under the
> hood to make sure that everything works as expected:
>=20
>  - The HSM (and V3D) clocks will be reparented to multiple PLLs
>    depending on the rate being asked for.
>  - Still depending on the rate, the firmware will adjust the voltage
>    of the various PLLs.
>  - Depending on the temperature of the CPU and GPU, the firmware will
>    change the rate of clocks to throttle in case of the cores
>    overheating, with all the fallout that might happen to clocks
>    deriving from it.
>  - No matter what we choose to do in Linux, this will happen so
>    whether or not we want to do it, so doing it behind the firmware's
>    back (or the firmware doing it behind Linux's back) will only
>    result in troubles, with voltages too low, or the firmware trying
>    to access the same register at the same time than the Linux driver
>    would, etc.
>=20
> So all in all, it just seems much easier and safer to use the firmware
> clocks.

I agree with your assesment. Both DVFS and overheating/overvoltage protecti=
ons
will cause trouble, if not, make a Linux solution impossible while using th=
e
Foundation's firmware.

Please note that, as Stefan says, it'd be nice to keep track of those argum=
ents
somewhere in the commit messages.

Regards,
Nicolas


--=-k9G+OdjwEzh2rr0BSMKX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5VMDMACgkQlfZmHno8
x/4/WQf+Kyv1s3y5c1zna47wu/wkKyIjrM7qRGSnveL9N9nIqBjK0Z4BH7iLDXBx
25kFxVsa9SyNx5ipe612NlRgWcyYHbOxwaWI7SynhXnoSHvAd990CGpEAMA/WZx4
jvB2Ll/SRJuHXtpAyRmZyOOBUE6vX7hnM/wC/Rl3pdd9jvc6phjEza5bB54BTGXW
/CLu1E+DR/Yr1KPkeP6odZ+Xfc5UIuyYGqDi9lALXg7mPJhYjKYdMRHtbueyyNMI
VGh5So6ZKwPMRCqruOh8C2A2+UqHg2Q8vq5x52uFBUC4PZXKgzpgDRWJBiPJLqhu
pVGAeN2+7Odf4HzO6fexgYGCxlooRg==
=yNC6
-----END PGP SIGNATURE-----

--=-k9G+OdjwEzh2rr0BSMKX--

