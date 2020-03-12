Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8413C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E97520716
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584051188;
	bh=dcD3PQuS143erOCvzUImAA+jsmHDh72jg6zK7TfHatA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qe9JSC+qxG45UoKk72xt0Dovql4TKYDAFxqPzhfVfMZNeFv5BTNBTzOJqmeMBnFq5
	 YbT/4NCyca97Eg+1NJRpaosDJa3N+uzv7SCa0a5WAq96eRvDDuMemPh96quD+z9t/M
	 /CMx9CPo1+7HG3wKhuZYXydSEsHbbkcMVhf97/Ug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgCLWNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:13:07 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35512 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgCLWNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 18:13:07 -0400
Received: by mail-oi1-f196.google.com with SMTP id k8so5801991oik.2;
        Thu, 12 Mar 2020 15:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0zNdctRyYMb4dv2GGX3Pw1gNp6pyPYjK0qq28+cNxpA=;
        b=Ba8jPja/Qa4kyz2QGIXgwQ6QBWXtMEPtmAp5krhaYXmDuqGJuM1wV6HENgqBaGaqIb
         vdsTofcHfk89KdGYaU4e+9rE3Yh12yRPGcxm/Tw3aCdwftTQFq6yo/wSKIAlHHm3ZLt5
         UkMtCv4opi6gtg05ND/BpMQsVmUemMf6WMmNJ6aoXVVhNjwdGQ+GaTUstkqvwaeUm4M+
         Oq2dCurqAcDQY3PxXrfqbUsAyYUf+IA5RsPN0xAYi7Flls5tYtfJ8tl4Pim+VOv2Ro/I
         guap9vz4tLI1IjrynJO9TL2KdgSO8v86X/eZB/uke2LkeJuuaIKdgfjXq6c6ZnZTktyY
         2smA==
X-Gm-Message-State: ANhLgQ2aCKFzO+iMYfqD1f0T0GOuX5JAUFX0pGO+s95C/K6PQ3wXgCai
        PVc/fR8ySJlxm6kmhOWz4g==
X-Google-Smtp-Source: ADFU+vsxg8cBnb7IRhMYqYaauPOczU1VRJHFbD6vCZeBEUlh+765naNrw3vPCM3Kk/SehoQEL6ZD9Q==
X-Received: by 2002:aca:5345:: with SMTP id h66mr2696847oib.110.1584051186346;
        Thu, 12 Mar 2020 15:13:06 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y34sm3354453ota.1.2020.03.12.15.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 15:13:05 -0700 (PDT)
Received: (nullmailer pid 6785 invoked by uid 1000);
        Thu, 12 Mar 2020 22:13:04 -0000
Date:   Thu, 12 Mar 2020 17:13:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sergey.Semin@baikalelectronics.ru
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Maxim Kaurkin <maxim.kaurkin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Add Baikal-T1 PVT sensor bindings
Message-ID: <20200312221304.GA31909@bogus>
References: <20200306132604.14312-1-Sergey.Semin@baikalelectronics.ru>
 <20200306132620.4ADCF8030702@mail.baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306132620.4ADCF8030702@mail.baikalelectronics.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 04:26:03PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> Baikal-T1 SoC is equipped with an embedded process, voltage and
> temperature sensor to monitor the chip internal environment like
> temperature, supply voltage and transistors performance.
> 
> This bindings describes the external Baikal-T1 PVT control interfaces
> like MMIO registers space, interrupt request number and clocks source.
> These are then used by the corresponding hwmon device driver to
> implement the sysfs files-based access to the sensors functionality.
> 
> Signed-off-by: Maxim Kaurkin <maxim.kaurkin@baikalelectronics.ru>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> ---
>  .../devicetree/bindings/hwmon/be,bt1-pvt.yaml | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/be,bt1-pvt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/be,bt1-pvt.yaml b/Documentation/devicetree/bindings/hwmon/be,bt1-pvt.yaml
> new file mode 100644
> index 000000000000..d575d124d538
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/be,bt1-pvt.yaml
> @@ -0,0 +1,100 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license

> +#
> +# Copyright (C) 2019 BAIKAL ELECTRONICS, JSC
> +#
> +# Baikal-T1 Process, Voltage, Temperature Sensor Device Tree Bindings.

drop

> +#
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/be,bt1-pvt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Baikal-T1 PVT Sensor Device Tree Bindings
> +
> +maintainers:
> +  - Serge Semin <fancer.lancer@gmail.com>
> +
> +description: |
> +  Baikal-T1 SoC provides an embedded process, voltage and temperature
> +  sensor to monitor an internal SoC environment (chip temperature, supply
> +  voltage and process monitor) and on time detect critical situations,
> +  which may cause the system instability and even damages. The IP-block
> +  is based on the Analog Bits PVT sensor, but is equipped with a dedicated
> +  control wrapper, which provides a MMIO registers-based access to the
> +  sensor core functionality (APB3-bus based) and exposes an additional
> +  functions like thresholds/data ready interrupts, its status and masks,
> +  measurements timeout. Its internal structure is depicted on the next
> +  diagram:
> +     Analog Bits core                     Bakal-T1 PVT control block
> +  +--------------------+                  +------------------------+
> +  | Temperature sensor |-+         +------| Sensors control        |
> +  |--------------------| |<---En---|      |------------------------|
> +  | Voltage sensor     |-|<--Mode--| +--->| Sampled data           |
> +  |--------------------| |<--Trim--+ |    |------------------------|
> +  | Low-Vt sensor      |-|           | +--| Thresholds comparator  |
> +  |--------------------| |---Data----| |  |------------------------|
> +  | High-Vt sensor     |-|           | +->| Interrupts status      |
> +  |--------------------| |--Valid--+-+ |  |------------------------|
> +  | Standard-Vt sensor |-+         +---+--| Interrupts mask        |
> +  +--------------------+                  |------------------------|
> +           ^                              | Interrupts timeout     |
> +           |                              +------------------------+
> +           |                                        ^  ^
> +  Rclk-----+----------------------------------------+  |
> +  APB3-------------------------------------------------+
> +
> +  This bindings describes the external Baikal-T1 PVT control interfaces
> +  like MMIO registers space, interrupt request number and clocks source.
> +  These are then used by the corresponding hwmon device driver to
> +  implement the sysfs files-based access to the sensors functionality.
> +
> +properties:
> +  compatible:
> +    const: be,bt1-pvt
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: PVT reference clock.
> +      - description: APB3 interface clock.
> +
> +  clock-names:
> +    items:
> +      - const: ref
> +      - const: pclk
> +
> +  "#thermal-sensor-cells":
> +      description: Baikal-T1 can be referenced as the CPU thermal-sensor.
> +      const: 0
> +
> +additionalProperties: false
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
> +    #include <dt-bindings/interrupt-controller/mips-gic.h>
> +    #include <dt-bindings/clock/bt1-ccu.h>
> +
> +    pvt: pvt@1F200000 {

lowercase hex

> +      compatible = "be,bt1-pvt";
> +      reg = <0x1F200000 0x1000>;
> +      #thermal-sensor-cells = <0>;
> +
> +      interrupts = <GIC_SHARED 31 IRQ_TYPE_LEVEL_HIGH>;
> +
> +      clocks = <&ccu_sys CCU_SYS_PVT_CLK>,
> +               <&ccu_sys CCU_SYS_APB_CLK>;
> +      clock-names = "ref", "pclk";
> +    };
> +...
> -- 
> 2.25.1
> 
