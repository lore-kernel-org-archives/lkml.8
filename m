Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D60C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029FE20732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="gpbr66qM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ddOeckvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgBXKgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 05:36:37 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:41107 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726216AbgBXKgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 05:36:37 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1E1A07445;
        Mon, 24 Feb 2020 05:36:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 05:36:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=98AnBcjT/7SHHMY59lwxXE1iEWB
        ci2hepKPUud3s7Ws=; b=gpbr66qMYvCLa/hrTLoLlWpQuhyFBOw5y91GB87bIRB
        ps5Kk9oXhlcpFVYtHWAeKO9e2Q1LoEqzqmQxfmTn09a3GVv5UEd2wiTPTa4pPrmR
        j+Ufpdb+aryj7xapQhv+w1np++en51FDaIeZqTzu2Vc+V5zpsC825EicUhkXN6th
        bx5Z/r2ARMvp4TuCZ58TBbgeFDZhg/hnJ/g5F25X5igJEZXBLTMPzCpZe6Hnjj+r
        Pa7dgGLrF6+0J7plr4z2Z8Nhn/+9+d5Ch5gtoaVNKwkfZr4eQIbSRnXGUmLbaW3L
        OjrRcjE5JiVfzvNDb55as/y64AJHpmoqBq9WQ6wgW2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=98AnBc
        jT/7SHHMY59lwxXE1iEWBci2hepKPUud3s7Ws=; b=ddOeckvY53iYw8cUHLURIt
        AmDwl1cxzcAVvtD/wi+FGGnyyz2CEc/Z4t3FKvwHITkv4qs+ho76EHEbTtV0Q5MK
        RxGJH6I8s9DdCDAVx9FSss0l/MfHTYPh57HO2Ap1jA/uTaTReSaJt7Mgbje3YqSN
        ZLz1nmP89dLUSgxOcCSfe0dUNjIo0T2XzU9PmOR/6S81X6cCnoi3g9s+VCXbGbsH
        8q/faAaq+RhTy6dRZA4Pm7xgZTHQkWsVrK+S/Ed8EGTjAGiUPtZaFIeO1eRLTwNM
        O/QroJ/oe1z9kvEFIgUsvLX8Z4Gl1VCWNQro2TJpoRt2QPRYnSblfGKRVPiQZDBw
        ==
X-ME-Sender: <xms:MKdTXvsFRLXmY0aXtwV7TYSTzGWMkpwleawOtphwNnsYpdynykKKGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:MKdTXrITZ1dfZ4RwR5rMHGl7R7BlkDYZ99H5LEMjBhqwPd70dxw3aw>
    <xmx:MKdTXrcYLwQXP4w0azweTXDeaBrTPU_5CwWmadIpS2Gv789Ar9rJnA>
    <xmx:MKdTXlWS60wzfuiDpzEXXNLCjcz9kpFjGr6D2BVOK9NrkP0NSlPjrQ>
    <xmx:MqdTXv7oylQfOnEuPSKw9lrk_UIU5cD0u1jq47Qe2bi2NaYHfaHfcQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 34AE83280062;
        Mon, 24 Feb 2020 05:36:32 -0500 (EST)
Date:   Mon, 24 Feb 2020 11:36:30 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v7 2/6] mailbox: sun6i-msgbox: Add a new mailbox driver
Message-ID: <20200224103630.iqvs2qhsve6mgfjz@gilmour.lan>
References: <20200223040853.2658-1-samuel@sholland.org>
 <20200223040853.2658-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4fdqcj27v6pfsjny"
Content-Disposition: inline
In-Reply-To: <20200223040853.2658-3-samuel@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4fdqcj27v6pfsjny
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 22, 2020 at 10:08:49PM -0600, Samuel Holland wrote:
> Allwinner sun6i, sun8i, sun9i, and sun50i SoCs contain a hardware
> message box used for communication between the ARM CPUs and the ARISC
> management coprocessor. This mailbox contains 8 unidirectional
> 4-message FIFOs.
>
> Add a driver for it, so it can be used with the Linux mailbox framework.
>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--4fdqcj27v6pfsjny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXlOnLgAKCRDj7w1vZxhR
xSYSAP90wmCOPtG7vTl+Qa8bGIV4x6/FQdLNVSWtHx6m9COPCwEArxwMK/wR/nQz
ZE/ck+ygsbElW4541iFuMeW7JxhIsQU=
=kBdP
-----END PGP SIGNATURE-----

--4fdqcj27v6pfsjny--
