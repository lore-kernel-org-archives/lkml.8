Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3C8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A52620C56
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OEbOSBMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437424AbgE2DlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 23:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437354AbgE2DlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 23:41:07 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC63C08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 20:41:07 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x11so488428plv.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 20:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=999gs+HXYwpU12XXE29LCP7xw0Rr+GSPVkv6l3joNHI=;
        b=OEbOSBMcyAqAaFWxdLCJZsfFrcbZJr0sQGO2J2CjporekEVvF5X7mzULzs7TSTtRwR
         pAPmJ8xn1A+ty3MA9pb8nEQ949qYK9UQxQZ8JLAyKa+MjvL0N4kb+Fm+DWMBRNMnXnTc
         WHP/SCewSDEXbsUiNWBopr5EvOx+e0ZZazAqezsivBz8pPlBi4gWkbQab73kZCH7tSPp
         qAEw8OKBxMioj2E1tjtTIIh4fpqH+jyCh3NcbAEfLTnZX7up1jzgGaOaobssuVIpdJuh
         vMsPNDFLc1/eIIMk816gh4LXgzOLZWaMDdS3m4AYd4NVf1yGDDb5NlMEWpzHcjYsSwrk
         KgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=999gs+HXYwpU12XXE29LCP7xw0Rr+GSPVkv6l3joNHI=;
        b=V5pZCHXhK7xQ9vQjVsOXt++mz1RUWnsMUPhIF33VuXJGt8z8VlmgZmnlRPptRKZ5aA
         OU1UD5ViBtpRjl+gYkSplBx0k+pZmETmwekHvvilS0HPyLFyzbKc9mAb+kyqAD1vQ4kF
         ZUp9pzmVCfjdKllFni0WWgqaeNzBVjkDRs319h7KNX4oWQIbdWBuSbEL6YzmaEqXZJip
         rntKN3HoYILwS6r8VFQaVakE12SGZj8bJs7rsviqmV+hKTRO6qYWBAaJWHXYQBzkqJi5
         ha0dkx6EplQWUKVe5XDK6YkCUoRUbsinNi3f9/Nwk1lY/A9q91yE0j37xgeagKniDlDX
         rYgw==
X-Gm-Message-State: AOAM531Je5MUmxZRIsbv0t72xCjsybweRuZNXVx5CdLull3gMR0p/mdU
        DJh9tFl9iySJ7HX943zeQrs4xg==
X-Google-Smtp-Source: ABdhPJz5sSdQ9afx5tCPSwgn9gtn9PQD5Wp2idGU0wVC7QGrS/Ny6KqMhKojMFs+bym4EdybjebViw==
X-Received: by 2002:a17:90a:d181:: with SMTP id fu1mr7620991pjb.147.1590723666572;
        Thu, 28 May 2020 20:41:06 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x193sm5874324pfd.149.2020.05.28.20.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 20:41:05 -0700 (PDT)
Date:   Thu, 28 May 2020 20:40:00 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sm8250: change ufs node name to ufshc
Message-ID: <20200529034000.GF279327@builder.lan>
References: <20200523175232.13721-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523175232.13721-1-jonathan@marek.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 23 May 10:52 PDT 2020, Jonathan Marek wrote:

> The ufs-qcom driver checks that the name matches the androidboot.bootdevice
> parameter provided by the bootloader, which uses the name ufshc. Without
> this change UFS fails to probe.
> 

Seems I only tested with UFS built as module, thanks for spotting this.

> I think this is broken behavior from the ufs-qcom driver, but using the
> name ufshc is consistent with dts for sdm845/sm8150/etc.
> 

I agree. Patch applied...

Thanks,
Bjorn

> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index e0344d3ba159..3bdce658c08a 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -309,7 +309,7 @@ uart2: serial@a90000 {
>  			};
>  		};
>  
> -		ufs_mem_hc: ufs@1d84000 {
> +		ufs_mem_hc: ufshc@1d84000 {
>  			compatible = "qcom,sm8250-ufshc", "qcom,ufshc",
>  				     "jedec,ufs-2.0";
>  			reg = <0 0x01d84000 0 0x3000>;
> -- 
> 2.26.1
> 
