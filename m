Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F10FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2694420723
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vr2Gr68I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390077AbgEYLIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 07:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390068AbgEYLIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 07:08:09 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE288C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 04:08:08 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y5so2412933wmj.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 04:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lQKQDzeVK4Uf3YS6MYrDsg7Y/owjPxYU/XltSmblwvw=;
        b=vr2Gr68IKZOePnRH+JwTxvfjJw1QyyouKk1/zx+aPK2wkF44mQ2yS4xfQOkTqzjS8d
         HbCLeCVZ2eg/OD9jp0ttXs2SdyrkRuQhWYb940sDiSlrfJMDPslZn8rS7TzPlBfWSnR4
         So6x/vwQbujFsjO9x6GXTv9zCQ6ImvrfCLbkRUW7ii/vYovyq+X/FAdklWj4F5aSf45M
         I237KjxQhoZeF1zPOzFQSbBnfvey4A6aKytsUtNAEuEl3qxERx+WCF6DzHoZZ72AWXha
         j3amNUooVpvkT08oOppXeU+j0bI/gbIu8r+gppg6r16buLUCtBJcK77nzEzY6VD/agx8
         6+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lQKQDzeVK4Uf3YS6MYrDsg7Y/owjPxYU/XltSmblwvw=;
        b=BpM733uyIFwjt1z/QXkAsB5OlwR1pB19l1oOEw2hQDBVIAp3VtaYWAz8ZYyck/MYo7
         nXugl7BJ5KoPbjvu92c90qOX8W0rOj+JfgXqrMzrNADH3Tide/VIaNuQ5fLfjqa5BZKc
         kTc2E2rtlr/sW3fd7P4NFqdlBrY2HXd/P84WRZgLUYRfCZYEszenssMiK5OLb2yR3HF+
         aI9iBPEUliJq3Bv4UTL917vO+xeRPdip+yIdDfX5y4+j3uPn1X1DMByh4ZZWJSN/pfPn
         w0YIayEjiUzGFVtYlUsPkK67wEawKCQ7dfVk5dTomys5/iABJyP0/WiSS8RWoMUjeI3u
         jjGg==
X-Gm-Message-State: AOAM531I2ajqRvN3Pzg889niJdRXIvt/Bs8A2dbgYzQwdX6oyLsjg5hG
        YS2n0glesuWxpxyLhku1NwdrkLDXFc8=
X-Google-Smtp-Source: ABdhPJzplrooTMofH5YFdtdecp/U7nYLCb5HbCk36w+9QdWdZmeknbEFpXjnChpyI8OlDim1kRmqIw==
X-Received: by 2002:a1c:bb05:: with SMTP id l5mr10962772wmf.141.1590404887419;
        Mon, 25 May 2020 04:08:07 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:f5b2:610d:e426:c0dd? ([2a01:e34:ed2f:f020:f5b2:610d:e426:c0dd])
        by smtp.googlemail.com with ESMTPSA id q1sm3445092wmj.9.2020.05.25.04.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 04:08:06 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: ls1028a: add one more thermal zone support
To:     Yuantian Tang <andy.tang@nxp.com>, shawnguo@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200525073827.13272-1-andy.tang@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <bdfd7018-aed8-ddbe-8bd2-2fa834013218@linaro.org>
Date:   Mon, 25 May 2020 13:08:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200525073827.13272-1-andy.tang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2020 09:38, Yuantian Tang wrote:
> There are 2 thermal zones in ls1028a soc. Current dts only
> includes one. This patch adds the other thermal zone node
> in dts to enable it.

For my personal information, is there a cooling device for the DDR?

> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> ---
>  .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 22 ++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 055f114cf848..bc6f0c0f85da 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -129,11 +129,31 @@
>  	};
>  
>  	thermal-zones {
> -		core-cluster {
> +		ddr-controller {
>  			polling-delay-passive = <1000>;
>  			polling-delay = <5000>;
>  			thermal-sensors = <&tmu 0>;
>  
> +			trips {
> +				ddr-ctrler-alert {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				ddr-ctrler-crit {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		core-cluster {
> +			polling-delay-passive = <1000>;
> +			polling-delay = <5000>;
> +			thermal-sensors = <&tmu 1>;
> +
>  			trips {
>  				core_cluster_alert: core-cluster-alert {
>  					temperature = <85000>;
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
