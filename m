Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14316C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 21:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D982420692
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 21:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CbcreuVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgDIVIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 17:08:55 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34144 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbgDIVIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 17:08:55 -0400
Received: by mail-pj1-f65.google.com with SMTP id q16so1298449pje.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 14:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NcQsyYub/r8Q9+PaSLKRYTmg67Aka19WbBMxwbtUrmE=;
        b=CbcreuVCbg+sbqe4omyBRWJUQGrBEIHCOPij1b2Q/5qjmdYbytQ9SIZiNBTjqVWXiK
         p8Yf4tg5qhTITaK7x6sGtcEBhkQfiacxiGd7X1J7kEyQKENeI327lhL+XUZxo3uYT9Y7
         sKb5ySZ+4deaz++qsHAYi1FISa11OfjfjilKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NcQsyYub/r8Q9+PaSLKRYTmg67Aka19WbBMxwbtUrmE=;
        b=hVFpgY0o+oQGiV/Js4uttnPUlifPCuAOInufySN0bA2oKzqXJg+JSyaC4roKG7xcO2
         kIhXHsdMf3GOsKWkVC3Q6EhFO1Ir1yPmwguaTQKgxwer+EPlPoxxQNyaF7GCB+dBzpFs
         9IIX4K+bOt0tCj+CPdvdexP/ywGIW3eus8clcnzt3hri8yjoBihsHwlTtnrmHEuLmISf
         7H9EWZKz/TjsxL5fD6aSqgjh0PHaYnX5C/A8PZTeLDuc0tAMwPHkMrYZjwwIJSuKdmn6
         h6tmZbBbT+1XRDG3YHbB1c2EnsvC1ZkzIhgk82B7MKEiaP3bzujJzThe4FZs6UHyqtOw
         kOYw==
X-Gm-Message-State: AGi0PuaYDXgPIhgglJ/JGNjLHg5HpQFpW13tLJQET5JB79jQ9xv5ih3I
        HEiFp1mLZKraFbEB5DlRY3s3kg==
X-Google-Smtp-Source: APiQypI+JLKnBNzx3vT/SrJu7AGoiJNMptA2tQDY3QvYF3NiPHoZnTNCYdr3+unc/KBmlGdCGN0IRA==
X-Received: by 2002:a17:902:9a8a:: with SMTP id w10mr1528326plp.218.1586466534558;
        Thu, 09 Apr 2020 14:08:54 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id e26sm13306pfi.84.2020.04.09.14.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 14:08:53 -0700 (PDT)
Date:   Thu, 9 Apr 2020 14:08:52 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Mansur Alisha Shaik <mansur@codeaurora.org>
Cc:     linux-media@vger.kernel.org, stanimir.varbanov@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org, Jeffrey Kardatzke <jkardatzke@google.com>,
        Atul Dhudase <adhudase@codeaurora.org>
Subject: Re: [PATCH] [PATCH] venus: core: remove CNOC voting while device
 suspend
Message-ID: <20200409210852.GU199755@google.com>
References: <1581940891-2376-1-git-send-email-mansur@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1581940891-2376-1-git-send-email-mansur@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mansur,

do you still intend to land this patch? If so please re-spin it to address
Stanimir's feedback.

Thanks

Matthias

On Mon, Feb 17, 2020 at 05:31:31PM +0530, Mansur Alisha Shaik wrote:
> video driver is voting for CNOC during probe and not clear
> while device suspend. Because of which XO shutdown is
> happing(BCM42: VALID: 0x1 VOTE_X: 0x0000 VOTE_Y: 0x0004).
> 
> So, clearing CNOC voting while device suspend.
> 
> Signed-off-by: Mansur Alisha Shaik <mansur@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/core.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index e7995cb..153effe 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -244,10 +244,6 @@ static int venus_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	ret = icc_set_bw(core->cpucfg_path, 0, kbps_to_icc(1000));
> -	if (ret)
> -		return ret;
> -
>  	ret = hfi_create(core, &venus_core_ops);
>  	if (ret)
>  		return ret;
> @@ -353,6 +349,10 @@ static __maybe_unused int venus_runtime_suspend(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> +	ret = icc_set_bw(core->cpucfg_path, 0, 0);
> +	if (ret)
> +		return ret;
> +
>  	if (pm_ops->core_power)
>  		ret = pm_ops->core_power(dev, POWER_OFF);
>  
> @@ -371,6 +371,10 @@ static __maybe_unused int venus_runtime_resume(struct device *dev)
>  			return ret;
>  	}
>  
> +	ret = icc_set_bw(core->cpucfg_path, 0, kbps_to_icc(1000));
> +	if (ret)
> +		return ret;
> +
>  	return hfi_core_resume(core, false);
>  }
>  
