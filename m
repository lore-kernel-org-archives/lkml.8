Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBA9C352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 09:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0DEA22240
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 09:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgDRJUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 05:20:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:44550 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbgDRJUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 05:20:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BC2F5AB7F;
        Sat, 18 Apr 2020 09:20:34 +0000 (UTC)
Message-ID: <9c20715fdb2955a3974b3d11f6c4eaff588be536.camel@suse.de>
Subject: Re: [PATCH v2 2/2] of: property: Do not link to disabled devices
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Saravana Kannan <saravanak@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Date:   Sat, 18 Apr 2020 11:20:34 +0200
In-Reply-To: <CAGETcx81uPQLCurX6N6pMH+2jOZBcs-9u5yhBp83jQWJks0EFw@mail.gmail.com>
References: <20200417165442.1856-1-nsaenzjulienne@suse.de>
         <20200417165442.1856-3-nsaenzjulienne@suse.de>
         <CAGETcx81uPQLCurX6N6pMH+2jOZBcs-9u5yhBp83jQWJks0EFw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-BqN1HHTsGcrPA2KLRaf6"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BqN1HHTsGcrPA2KLRaf6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-04-17 at 14:08 -0700, Saravana Kannan wrote:
> On Fri, Apr 17, 2020 at 9:54 AM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > When creating a consumer/supplier relationship between two devices,
> > make sure the supplier node is actually active. Otherwise this will
> > create a link relationship that will never be fulfilled. This, in the
> > worst case scenario, will hang the system during boot.
> >=20
> > Note that, in practice, the fact that a device-tree represented
> > consumer/supplier relationship isn't fulfilled will not prevent devices
> > from successfully probing.
> >=20
> > Fixes: a3e1d1a7f5fc ("of: property: Add functional dependency link from=
 DT
> > bindings")
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> >=20
> > ---
> >=20
> > Changes since v1:
> >  - Move availability check into the compatible search routine and bail
> >    if device node disabled
> >=20
> >  drivers/of/property.c | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index dc034eb45defd..14b6266dd054b 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -1045,8 +1045,25 @@ static int of_link_to_phandle(struct device *dev=
,
> > struct device_node *sup_np,
> >          * Find the device node that contains the supplier phandle.  It=
 may
> > be
> >          * @sup_np or it may be an ancestor of @sup_np.
> >          */
> > -       while (sup_np && !of_find_property(sup_np, "compatible", NULL))
> > +       while (sup_np) {
> > +
> > +               /*
> > +                * Don't allow linking a device node as consumer of a
> > disabled
> > +                * node.
> > +                */
>=20
> Minor nit: I'd just say "Don't allow linking to a disabled supplier".
>=20
> > +               if (!of_device_is_available(sup_np)) {
> > +                       dev_dbg(dev, "Not linking to %pOFP - Not
> > available\n",
> > +                               sup_np);
> > +                       of_node_put(sup_np);
> > +                       return -ENODEV;
> > +               }
>=20
> This if block looks very similar to the one right after the loop.
> Maybe there's a nice way to combine it?
>=20
> If you replace this if block with this, it'll end up with the same result=
.
> if (!of_device_is_available(sup_np)) {
>         of_node_put(sup_np);
>         sup_np =3D NULL;
> }
>=20
> of_get_next_parent() handles a NULL input properly. So that won't be a
> problem. And "No device" is a valid statement for both cases I think.
>=20
> > +
> > +               if (of_find_property(sup_np, "compatible", NULL))
> > +                       break;
> > +
> >                 sup_np =3D of_get_next_parent(sup_np);
> > +       }
> > +
> >         if (!sup_np) {
> >                 dev_dbg(dev, "Not linking to %pOFP - No device\n", tmp_=
np);
> >                 return -ENODEV;
>=20
> However, not against this patch as is if Rob/Frank like it as is.

Agree with your suggestions, I'll send an v3.

Regards,
Nicolas


--=-BqN1HHTsGcrPA2KLRaf6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl6axmIACgkQlfZmHno8
x/4tQwf/aCxO5DM4IyxA61VgCuBo+QzxtE6q4WBs20J4EKcM0tcoSwVQzCEJHC8f
HEDszhegck501HhapWxgnZvHbR1pv5aLehwgl0j/3MTo8HTM/fe3/odQpOUfKY+y
yjMWNULoy4iRQMsHDZHbdFKG4THQ/yz5vebhKVwxIlzlF37yDmMZgLBDlikbiJoa
6CA4WlKlgc0QU5+6OhVNDcP5fB0JVCSnePVCEqM51Usyngg0JXlBCJ9WQnLVMXDb
DtJy9sMC1GCYvuTp6BMWqsJ8ZUz0RAuQ0/bQtFKPvwsbpGDfR0EBl4KqTGH8BLjx
ZuC3RL9z8aSEmrfBkIJ//DMR5K3YXA==
=NwP/
-----END PGP SIGNATURE-----

--=-BqN1HHTsGcrPA2KLRaf6--

