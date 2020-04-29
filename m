Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7375FC83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 535AF218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="PrYcAPJq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BL6jylTn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgD2M1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 08:27:54 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46017 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726524AbgD2M1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:27:53 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id ABD9A5C01EB;
        Wed, 29 Apr 2020 08:27:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 29 Apr 2020 08:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=oT4XdLbogX87VMuvUNiDOpoFtZN
        n6gVXatcFFIiZFeY=; b=PrYcAPJqJFjMz+RZfG44n/S2fCG4TZd0pfBXw48loGx
        HpI/mYF51ClHuu2Jvsh/V1EmhcWoF2xeQsopWe7E5mBqztkw49ewtiBRpZIpB+1p
        xdgOkIuqJG2IvSyjHTR36o7U55ryyyEWDpgrYZD/R5ZVby6Nl0aB4/F6fqovBen0
        Cb7BYpYgm/VIZtP+6fO9Qwu9DjtDKGhhsWfYo1Njvo1XfnfsNxKDAnV37U+EE1wR
        kjLBC49jrsBxxXVjve7vcCbAlNvHX62zFC+mUK9jMmCAey8xNvmH+X6Zwimx3HFu
        uLIazw1UbfeBjB7t/Jk/IGe1tvYyGjuKMyg1eKofqYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=oT4XdL
        bogX87VMuvUNiDOpoFtZNn6gVXatcFFIiZFeY=; b=BL6jylTn596ytv/EgjRTsj
        K7IoSahkULBUo3+duOL56DiyUvNkGUf3MXAduZgHuaeSW1PUaspGOzveKnfZzjPZ
        Z01dc+IjdtzXKVVwsHTURlrmoBY5UcU3XVnwTQyXT4SIU8YNXDZwBL8TZoXP43fq
        97JxeXgEMcREZ6JjdNNrSZ39zYNlWRd0cYdPqXCFk0Frv01DauGERefk/gCzY2E4
        b2YXxeMzjZELknYIdw0pkXVfw/70AhCVHZmT5GHZCNdLwLQs8ELdObFy0sxF3ugu
        fpvrqwf2uE7lC7bhoqBnvrOvHb9QWgpFmcKLWRPzgpvXJviI5UrjHla3E2kocy/A
        ==
X-ME-Sender: <xms:x3KpXmnSae1Psg6-w79QpZs_HtXqNUzZbkuEO7AGKB87kYVy6H9Q1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrieefgdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:x3KpXiHiCdEjT-LZqED_-BKr-iDPDaK8RqtDfr4N3tADsJm_T6m7zQ>
    <xmx:x3KpXvradbjOwSMfK5FRTbkPtRjwxPsZQRpMvhmPLs-ABNkTIULvEQ>
    <xmx:x3KpXu7hYSZul2HOgsV1EmmdsdtSsKFCPw8nHmN8SrCj_bH1Nab2Uw>
    <xmx:yHKpXq_NPrfGhw0BrrSbbwmZ2zkGxT0p0XzwMlozF2tMu9B0WKsDNw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 92E0D328005D;
        Wed, 29 Apr 2020 08:27:51 -0400 (EDT)
Date:   Wed, 29 Apr 2020 14:27:50 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Yuti Amonkar <yamonkar@cadence.com>
Cc:     linux-kernel@vger.kernel.org, kishon@ti.com, mark.rutland@arm.com,
        jsarha@ti.com, tomi.valkeinen@ti.com, praneeth@ti.com,
        mparab@cadence.com, sjakhade@cadence.com
Subject: Re: [PATCH v1 2/2] phy: phy-cadence-torrent: Use PHY kernel APIs to
 set PHY attributes
Message-ID: <20200429122750.hup7vbmz3xnpfwa5@gilmour.lan>
References: <1588057804-29161-1-git-send-email-yamonkar@cadence.com>
 <1588057804-29161-3-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pfunkpzcbipvw67a"
Content-Disposition: inline
In-Reply-To: <1588057804-29161-3-git-send-email-yamonkar@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pfunkpzcbipvw67a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 28, 2020 at 09:10:04AM +0200, Yuti Amonkar wrote:
> From: Swapnil Jakhade <sjakhade@cadence.com>
>=20
> Use generic PHY framework function phy_set_bus_width() to set number
> of lanes and function phy_set_max_link_rate() to set maximum link rate
> supported by PHY.
>=20
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>

This should have your SoB.

> ---
>  drivers/phy/cadence/phy-cadence-torrent.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cade=
nce/phy-cadence-torrent.c
> index 7116127358ee..b914e5ddf93c 100644
> --- a/drivers/phy/cadence/phy-cadence-torrent.c
> +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> @@ -1852,6 +1852,9 @@ static int cdns_torrent_phy_probe(struct platform_d=
evice *pdev)
>  				 cdns_phy->phys[node].num_lanes,
>  				 cdns_phy->max_bit_rate / 1000,
>  				 cdns_phy->max_bit_rate % 1000);
> +
> +			phy_set_bus_width(gphy, cdns_phy->phys[node].num_lanes);
> +			phy_set_max_link_rate(gphy, cdns_phy->max_bit_rate);

I think what Kishon meant in his previous mail is that it's not really clea=
r (to
me at least) how that function would be useful.

In this particular case, what would the consumer make of that information? =
Does
the phy needs to be reconfigured based on the max rate being changed?

Some phy_configure_opts structures also have a somewhat similar field that =
can
be negociated between the provider and the consumer using phy_validate, wou=
ldn't
that be redundant?

Most of that discussion can only happen when you've provided a use-case for=
 that
series, so a consumer using it would help greatly there.

Maxime

--pfunkpzcbipvw67a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXqlyxgAKCRDj7w1vZxhR
xThKAQC5OdZLjKA1gu+WdGB9xXEOgeEfSI/um2KMqdAy9BYvRgEA5286nZI3e4Ei
hzBjNawMbJBAFARUzhy2ASwB6++dBAM=
=dF3D
-----END PGP SIGNATURE-----

--pfunkpzcbipvw67a--
