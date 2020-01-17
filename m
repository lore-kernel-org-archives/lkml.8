Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA82C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC89220748
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAQSI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 13:08:26 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:35258 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgAQSIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 13:08:25 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 549452002C;
        Fri, 17 Jan 2020 19:08:18 +0100 (CET)
Date:   Fri, 17 Jan 2020 19:08:17 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, stonea168@163.com,
        cawa.cheng@mediatek.com, linux-mediatek@lists.infradead.org,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com
Subject: Re: [PATCH v9 1/5] dt-bindings: display: panel: Add boe tv101wum-n16
 panel bindings
Message-ID: <20200117180817.GA17294@ravnborg.org>
References: <20200116021511.22675-1-jitao.shi@mediatek.com>
 <20200116021511.22675-2-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116021511.22675-2-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8
        a=mpaa-ttXAAAA:8 a=gEfo2CItAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
        a=e5mUnYsNAAAA:8 a=bHLQw6FTChaek29_IE4A:9 a=GUAa75DiEQyea0yL:21
        a=icJfZ08v17ktqyR2:21 a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
        a=6heAxKwa5pAsJatQ0mat:22 a=sptkURWiP4Gy88Gu7hUp:22
        a=AjGcO6oz07-iQ99wixmX:22 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jitao.

Looks good, much better than the individual files.
Rob Herring is still listed as maintainer which I questioned in last
feedback.

With this resolved (kept only if Rob confirms), this is
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

On Thu, Jan 16, 2020 at 10:15:07AM +0800, Jitao Shi wrote:
> Add documentation for "boe,tv101wum-n16", "auo,kd101n80-45na",
> "boe,tv101wum-n53" and "auo,b101uan08.3" panels.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  .../display/panel/boe,tv101wum-nl6.yaml       | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
> new file mode 100644
> index 000000000000..cc4e058f5eee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/boe,tv101wum-nl6.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: BOE TV101WUM-NL6 DSI Display Panel
> +
> +maintainers:
> +  - Thierry Reding <thierry.reding@gmail.com>
> +  - Sam Ravnborg <sam@ravnborg.org>
> +  - Rob Herring <robh+dt@kernel.org>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +        # BOE TV101WUM-NL6 10.1" WUXGA TFT LCD panel
> +      - boe,tv101wum-nl6
> +        # AUO KD101N80-45NA 10.1" WUXGA TFT LCD panel
> +      - auo,kd101n80-45na
> +        # BOE TV101WUM-N53 10.1" WUXGA TFT LCD panel
> +      - boe,tv101wum-n53
> +        # AUO B101UAN08.3 10.1" WUXGA TFT LCD panel
> +      - auo,b101uan08.3
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
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
