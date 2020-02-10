Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BACC3B185
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4572080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="F8jbaGgZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fEq3Z14v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbgBJJl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 04:41:58 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:51037 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726950AbgBJJl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 04:41:57 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 4428A21A97;
        Mon, 10 Feb 2020 04:41:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 10 Feb 2020 04:41:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=d9UVYjOFvIhqvu/YHII/qZzXr7G
        ct38JABDmCn0w5X8=; b=F8jbaGgZDT1zY6FziFyoGrH3wIfbJuPJ73uKI0lkfHv
        vCi+Pc4X+lIEp08xpgBcD5xGp9t9atMo0Gj0oWynWeNryrVfs/BwlQpSzZcSqAJG
        vsSBQAdUddK5Lp8vRCwz6khYegKe2o5n7jcnw6BTR5doVtnH60Vhe0ndMTn8+CU3
        4NAfNmjzEaPup0NiXBymdL8oZmZlIhDw/WjpwVTtKtde5laTJeMmFcvh3oq4HisD
        +mJTh1Xg1w8gulkp9Um/J6k8Rwj4c3j16QYhtPVx20u0TDsh+dtpbFakhTp5/end
        WqV/pzp8QopoXaH/8cS1fbQsg75uzzwNz3RFE9/I4gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=d9UVYj
        OFvIhqvu/YHII/qZzXr7Gct38JABDmCn0w5X8=; b=fEq3Z14vxDFoPUpI8LNKnT
        1po7RhhotquPwjoZMoiG522U0RLNM+kL15EwORlMY7ROqKtt1biz6UenZoElBn+P
        Ongy9vWxFy7Q+0BAjIibG9UYs1TSSLr0t83Q8D7MARwlIiubQD0mH6OfbG6vfi5H
        Q54LjaYQ61mFDOvBKdvxH9c6ehPf9C+5KElxKLkdSMj9duEtmCr8YXZnkVQ5MnY3
        8eZFWp6VNlYYuFj6cMTLurWA0apyF7BMO/Fcjw7XlfR8rqA0hNz/frWHGox8qsFF
        7x0aU/SxygcaB3wGoge15EGHmh4X3QLyun7BV+0BNPodPwqqSDLttE9GJl/t+ALg
        ==
X-ME-Sender: <xms:YSVBXrZdgESm-gLNg8o2FjfJ8kFqNc3s10vMd8n0mXnZwWYcp9r2Ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedriedugddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghr
    nhhordhtvggthheqnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordht
    vggthh
X-ME-Proxy: <xmx:YSVBXguuX4srb9zEpsDxIHDKbieKrmlSaTvfNSxo31KSrDqBv5OZQQ>
    <xmx:YSVBXqpTd2D-cb2Z-ObYq0wSWBgYy7vThsHVJJIRPI4A4JuUbRVvlw>
    <xmx:YSVBXgTUaMzlrsKvm9yshoBxnRBwLMvjeXyVaPqEp1cahlaCeg9DWg>
    <xmx:YiVBXmCnnFqkmhuNBJnGYWlcsJGl2vDH_y_SNEEukQenm-d7gt8hJg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6E65D3060717;
        Mon, 10 Feb 2020 04:41:53 -0500 (EST)
Date:   Mon, 10 Feb 2020 10:41:51 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     agriveaux@deutnet.info
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun5i: Add dts for inet86v_rev2
Message-ID: <20200210094151.acim7h4yladgluc7@gilmour.lan>
References: <20200210092736.3208998-1-agriveaux@deutnet.info>
 <20200210092736.3208998-2-agriveaux@deutnet.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i5c7nphjkfrh5sot"
Content-Disposition: inline
In-Reply-To: <20200210092736.3208998-2-agriveaux@deutnet.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i5c7nphjkfrh5sot
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Feb 10, 2020 at 10:27:36AM +0100, agriveaux@deutnet.info wrote:
> From: Alexandre GRIVEAUX <agriveaux@deutnet.info>
>
> Add Inet 86V Rev 2 support, based upon Inet 86VS.
>
> Missing things:
> - Accelerometer (MXC6225X)
> - Touchpanel (Sitronix SL1536)
> - Nand (29F32G08CBACA)
> - Camera (HCWY0308)

Same thing than for U-Boot, you're missing your SoB.

> ---
>  arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts
>
> diff --git a/arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts b/arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts
> new file mode 100644
> index 000000000000..e73abb9a1e32
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2020 Alexandre Griveaux <agriveaux@deutnet.info>
> + *
> + * Minimal dts file for the iNet 86V
> + */
> +
> +/dts-v1/;
> +
> +#include "sun5i-a13.dtsi"
> +#include "sun5i-reference-design-tablet.dtsi"
> +
> +/ {
> +	model = "iNET 86V Rev 02";
> +	compatible = "inet,86v-rev2", "allwinner,sun5i-a13";
> +
> +};

If it's exactly the same device, why do we need another device tree?

Maxime

--i5c7nphjkfrh5sot
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXkElXwAKCRDj7w1vZxhR
xVqQAP0WqaoWFqiHegUKPvKlv56b9oGniB5VpWmrxYdYEA2xdAEA72tUhIcb89Xk
YbyBfShDx6jSAVf/b7hvE/yy2ZX+ogw=
=YSHF
-----END PGP SIGNATURE-----

--i5c7nphjkfrh5sot--
