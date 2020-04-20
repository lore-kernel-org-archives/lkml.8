Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FE5C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 539CA206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="epRypLCK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KOvFfcVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgDTMtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:49:47 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:38485 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729458AbgDTMtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:49:39 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 6A6EF443;
        Mon, 20 Apr 2020 08:49:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 20 Apr 2020 08:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=txlve3/CTcfnUvbwX40ZvP3ANaO
        WQv9Voc732+vtkPc=; b=epRypLCKVuWg98xXbA3a5AvbDaH8iu8fZDyEzMaq4HH
        w57IRkXMj2jRpWdzF2usdVUjFGOvqS8pXi5sGu3KxTAikuAZpHJn6j0O42snSnFT
        gi6vftUyikzC5CeXoSbdYKjC1VRzATXqwIcJTiwWDiG7+09+4WnOs3wceTpfZEvq
        Hf5Atd3Uxq6mtbDo4x2SXdszh1H2QoXU6XsXyuf1vNPY1QvrWjel5u+rKOyb20hK
        mDkGfFJQRkHK47QvpdCzaYs/aF/hq7vxI+LQfKtLzhu61b0x+KXHdpUCyr60T9xj
        zWnAwL2D+HGcSUEimLzQsBSPkflMfjst7go+zQvEnvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=txlve3
        /CTcfnUvbwX40ZvP3ANaOWQv9Voc732+vtkPc=; b=KOvFfcVn5xQCA9zcGTiZ4L
        IZVQx3vvaNfJsrck/lZZQqKj8mYHONtc6U3GPyiV7aDSCadqzKdXB5aZoSO2AhNA
        6kFEbJfpnVKNjvgqFQLCrp7R+OTnIbJj95LMWnowdqG/UDsaTwgVmbgPoCPl0Hv9
        GEwuuYOTRKgRkcNllJIoDsRT6xlftgvux5kO4gVzsZNq3d8YHnWC5kJZ4eFDf4MR
        kwKqnivtAt+2d2ID3NXJhMSRce8nWnV/YPZfUsMIZsn5XNEZ6E/7aVqqUu4RyoVT
        9+1tDSgjv205twth4/Gvnqt+DhfZEUTWXQ7PD3vWOu7ZONe/DECvGbfTEz/TBveQ
        ==
X-ME-Sender: <xms:YZqdXhEMIFi3MBT888e2SjRyQ7H96ooFC1QiOMJksgR72ZJ6FermSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrgeefgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:YZqdXoX-Kx7WUcDBTwV2x45WnAWGxuvzVQA1Az8s8R1aFh0FQQaYWQ>
    <xmx:YZqdXnbHZfrqMy2qXc0qXm70aNuJZG-eeJ7ORLVRJ12nHGG7xB88fg>
    <xmx:YZqdXiC309TCkuS7EBAb5CCm4JG5cWEy_W15s4z8SJA7dbG55_M5Bw>
    <xmx:YpqdXlU6JyVeaSulfqpW_SIH2tIxat5ZaoQEQtF7qs5nCOeLCgpWnQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 42BA13280059;
        Mon, 20 Apr 2020 08:49:37 -0400 (EDT)
Date:   Mon, 20 Apr 2020 14:49:35 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Priit Laes <plaes@plaes.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/4] clk: sunxi-ng: a10/a20: rewrite init code to a
 platform driver
Message-ID: <20200420124935.asfbgv7envb2af55@gilmour.lan>
References: <20200417221730.555954-1-plaes@plaes.org>
 <20200417221730.555954-2-plaes@plaes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5wt3lytiztwzv3ef"
Content-Disposition: inline
In-Reply-To: <20200417221730.555954-2-plaes@plaes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5wt3lytiztwzv3ef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 18, 2020 at 01:17:27AM +0300, Priit Laes wrote:
> In order to register regmap for sun7i CCU, there needs to be
> a device structure already bound to the CCU device node.
>=20
> Convert the sun4i/sun7i CCU setup to platform driver to use
> it later as platform device.
>=20
> Signed-off-by: Priit Laes <plaes@plaes.org>

You can't relly do that though. We have timers that need those clocks befor=
e the
device model is initialized.

Maxime

--5wt3lytiztwzv3ef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXp2aXwAKCRDj7w1vZxhR
xf6RAP4lRgNAUaFxWq+xBoAy+3gdbbPDv06zoQib8NGNw5hqogEAz1ou9+SSxlMS
L4kNm9nZdNMKsGOFEcPHX6r+OleJvQA=
=yk2k
-----END PGP SIGNATURE-----

--5wt3lytiztwzv3ef--
