Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC40C4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647F82467B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="jyfbAqpj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wkMVVt7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgBZO01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 09:26:27 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:39037 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727198AbgBZO00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 09:26:26 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 64FAC6CC6;
        Wed, 26 Feb 2020 09:26:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 26 Feb 2020 09:26:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=MRxRrk3jAFQyO5nNuy2nyNGNvXF
        7vaF0qwd2iZ4I7NM=; b=jyfbAqpjnEVEF39WOTGLxBld3H6pkE40zv9I7VfyzyA
        rH3Bf8mpFs9xpuT3a0nSpoHDCDptCSuJC7xGzEI+4O3FE6tqvVjcLqDlJh/PqOeu
        EsRq92VzEh89hiln+yCu9enKfZ7pupaxaAGxWorRWYlogde5FjMh0cdPcguePrpf
        Ij5HgqJXezRz9A/PnSwfKSLf5q/WuwO+OgyuXhpeUCzENH333dumdDux5hysfrkM
        1/WAMOh9lg7xDec6w73+tpnnEUx9oblvdGw+6FyxtSiX1jcZcs8MNKhxbASIOvZa
        NSUeIIwH1yrl0tCcB8JO1fX/uIUiHFpAkuvBpgT4rKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=MRxRrk
        3jAFQyO5nNuy2nyNGNvXF7vaF0qwd2iZ4I7NM=; b=wkMVVt7ddT6XYDmr48IvF5
        wjMrg6QMLAfRfB23AaUAXgLFsTur1u7x7IKtKhT7FUiSTP9yCASM6/+H/Y/19IX+
        FMTiZE5AT3efVJ+7nPwybgefKx0PeqIt7RQbVTO4z0dpti9rKU4y58SbVLHWFiVp
        /vPULdvsJZoGLH4jsXchaYEeF7BdO70j5fbyqRYErc+gqt3pnA2E+gAJRl7Iz1Sn
        berNX0y4K5ESwmrPnEqtbmldApaJsxpOCtFxSyKG6h/rSnx9RxtRdrQPnawRH/k/
        fUi3XMRpLzIHG7G1e2srnR1mlg93KYGQjf4mfgXL3bVBd0EH6dE7YNgO670kqmcQ
        ==
X-ME-Sender: <xms:C4BWXl08AhnCz3J9AwIk3wJK1aWgF9CR991-_Lnbujm1w7sfBqr_Zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleeggdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:C4BWXlQXqCXPa2srKLKUOpN4x1K6oKv_oVtzCuaLgazgnjyJQZdquQ>
    <xmx:C4BWXqKZ5AOfRiup86XyrClbh77k8qjt_3H_PPEty60hrukQPsiywQ>
    <xmx:C4BWXon4HDfPy5xWKp70DLVgxQucm7F6L-4XKDF4Z9lUolXDXh2BYw>
    <xmx:EYBWXjx2kKeUa6oUpawYVJHMg7iWbtZef5MbJ_HcPs9XjoMqwaaZ0A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D1EC83280060;
        Wed, 26 Feb 2020 09:26:18 -0500 (EST)
Date:   Wed, 26 Feb 2020 15:26:17 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Eric Anholt <eric@anholt.net>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 10/89] clk: bcm: rpi: Remove global pllb_arm clock pointer
Message-ID: <20200226142617.mvis6olfzakiwqcc@gilmour.lan>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
 <3876f732b3fec2059270678d464d27b7d3a0414b.1582533919.git-series.maxime@cerno.tech>
 <52aebb76952df530f93e9de539124ddf1b825876.camel@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cfnnn2to3nsdt3mx"
Content-Disposition: inline
In-Reply-To: <52aebb76952df530f93e9de539124ddf1b825876.camel@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cfnnn2to3nsdt3mx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nicolas,

On Tue, Feb 25, 2020 at 05:13:33PM +0100, Nicolas Saenz Julienne wrote:
> On Mon, 2020-02-24 at 10:06 +0100, Maxime Ripard wrote:
> > The pllb_arm clk_hw pointer in the raspberry_clk structure isn't used
> > anywhere but in the raspberrypi_register_pllb_arm.
> >
> > Let's remove it, this will make our lives easier in future patches.
> >
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: linux-clk@vger.kernel.org
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

I guess you meant Acked or Reviewed-by?

Maxime

--cfnnn2to3nsdt3mx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXlaACQAKCRDj7w1vZxhR
xVyDAP4+q1ItaY+QWCIDmqEk2j/UzFHb+yklMprqAs4ll2R03AD9HHsS1kKWE0z3
6RfLFxLdmyDzRvDHmoFgGzr/ntYs5wc=
=5wL+
-----END PGP SIGNATURE-----

--cfnnn2to3nsdt3mx--
