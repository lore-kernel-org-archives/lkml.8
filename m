Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47DEC47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 10:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0BB1206A5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 10:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="c6opjvGM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KX/tQ5X2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgEDKyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 06:54:00 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:48545 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727051AbgEDKyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 06:54:00 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 409376DB;
        Mon,  4 May 2020 06:53:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 04 May 2020 06:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=zvy14YHR+znGe3t+Hmjo/EjD6Mr
        ZIZqEI9VaeaWaPVA=; b=c6opjvGMp1R7qBwwuGO5veGzwSInNqfyNFTHkFEqsbX
        j2Qi2i9Zk+h3W3Ku1zJ+QkmW2OwV5oRKl+Mr7b6dyu+OyjsOXMPTMxqKAdu5e3Dq
        5tFt+4/glEyVTLkkQvvBZL5DrlAk19DdJki0sNbMlZib5ZakBhISqnkUk9eQ1NsK
        //De2EGAk39Slc9kYnfpZq13rlQlAFuaILbM2LMIlBbIVbfPYsJJliQIj3XjVu0w
        lvWDPI/UO+raTNSSBZS2Umgktlu4/cqO/+uwdvMw/XOKRuPFr2AOBKDa4erZJO7c
        fpbwGHXrzZ3+2mXUh8eOaYmkumm0ZLk8EN8yvrQoPmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=zvy14Y
        HR+znGe3t+Hmjo/EjD6MrZIZqEI9VaeaWaPVA=; b=KX/tQ5X2P4047WY26xXMpN
        b2CgOT0HlF/mo52lhJp+yhpQsKnu+ibT+PJ1jEtKnZVWRYysBPRFG2YUR4RnmJqw
        6OBL+cf6T/7Y8HjBrQ399dTvj18V44olYeF0EJOEM+N9wCxqWAynaj6ENjrazRqg
        luaWfHH0RdFX0DNJcK2qzRkoEgt/6KXQvlUqbRqYSOyL2t2upq4WVS3M88HNFMfg
        PlRTYq9YiCUjMMxzWA6QVAoMDmfn1j6VAYcZk1OBh9s/T9xOO9oV3XVtaYWkui81
        tqDrXwaPO15eMDcejU6DMYvoruFYQG5KEWva5E5bfg6f9tngKiNywMcl+8ltPxwA
        ==
X-ME-Sender: <xms:QvSvXrqoYQNskZQcQQl8xwEk2H0i7mx16kbdj2CwSsp896PWfE4N9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrjeeggdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:QvSvXrz30qCcw3ZnA9cGgvIkheGr5Uv1PDHJ_esRVMc_c9shi1md7g>
    <xmx:QvSvXtwKchh-vk1ZccyGeZifdTRpqXjrVnzC_ZQwyMegWklxK5dqeQ>
    <xmx:QvSvXiTlRe_4owVrv-vXfGysxgEDdVepPsQKo1J8bSEjnSDnHqtE5w>
    <xmx:RvSvXtrr16GO2RI2A-sj8RjTFJMAIassDdgQOLxHpCm5qhcP4UwqGA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5F89F3280064;
        Mon,  4 May 2020 06:53:54 -0400 (EDT)
Date:   Mon, 4 May 2020 12:53:52 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] arm64: dts: allwinner: a64: pinetab: Fix cpvdd supply
 name
Message-ID: <20200504105352.m7x3yo7ne2j2goas@gilmour.lan>
References: <20200426162353.52465-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3rgwd3wzs7dmr2rs"
Content-Disposition: inline
In-Reply-To: <20200426162353.52465-1-samuel@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3rgwd3wzs7dmr2rs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2020 at 11:23:53AM -0500, Samuel Holland wrote:
> An older version of the analog codec binding referenced the headphone
> amplifier binding as "hpvcc". However, by the time it was merged in
> commit 21dd30200e3d ("ASoC: dt-bindings: sun50i-codec-analog: Add
> headphone amp regulator supply"), the regulator reference was renamed to
> "cpvdd". This board's device tree still uses the old name, which fails
> to work at runtime, and which causes a warning from `make dtbs_check`.
> Resolve both by fixing the name.
>=20
> Fixes: 674ef1d0a7b2 ("arm64: dts: allwinner: a64: add support for PineTab=
")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied, thanks!
Maxime

--3rgwd3wzs7dmr2rs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXq/0QAAKCRDj7w1vZxhR
xfCMAPwKSTdj7Wj0M2iBjxXSpxos0dEHNj3F/XGvsdNIlb16kwEAz/3eiEZHeaVM
aqGK08WsKBWeCCBX/TXwIfEoD21ruQ8=
=/g+o
-----END PGP SIGNATURE-----

--3rgwd3wzs7dmr2rs--
