Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1749C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB0212073A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hxZa+PUN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgHaJTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 05:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbgHaJTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:19:34 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3674CC061575
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 02:19:34 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id c15so2743165plq.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 02:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vvqxg7DlP54bUmB6SMyM4eTrmD6Tl7htFjPdmlDBX80=;
        b=hxZa+PUNWyTnrAw/0CgPHSU19gzM0GOPWz7NQSejhwvmJk+l5EFVQRaZ5+Id0pRKzq
         3dWvA67ysLe22C2sVasuMGBd/O9zCz+EBw6sP/+/hoBiAZxCIzn8lX6GHvj7gFQBmvGE
         KKOOW6EEMmLOika7AblSmG/AuIG8SMxYU7/hvdxHqMMcSDHwy2rxFAil/ORQemGfGv0K
         GWd5f/QXFCFB4ekpNxf9BwmXwYnYYP5YXpgMFRBaGq1mJAZwmx/LOPrUJJz5lO7Vmxo1
         J3dF6hYC6xqARnG5/ZEoyL2wk1q3thYue4g8MskfyDIOGyYCrScTix9XkBGlCCs/TXSx
         IITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vvqxg7DlP54bUmB6SMyM4eTrmD6Tl7htFjPdmlDBX80=;
        b=bd8jLqvvrAv7oK1l8797DtGdA6mQMbSk/emw+XepGckLjq37Fz8vgal+5tKixDgdT1
         lpJrzRI397/jtak/ULERNW5SVD91brJa/QPD68cH57O+8d7qeFVPAC6t/mp7tvVrGMU8
         nne2B+aKFiwH+w7jJMn3gIE6sO0Tfe8h2lXENRiwWDkN5TJFQSemkNxCOvSnJpXNX6Ps
         5paaslnO4IGbuaEudGUWakZ+ZAJ60WNOaFFrslpeAHvfUxZ28MpvL9BL6LMixidMjplp
         IY5cFdrk4tkUyP4EeyYWqsIx8BUBLOlqMZSX6JzJTcBrgxF3WIZ3hIJiMPwm7nF6j28W
         vg3Q==
X-Gm-Message-State: AOAM5304RbekYOLqWJ+kSWmYogNmlW/ADk6sVW41p5OuIy3VunFrYxLK
        ii6jHSFSpXlcPob1fCpXC3xK
X-Google-Smtp-Source: ABdhPJwQNTaazjo/SvPsuFRuTOgwlk/Rqpi/h52zTJjM69aHcf9PmuHF2p4hmpnavTPsazVXe2jL8w==
X-Received: by 2002:a17:90b:2383:: with SMTP id mr3mr535974pjb.29.1598865573127;
        Mon, 31 Aug 2020 02:19:33 -0700 (PDT)
Received: from mani ([2409:4072:70f:fdfa:1d6f:524d:c4d3:917e])
        by smtp.gmail.com with ESMTPSA id u191sm6709728pgu.56.2020.08.31.02.19.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Aug 2020 02:19:32 -0700 (PDT)
Date:   Mon, 31 Aug 2020 14:49:25 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Korsgaard <peter@korsgaard.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
Subject: Re: [PATCH v2 1/4] arm: dts: owl-s500: Fix incorrect PPI interrupt
 specifiers
Message-ID: <20200831091925.GC4154@mani>
References: <cover.1598621459.git.cristian.ciocaltea@gmail.com>
 <43702e492090417a490ba4cd81990a05aeea9f48.1598621459.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43702e492090417a490ba4cd81990a05aeea9f48.1598621459.git.cristian.ciocaltea@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 0828, Cristian Ciocaltea wrote:
> The PPI interrupts for cortex-a9 were incorrectly specified, fix them.
> 
> Fixes: fdfe7f4f9d85 ("ARM: dts: Add Actions Semi S500 and LeMaker Guitar")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> Reviewed-by: Peter Korsgaard <peter@korsgaard.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm/boot/dts/owl-s500.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
> index 5ceb6cc4451d..1dbe4e8b38ac 100644
> --- a/arch/arm/boot/dts/owl-s500.dtsi
> +++ b/arch/arm/boot/dts/owl-s500.dtsi
> @@ -84,21 +84,21 @@ scu: scu@b0020000 {
>  		global_timer: timer@b0020200 {
>  			compatible = "arm,cortex-a9-global-timer";
>  			reg = <0xb0020200 0x100>;
> -			interrupts = <GIC_PPI 0 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
> +			interrupts = <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
>  			status = "disabled";
>  		};
>  
>  		twd_timer: timer@b0020600 {
>  			compatible = "arm,cortex-a9-twd-timer";
>  			reg = <0xb0020600 0x20>;
> -			interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
> +			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
>  			status = "disabled";
>  		};
>  
>  		twd_wdt: wdt@b0020620 {
>  			compatible = "arm,cortex-a9-twd-wdt";
>  			reg = <0xb0020620 0xe0>;
> -			interrupts = <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
> +			interrupts = <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
>  			status = "disabled";
>  		};
>  
> -- 
> 2.28.0
> 
