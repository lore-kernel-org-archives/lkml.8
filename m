Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A7AC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5265820658
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="yzFTv6PV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgCQKwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:52:21 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34638 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgCQKwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:52:20 -0400
Received: by mail-vs1-f66.google.com with SMTP id t10so13513660vsp.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 03:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2h930L2nUaeWpN/VPq6cjVwd1EstsXRD+uH/UzVG50M=;
        b=yzFTv6PVIFzp+YEHgkfJktWrdnpr0NoIVVwCQtTNHKjE54+UQKGskUFPTQl0cH0/il
         RKsQaXITWE9Aad7OxxFsDCSM/te0ws0j4wJlKrjQ11NLx1XzXqZfaWd/KIcvJ3fATEis
         SfNhsN9gqE8M3VXyvbqgYvBO7hZgw8j3y22AVkkmU8lGijaqZmBSiAt7si9bHCZZ3wxG
         dxx/zRACvw2LuNBzWjNeTyJGjPcUiOLcjGQHhjPRyvW8oTzq65Gzx7vzk3i/xeQLb8q5
         ugpHD8GyX7kHvSsYaFdXcDnZ6crW1EGHwQdXEu1ZFFeJvvRNqBKrr/qZyP6udpCQAAAB
         kbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2h930L2nUaeWpN/VPq6cjVwd1EstsXRD+uH/UzVG50M=;
        b=NMjVDvYXva7NhVtxpmUYLpYPjNJ2+qfgplW2LxPmBnKD77hjcubltmmeiDMMUBQxrr
         BBHzVyyQm50730QoqBDhpjp/YO75HuC0SmWmOGovFLQC5E8h/Ya6ev0gjXttmVNP99fR
         EOfZs732KZrbiG4XUMeEJq+TplX1w3Lvc2VKaeSPmMF0D/i5KuTxwyLJLyM5AhXD3BgU
         S6nRPXh1nn5SfLwGeea7SUwQk4PkVJJX/e7YRInxmxffABYOeokmcAqLQ7eKvEcHArDD
         Ejevl7ogQuakENJChd/2f5Ffiljtz35TACOI315JPEe807R3ekeElIF21rAvjXdtGd1T
         /rTw==
X-Gm-Message-State: ANhLgQ0lM3NytGiYhemLw1R0w3n++o6pZdkzwj5ITn3S3k2TPsyd8jgv
        kEsaxtRESkzPesACAYe0xAEr66HIX4LnffXU7WXWmg==
X-Google-Smtp-Source: ADFU+vuJwh4C02Y8CB3LnnNmExzyITUoR6WKl8q1aLb0YHzq2cRlxar6SO9ePlsiqr5C/u1I9OAB68nw+UZqVFt/2RM=
X-Received: by 2002:a67:eb81:: with SMTP id e1mr3171827vso.27.1584442337603;
 Tue, 17 Mar 2020 03:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <1584430804-8343-1-git-send-email-rkambl@codeaurora.org>
In-Reply-To: <1584430804-8343-1-git-send-email-rkambl@codeaurora.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Tue, 17 Mar 2020 16:22:00 +0530
Message-ID: <CAHLCerOSz4aAkukPzRRwOgeiTnw1ATSp0gPd9ujqiv9uAfj2Mg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Changed polling-delay in
 Thermal-zones node
To:     Rajeshwari <rkambl@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        sivaa@codeaurora.org, sanm@codeaurora.org,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 1:11 PM Rajeshwari <rkambl@codeaurora.org> wrote:
>
> Changed polling-delay and polling-delay-passive to zero as per
> the requirement.
>
> Signed-off-by: Rajeshwari <rkambl@codeaurora.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 100 +++++++++++++++++------------------
>  1 file changed, 50 insertions(+), 50 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index ca876ed..d81c4f1 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -1907,8 +1907,8 @@
>
>         thermal-zones {
>                 cpu0-thermal {
> -                       polling-delay-passive = <250>;
> -                       polling-delay = <1000>;
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
>
>                         thermal-sensors = <&tsens0 1>;
>
> @@ -1955,8 +1955,8 @@
>                 };
>
>                 cpu1-thermal {
> -                       polling-delay-passive = <250>;
> -                       polling-delay = <1000>;
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
>
>                         thermal-sensors = <&tsens0 2>;
>
> @@ -2003,8 +2003,8 @@
>                 };
>
>                 cpu2-thermal {
> -                       polling-delay-passive = <250>;
> -                       polling-delay = <1000>;
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
>
>                         thermal-sensors = <&tsens0 3>;
>
> @@ -2051,8 +2051,8 @@
>                 };
>
>                 cpu3-thermal {
> -                       polling-delay-passive = <250>;
> -                       polling-delay = <1000>;
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
>
>                         thermal-sensors = <&tsens0 4>;
>
> @@ -2099,8 +2099,8 @@
>                 };
>
>                 cpu4-thermal {
> -                       polling-delay-passive = <250>;
> -                       polling-delay = <1000>;
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
>
>                         thermal-sensors = <&tsens0 5>;
>
> @@ -2147,8 +2147,8 @@
>                 };
>
>                 cpu5-thermal {
> -                       polling-delay-passive = <250>;
> -                       polling-delay = <1000>;
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
>
>                         thermal-sensors = <&tsens0 6>;
>
> @@ -2195,8 +2195,8 @@
>                 };
>
>                 cpu6-thermal {
> -                       polling-delay-passive = <250>;
> -                       polling-delay = <1000>;
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
>
>                         thermal-sensors = <&tsens0 9>;
>
> @@ -2235,8 +2235,8 @@
>                 };
>
>                 cpu7-thermal {
> -                       polling-delay-passive = <250>;
> -                       polling-delay = <1000>;
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
>
>                         thermal-sensors = <&tsens0 10>;
>
> @@ -2275,8 +2275,8 @@
>                 };
>
>                 cpu8-thermal {
> -                       polling-delay-passive = <250>;
> -                       polling-delay = <1000>;
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
>
>                         thermal-sensors = <&tsens0 11>;
>
> @@ -2315,8 +2315,8 @@
>                 };
>
>                 cpu9-thermal {
> -                       polling-delay-passive = <250>;
> -                       polling-delay = <1000>;
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
>
>                         thermal-sensors = <&tsens0 12>;
>
> @@ -2355,8 +2355,8 @@
>                 };
>
>                 aoss0-thermal {
> -                       polling-delay-passive = <250>;
> -                       polling-delay = <1000>;
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
>
>                         thermal-sensors = <&tsens0 0>;
>
> @@ -2376,8 +2376,8 @@
>                 };
>
>                 cpuss0-thermal {
> -                       polling-delay-passive = <250>;
> -                       polling-delay = <1000>;
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
>
>                         thermal-sensors = <&tsens0 7>;
>
> @@ -2396,8 +2396,8 @@
>                 };
>
>                 cpuss1-thermal {
> -                       polling-delay-passive = <250>;
> -                       polling-delay = <1000>;
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
>
>                         thermal-sensors = <&tsens0 8>;
>
> @@ -2416,8 +2416,8 @@
>                 };
>
>                 gpuss0-thermal {
> -                       polling-delay-passive = <250>;
> -                       polling-delay = <1000>;
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
>
>                         thermal-sensors = <&tsens0 13>;
>
> @@ -2437,8 +2437,8 @@
>                 };
>
>                 gpuss1-thermal {
> -                       polling-delay-passive = <250>;
> -                       polling-delay = <1000>;
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
>
>                         thermal-sensors = <&tsens0 14>;
>
> @@ -2458,8 +2458,8 @@
>                 };
>
>                 aoss1-thermal {
> -                       polling-delay-passive = <250>;
> -                       polling-delay = <1000>;
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
>
>                         thermal-sensors = <&tsens1 0>;
>
> @@ -2479,8 +2479,8 @@
>                 };
>
>                 cwlan-thermal {
> -                       polling-delay-passive = <250>;
> -                       polling-delay = <1000>;
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
>
>                         thermal-sensors = <&tsens1 1>;
>
> @@ -2500,8 +2500,8 @@
>                 };
>
>                 audio-thermal {
> -                       polling-delay-passive = <250>;
> -                       polling-delay = <1000>;
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
>
>                         thermal-sensors = <&tsens1 2>;
>
> @@ -2521,8 +2521,8 @@
>                 };
>
>                 ddr-thermal {
> -                       polling-delay-passive = <250>;
> -                       polling-delay = <1000>;
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
>
>                         thermal-sensors = <&tsens1 3>;
>
> @@ -2542,8 +2542,8 @@
>                 };
>
>                 q6-hvx-thermal {
> -                       polling-delay-passive = <250>;
> -                       polling-delay = <1000>;
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
>
>                         thermal-sensors = <&tsens1 4>;
>
> @@ -2563,8 +2563,8 @@
>                 };
>
>                 camera-thermal {
> -                       polling-delay-passive = <250>;
> -                       polling-delay = <1000>;
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
>
>                         thermal-sensors = <&tsens1 5>;
>
> @@ -2584,8 +2584,8 @@
>                 };
>
>                 mdm-core-thermal {
> -                       polling-delay-passive = <250>;
> -                       polling-delay = <1000>;
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
>
>                         thermal-sensors = <&tsens1 6>;
>
> @@ -2605,8 +2605,8 @@
>                 };
>
>                 mdm-dsp-thermal {
> -                       polling-delay-passive = <250>;
> -                       polling-delay = <1000>;
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
>
>                         thermal-sensors = <&tsens1 7>;
>
> @@ -2626,8 +2626,8 @@
>                 };
>
>                 npu-thermal {
> -                       polling-delay-passive = <250>;
> -                       polling-delay = <1000>;
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
>
>                         thermal-sensors = <&tsens1 8>;
>
> @@ -2647,8 +2647,8 @@
>                 };
>
>                 video-thermal {
> -                       polling-delay-passive = <250>;
> -                       polling-delay = <1000>;
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
>
>                         thermal-sensors = <&tsens1 9>;
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
