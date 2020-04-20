Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C314C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13B892082E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgDTL3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:29:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:50212 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgDTL3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:29:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 232B4AD10;
        Mon, 20 Apr 2020 11:29:07 +0000 (UTC)
Message-ID: <1363207183f599732f8bb9c97624886df42ced13.camel@suse.de>
Subject: Re: [PATCH v2 0/2] of: property: fw_devlink misc fixes
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 20 Apr 2020 13:29:07 +0200
In-Reply-To: <CAGETcx8EJiLSV8jzrusim6EvyVvX4H8ANvZaJwO72G1=iS-N2Q@mail.gmail.com>
References: <20200417165442.1856-1-nsaenzjulienne@suse.de>
         <500e8c46a9b411aed03965b6f9130ccde457193d.camel@suse.de>
         <CAGETcx8EJiLSV8jzrusim6EvyVvX4H8ANvZaJwO72G1=iS-N2Q@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-oWRQfEBEikL1V8VWHXq/"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oWRQfEBEikL1V8VWHXq/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Saravana,

On Fri, 2020-04-17 at 13:55 -0700, Saravana Kannan wrote:
> On Fri, Apr 17, 2020 at 11:06 AM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > Hi Saravana,
> >=20
> > On Fri, 2020-04-17 at 18:54 +0200, Nicolas Saenz Julienne wrote:
> > > As I'm interested in using this feature to fine-tune Raspberry Pi 4's
> > > device probe dependencies, I tried to get the board to boot with
> > > fw_devlink=3Don. As of today's linux-next the board won't boot with t=
hat
> > > option. I tried to address the underlying issues.
> > >=20
> >=20
> > On a semi-related topic, have you looked at vendor specific properties?=
 most
> > of
> > them create a consumer/supplier relationship, it'd be nice to be able t=
o
> > take
> > those ones into account as well.
>=20
> I'm on the wall about that. If we take every vendor specific property,
> this file will explode. Not sure I want to do that.
>=20
> Also, we haven't even finished all the generic bindings. I'm just
> adding bindings as I get familiar with each of them and I test them on
> hardware I have lying around before sending it out. So, there's where
> my focus is right now wrt fw_devlink and DT.
>=20
> I wonder how many of the vendor specific properties do very similar
> things and got in over time. Maybe they can be made generic? What one
> did you have in mind?

Well, long story short, we need to create a relationship between RPi4's PCI=
 bus
(which hangs from an interconnect in DT) and RPi4's co-processor, which has=
 a
highly unconventional firmware driver (raspberrypi.c in drivers/firmware). =
The
PCI bus just needs the co-processor interface to be up before probing, that=
's
all (I'll spare you the details of why). Ideally we want to avoid adding
platform specific code into an otherwise generic bus driver as it'll be use=
d by
a number of unrelated SoCs, and it's generally frowned upon.

There is no generic property to handle this case, and it's very unlikely th=
ere
will ever be one, since these firmware drivers have very little in common. =
I
guess this could make an argument for a generic _last resort only_
'supplied-by' property, but I bet this solution won't be very popular.

Another idea that comes to mind for vendor specific properties would be
exporting a macro in the lines of "DEFINE_SIMPLE_PROP()" for supplier drive=
rs
to define custom properties. The parse_prop() callbacks could then be added
into a special section for of/property.c to pickup and parse. The good thin=
g is
that the list length would be limited by the kernel configuration and the
maintenance burden moved to the driver authors, at least to some extent.

Anyway, if something comes to mind to solve RPi4's situation feel free to
propose anything :).

Regards,
Nicolas


--=-oWRQfEBEikL1V8VWHXq/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl6dh4MACgkQlfZmHno8
x/6bsQf+O9/wGDiM9jWmJgS5CcfOYfH+LH2Pu1Crp928ANt4oh7OZwBu3hsW3o/1
cWJ/89Juu3aftIrOPq3bsjJFDxefCwntesJgEhWhrN56uUubPxd0BPKgDqnSDMFo
Di4NAxqU8xRY2CYcd0vTxh0BUzRxKvNLNfs6RT3sha6GJ5HslboaGpE5Xk+g76HM
+RidyiUiHbjgOnwyM0FwTh83v/vd3V+gTtWN7OASShlAug5GR01WEWYlbWBbo6G6
Y+cXuBIPm1ksbMHQa3v6LJeO8VDbVv51FfyTb43NmOMDRMdLwtXBiaGEiEIY/joi
R9iEQAs27JwLsFUFyIHsJnNbbn3e9w==
=spL2
-----END PGP SIGNATURE-----

--=-oWRQfEBEikL1V8VWHXq/--

