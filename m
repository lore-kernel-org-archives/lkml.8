Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B36C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2E0214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="YuM3SuKZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fGXN3cXW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbgA0JnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 04:43:08 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57469 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727295AbgA0JnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 04:43:08 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id CB9F221AEF;
        Mon, 27 Jan 2020 04:43:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 27 Jan 2020 04:43:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=bshoA8LerED0wuEUEdmFMI+f7iF
        /vCx4mlFcm2okIV8=; b=YuM3SuKZ/qWIx8fc8/D8qwqXAozgbrwbsYJja2Zlv81
        XT9jImVbxwhcyHbuMkLglRtXIsEs1/zR+7npMRtE7MGNM+XvQ/8TEKgRJ82evN76
        bjwOzzxn+slwAJ+Obeb4eZlfD+6BmVqhknaxcPsZejPBvZiRMUo3eZ+Ycggkf/cG
        x8hjHaqKo44nSxBUSRFJXCEzBbwER9PxLBj1Hw5MQjfyAamM8hqU3xCKHe4kMA4p
        Cvy4lP5DzOdbs1dvcoFFS2pgH1qViYY3/zfqTYBsk8uMepkvTsqutsNKdlEpKfCi
        1uittLHkkwgPkxAbLi/5zd0eteGQSi4yavd6J55bNSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=bshoA8
        LerED0wuEUEdmFMI+f7iF/vCx4mlFcm2okIV8=; b=fGXN3cXWrg4TI5NwQ4ptJR
        URUsqufC1EDh4HOHPzKq+2n4IcAPnXy9VcfdUIWK+ILio7WLonJd5tsPVZXmaQyz
        Azw4eipA4fsjtj/5yJnXutrB9VAr2HUt8EltWzdDhV+Z2uhfJ5qoX1yi5e5p/JmQ
        nkIFQ/KeFzxAhIEhsSfNDCabF90rJfJWXcZEFxhzyA52+8KdCmSOd6heJ7I/f+zK
        /FcbhfQaTLljF3E3lVDNOS4PdfQNKcZyg/umMdwLmiXNxFryeYEm0wFVqjc45SJj
        OlHNA7AEJiMZxfpItC5IV1Ibt99ufUVpceC6I8D3Zb4/TTlFHU71vOKCWLZzQD0g
        ==
X-ME-Sender: <xms:qbAuXpK-tYARlgxTRiGmjozSSUkbqvQpPgQ3TsXNSnVo88QF9j3ZUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrfedvgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:qbAuXpZFVgKhv7lEooWFM4AOLgUnAkZpuCYz2B2UqnPNJvMmlHCrjQ>
    <xmx:qbAuXstRM30ZETJDUrA59elu9e8sy4kMimPKym8pjTw_0KeldMIDzg>
    <xmx:qbAuXus-eeriZAQJtHU6el6vhyDBpY-hV6U_3G7HPWG1MDb4WRZjFQ>
    <xmx:qrAuXp7tpbVK-vUDA1DnLpw5htIQ-MKHYeYWnIhmxTWI9TmLWT1zDQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id E78D4328005A;
        Mon, 27 Jan 2020 04:43:04 -0500 (EST)
Date:   Mon, 27 Jan 2020 10:43:02 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>, wens@csie.org,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "drm/sun4i: drv: Allow framebuffer modifiers in
 mode config"
Message-ID: <20200127094302.f3s4caona5is7gd5@gilmour.lan>
References: <20200126065937.9564-1-jernej.skrabec@siol.net>
 <20200127081419.GA25668@aptenodytes>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dboxkgv3c732tn6y"
Content-Disposition: inline
In-Reply-To: <20200127081419.GA25668@aptenodytes>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dboxkgv3c732tn6y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 27, 2020 at 09:14:19AM +0100, Paul Kocialkowski wrote:
> Hi Jernej,
>
> On Sun 26 Jan 20, 07:59, Jernej Skrabec wrote:
> > This reverts commit 9db9c0cf5895e4ddde2814360cae7bea9282edd2.
> >
> > Setting mode_config.allow_fb_modifiers manually is completely
> > unnecessary. It is set automatically by drm_universal_plane_init() based
> > on the fact if modifier list is provided or not. Even more, it breaks
> > DE2 and DE3 as they don't support any modifiers beside linear. Modifiers
> > aware applications can be confused by provided empty modifier list - at
> > least linear modifier should be included, but it's not for DE2 and DE3.
>
> Makes sense and it's apparently the norm to not report any modifier blob
> when only linear is supported, so let's stick to that.
>
> Note that when the reverted patch was applied, the core didn't set
> allow_fb_modifiers on its own yet. But it does now so let's rely on it instead.
>
> Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Applied, thanks!
Maxime

--dboxkgv3c732tn6y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXi6wpgAKCRDj7w1vZxhR
xavxAP4+7B2OvLts72lO+MlX4gW/ovZVA2uVk36MX4C/iIDjEwEA5luy/xFLJESN
/5djBA1bCYNq8JOCyHu+M8HYXgQ0DQE=
=qG/B
-----END PGP SIGNATURE-----

--dboxkgv3c732tn6y--
