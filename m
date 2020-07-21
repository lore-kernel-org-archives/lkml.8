Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF202C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B3752080D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595301943;
	bh=RABhCOC89MZhVuLxs3cnNJ3H6w6Ka5FamAwpLDmI4pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FZvxrEQVyKkdf/cGOw4T8g40MoiEM2OHdXr/Sa52K0l1m8gaDRjXMhUMh2xvfdwQz
	 UglZ3q3E66Tb+UJkbJOosNdKLj+7zZTxnNYBr6c+m5/tYl+tcaLSbz047hVaobnho8
	 //VdIBO+stl2gajulvcHqMieEQ7YfoACsWbWSdEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgGUDZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 23:25:42 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34416 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbgGUDZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 23:25:40 -0400
Received: by mail-io1-f66.google.com with SMTP id q74so19929979iod.1;
        Mon, 20 Jul 2020 20:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PbmHXiUgYZ7K3k3+4SC1dxQ0M9qSdVSxsuVwkOW5+Ow=;
        b=kdcyTZrdm44HBnXC9CerCLcMLYi1ecm0OmRxEB8f30NZI435BlzTnMIwXCnlclcrRs
         iXUbVvRuAvT8VnyEDLJ8qp6sbUjDqC0cIQY0fTXRnwuaauuYnuZGV1uuKBnRjH3CgS6j
         6sjAFqZbWYO6wF2W+ddRRKgV/KOI9B23b++N5ezvp9iJVZ1SJzSwNi6Py4OHtdJAnpXC
         i43LbeUvgeI3g6M+tBO/KQE48aspgOe4w8SdKh4F2gXjj71jmr+dsXIQf1iDszeH2e4z
         EEYq+ic0BPdZ+HwhHu2RVrnL2KRcGaD1qakYIaejASmv3dIXFEZhjRitGd1fQyZKc/WB
         kNGw==
X-Gm-Message-State: AOAM532SWFYVFGh9OUNDVYERviQ8nG7Avz1vaoJggrUokE8vJW6jgbkb
        yTKAcQHEgfbtK1tspjR7iw==
X-Google-Smtp-Source: ABdhPJycudUTQZUWHZqdt3WKQxrt/MH89xE6iuGVYnrVJSrbXkzUig2eq2rAIRTz4FYtbGGk+4363w==
X-Received: by 2002:a05:6602:1610:: with SMTP id x16mr25769599iow.68.1595301939583;
        Mon, 20 Jul 2020 20:25:39 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id p12sm9772317ilj.16.2020.07.20.20.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 20:25:38 -0700 (PDT)
Received: (nullmailer pid 3491686 invoked by uid 1000);
        Tue, 21 Jul 2020 03:25:36 -0000
Date:   Mon, 20 Jul 2020 21:25:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        dianders@chromium.org, heiko@sntech.de,
        Caesar Wang <wxt@rock-chips.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: power: rockchip: Convert to json-schema
Message-ID: <20200721032536.GA3476792@bogus>
References: <20200715170216.2875868-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715170216.2875868-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 07:02:16PM +0200, Enric Balletbo i Serra wrote:
> Convert the soc/rockchip/power_domain.txt binding document to json-schema
> and move to the power bindings directory.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  .../power/rockchip,power-controller.yaml      | 154 ++++++++++++++++++
>  .../bindings/soc/rockchip/power_domain.txt    | 136 ----------------
>  2 files changed, 154 insertions(+), 136 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
>  delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> new file mode 100644
> index 000000000000..af50cf2b3e63
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> @@ -0,0 +1,154 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/rockchip,power-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip Power Domains
> +
> +maintainers:
> +  - Caesar Wang <wxt@rock-chips.com>
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +description: |
> +  Rockchip processors include support for multiple power domains which can be
> +  powered up/down by software based on different application scenes to save power.
> +
> +  Power domains contained within power-controller node are generic power domain
> +  providers documented in Documentation/devicetree/bindings/power/power-domain.yaml.
> +
> +  IP cores belonging to a power domain should contain a 'power-domains'
> +  property that is a phandle for the power domain node representing the domain.
> +
> +properties:
> +  power-controller:
> +    type: object
> +    description: List of power domains provided by this controller.
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - rockchip,px30-power-controller
> +          - rockchip,rk3036-power-controller
> +          - rockchip,rk3066-power-controller
> +          - rockchip,rk3128-power-controller
> +          - rockchip,rk3188-power-controller
> +          - rockchip,rk3228-power-controller
> +          - rockchip,rk3288-power-controller
> +          - rockchip,rk3328-power-controller
> +          - rockchip,rk3366-power-controller
> +          - rockchip,rk3368-power-controller
> +          - rockchip,rk3399-power-controller
> +
> +      reg:
> +        description: |
> +          Power domain index. Valid values are defined in:
> +          "include/dt-bindings/power/px30-power.h" - for PX30 type power domain.
> +          "include/dt-bindings/power/rk3036-power.h" - for RK3036 type power domain.
> +          "include/dt-bindings/power/rk3066-power.h" - for RK3066 type power domain.
> +          "include/dt-bindings/power/rk3128-power.h" - for RK3128 type power domain.
> +          "include/dt-bindings/power/rk3188-power.h" - for RK3188 type power domain.
> +          "include/dt-bindings/power/rk3228-power.h" - for RK3228 type power domain.
> +          "include/dt-bindings/power/rk3288-power.h" - for RK3288 type power domain.
> +          "include/dt-bindings/power/rk3328-power.h" - for RK3328 type power domain.
> +          "include/dt-bindings/power/rk3366-power.h" - for RK3366 type power domain.
> +          "include/dt-bindings/power/rk3368-power.h" - for RK3368 type power domain.
> +          "include/dt-bindings/power/rk3399-power.h" - for RK3399 type power domain.
> +        maxItems: 1
> +
> +      clocks:
> +        description: |
> +          A number of phandles to clocks that need to be enabled while power domain
> +          switches state.
> +      pm_qos:
> +        description: |
> +          A number of phandles to qos blocks which need to be saved and restored
> +          while power domain switches state.
> +
> +      power-supply: true
> +
> +    required:
> +      - compatible
> +      - reg

You need:

       additionalProperties: false

(with indentation). Then you will get a bunch of errors as you are 
missing a level of nodes. The 'power-controller' node doesn't have 
'reg' for example. You'll need to use 'patternProperties' with '^pd_'.

And to describe the nested power domains, you have to describe yet 
another level. You can do a $ref with something like:

$ref: '#/properties/power-controller/patternProperties/^pd_'

That creates a circular reference though and I'm not sure what will 
happen. :)

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rk3399-cru.h>
> +    #include <dt-bindings/power/rk3399-power.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        qos_iep: qos@ffa98000 {
> +            compatible = "syscon";

This will generate a warning now. 'syscon' should not be used alone.

> +            reg = <0x0 0xffa98000 0x0 0x20>;
> +        };
> +
> +        qos_rga_r: qos@ffab0000 {
> +            compatible = "syscon";
> +            reg = <0x0 0xffab0000 0x0 0x20>;
> +        };
> +
> +        qos_rga_w: qos@ffab0080 {
> +            compatible = "syscon";
> +            reg = <0x0 0xffab0080 0x0 0x20>;
> +        };
> +
> +        qos_video_m0: qos@ffab8000 {
> +            compatible = "syscon";
> +            reg = <0x0 0xffab8000 0x0 0x20>;
> +        };
> +
> +        qos_video_m1_r: qos@ffac0000 {
> +            compatible = "syscon";
> +            reg = <0x0 0xffac0000 0x0 0x20>;
> +        };
> +
> +        qos_video_m1_w: qos@ffac0080 {
> +            compatible = "syscon";
> +            reg = <0x0 0xffac0080 0x0 0x20>;
> +        };
> +
> +        power-management@ff310000 {
> +            compatible = "rockchip,rk3399-pmu", "syscon", "simple-mfd";
> +            reg = <0x0 0xff310000 0x0 0x1000>;
> +
> +            power-controller {
> +                compatible = "rockchip,rk3399-power-controller";
> +                #power-domain-cells = <1>;
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                /* These power domains are grouped by VD_CENTER */
> +                pd_iep@RK3399_PD_IEP {
> +                    reg = <RK3399_PD_IEP>;
> +                    clocks = <&cru ACLK_IEP>,
> +                             <&cru HCLK_IEP>;
> +                    pm_qos = <&qos_iep>;
> +                };
> +                pd_rga@RK3399_PD_RGA {
> +                    reg = <RK3399_PD_RGA>;
> +                    clocks = <&cru ACLK_RGA>,
> +                             <&cru HCLK_RGA>;
> +                    pm_qos = <&qos_rga_r>,
> +                             <&qos_rga_w>;
> +                };
> +                pd_vcodec@RK3399_PD_VCODEC {
> +                    reg = <RK3399_PD_VCODEC>;
> +                    clocks = <&cru ACLK_VCODEC>,
> +                             <&cru HCLK_VCODEC>;
> +                    pm_qos = <&qos_video_m0>;
> +                };
> +                pd_vdu@RK3399_PD_VDU {
> +                    reg = <RK3399_PD_VDU>;
> +                    clocks = <&cru ACLK_VDU>,
> +                             <&cru HCLK_VDU>;
> +                    pm_qos = <&qos_video_m1_r>,
> +                             <&qos_video_m1_w>;
> +                };
> +            };
> +        };
> +    };
