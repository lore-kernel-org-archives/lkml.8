Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877EFC55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6583020728
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jl8RwHbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgD0Q4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbgD0Q4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:56:23 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DD4C03C1A7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:56:22 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z1so7588901pfn.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8g6+h4h4dML9W2E3qKI2k/RJ1RmRLIzzJuqzJaCIIOo=;
        b=Jl8RwHbwGBhtN9dZl2yt3PP8T1Lw2QY9QUk5gFwEXx5JJyxoMLX03TxjbpkTc1waCI
         9XxO6+3uoq4PooOO8mAW6va1t+fsjTHnFp1++Qoov7yOXy6Ffk/BJReo7pKIRLB47ane
         WTPIvCvwtwPV1I607+rms1wpCrt86js0t0nuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8g6+h4h4dML9W2E3qKI2k/RJ1RmRLIzzJuqzJaCIIOo=;
        b=p8uhsroq76sZpoPNPKzN6x2AX4qkrVVmukH3ZUo60R+jGGlEbe39zupNNfXV+day9E
         peUuXYBfRi7kUtk3c6xXBkuHfD5TiX6nK41wMPYf+znfJiBSmwxl25yCjEE/VmYfsweT
         19yt3lKs0AOjw2m/O0Tf5QQusLKUK8jQzWTToH5UOUMrMlRx2/d0+OrmcLihbB1DSGt9
         mgBIVhuFVGiZO1bRJghsvfFGqV9izbO9lG4yjmhf0J96WhVD1g/KR1se9yiF4JL56yyx
         /D0bXZMAnGezH4rbBY088sTbBNPZWoP8LPH0aJAFblpMzvdCzt1/xh8pw9dRAed1KKxT
         DR6Q==
X-Gm-Message-State: AGi0PuY6qifSieoDEnckaU9q82rV6jlstuffqyi2ElMUwXsNsSoA9oBS
        5Q916ElV0yGaMvGnOUKl362Aig==
X-Google-Smtp-Source: APiQypLxYauoRAtM5UuCTKW4As/J8PDpB/r8RLziPOpnx+JgWmGubSmDS7klN8ofJ0MCuKLi8Wjy6Q==
X-Received: by 2002:a62:174a:: with SMTP id 71mr26442771pfx.297.1588006581615;
        Mon, 27 Apr 2020 09:56:21 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id 140sm11041351pge.49.2020.04.27.09.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 09:56:20 -0700 (PDT)
Date:   Mon, 27 Apr 2020 09:56:16 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, akashast@codeaurora.org,
        rojay@codeaurora.org, msavaliy.qti.qualcomm.com@qualcomm.com
Subject: Re: [PATCH] arm64: dts: sc7180: Add wakeup support over UART RX
Message-ID: <20200427165616.GF4525@google.com>
References: <1587968844-26667-1-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1587968844-26667-1-git-send-email-skakit@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 27, 2020 at 11:57:24AM +0530, satya priya wrote:
> Add the necessary pinctrl and interrupts to make UART
> wakeup capable.
> 
> Signed-off-by: satya priya <skakit@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 4216b57..3a49603 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -637,9 +637,12 @@
>  				reg = <0 0x0088c000 0 0x4000>;
>  				clock-names = "se";
>  				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
> -				pinctrl-names = "default";
> +				pinctrl-names = "default", "sleep";
>  				pinctrl-0 = <&qup_uart3_default>;
> -				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-1 = <&qup_uart3_default>;

Why is the 'sleep' configuration needed if it's the same as 'default'?

> +				interrupts-extended =
> +					<&intc GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>,
> +					<&tlmm 41 0>;
>  				status = "disabled";
>  			};

This patch only adds wakeup support for uart3, which seems an arbitrary
choice at SoC level. Either it should do it for all UARTs of the SC7180,
or in the .dtsi of devices that use UART3 and need it to be wakeup capable.
