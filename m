Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D7AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1103C206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hee7HZ6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbgFOJ47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgFOJ47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:56:59 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8E6C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 02:56:58 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q25so14181597wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 02:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jsEUyoBTDZqiVYB9PCZ1vVhMpPe0f/z8iobsEEaUCw4=;
        b=hee7HZ6p8is7oxi8Go4xvjyiDZzsY/Q+zce2fLd0aZKNQ4xq9xxZXaeTFvZyTHGx0u
         We48FXH41ePPSmjgZtYxZYcJb0Uoa/nkYeRcJwhhzBMu/ML0l51V3qHJrUedtxhKHlys
         107STx4b3Qbby2dqKQ7s734eMiKgDM8Z8rj5YjQBw6JEQtdpwkUCBsRq+MpToxj2hGS5
         ZRBBucPpuY/Kf7Qps9hGJoxtK4BqnKR6bebmikQszNyf5LMJtRI3AW5e8Yeov2as/M87
         m01CbnP9fo+lblePdhg+zIrzirypT1fqvxlRcTLiNoxzFTl4p/OkfyAZSC7k7NmGFEKI
         jR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jsEUyoBTDZqiVYB9PCZ1vVhMpPe0f/z8iobsEEaUCw4=;
        b=bbRso443lbz+sKIX3Os5ubyrqYA51k5pWVftEeEQhXJNvYs8alZ3CVp3qo9jUmPPUa
         X1PJ0UY1cldpgiDd7jRQfU92nWJ+l2K8fXcn78LjBly+tdH1Mo+g4Kb/VSkeTPVUk288
         mAsscvTlg7UTwBeggdaju4ul8EuonixY63Ae7809N/9F6+ahk6B0yFJ82a32UUr3ib8W
         vbYUHbK1S416B4sPbRRMhb9JPJ4NESrXyeI52jtEFBKG5+Aku5IfQlWvBrw4tMvvc9G3
         UBPZ7Z+CtC9I5e6XfOWjx+dhhdm6dk+aAmlFTAxoL6NYIE3HCRFaqSl1Hx+2Qy/b50ti
         Z+0g==
X-Gm-Message-State: AOAM531j1es6B+sVfCUPdp0+sU+NzIimIm7hCrpYaKTkvkTlXmLQZYEg
        VVf3un5YyPxH8aeqEQN1y2J/vg==
X-Google-Smtp-Source: ABdhPJxZKKismQou/hvN0RyW10M0LOdtR9H7U0D3onGtbD82lRgrB1A+y0Judglrp+oKwjLU5BgKcw==
X-Received: by 2002:a1c:4c12:: with SMTP id z18mr12843943wmf.155.1592215017188;
        Mon, 15 Jun 2020 02:56:57 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id t7sm22347837wrq.41.2020.06.15.02.56.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 02:56:56 -0700 (PDT)
Subject: Re: [RFC v2 2/3] drivers: nvmem: Add QTI qfprom-efuse support
To:     Ravi Kumar Bokka <rbokka@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        rnayak@codeaurora.org, saiprakash.ranjan@codeaurora.org,
        dhavalp@codeaurora.org, mturney@codeaurora.org,
        sparate@codeaurora.org, c_rbokka@codeaurora.org,
        mkurumel@codeaurora.org
References: <1591868882-16553-1-git-send-email-rbokka@codeaurora.org>
 <1591868882-16553-3-git-send-email-rbokka@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <39ad93ee-236d-0e5e-571a-28ef91173309@linaro.org>
Date:   Mon, 15 Jun 2020 10:56:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1591868882-16553-3-git-send-email-rbokka@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I think Doug already covered most of the comments and his fixes seems be 
in right direction.

On 11/06/2020 10:48, Ravi Kumar Bokka wrote:
> +	qfpraw = platform_get_resource_byname(pdev, IORESOURCE_MEM, "raw");
> +
> +	priv->qfpraw = devm_ioremap_resource(dev, qfpraw);
> +	if (IS_ERR(priv->qfpraw)) {

General comment for up-streaming is that your patch should not break 
whats in mainline, Your patch is totally ignoring!! Please be mindful 
while doing changes to drivers which are used by other platforms.

--srini
> +		ret = PTR_ERR(priv->qfpraw);
> +		goto err;
> +	}
> +
> +	qfpconf = platform_get_resource_byname(pdev, IORESOURCE_MEM, "conf");
> +
> +	priv->qfpconf = devm_ioremap_resource(dev, qfpconf);
> +	if (IS_ERR(priv->qfpconf)) {
> +		ret = PTR_ERR(priv->qfpconf);
> +		goto err;
> +	}
> +
> +	qfpcorrected = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +						    "corrected");
> +
> +	priv->qfpcorrected = devm_ioremap_resource(dev, qfpcorrected);
> +	if (IS_ERR(priv->qfpcorrected)) {
> +		ret = PTR_ERR(priv->qfpcorrected);
> +		goto err;
> +	}
