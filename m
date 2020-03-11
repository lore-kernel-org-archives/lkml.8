Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,PDS_HP_HELO_NORDNS,RDNS_NONE,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39476 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgCKI1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:27:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id f10so1293565ljn.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 01:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583412540.git.amit.kucheria@linaro.org> <93466e6c031c0084de09bd6b448556a6c5080880.1583412540.git.amit.kucheria@linaro.org>
In-Reply-To: <93466e6c031c0084de09bd6b448556a6c5080880.1583412540.git.amit.kucheria@linaro.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 11 Mar 2020 09:26:56 +0100
Message-ID:
 <CAKfTPtBXaVww5fdU5HpWWH1-H3dKr2s=Uvdr==wf669BtKnyvQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: thermal: Add yaml bindings for
 thermal sensors
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
Message-ID: <20200311082656.td2HZPFdzPjXxE9OcRudt4G1H-1xu0wqTHyt5atI5-M@z>

On Thu, 5 Mar 2020 at 13:56, Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> As part of moving the thermal bindings to YAML, split it up into 3
> bindings: thermal sensors, cooling devices and thermal zones.
>
> The property #thermal-sensor-cells is required in each device that acts
> as a thermal sensor. It is used to uniquely identify the instance of the
> thermal sensor inside the system.
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  .../bindings/thermal/thermal-sensor.yaml      | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
>
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-sensor.yaml b/Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
> new file mode 100644
> index 0000000000000..920ee7667591d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0)
> +# Copyright 2020 Linaro Ltd.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/thermal-sensor.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Thermal sensor binding
> +
> +maintainers:
> +  - Amit Kucheria <amitk@kernel.org>
> +
> +description: |
> +  Thermal management is achieved in devicetree by describing the sensor hardware
> +  and the software abstraction of thermal zones required to take appropriate
> +  action to mitigate thermal overloads.
> +
> +  The following node types are used to completely describe a thermal management
> +  system in devicetree:
> +   - thermal-sensor: device that measures temperature, has SoC-specific bindings
> +   - cooling-device: device used to dissipate heat either passively or artively

typo: s/artively/actively/

> +   - thermal-zones: a container of the following node types used to describe all
> +     thermal data for the platform
> +
> +  This binding describes the thermal-sensor.
> +
> +  Thermal sensor devices provide temperature sensing capabilities on thermal
> +  zones. Typical devices are I2C ADC converters and bandgaps. Thermal sensor
> +  devices may control one or more internal sensors.
> +
> +properties:
> +  "#thermal-sensor-cells":
> +    description:
> +      Used to uniquely identify a thermal sensor instance within an IC. Will be
> +      0 on sensor nodes with only a single sensor and at least 1 on nodes
> +      containing several internal sensors.
> +    enum: [0, 1]
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    // Example 1: SDM845 TSENS
> +    soc: soc@0 {
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +
> +            /* ... */
> +
> +            tsens0: thermal-sensor@c263000 {
> +                    compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
> +                    reg = <0 0x0c263000 0 0x1ff>, /* TM */
> +                          <0 0x0c222000 0 0x1ff>; /* SROT */
> +                    #qcom,sensors = <13>;
> +                    interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
> +                                 <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
> +                    interrupt-names = "uplow", "critical";
> +                    #thermal-sensor-cells = <1>;
> +            };
> +
> +            tsens1: thermal-sensor@c265000 {
> +                    compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
> +                    reg = <0 0x0c265000 0 0x1ff>, /* TM */
> +                          <0 0x0c223000 0 0x1ff>; /* SROT */
> +                    #qcom,sensors = <8>;
> +                    interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>,
> +                                 <GIC_SPI 509 IRQ_TYPE_LEVEL_HIGH>;
> +                    interrupt-names = "uplow", "critical";
> +                    #thermal-sensor-cells = <1>;
> +            };
> +    };
> +...
> --
> 2.20.1
>

