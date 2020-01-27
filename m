Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1016BC33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 16:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09EF206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 16:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580143359;
	bh=DY8WFoZA7MSE6nKl9tDtfP3EGUiWhKiGOAxwLOR8mpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QHyf9KyWk5cx4YpMFOiFEcabxZ3cOpYDQ114Df8x8sEddCE8vBpeVW/nViEFGWthZ
	 yX2soUy5L/6ju5YVarKLTB7puyybJQkcQSl7qAZjitowZYOmfmy4lWSN7HLYBGBQ4n
	 m/82oBBZRWM9/Ru2KRiXvsRtcckv890qvwrbuE54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgA0Qmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 11:42:39 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34829 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgA0Qmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 11:42:38 -0500
Received: by mail-ot1-f68.google.com with SMTP id r16so9004098otd.2;
        Mon, 27 Jan 2020 08:42:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mjwje25YGXfPaqp/tzkaEu5Nx6YRWwHej2DPtGS41lw=;
        b=BTI7TnRHpVgnbFkOg2oO3ltT9pqavXgMMMR0wsLVD/KmgZEjmCe7KGABrTRx8A6pus
         3bBDaAjTYtYr2ccvUnxEc2KaCeUycwgOePVVad+cU4I6JBUyIcO/dcQ3hhMa9vdj8VJr
         tn4JDgp1oLdMNf8GdrgGIBlfAYBLostQJiLZWBwdkHMUrNEJgP/1sGPZF1U+s2LIhOgX
         2lVZ5QrVbo6Gm2lYvMk4TX0mZw6Wpi12Jgm5FDkiJj97r6AVAPWZuPsu+YgH9Fu/+4Rt
         BWXLOur3EuyAU6+wenBW48fKLefWLZwcYBMrrP0jf8uRW4rGy3BDIHaOcdzSPEHaGQul
         eZ6g==
X-Gm-Message-State: APjAAAWbU4UCuJ0RvmPKgB/cOFRHFIoOAbOjZlBEtAPspiG4xT6EZ0tK
        H6oXtll5T2Mk2fXAq2108Q==
X-Google-Smtp-Source: APXvYqxGZhO7r8DiGp3X+Vn9HS4tyNWXgafm1cLU/PZXPm9i5tFCHq4dyh74QUhHWIcE2n8bDhZqOQ==
X-Received: by 2002:a9d:6e98:: with SMTP id a24mr5421375otr.53.1580143357057;
        Mon, 27 Jan 2020 08:42:37 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 5sm3598718otr.13.2020.01.27.08.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 08:42:36 -0800 (PST)
Received: (nullmailer pid 27943 invoked by uid 1000);
        Mon, 27 Jan 2020 16:42:35 -0000
Date:   Mon, 27 Jan 2020 10:42:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yuti Amonkar <yamonkar@cadence.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, mark.rutland@arm.com, maxime@cerno.tech,
        jsarha@ti.com, tomi.valkeinen@ti.com, praneeth@ti.com,
        mparab@cadence.com, sjakhade@cadence.com
Subject: Re: [PATCH v3 13/14] dt-bindings: phy: phy-cadence-torrent: Add
 subnode bindings.
Message-ID: <20200127164235.GA7662@bogus>
References: <1579689918-7181-1-git-send-email-yamonkar@cadence.com>
 <1579689918-7181-14-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579689918-7181-14-git-send-email-yamonkar@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 11:45:17AM +0100, Yuti Amonkar wrote:
> From: Swapnil Jakhade <sjakhade@cadence.com>
> 
> Add sub-node bindings for each group of PHY lanes based on PHY
> type. Only PHY_TYPE_DP is supported currently. Each sub-node

What the driver supports is not relevant to the binding. Define all 
modes.

> includes properties such as master lane number, link reset, phy
> type, number of lanes etc.

Given the conversion and this have no compatibility, just make the 
commits delete the old binding and add this new binding. I'd rather not 
have reviewed what just gets deleted here.

> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> ---
>  .../bindings/phy/phy-cadence-torrent.yaml          | 90 ++++++++++++++++++----
>  1 file changed, 73 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> index dbb8aa5..eb21615 100644
> --- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> @@ -19,6 +19,12 @@ properties:
>        - cdns,torrent-phy
>        - ti,j721e-serdes-10g
>  
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
>    clocks:
>      maxItems: 1
>      description:
> @@ -41,44 +47,94 @@ properties:
>        - const: torrent_phy
>        - const: dptx_phy
>  
> -  "#phy-cells":
> -    const: 0
> +  resets:
> +    description:
> +      Must contain an entry for each in reset-names.
> +      See Documentation/devicetree/bindings/reset/reset.txt

How many reset entries? Needs a 'maxItems: 1' or an 'items' list if more 
than 1.

>  
> -  num_lanes:
> +  reset-names:
>      description:
> -      Number of DisplayPort lanes.
> -    allOf:
> -      - $ref: /schemas/types.yaml#/definitions/uint32
> -      - enum: [1, 2, 4]
> +      Must be "torrent_reset". It controls the reset to the

Should be a schema, not freeform text. However, not really a useful name 
as there's only 1, so I'd just remove 'reset-names'.

> +      torrent PHY.
>  
> -  max_bit_rate:
> +patternProperties:
> +  '^torrent-phy@[0-7]+$':
> +    type: object
>      description:
> -      Maximum DisplayPort link bit rate to use, in Mbps
> -    allOf:
> -      - $ref: /schemas/types.yaml#/definitions/uint32
> -      - enum: [2160, 2430, 2700, 3240, 4320, 5400, 8100]
> +      Each group of PHY lanes with a single master lane should be represented as a sub-node.
> +    properties:
> +      reg:
> +        description:
> +          The master lane number. This is the lowest numbered lane in the lane group.

Why not make it the list of lane numbers. Then you don't need num-lanes.

> +
> +      resets:
> +        description:
> +          Contains list of resets to get all the link lanes out of reset.

Needs a schema for how many? 1 per lane?

> +
> +      "#phy-cells":
> +        description:
> +          Generic PHY binding.

Not a useful description. Remove.

> +        const: 0
> +
> +      cdns,phy-type:
> +        description:
> +          Should be PHY_TYPE_DP.

Sounds like a constraint.

> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +      cdns,num-lanes:
> +        description:
> +          Number of DisplayPort lanes.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - enum: [1, 2, 4]
> +
> +      cdns,max-bit-rate:
> +        description:
> +          Maximum DisplayPort link bit rate to use, in Mbps
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - enum: [2160, 2430, 2700, 3240, 4320, 5400, 8100]
> +
> +    required:
> +      - reg
> +      - resets
> +      - "#phy-cells"
> +      - cdns,phy-type

Add (for the child nodes):

       addtionalProperties: false

>  
>  required:
>    - compatible
> +  - "#address-cells"
> +  - "#size-cells"
>    - clocks
>    - clock-names
>    - reg
>    - reg-names
> -  - "#phy-cells"
> +  - resets
> +  - reset-names
>  
>  additionalProperties: false
>  
>  examples:
>    - |
> -    dp_phy: phy@f0fb500000 {
> +    #include <dt-bindings/phy/phy.h>
> +    torrent_phy: phy@f0fb500000 {
>            compatible = "cdns,torrent-phy";
>            reg = <0xf0 0xfb500000 0x0 0x00100000>,
>                  <0xf0 0xfb030a00 0x0 0x00000040>;
>            reg-names = "torrent_phy", "dptx_phy";
> -          num_lanes = <4>;
> -          max_bit_rate = <8100>;
> -          #phy-cells = <0>;
> +          resets = <&phyrst 0>;
> +          reset-names = "torrent_reset";
>            clocks = <&ref_clk>;
>            clock-names = "refclk";
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +          torrent_phy_dp: torrent-phy@0 {

Just 'phy@...'

> +                    reg = <0>;
> +                    resets = <&phyrst 1>;
> +                    #phy-cells = <0>;
> +                    cdns,phy-type = <PHY_TYPE_DP>;
> +                    cdns,num-lanes = <4>;
> +                    cdns,max-bit-rate = <8100>;
> +          };
>      };
>  ...
> -- 
> 2.4.5
> 
