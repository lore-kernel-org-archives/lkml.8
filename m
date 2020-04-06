Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994C8C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7564D206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="WhAwEyU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgDFTFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:05:53 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44133 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgDFTFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 15:05:53 -0400
Received: by mail-vs1-f67.google.com with SMTP id e138so555339vsc.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 12:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CQD+C9Kg+kaXZdnpmDMOsE8KjUIcSylxGT9eltj8hNc=;
        b=WhAwEyU65nt+MH7u4Sm52detAfx9AIKlU92gMP8ZZjnP/YTmwEGd/LbcN7xKL2hE51
         k33IGFnYJNF81bp0cgu0ieHEO2nG2fgKfkeph9q5+J1j823v87d70SIQf5G5cmin7U33
         fJ595tv9GlciDWOEG78lrS0WKo0atnz3Pf9p5SgHb24u7KJue2mUW3Rj8gaaTBMZfkZ3
         tO1eq65TrQU0gUuBsACWKiy/EeyYYoJBz5BX/ZJFmU7pZ5BpCrs00HvnPh5d3nk0XN7M
         QiMV9X/r+33J0rScDcEvCa6HdGp9/8CL/c9ItWBlLbfswn4+hM9psHLM0KescvXJSasR
         5izg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CQD+C9Kg+kaXZdnpmDMOsE8KjUIcSylxGT9eltj8hNc=;
        b=VdTnYvupzsIvOEWKUUxo6RxvL/eMYzcrZ2/OwTo0ASeIVl4zQIH7J0dMMugCLHsUf6
         pJF8AoqFeKAoMy0XT54y5sN5VX7l31nAMS804hXjCtwrKE37ZmhgEJSrdAT2aGCjkk3u
         jF/NEN9leT7CTu64Ue5iV9xF3TCkO9QIXrzwCetlyDpI18zpcpQcnKmXUXfJO0TBC/PM
         /HitfnA32AU/stvrsRyJRaDY9whH60uU+sbsGtU55iKm/dM6yId913qW+SBXTRJN1TGs
         bxGvYwuZbSZDZVm8PNf/Sd+avfyZzA/ayS2G0Fbk1Djp/4l9h2zABdhy3EAkgO0tqrto
         fjvg==
X-Gm-Message-State: AGi0PuaaQXN+Qd3GE/yYhkfxoJtuhglxgIOt1MSBUdwCwqTY9DMUeoqW
        fTVP/GMQ9zRJMJB1GivjxZFv8BRG+Snnrbs1RUThXg==
X-Google-Smtp-Source: APiQypLdrhoD1+TZ4jdw1dsDSA7rmF0tkHvtxRtrwnEQz6g0MHUDl4HPqBpBqlQNHeEaYI9LDwzy6jJDIgV2779T/zM=
X-Received: by 2002:a05:6102:5c5:: with SMTP id v5mr1064068vsf.9.1586199952066;
 Mon, 06 Apr 2020 12:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200331075356.19171-1-j-keerthy@ti.com> <20200331075356.19171-5-j-keerthy@ti.com>
In-Reply-To: <20200331075356.19171-5-j-keerthy@ti.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Tue, 7 Apr 2020 00:35:41 +0530
Message-ID: <CAHLCerOwqOmGRotiofs_xtB9XEa-YUwYWFgJGNMXQqifW+azAA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] arm64: dts: ti: am6: Add VTM node
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
> VTM stands for voltage and thermal management. Add the vtm node and
> the associated thermal zones on the SoC.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> index f4227e2743f2..54a133fa1bf2 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> @@ -89,4 +89,15 @@
>                 clocks = <&k3_clks 59 0>;
>                 clock-names = "gpio";
>         };
> +
> +       wkup_vtm0: thermal@42050000 {
> +               compatible = "ti,am654-vtm";
> +               reg = <0x42050000 0x25c>;
> +               power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
> +               #thermal-sensor-cells = <1>;
> +       };
> +

Make this patch 3

> +       thermal_zones: thermal-zones {
> +               #include "k3-am654-industrial-thermal.dtsi"
> +       };
>  };

Move this with what is currently patch 3.

> --
> 2.17.1
>
