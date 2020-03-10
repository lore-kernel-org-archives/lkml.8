Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E557C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F9C20873
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583868577;
	bh=YSHmdSAUsUSrb+SJgrEy4KtQYNx3lyMmXOPE42VX0Sw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sfSIciFtn5M3Y3qkzwmPeiqTNMbZKfp8KzdodUilsOF4WNghpByVm+ZgE448EWitA
	 ptMnGV30L2UbvrkW8esHsDJfi+dQsxzgUyXlKMLbjfqp8/0T9eOUqkn/ZCMTUOUMWD
	 JBzxAT7wDDA5oV5p5M5hiTiCm1NW1lH0UwcIYsFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbgCJT3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:29:35 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39018 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgCJT3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:29:35 -0400
Received: by mail-oi1-f195.google.com with SMTP id d63so8315975oig.6;
        Tue, 10 Mar 2020 12:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ti2DUsUootG5Bb/9jhB9jDTpr9Lf8fcuPShhiLFGbzM=;
        b=XkiXm48dhGj1zviyak5rl6WPvlc/PXIeKsmSfUkH47YV5fN6mbG+iIgnPQHE+lr+4v
         VpAIlbAvMoFoRvquYUoJjJ3qK/NFLIcuhvmr30RJJfGhX70ju89AmbdpQwVDkXDIM8KQ
         v7R0+G64tV4wx2FTxaEwxUVkop8PwQZKLN5rTuKG8M9/3O2+pRxcxEXFJJsfnr0Em9Hq
         711+tpT+O8k/CfEk/5R7eIOgOLl9W/kgYWIiZpDTR4HDTFPJREathiMSsmKdWLfC3eZ0
         9fe/kCJrMJTDK0UEJbFoDASNijrnwX6dHfLQd6g+puJu+E+jXrQza01yt0df2JrgWW2p
         kQuQ==
X-Gm-Message-State: ANhLgQ29z+j0z3KGVjXTz0pJc4/jBkcrJ/NNFskWSBBfdqJej/gRr0v1
        L3YJLalIHRx+R9q4Mb0wi4cNvsE=
X-Google-Smtp-Source: ADFU+vsY5QkUJk3nxoCTdVDguFzMCTpu2klhELBPLKSw5lX4mSJAHDv7frNw6F1f7dVSVtDFZ845tw==
X-Received: by 2002:aca:e106:: with SMTP id y6mr2370120oig.131.1583868574471;
        Tue, 10 Mar 2020 12:29:34 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 3sm16382764otd.15.2020.03.10.12.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 12:29:33 -0700 (PDT)
Received: (nullmailer pid 17778 invoked by uid 1000);
        Tue, 10 Mar 2020 19:29:33 -0000
Date:   Tue, 10 Mar 2020 14:29:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc2: add compatible property for
 rk3328 usb
Message-ID: <20200310192933.GA15236@bogus>
References: <20200302115812.7207-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302115812.7207-1-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 12:58:11PM +0100, Johan Jonker wrote:
> A test with the command below gives these errors:
> 
> arch/arm64/boot/dts/rockchip/rk3328-a1.dt.yaml: usb@ff580000: compatible:
> ['rockchip,rk3328-usb', 'rockchip,rk3066-usb', 'snps,dwc2']
> is not valid under any of the given schemas
> arch/arm64/boot/dts/rockchip/rk3328-evb.dt.yaml: usb@ff580000: compatible:
> ['rockchip,rk3328-usb', 'rockchip,rk3066-usb', 'snps,dwc2']
> is not valid under any of the given schemas
> arch/arm64/boot/dts/rockchip/rk3328-rock64.dt.yaml: usb@ff580000: compatible:
> ['rockchip,rk3328-usb', 'rockchip,rk3066-usb', 'snps,dwc2']
> is not valid under any of the given schemas
> arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dt.yaml: usb@ff580000: compatible:
> ['rockchip,rk3328-usb', 'rockchip,rk3066-usb', 'snps,dwc2']
> is not valid under any of the given schemas
> 
> The compatible property for rk3328 dwc2 usb was somehow never added to
> the documention. Fix this error by adding
> 'rockchip,rk3328-usb', 'rockchip,rk3066-usb', 'snps,dwc2'
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
> index e95ba9373..e9f4cea21 100644
> --- a/Documentation/devicetree/bindings/usb/dwc2.yaml
> +++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
> @@ -41,6 +41,10 @@ properties:
>            - const: rockchip,rk3288-usb

Convert this entry to an 'enum' and add 'rockchip,rk3328-usb' here.

>            - const: rockchip,rk3066-usb
>            - const: snps,dwc2
> +      - items:
> +          - const: rockchip,rk3328-usb
> +          - const: rockchip,rk3066-usb
> +          - const: snps,dwc2
>        - const: lantiq,arx100-usb
>        - const: lantiq,xrx200-usb
>        - items:
> -- 
> 2.11.0
> 
