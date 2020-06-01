Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B43C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 10:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C4FE20772
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 10:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgFAKrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 06:47:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:41148 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgFAKrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 06:47:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B52FAAAC7;
        Mon,  1 Jun 2020 10:47:24 +0000 (UTC)
Message-ID: <2a8f0190c9d418cee89451c7dc3a227b9d0b5f45.camel@suse.de>
Subject: Re: [PATCH v3 0/2] usb: xhci: Load Raspberry Pi 4 VL805's firmware
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     mbrugger@suse.com, u-boot@lists.denx.de, bmeng.cn@gmail.com,
        marex@denx.de, linux-kernel@vger.kernel.org
Cc:     sjg@chromium.org, m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        mark.kettenis@xs4all.nl
Date:   Mon, 01 Jun 2020 12:47:18 +0200
In-Reply-To: <20200505162607.334-1-nsaenzjulienne@suse.de>
References: <20200505162607.334-1-nsaenzjulienne@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-FoyFFAtR94ftiz4AGz0j"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FoyFFAtR94ftiz4AGz0j
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-05-05 at 18:26 +0200, Nicolas Saenz Julienne wrote:
> Newer revisions of the RPi4 need their xHCI chip, VL805, firmware to be
> loaded explicitly. Earlier versions didn't need that as they where using
> an EEPROM for that purpose. This series takes care of setting up the
> relevant infrastructure and run the firmware loading routine at the
> right moment.
>=20
> Note that this builds on top of Sylwester Nawrocki's "USB host support
> for Raspberry Pi 4 board" series.
>=20
> ---

Please don't forget about this series. The new 8GB RPi4 contains this HW de=
sign
change and USB will not work without it. See this discussion on the downstr=
eam
kernel github, where other OS/bootloaders are hitting the issue:

https://github.com/raspberrypi/firmware/issues/1402

Otherwise, the Linux version of this is already in linux-next:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
drivers/usb/host/pci-quirks.c?h=3Dnext-20200529&id=3Dc65822fef4adc0ba40c37a=
47337376ce75f7a7bc

Regards,
Nicolas


--=-FoyFFAtR94ftiz4AGz0j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7U3LYACgkQlfZmHno8
x/7omwf/donq7M/ZBwd+eliUSQSxK4iJmA4GbAATesQ5EmQRHOlwRQSjofcVNrYM
yozHo3gepzqNS5e6uZcJeUOLTaboDgG9Aj2u1rewxjKV+hhBWXpAz7MDVOoMuSYw
D0VjqJEfmFi+FSnrX3XW3BoFQGcVxRVGgjM+9ETpcspCAVqJUkvMDi6b6vTeXjXI
MK3o4muhFzc2TenjOLsf7f674amN8VIO0+Pvu5WjfwJfs6Uz+87z8iw8x3BZPc7I
9g66aM1vR7QKQPn6LVkNqB4JwCJo4AjEYPTMvyBsqrorTgRUsTd8K34CBC1I6oH6
E+QvdH5fpLfznJNPcXaRQh45UxE8ZA==
=gmud
-----END PGP SIGNATURE-----

--=-FoyFFAtR94ftiz4AGz0j--

