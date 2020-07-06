Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA49C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 05:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A9592082E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 05:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="XxkxVykz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qHN3RnzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgGFFYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 01:24:24 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:34459 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726020AbgGFFYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 01:24:24 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id A1BFD5804D9;
        Mon,  6 Jul 2020 01:24:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 06 Jul 2020 01:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=qqcTrt1S9WmQ9Z3ANHKZn0/p6Me
        BRjl8KA/a+ywaFkA=; b=XxkxVykzNjq1Ig3avm0J5owdxx9mxKUnsfDFMfJ3QYy
        I3kyowcQr68Q8bYnY1Kf3tuCwgaVtbOwrECl72SAwK39gb73OlOZIH35T1PHoV2T
        CFd9gTL5AoWzcuouGAbrhz6Be2i0rY/RMiEUXyL3H2Z70bjgWG3AWvZArDNFzlGt
        PuOej3sYEUUB4vQ463kZXbZB6k9oxHFOPzVwA57iMEkH7Az7GYYkYIIvy1YIdXpi
        a/woGzW+MsW+a5w7rso9YGrRrYnwGkLzBK3F1swdmll+yhIzqZrSH4Ea5RgUqIO3
        bcsdGHdOViQ0e7uJVc2f5DoAObMuhGqq/LnBl+cbiwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=qqcTrt
        1S9WmQ9Z3ANHKZn0/p6MeBRjl8KA/a+ywaFkA=; b=qHN3RnzZrED/BLLtVW41LL
        FKroyEWMH0NqFCehoSNpb34IG9ZiPwEOIVAVEz+bmgz4365edJ5eeL7dPmeI8QBH
        GvF24Rg6HN2Uf/YSQPZ1vfoPWWPyUl0lHYtpkeaqOzrkusRl2SpWqGIrHlN1kW8N
        V4I2phZhsICjUDgOAIZS1MTwPi3rXemr/Vs1G+pMfeFfiDcxQfB3jnt66oSDa7zW
        UiFveU1g8WbtB/AwovWWn1Hbw5lx0QytMsXu+uun/yjYIOxF9k04cvmYZL/W8gVk
        Nw5ndJ1zx2ZzYwdiJKNmHopkYg84RTiHLQysMxtGWr0cdGj5qr9dRTvsQusijVFA
        ==
X-ME-Sender: <xms:hrUCX42IHkfFaxICK6EJFOauQuROSPKr4JvO5MuC485cQIhaW2MnoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdejvdfg
    veenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:hrUCXzHuoCYcSi6rYRarfzU6QzREhmGRgZxbicYU4YtmazSd7Ob5RA>
    <xmx:hrUCXw7JERM3I-DKe57rt34HicGwiuuGGztYGhqk9yrl9SQitCXzkA>
    <xmx:hrUCXx2bANuk7PKZYScTaNXMTvG_0FbBycnQyFcT3xOaWrhzd61z6w>
    <xmx:h7UCXz8-a7MdBY-xRPmd38SGkdBs_a7On6y4n5cBs82Uv36DSH2ruQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 14E0D3280060;
        Mon,  6 Jul 2020 01:24:21 -0400 (EDT)
Date:   Mon, 6 Jul 2020 07:24:20 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 06/16] ASoC: sun4i-i2s: Adjust regmap settings
Message-ID: <20200706052420.k2ggqpnb22pcqgyy@gilmour.lan>
References: <20200704113902.336911-1-peron.clem@gmail.com>
 <20200704113902.336911-7-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cgcntdw5vnpge4k3"
Content-Disposition: inline
In-Reply-To: <20200704113902.336911-7-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cgcntdw5vnpge4k3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 04, 2020 at 01:38:52PM +0200, Cl=E9ment P=E9ron wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>=20
> Bypass the regmap cache when flushing or reading the i2s FIFOs.
>=20
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks
Maxime

--cgcntdw5vnpge4k3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXwK1hAAKCRDj7w1vZxhR
xSYJAQDpkLyk6Txs2qDTp05ZoUuIJ8mt50NcgYgzKq98a9c50wEAh9RWsf0GcbDn
/XYnwdbRBF9aQb9Y9C9lJ0pMLkSg7gk=
=p247
-----END PGP SIGNATURE-----

--cgcntdw5vnpge4k3--
