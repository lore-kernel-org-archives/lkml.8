Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA037C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 23:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02172075B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 23:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579045275;
	bh=ZWR7/x+p3fsI9pv1YqqkYqgYUvTWq5NbUGhOupvrLE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WHlX7czZbNJsYI58Au1qn43Jw8/dydJMwyfvFREvJ+5yV3rS1i1dreUJjexpGBVY0
	 grrbInJvgIaIeviuiYRmA4RpK4+FG/4X76dV7PBpgM9O/5umUINufkVYzBBODrAM8c
	 1DlXATVHkEsLBbuwUZuVdNeQsChI4KJ5Oq0HPFIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgANXlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 18:41:14 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34052 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728874AbgANXlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 18:41:14 -0500
Received: by mail-oi1-f196.google.com with SMTP id l136so13681170oig.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 15:41:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D7XYS5juFiA+mkmXFcQrSAVcdM9zGgJea2kJ5TJPO6Q=;
        b=sKT7yVYXCHQtNTV50ygfplna81mvxqr/7R4u06j2wXyLYRdw4F2uk/2vgrCcWWgwrF
         KyM7DmywU9TzVcCHly/KF2M4eeMBc6xwI0o5kvvWLoSaIHOxem384HJkeAn9tvguOJFR
         Av8gR6i+zvG4wDSNPAl/awo0oRHmt3Ta26xZb6e/anUrXRHQtzYXAIAZi0ixF9zOkJ5Y
         qAgwamCWhg1Ul4FEA+MjdhuK9BVQgKiWVPy1gxCT/2JLnY1KToQfi3KJh/JB3MrkQFrV
         BFsg9xeYi/Hzd0lQyZXqT33tw1toPvVS7rNR7AKXJtbOynr9XoQIf409WkVYsOCY7WR7
         xNvw==
X-Gm-Message-State: APjAAAX9yzsurVnKTGBm55OCJydT84J13SDXoDiQCO4+g6N55unC2TO1
        GI+uBaW+dijwt4sb+hQP/6+oX4w=
X-Google-Smtp-Source: APXvYqzn0NkOuoLzh2WpsRo9iRbKS9v/aeZWFn3WEsoNOFX2IXtu8Ulnc6zA9iyXraL/Pd0CfrXu+A==
X-Received: by 2002:aca:4c4f:: with SMTP id z76mr19120604oia.21.1579045273081;
        Tue, 14 Jan 2020 15:41:13 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f4sm5075179oij.25.2020.01.14.15.41.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 15:41:11 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2209ae
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Tue, 14 Jan 2020 17:41:10 -0600
Date:   Tue, 14 Jan 2020 17:41:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [PATCH v2 3/3] dt-bindings: phy: qcom,qmp: Convert QMP phy
 bindings to yaml
Message-ID: <20200114234110.GA24051@bogus>
References: <1578486581-7540-1-git-send-email-sanm@codeaurora.org>
 <1578486581-7540-4-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578486581-7540-4-git-send-email-sanm@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 05:59:41PM +0530, Sandeep Maheswaram wrote:
> Convert QMP phy  bindings to DT schema format using json-schema.
> 
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> ---
>  .../devicetree/bindings/phy/qcom,qmp-phy.yaml      | 201 ++++++++++++++++++
>  .../devicetree/bindings/phy/qcom-qmp-phy.txt       | 227 ---------------------
>  2 files changed, 201 insertions(+), 227 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
>  delete mode 100644 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> new file mode 100644
> index 0000000..6eb00f5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> @@ -0,0 +1,201 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/qcom,qmp-phy.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm QMP PHY controller
> +
> +maintainers:
> +  - Manu Gautam <mgautam@codeaurora.org>
> +
> +description:
> +  QMP phy controller supports physical layer functionality for a number of
> +  controllers on Qualcomm chipsets, such as, PCIe, UFS, and USB.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,ipq8074-qmp-pcie-phy
> +      - qcom,ipq8074-qmp-pcie-phy
> +      - qcom,msm8996-qmp-pcie-phy
> +      - qcom,msm8996-qmp-usb3-phy
> +      - qcom,msm8998-qmp-usb3-phy
> +      - qcom,msm8998-qmp-ufs-phy
> +      - qcom,msm8998-qmp-pcie-phy
> +      - qcom,sc7180-qmp-usb3-phy
> +      - qcom,sdm845-qmp-usb3-phy
> +      - qcom,sdm845-qmp-usb3-uni-phy
> +      - qcom,sdm845-qmp-ufs-phy
> +      - qcom,sm8150-qmp-ufs-phy
> +
> +  reg:
> +    minItems: 1
> +    items:
> +      - description: Address and length of PHY's common serdes block.
> +      - description: Address and length of the DP_COM control block.
> +
> +  reg-names:
> +    items:
> +      - const: reg-base
> +      - const: dp_com
> +
> +  "#clock-cells":
> +     enum: [ 1, 2 ]
> +
> +  "#address-cells":
> +    enum: [ 1, 2 ]
> +
> +  "#size-cells":
> +    enum: [ 1, 2 ]
> +
> +  clocks:
> +    anyOf:

Should be oneOf rather than anyOf. Did oneOf not work?

> +      - items:
> +        - description: Phy aux clock.
> +        - description: Phy config clock.
> +        - description: 19.2 MHz ref clk.
> +        - description: Phy common block aux clock.

These should be indented 2 more spaces.

> +      - items:
> +        - description: Phy aux clock.
> +        - description: Phy config clock.
> +        - description: 19.2 MHz ref clk.

This can be dropped if you add 'minItems: 3' to the 1st case.

Then really, you should have an if/then to define which compatibles 
require 4 items.

> +      - items:
> +        - description: 19.2 MHz ref clk.
> +        - description: Phy reference aux clock.
> +      - items:
> +        - description: Phy reference aux clock.
> +
> +  clock-names:
> +    anyOf:

oneOf

> +      - items:
> +        - const: aux
> +        - const: cfg_ahb
> +        - const: ref
> +        - const: com_aux

Indent 2 more...

> +      - items:
> +        - const: aux
> +        - const: cfg_ahb
> +        - const: ref
> +      - items:
> +        - const: ref
> +        - const: ref_aux
> +      - items:
> +        - const: ref_aux
> +
> +  resets:
> +    anyOf:

oneOf

> +      - items:
> +        - description: reset of phy block.
> +        - description: phy common block reset.
> +        - description: ahb cfg block reset.
> +      - items:
> +        - description: reset of phy block.
> +        - description: phy common block reset.
> +      - items:
> +        - description: ahb cfg block reset.
> +        - description: PHY reset in the UFS controller.
> +      - items:
> +        - description: reset of phy block.
> +      - items:
> +        - description: PHY reset in the UFS controller.
> +
> +  reset-names:
> +    anyOf:
> +      - items:
> +        - const: phy
> +        - const: common
> +        - const: cfg
> +      - items:
> +        - const: phy
> +        - const: common
> +      - items:
> +        - const: ahb
> +        - const: ufsphy
> +      - items:
> +        - const: phy
> +      - items:
> +        - const: ufsphy
> +
> +  vdda-phy-supply:
> +    description:
> +        Phandle to a regulator supply to PHY core block.
> +
> +  vdda-pll-supply:
> +    description:
> +        Phandle to 1.8V regulator supply to PHY refclk pll block.
> +
> +  vddp-ref-clk-supply:
> +    description:
> +        Phandle to a regulator supply to any specific refclk
> +        pll block.

You need patternProperties with the child nodes defined.

> +
> +required:
> +  - compatible
> +  - reg
> +  - "#clock-cells"
> +  - "#address-cells"
> +  - "#size-cells"
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - vdda-phy-supply
> +  - vdda-pll-supply

Need a 'additionalProperties: false' here.

> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        anyOf:
> +          - items:
> +            - const: qcom,sdm845-qmp-usb3-phy
> +          - items:
> +            - const: qcom,sc7180-qmp-usb3-phy
> +then:
> +  required:
> +    - reg-names
> +
> +#Required nodes:
> +#Each device node of QMP phy is required to have as many child nodes as
> +#the number of lanes the PHY has.
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-sc7180.h>
> +    usb_1_qmpphy: phy-wrapper@88e9000 {
> +        compatible = "qcom,sc7180-qmp-usb3-phy";
> +        reg = <0 0x088e9000 0 0x18c>,
> +              <0 0x088e8000 0 0x38>;
> +        reg-names = "reg-base", "dp_com";
> +        #clock-cells = <1>;
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
> +                 <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
> +                 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
> +                 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
> +        clock-names = "aux", "cfg_ahb", "ref", "com_aux";
> +
> +        resets = <&gcc GCC_USB3_PHY_PRIM_BCR>;
> +        reset-names = "phy";
> +
> +        vdda-phy-supply = <&vreg_l3c_1p2>;
> +        vdda-pll-supply = <&vreg_l4a_0p8>;
> +
> +        usb_1_ssphy: phy@88e9200 {
> +            reg = <0 0x088e9200 0 0x128>,
> +                  <0 0x088e9400 0 0x200>,
> +                  <0 0x088e9c00 0 0x218>,
> +                  <0 0x088e9600 0 0x128>,
> +                  <0 0x088e9800 0 0x200>,
> +                  <0 0x088e9a00 0 0x18>;
> +            #clock-cells = <0>;
> +            #phy-cells = <0>;
> +            clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> +            clock-names = "pipe0";
> +            clock-output-names = "usb3_phy_pipe_clk_src";
> +        };
> +    };
