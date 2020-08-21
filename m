Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6538EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38F3E22B47
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgHURR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:17:58 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:52778 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729066AbgHURRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 13:17:04 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 0985F20022;
        Fri, 21 Aug 2020 19:17:00 +0200 (CEST)
Date:   Fri, 21 Aug 2020 19:16:59 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, robdclark@chromium.org,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: simple: Add KD116N21-30NV-A010
 compatible
Message-ID: <20200821171659.GA308295@ravnborg.org>
References: <20200821083454.1.I61e6248813d797c9eeebfbb7019c713aa71c4419@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821083454.1.I61e6248813d797c9eeebfbb7019c713aa71c4419@changeid>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=cm27Pg_UAAAA:8 a=Ivq3uMdIfu5b0hwgkMQA:9
        a=CjuIK1q_8ugA:10 a=xmb-EsYY8bH0VWELuYED:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Douglas.

On Fri, Aug 21, 2020 at 08:35:14AM -0700, Douglas Anderson wrote:
> The KD116N21-30NV-A010 is a pretty standard eDP panel.  Add it to the
> list of compatible strings.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Both patches applied to drm-misc-next.

	Sam

> ---
> 
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index 47247ace86ac..f2204f17a9dc 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -161,6 +161,8 @@ properties:
>        - innolux,n156bge-l21
>          # Innolux Corporation 7.0" WSVGA (1024x600) TFT LCD panel
>        - innolux,zj070na-01p
> +        # King & Display KD116N21-30NV-A010 eDP TFT LCD panel
> +      - kingdisplay,kd116n21-30nv-a010
>          # Kaohsiung Opto-Electronics Inc. 5.7" QVGA (320 x 240) TFT LCD panel
>        - koe,tx14d24vm1bpa
>          # Kaohsiung Opto-Electronics Inc. 10.1" WUXGA (1920 x 1200) LVDS TFT LCD panel
> -- 
> 2.28.0.297.g1956fa8f8d-goog
