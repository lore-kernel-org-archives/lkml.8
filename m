Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215AAC33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0093424671
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgAOVVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:21:13 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:44488 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgAOVVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 16:21:12 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 23F578050D;
        Wed, 15 Jan 2020 22:21:08 +0100 (CET)
Date:   Wed, 15 Jan 2020 22:21:06 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com,
        ck.hu@mediatek.com, stonea168@163.com
Subject: Re: [PATCH v8 1/8] dt-bindings: display: panel: Add BOE tv101wum-n16
 panel bindings
Message-ID: <20200115212106.GD28904@ravnborg.org>
References: <20200115135958.126303-1-jitao.shi@mediatek.com>
 <20200115135958.126303-2-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115135958.126303-2-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=mpaa-ttXAAAA:8
        a=7gkXJVJtAAAA:8 a=gEfo2CItAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
        a=-W9t3f-s57Xz0V4m3JgA:9 a=d-McAGeJY93I7joI:21 a=s8DGCSS_m8B6YGa2:21
        a=CjuIK1q_8ugA:10 a=6heAxKwa5pAsJatQ0mat:22 a=E9Po1WZjFZOl8hwRPBS3:22
        a=sptkURWiP4Gy88Gu7hUp:22 a=AjGcO6oz07-iQ99wixmX:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jitao.

A few comments that I missed in last round.

Please consider to combine the three panels in one binding.
I realise they are almost identical so no need for three binding files.

On Wed, Jan 15, 2020 at 09:59:51PM +0800, Jitao Shi wrote:
> Add documentation for boe tv101wum-n16 panel.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  .../display/panel/boe,tv101wum-nl6.yaml       | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
> new file mode 100644
> index 000000000000..d38aee22d406
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: GPL-2.0

Please use (GPL-2.0-only OR BSD-2-Clause) for all new bindings.
(Sorry if this was not part of my previous feedback)

	Sam

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/boe,tv101wum-nl6.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: BOE TV101WUM-Nl6 DSI Display Panel
> +
> +maintainers:
> +  - Thierry Reding <thierry.reding@gmail.com>
> +  - Sam Ravnborg <sam@ravnborg.org>

> +  - Rob Herring <robh+dt@kernel.org>
Rob is not a typical maintainer of panel bindings.
The fallback it Thierry and me.

But if you have agreed this with Rob then all is good.


> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +        const: boe,tv101wum-nl6
> +
> +  reg:
> +    description: the virtual channel number of a DSI peripheral
> +
> +  enable-gpios:
> +    description: a GPIO spec for the enable pin
> +
> +  pp1800-supply:
> +    description: core voltage supply
> +
> +  avdd-supply:
> +    description: phandle of the regulator that provides positive voltage
> +
> +  avee-supply:
> +    description: phandle of the regulator that provides negative voltage
> +
> +  backlight:
> +    description: phandle of the backlight device attached to the panel
> +
> +  port: true
> +
> +required:
> + - compatible
> + - reg
> + - enable-gpios
> + - pp1800-supply
> + - avdd-supply
> + - avee-supply

> + - backlight
I would be suprised if backlight is a required node.
You could always tie the input to a fixed voltage and then no backlight
node are required.
Please remove from the required list unless you can convince me
otherwise.

	Sam

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dsi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        panel@0 {
> +            compatible = "boe,tv101wum-nl6";
> +            reg = <0>;
> +            enable-gpios = <&pio 45 0>;
> +            avdd-supply = <&ppvarn_lcd>;
> +            avee-supply = <&ppvarp_lcd>;
> +            pp1800-supply = <&pp1800_lcd>;
> +            backlight = <&backlight_lcd0>;
> +            status = "okay";
> +            port {
> +                panel_in: endpoint {
> +                    remote-endpoint = <&dsi_out>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> -- 
> 2.21.0
