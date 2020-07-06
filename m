Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A238C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 05:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBF0520771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 05:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="TSzOA0uy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OVK4r1Zj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgGFFTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 01:19:02 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:58393 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726020AbgGFFTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 01:19:01 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 609DD5804FC;
        Mon,  6 Jul 2020 01:19:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 06 Jul 2020 01:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=rGGHBY0t7206Px54Uw3pH/xzhBq
        rSWNKVMJbEBZQGMs=; b=TSzOA0uyoppHVhoKTrJ2KfN7lbTGR0pPVFgjnc1R+yc
        NkNC6oOcsbuZLY2REZro7soO5gWXiVCafJ6So8Rx/eUBXSzwM7C53fmezW7C0FqR
        3kdII8O/RIZyslvNIhYVgP0wsSo5su5csXrmGIVk85/vYcBshfqkUB3LcPcFv7iL
        DEPRXdRw86bPa1jdD9fdirhhwS79tAavOqfANnfUiyyZ8R3b1XeZX6wRYP/X0Ixp
        aMIbdDqguqIH4LrBlz2EylppdouYxcRw2fJz4c4lpNez7fn2nWBiELbSEGnxn4IB
        jjNDwpS9xE5/9HXeV+E12JyJ9EVU0+yjIVOC09vr8RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=rGGHBY
        0t7206Px54Uw3pH/xzhBqrSWNKVMJbEBZQGMs=; b=OVK4r1ZjnH0qOsM0n7hkRH
        VSclHgikLx9m9BRfRr2fgS4dZQt5qq/jL0XJsFRpIx3nqPnCeG2OQ96dyBub3r7X
        11LJP4xoLP1KK9j4F+9o6751CSjqmcX+4a3NzGalbkAzrRMqjzCZ38MTZKQwR2m8
        xSfisq53AmuUjnc8hO+SUlR7mdpeS7cHBOKXKWOD0YTh6tj7jnQh2aiKvtLsPT1t
        0F3jWwjDZs/EjSJGHJ6PcrjE2dS78vso/Rjytb1DS8GY55OfyiQuO6JMerozA9yz
        +cyFE2jJgL6UURjyikC0pt6zzy0oSUm6quyTqeDTYFURz7f+T73nbsHtiZBhC25g
        ==
X-ME-Sender: <xms:RLQCX9_Bfnyirb9wvdZar7olax7tgrqI9Vg72qWBFH8oCmwWTjR0dg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdejvdfg
    veenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedvnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:RLQCXxsCsUfM-NgFtiu32ZVLIPIBx_d3YN1D05VtuMbE9J5BtRXdIA>
    <xmx:RLQCX7B_huDjMyygRDdhDmqk42IjQJ5cjUOj-WyHdYQAl3bY_eoP6w>
    <xmx:RLQCXxfqHwtX4KTQuuOAL2NVUbYe0aFR7QWvnfTW7XAXw461RltbrA>
    <xmx:RLQCXzF7nMK3bF4kkjp0CQSAOA3ddtrWfY8z-VcHyTtwHKA9vFGXAg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id F1CE93280059;
        Mon,  6 Jul 2020 01:18:59 -0400 (EDT)
Date:   Mon, 6 Jul 2020 07:18:58 +0200
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
Subject: Re: [PATCH 05/16] ASoc: sun4i-i2s: Add 20 and 24 bit support
Message-ID: <20200706051858.an7aefursbhmyfua@gilmour.lan>
References: <20200704113902.336911-1-peron.clem@gmail.com>
 <20200704113902.336911-6-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i4rg5zukerkvlxuj"
Content-Disposition: inline
In-Reply-To: <20200704113902.336911-6-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i4rg5zukerkvlxuj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 04, 2020 at 01:38:51PM +0200, Cl=E9ment P=E9ron wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>=20
> Extend the functionality of the driver to include support of 20 and
> 24 bits per sample.
>=20
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--i4rg5zukerkvlxuj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXwK0QgAKCRDj7w1vZxhR
xU2iAP0X8H8HDjI4TzDvrLbBY+AIrjYxkkX8cwNdewYnYRW5dwEA48sP2HBp2mI0
mjrnRZHppq39Ga3G/5KihHPVji3SLgs=
=Tc9o
-----END PGP SIGNATURE-----

--i4rg5zukerkvlxuj--
