Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17209C43332
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39A720724
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584642573;
	bh=rxgqISc6H/nWdoqhLpBm0M5HKY7xHBQ6EF93lmfO7Y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zLordtJ8M/YACCQxy7wLEjc1wioE67ByLgI3ASi0/dq9R92k6V1nRGtIjt9UTQSLD
	 Fzbx2BQqkl0y42YcS+H2ZNQMqmW67ZzCLMr6HoHaoWFfz9f7kxZPMSHNGKwerygry0
	 zeM7VCf+QCizLYzpBSTO8IYQly1FSjT/BWEI4LcA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgCSS3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 14:29:32 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:46972 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgCSS3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 14:29:31 -0400
Received: by mail-il1-f193.google.com with SMTP id e8so3156376ilc.13;
        Thu, 19 Mar 2020 11:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nuVG9R1fl5aV0113Wkqeyi+DwSUJE/i7o0mHYMU/pW0=;
        b=fNzyUo82gZ+XixyRoW4+PIO+KGthnbHdll9BhAZxsbFe6vKCVrpvXo/VAdPJ+zGqGb
         VkblMNViqBYhYf5FhR+N0TE3SrZa6p728jb5Qb8SgZoqflOtXqzICAQREbydE4ASE9tt
         kpQUVbn6qUDyNoYXbxmmdCdcN21O+Rn8rzLKp/pbRRtB7OeNTKAjiz1BEV3QAISRi5WP
         eDq9N/YjPDwpI0fdLUSP0OYSIDjda6LdKonZUK/lnizR+1gBk4LHCoahPCDzSJyW+l1v
         s+35X46HulciEUuZky0WiX/+PJ1g/zKpMT0BbMyho+jH3g0ScV43d2tRv8kIDjY1rJkR
         cl2g==
X-Gm-Message-State: ANhLgQ3K0djvg4y/+BU0J0+E4CsIVs6dH2yMeieECi7uDarwr3kAw5tV
        PHyRtnX4uZZLSEn44Yg9rA==
X-Google-Smtp-Source: ADFU+vuYRWENnnjTGXdM/3tIX9NPpmnsPCMZgoJW/FYaAg8G19QayHs3ZHRHOhNCbt+PxUpH9dpgjA==
X-Received: by 2002:a92:9c54:: with SMTP id h81mr4599212ili.109.1584642569415;
        Thu, 19 Mar 2020 11:29:29 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id c28sm1144757ilf.26.2020.03.19.11.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 11:29:28 -0700 (PDT)
Received: (nullmailer pid 16853 invoked by uid 1000);
        Thu, 19 Mar 2020 18:29:25 -0000
Date:   Thu, 19 Mar 2020 12:29:25 -0600
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
Subject: Re: [PATCH v13 2/6] dt-bindings: display: mediatek: control dpi pins
 mode to avoid leakage
Message-ID: <20200319182925.GA13920@bogus>
References: <20200311071823.117899-1-jitao.shi@mediatek.com>
 <20200311071823.117899-3-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311071823.117899-3-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 03:18:19PM +0800, Jitao Shi wrote:
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
> index 58914cf681b8..260ae75ac640 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
> @@ -17,6 +17,10 @@ Required properties:
>    Documentation/devicetree/bindings/graph.txt. This port should be connected
>    to the input port of an attached HDMI or LVDS encoder chip.
>  
> +Optional properties:
> +- pinctrl-names: Contain "default" and "sleep".

> +  pinctrl-names see Documentation/devicetree/bindings/pinctrlpinctrl-bindings.txt

Drop this line.

> +
>  Example:
>  
>  dpi0: dpi@1401d000 {
> @@ -27,6 +31,9 @@ dpi0: dpi@1401d000 {
>  		 <&mmsys CLK_MM_DPI_ENGINE>,
>  		 <&apmixedsys CLK_APMIXED_TVDPLL>;
>  	clock-names = "pixel", "engine", "pll";
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&dpi_pin_func>;
> +	pinctrl-1 = <&dpi_pin_idle>;
>  
>  	port {
>  		dpi0_out: endpoint {
> -- 
> 2.21.0
