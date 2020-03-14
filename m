Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D973EC1975A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD06620578
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbgCOCxO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:53:14 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38138 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbgCOCxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:53:14 -0400
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jD8Pn-0001Qn-3r; Sat, 14 Mar 2020 16:09:27 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: rockchip: use DMA channels for UARTs of TinkerBoard
Date:   Sat, 14 Mar 2020 16:09:26 +0100
Message-ID: <2930126.sCcUyySgUU@diego>
In-Reply-To: <20200314142327.25568-1-katsuhiro@katsuster.net>
References: <20200314142327.25568-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Samstag, 14. März 2020, 15:23:27 CET schrieb Katsuhiro Suzuki:
> This patch enables to use DMAC for all UARTs that are connected to
> dmac_peri core for TinkerBoard.
> 
> Only uart2 is connected different DMAC (dmac_bus_s) so keep current
> settings on this patch.

This belongs in rk3288.dtsi, as this is definitly not board-specific, as
the dma-uart connection is done inside the soc.

At least on arm64 (rk3328, px30, probably more) we already have the
uart dmas in the core dtsi without any problems.

Is there any reason why you only did add it to the tinker board only?


Heiko


> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> ---
>  arch/arm/boot/dts/rk3288-tinker.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
> index 312582c1bd37..6efabeaf3c6d 100644
> --- a/arch/arm/boot/dts/rk3288-tinker.dtsi
> +++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
> @@ -491,10 +491,14 @@ &tsadc {
>  };
>  
>  &uart0 {
> +	dmas = <&dmac_peri 1>, <&dmac_peri 2>;
> +	dma-names = "tx", "rx";
>  	status = "okay";
>  };
>  
>  &uart1 {
> +	dmas = <&dmac_peri 3>, <&dmac_peri 4>;
> +	dma-names = "tx", "rx";
>  	status = "okay";
>  };
>  
> @@ -503,10 +507,14 @@ &uart2 {
>  };
>  
>  &uart3 {
> +	dmas = <&dmac_peri 7>, <&dmac_peri 8>;
> +	dma-names = "tx", "rx";
>  	status = "okay";
>  };
>  
>  &uart4 {
> +	dmas = <&dmac_peri 9>, <&dmac_peri 10>;
> +	dma-names = "tx", "rx";
>  	status = "okay";
>  };
>  
> 




