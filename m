Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B153C54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FF6A214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t+DXpkd4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgD0TAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgD0TAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:00:03 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93ADC0610D5;
        Mon, 27 Apr 2020 12:00:02 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a2so15095484ejx.5;
        Mon, 27 Apr 2020 12:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ysq+lYr7LTBndMy6YgqJpqGJhtw6V84HyMC0bkjoYNk=;
        b=t+DXpkd4RSv2lcX+2xwpvAnzDAiRlhqjZQYmF2cfE8A/8eWSFGvigPuZ8cW/Rd1rpA
         hI2hK+5vHAg8yqcj6C6udFCG5OKUwWg4aJFn1odGj3wI1F9g0mbSQ8NAw3kCSTi0g4Ek
         BsjCO95npV6LGlnRS9iiw2JRp/8AT/FHZaAYzyinQiNoIyxVWzfTq+7ASuSA/dg5cP3o
         +smxhGDxdi2UZA7rC8fMQpUSDMcf0QKZqXb9klHFpX+3i9KAu58xnDgOYWBb6gi0G+U3
         rGNFmxp8iH8iENPAtKatAwhfWW+lxd7vIzHDYVhjBmRhN89Ir/lelT9SueqJB7UzeXS2
         HjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ysq+lYr7LTBndMy6YgqJpqGJhtw6V84HyMC0bkjoYNk=;
        b=Tn5e+IBen0BNYD2uonbmvIKz1LIjxj/KIY4xfUO7Vr/Nj5xZ/HxdWUh8dKAPI6xM58
         9zDb0uu9JZUTBuBeWdEHBaxAwEov29LrUMV1j11WH9Y5rdGLwB5s9EjrD8so0XWmPwt4
         CHFF3Z+CijNPNteWq3X/AgnjhUktfAv4hYfBvgr/l8F1UfppfQXVi40Bs/mKxlYgI23b
         OcAL1LOVo239EfZw72zB8OStmrNYD+YH3dKPnBYxTOJPMKm4xQ2nKzL2kCLlD8t88f8y
         gzxE/p7dbrpp+rzD9Xug6UQtl7OnBeN0tHP4uTo01Trv1h2MBpCXjsnZyKCowXuS5TYV
         4pkA==
X-Gm-Message-State: AGi0PubVCWq0F/u4mDtK2b1Rwej5IhjaPbODYsAX7mVznd6xPJhrFQE7
        61rCVb3xiou05e2QDlUfEGNKPGm2r+SMGkFPE3M=
X-Google-Smtp-Source: APiQypJtTYT311/FuxT+06XbdTrc9BUfR8HcpzgeYLkQomTdgTN76FEPKij2GG62CJynV2Ahs6lkbNWnm3G3ArAAIcs=
X-Received: by 2002:a17:906:7fd7:: with SMTP id r23mr20630680ejs.32.1588014001407;
 Mon, 27 Apr 2020 12:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200424181642.32084-1-pop.adrian61@gmail.com> <20200427064910.GC3559@dell>
In-Reply-To: <20200427064910.GC3559@dell>
From:   Adrian Pop <pop.adrian61@gmail.com>
Date:   Mon, 27 Apr 2020 21:59:59 +0300
Message-ID: <CAP-HsdQOyWrz+Y7gR9jrNjX09NCYB1EWK7swMQDZ-v-VJLGRMw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm: dt-bindings: mfd: stm32f-rcc: Add missing DSI clock
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 9:49 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Fri, 24 Apr 2020, Adrian Pop wrote:
>
> > Add missing clock.
> >
> > Signed-off-by: Adrian Pop <pop.adrian61@gmail.com>
> > ---
> >  include/dt-bindings/mfd/stm32f7-rcc.h | 1 +
> >  1 file changed, 1 insertion(+)
>
> I assume patch 2 depends on this?

Yes, second patch depends on this.

>
> If so, where is it?  Why isn't it in my inbox?
>

Here it is:

STM32f769-disco features a 4" MIPI DSI display: add support for it.

Signed-off-by: Adrian Pop <pop.adrian61@gmail.com>
---
 arch/arm/boot/dts/stm32f746.dtsi      | 34 ++++++++++++++++++
 arch/arm/boot/dts/stm32f769-disco.dts | 50 +++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746=
.dtsi
index 93c063796780..202bb6edc9f1 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -48,6 +48,19 @@ / {
        #address-cells =3D <1>;
        #size-cells =3D <1>;

+       reserved-memory {
+               #address-cells =3D <1>;
+               #size-cells =3D <1>;
+               ranges;
+
+               linux,dma {
+                       compatible =3D "shared-dma-pool";
+                       linux,dma-default;
+                       no-map;
+                       size =3D <0x10F000>;
+               };
+       };
+
        clocks {
                clk_hse: clk-hse {
                        #clock-cells =3D <0>;
@@ -75,6 +88,27 @@ clk_i2s_ckin: clk-i2s-ckin {
        };

        soc {
+               ltdc: display-controller@40016800 {
+                       compatible =3D "st,stm32-ltdc";
+                       reg =3D <0x40016800 0x200>;
+                       interrupts =3D <88>, <89>;
+                       resets =3D <&rcc STM32F7_APB2_RESET(LTDC)>;
+                       clocks =3D <&rcc 1 CLK_LCD>;
+                       clock-names =3D "lcd";
+                       status =3D "disabled";
+               };
+
+               dsi: dsi@40016c00 {
+                       compatible =3D "st,stm32-dsi";
+                       reg =3D <0x40016c00 0x800>;
+                       interrupts =3D <98>;
+                       clocks =3D <&rcc 1 CLK_F769_DSI>, <&clk_hse>;
+                       clock-names =3D "pclk", "ref";
+                       resets =3D <&rcc STM32F7_APB2_RESET(DSI)>;
+                       reset-names =3D "apb";
+                       status =3D "disabled";
+               };
+
                timer2: timer@40000000 {
                        compatible =3D "st,stm32-timer";
                        reg =3D <0x40000000 0x400>;
diff --git a/arch/arm/boot/dts/stm32f769-disco.dts
b/arch/arm/boot/dts/stm32f769-disco.dts
index 1626e00bb2cb..30ebbc193e82 100644
--- a/arch/arm/boot/dts/stm32f769-disco.dts
+++ b/arch/arm/boot/dts/stm32f769-disco.dts
@@ -153,3 +153,53 @@ &usbotg_hs {
        pinctrl-names =3D "default";
        status =3D "okay";
 };
+
+&dsi {
+       #address-cells =3D <1>;
+       #size-cells =3D <0>;
+       status =3D "okay";
+
+       ports {
+               #address-cells =3D <1>;
+               #size-cells =3D <0>;
+
+               port@0 {
+                       reg =3D <0>;
+                       dsi_in: endpoint {
+                               remote-endpoint =3D <&ltdc_out_dsi>;
+                       };
+               };
+
+               port@1 {
+                       reg =3D <1>;
+                       dsi_out: endpoint {
+                               remote-endpoint =3D <&dsi_in_panel>;
+                       };
+               };
+
+       };
+
+       panel: panel {
+               compatible =3D "orisetech,otm8009a";
+               reg =3D <0>; /* dsi virtual channel (0..3) */
+               reset-gpios =3D <&gpioj 15 GPIO_ACTIVE_LOW>;
+               status =3D "okay";
+
+               port {
+                       dsi_in_panel: endpoint {
+                               remote-endpoint =3D <&dsi_out>;
+                       };
+               };
+       };
+};
+
+&ltdc {
+       dma-ranges;
+       status =3D "okay";
+
+       port {
+               ltdc_out_dsi: endpoint {
+                       remote-endpoint =3D <&dsi_in>;
+               };
+       };
+};
--

> > diff --git a/include/dt-bindings/mfd/stm32f7-rcc.h b/include/dt-binding=
s/mfd/stm32f7-rcc.h
> > index a90f3613c584..ba5cb7456ee4 100644
> > --- a/include/dt-bindings/mfd/stm32f7-rcc.h
> > +++ b/include/dt-bindings/mfd/stm32f7-rcc.h
> > @@ -107,6 +107,7 @@
> >  #define STM32F7_RCC_APB2_SAI1                22
> >  #define STM32F7_RCC_APB2_SAI2                23
> >  #define STM32F7_RCC_APB2_LTDC                26
> > +#define STM32F7_RCC_APB2_DSI         27
> >
> >  #define STM32F7_APB2_RESET(bit)      (STM32F7_RCC_APB2_##bit + (0x24 *=
 8))
> >  #define STM32F7_APB2_CLOCK(bit)      (STM32F7_RCC_APB2_##bit + 0xA0)
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog

On Mon, Apr 27, 2020 at 9:49 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Fri, 24 Apr 2020, Adrian Pop wrote:
>
> > Add missing clock.
> >
> > Signed-off-by: Adrian Pop <pop.adrian61@gmail.com>
> > ---
> >  include/dt-bindings/mfd/stm32f7-rcc.h | 1 +
> >  1 file changed, 1 insertion(+)
>
> I assume patch 2 depends on this?
>
> If so, where is it?  Why isn't it in my inbox?
>
> > diff --git a/include/dt-bindings/mfd/stm32f7-rcc.h b/include/dt-binding=
s/mfd/stm32f7-rcc.h
> > index a90f3613c584..ba5cb7456ee4 100644
> > --- a/include/dt-bindings/mfd/stm32f7-rcc.h
> > +++ b/include/dt-bindings/mfd/stm32f7-rcc.h
> > @@ -107,6 +107,7 @@
> >  #define STM32F7_RCC_APB2_SAI1                22
> >  #define STM32F7_RCC_APB2_SAI2                23
> >  #define STM32F7_RCC_APB2_LTDC                26
> > +#define STM32F7_RCC_APB2_DSI         27
> >
> >  #define STM32F7_APB2_RESET(bit)      (STM32F7_RCC_APB2_##bit + (0x24 *=
 8))
> >  #define STM32F7_APB2_CLOCK(bit)      (STM32F7_RCC_APB2_##bit + 0xA0)
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
