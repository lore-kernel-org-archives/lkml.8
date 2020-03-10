Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0BCC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4898421D56
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583868618;
	bh=x9CgvK5HNHHvreggjYC56SM2xADTrAXnORnt5r5zkuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mY7Ru+DYQSOCWlmxBklmJisVZiy64Yicikg0ljr2cYTKRGv1XQPXLwuRU2MFhCP6A
	 Wu/hi/LxsrKnHPYmC13sUn3zhRRgdJjC0FC4oQ1M24BG5PA/fa+bQpdBE4GKrvGrnR
	 2R+GC6bGvqrbWlAynKRuea0EkHlU7XetKNkT4YNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbgCJTaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:30:17 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41544 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgCJTaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:30:17 -0400
Received: by mail-oi1-f196.google.com with SMTP id i1so15093239oie.8;
        Tue, 10 Mar 2020 12:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TXsHaF4fOcNE2W9tq/AYJCOMZXblb3kZRBtXTvgUFHE=;
        b=OGX148O27UYvoSx71GxJXH+PkYU790X6bqS00mZHnvk6oewtAk4IIAFjoT6M9G5gCY
         Rv9eO/YMEZUgRMLckvgeZKjFyyhnLxcACHNVVdSmxK+g2Mab8/AsGVTvHpMsrDD80aJe
         qVV2hnFoK2DwhB4gjoYHdeI8oEZ82OQRkMH31v+B1irt6dM2aD0nB264thuvfyd43aag
         Lx9L4EZQPck7ENkytTKCXuOyU523seqvNBBthOa9uyAzDydVkRiOrDm2AusTVwfKeBlu
         H5xl0U4x8Uqk62hMFugmx5CwrC83CT3XMeNCIbtyxKoB8LyJT7a/YpL8zPsq4j4I+8OC
         x5pQ==
X-Gm-Message-State: ANhLgQ14fenUmmwmtIOE+ZlEkQFb5n3DRJdfzLdZKTtwbItVfvjZKk6Y
        qfIe9KbPl0fXsFqc12Ngjg==
X-Google-Smtp-Source: ADFU+vvH5ymQhupC2P3V8EjfdHcq3DaB1uiTisg89ZmGHhSDnz8YXE2Mvbpo0sfVIj9y8PmrOGO7aQ==
X-Received: by 2002:a05:6808:56:: with SMTP id v22mr2265636oic.116.1583868614910;
        Tue, 10 Mar 2020 12:30:14 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w2sm11049466otq.10.2020.03.10.12.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 12:30:13 -0700 (PDT)
Received: (nullmailer pid 18889 invoked by uid 1000);
        Tue, 10 Mar 2020 19:30:13 -0000
Date:   Tue, 10 Mar 2020 14:30:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: usb: dwc2: add compatible property for
 rk3368 usb
Message-ID: <20200310193013.GA18080@bogus>
References: <20200302115812.7207-1-jbx6244@gmail.com>
 <20200302115812.7207-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302115812.7207-2-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 12:58:12PM +0100, Johan Jonker wrote:
> A test with the command below gives these errors:
> 
> arch/arm64/boot/dts/rockchip/rk3368-evb-act8846.dt.yaml: usb@ff580000: compatible:
> ['rockchip,rk3368-usb', 'rockchip,rk3066-usb', 'snps,dwc2']
> is not valid under any of the given schemas
> arch/arm64/boot/dts/rockchip/rk3368-geekbox.dt.yaml: usb@ff580000: compatible:
> ['rockchip,rk3368-usb', 'rockchip,rk3066-usb', 'snps,dwc2']
> is not valid under any of the given schemas
> arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dt.yaml: usb@ff580000: compatible:
> ['rockchip,rk3368-usb', 'rockchip,rk3066-usb', 'snps,dwc2']
> is not valid under any of the given schemas
> arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dt.yaml: usb@ff580000: compatible:
> ['rockchip,rk3368-usb', 'rockchip,rk3066-usb', 'snps,dwc2']
> is not valid under any of the given schemas
> arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dt.yaml: usb@ff580000: compatible:
> ['rockchip,rk3368-usb', 'rockchip,rk3066-usb', 'snps,dwc2']
> is not valid under any of the given schemas
> arch/arm64/boot/dts/rockchip/rk3368-r88.dt.yaml: usb@ff580000: compatible:
> ['rockchip,rk3368-usb', 'rockchip,rk3066-usb', 'snps,dwc2']
> is not valid under any of the given schemas
> 
> The compatible property for rk3368 dwc2 usb was somehow never added to
> the documention. Fix this error by adding
> 'rockchip,rk3368-usb', 'rockchip,rk3066-usb', 'snps,dwc2'
> to dwc2.yaml.
> 
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/usb/dwc2.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc2.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
> index e9f4cea21..14aeb67e8 100644
> --- a/Documentation/devicetree/bindings/usb/dwc2.yaml
> +++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
> @@ -45,6 +45,10 @@ properties:
>            - const: rockchip,rk3328-usb
>            - const: rockchip,rk3066-usb
>            - const: snps,dwc2
> +      - items:
> +          - const: rockchip,rk3368-usb

And you can do the same thing with this.

> +          - const: rockchip,rk3066-usb
> +          - const: snps,dwc2
>        - const: lantiq,arx100-usb
>        - const: lantiq,xrx200-usb
>        - items:
> -- 
> 2.11.0
> 
