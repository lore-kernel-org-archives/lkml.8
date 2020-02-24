Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0010EC35677
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 01:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48C420675
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 01:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582509424;
	bh=RjjvelCSB3sw7rmvNAkcaVIPmUcD/FgzgrYTn+iASdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I6xN94JgTQB5aO5hw7Xr/N2HIs/gyJLcOWeW1YlGgZATfCry0guaN+pjLdpE6XLyC
	 zJVmJDI/rIkDnhVRwH2LazHOiiDTxwcW0BlBdHIb2RIhg+JX542aH5zNNZJ/eGsPn3
	 tBPPBX0GaYWiRsSe4Rjy9+d5OZZwvk5e1gXoZlR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgBXB5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 20:57:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:52190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbgBXB5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 20:57:03 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63F27205C9;
        Mon, 24 Feb 2020 01:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582509422;
        bh=RjjvelCSB3sw7rmvNAkcaVIPmUcD/FgzgrYTn+iASdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j4fhzQXNsZXLRXHVD4gJXXfoOlXDNkmr1ur5RYNLm+pZn2QJ9tIRNIo/HvWaxsHyd
         jRV/8HPCQtu3tEk1nBa1dSHBK2WOnVYL3rmSFf9UYo6ksDhy5ZXBzK7c5zgLTppRq3
         9nCT7DtwGRLHdWCtmKb4AfmQITkZ62e2mjXwe4us=
Date:   Mon, 24 Feb 2020 09:56:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        devicetree@vger.kernel.org, kernel@puri.sm,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: Re: [PATCH v2 1/9] arm64: dts: librem5-devkit: add sai2 and sai6
 pinctrl definitions
Message-ID: <20200224015650.GD27688@dragon>
References: <20200218084942.4884-1-martin.kepplinger@puri.sm>
 <20200218084942.4884-2-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218084942.4884-2-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 09:49:34AM +0100, Martin Kepplinger wrote:
> From: "Angus Ainslie (Purism)" <angus@akkea.ca>
> 
> Add missing sai2 and sai6 audio interface pinctrl definitions for the
> Librem 5 devkit.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>

We do not need to be so verbose.  It can be squashed into patch #2.

Shawn

> ---
>  .../dts/freescale/imx8mq-librem5-devkit.dts   | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> index 007c14eec676..1e9fa80be647 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> @@ -567,6 +567,25 @@
>  		>;
>  	};
>  
> +	pinctrl_sai2: sai2grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC	0xd6
> +			MX8MQ_IOMUXC_SAI2_TXC_SAI2_TX_BCLK	0xd6
> +			MX8MQ_IOMUXC_SAI2_TXD0_SAI2_TX_DATA0	0xd6
> +			MX8MQ_IOMUXC_SAI2_RXD0_SAI2_RX_DATA0	0xd6
> +			MX8MQ_IOMUXC_SAI2_MCLK_SAI2_MCLK	0xd6
> +		>;
> +	};
> +
> +	pinctrl_sai6: sai6grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_SAI1_RXD5_SAI6_RX_DATA0	0xd6
> +			MX8MQ_IOMUXC_SAI1_RXD6_SAI6_RX_SYNC	0xd6
> +			MX8MQ_IOMUXC_SAI1_TXD4_SAI6_RX_BCLK     0xd6
> +			MX8MQ_IOMUXC_SAI1_TXD5_SAI6_TX_DATA0	0xd6
> +		>;
> +	};
> +
>  	pinctrl_typec: typecgrp {
>  		fsl,pins = <
>  			MX8MQ_IOMUXC_NAND_DATA06_GPIO3_IO12		0x16
> -- 
> 2.20.1
> 
