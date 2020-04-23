Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F358AC55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBB8E2077D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="f1HMyR60";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JUvTWXOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgDWJoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 05:44:13 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:35547 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726346AbgDWJoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 05:44:12 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 050DF6D9;
        Thu, 23 Apr 2020 05:44:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 23 Apr 2020 05:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=yTSdBL27L0HtM6cxIp18248+BCj
        5HmxK6PmNzKhh3oY=; b=f1HMyR60bY8nyFlkzaXnGTkz8BNUtPwIhyzWNFDXn95
        fCSarO+Liz5ZhsfMc3JhFsx1Xs//yoNa1+0k2CjAGLWc+xaZgRPN4Tmk7DUvD0YF
        rbbtsHMk3MwkAG4a1vuJD3h/8BMPu1n1H3koFozDdbKOvQ19evU5FhaEN1oIcWKR
        FXGCV8HgJyMPL/XH/uKh2hAMT6IcOYkvLbcBrAvuk57hNAqbO0cOC0klmAdi12u1
        uEnCOupZk454nnnORzfNS4FxNlh8jmoLaxgo3I+rmtCygjAykrXdNhe1JSx5gsvg
        sON/UnUlYPzQv2S211eJ4SORsZv1t3b0K2bbwwf1lqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=yTSdBL
        27L0HtM6cxIp18248+BCj5HmxK6PmNzKhh3oY=; b=JUvTWXOhDBjKe1CGF9kkoQ
        cK+d85sUETQ/elG6cHsB1FWx2uXeBd4noYmcYx0C0FI5Fv+1ahTVEKdeE3zdrj49
        kt8EHkzHrjgmFdQwdS7vePyJfn6eYtX0bqqEvzbmGyVvyFN7oyC2q29319IZD5Fn
        GfMSgJrO0Mm66fQtjKV936ZdfgT/OvV2W3lWJce75wszI4rBqislBkguo7bKLXB2
        +9bCz1p2lSAUZTORwrhsD/dNtSzN4VLUVoCHJ5NWpndcg10ZaCUumeHsyihoR3/s
        EjjUXRLXPR8TQ5yE/mj0/SdkbCLLYNuVI39nCYbIXj+kfYz9yRKIdsY7fdWCzxeA
        ==
X-ME-Sender: <xms:aGOhXnQWZGxdwbYT5O8DLxkp6l_0R47bUq1Mf8-_LzUI6a4oVvgzBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrgeelgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucffohhmrghinh
    epughtshhirdgrshenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrth
    gvtghh
X-ME-Proxy: <xmx:aGOhXtVaNUCw8t52e84d5lgOjrlpSzhg54eR-z_HaDeDXYpLI7AMag>
    <xmx:aGOhXp-Kj_mkXIEswmsQnkPQi0Fu0CqAgrJToyPCOROd8N0p-F3Qcw>
    <xmx:aGOhXt1w-CfTg7VeKrf_Xp86c94pm30803OtsqrGAHsqeFRGaB8V_w>
    <xmx:amOhXnxIxPIOQIZqjLYXzU9B1ONDvPIHpdOCSLrNahrf4GOs7AWPzg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 48B99328005E;
        Thu, 23 Apr 2020 05:44:08 -0400 (EDT)
Date:   Thu, 23 Apr 2020 11:44:06 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH] arm64: dts: allwinner: h6: fix cooling-cell property
Message-ID: <20200423094406.eklbvj4n5wqoiqgy@gilmour.lan>
References: <20200420143016.16835-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rfqdufxyhslfmsyh"
Content-Disposition: inline
In-Reply-To: <20200420143016.16835-1-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rfqdufxyhslfmsyh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2020 at 04:30:16PM +0200, Cl=E9ment P=E9ron wrote:
> We define cooling-cells property for CPUs only for board including
> the sun50i-h6-cpu-opp.dtsi. As not all boards have the CPU OPP
> dtsi file included this create a warning because the cooling-maps
> is defined but not the cooling-cells property in CPU nodes.
>=20
> Move the cooling-cells to the sun50i-h6.dtsi instead of the
> sun50i-h6-cpu-opp.dtsi
>=20
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

Squashed it into the patches 2 and 3 of your series,
Thanks!
Maxime

--rfqdufxyhslfmsyh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXqFjZgAKCRDj7w1vZxhR
xbCxAQDUBsEqD3yTS4praYqwY4PKSgPpxVdNokuUTqeFd6GzQQD/Trd+l6jCnXgp
rWz0egIitLYCHooKA8xBXnl+uhY7FQE=
=/LdK
-----END PGP SIGNATURE-----

--rfqdufxyhslfmsyh--
