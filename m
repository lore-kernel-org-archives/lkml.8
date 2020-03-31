Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F30C2D0F2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CB120BED
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585675443;
	bh=sij6sZdHjrlJxBbn/We2enRGZ1HI64tlL2sxfrwjRH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mU8wT7xGBg9rBJUNYke2dli9wRJbSIUONO1kyCXTH3v/DwR00vySrmTDPysjQ0IRl
	 v3lyMcFFc4SsSYLQgGCBVBTYUPLIpAA7EypPAQqK7FNhc0MBnFJK92FRrX/cHUlr8P
	 CETTW3f29tSL2hQF+Bmhu0opgjLoXkk71JiYji7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgCaRYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:24:02 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41751 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgCaRYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 13:24:02 -0400
Received: by mail-io1-f66.google.com with SMTP id b12so6358924ion.8;
        Tue, 31 Mar 2020 10:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cVWsnQ0VONc6v7HfiFPWgR2S4ya+hTSxwz6XaXmpXss=;
        b=Rkp/g0E/47cQLejUa+qzvwvCqzCZvCHHLEecBVeLGnkjjpqjY3z8kvbkFMgVpjDCvA
         58JljF7sUa4h1wKrAEQ8S2QmQrO55U/7A28lzDqYcg+M9lda/C/HgjZYf2pUOEvJdnAH
         eMjApo02mb6+Hdd2hL9E2zKHwETgMaZM37H23+1m/KBRX5giXjF9dfJK8lBetW3in8fV
         VxKYW/juYDCwGIUGx5ckgAugJJTKI/NJHX5xiOInXSS1MBuOFcebluHo2heLLaPxnv2W
         0w3n3Qb92cXnazDw8zEoNnSABw+S8mecSreUT+KwvuOe50hrMZhbDaB4JRRiiUFwLsu+
         qHtA==
X-Gm-Message-State: ANhLgQ3TPmcV/SFqRmqwrVVphMvNWfhcp26KlNNsjcUTEYf/0cAIGuyj
        /DxZLFaFCCILJ/aFSDuKow==
X-Google-Smtp-Source: ADFU+vsAbWO1axaYoXWeW6Y3V8OsG3c2p6U8F18DLUHtvG4ZeBvb48x4rCJ793KU54E9bszHHfmKYQ==
X-Received: by 2002:a02:634e:: with SMTP id j75mr16757788jac.23.1585675439237;
        Tue, 31 Mar 2020 10:23:59 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id s25sm6100141ilb.37.2020.03.31.10.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 10:23:57 -0700 (PDT)
Received: (nullmailer pid 15410 invoked by uid 1000);
        Tue, 31 Mar 2020 17:23:56 -0000
Date:   Tue, 31 Mar 2020 11:23:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, mark.rutland@arm.com
Subject: Re: [PATCH 4/5] dt-bindings: documentation: add clock bindings
 information for Agilex
Message-ID: <20200331172356.GA17436@bogus>
References: <20200320170212.21523-1-dinguyen@kernel.org>
 <20200320170212.21523-5-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320170212.21523-5-dinguyen@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 12:02:10PM -0500, Dinh Nguyen wrote:
> Document the Agilex clock bindings, and add the clock header file. The
> clock header is an enumeration of all the different clocks on the Agilex
> platform.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v4: really fix build error(comment formatting was wrong)
> v3: address comments from Stephen Boyd
>     fix build error(tab removed in line 37)
>     renamed to intel,agilex.yaml
> v2: convert original document to YAML
> ---
>  .../bindings/clock/intel,agilex.yaml          | 36 ++++++++++
>  include/dt-bindings/clock/agilex-clock.h      | 70 +++++++++++++++++++
>  2 files changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/intel,agilex.yaml
>  create mode 100644 include/dt-bindings/clock/agilex-clock.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/intel,agilex.yaml b/Documentation/devicetree/bindings/clock/intel,agilex.yaml
> new file mode 100644
> index 000000000000..5cf2ee5d6fcc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/intel,agilex.yaml
> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings please:

(GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/intel,agilex.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel SoCFPGA Agilex platform clock controller binding
> +
> +maintainers:
> +  - Dinh Nguyen <dinguyen@kernel.org>
> +
> +description:
> +  The Intel Agilex Clock controller is an integrated clock controller, which
> +  generates and supplies to all modules.
> +
> +properties:
> +  compatible:
> +    const: intel,agilex-clkmgr
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'

Add:

additionalProperties: false

> +
> +examples:
> +  # Clock controller node:
> +  - |
> +    clkmgr: clock-controller@ffd10000 {
> +      compatible = "intel,agilex-clkmgr";
> +      reg = <0xffd10000 0x1000>;
> +      #clock-cells = <1>;

No clock inputs?

> +    };
> +...
> diff --git a/include/dt-bindings/clock/agilex-clock.h b/include/dt-bindings/clock/agilex-clock.h
> new file mode 100644
> index 000000000000..f19cf8ccbdd2
> --- /dev/null
> +++ b/include/dt-bindings/clock/agilex-clock.h
> @@ -0,0 +1,70 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2019, Intel Corporation
> + */
> +
> +#ifndef __AGILEX_CLOCK_H
> +#define __AGILEX_CLOCK_H
> +
> +/* fixed rate clocks */
> +#define AGILEX_OSC1			0
> +#define AGILEX_CB_INTOSC_HS_DIV2_CLK	1
> +#define AGILEX_CB_INTOSC_LS_CLK		2
> +#define AGILEX_L4_SYS_FREE_CLK		3
> +#define AGILEX_F2S_FREE_CLK		4
> +
> +/* PLL clocks */
> +#define AGILEX_MAIN_PLL_CLK		5
> +#define AGILEX_MAIN_PLL_C0_CLK		6
> +#define AGILEX_MAIN_PLL_C1_CLK		7
> +#define AGILEX_MAIN_PLL_C2_CLK		8
> +#define AGILEX_MAIN_PLL_C3_CLK		9
> +#define AGILEX_PERIPH_PLL_CLK		10
> +#define AGILEX_PERIPH_PLL_C0_CLK	11
> +#define AGILEX_PERIPH_PLL_C1_CLK	12
> +#define AGILEX_PERIPH_PLL_C2_CLK	13
> +#define AGILEX_PERIPH_PLL_C3_CLK	14
> +#define AGILEX_MPU_FREE_CLK		15
> +#define AGILEX_MPU_CCU_CLK		16
> +#define AGILEX_BOOT_CLK			17
> +
> +/* fixed factor clocks */
> +#define AGILEX_L3_MAIN_FREE_CLK		18
> +#define AGILEX_NOC_FREE_CLK		19
> +#define AGILEX_S2F_USR0_CLK		20
> +#define AGILEX_NOC_CLK			21
> +#define AGILEX_EMAC_A_FREE_CLK		22
> +#define AGILEX_EMAC_B_FREE_CLK		23
> +#define AGILEX_EMAC_PTP_FREE_CLK	24
> +#define AGILEX_GPIO_DB_FREE_CLK		25
> +#define AGILEX_SDMMC_FREE_CLK		26
> +#define AGILEX_S2F_USER0_FREE_CLK	27
> +#define AGILEX_S2F_USER1_FREE_CLK	28
> +#define AGILEX_PSI_REF_FREE_CLK		29
> +
> +/* Gate clocks */
> +#define AGILEX_MPU_CLK			30
> +#define AGILEX_MPU_L2RAM_CLK		31
> +#define AGILEX_MPU_PERIPH_CLK		32
> +#define AGILEX_L4_MAIN_CLK		33
> +#define AGILEX_L4_MP_CLK		34
> +#define AGILEX_L4_SP_CLK		35
> +#define AGILEX_CS_AT_CLK		36
> +#define AGILEX_CS_TRACE_CLK		37
> +#define AGILEX_CS_PDBG_CLK		38
> +#define AGILEX_CS_TIMER_CLK		39
> +#define AGILEX_S2F_USER0_CLK		40
> +#define AGILEX_EMAC0_CLK		41
> +#define AGILEX_EMAC1_CLK		43
> +#define AGILEX_EMAC2_CLK		44
> +#define AGILEX_EMAC_PTP_CLK		45
> +#define AGILEX_GPIO_DB_CLK		46
> +#define AGILEX_NAND_CLK			47
> +#define AGILEX_PSI_REF_CLK		48
> +#define AGILEX_S2F_USER1_CLK		49
> +#define AGILEX_SDMMC_CLK		50
> +#define AGILEX_SPI_M_CLK		51
> +#define AGILEX_USB_CLK			52
> +#define AGILEX_NUM_CLKS			53
> +
> +#endif	/* __AGILEX_CLOCK_H */
> -- 
> 2.25.1
> 
