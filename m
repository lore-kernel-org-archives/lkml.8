Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303BDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 039A02067B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591742758;
	bh=ONePyQRofrJxKBPHH/k/aLosqh0N8oOuBRFyf046l/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oDm78n4iSXU3cNdRnbQUYJ2cSuH/jubJwQJaniPAJbqGA64VK+fF+i0qR7VwpSuX8
	 iS3cWpgDg9vNemCP7pPJKj4nckEydvE3i3LANEW20HHDPDdhoYlgbNCoEzAvoJoSpd
	 NU+KQ6Gz7V32G2q/H+BCdQSFak0bXDQrPvseI3cE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgFIWp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 18:45:56 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33872 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgFIWpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 18:45:53 -0400
Received: by mail-io1-f67.google.com with SMTP id m81so43530ioa.1;
        Tue, 09 Jun 2020 15:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gz1fd2hBJ5hS3FPButyvI5+04t5MDlej2TuLhr1kaRU=;
        b=q5iX6l5o4dMsHRIKAPKKXey3CuawzlLrP3queE5nPN7GoO7+q/6dn6QQt1xvOdaO2C
         4gpjx76tofyloWoI6o0/m4zY9ARCvoUYWLLzW86DwbKJxH3OJ3DzeYfkbY10cwt6/2+g
         e6Vat6bAmN0iKWtVmyj08lIz5p6OO2zZT1Z/u1G/OrzNvdtdnF6UAjfRYxe7CKgWHMs0
         pWraHeP8TkGKO/pJE/5+AFesMUzy/uWCXElAhjn4S0mVLy4seOB51tJGBHr9KSfjvnl2
         m/7JZLylb+eDqb6u1OfGir94dS5FHbXhgLCbbGGj57ELQLKXhDdGlcnt3e5CTmABki7e
         Ygeg==
X-Gm-Message-State: AOAM532UMb/q2q9YpJHj5Son8s/Q3c2EWV2UEg1gEoOXTwYbyXtz6J9+
        CGxXotAzdobgpf+uxplaqck39E4=
X-Google-Smtp-Source: ABdhPJx05Lrtg4Cvy7MVHcnLfguL4y+dXcEflZSsvL7VlBjfDfG+EUZEpNI/rb5I3rm62JXfVmWpGQ==
X-Received: by 2002:a02:c848:: with SMTP id r8mr410528jao.15.1591742752203;
        Tue, 09 Jun 2020 15:45:52 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id z4sm7945719iot.24.2020.06.09.15.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 15:45:51 -0700 (PDT)
Received: (nullmailer pid 1644565 invoked by uid 1000);
        Tue, 09 Jun 2020 22:45:50 -0000
Date:   Tue, 9 Jun 2020 16:45:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Parthiban Nallathambi <parthiban@linumiz.com>
Cc:     m.felsch@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] ARM: dts: imx6ull: add MYiR MYS-6ULX SBC
Message-ID: <20200609224550.GB1626212@bogus>
References: <20200601145857.5658-1-parthiban@linumiz.com>
 <20200601145857.5658-2-parthiban@linumiz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601145857.5658-2-parthiban@linumiz.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 04:58:57PM +0200, Parthiban Nallathambi wrote:
> Add support for the MYiR imx6ULL based single board computer
> equipped with on board 256MB NAND & RAM. The board also
> provides expansion header for expansion board, but this
> commit adds only support for SBC.
> 
> Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
> ---
> 
> Notes:
>     Changelog v2:
>     - moved regulator under root node
>     - status property removed
> 
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../boot/dts/imx6ull-myir-mys-6ulx-nand.dts   |  19 ++
>  arch/arm/boot/dts/imx6ull-myir-mys-6ulx.dtsi  | 238 ++++++++++++++++++
>  3 files changed, 258 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6ull-myir-mys-6ulx-nand.dts
>  create mode 100644 arch/arm/boot/dts/imx6ull-myir-mys-6ulx.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index e8dd99201397..eab86051d782 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -612,6 +612,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
>  	imx6ull-14x14-evk.dtb \
>  	imx6ull-colibri-eval-v3.dtb \
>  	imx6ull-colibri-wifi-eval-v3.dtb \
> +	imx6ull-myir-mys-6ulx-nand.dtb \
>  	imx6ull-opos6uldev.dtb \
>  	imx6ull-phytec-segin-ff-rdk-nand.dtb \
>  	imx6ull-phytec-segin-ff-rdk-emmc.dtb \
> diff --git a/arch/arm/boot/dts/imx6ull-myir-mys-6ulx-nand.dts b/arch/arm/boot/dts/imx6ull-myir-mys-6ulx-nand.dts
> new file mode 100644
> index 000000000000..43e072671ca4
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6ull-myir-mys-6ulx-nand.dts
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 Linumiz
> + * Author: Parthiban Nallathambi <parthiban@linumiz.com>
> + */
> +
> +/dts-v1/;
> +#include "imx6ull.dtsi"
> +#include "imx6ull-myir-mys-6ulx.dtsi"
> +
> +/ {
> +	model = "MYiR i.MX6ULL MYS-6ULX Single Board Computer with NAND";
> +	compatible = "myir,imx6ull-mys-6ulx-nand", "myir,imx6ull-mys-6ulx",
> +		     "fsl,imx6ull";

Doesn't match the schema which says you have either 
"myir,imx6ull-mys-6ulx-nand" or "myir,imx6ull-mys-6ulx".

You ran this against 'make dtbs_check', right?


> +};
> +
> +&gpmi {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/imx6ull-myir-mys-6ulx.dtsi b/arch/arm/boot/dts/imx6ull-myir-mys-6ulx.dtsi
> new file mode 100644
> index 000000000000..03365a1ca8e6
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6ull-myir-mys-6ulx.dtsi

If w/o nand is a valid board config, don't you want to build this (i.e. 
make it a .dts)?

> @@ -0,0 +1,238 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 Linumiz
> + * Author: Parthiban Nallathambi <parthiban@linumiz.com>
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/pwm/pwm.h>
