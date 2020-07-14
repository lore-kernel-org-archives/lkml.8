Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E76C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA26820658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594761151;
	bh=555ffu1VVePu0eeyZjDrmVVCXp6JFi7LXltX5kkzFbs=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:List-ID:
	 From;
	b=y0Z3Tcn9tK+JE3qgicZYQWf8yGskSe+LauUtpuaZyaXZbJXvtkaYYw8XIk3Hx3JNp
	 IKPtIq1jK8t/mkda/3BrwoU5FRbIWnOWHAKRxnkaJl29cwQEbHIJqNpai6s1l07sGY
	 y9rYOpVGDiah3a7T82DAwEvQ1tH38Qz+Tz3f55rs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgGNVMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:12:30 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:41220 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbgGNVMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 17:12:30 -0400
Received: by mail-il1-f196.google.com with SMTP id q3so58025ilt.8;
        Tue, 14 Jul 2020 14:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S13MP5PonlfNBx38Brx7HPH7gHXZ1ZmRAhb/buFrfQk=;
        b=bej9e2exjXIcLza7LLRNsxv5tVND07bIYfhBYjTYo9Xc9UBWQOdt7LFw/hLOR9W8//
         FBtslCFX6nIGQK/uvAlFtIDbsvlxZz+t61Z1THnoIc+0N+nmPz/NImHsIzAilw7VtWA0
         kO+K7tsUN8ctYMR9zntsy9A6S3xcIPH6XxhMZXgVH8mqkRLNKPCow+s3OT6KhkX7OHT1
         /6aa/tp35cPeFpngRRvj96J3MFTcw5ChlVxnmc0i17KdmjjRKaT96Ha3wO0zBSG3UabC
         QNGTGvXjQVr1nRv/PCgjWj8r3khsUiboD3yvSEtrbxLbqezzdv44E8lweBctpdQhKV5r
         3unQ==
X-Gm-Message-State: AOAM531VddElLf3aLsPhKyBFncJQigGgAaudgoeCKxK1/3zBTs6rNHsp
        8QmRsahTYjHjAiQLRG0AnHVSRops7O/n
X-Google-Smtp-Source: ABdhPJyDNiUPgR201wUJawqLfdOlbMUE19Yu2W+Wctasoh8enVF6bWtaSMKWKLDHb59+amEamS0T3w==
X-Received: by 2002:a92:8b11:: with SMTP id i17mr6580022ild.212.1594761148802;
        Tue, 14 Jul 2020 14:12:28 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id l18sm57363ill.56.2020.07.14.14.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 14:12:28 -0700 (PDT)
Received: (nullmailer pid 2927743 invoked by uid 1000);
        Tue, 14 Jul 2020 21:12:27 -0000
Date:   Tue, 14 Jul 2020 15:12:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
List-Id: <soc.lore.kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, SoC Team <soc@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCH v3 3/7] dt-bindings: clock: Add Keem Bay clock IDs
Message-ID: <20200714211227.GA2924943@bogus>
References: <20200714161305.836348-1-daniele.alessandrelli@linux.intel.com>
 <20200714161305.836348-4-daniele.alessandrelli@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714161305.836348-4-daniele.alessandrelli@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 05:13:01PM +0100, Daniele Alessandrelli wrote:
> From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> 
> Add clock dt-bindings for Keem Bay SoC.

Where's the binding schema?

> 
> Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> ---
>  include/dt-bindings/clock/keembay-clocks.h | 188 +++++++++++++++++++++
>  1 file changed, 188 insertions(+)
>  create mode 100644 include/dt-bindings/clock/keembay-clocks.h
> 
> diff --git a/include/dt-bindings/clock/keembay-clocks.h b/include/dt-bindings/clock/keembay-clocks.h
> new file mode 100644
> index 000000000000..4ad6616ee8e0
> --- /dev/null
> +++ b/include/dt-bindings/clock/keembay-clocks.h
> @@ -0,0 +1,188 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
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
> -- 
> 2.26.2
> 
