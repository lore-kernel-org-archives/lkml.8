Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4BBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DE8420691
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="BnwR7wP2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X5b6o91S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgFLPgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 11:36:03 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:57511 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726085AbgFLPgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 11:36:02 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 938105C01A5;
        Fri, 12 Jun 2020 11:36:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 12 Jun 2020 11:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=i46wPfrcUIR0bEAZlAykfvGtcc2
        1AKB8ziEcZQaaqkw=; b=BnwR7wP2lY41wkLEtaL3I1g01xCASKpwAAI7z2XF24F
        rNBvnzNRsYm2jdjA32TOQelLkZd9bPZ2PHiC5tU/o4VqgpnjIytRWO1aKF4gK2y8
        UZuY9GiJEfq041OS0ipEUk8lRFc8yNBEPbwRY/SNZlWvxPtCY38pcojsDRiX1Bio
        uiNxXDU0e5KPmslLxHvGhKr6mAuqCNm/JR0gGm8PHzV3IDMHKrs1xNJYppql9XRw
        NlpZ/zNQhojPrcwRsWkuaKbpHw2sXnZ1PIBCnIEgqz1RAIly95UXujl5xPquwj26
        unquYGFtTijdtxd/vw/sOU81LST4Cl190fxQVyxrSbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=i46wPf
        rcUIR0bEAZlAykfvGtcc21AKB8ziEcZQaaqkw=; b=X5b6o91SO/aDmqT6iWePhe
        lDkgjaJJ59dVQoB8qP/jnAvNqt4nMhengMrO1EPhIDRmaMRDz28TslaqLtbvJyKL
        bD02iLd6HyakJTRgqTQJIn2yVeXWGgg/8vOlqgP4oXL/Em4oRT4E4p6LZ2DUrEQP
        I6b8+fvFWqEIgTuf3nMgUOujxY8RsRSAGNdwvQYTtj6mdNuDoyYzwGpQmnTLGehY
        n0f4O4EMaVgFOql3ddH4OWcJj5a1X1q0N+OfSMx7o3orjB+UijQqLAF0gl+Fabkd
        P1ttHEs3RJFFqgdkkY8mX51LkXJSmviMOOmm8XZaBKXBi2TWJbnEczTgwGsQk3kQ
        ==
X-ME-Sender: <xms:4KDjXgEg8GE_QHnW5MKlqja3GyOfCe6e_8Bj77QSByNcAeZzVBhgSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeiuddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:4KDjXpWi4BZThfNVw3Rs8D334SYqOA4xl4d-LVhhW44eH2YMNT4SPg>
    <xmx:4KDjXqJvc54evPMOFJFdT7NaOmc0h7U4-1RFN73w6WgXtKEo7Dss_w>
    <xmx:4KDjXiGArdcVByWkVn_aveCfrcZ33-GZihId-VHUAbG6ZeTOT7b5sQ>
    <xmx:4KDjXoKHGUr-bt_Qs5S2k8v2ixtTNUqdfGgeFB9v9ItkIvAPvv5iiw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C39BA30614FA;
        Fri, 12 Jun 2020 11:35:59 -0400 (EDT)
Date:   Fri, 12 Jun 2020 17:35:58 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Eric Anholt <eric@anholt.net>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH v3 032/105] drm/vc4: crtc: Enable and disable the PV in
 atomic_enable / disable
Message-ID: <20200612153558.3ekadlu3e2qctvf6@gilmour.lan>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
 <d2c1850e38e14f3def4c0307240e6826e296c14b.1590594512.git-series.maxime@cerno.tech>
 <CADaigPU7c=1u47R9GzvGCH_Z2fywY1foGYEy=KbBikjUQpwUFg@mail.gmail.com>
 <20200602141228.7zbkob7bw3owajsq@gilmour>
 <CAPY8ntDZWJeu14mL5a0jqUWHFOEWm2OOBBkh4yjjP0oLU83UCQ@mail.gmail.com>
 <CADaigPUHPhdrt9JkTfaw0iT7Z8z3Si-v2VJ-s+dhnFQaDNkAaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kjenvng7r4phiuyn"
Content-Disposition: inline
In-Reply-To: <CADaigPUHPhdrt9JkTfaw0iT7Z8z3Si-v2VJ-s+dhnFQaDNkAaA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kjenvng7r4phiuyn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, Jun 02, 2020 at 12:31:37PM -0700, Eric Anholt wrote:
> On Tue, Jun 2, 2020 at 8:02 AM Dave Stevenson
> <dave.stevenson@raspberrypi.com> wrote:
> >
> > Hi Maxime and Eric
> >
> > On Tue, 2 Jun 2020 at 15:12, Maxime Ripard <maxime@cerno.tech> wrote:
> > >
> > > Hi Eric
> > >
> > > On Wed, May 27, 2020 at 09:54:44AM -0700, Eric Anholt wrote:
> > > > On Wed, May 27, 2020 at 8:50 AM Maxime Ripard <maxime@cerno.tech> w=
rote:
> > > > >
> > > > > The VIDEN bit in the pixelvalve currently being used to enable or=
 disable
> > > > > the pixelvalve seems to not be enough in some situations, which w=
hill end
> > > > > up with the pixelvalve stalling.
> > > > >
> > > > > In such a case, even re-enabling VIDEN doesn't bring it back and =
we need to
> > > > > clear the FIFO. This can only be done if the pixelvalve is disabl=
ed though.
> > > > >
> > > > > In order to overcome this, we can configure the pixelvalve during
> > > > > mode_set_no_fb, but only enable it in atomic_enable and flush the=
 FIFO
> > > > > there, and in atomic_disable disable the pixelvalve again.
> > > >
> > > > What displays has this been tested with?  Getting this sequencing
> > > > right is so painful, and things like DSI are tricky to get to light
> > > > up.
> > >
> > > That FIFO is between the HVS and the HDMI PVs, so this was obviously
> > > tested against that. Dave also tested the DSI output IIRC, so we shou=
ld
> > > be covered here.
> >
> > DSI wasn't working on the first patch set that Maxime sent - I haven't
> > tested this one as yet but will do so.
> > DPI was working early on to both an Adafruit 800x480 DPI panel, and
> > via a VGA666 as VGA.
> > HDMI is obviously working.
> > VEC is being ignored now. The clock structure is more restricted than
> > earlier chips, so to get the required clocks for the VEC without using
> > fractional divides it compromises the clock that other parts of the
> > system can run at (IIRC including the ARM). That's why the VEC has to
> > be explicitly enabled for the firmware to enable it as the only
> > output. It's annoying, but that's just a restriction of the chip.
>=20
> I'm more concerned with "make sure we don't regress pre-pi4 with this
> series" than "pi4 displays all work from the beginning"

I tested the DSI today on an RPI3, and I had to fix an issue with the
HVS-PV muxing, but otherwise it works with this series. Otherwise, the
HDMI and TXP work on the Pi3 too, I'll give a try to the VGA adapter on
it next week to test DPI too.

As a side note, my DSI display without my patches gives DSI transfer
timeouts at boot, since at least (mainline) 5.4, I haven't tested
further back. It just stalls the modeset for a while, but the display
works fine after that.

Does that ring any bell?

Maxime

--kjenvng7r4phiuyn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXuOg3gAKCRDj7w1vZxhR
xRIVAQCQ9i9hYXPvUtEka4284eq9v67Twhyjfiex//nc2r4PIAD7BvQEVc4JW4id
g0nVDJpdj1tkhinSfTe+fu1vNaG1fgU=
=qQpW
-----END PGP SIGNATURE-----

--kjenvng7r4phiuyn--
