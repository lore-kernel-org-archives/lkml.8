Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A575C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 031FE21D7F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633502AbgDPLdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:33:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:56020 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506097AbgDPLco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:32:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 068B9AC64;
        Thu, 16 Apr 2020 11:32:41 +0000 (UTC)
Message-ID: <096375407b15960b93f8511f0ba79618af7804e2.camel@suse.de>
Subject: Re: [PATCH 1/4] of: property: Fix create device links for all
 child-supplier dependencies
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 16 Apr 2020 13:32:40 +0200
In-Reply-To: <CAGETcx_+i9=+a4OEY-rySY4vNDg1jt4160zAMPR7U-UG38Ysww@mail.gmail.com>
References: <20200415150550.28156-1-nsaenzjulienne@suse.de>
         <20200415150550.28156-2-nsaenzjulienne@suse.de>
         <CAGETcx_+i9=+a4OEY-rySY4vNDg1jt4160zAMPR7U-UG38Ysww@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-o8zR7/3qQoOvLtsIlcam"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-o8zR7/3qQoOvLtsIlcam
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-04-15 at 11:22 -0700, Saravana Kannan wrote:
> Actually a few more nits about the commit text.
>=20
> On Wed, Apr 15, 2020 at 8:06 AM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > Upon adding a new platform device we scan its properties and its
>=20
> This code runs for all devices created from a DT node. Not just
> platform devices. So fix this paragraph appropriately?
>=20
> Upon adding a new device from a DT node, we scan... ?

Noted.

Regards,
Nicolas


--=-o8zR7/3qQoOvLtsIlcam
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl6YQlgACgkQlfZmHno8
x/522wf8Cl2aGiFtYYqXEYWScQzi9HK5/l8eZnRUjn1jAH4bhP8AdKJY6LTC7g0t
TnY8ux5Hbj6psHREIZWz6w8E/IRHXtyiOl4fWXE9Ai+azgJCuxhZyvhkjclQl6Vv
D3xeimHvWtXC5QtboMLXomVBpSpGx2F+aBj1ESj2Iq/CWjJT/FLSO85m4Aj9NQmq
hVaWxOGDp4USMrUeDIzs2JLy9r3KCpgRSsv3cMmIQ1pEUfGdUjBy/qdyhem1/uBr
gR4A0AFwoO5tRKsREMjkmf06DV/yvMXpUgfCKYIfAUvdiYyVqBymDFYtdCRKx4If
7wOtx1ftvFBq2sttpA/5ioadNzuD1A==
=MowF
-----END PGP SIGNATURE-----

--=-o8zR7/3qQoOvLtsIlcam--

