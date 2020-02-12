Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6D3C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675EB24677
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IDjXvk3C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgBLUQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:16:37 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45309 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbgBLUQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:16:37 -0500
Received: by mail-pg1-f193.google.com with SMTP id b9so1648746pgk.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 12:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4cuXzzmmpPcLczy0qmJk/Rn4HY2/+QU6mo8lxNbiZT4=;
        b=IDjXvk3CUYXG9mtaCYefq9509kGq2mr2Nphq+QyeEay9hJK+wwO0uFqR+n1G0vNwLd
         k6ZNxgWaltfWzksSdSIw/KJQ+hJ7REPlF/myQCInKojiDc/+aVOj2SjHvWEgPGZm6PS3
         CmzLpQKY0k1hF4BWDkmqoHgvs5Ulib7KZbreQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4cuXzzmmpPcLczy0qmJk/Rn4HY2/+QU6mo8lxNbiZT4=;
        b=ZFg02nBIChcIXAb5mVSdgxDiiCGecVW3f+Wv9IqUr9Tmv5f4BJ/PFE6tcNADIjgTck
         RVON1G+eT8ASbDNuqJIsSQGwIFr5545OxFb0rN2FHz1OtdADT3XK6gJzFB4RWmFXjAXf
         84gWG7ikrbkzXkd/K0upSKOSt/OeNLmHcaiiFAdrWzH+ysvNam4MOcF33+n/otDOuPZo
         +eKGp8x/hDX55/bYP+//Nr1ElBvGAlfzpBhS6a0yBHHC93w7APjzFRUQSmnjZVrRsiqv
         OkX9xR4fhpAXZMHn9To8PdUeYkotCfg7pHF3Gy3Fr6fCrqxbf/LiBWdolfWYgQ0BBfTK
         DGqA==
X-Gm-Message-State: APjAAAVLmbsoFCUs5GggYbmBv86P9r9/v5wnYcG+wAfcKms0SyapyU8v
        MTj5iQJVQ/YGp50Eu8VxWXZ/uhfSbaQ=
X-Google-Smtp-Source: APXvYqy9/lSIxZTxrSAoNKdWNEvaWgClcoOpfpuXtcZ2mTH3lRa8Ax5wU98mkoXfsMblDMJycUQjNA==
X-Received: by 2002:a63:7c4d:: with SMTP id l13mr14282223pgn.275.1581538595417;
        Wed, 12 Feb 2020 12:16:35 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id i64sm1401950pgc.51.2020.02.12.12.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 12:16:34 -0800 (PST)
Date:   Wed, 12 Feb 2020 12:16:33 -0800
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
        devicetree@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: phy: qcom,qmp: Convert QMP phy
 bindings to yaml
Message-ID: <20200212201633.GB50449@google.com>
References: <1581506488-26881-1-git-send-email-sanm@codeaurora.org>
 <1581506488-26881-2-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1581506488-26881-2-git-send-email-sanm@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandeep,

On Wed, Feb 12, 2020 at 04:51:25PM +0530, Sandeep Maheswaram wrote:
> Convert QMP phy  bindings to DT schema format using json-schema.

nit: s/phy  bindings/PHY bindings/

> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> ---
>  .../devicetree/bindings/phy/qcom,qmp-phy.yaml      | 283 +++++++++++++++++++++
>  .../devicetree/bindings/phy/qcom-qmp-phy.txt       | 227 -----------------
>  2 files changed, 283 insertions(+), 227 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
>  delete mode 100644 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> new file mode 100644
> index 0000000..b39a594
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> @@ -0,0 +1,283 @@
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
> +      - qcom,msm8996-qmp-pcie-phy
> +      - qcom,msm8996-qmp-usb3-phy
> +      - qcom,msm8998-qmp-usb3-phy
> +      - qcom,msm8998-qmp-ufs-phy
> +      - qcom,msm8998-qmp-pcie-phy
> +      - qcom,sdm845-qmp-usb3-phy
> +      - qcom,sdm845-qmp-usb3-uni-phy
> +      - qcom,sdm845-qmp-ufs-phy
> +      - qcom,sm8150-qmp-ufs-phy

nit: sort in alphabetical order (i.e. -pcie, -ufs, -usb3)?

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
> +    maxItems: 4
> +    minItems: 1

nit: minItems before maxItems, which is the order humans expect, also
it is the prevalent order in other .yaml bindings.

Do we actually need min/maxItems? I would expect the below rules for each
compatible string to take care of it, however I'm not a schema expert.

> +
> +  clock-names:
> +    maxItems: 4
> +    minItems: 1
> +  resets:
> +    maxItems: 3
> +    minItems: 1
> +
> +  reset-names:
> +    maxItems: 3
> +    minItems: 1
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
> +
> +#Required nodes:
> +patternProperties:
> +  "^lanes@[0-9a-f]+$":
> +    type: object
> +    description:
> +      Each device node of QMP phy is required to have as many child nodes as
> +      the number of lanes the PHY has.
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
> +
> +additionalProperties: false
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +             enum:

fix indentation (2 blanks, not 3)

> +               - qcom,sdm845-qmp-usb3-phy
> +               - qcom,sdm845-qmp-usb3-uni-phy
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: Phy aux clock.
> +            - description: Phy config clock.
> +            - description: 19.2 MHz ref clk.
> +            - description: Phy common block aux clock.
> +        clock-names:
> +          items:
> +            - const: aux
> +            - const: cfg_ahb
> +            - const: ref
> +            - const: com_aux
> +        resets:
> +          items:
> +            - description: reset of phy block.
> +            - description: phy common block reset.
> +        reset-names:
> +          items:
> +             - const: phy
> +             - const: common

fix indentation (3 -> 2)

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +             enum:

fix indentation (3 -> 2)

> +               - qcom,msm8996-qmp-pcie-phy
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: Phy aux clock.
> +            - description: Phy config clock.
> +            - description: 19.2 MHz ref clk.
> +

nit: remove empty line or add it everywhere.

> +        clock-names:
> +          items:
> +            - const: aux
> +            - const: cfg_ahb
> +            - const: ref
> +        resets:
> +          items:
> +            - description: reset of phy block.
> +            - description: phy common block reset.
> +            - description: phy's ahb cfg block reset.
> +        reset-names:
> +          items:
> +             - const: phy
> +             - const: common
> +             - const: cfg

fix indentation (3 -> 2)

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +             enum:

fix indentation (3 -> 2)

> +               - qcom,msm8996-qmp-pcie-phy
> +               - qcom,msm8996-qmp-usb3-phy
> +               - qcom,msm8998-qmp-pcie-phy
> +               - qcom,msm8998-qmp-usb3-phy
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: Phy aux clock.
> +            - description: Phy config clock.
> +            - description: 19.2 MHz ref clk.
> +        clock-names:
> +          items:
> +            - const: aux
> +            - const: cfg_ahb
> +            - const: ref
> +        resets:
> +          items:
> +            - description: reset of phy block.
> +            - description: phy common block reset.
> +        reset-names:
> +          items:
> +             - const: phy
> +             - const: common

According to the .txt binding this is not correct for
'qcom,msm8996-qmp-pcie-phy':

  For "qcom,msm8996-qmp-pcie-phy" must contain:
			"phy", "common", "cfg".

This also matches the actual use in arch/arm64/boot/dts/qcom/msm8996.dtsi

Also the indentation needs to be fixed (3 -> 2)

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +             enum:

fix indentation (3 -> 2)

> +               - qcom,msm8998-qmp-ufs-phy
> +               - qcom,sdm845-qmp-ufs-phy
> +               - qcom,sm8150-qmp-ufs-phy
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: 19.2 MHz ref clk.
> +            - description: Phy reference aux clock.
> +        clock-names:
> +          items:
> +            - const: ref
> +            - const: ref_aux
> +        resets:
> +          items:
> +            - description: PHY reset in the UFS controller.
> +        reset-names:
> +          items:
> +            - const: ufsphy
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +             enum:

fix indentation (3 -> 2)

Thanks

Matthias
