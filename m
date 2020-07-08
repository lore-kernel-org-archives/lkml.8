Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C3DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 23:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A98C2078A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 23:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="BMYaD0/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgGHX46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 19:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgGHX44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 19:56:56 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A930FC08C5CE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 16:56:56 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id i4so418062iov.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 16:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/iDCx5PxrdwYp68iaHGF0XiGxVIe5SyIhKdtgrZ3fbE=;
        b=BMYaD0/Nzi03pb3sn9RUwDiR18d4K3VFvZUWDS94d65LrOZ3NZJGGuSCKvZWsGHog3
         d2jOJjAlNJha9XmY0tuNE/dEJ0lAVflerZ3TbS5KpcCan2uyVJO8jJk0EuVbfALjF/KB
         vZ5qBHx4aM35NhDhqBOh6QgMn4XObO1IN9xaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/iDCx5PxrdwYp68iaHGF0XiGxVIe5SyIhKdtgrZ3fbE=;
        b=gLJFa3hgzAmIKXk3EDGcRvs3exTtIsLnvqVhfCD1S0A5ZsqdYTpIg7hnONY/xRKboX
         MquFeY+/CgC+hgEvb/kjmq0/dXqurd5jb7HKJKipccDvD7cSeP4DNO2Oik1OxO/LoDTi
         IarwZHkXw8SA131Tm8+f0+QEZBCbZjsqxGXTp76BAAN4B+2VkmkVOkTGziaPfDuDFU0R
         cJySD8smTL9Pw0mxQcXClcyg1Klx2b1kTV4d1GeeOmiizez2UPLi3IhcOYvRBOCfaOfj
         +PaFP/RlNrJMi9CNGbRxWBMRmIYKqZd1pR2+kxXRuMTYP1RxHmagjIwGHWt37aMjfHgw
         TYeA==
X-Gm-Message-State: AOAM533MQ2XbSi99a9tj5xnJuh4yCp6BpSv9e5I9EJbgGa9uqqA3M0yh
        NaZ+n/FplAcdSTmoVI7R/xfZDk6iLnY=
X-Google-Smtp-Source: ABdhPJw+iUwHbNQ7QnJ24KlDR1MTMUzUdkM9xE4xOuYNCxoRraxAVRHqp2cePwxufGhgI0g0ESYPWg==
X-Received: by 2002:a5d:8c8f:: with SMTP id g15mr39488286ion.206.1594252616081;
        Wed, 08 Jul 2020 16:56:56 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id x1sm838958ilh.29.2020.07.08.16.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 16:56:55 -0700 (PDT)
Subject: Re: [PATCH v6 2/2] remoteproc: qcom: Add notification types to SSR
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org
References: <1592965408-16908-1-git-send-email-rishabhb@codeaurora.org>
 <1592965408-16908-3-git-send-email-rishabhb@codeaurora.org>
From:   Alex Elder <elder@ieee.org>
Message-ID: <6625fefc-74ef-0cb9-ad06-5a4dcea0efb5@ieee.org>
Date:   Wed, 8 Jul 2020 18:56:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1592965408-16908-3-git-send-email-rishabhb@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/20 9:23 PM, Rishabh Bhatnagar wrote:
> The SSR subdevice only adds callback for the unprepare event. Add callbacks
> for prepare, start and prepare events. The client driver for a particular
> remoteproc might be interested in knowing the status of the remoteproc
> while undergoing SSR, not just when the remoteproc has finished shutting
> down.

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  drivers/remoteproc/qcom_common.c      | 44 ++++++++++++++++++++++++++++++++++-
>  include/linux/remoteproc/qcom_rproc.h | 16 +++++++++++++
>  2 files changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
> index 7a7384c..7ec4597 100644
> --- a/drivers/remoteproc/qcom_common.c
> +++ b/drivers/remoteproc/qcom_common.c
> @@ -265,6 +265,44 @@ int qcom_unregister_ssr_notifier(void *notify, struct notifier_block *nb)
>  }
>  EXPORT_SYMBOL_GPL(qcom_unregister_ssr_notifier);
>  
> +static int ssr_notify_prepare(struct rproc_subdev *subdev)
> +{
> +	struct qcom_rproc_ssr *ssr = to_ssr_subdev(subdev);
> +	struct qcom_ssr_notify_data data = {
> +		.name = ssr->info->name,
> +		.crashed = false,
> +	};
> +
> +	srcu_notifier_call_chain(&ssr->info->notifier_list,
> +				 QCOM_SSR_BEFORE_POWERUP, &data);
> +	return 0;
> +}
> +
> +static int ssr_notify_start(struct rproc_subdev *subdev)
> +{
> +	struct qcom_rproc_ssr *ssr = to_ssr_subdev(subdev);
> +	struct qcom_ssr_notify_data data = {
> +		.name = ssr->info->name,
> +		.crashed = false,
> +	};
> +
> +	srcu_notifier_call_chain(&ssr->info->notifier_list,
> +				 QCOM_SSR_AFTER_POWERUP, &data);
> +	return 0;
> +}
> +
> +static void ssr_notify_stop(struct rproc_subdev *subdev, bool crashed)
> +{
> +	struct qcom_rproc_ssr *ssr = to_ssr_subdev(subdev);
> +	struct qcom_ssr_notify_data data = {
> +		.name = ssr->info->name,
> +		.crashed = crashed,
> +	};
> +
> +	srcu_notifier_call_chain(&ssr->info->notifier_list,
> +				 QCOM_SSR_BEFORE_SHUTDOWN, &data);
> +}
> +
>  static void ssr_notify_unprepare(struct rproc_subdev *subdev)
>  {
>  	struct qcom_rproc_ssr *ssr = to_ssr_subdev(subdev);
> @@ -273,7 +311,8 @@ static void ssr_notify_unprepare(struct rproc_subdev *subdev)
>  		.crashed = false,
>  	};
>  
> -	srcu_notifier_call_chain(&ssr->info->notifier_list, 0, &data);
> +	srcu_notifier_call_chain(&ssr->info->notifier_list,
> +				 QCOM_SSR_AFTER_SHUTDOWN, &data);
>  }
>  
>  /**
> @@ -298,6 +337,9 @@ void qcom_add_ssr_subdev(struct rproc *rproc, struct qcom_rproc_ssr *ssr,
>  	}
>  
>  	ssr->info = info;
> +	ssr->subdev.prepare = ssr_notify_prepare;
> +	ssr->subdev.start = ssr_notify_start;
> +	ssr->subdev.stop = ssr_notify_stop;
>  	ssr->subdev.unprepare = ssr_notify_unprepare;
>  
>  	rproc_add_subdev(rproc, &ssr->subdev);
> diff --git a/include/linux/remoteproc/qcom_rproc.h b/include/linux/remoteproc/qcom_rproc.h
> index 2a1d6d0..6470516 100644
> --- a/include/linux/remoteproc/qcom_rproc.h
> +++ b/include/linux/remoteproc/qcom_rproc.h
> @@ -5,6 +5,22 @@ struct notifier_block;
>  
>  #if IS_ENABLED(CONFIG_QCOM_RPROC_COMMON)
>  
> +/**
> + * enum qcom_ssr_notify_type - Startup/Shutdown events related to a remoteproc
> + * processor.
> + *
> + * @QCOM_SSR_BEFORE_POWERUP:	Remoteproc about to start (prepare stage)
> + * @QCOM_SSR_AFTER_POWERUP:	Remoteproc is running (start stage)
> + * @QCOM_SSR_BEFORE_SHUTDOWN:	Remoteproc crashed or shutting down (stop stage)
> + * @QCOM_SSR_AFTER_SHUTDOWN:	Remoteproc is down (unprepare stage)
> + */
> +enum qcom_ssr_notify_type {
> +	QCOM_SSR_BEFORE_POWERUP,
> +	QCOM_SSR_AFTER_POWERUP,
> +	QCOM_SSR_BEFORE_SHUTDOWN,
> +	QCOM_SSR_AFTER_SHUTDOWN,
> +};
> +
>  struct qcom_ssr_notify_data {
>  	const char *name;
>  	bool crashed;
> 

