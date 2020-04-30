Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDFEC83000
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 545E72072A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgD3OfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgD3OfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:35:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143ADC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:35:19 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1jUAHL-0000D2-Lw; Thu, 30 Apr 2020 16:35:07 +0200
Message-ID: <3895f202cf5919e41a56878a62f6d5259dea12d3.camel@pengutronix.de>
Subject: Re: [RFC PATCH 3/4] drm/etnaviv: Change order of enabling clocks to
 fix boot on i.MX8MM
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        Adam Ford <aford173@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Li Jun <jun.li@nxp.com>, NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 30 Apr 2020 16:35:06 +0200
In-Reply-To: <20200430124602.14463-4-frieder.schrempf@kontron.de>
References: <20200430124602.14463-1-frieder.schrempf@kontron.de>
         <20200430124602.14463-4-frieder.schrempf@kontron.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1 (3.36.1-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 30.04.2020, 12:46 +0000 schrieb Schrempf Frieder:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> On some i.MX8MM devices the boot hangs when enabling the GPU clocks.
> Changing the order of clock initalization to
> 
> core -> shader -> bus -> reg
> 
> fixes the issue. This is the same order used in the imx platform code
> of the downstream GPU driver in the NXP kernel [1]. For the sake of
> consistency we also adjust the order of disabling the clocks to the
> reverse.
> 
> [1] https://source.codeaurora.org/external/imx/linux-imx/tree/drivers/mxc/gpu-viv/hal/os/linux/kernel/platform/freescale/gc_hal_kernel_platform_imx.c?h=imx_5.4.3_2.0.0#n1538

I don't see why the order of the clocks is important. Is this really a
GPU issue? As in: does a GPU access hang when enabling the clocks in
the wrong order? Or is this a clock driver issue with a clock access
hanging due to an upstream clock still being disabled?

Regards,
Lucas

> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 42 +++++++++++++--------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index 7b138d4dd068..424b2e5951f0 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -1487,55 +1487,55 @@ static int etnaviv_gpu_clk_enable(struct etnaviv_gpu *gpu)
>  {
>  	int ret;
>  
> -	if (gpu->clk_reg) {
> -		ret = clk_prepare_enable(gpu->clk_reg);
> +	if (gpu->clk_core) {
> +		ret = clk_prepare_enable(gpu->clk_core);
>  		if (ret)
>  			return ret;
>  	}
>  
> -	if (gpu->clk_bus) {
> -		ret = clk_prepare_enable(gpu->clk_bus);
> +	if (gpu->clk_shader) {
> +		ret = clk_prepare_enable(gpu->clk_shader);
>  		if (ret)
> -			goto disable_clk_reg;
> +			goto disable_clk_core;
>  	}
>  
> -	if (gpu->clk_core) {
> -		ret = clk_prepare_enable(gpu->clk_core);
> +	if (gpu->clk_bus) {
> +		ret = clk_prepare_enable(gpu->clk_bus);
>  		if (ret)
> -			goto disable_clk_bus;
> +			goto disable_clk_shader;
>  	}
>  
> -	if (gpu->clk_shader) {
> -		ret = clk_prepare_enable(gpu->clk_shader);
> +	if (gpu->clk_reg) {
> +		ret = clk_prepare_enable(gpu->clk_reg);
>  		if (ret)
> -			goto disable_clk_core;
> +			goto disable_clk_bus;
>  	}
>  
>  	return 0;
>  
> -disable_clk_core:
> -	if (gpu->clk_core)
> -		clk_disable_unprepare(gpu->clk_core);
>  disable_clk_bus:
>  	if (gpu->clk_bus)
>  		clk_disable_unprepare(gpu->clk_bus);
> -disable_clk_reg:
> -	if (gpu->clk_reg)
> -		clk_disable_unprepare(gpu->clk_reg);
> +disable_clk_shader:
> +	if (gpu->clk_shader)
> +		clk_disable_unprepare(gpu->clk_shader);
> +disable_clk_core:
> +	if (gpu->clk_core)
> +		clk_disable_unprepare(gpu->clk_core);
>  
>  	return ret;
>  }
>  
>  static int etnaviv_gpu_clk_disable(struct etnaviv_gpu *gpu)
>  {
> +	if (gpu->clk_reg)
> +		clk_disable_unprepare(gpu->clk_reg);
> +	if (gpu->clk_bus)
> +		clk_disable_unprepare(gpu->clk_bus);
>  	if (gpu->clk_shader)
>  		clk_disable_unprepare(gpu->clk_shader);
>  	if (gpu->clk_core)
>  		clk_disable_unprepare(gpu->clk_core);
> -	if (gpu->clk_bus)
> -		clk_disable_unprepare(gpu->clk_bus);
> -	if (gpu->clk_reg)
> -		clk_disable_unprepare(gpu->clk_reg);
>  
>  	return 0;
>  }

