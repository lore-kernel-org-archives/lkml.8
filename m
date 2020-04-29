Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD8FC83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 21:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7A0C20BED
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 21:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588195587;
	bh=F7uD432SGEUbxp+6xK1GCD9A4BQJFB+hqOVWdvvvl60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PfevZ4FTJfEi0H42pFlf4AVryHgMGNf96sszAQGYbBmjGPib/GVabrRbQNsXRP1UB
	 te743Tkx/kjBst2o1fEMogl/F8YCPP+A6QFHkVYVW+ZgyPpA3DVObuVyrZkvegnYlw
	 LoCXFOuMY3AC5auOlvHAHDGvzotH437JyGq+zbA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgD2V01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 17:26:27 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:33390 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgD2V00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 17:26:26 -0400
Received: by mail-oo1-f67.google.com with SMTP id b17so780192ooa.0;
        Wed, 29 Apr 2020 14:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jZdQqz//+UegbVE8A4Ss6PQqpaUbK0Xf8KqifQRUIYA=;
        b=arYRatlCEstABDNFzLh8VMvD9y1yX5+F3CdDBUfEOhpe8ZuaEq7GzZFDnYgb2oZaA2
         8aHH54B4ehd9Rg0ydb4ypfN2HfT2gvi5viMXbeNbWc9x9lwcRl25Mi9iKpwEBDRwt69I
         ChOI7C6SXy3IxE5mIJd6KxFEzGHgtW7OI9xAFgfX4FKZy1HXwKH0MU9dCKFK/2+GIAVh
         75QsVL1BA+WKzYexRz3Ou3v75D+sFXoCjEPXgZVo3S5EOKXMVRMKDFnCPfem6QsDwm5H
         fBkBzOZ/ihoPaPiGABHMM0i5immLlde6I4JE9fwat+XGWPFeyhLKG3Rw6E0wShlBasf7
         zh6g==
X-Gm-Message-State: AGi0PuYaITMRbtV76AQGeVZPy6SHt9lB9/lxS6SNqNrCjVN469CHcSzP
        bNAI6Ho8ggN6Iuru2vqMRQ==
X-Google-Smtp-Source: APiQypKwsnnuEjrK//ENA1olM+ndEcdtQnnyaYhWVWsNx0ix/MtVtneEX6PtoFrzg2X8/em70PIiow==
X-Received: by 2002:a4a:621d:: with SMTP id x29mr59980ooc.92.1588195585576;
        Wed, 29 Apr 2020 14:26:25 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k84sm695519oib.10.2020.04.29.14.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 14:26:24 -0700 (PDT)
Received: (nullmailer pid 26020 invoked by uid 1000);
        Wed, 29 Apr 2020 21:26:22 -0000
Date:   Wed, 29 Apr 2020 16:26:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V3 1/5] dt-bindings: clock: Convert i.MX6Q clock to
 json-schema
Message-ID: <20200429212622.GA23326@bogus>
References: <1587084091-5941-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587084091-5941-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 08:41:27AM +0800, Anson Huang wrote:
> Convert the i.MX6Q clock binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V2:
> 	- Force 'interrupts' minItem/maxItem to 2.

Not necessary. maxItems is sufficient.

> ---
>  .../devicetree/bindings/clock/imx6q-clock.txt      | 41 -------------
>  .../devicetree/bindings/clock/imx6q-clock.yaml     | 67 ++++++++++++++++++++++
>  2 files changed, 67 insertions(+), 41 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/imx6q-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.txt b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> deleted file mode 100644
> index 13d36d4..0000000
> --- a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -* Clock bindings for Freescale i.MX6 Quad
> -
> -Required properties:
> -- compatible: Should be "fsl,imx6q-ccm"
> -- reg: Address and length of the register set
> -- interrupts: Should contain CCM interrupt
> -- #clock-cells: Should be <1>
> -
> -Optional properties:
> -- fsl,pmic-stby-poweroff: Configure CCM to assert PMIC_STBY_REQ signal
> -  on power off.
> -  Use this property if the SoC should be powered off by external power
> -  management IC (PMIC) triggered via PMIC_STBY_REQ signal.
> -  Boards that are designed to initiate poweroff on PMIC_ON_REQ signal should
> -  be using "syscon-poweroff" driver instead.
> -- clocks: list of clock specifiers, must contain an entry for each entry
> -          in clock-names
> -- clock-names: valid names are "osc", "ckil", "ckih1", "anaclk1" and "anaclk2"
> -
> -The clock consumer should specify the desired clock by having the clock
> -ID in its "clocks" phandle cell.  See include/dt-bindings/clock/imx6qdl-clock.h
> -for the full list of i.MX6 Quad and DualLite clock IDs.
> -
> -Examples:
> -
> -#include <dt-bindings/clock/imx6qdl-clock.h>
> -
> -clks: ccm@20c4000 {
> -	compatible = "fsl,imx6q-ccm";
> -	reg = <0x020c4000 0x4000>;
> -	interrupts = <0 87 0x04 0 88 0x04>;
> -	#clock-cells = <1>;
> -};
> -
> -uart1: serial@2020000 {
> -	compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
> -	reg = <0x02020000 0x4000>;
> -	interrupts = <0 26 0x04>;
> -	clocks = <&clks IMX6QDL_CLK_UART_IPG>, <&clks IMX6QDL_CLK_UART_SERIAL>;
> -	clock-names = "ipg", "per";
> -};
> diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.yaml b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> new file mode 100644
> index 0000000..0daf789
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/imx6q-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Clock bindings for Freescale i.MX6 Quad
> +
> +maintainers:
> +  - Anson Huang <Anson.Huang@nxp.com>
> +
> +properties:
> +  compatible:
> +    const: fsl,imx6q-ccm
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 2
> +    maxItems: 2
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  clocks:
> +    items:
> +      - description: 24m osc
> +      - description: 32k osc
> +      - description: ckih1 clock input
> +      - description: anaclk1 clock input
> +      - description: anaclk2 clock input
> +
> +  clock-names:
> +    items:
> +      - const: osc
> +      - const: ckil
> +      - const: ckih1
> +      - const: anaclk1
> +      - const: anaclk2
> +
> +  fsl,pmic-stby-poweroff:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      Use this property if the SoC should be powered off by external power
> +      management IC (PMIC) triggered via PMIC_STBY_REQ signal.
> +      Boards that are designed to initiate poweroff on PMIC_ON_REQ signal should
> +      be using "syscon-poweroff" driver instead.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - '#clock-cells'
> +
> +examples:
> +  # Clock Control Module node:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    clks: clock-controller@20c4000 {

Drop the label.

> +        compatible = "fsl,imx6q-ccm";
> +        reg = <0x020c4000 0x4000>;
> +        interrupts = <0 87 IRQ_TYPE_LEVEL_HIGH>,
> +                     <0 88 IRQ_TYPE_LEVEL_HIGH>;
> +        #clock-cells = <1>;
> +    };
> -- 
> 2.7.4
> 
