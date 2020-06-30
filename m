Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6749FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C32620720
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NJIBZqjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgF3FMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 01:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgF3FMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 01:12:32 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F706C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 22:12:32 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id e3so6079369uan.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 22:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GZqNJf/On7BSXnSaIpAwlixbpz1QEKZR/Qh4WmlHE/w=;
        b=NJIBZqjmorg7A0uHIHgK7pGtai2uUiiTma8MdmUkVCHd7SDCxBgURyucrMkwdp+L/X
         dNkiucbsIrhfA1ZA0nnEKfcBG59EechfNdhez+CIs+s9SzgZdfhBNuADSBxHaNxccY9b
         dyyUubT4IBnUVvIjV75XEkalZZR7i+fjNvR9Tr6WjP65XVjAeQ2vl5X7xU2FLERe8FQl
         qaWhrz5R2fCn+7ZDjNdwnIzGpFnaj9ivBMMhvi5jPVtc643LBW4K2hHYPhG/Fz/f4peS
         xBQiGYopJppEfASjygrVZtCDzqOg7lpNNWM2dSmae9wm6l4qEFLqW/fgz+8jJ6N1Z0DC
         LfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZqNJf/On7BSXnSaIpAwlixbpz1QEKZR/Qh4WmlHE/w=;
        b=POGvHvd1Ogo7xEGs9ogf/h6fpIfqpSno8yz1TsRvcOsS7sT/1qGcN1yh0h8ZIdALmM
         ukD/XhQZ+1WqZDlw1eJi9cHI7+ACPIrom678Gv1Ah1XVgagawWPtnLtCL1XfiM5u63on
         kNz3QSHgXvr3gqW+GufqjgDVtu/EiP8gQcZg2WaD/AhWPYxSGhHPgmTxE+LqJix40EWu
         5bEymaKR3zW8jCuZRPjBAoojw5JBwVlMhPt23VbycpxUrKlEzKRPwES5XEsljfLu7Wm3
         qGc3zwQi2kxzWzC6cK293+ILTAyQFs9MD80wuC1mZXMOJKNbR9KzqIv+9WEA18SfN+cg
         uUFA==
X-Gm-Message-State: AOAM5326TCce2CtV0J1bgNnFMakZLFsHUlFtRYg0bVkEcijsE+rrU5GK
        oj4GkJM21837ndb8nCnNQBP8Gv41AeI8+GxUwk76Dw==
X-Google-Smtp-Source: ABdhPJysDkIaaWnh2DqQmc9Gtn6fINTLTYAwh+PfYrZlIuIQbRi6Xt9uuRB0lB6S1M+uDHcG3XhPJeGk1ho0vHvBT48=
X-Received: by 2002:a9f:3113:: with SMTP id m19mr4054878uab.77.1593493951335;
 Mon, 29 Jun 2020 22:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200630032014.22956-1-andy.tang@nxp.com>
In-Reply-To: <20200630032014.22956-1-andy.tang@nxp.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 30 Jun 2020 10:42:19 +0530
Message-ID: <CAHLCerO3B4Z67KP8VaF957Jkid21gLvzhS49gNeqUC+6muPkjA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: ls1088a: add more thermal zone support
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

On Tue, Jun 30, 2020 at 8:56 AM <andy.tang@nxp.com> wrote:
>
> From: Yuantian Tang <andy.tang@nxp.com>
>
> There are 2 thermal zones in ls1088a soc. Add the other thermal zone
> node to enable it.
> Also update the values in calibration table to make the temperatures
> monitored more precise.
>
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> ---
>  .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 100 +++++++++++-------
>  1 file changed, 62 insertions(+), 38 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index 36a799554620..ccbbc23e6c85 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -129,19 +129,19 @@
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
> +                               core_cluster_crit: core-cluster-crit {
>                                         temperature = <95000>;
>                                         hysteresis = <2000>;
>                                         type = "critical";
> @@ -150,7 +150,7 @@
>
>                         cooling-maps {
>                                 map0 {
> -                                       trip = <&cpu_alert>;
> +                                       trip = <&core_cluster_alert>;
>                                         cooling-device =
>                                                 <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>                                                 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> @@ -163,6 +163,26 @@
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
> +                               soc-alert {
> +                                       temperature = <85000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               soc-crit {
> +                                       temperature = <95000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };

You should also add a cooling-maps section for this thermal zone given
that it has a passive trip type. Otherwise there is no use for a
passive trip type.

>         };
>
>         timer {
> @@ -209,45 +229,49 @@
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
