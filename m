Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D38C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24144208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgIJVnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:43:20 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:47251 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730477AbgIJM7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 08:59:35 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 28C9E5C00C3;
        Thu, 10 Sep 2020 08:59:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 10 Sep 2020 08:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=sS4bxANMr6xg2qR/hZMWsTq/vX/
        b6tWWMKIQiRigbQE=; b=knM5OhHJXfCtJlWt5+CqX4Wif+JUanAB+5KN7YGGX0P
        EltwyRGjJ/mrFWYC5mBqrnx7CjvLoPq4yqyBkOPKsQULHk8V9Nl7Nqfr4tirMZYQ
        eKW1WIJOg8bEJ9SS/tBb9YgMi7jFgQfRZurnrOqigiEg3whBXx9uko7q0G2oTsNU
        lZ1nZXmC06ssniIP0jheWg1ANJGj5se6oljTZx01aJ3XzRPJQcfjVmHdu8WE4HTb
        rYsqa7iEdcez/aaRvRTAxiP+WmUnvsvqZeLzNjZ3BbYxhDtqD83P9Czd04QOOVT3
        qq6Kt7QF4k8CxO6szq3KorqxLX3YUvbG/PpQunE+pPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=sS4bxA
        NMr6xg2qR/hZMWsTq/vX/b6tWWMKIQiRigbQE=; b=nEac7f/KFbNEe3+Az8DpBP
        Ix/9LxJRpbjFIUiJ0mUZbmi9wCz7TWesoQuDkkxgHKRMdSdG9ITSeERsMugtvM5q
        26ouyAdpEgamV2U8MKnKE1geUpbd2RHmHYTGtxpT0WJntwWVYv22Lr3o1DkeIyMw
        9wMZMI42ktGqUAZRYTPPQeulzi2uwLWN0gm2IDt9bpLqhs3nYjzA5VMm9CckLTth
        f1PFggFfa9EU5+/Zo3nWTxoqoUwEiFmxFyTz8cjKUuvV0eAheH4ijzfn7r9q/h9L
        EmeIA29TBExcgQwvlhy2q9871+GdNqxdljuWAczVkX92zwFS5jxfMkG9WvwNdmCw
        ==
X-ME-Sender: <xms:MCNaX81rwQZTtf8P0RRzxz4fbabqsOrecMIQEzydc8jrDcG9Gs8cAQ>
    <xme:MCNaX3EwJxb9WGSsljgIvLeqFGiEa0lsoCcYhz1ZijPZhNrrAbWNJOwrqJuooRDFT
    aes9sIjFBcUPp4ARyM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehjedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnheptdfggfelgeehieeuieegfefgueduudefheffhfejleekheefjeevveegueel
    ueefnecuffhomhgrihhnpehlihhnuhigqdhsuhhngihirdhorhhgnecukfhppeeltddrke
    elrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:MCNaX05-wUET0GjTQjjIpn3k7xJuu5xP2xFok--Pw__JW5uHdb4x9w>
    <xmx:MCNaX11HqC-07I2CXQb75YDyKb6putjsQnQtnQZLSe1KWPPgf32uZg>
    <xmx:MCNaX_G0wyYbqCBIkZml-CyEVC7Wc0oszK--AJ728vHg01Tvyhm7JQ>
    <xmx:MSNaX1MBzNczurbftulWRhbkpZz6E0lQz9VRieg6G0mDcNFrMcSqNw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id CA538328005E;
        Thu, 10 Sep 2020 08:59:27 -0400 (EDT)
Date:   Thu, 10 Sep 2020 14:59:25 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Wilken Gottwalt <wilken.gottwalt@mailbox.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] documentation: arm: sunxi: Allwinner H2+/H3 update
Message-ID: <20200910125925.f3m5gd5ngcv4nxiq@gilmour.lan>
References: <20200908131808.GA65247@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jqmigleombspvxe5"
Content-Disposition: inline
In-Reply-To: <20200908131808.GA65247@monster.powergraphx.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jqmigleombspvxe5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 08, 2020 at 03:18:08PM +0200, Wilken Gottwalt wrote:
> Updated information about H2+ and H3 difference and added a link to a
> slightly newer datasheet.
>=20
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@mailbox.org>
> ---
>  Documentation/arm/sunxi.rst | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/arm/sunxi.rst b/Documentation/arm/sunxi.rst
> index b037428aee98..50b9199d929d 100644
> --- a/Documentation/arm/sunxi.rst
> +++ b/Documentation/arm/sunxi.rst
> @@ -103,12 +103,15 @@ SunXi family
> =20
>          * No document available now, but is known to be working properly=
 with
>            H3 drivers and memory map.
> +        * It is basically a H3 where the GMAC block was replaced by a 10=
0 MBit only MAC block.

There's more to it (like 4k output in the display engine iirc), but I'm
not really sure that it's this file purpose to document each variation
between SoCs.

>        - Allwinner H3 (sun8i)
> =20
>          * Datasheet
> =20
>            http://dl.linux-sunxi.org/H3/Allwinner_H3_Datasheet_V1.0.pdf
> +          or a slightly more up to date version
> +          https://linux-sunxi.org/images/4/4b/Allwinner_H3_Datasheet_V1.=
2.pdf

Why not just update the link?

Maxime

--jqmigleombspvxe5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX1ojLQAKCRDj7w1vZxhR
xfDUAP9jgdE8x0VrdXyNBbWljUomEg0TrJa3egeYncWwYJzb2gEAzQmvOrQUSQTB
kzN0nK4mfgx7QIWetU0KDy3rWfpQ0go=
=sRYe
-----END PGP SIGNATURE-----

--jqmigleombspvxe5--
