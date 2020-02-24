Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B82C11D2A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6DD20828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="oQm/TvZr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TB1cVtI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbgBXJUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:20:23 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37287 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726687AbgBXJUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:20:23 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 2A13C213F4;
        Mon, 24 Feb 2020 04:20:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:20:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=4FAYsRBkOa26LsnccPdAjqvJIED
        dTNwKyyIBqp33KCo=; b=oQm/TvZrb6E0KKtZjwj4oLmuTwNtRu/ZzfE8hYWtGcp
        Zdlk5Rwp2eM4hzTMgk/zutAqvI5olyTeKBkqKpQqYDxJUrPadyonrEahuzKoYPGt
        BJcPpyZhrhXPO49WwV+BqSSxTHYrJ9F4v8Duld4dARf9Ro9MWfHNOC/+o73uV4hi
        zY2bLJZWQzf8IDygpnMkZsYDSR62WPQiF67k7cJ5nA+5UMHAah92TRUp2Ivy2YM5
        zxvRPRHyhMMxym8nohwPbiicTedXrCBcj8UwUNs2khX6dlUEByH/Fu1Me2znAOT+
        gO4lAXCNzFWw+IheiQrz4ibItuWxp5FIGPDBl063TpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=4FAYsR
        BkOa26LsnccPdAjqvJIEDdTNwKyyIBqp33KCo=; b=TB1cVtI7pUAdoX37U/vKc+
        Q8DsIeECEz6n+zWjYKz74EGrCWSY3QVqyIh3POnjEmwHUcy++O4DYzdi50bL8w7x
        tekaRk8Xbqj/a3hHrnGNcfA+5s2LZ2ySXvYcRcnIdGnk/8vOCvPJcrEFGpaGeeAD
        1Q10CgytV8KHt0KWHgf/SnHUFVaSQITQThsxN6n9Keo4a9RKIc9m2yzoFsvbbE/P
        fAsfTk0uEwrEMwd4eYzM3C/BQb78eg1Q6cG/OIZdy9ND/MYWP1ww2Rz4UOXWNaqT
        6m79mZj/UEdzzJzLthinl/9cxavc1Ma4vcgDaiFomsGcUOv9kdwZrAsYVskMD+eQ
        ==
X-ME-Sender: <xms:VZVTXivAV4qTGhIgkivrNTDdStEHgW2t2TFf9F9v1LOD1VJzrWvfOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucffohhmrghinh
    epmhgvghhouhhsrdgtohhmnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnh
    hordhtvggthh
X-ME-Proxy: <xmx:VZVTXrtAzwF5qL7tKYhe4jpESrv0JcEiS4SRjdfhNF_90G2USVAnAw>
    <xmx:VZVTXqtJstnCcUjycgKQ665U69xBH6prjVnV3GQAYXHzJ_Q9LEV-wQ>
    <xmx:VZVTXr6ATPbOEfpWow4nNkbdeUAZAxBYlWTrn5sV6vvnpq1CKgUfJQ>
    <xmx:VpVTXknoqFgA-zhEBQqERw_FNEFnXT1zmzU6JVrsYQoSIJkpUdDMkw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4C12E3060F9B;
        Mon, 24 Feb 2020 04:20:21 -0500 (EST)
Date:   Mon, 24 Feb 2020 10:20:20 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: sun8i-a83t: Add thermal trip points/cooling
 maps
Message-ID: <20200224092020.xxru2rkhrywonrx7@gilmour.lan>
References: <20200222214039.209426-1-megous@megous.com>
 <CAGb2v647zKVrDvnHeLvwNPEZLX+yTgPq-x7MJkp9=duzkQN3mw@mail.gmail.com>
 <20200223101050.lqe5uegpmoyqvna6@core.my.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2s6qec42w4cbjxw2"
Content-Disposition: inline
In-Reply-To: <20200223101050.lqe5uegpmoyqvna6@core.my.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2s6qec42w4cbjxw2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2020 at 11:10:50AM +0100, Ond=C5=99ej Jirman wrote:
> Hello,
>
> On Sun, Feb 23, 2020 at 11:29:07AM +0800, Chen-Yu Tsai wrote:
> > Hi,
> >
> > On Sun, Feb 23, 2020 at 5:40 AM Ondrej Jirman <megous@megous.com> wrote:
> > >
> > > This enables passive cooling by down-regulating CPU voltage
> > > and frequency.
> >
> > Please state for the record how the trip points were derived. Were they=
 from
> > the BSP? Or the user manual?
>
> The values are taken from the BSP for A83T:
>
> https://megous.com/git/linux/tree/drivers/thermal/sunxi-temperature.c?h=
=3Da83t-3.4-bsp-tbs-a711#n747
>
> The datasheet only mentions recommended Ta (ambient operating temperature=
) range
> -20 to +70=C2=B0C. So die voltages will be larger than that. I guess that=
 roughly
> matches the BSP values.

Can you put that in the commit log?

Thanks!
Maxime

--2s6qec42w4cbjxw2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXlOVVAAKCRDj7w1vZxhR
xX3uAP9BHDiExokGZnYdS2Hnvg/6BxQA+lI33CwXBcAtyDDNygD9Hd30W+Yao0Js
DAIsy3WRebkWFb2c2O+NCt21wer90gI=
=pwbG
-----END PGP SIGNATURE-----

--2s6qec42w4cbjxw2--
