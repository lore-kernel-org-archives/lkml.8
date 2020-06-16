Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39024C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23C8B20786
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbgFPQWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:22:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:53216 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729386AbgFPQWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:22:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6D7BEAD33;
        Tue, 16 Jun 2020 16:22:23 +0000 (UTC)
Message-ID: <cabeb88787e032d0b241369884720b410142f72b.camel@suse.de>
Subject: Re: [PATCH v3 2/3] ARM: bcm2835: Switch to use %ptT
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stefan Wahren <wahrenst@gmx.net>
Date:   Tue, 16 Jun 2020 18:22:17 +0200
In-Reply-To: <20200616161346.GW2428291@smile.fi.intel.com>
References: <20200415170046.33374-1-andriy.shevchenko@linux.intel.com>
         <20200415170046.33374-3-andriy.shevchenko@linux.intel.com>
         <5551ac7d9c7ba7df2b44832af49b3744869b34ef.camel@suse.de>
         <20200616161346.GW2428291@smile.fi.intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-PuZi12gRFbqH4DG5aG9Z"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PuZi12gRFbqH4DG5aG9Z
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-06-16 at 19:13 +0300, Andy Shevchenko wrote:
> On Tue, Jun 16, 2020 at 05:53:23PM +0200, Nicolas Saenz Julienne wrote:
> > On Wed, 2020-04-15 at 20:00 +0300, Andy Shevchenko wrote:
> > > Use %ptT instead of open coded variant to print content of
> > > time64_t type in human readable format.
> > >=20
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> >=20
> > as originally reported by Stefan Wahren, this patch is likely to be the
> > cause
> > for a regression on RPi3b+ 32bit mode (multi_v7_defconfig,
> > 5.8.0-rc1-00019-ga5dc8300df75):
> >=20
> > [    3.759892] raspberrypi-firmware soc:firmware: Attached to firmware =
from
> > 18446744073709048425-02-19T15:52:16
> >=20
> > Whereas the same doesn't seem to happen in 64bit mode:
> >=20
> > [    1.584126] raspberrypi-firmware soc:firmware: Attached to firmware =
from
> > 2020-02-12T12:39:27
>=20
> Had you chance to run test_printf on that machine and see if it reports a=
ny
> failure?
> If no, can you provide a raw date which makes this happen?
>=20
> Ah, I think I have an idea what is going on... stay tuned!
>=20
> Does below fix it?

Yes :)

> --- a/drivers/firmware/raspberrypi.c
> +++ b/drivers/firmware/raspberrypi.c
> @@ -181,6 +181,7 @@ EXPORT_SYMBOL_GPL(rpi_firmware_property);
>  static void
>  rpi_firmware_print_firmware_revision(struct rpi_firmware *fw)
>  {
> +	time64_t date_and_time;
>  	u32 packet;
>  	int ret =3D rpi_firmware_property(fw,
>  					RPI_FIRMWARE_GET_FIRMWARE_REVISION,
> @@ -189,7 +190,8 @@ rpi_firmware_print_firmware_revision(struct rpi_firmw=
are
> *fw)
>  	if (ret)
>  		return;
> =20
> -	dev_info(fw->cl.dev, "Attached to firmware from %ptT\n", &packet);
> +	date_and_time =3D packet;
> +	dev_info(fw->cl.dev, "Attached to firmware from %ptT\n",
> &date_and_time);
>  }
>=20


--=-PuZi12gRFbqH4DG5aG9Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7o8bkACgkQlfZmHno8
x/4DUAgAnnaDTkZauG+tPW/V8c3ozayVYYwVlDW3YUC79UDjrI9MRcFuMc1LNPdt
OaJSdil1QNaG08/X03vfymXUOkKJx18chWPbxmdYxEFOeyb7FrXckTRFDX52qxkK
b0tfM09kTEFq8GfhBAsMdaRfKESMk5GIh0e7hlzV3uSX4O8EL5k7fcRAMj1Yt29T
V7QeWYRmAP8VgNUVJzZHz73c6jPLYy+OgxE+YPKXD1NeSKYmatanW76BHppMeOcz
FKRsIXtJoyepM0dZe9foBKTxi7BG6aIG8mhxrmT3zxZ/3yUX5afMGgGZGyUzG77H
JHtJ9IjIiDvllUH+9hgazMrJUqff9Q==
=xiZt
-----END PGP SIGNATURE-----

--=-PuZi12gRFbqH4DG5aG9Z--

