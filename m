Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EF3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E39A207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nhSXSxrx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgERNBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 09:01:19 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35644 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgERNBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:01:18 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04ID1HMP084606;
        Mon, 18 May 2020 08:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589806877;
        bh=vRoVFmRyvr9jZQQVVsgz4H8H3PnUws6cclIyZp3kNP0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nhSXSxrxFCJU2j5IQ/YEHkK+lFFeFQpGsy/rZ6b04T8dzkgZFcJlYQprnwgaZ6C/J
         zLjiwtJoYyz2N6drm8yelUbxiL6XDEfX1ANcIsJdhHRU8fjCYqBdG2xeTN7eI1DCre
         BdODUO/V4pE9ckKfLbDyv0zVTOmaF5IZtnJv4ysg=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04ID1Hno054102
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 May 2020 08:01:17 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 18
 May 2020 08:01:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 18 May 2020 08:01:16 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04ID1DGC043116;
        Mon, 18 May 2020 08:01:14 -0500
Subject: Re: [PATCH v3 2/7] dt-bindings: mdf: ti,j721e-syscon.yaml: Add J721e
 system controller
To:     <t-kristo@ti.com>, <robh@kernel.org>
CC:     <kishon@ti.com>, <nm@ti.com>, <nsekhar@ti.com>, <vigneshr@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200508082937.14171-1-rogerq@ti.com>
 <20200508082937.14171-3-rogerq@ti.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <caa2652d-28c6-1069-cd9d-5079ad89112c@ti.com>
Date:   Mon, 18 May 2020 16:01:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508082937.14171-3-rogerq@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 08/05/2020 11:29, Roger Quadros wrote:
> Add DT binding schema for J721e system controller.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

If this can get your Ack it would be great. Thanks!

cheers,
-roger

> ---
>   .../bindings/mfd/ti,j721e-syscon.yaml         | 69 +++++++++++++++++++
>   1 file changed, 69 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/mfd/ti,j721e-syscon.yaml
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
> +
> +properties:
> +  compatible:
> +    anyOf:
> +      - items:
> +        - enum:
> +          - ti,j721e-system-controller
> +
> +        - const: syscon
> +
> +      - contains:
> +          const: syscon
> +        additionalItems: true
> +
> +# Optional children
> +
> +  "^serdes-ln-ctrl@[0-9a-f]+$":
> +    type: object
> +    description: |
> +      This is the SERDES lane control mux. It should follow the bindings
> +      specified in
> +      Documentation/devicetree/bindings/mux/reg-mux.txt
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
> +
> +        serdes_ln_ctrl: serdes-ln-ctrl@4080 {
> +            compatible = "mmio-mux";
> +            reg = <0x00004080 0x50>;
> +        };
> +    };
> +...
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
