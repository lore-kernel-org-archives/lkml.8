Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B24C3A5A0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F9B820656
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506520AbgDPLiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:38:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:57660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506483AbgDPLhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:37:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CF685AC64;
        Thu, 16 Apr 2020 11:37:48 +0000 (UTC)
Message-ID: <55611d3e028b6ea418cba1ef9d94fe7bf1e1b1fd.camel@suse.de>
Subject: Re: [PATCH 2/4] of: property: Do not link to disabled devices
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 16 Apr 2020 13:37:48 +0200
In-Reply-To: <CAGETcx_7cTp0zx2hfGX0X=NpudkAjER8YeLMmRxTEtoqxc0pFw@mail.gmail.com>
References: <20200415150550.28156-1-nsaenzjulienne@suse.de>
         <20200415150550.28156-3-nsaenzjulienne@suse.de>
         <CAGETcx_7cTp0zx2hfGX0X=NpudkAjER8YeLMmRxTEtoqxc0pFw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-YH2OaEqwZ+TPp+cvOI2i"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YH2OaEqwZ+TPp+cvOI2i
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-04-15 at 11:30 -0700, Saravana Kannan wrote:
> On Wed, Apr 15, 2020 at 8:06 AM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > When creating a consumer/supplier relationship between two devices, mak=
e
> > sure the supplier node is actually active. Otherwise this will create a
> > device link that will never be fulfilled. This, in the worst case
> > scenario, will hang the system during boot.
> >=20
> > Note that, in practice, the fact that a device-tree represented
> > consumer/supplier relationship isn't fulfilled will not prevent devices
> > from successfully probing.
> >=20
> > Fixes: a3e1d1a7f5fc ("of: property: Add functional dependency link from=
 DT
> > bindings")
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >  drivers/of/property.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index a8c2b13521b27..487685ff8bb19 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -1052,6 +1052,13 @@ static int of_link_to_phandle(struct device *dev=
,
> > struct device_node *sup_np,
> >                 return -ENODEV;
> >         }
> >=20
> > +       /* Don't allow linking a device node as consumer of a disabled =
node
> > */
> > +       if (!of_device_is_available(sup_np)) {
> > +               dev_dbg(dev, "Not linking to %pOFP - Not available\n",
> > sup_np);
> > +               of_node_put(sup_np);
> > +               return -ENODEV;
> > +       }
> > +
>=20
> Again, surprised I haven't hit this situation with the number of
> disabled devices I have.

I'll point out to the example that triggered this issue on my reply to patc=
h
#4.

> The idea is right, but the implementation can be better. I think this
> check needs to be the first check after the of_node_get(sup_np) --
> before we do any of the "walk up to find the device" part.
>=20
> Otherwise, you could have a supplier device (the one with compatible
> prop) that's available with a child node that's disabled. And the
> phandle could be pointing to that disabled child node. If you don't do
> this as the first check, you might still try to form a pointless
> device link. It won't affect probing (because the actual struct device
> will probe) but it's still a pointless device link and a pointless
> delay in probing, etc.

Agree, I'll update the patch.

Regards,
Nicolas


--=-YH2OaEqwZ+TPp+cvOI2i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl6YQ4wACgkQlfZmHno8
x/7CQwgAlEnq8CbPih0tHYb/hiZxVOfc5OBXZ8B1bBe5PoGNyCKfxSehoWqog+fw
/LDFWdYASXiHvs3jSnKeSoXJTHa+rtBt+EeE/UEXU/c6geGUFq6FKnhRQBmzceBP
yAJOgDwKtvS86k5bpNuFRbh+nkwN+AFNYglSWBOWlFsuIg2JXaXOCNsF52q7rSS5
mhNFPkGCqHtvgGlFPYA5hLQMjR+pdwn8/G5rk4Tzr/KSCqJNqNMtsAqpGTvTrI5E
MtY2COIf/pkkqi7hNbxhD8jaS62zPJ5jBdRq3nkWroZAWwd01CfdYsqfNZhoPdyX
1PyuuJgabgqfbPrjcIHqWMV5M0DJlg==
=hiud
-----END PGP SIGNATURE-----

--=-YH2OaEqwZ+TPp+cvOI2i--

