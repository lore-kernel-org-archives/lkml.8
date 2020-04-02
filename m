Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F55C2BA13
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 10:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8089C20857
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 10:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eihORtTg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387936AbgDBKKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 06:10:13 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38444 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387895AbgDBKKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 06:10:12 -0400
Received: by mail-ot1-f68.google.com with SMTP id t28so2829054ott.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 03:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MRdlSIlWiqiUEn9v/+BSCM98gAfMn515+Qx9Pso1+1M=;
        b=eihORtTgxTZlcrTJ/9m6HDeGAe36CEbjF+saO5ljAmLWT/D8IrrbD/k7YTxI3xWXO4
         ylnchmXj5sp9VZ7zqA/HMR7QDWFcrBNQcuwNPbNnQ4dMocOW51OLPY7OTJak3JK+Oqwp
         GJzYConXFZ8RL2W+vQ+t4j9yLNaKA5VskegVJPg0L9KNMDortPbE8UtViAiQ3oQZiqeT
         1C6N66XvBAyAOgQRTKQBfB7K6CRqR/HMkJsA/8LbB6Sa9nSQ2ohnRRwPAUntCv1JAQ84
         /GgKhieuyOZS50zZ7AjXCxCpmCE+LFNkJl6FW2xiKh2c8FWNGJI4LJFGlhKdoGpRw8/X
         Uvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MRdlSIlWiqiUEn9v/+BSCM98gAfMn515+Qx9Pso1+1M=;
        b=MFwUWSo/Ptije+zTgQ06Nd5rY40mpqBHtvDjdlxfdtt6OERpzytz0p9B2dyiKzndwL
         3rjAuXQ1tmjD9PDWcgvyoCtptXvbQkeJ0qWoIcGuOBIPuz1q8s08j5wqGphiDv6TRxk7
         FErd7YE3qSR1FbjfT9zwBtQss52X08JCsh9TdNtQg0KwsJ3kAV9IeurDKtBtxe73oqYX
         BiEYhsGdho6lpyDjwLM+tpzFmKQ/XBwaDm5fYzy/30lGA68bHJixxKnuKNxXOdXtKWPT
         kBXZUuShw7k1WeJNKPcOXCcR1hLjp3/RdTB/TWQW/NriMM/KfJOWFkofJ5EwUfxrdBQH
         XlHQ==
X-Gm-Message-State: AGi0PuZOXLvTl9uasBhntrZI7GM8tal3nSv7HQMD2v5C8tMUTxFjRTvY
        UM8g74NICUsNg8rV/9cW+Vqg1+k9LgkVkCJC8wR/4g==
X-Google-Smtp-Source: APiQypKBm/Lg+9lw65OG6XgOJFxflgoP4WFpsTputiWXnE3eeGtQPAOXhxBX+bGTFsX8n8K4MxbqvgyMTSSGZvo3ZmQ=
X-Received: by 2002:a9d:6c88:: with SMTP id c8mr1673754otr.272.1585822211618;
 Thu, 02 Apr 2020 03:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200331133346.372517-1-robert.foss@linaro.org>
 <20200331133346.372517-2-robert.foss@linaro.org> <20200401080705.j4goeqcqhoswhx4u@gilmour.lan>
In-Reply-To: <20200401080705.j4goeqcqhoswhx4u@gilmour.lan>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 2 Apr 2020 12:10:00 +0200
Message-ID: <CAG3jFyvUd08U9yNVPUD9Y=nd5Xpcx34GcHJRhtvAAycoq3qimg@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] media: dt-bindings: ov8856: Document YAML bindings
To:     Maxime Ripard <maxime@cerno.tech>
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

Hey Maxime,

On Wed, 1 Apr 2020 at 10:07, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi,
>
> On Tue, Mar 31, 2020 at 03:33:44PM +0200, Robert Foss wrote:
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
> We also had that discussion recently for another omnivision sensor
> (ov5645 iirc), but what is clock-frequency useful for?
>
> It seems that the sensor is passed in clocks, so if you need to
> retrieve the clock rate you should use the clock API instead.
>
> Looking at the driver, it looks like it first retrieves the clock, set
> it to clock-frequency, and then checks that this is OV8856_XVCLK_19_2
> (19.2 MHz).

As far as I understand it, 19.2MHz is requirement for the sensor mode
that currently defaults to. Some modes require higher clock speeds
than this however.

>
> The datasheet says that the sensor can have any frequency in the 6 -
> 27 MHz range, so this is a driver limitation and should be set in the
> driver using the clock API, and you can always bail out if it doesn't
> provide a rate that is not acceptable for the drivers assumption.
>
> In any case, you don't need clock-frequency here...

So your suggestion is that we remove all clocks-rate properties, and
replace the clk_get_rate() calls in the driver with clk_set_rate()
calls for the desired frequencies?

>
> > +  assigned-clocks:
> > +    description:
> > +      Input clock for the sensor.
> > +
> > +  assigned-clock-rates:
> > +    description:
> > +      Frequency of the xvclk clock in Hertz.
>
> And you don't need assigned-clock-rates either.

Ack.

>
> Maxime
