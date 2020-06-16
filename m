Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03752C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D60B520679
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbgFPQmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:42:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:60274 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729933AbgFPQmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:42:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 91F8BAAF1;
        Tue, 16 Jun 2020 16:42:06 +0000 (UTC)
Message-ID: <1e504c53d632b4f175f69782d1e38f0030dc9055.camel@suse.de>
Subject: Re: [PATCH v1] ARM: bcm2835: Fix integer overflow in
 rpi_firmware_print_firmware_revision()
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc:     Stefan Wahren <wahrenst@gmx.net>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Date:   Tue, 16 Jun 2020 18:42:00 +0200
In-Reply-To: <20200616163139.4229-1-andriy.shevchenko@linux.intel.com>
References: <20200616163139.4229-1-andriy.shevchenko@linux.intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-GVrUT0pbyW2P36bcV1qT"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GVrUT0pbyW2P36bcV1qT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-06-16 at 19:31 +0300, Andy Shevchenko wrote:
> time64_t is 64-bit width type, we are not supposed to supply lesser ones
> as in the case of rpi_firmware_print_firmware_revision() after the commit
> 4a60f58ee002 ("ARM: bcm2835: Switch to use %ptT"). Use temporary variable
> of time64_t type to correctly handle lesser types.
>=20
> Fixes: 4a60f58ee002 ("ARM: bcm2835: Switch to use %ptT")
> Reported-by: Stefan Wahren <wahrenst@gmx.net>
> Reported-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

If this doesn't fit the printk tree I don't mind taking it trough the rpi s=
oc
tree.

I'll also update the MAINTAINERS file so the firmware driver isn't orphaned=
.

Thanks!
Nicolas


--=-GVrUT0pbyW2P36bcV1qT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7o9lgACgkQlfZmHno8
x/6SRQgAsFBYKRTfAZu0YVZspmuX0VsUC2lK4krspCQAZD2QOvbYAeTHHkR5KpRy
buABS2qKzQ8WZ46osLrBpsGaG0CV73n/RA9TvGxBKqoUVPYbUhIzrxTqr9D0j1Rx
KCdh/i0OVpE/epHEl/xdKh1bH9EVdaaVWOh7LV6rQnBBvbov4aBjQMJ/i15nuJ5g
TdPA3BZSCt70jXIvjC5kwyu92NRxtoYhnPcWgReIGjOGQhtXCnYVDkTYBb5CWF36
xANc6cDQHMbg+WWYSmOCqI2Du7a6BvJCBOi7YacW5dyy/35rUX5X7KNEYGnc9Xcl
5TdElqhxeAyFCs9fa+4TfmFc828PIg==
=QsZ7
-----END PGP SIGNATURE-----

--=-GVrUT0pbyW2P36bcV1qT--

