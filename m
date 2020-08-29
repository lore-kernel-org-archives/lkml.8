Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF58C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 21:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F07EA2076D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 21:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgH2VG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 17:06:57 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:51596 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbgH2VG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 17:06:56 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 8C45F80487;
        Sat, 29 Aug 2020 23:06:53 +0200 (CEST)
Date:   Sat, 29 Aug 2020 23:06:52 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: display: samsung,amoled-mipi-dsi: Do
 not require enable-gpios on samsung,s6e63j0x03
Message-ID: <20200829210652.GD796939@ravnborg.org>
References: <20200829172532.29358-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829172532.29358-1-krzk@kernel.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=A5ZCwZeG c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=VwQbUJbxAAAA:8 a=7gkXJVJtAAAA:8
        a=sbQQ0qVRGQwO19CD9CoA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 07:25:29PM +0200, Krzysztof Kozlowski wrote:
> The samsung,s6e63j0x03 does not have enable GPIO, so do not require it.
> This fixes dtbs_check warning:
> 
>   arch/arm/boot/dts/exynos3250-rinato.dt.yaml: panel@0: 'enable-gpios' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>

I expect this patch is picked up with the dts fixes.

	Sam

> ---
>  .../display/panel/samsung,amoled-mipi-dsi.yaml       | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/samsung,amoled-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/panel/samsung,amoled-mipi-dsi.yaml
> index 96bdde9298e0..ccc482570d6a 100644
> --- a/Documentation/devicetree/bindings/display/panel/samsung,amoled-mipi-dsi.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/samsung,amoled-mipi-dsi.yaml
> @@ -12,6 +12,17 @@ maintainers:
>  allOf:
>    - $ref: panel-common.yaml#
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - samsung,s6e3ha2
> +              - samsung,s6e3hf2
> +    then:
> +      required:
> +        - enable-gpios
> +
>  properties:
>    compatible:
>      enum:
> @@ -39,7 +50,6 @@ required:
>    - vdd3-supply
>    - vci-supply
>    - reset-gpios
> -  - enable-gpios
>  
>  additionalProperties: false
>  
> -- 
> 2.17.1
