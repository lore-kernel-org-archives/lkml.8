Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED814C7619C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 04:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA562072C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 04:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581912595;
	bh=N6Y5KKKWqMwm7aFctqJ1MGvZUyDeIUpv6buvA4gPxUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YY1pi83G70SiZ85GpBE9lcVyw+Tpbe4TrlekpZswthyxcsav1gSlSmRCgFetFbTbZ
	 vGacLNfRTngthX41gJMuVPzBauqDKcO9i9ZM6ufsIVZfNY1ME/gYLF/lycCBuMsBFk
	 MmXz7Sugy3x3ohDs6xLKad5nSE8dfN6n8kPbcito=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgBQEJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 23:09:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:38984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbgBQEJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 23:09:54 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DDF920717;
        Mon, 17 Feb 2020 04:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581912593;
        bh=N6Y5KKKWqMwm7aFctqJ1MGvZUyDeIUpv6buvA4gPxUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2F8+vWxe9UuNOOVTK+1AxAoBzcorwtXspYXHIItjZuNh5yW39woNtzY8Vsh76jdjC
         eblBjzyyiqNHjIEDi1gTvKWDaf6oA9s+g6rx9dvAtT4lQmCBTr5Lya9f+dA15wcbF/
         76Zi0fXQJZajaAJ7o6rh2vHS1zZK2J6pjs7qgoxU=
Date:   Mon, 17 Feb 2020 12:09:43 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, devicetree@vger.kernel.org, kernel@puri.sm,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: Re: [PATCH v1 10/12] arm64: dts: librem5-devkit: configure VSELECT
Message-ID: <20200217040942.GG5395@dragon>
References: <20200205143003.28408-1-martin.kepplinger@puri.sm>
 <20200205143003.28408-11-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205143003.28408-11-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 03:30:01PM +0100, Martin Kepplinger wrote:
> From: "Angus Ainslie (Purism)" <angus@akkea.ca>
> 
> use vselect to set the io voltage to 1.8V
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> index fbc7062c4633..8f920c554ebd 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> @@ -789,6 +789,7 @@
>  			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1	0xc3
>  			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2	0xc3
>  			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3	0xc3
> +			MX8MQ_IOMUXC_GPIO1_IO04_GPIO1_IO4	0xc1

How is the pin working without a pinctrl handle pointing it?

Shawn

>  		>;
>  	};
>  
> @@ -800,6 +801,7 @@
>  			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1	0xcd
>  			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2	0xcd
>  			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3	0xcd
> +			MX8MQ_IOMUXC_GPIO1_IO04_GPIO1_IO4	0xc1
>  		>;
>  	};
>  
> @@ -811,6 +813,7 @@
>  			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1	0xcf
>  			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2	0xcf
>  			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3	0xcf
> +			MX8MQ_IOMUXC_GPIO1_IO04_GPIO1_IO4	0xc1
>  		>;
>  	};
>  
> -- 
> 2.20.1
> 
