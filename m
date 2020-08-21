Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D28C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 378CC20656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YJdpR1xV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgHUQ2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbgHUQ0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:26:34 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2B9C061755
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 09:26:33 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id v15so1232740pgh.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 09:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B9AWbTbWPp7aT8cVV5y9qjtG9r2gj7nhh9YWaOKKiuk=;
        b=YJdpR1xVWyhRcbML3ChNs3j4d3/YmKtUkn0siTwj4xe3D70EJaZ8TS6WroZCqXa4CC
         AnyHG9WkVzh4jPWrC0JgsToWMta4CkhAEcL3Bxg/j6Bz7oLuQ2JbQ9BBisReA6HOMt+Y
         nmkFUIg82wwwm9Z8YdSLGBXdSC+aEbG/U29jQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B9AWbTbWPp7aT8cVV5y9qjtG9r2gj7nhh9YWaOKKiuk=;
        b=LqfKrWwLF93Vhtcwb2kIK2xv9rssblXK+7FZcg5vWARdJ47iRY4zub8FffWKyTYpua
         lPn3m+v0BwaqmEyoU8LeUmjPL+ONqW03mFrZlIKYHIv+r8uN4SuEcC+IFHKkEjvj3W+o
         XKczE7KlBz/A/5vNAsK8EeWFfSokymEzK5x280XNUuXg5/VS76iNdd1rnoxldHBZPRLu
         GZEWXry/a4t7xzkJ96AspBYEHpNhL1KZkH9u5QbSPbMtGxygffcL+xhKyAbA/2TaSVaF
         tG6YZ5/aBXRw5rMKWbR675PU022hX/pQg8bUxApgM/YGeTuE5RTBfQcX9HFgvlwPhdjv
         IyQg==
X-Gm-Message-State: AOAM532z7wmdnPeLvXY0a2hd7GfF+xRZk8CsOQks8ZrPZM0KQq5VEvwB
        kMZbIxJYQsqjkdPuDA9aIQlqwLWlgq/Ilw==
X-Google-Smtp-Source: ABdhPJxA02Wr8aE7e7k0ORPqzYjpHeciFt5VagaVUucvu925wOq50WmJHhy05pdcud86/UKNZ+gUOQ==
X-Received: by 2002:a05:6a00:78e:: with SMTP id g14mr3052283pfu.171.1598027192818;
        Fri, 21 Aug 2020 09:26:32 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id m26sm2978275pfe.184.2020.08.21.09.26.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 09:26:31 -0700 (PDT)
Date:   Fri, 21 Aug 2020 09:26:30 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        gregkh@linuxfoundation.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, akashast@codeaurora.org,
        rojay@codeaurora.org, msavaliy@qti.qualcomm.com
Subject: Re: [PATCH V3 1/3] arm64: dts: sc7180: Add wakeup support over UART
 RX
Message-ID: <20200821162630.GA486007@google.com>
References: <1597931467-24268-1-git-send-email-skakit@codeaurora.org>
 <1597931467-24268-2-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1597931467-24268-2-git-send-email-skakit@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 07:21:05PM +0530, satya priya wrote:
> Add the necessary pinctrl and interrupts to make UART
> wakeup capable.
> 
> Signed-off-by: satya priya <skakit@codeaurora.org>
> Reviewed-by: Akash Asthana <akashast@codeaurora.org>
> ---
> Changes in V2:
>  - As per Matthias's comment added wakeup support for all the UARTs
>    of SC7180.
> 
> Changes in V3:
>  - No change.
> 
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 98 ++++++++++++++++++++++++++++++------
>  1 file changed, 84 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index d46b383..855b13e 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>
> ...
>
> +			qup_uart0_sleep: qup-uart0-sleep {
> +				pinmux {
> +					pins = "gpio34", "gpio35",
> +					       "gpio36", "gpio37";
> +					function = "gpio";

What is the reason that the GPIO function needs to be selected in sleep mode
to support wakeup?

This should be explained in the commit message unless it is evident.
