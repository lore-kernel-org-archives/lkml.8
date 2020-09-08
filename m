Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB84C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01CBE206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u7+Ho6xm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgIHKio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729717AbgIHKg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:36:28 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E00C061756
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 03:36:27 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e33so9763890pgm.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 03:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MgywjL0uucS1GgfjcXOCNe48ST0hLkPQB14tD2SYKHw=;
        b=u7+Ho6xmQepjBmUHL21LDM96wcPI0c+X/f4cHQ7fMfm4ljWMRGi4BwJoeVgRgQWGro
         pEYkoseNMf9Q3ZwFvKEHEXP+XwPzNYJAUU2mo/VCdt7ZsQm0xOwizXT2Qj0kozQm/6lx
         0qBnfaCspfqMs8G+LZWEubYphEko1dtF4P+riyIcbznQ5fLhEQIz0NVLpgXKFIOo+hIy
         cQ0HZuym/XPabmJe+oSMyl/TWu6MuVj8fb2ujLiJu2T7lH8aFhlelCuyd2udYbmSRcfI
         gdmtIjPxsNxnDp7FyflA8XlAgSwpIf/9DrEOdgv858R9Sc0WiQmBPuZse0xZlciAVgao
         Cgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MgywjL0uucS1GgfjcXOCNe48ST0hLkPQB14tD2SYKHw=;
        b=LP6xpX5M1j6RJQtRpOMonY1RveI9T7I4CQi1U7E7Wr3NP+07Et9q4BgwX9TZmNTje5
         cqZkSjRQ+fsjVQi1et7J7jXSYekhedJ6SWEKRtfBo05WJSIFC+J4MJitHNw6VdydrKX5
         RmRq0rF/0so7GGHpB+EpkGfFNlVgGimK+gqymW2UQCatIEVfCjhY3DAUQghMO1CQx4Bb
         FuIMJ5ooQjBC5LiMv4HLnVrCenkZrwyAmTiADyNZDUXqaDl2SzLMUAm0AjVn5CP0mEnG
         rELGJX7zzjYgRiZUNDfVkt5l4gz7N+mtSC9NcX6/IXAKCez7G/MRVnFHTXnQG6CIkr1R
         Z6CA==
X-Gm-Message-State: AOAM533VXdRu0U0PeyondWOOYByvxdx5vLIGw34lqyskv3RxB68bQ1P1
        +jS6SFkWnkYmAULZjP2z2Mw33g==
X-Google-Smtp-Source: ABdhPJyh+51Moh3eoMoGX/l9hmnM/lXHQ8+NTU0Y9OnHtg+GDLY1oslfmE6zrfInTsqNGo/iMTxb1w==
X-Received: by 2002:aa7:9286:0:b029:13c:1611:66c1 with SMTP id j6-20020aa792860000b029013c161166c1mr22172024pfa.12.1599561387453;
        Tue, 08 Sep 2020 03:36:27 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id g192sm10646153pfb.168.2020.09.08.03.36.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2020 03:36:26 -0700 (PDT)
Date:   Tue, 8 Sep 2020 16:06:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dmitry.baryshkov@linaro.org, tdas@codeaurora.org
Subject: Re: [PATCH 7/7] cpufreq: qcom-hw: Use
 devm_platform_ioremap_resource() to simplify code
Message-ID: <20200908103625.swla4uoxxb3hj2w2@vireshk-i7>
References: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
 <20200908075716.30357-8-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908075716.30357-8-manivannan.sadhasivam@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-09-20, 13:27, Manivannan Sadhasivam wrote:
> devm_platform_ioremap_resource() is the combination of
> platform_get_resource() and devm_ioremap_resource(). Hence, use it to
> simplify the code a bit.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index c3c397cc3dc6..6eeeb2bd4dfa 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -307,7 +307,6 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  	struct of_phandle_args args;
>  	struct device_node *cpu_np;
>  	struct device *cpu_dev;
> -	struct resource *res;
>  	void __iomem *base;
>  	struct qcom_cpufreq_data *data;
>  	const struct of_device_id *match;
> @@ -333,13 +332,9 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  
>  	index = args.args[0];
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
> -	if (!res)
> -		return -ENODEV;
> -
> -	base = devm_ioremap(dev, res->start, resource_size(res));
> -	if (!base)
> -		return -ENOMEM;
> +	base = devm_platform_ioremap_resource(pdev, index);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
>  
>  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>  	if (!data) {

Keep such patches at the top, so they could be independently applied.

-- 
viresh
