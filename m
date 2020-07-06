Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E40C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 05:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 913582067D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 05:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="pKROQzTh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="psUvSDYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgGFFZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 01:25:24 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:40915 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726020AbgGFFZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 01:25:23 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 895A4580508;
        Mon,  6 Jul 2020 01:25:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 06 Jul 2020 01:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=ILtDYkio/SxGrWXtWU7LPyleNA3
        WUTJwA9dGmCAgkyw=; b=pKROQzThHBEr3YKqA4b5+DBlRQ5YqCAY6brTw5BnwVG
        YSvPlOXP1YXl67f1BpwN+nD6Apve5wYvfjPRszyzFqe61AEDefGo/EG4LvRKdJgV
        y7ZmfFBcdKhnlGeHbEBNX+gt4NtRZUlWF0WAdFxP28SqoDk6uNTthwVLvs2BZ7ds
        7vslUokACLpO1o4Pkym8rQml1Gr9jz23/g6CiW6pqarwuBTBrw5gXXhrytwjZm10
        vs49tOls91eObKrGS0DLDTZiRtdLQzXBjQAl2jBOhP4WZm0t/XB/k8JcZsmtO1yo
        uBkGLLc4hvyzR9Q15fCJkuSf+fVbc1uIBHJRX6fSEMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ILtDYk
        io/SxGrWXtWU7LPyleNA3WUTJwA9dGmCAgkyw=; b=psUvSDYHzkbxrV9w+cdSYZ
        TVXoE5M7QJ8ZGXDfudSqtgOqgalwyjTqznZmtxROQmT9XzTw+1qBIzJQcj61vzC+
        /TuNNT2wUaW5bXFFef+HD1JgeanjyNu0eKmHK3G48mpXETIRt2UwhO4GFomHKDFm
        pGcCyYHcsF1zYOWfjk/K7mVWzdgmZAhQDg3DGr0RiznDpOOiNnkMdRsSHsUDqrlU
        HpTxQ6uCwfJPppMemHc6e3rjxR/NW6BkgBxIrA5AL47wi7rkcCo5mPgy0kFSrLsI
        x+/CJimEijc0kbf9SZPKFsKrAgMK9hFq+V1M7lnyDpeh0PCdH759LCc0KnQgbayQ
        ==
X-ME-Sender: <xms:wrUCX2dBjFwvsvtOxD7_RvlqJiR77MYTDLvtd2ZitXC0_2p99A93XQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvgdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdejvdfg
    veenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:wrUCXwN_ZE8qGSmdak-441G_T38ovrUYtStxothvrUCQywRRYT0nGA>
    <xmx:wrUCX3geC8BW4QRTddTmUYtaV9EapVt84LCGzSiw7-Qzr3hBxNUTUQ>
    <xmx:wrUCXz81ny3fJebnTlAQ7YH_1ICOezutZe9Ub09HklsT1wnDLLPP3Q>
    <xmx:wrUCXzl98WTYIhwjq6_AkhE7oFYCnt3-WCunjYPPtlA7Zg0WGe3bZw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 27FE630653F0;
        Mon,  6 Jul 2020 01:25:22 -0400 (EDT)
Date:   Mon, 6 Jul 2020 07:25:21 +0200
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
Subject: Re: [PATCH 07/16] ASoC: sun4i-i2s: Fix sun8i volatile regs
Message-ID: <20200706052521.cpsqkd3yadrzbu7u@gilmour.lan>
References: <20200704113902.336911-1-peron.clem@gmail.com>
 <20200704113902.336911-8-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nj26snxgljor52zn"
Content-Disposition: inline
In-Reply-To: <20200704113902.336911-8-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nj26snxgljor52zn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 04, 2020 at 01:38:53PM +0200, Cl=E9ment P=E9ron wrote:
> The FIFO TX reg is volatile and sun8i i2s register
> mapping is different from sun4i.
>=20
> Even if in this case it's doesn't create an issue,
> Avoid setting some regs that are undefined in sun8i.
>=20
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

Acked-by: Maxime Ripard <mripard@kernel.org>
Maxime

--nj26snxgljor52zn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXwK1wQAKCRDj7w1vZxhR
xXHGAP9d880O5SZa3z/uz3yCWB6TSyGRZRO+OMed5HGlkeLCKQD/YIx7mGEurwoI
Enjw6MbwmQcouqRr3IIZqVom3vvcQw8=
=5Pi2
-----END PGP SIGNATURE-----

--nj26snxgljor52zn--
