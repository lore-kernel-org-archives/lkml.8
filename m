Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBF2C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A96B2073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="frOKGgAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgDUIPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 04:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgDUIPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:15:37 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455E5C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 01:15:37 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e26so2498207wmk.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 01:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7xjSknTeR+7dqcaL1YgejpgJ9/KujY8j8UEnyfLmZD4=;
        b=frOKGgAVIjbSzucTY8HiXqzPrWgYdihoiEtz+cb34v3+J49RpTLLTKTwBeXk+DnyE/
         Ma/xI/Oz4r+iM7CFvAgmw0X7Oa1CoDY3pQPLZWCm04SaG+jx1Cg8F8ipUTjca56HpLcP
         sqW3/+7LhmRxDOqO4/j0dRG2dGQhvnU1BAhRMGEYqTQqX/1dnb99c+ctJj7h0fXVuc6f
         B/5XyRppCG6V9Hs8TWKyfwNOYfNldnC2fjsFvYYbASsK8YajbRqqTQl1VOee2YmGjuVN
         DgzLhyyFVbu5ax5j4VzJ+uGJhqdBCMQbAETtVyt1n1J2iqSZmvbUoeKXPnVVc0XZIRHo
         DqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7xjSknTeR+7dqcaL1YgejpgJ9/KujY8j8UEnyfLmZD4=;
        b=DvHEa75O71xkaBvzBvtW4NI76aTS+yb6CrbP52FbFm9oUMH8kXDz+Q7o/Aa2YrmIOF
         xnejDGoqmVcfZd90a3o0MJJMFId6LOZd8FwybS1ppFLgAZSsFhrAufjm0D2WZiuR3kr4
         ge+mcYTkmZivhtai+b1OdhqI38OwuYtr2LcPfwk76jVA+YbvE5kjB0BGct9v06OzL64w
         7vPJ9zpwNKlsCxWMYh7vJC5Yj865kln0M7o05TeO8gvIele6uMqOBvLn55humhUrEiUv
         H5fFf16kNVfG85FCy29sLyqzcrm+tMl1AJlRa78lN0gMsuXA81QxeyJgH1BdypY0c3B8
         yPkQ==
X-Gm-Message-State: AGi0PuYc9vwxtIAmE3UC/DkgZQG6BkI8sOwzyD1DH0+TuLiJNzxaZKj3
        y1FKCBzNLZHdcX424dNc1ArsZQ==
X-Google-Smtp-Source: APiQypLAbrQ/7+vnxMSEVWZPMUZwhWOh+FsfXCIwjmuMJt8X2Ze0PcEBnGHrEyqo46iBVLy1lNevDA==
X-Received: by 2002:a1c:1d4b:: with SMTP id d72mr3484494wmd.19.1587456935761;
        Tue, 21 Apr 2020 01:15:35 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:8985:83c2:22f1:8de3? ([2a01:e34:ed2f:f020:8985:83c2:22f1:8de3])
        by smtp.googlemail.com with ESMTPSA id k14sm2678325wrp.53.2020.04.21.01.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 01:15:35 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] thermal: cpuidle: Register cpuidle cooling device
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:CPU IDLE TIME MANAGEMENT FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CPUIDLE DRIVER - ARM PSCI" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200414220837.9284-1-daniel.lezcano@linaro.org>
 <20200414220837.9284-4-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6b58035c-fe48-09ab-f042-729b07bcfec6@linaro.org>
Date:   Tue, 21 Apr 2020 10:15:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200414220837.9284-4-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Lorenzo, Sudeep,

other patches of the series are acked / reviewed.

If you are ok with these changes, could you add your acked-by so I can
merge all the series via the thermal tree?

Thanks

  -- Daniel

On 15/04/2020 00:08, Daniel Lezcano wrote:
> The cpuidle driver can be used as a cooling device by injecting idle
> cycles. The DT binding for the idle state added an optional
> 
> When the property is set, register the cpuidle driver with the idle
> state node pointer as a cooling device. The thermal framework will do
> the association automatically with the thermal zone via the
> cooling-device defined in the device tree cooling-maps section.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpuidle/cpuidle-arm.c  | 5 +++++
>  drivers/cpuidle/cpuidle-psci.c | 5 +++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
> index 9e5156d39627..2406ac0ae134 100644
> --- a/drivers/cpuidle/cpuidle-arm.c
> +++ b/drivers/cpuidle/cpuidle-arm.c
> @@ -8,6 +8,7 @@
>  
>  #define pr_fmt(fmt) "CPUidle arm: " fmt
>  
> +#include <linux/cpu_cooling.h>
>  #include <linux/cpuidle.h>
>  #include <linux/cpumask.h>
>  #include <linux/cpu_pm.h>
> @@ -124,6 +125,10 @@ static int __init arm_idle_init_cpu(int cpu)
>  	if (ret)
>  		goto out_kfree_drv;
>  
> +	ret = cpuidle_cooling_register(drv);
> +	if (ret)
> +		pr_err("Failed to register the idle cooling device: %d\n", ret);
> +
>  	return 0;
>  
>  out_kfree_drv:
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index edd7a54ef0d3..8e805bff646f 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -9,6 +9,7 @@
>  #define pr_fmt(fmt) "CPUidle PSCI: " fmt
>  
>  #include <linux/cpuhotplug.h>
> +#include <linux/cpu_cooling.h>
>  #include <linux/cpuidle.h>
>  #include <linux/cpumask.h>
>  #include <linux/cpu_pm.h>
> @@ -305,6 +306,10 @@ static int __init psci_idle_init_cpu(int cpu)
>  	if (ret)
>  		goto out_kfree_drv;
>  
> +	ret = cpuidle_cooling_register(drv);
> +	if (ret)
> +		pr_err("Failed to register the idle cooling device: %d\n", ret);
> +
>  	return 0;
>  
>  out_kfree_drv:
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
