Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AFFC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D84E206F8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Gl69dg/K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HN2Ugj01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbgCWPNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:13:08 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:41957 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725861AbgCWPNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:13:08 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 783A9580118;
        Mon, 23 Mar 2020 11:13:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 23 Mar 2020 11:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=GAe9evQKgPl6kCh0zfTEzT/CM76
        CMhkxj8qnRU/5u+0=; b=Gl69dg/KL0fB2QP1vl5cZ85/lT7aRrLjbJKGwt/RdTL
        /7jB+HgApPvKUMRoyb2Qt1EGvMIqDp/QjW+rSokBqQTEkyTuV3JUq/j7ZKA/Hrnp
        WlcEJzNWRJUmAwK6ntpcVTDG+Yz3lrG8AffcoAKC4GnpQM/TNe94/ZaZerhaN7RL
        oD6NmOGsQNPiiIhsunX/G3w/SNo4xJo+hpS73o9OIBXbuKZZ2KJWRMqfpzTUgGFN
        +k17QeS4Jt9vVw1hQ/4NL6mAC7YtiwHoKYTvz9MvfMS0IFxW0F/FMSB7KE8MACOf
        FnQb+9TNuNyLmR/GIFY5ihN7vA9o1sYXrSRbsr0rtWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=GAe9ev
        QKgPl6kCh0zfTEzT/CM76CMhkxj8qnRU/5u+0=; b=HN2Ugj01J2KGTv3SX8ynQn
        KNFCNrha666DIO28e6EycqxyieMUf9tx9eylhLd5vjqq/QEkNHUzspqXL2C6IkV8
        5SSiplNdrZ27rxu2kHw5R3tMD5KJjLWNaYPkg7SunLBjtYjwV3wefeCofWXliLfK
        onST2HlEBdMuB0HpRudemyOfssvewDt6XG6FH4Fa6yDxwAU2ZPlgSWNv6L+9WqTg
        MirRl1b64x1WKbxCel0c5MrB8oIR4XUPlSzb5tcxF2hGsXqzN+141nw7U3UjLsjn
        nguxZuWYQtUjeO0r/GUzgZy9uhxiejE29TNx5zYf4SikxOirwNncxLW64L4BfJ9A
        ==
X-ME-Sender: <xms:ANJ4XtJNo40pA1nqiNL8_aKRSu00TlMjV_QZsv9m3yClraBzeEdI5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudegkedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:ANJ4XgQAKlM8v0yTpNI5NFWm2IWzuF4DJ4QXOyL9VEnAN8bGknTD6A>
    <xmx:ANJ4XoEWcJDSOi546MJKkxfd3cdhgtd7uLKFtnvVUd-PeSfx0CC3fQ>
    <xmx:ANJ4XoFlPY5gSl3QM-_rjLR-tGIMoXFQ9ve6UUiiivHQXYGRSDiFDw>
    <xmx:AtJ4Xg3kdjwW1dkBLRNuaXG9Rrbo83yojgh7ddnJzZaUJam9ajIH8w>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D7EF3328005A;
        Mon, 23 Mar 2020 11:13:03 -0400 (EDT)
Date:   Mon, 23 Mar 2020 16:13:02 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 07/89] clk: bcm: rpi: Allow the driver to be probed by DT
Message-ID: <20200323151302.ckpvc4a7eiinnfbq@gilmour.lan>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
 <c358081207dcf4f320a6b7e2932f0d5365bf3242.1582533919.git-series.maxime@cerno.tech>
 <d793e358-32db-5fea-aac9-d06062918718@i2se.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v5m5awxasxzcip5g"
Content-Disposition: inline
In-Reply-To: <d793e358-32db-5fea-aac9-d06062918718@i2se.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v5m5awxasxzcip5g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Stefan,

On Sun, Mar 01, 2020 at 01:16:28PM +0100, Stefan Wahren wrote:
> Hi Maxime,
>
> Am 24.02.20 um 10:06 schrieb Maxime Ripard:
> > The current firmware clock driver for the RaspberryPi can only be probed by
> > manually registering an associated platform_device.
> >
> > While this works fine for cpufreq where the device gets attached a clkdev
> > lookup, it would be tedious to maintain a table of all the devices using
> > one of the clocks exposed by the firmware.
> >
> > Since the DT on the other hand is the perfect place to store those
> > associations, make the firmware clocks driver probe-able through the device
> > tree so that we can represent it as a node.
> >
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: linux-clk@vger.kernel.org
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>
> FWIW i want to mention that starting with this commit, X doesn't start
> on my Raspberry Pi 3A (applied on top of linux-next using
> multi_v7_defconfig).

Was this the same issue you reported with the HSM clock rate, or truly
an issue with my series?

Maxime

--v5m5awxasxzcip5g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXnjR/gAKCRDj7w1vZxhR
xWCaAQCLY6mdJ+pXqjn7wvV8WOobxLaPy0P6y1ZPPf/arV8g9AEAnOxapP+tmnzB
zJdBac5cosAeX20cT1zCpqqzz1jHQQE=
=7v4z
-----END PGP SIGNATURE-----

--v5m5awxasxzcip5g--
