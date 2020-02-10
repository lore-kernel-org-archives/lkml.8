Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CC1C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 21:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058D12082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 21:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D/S3ih4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgBJVbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 16:31:36 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36600 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgBJVbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 16:31:35 -0500
Received: by mail-pf1-f193.google.com with SMTP id 185so4343612pfv.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 13:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=B8Y46yQxNOEffuymdtO7hMB+CO0Z+Y5wI8m+HEDcLu0=;
        b=D/S3ih4FUlxnwCjb4++UV+gkh9rbF7w4ohuxhC5YfRsEvBGbU59g3YST1JIOCQGYtY
         AWhH0RNIEtQ8tYx3zeL8FMhqM1jshXU4oMhT99eDck67cR0AZrx5/4waU151yC8TYzEB
         lswy5VGCd1OHy72SVT35N3B+8glmCX+b8Bynk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=B8Y46yQxNOEffuymdtO7hMB+CO0Z+Y5wI8m+HEDcLu0=;
        b=isxXJS/Oi6opwKI/TDnr28CIPUt75tDnZ1D6vcEADPiVskog+uA2zwKRdi6cP8B400
         v+fxI+6ht87txh///iFLGdypKI/3dcyvh4N4au7L5RF8A+iVQRamX82OxM3GR7czlbR/
         q3J/FQSXw5gIwS9LzArDS++1XqBHwP7YACJQfjtIlLMnE8YSvcb3dHPjyX1cITsUTeb4
         /AzQYiL16MoNtkxCN5UYbWRQ+wHkzemYNShn6inbR80P3wzHe22++sL6peMB1u5gIBgW
         FTktqE3IY9kXRHjR7ux/n/AEHeVbbqOpSiSPHf3MgZVsHi3yDc2yiQyY5TOy0I0N0E7Y
         rl3g==
X-Gm-Message-State: APjAAAVajp+uA5nJcXUbRPSzN8aWHVVxsfxtVTnFSL0ZL/LBjU72I3S0
        2psu+KPgJ6kLLMVrWirVqXlBBw==
X-Google-Smtp-Source: APXvYqyIJ9mIrIMYZ5G+St3pLYf8dL+L3VyB/n0oKkMz8V7RjDvi5XCqGoir/2GDp8r+GsLQlFeJMQ==
X-Received: by 2002:a63:2266:: with SMTP id t38mr3712682pgm.145.1581370294997;
        Mon, 10 Feb 2020 13:31:34 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id j125sm1247180pfg.160.2020.02.10.13.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 13:31:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1581316605-29202-2-git-send-email-sanm@codeaurora.org>
References: <1581316605-29202-1-git-send-email-sanm@codeaurora.org> <1581316605-29202-2-git-send-email-sanm@codeaurora.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: qcom,dwc3: Convert USB DWC3 bindings
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
Date:   Mon, 10 Feb 2020 13:31:33 -0800
Message-ID: <158137029351.121156.8319119424832255457@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sandeep Maheswaram (2020-02-09 22:36:44)
> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Docum=
entation/devicetree/bindings/usb/qcom,dwc3.yaml
> new file mode 100644
> index 0000000..0353401
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> @@ -0,0 +1,155 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SuperSpeed DWC3 USB SoC controller
> +
> +maintainers:
> +  - Manu Gautam <mgautam@codeaurora.org>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,msm8996-dwc3
> +          - qcom,msm8998-dwc3
> +          - qcom,sdm845-dwc3
> +      - const: qcom,dwc3
> +
> +  reg:
> +    description: Offset and length of register set for QSCRATCH wrapper
> +    maxItems: 1
> +
> +  "#address-cells":
> +    enum: [ 1, 2 ]
> +
> +  "#size-cells":
> +    enum: [ 1, 2 ]
> +
> +  power-domains:
> +    description: specifies a phandle to PM domain provider node
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      A list of phandle and clock-specifier pairs for the clocks
> +      listed in clock-names.
> +    items:
> +      - description: System Config NOC clock.
> +      - description: Master/Core clock, has to be >=3D 125 MHz
> +          for SS operation and >=3D 60MHz for HS operation.
> +      - description: System bus AXI clock.
> +      - description: Mock utmi clock needed for ITP/SOF generation
> +          in host mode.Its frequency should be 19.2MHz.

Please add a space between the end of sentence and next one.

> +      - description: Sleep clock, used for wakeup when
> +          USB3 core goes into low power mode (U3).
> +
> +  clock-names:
> +    items:
> +      - const: cfg_noc
> +      - const: core
> +      - const: iface
> +      - const: mock_utmi
> +      - const: sleep
> +
> +  assigned-clocks:
> +    items:
> +      - description: Phandle to MOCK_UTMI_CLK.
> +      - description: Phandle to MASTER_CLK.

It's a phandle and clock specifier pair, not always just a phandle.
Maybe the base schema can enforce that somehow, but the description
isn't accurate.

> +
> +  assigned-clock-rates:
> +    items:
> +      - description: Must be 19.2MHz (19200000).
> +      - description: Must be >=3D 60 MHz in HS mode, >=3D 125 MHz in SS =
mode.

Can this be more strict? I see in [1] that it was suggested to update
the schema checker. Did you try that?

> +
> +  resets:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: The interrupt that is asserted
> +          when a wakeup event is received on USB2 bus.
> +      - description: The interrupt that is asserted
> +          when a wakeup event is received on USB3 bus.
> +      - description: Wakeup event on DM line.
> +      - description: Wakeup event on DP line.
> +
> +  interrupt-names:
> +    items:
> +      - const: hs_phy_irq
> +      - const: ss_phy_irq
> +      - const: dm_hs_phy_irq
> +      - const: dp_hs_phy_irq
> +
> +  qcom,select-utmi-as-pipe-clk:
> +    description:
> +      If present, disable USB3 pipe_clk requirement.
> +      Used when dwc3 operates without SSPHY and only
> +      HS/FS/LS modes are supported.
> +    type: boolean
> +
> +# Required child node:
> +
> +patternProperties:
> +  "^dwc3@[0-9a-f]+$":
> +    type: object
> +    description:
> +      A child node must exist to represent the core DWC3 IP block
> +      The content of the node is defined in dwc3.txt.
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - power-domains
> +  - clocks
> +  - clock-names

Why aren't interrupts required? They're always present, aren't they?

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>

It would be good to include <dt-bindings/interrupt-controller/irq.h>
here too, just in case someone wants to move that include out of
arm-gic.h, which is possible.

> +    usb_1: usb@a6f8800 {

Can we drop the phandle? It's not used.

> +        compatible =3D "qcom,sdm845-dwc3", "qcom,dwc3";
> +        reg =3D <0 0x0a6f8800 0 0x400>;
> +
> +        #address-cells =3D <2>;
> +        #size-cells =3D <2>;
> +
> +        clocks =3D <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
> +                 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
> +                 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
> +                 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
> +                 <&gcc GCC_USB30_PRIM_SLEEP_CLK>;
> +        clock-names =3D "cfg_noc", "core", "iface", "mock_utmi",
> +                        "sleep";

Spacing looks off. Are there tabs?

> +
> +        assigned-clocks =3D <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
> +                          <&gcc GCC_USB30_PRIM_MASTER_CLK>;
> +        assigned-clock-rates =3D <19200000>, <150000000>;
> +
> +        interrupts =3D <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 488 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 489 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names =3D "hs_phy_irq", "ss_phy_irq",
> +                              "dm_hs_phy_irq", "dp_hs_phy_irq";

Same spacing nit

> +
> +            power-domains =3D <&gcc USB30_PRIM_GDSC>;
> +
> +            resets =3D <&gcc GCC_USB30_PRIM_BCR>;
> +
> +            usb_1_dwc3: dwc3@a600000 {

Drop this phandle too? It isn't used.

> +                compatible =3D "snps,dwc3";
> +                reg =3D <0 0x0a600000 0 0xcd00>;
> +                interrupts =3D <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
> +                iommus =3D <&apps_smmu 0x740 0>;
> +                snps,dis_u2_susphy_quirk;
> +                snps,dis_enblslpm_quirk;
> +                phys =3D <&usb_1_hsphy>, <&usb_1_ssphy>;
> +                phy-names =3D "usb2-phy", "usb3-phy";
> +            };

[1] https://lkml.kernel.org/r/20191218221310.GA4624@bogus
