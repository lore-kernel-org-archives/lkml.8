Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D14C2D0FA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE21F20740
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589359782;
	bh=Qauh/VwoTNTJSJLEJKWQMbLlhyJq/zOthvGyPHoKN80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dBdV4BH13Im/xkFYrAvfIEdLzhdYb1vtWK0OXyf/K7jYgwbLyOpVRZlfHrP8NfniV
	 XTVX1f7zw8D7egvIj/sn/wwSdgBo16RMGgD5AVR06BI0q0pWe21wvfW4dEK9guilgM
	 bsBqUvnzj56w5jX3O30t+RraVCVXQQ+Be4qIu0P4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732430AbgEMItl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 04:49:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730237AbgEMItl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 04:49:41 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91BAF206F5;
        Wed, 13 May 2020 08:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589359780;
        bh=Qauh/VwoTNTJSJLEJKWQMbLlhyJq/zOthvGyPHoKN80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rxgeSGbpGJGcIZyG6xdYlVcNjSvCvtsQUe79QDaTpoIoMwNBen7tL/1ZtaQHXC0ch
         alUNBeEp82sfVe4/75o6xYhC3CjgHss9Gj8a8aZNBwYNqyKdg1I63Hks+Bhz244xxE
         2Ux1qlhTs5J0tBfy2TuK2JRKaZqDxUaZgwyqNk4s=
Date:   Wed, 13 May 2020 16:49:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     fugang.duan@nxp.com
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, Anson.Huang@nxp.com,
        devicetree@vger.kernel.org, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: dts: imx8mp: add "fsl,imx6sx-fec" compatible
 string
Message-ID: <20200513084933.GF26997@dragon>
References: <1588154654-13684-1-git-send-email-fugang.duan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588154654-13684-1-git-send-email-fugang.duan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 06:04:14PM +0800, fugang.duan@nxp.com wrote:
> From: Fugang Duan <fugang.duan@nxp.com>
> 
> Add "fsl,imx6sx-fec" compatible string for fec node, then
> i.MX8MP EVK ethernet function can work now.
> 
> Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index 9b1616e59d58..b5df957c5063 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -615,7 +615,7 @@
>  			};
>  
>  			fec: ethernet@30be0000 {
> -				compatible = "fsl,imx8mp-fec", "fsl,imx8mq-fec";
> +				compatible = "fsl,imx8mp-fec", "fsl,imx8mq-fec", "fsl,imx6sx-fec";

In this case, "fsl,imx8mq-fec" can be dropped?

Shawn

>  				reg = <0x30be0000 0x10000>;
>  				interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
> -- 
> 2.17.1
> 
