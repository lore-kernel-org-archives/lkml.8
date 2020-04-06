Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D813C2BA1B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E2C206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="bOB0LqZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgDFTEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:04:31 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:36762 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgDFTEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 15:04:30 -0400
Received: by mail-ua1-f65.google.com with SMTP id m15so363948uao.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 12:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dKSOuUapGnWf3Hq2VKiORYvF7/gi1e0olK/3vh44kQQ=;
        b=bOB0LqZRTfAo6bdJQM33HQTyFUvLOR2z0Foi8Jb7TOSz1Og4RBWGZeKA4kZ/KpEEAp
         lAEpgpzt0q6aG5DTLjV4xRZnSYIp0ZzUTqyGwsDsiCON6vSw4wMh362yvErfWIEjIFtE
         Wa+l+6HD1L6snPqXyu03v/xIPeJB9BnUfoLrY6RgTLjRXZdnoRb04+OZOWBvFSzLCXmG
         Lczq/lgonbLYzFjzZZBUwzc41Ae9iurYnVUxNbq3GDCxYejuuHJkSx8X/MQ2/WEHfbVC
         Y/gPn+28cj89NxAFAFKPa/J8wNu1zga0PppWe0Z6j9DtuYOUV0tBIJCUQnHtf0qtUtqy
         mRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dKSOuUapGnWf3Hq2VKiORYvF7/gi1e0olK/3vh44kQQ=;
        b=c3pVGkP5rW7is+57pBiiAr6qfhnd/p0xjyNg9g5G+Ulz7gCIUe0oWGWWh2harATAoT
         VMLHU4VGLN8OvxpKFqclziHRXh2r4YPN0+Cp0qunVflHJtBoP9qx/QdUDJKE+pJC+rj+
         40TQEaDAxGwZs2ETPQihCnOn7nX2CiD/5vPfsrexGdBggqmRBdugc4lDl97MJ69JfdfQ
         wvQhFpk00Bq0akyWD00RqQv9Pio1M1f3wK1b/7gCMfu/5BjoN6cwVkdaIUdRlp14Sh9T
         4N19b13BD0KgN9/XeiEWZLP3td9VlijmwnO9+Y4Pca4pgJLOpKJ/YMggBHATse4BW8h+
         MKjA==
X-Gm-Message-State: AGi0Pubq661NHLOYvCVNsYMbri2E1elIxqsZa4C/I1+FFG4SNfF6SNAu
        pBdsioCQzYL0gPN5+ipVShQrt0A6BjLrlJzfnatvaQ==
X-Google-Smtp-Source: APiQypIK/YDmw7c24JNIRU7dH38DelSt/uLu7XVUJgDjKlcvdhZlf2ykNjo+z5hkGjCXR2mqiEa0SbEjT9HPUmZGtmU=
X-Received: by 2002:ab0:5f90:: with SMTP id b16mr805358uaj.77.1586199867533;
 Mon, 06 Apr 2020 12:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200331075356.19171-1-j-keerthy@ti.com> <20200331075356.19171-4-j-keerthy@ti.com>
In-Reply-To: <20200331075356.19171-4-j-keerthy@ti.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Tue, 7 Apr 2020 00:34:16 +0530
Message-ID: <CAHLCerP3usTcNeRwGekWG6xGdAQedZfoegtfsda8O-OHW9i-oQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] arm64: dts: ti: am654: Add thermal zones
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

On Tue, Mar 31, 2020 at 1:24 PM Keerthy <j-keerthy@ti.com> wrote:
>
> The am654 SoC has three thermal zones namely MPU0, MPU1 and MCU
> zones
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  .../dts/ti/k3-am654-industrial-thermal.dtsi   | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi
>
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

You are referencing the wkup_vtm0 node before defining it in the next patch.

Swap the order of the patches and move the include for thermal zones
to this patch.

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
