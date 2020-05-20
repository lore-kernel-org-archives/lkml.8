Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C50C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C835B2072C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589936765;
	bh=zor48bXJQ4c2kAxaJluW7+9Ew89ICgOqiSGEW4LgzI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pnWhTMi346VbRGWycTiuPlktZESQMxMdmaa/TU9eQDnc/02/Pf5frz3CqmUdGlIke
	 2fFCVtUDpcSF/G7JlibLCcfGCQbYEOZWjKimLgYQYl1GaxelKX3/ljp5UBTTde6Gaz
	 kmBLJT+JqoKqRUH+bEeuZZKclFOcNzaqXhIsP8Eo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgETBGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 21:06:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbgETBGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 21:06:04 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE4A620708;
        Wed, 20 May 2020 01:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589936764;
        bh=zor48bXJQ4c2kAxaJluW7+9Ew89ICgOqiSGEW4LgzI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=alcv5suyhyRxqBPQAM026Gtjv1cHG5anqpF86KMAtYP0hwh+PBQlJF/PVGXhNv4py
         BdZ2zF9jIdu1TFQSXWQHstetWrldKlrOCS89qy6W4QoeRvKVUGZi21LE4NNxm3hWte
         jSQa+8bLDq2vusmQL0Q7BQVLd8MkMS+Qp6fNoi9g=
Date:   Wed, 20 May 2020 09:05:59 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mm: Add node for SPDIF
Message-ID: <20200520010558.GF11739@dragon>
References: <20200502132011.196045-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200502132011.196045-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 02, 2020 at 08:20:11AM -0500, Adam Ford wrote:
> The i.MX8M Mini can support SPIDF which is very similar to the
> IP used on the i.MX35.
> 
> This patch adds the SPIF node.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index d46e727fc362..00aad55ece65 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -358,6 +358,29 @@ micfil: micfil@30080000 {
>  				status = "disabled";
>  			};
>  
> +			spdif1: spdif@30090000 {

It should be in a patch series with previous micfil one, as it cannot be
applied independently.

> +				compatible = "fsl,imx8mm-spdif", "fsl,imx35-spdif";
> +				reg = <0x30090000 0x10000>;
> +				interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MM_CLK_AUDIO_AHB>, /* core */
> +					 <&clk IMX8MM_CLK_24M>, /* rxtx0 */
> +					 <&clk IMX8MM_CLK_SPDIF1>, /* rxtx1 */
> +					 <&clk IMX8MM_CLK_DUMMY>, /* rxtx2 */
> +					 <&clk IMX8MM_CLK_DUMMY>, /* rxtx3 */
> +					 <&clk IMX8MM_CLK_DUMMY>, /* rxtx4 */
> +					 <&clk IMX8MM_CLK_AUDIO_AHB>, /* rxtx5 */
> +					 <&clk IMX8MM_CLK_DUMMY>, /* rxtx6 */
> +					 <&clk IMX8MM_CLK_DUMMY>, /* rxtx7 */
> +					 <&clk IMX8MM_CLK_DUMMY>; /* spba */
> +				clock-names = "core", "rxtx0",
> +					      "rxtx1", "rxtx2",
> +					      "rxtx3", "rxtx4",
> +					      "rxtx5", "rxtx6",
> +					      "rxtx7", "spba";
> +				dmas = <&sdma2 28 18 0>, <&sdma2 29 18 0>;
> +				dma-names = "rx", "tx";
> +				status = "disabled";
> +			};

Have a newline between nodes.

Shawn

>  			gpio1: gpio@30200000 {
>  				compatible = "fsl,imx8mm-gpio", "fsl,imx35-gpio";
>  				reg = <0x30200000 0x10000>;
> -- 
> 2.25.1
> 
