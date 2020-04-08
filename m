Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3775DC2BA1B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7362074F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="Hvo2oCqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgDHHal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 03:30:41 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44805 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgDHHak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 03:30:40 -0400
Received: by mail-vs1-f67.google.com with SMTP id s25so2157031vsp.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 00:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o2awHw9ue68/ioPQ/hcJMwV/cE3GRHWFi4nGkCXTPbg=;
        b=Hvo2oCqtE17cvDi5h706vd7Fxzwir+m/OZWa7BGhDLz6xJwaTOpq6XrMP+kPjV4Qzj
         bqanKuAY0pGptv9P9cfnMNx6Mj4Ihq55xfj5KmpRQyKxPVmwk9IWlfR+Utz2g9uaLLHM
         hQGcb3X4jAYuwQmAstYccEv7thXGDN54MFu1f5KJV+d5Nu19FbL9VM9BD2bEvzORYbob
         hSraiQY7Flb5jqULSSJkAqTqLglHZpY3u5/FKt/v2yIhzfjrYcCDRB4gJ5nVsYE9WLld
         6BDn5LxOMDz/uT8VGyOtmrRh4A6/ymYyeeTL3w05OtRcF5VsDKUKcgOlAybtCc0vD4BD
         j1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o2awHw9ue68/ioPQ/hcJMwV/cE3GRHWFi4nGkCXTPbg=;
        b=IhNpr1UKkMidw7e5LZqC6OAHcs0nK5lvB0/axzTVlxs9FVPSVHcDryMcSsjx5O8m46
         zUFSv3rOFbsZ2hzNe55QMNdyUvN+Uyam0BhH1cMMdSuZPXxETW4bntVqpO4u0QjjRzNZ
         euCf4Z3xzxkKGKI4jANIs0cx5diCBKtryyGnBN69AJ6ifuKnFSbMXSf5rsZT97J97r3j
         OK4jKORL7ZgTZiRYOgf+851Z6+sM+lBg9TciwU3NBiwh5VwO8M4oPQxnNyeJ90MRlx9C
         kmaAsoOgXLlKF3e/1bJCntJQsCQqzc6e1lZ4DGT1uVgeu0yXoRjRtqtkbfQfHzvRnhub
         4gaw==
X-Gm-Message-State: AGi0PubuTCymU6nxvDWkjQCaQPj0l34gu5iNOjiX0bWTlFAZ9P3YXisb
        O98Jsvr2/zhIQoNyqtW+HkwCHAxYuPP7TmtiJIJkHw==
X-Google-Smtp-Source: APiQypLTmXBd+2LWVSrhlxxqM9wlcwqHYDI3H4zuMX9eSDO877vQ5tMjIv6xmU/xvJo0Yfccvn/Nmu/8tLxAtcnnsGU=
X-Received: by 2002:a67:c594:: with SMTP id h20mr2746932vsk.95.1586331038462;
 Wed, 08 Apr 2020 00:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200407055116.16082-1-j-keerthy@ti.com> <20200407055116.16082-5-j-keerthy@ti.com>
In-Reply-To: <20200407055116.16082-5-j-keerthy@ti.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 8 Apr 2020 13:00:00 +0530
Message-ID: <CAHLCerNZqQj=DLkTdHbL5SSs3ufej5BdW+OBVqjuioL26Fn_iQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] arm64: dts: ti: am654: Add thermal zones
To:     Keerthy <j-keerthy@ti.com>
Cc:     Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, t-kristo@ti.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 11:21 AM Keerthy <j-keerthy@ti.com> wrote:
>
> The am654 SoC has three thermal zones namely MPU0, MPU1 and MCU
> zones.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi    |  4 ++
>  .../dts/ti/k3-am654-industrial-thermal.dtsi   | 45 +++++++++++++++++++
>  2 files changed, 49 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> index 98b89cf0ccdf..54a133fa1bf2 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> @@ -96,4 +96,8 @@
>                 power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
>                 #thermal-sensor-cells = <1>;
>         };
> +
> +       thermal_zones: thermal-zones {
> +               #include "k3-am654-industrial-thermal.dtsi"
> +       };
>  };
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi
> new file mode 100644
> index 000000000000..cdc3d40c3f60
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <dt-bindings/thermal/thermal.h>
> +
> +mpu0_thermal: mpu0_thermal {
> +       polling-delay-passive = <250>; /* milliseconds */
> +       polling-delay = <500>; /* milliseconds */
> +       thermal-sensors = <&wkup_vtm0 0>;
> +
> +       trips {
> +               mpu0_crit: mpu0_crit {
> +                       temperature = <125000>; /* milliCelsius */
> +                       hysteresis = <2000>; /* milliCelsius */
> +                       type = "critical";
> +               };
> +       };
> +};
> +
> +mpu1_thermal: mpu1_thermal {
> +       polling-delay-passive = <250>; /* milliseconds */
> +       polling-delay = <500>; /* milliseconds */
> +       thermal-sensors = <&wkup_vtm0 1>;
> +
> +       trips {
> +               mpu1_crit: mpu1_crit {
> +                       temperature = <125000>; /* milliCelsius */
> +                       hysteresis = <2000>; /* milliCelsius */
> +                       type = "critical";
> +               };
> +       };
> +};
> +
> +mcu_thermal: mcu_thermal {
> +       polling-delay-passive = <250>; /* milliseconds */
> +       polling-delay = <500>; /* milliseconds */
> +       thermal-sensors = <&wkup_vtm0 2>;
> +
> +       trips {
> +               mcu_crit: mcu_crit {
> +                       temperature = <125000>; /* milliCelsius */
> +                       hysteresis = <2000>; /* milliCelsius */
> +                       type = "critical";
> +               };
> +       };
> +};
> --
> 2.17.1
>
