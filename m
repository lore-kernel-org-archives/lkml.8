Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C98C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 10:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24D5E2073B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 10:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/PZmuLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgEDKzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 06:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727098AbgEDKzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 06:55:47 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E188C061A0E;
        Mon,  4 May 2020 03:55:46 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id r26so8522106wmh.0;
        Mon, 04 May 2020 03:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MQzZFCIobcGRmD/3+2nuvnxHv+aNaXAHRF5s3/10ij8=;
        b=m/PZmuLtPqcrVYqQd8qj0jK+TnpKJK5MX7Eozj10EZs/2HHL50KGQbVzu8gMp02gQJ
         6F9pbqJxSIP5cyRweFxpWJmvEjHRO8iYRZ7uJtUkgDOuGJdz6ddKmppLGZR3e5PZRy8p
         lscDnAenUEC22uEp+XgYw32aZ+HkLVSqsvC75MSuht8EuPG6ScVjIjvMEFV9pdkEkkcf
         OArBZA9Q1sjFRuzpgxMJe/LVC99w/wnQt0E3X/QvpCR24OL4Clof6mIPLcYdTz1iOWT0
         IgmiGmXOguP6TDTfqbTQZvpTCTiMEWCPmXlM5UOvtimIP+GKpRwOyklM3Lsq6jw5VEvG
         JW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQzZFCIobcGRmD/3+2nuvnxHv+aNaXAHRF5s3/10ij8=;
        b=ZV9X1bqalkcw/gZPBYDcAEgC9yUxoPWp4/LtHnV8h0jt+bAGce7XO9Fi09ow8UoTZC
         I4FCOhYHzu48cNwsPzev/cvN7ziE6H4Hs2lVmO6qKaRoCp+fq2WFFvyIeUUFzSso+bLW
         /pGuU/DkcH5s+gv2HU2W5a7FnrPEUdom8BYyX8exfbC3cYifU+j8WNl3rjhbjXJYaGPw
         h7GIHy9IOlE8wQyAKuliigIanGy636MQQb2ouXsoZVIR1Gkw4nHHrklD3uyZ/BEtzkyD
         vwtLaf5kbH6Ku8GfpD76Mm0VXbTBAe3vbHha9jD0H3dXe+7T1ZDhgYLCl0kHeDZdFUR+
         BNaQ==
X-Gm-Message-State: AGi0Pua6+/AlmdHBEXzlMul+Iw5yIz1L7EkE88G8KdQ+M8R4WcvZz6nq
        gWrw3Bc1Y8BZxqo0535A8GU0ma8ZEg2K/K06t3I=
X-Google-Smtp-Source: APiQypIYRxd9Jarg4XaVun2QaTdEW4Ftk+7SlWd5NIBX1wOKIWiArNVS6La7qmbqT0diARP8mRcyXHfJL2xmf4cg4Io=
X-Received: by 2002:a7b:c0c5:: with SMTP id s5mr13769191wmh.134.1588589744849;
 Mon, 04 May 2020 03:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200502114752.1048500-1-martin.blumenstingl@googlemail.com> <20200502114752.1048500-2-martin.blumenstingl@googlemail.com>
In-Reply-To: <20200502114752.1048500-2-martin.blumenstingl@googlemail.com>
From:   hex dump <hexdump0815@gmail.com>
Date:   Mon, 4 May 2020 12:55:30 +0200
Message-ID: <CAKTihDVy6oSuQe4eP87hWO17tBu3=XZ-PM41YOqLVOtXJ8+YeQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: phy: meson8b-usb2: Convert to json-schema
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 2, 2020 at 1:48 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Now that we have the DT validation in place, let's convert the device
> tree bindings for the Amlogic Meson8, Meson8b, Meson8m2 and GXBB USB2
> PHY over to a YAML schema.
>
> While here, also add the fallback compatible string
> "amlogic,meson-gxbb-usb2-phy" which is already used in
> arch/arm/boot/dts/meson{,8,8b}.dtsi.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Tested-by: hexdump <hexdump0815@googlemail.com>

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
> +       Phandle to a regulator that provides power to the PHY. This
> +       regulator will be managed during the PHY power on/off sequence.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - "#phy-cells"
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
> diff --git a/Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt b/Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt
> deleted file mode 100644
> index d81d73aea608..000000000000
> --- a/Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -* Amlogic Meson8, Meson8b and GXBB USB2 PHY
> -
> -Required properties:
> -- compatible:  Depending on the platform this should be one of:
> -       "amlogic,meson8-usb2-phy"
> -       "amlogic,meson8b-usb2-phy"
> -       "amlogic,meson-gxbb-usb2-phy"
> -- reg:         The base address and length of the registers
> -- #phys-cells: should be 0 (see phy-bindings.txt in this directory)
> -- clocks:      phandle and clock identifier for the phy clocks
> -- clock-names: "usb_general" and "usb"
> -
> -Optional properties:
> -- resets:      reference to the reset controller
> -- phy-supply:  see phy-bindings.txt in this directory
> -
> -
> -Example:
> -
> -usb0_phy: usb-phy@c0000000 {
> -       compatible = "amlogic,meson-gxbb-usb2-phy";
> -       #phy-cells = <0>;
> -       reg = <0x0 0xc0000000 0x0 0x20>;
> -       resets = <&reset RESET_USB_OTG>;
> -       clocks = <&clkc CLKID_USB>, <&clkc CLKID_USB0>;
> -       clock-names = "usb_general", "usb";
> -       phy-supply = <&usb_vbus>;
> -};
> --
> 2.26.2
>
