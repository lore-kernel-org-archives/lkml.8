Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6000C35E15
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CECE246AA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EBgRVvpA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbgB0SrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:47:10 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:47031 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbgB0SrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:47:10 -0500
Received: by mail-pl1-f195.google.com with SMTP id y8so137761pll.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 10:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lcrpnq/b6/hpdUjJ7BPbI1dg5z0iJwDYFP4cImRT74Q=;
        b=EBgRVvpATZd+QdllWh7NgaqS+BEpB4r+tKv0NcGj8T6IejQ3JSGblsVlM3JqSpvkUp
         KFswIxe3vj9uVxeHURFe7KHbkZfbgW5bpPj2+sz2YA5/jW2xsej+si7DyS+cHQnuFKpo
         Grytv0YQSoYqUtgbsgqWNtco4yYJYJU/3/kItHoEyRlzenpJIgYyjHD9vjzxocZOgYPn
         TGXazEmGe9xX8g35FKQZAe9OTufWqwCCCUsQdMEqjbOJR993VDCAfV4BipMoCXNtpAEn
         8ob3I4Isj6uIVUuuo1HrvNHQT8xlcmUKu/UapSmtGiuvC/+nGD4eGDbki6Jg2Lrk4yAQ
         xqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lcrpnq/b6/hpdUjJ7BPbI1dg5z0iJwDYFP4cImRT74Q=;
        b=gFJdf/cKT4Mi00WVKObpd2eNPhNyXTo6Yqyjed/L2/fyJLLO/omtZTCPPTaJ5/84dN
         uT3mLL/F46gTOCwTYWSNt9N201a+AzAmBQ9NiEAtQDOVLiDmBohUzl+vQ3fh9nmjOj+r
         2/Kuro+hOuJDCzYCT22YpNp2CaHS+4owc9XhUwi6/r3llXqrbQiAW2YQdkBHH0da/jvk
         z/U54o0KCwksQOw7K0H1/m4tOLVIc5mhHv/THeebroVW/qknMTiYCXbkdLcG5HnBsX9J
         qu+6lQWM9q6WCMMSZZ8XjfaCIZU+W44sqQ6e8O3VOMC1XCMcba9nSlAKjfM+DQITEKIK
         GFrg==
X-Gm-Message-State: APjAAAWQCMdySumLY8QCNZOnj6TkmmTeFnUORVUDOvkl7BPPfbOaOmix
        AAn0UUjoOE392DcAunIpH9g4AA==
X-Google-Smtp-Source: APXvYqyyvmpMV6UxoiAw6oNqpaKxbRnOQVGywr7htIuimBaTBFfOvraztV8a2ntnrTPplYWpShvBMw==
X-Received: by 2002:a17:90a:b386:: with SMTP id e6mr354511pjr.106.1582829229170;
        Thu, 27 Feb 2020 10:47:09 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id e2sm3343567pfh.151.2020.02.27.10.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 10:47:08 -0800 (PST)
Date:   Thu, 27 Feb 2020 11:47:06 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Siddharth Gupta <sidgup@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, rishabhb@codeaurora.org
Subject: Re: [PATCH 3/6] remoteproc: sysmon: Inform current rproc about all
 active rprocs
Message-ID: <20200227184706.GA20116@xps15>
References: <1582167465-2549-1-git-send-email-sidgup@codeaurora.org>
 <1582167465-2549-4-git-send-email-sidgup@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582167465-2549-4-git-send-email-sidgup@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 06:57:42PM -0800, Siddharth Gupta wrote:
> A remoteproc that has just recovered from a crash will not be aware of the
> state of other remoteprocs. Send sysmon notifications on behalf of all the
> active/online remoteprocs to the one that just booted up.
> 
> Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
> ---
>  drivers/remoteproc/qcom_sysmon.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_sysmon.c b/drivers/remoteproc/qcom_sysmon.c
> index 851664e..d0d59d5 100644
> --- a/drivers/remoteproc/qcom_sysmon.c
> +++ b/drivers/remoteproc/qcom_sysmon.c
> @@ -457,6 +457,7 @@ static int sysmon_start(struct rproc_subdev *subdev)
>  {
>  	struct qcom_sysmon *sysmon = container_of(subdev, struct qcom_sysmon,
>  						  subdev);
> +	struct qcom_sysmon *target;
>  	struct sysmon_event event = {
>  		.subsys_name = sysmon->name,
>  		.ssr_event = SSCTL_SSR_EVENT_AFTER_POWERUP
> @@ -464,6 +465,17 @@ static int sysmon_start(struct rproc_subdev *subdev)
>  
>  	blocking_notifier_call_chain(&sysmon_notifiers, 0, (void *)&event);
>  
> +	mutex_lock(&sysmon_lock);
> +	list_for_each_entry(target, &sysmon_list, node) {
> +		if (target == sysmon ||
> +		    target->rproc->state != RPROC_RUNNING)
> +			continue;
> +
> +		event.subsys_name = target->name;
> +		ssctl_send_event(sysmon, &event);
> +	}
> +	mutex_unlock(&sysmon_lock);
> +

The changelog is specific about crash recovery but to me this code will run
every time an MCU is switched on.  If I understand correctly, in a crash
recovery situation or simply an MCU coming on line, you want to make sure the
subdevices associated to the booting (or recovering) MCU knows about subdevices
that were registered with the sysmon_notifiers before it.

If that is the case, the changelog needs to be modified and a good chunk of
comments need to be added to this patch.

Lastly, shouldn't there be a provision for sysmon->ssctl_version == 2?

Thanks,
Mathieu 

>  	return 0;
>  }
>  
> -- 
> Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
