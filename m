Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06516C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 20:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBAE221D46
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 20:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599683806;
	bh=OF5pupg8O1K2TxpzSEhDaBCf68fjVHSF+639uJzL9Yk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yVj7piLqJgWSraeczo1suqTxB1c1RRv6YQsqA4MJiH5xazn3lnXIUEOGFyuTUCP3K
	 i7QyCX+05PH31a1u0K7R7tECB7TBhhL+BzjTB3tjjYdyqgzlWKFE3wCrv2f0Bf8/nZ
	 4E9YfwHD+WDUtq1vByg8qLZpLOLbBk+BfaTGsDYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbgIIUgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 16:36:46 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:38974 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgIIUgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 16:36:45 -0400
Received: by mail-il1-f194.google.com with SMTP id u20so3625743ilk.6;
        Wed, 09 Sep 2020 13:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tD9tolo1brm9/WWkIMmC/3imxbO/TchAZXbaapTa7wQ=;
        b=PJLctGEqmvvjLeteZ7+igVB//7qxAfLtZNqrg6FjLBippBwPbljGA+lv0ooS8iirkw
         oNv4QUYMZFoTRcNAWuBqwJRjbFBMa2jAk9sS99pYN7Cbv6OpE57WWH76K5IBDMCdv+xt
         7rLsDjkLciTtAUzJztysjWGseHYq7I0/EVCSMybj9v6gW7+PKOSV7yuWx4zLMhx2Gmn/
         nIMzLXWlhpGKBf+MFlAwI/LKcWyCXrylegy8nLkPvzP4Xqk5zv7SL9q9ykw6NmjGMQ1N
         wFIapsHgZWXTHWSSLwBFN7lChfNk9A1QXf3RhntGIahIC6LoikQ5nFDEt5N6u4IFjVab
         OLKg==
X-Gm-Message-State: AOAM531ApnOAyQ/TTxmouIu/CNwJ7vU4Zjlnc8drtg3AnYrbBEPeFmAk
        j+w0KC/v4BV957XIj/+tmA==
X-Google-Smtp-Source: ABdhPJwboNKxydBskQnpH/Yew3oH2kR5BqC35FLjuY/D4iiOIUDsG3kaodAVucTb14h0+QQl4cjtAw==
X-Received: by 2002:a05:6e02:f06:: with SMTP id x6mr4646832ilj.222.1599683803168;
        Wed, 09 Sep 2020 13:36:43 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id p12sm1229709iom.47.2020.09.09.13.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 13:36:42 -0700 (PDT)
Received: (nullmailer pid 3035275 invoked by uid 1000);
        Wed, 09 Sep 2020 20:36:31 -0000
Date:   Wed, 9 Sep 2020 14:36:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     vkoul@kernel.org, kishon@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mparab@cadence.com,
        yamonkar@cadence.com, tomi.valkeinen@ti.com, jsarha@ti.com,
        nsekhar@ti.com
Subject: Re: [PATCH v2 7/7] dt-bindings: phy: cadence-torrent: Update Torrent
 PHY bindings for generic use
Message-ID: <20200909203631.GA3026331@bogus>
References: <1598534932-18693-1-git-send-email-sjakhade@cadence.com>
 <1598534932-18693-8-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598534932-18693-8-git-send-email-sjakhade@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 03:28:52PM +0200, Swapnil Jakhade wrote:
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
> index a7ee19d27c19..1b9e1231f8d8 100644
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

No, nodes with #phy-cell should be named 'phy'.

Also, the '+' is wrong unless unit-addresses are in octal.

>      type: object
>      description:
>        Each group of PHY lanes with a single master lane should be represented as a sub-node.
> @@ -78,13 +81,13 @@ patternProperties:
>            Specifies the type of PHY for which the group of PHY lanes is used.
>            Refer include/dt-bindings/phy/phy.h. Constants from the header should be used.
>          $ref: /schemas/types.yaml#/definitions/uint32
> -        enum: [1, 2, 3, 4, 5, 6]
> +        enum: [1, 2, 3, 4, 5, 6, 7, 8, 9]

Probably better to change this to:

minimum: 1
maximum: 9

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
> @@ -141,14 +145,50 @@ examples:
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
> +            };
> +
> +            link@2 {
> +                reg = <2>;
> +                resets = <&phyrst 4>;
> +                #phy-cells = <0>;
> +                cdns,phy-type = <PHY_TYPE_SGMII>;
> +                cdns,num-lanes = <1>;
> +                cdns,ssc-mode = <TORRENT_SERDES_NO_SSC>;
>              };
>          };
>      };
> -- 
> 2.26.1
> 
