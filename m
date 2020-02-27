Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DA8C4BA2D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2432469E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="r7r1Jzmy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JyhPkrf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgB0NEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:04:33 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:60153 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729025AbgB0NEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:04:33 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id CB3138148;
        Thu, 27 Feb 2020 08:04:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 27 Feb 2020 08:04:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=pcqE+m1HBssPDljnUDjxn5Zpsb/
        nsjs+cLUWmmlhvgc=; b=r7r1JzmyY5dqNLeJXd06uTyOec79PQxhArFmv+nV8DQ
        KpSKT/rVa55JFxl0thhrfp12JqRHDjjSkE+JSuJ6xdhF23xFeu9SkbxhdBXCgWSH
        IRfw8SLz17iui2tkwPMJJIfqLfRCkfh+LTgxr+aFiB+4A/zUPKZfBMIlH8SFj9G6
        HAmgtRiUWNWaa/R9oFkxsLtpPXtwP/Ej58uQjRVPoFQdBc/mn6qPcytbN0YO/PR7
        L6G5Uo+h1+ThD9cwXwJaiJ2bxwCRZkTxfMXWOSJxc9+Eg4fPlctfbC7KVLAC6l6F
        ZO2UjZuruycdCH718QwprBOIqC/qu7lEQV34NenVRhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=pcqE+m
        1HBssPDljnUDjxn5Zpsb/nsjs+cLUWmmlhvgc=; b=JyhPkrf1wpEdu6dEdWYfbR
        3PVGUh01aTU+0UNdbx7mnFmvys9B782DMmpP+5MHg2e/oE9qOuJsUAG6zGYF4ol3
        1ufPvS10+BDQO/MTcctC8QH71ksEtgUBfqam1RCpOp8R/uxqVaVDWy7Akc7cZ2pz
        2ALmP/MZDxB1b6mzrXQL0DWWunClvNyp3907N64Q4bgYKt2tS/d5Ubxeg5zXi9Uh
        5PpPbcPuCgR6K9rdgE0OZGJj0RrwdjKO7aO2fN0eRMjQxjevZOB/T7IoJGv031XX
        /EhOR/VQFhclA0nKQnf/H2r0pBxfqnNcIMN+pEFBL41QhHjjqlaCDfBetYi9LRBA
        ==
X-ME-Sender: <xms:Xb5XXpWQlPuwgiFUD3x9JrBisTz_HO6GePOTI_KrYaFhGFfZhif4Eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleeigdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:Xb5XXnZ7o_CUSOfXi-w5z1McZDeixbhlXXkhZRZWihPjnzcqtiObxA>
    <xmx:Xb5XXv3KkCj-_pkFoIVRWMlqfcUOXiMybkzv8IbiyVKOB_ZWCjXI-g>
    <xmx:Xb5XXpgJ2DFC0dbEL4A7RvpVNukxsRKkEISzi87Ja_ZsyM9pd-kPIw>
    <xmx:X75XXtpDToEIpIQpMTAEUXVZVZMG2BoUxp8LPTQi_BjnEXSILropgw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B885A3280066;
        Thu, 27 Feb 2020 08:04:28 -0500 (EST)
Date:   Thu, 27 Feb 2020 14:04:27 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Georgii Staroselskii <georgii.staroselskii@emlid.com>,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Add support for Pine64 PinePhone Linux Smartphone
Message-ID: <20200227130427.s6dckhlxxpwmekch@gilmour.lan>
References: <20200227012650.1179151-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zwx22sai7cfpdfgo"
Content-Disposition: inline
In-Reply-To: <20200227012650.1179151-1-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zwx22sai7cfpdfgo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2020 at 02:26:47AM +0100, Ondrej Jirman wrote:
> This series adds an initial support for Pine64 PinePhone.
>
> Please take a look.
>
> thank you and regards,
>   Ondrej Jirman

Applied all three, thanks

Maxime

--zwx22sai7cfpdfgo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXle+WwAKCRDj7w1vZxhR
xd5xAP9pdqB3zp5dscktGeYzDa686JcCAnFl/zFrPGGGTrqYUQEAtuFpaNG+MkNl
cMwtfbi32FIP3+Pz7ejPZYhvHCwxZQY=
=1O+l
-----END PGP SIGNATURE-----

--zwx22sai7cfpdfgo--
