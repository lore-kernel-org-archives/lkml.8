Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E97AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 20:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CCD20702
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 20:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="muu5NtVB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgA2U2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 15:28:24 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:51944 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgA2U2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 15:28:23 -0500
Received: by mail-pj1-f67.google.com with SMTP id fa20so293217pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 12:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FYPa7lFmYtTm2A5/QQXkao+No6TTIoQfgc3zZC2dceA=;
        b=muu5NtVBTvYDhbsmr+WI5Vnk7NRmRvSA6jdnfOdSYjTA7MbfDSdd/WljahBu+Xbtmi
         lGIZnaGMsYUxUrW3mZchK9fI11iy52zJwITuSc8k5W8R/B9Sk3FdjAQRsKvYh7XzGaWC
         JXHGADf2dezpT00pdoqxNudLtFrUf74FmmKeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FYPa7lFmYtTm2A5/QQXkao+No6TTIoQfgc3zZC2dceA=;
        b=mdelYBxVcbz+wHtGTFtYQrw/m0C/WPkaNMYWES/l+UiqGjHqC6TQc/RGz0BgjZJ9Z8
         TMCj4xb6fPc1iE+fYIEVEs6N1gFWNangMuC2G0pTKyX3oGEbb4kBGvrrceAANQs+w8aj
         Uk2og/+lBSIJ71W6G4Zj8OJIgiHY4zByGcZVhg50+5yk7KOBqWEBGwuAdImd6bzjBvn0
         i+zWijjlHBYjlTykf2muHg5+I7LTPLUIK1p2tuOghKhaoQ4hg24ey9dSvjFckTRZi8a4
         oCE882aSAXVQBwMqpV519F5XVhgsGMvghii0CzggiZbpYNxCIPRahyXoPdRT9NsAlr7l
         vdpg==
X-Gm-Message-State: APjAAAUXT4VPPLn2HxGMATSBSrPOXIZwbTIfpQaii/UC1HN7DEM+f/WJ
        ElEPapv0Izcyxp4kMUaZ7acTvg==
X-Google-Smtp-Source: APXvYqx6+EsdVKGm9bRaKbZNvefgqPU0zzUyY7QlBcEjRg2J+2tcRbAARgQjrWXLP4HFPvuMfVfIkg==
X-Received: by 2002:a17:902:9a8e:: with SMTP id w14mr1128098plp.315.1580329702688;
        Wed, 29 Jan 2020 12:28:22 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id j28sm3719781pgb.36.2020.01.29.12.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 12:28:21 -0800 (PST)
Date:   Wed, 29 Jan 2020 12:28:20 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/8] dt-bindings: phy: qcom,qusb2: Convert QUSB2 phy
 bindings to yaml
Message-ID: <20200129202820.GC71044@google.com>
References: <1580305919-30946-1-git-send-email-sanm@codeaurora.org>
 <1580305919-30946-2-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1580305919-30946-2-git-send-email-sanm@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 07:21:52PM +0530, Sandeep Maheswaram wrote:
> Convert QUSB2 phy  bindings to DT schema format using json-schema.
> 
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> ---
>  .../devicetree/bindings/phy/qcom,qusb2-phy.yaml    | 142 +++++++++++++++++++++
>  .../devicetree/bindings/phy/qcom-qusb2-phy.txt     |  68 ----------
>  2 files changed, 142 insertions(+), 68 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
>  delete mode 100644 Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
> new file mode 100644
> index 0000000..90b3cc6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
> @@ -0,0 +1,142 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/qcom,qusb2-phy.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm QUSB2 phy controller
> +
> +maintainers:
> +  - Manu Gautam <mgautam@codeaurora.org>
> +
> +description:
> +  QUSB2 controller supports LS/FS/HS usb connectivity on Qualcomm chipsets.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,msm8996-qusb2-phy
> +      - qcom,msm8998-qusb2-phy
> +      - qcom,sdm845-qusb2-phy
> +  reg:
> +    maxItems: 1
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  clocks:
> +    minItems: 2
> +    items:
> +      - description: phy config clock
> +      - description: 19.2 MHz ref clk
> +      - description: phy interface clock (Optional)
> +
> +  clock-names:
> +    minItems: 2
> +    items:
> +      - const: cfg_ahb
> +      - const: ref
> +      - const: iface
> +
> +  vdda-pll-supply:
> +     description:
> +       Phandle to 1.8V regulator supply to PHY refclk pll block.
> +
> +  vdda-phy-dpdm-supply:
> +     description:
> +       Phandle to 3.1V regulator supply to Dp/Dm port signals.
> +
> +  resets:
> +    maxItems: 1
> +
> +  nvmem-cells:
> +    maxItems: 1
> +    description:
> +        Phandle to nvmem cell that contains 'HS Tx trim'
> +        tuning parameter value for qusb2 phy.
> +
> +  qcom,tcsr-syscon:
> +    description:
> +        Phandle to TCSR syscon register region.
> +    $ref: /schemas/types.yaml#/definitions/cell
> +
> +  qcom,imp-res-offset-value:
> +    description:
> +        It is a 6 bit value that specifies offset to be
> +        added to PHY refgen RESCODE via IMP_CTRL1 register. It is a PHY
> +        tuning parameter that may vary for different boards of same SOC.
> +        This property is applicable to only QUSB2 v2 PHY.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +        maximum: 63
> +        default: 0
> +
> +  qcom,hstx-trim-value:
> +    description:
> +        It is a 4 bit value that specifies tuning for HSTX
> +        output current.
> +        Possible range is - 15mA to 24mA (stepsize of 600 uA).
> +        See dt-bindings/phy/phy-qcom-qusb2.h for applicable values.
> +        This property is applicable to only QUSB2 v2 PHY.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +        maximum: 15
> +        default: 3
> +
> +  qcom,preemphasis-level:
> +    description:
> +        It is a 2 bit value that specifies pre-emphasis level.
> +        Possible range is 0 to 15% (stepsize of 5%).
> +        See dt-bindings/phy/phy-qcom-qusb2.h for applicable values.
> +        This property is applicable to only QUSB2 v2 PHY.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +        maximum: 3
> +        default: 2
> +
> +  qcom,preemphasis-width:
> +    description:
> +        It is a 1 bit value that specifies how long the HSTX
> +        pre-emphasis (specified using qcom,preemphasis-level) must be in
> +        effect. Duration could be half-bit of full-bit.
> +        See dt-bindings/phy/phy-qcom-qusb2.h for applicable values.
> +        This property is applicable to only QUSB2 v2 PHY.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +        maximum: 1
> +        default: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#phy-cells"
> +  - clocks
> +  - clock-names
> +  - vdda-pll-supply
> +  - vdda-phy-dpdm-supply
> +  - resets
> +
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-msm8996.h>
> +    hsusb_phy: phy@7411000 {
> +        compatible = "qcom,msm8996-qusb2-phy";
> +        reg = <0x7411000 0x180>;
> +        #phy-cells = <0>;
> +
> +        clocks = <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
> +                 <&gcc GCC_RX1_USB2_CLKREF_CLK>;
> +        clock-names = "cfg_ahb", "ref";
> +
> +        vdda-pll-supply = <&pm8994_l12>;
> +        vdda-phy-dpdm-supply = <&pm8994_l24>;
> +
> +        resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
> +        nvmem-cells = <&qusb2p_hstx_trim>;
> +    };
> diff --git a/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
> deleted file mode 100644
> index fe29f9e..0000000
> --- a/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
> +++ /dev/null
> @@ -1,68 +0,0 @@
> -Qualcomm QUSB2 phy controller
> -=============================
> -
> -QUSB2 controller supports LS/FS/HS usb connectivity on Qualcomm chipsets.
> -
> -Required properties:
> - - compatible: compatible list, contains
> -	       "qcom,msm8996-qusb2-phy" for 14nm PHY on msm8996,
> -	       "qcom,msm8998-qusb2-phy" for 10nm PHY on msm8998,
> -	       "qcom,sdm845-qusb2-phy" for 10nm PHY on sdm845.
> -
> - - reg: offset and length of the PHY register set.
> - - #phy-cells: must be 0.
> -
> - - clocks: a list of phandles and clock-specifier pairs,
> -	   one for each entry in clock-names.
> - - clock-names: must be "cfg_ahb" for phy config clock,
> -			"ref" for 19.2 MHz ref clk,
> -			"iface" for phy interface clock (Optional).
> -
> - - vdda-pll-supply: Phandle to 1.8V regulator supply to PHY refclk pll block.
> - - vdda-phy-dpdm-supply: Phandle to 3.1V regulator supply to Dp/Dm port signals.
> -
> - - resets: Phandle to reset to phy block.
> -
> -Optional properties:
> - - nvmem-cells: Phandle to nvmem cell that contains 'HS Tx trim'
> -		tuning parameter value for qusb2 phy.
> -
> - - qcom,tcsr-syscon: Phandle to TCSR syscon register region.
> - - qcom,imp-res-offset-value: It is a 6 bit value that specifies offset to be
> -		added to PHY refgen RESCODE via IMP_CTRL1 register. It is a PHY
> -		tuning parameter that may vary for different boards of same SOC.
> -		This property is applicable to only QUSB2 v2 PHY (sdm845).
> - - qcom,hstx-trim-value: It is a 4 bit value that specifies tuning for HSTX
> -		output current.
> -		Possible range is - 15mA to 24mA (stepsize of 600 uA).
> -		See dt-bindings/phy/phy-qcom-qusb2.h for applicable values.
> -		This property is applicable to only QUSB2 v2 PHY (sdm845).
> -		Default value is 22.2mA for sdm845.
> - - qcom,preemphasis-level: It is a 2 bit value that specifies pre-emphasis level.
> -		Possible range is 0 to 15% (stepsize of 5%).
> -		See dt-bindings/phy/phy-qcom-qusb2.h for applicable values.
> -		This property is applicable to only QUSB2 v2 PHY (sdm845).
> -		Default value is 10% for sdm845.
> -- qcom,preemphasis-width: It is a 1 bit value that specifies how long the HSTX
> -		pre-emphasis (specified using qcom,preemphasis-level) must be in
> -		effect. Duration could be half-bit of full-bit.
> -		See dt-bindings/phy/phy-qcom-qusb2.h for applicable values.
> -		This property is applicable to only QUSB2 v2 PHY (sdm845).
> -		Default value is full-bit width for sdm845.
> -
> -Example:
> -	hsusb_phy: phy@7411000 {
> -		compatible = "qcom,msm8996-qusb2-phy";
> -		reg = <0x7411000 0x180>;
> -		#phy-cells = <0>;
> -
> -		clocks = <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
> -			<&gcc GCC_RX1_USB2_CLKREF_CLK>,
> -		clock-names = "cfg_ahb", "ref";
> -
> -		vdda-pll-supply = <&pm8994_l12>;
> -		vdda-phy-dpdm-supply = <&pm8994_l24>;
> -
> -		resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
> -		nvmem-cells = <&qusb2p_hstx_trim>;
> -        };

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
