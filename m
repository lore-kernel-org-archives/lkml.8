Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A21C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82ED8207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgHJS1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 14:27:17 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:54584 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgHJS1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 14:27:16 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 4F7CB20023;
        Mon, 10 Aug 2020 20:27:13 +0200 (CEST)
Date:   Mon, 10 Aug 2020 20:27:12 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     allen <allen.chen@ite.com.tw>
Cc:     Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] ite-it6505 change trigger conditions
Message-ID: <20200810182712.GA408647@ravnborg.org>
References: <1597053278-25421-1-git-send-email-allen.chen@ite.com.tw>
 <1597053278-25421-2-git-send-email-allen.chen@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597053278-25421-2-git-send-email-allen.chen@ite.com.tw>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=d2tX9T8KrmGLFF5Hj1IA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Allen.

On Mon, Aug 10, 2020 at 05:53:17PM +0800, allen wrote:
> it6505 changes trigger conditions.
> ---
>  Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> index 2c50016..bf0e889 100644
> --- a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> @@ -73,7 +73,7 @@ examples:
>  
>          dp-bridge@5c {
>              compatible = "ite,it6505";
> -            interrupts = <152 IRQ_TYPE_EDGE_FALLING 152 0>;
> +            interrupts = <152 IRQ_TYPE_LEVEL_LOW 152 0>;
>              reg = <0x5c>;
>              pinctrl-names = "default";
>              pinctrl-0 = <&it6505_pins>;
I fail to see the need for this. The example shall describe the binding
and is not necessarily a correct description of the HW.
People should look in the dts file for the HW descriptions, not the
binding examples. So I have dropped this patch.

	Sam

> -- 
> 1.9.1
