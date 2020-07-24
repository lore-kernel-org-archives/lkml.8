Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50DFC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 06:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CA9F20748
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 06:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxcYfC+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgGXGZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 02:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgGXGZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 02:25:46 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C690CC0619D3;
        Thu, 23 Jul 2020 23:25:45 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id c10so650177ejs.5;
        Thu, 23 Jul 2020 23:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mDAq2YfSHK1HsprezYy0GPAUl3qgXLBONIRCqnqmdVI=;
        b=AxcYfC+5gJHAX4GK7CjksvO5LwwQVJD+X0dF8njaaryniNfqDIRtlWzGtsfDYfY71J
         ScIoLWSndx/K7S2So5/G5v6x5IA0Pnqy4Jpr3S7fir+5XEdglGi5eozjF8YsWcZqrDw9
         CyQB/1cFquhHEX37lxLc6qcZTaqKQKYj3sgEXmeuNETvcuAs1z0r+vIylhDplTA6SkI0
         vDJm/+F1YqpQUnycers7QwJOV5fLMxOX0pt3bj6Lgd6We7I6EWucJ+B6UjMF0EiNEAM0
         VXJzfAGKYUMVe4PR9+SK2/mdm3KyYOtCwnjMhrVYen6MZ77IDxUR3w+F2qUjUycXmF6R
         2ezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mDAq2YfSHK1HsprezYy0GPAUl3qgXLBONIRCqnqmdVI=;
        b=cxoGOGhJjZ4VjTcBHEVs9vJw0ebAOaz0FVjYhN0en9xVXS8aKW+LZwajb/HsnArgfv
         f9MhM1N7/Pdmce6QRNt3SPi6CpfIpGd0Jj7Yf+/AC3JTgtavwLfGad6mT3XVP59E+3C0
         vZ0WfR7B5LG6H6+9w8VmXQh75UyIm6Z4aP2IYq/DV1HNA0lFqi6UlDQO9wye2HJaM6Fk
         qiTQZ0AgZIfa4KKHv8Kp7IkICFIFoZ9P8wwq04Qj0KyXRUnQvlqj35u2SY0KTXQfzU6F
         voSbmGmz22LOhxhkeMBhqMHDK4oYhsN4vw2GhVvly4bytI0cH8AMuoE+mIldKljc1m5c
         Yv5w==
X-Gm-Message-State: AOAM533Wze4crZAu1cPP/L5D3+dSAN9ESmaXCp71KBNPTEYKpL89U1cN
        kG6IWNJSUt2iAieczEKcDY5R/t8KXHQRV2RRTyP41DdI
X-Google-Smtp-Source: ABdhPJyO0d5mbACkrpqJr/4A52AgFjadu0CUaddbyYNj8LlE+CM041O9qfq+Pbs27gFRJ3helFokoZ/uXnob60CeQ5s=
X-Received: by 2002:a17:906:c44c:: with SMTP id ck12mr8047936ejb.145.1595571944447;
 Thu, 23 Jul 2020 23:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1594708863.git.frank@allwinnertech.com> <f7f86c648bad6e72f8fc8117b96065bf5326a273.1594708864.git.frank@allwinnertech.com>
 <20200723165448.crdc4fc5jwqmsret@gilmour.lan>
In-Reply-To: <20200723165448.crdc4fc5jwqmsret@gilmour.lan>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Fri, 24 Jul 2020 14:25:33 +0800
Message-ID: <CAEExFWu0PUOD0R+QvEiOsoZy_7JO_53i6OH3JoavVvGASxEeuA@mail.gmail.com>
Subject: Re: [PATCH v4 14/16] arm64: allwinner: A100: add the basical
 Allwinner A100 DTSI file
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Frank Lee <frank@allwinnertech.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?6buE54OB55Sf?= <huangshuosheng@allwinnertech.com>,
        liyong@allwinnertech.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

On Fri, Jul 24, 2020 at 12:54 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi,
>
> On Tue, Jul 14, 2020 at 03:20:29PM +0800, Frank Lee wrote:
> > From: Yangtao Li <frank@allwinnertech.com>
> >
> > Allwinner A100 is a new SoC with Cortex-A53 cores, this commit adds
> > the basical DTSI file of it, including the clock, i2c, pins, sid, ths,
> > nmi, and UART support.
> >
> > Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> > ---
> >  .../arm64/boot/dts/allwinner/sun50i-a100.dtsi | 364 ++++++++++++++++++
> >  1 file changed, 364 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> > new file mode 100644
> > index 000000000000..3fb2443f2121
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> > @@ -0,0 +1,364 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> > +/*
> > + * Copyright (c) 2020 Yangtao Li <frank@allwinnertech.com>
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/clock/sun50i-a100-ccu.h>
> > +#include <dt-bindings/clock/sun50i-a100-r-ccu.h>
> > +#include <dt-bindings/reset/sun50i-a100-ccu.h>
> > +#include <dt-bindings/reset/sun50i-a100-r-ccu.h>
> > +
> > +/ {
> > +     interrupt-parent = <&gic>;
> > +     #address-cells = <2>;
> > +     #size-cells = <2>;
> > +
> > +     cpus {
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
> > +
> > +             cpu0: cpu@0 {
> > +                     compatible = "arm,armv8";
>
> You should use the arm,cortex-a53 compatible here, arm,armv8 is for
> software models.
>
> > +             sid@3006000 {
>
> The node name is supposed to be the class of the device, and the DT spec
> defines a list of them already. eeprom would be better suited here.

EFuse is more accurate?

Thx,
Yangtao
