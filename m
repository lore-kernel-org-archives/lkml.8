Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD16CC10F29
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA6E20658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584326261;
	bh=XrwwTekwQ2HDHfKOkxj8tKgmnEkC52AJfRIvVSYZKFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=quPWkXjScBgjM6eZQi0PlrVcE8L9bu2vdsAqej9yH5WQdoCLy8BUuwshQ8e+DrNmI
	 ht3/PUEs1X1CFtAlO1ZoLopq8N0jxGXUISBwtd5e/kegAazyX8uVYgre8WY8qIFZnK
	 MXKA0TJk6XSmPnJ/If8xTL8TN2lK/KVt0bU3mUFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbgCPChk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 22:37:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730120AbgCPChg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 22:37:36 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39590206E9;
        Mon, 16 Mar 2020 02:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584326255;
        bh=XrwwTekwQ2HDHfKOkxj8tKgmnEkC52AJfRIvVSYZKFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dABnWIbR5/3oZQlzrowP1QyTOPSxORhSDtsEK8hZvL4Nc67uSpOKc6RsT3uE98oCW
         B0xS2L53xF8PfXWwLWe5Op99hOVf17jmIsq1BttwDt54T17mStUcf3bgp5wDRZdQDk
         hjNIH3A3Mi4TgU1pSVdrdpfyM8zn9OAhSDnisf64=
Date:   Mon, 16 Mar 2020 10:37:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Igor Opaniuk <igor.opaniuk@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] ARM: dts: colibri: introduce dts with UHS-I
 support enabled
Message-ID: <20200316023727.GX17221@dragon>
References: <20200312185113.2504-1-igor.opaniuk@gmail.com>
 <20200312185113.2504-2-igor.opaniuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312185113.2504-2-igor.opaniuk@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 08:51:13PM +0200, Igor Opaniuk wrote:
> From: Igor Opaniuk <igor.opaniuk@toradex.com>
> 
> Introduce DTS for Colibri iMX6S/DL V1.1x re-design, where UHS-I support was
> added. Provide proper configuration for VGEN3, which allows that rail to
> be automatically switched to 1.8 volts for proper UHS-I operation mode.
> 
> Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
> 
> ---
> 
> v4:
> - Document Colibri iMX6S/DL V1.1x re-design devicetree binding [Shawn Guo]
> - wakeup-source property fix [Shawn Guo]
> 
> v3:
> - change hierarchy according to Marco's suggestions [Marco Felsch]
> - adjust compatible string adding v1.1 [Stefan Agner]
> 
> v2:
> - rework hierarchy of dts files, and a separate dtsi for Colibri
>   iMX6S/DL V1.1x re-design, where UHS-I was added [Marcel Ziswiler]
> - add comments about vgen3 power rail [Marcel Ziswiler]
> - fix other minor issues, addressing Marcel's comments. [Marcel Ziswiler]
> 
>  arch/arm/boot/dts/Makefile                    |  1 +
>  .../boot/dts/imx6dl-colibri-v1_1-eval-v3.dts  | 59 +++++++++++++++++++
>  arch/arm/boot/dts/imx6qdl-colibri.dtsi        | 11 +++-
>  3 files changed, 70 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index d6546d2676b9..97da51be1de6 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -412,6 +412,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6dl-aristainetos2_4.dtb \
>  	imx6dl-aristainetos2_7.dtb \
>  	imx6dl-colibri-eval-v3.dtb \
> +	imx6dl-colibri-v1_1-eval-v3.dtb \
>  	imx6dl-cubox-i.dtb \
>  	imx6dl-cubox-i-emmc-som-v15.dtb \
>  	imx6dl-cubox-i-som-v15.dtb \
> diff --git a/arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dts
> new file mode 100644
> index 000000000000..fced7d99f5d5
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dts
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0 OR X11
> +/*
> + * Copyright 2019 Toradex AG
> + */

Shouldn't this follow what you just updated for other Toradex boards?

Shawn

> +
> +/dts-v1/;
> +
> +#include "imx6dl-colibri-eval-v3.dts"
> +
> +/ {
> +	model = "Toradex Colibri iMX6DL/S V1.1 on Colibri Evaluation Board V3";
> +	compatible = "toradex,colibri_imx6dl-v1_1-eval-v3",
> +		     "toradex,colibri_imx6dl-v1_1",
> +		     "toradex,colibri_imx6dl-eval-v3",
> +		     "toradex,colibri_imx6dl",
> +		     "fsl,imx6dl";
> +};
> +
> +&iomuxc {
> +	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x170b1
> +			MX6QDL_PAD_SD1_CLK__SD1_CLK    0x100b1
> +			MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x170b1
> +			MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x170b1
> +			MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x170b1
> +			MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x170b1
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x170f1
> +			MX6QDL_PAD_SD1_CLK__SD1_CLK    0x100f1
> +			MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x170f1
> +			MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x170f1
> +			MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x170f1
> +			MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x170f1
> +		>;
> +	};
> +};
> +
> +/* Colibri MMC */
> +&usdhc1 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_mmc_cd>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz &pinctrl_mmc_cd>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz &pinctrl_mmc_cd>;
> +	vmmc-supply = <&reg_module_3v3>;
> +	vqmmc-supply = <&vgen3_reg>;
> +	wakeup-source;
> +	keep-power-in-suspend;
> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	status = "okay";
> +	/delete-property/no-1-8-v;
> +};
> diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> index d03dff23863d..e85a41e84fd4 100644
> --- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> @@ -229,7 +229,16 @@
>  				regulator-always-on;
>  			};
>  
> -			/* vgen3: unused */
> +			/*
> +			 * +V3.3_1.8_SD1 coming off VGEN3 and supplying
> +			 * the i.MX 6 NVCC_SD1.
> +			 */
> +			vgen3_reg: vgen3 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
>  
>  			vgen4_reg: vgen4 {
>  				regulator-min-microvolt = <1800000>;
> -- 
> 2.17.1
> 
