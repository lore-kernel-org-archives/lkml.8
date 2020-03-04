Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B76C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC1420732
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583334002;
	bh=wvxq/vGbzNiq8n/RK5/EhcHV3z/kcMg9Bm6arutZxwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OMBQ6rs7XwLt7Nmt4PEPrHK2cmXQa0+ZvATqnkzRpG7rBELBDz6AebRNHzE5xkR9b
	 u0HDfFGybjNmYjxgFEG+NwxQb9CZ5SbpbtGJfd8SJRBQhOFVHs6E2KW1Q2Mz/OVvVy
	 tvT9JG0iyWgz62qOr7JR6yRPvVw1i0vZgGaqY8vA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgCDPAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:00:01 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43275 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgCDPAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:00:01 -0500
Received: by mail-oi1-f194.google.com with SMTP id p125so2335677oif.10;
        Wed, 04 Mar 2020 07:00:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5kzs+suiXGOLM6214SN1xySZQC2yuoHuAv+kXNmxnJI=;
        b=lcRtyXlcvbKwgeaV9KVnIuJXQjvC/Jf5lmd69MWPJEk5efZonlrtTATuknOsOFZKbp
         fSESkjBWIKORTGhEyq93mJt02ujRmICM2NwL8BbsBoMugDv7kqqHItpecZxQyW0UVo0t
         9jXCZulEF4Fx5KjbpX/j0WtBXYTXQj+77Q3RHZoMltx41B/kv1RpMwRLGXTGQpPQUYzA
         kCFS9GFYbNeX9qXR9dNEscSAtnZLfOjm6WL2uHp66CgATHyrvauCkUnRo7poE4/sH/sQ
         lG1Bl/xttv6whB6Eqb2yRydxJvZHEdBpoVXPGKdmJTRkv7T1P0WIb5NbONvkTsKOZiLY
         Sl2g==
X-Gm-Message-State: ANhLgQ2WZhcmYr6mDtJQlE5tnQ08EkzoXTF097kTE69GX4q8DvggxZxc
        YOH7mDIlUm4ojluZBzgYig==
X-Google-Smtp-Source: ADFU+vv8e6bqzfrEUfhRglZm6ics/VgmQ0DWwpgysZeN1Q7F7AyUjL7HRD+dgHJdDUz55H2/3Q1G6Q==
X-Received: by 2002:aca:5194:: with SMTP id f142mr2089262oib.100.1583333999966;
        Wed, 04 Mar 2020 06:59:59 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b15sm6358282oic.52.2020.03.04.06.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 06:59:59 -0800 (PST)
Received: (nullmailer pid 20406 invoked by uid 1000);
        Wed, 04 Mar 2020 14:59:58 -0000
Date:   Wed, 4 Mar 2020 08:59:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com,
        ck.hu@mediatek.com, stonea168@163.com, huijuan.xie@mediatek.com
Subject: Re: [PATCH v12 2/6] dt-bindings: display: mediatek: control dpi pins
 mode to avoid leakage
Message-ID: <20200304145958.GA17716@bogus>
References: <20200303052722.94795-1-jitao.shi@mediatek.com>
 <20200303052722.94795-3-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303052722.94795-3-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 01:27:18PM +0800, Jitao Shi wrote:
> Add property "pinctrl-names" to swap pin mode between gpio and dpi mode. Set
> the dpi pins to gpio mode and output-low to avoid leakage current when dpi
> disabled.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dpi.txt  | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
> index 58914cf681b8..77ca32a32399 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
> @@ -17,6 +17,10 @@ Required properties:
>    Documentation/devicetree/bindings/graph.txt. This port should be connected
>    to the input port of an attached HDMI or LVDS encoder chip.
>  
> +Optional properties:
> +- pinctrl-names: Contain "gpiomode" and "dpimode".

Doesn't match the example.

> +  pinctrl-names see Documentation/devicetree/bindings/pinctrlpinctrl-bindings.txt
> +
>  Example:
>  
>  dpi0: dpi@1401d000 {
> @@ -27,6 +31,9 @@ dpi0: dpi@1401d000 {
>  		 <&mmsys CLK_MM_DPI_ENGINE>,
>  		 <&apmixedsys CLK_APMIXED_TVDPLL>;
>  	clock-names = "pixel", "engine", "pll";
> +	pinctrl-names = "active", "idle";
> +	pinctrl-0 = <&dpi_pin_func>;
> +	pinctrl-1 = <&dpi_pin_idle>;
>  
>  	port {
>  		dpi0_out: endpoint {
> -- 
> 2.21.0
