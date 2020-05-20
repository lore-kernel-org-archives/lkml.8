Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D93C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7057920829
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589936586;
	bh=PnghFW2q0z4J9/+uLRYIWxx0fTo5s2jisGaXp615ofY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WFXcs71ctfXlRPJuEwaC3chxGLgYKESbAH6acby5cijsBESw8o+hbLwyH7c36S6IR
	 irdfnud8sqSLB96qO+4UWf6uUYYasN9QXasT4kFPAXkHHsblweT8Zp45xzqk36MuU0
	 zd2yd7gzudIjAy8nZwAT1ZLl/5vcr8PYTa8zsGuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgETBDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 21:03:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgETBDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 21:03:05 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB6B1207D8;
        Wed, 20 May 2020 01:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589936585;
        bh=PnghFW2q0z4J9/+uLRYIWxx0fTo5s2jisGaXp615ofY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XtcZPHkUAob0Zyy/LFFTSkGnFY9V8EXP/haMriBYfa1SaR8nzeh8ctPwALmGPeRM/
         vTZjCd5Kl2RlZ1vCIKDpD/icBra2DBSdaqdpr6xMLW0G95h1lZQxvRVtLtgg0fM3oh
         +sxonEQmpk2HqdHqZnF9U7ieuaGFYCrkDHfanB9A=
Date:   Wed, 20 May 2020 09:02:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconemedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: Enable some audio drivers on i.MX8M
 Mini
Message-ID: <20200520010254.GD11739@dragon>
References: <20200502125949.194032-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200502125949.194032-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 02, 2020 at 07:59:47AM -0500, Adam Ford wrote:
> The i.MX8M Mini has SAI and micfil support but the drivers
> are not being loaded.
> 
> This patch updates the defconfig to add support
> CONFIG_SND_SOC_FSL_SAI and CONFIG_SND_SOC_FSL_MICFIL to support
> these drivers.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 366857dfa9de..4e60e8a98b83 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -638,6 +638,8 @@ CONFIG_SND_HDA_TEGRA=m
>  CONFIG_SND_HDA_CODEC_HDMI=m
>  CONFIG_SND_SOC=y
>  CONFIG_SND_BCM2835_SOC_I2S=m
> +CONFIG_SND_SOC_FSL_SAI=y
> +CONFIG_SND_SOC_FSL_MICFIL=y

Please enable them as 'm'.

Shawn

>  CONFIG_SND_MESON_AXG_SOUND_CARD=m
>  CONFIG_SND_SOC_SDM845=m
>  CONFIG_SND_SOC_ROCKCHIP=m
> -- 
> 2.25.1
> 
