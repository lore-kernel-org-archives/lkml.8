Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD62EC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 806872083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="aZ6BMlLY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2xpJKAgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgEGRRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:17:44 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:52755 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725949AbgEGRRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:17:44 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8819E5C0097;
        Thu,  7 May 2020 13:17:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 07 May 2020 13:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=yEsIB30Ejf9A/4N9N1Ex/jbueD0
        rngjg+1SZuLpBXTo=; b=aZ6BMlLYTGQG6grA5WlTsxCBMT+o0jhJD3zhofaNaKz
        92J1/qd+69LzDbI3os9x5EsGyqWCl0KGA6bO/5p6cS1/OmmdUVWnBHfnZuQuuFJV
        wpJRoE1D5gEh6MWRNBzXHmdr5V3YkUXv4fzfqGg1gXAfB9HrTK6t0JSSlkfJ6a20
        4jRw06yWgNgwQGPvG8hPluL3coQM0uP6UNir3AQBuqaJOzK0y1AtobYBFZY/zJT/
        Ba+xKkbCSdlCQqnxo12Ij+vFh+JdzQNMLH5p17GrWBHyaKQAdckTOO29n/d6ur9b
        JvzR86sYa+BJpEUGF2AeFB5IT/2h81DXT0cag7OXB0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=yEsIB3
        0Ejf9A/4N9N1Ex/jbueD0rngjg+1SZuLpBXTo=; b=2xpJKAgMTlMjdFW8q/zAhg
        MC1WmBGPmIzhn9w8HIaukk2RiV0ALBEoefetBLDCPnaVe/5vsIuSxt4hjaAkWHHA
        TZcDuBqxIicRVBZ0UTLWYwtsePlZZ/ZhFVsFOYTHM273iJ5NiyQhnx+/b1RRB3yn
        qtZQNRW7aVQMmY1z0V3knFWRvZK5Cp6RKLg4LtfDwGHCmM25NFdj4nmPFSzd/6FV
        OprtRERSVeqHWiPhELEZ2jAW0XS31oEpyyFk0JrsgsGJJSOuOyx79+fv9f7vlel2
        DfJ8bW+WJpJshJsSPCV3L8po2MGuOahFWy4qYKvAiNc9Y8fgM422ruoH3eJVqBCQ
        ==
X-ME-Sender: <xms:tUK0Xtp18SyAqgSHGp86QawcMYsejfSrROwiUoAOFJK_RSEEPVgRJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrkedtgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:tUK0XrXg9V5LEF00-qghTAreUeWpacAttfRw-Re-QPjkPtmwx1uHxQ>
    <xmx:tUK0XhFD4T8la6yL6UeZirYfZi2KvdggCy3feRLL7lE65WoKQDcMdg>
    <xmx:tUK0XtuUw3R5yMmEPx_FRW38p3KArS3pc_7gC-VFI42fILjOHI_cKQ>
    <xmx:tkK0Xl8LVetx1yrdk87eKdGy5UB4orQV-35ZCF8pKdRdpzKyhe2oHw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9292C3280063;
        Thu,  7 May 2020 13:17:41 -0400 (EDT)
Date:   Thu, 7 May 2020 19:17:38 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Swapnil Kashinath Jakhade <sjakhade@cadence.com>
Cc:     Yuti Suresh Amonkar <yamonkar@cadence.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jsarha@ti.com" <jsarha@ti.com>,
        "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>,
        "praneeth@ti.com" <praneeth@ti.com>,
        Milind Parab <mparab@cadence.com>
Subject: Re: [PATCH v1 2/2] phy: phy-cadence-torrent: Use PHY kernel APIs to
 set PHY attributes
Message-ID: <20200507171738.atzyfpueo6bjbwpb@gilmour.lan>
References: <1588057804-29161-1-git-send-email-yamonkar@cadence.com>
 <1588057804-29161-3-git-send-email-yamonkar@cadence.com>
 <20200429122750.hup7vbmz3xnpfwa5@gilmour.lan>
 <BY5PR07MB69827A1E2136455BFDD6090BC5AA0@BY5PR07MB6982.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fnwfzinzf67jig65"
Content-Disposition: inline
In-Reply-To: <BY5PR07MB69827A1E2136455BFDD6090BC5AA0@BY5PR07MB6982.namprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fnwfzinzf67jig65
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Thu, Apr 30, 2020 at 02:06:20PM +0000, Swapnil Kashinath Jakhade wrote:
> Thank you so much for reviewing the patch. Please see inline reply below.
>=20
> > -----Original Message-----
> > From: Maxime Ripard <maxime@cerno.tech>
> > Sent: Wednesday, April 29, 2020 5:58 PM
> > To: Yuti Suresh Amonkar <yamonkar@cadence.com>
> > Cc: linux-kernel@vger.kernel.org; kishon@ti.com; mark.rutland@arm.com;
> > jsarha@ti.com; tomi.valkeinen@ti.com; praneeth@ti.com; Milind Parab
> > <mparab@cadence.com>; Swapnil Kashinath Jakhade
> > <sjakhade@cadence.com>
> > Subject: Re: [PATCH v1 2/2] phy: phy-cadence-torrent: Use PHY kernel AP=
Is to
> > set PHY attributes
> >=20
> > EXTERNAL MAIL
> >=20
> >=20
> > Hi,
> >=20
> > On Tue, Apr 28, 2020 at 09:10:04AM +0200, Yuti Amonkar wrote:
> > > From: Swapnil Jakhade <sjakhade@cadence.com>
> > >
> > > Use generic PHY framework function phy_set_bus_width() to set number
> > > of lanes and function phy_set_max_link_rate() to set maximum link rate
> > > supported by PHY.
> > >
> > > Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> >=20
> > This should have your SoB.
> >=20
> > > ---
> > >  drivers/phy/cadence/phy-cadence-torrent.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/phy/cadence/phy-cadence-torrent.c
> > b/drivers/phy/cadence/phy-cadence-torrent.c
> > > index 7116127358ee..b914e5ddf93c 100644
> > > --- a/drivers/phy/cadence/phy-cadence-torrent.c
> > > +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> > > @@ -1852,6 +1852,9 @@ static int cdns_torrent_phy_probe(struct
> > platform_device *pdev)
> > >  				 cdns_phy->phys[node].num_lanes,
> > >  				 cdns_phy->max_bit_rate / 1000,
> > >  				 cdns_phy->max_bit_rate % 1000);
> > > +
> > > +			phy_set_bus_width(gphy, cdns_phy-
> > >phys[node].num_lanes);
> > > +			phy_set_max_link_rate(gphy, cdns_phy-
> > >max_bit_rate);
> >=20
> > I think what Kishon meant in his previous mail is that it's not really =
clear (to
> > me at least) how that function would be useful.
> >=20
> > In this particular case, what would the consumer make of that informati=
on?
> > Does
> > the phy needs to be reconfigured based on the max rate being changed?
> >=20
> > Some phy_configure_opts structures also have a somewhat similar field t=
hat
> > can
> > be negociated between the provider and the consumer using phy_validate,
> > wouldn't
> > that be redundant?
> >=20
> > Most of that discussion can only happen when you've provided a use-case
> > for that
> > series, so a consumer using it would help greatly there.
>=20
> Actually, for this particular case, consumer driver will be the Cadence M=
HDP
> bridge driver for DisplayPort which is also under review process for
> upstreaming [1]. So this DRM bridge driver will make use of the PHY APIs
> phy_get_bus_width() and phy_get_max_link_rate() during execution of probe
> function to get the number of lanes and maximum link rate supported by Ca=
dence
> Torrent PHY. This information is required to set the host capabilities in=
 the
> DRM bridge driver, based on which initial values for DisplayPort link tra=
ining
> will be determined.
>
> The changes in this PHY patch series are based on suggestions in the revi=
ew
> comments in [1] which asks to use kernel PHY APIs to read these properties
> instead of directly accessing PHY device node. The complete driver and ac=
tual
> use of these APIs can be found in [2]. This is how we are planning to use
> these APIs.

I haven't really looked into the displayport spec, but I'd assume that ther=
e's a
lot more parameters that would need to be negociated between the phy and th=
e DP
block? If so, then it would make more sense to follow the path we did for
MIPI-DSI where the parameters can be negociated through the phy_configure /
phy_validate interface.

Maxime

--fnwfzinzf67jig65
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXrRCsgAKCRDj7w1vZxhR
xcxNAQCJzdDTI7XfDxwOQTyRA+A0KjWJ540bnKWNjxgcXBGkLAEA81jx2j6ogfZR
BBWqGaYotEewPh3kQu0Uxc5JUJ/6hws=
=HjJD
-----END PGP SIGNATURE-----

--fnwfzinzf67jig65--
