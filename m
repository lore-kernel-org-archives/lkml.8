Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2055C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C0EE204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598321700;
	bh=XGFf5Fw0UayQG3j+uycg9IlFb0HpDoqlWLldlWqSOrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JdHqXC56+9Vn8X7HOIAmpVa1lFXqXtQTUNz1EXZ+TURT+0LoJjQKr+1VxXc+QPNiA
	 c85gc+Xa9dAptSpJpbI3q023OSl5VUe03KjkS09HwVlGa2rxMx5O+9xYmdCEJMEhbZ
	 PwKzYM3YALeuZuBuNDLIUsYbvjavsKSOhZ9hxCNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgHYCO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:14:59 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42033 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgHYCO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:14:58 -0400
Received: by mail-io1-f67.google.com with SMTP id g13so10899958ioo.9;
        Mon, 24 Aug 2020 19:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ek5F+H3O/scHf/IKBLIJYApR8mf1sgNbCuJGX+O39pc=;
        b=WxAadAshJ9PUZjzeGen5RVe1MbeWjNZ8pAX797M9aD2lmimizVD8om+7CnBjkkOgwl
         KF9izVh54stq7/t2IH40nPqozD8IwQHfdYVeOjC6/R5BXD7AlWd2Zm2OwaJ/wHlqC8UO
         1L+JKbFhUw8q8bfn3kndB+zgE+VpZGK3SpQYA4jd95xfuWdayQT0xTshWZTjV9g1n0bS
         g6t5odpTs2Xl+N/Dq62BSHgMWM05dk8AAiuhizfgjkh4K7HsJH+kQaV2KRgdalw8OLwt
         H1CZZmj9T+uGe9T2QEPDLvuwidBIZ3D9wv6eNirsun+cyqN3XT3L/964l59JOWeSobDb
         BUlA==
X-Gm-Message-State: AOAM531MJxpndaoNG/RZrI44ptjEL3iP4VjjaG0E1/YjAeQs+6zWJusk
        jh+0di3onWNyJgVkIhhJeA==
X-Google-Smtp-Source: ABdhPJxNxfKvFbxG4f0/yZMBg5QNRAhicF99/EkuVFWZ1jMVx0ih0hihJnB5oksWscSPYnlTD3tIsw==
X-Received: by 2002:a02:a90f:: with SMTP id n15mr8550255jam.120.1598321697011;
        Mon, 24 Aug 2020 19:14:57 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id 132sm8430792ilb.36.2020.08.24.19.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:14:56 -0700 (PDT)
Received: (nullmailer pid 3797833 invoked by uid 1000);
        Tue, 25 Aug 2020 02:14:52 -0000
Date:   Mon, 24 Aug 2020 20:14:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>, devicetree@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 10/17] Documentation: bindings: clk: Add bindings for
 i.MX BLK_CTRL
Message-ID: <20200825021452.GA3795142@bogus>
References: <1597406966-13740-1-git-send-email-abel.vesa@nxp.com>
 <1597406966-13740-11-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597406966-13740-11-git-send-email-abel.vesa@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 03:09:19PM +0300, Abel Vesa wrote:
> Document the i.MX BLK_CTRL with its devicetree properties.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  .../bindings/clock/fsl,imx-blk-ctrl.yaml           | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx-blk-ctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/fsl,imx-blk-ctrl.yaml b/Documentation/devicetree/bindings/clock/fsl,imx-blk-ctrl.yaml
> new file mode 100644
> index 00000000..b47590c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/fsl,imx-blk-ctrl.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only)

Dual license new bindings please:

(GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/fsl,imx-blk-ctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX BLK_CTRL
> +
> +maintainers:
> +  - Abel Vesa <abel.vesa@nxp.com>
> +
> +description:
> +  i.MX BLK_CTRL is a conglomerate of different GPRs that are
> +  dedicated to a specific subsystem. Because it usually contains
> +  clocks amongst other things, it needs access to the i.MX clocks
> +  API. All the other functionalities it provides can work just fine
> +  from the clock subsystem tree.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +         - fsl,imx8mp-audio-blk-ctrl
> +         - fsl,imx8mp-hdmi-blk-ctrl
> +         - fsl,imx8mp-media-blk-ctrl
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#reset-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - power-domains
> +  - '#clock-cells'
> +  - '#reset-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8mp-clock.h>
> +
> +    audio_blk_ctrl: clock-controller@30e20000 {
> +       compatible = "fsl,imx8mp-audio-blk-ctrl", "syscon";
> +       reg = <0x30e20000 0x10000>;
> +       power-domains = <&audiomix_pd>;
> +
> +       #clock-cells = <1>;
> +       #reset-cells = <1>;
> +    };
> -- 
> 2.7.4
> 
