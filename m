Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81174CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 214DA206CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="SHeK9zOK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T8JBWsL0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbgEMLww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 07:52:52 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:55725 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725982AbgEMLwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 07:52:51 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 74C8558015B;
        Wed, 13 May 2020 07:52:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 13 May 2020 07:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=/AYFFr1MNgJJ+o7d5S4rnrDYJJs
        eH51ikD+z7qPz61c=; b=SHeK9zOKaDJna8C4jP121kXKjyPnjNecvnjP0iCrvFS
        RnSYyReZHdXtF8jenjymlGXj4GyPYjrw+KWj7zbnFfsGgYlK8fg/wNzfyg0bT9Nh
        /OqCDyjNTwtvIaw2NL9d0btuGNQBUEfa7QT258b12Kw2sPpiH7j+54WPdn8er/Wj
        91cQDVDfwcvllyCGNUlhn31HnXvulBN+sFujWaluhTGUcg/SPpPryAL4m1bt1zTx
        PFiPFxyN9elXjGyoVWMcU5KqOkPyE0EKpCofhgbAzkYUmozWI9Ehy31b9J8IsebU
        Dux8ywFx4gcY3kCtUZfFca9w1AkVhrbiWNQyHFk5mPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=/AYFFr
        1MNgJJ+o7d5S4rnrDYJJseH51ikD+z7qPz61c=; b=T8JBWsL0UMCMphAJdRwyFl
        vifRo/GpMAtWgxUq8TqrCb2vIg9jxCJVwYcWld46z5DyZqkGjhNSZnE+ucVNyfUr
        tnbPYabxNwQSPCdOrcPJ4xB91ZEMJsKpDyCboG3l7Rw2WdyHUNNZhcGQGWJwAsLX
        GlU6H0jfie+ghTwD41+mSEKUgTnz/bqJm86cjdReeKtNa1/7sM56KKDhClrR3/Xf
        mEoTI1YS2oqgcF/rY09JOKZyQlrERN6zBnr17qyxaq+HCNnZ8jJkAQZWWDTTFPKp
        23JGyse7Ib9tcS1Ehaet5qe1iW3aCHomawEs3ZLWmXl81qaUPezQOJySlxTMLkzw
        ==
X-ME-Sender: <xms:kd-7XuKT8PhhjcEUQBW66PYqBBllwrS1yfICrXVjIUjIZdLb2gdTrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrleeggdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:kd-7XmIfmrslGfp-DubBsUSZezcfnw3zsDnedT5xMKphy8xG1oPOqA>
    <xmx:kd-7XuvAiTqYBKlxC6Sjl-8FKOU36HGUS-LxJAFEoDMvVoVSigtlVw>
    <xmx:kd-7XjaygZc2oMf_vt3tRkH1l2cHFqlQUnf8ljeLTBEjnD84e7pFTw>
    <xmx:kt-7Xh5GMsGnbqshAHOKdgr1gCP-d05hn76ukarVVctrAY8ubSeriA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 671253280065;
        Wed, 13 May 2020 07:52:49 -0400 (EDT)
Date:   Wed, 13 May 2020 13:52:46 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH v2 22/91] reset: Move reset-simple header out of
 drivers/reset
Message-ID: <20200513115246.rcago5fue5bb4xzt@gilmour.lan>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
 <6f7651682a6dab539bd89c80704c8303bbae68bd.1587742492.git-series.maxime@cerno.tech>
 <b1af9917885ee3da60de1385edd2d8094ecb3b7d.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7unmcshnw527jht7"
Content-Disposition: inline
In-Reply-To: <b1af9917885ee3da60de1385edd2d8094ecb3b7d.camel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7unmcshnw527jht7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Philipp,

On Wed, May 06, 2020 at 11:26:34AM +0200, Philipp Zabel wrote:
> On Fri, 2020-04-24 at 17:34 +0200, Maxime Ripard wrote:
> > The reset-simple code can be useful for drivers outside of drivers/reset
> > that have a few reset controls as part of their features. Let's move it=
 to
> > include/linux/reset.
> >=20
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>=20
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
>=20
> Do you need the reset patches applied together with this series, or can
> I pick them up individually?

You can definitely pick them up individually. I'll resend them separately w=
ith
your changes addressed.

Thanks!
Maxime

--7unmcshnw527jht7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXrvfjgAKCRDj7w1vZxhR
xR7yAP4lmUkJZpZ/LFiqX3QxnC3WMocoqEk7ZY3k2EIVbiwysAEAzhQyCVvDHYkA
ySN2FN++xDb5ZhKP4ThE7Y4BFL4/Xww=
=lSEg
-----END PGP SIGNATURE-----

--7unmcshnw527jht7--
