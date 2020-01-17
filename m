Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB011C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B721D2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579285541;
	bh=Ajf3BP5hBZsV+EVeWhN6NMnAll1+MYA0SUMuToB9Bi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kfrVjcD60SJ0+tHvn4qSznRLl8VegL5I/b82W6SGRcdhNPkZu0bvAZsi8pjSSTpbR
	 338e3wHJ/9wjmcDYELVqJg/Q9NRZb4GNKUOX1wkivcQtrqdt0CY4ZOPJj3mcC4+FXa
	 NCTCi4M6hvPOC+ZPUD58Kwq2e5M1wt8ohs59xZ18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgAQSZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 13:25:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:38294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbgAQSZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 13:25:40 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04F0E206D5;
        Fri, 17 Jan 2020 18:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579285539;
        bh=Ajf3BP5hBZsV+EVeWhN6NMnAll1+MYA0SUMuToB9Bi8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rGISdMu+rzywI2gZjVcM1WGByjW5TW2wt+NoZo0MifkumfhruGnOL0SOu98nDSXnW
         vCTYqXaeAAUINnBx/ZLG1eN9wlBGnta3fl2ZvyHMKSqhoxKpzIugxEBDZ4JIuL9TWZ
         ETmRjk8Oo4A+/dOMlHkUwJzBbOQsq0qkLu6XJqaE=
Date:   Fri, 17 Jan 2020 19:25:37 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: sunxi: add OrangePi 3 with eMMC
Message-ID: <20200117182537.scttsuq26g6v6yno@gilmour.lan>
References: <20200115194216.173117-1-jernej.skrabec@siol.net>
 <4200557.LvFx2qVVIh@jernej-laptop>
 <20200116122944.sgl2fgxf5mrg6i52@gilmour.lan>
 <12435330.uLZWGnKmhe@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mplvgv5b6upxjosy"
Content-Disposition: inline
In-Reply-To: <12435330.uLZWGnKmhe@jernej-laptop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mplvgv5b6upxjosy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 16, 2020 at 05:33:45PM +0100, Jernej =C5=A0krabec wrote:
> Dne =C4=8Detrtek, 16. januar 2020 ob 13:29:44 CET je Maxime Ripard napisa=
l(a):
> > On Thu, Jan 16, 2020 at 12:10:58AM +0100, Jernej =C5=A0krabec wrote:
> > > Hi!
> > >
> > > Dne sreda, 15. januar 2020 ob 22:57:31 CET je Rob Herring napisal(a):
> > > > On Wed, Jan 15, 2020 at 1:42 PM Jernej Skrabec <jernej.skrabec@siol=
=2Enet>
> > >
> > > wrote:
> > > > > OrangePi 3 can optionally have eMMC. Add a compatible for it.
> > > >
> > > > Is this just a population option or a different board layout? If the
> > > > former, I don't think you need a new compatible, just add/enable a
> > > > node for the eMMC.
> > >
> > > I have only board with eMMC but I imagine it's the former. Even so,
> > > current
> > > approach with Allwinner boards is to have two different board DT file=
s,
> > > one for each variant. This can be seen from
> > > Documentation/devicetree/bindings/arm/ sunxi.yaml which has a lot of
> > > compatibles ending with "-emmc". I guess reason for that is to avoid
> > > having MMC controller being powered on for no reason.
> > The main reason for that is that those populating options can be
> > conflicting. For example, last week we discussed an issue about the
> > eMMC being on the same pin set than an SPI flash, both options being
> > available.
> >
> > The solution Andre suggested then was to let the eMMC be disabled, and
> > have the bootloader probe the emmc, and if found, enable
> > it. Otherwise, it means that you have a SPI flash (and enable it).
> >
> > I guess a similar solution would apply here.
>
> From what I can tell from schematic, pins are dedicated for eMMC.
>
> So what solution do you suggest? Put eMMC node in original OrangePi 3 DT =
and
> set status to disabled?

If it's always dedicated to eMMC, but the eMMC is not always there, I
guess we could remove the non-removable property from the eMMC
mode. IIRC, without it (and without CD GPIO), it will fall-back to
polling the card and will be able to detect it if it's there (and not
use it if it's not).

Maxime

--mplvgv5b6upxjosy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXiH8IQAKCRDj7w1vZxhR
xbWvAQDklRiCu9YordwQFOhckNNptssNw4rGbHaZXxEmxqtxQAD/UzPfwuDk4SR/
fyxg+YnibVHtraJeNwUYsL27/pkCOQA=
=TwtM
-----END PGP SIGNATURE-----

--mplvgv5b6upxjosy--
