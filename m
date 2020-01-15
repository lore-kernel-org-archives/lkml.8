Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6416C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 01:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8884C24679
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 01:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579053430;
	bh=+RnBK1mCOewjQFIBYg85WmzjncWkAV2zsiVMVrHN9hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aP3hP87KvBJVRylXiB5N18VO33Nwe7x08Tam5TLXlPog8AyzUlRkBfO4PvyJbDoSw
	 cV5tIwT9WzhzXD1zV7jZ7G4skR9vs78w/mZ5qd8s2thm0dnO5rrrf8fFXljhajgoba
	 7xBeZHjnIfeRwasp8C/486GeeiI6Smz2igJ4QhfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgAOB5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 20:57:09 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34053 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728862AbgAOB5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 20:57:09 -0500
Received: by mail-ot1-f65.google.com with SMTP id a15so14718989otf.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 17:57:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XGLcLKcTFWSB66QXGtgKLA+04IUnUM9PoGpdYQjMx20=;
        b=FwNe81rFWtOPRZkjGrnQv9G3RNHqpjWoEfe+fglqArzOQEYb7ipqibQswunyEaYPDd
         IU4r/2Cx6a8UnlfYxDvybKQQqBr0Gbp4Us5guEAetZb+oJPm5k6M2co+7YuBQ7wMZ38j
         vwLVgslik4DtfYJxlPxATg91cRinmya1WL8453W48zX71ztxoONkzw5xM2buhxgvW0G4
         YygI34GOyVPFqeVNEYWhTcZ/TwEhK7oZknKkdmuggRYaTAKV13o/y93lK23+lVSCWkzR
         UXF/cClU3bp7icVuUO9Tv7fyny2d6kfpFDw11wGOUKGrJTrb6BWN1/e261dXv+Nt7b/U
         PRyw==
X-Gm-Message-State: APjAAAWIM8sTMuBi14efZ7c7mZXViJB7LKVsU5/bPM2pxMcbEAfo1Qqa
        KUmPQreGJmboNHk4AHQALKOKD8g=
X-Google-Smtp-Source: APXvYqwECNNnGegiYjYvc2PtVVmYvyUa0YoQ5HN8uqQ7QesxlbhBqHRiLwMwl/7h8Py5GZy59Fa8gQ==
X-Received: by 2002:a05:6830:145:: with SMTP id j5mr1042329otp.242.1579053428016;
        Tue, 14 Jan 2020 17:57:08 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q25sm6088590otf.45.2020.01.14.17.57.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 17:57:07 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2209ae
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Tue, 14 Jan 2020 19:57:06 -0600
Date:   Tue, 14 Jan 2020 19:57:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        mark.rutland@arm.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 01/10] dt-bindings: mtd: add rockchip nand
 controller bindings
Message-ID: <20200115015706.GA30647@bogus>
References: <20200108205338.11369-1-jbx6244@gmail.com>
 <20200108205338.11369-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108205338.11369-2-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 09:53:29PM +0100, Johan Jonker wrote:
> Add the Rockchip NAND controller bindings.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../devicetree/bindings/mtd/rockchip,nandc.yaml    | 78 ++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/rockchip,nandc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/rockchip,nandc.yaml b/Documentation/devicetree/bindings/mtd/rockchip,nandc.yaml
> new file mode 100644
> index 000000000..573d1a580
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/rockchip,nandc.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings:

(GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/rockchip,nandc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip NAND Controller Device Tree Bindings
> +
> +allOf:
> +  - $ref: "nand-controller.yaml"

Should end with a '#'.

> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,nandc-v6
> +      - rockchip,nandc-v9

Use SoC specific compatibles, not version numbers.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:
> +    oneOf:
> +      - items:
> +        - const: hclk_nandc
> +      - items:
> +        - const: clk_nandc
> +        - const: hclk_nandc

Can't you put hclk_nandc first so it's always index 0.

> +
> +patternProperties:
> +  "^nand@[a-f0-9]+$":
> +    type: object
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 3
> +
> +      nand-is-boot-medium: true
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rk3188-cru-common.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    nandc: nand-controller@10500000 {
> +      compatible = "rockchip,nandc-v6";
> +      reg = <0x10500000 0x4000>;
> +      interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks = <&cru HCLK_NANDC0>;
> +      clock-names = "hclk_nandc";
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      nand@0 {
> +        reg = <0>;
> +        nand-is-boot-medium;
> +      };
> +    };
> +
> +...
> -- 
> 2.11.0
> 
