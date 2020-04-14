Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6458C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 07:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93DD820575
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 07:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="vRekPm9r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y1CPFzZe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406676AbgDNHeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 03:34:18 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:32817 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406666AbgDNHeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 03:34:11 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 47C4ABDB;
        Tue, 14 Apr 2020 03:34:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 14 Apr 2020 03:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=LBhKkgRT725GUf9jEN+2zEk/o6Q
        t0cWoESUX5EZnFas=; b=vRekPm9rDn8y1dn5G6GkAbKOh6Ymhs14ovB6yezBml9
        exBDwqih6icHJSdJGvaTDwn1ElOCq9jQVAfsR9yyYfmk6RXbaHanvcJpyeMkoB5d
        pq1+ANjJS2IoB2quCGCgovDU9xG/9+FduDVKX8RwfLRze5UJ4kxmbwC44/KhtVZW
        UXpiMrO+4CbLT5V5XxMCAOn6FyGuAiKzMJ++SbMnLE3qnQ0ohlUSM2QRrk37zBoh
        q+PdMqeoW1UYLjcz6ni8Gei6msO7qmHwQ17oh62syDth1usyMVU3UXHRe8tiIpnR
        oa+YuAPspEonTgalEmoBVD5Z9rsbe91JKyR2V/wtl6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=LBhKkg
        RT725GUf9jEN+2zEk/o6Qt0cWoESUX5EZnFas=; b=Y1CPFzZeJaW1D5NZudM8P4
        VwqpTA4gGWfSZF9dohWOUgVoUSYrcnsSMeyiy+pqmj8exTuNflxienU+e8jJQho6
        uNhCEpMSbD9pVCqlnjOzIPrB0eoOXmr7fifMpwy8zBNN2D6MTklntg10O4zOpkof
        aEwJZv+sE//t0IbNuyxBiroazSIKH4wPn1xQ3zLu/aIgXGf3LzYtCGBNQv0do6BF
        1nF/m0ZRqMGDTEfoA4tCIOB7PtSaq87VhEANXhjStcCRQeFMrRJo2zrm51mvc7ii
        /kx5R6enNRKRKC/LKs2fySN28N3cISHfslSycJNy8PslwIvVuYk2d+DsPw3mTR1A
        ==
X-ME-Sender: <xms:a2eVXrkvsFUCAikOM0TFwV5lGWcR1xBtRTpK5V0HK-zI8lsBekSrqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrfedtgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:a2eVXk-Mn84AZsSqUxS9zLQwmN-IsHzrg_3Srf_ZtiHjkT453m8v7g>
    <xmx:a2eVXnNfjdeCPDbeoxW9BVFSIItLYaJeEvFDLiWGzjbTT7Huk5B4rQ>
    <xmx:a2eVXm-THMmHC1dbxuHwV4Zfwnui3Jm-xhYDlnCIXFMS2wJiU1xiMA>
    <xmx:cWeVXv3L30ajP49vtRbiuTxbJQ01m1K9hPJd-lmZFLBaIa-JXNxS7A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 60B1B3280064;
        Tue, 14 Apr 2020 03:34:03 -0400 (EDT)
Date:   Tue, 14 Apr 2020 09:34:02 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 0/3] arm64: dts: allwinner: h6: OrangePi Lite2 and One
 Plus DTs
Message-ID: <20200414073402.7qfdbtn4jom4rvh6@gilmour.lan>
References: <20200413062433.1145043-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bxl4can4rfdluf7e"
Content-Disposition: inline
In-Reply-To: <20200413062433.1145043-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bxl4can4rfdluf7e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 13, 2020 at 08:24:30AM +0200, Jernej Skrabec wrote:
> This series adds missing nodes for OrangePi Lite2 and One Plus and
> fixes USB OTG mode to host because there is no way to toggle VBUS
> power supply on/off.
>
> The only remaining board specific functionality not enabled is USB3
> on OrangePi Lite2, but for that USB connector power supply support
> has to be added to driver first.
>
> Please take a look.

Applied all three, thanks!
Maxime

--bxl4can4rfdluf7e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXpVnagAKCRDj7w1vZxhR
xStmAQC2chM8vw0xMLPtHaFXgaLTF8837sWGbKvl8jDcqLna5QEA9HsyVfnVQNQV
xyi363QBArJKoKIJEdYpXvGVKfYfzwg=
=GKw8
-----END PGP SIGNATURE-----

--bxl4can4rfdluf7e--
