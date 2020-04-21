Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECC1C55186
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 23:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18E6C20736
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 23:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587510103;
	bh=OzM3PC6Eo/10PD5ApVmiinYzSR9WtgVpy63OgR+KnOQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IkesQsopN1owgsrzst4VWr0Rtl2p0X2qg0dL24D9dtgdHGq8715wG0v/2P3RAE9kJ
	 HINMYzYLQbIEMJQy0AOj2ToP9o2PgBqbZh8tH1mIcFyCWHVTPw0GE2uS2wXvICJcoS
	 2Qu0Hd0ak+EYvgu4yXa6UfKL94fM44/afRY2ASXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgDUXBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 19:01:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgDUXBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 19:01:41 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81EDE20736;
        Tue, 21 Apr 2020 23:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587510100;
        bh=OzM3PC6Eo/10PD5ApVmiinYzSR9WtgVpy63OgR+KnOQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YUBpeY7yvgo9UJe25lyaTkXN9eqvci7g+yXrTMi8wurkq18JUtTIUUDiXkH6HwG26
         cPqW9C/UCkL8CTwLPnslJgXmmMODTXA6556UNBJ7LFft+SRWVnvsc5OxNlCZCGSuxo
         ZTUEKxwntWN3rtC+RB2nTet99RqsYapYRBRvS0BI=
Received: by mail-ej1-f46.google.com with SMTP id n17so345375ejh.7;
        Tue, 21 Apr 2020 16:01:40 -0700 (PDT)
X-Gm-Message-State: AGi0PuauS1ANFSxTPzgG+v7uIO4zHhQ4Z1pm3gIUc/WSHa4x2oyFttKj
        vOHbSbBoeSLfGn6mNOpRoK4SA7QYaiqNL300Lg==
X-Google-Smtp-Source: APiQypJjtQ9J79KZq2uuN/KxEwfL8dIg+xvPcbzJEGwVqG3VA0FTVqHmr1wJByUQFRVOzIk8+SnGlVKcLKQub2AHOLY=
X-Received: by 2002:a17:906:eb90:: with SMTP id mh16mr23786643ejb.201.1587510098939;
 Tue, 21 Apr 2020 16:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200415011319.25559-1-jitao.shi@mediatek.com> <20200415011319.25559-3-jitao.shi@mediatek.com>
In-Reply-To: <20200415011319.25559-3-jitao.shi@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 22 Apr 2020 07:01:27 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9-=VxBYbz2VNnPEphpa2gYBJnrVfJvL5Z+G6m_vcg2xQ@mail.gmail.com>
Message-ID: <CAAOTY_9-=VxBYbz2VNnPEphpa2gYBJnrVfJvL5Z+G6m_vcg2xQ@mail.gmail.com>
Subject: Re: [PATCH v15 2/3] dt-bindings: display: mediatek: convert the
 document format from txt to yaml
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        huijuan.xie@mediatek.com, stonea168@163.com,
        cawa.cheng@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, yingjoe.chen@mediatek.com,
        eddie.huang@mediatek.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jitao:

Please fixup these checkpatch warnings.

WARNING: Missing commit description - Add an appropriate one
WARNING: DT binding docs and includes should be a separate patch. See:
Documentation/devicetree/bindings/submitting-patches.txt
WARNING: DT binding docs and includes should be a separate patch. See:
Documentation/devicetree/bindings/submitting-patches.txt
WARNING: DT binding documents should be licensed (GPL-2.0-only OR BSD-2-Cla=
use)
#71: FILE: Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.=
yaml:1:
+# SPDX-License-Identifier: GPL-2.0

Regards,
Chun-Kuang.

Jitao Shi <jitao.shi@mediatek.com> =E6=96=BC 2020=E5=B9=B44=E6=9C=8815=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=889:13=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  .../bindings/display/mediatek/mediatek,dpi.txt     | 42 ----------
>  .../bindings/display/mediatek/mediatek,dpi.yaml    | 97 ++++++++++++++++=
++++++
>  2 files changed, 97 insertions(+), 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/mediatek/me=
diatek,dpi.txt
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/me=
diatek,dpi.yaml
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
dpi.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.t=
xt
> deleted file mode 100644
> index 77def4456706..000000000000
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -Mediatek DPI Device
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -The Mediatek DPI function block is a sink of the display subsystem and
> -provides 8-bit RGB/YUV444 or 8/10/10-bit YUV422 pixel data on a parallel
> -output bus.
> -
> -Required properties:
> -- compatible: "mediatek,<chip>-dpi"
> -  the supported chips are mt2701 , mt8173 and mt8183.
> -- reg: Physical base address and length of the controller's registers
> -- interrupts: The interrupt signal from the function block.
> -- clocks: device clocks
> -  See Documentation/devicetree/bindings/clock/clock-bindings.txt for det=
ails.
> -- clock-names: must contain "pixel", "engine", and "pll"
> -- port: Output port node with endpoint definitions as described in
> -  Documentation/devicetree/bindings/graph.txt. This port should be conne=
cted
> -  to the input port of an attached HDMI or LVDS encoder chip.
> -
> -Optional properties:
> -- pinctrl-names: Contain "default" and "sleep".
> -
> -Example:
> -
> -dpi0: dpi@1401d000 {
> -       compatible =3D "mediatek,mt8173-dpi";
> -       reg =3D <0 0x1401d000 0 0x1000>;
> -       interrupts =3D <GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>;
> -       clocks =3D <&mmsys CLK_MM_DPI_PIXEL>,
> -                <&mmsys CLK_MM_DPI_ENGINE>,
> -                <&apmixedsys CLK_APMIXED_TVDPLL>;
> -       clock-names =3D "pixel", "engine", "pll";
> -       pinctrl-names =3D "default", "sleep";
> -       pinctrl-0 =3D <&dpi_pin_func>;
> -       pinctrl-1 =3D <&dpi_pin_idle>;
> -
> -       port {
> -               dpi0_out: endpoint {
> -                       remote-endpoint =3D <&hdmi0_in>;
> -               };
> -       };
> -};
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.=
yaml
> new file mode 100644
> index 000000000000..2c2d6a71cb8b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yam=
l
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: mediatek DPI Controller Device Tree Bindings
> +
> +maintainers:
> +  - CK Hu <ck.hu@mediatek.com>
> +  - Jitao shi <jitao.shi@mediatek.com>
> +
> +description: |
> +  The Mediatek DPI function block is a sink of the display subsystem and
> +  provides 8-bit RGB/YUV444 or 8/10/10-bit YUV422 pixel data on a parall=
el
> +  output bus.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt2701-dpi
> +      - mediatek,mt8173-dpi
> +      - mediatek,mt8183-dpi
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Pixel Clock
> +      - description: Engine Clock
> +      - description: DPI PLL
> +
> +  clock-names:
> +    items:
> +      - const: pixel
> +      - const: engine
> +      - const: pll
> +
> +  pinctrl-0: true
> +  pinctrl-1: true
> +
> +  pinctrl-names:
> +    items:
> +      - const: default
> +      - const: sleep
> +
> +  port:
> +    type: object
> +    description:
> +      Output port node with endpoint definitions as described in
> +      Documentation/devicetree/bindings/graph.txt. This port should be c=
onnected
> +      to the input port of an attached HDMI or LVDS encoder chip.
> +
> +    properties:
> +      endpoint:
> +        type: object
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/mt8173-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    dpi0: dpi@1401d000 {
> +        compatible =3D "mediatek,mt8173-dpi";
> +        reg =3D <0 0x1401d000 0 0x1000>;
> +        interrupts =3D <GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>;
> +        clocks =3D <&mmsys CLK_MM_DPI_PIXEL>,
> +             <&mmsys CLK_MM_DPI_ENGINE>,
> +             <&apmixedsys CLK_APMIXED_TVDPLL>;
> +        clock-names =3D "pixel", "engine", "pll";
> +        pinctrl-names =3D "default", "sleep";
> +        pinctrl-0 =3D <&dpi_pin_func>;
> +        pinctrl-1 =3D <&dpi_pin_idle>;
> +
> +        port {
> +            dpi0_out: endpoint {
> +                remote-endpoint =3D <&hdmi0_in>;
> +            };
> +        };
> +    };
> +
> +...
> --
> 2.12.5
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
