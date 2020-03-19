Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE11C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 01:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AEC20767
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 01:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lTy0INGy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgCSBDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 21:03:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40106 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCSBDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 21:03:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id t24so245052pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 18:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=cxvWWdiLWhwcBWA6ADvkCOYt4fG2zyPQ2T9tIxIBDEQ=;
        b=lTy0INGyi6isNdz4BWtj2OHapIpXObN/A5Bw5xR2jUiAyFrM0ev10C0DXvExOlxwhc
         ImZia8GiXsiPGuNaM/4kS8ZVnHfFUYJ2HWiWCkHtxE2eL6fhgDfNjv8fDe5Y3TDI0/og
         7WX/Gjp9iTU9Hl6Uqs4FH6jOiVv/YankzE2fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=cxvWWdiLWhwcBWA6ADvkCOYt4fG2zyPQ2T9tIxIBDEQ=;
        b=OMxTv/o8gk47AsMkcquJnQAYXtp8xFrM4pwI+amE4QkwHBIRxcDpXAvUERpl9qrArf
         gvlHUb7qMZCQZzLVSUeDT8KIXCkQGCBybyZBlSpdufb0QUdFHybGhNJXYusHQwBWHFFC
         FhbV4VnbfqkjPADteZ2ssXdbrCy0QnnRWQdAqNdQBsXXN0IzjQW4Hos4tjoZ7pyOAluK
         220ajjRcjaN8YZUg8TDjxIIz6cW+9SikdrrdjphTsVRvUBCOGxRHryuniQ+uh1UGHfYB
         nz9IZG/i92ZF9ykQ9BPYMjv/Z2Ka7rAaTfEXCX+EeD+hjHFB0ZvI/BL6tS8ykRCaE+1L
         YKzg==
X-Gm-Message-State: ANhLgQ2eQbeq0n83iZSl/arpFberras8kUgPqLuftuntNc+Ufz5SUDY4
        yL7VU1eJ6lr9zerod+T8Bs3zww==
X-Google-Smtp-Source: ADFU+vvJQBekMCStovu5VWz10374hQ0R97C2UWDJEFdyIkEHKe7U2rbXhUVHYtmBV6EUNpQHMp4PHg==
X-Received: by 2002:a63:1404:: with SMTP id u4mr564252pgl.172.1584579790905;
        Wed, 18 Mar 2020 18:03:10 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id u14sm250068pgg.67.2020.03.18.18.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 18:03:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1583928252-21246-2-git-send-email-sanm@codeaurora.org>
References: <1583928252-21246-1-git-send-email-sanm@codeaurora.org> <1583928252-21246-2-git-send-email-sanm@codeaurora.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: phy: qcom,qmp: Convert QMP PHY bindings to yaml
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
Date:   Wed, 18 Mar 2020 18:03:09 -0700
Message-ID: <158457978900.152100.4898904631535195370@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sandeep Maheswaram (2020-03-11 05:04:09)
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Do=
cumentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> new file mode 100644
> index 0000000..39ec3f24
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> @@ -0,0 +1,311 @@
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
> +  QMP phy controller supports physical layer functionality for a number =
of
> +  controllers on Qualcomm chipsets, such as, PCIe, UFS, and USB.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,ipq8074-qmp-pcie-phy
> +      - qcom,msm8996-qmp-pcie-phy
> +      - qcom,msm8996-qmp-usb3-phy
> +      - qcom,msm8998-qmp-pcie-phy
> +      - qcom,msm8998-qmp-ufs-phy
> +      - qcom,msm8998-qmp-usb3-phy
> +      - qcom,sdm845-qhp-pcie-phy
> +      - qcom,sdm845-qmp-pcie-phy
> +      - qcom,sdm845-qmp-ufs-phy
> +      - qcom,sdm845-qmp-usb3-phy
> +      - qcom,sdm845-qmp-usb3-uni-phy

I was looking at the DP phy binding in another thread and I'm wondering
what qmp-usb3-uni-phy means. Is that a usb3 phy that doesn't have DP phy
combined with it? It looks like the DP phy binding needs to be merged
with this binding (and some of the driver part too), so I'm not sure
this binding is correct as it stands. Probably needs to be updated to
support DP too.

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
> +    minItems: 1
> +    maxItems: 4
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 4
> +
> +  resets:
> +    minItems: 1
> +    maxItems: 3
> +
> +  reset-names:
> +    minItems: 1
> +    maxItems: 3
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
> +  "^phy@[0-9a-f]+$":
> +    type: object
> +    description:
> +      Each device node of QMP phy is required to have as many child node=
s as
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
> +            enum:
> +              - qcom,sdm845-qmp-usb3-phy
> +              - qcom,sdm845-qmp-usb3-uni-phy
> +    then:

There's a lot of if-then nesting stuff. Maybe we could split the binding
into many files for the different compatibles so that it is more
readable.

> +      properties:
> +        clocks:
