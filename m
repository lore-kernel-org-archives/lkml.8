Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC628C11D10
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F4424673
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="rsy8BLO9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R6+adF2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgBTRW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 12:22:29 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55503 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728926AbgBTRW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 12:22:26 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 8147D21DC4;
        Thu, 20 Feb 2020 12:22:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 20 Feb 2020 12:22:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=Y/LbR6Gks9hLwTyOoP+fgUalI9X
        hENSr9+HkBd7I4X0=; b=rsy8BLO9wTPt5VT1koKQ++7YX/JqNw2f4K45TBjw61K
        NtrqK/J1EBgQYnqC7YFDQPkqZud22SIAPgJcoWT1ILayHtkQybaoMehemsVvBOBi
        7i4cjcDq32I/E6S7ES4KB9TOOHVCGcgp/fyVvtwoQCfFifhSp5kciq5ibEkWYDe1
        vBeJnDgdYC4kOTn0TAxST6lK9Q06nJmiz3J9CNHN5WTPfhIOA/RYaKUvmMSP7adg
        6V/I3RyaRAUirYnz7zoHoz/3c16LsVMd7iYu8/WazO0hySSg26lrRksqXVPUTR0A
        mrA0PIKjrsYYowLE9VSNMolVdQtSiK7ArAhC/FN9x9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Y/LbR6
        Gks9hLwTyOoP+fgUalI9XhENSr9+HkBd7I4X0=; b=R6+adF2rysmiZatF269DgT
        q08nniKYJWkj3UoyZ3iJ+fY3LO725EKt5QN4tZKZDzjX6/k7+2GW7Spq18637cD7
        U4AQd2t8kfp8TD5J/wEARU4iKSzOEpVC2/0PLbenrhZL82ERj3vWnSIATeOoEwpL
        iwUGrGk2vslNFmYqiMW68Y97o29byM5cAEAeVBPpIYYTEmJaFy8+zz9/oo02k9Yp
        FK+jow0+EK7+VqaIExL5nUyzcCtsXsyWzSH6x9gamO0KCyCJmEKXbX4adHxHPpLX
        ixd0C4lGZKHLmllIMh8GwRnX3gVCU4Q70qnrgdbLG6s8AepecQpqApSTbkNjGJ4g
        ==
X-ME-Sender: <xms:UcBOXsPtVx0Kka06Pp2MdvillpDUXARbRezhJYZRxRyd50uUz3e8fg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrkedvgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:UcBOXsBjQCEDGuAQPtHvcaGoQYDBDoTV055YxBXU0LEHR3T7Flnw0A>
    <xmx:UcBOXsVVdXtbCRvybu_vV20qG23UUQWSRJ_Qd1v8pAfqkFgtpAX1uw>
    <xmx:UcBOXgcCgwQTIL6hBrah-yD2DId9vI6gCTT-bv9kTSOCkSnuzrcR5Q>
    <xmx:UcBOXsQNGzQYx5UzJP61oxMDyeIbxa33Yk2aL31PWJoqbHgwtnGR8Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 331E03060BE4;
        Thu, 20 Feb 2020 12:22:25 -0500 (EST)
Date:   Thu, 20 Feb 2020 18:22:23 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andrey Lebedev <andrey.lebedev@gmail.com>
Cc:     wens@csie.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Andrey Lebedev <andrey@lebedev.lt>
Subject: Re: [PATCH 2/5] drm/sun4i: tcon: Separate quirks for tcon0 and tcon1
 on A20
Message-ID: <20200220172223.xoy6e3njmsb2vcon@gilmour.lan>
References: <20200210195633.GA21832@kedthinkpad>
 <20200219180858.4806-1-andrey.lebedev@gmail.com>
 <20200219180858.4806-3-andrey.lebedev@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bi7wpjn7s3dhfi3c"
Content-Disposition: inline
In-Reply-To: <20200219180858.4806-3-andrey.lebedev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bi7wpjn7s3dhfi3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 19, 2020 at 08:08:55PM +0200, Andrey Lebedev wrote:
> From: Andrey Lebedev <andrey@lebedev.lt>
>
> Timing controllers on A20 are not equivalent: tcon0 on A20 supports
> LVDS output and tcon1 does not. Separate the capabilities by
> introducing independent set of quirks for each of the tcons.
>
> Signed-off-by: Andrey Lebedev <andrey@lebedev.lt>
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index cc6b05ca2c69..b7234eef3c7b 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -1508,6 +1508,8 @@ const struct of_device_id sun4i_tcon_of_table[] = {
>  	{ .compatible = "allwinner,sun5i-a13-tcon", .data = &sun5i_a13_quirks },
>  	{ .compatible = "allwinner,sun6i-a31-tcon", .data = &sun6i_a31_quirks },
>  	{ .compatible = "allwinner,sun6i-a31s-tcon", .data = &sun6i_a31s_quirks },
> +	{ .compatible = "allwinner,sun7i-a20-tcon0", .data = &sun7i_a20_quirks },
> +	{ .compatible = "allwinner,sun7i-a20-tcon1", .data = &sun7i_a20_quirks },

It wasn't ordered alphabetically, I've fixed it up while applying.

Maxime

--bi7wpjn7s3dhfi3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXk7ATwAKCRDj7w1vZxhR
xaxkAQC4slxXfrNAlNDduUqdbx09RyWm5i9BjI+oi87n++Sj7wEA+3wqikR7D1eY
1FTAfdjEbPqk07Awe1jmsHs2OYbK2gQ=
=Um74
-----END PGP SIGNATURE-----

--bi7wpjn7s3dhfi3c--
