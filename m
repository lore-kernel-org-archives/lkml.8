Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B68AC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29AB6204EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="EpCifEom";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hO/KnZpW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgHYNjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:39:37 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:59075 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726661AbgHYNgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:36:15 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 305A0CE5;
        Tue, 25 Aug 2020 09:36:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 25 Aug 2020 09:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=ijja1zd1NrI/KqNd5QwvwVeI+/N
        wFID0Zk+H/Ib8Sf8=; b=EpCifEomFNpLiC32fhxlKOIVd+6jRivaUp2ddKQCsQd
        zRxi5vMq558vHws5iChP5gN7MawflsjU52Yqnbzywic21/eE9AI2XwX/s9y5ppqf
        1jaItK3u489q3AiJIs3FY8X0+jltZRB255Fb/Javq4DyqdYRa5Jp6w3h7cOvkjFN
        zRTUqFUjKZE6RvbckIT9mgdMugj+ajvd/8g8SrtssPn6vbkXjn/AXGq8z3WDgvbR
        PFU80Cg2ILWxSa6BnEiS+Ch24yP8wqwmnc2CZtnw/8AstSysZUx4QKRFvWog77Do
        0751FMiA+lONZp2kwvXgh7K3MYN9SjkMK3gAVlGa62Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ijja1z
        d1NrI/KqNd5QwvwVeI+/NwFID0Zk+H/Ib8Sf8=; b=hO/KnZpWpva2pkWv83V455
        WluLNIVYGYkaEPrkhy4fYbIYW2BekC9Hh4J/HM4YOyp5Lm4jP5AVvNRz3XH91uhI
        OIVObhsi3IUwaUXThcFf8Bs1se5R+XtD8l0Va3GyAJMbb2cIEiHLgqZ6bFECRJ+S
        jU2bzLdNCRP4MuW4zYPoTfaNWCjdxGPdmVqgQfG+tlT2QJ+4tLoccFLGYHIz4c5z
        vuVAnr8c6LVayvh5EZas7ysp5so1mZ2bxXxFGfJMLME1zWPjzhQrQxeBY2yZFQ+F
        jyRdedQsx5vXvINuNueYQyWef39qFOsSTgeGoyrPzV0m5ZZB3mW05Kx3hEM7UbXQ
        ==
X-ME-Sender: <xms:zBNFX-Wt7Sqp1VX5Ch1Wxova3TW0ILo01uyRBIvCxi3C9jL29UMCEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudekne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:zBNFX6nkgP6_m4jPRsfVpk3KUUzP3qC00EL9e9NEfyISsM22Yh3bbQ>
    <xmx:zBNFXyaKfXuldkmN3FNWfkwXZIdykVj9iHoI9VZtEHkHRC4P2GfPzw>
    <xmx:zBNFX1ViffIuC0jdtK7TgT96yMB_GIKh4bj2aYe1ln5ALD-pky8KrQ>
    <xmx:zRNFXyd3w2sHe6WP61uQaDKkdukKp8RGA98ZToxCPKtFtb-JrJgONXZkTso>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 960A230600B2;
        Tue, 25 Aug 2020 09:36:12 -0400 (EDT)
Date:   Tue, 25 Aug 2020 10:50:37 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     robh+dt@kernel.org, wens@csie.org, icenowy@aosc.io,
        megous@megous.com, clabbe@baylibre.com, karlp@tweak.net.au,
        bage@linutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tiny.windzz@gmail.com, huangshuosheng@allwinnertech.com,
        liyong@allwinnertech.com, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 15/16] dt-bindings: arm: sunxi: Add Allwinner A100
 Perf1 Board bindings
Message-ID: <20200825085037.nrgsah7iueom4pva@gilmour.lan>
References: <cover.1595572867.git.frank@allwinnertech.com>
 <0368996b732f300d0b5719e51dbd4322fa09053d.1595572867.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5zlmlzykjskcqmd3"
Content-Disposition: inline
In-Reply-To: <0368996b732f300d0b5719e51dbd4322fa09053d.1595572867.git.frank@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5zlmlzykjskcqmd3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2020 at 03:20:12PM +0800, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
>=20
> Document board compatible names for Allwinner A100 Perf1 Board.
>=20
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied, thanks!
Maxime

--5zlmlzykjskcqmd3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX0TQ3QAKCRDj7w1vZxhR
xaAvAP9zeYUaQsnMXlw6X6M1x8FFSPu772Y3fLxjAgwAnaUj0AD+LvIa19X6V4v/
v6Q09616KvDpHmwFLosGupxmADJXjQM=
=q/nN
-----END PGP SIGNATURE-----

--5zlmlzykjskcqmd3--
