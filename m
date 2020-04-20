Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53EDC55182
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F07620722
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587418951;
	bh=rhcP7M0NLQUCuXY0j3cjLY+jZi+dSG5Uib24l3OE+PU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IeN9f8TEjLplLuYtcaXuFinbNtlHqpV8mgBidP7aOqoXte+mXUJtQTO4RaITbCW26
	 lxQXLLk9p9o6SWgpUf4paALlge6orIf0mtQrUGnC2l4PgAhiEEvWyRKL8ob+X6SL3S
	 KVKwF+OPm+de9KVuI5pd4ni10imZB+63qk6H6glc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgDTVma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:42:30 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:36777 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgDTVma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 17:42:30 -0400
Received: by mail-oo1-f66.google.com with SMTP id x17so2480108ooa.3;
        Mon, 20 Apr 2020 14:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MQYFkBcbkzjp4qKekddjrNm+MWFdaUwiorS/Z/G0gTk=;
        b=CkJjCI9g9M9AZbdulu9d1Um0vI+BwS1JLJSNgFyAFenGBOh5X/KCv9bAEyhpjVvk0P
         Xz92xhTGpnIjbFVMYqmGCcQpUiwwDmHor+cvJdlMW9jUd8AROg5V6amnSQYnf6bT+gd5
         4Tcbl+Mxg94TjL0T4sh+PPzhRWRfXLZjxc/gYbcMuzsC3KWgB3Su6GNRr1O78MfEljWK
         /4o12tCI4FW83c7/iqHkiPiF+TlyHFvl56eNtgFKA940MJMvnGHTg849J2fEI+zoiVGR
         Ar2/aFAmVa4YwFMI9+ZsyuZGYyKWuNzEYc79iSBiovVs9mTQDgBCXkBXX0S431vbYodv
         YMvA==
X-Gm-Message-State: AGi0PuZlXVJgpAL+cPvm/eh0ekqxVVyruE0KC2q1Btby8lXi8rrZKtlG
        LR+K1xoZW1VNLB3cmOIhBQ==
X-Google-Smtp-Source: APiQypImh3ff6PfCFGICy2xjqiHsC1DZWwUu2sDJNkQQTuC42XKN8+cjzxR35UswOmFUPMAfei+F0g==
X-Received: by 2002:a4a:95ee:: with SMTP id p43mr14278036ooi.24.1587418949025;
        Mon, 20 Apr 2020 14:42:29 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u13sm170429oor.45.2020.04.20.14.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 14:42:28 -0700 (PDT)
Received: (nullmailer pid 13178 invoked by uid 1000);
        Mon, 20 Apr 2020 21:42:27 -0000
Date:   Mon, 20 Apr 2020 16:42:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     srinivas.kandagatla@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/3] dt-bindings: nvmem: Convert i.MX OCOTP to json-schema
Message-ID: <20200420214227.GA23817@bogus>
References: <1586921602-1877-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586921602-1877-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 11:33:20AM +0800, Anson Huang wrote:
> Convert the i.MX OCOTP binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/nvmem/imx-ocotp.txt        |  50 ----------
>  .../devicetree/bindings/nvmem/imx-ocotp.yaml       | 103 +++++++++++++++++++++
>  2 files changed, 103 insertions(+), 50 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
>  create mode 100644 Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
> deleted file mode 100644
> index 6e346d5..0000000
> --- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -Freescale i.MX6 On-Chip OTP Controller (OCOTP) device tree bindings
> -
> -This binding represents the on-chip eFuse OTP controller found on
> -i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX, i.MX6UL, i.MX6ULL/ULZ, i.MX6SLL,
> -i.MX7D/S, i.MX7ULP, i.MX8MQ, i.MX8MM, i.MX8MN and i.MX8MP SoCs.
> -
> -Required properties:
> -- compatible: should be one of
> -	"fsl,imx6q-ocotp" (i.MX6Q/D/DL/S),
> -	"fsl,imx6sl-ocotp" (i.MX6SL), or
> -	"fsl,imx6sx-ocotp" (i.MX6SX),
> -	"fsl,imx6ul-ocotp" (i.MX6UL),
> -	"fsl,imx6ull-ocotp" (i.MX6ULL/ULZ),
> -	"fsl,imx7d-ocotp" (i.MX7D/S),
> -	"fsl,imx6sll-ocotp" (i.MX6SLL),
> -	"fsl,imx7ulp-ocotp" (i.MX7ULP),
> -	"fsl,imx8mq-ocotp" (i.MX8MQ),
> -	"fsl,imx8mm-ocotp" (i.MX8MM),
> -	"fsl,imx8mn-ocotp" (i.MX8MN),
> -	"fsl,imx8mp-ocotp" (i.MX8MP),
> -	followed by "syscon".
> -- #address-cells : Should be 1
> -- #size-cells : Should be 1
> -- reg: Should contain the register base and length.
> -- clocks: Should contain a phandle pointing to the gated peripheral clock.
> -
> -Optional properties:
> -- read-only: disable write access
> -
> -Optional Child nodes:
> -
> -- Data cells of ocotp:
> -  Detailed bindings are described in bindings/nvmem/nvmem.txt
> -
> -Example:
> -	ocotp: ocotp@21bc000 {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		compatible = "fsl,imx6sx-ocotp", "syscon";
> -		reg = <0x021bc000 0x4000>;
> -		clocks = <&clks IMX6SX_CLK_OCOTP>;
> -
> -		tempmon_calib: calib@38 {
> -			reg = <0x38 4>;
> -		};
> -
> -		tempmon_temp_grade: temp-grade@20 {
> -			reg = <0x20 4>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
> new file mode 100644
> index 0000000..70aa637
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
> @@ -0,0 +1,103 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/imx-ocotp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX6 On-Chip OTP Controller (OCOTP) device tree bindings
> +
> +maintainers:
> +  - Anson Huang <Anson.Huang@nxp.com>
> +
> +description: |
> +  This binding represents the on-chip eFuse OTP controller found on
> +  i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX, i.MX6UL, i.MX6ULL/ULZ, i.MX6SLL,
> +  i.MX7D/S, i.MX7ULP, i.MX8MQ, i.MX8MM, i.MX8MN and i.MX8MP SoCs.
> +
> +allOf:
> +  - $ref: "nvmem.yaml#"
> +
> +properties:
> +  compatible:
> +    anyOf:
> +      - items:
> +        - enum:
> +          - fsl,imx6q-ocotp
> +          - fsl,imx6sl-ocotp
> +          - fsl,imx6sx-ocotp
> +          - fsl,imx6ul-ocotp
> +          - fsl,imx6ull-ocotp
> +          - fsl,imx7d-ocotp
> +          - fsl,imx6sll-ocotp
> +          - fsl,imx7ulp-ocotp
> +          - fsl,imx8mq-ocotp
> +          - fsl,imx8mm-ocotp
> +          - fsl,imx8mn-ocotp
> +          - fsl,imx8mp-ocotp
> +

Drop the blank line here.

> +        - const: syscon
> +
> +      - contains:
> +          const: syscon
> +        additionalItems: true

You shouldn't need the 2nd clause here. And then can remove the 'anyOf'.

> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  clocks:
> +    description: |
> +      OCOTP's clock source.

Drop

> +    maxItems: 1
> +
> +required:
> +  - "#address-cells"
> +  - "#size-cells"
> +  - compatible
> +  - reg
> +
> +patternProperties:
> +  "^.*@[0-9a-f]+$":
> +    type: object
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +        description:
> +          Offset and size in bytes within the storage device.
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx6sx-clock.h>
> +
> +    ocotp: efuse@21bc000 {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        compatible = "fsl,imx6sx-ocotp", "syscon";
> +        reg = <0x021bc000 0x4000>;
> +        clocks = <&clks IMX6SX_CLK_OCOTP>;
> +
> +        cpu_speed_grade: speed-grade@10 {
> +            reg = <0x10 4>;
> +        };
> +
> +        tempmon_calib: calib@38 {
> +            reg = <0x38 4>;
> +        };
> +
> +        tempmon_temp_grade: temp-grade@20 {
> +            reg = <0x20 4>;
> +        };
> +    };
> +
> +...
> -- 
> 2.7.4
> 
