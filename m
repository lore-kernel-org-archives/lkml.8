Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C41C38BE0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB962080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zlXKmr/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgBXSxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:53:38 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43465 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgBXSxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:53:37 -0500
Received: by mail-pf1-f193.google.com with SMTP id s1so5795605pfh.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 10:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5o+NRLE+XeQOQqO+QGCBe9virQiAW2Yqk+LqPr6RM+k=;
        b=zlXKmr/tXaX2hjWqTpQ2njtzL2v39uLcpNTrh6YWx5o5mRLOnjMG0dB9wXvhmk4/QP
         mszWYPx63JNQ0rNx9QhLrp2Ty2oJ62q/wHOeDBTmyJcxFUC2gD/GsB94xMpHsLz+SIJo
         oaU2MtzeREnx5KcWl+gpwnp9dGoL2pvM6cwAVb26fFIAjgMLcUidsFJSrGce6IY2ddtH
         DHHkfjIClkjdJ9Ksj84wcjHPezT++M655R7NO5VWHNuSwIANqs/8bQtR2iHA5Av/beM6
         Yt9YlYL4zMXwazL8tbEG1TVgex9D/w4/dlMdEuSmroq2NvA+xmREquf6s839RLDJS8GH
         gQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5o+NRLE+XeQOQqO+QGCBe9virQiAW2Yqk+LqPr6RM+k=;
        b=ODECRL1//rObx8c6wF5eD8rk6xXY/oGiz4jKLc+anS73PiJuhxdCKGGJsk2EOWhFqP
         NgOXN20Uon0/Gyf1DtG1sGlnTsqhwXgr7PAjC6WYeP6KQaSJX7SBwuWHVsnKRarsqYvw
         73g6MP4Y7+jLd2VfVTWmMLRUPCMTQjpOmd/EQx9o6wyigT69P67nOvMQJ8f+v9QrhZKJ
         hHZmTrEY3KJaJTDGKrXJyydpZ8UZSxpH024a3isUdJkLVmUIzmJNcsOPYSHrAIwtxR8d
         nA64wemrUBJ+S6uJgwJKb/+wptKluHGhsPy+DBAkrT8nQrqbBYahH7q1AZSJWVubfOMY
         aSwA==
X-Gm-Message-State: APjAAAWUyX9GqMe69F3HXlGCdjLao/4SE5ckNw7RyuB32wjNtvQ95Ihf
        dp1mVAOja5bFYxttuKx2lWIFAg==
X-Google-Smtp-Source: APXvYqxlG79nw9hdnewWjUWulRuruSK0ApRJJQ/cb+aNxOv7rQwCZTRuCo/oWDO8TH8Xl6qVAeD9iw==
X-Received: by 2002:a63:7ce:: with SMTP id 197mr44461643pgh.429.1582570417176;
        Mon, 24 Feb 2020 10:53:37 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id j4sm13931577pfh.152.2020.02.24.10.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:53:36 -0800 (PST)
Date:   Mon, 24 Feb 2020 11:53:34 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Siddharth Gupta <sidgup@codeaurora.org>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, rishabhb@codeaurora.org
Subject: Re: [PATCH 2/2] remoteproc: core: Prevent sleep when rproc crashes
Message-ID: <20200224185334.GB9477@xps15>
References: <1582164713-6413-1-git-send-email-sidgup@codeaurora.org>
 <1582164713-6413-3-git-send-email-sidgup@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582164713-6413-3-git-send-email-sidgup@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 06:11:53PM -0800, Siddharth Gupta wrote:
> Remoteproc recovery should be fast and any delay will have an impact on the
> user-experience. Use power management APIs (pm_stay_awake and pm_relax) to
> ensure that the system does not go to sleep.

When you say "ensure the system does not go to sleep", you're referring to the
system going idle from the CPUidle subsystem? 

> 
> Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
> ---
>  drivers/remoteproc/remoteproc_core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 5ab65a4..52e318c 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1712,6 +1712,8 @@ static void rproc_crash_handler_work(struct work_struct *work)
>  
>  	if (!rproc->recovery_disabled)
>  		rproc_trigger_recovery(rproc);
> +
> +	pm_relax(&rproc->dev);
>  }
>  
>  /**
> @@ -2242,6 +2244,8 @@ void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type)
>  		return;
>  	}
>  
> +	pm_stay_awake(&rproc->dev);
> +

I fail to understand how this can be useful since there is no HW associted to
rproc->dev...  Is it possible for you to elaborate more on the problem you're
trying to fix?

Thanks,
Mathieu

>  	dev_err(&rproc->dev, "crash detected in %s: type %s\n",
>  		rproc->name, rproc_crash_to_string(type));
>  
> -- 
> Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
