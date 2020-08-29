Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48D1C43461
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 21:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A522C2076D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 21:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbgH2VGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 17:06:05 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:51528 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbgH2VGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 17:06:03 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 02FCA804A4;
        Sat, 29 Aug 2020 23:06:00 +0200 (CEST)
Date:   Sat, 29 Aug 2020 23:05:59 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v2 1/2] dt-bindings: display: simple: Add
 AM-1280800N3TZQW-T00H
Message-ID: <20200829210559.GC796939@ravnborg.org>
References: <20200829163328.249211-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829163328.249211-1-jagan@amarulasolutions.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=A5ZCwZeG c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=iP-xVBlJAAAA:8 a=B3g72izkqJmtQJUIFioA:9
        a=CjuIK1q_8ugA:10 a=lHLH-nfn2y1bM_0xSXwp:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan.

On Sat, Aug 29, 2020 at 10:03:27PM +0530, Jagan Teki wrote:
> Add dt-bindings for 10.1" TFT LCD module from Ampire Co. Ltd.
> as part of panel-simple.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Thanks for the quick update.
Applied both patches to drm-misc-next.

	Sam

> ---
> Changes for v2:
> - none
> 
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index d6cca1479633..f629d04f7737 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -29,6 +29,8 @@ properties:
>      # compatible must be listed in alphabetical order, ordered by compatible.
>      # The description in the comment is mandatory for each compatible.
>  
> +        # Ampire AM-1280800N3TZQW-T00H 10.1" WQVGA TFT LCD panel
> +      - ampire,am-1280800n3tzqw-t00h
>          # Ampire AM-480272H3TMQW-T01H 4.3" WQVGA TFT LCD panel
>        - ampire,am-480272h3tmqw-t01h
>          # Ampire AM-800480R3TMQW-A1H 7.0" WVGA TFT LCD panel
> -- 
> 2.25.1
