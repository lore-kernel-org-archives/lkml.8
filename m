Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B8DC35677
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D042469B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582823948;
	bh=kl/04uM+7lf6zfg55PDxvBrsVB2mcSqNhD3IZxQZju4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KIQdkqM4mSwmnag8O1spdjVBxyXWCk0TWyAm6YqcW4ujYDn1+XmlSflRsEILXPsI1
	 mVdmjMB9qpxew5cBqjbBysbr0FfrH9H/n3JKxbRYmSVhM60Hh9h0UszcRB11wbQvFf
	 2z2BkBKY/TxTKft8XRUvelumHCnQNdGuoFiNa0uY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbgB0RTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 12:19:07 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38177 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbgB0RTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 12:19:07 -0500
Received: by mail-oi1-f194.google.com with SMTP id 2so2919244oiz.5;
        Thu, 27 Feb 2020 09:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EEa7ye+4SNg6W5sroyNYrJMOxOtx09zWUa0ioGPqjd8=;
        b=b4t1XujXYCvJF1sKtgq/7eqiTpLx0mWszbbBBKagF+vED6KvsrZ3+SS7OdUWBQlCzi
         1gfcU+sMVU4BF1vodnfPeXcxoFamUgxfRasCyajIe0Wv8U4WzEMa/tyAVVB+mlCiip66
         jk4QgaO1E8qlCP5kzxpcMEgxZ5YUItbUri64MeS/I870Rre/z78z8xNqdD9+WyKmrmuD
         9q3a9t4t93bKbirgPRlhd42jFX3EbWc5oH+qwU6Sjz1C+LVV29xDXB8FlYvjsMDrg5aw
         4OD2AGmTib8Ukca1juQn1PzluG2TM34wul9jQ20vCX0fKTz+yT5YiTMZUr0rMcg5k4om
         k3OQ==
X-Gm-Message-State: APjAAAU1mdiRano1xCKOJBoiIP4ayJCA0vHSlQE90Lca5ImeeEPXHcyO
        itBUrxJCOTbKXtz5TfbEDw==
X-Google-Smtp-Source: APXvYqyivrbnGPADBq2gCXjpZ0Ulx7DPwJxfGsdNrYwEE5j4rbjAGXZ2yhl3jW4hSxNtdbA1D1ycUA==
X-Received: by 2002:aca:3857:: with SMTP id f84mr58985oia.150.1582823946480;
        Thu, 27 Feb 2020 09:19:06 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k201sm2165169oih.43.2020.02.27.09.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 09:19:06 -0800 (PST)
Received: (nullmailer pid 18856 invoked by uid 1000);
        Thu, 27 Feb 2020 17:19:04 -0000
Date:   Thu, 27 Feb 2020 11:19:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        huijuan.xie@mediatek.com, stonea168@163.com,
        cawa.cheng@mediatek.com, linux-mediatek@lists.infradead.org,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 3/5] dt-bindings: display: mediatek: dpi sample data
 in dual edge support
Message-ID: <20200227171904.GA17829@bogus>
References: <20200226053238.31646-1-jitao.shi@mediatek.com>
 <20200226053238.31646-4-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226053238.31646-4-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 01:32:36PM +0800, Jitao Shi wrote:
> Add property "pclk-sample" to config the dpi sample on falling (0),
> rising (1), both falling and rising (2).
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dpi.txt       | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
> index a7b1b8bfb65e..4299aa1adf45 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
> @@ -20,6 +20,7 @@ Required properties:
>  Optional properties:
>  - pinctrl-names: Contain "gpiomode" and "dpimode".
>    pinctrl-names see Documentation/devicetree/bindings/pinctrlpinctrl-bindings.txt
> +- pclk-sample: refer Documentation/devicetree/bindings/media/video-interfaces.txt.
>  
>  Example:
>  
> @@ -37,6 +38,7 @@ dpi0: dpi@1401d000 {
>  
>  	port {
>  		dpi0_out: endpoint {
> +			pclk-sample = 0;

Not valid dts syntax: <0>

>  			remote-endpoint = <&hdmi0_in>;
>  		};
>  	};
> -- 
> 2.21.0
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
