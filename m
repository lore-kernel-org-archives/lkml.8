Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B962C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 07:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB71020575
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 07:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="zE/jGiuF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nq9aL/sI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406653AbgDNHaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 03:30:30 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:60607 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406631AbgDNHaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 03:30:20 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id B2BC5D32;
        Tue, 14 Apr 2020 03:30:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 14 Apr 2020 03:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=n8uUxVj2O6wC8BBvVzkUMzLkQR/
        W6dq7ltsB0YDVqY4=; b=zE/jGiuFNG2fMrdB/Bi9+JqxyycaHke4V7PkoCmi+b9
        HORrYxEBIEAoV2NCXzmsxIbYPGXeS1AHUrdqXgNdXVnlQrohkJASvtLkA8Axr9O7
        bY+aeeHGj0Vqvox0bSAFZQ4bk4LOcDrwIab6U5mWJGDmMWrJb7MQDRjO9BC3A4rx
        tqZSw3F5vQq93lj/qL8EIyB0p9dFZLSGVyiMVUSL7iI8mr0eowO1Qpa3Bi8KNxd0
        Dn4yhAHL0FQJ4Vvn96HkiLfwxNduXdsFzKVv1zIHECMFSd+JFWfEJhcbDtiJ9FY5
        ZFfRHDFAtnVqeKJtJo4ykFjm/kZUojMI9ukRhbd5ViA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=n8uUxV
        j2O6wC8BBvVzkUMzLkQR/W6dq7ltsB0YDVqY4=; b=nq9aL/sICld4Oxszs3w7vg
        pcSgGRGgUYtKAvmtqzAGoOd3KXWa05yl++VMDpVgW+/9pVqlRwuN7amaUgMToFso
        JlyMEzobMRUxR63KCR884TYmmuI8brwemTYOho9rHa7HAKNzMfMHQlJyeULiHF3+
        vtOd2q+meqPfvhAQc3LOoFqzmNNs1L0N4s4qfgDORCGW2o+gxK5ZgZjcsaHeMjjV
        6UqgjM0iIuCjWYbrG3tssq/Q8wTmXGmNgS6cHf/m1DcE+i7MOAey4YKwZXVDOtK+
        sMzgvifpt2jVamN8bba4guBuokXZYAz6Kdx/RaLnvFWPf/2o1BHPl0lawVEMr1eg
        ==
X-ME-Sender: <xms:imaVXg3gNZwcb1EbhpbiE22rpUEKrAfkPIvS6JlG6HgfFii_3qJJvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrfedtgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuffhomhgrih
    hnpegsrghnrghnrgdqphhirdhorhhgnecukfhppeeltddrkeelrdeikedrjeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvse
    gtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:imaVXlohIirwGi2SsenxxMbnGlZE4SBaJutpFgbla72X2XGTDHktew>
    <xmx:imaVXlcdlz5Ni2FvP6C2iTF5s0OJVR4gpId7IOpQw3vgvLeY2TyS1Q>
    <xmx:imaVXsrdKJYiETffIHCEYuoeZUyX2Ghlt3ujM7eWg-a1bkfFJ6Y1SA>
    <xmx:i2aVXmsh5wZrIIAt9aBZ14ZdmjLjwC2lIObNO6jry51Lj3DljSKIwQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 800FF3280065;
        Tue, 14 Apr 2020 03:30:18 -0400 (EDT)
Date:   Tue, 14 Apr 2020 09:30:17 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@laposte.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH] ARM: dts: sun8i-h2-plus-bananapi-m2-zero: Fix led
 polarity
Message-ID: <20200414073017.ctfvws2ph67gqgit@gilmour.lan>
References: <20200411174843.4112-1-vincent.stehle@laposte.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3day4t7c5vd65lny"
Content-Disposition: inline
In-Reply-To: <20200411174843.4112-1-vincent.stehle@laposte.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3day4t7c5vd65lny
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2020 at 07:48:43PM +0200, Vincent Stehl=E9 wrote:
> The PWR-LED on the bananapi m2 zero board is on when gpio PL10 is low.
> This has been verified on a board and in the schematics [1].
>
> [1]: http://wiki.banana-pi.org/Banana_Pi_BPI-M2_ZERO#Documents
>
> Fixes: 8b8061fcbfae ("ARM: dts: sun8i: h2+: add support for Banana Pi M2 =
Zero board")
> Signed-off-by: Vincent Stehl=E9 <vincent.stehle@laposte.net>
> Cc: Icenowy Zheng <icenowy@aosc.io>
> Cc: Maxime Ripard <mripard@kernel.org>

Applied, thanks

Maxime

--3day4t7c5vd65lny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXpVmiQAKCRDj7w1vZxhR
xSL2AP4pPm/60fbnUXcvq+Sg3y4w2PbhMA606DmAdxn+7ecfbgEAqJyhGyhAizfV
mjIB3RBOPA9GVgyRlZqz3GmsgnzCRwo=
=JZo2
-----END PGP SIGNATURE-----

--3day4t7c5vd65lny--
