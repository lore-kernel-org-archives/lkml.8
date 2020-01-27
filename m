Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553FFC33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 16:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B92206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 16:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580142337;
	bh=evQNgGRkP2bhS+Ih9eqfBSFXi0ycJwx9Xl7siCJVyQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VbnntwDwIYe/hNBnB1/iSTemeAHD3O5dmqIsG/tjk9jgdEjbtOEm3khIiQlM1D8ca
	 oE6fWVvWkkaoAsNjbxuFjSGsImXSN7ww/z+xQl1m3K8JGTsBiu0QqgKjSqgVSUK4nz
	 6Iz8ExDbQIw5cnRiyLuC9AO+pYOculpmiHL1r90M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgA0QZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 11:25:36 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34954 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgA0QZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 11:25:35 -0500
Received: by mail-oi1-f194.google.com with SMTP id b18so3255020oie.2;
        Mon, 27 Jan 2020 08:25:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OJucG96FhGoPAsq3RuvwmFtMjR8zGUwV0tQ5FFG1jKc=;
        b=BGFdiG35FSOnzlYq+tJT5yEg8TfLaQW06+rVlAonYE03kjCcakpZx3ZrhkVOx25Mvh
         h0a/n7Q4Noib4nLg/tML4oGrGKbfwDoli6IUChb/bVObJ/S3vvnwiOJwNmXbSNCDedXH
         Vk21KTkTVVv1L0YblHwXL6Dup3qZZIur/wChZosIY0MFvtytiL+0FLn98GYgk+3Fw4rv
         ATx3yeW7nRV5ean675ASgKdDYZprEQ478oZ2tBJk4jxU697+Dg4du5PmmVzWsayDZCcG
         gxaphlTCx7SaiXrQX+9MWWjjkV5GXvs+yeb20Z641TwpLQPjCIobvJjbXCTIe+aPuS6F
         N2DQ==
X-Gm-Message-State: APjAAAXPcdNwizD7eN9cWax+qRpWf0Nz7/AKxoeIb1YLYuS6HexiciCB
        62Q4bgKTzvvglx+np3PMaw==
X-Google-Smtp-Source: APXvYqw6dy/abosD5vhi2iH+JS6Mc0uw4qRSNJcVSFxxqV870nhHwoqdtCZhMnH8PG0ugCojlXjS6g==
X-Received: by 2002:aca:4dd6:: with SMTP id a205mr7732517oib.43.1580142335070;
        Mon, 27 Jan 2020 08:25:35 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 15sm5719271otv.20.2020.01.27.08.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 08:25:34 -0800 (PST)
Received: (nullmailer pid 4529 invoked by uid 1000);
        Mon, 27 Jan 2020 16:25:33 -0000
Date:   Mon, 27 Jan 2020 10:25:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yuti Amonkar <yamonkar@cadence.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, mark.rutland@arm.com, maxime@cerno.tech,
        jsarha@ti.com, tomi.valkeinen@ti.com, praneeth@ti.com,
        mparab@cadence.com, sjakhade@cadence.com
Subject: Re: [PATCH v3 01/14] dt-bindings: phy: Convert Cadence MHDP PHY
 bindings to YAML.
Message-ID: <20200127162533.GA20343@bogus>
References: <1579689918-7181-1-git-send-email-yamonkar@cadence.com>
 <1579689918-7181-2-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579689918-7181-2-git-send-email-yamonkar@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 11:45:05AM +0100, Yuti Amonkar wrote:
> - Convert the MHDP PHY devicetree bindings to yaml schemas.
> - Rename DP PHY to have generic Torrent PHY nomrnclature.
> - Add Torrent PHY reference clock bindings.
> - Rename compatible string from "cdns,dp-phy" to "cdns,torrent-phy".
>   This will not affect ABI as the driver has never been functional,
>   and therefore do not exist in any active use case
> 
> Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
> ---
>  .../devicetree/bindings/phy/phy-cadence-dp.txt     | 30 --------
>  .../bindings/phy/phy-cadence-torrent.yaml          | 82 ++++++++++++++++++++++
>  2 files changed, 82 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml

> diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> new file mode 100644
> index 0000000..eb633d7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> @@ -0,0 +1,82 @@

Missing SPDX tag.

As Cadence is the only contributor to the old doc, please relicense to 
dual license:

(GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/phy-cadence-torrent.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Cadence Torrent SD0801 PHY binding for DisplayPort
> +
> +description:
> +  This binding describes the Cadence SD0801 PHY (also known as Torrent PHY)
> +  hardware included with the Cadence MHDP DisplayPort controller.
> +
> +maintainers:
> +  - Swapnil Jakhade <sjakhade@cadence.com>
> +  - Yuti Amonkar <yamonkar@cadence.com>
> +
> +properties:
> +  compatible:
> +    const: cdns,torrent-phy
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      PHY reference clock. Must contain an entry in clock-names.
> +
> +  clock-names:
> +    const: refclk
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - description: Offset of the Torrent PHY configuration registers.
> +      - description: Offset of the DPTX PHY configuration registers.
> +
> +  reg-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - const: torrent_phy
> +      - const: dptx_phy
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  num_lanes:

Given you don't care about compatibility, please make this 'num-lanes'.

> +    description:
> +      Number of DisplayPort lanes.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [1, 2, 4]

If optional, then define a default.

> +
> +  max_bit_rate:

And this 'max-bit-rate-mbps'.

> +    description:
> +      Maximum DisplayPort link bit rate to use, in Mbps
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [2160, 2430, 2700, 3240, 4320, 5400, 8100]

default?

> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - reg
> +  - reg-names
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dp_phy: phy@f0fb500000 {
> +          compatible = "cdns,torrent-phy";
> +          reg = <0xf0 0xfb500000 0x0 0x00100000>,
> +                <0xf0 0xfb030a00 0x0 0x00000040>;
> +          reg-names = "torrent_phy", "dptx_phy";
> +          num_lanes = <4>;
> +          max_bit_rate = <8100>;
> +          #phy-cells = <0>;
> +          clocks = <&ref_clk>;
> +          clock-names = "refclk";
> +    };
> +...
> -- 
> 2.4.5
> 
