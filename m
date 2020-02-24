Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247D7C35670
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 01:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1216206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 01:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582508888;
	bh=UUE5dvuQrZiK4JgjRWz7QqXRcMX4gRQ9G5eXNzAVSZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D7RAowSz765F6s1OPlspiDFcUBDkPoveI/FMpkF0wWXe7HcCiEJR0/yN6YjBkByeQ
	 4xXPm6ZWyNwpnqaV0U1icaqiva8mjG8wkaJ6HwpA3rvpzOkPyZaYmvwU0PqQt5OpDl
	 SnW50gJSQdKpxSdn6baG3pDk+dfjP6ah9U4cpeBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgBXBsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 20:48:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:50450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbgBXBsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 20:48:06 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7EBD20675;
        Mon, 24 Feb 2020 01:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582508886;
        bh=UUE5dvuQrZiK4JgjRWz7QqXRcMX4gRQ9G5eXNzAVSZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i8eV/LC5db5ok5trjevxGgW9fsAQ6MdilxGUXgilibCAvZKfWAPu+nfgFjQrH0unc
         kemV9osveGer6tKgit0qHGpKz8W2nkWbytYkYOumh7TU9ButNNJpEDSzET+8F0etNv
         fGuW3tKudH6dqLyU0XBu+y/STcRWBvsvTpKlrce8=
Date:   Mon, 24 Feb 2020 09:48:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, abel.vesa@nxp.com,
        leonard.crestez@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] arm64: dts: imx8mn-ddr4-evk: Adjust 1.2GHz OPP voltage
 to OD mode
Message-ID: <20200224014759.GB27688@dragon>
References: <1581990752-10219-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581990752-10219-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 09:52:32AM +0800, Anson Huang wrote:
> According to latest datasheet Rev.0, 10/2019, there is restriction
> as below:
> 
> "If VDD_SOC/GPU/DDR = 0.95V, then VDD_ARM must be >= 0.95V."
> 
> As by default SoC is running at OD mode(VDD_SOC = 0.95V), so
> VDD_ARM 1.2GHz OPP's voltage should be increased to 0.95V.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> index 2497eeb..7a61a1a 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> @@ -13,6 +13,12 @@
>  	compatible = "fsl,imx8mn-ddr4-evk", "fsl,imx8mn";
>  };
>  
> +&a53_opp_table {
> +	opp-1200000000 {
> +		opp-microvolt = <950000>;
> +	};
> +};
> +

The restriction applies to SoC rather than a particular board, right?
If so, the change should be made in imx8mn.dtsi?

Shawn

>  &A53_0 {
>  	cpu-supply = <&buck2_reg>;
>  };
> -- 
> 2.7.4
> 
