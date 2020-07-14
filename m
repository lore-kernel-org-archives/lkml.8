Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEAFC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE3F221D95
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594696357;
	bh=7teKimDiKhtN7gwdoqrph9NXDazpZxHuNwREga8FR8o=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:List-ID:
	 From;
	b=QdQy4V/sXet9hqtxS/Ywe66rtLYn6L5HFDnKpjWLO3mPLP04QZNhVnS1T1eop87PV
	 hb4/muTyYcX+JA9CLpFbirptE0v2cJASHbCx6QonQz9SCAmu9AEuW9UEOnqkEWpN01
	 79B5beWP6h4h/oM2v6nd3Ayofn6xOtzcdgSkKRH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgGNDMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 23:12:36 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40142 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgGNDMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 23:12:36 -0400
Received: by mail-io1-f66.google.com with SMTP id l17so4297395iok.7;
        Mon, 13 Jul 2020 20:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o50eYrt6CTyb4zIhccu8LhaeagMqxW7kpjbC8HMyN3Q=;
        b=Ps/WfoJR70BqqpP9Nm4kBiPZrzH6K+s8V/6wGHxNfa5hoVBD7pbfT0ATG+2+s0L0sr
         vRTShTM0w6SLxmeGGWcV2kCocD5rHTOFVRBWuHXthywaQ1F1F0D59I59GckMvRT8pwye
         kQnOhUS+OrHdq7ychneJFD3G2fSwLNjyKUHwvrr0bj9NKmubS4Pystxo3EVsp4jCsYoB
         J+pFeag9FL7tzty0VaD7ZNM4VS3V6a9XbYD9KpQ+rbXU9LJpYw8qUv0XiPBuuEsJ/axi
         ln4855gDfF5KuzBdSxTnyk9C4BUhvHx5F8zl6cHER2ayjWTbUUeeizZ7zrT0LbSRlXLK
         KIIg==
X-Gm-Message-State: AOAM531Eto5+nufYxSyV9bMikiRCyQ3Tfhmc6ubVQbSD/NShKC4l6Zor
        Y5z4YUxmgZTajqa2AtPdbA==
X-Google-Smtp-Source: ABdhPJzBGWn7ulFpqO8YxkqyXNCEyzdolgeM/5kMPXaMpYrROKZsKBk5f8R3qqcIYA577cHR6iUFIw==
X-Received: by 2002:a05:6602:234d:: with SMTP id r13mr2820944iot.83.1594696354100;
        Mon, 13 Jul 2020 20:12:34 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v5sm8563851ios.54.2020.07.13.20.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 20:12:33 -0700 (PDT)
Received: (nullmailer pid 1218891 invoked by uid 1000);
        Tue, 14 Jul 2020 03:12:32 -0000
Date:   Mon, 13 Jul 2020 21:12:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
List-Id: <soc.lore.kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, SoC Team <soc@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        devicetree@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
        Paul Murphy <paul.j.murphy@intel.com>,
        Will Deacon <will@kernel.org>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: arm: Add Keem Bay bindings
Message-ID: <20200714031232.GA1217280@bogus>
References: <20200708175020.194436-1-daniele.alessandrelli@linux.intel.com>
 <20200708175020.194436-3-daniele.alessandrelli@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708175020.194436-3-daniele.alessandrelli@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 06:50:17PM +0100, Daniele Alessandrelli wrote:
> From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> 
> Document Intel Movidius SoC code-named Keem Bay, along with the Keem Bay
> EVM board.
> 
> Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
> Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> ---
>  .../devicetree/bindings/arm/keembay.yaml      |  19 ++

>  include/dt-bindings/clock/keembay-clocks.h    | 188 ++++++++++++++++++
>  include/dt-bindings/power/keembay-power.h     |  19 ++

These belong with the clock and power bindings.

>  3 files changed, 226 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/keembay.yaml
>  create mode 100644 include/dt-bindings/clock/keembay-clocks.h
>  create mode 100644 include/dt-bindings/power/keembay-power.h
> 
> diff --git a/Documentation/devicetree/bindings/arm/keembay.yaml b/Documentation/devicetree/bindings/arm/keembay.yaml
> new file mode 100644
> index 000000000000..f81b110046ca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/keembay.yaml
> @@ -0,0 +1,19 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/keembay.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Keem Bay platform device tree bindings
> +
> +maintainers:
> +  - Paul J. Murphy <paul.j.murphy@intel.com>
> +  - Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +        - intel,keembay-evm
> +      - const: intel,keembay
> +...
> diff --git a/include/dt-bindings/clock/keembay-clocks.h b/include/dt-bindings/clock/keembay-clocks.h
> new file mode 100644
> index 000000000000..a68e986dd565
> --- /dev/null
> +++ b/include/dt-bindings/clock/keembay-clocks.h
> @@ -0,0 +1,188 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2020 Intel Corporation.
> + *
> + * Device tree defines for clocks in Keem Bay.
> + */
> +
> +#ifndef __DT_BINDINGS_KEEMBAY_CLOCKS_H
> +#define __DT_BINDINGS_KEEMBAY_CLOCKS_H
> +
> +/* CPR_PLL region. CLK_ID: 0 - 11 */
> +#define KEEM_BAY_A53_PLL_START_ID (0)
> +#define KEEM_BAY_A53_PLL_0_OUT_0 (KEEM_BAY_A53_PLL_START_ID + 0)
> +#define KEEM_BAY_A53_PLL_0_OUT_1 (KEEM_BAY_A53_PLL_START_ID + 1)
> +#define KEEM_BAY_A53_PLL_0_OUT_2 (KEEM_BAY_A53_PLL_START_ID + 2)
> +#define KEEM_BAY_A53_PLL_0_OUT_3 (KEEM_BAY_A53_PLL_START_ID + 3)
> +#define KEEM_BAY_A53_PLL_1_OUT_0 (KEEM_BAY_A53_PLL_START_ID + 4)
> +#define KEEM_BAY_A53_PLL_1_OUT_1 (KEEM_BAY_A53_PLL_START_ID + 5)
> +#define KEEM_BAY_A53_PLL_1_OUT_2 (KEEM_BAY_A53_PLL_START_ID + 6)
> +#define KEEM_BAY_A53_PLL_1_OUT_3 (KEEM_BAY_A53_PLL_START_ID + 7)
> +#define KEEM_BAY_A53_PLL_2_OUT_0 (KEEM_BAY_A53_PLL_START_ID + 8)
> +#define KEEM_BAY_A53_PLL_2_OUT_1 (KEEM_BAY_A53_PLL_START_ID + 9)
> +#define KEEM_BAY_A53_PLL_2_OUT_2 (KEEM_BAY_A53_PLL_START_ID + 10)
> +#define KEEM_BAY_A53_PLL_2_OUT_3 (KEEM_BAY_A53_PLL_START_ID + 11)
> +#define KEEM_BAY_A53_PLL_MAX_ID (KEEM_BAY_A53_PLL_2_OUT_3)
> +
> +/* A53_CPR region. CLK_ID: 12 - 30 */
> +#define KEEM_BAY_A53_START_ID (KEEM_BAY_A53_PLL_MAX_ID + 1)
> +#define KEEM_BAY_A53_AON (KEEM_BAY_A53_START_ID + 0)
> +#define KEEM_BAY_A53_NOC (KEEM_BAY_A53_START_ID + 1)
> +#define KEEM_BAY_A53_FUSE (KEEM_BAY_A53_START_ID + 2)
> +#define KEEM_BAY_A53_ROM (KEEM_BAY_A53_START_ID + 3)
> +#define KEEM_BAY_A53_ICB (KEEM_BAY_A53_START_ID + 4)
> +#define KEEM_BAY_A53_GIC (KEEM_BAY_A53_START_ID + 5)
> +#define KEEM_BAY_A53_TIM (KEEM_BAY_A53_START_ID + 6)
> +#define KEEM_BAY_A53_GPIO (KEEM_BAY_A53_START_ID + 7)
> +#define KEEM_BAY_A53_JTAG (KEEM_BAY_A53_START_ID + 8)
> +#define KEEM_BAY_A53_MBIST_0 (KEEM_BAY_A53_START_ID + 9)
> +#define KEEM_BAY_A53_DSS (KEEM_BAY_A53_START_ID + 10)
> +#define KEEM_BAY_A53_MSS (KEEM_BAY_A53_START_ID + 11)
> +#define KEEM_BAY_A53_PSS (KEEM_BAY_A53_START_ID + 12)
> +#define KEEM_BAY_A53_PCIE (KEEM_BAY_A53_START_ID + 13)
> +#define KEEM_BAY_A53_VENC (KEEM_BAY_A53_START_ID + 14)
> +#define KEEM_BAY_A53_VDEC (KEEM_BAY_A53_START_ID + 15)
> +#define KEEM_BAY_A53_MBIST_1 (KEEM_BAY_A53_START_ID + 16)
> +#define KEEM_BAY_A53_MBIST_2 (KEEM_BAY_A53_START_ID + 17)
> +#define KEEM_BAY_A53_MBIST_3 (KEEM_BAY_A53_START_ID + 18)
> +#define KEEM_BAY_A53_MAX_ID (KEEM_BAY_A53_MBIST_3)
> +
> +/* A53_CPR_AUX region. CLK_ID: 31 - 57 */
> +#define KEEM_BAY_A53_AUX_START_ID (KEEM_BAY_A53_MAX_ID + 1)
> +#define KEEM_BAY_A53_AUX_32KHZ (KEEM_BAY_A53_AUX_START_ID + 0)
> +#define KEEM_BAY_A53_AUX_CPR (KEEM_BAY_A53_AUX_START_ID + 1)
> +#define KEEM_BAY_A53_AUX_TSENS (KEEM_BAY_A53_AUX_START_ID + 2)
> +#define KEEM_BAY_A53_AUX_GPIO0 (KEEM_BAY_A53_AUX_START_ID + 3)
> +#define KEEM_BAY_A53_AUX_GPIO1 (KEEM_BAY_A53_AUX_START_ID + 4)
> +#define KEEM_BAY_A53_AUX_GPIO2 (KEEM_BAY_A53_AUX_START_ID + 5)
> +#define KEEM_BAY_A53_AUX_GPIO3 (KEEM_BAY_A53_AUX_START_ID + 6)
> +#define KEEM_BAY_A53_AUX_DDR_REF (KEEM_BAY_A53_AUX_START_ID + 7)
> +#define KEEM_BAY_A53_AUX_DDR_REF_BYPASS (KEEM_BAY_A53_AUX_START_ID + 8)
> +#define KEEM_BAY_A53_AUX_RESERVED1 (KEEM_BAY_A53_AUX_START_ID + 9)
> +#define KEEM_BAY_A53_AUX_VENC (KEEM_BAY_A53_AUX_START_ID + 10)
> +#define KEEM_BAY_A53_AUX_VDEC (KEEM_BAY_A53_AUX_START_ID + 11)
> +#define KEEM_BAY_A53_AUX_USOC_USB_CTRL (KEEM_BAY_A53_AUX_START_ID + 12)
> +#define KEEM_BAY_A53_AUX_USB (KEEM_BAY_A53_AUX_START_ID + 13)
> +#define KEEM_BAY_A53_AUX_USB_REF (KEEM_BAY_A53_AUX_START_ID + 14)
> +#define KEEM_BAY_A53_AUX_USB_ALT_REF (KEEM_BAY_A53_AUX_START_ID + 15)
> +#define KEEM_BAY_A53_AUX_USB_SUSPEND (KEEM_BAY_A53_AUX_START_ID + 16)
> +#define KEEM_BAY_A53_AUX_RESERVED2 (KEEM_BAY_A53_AUX_START_ID + 17)
> +#define KEEM_BAY_A53_AUX_PCIE (KEEM_BAY_A53_AUX_START_ID + 18)
> +#define KEEM_BAY_A53_AUX_DBG_CLK (KEEM_BAY_A53_AUX_START_ID + 19)
> +#define KEEM_BAY_A53_AUX_DBG_TRACE (KEEM_BAY_A53_AUX_START_ID + 20)
> +#define KEEM_BAY_A53_AUX_DBG_DAP (KEEM_BAY_A53_AUX_START_ID + 21)
> +#define KEEM_BAY_A53_AUX_ARM_CLKIN (KEEM_BAY_A53_AUX_START_ID + 22)
> +#define KEEM_BAY_A53_AUX_ARM_AXI (KEEM_BAY_A53_AUX_START_ID + 23)
> +#define KEEM_BAY_A53_AUX_USOC (KEEM_BAY_A53_AUX_START_ID + 24)
> +#define KEEM_BAY_A53_AUX_USOC_REF (KEEM_BAY_A53_AUX_START_ID + 25)
> +#define KEEM_BAY_A53_AUX_USOC_ALT_REF (KEEM_BAY_A53_AUX_START_ID + 26)
> +#define KEEM_BAY_A53_AUX_MAX_ID (KEEM_BAY_A53_AUX_USOC_ALT_REF)
> +
> +/* PSS_CPR region CLK_ID: CLK_ID: 58 - 82 */
> +#define KEEM_BAY_PSS_START_ID (KEEM_BAY_A53_AUX_MAX_ID + 1)
> +#define KEEM_BAY_PSS_I2C0 (KEEM_BAY_PSS_START_ID + 0)
> +#define KEEM_BAY_PSS_I2C1 (KEEM_BAY_PSS_START_ID + 1)
> +#define KEEM_BAY_PSS_I2C2 (KEEM_BAY_PSS_START_ID + 2)
> +#define KEEM_BAY_PSS_I2C3 (KEEM_BAY_PSS_START_ID + 3)
> +#define KEEM_BAY_PSS_I2C4 (KEEM_BAY_PSS_START_ID + 4)
> +#define KEEM_BAY_PSS_SD0 (KEEM_BAY_PSS_START_ID + 5)
> +#define KEEM_BAY_PSS_SD1 (KEEM_BAY_PSS_START_ID + 6)
> +#define KEEM_BAY_PSS_EMMC (KEEM_BAY_PSS_START_ID + 7)
> +#define KEEM_BAY_PSS_AXI_DMA (KEEM_BAY_PSS_START_ID + 8)
> +#define KEEM_BAY_PSS_SPI0 (KEEM_BAY_PSS_START_ID + 9)
> +#define KEEM_BAY_PSS_SPI1 (KEEM_BAY_PSS_START_ID + 10)
> +#define KEEM_BAY_PSS_SPI2 (KEEM_BAY_PSS_START_ID + 11)
> +#define KEEM_BAY_PSS_SPI3 (KEEM_BAY_PSS_START_ID + 12)
> +#define KEEM_BAY_PSS_I2S0 (KEEM_BAY_PSS_START_ID + 13)
> +#define KEEM_BAY_PSS_I2S1 (KEEM_BAY_PSS_START_ID + 14)
> +#define KEEM_BAY_PSS_I2S2 (KEEM_BAY_PSS_START_ID + 15)
> +#define KEEM_BAY_PSS_I2S3 (KEEM_BAY_PSS_START_ID + 16)
> +#define KEEM_BAY_PSS_UART0 (KEEM_BAY_PSS_START_ID + 17)
> +#define KEEM_BAY_PSS_UART1 (KEEM_BAY_PSS_START_ID + 18)
> +#define KEEM_BAY_PSS_UART2 (KEEM_BAY_PSS_START_ID + 19)
> +#define KEEM_BAY_PSS_UART3 (KEEM_BAY_PSS_START_ID + 20)
> +#define KEEM_BAY_PSS_I3C0 (KEEM_BAY_PSS_START_ID + 21)
> +#define KEEM_BAY_PSS_I3C1 (KEEM_BAY_PSS_START_ID + 22)
> +#define KEEM_BAY_PSS_I3C2 (KEEM_BAY_PSS_START_ID + 23)
> +#define KEEM_BAY_PSS_GBE (KEEM_BAY_PSS_START_ID + 24)
> +#define KEEM_BAY_PSS_MAX_ID (KEEM_BAY_PSS_GBE)
> +
> +/* PSS_CPR_AUX region. CLK_ID: 83 - 97 */
> +#define KEEM_BAY_PSS_AUX_START_ID (KEEM_BAY_PSS_MAX_ID + 1)
> +#define KEEM_BAY_PSS_AUX_I2S0 (KEEM_BAY_PSS_AUX_START_ID + 0)
> +#define KEEM_BAY_PSS_AUX_I2S1 (KEEM_BAY_PSS_AUX_START_ID + 1)
> +#define KEEM_BAY_PSS_AUX_I2S2 (KEEM_BAY_PSS_AUX_START_ID + 2)
> +#define KEEM_BAY_PSS_AUX_I2S3 (KEEM_BAY_PSS_AUX_START_ID + 3)
> +#define KEEM_BAY_PSS_AUX_UART0 (KEEM_BAY_PSS_AUX_START_ID + 4)
> +#define KEEM_BAY_PSS_AUX_UART1 (KEEM_BAY_PSS_AUX_START_ID + 5)
> +#define KEEM_BAY_PSS_AUX_UART2 (KEEM_BAY_PSS_AUX_START_ID + 6)
> +#define KEEM_BAY_PSS_AUX_UART3 (KEEM_BAY_PSS_AUX_START_ID + 7)
> +#define KEEM_BAY_PSS_AUX_SD0 (KEEM_BAY_PSS_AUX_START_ID + 8)
> +#define KEEM_BAY_PSS_AUX_SD1 (KEEM_BAY_PSS_AUX_START_ID + 9)
> +#define KEEM_BAY_PSS_AUX_EMMC (KEEM_BAY_PSS_AUX_START_ID + 10)
> +#define KEEM_BAY_PSS_AUX_TRNG (KEEM_BAY_PSS_AUX_START_ID + 11)
> +#define KEEM_BAY_PSS_AUX_OCS (KEEM_BAY_PSS_AUX_START_ID + 12)
> +#define KEEM_BAY_PSS_AUX_GBE_PTP (KEEM_BAY_PSS_AUX_START_ID + 13)
> +#define KEEM_BAY_PSS_AUX_GBE_TX (KEEM_BAY_PSS_AUX_START_ID + 14)
> +#define KEEM_BAY_PSS_AUX_MAX_ID (KEEM_BAY_PSS_AUX_GBE_TX)
> +
> +/* DSS_CPR region. CLK_ID: 98 - 109 */
> +#define KEEM_BAY_DSS_START_ID (KEEM_BAY_PSS_AUX_MAX_ID + 1)
> +#define KEEM_BAY_DSS_SYS (KEEM_BAY_DSS_START_ID + 0)
> +#define KEEM_BAY_DSS_DEC400 (KEEM_BAY_DSS_START_ID + 1)
> +#define KEEM_BAY_DSS_TSENSE (KEEM_BAY_DSS_START_ID + 2)
> +#define KEEM_BAY_DSS_BUS_0 (KEEM_BAY_DSS_START_ID + 3)
> +#define KEEM_BAY_DSS_CORE_0 (KEEM_BAY_DSS_START_ID + 4)
> +#define KEEM_BAY_DSS_REF_0 (KEEM_BAY_DSS_START_ID + 5)
> +#define KEEM_BAY_DSS_REF_BYP_0 (KEEM_BAY_DSS_START_ID + 6)
> +#define KEEM_BAY_DSS_BUS_1 (KEEM_BAY_DSS_START_ID + 7)
> +#define KEEM_BAY_DSS_CORE_1 (KEEM_BAY_DSS_START_ID + 8)
> +#define KEEM_BAY_DSS_REF_1 (KEEM_BAY_DSS_START_ID + 9)
> +#define KEEM_BAY_DSS_REF_BYP_1 (KEEM_BAY_DSS_START_ID + 10)
> +#define KEEM_BAY_DSS_MMU500 (KEEM_BAY_DSS_START_ID + 11)
> +#define KEEM_BAY_DSS_MAX_ID (KEEM_BAY_DSS_MMU500)
> +
> +/* USS_CPR region. CLK_ID: 110 - 116 */
> +#define KEEM_BAY_USS_START_ID (KEEM_BAY_DSS_MAX_ID + 1)
> +#define KEEM_BAY_USS_SYS (KEEM_BAY_USS_START_ID + 0)
> +#define KEEM_BAY_USS_REF (KEEM_BAY_USS_START_ID + 1)
> +#define KEEM_BAY_USS_ALT_REF (KEEM_BAY_USS_START_ID + 2)
> +#define KEEM_BAY_USS_SUSPEND (KEEM_BAY_USS_START_ID + 3)
> +#define KEEM_BAY_USS_CORE (KEEM_BAY_USS_START_ID + 4)
> +#define KEEM_BAY_USS_LOW_JIT (KEEM_BAY_USS_START_ID + 5)
> +#define KEEM_BAY_USS_PHY_TST (KEEM_BAY_USS_START_ID + 6)
> +#define KEEM_BAY_USS_MAX_ID (KEEM_BAY_USS_PHY_TST)
> +
> +/* MSS_CPR region. CLK_ID: 117 - 129 */
> +#define KEEM_BAY_MSS_START_ID (KEEM_BAY_USS_MAX_ID + 1)
> +#define KEEM_BAY_MSS_CPU (KEEM_BAY_MSS_START_ID + 0)
> +#define KEEM_BAY_MSS_CPU_DSU (KEEM_BAY_MSS_START_ID + 1)
> +#define KEEM_BAY_MSS_CPU_L2C (KEEM_BAY_MSS_START_ID + 2)
> +#define KEEM_BAY_MSS_CPU_ICB (KEEM_BAY_MSS_START_ID + 3)
> +#define KEEM_BAY_MSS_CPU_TIM (KEEM_BAY_MSS_START_ID + 4)
> +#define KEEM_BAY_MSS_JPGENC (KEEM_BAY_MSS_START_ID + 5)
> +#define KEEM_BAY_MSS_DTB (KEEM_BAY_MSS_START_ID + 6)
> +#define KEEM_BAY_MSS_BLT (KEEM_BAY_MSS_START_ID + 7)
> +#define KEEM_BAY_MSS_UPA (KEEM_BAY_MSS_START_ID + 8)
> +#define KEEM_BAY_MSS_NCE (KEEM_BAY_MSS_START_ID + 9)
> +#define KEEM_BAY_MSS_CV (KEEM_BAY_MSS_START_ID + 10)
> +#define KEEM_BAY_MSS_ISP (KEEM_BAY_MSS_START_ID + 11)
> +#define KEEM_BAY_MSS_CAM (KEEM_BAY_MSS_START_ID + 12)
> +#define KEEM_BAY_MSS_MAX_ID (KEEM_BAY_MSS_CAM)
> +
> +/* MSS_CPR_AUX region. CLK_ID: 130 - 138 */
> +#define KEEM_BAY_MSS_AUX_START_ID (KEEM_BAY_MSS_MAX_ID + 1)
> +#define KEEM_BAY_MSS_AUX_CIF (KEEM_BAY_MSS_AUX_START_ID + 0)
> +#define KEEM_BAY_MSS_AUX_LCD (KEEM_BAY_MSS_AUX_START_ID + 1)
> +#define KEEM_BAY_MSS_AUX_SLVDS0 (KEEM_BAY_MSS_AUX_START_ID + 2)
> +#define KEEM_BAY_MSS_AUX_SLVDS1 (KEEM_BAY_MSS_AUX_START_ID + 3)
> +#define KEEM_BAY_MSS_AUX_MIPI_TX0 (KEEM_BAY_MSS_AUX_START_ID + 4)
> +#define KEEM_BAY_MSS_AUX_MIPI_TX1 (KEEM_BAY_MSS_AUX_START_ID + 5)
> +#define KEEM_BAY_MSS_AUX_MIPI_ECFG (KEEM_BAY_MSS_AUX_START_ID + 6)
> +#define KEEM_BAY_MSS_AUX_MIPI_CFG (KEEM_BAY_MSS_AUX_START_ID + 7)
> +#define KEEM_BAY_MSS_AUX_JPGENC (KEEM_BAY_MSS_AUX_START_ID + 8)
> +#define KEEM_BAY_MSS_AUX_MAX_ID (KEEM_BAY_MSS_AUX_JPGENC)
> +
> +#define KEEM_BAY_NUM_CLOCKS (KEEM_BAY_MSS_AUX_MAX_ID + 1)
> +
> +#endif /* __DT_BINDINGS_KEEMBAY_CLOCKS_H */
> diff --git a/include/dt-bindings/power/keembay-power.h b/include/dt-bindings/power/keembay-power.h
> new file mode 100644
> index 000000000000..335008a8b68e
> --- /dev/null
> +++ b/include/dt-bindings/power/keembay-power.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2020 Intel Corporation.
> + *
> + * Device tree defines for power domains in Keem Bay.
> + */
> +
> +#ifndef __DT_BINDINGS_KEEMBAY_POWER_H
> +#define __DT_BINDINGS_KEEMBAY_POWER_H
> +
> +#define KEEM_BAY_PSS_POWER_DOMAIN 0
> +#define KEEM_BAY_MSS_CPU_POWER_DOMAIN 1
> +#define KEEM_BAY_VDEC_POWER_DOMAIN 2
> +#define KEEM_BAY_VENC_POWER_DOMAIN 3
> +#define KEEM_BAY_PCIE_POWER_DOMAIN 4
> +#define KEEM_BAY_USS_POWER_DOMAIN 5
> +#define KEEM_BAY_MSS_CAM_POWER_DOMAIN 6
> +
> +#endif /* __DT_BINDINGS_KEEMBAY_POWER_H */
> -- 
> 2.26.2
> 
