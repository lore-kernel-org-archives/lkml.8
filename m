Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	PDS_HP_HELO_NORDNS,RDNS_NONE,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44989 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgCKKIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 06:08:25 -0400
MIME-Version: 1.0
References: <1583872919-7757-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1583872919-7757-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1583872919-7757-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2020 11:08:13 +0100
Message-ID:
 <CAMuHMdVqwLEavjnPgZaevFqjTytAPMmT042yRrcDw9YpkjE3bg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: renesas: Add HiHope RZ/G2M board with
 idk-1110wr display
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
Message-ID: <20200311100813.pZHSwtMwotxdQr4AGJrvlTaoL7BT5AyAuK5uL9bmY0k@z>

Hi Lad,

On Tue, Mar 10, 2020 at 9:42 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
>
> The HiHope RZ/G2M is advertised as compatible with panel idk-1110wr
> from Advantech, however the panel isn't sold alongside the board.
> A new dts, adding everything that's required to get the panel to
> work the HiHope RZ/G2M, is the most convenient way to support the
> HiHope RZ/G2M when it's connected to the idk-1110wr.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for picking up this patch!

> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-idk-1110wr.dts
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for the HiHope RZ/G2M sub board connected to an
> + * Advantech IDK-1110WR 10.1" LVDS panel
> + *
> + * Copyright (C) 2020 Renesas Electronics Corp.
> + */
> +
> +#include "r8a774a1-hihope-rzg2m-ex.dts"
> +
> +/ {
> +       backlight {
> +               compatible = "pwm-backlight";
> +               pwms = <&pwm0 0 50000>;
> +
> +               brightness-levels = <0 2 8 16 32 64 128 255>;
> +               default-brightness-level = <6>;
> +       };
> +
> +       panel-lvds {
> +               compatible = "advantech,idk-1110wr", "panel-lvds";
> +
> +               width-mm = <223>;
> +               height-mm = <125>;
> +
> +               data-mapping = "jeida-24";
> +
> +               panel-timing {
> +                       /* 1024x600 @60Hz */
> +                       clock-frequency = <51200000>;
> +                       hactive = <1024>;
> +                       vactive = <600>;
> +                       hsync-len = <240>;
> +                       hfront-porch = <40>;
> +                       hback-porch = <40>;
> +                       vfront-porch = <15>;
> +                       vback-porch = <10>;
> +                       vsync-len = <10>;
> +               };
> +
> +               port {
> +                       panel_in: endpoint {
> +                               remote-endpoint = <&lvds0_out>;
> +                       };
> +               };
> +       };

I believe the plan was to include the existing
rzg2-advantech-idk-1110wr-panel.dtsi instead, to provide the
panel-lvds node...

> +};
> +
> +&gpio1 {
> +       /*
> +        * When GP1_20 is LOW LVDS0 is connected to the LVDS connector
> +        * When GP1_20 is HIGH LVDS0 is connected to the LT8918L
> +        */
> +       lvds-connector-en-gpio {
> +               gpio-hog;
> +               gpios = <20 GPIO_ACTIVE_HIGH>;
> +               output-low;
> +               line-name = "lvds-connector-en-gpio";
> +       };
> +};
> +
> +&lvds0 {
> +       status = "okay";
> +
> +       ports {
> +               port@1 {
> +                       lvds0_out: endpoint {
> +                               remote-endpoint = <&panel_in>;
> +                       };
> +               };
> +       };
> +};

... and the lvds_connector endpoint configuration.

The rest looks good to me.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

