Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E5BC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 11:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27267208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 11:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=stwcx.xyz header.i=@stwcx.xyz header.b="U8JPy01F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rWKq35sr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgEALky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 07:40:54 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:55501 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728575AbgEALkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 07:40:53 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 7401A702;
        Fri,  1 May 2020 07:40:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 01 May 2020 07:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Sb3goio2fiGntHYbz+m2AsCFkNQ
        rFG+Kg4TJuY9VPSk=; b=U8JPy01FEaCgmL0/x3Wq6/hHhS3ABZ9Ze/zBRZ21P/D
        eApxU4+pXkv9R/OYMs7iYojHqJXSmRxCAq/D4DZ1H2j15x7dG9lxDFfIhXErm6R6
        JMwbJP9pR1yvU6ZPG1dWNOfPTySU68jj0v4JGXX2SLrsY5No9go8Z6ix57E0Ss+H
        4oRr+8XvY+SB2/tiIObU3Fa9+WiAc8gb8EPUyeoRD73KJp+Q7SUXDZW7U/SPRSK+
        r1atLU5zpmCTLfaAhqOJEz+jIr8u6vKwq1b2UUtsMdzsQU/Wg49HMpJ3sYtBLCUq
        WskJGp8jlpK52s/9vT9MgCRtCLHt2yjjGo9UMChSxXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Sb3goi
        o2fiGntHYbz+m2AsCFkNQrFG+Kg4TJuY9VPSk=; b=rWKq35srI3fHGJXnJg7ToM
        gz/1MfC2xoaLKwSlcoHy0VTRxE3sTpppHIPxXUIjSbKwoi9L3ZUsCc9WwBKlE133
        2w2lyN3EzEMn/ajuvdC8ZKBOzsCJ2U30SxdsHBV+Ytt8MWWURhPEV4FjpP8ttYQo
        PSZs+AP6/21pPMnjjMFfk1f1A8CWm9s7DyK+eXVIqTYfHepCmNkHziKXQU689jZA
        OJczTLIw1557vDOzJav57ZYhaYMHf+Dk7f4ww88/CSMoWOQ9e9R5LlmH41ikUeB/
        HCnTCjhC5havGJz1/yvVot0TUJ5l5nbtVFHh/lAP9/PitkJGJuoZjEC2mGFgo6zQ
        ==
X-ME-Sender: <xms:wQqsXhH-jhFVf4-4_6mcgDu94tNfRt_S4UZwJlvk9BhK-8-7MFKdCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrieejgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdefhedmnecujfgurhepfffhvffukfhfgggtuggjsehgtderredttddv
    necuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghksehsth
    iftgigrdighiiiqeenucggtffrrghtthgvrhhnpeegheehfeffgeekveehtdfhgfduhfeg
    fefgtdehhfektdelffevkefgueffhedtieenucfkphepjeeirddvhedtrdekgedrvdefie
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprght
    rhhitghksehsthiftgigrdighiii
X-ME-Proxy: <xmx:wQqsXgkmkfTAS42UxYD2Zpr15FMTaDn8g_JBwQOm-SFrLb2RXoSXOA>
    <xmx:wQqsXonjbQUZkEH46KBo1deDxN6Wo-C37USh7n8DkXZgXDyjWPa2NA>
    <xmx:wQqsXtUWIuUa3A2zcdUx5JYnCfH-ExAABPBoR4cmnddYvMi1t3rZEg>
    <xmx:xAqsXik-JS_8sIz5rPEFXTYf3vw7Mw1lhQLqJI48GgV5y4gxfsb0hA>
Received: from localhost (76-250-84-236.lightspeed.austtx.sbcglobal.net [76.250.84.236])
        by mail.messagingengine.com (Postfix) with ESMTPA id C9B693065F66;
        Fri,  1 May 2020 07:40:48 -0400 (EDT)
Date:   Fri, 1 May 2020 06:40:47 -0500
From:   Patrick Williams <patrick@stwcx.xyz>
To:     Alexander Filippov <a.filippov@yadro.com>
Cc:     linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Geissler <geissonator@yahoo.com>
Subject: Re: [PATCH v7] ARM: DTS: Aspeed: Add YADRO Nicole BMC
Message-ID: <20200501114047.GC5268@heinlein.lan.stwcx.xyz>
References: <20200429113711.13183-1-a.filippov@yadro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UFHRwCdBEJvubb2X"
Content-Disposition: inline
In-Reply-To: <20200429113711.13183-1-a.filippov@yadro.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UFHRwCdBEJvubb2X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2020 at 02:37:11PM +0300, Alexander Filippov wrote:
> Nicole is an OpenPower machine with an Aspeed 2500 BMC SoC manufactured
> by YADRO.
>=20
> Signed-off-by: Alexander Filippov <a.filippov@yadro.com>
> ---
>  arch/arm/boot/dts/Makefile                  |   1 +
>  arch/arm/boot/dts/aspeed-bmc-opp-nicole.dts | 326 ++++++++++++++++++++
>  2 files changed, 327 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-nicole.dts
>=20

Reviewed-by: Patrick Williams <patrick@stwcx.xyz>

--=20
Patrick Williams

--UFHRwCdBEJvubb2X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAl6sCr0ACgkQqwNHzC0A
wRkYyQ/+Ia0bM1fVefwj8qDw02722tG9QTWwgkAr/0ln2lYPm6WeBmhNWiQlcq73
siHVSVZmAIxGeqAj/fo0WRA6XgemmlMNylICZj2JMlJs/RaqfdzkzMxjXDPF3jir
kniXIA/naEnakX9e9IyzP1zeEHUeCfIBD8YdWhBXSaz8yTXw6fV4gFDCXGqjSOhc
HSlVA3Tj9B0810DoMdGGRXU1Y90Q6H5xdZ7gdROvuZDa04jusuqFDZ9LDw47OIDp
W+0zEW2eqhwFLp6QSDZXhBDOiB1kHdc2tEMfW0uzzqpT2JoBoGzc6PMrjPCBaIrP
Aj23HE8zM1uuMzFZCCQ2vPUxxSroAxdhN2H1/8Cc9ekvGiAHX5e73g2hT8DOXIJD
TLkkn9nVnKra0P+N0JhQQKXDRnSGGdoc0tsIlq7AMi6lsjzPIoV4tRqeGYZgGSBC
henTkYrFFsmjTVnh9mTq0UdXDVZscW3oWnrK3tuzphX+tFJxlRo8QgrTLVBU52cj
k5AL7gk/FuK+y0zYd3weLXRAEzU8u0OFDROQLsEb6jJH+2GqIcz7qPm4XkjPENDa
5rkOxMovA+01t13eShDsWJ7vCLQPbGpDtwj7nnFtWo/uZ+pU7eqNnxVFH7iyMo4P
obUf/pikY7qzZSVgYmi52h2c8pRRdgExNa67EOcP/SPr59zXlKQ=
=cOmO
-----END PGP SIGNATURE-----

--UFHRwCdBEJvubb2X--
