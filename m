Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61676C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 06:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3961C208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 06:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="i9Of1F54";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YupaDDKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgBKGvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 01:51:45 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:45917 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727870AbgBKGvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 01:51:45 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 40BA1210F2;
        Tue, 11 Feb 2020 01:51:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 11 Feb 2020 01:51:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=5mDUEWpE27ncbun9QxnoOkNQ68K
        ltXN7NhZqgt6xf/0=; b=i9Of1F543FGmbjSaxpADoL/tvuOCEilkgZFWr32r404
        2N+l8izu/XeI5g+3aZ/p/I71RmooyGBikOeB6FJONOMKYXtPuIRwhAAPSK99GDb0
        5LQfYGvAwdYY7ZQH4/FnlSbnMzYg1C6HFOH9l9yvep8Y1FZ9nSbIuMY5/QRanIw9
        nVcMwzqGs0MgqwP/gg+DLC7HfLD0LbSCSkEQb+DjqK8M6THHVFeXuV7WD5hNiFjJ
        XdtlapWxtOoL5rCFKihONBPtcOiA+mKs/OraRkAVp8InDEVG140Plh112mnc9+q7
        v6tRtzTQw+OLb4Apif31HO8rAjwZNIyQ869pPmdPIwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=5mDUEW
        pE27ncbun9QxnoOkNQ68KltXN7NhZqgt6xf/0=; b=YupaDDKQH8KkWvnj2NMsIN
        msFS1kTRSKEbfKZS10UPmHHwVCfjrpUOezeaGNk/jpbGSzBLxvInhDwlPZFWGq/a
        RQNh3HEImSUcJnff1rA2rVEGqTAOAFx4Lg/l4NMJPoBvAaCzVNAwWb0R5N3KDw5a
        dE0gNPlrXjJuS4X3wljMN2soBxNgjjadGVuM/fCoT4k8PvAbFDqTde2vNpt2bYaA
        eVsvKWJsWfnWF5L1a5fsT5KL884rYRiY+IiMq69mHLmDDYb+N16rg0I7ymNnCrAv
        EeRA+uXGgqRaRNk6cM9P9dKx5lrjCH7nwnbl1WF9jG4v/okO3webGxMINu4QDf4Q
        ==
X-ME-Sender: <xms:_05CXq0CtvoQXJAcPrhrQMOIT1ST4XuqlYRm0tpBZDMidPaCvxz4ZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedriedvgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:_05CXriOJZeHzY9O8vaqAZvXD-JoCRwm6Qcf6sUurLr_TUEMAx1QNg>
    <xmx:_05CXlqfjFeJENiJBc08Z3wzVMYqyq2OXWQN4srPF0JRVGOq4G5DwQ>
    <xmx:_05CXgp7eeiyHw7V9ufN1NbIxMP2Xu5q79kS7LUN2MVvQpF0UJ7OpA>
    <xmx:AE9CXkfzX29Ll92AO5dJHI3FkAIDopGKpsDxe4ohKkrmMgLiIG47xw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5427230600DC;
        Tue, 11 Feb 2020 01:51:43 -0500 (EST)
Date:   Tue, 11 Feb 2020 07:51:41 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2] arm64: dts: allwinner: h6: orangepi-3: Add eMMC node
Message-ID: <20200211065141.2kn2gsg5kvzu7kl6@gilmour.lan>
References: <20200210174007.118575-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ip7qoenpyd2aql5h"
Content-Disposition: inline
In-Reply-To: <20200210174007.118575-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ip7qoenpyd2aql5h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 10, 2020 at 06:40:07PM +0100, Jernej Skrabec wrote:
> OrangePi 3 can optionally have 8 GiB eMMC (soldered on board). Because
> those pins are dedicated to eMMC exclusively, node can be added for both
> variants (with and without eMMC). Kernel will then scan bus for presence
> of eMMC and act accordingly.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
> Changes since v1:
> - don't make separate DT just for -emmc variant - add node to existing
>   orangepi 3 DT
>
>  arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> index c311eee52a35..1e0abd9d047f 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> @@ -144,6 +144,15 @@ brcm: sdio-wifi@1 {
>  	};
>  };
>
> +&mmc2 {
> +	vmmc-supply = <&reg_cldo1>;
> +	vqmmc-supply = <&reg_bldo2>;
> +	cap-mmc-hw-reset;
> +	non-removable;

Given that non-removable is documented as "Non-removable slot (like
eMMC); assume always present.", we should probably get rid of that
property?

Maxime

--ip7qoenpyd2aql5h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXkJO/QAKCRDj7w1vZxhR
xfyQAQDzdcTDZGRSxQJIm3oA/QlF8QG2IrKgtCKGemsMjPqABQD+NO1FjcZSa0TE
tMAAZO2Qmyl/RlZtTR+iTc7WYemlvgw=
=ZKuN
-----END PGP SIGNATURE-----

--ip7qoenpyd2aql5h--
