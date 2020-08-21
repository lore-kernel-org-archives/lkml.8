Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3925C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 06:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9960D207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 06:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n/dLDodq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgHUGKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 02:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgHUGKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 02:10:10 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E590EC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 23:10:09 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id e14so289283vsa.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 23:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6CmmgnaEzkt8llRqb27IcigQQKm5dN+mhMmyEDhAUQk=;
        b=n/dLDodqrSi2QB2NGxsN6yXv5Tg9CpKMDa66Um9hF+QjroPOw64gYF4gqU5woqMZtJ
         R+scaji4pRdg3ma/nDLaVbAN45CvPK0Lg4t1CCGsuWYChQaeeP/3NKBoDcLPMym+3VA/
         06dyXDJubrHzRGJhLGSTaOt9c1iJ4lRkpRu8mQLABuuQKDVlst69zZAgW5AqI0PUuAfD
         DXVYvnV0Qg7OgA3QcJgY1soIJkG5NLVQXkKbr51wM2ntqJGV9uAwtCIB7mKGfmBX8dPe
         7A+ucfhGHlbbzP+Ige6COlCwpnrebTI2oImQqSyUzj50/wdcpV63M2rmL//XogsOosiz
         8mqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6CmmgnaEzkt8llRqb27IcigQQKm5dN+mhMmyEDhAUQk=;
        b=Bs7kvSlvnabOhW/bUbIkWj1MIExi21NwDqTs5TPWMQex8BC66qUtGNm1edWG8uBMb1
         bwIbYbbE3+JUsx1KXNO16c6whOKufJ+Gm2gLH6DWop8F15gCrfYObkfLt6GMf3VrSwOR
         hU+8w7zHK9WrA3sBJISBVnjQ9wx4WG0hZINuDT9azNomq52aJIOuHHZU2aUoK5FHGgZ0
         meTqPVIZ56lOmi/5wQypUShymSP0mwQBSBitSs8ISXs2kF3MXGBliqansmrCAsMva9Tf
         60W10/wUWha7WKmIktG+634wvq77YobpSL5R0Ri5eyYa70CvRUgNLtLfFn7OB/1YWQnV
         roXw==
X-Gm-Message-State: AOAM532Q4/nBsqw6EOAWsWM7vFRCJNzUOJIZvkVwCy7uvCjXC3sCCuUg
        C/STEtfXxAwZdCgsw5YDsFmyjTrp6qO0EIarsIBr4g==
X-Google-Smtp-Source: ABdhPJwqFMWt/HO4S1xxju+gQabMi09PJBxALNIfHrK5+TejL/lt4JhT2+ouM8Vp9voSiNYAA0oWGbAXgLK4YJCVsPk=
X-Received: by 2002:a67:f897:: with SMTP id h23mr826426vso.9.1597990209107;
 Thu, 20 Aug 2020 23:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200715064909.9161-1-andy.tang@nxp.com> <20200715064909.9161-2-andy.tang@nxp.com>
In-Reply-To: <20200715064909.9161-2-andy.tang@nxp.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 21 Aug 2020 11:39:58 +0530
Message-ID: <CAHLCerMerO3-NR8N6NHnRuJ51xyJAthnpE8NTYr55-575YVrgw@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] arm64: dts: ls208xa: add more thermal zone support
To:     Yuantian Tang <andy.tang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 12:25 PM <andy.tang@nxp.com> wrote:
>
> From: Yuantian Tang <andy.tang@nxp.com>
>
> There are 7 thermal zones in ls208xa soc. Add the other thermal zone
> nodes to enable them.
>
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>

Reviewed-by: Amit Kucheria <amitk@kernel.org>

> ---
> v2:
>         - remove useless alert trip
>         - add cooling-map to core cluster zones.
>
>  .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 141 ++++++++++++++++--
>  1 file changed, 132 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> index 41102dacc2e1..cc36c969dd9d 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> @@ -79,20 +79,62 @@
>         };
>
>         thermal-zones {
> -               cpu_thermal: cpu-thermal {
> +               ddr-controller1 {
>                         polling-delay-passive = <1000>;
>                         polling-delay = <5000>;
> +                       thermal-sensors = <&tmu 1>;
>
> +                       trips {
> +                               ddr-ctrler1-crit {
> +                                       temperature = <95000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +
> +               ddr-controller2 {
> +                       polling-delay-passive = <1000>;
> +                       polling-delay = <5000>;
> +                       thermal-sensors = <&tmu 2>;
> +
> +                       trips {
> +                               ddr-ctrler2-crit {
> +                                       temperature = <95000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +
> +               ddr-controller3 {
> +                       polling-delay-passive = <1000>;
> +                       polling-delay = <5000>;
> +                       thermal-sensors = <&tmu 3>;
> +
> +                       trips {
> +                               ddr-ctrler3-crit {
> +                                       temperature = <95000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +
> +               core-cluster1 {
> +                       polling-delay-passive = <1000>;
> +                       polling-delay = <5000>;
>                         thermal-sensors = <&tmu 4>;
>
>                         trips {
> -                               cpu_alert: cpu-alert {
> -                                       temperature = <75000>;
> +                               core_cluster1_alert: core-cluster1-alert {
> +                                       temperature = <85000>;
>                                         hysteresis = <2000>;
>                                         type = "passive";
>                                 };
> -                               cpu_crit: cpu-crit {
> -                                       temperature = <85000>;
> +
> +                               core-cluster1-crit {
> +                                       temperature = <95000>;
>                                         hysteresis = <2000>;
>                                         type = "critical";
>                                 };
> @@ -100,14 +142,95 @@
>
>                         cooling-maps {
>                                 map0 {
> -                                       trip = <&cpu_alert>;
> +                                       trip = <&core_cluster1_alert>;
>                                         cooling-device =
>                                                 <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -                                               <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                               <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                       };
> +               };
> +
> +               core-cluster2 {
> +                       polling-delay-passive = <1000>;
> +                       polling-delay = <5000>;
> +                       thermal-sensors = <&tmu 5>;
> +
> +                       trips {
> +                               core_cluster2_alert: core-cluster2-alert {
> +                                       temperature = <85000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               core-cluster2-crit {
> +                                       temperature = <95000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +
> +                       cooling-maps {
> +                               map0 {
> +                                       trip = <&core_cluster2_alert>;
> +                                       cooling-device =
>                                                 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -                                               <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                               <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                       };
> +               };
> +
> +               core-cluster3 {
> +                       polling-delay-passive = <1000>;
> +                       polling-delay = <5000>;
> +                       thermal-sensors = <&tmu 6>;
> +
> +                       trips {
> +                               core_cluster3_alert: core-cluster3-alert {
> +                                       temperature = <85000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               core-cluster3-crit {
> +                                       temperature = <95000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +
> +                       cooling-maps {
> +                               map0 {
> +                                       trip = <&core_cluster3_alert>;
> +                                       cooling-device =
>                                                 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -                                               <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                               <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                       };
> +               };
> +
> +               core-cluster4 {
> +                       polling-delay-passive = <1000>;
> +                       polling-delay = <5000>;
> +                       thermal-sensors = <&tmu 7>;
> +
> +                       trips {
> +                               core_cluster4_alert: core-cluster4-alert {
> +                                       temperature = <85000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               core-cluster4-crit {
> +                                       temperature = <95000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +
> +                       cooling-maps {
> +                               map0 {
> +                                       trip = <&core_cluster4_alert>;
> +                                       cooling-device =
>                                                 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>                                                 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>                                 };
> --
> 2.17.1
>
