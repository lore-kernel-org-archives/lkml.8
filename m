Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D78C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 11:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F03E207C3
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 11:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgIGLqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 07:46:52 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:42196 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728973AbgIGLp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:45:57 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 184F420024;
        Mon,  7 Sep 2020 13:45:54 +0200 (CEST)
Date:   Mon, 7 Sep 2020 13:45:52 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     thierry.reding@gmail.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: display: panel: add TDO tl070wsh30
 DSI panel bindings
Message-ID: <20200907114552.GA526406@ravnborg.org>
References: <20200907111027.21933-1-narmstrong@baylibre.com>
 <20200907111027.21933-3-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907111027.21933-3-narmstrong@baylibre.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=CaYmGojl c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=IpJZQVW2AAAA:8 a=gEfo2CItAAAA:8
        a=3nj7rlk6SGwJzBwD0W8A:9 a=CjuIK1q_8ugA:10 a=IawgGOuG5U0WyFbmm1f5:22
        a=sptkURWiP4Gy88Gu7hUp:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil.

On Mon, Sep 07, 2020 at 01:10:26PM +0200, Neil Armstrong wrote:
> This add the bindings for the 1024*600 tl070wsh30 DSI panel.

The binding looks like a panel-simple-dsi.yaml candidate.
Only differen is enable-gpios versus reset-gpios

Could you check if we can use panel-simple-dsi-yaml.

	Sam

> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../display/panel/tdo,tl070wsh30.yaml         | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/tdo,tl070wsh30.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/tdo,tl070wsh30.yaml b/Documentation/devicetree/bindings/display/panel/tdo,tl070wsh30.yaml
> new file mode 100644
> index 000000000000..20f4fdedfcb0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/tdo,tl070wsh30.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +# Copyright 2020 BayLibre, SAS
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/tdo,tl070wsh30.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TDO TL070WSH30 DSI panel
> +
> +maintainers:
> +  - Neil Armstrong <narmstrong@baylibre.com>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +
> +  compatible:
> +    enum:
> +      - tdo,tl070wsh30
> +
> +  reg:
> +    maxItems: 1
> +    description: DSI virtual channel
> +
> +  backlight: true
> +  reset-gpios: true
> +  port: true
> +  power-supply: true
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - power-supply
> +  - reset-gpios
> +  - port
> +  - reg
> +
> +examples:
> +  - |
> +    dsi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      panel@0 {
> +        compatible = "tdo,tl070wsh30";
> +        reg = <0>;
> +        power-supply = <&vcc_lcd_reg>;
> +        backlight = <&panel_backlight>;
> +        reset-gpios = <&gpio_reset>;
> +
> +        port {
> +          panel: endpoint {
> +            remote-endpoint = <&mipi_dsi_out>;
> +          };
> +        };
> +      };
> +    };
> -- 
> 2.22.0
