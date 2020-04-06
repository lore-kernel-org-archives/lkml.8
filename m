Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE23EC2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A721206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Ro214fb4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FR5Grp1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgDFJPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 05:15:14 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:47793 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726744AbgDFJPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 05:15:14 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id DB10B58014F;
        Mon,  6 Apr 2020 05:15:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 06 Apr 2020 05:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=Yo+kk4ssQ5zTwLnaP0Ele1F1y+q
        26rLa/dshj8KwXRs=; b=Ro214fb4noi/VPI5Awh/ibsEBUH7Z0GDSeRdL6qHYNE
        WSGTgsQP5+6VhuWw9Ijk1lgaOPmNONRf3EXjX8sa2BbJjqInAyBuf7Uv+Iy9M5+L
        usgr7yewwEJCyjQBbXkhtq1iAOxPOgrQKjQn97RIGsIpyIvAbly7HOg72t48Anxc
        8DH12mBcovs+0oMyKWConql2bipT4Xc3eACcVNNoXxKaaaWJfQMbqRSSel++g22P
        88fpGjS/9ACxPKF+9zWSFkDNDfukHxY7Wq/CvlnVHC40a2M4Am/eO/w6YbA0mu2x
        vcyPGvsuxx1bp4fA/89o74GRTRPjrTba2A8I+WhmUTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Yo+kk4
        ssQ5zTwLnaP0Ele1F1y+q26rLa/dshj8KwXRs=; b=FR5Grp1IpF2SHehuXf4r3T
        jtjEpQUxE/4oUH49uBfa3ICmSkitQx0xtqkdtzt9M/hCnqxkETqV7RBMO/0CkIu9
        xeBKOs9HQS2snUBhB3iidR9TZaoU3kG4SaTcsr8RKXhgLrHih+Muo4tTin/yFwEP
        O6tLMUSLGUkCCNCRi0u9oLIkmmJoAUkyU/5TlYtTZsTBZmKxrVW74qoGeI5nnS+5
        5VObxN3qoh1brt1cxFT5fdkNMERQrJ5AcqzOzqLGEtHAgV7TZaz7z+Si/AY3TobL
        vZ4vzoDsgtCsa17DkciA/hIEqII76xDso8J5lB5yuSC5gLhGxnwXssch2lh5Jm2g
        ==
X-ME-Sender: <xms:HfOKXr5Nyxk6k1GVM9huhudZON1Hd0xo4IV5rT93EZvHaC1VzD3jTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudefgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucffohhmrghinh
    epkhgvrhhnvghlrdhorhhgnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnh
    hordhtvggthh
X-ME-Proxy: <xmx:HfOKXn0d3TaUbMsAZPubP-kvk10FGNh38AW9nbJRP30Fl6YIAcNAAg>
    <xmx:HfOKXnn4plu2WCUixfRxj3e5hNUQWt_Gk-ZHD2dx30OJhCPOGFUKQw>
    <xmx:HfOKXggQ-btirr7O0G8WO0ikBaRltjPaSejWBznZ5pkiSr3u8c_CCg>
    <xmx:HvOKXmsisu5MBDr0BCoB62pLG6EMM8T4AHp8Oc61JSeoAWyA-6YXhw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7C6C9328005D;
        Mon,  6 Apr 2020 05:15:09 -0400 (EDT)
Date:   Mon, 6 Apr 2020 11:15:07 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v7 0/6] Allwinner sun6i message box support
Message-ID: <20200406091507.jojdzjidru64sjhm@gilmour.lan>
References: <20200223040853.2658-1-samuel@sholland.org>
 <59dc1ee9-a369-7cf9-df6a-4b5b99e24324@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xdzfhjy327jx4nkm"
Content-Disposition: inline
In-Reply-To: <59dc1ee9-a369-7cf9-df6a-4b5b99e24324@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xdzfhjy327jx4nkm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 01, 2020 at 11:55:34AM -0500, Samuel Holland wrote:
> On 2/22/20 10:08 PM, Samuel Holland wrote:
> > Samuel Holland (6):
> >   dt-bindings: mailbox: Add a binding for the sun6i msgbox
> >   mailbox: sun6i-msgbox: Add a new mailbox driver
>
> These two patches have been applied for 5.7[1], so the DTS changes should be
> ready to apply as well.
>
> [1]:
> https://lore.kernel.org/lkml/CABb+yY0-q+5+pqP-rBHCYpw-LmT+h80+OU26XL34fTrXhO+T3Q@mail.gmail.com/

Sorry, I missed that it was merged and sent for a PR.

I've queued the DT changes for 5.8

Maxime

--xdzfhjy327jx4nkm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXorzGwAKCRDj7w1vZxhR
xfkjAQDQamF1U+7L7tVY2lQH6acuSJ6qmfCYNC0tJ9ZUu1NNmQD9H2qUHh5Aqh+d
wYXK+j0yeHQAgMu9TwBZ32Dg/eeKRwU=
=ay2J
-----END PGP SIGNATURE-----

--xdzfhjy327jx4nkm--
