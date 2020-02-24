Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689BAC3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345E720726
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="oLgLtF9A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M6fHG36N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbgBXLCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 06:02:55 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:48625 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726838AbgBXLCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 06:02:54 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id C782F46F;
        Mon, 24 Feb 2020 06:02:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 06:02:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=xHt2MK1heAneZjk7lxOHA207z1m
        V+6niWv3tm6W4trM=; b=oLgLtF9Af//57lWcVGNMlOihaz1k9FQCx+lIUsnnjQf
        XuLwscDFImI1pV3dttYo285rMu/FvYuFuZs6FcbZMZ41Ajxe0ZaXd11YM1Dv4xzR
        HyspdQnyE4KnGUlNBXHGPlm0rhVfZO3qLoS29RYcV/siui5UgAFe9iuJH2hPgIZc
        JmGK7VbeTWHTIgqq0ZqkHjqP/q0Kf/BnyXSu0fVj/K0BKRByJTljuRG2qhtyoqdP
        0xRyeodSCVsshCMKRASEa6FheP4B7CCR6tdu4hVCUZN+/mwAsND79SZ7YFHj6Pap
        nVSs0Q6oRYtuAI5H1nZour18aCD0e1sAab1uqVVBjkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=xHt2MK
        1heAneZjk7lxOHA207z1mV+6niWv3tm6W4trM=; b=M6fHG36NgdH8xdAdDANRO5
        F1LkjzYHOossC9uRzvXexUPrRjreGhNVVj1ikQRFTUN0TlzIoflwTDwut0/k8nRq
        QgbITFTNV3W3yP2/mfGsykTkARfnRqEi5gW2Uq68OI4ZIg+DF24PjW8q/mlPMD9z
        v5g7MDRwFFD17fhrb28y2k89Yrk0T1MNRANtYwLyMMP/zpA2xQffh8mLwT1y5ec7
        vH6lZmGM7HxevW2kzoJPZIRGK++KzpuJeHiYgdZ7hgboVDJfUXhB+MA+6LiqQLFF
        4jssje7YzJi2vUCSf014B5Zsw1faGNPWm5Q3rRvPpgNSjKFpdxEhMHp2mL2IrZpg
        ==
X-ME-Sender: <xms:Wq1TXnEcBlSfOhJ8C0JNkgaSpKWsoXA3_8qG11wWKLY0KO_Zhw881A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:Wq1TXlz0QizJwVtlb7NBSTi_b2j7ky9Sq2KgFgzjALWQY8YE4BvUSw>
    <xmx:Wq1TXkjrkjETxdF64tBXJq5iHfJ3zM9-yNhEneghxHG7WVUQ_0u5tw>
    <xmx:Wq1TXiLSr4vzEJmfeMyJbAaHLqXSre4dSUW0JC5IN-CW-z8gG8EFaw>
    <xmx:Xa1TXkUAZW5yNro3fwZmf6i4muMubNGSs8O2zUAVHGqItmKKBeoXyg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 057D8328005E;
        Mon, 24 Feb 2020 06:02:49 -0500 (EST)
Date:   Mon, 24 Feb 2020 12:02:48 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] bus: sunxi-rsb: Return correct data when mixing
 16-bit and 8-bit reads
Message-ID: <20200224110248.hpi3dhp3t7q56hmm@gilmour.lan>
References: <20200221202728.1583768-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="srx47feia3nohrm4"
Content-Disposition: inline
In-Reply-To: <20200221202728.1583768-1-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--srx47feia3nohrm4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 21, 2020 at 09:27:26PM +0100, Ondrej Jirman wrote:
> When doing a 16-bit read that returns data in the MSB byte, the
> RSB_DATA register will keep the MSB byte unchanged when doing
> the following 8-bit read. sunxi_rsb_read() will then return
> a result that contains high byte from 16-bit read mixed with
> the 8-bit result.
>
> The consequence is that after this happens the PMIC's regmap will
> look like this: (0x33 is the high byte from the 16-bit read)
>
> % cat /sys/kernel/debug/regmap/sunxi-rsb-3a3/registers
> 00: 33
> 01: 33
> 02: 33
> 03: 33
> 04: 33
> 05: 33
> 06: 33
> 07: 33
> 08: 33
> 09: 33
> 0a: 33
> 0b: 33
> 0c: 33
> 0d: 33
> 0e: 33
> [snip]
>
> Fix this by masking the result of the read with the correct mask
> based on the size of the read. There are no 16-bit users in the
> mainline kernel, so this doesn't need to get into the stable tree.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

--srx47feia3nohrm4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXlOtWAAKCRDj7w1vZxhR
xZ3GAQDQc1KfI9aGFO2vdN8rwe58X/8JKWbnV1gWWOW6MvI39wEAzTL/pyT7Z9hY
YnHiJd9rQY5Llx/U60FxMs+RfZ15wAY=
=Ggtt
-----END PGP SIGNATURE-----

--srx47feia3nohrm4--
