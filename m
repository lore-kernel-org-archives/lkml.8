Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6569EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4605920738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="RoWNw4NK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kSElpLqy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgHYNrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:47:14 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:39777 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726113AbgHYNf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:35:58 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id BDD43C41;
        Tue, 25 Aug 2020 09:35:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 25 Aug 2020 09:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=VVtlW4HhdtLjXxeuomS0ncEugVO
        xoM1/RkR8Lb06Uu8=; b=RoWNw4NKNj/bo2BclZ6HWv24uk7sVQAtdsimNHyLzZe
        0yZEQQxcS18OjLkqSKhhKV1Jv78o0UHGOgDADSdlpkStNmcVqTGGxA3EqVwqa8gV
        2Hl243tGBGlZRIebV7Y5v8oITRdx/jzZqVm0hmyxzzq2RjP4GL26GODGrTpR2jmk
        whHndsPso4pNAbbPnQ+N1Aceiqmaopy5S91vqU+n/XS8oILQBCRns4KrFTz8DQOw
        5rKXGPBSdqODUaYy8fcgPMDZkcoHXgQ0+UuG3j60GykO1LdcgyFmuo/hVAqDdTwL
        IZLqx3kj2O5psWEP0je5YQ9+Xcw2vk2V8URGy1GG9lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=VVtlW4
        HhdtLjXxeuomS0ncEugVOxoM1/RkR8Lb06Uu8=; b=kSElpLqyWDgFaTEm16ppG3
        p10cDp/f3+RuHxdQhL5eJwBB5DlcaqzQa0rEPhH3d8wOTvgwlH/nuXVVtpWSxCK6
        I+kPVTW2wcFx5cZSoWZgCL/FQVS+8UrabvbFL25/HxhcEuwhc+Zy0MIsx0SXo6Ip
        qvlpz0V4In0BD9qcpAksfTOQFAT4itOgk8qzDE6Tik9yBLXDBZ3/Y/mNkP+NnjIM
        pNRIp403w5B635yfl5F6GK2G9odzQQwDxP0lp92+kLbQXMTU0Wj9Wcai6kr8grBT
        LmrmE0zSxQ/RU86zSqLef+uKutezy7m0ly2xbpmtcCGXAVn8qZZaAcVrDfTaRddQ
        ==
X-ME-Sender: <xms:uxNFXwC1BbrdST-ojgpYHi7mU6j962QR4yysdYsYC0wJrGvAabRjpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepjeenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:uxNFXygtAnnreRsIA2TwVkzT1GLfgqHC150PBWfF1RWfppnZqs-4Ow>
    <xmx:uxNFXzmCv8JxbUoItmpMNdcy3zU1DlPSiLDsW4u3GiUrmx5O-eZidA>
    <xmx:uxNFX2wU-blq4aLQ60tO5oCFuYlLvBtx_cDr8cCx1nu3TSZDsP6OSg>
    <xmx:vBNFX2RRcSbsIhEQkNtGzh4o-LPJ1ESPmpimLf2eWPvSdTUhL2g9afrcvMU>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6F4ED30600B1;
        Tue, 25 Aug 2020 09:35:55 -0400 (EDT)
Date:   Tue, 25 Aug 2020 10:39:02 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch, heiko@sntech.de, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 0/2] ARM: dts: sun8i: r40: Enable mali400 GPU
Message-ID: <20200825083902.5o54lltoglbs3cui@gilmour.lan>
References: <20200824150434.951693-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gemdfh7kx36fvawn"
Content-Disposition: inline
In-Reply-To: <20200824150434.951693-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gemdfh7kx36fvawn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2020 at 05:04:32PM +0200, Jernej Skrabec wrote:
> Following two patches enable Mali400 GPU on Allwinner R40 SoC. At this
> point I didn't add table for frequency switching because it would
> require far more testing and defaults work stable and reasonably well.
>=20
> Please take a look.

Applied both, thanks

Maxime

--gemdfh7kx36fvawn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX0TOJgAKCRDj7w1vZxhR
xWEGAQDMARVYvs1kmIOcDlaG6HVY60QAfYio6XLChV8tPlnk8QD+NUSD51f0RiGV
2CCxdlX746Cq5lcsYWglELWDAYtnEQ0=
=OzYK
-----END PGP SIGNATURE-----

--gemdfh7kx36fvawn--
