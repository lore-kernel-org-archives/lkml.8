Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C06C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C232F20772
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="jAUnEuWc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hu4oqsVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgFBOMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 10:12:34 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:58351 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726037AbgFBOMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 10:12:33 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id DF8795C00B9;
        Tue,  2 Jun 2020 10:12:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 02 Jun 2020 10:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=6nfNzIAdvv+2u2nlDiEbeWjNRvu
        HHWtTui6XJIgYRnc=; b=jAUnEuWco8XlUL2BK4xM3qarlYtcrL+3VZ0Ym1RM8WD
        5b5AAbDS7DVtJLbQknXzWWrhrpvUmpN+U91zfJ/soaK39ndvePIEKUYrmuaYORGT
        4x4KrUOhaCRClx3KNGcWEfuICJLq4t/tib5EP7eCG2goCt9YRerKedfW13jepPtt
        gQfFqQdfKJECr7Ryku8u4/aj91qVPIWaanSp5Lf6hJ9DyGbX3AlSGd6xbVjW8cKl
        1YYlss8WlFoEHFBdGOQIyJU95rSRjeLHy9WnuIQ0/RukKbrtbo/BcUFoTVAo47LU
        RCDQDZR3nu5zpnpUyMOWUI2krXgijryDKSx0XSSXa+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=6nfNzI
        Advv+2u2nlDiEbeWjNRvuHHWtTui6XJIgYRnc=; b=Hu4oqsVsaTtiSj5i7jvC4r
        NsH/ZN/D2lCDRDqGz7TrWtTeQC8EuTYqs8G+Ezfb2mLymz9Xa/BzSxNEG9ZJ/gkl
        aM4h2IdDYABb7EuvQadKyThkjSB7SWHRbP7hEXazK9mRUBdqlSu9S/LCB9qu/1uE
        cc7vfIdIqQ9TBsQB47COChmIFjY4vopQ9L7wsIbPBJyzNRq84CIRqr0yf4Z2SekP
        KnWNl28M5SNbFUF8ctmDHpeEgz8cJIN06TajSckWZuIWNk+TkiOD49pxb2TyMkQz
        z2IAUcviiPttjrseNGyOyJGVGz00DUZASBdrdOIzjfR1tBqNBwXhPMzrz2dCQdpw
        ==
X-ME-Sender: <xms:TV7WXo9CO17tSpLgPFR7ZfnEb5jzmTgd-KulMWm5-4SGMKqS_moV-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudefjedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:TV7WXgvt0QITr9I9KP7DC0J-r-wx8Bobhwlhcl2qoc1fCp_MLUuhNw>
    <xmx:TV7WXuAn3tU1N1MDvgwI8oOe8_do1iKiV-M_RsYxFV3cGLgaFV615w>
    <xmx:TV7WXoemze4jGbSqKicPDyTImtFDo5iRHqfM-rDJbUfwYHOtOgIAiA>
    <xmx:T17WXpBpyteFSyJTeWMejXCyGZvzmoEFEMDuFNQBphC0Xg8f1UGoZQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 725C43280066;
        Tue,  2 Jun 2020 10:12:29 -0400 (EDT)
Date:   Tue, 2 Jun 2020 16:12:28 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Eric Anholt <eric@anholt.net>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH v3 032/105] drm/vc4: crtc: Enable and disable the PV in
 atomic_enable / disable
Message-ID: <20200602141228.7zbkob7bw3owajsq@gilmour>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
 <d2c1850e38e14f3def4c0307240e6826e296c14b.1590594512.git-series.maxime@cerno.tech>
 <CADaigPU7c=1u47R9GzvGCH_Z2fywY1foGYEy=KbBikjUQpwUFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6jdhhfajj55wnhto"
Content-Disposition: inline
In-Reply-To: <CADaigPU7c=1u47R9GzvGCH_Z2fywY1foGYEy=KbBikjUQpwUFg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6jdhhfajj55wnhto
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Eric

On Wed, May 27, 2020 at 09:54:44AM -0700, Eric Anholt wrote:
> On Wed, May 27, 2020 at 8:50 AM Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > The VIDEN bit in the pixelvalve currently being used to enable or disab=
le
> > the pixelvalve seems to not be enough in some situations, which whill e=
nd
> > up with the pixelvalve stalling.
> >
> > In such a case, even re-enabling VIDEN doesn't bring it back and we nee=
d to
> > clear the FIFO. This can only be done if the pixelvalve is disabled tho=
ugh.
> >
> > In order to overcome this, we can configure the pixelvalve during
> > mode_set_no_fb, but only enable it in atomic_enable and flush the FIFO
> > there, and in atomic_disable disable the pixelvalve again.
>=20
> What displays has this been tested with?  Getting this sequencing
> right is so painful, and things like DSI are tricky to get to light
> up.

That FIFO is between the HVS and the HDMI PVs, so this was obviously
tested against that. Dave also tested the DSI output IIRC, so we should
be covered here.

Maxime

--6jdhhfajj55wnhto
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXtZeTAAKCRDj7w1vZxhR
xVJqAQCUmpR8JL8pnnKjcPFlmgxyfzwLZXpVwBbL1P2+kZmIMAEAtrzlIP25oS5g
9aixg7Ifrmc88nWmBcIbxDH1tuDcFAs=
=Ak49
-----END PGP SIGNATURE-----

--6jdhhfajj55wnhto--
