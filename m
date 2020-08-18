Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1C7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E89720738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="qgNk/129";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JN6U/R1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgHYNq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:46:28 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:41899 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726551AbgHYNlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:41:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id A45A3C3A;
        Tue, 25 Aug 2020 09:35:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 25 Aug 2020 09:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=xTWDnflbQvjGc9pJORy0trBH/Hi
        jBQsjxwEsTIAsojw=; b=qgNk/129ZMAdQFwYnTgnBFShZX/0z/9wi0B53VaumK5
        BPoe7vG0j6ENPJlYhJ89s/Wah7rk6GGsNWZon6LoDVMAIhwTkecXqjxQ0B/2cFp5
        q8bSNjdeI6G1t7xiaJsxntVqwfF0BCCHVbIbXml/lDRe7ltWp7TDu0O+uuBnqmWS
        Cs/HRbJW60mt63Gp8M00kJzbfepXVuImrl6uqIXlNGLxYdCXvxr9ZYriqbAeuXmk
        K+NwoIxZbmbVSvykR4jRZyMMQZklnKfhVNpkIFYWvxpAyF/+OhnMeqYIB69i2TOy
        OixgqW8IqhkqfBQmlhKIAfjGtBmmJdyIXYhqUqXDM1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=xTWDnf
        lbQvjGc9pJORy0trBH/HijBQsjxwEsTIAsojw=; b=JN6U/R1d/ynU1n70jTUR4d
        c9ubnk6cR4WCLYaGmKfmXTh4G2A6R4f4H0ezzZKw16E9dDO9z8hLFsw2fn4U5BYj
        BPX8O26NEY4wHTLy3fg4TvwQ3Gr+wM9+S+QOrQWdKczyHYlQxySgJvcXAJAPEG8K
        6Rdv7LbrZcraUkNrw68CZrJGZWWfwVLVk1CTvxhZ1BZgBqZu5EJduNevNFRtXR5n
        4I6umJCocFUZWXozdCfQTQG7kYSB+d7MpxR9BL7cbUmdXwHkV6q9ebieCPxLBWpS
        g4XjT9qaBZpxRw96wgXaZFh2B6+6dxd3hxaAME5S4pdk9N7r9sub/jvLG+k7KLbQ
        ==
X-ME-Sender: <xms:nxNFX6yxuvSuu-Z8Di38cWYcCKkhWufA1c57mmQ4U9hDgRlN8PlXAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:nxNFX2RKpCnmTKla08HUz3kF9C2W5doYQW8rA2h9Q0pBIY1Wz1nGzQ>
    <xmx:nxNFX8XcWZkhIvpQt4NKJQX_-g95nfb29F_Nj3SUb2faSejoUidPkg>
    <xmx:nxNFXwhqG6gZvjqhAM70OMNr1mvpOMw29cY2xznXN332cJHnVRNcPA>
    <xmx:oBNFX_MIKJG3ugU8S1c_5NY6S6CFtYksfc9D6n6idfw_YTCjXWqvaw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9BBDE3280059;
        Tue, 25 Aug 2020 09:35:27 -0400 (EDT)
Date:   Tue, 18 Aug 2020 11:04:09 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Alexander Kochetkov <al.kochet@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexander Kochetkov <akochetkov@lintech.ru>
Subject: Re: [PATCH] arm64: dts: allwinner: replace numerical constant with
 CCU_CLKX
Message-ID: <20200818090409.te6oefjtuseclx4g@gilmour.lan>
References: <20200803143022.25909-1-al.kochet@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pga65g2vz6oo4kok"
Content-Disposition: inline
In-Reply-To: <20200803143022.25909-1-al.kochet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pga65g2vz6oo4kok
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 03, 2020 at 05:30:22PM +0300, Alexander Kochetkov wrote:
> From: Alexander Kochetkov <akochetkov@lintech.ru>
>=20
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>

Applied, thanks

Maxime

--pga65g2vz6oo4kok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXzuZiQAKCRDj7w1vZxhR
xRD2APiHXOaxYjxcyyB920l1xxejOlrk/yVKF/YHdgQVWmQSAP9lU84Nbjf9wLwA
nrvH0z9sV68fq/EbcHryPrKy++qdAw==
=UJIV
-----END PGP SIGNATURE-----

--pga65g2vz6oo4kok--
