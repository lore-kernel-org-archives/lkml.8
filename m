Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1899C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 22:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C2020753
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 22:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585000838;
	bh=/0FVKzFHqIhe63ISdXNoCbWC3FR+88Guj0g2rxFpzA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yTgmy8FDaHSsnYbITBagJUFgChmO7NlYFLNbjueZfjzZ+HLmpjN2OGV5kVAWfSij0
	 5c6+Xlx28s+lLj96nQfb/nPw5ruNMgYi7r2M3bSFWX/TDa/b2CguyMWw7BbN4wmzbr
	 1icdvOZDruZyB5hBn92H9pDNhc4u/zcz1hxIVB54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgCWWAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 18:00:37 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:46209 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgCWWAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 18:00:37 -0400
Received: by mail-il1-f195.google.com with SMTP id e8so14845445ilc.13;
        Mon, 23 Mar 2020 15:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qFiwHqrhsKdbaQVzkW2fMkiFVAgwIM9ohgEmy5tZ2Xk=;
        b=h2XaWn25BA8f6ZdtQT7HumjsgZtaP6yjerv0FBvcjkUiO162O/U8UWR7wttUhTeeWU
         oqYnRtmybdIahgKbbX3/oJSjVv3YUXNh3xwcWzcqR/m8xygehiLopZDBq1jrAlbdIPCY
         xHNeBep+J2sJNa9jseWm0Yiz9x5OBJV7g4kokMBx0sPHoCkqR4gvaThy8tY4lDJrQ8jL
         0S/LPIDNuKTXDs43OCno432UayexhBI0CD+U98M+iPuf288pSCAm8hVgCkHTAMxd25Sv
         tnTUu3MLCvrUwYwlag+nyW3YskBZZzVw/jgYE8J0mD/oJaKa0DiwkDEkGxRJwUcGrJRg
         ly4g==
X-Gm-Message-State: ANhLgQ0NJn3f7gG+rJpLxyGvxvG+zX7u6pcfAYa7hv2/Vbr+L6wvdoux
        1DNmqlDcXFNEaoZMPOujcA==
X-Google-Smtp-Source: ADFU+vtSXHZEpiLMs2FsMhDZIZ99EheK1oZfK6YT/nyh4eZQFkcY0AWh7hyF7JqjXt0YhfmzAA9P8Q==
X-Received: by 2002:a92:ddcb:: with SMTP id d11mr23249377ilr.211.1585000835890;
        Mon, 23 Mar 2020 15:00:35 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id m18sm5620099ila.54.2020.03.23.15.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 15:00:35 -0700 (PDT)
Received: (nullmailer pid 10516 invoked by uid 1000);
        Mon, 23 Mar 2020 22:00:33 -0000
Date:   Mon, 23 Mar 2020 16:00:33 -0600
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
Subject: Re: [PATCH v3 1/4] dt-bindings: display: mediatek: add property to
 control mipi tx drive current
Message-ID: <20200323220033.GA29463@bogus>
References: <20200311074032.119481-1-jitao.shi@mediatek.com>
 <20200311074032.119481-2-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311074032.119481-2-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 03:40:29PM +0800, Jitao Shi wrote:
> Add a property to control mipi tx drive current:
> "drive-strength-microamp"
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dsi.txt     | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
> index a19a6cc375ed..d501f9ff4b1f 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
> @@ -33,6 +33,9 @@ Required properties:
>  - #clock-cells: must be <0>;
>  - #phy-cells: must be <0>.
>  
> +Optional properties:
> +- drive-strength-microamp: adjust driving current, should be 1 ~ 0xF

TBC, 1-0xf is in units of microamps? So a max drive strength of 15uA? 
Seems a bit low.

> +
>  Example:
>  
>  mipi_tx0: mipi-dphy@10215000 {
> @@ -42,6 +45,7 @@ mipi_tx0: mipi-dphy@10215000 {
>  	clock-output-names = "mipi_tx0_pll";
>  	#clock-cells = <0>;
>  	#phy-cells = <0>;
> +	drive-strength-microamp = <0x8>;
>  };
>  
>  dsi0: dsi@1401b000 {
> -- 
> 2.21.0
