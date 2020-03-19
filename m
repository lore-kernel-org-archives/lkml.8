Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA361C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 09:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D0D20722
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 09:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="pHUPtJq4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wa5MNnrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgCSJyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 05:54:47 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:50971 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725601AbgCSJyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 05:54:47 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id CC5E23BC;
        Thu, 19 Mar 2020 05:54:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 19 Mar 2020 05:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=AEweTAoYqzmbnIPkNbbqyUDpsBm
        QCn1jJNkZ+yktwS8=; b=pHUPtJq47kWB0/PzKUMTMDB8z2sBBBnhmNVh+Zkja7l
        YoyY6wekqF11f8jv+oZ9rY6cY/0+BwGn7LO2dlZxi0F7N9lz9PQZXH1m42FFp4bA
        HuEZ2WvwO4KzawnPzhH3ktHoELxkzQdopswvHlQTm2pIsNy2jCymTkuBq5FkFUVo
        DqH8mmfQzGpg9QrKBjp1BoveMbE8czQLI+yEgZJ5qvyFQxIkmqrlfmrUUjjoASeH
        U7AtTa//bmNddEVXUDAEhpMyEMhP+3MU0VTN0N72M8VjxP5wzTRpUqEOLDXWxDk7
        U6BgeIW24scdtKBWkEoGAR3QhCJ3HpFA10Lo6Eq5dPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=AEweTA
        oYqzmbnIPkNbbqyUDpsBmQCn1jJNkZ+yktwS8=; b=Wa5MNnrXfnbc0Ga1eRa05I
        9E+hM5kg/2N10ZhFu1qyF2q9kiPFFy3NrKBe+YLIVneH87/dU3vunv9fmeTzU30H
        xgP2ZYpmUCQ9VGqgJehzd2+t2JAtL8ZyzUdNEhZXiKQ0CyZ0Q+h4HQx8B+ora178
        OZ7vVvDDaf9OClMs9adfidvJNXZocwrCf0F467ObeL5sWpEfja9vYGwpvx4IeXOA
        zrSVYiYDAf6AYbnQ73SZonwHPwBHysSkS9KT0CgPwmN0r1rn1hLoBAm3HanRFayn
        r3raqSnPkHUFTil7FD3Jf9Tw5ZCa8H3JaSy332Ds92TsyZxv1/GBxrjgCb/sD/gg
        ==
X-ME-Sender: <xms:YkFzXgg5ohRlCNSyYewsJFE-Ihb1N3TQvAKCV6mtZ_tL0oU_aeOy1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudefledguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:YkFzXtRt1KyM74jD9WTebfQ53NFpn52mMKp4Q0NEVzOqdXnteglveg>
    <xmx:YkFzXjEoOkqBt0MeQ846QAL8ky4CFFRefhkvn-mQenTfpiU5n3h5ew>
    <xmx:YkFzXlksCnUDCp552SGsmrBF4xXVYC7IUkXR80osywZ_LnX8zGPQIw>
    <xmx:ZEFzXsOvBqFJtWlO-qhnAZjIomuTgyzpM5HmQo80aJ2HtFdKv5UYNaWMTwc>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 92843328005A;
        Thu, 19 Mar 2020 05:54:42 -0400 (EDT)
Date:   Thu, 19 Mar 2020 10:54:41 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Ondrej Jirman <megous@megous.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 4/5] drm/sun4i: sun6i_mipi_dsi: fix horizontal timing
 calculation
Message-ID: <20200319095441.zfaivhnh3pwuphp4@gilmour.lan>
References: <20200316133503.144650-1-icenowy@aosc.io>
 <20200316133503.144650-5-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="du2tzzvxzpnq2xcd"
Content-Disposition: inline
In-Reply-To: <20200316133503.144650-5-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--du2tzzvxzpnq2xcd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Mar 16, 2020 at 09:35:02PM +0800, Icenowy Zheng wrote:
> The max() function call in horizontal timing calculation shouldn't pad a
> length already subtracted with overhead to overhead, instead it should
> only prevent the set timing to underflow.

Some explanation on why it shouldn't do that would be appreciated.

Also, with the changes you have below, the comments above each max
call don't match anymore and should be updated.

Maxime

--du2tzzvxzpnq2xcd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXnNBYQAKCRDj7w1vZxhR
xVK2AP9MrOr+g0Wxeod4btE4njIJOm/ARGGGAOMiH4E54MPtvAEAvxcr9/HggXHX
CbB5ndVBG5C8Z2r5jKBQqYK0BN+Iqgo=
=YB6s
-----END PGP SIGNATURE-----

--du2tzzvxzpnq2xcd--
