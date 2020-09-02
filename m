Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87F1C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A004520829
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="XXkBZ0AU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tWoJdacz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgIBO7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:59:21 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:59977 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726528AbgIBNwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:52:35 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 679675DD;
        Wed,  2 Sep 2020 09:52:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 02 Sep 2020 09:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=uYl4BPHJHJwCu+IH/QSOVmLDopG
        QR9pU8iqrt6n2QJ0=; b=XXkBZ0AU1gPtIpCT7UwgtStXIxC4oVjC5FcJH6iX5uu
        wU8wjbZRK+1vICtZ/tqPMGhwhPvsfFVbDVuin0kFLguFYqVV50GOYS1zHOhHen3i
        KeeHo1QhqbPDsysn7wll3hIotJ3Cd69FKxgIqtbZiAv8H7Jo/lo/wDHUs51Fhjl9
        Fxy9ABtJ1odVwjWjiKsdTFMRZSER7IySA/+KejSIreeCxel/DIYZJrl5wO1a1XjI
        wTEZSN5YjXCj98GWwBOo4QxYVOoU4rTGY5oHFSPX87u2PX5ER6llcTj63hVJ94Be
        79kH65Z/JoTSk1DYXlsSCpgWMBQVshsyTTo1SRScd2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=uYl4BP
        HJHJwCu+IH/QSOVmLDopGQR9pU8iqrt6n2QJ0=; b=tWoJdaczodYmxy9J3bFBoX
        buLaM3YefbPsTm0YESK7pU2fH2O4d9bhnx1mMLYb1e1MGPjUJw7DmKqkOSn3vAaH
        cii0IYzDwoc2KYriGH/w0x0dFr+WoE6aqxDPL2QYIvF7Q/WVfWXoLhLsrrrsWxLn
        lr2YERIwgcuvlIt832jKJXsjfJx7w0lDm5b+6+nCr5UJNKSznDikAtCKmUL479i/
        fjkPOhVgHUdNr15aa//iCKtzrtFsRV7TfH4ysy0syrENwm/Y674NDOiM2pt2KOpX
        Avh4zd2A2sjHztEX+71YVf57YMP608BpfL4z0JIavPbzsDUbBut785e9GvY7HTYQ
        ==
X-ME-Sender: <xms:n6NPX_qTozjzfe7fC4apLu9gBl2-reHQmCuC-doz2DB5lGMOkSgSGw>
    <xme:n6NPX5q5BpOf_e2Ys3Ec66brJ63DJNPwSSkiJuqz4WccZWPmi824aRCXvQJL7t0rq
    LjXYDTPN53sumIMlp0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepuddvudfhkeekhefgffetffelgffftdehffduffegveetffehueeivddvjedv
    gfevnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:n6NPX8O69UHTuexuOmoIizn2havGvGAJxVqtDwjneINQxnWDPV_KXg>
    <xmx:n6NPXy4jE2Y_PBTupPEGBJBijeDTFyEWOj9ThEqavfUXNml4oOyjcQ>
    <xmx:n6NPX-4SbTbPsnGqG7FfpQFxNJ0FpD68ZtoqHuh7YL63anamrGAenw>
    <xmx:oaNPX9RvhgC5IuuXK-6wp4pu4tPY8NNdvcBQt_Nnj2BubG8zLBazXVNhzPg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B013D328005E;
        Wed,  2 Sep 2020 09:52:31 -0400 (EDT)
Date:   Wed, 2 Sep 2020 15:52:30 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Hoegeun Kwon <hoegeun.kwon@samsung.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>, devicetree@vger.kernel.org,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 00/78] drm/vc4: Support BCM2711 Display Pipeline
Message-ID: <20200902135230.5hpvfjqsamot5zg6@gilmour.lan>
References: <CGME20200709070649epcas1p13664bacc66a0f73443bf4d3e8940f933@epcas1p1.samsung.com>
 <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <1a39aedf-b708-e490-6acb-9a07e1b73300@samsung.com>
 <20200902133220.avp6dhfv2fhpiyf3@gilmour.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hfgqy6buhvjnpemx"
Content-Disposition: inline
In-Reply-To: <20200902133220.avp6dhfv2fhpiyf3@gilmour.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hfgqy6buhvjnpemx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 02, 2020 at 03:32:20PM +0200, Maxime Ripard wrote:
> Hi Hoegeun
>=20
> On Fri, Aug 21, 2020 at 04:18:34PM +0900, Hoegeun Kwon wrote:
> > Hi Maxime,
> >=20
> > Thank you for your version 4 patch.
> > I tested all 78 patches based on the next-20200708.
> >=20
> >=20
> > Dual HDMI opearation does not work normally.
> > flip_done timed out occurs and doesn't work.
> > Could you check please it.
> >=20
> > [=A0 105.694541] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR*=
=20
> > [CRTC:64:crtc-3] flip_done timed out
> > [=A0 115.934994] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR*=
=20
> > [CONNECTOR:32:HDMI-A-1] flip_done timed out
> > [=A0 126.174545] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR*=
=20
> > [PLANE:60:plane-3] flip_done timed out
>=20
> Thanks for testing and reporting this. I've been looking into it, and it
> seems that it's not just the dual output that's broken, but HDMI1
> entirely (so even a single display connected to HDMI1 doesn't work).
>=20
> Is it happening for you as well?

Nevermind, I had the DSI panel connected and it was interfering

Maxime


--hfgqy6buhvjnpemx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX0+jngAKCRDj7w1vZxhR
xVSHAQCnCDlA/SJLCP5PetU7Iyf4P2mZvBCHHAz/RyMCctXhaAEA+AQnVnAQhqZZ
mmLYhcaotKt4KrJuuhWp61WNWd0RMwQ=
=1Ln2
-----END PGP SIGNATURE-----

--hfgqy6buhvjnpemx--
