Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6720C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BCD42080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E1CCnj/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731146AbgGTUOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730588AbgGTUOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 16:14:44 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8512CC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:14:44 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k4so9198190pld.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WNxueUD+phKhrmwrBdcVRQhaNP8PUOrPfRv3y1egQ5E=;
        b=E1CCnj/RHxGKi6otHBchqn4UNxlKdUhFfwYvmOvj2vRrkkqCCoay/h2uPDjR7+NYow
         9P7dc0bFsiLH3vMaA31EYyOp1W1FSxvz0u05W+aN7sOj8l+v9q3QxjSabuW+5IVkq1YW
         4xxQYcHG+xiTks20hnRo9JVM03fxeBjSLHcOK06Kng/vPP6llVvJiMEpgTpNXmzcwv4W
         m3Jx/RZDxcO4MfluMT/KN412FcJTZhGMvNeLIxLdUUeF5PQij50aIFngBHViqbED+09h
         1d8OfdzGrf3kXxlcKOz8ftipntfaNqe6HDJ96W8E57ZuqFgHkWHNwrvr6g+3aUjIrqOp
         H5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WNxueUD+phKhrmwrBdcVRQhaNP8PUOrPfRv3y1egQ5E=;
        b=P10sMQSjkXqDCok26DakelVGYyi6G0ZOfMA5oV0iYrnIWOjz2dyk/4B6XPUVhEJj18
         Eg1J/vqcSI3gsVFyPeEWZ3ogiZq0Nlk8wW1m4ONMWyPTiG1oDpfnok5CZ+Kg7zWEAiEx
         mCeycvAglUj5DKq9mCmO4yW7Xqv5hSmHVk6gyG7+9BYwdhiNB+ozQgkpa6+e+bT7h4CX
         RKcoLoSAfZJCcEHex+CGzNfqa8JqKTFJYuWvKogAyc89tyBstoa/vBZVU3ULuErjXaBc
         76X1iooo+QnFlHOLbVJSPrdKqCbAQmbfqsd4reWYJxHrRuiqxBj5bG0GST4gBL/HcNxg
         0tMQ==
X-Gm-Message-State: AOAM530krBgj6rZknKVPQBRD1rp84F/kMWs3tcMlgqeORn1EsQ/rklaC
        cyy/VHyGM6U37siMBmuAcneHfA==
X-Google-Smtp-Source: ABdhPJwC+tqCP7BZQFSJhNsFHM48/I1Q6bLrLh2Bd1mMlJN45npNo34FhKHXO2J6ToU6SXC0IVl0og==
X-Received: by 2002:a17:902:c408:: with SMTP id k8mr20000709plk.279.1595276083869;
        Mon, 20 Jul 2020 13:14:43 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m26sm17621860pff.84.2020.07.20.13.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 13:14:43 -0700 (PDT)
Date:   Mon, 20 Jul 2020 13:12:47 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        saipraka@codeaurora.org, msavaliy@codeaurora.org
Subject: Re: [PATCH] soc: qcom: geni: Fix NULL pointer dereference
Message-ID: <20200720201247.GI1218486@builder.lan>
References: <1594996342-26964-1-git-send-email-akashast@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594996342-26964-1-git-send-email-akashast@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17 Jul 07:32 PDT 2020, Akash Asthana wrote:

> pdev struct doesn't exits for the devices whose status are disabled
> from DT node, in such cases NULL is returned from 'of_find_device_by_node'
> Later when we try to get drvdata from pdev struct NULL pointer dereference
> is triggered.
> 
> Add a NULL check for return values to fix the issue.
> 
> We were hitting this issue when one of QUP is disabled.
> 
> Fixes: 048eb908a1f2 ("soc: qcom-geni-se: Add interconnect support to fix earlycon crash")
> Reported-by: Sai Prakash Ranjan <saipraka@codeaurora.org>
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>

And applied with Matthias suggested rename of wrapper_pdev to pdev.


PS. Please include linux-arm-msm@vger.kernel.org among your recipients
for future patches.

Regards,
Bjorn

> ---
>  drivers/soc/qcom/qcom-geni-se.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> index 355d503..6e5fe65 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -820,6 +820,7 @@ void geni_remove_earlycon_icc_vote(void)
>  	struct geni_wrapper *wrapper;
>  	struct device_node *parent;
>  	struct device_node *child;
> +	struct platform_device *wrapper_pdev;
>  
>  	if (!earlycon_wrapper)
>  		return;
> @@ -829,7 +830,12 @@ void geni_remove_earlycon_icc_vote(void)
>  	for_each_child_of_node(parent, child) {
>  		if (!of_device_is_compatible(child, "qcom,geni-se-qup"))
>  			continue;
> -		wrapper = platform_get_drvdata(of_find_device_by_node(child));
> +
> +		wrapper_pdev = of_find_device_by_node(child);
> +		if (!wrapper_pdev)
> +			continue;
> +
> +		wrapper = platform_get_drvdata(wrapper_pdev);
>  		icc_put(wrapper->to_core.path);
>  		wrapper->to_core.path = NULL;
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
> 
