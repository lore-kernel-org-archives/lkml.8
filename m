Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4CEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 10:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02E4B20675
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 10:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UFfEB4pO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgHLKLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 06:11:18 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:51574 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgHLKLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 06:11:15 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07CABBlo081432;
        Wed, 12 Aug 2020 05:11:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1597227071;
        bh=RYPEYFQZ1QFXT5zzo/sh99PaE9LQd6lVR0rqcndrkzo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=UFfEB4pOlJDSwwYkIUgKFs10D0b4xWDTu+q9HsqeLqfAubRUdkhhNRbCfU3k1LEn1
         PfdYZcbVSUpKaRsHBZShqxjux3yZUsWpcmEwBLN2oL6qFAAoRQ70yjsqKXe9F3Je9v
         IMRjCJ3MkBFt+QtOp2QDb0uWrJZJ8Yj+vsHDIPrI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07CABBsP021642
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Aug 2020 05:11:11 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 12
 Aug 2020 05:11:11 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 12 Aug 2020 05:11:11 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07CAB6pr119158;
        Wed, 12 Aug 2020 05:11:07 -0500
Subject: Re: [PATCH v1 7/7] dt-bindings: phy: cadence-torrent: Update Torrent
 PHY bindings for generic use
To:     Swapnil Jakhade <sjakhade@cadence.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <yamonkar@cadence.com>,
        <tomi.valkeinen@ti.com>, <jsarha@ti.com>, <nsekhar@ti.com>
References: <1596795165-13341-1-git-send-email-sjakhade@cadence.com>
 <1596795165-13341-8-git-send-email-sjakhade@cadence.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <d7cfd890-2540-7d9e-72a9-8f2011b7b0ff@ti.com>
Date:   Wed, 12 Aug 2020 15:41:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1596795165-13341-8-git-send-email-sjakhade@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Swapnil,

On 8/7/2020 3:42 PM, Swapnil Jakhade wrote:
> Torrent PHY can be used in different multi-link multi-protocol
> configurations including protocols other than DisplayPort also,
> such as PCIe, USB, SGMII, QSGMII etc. Update the bindings to have
> support for these configurations.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> ---
>  .../bindings/phy/phy-cadence-torrent.yaml     | 76 ++++++++++++++-----
>  1 file changed, 58 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> index a7ee19d27c19..b2275712363d 100644
> --- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> @@ -4,11 +4,13 @@
>  $id: "http://devicetree.org/schemas/phy/phy-cadence-torrent.yaml#"
>  $schema: "http://devicetree.org/meta-schemas/core.yaml#"
>  
> -title: Cadence Torrent SD0801 PHY binding for DisplayPort
> +title: Cadence Torrent SD0801 PHY binding
>  
>  description:
>    This binding describes the Cadence SD0801 PHY (also known as Torrent PHY)
> -  hardware included with the Cadence MHDP DisplayPort controller.
> +  hardware included with the Cadence MHDP DisplayPort controller. Torrent
> +  PHY also supports multilink multiprotocol combinations including protocols
> +  such as PCIe, USB, SGMII, QSGMII etc.
>  
>  maintainers:
>    - Swapnil Jakhade <sjakhade@cadence.com>
> @@ -49,13 +51,14 @@ properties:
>        - const: dptx_phy
>  
>    resets:
> -    maxItems: 1
> -    description:
> -      Torrent PHY reset.
> -      See Documentation/devicetree/bindings/reset/reset.txt
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - description: Torrent PHY reset.
> +      - description: Torrent APB reset. This is optional.
>  
>  patternProperties:
> -  '^phy@[0-7]+$':
> +  '^link@[0-7]+$':

Wouldn't this break older device tree binding? Or are there no upstream DT
nodes with phy sub-node?

Thanks
Kishon

>      type: object
>      description:
>        Each group of PHY lanes with a single master lane should be represented as a sub-node.
> @@ -78,13 +81,13 @@ patternProperties:
>            Specifies the type of PHY for which the group of PHY lanes is used.
>            Refer include/dt-bindings/phy/phy.h. Constants from the header should be used.
>          $ref: /schemas/types.yaml#/definitions/uint32
> -        enum: [1, 2, 3, 4, 5, 6]
> +        enum: [1, 2, 3, 4, 5, 6, 7, 8, 9]
>  
>        cdns,num-lanes:
>          description:
> -          Number of DisplayPort lanes.
> +          Number of lanes.
>          $ref: /schemas/types.yaml#/definitions/uint32
> -        enum: [1, 2, 4]
> +        enum: [1, 2, 3, 4]
>          default: 4
>  
>        cdns,ssc-mode:
> @@ -108,6 +111,7 @@ patternProperties:
>        - resets
>        - "#phy-cells"
>        - cdns,phy-type
> +      - cdns,num-lanes
>  
>      additionalProperties: false
>  
> @@ -141,15 +145,51 @@ examples:
>              clock-names = "refclk";
>              #address-cells = <1>;
>              #size-cells = <0>;
> -            phy@0 {
> -                      reg = <0>;
> -                      resets = <&phyrst 1>, <&phyrst 2>,
> -                               <&phyrst 3>, <&phyrst 4>;
> -                      #phy-cells = <0>;
> -                      cdns,phy-type = <PHY_TYPE_DP>;
> -                      cdns,num-lanes = <4>;
> -                      cdns,max-bit-rate = <8100>;
> +            link@0 {
> +                reg = <0>;
> +                resets = <&phyrst 1>, <&phyrst 2>,
> +                         <&phyrst 3>, <&phyrst 4>;
> +                #phy-cells = <0>;
> +                cdns,phy-type = <PHY_TYPE_DP>;
> +                cdns,num-lanes = <4>;
> +                cdns,max-bit-rate = <8100>;
> +            };
> +        };
> +    };
> +  - |
> +    #include <dt-bindings/phy/phy.h>
> +    #include <dt-bindings/phy/phy-cadence-torrent.h>
> +
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        torrent-phy@f0fb500000 {
> +            compatible = "cdns,torrent-phy";
> +            reg = <0xf0 0xfb500000 0x0 0x00100000>;
> +            reg-names = "torrent_phy";
> +            resets = <&phyrst 0>, <&phyrst 1>;
> +            clocks = <&ref_clk>;
> +            clock-names = "refclk";
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            link@0 {
> +                reg = <0>;
> +                resets = <&phyrst 2>, <&phyrst 3>;
> +                #phy-cells = <0>;
> +                cdns,phy-type = <PHY_TYPE_PCIE>;
> +                cdns,num-lanes = <2>;
> +                cdns,ssc-mode = <TORRENT_SERDES_NO_SSC>;
>              };
> +
> +            link@2 {
> +                reg = <2>;
> +                resets = <&phyrst 4>;
> +                #phy-cells = <0>;
> +                cdns,phy-type = <PHY_TYPE_SGMII>;
> +                cdns,num-lanes = <1>;
> +                cdns,ssc-mode = <TORRENT_SERDES_NO_SSC>;
> +           };
>          };
>      };
>  ...
> 
