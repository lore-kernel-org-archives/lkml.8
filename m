Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DB9C3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3F220658
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="jYHVCyH8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gkNme53X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgBXJRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:17:53 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:53897 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727183AbgBXJRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:17:52 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id C28BD92C;
        Mon, 24 Feb 2020 04:17:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:17:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=bhiSTGzIzLvbB70YLw0z3IoRroB
        BdxIBBUPukc//z2k=; b=jYHVCyH8g9nqg/zYl17i16JkenbWeSe4RJkFKb5s81Z
        lH8dlS5LH0iiSiwf1Dil+3Wdq41wqQAjumX1SANJ+ZSpkZLPSTwFODD512b9bIru
        HMHmPInAWxKK127YRej+6Ky0Z2TqJLcGUynBj8JbOepWU2Ogot2FK3iBUfAOKj66
        SV7FxmM+DknYeeen3vd+jPRNF8RCiMoHtHQKHTfmaugKh6t1zwzhGMaLHD9X+hUT
        eYeWJQ2e7jAM9Ao5HHsYVYKbMzEzSN4mRAfmko31Of2LrRTJMAMZ9uoXtAxN7drN
        m6Hr+xSjN6rotrtKY+iKzXdjLryPlKGg3ROYJeR+qhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=bhiSTG
        zIzLvbB70YLw0z3IoRroBBdxIBBUPukc//z2k=; b=gkNme53XO+FnuMGD8Ajsen
        /9f0CKLdSml0Y1r6i0seq9WSo43MENIWClY7dNhuG6we46yxlOuau0jl73CWIfl/
        g79Op6PIhyeNbj9bsZUH0S+3IUPy+UpDm8ZefiK9RDAeobAl5koep2KY9IcYZPJ+
        OKIszKZa1WQKtw8x8sJBdsowYoKfiOeKoKXVs00KgQmGWfh/YNtRHqOGx6l40ezE
        rh3MBXbLIpUtaXo8Un3hQ3vi35JxZlW3WXbL2/1CMq09ItaewYjFJVibOue3yEx3
        qBdaQPgaSwOhNIHPpz8apDtyO8XuOoHRk94t2kRnY+N42/Iw4y/4TXdt1FULr4zQ
        ==
X-ME-Sender: <xms:vJRTXgIgw2wDuExCBeq6zdnhZF0iVR25zGUAXlo9VZ8AJGw5A-BPlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:vJRTXsjsjhxeKwrQoPnm5rtwyOjVeOWKkCFVbnaoOWCYD6bqStpCIg>
    <xmx:vJRTXlISsoyDpUvoYYqQ4RqyeogTyqkTf0ESLoCmNbeDLxaPCi3BAg>
    <xmx:vJRTXriNFGtQk4Q4cFjrmLG2ImZp8EbwrKF7HR8sjf0tPVgzIjJ6jw>
    <xmx:v5RTXkHlYQmCvoFng4iAFMxRUoATVKEp-SGW7cxOLkO_bgZUzcQmGA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 901E8328005D;
        Mon, 24 Feb 2020 04:17:48 -0500 (EST)
Date:   Mon, 24 Feb 2020 10:17:47 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Sunil Mohan Adapa <sunil@medhas.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add prefix for
 PocketBook International SA
Message-ID: <20200224091747.zwnvzosdb34tg5de@gilmour.lan>
References: <20200223031614.515563-1-megous@megous.com>
 <20200223031614.515563-2-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s3lc6so7ejypionk"
Content-Disposition: inline
In-Reply-To: <20200223031614.515563-2-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s3lc6so7ejypionk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 23, 2020 at 04:16:12AM +0100, Ondrej Jirman wrote:
> Call it "pocketbook".
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>


Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--s3lc6so7ejypionk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXlOUuwAKCRDj7w1vZxhR
xa3PAQD5b10L3aKPDDSM7Tfa1QeBY1g2L8BN+Yd10w4ekayS7wD8Ckd8fS7y2r27
5U3OK2rz8CdHy416LnVeOyTtiJosogA=
=ux3c
-----END PGP SIGNATURE-----

--s3lc6so7ejypionk--
