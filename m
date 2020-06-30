Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD2AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A28620768
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="RHXDNlGx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b93xSicY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbgF3IZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 04:25:14 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:40925 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727059AbgF3IZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 04:25:13 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 388487F8;
        Tue, 30 Jun 2020 04:25:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 30 Jun 2020 04:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=93ebSxQIAB/Yiarpi/LzBGI2pSh
        Q5+igEhkB54WEe2Y=; b=RHXDNlGxBiCN7WinLLOITPAGiYCEC7sPvozNg2qk6Kb
        cn4sI3fi8iW0lGm7+CsJpdPmapvVg6Ou3isGHm8TUKDUvUEzNh07aNwrwwms//tH
        C1ZDLDiF4D/dBV0KdHKEmsVjMneBJKIyOcJHE6WcYxQIQ05NL4B+5trQc0/t68Ij
        xU0PWT3DLFIS4qSfNQP/DVJsL2X6NsFmQhFvJWy2PjtjY/u+F5X675s4mb24ccg6
        K/Hg8UPTY852CPTI42lQQwoIMUeEH3gYFqDoSYMxpnWPJZ0ab/jJ3LiWvJk+hjga
        hgD+jHl0ImgTa3++YirIUfzXk48nsMFCZMddIwekAow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=93ebSx
        QIAB/Yiarpi/LzBGI2pShQ5+igEhkB54WEe2Y=; b=b93xSicYm6jBlBjh11pQFc
        78n70DYAnbmlq5gzMb9PkgdwV3GFWfVqDAVamPJ3hf3S93j+pyNFyQX7mV4TL8QV
        sVa1B8fbgOhsNCHkgdPxxLLjvr9iqf8d09EM94vkihOLz9WNlCwLwL+OJm8VmDV5
        RsVmz00JT9UkCBy0kYcHy6CqcJlcdbGEwSK4mBMnEspALYteaHFYp1nX/nvNJqIG
        5piWHAHfJCgY5urodX8ed/dH73rEb8OoeXjlsyvPE3xS5/QM24bCAoqi5rA+dMcx
        IPNr+1jOF55QBpxPejKPnfzTGxGyFgNSwTGwluv2RAPoC7cSjQ+RbVpm5s35wAqA
        ==
X-ME-Sender: <xms:5_b6XhHKJC3UURcgsjBg0-BRYPu31fpufRcoHy7bfE9Ye2JlzGdurg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrvddtuddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:5_b6XmVr15MFYmdKfXV-1IqkzFEvw3gqWddtWAA47cylKytidAgflg>
    <xmx:5_b6XjLQsQuJMjgtmQyonfQPBVO_-YEkGe-yitKL_FEKu6grqQZJuA>
    <xmx:5_b6XnH9vUorFD1-xLVix1Oq3EnCfWqdJ_O7bkbv2s-IOPamH_sHCQ>
    <xmx:5_b6XpLVDFuKHGBktPEtDqQe7CuGQpxVNqg9n71Irq3FL1vrL7bCJw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id F065A328005D;
        Tue, 30 Jun 2020 04:25:10 -0400 (EDT)
Date:   Tue, 30 Jun 2020 10:25:09 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH v4 0/9] drm/vc4: Turn the TXP into a CRTC
Message-ID: <20200630082509.puuzneiipalvrxup@gilmour.lan>
References: <cover.c33f5fd8b1b2703081f25398eb879937c9f7ce0b.1591882579.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xsn4uor3uoermk3h"
Content-Disposition: inline
In-Reply-To: <cover.c33f5fd8b1b2703081f25398eb879937c9f7ce0b.1591882579.git-series.maxime@cerno.tech>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xsn4uor3uoermk3h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Thu, Jun 11, 2020 at 03:36:45PM +0200, Maxime Ripard wrote:
> Hi,
>=20
> This is another part of the rpi4 HDMI series that got promoted to a
> series of its own to try to reduce the main one.
>=20
> This rework is needed since the bcm2711 used in the rpi4 has a more
> complex routing in the HVS that doesn't allow to use a fairly simple
> mapping like what was used before.
>=20
> Since that mapping affects both the pixelvalves and the TXP, turning the
> TXP into a CRTC just like pixelvalves are allows to deal with the
> mapping in the CRTC states, which turns out to be pretty convenient.
>=20
> Let me know what you think,
> Maxime
>=20
> Changes from v3:
>   - Stripped the patches out of the main HDMI series
>   - Change the bind order of the HVS to avoid a compatible check
>   - Added Eric's tags
>   - Rebased on top of drm-misc-next
>=20
> Maxime Ripard (9):
>   drm/vc4: Reorder the bind order of the devices
>   drm/vc4: crtc: Move HVS setup code to the HVS driver

Could you review those two patches? You haven't reviewed them yet and
it's holding back the rest of the patches.

Thanks!
Maxime

--xsn4uor3uoermk3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXvr25QAKCRDj7w1vZxhR
xWK5AQCC0PlbGFc9DmYVyYPdIVGgYaoiye5z/1pskPGlmr17hAD/eo+lPyeCVSpt
JcdTD981ITVOaQo2zJGTk7dg7fo7Cgk=
=zGmp
-----END PGP SIGNATURE-----

--xsn4uor3uoermk3h--
