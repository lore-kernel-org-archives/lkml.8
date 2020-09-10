Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C327BC2D0A7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 899DA20719
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UFahawZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgIJWAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 18:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgIJWAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 18:00:41 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D97C061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 15:00:40 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id e7so6142045qtj.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 15:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PT5fNi7xEflk8GkI4Xi2kkoOSPhyGZTLMGtsTW99lM8=;
        b=UFahawZL4avRAiB31WSjU4euU3yRJTvrwhgJJi+Qn9x5fE7mBIWZH9kFeYWriHmGo0
         8DHjQ50B0xl5dOak65fkLcV7yN5nOj1VsXQgQL4pnpjyXKeRmShEKNeJfTtR0mesghnq
         1CvMe0xbWvYL/GH0IlhuCHB3VedkLXkWosVaUZVL1AbvGCkv73Vg4ZUIg+1YfY2orVY4
         ibgOpRDf2ulUeLZOiriIIhngYnlgiH1Ul0bXET7r0sUeUwXoYVnH3b1erPyJJ+CTh/gW
         7BPZdJCEA0WMx6E0iFl0XvHMlzIpVULhWwJ3piwrrgfe0RTT3ZLO3kQzq2D2JvEyh2f7
         1g4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PT5fNi7xEflk8GkI4Xi2kkoOSPhyGZTLMGtsTW99lM8=;
        b=kvFW/kn6J7gGcrMU9QxYJ+POvrALVPKhD1UroNEymQK7LnFYaBqa59jrT37Amb9sYW
         LCXFkZIoCb+79kG/0qCWlZJaZaiDXk0kkvpzPC7rxG2A7gPtdsGUVKZ+ws1TAf+jkt20
         gi0MPTsgaIVTwHG4UfhXLe49ub6X6oS8clafw6p/FavYQQ09NonoposrcuhXJz4zFlvh
         tQeK/LOnwjSe7PxHO9gf/oCkanSYf8Mn1ONZaeBB05eMMUauwJcyllKnBVMEkFcHd+iD
         idK3lZu2e1+bChuKfhWJ7g8U8hU75aZLZgKh6sDSorxDnmpaJa3EAkUis10r8n9Z0qHG
         UzdA==
X-Gm-Message-State: AOAM533uKrPNTeG61OKs0vrJ3PZhkeHBVbbaHS8PajWIdoWEHPIF5Ir7
        HmEbp428oUQins6KxmVwunns/g==
X-Google-Smtp-Source: ABdhPJzkV98KqvV9kj+Vq3Fl6B3U5epSGI8O2umuU/HuE10PsA2MfBhWuzMuy+vaiCys73JsOVxnXA==
X-Received: by 2002:ac8:376d:: with SMTP id p42mr10057359qtb.288.1599775239625;
        Thu, 10 Sep 2020 15:00:39 -0700 (PDT)
Received: from uller (ec2-34-197-84-77.compute-1.amazonaws.com. [34.197.84.77])
        by smtp.gmail.com with ESMTPSA id u66sm406702qka.136.2020.09.10.15.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 15:00:39 -0700 (PDT)
Date:   Thu, 10 Sep 2020 22:00:37 +0000
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kalyan Thota <kalyan_t@codeaurora.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        Krishna Manikandan <mkrishn@codeaurora.org>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        dianders@chromium.org, jsanka@codeaurora.org,
        travitej@codeaurora.org, nganji@codeaurora.org
Subject: Re: [PATCH 2/3] arm64: dts: sc7180: add bus clock to mdp node for
 sc7180 target
Message-ID: <20200910220037.GA472@uller>
References: <1594899334-19772-1-git-send-email-kalyan_t@codeaurora.org>
 <1594899334-19772-2-git-send-email-kalyan_t@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594899334-19772-2-git-send-email-kalyan_t@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16 Jul 11:35 UTC 2020, Kalyan Thota wrote:

> From: Krishna Manikandan <mkrishn@codeaurora.org>
> 
> Move the bus clock to mdp device node,in order
> to facilitate bus band width scaling on sc7180
> target.
> 
> The parent device MDSS will not vote for bus bw,
> instead the vote will be triggered by mdp device
> node. Since a minimum vote is required to turn
> on bus clock, move the clock node to mdp device
> from where the votes are requested.
> 
> This patch has dependency on the below series
> https://patchwork.kernel.org/patch/11468783/
> 

Isn't this dependency on an old revision of patch 3/3 in this series?

Regardless, I don't see either the linked patch or patch 3 merged in
linux-next, so I presume I should not merge this?

Regards,
Bjorn

> Signed-off-by: Krishna Manikandan <mkrishn@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 4f2c0d1..31fed6d 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -1510,10 +1510,9 @@
>  			power-domains = <&dispcc MDSS_GDSC>;
>  
>  			clocks = <&gcc GCC_DISP_AHB_CLK>,
> -				 <&gcc GCC_DISP_HF_AXI_CLK>,
>  				 <&dispcc DISP_CC_MDSS_AHB_CLK>,
>  				 <&dispcc DISP_CC_MDSS_MDP_CLK>;
> -			clock-names = "iface", "bus", "ahb", "core";
> +			clock-names = "iface", "ahb", "core";
>  
>  			assigned-clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>;
>  			assigned-clock-rates = <300000000>;
> @@ -1539,12 +1538,13 @@
>  				      <0 0x0aeb0000 0 0x2008>;
>  				reg-names = "mdp", "vbif";
>  
> -				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +				clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
> +					 <&dispcc DISP_CC_MDSS_AHB_CLK>,
>  					 <&dispcc DISP_CC_MDSS_ROT_CLK>,
>  					 <&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
>  					 <&dispcc DISP_CC_MDSS_MDP_CLK>,
>  					 <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
> -				clock-names = "iface", "rot", "lut", "core",
> +				clock-names = "bus", "iface", "rot", "lut", "core",
>  					      "vsync";
>  				assigned-clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>,
>  						  <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
> -- 
> 1.9.1
> 
