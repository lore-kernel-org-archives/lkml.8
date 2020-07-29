Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DBBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D5D0206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="YwnB92Tr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgG2HO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 03:14:59 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:55620 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgG2HO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 03:14:59 -0400
IronPort-SDR: x6StlzwikKWDu1MOZ0lA7CIUwNWCYDVuzr/wNV85ZLZNahD9l+LtZvUbjgZtyuLNhZqKKuMIfG
 2WEDe27GU/1TZpsA7+CFYJa8n7Myd7ChKkeeZv/2PPILyCuxG5ShNoEuPhzWQtX/yYjx2koW2R
 YPPMEELd4HF2D7IUR6QByLdCjEjJvaXs1SnpkJpU2R2biRRxPSYz7/yeiOc4v5xOMr/kPcBFF4
 3BMPWxG5wkFsd9U3ybsFDYZxCIH1VkcktLRrY9QBX0W4MmvjorpOM2WeXwQdMGGRMWIJlYsIOg
 cB0=
X-IronPort-AV: E=Sophos;i="5.75,409,1589234400"; 
   d="scan'208";a="13271882"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 29 Jul 2020 09:14:57 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 29 Jul 2020 09:14:57 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 29 Jul 2020 09:14:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1596006897; x=1627542897;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RVYf9+lqvm1U2wO113y5gOtAIDQlfnbNeYkosjkOWCU=;
  b=YwnB92Trmyt3ofc52zOhG4gETYac5x/lw7NqxhZa10gtlL634WeimzDD
   2I19oBDm2vkzzTcbrm7dVejTKDS2GZsPF1IU0eoKoWlgW3aakEC6wWB8Y
   TWaOA48KUweNv1Y7/kKKhsQtPjJsRsyUJZW6WSPz7y+m31yZOspy6v7uu
   wLg7quDIB/xzk9Hb1eVLxuRwTKY6zoAnHVnl/y73BOxJv9Vm2n+6y1amL
   Z91ReshLG96z1ilYT3jn618+NF5/hfUHkZiOEbKxCEXCp7JUqQy0mycus
   6HzCXCbq5HVc+zuokwIb//ziiXj3U1t3tBsQiuJfy8PT9Ns7ZeYU2WMNa
   w==;
IronPort-SDR: 4ekXAohnQBN3XC+6/ijUyNP+u9C3mqLFYEwu/rygbCet+KCi0fDsWXEdCXsXv1zI9JcL13FrDp
 CWX6Af7fK1Vaf2LFSwvPzKJkU5gr8asQ62BplKYpTkCf+5jKFPxdnU4NCNJ2M1pgQXNFVOY7sR
 JzG90z1Lt/uxBZ4CdRGbYLZX+hHNYb9O9prWhsrXbfWZAq2URqeqxZRtdzn9TwMOrx5NMEuhsF
 SNsOtn/MWTFquS4gV8EDjbeP4Wo66qjYu+mnCzlQXdWOx37dpzX790Bs1Ez9KO766LZJ8A6RSa
 y24=
X-IronPort-AV: E=Sophos;i="5.75,409,1589234400"; 
   d="scan'208";a="13271881"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 29 Jul 2020 09:14:57 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 579AE280065;
        Wed, 29 Jul 2020 09:14:57 +0200 (CEST)
Message-ID: <33fbac338c9d9accda37837eb1338003b28cafee.camel@ew.tq-group.com>
Subject: Re: [PATCH v2] arm: dts: imx7: add QSPI
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Date:   Wed, 29 Jul 2020 09:14:55 +0200
In-Reply-To: <20200729071106.8213-1-matthias.schiffer@ew.tq-group.com>
References: <20200729071106.8213-1-matthias.schiffer@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-29 at 09:11 +0200, Matthias Schiffer wrote:
> In preparation for an update of the TQ-Systems TQMa7x/MBa7x DTS, add
> the
> QSPI controller to imx7s.dtsi.
> 
> Based-on-patch-by: Han Xu <han.xu@nxp.com>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
> 
> v2:
> - renamed node and label
> - reordered properties
> (as suggested by Marco Felsch)

Ugh, I neglected to check for compile warnings after adjusting the node
name. This now gives the following warning:

arch/arm/boot/dts/imx7s.dtsi:1165.24-1176.6: Warning (spi_bus_bridge): 
/soc/bus@30800000/qspi@30bb0000: node name for SPI buses should be
'spi'

So I guess this should be called spi@ after all?


> 
> 
>  arch/arm/boot/dts/imx7s.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7s.dtsi
> b/arch/arm/boot/dts/imx7s.dtsi
> index 1cfaf410aa43..22e4c38223bd 100644
> --- a/arch/arm/boot/dts/imx7s.dtsi
> +++ b/arch/arm/boot/dts/imx7s.dtsi
> @@ -1162,6 +1162,19 @@
>  				status = "disabled";
>  			};
>  
> +			qspi: qspi@30bb0000 {
> +				compatible = "fsl,imx7d-qspi";
> +				reg = <0x30bb0000 0x10000>, <0x60000000
> 0x10000000>;
> +				reg-names = "QuadSPI", "QuadSPI-
> memory";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interrupts = <GIC_SPI 107
> IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX7D_QSPI_ROOT_CLK>,
> +					<&clks IMX7D_QSPI_ROOT_CLK>;
> +				clock-names = "qspi_en", "qspi";
> +				status = "disabled";
> +			};
> +
>  			sdma: sdma@30bd0000 {
>  				compatible = "fsl,imx7d-sdma",
> "fsl,imx35-sdma";
>  				reg = <0x30bd0000 0x10000>;

