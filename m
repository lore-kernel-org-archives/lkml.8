Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F129C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 12:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A6520409
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 12:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="zb7KlrP8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WJfAQVpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgCZMcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 08:32:19 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:50123 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727781AbgCZMcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 08:32:19 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id A3DFD5F2;
        Thu, 26 Mar 2020 08:32:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 26 Mar 2020 08:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=6LPzcEpZCIWZe3NWzXCtwyC1WRy
        8GtF3+kzmi9vHqJQ=; b=zb7KlrP8//mqZlUFFm7OBjbNUhlJFsIf7jHIp5WCwfg
        MS+GkFN0EISqpDyMhYQAyF+aNL4pMNP8Kg7ONpLcbU9BKNZein7FMmkfL3FMG5iW
        SQCdvNeg7UBXpa3cQdQsi52ewJIPVGL190r95PPenn4cgVKBzrACrLcKpN+bZNdD
        9/QQPVc7TRkRMXdY05CjqKubjESLuW1iLr6Nf4sSULpPdcnCwoq//ivebdmICYAL
        skKjE4+9pcU3Vrl9YLSzb9mvQ1Xk/ejQCXQdqJhE7edBlChBEWd5rT865FWMuEk3
        CKw3xcpmqCK3hJfhcgQE1xsos/lWYHvg4omCk+V0fxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=6LPzcE
        pZCIWZe3NWzXCtwyC1WRy8GtF3+kzmi9vHqJQ=; b=WJfAQVpNlaQNhVBwxd8UTF
        EbWip3j8NfDKAGFnYE05SwPsqzzSi4vwHjwartVxM9VJBE6eLGEuICJ9mkcd6Dkw
        BAHrumVa+ZvsUPzc7DJQ1uZj3ZUOQTswuWllUM6YT6e23cS3y5yLSyysdIFugdm1
        cHdqWfXIGUS7dGb/Nc8KR3zlBWY9sGRHwL6uGt6xjPs4yh4Nd9dERHqUrMuu9hSI
        vi8Xp6LU780FF+uZ7+lGkDrylz5gab8H5yL91CsUkpcn/IENNetSn8Q7Zc2RQ8NH
        ikcvw1xwqb99NggfGG6jo8Ll4EZJApptAszMFZ24w1e4D/RYLbpyuMcEjJwqfdbg
        ==
X-ME-Sender: <xms:zqB8XrAWJcSwPfZVp6bYg9IM-S2U54bu9TvbF9mca1PT0kVPpmluog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudehiedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:zqB8XtFypG5HVZuotwPN2jMDykCJ0tHvzAI4Hsf6oYQJlEBAtPf2xw>
    <xmx:zqB8Xt3ypyYOjbZu74dbyJmZ72Q9UgwiNU8MnOrzCaXUI1XV2IaoOQ>
    <xmx:zqB8XmI5RTOQW0-uz3PGClzN0TBsn2LehT4swIaI5z1mxx0ermf69g>
    <xmx:0aB8Xsk7c8LvaMObwbm2BlgtSeu8vUYSUcgPkYdz76sSGEh2glMbdJE2j3c>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0DB52328005A;
        Thu, 26 Mar 2020 08:32:13 -0400 (EDT)
Date:   Thu, 26 Mar 2020 13:32:12 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Eric Anholt <eric@anholt.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-rpi-kernel@lists.infradead.org, f.fainelli@gmail.com,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vc4: Fix HDMI mode validation
Message-ID: <20200326123212.q6fl23fnjg7o7yyp@gilmour.lan>
References: <20200326122001.22215-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vddfs4mx3yibhlne"
Content-Disposition: inline
In-Reply-To: <20200326122001.22215-1-nsaenzjulienne@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vddfs4mx3yibhlne
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 26, 2020 at 01:20:01PM +0100, Nicolas Saenz Julienne wrote:
> Current mode validation impedes setting up some video modes which should
> be supported otherwise. Namely 1920x1200@60Hz.
>
> Fix this by lowering the minimum HDMI state machine clock to pixel clock
> ratio allowed.
>
> Fixes: 32e823c63e90 ("drm/vc4: Reject HDMI modes with too high of clocks")
> Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
> Suggested-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Maxime

--vddfs4mx3yibhlne
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXnygxwAKCRDj7w1vZxhR
xfOfAP0XYlKMR4DO967bRlehb2c975Ko9zqxfY2QFxSGl8gB6QD/VsLjZcdU5pOT
uncl3gohPDbB7bP6wYIzKtG3hicnwQA=
=Tn00
-----END PGP SIGNATURE-----

--vddfs4mx3yibhlne--
