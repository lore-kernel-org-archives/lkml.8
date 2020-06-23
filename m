Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757FFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DD402078E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="QMMrg5tm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390286AbgFWVqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388292AbgFWVqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:46:00 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4415C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 14:46:00 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id h4so17922976ior.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 14:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HZHJ+lW7xSmoSfHRie1OqWIcs5GILHV56xiQdBcP6dA=;
        b=QMMrg5tm407Cx/Zn/FOuyZluu+7AZrT7m38I06iMLSPIVG9onoUXSdfOc2VJ2+lwul
         TjtyN0Vn4UKtjhazoIQNzIi30yJ8ro9l5B2meWFnOiFSTBZFXyhsC8Mk1+JIxz10RbAe
         L55t/JcBfT0TJHQTJixOekpAVQ6/nOVO+B35g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HZHJ+lW7xSmoSfHRie1OqWIcs5GILHV56xiQdBcP6dA=;
        b=d1/s+FG7W54TCI6enkL+veMSvIrb1xO6/6TJBv5GZ8CLkiI67M0lMAwF64AyfiACdl
         LPeA2RcnGd5X1hA93gQuR5049DgevAtJF8eeSs0Ow07CiUc2WZ9gLvdi8ZdF20EsokPe
         0nSMjkHM2ql7xBy6aRu8vJ/NcFA1Jt8us4aYswv2JTSSLflbZHm2AEPPZNyythN14qhO
         AnTTKjNXaDSzDyflvBGKdlIlKyIXUY3zY9b96CGrMFaTEf3El3/1hTpwxbF1NaL/N4LH
         +k/J0nnso+vpHPiLi3u36Gvs6RIrRnKLg3obXe/ktC3Vte2A/PybzGUO8MHGkw4zx6Be
         ucgw==
X-Gm-Message-State: AOAM532NGtp1rOGE8WdKdstRqTzG3wLNn+WRxNv4fL1enWpx35RZKJKt
        s+V7pfKwCkzhnTiw2uC19EX+VGsIFF4=
X-Google-Smtp-Source: ABdhPJyDgVbfGjzVCkL7thJ9DFCsTFLxiMAsmfeo15PsDTvQJ+7DBl5bd1oouz1k63rIQVLLtKxVAw==
X-Received: by 2002:a02:6641:: with SMTP id l1mr26525746jaf.23.1592948760185;
        Tue, 23 Jun 2020 14:46:00 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id t1sm10529100iob.16.2020.06.23.14.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 14:45:59 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] remoteproc: qcom: Add notification types to SSR
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org
References: <1592874271-26697-1-git-send-email-rishabhb@codeaurora.org>
 <1592874271-26697-3-git-send-email-rishabhb@codeaurora.org>
From:   Alex Elder <elder@ieee.org>
Message-ID: <08c5deed-0ed5-0e75-2c2e-4a508515be0a@ieee.org>
Date:   Tue, 23 Jun 2020 16:45:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1592874271-26697-3-git-send-email-rishabhb@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/20 8:04 PM, Rishabh Bhatnagar wrote:
> The SSR subdevice only adds callback for the unprepare event. Add callbacks
> for prepare, start and prepare events. The client driver for a particular
> remoteproc might be interested in knowing the status of the remoteproc
> while undergoing SSR, not just when the remoteproc has finished shutting
> down.
> 
> Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>

This looks good to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/remoteproc/qcom_common.c      | 44 ++++++++++++++++++++++++++++++++++-
>   include/linux/remoteproc/qcom_rproc.h | 16 +++++++++++++
>   2 files changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
> index 658f2ca..0848bf1 100644
> --- a/drivers/remoteproc/qcom_common.c
> +++ b/drivers/remoteproc/qcom_common.c
> @@ -262,6 +262,44 @@ int qcom_unregister_ssr_notifier(void *notify, struct notifier_block *nb)
>   }
>   EXPORT_SYMBOL_GPL(qcom_unregister_ssr_notifier);
>   
> +static int ssr_notify_prepare(struct rproc_subdev *subdev)
> +{
> +	struct qcom_rproc_ssr *ssr = to_ssr_subdev(subdev);
> +	struct qcom_ssr_notif_data data = {
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
> +	struct qcom_ssr_notif_data data = {
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
> +	struct qcom_ssr_notif_data data = {
> +		.name = ssr->info->name,
> +		.crashed = crashed,
> +	};
> +
> +	srcu_notifier_call_chain(&ssr->info->notifier_list,
> +				 QCOM_SSR_BEFORE_SHUTDOWN, &data);
> +}
> +
>   static void ssr_notify_unprepare(struct rproc_subdev *subdev)
>   {
>   	struct qcom_rproc_ssr *ssr = to_ssr_subdev(subdev);
> @@ -270,7 +308,8 @@ static void ssr_notify_unprepare(struct rproc_subdev *subdev)
>   		.crashed = false,
>   	};
>   
> -	srcu_notifier_call_chain(&ssr->info->notifier_list, 0, &data);
> +	srcu_notifier_call_chain(&ssr->info->notifier_list,
> +				 QCOM_SSR_AFTER_SHUTDOWN, &data);
>   }
>   
>   /**
> @@ -294,6 +333,9 @@ void qcom_add_ssr_subdev(struct rproc *rproc, struct qcom_rproc_ssr *ssr,
>   	}
>   
>   	ssr->info = info;
> +	ssr->subdev.prepare = ssr_notify_prepare;
> +	ssr->subdev.start = ssr_notify_start;
> +	ssr->subdev.stop = ssr_notify_stop;
>   	ssr->subdev.unprepare = ssr_notify_unprepare;
>   
>   	rproc_add_subdev(rproc, &ssr->subdev);
> diff --git a/include/linux/remoteproc/qcom_rproc.h b/include/linux/remoteproc/qcom_rproc.h
> index 58422b1..83ac8e8 100644
> --- a/include/linux/remoteproc/qcom_rproc.h
> +++ b/include/linux/remoteproc/qcom_rproc.h
> @@ -5,6 +5,22 @@ struct notifier_block;
>   
>   #if IS_ENABLED(CONFIG_QCOM_RPROC_COMMON)
>   
> +/**
> + * enum qcom_ssr_notif_type - Startup/Shutdown events related to a remoteproc
> + * processor.
> + *
> + * @QCOM_SSR_BEFORE_POWERUP:	Remoteproc about to start (prepare stage)
> + * @QCOM_SSR_AFTER_POWERUP:	Remoteproc is running (start stage)
> + * @QCOM_SSR_BEFORE_SHUTDOWN:	Remoteproc crashed or shutting down (stop stage)
> + * @QCOM_SSR_AFTER_SHUTDOWN:	Remoteproc is down (unprepare stage)
> + */
> +enum qcom_ssr_notif_type {
> +	QCOM_SSR_BEFORE_POWERUP,
> +	QCOM_SSR_AFTER_POWERUP,
> +	QCOM_SSR_BEFORE_SHUTDOWN,
> +	QCOM_SSR_AFTER_SHUTDOWN,
> +};
> +
>   struct qcom_ssr_notif_data {
>   	const char *name;
>   	bool crashed;
> 

