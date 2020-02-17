Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3794C35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 05:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4FB720725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 05:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581917675;
	bh=WgxWt0Xzjz1EgX03HNLnvJPTYT1f2Dma7HaptLd2cs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KIdV2IzCFrRzNC5kyCteKjRE5UBcvmMdroqDbnJxjf2Ecvdqy4e8hohjb3aa6by//
	 6pPCX3DmXglCGE+o1hfD7rSc8dvKMsbFRxrZlHM8uJ3cdC5tIfyx+G6pEAUQGk7Z9y
	 iXeTimz1+1c/NProkAZF9p1Dg51nN3y9BbQon4mI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgBQFee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 00:34:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:53032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgBQFee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 00:34:34 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3125A20718;
        Mon, 17 Feb 2020 05:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581917673;
        bh=WgxWt0Xzjz1EgX03HNLnvJPTYT1f2Dma7HaptLd2cs0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wxYh4P8GdcAMVFWWB91/DnURPh8cCx+MN0CZbx4Is6YlnsiEElnU3CiSQhzaxaJYX
         eR6IfcL7NJJPhOiK47S4tkwLgk/nf/U6jZxQKAwOUldQAKh7okkEOZf0G9BswummdQ
         sDItXvrzwTNVQG1RsT+u2fNjnxIhf7BLWk0vKOHY=
Date:   Mon, 17 Feb 2020 13:34:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: defconfig: run through savedefconfig for
 ordering
Message-ID: <20200217053427.GA6042@dragon>
References: <1581382559-18520-1-git-send-email-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581382559-18520-1-git-send-email-leoyang.li@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 06:55:58PM -0600, Li Yang wrote:
> Used "make defconfig savedefconfig" to regenerate defconfig file in the
> right order to prepare for additional defconfig changes.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>

Arnd, Olof,

How do we handle arm64 defconfig savedefconfig changes? I think it will
likely cause conflicts with changes from other platform maintainers.

Shawn

> ---
>  arch/arm64/configs/defconfig | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 0f212889c931..618001ef5c81 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -471,9 +471,9 @@ CONFIG_DW_WATCHDOG=y
>  CONFIG_SUNXI_WATCHDOG=m
>  CONFIG_IMX2_WDT=y
>  CONFIG_IMX_SC_WDT=m
> +CONFIG_QCOM_WDT=m
>  CONFIG_MESON_GXBB_WATCHDOG=m
>  CONFIG_MESON_WATCHDOG=m
> -CONFIG_QCOM_WDT=m
>  CONFIG_RENESAS_WDT=y
>  CONFIG_UNIPHIER_WATCHDOG=y
>  CONFIG_BCM2835_WDT=y
> @@ -594,8 +594,8 @@ CONFIG_SND_SOC_TAS571X=m
>  CONFIG_SND_SIMPLE_CARD=m
>  CONFIG_SND_AUDIO_GRAPH_CARD=m
>  CONFIG_I2C_HID=m
> -CONFIG_USB=y
>  CONFIG_USB_CONN_GPIO=m
> +CONFIG_USB=y
>  CONFIG_USB_OTG=y
>  CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_XHCI_TEGRA=y
> @@ -617,7 +617,6 @@ CONFIG_USB_CHIPIDEA_HOST=y
>  CONFIG_USB_ISP1760=y
>  CONFIG_USB_HSIC_USB3503=y
>  CONFIG_NOP_USB_XCEIV=y
> -CONFIG_USB_ULPI=y
>  CONFIG_USB_GADGET=y
>  CONFIG_USB_RENESAS_USBHS_UDC=m
>  CONFIG_USB_RENESAS_USB3=m
> @@ -756,7 +755,6 @@ CONFIG_OWL_PM_DOMAINS=y
>  CONFIG_RASPBERRYPI_POWER=y
>  CONFIG_IMX_SCU_SOC=y
>  CONFIG_QCOM_AOSS_QMP=y
> -CONFIG_QCOM_COMMAND_DB=y
>  CONFIG_QCOM_GENI_SE=y
>  CONFIG_QCOM_GLINK_SSR=m
>  CONFIG_QCOM_RMTFS_MEM=m
> @@ -771,14 +769,12 @@ CONFIG_ARCH_R8A774A1=y
>  CONFIG_ARCH_R8A774B1=y
>  CONFIG_ARCH_R8A774C0=y
>  CONFIG_ARCH_R8A7795=y
> -CONFIG_ARCH_R8A7796=y
>  CONFIG_ARCH_R8A77961=y
>  CONFIG_ARCH_R8A77965=y
>  CONFIG_ARCH_R8A77970=y
>  CONFIG_ARCH_R8A77980=y
>  CONFIG_ARCH_R8A77990=y
>  CONFIG_ARCH_R8A77995=y
> -CONFIG_QCOM_PDC=y
>  CONFIG_ROCKCHIP_PM_DOMAINS=y
>  CONFIG_ARCH_TEGRA_132_SOC=y
>  CONFIG_ARCH_TEGRA_210_SOC=y
> @@ -809,6 +805,7 @@ CONFIG_PWM_ROCKCHIP=y
>  CONFIG_PWM_SAMSUNG=y
>  CONFIG_PWM_SUN4I=m
>  CONFIG_PWM_TEGRA=m
> +CONFIG_QCOM_PDC=y
>  CONFIG_RESET_QCOM_AOSS=y
>  CONFIG_RESET_QCOM_PDC=m
>  CONFIG_RESET_TI_SCI=y
> @@ -880,16 +877,16 @@ CONFIG_NLS_ISO8859_1=y
>  CONFIG_SECURITY=y
>  CONFIG_CRYPTO_ECHAINIV=y
>  CONFIG_CRYPTO_ANSI_CPRNG=y
> +CONFIG_CRYPTO_USER_API_RNG=m
>  CONFIG_CRYPTO_DEV_SUN8I_CE=m
>  CONFIG_CRYPTO_DEV_FSL_CAAM=m
> -CONFIG_CRYPTO_DEV_HISI_ZIP=m
> -CONFIG_CRYPTO_USER_API_RNG=m
>  CONFIG_CRYPTO_DEV_QCOM_RNG=m
> +CONFIG_CRYPTO_DEV_HISI_ZIP=m
>  CONFIG_CMA_SIZE_MBYTES=32
>  CONFIG_PRINTK_TIME=y
>  CONFIG_DEBUG_INFO=y
> -CONFIG_DEBUG_FS=y
>  CONFIG_MAGIC_SYSRQ=y
> +CONFIG_DEBUG_FS=y
>  CONFIG_DEBUG_KERNEL=y
>  # CONFIG_SCHED_DEBUG is not set
>  # CONFIG_DEBUG_PREEMPT is not set
> -- 
> 2.17.1
> 
