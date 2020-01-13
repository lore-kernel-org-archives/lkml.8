Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C14BC33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C932080D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578934799;
	bh=C887XgOr4yGGRx4kPw2J3hdbZjSJ9qRttgMw4Hl24fg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ycWa8CaGnn0M4miA8TPeBj57VUVKkJjucBSl84hQ0vZ0ieordiRaZABlHOjdqt9aP
	 +c20hQzGXvHYjpx69LyHc1gu+tPrJ8g1n5qFsjU/oYV/IpEnVlCZZ9rOStd4TdZwRW
	 mZdDjNKL7n964/OJH3vOOszHNcaaMvLgJi2CSGTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgAMQ76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 11:59:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:55668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbgAMQ76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:59:58 -0500
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53BBF2084D;
        Mon, 13 Jan 2020 16:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578934797;
        bh=C887XgOr4yGGRx4kPw2J3hdbZjSJ9qRttgMw4Hl24fg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1D9C8fHU2yZUL+2lmol0ZrU01jwRVA5wBpRHU7VvTXBBmtti9KxXA7KN+eRcVoWtN
         iuQO2VyLDLK8f9zxic3EpKNLWVAH+cPfJ7CA0Sm5xdFsPLvm1m6cmYr13FHchedfzT
         TitcgIyfNDw3yBWs1kw/L2DdUy6OikKQoSBAXQRI=
Received: by mail-qk1-f178.google.com with SMTP id z14so9124248qkg.9;
        Mon, 13 Jan 2020 08:59:57 -0800 (PST)
X-Gm-Message-State: APjAAAU1CMOZX6t9fi4m2Lxdgb7tXpe3nP50WrE8f3zGC7nZ87CFOBhx
        aZdzq1nhQPaS8SgHyKEORkJFJRyZAA05dHuHDg==
X-Google-Smtp-Source: APXvYqz93q70e0350aIvmLIJU7kxKgWIl0XefSuOVzohskiP5LP9GN3+ujbynT3tGLo2ZX5BR125F9sDL29+B1OPGKw=
X-Received: by 2002:ae9:f205:: with SMTP id m5mr17209224qkg.152.1578934796459;
 Mon, 13 Jan 2020 08:59:56 -0800 (PST)
MIME-Version: 1.0
References: <20200107105929.18938-1-beniamin.bia@analog.com> <20200107105929.18938-2-beniamin.bia@analog.com>
In-Reply-To: <20200107105929.18938-2-beniamin.bia@analog.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 13 Jan 2020 10:59:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLF+zB4pv_FT=oPMCHFRYELCW-vrbLDZjkDOnp5uTYFEQ@mail.gmail.com>
Message-ID: <CAL_JsqLF+zB4pv_FT=oPMCHFRYELCW-vrbLDZjkDOnp5uTYFEQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-binding: hwmon: Add documentation for ADM1177
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     Linux HWMON List <linux-hwmon@vger.kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        biabeniamin@outlook.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 7, 2020 at 4:58 AM Beniamin Bia <beniamin.bia@analog.com> wrote:
>
> Documentation for ADM1177 was added.
>
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes in v3:
> -nothing changed
>
>  .../bindings/hwmon/adi,adm1177.yaml           | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml

This is breaking linux-next. Please fix and run 'make dt_binding_check':

Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml: while
scanning a block scalar
  in "<unicode string>", line 51, column 5
 found a tab character where an indentation space is expected
  in "<unicode string>", line 61, column 1
>
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
> new file mode 100644
> index 000000000000..65ef95328bc6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/adi,adm1177.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADM1177 Hot Swap Controller and Digital Power Monitor
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +  - Beniamin Bia <beniamin.bia@analog.com>
> +
> +description: |
> +  Analog Devices ADM1177 Hot Swap Controller and Digital Power Monitor
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADM1177.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adm1177
> +
> +  reg:
> +    maxItems: 1
> +
> +  avcc-supply:
> +    description:
> +      Phandle to the Avcc power supply
> +
> +  shunt-resistor-micro-ohms:
> +    description:
> +      The value of curent sense resistor in microohms. If not provided,
> +      the current reading and overcurrent alert is disabled.
> +
> +  adi,shutdown-threshold-microamp:
> +    description:
> +      Specifies the current level at which an over current alert occurs.
> +      If not provided, the overcurrent alert is configured to max ADC range
> +      based on shunt-resistor-micro-ohms.
> +
> +  adi,vrange-high-enable:
> +    description:
> +      Specifies which internal voltage divider to be used. A 1 selects
> +      a 7:2 voltage divider while a 0 selects a 14:1 voltage divider.
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pwmon@5a {
> +                compatible = "adi,adm1177";
> +                reg = <0x5a>;
> +               shunt-resistor-micro-ohms = <50000>; /* 50 mOhm */
> +                adi,shutdown-threshold-microamp = <1059000>; /* 1.059 A */
> +                adi,vrange-high-enable;
> +        };
> +    };
> +...
> --
> 2.17.1
>
