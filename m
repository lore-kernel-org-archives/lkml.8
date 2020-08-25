Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B6BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 337B32071E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="eEENWt/J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ukB6Ymh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgHYNic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:38:32 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:58475 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726666AbgHYNgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:36:16 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id CB907C44;
        Tue, 25 Aug 2020 09:36:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 25 Aug 2020 09:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=6W84PROEQmkc2RBlckn+N87LQMj
        GNR/EGQp574cjw3s=; b=eEENWt/Jb5iqxaDm6IwF2aFfKrXAyqlElS+EfV7HFIf
        YbtslznD2C0ayt97gwGRh+Zw9ip1+ZuUFLki2Xi35AqGVuN3RnYjIYtPjhbRHT5i
        3K3J/oGSSyTaIMgrsoTiXEKYJnSuSFp4mWJrL3fg2cjECPrcI52z+nX34H3PvMSB
        S5YAUUjv+S/DNytvTfLdqwXpTKpB+TbimxpC3KTC6FjJzupYSghFqKfjQHxmleh3
        WxWZG66xcnwDMCaYXbZPDzlxrShma8je6Tfnd3SHOV5IqszBDYWf/shfr1UqK5qs
        mIhQnDI0F9Qx2BL3gqNIJDbtB8Tzw1edgVX0pZV8kyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=6W84PR
        OEQmkc2RBlckn+N87LQMjGNR/EGQp574cjw3s=; b=ukB6Ymh/jZqd9UlE8u92dI
        K4NKtgsf8RtU0VyHzweGw9N4ekYp3R+vKvypo5ZNP5RvmbaTi01ahoUKkfFPuDZB
        Phi0HT8/DDNgc+vDDCHOiyw92ow12pleduJeS4zpTv9Qc60zWY2L2CDdt+1jN+W4
        fhEs46zLwDIXQ7V/dwQrc1mQTCRruvsGEWjPE+wZ9/O9r8wK1XuQqX+ym2wfUsLt
        LOf3rejmXctpa1giUVAQ7sPAZtLs/xWV9ZlPSC+axWfaUbCN+o/PpMC2hhYJH14z
        983LNk+XUIRHhh5xs8D8kg4EkHZUpcBuCOYevzao0RRQt1qGdGvNeZQuxKBJocqw
        ==
X-ME-Sender: <xms:zhNFX9teEcsvc0M8yvwZBjJ6wPd_QPSjaD0fOV-3zP2rEFNEeQUReA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepuddvudfhkeekhefgffetffelgffftdehffduffegveetffehueeivddvjedv
    gfevnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:zhNFX2dBeLWcm0a_WglsHYNpsLJ3X1kzLlsbQMLTporojbAzs38wag>
    <xmx:zhNFXwy7SuMttLMhWUs4pyOMkLJpRHCdHmKmjI3bPKWAlwGc47rIrQ>
    <xmx:zhNFX0PY0QY19Dz809NtxJkXtI8_GMwBA9y4F0OBSomdG3jY_aakAg>
    <xmx:zhNFXwlGIL7v88QtUdSSIAvlIzlMLg4KZ-vMFPGfy79VBpdzsoePsQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 109D03280059;
        Tue, 25 Aug 2020 09:36:13 -0400 (EDT)
Date:   Tue, 25 Aug 2020 10:51:07 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tiny.windzz@gmail.com,
        huangshuosheng@allwinnertech.com, liyong@allwinnertech.com
Subject: Re: [PATCH v5 16/16] arm64: allwinner: A100: add support for
 Allwinner Perf1 board
Message-ID: <20200825085107.kxy4gnybrdcu3wvt@gilmour.lan>
References: <cover.1595572867.git.frank@allwinnertech.com>
 <30f4a3fc6ac84d05094e2c3b89d1dddc8ff6b7fc.1595572867.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lxn37t4dsz2j435x"
Content-Disposition: inline
In-Reply-To: <30f4a3fc6ac84d05094e2c3b89d1dddc8ff6b7fc.1595572867.git.frank@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lxn37t4dsz2j435x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2020 at 03:21:05PM +0800, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
>=20
> A100 perf1 is an Allwinner A100-based SBC, with the following features:
>=20
> - 1GiB DDR3 DRAM
> - AXP803 PMIC
> - 2 USB 2.0 ports
> - MicroSD slot and on-board eMMC module
> - on-board Nand flash
> - =B7=B7=B7
>=20
> Adds initial support for it, including UART and PMU.
>=20
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>

Applied thanks!
Maxime

--lxn37t4dsz2j435x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX0TQ+gAKCRDj7w1vZxhR
xfUzAQD3AW8OyYU3exYwA0a3IaKo9c98e6hnoYQ27izQfONzQwD9F/H7Zdhn+YEP
fuuTq0ApgXKkHP1YOyH41Hacyux6nwo=
=fy21
-----END PGP SIGNATURE-----

--lxn37t4dsz2j435x--
