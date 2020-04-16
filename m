Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15205C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF1C6214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895358AbgDPQBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:01:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:50406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2636513AbgDPQBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:01:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EBC40AC20;
        Thu, 16 Apr 2020 16:01:04 +0000 (UTC)
Message-ID: <c48a3baef99f3d74e7904498c4054221ec384b36.camel@suse.de>
Subject: Re: [PATCH 4/4] of: property: Avoid linking devices with circular
 dependencies
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 16 Apr 2020 18:01:03 +0200
In-Reply-To: <CAGETcx9ewwOq3TRWorDf26HQzfQSd0KbtUT9AcoNnKpBwfuu+g@mail.gmail.com>
References: <20200415150550.28156-1-nsaenzjulienne@suse.de>
         <20200415150550.28156-5-nsaenzjulienne@suse.de>
         <CAGETcx9ewwOq3TRWorDf26HQzfQSd0KbtUT9AcoNnKpBwfuu+g@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-IU+VxIL8s8vBUZATDN/4"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IU+VxIL8s8vBUZATDN/4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-04-15 at 11:52 -0700, Saravana Kannan wrote:
> On Wed, Apr 15, 2020 at 8:06 AM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > When creating a consumer/supplier relationship between devices it's
> > essential to make sure they aren't supplying each other creating a
> > circular dependency.
>=20
> Kinda correct. But fw_devlink is not just about optimizing probing.
> It's also about ensuring sync_state() callbacks work correctly when
> drivers are built as modules. And for that to work, circular
> "SYNC_STATE_ONLY" device links are allowed. I've explained it in a bit
> more detail here [1].

Understood.

[...]

> This only catches circular links made out of 2 devices. If we really
> needed such a function that worked correctly to catch bigger
> "circles", you'd need to recurse and it'll get super wasteful and
> ugly.

Yeah, I was kind of expecting this reply :).

> Thankfully, device_link_add() already checks for circular dependencies
> when we need it and it's much cheaper because the links are at a
> device level and not examined at a property level.
>=20
> Is this a real problem you are hitting with the Raspberry Pi 4's? If
> so can you give an example in its DT where you are hitting this?

So the DT bit that triggered all this series is in
'arch/arm/boot/dts/bcm283x.dtsi'. Namely the interaction between
'cprman@7e101000' and 'dsi@7e209000.' Both are clock providers and both are
clock consumers of each other.

Well I had a second deeper look at the issue, here is how the circular
dependency breaks the boot process (A being soc, B being cprman and C being
dsi):

Device node A
	Device node B -> C
	Device node C -> B

The probe sequence is the following (with DL_FLAG_AUTOPROBE_CONSUMER):
1. A device is added, the rest of devices are siblings, nothing is done
2. B device is added, C device doesn't exist, B is added to
   'wait_for_suppliers' list with 'need_for_probe' flag set.
3. C device is added, B is picked up from 'wait_for_suppliers' list, device
   link created with B consuming from C.
4. C is then parsed, and tried to be linked with B as a consumer this time.
   This fails after testing for circular deps (by device_is_dependent()) du=
ring
   device_link_add(). This leaves C in the 'wait_for_suppliers' list *for e=
ver*
   as every further attempt at add_link() on C will fail.

-> Ultimately this prevents C for ever being probed, which also prevents B =
from
   being probed. Which isn't good as B is the main clock provider of the sy=
stem.

Note that B can live without C. I think some clock re-parenting will not be
accessible, but that's all.

> I'll have to NACK this patch for reasons mentioned above and in [1].
> However, I think I have a solution that should work for what I'm
> guessing is your real problem. But let me see the description of the
> real scenario before I claim to have a solution.

My intuition would be, upon getting a circular dep from device_is_dependent=
()
with DL_FLAG_AUTOPROBE_CONSUMER to switch need_for_probe to false on both
devices.

Regards,
Nicolas


--=-IU+VxIL8s8vBUZATDN/4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl6YgT8ACgkQlfZmHno8
x/4HIQf/YzvcO8H45/rGAJj01DwZWfYBY1Y9O4IY+FxsUryfxFQJzRy1BsxEiBrg
cr3EkaaBEEqxnojCYE7EYV7hWObvMv+HaSY7GiERH5xGCatVbdz8Wa7ysz9y5nNR
5t10OlVwFdXfb+V5YYqXJ+Q+9X6H88XAIvTl6XJIqbJPnes0BBkEEu5BjYd7AZbq
elVbo4xmRq166ZyrjrG+DJ/6/v48iE3jhBrR4zpTz4aY/3D5mE4cveLuIM/IRrun
WwanZB8NgfogJ9OjFtUx82Wh1PJO5iIQPmS49JBgc7QNfnYMEnNTcqGtY2kIz2FE
xVqhsYqj0xfKkrdw62L7uC8zGft72g==
=H5F4
-----END PGP SIGNATURE-----

--=-IU+VxIL8s8vBUZATDN/4--

