Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FEBC4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0958721D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582730807;
	bh=2LGcpavSmipH6rIBYAM911GZvRXy5NjGLP+bOq6LCbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SG5zZ5DWdStv4ofEsWJ7x6N/SR6PA0W00XhUEoKOqd2ssRwB7W7arT9qCWh31gYjx
	 7bH+HZ+7yCB9onW+4b3ucJezs8Ks5+ayue0SiAkrpwoZkAUvLkj1CZErPqcdJ2y4G3
	 QkQorTeATE4BI4jJ8RCJkz9tWWoqaqP/Nzc9eK3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgBZP0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:26:46 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36756 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgBZP0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:26:45 -0500
Received: by mail-ot1-f65.google.com with SMTP id j20so3300991otq.3;
        Wed, 26 Feb 2020 07:26:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9RM2qplPak7AljZxjMc9YQCmJZvQ+Q6c/mA66gm9+R8=;
        b=ZxVwsASE58e0vDFUX3R0oHuKJpCn2ULZVDGIohiXBW8YC8kjy1kNwyvK2wzrFiFdYP
         bxwvI4MdSdKsAR1FNCKeglBI+5z5nGHYbqWTzKBLbdWwt8lMZZAt9oJWJEJ1PC2AUuPY
         9nSJ57xfNoVSkYVGgQNk+4GcND/XbzBLqAeQZ657AaidVkLNX/jNpTtkgaVkA6wuaiMK
         1l0FPcWoc16eeP25KWG3MzvWM0cslJkU+Xz5+tTo2M+06aWa48wWZfeILE5ueCyItxq9
         6wAE41pTZe/6lqqCJE0TqZjt+P/xPnFs5fKRrJD4Oe36y8rLJhs1d6sBCw2mIjMEeIP0
         jv/w==
X-Gm-Message-State: APjAAAWB+mOyjcKlmMyjW+LtsxGPnJTbiTqY0v3q/qAbPYZ/nJaXZQqz
        1HOUfHR2xiwD9wMjtZqhng==
X-Google-Smtp-Source: APXvYqxlqaPG48CQ8FpDR9lxOz6WMsCsbJ7qIcWsypoZ1dMulgChx2uhA2AC5sT/NEN/FP8jU9L06g==
X-Received: by 2002:a05:6830:1d7b:: with SMTP id l27mr3292649oti.251.1582730804414;
        Wed, 26 Feb 2020 07:26:44 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n8sm875925otl.11.2020.02.26.07.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 07:26:43 -0800 (PST)
Received: (nullmailer pid 688 invoked by uid 1000);
        Wed, 26 Feb 2020 15:26:42 -0000
Date:   Wed, 26 Feb 2020 09:26:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH v5 3/7] dt-bindings: clk: sprd: add bindings for sc9863a
 clock controller
Message-ID: <20200226152642.GA26474@bogus>
References: <20200219040915.2153-1-zhang.lyra@gmail.com>
 <20200219040915.2153-4-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219040915.2153-4-zhang.lyra@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 12:09:11PM +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> add a new bindings to describe sc9863a clock compatible string.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  .../bindings/clock/sprd,sc9863a-clk.yaml      | 110 ++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
> new file mode 100644
> index 000000000000..b31569b524e5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
> @@ -0,0 +1,110 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2019 Unisoc Inc.
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/clock/sprd,sc9863a-clk.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: SC9863A Clock Control Unit Device Tree Bindings
> +
> +maintainers:
> +  - Orson Zhai <orsonzhai@gmail.com>
> +  - Baolin Wang <baolin.wang7@gmail.com>
> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> +
> +properties:
> +  "#clock-cells":
> +    const: 1
> +
> +  compatible :
> +    enum:
> +      - sprd,sc9863a-ap-clk
> +      - sprd,sc9863a-aon-clk
> +      - sprd,sc9863a-apahb-gate
> +      - sprd,sc9863a-pmu-gate
> +      - sprd,sc9863a-aonapb-gate
> +      - sprd,sc9863a-pll
> +      - sprd,sc9863a-mpll
> +      - sprd,sc9863a-rpll
> +      - sprd,sc9863a-dpll
> +      - sprd,sc9863a-mm-gate
> +      - sprd,sc9863a-apapb-gate
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 4
> +    description: |
> +      The input parent clock(s) phandle for this clock, only list fixed
> +      clocks which are declared in devicetree.
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 4
> +    description: |
> +      Clock name strings used for driver to reference.

Drop this. That's all 'clock-names'.

> +    items:
> +      - const: ext-26m
> +      - const: ext-32k
> +      - const: ext-4m
> +      - const: rco-100m
> +
> +  reg:
> +    description: |
> +      Contain the registers base address and length.

Drop this. You need to define how many entries (maxItems: 1).

> +
> +required:
> +  - compatible
> +  - '#clock-cells'
> +
> +if:
> +  properties:
> +    compatible:
> +      enum:
> +        - sprd,sc9863a-ap-clk
> +        - sprd,sc9863a-aon-clk
> +then:
> +  required:
> +    - reg
> +
> +else:
> +  description: |
> +    Other SC9863a clock nodes should be the child of a syscon node with
> +    the required property:
> +
> +    - compatible: Should be the following:
> +                  "sprd,sc9863a-glbregs", "syscon", "simple-mfd"
> +
> +    The 'reg' property is also required if there is a sub range of
> +    registers for the clocks that are contiguous.

Which ones are these? You should be able to define that exactly starting 
with the example below.

> +
> +examples:
> +  - |
> +    ap_clk: clock-controller@21500000 {
> +      compatible = "sprd,sc9863a-ap-clk";
> +      reg = <0 0x21500000 0 0x1000>;
> +      clocks = <&ext_26m>, <&ext_32k>;
> +      clock-names = "ext-26m", "ext-32k";
> +      #clock-cells = <1>;
> +    };
> +
> +  - |
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      ap_ahb_regs: syscon@20e00000 {
> +        compatible = "sprd,sc9863a-glbregs", "syscon", "simple-mfd";
> +        reg = <0 0x20e00000 0 0x4000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges = <0 0 0x20e00000 0x4000>;
> +
> +        apahb_gate: apahb-gate@0 {
> +          compatible = "sprd,sc9863a-apahb-gate";
> +          reg = <0x0 0x1020>;
> +          #clock-cells = <1>;

Doesn't this block have input clocks?

> +        };
> +      };
> +    };
> +
> +...
> -- 
> 2.20.1
> 
