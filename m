Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F794C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283BF2073E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="WJ19pKRi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gBbVxrhQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgCXPhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:37:47 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:34175 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728783AbgCXPhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:37:46 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id D33087E1;
        Tue, 24 Mar 2020 11:37:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 24 Mar 2020 11:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=/8GGCfjSDSOcyCzU/fE+Iy8ZyVZ
        xms/k45jF55KNAxo=; b=WJ19pKRiEIaAXaeehQTWMZ6VLS1+ll8gJWvaPC2tkLl
        XEMD/BqcgYtsa+3l3XNNFQ1iBkNrGG8mBeY4crczeaaQrGxHkMVR+h+/GTRVIKKe
        ssAF5k7PSfDo4SMqvKB7Lgpc8ov7EuiNlkeXwjG6hJRSG0Ql3QfEFY20y85XTU7P
        OZnJBpIcaee4PlVbuzmfUMoCjwYyUdoYDsSGOfhcVV/GbV8ldW194i8/zoJJZJ42
        SbHW5pKLc2mB4Bh0mw5upRi25Eu3KdX6YyW5Q/W3+oxaHPMLbPxJ/Ok/ob614tYg
        XPqC5Rg/Buk3oW6m8zuApC+fuhzQokYGsxLWRjiSxJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=/8GGCf
        jSDSOcyCzU/fE+Iy8ZyVZxms/k45jF55KNAxo=; b=gBbVxrhQXOK8FAkMp5Ows5
        lRajk1ZPTs6ItDc8Le9JDUUmXjSy4OvfMFuFWViVgn5sxfBeVVnxM/QbrYjqHJoD
        Io+9BdV+Z+KpRI/CzK/BUSVYLvJVaqGwxKmx7lbQoIR74RnwkYSxAHlRmdiTmfg2
        nfGuO3WxBKgWonfA4J9xoLFxe/oYGG1oz6ELFmutShR0LzM5fob1iR+ThJMW9/3D
        xqywP2nJKCP2DZf7uuAanlgvVbtijz063mKwDpBaYQfEwtZuC9jyVQuHWxyPiplY
        GHcWTo1Hh2yWD3wg4SHVys+ENmCVi/nDsZ7S+wm7OekKiV9aybUE221YzQSdjcXQ
        ==
X-ME-Sender: <xms:Ryl6XtXnp7C2olFE8f6_A00PYCJj_hoeqmAvUfWCK1JduUXG4tBNGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudehuddggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:Ryl6XoQgvcBUJKlflXshJpxZjllKlRTyrrejaSXnTteUeHbbh2Ci7Q>
    <xmx:Ryl6Xl3R7doO7hxE58iR8Tb_OBjZ0JySI4O-EqnMc6i3SsA6wB3gVQ>
    <xmx:Ryl6XmWF6DIrrLppP3g2drl5Us6eM57P_TNmYPgJ82_5pZtW1t7MZQ>
    <xmx:SCl6XsqanWQS_PVX593aPxHhsNOMQcO1Rdxo3okOMx8V5Rp53P_Oew>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D5E443280059;
        Tue, 24 Mar 2020 11:37:42 -0400 (EDT)
Date:   Tue, 24 Mar 2020 16:37:41 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Emilio =?utf-8?B?TMOzcGV6?= <emilio@elopez.com.ar>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH RESEND] clk: sunxi: Fix incorrect usage of round_down()
Message-ID: <20200324153741.cduhe54zya3dfn3z@gilmour.lan>
References: <20200317211333.2597793-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qd23x4pcu2qxe5pk"
Content-Disposition: inline
In-Reply-To: <20200317211333.2597793-1-rikard.falkeborn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qd23x4pcu2qxe5pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 17, 2020 at 10:13:32PM +0100, Rikard Falkeborn wrote:
> round_down() can only round to powers of 2. If round_down() is asked
> to round to something that is not a power of 2, incorrect results are
> produced. The incorrect results can be both too large and too small.
>
> Instead, use rounddown() which can round to any number.
>
> Fixes: 6a721db180a2 ("clk: sunxi: Add A31 clocks support")
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Queued for 5.8, thanks!
Maxime

--qd23x4pcu2qxe5pk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXnopRQAKCRDj7w1vZxhR
xbsDAP9HNPJgJv/i/PES34txFREPG9WzuLhxYhExZ+57Dfp4bgEAoMRzRRzGl9/L
zvgAgAVuBVoC83GhKIqHFx4eFO8iqgo=
=KHLP
-----END PGP SIGNATURE-----

--qd23x4pcu2qxe5pk--
