Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AC2C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 11:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4241C20C09
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 11:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbgIJLN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 07:13:59 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:58933 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726847AbgIJLJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 07:09:31 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id EAD415C01AF;
        Thu, 10 Sep 2020 07:09:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 10 Sep 2020 07:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=vzZHi8Yhpl770vw3uaxiREazDoJ
        LAZZb5Valsfgma+M=; b=N2kxe4HUgYcH+yXXxUSh95XQzV7hp3ieuCou6PPLH6W
        Bod5x/NRe6H8eVmjxC5NhAOWT8Zq5OA+ddJ5aC77FhnHTaXeUiftCrslzLLAH58X
        932zwaIl9BhQ3M8fnxWiAkMavK5MRzHDmg59Xs6MB2Lt6vVBk3iC3pa7QEpiR47r
        6HsZYbeV4cx7zSIbVIju2FLsryBj+IcZXIkmqW0h4tuwH+DdlrPvohuaKu88vYz2
        I3XaARE1lBmGopoECmlT7cK4Xi7Ozj4WeQIlAjkAZ5xlfm4iDVb7S0svHCPxGrM+
        iTPLsRPmanfTljCrFz3mQ/krXRlJBR9TP8sVN2kO2ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=vzZHi8
        Yhpl770vw3uaxiREazDoJLAZZb5Valsfgma+M=; b=e9FzldYcXd6Yb0cd4gMpFQ
        +6osmCiBYMO0AgPxfdD56nvQfvpvPQe6bgBE+rT/U61mZhyX4rZyZ4+UkxhGJaHM
        CPTooifhka6Sb9RrTEYVulN9cTCmVHmT2rR0taUkX5u+1BdBahGGkbrZqq3lDxWx
        /NzWTRP+UGFoeNA5oCmRTuKjG13gsxjA7A0pwtYZeQmOnQDG5BHyQKOfekD2tZS8
        HOKvtXaBc+ayLzfqsR1t8WDaTPfXl8wflbdWr5+iP53Y9CifQZt3RSVDpAPFy4+g
        T/bYDQzDXSsRTe/2nNPda22M2MTXRMA1t5pqpMX2EUOB3HQYT9zMfIGtVM98gwPw
        ==
X-ME-Sender: <xms:aAlaX8jrKNYJjjqY_z0WeKdsGkgvt7iS0ZWn68Gkur3A4oRSYrs9yQ>
    <xme:aAlaX1AwmAe2xld7dxznaSlY_47qo5e2YPdqQPLFL29gmWzEMISjQjH-4oNNMLWmw
    WppuXUyEFlZoOXPC2k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehjedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:aAlaX0HKVNhWJi8BP39rGOb04OvfLtHKLyAvQxVRNnN6Us40Q8H56Q>
    <xmx:aAlaX9Tvn2CTR6RTDdF4UEX4HUG2BUvDO-EiVrLFA2mdFth4teZn7w>
    <xmx:aAlaX5xZRQHmAcJ7dV20bA6z-j0Go28B6EabEOdWRMSVPe4zz7f-sw>
    <xmx:aQlaX8qYcEGjOTNCZfIv1pe4TmbUKjjR1qu2v88z4hZKTUCTmD_kZQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 940753280066;
        Thu, 10 Sep 2020 07:09:28 -0400 (EDT)
Date:   Thu, 10 Sep 2020 13:09:26 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Martin Cerveny <m.cerveny@computer.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drm/sun4i: sun8i-csc: Secondary CSC register
 correction
Message-ID: <20200910110926.bhoytmn6fhonlaxt@gilmour.lan>
References: <20200906162140.5584-1-m.cerveny@computer.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gd632ad2gwerkoq7"
Content-Disposition: inline
In-Reply-To: <20200906162140.5584-1-m.cerveny@computer.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gd632ad2gwerkoq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 06, 2020 at 06:21:38PM +0200, Martin Cerveny wrote:
> The secondary video layer (VI) on "Allwinner V3s" displays
> decoded video (YUV) in wrong colors. The secondary
> CSC should be programmed.=20
> Let's correct CSC register offset and extend regmap size.

Applied both, thanks

Maxime

--gd632ad2gwerkoq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX1oJZgAKCRDj7w1vZxhR
xWRDAP9yQx9ZDPAzz2RNzaVJ18yDPmCkCQLqhvrS2ht7GUQZIgD+N42Dub03IPkI
BCMbhyB3VzWyqGUmIZW6ZDurm4VnfQo=
=sU2K
-----END PGP SIGNATURE-----

--gd632ad2gwerkoq7--
