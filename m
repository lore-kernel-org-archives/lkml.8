Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850FBC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 06:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C571207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 06:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RG2wLagD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgHUGKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 02:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgHUGJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 02:09:58 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084DEC061386
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 23:09:56 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id n25so294640vsq.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 23:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JW3ozXdShYYofb3XNyMiyoXtYwbQgNjFmTpyqQVrWrY=;
        b=RG2wLagDKFi3HO0EQE0nsazch7qCSoA2b8iEkPWVJLkavPUKF4oX9jVgnY+tjFeTTP
         vf/dUBx8o74YwjfStg+CZ2NgdNYy5OfrRNcK40Ah/nYd+0jpMOiAEW0ZK7hODdR+NS1G
         ny3/z3E0EC6ImkP2HGojBtrpL07mCTnvUX1Quy+9NDKPhow6NReRb28keq1VGKwdGLjd
         88h1btWlZoULcZqf1J9SQLXpE4PLyqWxV7hA2b1mItgZ3Ba0gEKy1zDRlBpKhTAwDJD4
         xNw/LTsHv+SEUipwX4YiA/30XdQCdrx3mUQtOmSNwiQAap18eGKyRuUU6BoD7dapj0/C
         YMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JW3ozXdShYYofb3XNyMiyoXtYwbQgNjFmTpyqQVrWrY=;
        b=U5O+AoFuzNPYIvtl0dgxELHIMonGNkKcRc2jyQWmmvTLQVzlK/fzkDL9Frb+lByrT7
         O5vmlg9DNnFqHKqPmihjsoM1wOwYDr4LfYD/tvv+MgZKiyN+H4ADRZgvRxTigFYnhJNl
         ZSF5QyygjR8tm5jcj18ACaGHG5dFhTKjIhQtX28Zd4kqtVQjb3VeIP1sBvDdayw3Up7n
         5Lr+6F/I10d0lkY6RZ9VsdRTmvAV8oE86PrtDqSg8m4Fn4QEFKJWaekfN+N5h352cb7e
         jCr08ckpvUo9/eKBiy9ysv17a4Y62F7yQ8qg4mlZp+FlaHujxuUmnlyGGDGd1yB0Y2cP
         ErOA==
X-Gm-Message-State: AOAM532F7Ur6IktGPcRFoGrm0gwd/bYJJqMTWJW+Bpv/veJ8ysDJjR9U
        ufiWS0YNC4Viy1ORrEbAuAqB0PqFXIe5ptAfMe4SPQ==
X-Google-Smtp-Source: ABdhPJx8xpveXw3qZj/zMsBfKzYf/TP3PHvI91tV7PQ6vsOKw6Y9uNBFCa+7Et6BYfxQxOWRGY0c0vDMVv/ChvLsmTI=
X-Received: by 2002:a67:e40a:: with SMTP id d10mr769663vsf.95.1597990196050;
 Thu, 20 Aug 2020 23:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200715064909.9161-1-andy.tang@nxp.com>
In-Reply-To: <20200715064909.9161-1-andy.tang@nxp.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 21 Aug 2020 11:39:45 +0530
Message-ID: <CAHLCerM6_1NW1c+y990Y052uzK39gGLgkj8wo76CF_YPaEszJA@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] arm64: dts: ls1088a: add more thermal zone support
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
> There are 2 thermal zones in ls1088a soc. Add the other thermal zone
> node to enable it.
> Also update the values in calibration table to make the temperatures
> monitored more precise.
>
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>

Reviewed-by: Amit Kucheria <amitk@kernel.org>

> ---
> v2:
>         - remove useless alert trip
>
>  .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 94 +++++++++++--------
>  1 file changed, 56 insertions(+), 38 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index 169f4742ae3b..b961a896ede7 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -130,19 +130,19 @@
>         };
>
>         thermal-zones {
> -               cpu_thermal: cpu-thermal {
> +               core-cluster {
>                         polling-delay-passive = <1000>;
>                         polling-delay = <5000>;
>                         thermal-sensors = <&tmu 0>;
>
>                         trips {
> -                               cpu_alert: cpu-alert {
> +                               core_cluster_alert: core-cluster-alert {
>                                         temperature = <85000>;
>                                         hysteresis = <2000>;
>                                         type = "passive";
>                                 };
>
> -                               cpu_crit: cpu-crit {
> +                               core-cluster-crit {
>                                         temperature = <95000>;
>                                         hysteresis = <2000>;
>                                         type = "critical";
> @@ -151,7 +151,7 @@
>
>                         cooling-maps {
>                                 map0 {
> -                                       trip = <&cpu_alert>;
> +                                       trip = <&core_cluster_alert>;
>                                         cooling-device =
>                                                 <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>                                                 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> @@ -164,6 +164,20 @@
>                                 };
>                         };
>                 };
> +
> +               soc {
> +                       polling-delay-passive = <1000>;
> +                       polling-delay = <5000>;
> +                       thermal-sensors = <&tmu 1>;
> +
> +                       trips {
> +                               soc-crit {
> +                                       temperature = <95000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
>         };
>
>         timer {
> @@ -210,45 +224,49 @@
>                         compatible = "fsl,qoriq-tmu";
>                         reg = <0x0 0x1f80000 0x0 0x10000>;
>                         interrupts = <0 23 0x4>;
> -                       fsl,tmu-range = <0xb0000 0x9002a 0x6004c 0x30062>;
> +                       fsl,tmu-range = <0xb0000 0x9002a 0x6004c 0x70062>;
>                         fsl,tmu-calibration =
>                                 /* Calibration data group 1 */
> -                               <0x00000000 0x00000026
> -                               0x00000001 0x0000002d
> -                               0x00000002 0x00000032
> -                               0x00000003 0x00000039
> -                               0x00000004 0x0000003f
> -                               0x00000005 0x00000046
> -                               0x00000006 0x0000004d
> -                               0x00000007 0x00000054
> -                               0x00000008 0x0000005a
> -                               0x00000009 0x00000061
> -                               0x0000000a 0x0000006a
> -                               0x0000000b 0x00000071
> +                               <0x00000000 0x00000023
> +                               0x00000001 0x0000002a
> +                               0x00000002 0x00000030
> +                               0x00000003 0x00000037
> +                               0x00000004 0x0000003d
> +                               0x00000005 0x00000044
> +                               0x00000006 0x0000004a
> +                               0x00000007 0x00000051
> +                               0x00000008 0x00000057
> +                               0x00000009 0x0000005e
> +                               0x0000000a 0x00000064
> +                               0x0000000b 0x0000006b
>                                 /* Calibration data group 2 */
> -                               0x00010000 0x00000025
> -                               0x00010001 0x0000002c
> -                               0x00010002 0x00000035
> -                               0x00010003 0x0000003d
> -                               0x00010004 0x00000045
> -                               0x00010005 0x0000004e
> -                               0x00010006 0x00000057
> -                               0x00010007 0x00000061
> -                               0x00010008 0x0000006b
> -                               0x00010009 0x00000076
> +                               0x00010000 0x00000022
> +                               0x00010001 0x0000002a
> +                               0x00010002 0x00000032
> +                               0x00010003 0x0000003a
> +                               0x00010004 0x00000042
> +                               0x00010005 0x0000004a
> +                               0x00010006 0x00000052
> +                               0x00010007 0x0000005a
> +                               0x00010008 0x00000062
> +                               0x00010009 0x0000006a
>                                 /* Calibration data group 3 */
> -                               0x00020000 0x00000029
> -                               0x00020001 0x00000033
> -                               0x00020002 0x0000003d
> -                               0x00020003 0x00000049
> -                               0x00020004 0x00000056
> -                               0x00020005 0x00000061
> -                               0x00020006 0x0000006d
> +                               0x00020000 0x00000021
> +                               0x00020001 0x0000002b
> +                               0x00020002 0x00000035
> +                               0x00020003 0x00000040
> +                               0x00020004 0x0000004a
> +                               0x00020005 0x00000054
> +                               0x00020006 0x0000005e
>                                 /* Calibration data group 4 */
> -                               0x00030000 0x00000021
> -                               0x00030001 0x0000002a
> -                               0x00030002 0x0000003c
> -                               0x00030003 0x0000004e>;
> +                               0x00030000 0x00000010
> +                               0x00030001 0x0000001c
> +                               0x00030002 0x00000027
> +                               0x00030003 0x00000032
> +                               0x00030004 0x0000003e
> +                               0x00030005 0x00000049
> +                               0x00030006 0x00000054
> +                               0x00030007 0x00000060>;
>                         little-endian;
>                         #thermal-sensor-cells = <1>;
>                 };
> --
> 2.17.1
>
