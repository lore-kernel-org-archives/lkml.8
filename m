Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D209C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 20:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D636820748
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 20:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579207701;
	bh=sovqMoJzNJbW/wMTxoZfJ3ui+9xtKfhoHmYs/tyDV68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=alKrB/DvLpcwsnDxDgQoSbWSDJxamG4djZkzsUCSjSSDSRkE4iTefi310N33mbVhD
	 n1k+jfP8aYeP/scbGN/82fqxgyJC6u4vqjfEmQxVx+24xgNDjHaTjkMqI1yAF1uFyJ
	 LL+A1lZzZECqHy9cWt1YCGfbknJFCr4k9Auak4Mc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388150AbgAPUsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 15:48:20 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42058 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgAPUsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 15:48:20 -0500
Received: by mail-ot1-f67.google.com with SMTP id 66so20650830otd.9;
        Thu, 16 Jan 2020 12:48:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BKpDxkPQvhaYwq0BM0j0+4RX+8L/FqW/tD6hcJ/WZ8Y=;
        b=ulOidGdKRiRdlY8VOZszJhyjAauTrxAXsdD7IE4cuJrJ30QApKjd0bvId4BtV+JP3p
         UK4SbWHOqIgCWrxlej3LAP8DDdskftp9FTDtjHt98ieN1anyVCLBv2Ix6d2GChWkxL/t
         BguuPl2HoetxwtUrcIRYT8SMLu9QM+/Lb9quMWrpMDXRIipIB5bZPBhASej64roO4s31
         81Yu38XbJ96LgWTI/hq6Fo7DqI+eCLr+J/CerJCYILQasRaVJ1ikJECgdZollcXOS9VU
         xd4LrQHJDHkCos37jQC1hY9x+lne9zXQxyOynoNq5Avf14doJl+CFCtrQvOU9syb8lxs
         AyUw==
X-Gm-Message-State: APjAAAUtsY1rsIF5Qn88rUTH41kodMdWHXq++ACf8NwxWt8CrCuiUqP3
        VeyLo0eUM4qscGlDjUjS/g==
X-Google-Smtp-Source: APXvYqwElUK+YujhdGIIl9hNxkKGMyK9dGJUHl9hNmGbi/q+K5ZFvapHlfm9AC50/8wXvJNavkLnjQ==
X-Received: by 2002:a9d:6e03:: with SMTP id e3mr3614892otr.46.1579207699487;
        Thu, 16 Jan 2020 12:48:19 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a17sm8039507otp.66.2020.01.16.12.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 12:48:18 -0800 (PST)
Received: (nullmailer pid 14099 invoked by uid 1000);
        Thu, 16 Jan 2020 20:48:17 -0000
Date:   Thu, 16 Jan 2020 14:48:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jian Hu <jian.hu@amlogic.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Chandle Zou <chandle.zou@amlogic.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/5] dt-bindings: clock: meson: add A1 PLL clock
 controller bindings
Message-ID: <20200116204817.GA9529@bogus>
References: <20200116080440.118679-1-jian.hu@amlogic.com>
 <20200116080440.118679-2-jian.hu@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116080440.118679-2-jian.hu@amlogic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 04:04:36PM +0800, Jian Hu wrote:
> Add the documentation to support Amlogic A1 PLL clock driver,
> and add A1 PLL clock controller bindings.
> 
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> ---
>  .../bindings/clock/amlogic,a1-pll-clkc.yaml   | 54 +++++++++++++++++++
>  include/dt-bindings/clock/a1-pll-clkc.h       | 16 ++++++
>  2 files changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/a1-pll-clkc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> new file mode 100644
> index 000000000000..071240b65e70
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/amlogic,a1-pll-clkc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic Meson A/C serials PLL Clock Control Unit Device Tree Bindings
> +
> +maintainers:
> +  - Neil Armstrong <narmstrong@baylibre.com>
> +  - Jerome Brunet <jbrunet@baylibre.com>
> +  - Jian Hu <jian.hu@jian.hu.com>
> +
> +properties:
> +  compatible:
> +    const: amlogic,a1-pll-clkc
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2

Not necessary, so drop. Implied by the length of 'items'.

> +    items:
> +     - description: input xtal_fixpll
> +     - description: input xtal_hifipll
> +
> +  clock-names:
> +    maxItems: 2

Same here.

> +    items:
> +      - const: xtal_fixpll
> +      - const: xtal_hifipll
> +
> +required:
> +  - compatible
> +  - "#clock-cells"
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clkc_pll: pll-clock-controller@7c80 {
> +                compatible = "amlogic,a1-pll-clkc";
> +                reg = <0 0x7c80 0 0x18c>;
> +                #clock-cells = <1>;
> +                clocks = <&clkc_periphs CLKID_XTAL_FIXPLL>,
> +                         <&clkc_periphs CLKID_XTAL_HIFIPLL>;

The example will fail to build because these aren't defined.

Run 'make dt_binding_check'.

> +                clock-names = "xtal_fixpll", "xtal_hifipll";
> +    };
> diff --git a/include/dt-bindings/clock/a1-pll-clkc.h b/include/dt-bindings/clock/a1-pll-clkc.h
> new file mode 100644
> index 000000000000..58eae237e503
> --- /dev/null
> +++ b/include/dt-bindings/clock/a1-pll-clkc.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
> + */
> +
> +#ifndef __A1_PLL_CLKC_H
> +#define __A1_PLL_CLKC_H
> +
> +#define CLKID_FIXED_PLL				1
> +#define CLKID_FCLK_DIV2				6
> +#define CLKID_FCLK_DIV3				7
> +#define CLKID_FCLK_DIV5				8
> +#define CLKID_FCLK_DIV7				9
> +#define CLKID_HIFI_PLL				10
> +
> +#endif /* __A1_PLL_CLKC_H */
> -- 
> 2.24.0
> 
