Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23B4C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4AA20714
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="oyGr9tAx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lMnCqBKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732452AbgDAMOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 08:14:46 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:39845 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727661AbgDAMOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 08:14:46 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id A16716B7;
        Wed,  1 Apr 2020 08:14:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 01 Apr 2020 08:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=riGmB2diO+qhO4m3ef50ZIgs9zg
        sZUj/MkF7JyIQwJI=; b=oyGr9tAximrzsF7O0+NzcvTkxWcOu82jh30GU02HAxV
        BgTEVeLBTUDvHDh7ITnIJyNlUt00vhabS8R0WITPRe2IpeO1S1rtb7aEmW0YZqqI
        JEX5QTivfKgwQTc+FDuRiF69oRTTluCLmbS3QS+6iT6yiPBvnw5I4YANjrelYJQd
        sPJTFKlJdh1Z41hPTMS4n2LaK2tYZtoOXWP7sRA7Nx5dPjsIiFlGJW3w3ZFQaHXG
        5XD0QAdZpZ/lEbD07a6eM2UgCpe9nU13BhSmFeAdlELA6btZovMpR9MJFgt+RA0K
        yazrZiWlCbBJR1djx8+f0vL317MBN0PwZi7Y29rSbzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=riGmB2
        diO+qhO4m3ef50ZIgs9zgsZUj/MkF7JyIQwJI=; b=lMnCqBKyKZuaWaiUIcHsJF
        zQjfxXc2s10I3qFb7O/EBhgSmp70u9lWMrdOq4MvliWiag6ynPWeFbtXmOTZ/AGt
        8U22yjKFIcZ+l/sT4hzjcCq70vBo/04xUEHYog865lQltLnZ78LqEPJYWZH7I1rM
        rco6uLw7ywHp6T32IfDoFN2tkbG4YLYfigm1KM6JIl9xQ+PyQ30DPPOAjMGismHX
        eRKBtnOc6CwlOYA+59F0etlzgI8utmnlnBxFppekrmO3KG83kH2b2lx9PgIQ6H5R
        NC6u4pPkSe85PYHHW/yUYQvoYJ+dqqXmR1ITpNc6n+kFiaxmC7t1h4lvZC1kgYyw
        ==
X-ME-Sender: <xms:soWEXg3RSaHT0QnHe8K7B-YKWUwa4oSvE-68KVwZJW7yxt2PhhtBpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrtddvgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucffohhmrghinh
    epkhgvrhhnvghlrdhorhhgnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnh
    hordhtvggthh
X-ME-Proxy: <xmx:soWEXovmjV_lepey-Hk9z-G609gxrC39fnoWQlr4ulRUzoJDCczXAg>
    <xmx:soWEXjjB9i-vcMsuOCzUZ-xp8lYxTEjTc2-egSPpBmNMBduCdJK6pw>
    <xmx:soWEXjyQqm9lJqFo_-NO6Q4Utr8G3YOhjh5X-s9ptvfPDc-kMS--GQ>
    <xmx:tIWEXiaFArDSF4BzmWCAud29O9nzIE_QM4Var0sTibOeTakTOPQweQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 462C6328006A;
        Wed,  1 Apr 2020 08:14:42 -0400 (EDT)
Date:   Wed, 1 Apr 2020 14:14:40 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andrey Lebedev <andrey@lebedev.lt>
Cc:     Andrey Lebedev <andrey.lebedev@gmail.com>, wens@csie.org,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 5/5] drm/sun4i: tcon: Support LVDS output on Allwinner A20
Message-ID: <20200401121440.z4hj3g5nnrpehhy6@gilmour.lan>
References: <20200210195633.GA21832@kedthinkpad>
 <20200219180858.4806-1-andrey.lebedev@gmail.com>
 <20200219180858.4806-6-andrey.lebedev@gmail.com>
 <20200220172512.dmjtqgyay73x3ubx@gilmour.lan>
 <fa780b70-f1cc-ee4c-e779-089c7e9159ab@lebedev.lt>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4urpxa7m4yqglfam"
Content-Disposition: inline
In-Reply-To: <fa780b70-f1cc-ee4c-e779-089c7e9159ab@lebedev.lt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4urpxa7m4yqglfam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andrey,

On Wed, Apr 01, 2020 at 01:59:27PM +0300, Andrey Lebedev wrote:
> Hello Maxime,
>
> Since Linus' merge window is now open, do I have to do anything to get this
> merged into the mainline kernel?

You don't have to do anything, it's already on its way to Linus:
https://lore.kernel.org/lkml/CAPM=9twza_DeycOEhT+u6Erh0yFTAUe447J6bxWCLq5+QW8ZaA@mail.gmail.com/

Maxime

--4urpxa7m4yqglfam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXoSFsAAKCRDj7w1vZxhR
xTv4AQD3RW3fxzBC0un1iccyOIDGwU4RRbxjDXtwj9WeWzIBdQD9E2WACdnxoyZs
vikDyWZGzFHhl6C5fZJdL4IWWCh9Pgs=
=ndqj
-----END PGP SIGNATURE-----

--4urpxa7m4yqglfam--
