Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FB2C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 05:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02E5520735
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 05:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ML7679Gi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgEDFNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 01:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgEDFNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 01:13:06 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5734EC061A0F
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 22:13:06 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a31so3213784pje.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 22:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CGgfVInUBc8d8MeEEhRqNzZfEuhBaHkKRq5GSypONxA=;
        b=ML7679GiJcCvmMTmxW61nvXsnDgL1EIu+eX/BfjNOZQTioT5PmIWm0iw6HgAKA9CLX
         fujQoQ59MLeuXJBLGfQf7vz19E+afar2cBGtutwAIe1BTznB+gCPJXfCR16XPNwCg069
         5PcIp4JY3+yw/a/zMCMvFyejBLCvLvy1ng5Y8SMlOPBLkohTz49BVDw2aABiRa8jPRqV
         xBgCMYQPLzxXhTEE5r93YfAWnhABYgHz1EFW3461Kl1RxgGsNGtTFyFCiQhDjx5fzMGX
         zTx3D5QZBQ7YhXZDvinmpYR17xQ2TEhat1T1XQ8f+ai/8RASDDQp/i4lUxIbeKeRSB2L
         mF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CGgfVInUBc8d8MeEEhRqNzZfEuhBaHkKRq5GSypONxA=;
        b=rD3IN3wo7CJ32XdBoqEfzRgsWRHCabhO2Jq5Uyg/upFjbQMFDvUbBdGnKJHBkzqM09
         p2NJfCBUTPNAMdK/h0lVDdginJQdcEANN1GKFOjfkQVpq+CIzoVQTCoEqjuBDxW4movo
         lnvL5zrAC6fu6uULIDYyf1fhJOYqfv3O3gVRo1vkK8Lye8i0jhJYxpae29DX3u039jwo
         de9vkbeeDcJolfE3LTF4DZP7U40qyg9TclAV73Mhf1r8GO+HmbZw/KppGG7SdAjOLx+m
         O8aEUO31Dn6Z9RUtWrrBuGsU9ACIUf3iu4w/46B0+eRjYPkHEHPk0ExTdEum41PnCj7w
         FQFw==
X-Gm-Message-State: AGi0Pubh8JmSHB0CCmisJgRw1EEFmOyIgvJyPRkEs66ZMvrICCk1fNyz
        3E23Yz0wq9nc7ZQBTpS3l2VGmA==
X-Google-Smtp-Source: APiQypI6IdV05QBzAML2J+Fi9YQIWcD1PVuThQvH6+otzWE9wJBnp3sC6BNSCfGKWji9101yrzoIJg==
X-Received: by 2002:a17:90b:1993:: with SMTP id mv19mr14636453pjb.88.1588569185845;
        Sun, 03 May 2020 22:13:05 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id a99sm5755483pje.35.2020.05.03.22.13.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 May 2020 22:13:05 -0700 (PDT)
Date:   Mon, 4 May 2020 10:43:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Ilia Lin <ilia.lin@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sricharan R <sricharan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom: fix wrong compatible binding
Message-ID: <20200504051303.zvmvvjipdkjpo4yh@vireshk-i7>
References: <20200430222225.3941-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430222225.3941-1-ansuelsmth@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-05-20, 00:22, Ansuel Smith wrote:
> Binding in Documentation is still "operating-points-v2-kryo-cpu".
> Restore the old binding to fix the compatibility problem.
> 
> Fixes: a8811ec764f9 ("cpufreq: qcom: Add support for krait based socs")
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index a1b8238872a2..d06b37822c3d 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -277,7 +277,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>  	if (!np)
>  		return -ENOENT;
>  
> -	ret = of_device_is_compatible(np, "operating-points-v2-qcom-cpu");
> +	ret = of_device_is_compatible(np, "operating-points-v2-kryo-cpu");
>  	if (!ret) {
>  		of_node_put(np);
>  		return -ENOENT;

Applied. Thanks.

-- 
viresh
