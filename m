Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD127C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 21:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9ADA206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 21:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578949428;
	bh=HGYYgpOTg+9FgZ6pYyCmgYJxIzU8UhftsPUKpqFAfw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=04be3MZFcnHJrrGOkPUv3rEDabZB2FOZhOYPr1SGcbEb2f5KUUCN/krYqbT+ooAMZ
	 9Iv3HeeMuUCYmxlNDr2nxPnAQXLyH643Fcphjiu9+1WDIrO/UVT3fTQQ7VSavmpNu9
	 VDsJRtNhv/iNptjw9GUN/+ZdGKQhcl8EU2KORI5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgAMVDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 16:03:47 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44829 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgAMVDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 16:03:47 -0500
Received: by mail-ot1-f65.google.com with SMTP id h9so10321398otj.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 13:03:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zoMuCqrtbq7pL6Vxs6+VLfL47ToDJhTtq6v+uJlisK8=;
        b=MDXsXP2dOiEwxKxRCkc4rJ2ZUPg3uhhGJetqMrVWZQTKQRYldqSo994N/Q9cmy61dX
         FoqI+pbkUKWh+MjeDlf2bwHpqBWQ/g1W/WFggpMYjCKEKWpS1hLddhWxa1EgqvyXUHeO
         ikuC7oh7zxdOn9CIv5kivEwggoV5MS6b3LlO58aK/9DyxW05S63LgXtoadClRmY1vP6f
         sNewIAZBjN0X1QWxGQGXCD6f6KcKFHg+E37omGodBCoGHEKnTRFHusIHbXplWJ/zGgx5
         Rg60+HAIN1Z62eYXxcYizusE0Z3/g1aBk5TzIzU/XtNLSmtOveVs2ZopSW95lglV65Xm
         xzDg==
X-Gm-Message-State: APjAAAXrjhpHPXkQQaTeiEiYoVaWphxfioC3Z6Tma3J79GcqvoecvjQV
        ayDvszKfOlv2gdSw19fYCf5yXQ4=
X-Google-Smtp-Source: APXvYqzQsaN5d4vE9l0HiSZIu2Qy54RT6Au+lgGxtBCUv97QtVvaau8O+vJUuIGZ1kce2Yfq0Qotaw==
X-Received: by 2002:a9d:6196:: with SMTP id g22mr14962832otk.204.1578949426210;
        Mon, 13 Jan 2020 13:03:46 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e17sm4537646otq.58.2020.01.13.13.03.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 13:03:45 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220b00
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 15:03:44 -0600
Date:   Mon, 13 Jan 2020 15:03:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     maz@kernel.org, jason@lakedaemon.net, tglx@linutronix.de,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        fugang.duan@nxp.com
Subject: Re: [PATCH V4 RESEND 1/2] dt-bindings/irq: add binding for NXP
 INTMUX interrupt multiplexer
Message-ID: <20200113210344.GA4615@bogus>
References: <1578899321-1365-1-git-send-email-qiangqing.zhang@nxp.com>
 <1578899321-1365-2-git-send-email-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578899321-1365-2-git-send-email-qiangqing.zhang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 03:08:40PM +0800, Joakim Zhang wrote:
> This patch adds the DT bindings for the NXP INTMUX interrupt multiplexer
> for i.MX8 family SoCs.
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  .../interrupt-controller/fsl,intmux.yaml      | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml

Please run 'make dt_binding_check' and fix the errors:

Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml:  
while scanning for the next token found character that cannot start any token 
  in "<unicode string>", line 60, column 1

> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml
> new file mode 100644
> index 000000000000..4dba532fe0bd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/fsl,intmux.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale INTMUX interrupt multiplexer
> +
> +maintainers:
> +  - Marc Zyngier <maz@kernel.org>
> +
> +properties:
> +  compatible:
> +    items:
> +      const: fsl,imx-intmux
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 8
> +    description: |
> +      Should contain the parent interrupt lines (up to 8) used to multiplex
> +      the input interrupts.
> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 2
> +
> +  clocks:
> +    maxItems: 1
> +    description: ipg clock.
> +
> +  clock-names:
> +    items:
> +      const: ipg
> +
> +  fsl,intmux_chans:

Don't use '_' in property names.

Is this any different from the length of 'interrupts' which you can 
count?

> +    maxItems: 1
> +    description: |
> +      The number of channels used for interrupt source. The Maximum value is 8.
> +      If this property is not set in DT then driver uses 1 channel by default.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +  - clocks
> +  - clock-name
> +  - fsl,intmux_chans
> +
> +additionalProperties: false
> +
> +Example:
> +
> +	intmux@37400000 {

interrupt-controller@...

> +		compatible = "fsl,imx-intmux";
> +		reg = <0x37400000 0x1000>;
> +		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		clocks = <&clk IMX8QM_CM40_IPG_CLK>;
> +		clock-names = "ipg";
> +		fsl,intmux_chans = <8>;
> +	};
> +
> -- 
> 2.17.1
> 
