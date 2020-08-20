Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4891AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 200D3208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ipCf1MHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbgHTNqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:46:23 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41406 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730626AbgHTNlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 09:41:05 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07KDevGI046097;
        Thu, 20 Aug 2020 08:40:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1597930857;
        bh=mCqsC8I7TNN41Xg66/1Y1+1+wh+JFrJTfp3db0LJpjs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ipCf1MHpGpcSVa5KXgsYhmukQmfffwOT9EJEJCrit4p1UPb5E5bNY2pmK7gKsY42g
         o9j17wR8VAIAR4LUSxTt8rnHDzd8ptD/T1D+LnRy5AhP/WH4sqwwyr5ReJ8uIsRwxs
         QxoXGlc+pbw6wZ9Wo6R8QlLkZPjPDnHMViPPFN0s=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07KDevoZ068958
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Aug 2020 08:40:57 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 20
 Aug 2020 08:40:57 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 20 Aug 2020 08:40:57 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07KDetFR019331;
        Thu, 20 Aug 2020 08:40:56 -0500
Subject: Re: [PATCH v4 1/3] dt-binding: phy: convert ti,omap-usb2 to YAML
To:     <kishon@ti.com>
CC:     <robh+dt@kernel.org>, <nsekhar@ti.com>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20200716082252.21266-1-rogerq@ti.com>
 <20200716082252.21266-2-rogerq@ti.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <4032ac86-5f2e-98ca-180b-73a483bae6b6@ti.com>
Date:   Thu, 20 Aug 2020 16:40:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716082252.21266-2-rogerq@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kishon,

On 16/07/2020 11:22, Roger Quadros wrote:
> Move ti,omap-usb2 to its own YAML schema.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Can you please pick just this one patch from this series for -next? Thanks.

cheers,
-roger

> ---
>   .../devicetree/bindings/phy/ti,omap-usb2.yaml | 72 +++++++++++++++++++
>   .../devicetree/bindings/phy/ti-phy.txt        | 37 ----------
>   2 files changed, 72 insertions(+), 37 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml b/Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml
> new file mode 100644
> index 000000000000..a05110351814
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/ti,omap-usb2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: OMAP USB2 PHY
> +
> +maintainers:
> + - Kishon Vijay Abraham I <kishon@ti.com>
> + - Roger Quadros <rogerq@ti.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +        - enum:
> +          - ti,dra7x-usb2
> +          - ti,dra7x-usb2-phy2
> +          - ti,am654-usb2
> +        - enum:
> +          - ti,omap-usb2
> +      - items:
> +        - const: ti,omap-usb2
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  clocks:
> +    minItems: 1
> +    items:
> +      - description: wakeup clock
> +      - description: reference clock
> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: wkupclk
> +      - const: refclk
> +
> +  syscon-phy-power:
> +    $ref: /schemas/types.yaml#definitions/phandle-array
> +    description:
> +      phandle/offset pair. Phandle to the system control module and
> +      register offset to power on/off the PHY.
> +
> +  ctrl-module:
> +    $ref: /schemas/types.yaml#definitions/phandle
> +    description:
> +      (deprecated) phandle of the control module used by PHY driver
> +      to power on the PHY. Use syscon-phy-power instead.
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#phy-cells"
> +  - clocks
> +  - clock-names
> +
> +examples:
> +  - |
> +    usb0_phy: phy@4100000 {
> +      compatible = "ti,am654-usb2", "ti,omap-usb2";
> +      reg = <0x4100000 0x54>;
> +      syscon-phy-power = <&scm_conf 0x4000>;
> +      clocks = <&k3_clks 151 0>, <&k3_clks 151 1>;
> +      clock-names = "wkupclk", "refclk";
> +      #phy-cells = <0>;
> +    };
> diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
> index 8f93c3b694a7..60c9d0ac75e6 100644
> --- a/Documentation/devicetree/bindings/phy/ti-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
> @@ -27,43 +27,6 @@ omap_control_usb: omap-control-usb@4a002300 {
>           reg-names = "otghs_control";
>   };
>   
> -OMAP USB2 PHY
> -
> -Required properties:
> - - compatible: Should be "ti,omap-usb2"
> -	       Should be "ti,dra7x-usb2" for the 1st instance of USB2 PHY on
> -	       DRA7x
> -	       Should be "ti,dra7x-usb2-phy2" for the 2nd instance of USB2 PHY
> -	       in DRA7x
> -	       Should be "ti,am654-usb2" for the USB2 PHYs on AM654.
> - - reg : Address and length of the register set for the device.
> - - #phy-cells: determine the number of cells that should be given in the
> -   phandle while referencing this phy.
> - - clocks: a list of phandles and clock-specifier pairs, one for each entry in
> -   clock-names.
> - - clock-names: should include:
> -   * "wkupclk" - wakeup clock.
> -   * "refclk" - reference clock (optional).
> -
> -Deprecated properties:
> - - ctrl-module : phandle of the control module used by PHY driver to power on
> -   the PHY.
> -
> -Recommended properies:
> -- syscon-phy-power : phandle/offset pair. Phandle to the system control
> -  module and the register offset to power on/off the PHY.
> -
> -This is usually a subnode of ocp2scp to which it is connected.
> -
> -usb2phy@4a0ad080 {
> -	compatible = "ti,omap-usb2";
> -	reg = <0x4a0ad080 0x58>;
> -	ctrl-module = <&omap_control_usb>;
> -	#phy-cells = <0>;
> -	clocks = <&usb_phy_cm_clk32k>, <&usb_otg_ss_refclk960m>;
> -	clock-names = "wkupclk", "refclk";
> -};
> -
>   TI PIPE3 PHY
>   
>   Required properties:
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
