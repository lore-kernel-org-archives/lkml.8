Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAA9C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 23:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A74720771
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 23:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="Cv/lLBw6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgGDXFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 19:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbgGDXFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 19:05:16 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A7BC061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 16:05:16 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id y2so35787260ioy.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 16:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1b6Zq/ik5y+6+UPTKmjgF9J8BXZfZn14G/55aee+vOQ=;
        b=Cv/lLBw6mtGXlAa7LIF7cVoxdGMYY12eWancBhuakyFL1HpB7dWYMH5CI+z1z4VOuF
         8Ci3H+OiSXvK0As1fPYjiVufpIeCleLANSJExyIi8xOG0Ut59Hjhk4dCO3K27vdyWLmM
         8YnOOrDM8XnvHJOyh3U7hNU2Z+DAAhmUZsHhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1b6Zq/ik5y+6+UPTKmjgF9J8BXZfZn14G/55aee+vOQ=;
        b=B0EFQ37sNeKMC9vaen540T5l6buCXa0PW1d1W0VWSjcMdiHEIyXeyEe5TuJWXonwOs
         B1xDFBK1GPgTgk3eSuu2SO0EQOfacbHOJwAQYHO4D17YaOGb3N9fl2+8B5boDWmU6niA
         QFBZH1J5te1HbNYh0AEumiDm/Lw+A5pNBLH3Mh2SXuekK5BX/F62HbXj63GUpxj4sWBq
         WMP8fJbRE5HZJWePdFhW+sXN6EBUJOsah4P8+LhiKO9FHQ8n5hYpAsxjB4LV6dC0IqYM
         6RC0yOCsPfjjYBhf7hZe/3lJQpz3CI5qEOzKuBpjF2hBdSXFcm7DJMNlpq3NvAYLVng1
         GWIg==
X-Gm-Message-State: AOAM531F2KVt0eEJVRtTLNQWPsyl2zdTG85YgejscmB5PUYJmnKWE68L
        glIEI93iwQdXKN08dUuw1/V+X1JuYrLtBTtzg9c8og==
X-Google-Smtp-Source: ABdhPJxYv5zm0JbEyLP8+KXGjGKOtsUS89Xi/utAR0f0EuTQ97QBiaZAu3cwWZP/1qHghry2/mlU7ciHVUmTMQwAELY=
X-Received: by 2002:a02:ba05:: with SMTP id z5mr40081280jan.127.1593903914549;
 Sat, 04 Jul 2020 16:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200704173459.78ceec60@archlinux> <20200704193345.18847-1-grandmaster@al2klimov.de>
In-Reply-To: <20200704193345.18847-1-grandmaster@al2klimov.de>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sat, 4 Jul 2020 16:05:01 -0700
Message-ID: <CAJCx=gmv67jh2aP14U-Jr=+SGPtzE8z5K-ax5dn9yM74SaVj+g@mail.gmail.com>
Subject: Re: [PATCH v2] Replace HTTP links with HTTPS ones: Documentation/devicetree/bindings/iio
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 4, 2020 at 12:34 PM Alexander A. Klimov
<grandmaster@al2klimov.de> wrote:
>
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
>

With regards to the drivers that I've authored the changes look good to me.

Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>


> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.
>
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Changes in v2:
>  Addressed https://lore.kernel.org/linux-iio/20200704173459.78ceec60@archlinux/
>
>  Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml  | 4 ++--
>  Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt      | 2 +-
>  Documentation/devicetree/bindings/iio/iio-bindings.txt        | 2 +-
>  Documentation/devicetree/bindings/iio/light/apds9300.txt      | 2 +-
>  Documentation/devicetree/bindings/iio/light/apds9960.txt      | 2 +-
>  Documentation/devicetree/bindings/iio/light/opt3001.txt       | 2 +-
>  Documentation/devicetree/bindings/iio/light/vl6180.txt        | 2 +-
>  .../devicetree/bindings/iio/potentiometer/mcp41010.txt        | 2 +-
>  .../devicetree/bindings/iio/potentiostat/lmp91000.txt         | 4 ++--
>  .../devicetree/bindings/iio/pressure/asc,dlhl60d.yaml         | 2 +-
>  .../devicetree/bindings/iio/proximity/devantech-srf04.yaml    | 4 ++--
>  11 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> index d124eba1ce54..fd4eaa3d0ab4 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> @@ -12,8 +12,8 @@ maintainers:
>  description: |
>    Analog Devices ADXL345/ADXL375 3-Axis Digital Accelerometers that supports
>    both I2C & SPI interfaces.
> -    http://www.analog.com/en/products/mems/accelerometers/adxl345.html
> -    http://www.analog.com/en/products/sensors-mems/accelerometers/adxl375.html
> +    https://www.analog.com/en/products/mems/accelerometers/adxl345.html
> +    https://www.analog.com/en/products/sensors-mems/accelerometers/adxl375.html
>
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
> index 639c94ed83e9..17af395b99d9 100644
> --- a/Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
> +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
> @@ -6,7 +6,7 @@ Is is programmable through an SPI interface.
>
>  The internal DACs are loaded when the LOADDACS pin is pulled down.
>
> -http://www.ti.com/lit/ds/sbas106/sbas106.pdf
> +https://www.ti.com/lit/ds/sbas106/sbas106.pdf
>
>  Required Properties:
>  - compatible: Should be one of:
> diff --git a/Documentation/devicetree/bindings/iio/iio-bindings.txt b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> index af33267727f4..aa63cac7323e 100644
> --- a/Documentation/devicetree/bindings/iio/iio-bindings.txt
> +++ b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> @@ -9,7 +9,7 @@ specifier is an array of one or more cells identifying the IIO
>  output on a device. The length of an IIO specifier is defined by the
>  value of a #io-channel-cells property in the IIO provider node.
>
> -[1] http://marc.info/?l=linux-iio&m=135902119507483&w=2
> +[1] https://marc.info/?l=linux-iio&m=135902119507483&w=2
>
>  ==IIO providers==
>
> diff --git a/Documentation/devicetree/bindings/iio/light/apds9300.txt b/Documentation/devicetree/bindings/iio/light/apds9300.txt
> index aa199e09a493..3aa6db3ee99d 100644
> --- a/Documentation/devicetree/bindings/iio/light/apds9300.txt
> +++ b/Documentation/devicetree/bindings/iio/light/apds9300.txt
> @@ -1,6 +1,6 @@
>  * Avago APDS9300 ambient light sensor
>
> -http://www.avagotech.com/docs/AV02-1077EN
> +https://www.avagotech.com/docs/AV02-1077EN
>
>  Required properties:
>
> diff --git a/Documentation/devicetree/bindings/iio/light/apds9960.txt b/Documentation/devicetree/bindings/iio/light/apds9960.txt
> index 3af325ad194b..c53ddb81c4aa 100644
> --- a/Documentation/devicetree/bindings/iio/light/apds9960.txt
> +++ b/Documentation/devicetree/bindings/iio/light/apds9960.txt
> @@ -1,6 +1,6 @@
>  * Avago APDS9960 gesture/RGB/ALS/proximity sensor
>
> -http://www.avagotech.com/docs/AV02-4191EN
> +https://www.avagotech.com/docs/AV02-4191EN
>
>  Required properties:
>
> diff --git a/Documentation/devicetree/bindings/iio/light/opt3001.txt b/Documentation/devicetree/bindings/iio/light/opt3001.txt
> index 47b13eb8f4ec..9e6f2998e751 100644
> --- a/Documentation/devicetree/bindings/iio/light/opt3001.txt
> +++ b/Documentation/devicetree/bindings/iio/light/opt3001.txt
> @@ -6,7 +6,7 @@ the optional generation of IIO events on rising/falling light threshold changes
>  requires the use of interrupts. Without interrupts, only the simple reading
>  of the current light value is supported through the IIO API.
>
> -http://www.ti.com/product/opt3001
> +https://www.ti.com/product/opt3001
>
>  Required properties:
>    - compatible: should be "ti,opt3001"
> diff --git a/Documentation/devicetree/bindings/iio/light/vl6180.txt b/Documentation/devicetree/bindings/iio/light/vl6180.txt
> index 2c52952715a0..fb9137d85df9 100644
> --- a/Documentation/devicetree/bindings/iio/light/vl6180.txt
> +++ b/Documentation/devicetree/bindings/iio/light/vl6180.txt
> @@ -1,6 +1,6 @@
>  STMicro VL6180 -  ALS, range and proximity sensor
>
> -Link to datasheet: http://www.st.com/resource/en/datasheet/vl6180x.pdf
> +Link to datasheet: https://www.st.com/resource/en/datasheet/vl6180x.pdf
>
>  Required properties:
>
> diff --git a/Documentation/devicetree/bindings/iio/potentiometer/mcp41010.txt b/Documentation/devicetree/bindings/iio/potentiometer/mcp41010.txt
> index 566711b9950c..4f245e8469fd 100644
> --- a/Documentation/devicetree/bindings/iio/potentiometer/mcp41010.txt
> +++ b/Documentation/devicetree/bindings/iio/potentiometer/mcp41010.txt
> @@ -1,7 +1,7 @@
>  * Microchip MCP41010/41050/41100/42010/42050/42100 Digital Potentiometer
>
>  Datasheet publicly available at:
> -http://ww1.microchip.com/downloads/en/devicedoc/11195c.pdf
> +https://ww1.microchip.com/downloads/en/devicedoc/11195c.pdf
>
>  The node for this driver must be a child node of a SPI controller, hence
>  all mandatory properties described in
> diff --git a/Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt b/Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt
> index e6d0c2eb345c..f3ab02b0dd41 100644
> --- a/Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt
> +++ b/Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt
> @@ -1,7 +1,7 @@
>  * Texas Instruments LMP91000 series of potentiostats
>
> -LMP91000: http://www.ti.com/lit/ds/symlink/lmp91000.pdf
> -LMP91002: http://www.ti.com/lit/ds/symlink/lmp91002.pdf
> +LMP91000: https://www.ti.com/lit/ds/symlink/lmp91000.pdf
> +LMP91002: https://www.ti.com/lit/ds/symlink/lmp91002.pdf
>
>  Required properties:
>
> diff --git a/Documentation/devicetree/bindings/iio/pressure/asc,dlhl60d.yaml b/Documentation/devicetree/bindings/iio/pressure/asc,dlhl60d.yaml
> index 64c18f1693f0..be2be4b556db 100644
> --- a/Documentation/devicetree/bindings/iio/pressure/asc,dlhl60d.yaml
> +++ b/Documentation/devicetree/bindings/iio/pressure/asc,dlhl60d.yaml
> @@ -13,7 +13,7 @@ description: |
>    Bindings for the All Sensors DLH series pressure sensors.
>
>    Specifications about the sensors can be found at:
> -    http://www.allsensors.com/cad/DS-0355_Rev_B.PDF
> +    https://www.allsensors.com/cad/DS-0355_Rev_B.PDF
>
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
> index f86f8b23ef18..ce795279839e 100644
> --- a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
> +++ b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
> @@ -17,9 +17,9 @@ description: |
>      until it is received once again
>
>    Specifications about the devices can be found at:
> -  http://www.robot-electronics.co.uk/htm/srf04tech.htm
> +  https://www.robot-electronics.co.uk/htm/srf04tech.htm
>
> -  http://www.maxbotix.com/documents/LV-MaxSonar-EZ_Datasheet.pdf
> +  https://www.maxbotix.com/documents/LV-MaxSonar-EZ_Datasheet.pdf
>
>  properties:
>    compatible:
> --
> 2.27.0
>
