Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECD4C18E5B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 09:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77782074D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 09:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RlrMaBDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387734AbgDBJ5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 05:57:23 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37761 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgDBJ5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 05:57:23 -0400
Received: by mail-ot1-f67.google.com with SMTP id g23so2799220otq.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 02:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k7BONJVnKzuVhtjjNj+qftoNDxpPeWoFQFGqO2BllZ4=;
        b=RlrMaBDl00mz5wHT4OGSuNFqsCyjlszw2abHjiHD3AUxmMEGyUTX1P09R9ovOsGTAk
         AUgtBVGV0tova9mq6fSrTsS1/wdwaS5aZALgGP4iMWn+93lB3xUJOtxC6Tn/rk8llQH+
         QzWQnhhchF7mK+qv+rpfXEmPDtMctDhXEO0vIOzyIBgBzApFDCkMUwHx5VC7z5YDIcX9
         QpTvWFaLRnvhvv75fXJ+AN7f+oyLe+SZE8urzCsCxn0NTZ/TuzDz+Pczq0d17RegcRYT
         xfzSoXzH1+SVHB6fKoty/+ltaR7NsJPVoKDNGgd2sD0RVWRjw6f2NQI7uAiE+wDoJdVI
         Lz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k7BONJVnKzuVhtjjNj+qftoNDxpPeWoFQFGqO2BllZ4=;
        b=NIgOWgQBNaGGa3whAu5uR1XoQG4PGXhTw9WktP7TPzcUZDxnbyimyYlQOy7yDrc75p
         03UQXgQR3/NrzSZYdZiS7c8bL3MWWmj0aF9z2wUmNfVoBECRiX1NRGo/uuizn2MFtL05
         vEnc1euc5QZ/qw8/mqrQBu+MekCGTE5yvjAbxP3olQUrTSo5FpA1SB1BQJpHggHZPjVo
         Vf/+CwUR3trz5PDs3Uf3K32tndHNyK7zR0ls99z7oPgJOwSOYpp98LYhArrj2BhWfGtv
         9n85OVC8Nj99sYNqnPS6zfgGzCGFsWhJbMNlaHxsDueGVgpyM1yHUm4X6Z8cUwLU2gwq
         y1/A==
X-Gm-Message-State: AGi0PuYk/The3EfZaPLgV0kMdH9GMvaFl8n1NkQ9SFWamG9EXCatzpNH
        Y59EYKNTA6x7t4jqR3FRv16FaSXE64kJa4O9MTNBAtC7atuEMQ==
X-Google-Smtp-Source: APiQypJvsIEDz687agNDV5HB9tocDbOrr7IGIaIt4p+7ALU7k2BUZOZdtADN61SUSI+h6xq4jL10+O07CT29CbXFI1U=
X-Received: by 2002:a9d:27a7:: with SMTP id c36mr1717257otb.68.1585821441364;
 Thu, 02 Apr 2020 02:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200331133346.372517-1-robert.foss@linaro.org>
 <20200331133346.372517-2-robert.foss@linaro.org> <20200331151253.q6ody3erhvsabznz@pengutronix.de>
In-Reply-To: <20200331151253.q6ody3erhvsabznz@pengutronix.de>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 2 Apr 2020 11:57:10 +0200
Message-ID: <CAG3jFyvBmfwoSoKxZJPh2VcJe2aCYGWRRNmkuky3wU2jOsRwBQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] media: dt-bindings: ov8856: Document YAML bindings
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'Hey Marco,

On Tue, 31 Mar 2020 at 17:13, Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> Hi Robert,
>
> On 20-03-31 15:33, Robert Foss wrote:
> > From: Dongchun Zhu <dongchun.zhu@mediatek.com>
> >
> > This patch adds documentation of device tree in YAML schema for the
> > OV8856 CMOS image sensor.
> >
> > Signed-off-by: Dongchun Zhu <dongchun.zhu@mediatek.com>
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
> > ---
> >
> > - Changes since v5:
> >   * Add assigned-clocks and assigned-clock-rates
> >   * robher: dt-schema errors
> >
> > - Changes since v4:
> >   * Fabio: Change reset-gpio to GPIO_ACTIVE_LOW, explain in description
> >   * Add clock-lanes property to example
> >   * robher: Fix syntax error in devicetree example
> >
> > - Changes since v3:
> >   * robher: Fix syntax error
> >   * robher: Removed maxItems
> >   * Fixes yaml 'make dt-binding-check' errors
> >
> > - Changes since v2:
> >   Fixes comments from from Andy, Tomasz, Sakari, Rob.
> >   * Convert text documentation to YAML schema.
> >
> > - Changes since v1:
> >   Fixes comments from Sakari, Tomasz
> >   * Add clock-frequency and link-frequencies in DT
> >
> >  .../devicetree/bindings/media/i2c/ov8856.yaml | 150 ++++++++++++++++++
> >  MAINTAINERS                                   |   1 +
> >  2 files changed, 151 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/i2c/ov8856.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/media/i2c/ov8856.yaml b/Documentation/devicetree/bindings/media/i2c/ov8856.yaml
> > new file mode 100644
> > index 000000000000..beeddfbb8709
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/i2c/ov8856.yaml
> > @@ -0,0 +1,150 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright (c) 2019 MediaTek Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/i2c/ov8856.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Omnivision OV8856 CMOS Sensor Device Tree Bindings
> > +
> > +maintainers:
> > +  - Ben Kao <ben.kao@intel.com>
> > +  - Dongchun Zhu <dongchun.zhu@mediatek.com>
> > +
> > +description: |-
> > +  The Omnivision OV8856 is a high performance, 1/4-inch, 8 megapixel, CMOS
> > +  image sensor that delivers 3264x2448 at 30fps. It provides full-frame,
> > +  sub-sampled, and windowed 10-bit MIPI images in various formats via the
> > +  Serial Camera Control Bus (SCCB) interface. This chip is programmable
> > +  through I2C and two-wire SCCB. The sensor output is available via CSI-2
> > +  serial data output (up to 4-lane).
> > +
> > +properties:
> > +  compatible:
> > +    const: ovti,ov8856
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    description:
> > +      Input clock for the sensor.
> > +    items:
> > +      - const: xvclk
> > +
> > +  clock-frequency:
> > +    description:
> > +      Frequency of the xvclk clock in Hertz.
>
> Why do we need this here?
>
> > +  assigned-clocks:
> > +    description:
> > +      Input clock for the sensor.
> > +
> > +  assigned-clock-rates:
> > +    description:
> > +      Frequency of the xvclk clock in Hertz.
>
> Also this isn't related to the chip. You need this because you are using
> a qcom platform which provides the clock.
>
> IMHO you only need to specify the clock. You can get the frequency with
> the clk_get_rate() function.

The way I understood this, was that clk_get_rate() would fetch the
clock rate as defined by the 'assigned-clock-rates'
Is this not the case? And if so, what rate would cllk_get_rate()
actually retrieve?

>
> > +  dovdd-supply:
> > +    description:
> > +      Definition of the regulator used as interface power supply.
>
> Phandle to the interface power supply regulator?
>
> > +
> > +  avdd-supply:
> > +    description:
> > +      Definition of the regulator used as analog power supply.
> > +
> > +  dvdd-supply:
> > +    description:
> > +      Definition of the regulator used as digital power supply.
> > +
> > +  reset-gpios:
> > +    description:
> > +      The phandle and specifier for the GPIO that controls sensor reset.
> > +      This corresponds to the hardware pin XSHUTDOWN which is physically
> > +      active low.
> > +
> > +  port:
> > +    type: object
> > +    additionalProperties: false
> > +    description:
> > +      A node containing input and output port nodes with endpoint definitions
> > +      as documented in
> > +      Documentation/devicetree/bindings/media/video-interfaces.txt
> > +
> > +    properties:
> > +      endpoint:
> > +        type: object
> > +
> > +        properties:
> > +          clock-lanes:
> > +            maxItems: 1
> > +
> > +          data-lanes:
> > +            maxItems: 1
> > +
> > +          remote-endpoint: true
> > +
> > +        required:
> > +          - clock-lanes
> > +          - data-lanes
> > +          - remote-endpoint
> > +
> > +    required:
> > +      - endpoint
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - clock-frequency
> > +  - assigned-clocks
> > +  - assigned-clock-rates
> > +  - dovdd-supply
> > +  - avdd-supply
> > +  - dvdd-supply
> > +  - reset-gpios
> > +  - port
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/clock/qcom,camcc-sdm845.h>
>
> IMHO we should avoid examples with hardware specific includes.

The HW specific include is used for the clocks property.
clocks = <&clock_camcc CAM_CC_MCLK0_CLK>;

Is there a non hw specific clock that would be better to use for examples?

>
> > +
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        ov8856: camera@10 {
> > +            compatible = "ovti,ov8856";
> > +            reg = <0x10>;
> > +
> > +            reset-gpios = <&pio 111 GPIO_ACTIVE_LOW>;
> > +            pinctrl-names = "default";
> > +            pinctrl-0 = <&clk_24m_cam>;
> > +
> > +            clocks = <&clock_camcc CAM_CC_MCLK0_CLK>;
> > +            clock-names = "xvclk";
> > +            clock-frequency = <19200000>;
> > +            assigned-clocks = <&clock_camcc CAM_CC_MCLK0_CLK>;
> > +            assigned-clock-rates = <19200000>;
> > +
> > +            avdd-supply = <&mt6358_vcama2_reg>;
> > +            dvdd-supply = <&mt6358_vcamd_reg>;
> > +            dovdd-supply = <&mt6358_vcamio_reg>;
> > +
> > +            port {
> > +                wcam_out: endpoint {
> > +                    remote-endpoint = <&mipi_in_wcam>;
> > +                    clock-lanes = <0>;
> > +                    data-lanes = <1 2 3 4>;
> > +                    link-frequencies = /bits/ 64 <360000000 180000000>;
>
> Should we add the link-frequencies as optional param?
>
> Regards,
>   Marco
>
> > +                };
> > +            };
> > +        };
> > +    };
> > +...
> > \ No newline at end of file
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a6fbdf354d34..0f99e863978a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12355,6 +12355,7 @@ L:    linux-media@vger.kernel.org
> >  T:   git git://linuxtv.org/media_tree.git
> >  S:   Maintained
> >  F:   drivers/media/i2c/ov8856.c
> > +F:   Documentation/devicetree/bindings/media/i2c/ov8856.yaml
> >
> >  OMNIVISION OV9650 SENSOR DRIVER
> >  M:   Sakari Ailus <sakari.ailus@linux.intel.com>
> > --
> > 2.25.1
> >
> >
>
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
