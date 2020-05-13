Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D33CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 109A320671
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="ZJO7lWSA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XZDh0kLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388930AbgEMOT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 10:19:29 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:38379 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733142AbgEMOT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 10:19:28 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id A7DB55C01D6;
        Wed, 13 May 2020 10:19:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 13 May 2020 10:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=6fjHlyOTOqWxHSt4RPRb8GVZ91Z
        qD9TrDEJsn//PCGI=; b=ZJO7lWSA1pGZWi77jHrq32z7Kh+jSm15JVHlGSRHKvV
        O8MQzeqo6gFi4DzkkOXBXHxXEkqP9u79WIBJNeDQYstbGM4IF/DZB2GD79jDc+KM
        k+Qi05829aHju0opokmObn9us4YjjRWajf7z71yrjSpqsAPaj9BSceGGuz6CV1AM
        7vWCksQe0Z9CD55EJ2OjatiODXhZ58TM76WhqjwzfJDNw4yxWRtJgWeCsAmygv2L
        sajikkBNZn3mNWSGzrlQcG8rfXPiUm2g3VmPSA/Ar1cejeOAtgwsu0JjKN9XHoy3
        9OqSOehjuOQ9MhSwa8vpjn8xj9FUkF7GZ3oDlQae98g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=6fjHly
        OTOqWxHSt4RPRb8GVZ91ZqD9TrDEJsn//PCGI=; b=XZDh0kLBcHH9Yt+8i992CH
        MpLJEFE1lYT8xfl94OHJ880u0bFQ0lJ+IVl3ckcXz3q1TeNVfLQv1vOjU/dE2a9n
        FdrZrk+II/hDrdIElcYWzrq/8xXVaTW694NbBA+q8FKDr/mVmp9gSnNSqU7jOJLu
        VCdjn/RW2jtmRl7fkemUcv/y7CWqTWk9KNJpk7exYVVugZCyLQ2ukYwtohiQMTdY
        vwjdwPr7/7Lx1JSQHeJjtY39rKODDR/9eP5nccwH3vIgsaZrMYTSkZwC5SyH+Jj9
        4hIMK5omIlFttPIRo+NRdCiDuI6Is7IqIA+RFJguZsMPed3Y/L1lgJBAAeogGr1Q
        ==
X-ME-Sender: <xms:7gG8Xjc1-jAmWs4zidapqSMWKH7xX_IUOGlynmyyAVa6ZOPYFNSfKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrleeggdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghr
    nhhordhtvggthheqnecuggftrfgrthhtvghrnhepleekgeehhfdutdeljefgleejffehff
    fgieejhffgueefhfdtveetgeehieehgedunecukfhppeeltddrkeelrdeikedrjeeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimh
    gvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:7gG8XpMuAq-TjdugyqsUGqR86HcwnlTEnvMEal0lOwP8NEC0ypq19A>
    <xmx:7gG8Xsg-qtpBZoJgCZt1nuy1Azyv0dDsAE5l_xgTKelL_hcNw4tgoA>
    <xmx:7gG8Xk_XJ6S60gRhpBm2Onla_uzS5xavcTtCGVdUkod7E3DEP8ZYzw>
    <xmx:7wG8XlXXbyVi5ickxuVV-yGc1SgXk66YGaZ5WLjily-gjjZMet4rRA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id DD500328005D;
        Wed, 13 May 2020 10:19:25 -0400 (EDT)
Date:   Wed, 13 May 2020 16:19:23 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Zou <zou_wei@huawei.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, wens@csie.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ASoC: sun4i-i2s: Use PTR_ERR_OR_ZERO() to simplify
 code
Message-ID: <20200513141923.klp2omelhawzxy4d@gilmour.lan>
References: <1588752912-37596-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6ttmhlo4bwfcw7it"
Content-Disposition: inline
In-Reply-To: <1588752912-37596-1-git-send-email-zou_wei@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6ttmhlo4bwfcw7it
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



On Wed, May 06, 2020 at 04:15:12PM +0800, Samuel Zou wrote:
> Fixes coccicheck warning:
>=20
> sound/soc/sunxi/sun4i-i2s.c:1177:1-3: WARNING: PTR_ERR_OR_ZERO can be used
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Samuel Zou <zou_wei@huawei.com>

Didn't we remove that coccicheck test?

Maxime

--6ttmhlo4bwfcw7it
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXrwB6wAKCRDj7w1vZxhR
xbWmAP0Wl+mfUFUgVS86noXlYchEz4RTpXjy5YY+CO73b7vL5wEA4PceZeiROH26
wMKoHBBgjpNbCBfMKyOwfraY1MTy1AM=
=crja
-----END PGP SIGNATURE-----

--6ttmhlo4bwfcw7it--
