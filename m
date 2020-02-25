Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBA4C35DF9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5120A2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="aF6UJQFg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OQfE9EZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgBYJFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 04:05:09 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54119 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729153AbgBYJFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 04:05:09 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id CEA3722085;
        Tue, 25 Feb 2020 04:05:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 25 Feb 2020 04:05:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=hKt9OOfB9XeD3ZLSEgsAq6xaJ/6
        rxoPVZNvP3Ww5CRw=; b=aF6UJQFgDWDX+W6sZ6uarr50+bF/ndtyBmSx9iedziC
        QMoILY2bSbT+Pyatw/rSDIE9wGNOhjNSp6OMcDIqRKSbfpuA9fdhpJOrIot/fHvl
        d7R8b4yFQsu6DIK/SdQVZ+vc710I7aZ9GRqm3sIL4+u4rtVdRYnaaVLWqh50Qzft
        VxRIHd4TYkAnaiybjvRKCBcU//kcMWfCWlhU0lc/CLzhN4ofa+G9bD6BQYZ17cs/
        Ck04yDs/1QhySXrwNdSTin6ao8SVJrH0Bzfl7CGbfgHFjGelcs3yTA6As+1g0wA3
        bqn5+fUdsgDGpbwGdgK8r9OdVFs4KrB8PvHfIC/g+xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=hKt9OO
        fB9XeD3ZLSEgsAq6xaJ/6rxoPVZNvP3Ww5CRw=; b=OQfE9EZS6U5GwpmMsz2WTQ
        HBZ+eikiYPUFE0eJiEERN/Tux0JUueQw0YlqKxtGVsgRzbNlPN9Swo68DVtdojAh
        HLX1Q1YenlnHHaP4b+7IOR5C6GbKTkJNuQjOaMvI63vkT/O0SWLq78oQvD4rNWOK
        LyG07ViY3+Ya7S/aywwDDcPQdN0FYwRcLN7obt9ORk1qLyQtu8b9yx/ynbd0ZDGv
        T1oRgl0MiLD3Nb0OOmylJQ18txU3hwVcyP/D3F0LMZKlBls1qLA7cbkGL32mUJK0
        qR6CXWIoP8sqcw3IpOXI0TauIeJXRETCgLfze0fS1RyPH9oEFHiUKW5by+XUnFjw
        ==
X-ME-Sender: <xms:Q-NUXhdSGO21088RZoqhnwU-N9Z2TZhsRXqtw8gl1QaKUpR-l8P7Kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledugdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:Q-NUXjeTdA0LaTk9oFS3bfmdqTPNIZI6_h763JfXq3VkckM7WeMVFw>
    <xmx:Q-NUXlgFRaFwZf9-FscMZvjqZAtCQNqeuHpo6xzEfNZl8-k1t6Y9dg>
    <xmx:Q-NUXvRfT_njXx0BBTIHubCLo8Yxw_TGcbjiI_eVw5Gc6TtURtrwQg>
    <xmx:Q-NUXpvbwx2KCPU45bA4GJylYdbpbnMCtciTsU6k9hu3iaqB39F-RQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5F6BE3280065;
        Tue, 25 Feb 2020 04:05:07 -0500 (EST)
Date:   Tue, 25 Feb 2020 10:05:06 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ARM: dts: sun8i-a83t: Add thermal trip points/cooling
 maps
Message-ID: <20200225090506.4fnylq56bscuhtf3@gilmour.lan>
References: <20200224165417.334617-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vwpjjsjg2oauasuz"
Content-Disposition: inline
In-Reply-To: <20200224165417.334617-1-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vwpjjsjg2oauasuz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2020 at 05:54:17PM +0100, Ondrej Jirman wrote:
> This enables passive cooling by down-regulating CPU voltage
> and frequency.
>
> For the trip points, I used values from the BSP code directly.
>
> The critical trip point value is 30=B0C above the maximum recommended
> ambient temperature (70=B0C) for the SoC from the datasheet, so there's
> some headroom even at such a high ambient temperature.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Applied, thanks!
Maxime

--vwpjjsjg2oauasuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXlTjQgAKCRDj7w1vZxhR
xYalAP9vnW4VdHS9SOdq6rECbAh1zFYhmhM1JDb6JlXtDGMdNwEAvKgrrmVt/jfK
sa2LzjhCPTU65QA8na0nLnyQC3clbwM=
=gevU
-----END PGP SIGNATURE-----

--vwpjjsjg2oauasuz--
