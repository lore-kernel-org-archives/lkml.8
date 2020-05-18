Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07619C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D86B720674
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589813496;
	bh=3g/wWLqaVxhq0vYZZHFyMFQevGxo/263BuDxMn0ml9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xUPEi/H5lCPOUNaJNyeQ6hWX3N7SG6DUd1bYzyw/Y1JzlAFqkbk5PvgzOgg+WACf1
	 xwTyLHsZ0gc0jITari/sRoQUlHZHj8Z1LyJJY1o3hWEBbBQywbrGtiMM44hK3sH1fz
	 yvERzuqXkqHxFuZR28utctuBMLCFqySDtBQPr7no=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgEROvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 10:51:36 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40673 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgEROvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 10:51:36 -0400
Received: by mail-io1-f66.google.com with SMTP id s10so10854299iog.7;
        Mon, 18 May 2020 07:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7Gn4YlK7kUoPp9dtG/ayb4X1H6fNbTT3yU13bYuwlvE=;
        b=p/OVFRkMnqwrnw9RDeowmz1C5yNh7DhwGzwnxRQrA4dguXAqJobHnqh8S8cQiq86i2
         2ae7JQ+aSsoaHB+huNZKlvpHru72TxCwe0GZcZk1p6BgwU/RXNHsCgHoKyH2+29OtUDm
         tdMj7z/rM12hMsJZ2BVs5o21HUrGgxh1oMdXx0V/6B7cke0xkkFz1/9LZYZzxoT9U3+u
         qyPCri+HBHuVPwoXyeN0Y7g6wE7MOPxmoiCfmHYD5mXaTzPlSu9BN+Nx1HmLOnXTIkLL
         W68CWtvlEPpD3OA8w0Or/AzkSON6ZjFe2/BTh/hhaOMGM/p4LsB87pC+LuCn56RAD/s+
         sMtQ==
X-Gm-Message-State: AOAM532giTylmZPB3qQvz8t4M/wkBaVfu+dWMGDSCd/GFQZ2XwHqy2JX
        CmYb5SUSodCud952W51yQg==
X-Google-Smtp-Source: ABdhPJxP6hmZ29im/bZWGYdsZGSQGyDZT5FiNmO3e8HqPcv23kCcqg2yfEAMokjjGRF3R93jjNHzdw==
X-Received: by 2002:a6b:b586:: with SMTP id e128mr14709413iof.168.1589813494724;
        Mon, 18 May 2020 07:51:34 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id c10sm4038351ioc.24.2020.05.18.07.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 07:51:34 -0700 (PDT)
Received: (nullmailer pid 21742 invoked by uid 1000);
        Mon, 18 May 2020 14:51:33 -0000
Date:   Mon, 18 May 2020 08:51:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     t-kristo@ti.com, kishon@ti.com, nm@ti.com, nsekhar@ti.com,
        vigneshr@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] dt-bindings: mdf: ti,j721e-syscon.yaml: Add J721e
 system controller
Message-ID: <20200518145133.GA2280@bogus>
References: <20200508082937.14171-1-rogerq@ti.com>
 <20200508082937.14171-3-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508082937.14171-3-rogerq@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 11:29:32AM +0300, Roger Quadros wrote:
> Add DT binding schema for J721e system controller.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  .../bindings/mfd/ti,j721e-syscon.yaml         | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,j721e-syscon.yaml

Use the compatible string for filename.

> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-syscon.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-syscon.yaml
> new file mode 100644
> index 000000000000..e832fb43f884
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ti,j721e-syscon.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/ti,j721e-syscon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI J721e System Controller Registers R/W Device Tree Bindings
> +
> +description: |
> +  This represents the Control Module registers (CTRL_MMR0) on the SoC.
> +  System controller node represents a register region containing a set
> +  of miscellaneous registers. The registers are not cohesive enough to
> +  represent as any specific type of device. The typical use-case is
> +  for some other node's driver, or platform-specific code, to acquire
> +  a reference to the syscon node (e.g. by phandle, node path, or
> +  search using a specific compatible value), interrogate the node (or
> +  associated OS driver) to determine the location of the registers,
> +  and access the registers directly.
> +
> +maintainers:
> +  - Kishon Vijay Abraham I <kishon@ti.com>
> +  - Roger Quadros <rogerq@ti.com
> +
> +allOf:
> +  - $ref: "syscon.yaml#"

Drop this as it is not needed.

> +
> +properties:
> +  compatible:
> +    anyOf:
> +      - items:
> +        - enum:
> +          - ti,j721e-system-controller
> +
> +        - const: syscon

What about simple-mfd?

> +
> +      - contains:
> +          const: syscon
> +        additionalItems: true

Should be dropped.

You are going to need a 'select' entry or this will match on any syscon 
or simple-mfd node:

select:
  properties:
    compatible:
      contains:
        const: ti,j721e-system-controller
  required:
    - compatible


> +
> +# Optional children
> +
> +  "^serdes-ln-ctrl@[0-9a-f]+$":
> +    type: object
> +    description: |
> +      This is the SERDES lane control mux. It should follow the bindings
> +      specified in
> +      Documentation/devicetree/bindings/mux/reg-mux.txt

Really this should reference a 'reg-mux' schema, but fine for now. Bonus 
points if you do convert reg-mux.txt though. 

> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    scm_conf: scm-conf@100000 {
> +        compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
> +        reg = <0x00100000 0x1c000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;

These aren't documented and you need 'ranges' for the child address to 
be translatable.

> +
> +        serdes_ln_ctrl: serdes-ln-ctrl@4080 {
> +            compatible = "mmio-mux";
> +            reg = <0x00004080 0x50>;
> +        };
> +    };
> +...
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
