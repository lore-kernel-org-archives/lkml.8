Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89650C54E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 624E1206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589295344;
	bh=10Wbibz5MtplL9oNw/JJCifW7QqDUGxQxv2LMOfQXNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zkKHblIjJiliLHhW3QpJlbC2nXBE+68CQqKJjRyAcvC0fLXuxGs93AmCGSYvsqjvE
	 FDTQIyK3q/38N4zu9KAb3rSrEh35MNrKO+N5Bm3ECtSA9WZLsfIbAEtTNhFxQukhCb
	 TvJ7FY4qvKDQ+agHTe5B+YMZQ7tSig8Ke9h059Z8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbgELOzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:55:43 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43487 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbgELOzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:55:43 -0400
Received: by mail-oi1-f195.google.com with SMTP id i22so1854132oik.10;
        Tue, 12 May 2020 07:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fQ/KirqKw6BO2UGDgRcS3zleuiv+6S0ku0zLBHrcdQE=;
        b=B+WTLvJgFm4p2L6t1i5L9KUz3yO2X6IBwts1XOY58mRbFk7msGAjkoIQvARexAlxGL
         Jc1Rj7u2iBTgNnQbyECP/XrbwkRQNR8O2inCxwh61RH7hSr2/hbXN+yt5NVWL+JoUZfO
         tpc5qAIqs8KQUDLTVDQUbDWMihk24ZQRZMKk6uneRKtSQrYdeYP4Gooqztt7v1xTzubf
         JniJbjMy4IgXjGYG4O27/3mb2dUl0UxVsSzOLkBoiLYg3DFjXedHFkJBn87u1hjTt3KV
         4/SFA4WX19lumBg9U33/HdjTa3D0CEpHenoxoymPoMg4CGkYjS8kVDGOswOc6SPutEUr
         +fFQ==
X-Gm-Message-State: AGi0PuYWP4QQ8pCSePK+6NiCp/be2450kBUCq7epXh9psGGffRPYZ9Op
        5H1s9mT8SklswgQyjdCsrQ==
X-Google-Smtp-Source: APiQypKGFg5K792meOQtyk/OqmaGeRZs+OjkzVpOC5F4wC2KYFUclFMd7QTJb3TdXvy6aRGZ9Dv7iw==
X-Received: by 2002:aca:5513:: with SMTP id j19mr22756944oib.31.1589295342052;
        Tue, 12 May 2020 07:55:42 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c84sm5382655oig.37.2020.05.12.07.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 07:55:40 -0700 (PDT)
Received: (nullmailer pid 31636 invoked by uid 1000);
        Tue, 12 May 2020 14:55:39 -0000
Date:   Tue, 12 May 2020 09:55:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V4 2/5] dt-bindings: clock: Convert i.MX6SX clock to
 json-schema
Message-ID: <20200512145539.GA25671@bogus>
References: <1588207921-20604-1-git-send-email-Anson.Huang@nxp.com>
 <1588207921-20604-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588207921-20604-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 08:51:58AM +0800, Anson Huang wrote:
> Convert the i.MX6SX clock binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V3:
> 	- update license to be with (GPL-2.0-only OR BSD-2-Clause);
> 	- remove unnecessary minItem for interrupts;
> 	- remove label in example.
> ---
>  .../devicetree/bindings/clock/imx6sx-clock.txt     | 13 -----
>  .../devicetree/bindings/clock/imx6sx-clock.yaml    | 64 ++++++++++++++++++++++
>  2 files changed, 64 insertions(+), 13 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/imx6sx-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/imx6sx-clock.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx6sx-clock.txt b/Documentation/devicetree/bindings/clock/imx6sx-clock.txt
> deleted file mode 100644
> index 22362b9..0000000
> --- a/Documentation/devicetree/bindings/clock/imx6sx-clock.txt
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -* Clock bindings for Freescale i.MX6 SoloX
> -
> -Required properties:
> -- compatible: Should be "fsl,imx6sx-ccm"
> -- reg: Address and length of the register set
> -- #clock-cells: Should be <1>
> -- clocks: list of clock specifiers, must contain an entry for each required
> -  entry in clock-names
> -- clock-names: should include entries "ckil", "osc", "ipp_di0" and "ipp_di1"
> -
> -The clock consumer should specify the desired clock by having the clock
> -ID in its "clocks" phandle cell.  See include/dt-bindings/clock/imx6sx-clock.h
> -for the full list of i.MX6 SoloX clock IDs.
> diff --git a/Documentation/devicetree/bindings/clock/imx6sx-clock.yaml b/Documentation/devicetree/bindings/clock/imx6sx-clock.yaml
> new file mode 100644
> index 0000000..2c7f625
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/imx6sx-clock.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/imx6sx-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Clock bindings for Freescale i.MX6 SoloX
> +
> +maintainers:
> +  - Anson Huang <Anson.Huang@nxp.com>
> +
> +properties:
> +  compatible:
> +    const: fsl,imx6sx-ccm
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 2

Need to define what each one is:

interrupts:
  items:
    - description: ...
    - description: ...

And you should explain why this was added.

> +
> +  '#clock-cells':
> +    const: 1
> +
> +  clocks:
> +    items:
> +      - description: 32k osc
> +      - description: 24m osc
> +      - description: ipp_di0 clock input
> +      - description: ipp_di1 clock input
> +      - description: anaclk1 clock input
> +      - description: anaclk2 clock input
> +
> +  clock-names:
> +    items:
> +      - const: ckil
> +      - const: osc
> +      - const: ipp_di0
> +      - const: ipp_di1
> +      - const: anaclk1
> +      - const: anaclk2
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - '#clock-cells'
> +  - clocks
> +  - clock-names
> +
> +examples:
> +  # Clock Control Module node:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    clock-controller@20c4000 {
> +        compatible = "fsl,imx6sx-ccm";
> +        reg = <0x020c4000 0x4000>;
> +        interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
> +        #clock-cells = <1>;
> +        clocks = <&ckil>, <&osc>, <&ipp_di0>, <&ipp_di1>, <&anaclk1>, <&anaclk2>;
> +        clock-names = "ckil", "osc", "ipp_di0", "ipp_di1", "anaclk1", "anaclk2";
> +    };
> -- 
> 2.7.4
> 
