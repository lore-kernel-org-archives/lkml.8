Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8362FC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EDD52071C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584033960;
	bh=PTvuO3YiFJRIht1oaTpuGfBpue7S7PiLmmQVu1qVIn4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wFZZIN1eLxlhj7qxfaj+iZginHVK38oVx45OaCmg1LtlmyNhYx2voHmVKhzsghlTC
	 i82eEfuQz75jwqokpdQwlEJomvu5ktfdUY8Vh4t1TTpjaF+lX1UWzkAexJlfuaAQn0
	 DZhXLvr98Ygec5jtuXRbKW0iPc+Orwt4YpiFwHDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgCLRZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:25:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgCLRZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:25:58 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD11C20736
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 17:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584033958;
        bh=PTvuO3YiFJRIht1oaTpuGfBpue7S7PiLmmQVu1qVIn4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=v4yGTumBUbUn7LDvYCm6yGZ6JW8eLb4w5G5kAmN2IEtHIgm/n7DUy3NLoGqNvt2ub
         ZZOYtOwqpI3b1qbtf2yCXD6alkY0I5+wnGXaibG00eUYNsMyMQaHlqlWsXiKiafHoi
         oUbwUWuSNs0I9SO6qDyTuDW4ZeQhXkk6+Rm2oU1k=
Received: by mail-qt1-f182.google.com with SMTP id l13so4994423qtv.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 10:25:57 -0700 (PDT)
X-Gm-Message-State: ANhLgQ33klbpNwAncdDRZ1U8uMW8r7q/ME90ytkhFpesFiHCqlUUFIH2
        c0znARcIFIlGjQ1WpYLjZujQWANXWNnMxzeu3A==
X-Google-Smtp-Source: ADFU+vuTNhe4RU9kuU5b409wZdxlxUCyoJ8PZURcjbAM9GBDKgaJKZ5s5NABcrdZFt2QuePKLVKem4BfjeKrNJsx1fQ=
X-Received: by 2002:ac8:1b33:: with SMTP id y48mr8614017qtj.136.1584033956950;
 Thu, 12 Mar 2020 10:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200306124930.20978-1-laurentiu.palcu@oss.nxp.com> <20200306124930.20978-4-laurentiu.palcu@oss.nxp.com>
In-Reply-To: <20200306124930.20978-4-laurentiu.palcu@oss.nxp.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 12 Mar 2020 12:25:45 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJbZdrANVLgaiDWO0V8bzZ568hHZ8Fu5UZ7D5Nr3hjHiA@mail.gmail.com>
Message-ID: <CAL_JsqJbZdrANVLgaiDWO0V8bzZ568hHZ8Fu5UZ7D5Nr3hjHiA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] dt-bindings: display: imx: add bindings for DCSS
To:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        lukas@mntmn.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 6, 2020 at 6:50 AM Laurentiu Palcu
<laurentiu.palcu@oss.nxp.com> wrote:
>
> From: Laurentiu Palcu <laurentiu.palcu@nxp.com>

Please send to DT list if you want timely (by some definition) feedback.

> Add bindings for iMX8MQ Display Controller Subsystem.
>
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> ---
>  .../bindings/display/imx/nxp,imx8mq-dcss.yaml | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
>
> diff --git a/Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml b/Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
> new file mode 100644
> index 000000000000..fde6ec8cb0c3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019 NXP
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/display/imx/nxp,imx8mq-dcss.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: iMX8MQ Display Controller Subsystem (DCSS)
> +
> +maintainers:
> +  - Laurentiu Palcu <laurentiu.palcu@nxp.com>
> +
> +description:
> +
> +  The DCSS (display controller sub system) is used to source up to three
> +  display buffers, compose them, and drive a display using HDMI 2.0a(with HDCP
> +  2.2) or MIPI-DSI. The DCSS is intended to support up to 4kp60 displays. HDR10
> +  image processing capabilities are included to provide a solution capable of
> +  driving next generation high dynamic range displays.
> +
> +properties:
> +  compatible:
> +    const: nxp,imx8mq-dcss
> +
> +  reg:
> +    maxItems: 2

Need to say what each entry is.


> +
> +  interrupts:
> +    maxItems: 3

Can drop. Implied by 'items' list.

> +    items:
> +      - description: Context loader completion and error interrupt
> +      - description: DTG interrupt used to signal context loader trigger time
> +      - description: DTG interrupt for Vblank
> +
> +  interrupt-names:
> +    maxItems: 3

Can drop.

> +    items:
> +      - const: ctxld
> +      - const: ctxld_kick
> +      - const: vblank
> +
> +  clocks:
> +    maxItems: 5

Can drop.

> +    items:
> +      - description: Display APB clock for all peripheral PIO access interfaces
> +      - description: Display AXI clock needed by DPR, Scaler, RTRAM_CTRL
> +      - description: RTRAM clock
> +      - description: Pixel clock, can be driver either by HDMI phy clock or MIPI
> +      - description: DTRC clock, needed by video decompressor
> +
> +  clock-names:
> +    items:
> +      - const: apb
> +      - const: axi
> +      - const: rtrm
> +      - const: pix
> +      - const: dtrc
> +
> +  port:
> +    type: object
> +    description:
> +      A port node pointing to the input port of a HDMI/DP or MIPI display bridge.
> +
> +examples:
> +  - |
> +    dcss: display-controller@32e00000 {
> +        compatible = "nxp,imx8mq-dcss";
> +        reg = <0x32e00000 0x2d000>, <0x32e2f000 0x1000>;
> +        interrupts = <6>, <8>, <9>;
> +        interrupt-names = "ctxld", "ctxld_kick", "vblank";
> +        interrupt-parent = <&irqsteer>;
> +        clocks = <&clk 248>, <&clk 247>, <&clk 249>,
> +                 <&clk 254>,<&clk 122>;
> +        clock-names = "apb", "axi", "rtrm", "pix", "dtrc";
> +        assigned-clocks = <&clk 107>, <&clk 109>, <&clk 266>;
> +        assigned-clock-parents = <&clk 78>, <&clk 78>, <&clk 3>;
> +        assigned-clock-rates = <800000000>,
> +                               <400000000>;
> +        port {
> +            dcss_out: endpoint {
> +                remote-endpoint = <&hdmi_in>;
> +            };
> +        };
> +    };
> +
> --
> 2.17.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
