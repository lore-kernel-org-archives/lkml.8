Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81609C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 599DD20772
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="ZjbN1tNw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LPxmf7+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgGJMgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 08:36:23 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:38899 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726725AbgGJMgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 08:36:22 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id A423DB1D;
        Fri, 10 Jul 2020 08:36:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 10 Jul 2020 08:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=7
        oMy9IpqZYDqcm9RBEJcXVJlmud15j6wXDnFy51KAZA=; b=ZjbN1tNwJV7rtuNQd
        yYU99gG4fq+bweOaAWQZPdQwIqLgUiyIPyIq3ED1k5vCy10ZH/0KS+3jjxzz01s5
        xJJq6K5bTsmpyxgNGXFLRnKF88GMI2H7vh5CE1CziOYlHuCgmrwZVsuIazWpdurv
        0WPm+CZ5qx3NidGx0viflEo3faNMJObmMWk4XS0jjI83gP2EgfIeo1qCVnvpDc+g
        /R/brjOtYIBw5BuvXEeM9Zle9GF4PrueIfUqYBFAer6c2rY+B6ypnVGpz+eBfG+9
        8hPAZyBEAlU+BpfGtxwDt3L4IfMRkobSHwNtQJMoOIwJz9j4/9dzmIjud4dyM7EH
        iwpkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=7oMy9IpqZYDqcm9RBEJcXVJlmud15j6wXDnFy51KA
        ZA=; b=LPxmf7+EeM8ufDyFsfufrAF5nCUIAL3FaRx6+oYgBcHNvcXn9POb3KK38
        PgXsTnJ6NmdWNh2llArw7mt9Ov/SQ3BWHBEJUI/z4WK7+JY5UBWjqclTg7IZsSYV
        L58exbIDfPmE4YMLs7/MYogtCcXbAqtjx7BXWXfrYKUnwniyJ7JAUF6zRYPKxYQo
        dwadnFnptDrWzm7TXL7H8dWMmZKaYn2L2Zox75yWbFY07CpeSWaShNTYNQ7f+ih+
        gRNG5b8/n9f+19wyvlQPmv1n/cRtP60Uj7TzzQBW+BkXGPynPfXYM/XxAQCNx9vZ
        5kJBirAnKa6Alx36Y/Xuhq3XfRlPg==
X-ME-Sender: <xms:w2AIXwcvRh_W_evR2SXH1o-6toM5nL2sdnjyj3J46rcyCJGCQn6VWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrvddugdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtqhertddttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepheelvdfhkeelgfevleekleduvefftefhudekvdffhffhgeefuefgheegfeej
    vedtnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:w2AIXyNsjBM6VT_FlwZCXc8YFW273hPL4Uwi2DfTEoaJ8BQCWQpHtQ>
    <xmx:w2AIXxjVlX1bWo_gstltWIb1nHiTzSKOnQiYy-Q-q5osWWbkYEIxow>
    <xmx:w2AIX1-3Qp0v-wRA-REDijmFd7vuNU-yoQKvnkArPvQjfxPSsCN5kg>
    <xmx:xGAIX2W6IS2PqjBfGb-itlj9mtsWOE13Y9AtTz_DZfr02Fr8gjUY-w>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3A2403060067;
        Fri, 10 Jul 2020 08:36:19 -0400 (EDT)
Date:   Fri, 10 Jul 2020 14:36:17 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     wens@csie.org, robh+dt@kernel.org, tiny.windzz@gmail.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, huangshuosheng@allwinnertech.com,
        liyong@allwinnertech.com
Subject: Re: [PATCH v3 16/16] arm64: allwinner: A100: add support for
 Allwinner Perf1 board
Message-ID: <20200710123617.ebd2ljn7okdrx4ph@gilmour.lan>
References: <20200708082821.13188-1-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200708082821.13188-1-frank@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 08, 2020 at 04:28:21PM +0800, Frank Lee wrote:
> A100 perf1 is an Allwinner A100-based SBC, with the following features:
>=20
> - 1GiB DDR3 DRAM
> - AXP803 PMIC
> - 2 USB 2.0 ports
> - MicroSD slot and on-board eMMC module
> - on-board Nand flash
> - =B7=B7=B7
>=20
> Adds initial support for it, including UART and PMU.
>=20
> Signed-off-by: Frank Lee <frank@allwinnertech.com>
> ---
>  arch/arm64/boot/dts/allwinner/Makefile             |   1 +
>  .../dts/allwinner/sun50i-a100-allwinner-perf1.dts  | 180 +++++++++++++++=
++++++
>  2 files changed, 181 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-p=
erf1.dts
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts=
/allwinner/Makefile
> index e4d3cd0..ab780db 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -14,6 +14,7 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pinephone-1.1.=
dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pinetab.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-sopine-baseboard.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-teres-i.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a100-allwinner-perf1.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h5-bananapi-m2-plus.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h5-bananapi-m2-plus-v1.2.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h5-emlid-neutis-n5-devboard.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dt=
s b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
> new file mode 100644
> index 0000000..38621bb
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (c) 2020 Frank Lee <frank@allwinnertech.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "sun50i-a100.dtsi"
> +
> +/{
> +	model =3D "Allwinner A100 Perf1";
> +	compatible =3D "allwinner,a100-perf1", "allwinner,sun50i-a100";
> +
> +	aliases {
> +		serial0 =3D &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +};
> +
> +&pio {
> +	vcc-pb-supply =3D <&reg_dcdc1>;
> +	vcc-pc-supply =3D <&reg_eldo1>;
> +	vcc-pd-supply =3D <&reg_dcdc1>;
> +	vcc-pe-supply =3D <&reg_dldo2>;
> +	vcc-pf-supply =3D <&reg_dcdc1>;
> +	vcc-pg-supply =3D <&reg_dldo1>;
> +	vcc-ph-supply =3D <&reg_dcdc1>;
> +};

There's something off here. The PC supply is set to eldo1, but

> +&reg_dcdc1 {
> +	regulator-always-on;
> +	regulator-min-microvolt =3D <3300000>;
> +	regulator-max-microvolt =3D <3300000>;
> +	regulator-name =3D "vcc-pc-io-usb-pd-emmc-nand-card";
> +};

But here you say in the name that dldo1 is a PC supply too?

Maxime
