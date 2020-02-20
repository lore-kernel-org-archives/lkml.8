Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1EBC11D13
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83ED1207FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="VUHxBO0z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tbv/SagD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgBTRWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 12:22:00 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37869 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728692AbgBTRV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 12:21:59 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 593AF21D6E;
        Thu, 20 Feb 2020 12:21:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 20 Feb 2020 12:21:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=F59Fd4S1GGUgMmZ4kteMtbJWPk0
        n14U6PXOXNH3ut34=; b=VUHxBO0zQwwgUd9v0sbrKeNgkepO9x6Mgsf07D+aXm3
        7sh5tSnnfbQduIEa0niXhJJ5PzhwSD/VJZNM1Iy22X2BVUZifuds1zoB/Yw1WfqK
        98piyQbeTHBkz9Nm3BeA83uYYfVwIgd1kqDxJRZLJG3dff4R5PvzJCFgk7LKK3gL
        P6NH8pDPpzdlaBQJcfsnfkSDBCm6eh4LD3zKyOOsrke8T55Jc409Y38bCimGuQ3l
        mXUQP6N407IkE0BT7Ro6GovOkpO03VTbRtUxXMF71lmQ0URuFWhY0OiZ7KSfPi+g
        rhI2eidcHWV+qPj/v1AOB3vajzk8iL42niuNjlhK6rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=F59Fd4
        S1GGUgMmZ4kteMtbJWPk0n14U6PXOXNH3ut34=; b=tbv/SagDhZJx3TKjU5lu6L
        zMypsEcVI8cEuzk3Nj5rMqlQv6saXzs7QM4MbnsPXzFuKeb7ysS/G5Px2MmeTHn1
        ghedvtWLg5IINkkR3n4O1f9VNJP92F9wak2qI4A9hfwR5iBP6UdzqAv+sOAH1Ac/
        rMyAXPRpKcPiWO8NX/683vsry8LfOyRu+jyx5KYLpLqueQagi/CNvoOS9Qva7Eeq
        xMLWmRPwaIIhBVCOR8XJkYPVzyrIVEgFZAeQWZx6/lUoUQXcWhuHp/aysYOgvDCw
        C85AlMDbj/IDpJcwyOnlm+ZX04tJLcrNJLECm4fdEs+1SukHoquNuKdapMRBTbFA
        ==
X-ME-Sender: <xms:NMBOXh5gW9DW_VmHBw2G2rJbcSkCbLDB3ab3Mdk8FfMFwAGmXYJdZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrkedvgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:NMBOXmewfMVZna6p87U6QqUTqxdkUT2TPDuxwOyHXJU9ZpvimFj_Jg>
    <xmx:NMBOXoGwMiiWv6LCVibC0HK3Ppdss-9frps9SgLoMTHGUraftXxyBQ>
    <xmx:NMBOXm5syPAax3Qji5RA2VsbgY0ut2rhdyQUPoU4ox94h9oucR10rw>
    <xmx:NsBOXpE_AC7_DOPIOVE5t_snJM9O6yxDIt5Wxju4LDxy0VFHvoVewA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4926D328005A;
        Thu, 20 Feb 2020 12:21:56 -0500 (EST)
Date:   Thu, 20 Feb 2020 18:21:54 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andrey Lebedev <andrey.lebedev@gmail.com>
Cc:     wens@csie.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Andrey Lebedev <andrey@lebedev.lt>
Subject: Re: [PATCH 1/5] drm/sun4i: tcon: Introduce LVDS setup routine setting
Message-ID: <20200220172154.22gw55s2mzyr45tj@gilmour.lan>
References: <20200210195633.GA21832@kedthinkpad>
 <20200219180858.4806-1-andrey.lebedev@gmail.com>
 <20200219180858.4806-2-andrey.lebedev@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c624jhpfn4hat26s"
Content-Disposition: inline
In-Reply-To: <20200219180858.4806-2-andrey.lebedev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c624jhpfn4hat26s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 19, 2020 at 08:08:54PM +0200, Andrey Lebedev wrote:
> From: Andrey Lebedev <andrey@lebedev.lt>
>
> Different sunxi flavors require slightly different sequence for enabling
> LVDS output. This allows to differentiate between them.
>
> Signed-off-by: Andrey Lebedev <andrey@lebedev.lt>
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 68 ++++++++++++++++--------------
>  drivers/gpu/drm/sun4i/sun4i_tcon.h |  3 ++
>  2 files changed, 39 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index c81cdce6ed55..cc6b05ca2c69 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -114,46 +114,48 @@ static void sun4i_tcon_channel_set_status(struct sun4i_tcon *tcon, int channel,
>  	}
>  }
>
> +static void sun6i_tcon_setup_lvds_phy(struct sun4i_tcon *tcon,
> +				      const struct drm_encoder *encoder)
> +{
> +	u8 val;
> +
> +	regmap_write(tcon->regs, SUN4I_TCON0_LVDS_ANA0_REG,
> +		     SUN6I_TCON0_LVDS_ANA0_C(2) |
> +		     SUN6I_TCON0_LVDS_ANA0_V(3) |
> +		     SUN6I_TCON0_LVDS_ANA0_PD(2) |
> +		     SUN6I_TCON0_LVDS_ANA0_EN_LDO);
> +	udelay(2);
> +
> +	regmap_update_bits(tcon->regs, SUN4I_TCON0_LVDS_ANA0_REG,
> +			   SUN6I_TCON0_LVDS_ANA0_EN_MB,
> +			   SUN6I_TCON0_LVDS_ANA0_EN_MB);
> +	udelay(2);
> +
> +	regmap_update_bits(tcon->regs, SUN4I_TCON0_LVDS_ANA0_REG,
> +			   SUN6I_TCON0_LVDS_ANA0_EN_DRVC,
> +			   SUN6I_TCON0_LVDS_ANA0_EN_DRVC);
> +
> +	if (sun4i_tcon_get_pixel_depth(encoder) == 18)
> +		val = 7;
> +	else
> +		val = 0xf;
> +
> +	regmap_write_bits(tcon->regs, SUN4I_TCON0_LVDS_ANA0_REG,
> +			  SUN6I_TCON0_LVDS_ANA0_EN_DRVD(0xf),
> +			  SUN6I_TCON0_LVDS_ANA0_EN_DRVD(val));
> +
> +}
> +

There's an extra blank line here that was reported by checkpatch. I've
fixed it up while applying.

Maxime

--c624jhpfn4hat26s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXk7AMgAKCRDj7w1vZxhR
xRPmAQCP8Snrmn5Bhh4728GFgDNTv5Vaa/Z6hDqOEA60JuEqfwEAjU5pw2xAgG6t
RZ127dNTQF3BXJ+J4Y6udTTvuGBrRwo=
=Jwt1
-----END PGP SIGNATURE-----

--c624jhpfn4hat26s--
