Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F46C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC6F20FC3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xrFHOtnA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgE0H7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 03:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbgE0H7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 03:59:48 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1D0C03E97A
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 00:59:47 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id z12so8169125uap.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 00:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nC1TMqfprJ4W4XcfqrgFpbNgqAseys6jy1vlJXxtKz4=;
        b=xrFHOtnACP+26w28xn0jWdYc4q+twRA4nYNBqq+GxOcK4CrGmCUxX4ODa3YOt0hVC2
         qyL+r4oS5uYdSJM5RzfwlXajcKD1oZF94NYLP8mj4bk17zda9J1/o5eZd4fkMol6jSv1
         CbzOlHuBw945vXlVLyqw4cLeH4v/OONzWRkHZtsOuQrw2sfM8lv+nzyMgcNV3G9MNUsz
         visEScsBVRyt3WXAmviPU9c2tM/gIcyMgIS65Wnl4nNKXeFyzSV7w7atguhOFZZRn/0W
         Y0HhZ+clpnI54kbpYREw24lnjm/Z7GqeQ+NuWSx3K7KjoOCRBVSpu0iGJLLLzpwjjnkm
         tZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nC1TMqfprJ4W4XcfqrgFpbNgqAseys6jy1vlJXxtKz4=;
        b=Bq33xb9Gl78wQUZu15ax7o2wJDdu24mVvpyoqK38ZMTdA1k6qH1Biki1x2KadIjL+L
         31rvx+2ftvqnyws+B82C/Ib3Lkz5VC+2t0FCnYGgwxT+kVDXYwt+FCp3ONCzt3CQfJoW
         qQZufqPKpV4VCg+zalFsQ+sOKKrnIDjT4Urzg2++ANN2dfcDJlwhEr+5zB2pe4FJy6dM
         KyNnycvwWxWbt8EtfnZmUUgnBU6bmZfglwO7LvXaijrXPiKTP9qfU32i39G/qNyLj3Sz
         Db14tk0t009yyGpvur8naf6fz1LVHxY6VMpPdaFON212hyJuDGM59ecAooy9vdZh/BM1
         Nk6w==
X-Gm-Message-State: AOAM532TLy9h8u80CluRj5TBzE0Utdrrzg+nFOATT0CSYEU91k8/vHCs
        N0Gm6pOeezwQofuLrkm+wfENYRDtyOOIU1EGv3FqGpZQYn0=
X-Google-Smtp-Source: ABdhPJwlzabapp6LAdlMzLDMwiqPOJn6VaWANOgPljKotK2/jimNwANqOCumpZkJwt52NDYrLCy2/v8KD+hGOLTzLOE=
X-Received: by 2002:ab0:13f2:: with SMTP id n47mr3757389uae.129.1590566386824;
 Wed, 27 May 2020 00:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200521091356.2211020-1-lkundrak@v3.sk> <20200521091356.2211020-2-lkundrak@v3.sk>
In-Reply-To: <20200521091356.2211020-2-lkundrak@v3.sk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 May 2020 09:59:10 +0200
Message-ID: <CAPDyKFogpp+9d44Dgc8gXmeULj2CxoUzo4EhnLp+=_1YcvXT-g@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: mmc: Convert sdhci-pxa to json-schema
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Lubomir Rintel <lkundrak@v3.sk>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020 at 11:14, Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> Convert the sdhci-pxa binding to DT schema format using json-schema.
>
> At the same time, fix a couple of issues with the examples discovered by
> the validation tool -- a semicolon instead of a comma and wrong node names.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Rob, are you fine with this v2? I am intending to queue it up via my
mmc tree, unless you want to pick it?

Kind regards
Uffe

>
> ---
> Changes since v1:
> - move reg-names items: from the conditional to main properties:, only
>   specify maxItems and minItems in conditional branches
> - Specify minItems and maxItems in properties/reg instad of on
>   conditional branchs
> - Add default GPL-2.0-only license tag
> - Fill in maintainers from MAINTAINERS file
>
>  .../devicetree/bindings/mmc/sdhci-pxa.txt     |  50 ---------
>  .../devicetree/bindings/mmc/sdhci-pxa.yaml    | 103 ++++++++++++++++++
>  2 files changed, 103 insertions(+), 50 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt b/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
> deleted file mode 100644
> index 3d1b449d6097..000000000000
> --- a/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -* Marvell sdhci-pxa v2/v3 controller
> -
> -This file documents differences between the core properties in mmc.txt
> -and the properties used by the sdhci-pxav2 and sdhci-pxav3 drivers.
> -
> -Required properties:
> -- compatible: Should be "mrvl,pxav2-mmc", "mrvl,pxav3-mmc" or
> -  "marvell,armada-380-sdhci".
> -- reg:
> -  * for "mrvl,pxav2-mmc" and "mrvl,pxav3-mmc", one register area for
> -    the SDHCI registers.
> -
> -  * for "marvell,armada-380-sdhci", three register areas. The first
> -    one for the SDHCI registers themselves, the second one for the
> -    AXI/Mbus bridge registers of the SDHCI unit, the third one for the
> -    SDIO3 Configuration register
> -- reg names: should be "sdhci", "mbus", "conf-sdio3". only mandatory
> -  for "marvell,armada-380-sdhci"
> -- clocks: Array of clocks required for SDHCI; requires at least one for
> -    I/O clock.
> -- clock-names: Array of names corresponding to clocks property; shall be
> -    "io" for I/O clock and "core" for optional core clock.
> -
> -Optional properties:
> -- mrvl,clk-delay-cycles: Specify a number of cycles to delay for tuning.
> -
> -Example:
> -
> -sdhci@d4280800 {
> -       compatible = "mrvl,pxav3-mmc";
> -       reg = <0xd4280800 0x800>;
> -       bus-width = <8>;
> -       interrupts = <27>;
> -       clocks = <&chip CLKID_SDIO1XIN>, <&chip CLKID_SDIO1>;
> -       clock-names = "io", "core";
> -       non-removable;
> -       mrvl,clk-delay-cycles = <31>;
> -};
> -
> -sdhci@d8000 {
> -       compatible = "marvell,armada-380-sdhci";
> -       reg-names = "sdhci", "mbus", "conf-sdio3";
> -       reg = <0xd8000 0x1000>,
> -               <0xdc000 0x100>;
> -               <0x18454 0x4>;
> -       interrupts = <0 25 0x4>;
> -       clocks = <&gateclk 17>;
> -       clock-names = "io";
> -       mrvl,clk-delay-cycles = <0x1F>;
> -};
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
> new file mode 100644
> index 000000000000..27ea069aa5fc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
> @@ -0,0 +1,103 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/sdhci-pxa.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell PXA SDHCI v2/v3 bindings
> +
> +maintainers:
> +  - Ulf Hansson <ulf.hansson@linaro.org>
> +  - Rob Herring <robh+dt@kernel.org>
> +
> +allOf:
> +  - $ref: mmc-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: marvell,armada-380-sdhci
> +    then:
> +      properties:
> +        regs:
> +          minItems: 3
> +        reg-names:
> +          minItems: 3
> +      required:
> +        - reg-names
> +    else:
> +      properties:
> +        regs:
> +          maxItems: 1
> +        reg-names:
> +          maxItems: 1
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mrvl,pxav2-mmc
> +      - mrvl,pxav3-mmc
> +      - marvell,armada-380-sdhci
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 3
> +
> +  reg-names:
> +    items:
> +      - const: sdhci
> +      - const: mbus
> +      - const: conf-sdio3
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - const: io
> +      - const: core
> +
> +  mrvl,clk-delay-cycles:
> +    description: Specify a number of cycles to delay for tuning.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/berlin2.h>
> +    mmc@d4280800 {
> +        compatible = "mrvl,pxav3-mmc";
> +        reg = <0xd4280800 0x800>;
> +        bus-width = <8>;
> +        interrupts = <27>;
> +        clocks = <&chip CLKID_SDIO1XIN>, <&chip CLKID_SDIO1>;
> +        clock-names = "io", "core";
> +        non-removable;
> +        mrvl,clk-delay-cycles = <31>;
> +    };
> +  - |
> +    mmc@d8000 {
> +        compatible = "marvell,armada-380-sdhci";
> +        reg-names = "sdhci", "mbus", "conf-sdio3";
> +        reg = <0xd8000 0x1000>,
> +              <0xdc000 0x100>,
> +              <0x18454 0x4>;
> +        interrupts = <0 25 0x4>;
> +        clocks = <&gateclk 17>;
> +        clock-names = "io";
> +        mrvl,clk-delay-cycles = <0x1F>;
> +    };
> +
> +...
> --
> 2.26.2
>
