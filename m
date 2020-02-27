Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B84C3567B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F742469B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582823892;
	bh=vCfD8lKA/BRV5QIpeM7XazOb/cNE2SkmtSo6u/GGM2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CV0QtGi0EVQmwyXKnJAEMcHSa2egBoKCo8EmH8cubrHD2Nd09gs4dKgz1tx6IdTf7
	 A4zZmViFa4ktvKRgP7KdHoACx/+pi9K0G6+87i9AkIKCNnDUNZUbRaDAC5/3Y4iBPw
	 GZHnRLOqIKf3gkzI9kIhpxFfnDpHkJzNLokPLHhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbgB0RSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 12:18:11 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40103 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbgB0RSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 12:18:11 -0500
Received: by mail-ot1-f66.google.com with SMTP id a36so933306otb.7;
        Thu, 27 Feb 2020 09:18:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XZeF351ndR744jQMDSplVe35nCjD4JTzL+l4xDtw+Bw=;
        b=jt9AaYbS7Xihy5l3D7LoWuMLPIVkID8h8mUDq0675hMtvMlAlVN9nmP0eSWLYIrKHg
         PlAMVmDhL/jJXsIA5Thg/okwzDYmyXJnHGckY3MH8LPzH8gDtWmtbRNXWEZSTsEnwzR3
         w9YlZ8bCaFdtyJInSwa4IlvKb/e4/uNc6r2Qlgt0RQPS5dksGFgtiUvjp0HfmnmAylu7
         jd47pvS4I+JL5rqgdCZHCS+9OflpHasYhKlpudXyBp3DU9r+LPAsXFkEhBL6INGb3emc
         o4U0o16LVkAgSF5EtYegglTgemF9P4o1D3zXvHz2N9OPk2mn07frkKjb0dZGA5Vl2pvV
         fwUg==
X-Gm-Message-State: APjAAAVHfNIrmYJWoVdVZCpN45TRRlEFTuOKZDNwZ89AkW/bThzGoAUr
        5+XdPnZIl76xvn3Xn5NlDQ==
X-Google-Smtp-Source: APXvYqyxJP9z8nGYLwYOVzQtOy/w76xG4aTIepvKbnC66otUKEKBXXxHCjQtG595rcBsR3kyNOZgDQ==
X-Received: by 2002:a05:6830:128e:: with SMTP id z14mr650788otp.184.1582823890285;
        Thu, 27 Feb 2020 09:18:10 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r26sm1109461otc.66.2020.02.27.09.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 09:18:09 -0800 (PST)
Received: (nullmailer pid 17673 invoked by uid 1000);
        Thu, 27 Feb 2020 17:18:08 -0000
Date:   Thu, 27 Feb 2020 11:18:08 -0600
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
Subject: Re: [PATCH v9 2/5] dt-bindings: display: mediatek: control dpi pins
 mode to avoid leakage
Message-ID: <20200227171808.GA14590@bogus>
References: <20200226053238.31646-1-jitao.shi@mediatek.com>
 <20200226053238.31646-3-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226053238.31646-3-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 01:32:35PM +0800, Jitao Shi wrote:
> Add property "pinctrl-names" to swap pin mode between gpio and dpi mode. Set
> pin mode to gpio oupput-low to avoid leakage current when dpi disable.

s/oupput/output/

> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dpi.txt  | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
> index 58914cf681b8..a7b1b8bfb65e 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
> @@ -17,6 +17,10 @@ Required properties:
>    Documentation/devicetree/bindings/graph.txt. This port should be connected
>    to the input port of an attached HDMI or LVDS encoder chip.
>  
> +Optional properties:
> +- pinctrl-names: Contain "gpiomode" and "dpimode".
> +  pinctrl-names see Documentation/devicetree/bindings/pinctrlpinctrl-bindings.txt
> +
>  Example:
>  
>  dpi0: dpi@1401d000 {
> @@ -27,6 +31,9 @@ dpi0: dpi@1401d000 {
>  		 <&mmsys CLK_MM_DPI_ENGINE>,
>  		 <&apmixedsys CLK_APMIXED_TVDPLL>;
>  	clock-names = "pixel", "engine", "pll";
> +	pinctrl-names = "gpiomode", "dpimode";

The somewhat standard way to do this is '"default", "sleep"' if I 
remember the names right. And the normal operating mode is usually 
first.

> +	pinctrl-0 = <&dpi_pin_gpio>;
> +	pinctrl-1 = <&dpi_pin_func>;
>  
>  	port {
>  		dpi0_out: endpoint {
> -- 
> 2.21.0
