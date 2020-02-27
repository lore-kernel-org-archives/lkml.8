Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48B9C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA3524693
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="uG/klM/B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rgxzXkga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbgB0MxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:53:22 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:37111 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728977AbgB0MxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:53:22 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id C87BA7B64;
        Thu, 27 Feb 2020 07:53:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 27 Feb 2020 07:53:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=dg1VFIcvLaP5nEziGd8HsDrRTUd
        L8mTlPmPl1XUFXJE=; b=uG/klM/BtKxPTmdRNYbM/h0HAUCJyd6uIETqfqLgc0h
        TjAvIbSzalBF5heUpNpFRY7LAOV9HNkBg3OF1nQtSBJ7Vely0EfRvxhrdMtR4bH8
        5LU6GPiyVr5hEywDLSYcy9Vfj4Fn30239rXRhcI0ICFiN3/le+GNe1sQVgSz4V1q
        RI6uFABUdqDV2K+ZzFK7T90M2JOrZFBhDY90qckU6HsgAYTVZTLdsk011FgJRE4z
        YTQu3O/cnjcZC9pxTAWhrqvTCKZq1za6LATLV2GMngczFkXKmsi2BgxarR/KY0uV
        dB77vZ/e3ieYcfOUTc3EgjqG1llXe51VQaEVpQ71LfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=dg1VFI
        cvLaP5nEziGd8HsDrRTUdL8mTlPmPl1XUFXJE=; b=rgxzXkga6Vz/q8ibvePdKE
        Q1LaW0dAHbPN75tiF5KgNerBw+BQ7k2Nfituc90tSyPhT41a0MT7dqCgST/I2xFG
        yRJk3dgI4UngaI+fz6lmrQ9AtmM6N6pKydzrQ9gwmwKJAtI5iNB++FoYlh3k6AOC
        SoJ70Wm28m57V8nnonWCsBMP5YNL2tJIWgKYqQ2Qzx6cz7xNNQIwyCnOXGOh0gHR
        qTEB++5skRk8GVWg+qFArs49ztDOPr7C1kNEo+Ky/dGyxiUcOfiPDaeXYbi56eSE
        Lr/6ULMfdoZP2lbLl8AgwvVhbMLRNOZaUfqMfby2S4DwU3VbY2JnjqOLMnZ5bsOQ
        ==
X-ME-Sender: <xms:u7tXXhPmXN-3uOFEGLxT6i8bviXJjba7XPp3Mqomr2-86hzBb-AUtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleeigdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:u7tXXtR3tAhbApasVu6ORLm8rRDds7FKoh144uLnSOYnDxc5SOvyng>
    <xmx:u7tXXnhMZY6frqiLbiRBaCfP18PdiQcpyTen05GZux-_yHq6iPBEeA>
    <xmx:u7tXXu99pcF2nr3Ck4I57eEN8zxtgjvOYl-JVYm9mq7QJhHU59iPGQ>
    <xmx:wLtXXutVnkivB2V07VUGn2mpjvFovmqwJdRDEr8gpuWWZVSbI_UXMg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 880793280059;
        Thu, 27 Feb 2020 07:53:15 -0500 (EST)
Date:   Thu, 27 Feb 2020 13:53:13 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Torsten Duwe <duwe@suse.de>, Icenowy Zheng <icenowy@aosc.io>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 6/6] arm64: allwinner: a64: enable LCD-related
 hardware for Pinebook
Message-ID: <20200227125313.lvgflcik4ra26m2r@gilmour.lan>
References: <20200226081011.1347245-1-anarsoul@gmail.com>
 <20200226081011.1347245-7-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3bq54ytukgsvs3eu"
Content-Disposition: inline
In-Reply-To: <20200226081011.1347245-7-anarsoul@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3bq54ytukgsvs3eu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 26, 2020 at 12:10:11AM -0800, Vasily Khoruzhick wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
>
> Pinebook has an ANX6345 bridge connected to the RGB666 LCD output and
> eDP panel input. The bridge is controlled via I2C that's connected to
> R_I2C bus.
>
> Enable all this hardware in device tree.
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Applied the 6 patches, thanks!
Maxime

--3bq54ytukgsvs3eu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXle7uQAKCRDj7w1vZxhR
xaczAPoC3ALs6FJiOTdBAkkgLMLeU5xSuyL54sh1Q4tkALRViwEA+VH+kLki+xAR
3WxVIhBlXQvrAtrSbtL5C0Md5xmCsQo=
=WsJg
-----END PGP SIGNATURE-----

--3bq54ytukgsvs3eu--
