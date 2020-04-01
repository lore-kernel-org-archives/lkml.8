Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE529C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FBF2077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="iJgSy+pp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732565AbgDANi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 09:38:27 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:33845 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732205AbgDANi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 09:38:27 -0400
Received: by mail-vk1-f196.google.com with SMTP id p123so6719327vkg.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 06:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tdGCqc9X95oHSJMV+qy+8plsVCVI++tvDUGtwBmzzE0=;
        b=iJgSy+ppUkCv23YRcokF5MvB1CtI9Q9oPoqYsxGBvu9wQipZSozOMMaBt5dk8Z64Pw
         pTqrH4QMYPH1T/fOh6ky2k1mwgCWG7thPsK0HAJKY+KXigsZcFA+vVdLs/+lh9GW4g30
         qbRMR59VqZieEJeHPKCmGXfF7UbjExFTSoH7GkWcm0/jwTeKIVdLWDpubhtHxQnMbAgz
         Ghv9x6l9K3/76kloSSkSjPNzkOp95zWBlJehfWWaBtJv76JVFxFIa+/Ygzb9Esu3jKuQ
         0hsOys1sDLjt4KEaEehzyUyS3F73eRnw2Mfvv0aRNpK0bNEezRK7eWIi7O8gknxzWU0R
         Eexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tdGCqc9X95oHSJMV+qy+8plsVCVI++tvDUGtwBmzzE0=;
        b=CHVf7X2xa4nF9/rQQZXQgaj1SBdanDNzz2oocY0KYoNBaJH3LkNUx851FVDM+oxr54
         6L2LJD8yXe0T5Q0KK50Iyn6iH516kwqE4WL9IlPyJ97qDZNNrdxpHfovSaRF5j1pV+JQ
         KUpOvwmupolczf2173x6GSSgl++dmHx6rVc9X0HM1LCVwCPTofJ2wtENCZndYRj1YpRg
         egxlfjNt3zqq4jUbgOgZX1Y48fl+K6Mbfu8+UdSt27Sv6MpeRoyb2MONpbJHPdA/lBbW
         zAF6DZA5XK41+9WZPqDrM3tWDYYHbWRLLLk53QRHhhNU6zGVZCtYo+GXBlNSsOJ5I30J
         2xBw==
X-Gm-Message-State: AGi0PuYb6DdJ/lkIDA9sihJDG8D5NQSDqqeDVCSRfcD5amCeDd3zb+VD
        eWzYJ6CC2InprGwAqSm+cy4YFFBKjLqlxDY4eDyewA==
X-Google-Smtp-Source: APiQypK82L+3ASqFUwhZ41FJdoIyKv5f4kEy867p4zztojbVdS++g9Yx4zgyKPjtA8Vk65/Js9wTmlxCm8JpqJ5m7bo=
X-Received: by 2002:a1f:ee05:: with SMTP id m5mr16812468vkh.9.1585748305004;
 Wed, 01 Apr 2020 06:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585738725.git.amit.kucheria@linaro.org>
 <146b5dfebf23321c1eed8190ada957e2264ffe65.1585738725.git.amit.kucheria@linaro.org>
 <da9860cf-0c2e-b7ff-47c2-19c79b06ad55@arm.com>
In-Reply-To: <da9860cf-0c2e-b7ff-47c2-19c79b06ad55@arm.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 1 Apr 2020 19:08:13 +0530
Message-ID: <CAHLCerMvwfBEGO6O9kHMg14AfJ1bEO7ZP4i=SH3XO6HCKucVKQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: thermal: Add yaml bindings for
 thermal sensors
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 6:10 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 4/1/20 12:15 PM, Amit Kucheria wrote:
> > As part of moving the thermal bindings to YAML, split it up into 3
> > bindings: thermal sensors, cooling devices and thermal zones.
> >
> > The property #thermal-sensor-cells is required in each device that acts
> > as a thermal sensor. It is used to uniquely identify the instance of the
> > thermal sensor inside the system.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >   .../bindings/thermal/thermal-sensor.yaml      | 72 +++++++++++++++++++
> >   1 file changed, 72 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/thermal-sensor.yaml b/Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
> > new file mode 100644
> > index 0000000000000..920ee7667591d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
> > @@ -0,0 +1,72 @@
> > +# SPDX-License-Identifier: (GPL-2.0)
> > +# Copyright 2020 Linaro Ltd.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/thermal/thermal-sensor.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Thermal sensor binding
> > +
> > +maintainers:
> > +  - Amit Kucheria <amitk@kernel.org>
> > +
> > +description: |
> > +  Thermal management is achieved in devicetree by describing the sensor hardware
> > +  and the software abstraction of thermal zones required to take appropriate
> > +  action to mitigate thermal overloads.
> > +
> > +  The following node types are used to completely describe a thermal management
> > +  system in devicetree:
> > +   - thermal-sensor: device that measures temperature, has SoC-specific bindings
> > +   - cooling-device: device used to dissipate heat either passively or artively
>
> s/artively/actively
>
> > +   - thermal-zones: a container of the following node types used to describe all
> > +     thermal data for the platform
> > +
> > +  This binding describes the thermal-sensor.
> > +
> > +  Thermal sensor devices provide temperature sensing capabilities on thermal
> > +  zones. Typical devices are I2C ADC converters and bandgaps. Thermal sensor
> > +  devices may control one or more internal sensors.
> > +
> > +properties:
> > +  "#thermal-sensor-cells":
> > +    description:
> > +      Used to uniquely identify a thermal sensor instance within an IC. Will be
> > +      0 on sensor nodes with only a single sensor and at least 1 on nodes
> > +      containing several internal sensors.
> > +    enum: [0, 1]
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    // Example 1: SDM845 TSENS
> > +    soc: soc@0 {
> > +            #address-cells = <2>;
> > +            #size-cells = <2>;
> > +
> > +            /* ... */
> > +
> > +            tsens0: thermal-sensor@c263000 {
> > +                    compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
> > +                    reg = <0 0x0c263000 0 0x1ff>, /* TM */
> > +                          <0 0x0c222000 0 0x1ff>; /* SROT */
> > +                    #qcom,sensors = <13>;
> > +                    interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
> > +                                 <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
> > +                    interrupt-names = "uplow", "critical";
> > +                    #thermal-sensor-cells = <1>;
> > +            };
> > +
> > +            tsens1: thermal-sensor@c265000 {
> > +                    compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
> > +                    reg = <0 0x0c265000 0 0x1ff>, /* TM */
> > +                          <0 0x0c223000 0 0x1ff>; /* SROT */
> > +                    #qcom,sensors = <8>;
> > +                    interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>,
> > +                                 <GIC_SPI 509 IRQ_TYPE_LEVEL_HIGH>;
> > +                    interrupt-names = "uplow", "critical";
> > +                    #thermal-sensor-cells = <1>;
> > +            };
> > +    };
> > +...
> >
>
> Apart from the above, looks good.
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Thanks for the review. Will spin a v5 with those trivial fixes.
