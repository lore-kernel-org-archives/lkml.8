Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61165C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 02:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39F5320717
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 02:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595297267;
	bh=+ts4zy5C6VLaAdZUBa4hYy3VRNpbixHGF/DyON4s8UE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=agj+ro2A7c777Bi5iW2aIk1nIj38vywFQy07qmBvqiWAgV+sGlfEbnkih4AB3Jgxb
	 ytuQXzVgTqKvG5QcdDf0uJ/hWAYJXoScMkZ19bVEg8CcVfkQGc3CKgmYaKf/cBg+1C
	 5yNYa18Le65uXN1XlH3XTacOjpKbwHHsJdGgfzmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgGUCHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 22:07:45 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44120 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgGUCHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 22:07:44 -0400
Received: by mail-io1-f68.google.com with SMTP id i4so19690990iov.11;
        Mon, 20 Jul 2020 19:07:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hTY3veWiVTWEBJAoyzuJVm52NubnJ7An2M9eukUiOrU=;
        b=bP7ehV63k7eG3CeWp8qPLq4RlpfXmdUy81yDTSg05LNzpg/nORQPnun9ogbZoEditE
         W3Qr/LNVJD/rn16Knj6JJIK2MhVxmNc46ZaWaK3oG3kibjVB3RUdg7cX1R2wxFkgDsKF
         zQpvEgNb43pzIA5pv0z/Ay40i3v8sZSfmOCUnAZVeYK5kS1orA7ViCRR1MprZO+1iOPB
         6gBuIhsZQtiub4qL5LZ9Tg5kSzRTTbc4hZsxzOSpO8ho4M2/qx9npBH3Et1fseZKeZzq
         FrH1hwSm3BjkJy6NAs4PqZGZ+s++GyjysklsPd+5fueRpyNtpxJy/g+iIbP1EnxZ+Qz2
         +jsA==
X-Gm-Message-State: AOAM532/xf4yHsIdQ7ilpB0KMMQZ0+XUNms6zTLpN3DpGH7Tr8vb2XRX
        uqHeruVDknxKCf2Zn18rew==
X-Google-Smtp-Source: ABdhPJw8swEl/2Nq6F7rvsd0KLS7MVckYcnrFaXBYa4pxsQXXVmksaVj5LWsPyjhiP+nS3XxXuFNgw==
X-Received: by 2002:a5e:a60d:: with SMTP id q13mr25571264ioi.199.1595297263389;
        Mon, 20 Jul 2020 19:07:43 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id n10sm446926iom.21.2020.07.20.19.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 19:07:42 -0700 (PDT)
Received: (nullmailer pid 3382159 invoked by uid 1000);
        Tue, 21 Jul 2020 02:07:40 -0000
Date:   Mon, 20 Jul 2020 20:07:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, git@xilinx.com,
        saikrishna12468@gmail.com
Subject: Re: [PATCH 1/2] dt-bindings: reset: Updated binding for Versal reset
 driver
Message-ID: <20200721020740.GA3376303@bogus>
References: <1594708149-29944-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <1594708149-29944-2-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594708149-29944-2-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 11:59:08AM +0530, Sai Krishna Potthuri wrote:
> Added documentation and Versal reset indices to describe
> about Versal reset driver bindings.
> 
> Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
> ---
>  .../bindings/reset/xlnx,zynqmp-reset.txt      |  11 +-
>  .../dt-bindings/reset/xlnx-versal-resets.h    | 105 ++++++++++++++++++
>  2 files changed, 112 insertions(+), 4 deletions(-)
>  create mode 100644 include/dt-bindings/reset/xlnx-versal-resets.h
> 
> diff --git a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
> index 27a45fe5ecf1..ed836868dbf1 100644
> --- a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
> +++ b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
> @@ -1,7 +1,7 @@
>  --------------------------------------------------------------------------
> - =  Zynq UltraScale+ MPSoC reset driver binding =
> + =  Zynq UltraScale+ MPSoC and Versal reset driver binding =
>  --------------------------------------------------------------------------
> -The Zynq UltraScale+ MPSoC has several different resets.
> +The Zynq UltraScale+ MPSoC and Versal has several different resets.
>  
>  See Chapter 36 of the Zynq UltraScale+ MPSoC TRM (UG) for more information
>  about zynqmp resets.
> @@ -10,7 +10,8 @@ Please also refer to reset.txt in this directory for common reset
>  controller binding usage.
>  
>  Required Properties:
> -- compatible:	"xlnx,zynqmp-reset"
> +- compatible:	"xlnx,zynqmp-reset" for Zynq UltraScale+ MPSoC platform
> +		"xlnx,versal-reset" for Versal platform
>  - #reset-cells:	Specifies the number of cells needed to encode reset
>  		line, should be 1
>  
> @@ -37,8 +38,10 @@ Device nodes that need access to reset lines should
>  specify them as a reset phandle in their corresponding node as
>  specified in reset.txt.
>  
> -For list of all valid reset indicies see
> +For list of all valid reset indices for Zynq UltraScale+ MPSoC see
>  <dt-bindings/reset/xlnx-zynqmp-resets.h>
> +For list of all valid reset indices for Versal see
> +<dt-bindings/reset/xlnx-versal-resets.h>
>  
>  Example:
>  
> diff --git a/include/dt-bindings/reset/xlnx-versal-resets.h b/include/dt-bindings/reset/xlnx-versal-resets.h
> new file mode 100644
> index 000000000000..895424e9b0e5
> --- /dev/null
> +++ b/include/dt-bindings/reset/xlnx-versal-resets.h
> @@ -0,0 +1,105 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + *  Copyright (C) 2020 Xilinx, Inc.
> + */
> +
> +#ifndef _DT_BINDINGS_VERSAL_RESETS_H
> +#define _DT_BINDINGS_VERSAL_RESETS_H
> +
> +#define VERSAL_RST_PMC_POR			(0xc30c001U)

Perhaps some explanation on the numbering as ZynqMP seems to be just an 
index.

> +#define VERSAL_RST_PMC				(0xc410002U)
> +#define VERSAL_RST_PS_POR			(0xc30c003U)
> +#define VERSAL_RST_PL_POR			(0xc30c004U)
> +#define VERSAL_RST_NOC_POR			(0xc30c005U)
> +#define VERSAL_RST_FPD_POR			(0xc30c006U)
> +#define VERSAL_RST_ACPU_0_POR			(0xc30c007U)
> +#define VERSAL_RST_ACPU_1_POR			(0xc30c008U)
> +#define VERSAL_RST_OCM2_POR			(0xc30c009U)
> +#define VERSAL_RST_PS_SRST			(0xc41000aU)
> +#define VERSAL_RST_PL_SRST			(0xc41000bU)
> +#define VERSAL_RST_NOC				(0xc41000cU)
> +#define VERSAL_RST_NPI				(0xc41000dU)
> +#define VERSAL_RST_SYS_RST_1			(0xc41000eU)
> +#define VERSAL_RST_SYS_RST_2			(0xc41000fU)
> +#define VERSAL_RST_SYS_RST_3			(0xc410010U)
> +#define VERSAL_RST_FPD				(0xc410011U)
> +#define VERSAL_RST_PL0				(0xc410012U)
> +#define VERSAL_RST_PL1				(0xc410013U)
> +#define VERSAL_RST_PL2				(0xc410014U)
> +#define VERSAL_RST_PL3				(0xc410015U)
> +#define VERSAL_RST_APU				(0xc410016U)
> +#define VERSAL_RST_ACPU_0			(0xc410017U)
> +#define VERSAL_RST_ACPU_1			(0xc410018U)
> +#define VERSAL_RST_ACPU_L2			(0xc410019U)
> +#define VERSAL_RST_ACPU_GIC			(0xc41001aU)
> +#define VERSAL_RST_RPU_ISLAND			(0xc41001bU)
> +#define VERSAL_RST_RPU_AMBA			(0xc41001cU)
> +#define VERSAL_RST_R5_0				(0xc41001dU)
> +#define VERSAL_RST_R5_1				(0xc41001eU)
> +#define VERSAL_RST_SYSMON_PMC_SEQ_RST		(0xc41001fU)
> +#define VERSAL_RST_SYSMON_PMC_CFG_RST		(0xc410020U)
> +#define VERSAL_RST_SYSMON_FPD_CFG_RST		(0xc410021U)
> +#define VERSAL_RST_SYSMON_FPD_SEQ_RST		(0xc410022U)
> +#define VERSAL_RST_SYSMON_LPD			(0xc410023U)
> +#define VERSAL_RST_PDMA_RST1			(0xc410024U)
> +#define VERSAL_RST_PDMA_RST0			(0xc410025U)
> +#define VERSAL_RST_ADMA				(0xc410026U)
> +#define VERSAL_RST_TIMESTAMP			(0xc410027U)
> +#define VERSAL_RST_OCM				(0xc410028U)
> +#define VERSAL_RST_OCM2_RST			(0xc410029U)
> +#define VERSAL_RST_IPI				(0xc41002aU)
> +#define VERSAL_RST_SBI				(0xc41002bU)
> +#define VERSAL_RST_LPD				(0xc41002cU)
> +#define VERSAL_RST_QSPI				(0xc10402dU)
> +#define VERSAL_RST_OSPI				(0xc10402eU)
> +#define VERSAL_RST_SDIO_0			(0xc10402fU)
> +#define VERSAL_RST_SDIO_1			(0xc104030U)
> +#define VERSAL_RST_I2C_PMC			(0xc104031U)
> +#define VERSAL_RST_GPIO_PMC			(0xc104032U)
> +#define VERSAL_RST_GEM_0			(0xc104033U)
> +#define VERSAL_RST_GEM_1			(0xc104034U)
> +#define VERSAL_RST_SPARE			(0xc104035U)
> +#define VERSAL_RST_USB_0			(0xc104036U)
> +#define VERSAL_RST_UART_0			(0xc104037U)
> +#define VERSAL_RST_UART_1			(0xc104038U)
> +#define VERSAL_RST_SPI_0			(0xc104039U)
> +#define VERSAL_RST_SPI_1			(0xc10403aU)
> +#define VERSAL_RST_CAN_FD_0			(0xc10403bU)
> +#define VERSAL_RST_CAN_FD_1			(0xc10403cU)
> +#define VERSAL_RST_I2C_0			(0xc10403dU)
> +#define VERSAL_RST_I2C_1			(0xc10403eU)
> +#define VERSAL_RST_GPIO_LPD			(0xc10403fU)
> +#define VERSAL_RST_TTC_0			(0xc104040U)
> +#define VERSAL_RST_TTC_1			(0xc104041U)
> +#define VERSAL_RST_TTC_2			(0xc104042U)
> +#define VERSAL_RST_TTC_3			(0xc104043U)
> +#define VERSAL_RST_SWDT_FPD			(0xc104044U)
> +#define VERSAL_RST_SWDT_LPD			(0xc104045U)
> +#define VERSAL_RST_USB				(0xc104046U)
> +#define VERSAL_RST_DPC				(0xc208047U)
> +#define VERSAL_RST_PMCDBG			(0xc208048U)
> +#define VERSAL_RST_DBG_TRACE			(0xc208049U)
> +#define VERSAL_RST_DBG_FPD			(0xc20804aU)
> +#define VERSAL_RST_DBG_TSTMP			(0xc20804bU)
> +#define VERSAL_RST_RPU0_DBG			(0xc20804cU)
> +#define VERSAL_RST_RPU1_DBG			(0xc20804dU)
> +#define VERSAL_RST_HSDP				(0xc20804eU)
> +#define VERSAL_RST_DBG_LPD			(0xc20804fU)
> +#define VERSAL_RST_CPM_POR			(0xc30c050U)
> +#define VERSAL_RST_CPM				(0xc410051U)
> +#define VERSAL_RST_CPMDBG			(0xc208052U)
> +#define VERSAL_RST_PCIE_CFG			(0xc410053U)
> +#define VERSAL_RST_PCIE_CORE0			(0xc410054U)
> +#define VERSAL_RST_PCIE_CORE1			(0xc410055U)
> +#define VERSAL_RST_PCIE_DMA			(0xc410056U)
> +#define VERSAL_RST_CMN				(0xc410057U)
> +#define VERSAL_RST_L2_0				(0xc410058U)
> +#define VERSAL_RST_L2_1				(0xc410059U)
> +#define VERSAL_RST_ADDR_REMAP			(0xc41005aU)
> +#define VERSAL_RST_CPI0				(0xc41005bU)
> +#define VERSAL_RST_CPI1				(0xc41005cU)
> +#define VERSAL_RST_XRAM				(0xc30c05dU)
> +#define VERSAL_RST_AIE_ARRAY			(0xc10405eU)
> +#define VERSAL_RST_AIE_SHIM			(0xc10405fU)
> +
> +#endif
> -- 
> 2.17.1
> 
