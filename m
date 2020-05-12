Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87ACAC2D0FB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 675C4206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589320998;
	bh=qcCz8CQ5JmHBuoyoHsLahiU4DSa3lcQM42OalNpS6BU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SN1Of+yMqlu97kW1ksvspmIHjvL66RyHJM8QE7T+nSMyWaCpYj5fg00NElUVS+1kW
	 v2PozrIpH4SV+xOBO6zucrDsb6MfjnCv9aWqPfSbbVT8MvabQ61/Rr52q4DAPM1FYa
	 mQT/WpEq17OloLG/YVF9YmaqA2+OCfHU4eejiMaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731462AbgELWDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:03:17 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39926 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbgELWDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:03:17 -0400
Received: by mail-ot1-f68.google.com with SMTP id m13so11826820otf.6;
        Tue, 12 May 2020 15:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MUwPbwoCw7AWkOjfbYkkLEEsldhhBednze2KVALn6gg=;
        b=CObpsxysjKCGWwSiewjYMTi/v4smjP1lgSX8rM7M+6PVWBViC9DRZjL1BYR4dIEM1v
         hSAXhBoq4NxVrKzkFPejZNN+6d6KTOk5V7ASRZQKlrmEG4nBzfPupnBJh0J92tLDpG/u
         rWmqXkl08FUATmy2CCEy/Wn73e47FOSErukGSGG7RvAPTEJxQC3UvEwdFnsHI1bqsX98
         6wqkiF1M+Gyf5rJwFK1J3rCP5b6EFqIy/CkhiiIsgPp9umQsuinQOCsB4S6NsBHsQRso
         y0dd7EQlK6LmrVelA0Jd7Gk1TXcrQTGYs6AezO2CQHu0IY9n66vwbvpKXAMQYVQu72D/
         UkKw==
X-Gm-Message-State: AGi0Pua9fir5cLJIC30lzExJbPJQJ7Q98gEzVNwUNstJWvFepEMf9i8I
        wYdKFDeBn/UrR+RQJyp4Lg==
X-Google-Smtp-Source: APiQypJgSZbfY16yL5q4Va7ckktZ2np41KwS/08QmNxY59XKZdbVclDoACFX2ieFTq/+LTS07P9ekg==
X-Received: by 2002:a9d:6847:: with SMTP id c7mr17918699oto.159.1589320996371;
        Tue, 12 May 2020 15:03:16 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j47sm2689110oof.11.2020.05.12.15.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:03:15 -0700 (PDT)
Received: (nullmailer pid 13443 invoked by uid 1000);
        Tue, 12 May 2020 22:03:14 -0000
Date:   Tue, 12 May 2020 17:03:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kishon@ti.com, vkoul@kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, narmstrong@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hexdump0815@googlemail.com
Subject: Re: [PATCH 1/6] dt-bindings: phy: meson8b-usb2: Convert to
 json-schema
Message-ID: <20200512220314.GA28996@bogus>
References: <20200502114752.1048500-1-martin.blumenstingl@googlemail.com>
 <20200502114752.1048500-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200502114752.1048500-2-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 02, 2020 at 01:47:47PM +0200, Martin Blumenstingl wrote:
> Now that we have the DT validation in place, let's convert the device
> tree bindings for the Amlogic Meson8, Meson8b, Meson8m2 and GXBB USB2
> PHY over to a YAML schema.
> 
> While here, also add the fallback compatible string
> "amlogic,meson-gxbb-usb2-phy" which is already used in
> arch/arm/boot/dts/meson{,8,8b}.dtsi.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../phy/amlogic,meson8b-usb2-phy.yaml         | 61 +++++++++++++++++++
>  .../bindings/phy/meson8b-usb2-phy.txt         | 28 ---------
>  2 files changed, 61 insertions(+), 28 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml
>  delete mode 100644 Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml
> new file mode 100644
> index 000000000000..c2fe8c08d99e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/amlogic,meson8b-usb2-phy.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic Meson8, Meson8b, Meson8m2 and GXBB USB2 PHY
> +
> +maintainers:
> +  - Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +            - amlogic,meson8-usb2-phy
> +            - amlogic,meson8b-usb2-phy

Needs 2 more spaces indent.

> +          - const: amlogic,meson-mx-usb2-phy
> +      - const: amlogic,meson-gxbb-usb2-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: usb_general
> +      - const: usb
> +
> +  resets:
> +    minItems: 1
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  phy-supply:
> +     description:

Wrong indentation.

> +       Phandle to a regulator that provides power to the PHY. This
> +       regulator will be managed during the PHY power on/off sequence.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - "#phy-cells"

Add:

additionalProperties: false

> +
> +examples:
> +  - |
> +    usb-phy@c0000000 {
> +      compatible = "amlogic,meson-gxbb-usb2-phy";
> +      reg = <0xc0000000 0x20>;
> +      resets = <&reset_usb_phy>;
> +      clocks = <&clk_usb_general>, <&reset_usb>;
> +      clock-names = "usb_general", "usb";
> +      phy-supply = <&usb_vbus>;
> +      #phy-cells = <0>;
> +    };
