Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01F1C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 11:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3F6B21D7B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 11:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZqfF3FxE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgIILRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 07:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbgIILJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 07:09:52 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF28C061755
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 04:08:49 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j34so1819732pgi.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 04:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zDa7gUwuLGfjA17e0NtxK2JttUN8x3gIbUwu4FyUUfI=;
        b=ZqfF3FxEAYU8w90AHq6Hk5n/DkRIsA5gdi4ZbN/o6XOD5PZLNtE9uyq4bViDjTyM/K
         TqdYY/JwIrPnMjTSSGYO8vldLkvDV4JYO+XhWtpZFpIF5A548GvpspQlceVRuE4bTZFM
         iZmVnu6gMNeOPN82USLV8Eg7lK4YxW3Xv6gsUiLt9rfqelGUDu9oqGTXyFtya3wHsf/4
         5zrY5215+VzZ1lKOKJl1TgPwATvkRwmVJglFP8vM0vb06loz1H56FgFcq81SFPc01mSe
         ruoxLDg32fbfzxTaic8T+vkWTMAXmNoezq4oWlqQIHxLQ+CCrWMVwhcYi/TTOi6vSPqe
         Rjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zDa7gUwuLGfjA17e0NtxK2JttUN8x3gIbUwu4FyUUfI=;
        b=jEtXr2amO+CSjCeX+95n3Fb61cVdTGeG8qQOrMHp3Zbv9ssaqHzOHtsCS+AZxwfvuh
         FxSwzOVgVq5q4mQ2bjsTsOgBdYjhTZ9Nex+AbOpWLaTWYBcpRP/oNGF1WlLRFHxjO8da
         QOae45jnKbZ4HhSWlJmq3Z+/x5N+AxWR1pXOA4PVULrEWAcv8p5I10bUizaORnmO9Fuo
         dYcA+OaHuwowOaJt0v3pS9O6tzzdqsH1w9chgCkIHqa/WYUVUt+o8ItEG8568gFGUn+K
         476QaQmPtQ2t8A7l+kjMYIvR7Ix8V4DChfT8CYcBc4v5AqbJ8NWRFyCN19UOLCcH/7vM
         6UwA==
X-Gm-Message-State: AOAM533Epa7zFGfvRJFOI4pInGhyIVAGUZsrnUmLVkTjkaBo5J1Ap4wA
        dTIkONsmQspng7UiPurOTxEpfw==
X-Google-Smtp-Source: ABdhPJwTXpHsO5ma1U37W6x5iJR8PhtUfhkR/Q0unfzXFv2OoL1One9pN7+O8oOL67cGz80SLXekFQ==
X-Received: by 2002:a63:1d5a:: with SMTP id d26mr235857pgm.432.1599649729135;
        Wed, 09 Sep 2020 04:08:49 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id d17sm2264785pgn.56.2020.09.09.04.08.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 04:08:48 -0700 (PDT)
Date:   Wed, 9 Sep 2020 16:38:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Viresh Kumar <vireshk@kernel.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: watchdog: sp-805: Convert to Json-schema
Message-ID: <20200909110846.i3rrd7gayzypj6sp@vireshk-i7>
References: <20200909105046.160991-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909105046.160991-1-andre.przywara@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-09-20, 11:50, Andre Przywara wrote:
> Convert the ARM SP-805 watchdog IP DT binding over to Json-schema.
> 
> A straight-forward conversion, but the requirement for providing two
> clocks got strengthened from "should" to "must".
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Hi,
> 
> this is just the bindings conversion patch, updated to address Rob's
> comments:
> - Remove redundant primecell.yaml inclusion
> - Reference watchdog.yaml
> - Drop now redundant timeout-sec property
> - Add unevaluatedProperties
> 
> The DT fixes are independent and now partly already queued, so I am
> posting this separately.
> 
> Cheers,
> Andre
> 
>  .../bindings/watchdog/arm,sp805.txt           | 32 ---------
>  .../bindings/watchdog/arm,sp805.yaml          | 71 +++++++++++++++++++
>  2 files changed, 71 insertions(+), 32 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/arm,sp805.txt
>  create mode 100644 Documentation/devicetree/bindings/watchdog/arm,sp805.yaml
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/arm,sp805.txt b/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
> deleted file mode 100644
> index bee6f1f0e41b..000000000000
> --- a/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -ARM AMBA Primecell SP805 Watchdog
> -
> -SP805 WDT is a ARM Primecell Peripheral and has a standard-id register that
> -can be used to identify the peripheral type, vendor, and revision.
> -This value can be used for driver matching.
> -
> -As SP805 WDT is a primecell IP, it follows the base bindings specified in
> -'arm/primecell.txt'
> -
> -Required properties:
> -- compatible:  Should be "arm,sp805" & "arm,primecell"
> -- reg:         Should contain location and length for watchdog timer register
> -- clocks:      Clocks driving the watchdog timer hardware. This list should be
> -               2 clocks. With 2 clocks, the order is wdog_clk, apb_pclk
> -               wdog_clk can be equal to or be a sub-multiple of the apb_pclk
> -               frequency
> -- clock-names: Shall be "wdog_clk" for first clock and "apb_pclk" for the
> -               second one
> -
> -Optional properties:
> -- interrupts:  Should specify WDT interrupt number
> -- timeout-sec: Should specify default WDT timeout in seconds. If unset, the
> -               default timeout is determined by the driver
> -
> -Example:
> -	watchdog@66090000 {
> -		compatible = "arm,sp805", "arm,primecell";
> -		reg = <0x66090000 0x1000>;
> -		interrupts = <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&wdt_clk>, <&apb_pclk>;
> -		clock-names = "wdog_clk", "apb_pclk";
> -	};
> diff --git a/Documentation/devicetree/bindings/watchdog/arm,sp805.yaml b/Documentation/devicetree/bindings/watchdog/arm,sp805.yaml
> new file mode 100644
> index 000000000000..a69cac8ec208
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/arm,sp805.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/arm,sp805.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARM AMBA Primecell SP805 Watchdog
> +
> +maintainers:
> +  - Viresh Kumar <vireshk@kernel.org>
> +
> +description: |+
> +  The Arm SP805 IP implements a watchdog device, which triggers an interrupt
> +  after a configurable time period. If that interrupt has not been serviced
> +  when the next interrupt would be triggered, the reset signal is asserted.
> +
> +allOf:
> +  - $ref: /schemas/watchdog/watchdog.yaml#
> +
> +# Need a custom select here or 'arm,primecell' will match on lots of nodes
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        const: arm,sp805
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: arm,sp805
> +      - const: arm,primecell
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description: |
> +      Clocks driving the watchdog timer hardware. The first clock is used
> +      for the actual watchdog counter. The second clock drives the register
> +      interface.
> +    minItems: 2
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: wdog_clk
> +      - const: apb_pclk
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    watchdog@66090000 {
> +        compatible = "arm,sp805", "arm,primecell";
> +        reg = <0x66090000 0x1000>;
> +        interrupts = <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&wdt_clk>, <&apb_pclk>;
> +        clock-names = "wdog_clk", "apb_pclk";
> +    };

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
