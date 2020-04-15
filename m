Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E2EC3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2372A20784
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FaDHsxJ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410663AbgDOREA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410653AbgDORDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:03:55 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099ADC061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 10:03:55 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t11so205926pgg.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 10:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TXmBTmjlGDdkYJ5YaS9MFQANC5ZQIcUdQZgB+/qVJcg=;
        b=FaDHsxJ/Bsq5/mrz/KAm6LRhZzJ4oycH4qGHGQN9l033vBRXCFWhhDAHZx0+xkwcn6
         3d9mqYrLsMXHMiqUyBOvrSZgysqBewL5VEDFgtVWtZ5r5R4iKx0idNL1JXlvFWZkTJG1
         z4/YrF5Wga+eRnhDgvfXrFjJEwsFIlqlBzlRcSojTuj2fo9hu1Gco/ImeqCdmYAyEG7h
         ladEsxtLlmQSyVLOdLCdz9Y6RtEjYQKZnB+Ofr1ZjLsx6jSBvrP7LBYE5Itxoaazm7tz
         FI4TPa2wRScdEcGxXCnlV1c5PskOclAIjNWYYB/RjLot4De6rh4OvuWVsPpy2MGobT+R
         vnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TXmBTmjlGDdkYJ5YaS9MFQANC5ZQIcUdQZgB+/qVJcg=;
        b=AhueSTTpvm9ctAxtNpdSMkPya7zostGy9O8MdbmPviOZdXV1GS4r5sEQhdRbzotDGu
         /gn1n8QxmU7heDUshtTXE8evZAulwM1Bp9SyIZrMywd5WZTvR7B0ta8wg/v5An8lnitd
         vejTmkS4Nl6ufXV/+4unXBAzeptyauYlBHWBE6NBZIr4+Z5FaDXBgJjJCf1P7dNp30Hu
         /ZUTlt0H7MmHYP2LoqNchrKhO60KRjxjpQwf9K20I47TUnUF+9EHvhodKtGwVqXx6VtN
         uAeb3Sok30EGv5nLJGUabJoaAMgJXv0JiTW/yA9M+Guw4NS3tWRj8Ok5rqibdaE4Aflf
         tQVg==
X-Gm-Message-State: AGi0PuaiyP4UolsoOgzl7rEWpt46C/Efh5g18/ftgjg3Y/FQOi9spwzZ
        JixacafuC1xoYByYLTttsa8ZSw==
X-Google-Smtp-Source: APiQypKxA2s9Ixhh/x4lzTu9wFMre6vgaWEw6jKo5l4u/n/V4C6g53A2/FTS+wGYaVfEJGJ7TqgWsQ==
X-Received: by 2002:a62:2506:: with SMTP id l6mr24888469pfl.184.1586970234265;
        Wed, 15 Apr 2020 10:03:54 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id i124sm14308027pfg.14.2020.04.15.10.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 10:03:53 -0700 (PDT)
Date:   Wed, 15 Apr 2020 11:03:51 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Siddharth Gupta <sidgup@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, rishabhb@codeaurora.org
Subject: Re: [PATCH v2 2/6] remoteproc: sysmon: Add notifications for events
Message-ID: <20200415170351.GB16583@xps15>
References: <1586389003-26675-1-git-send-email-sidgup@codeaurora.org>
 <1586389003-26675-3-git-send-email-sidgup@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586389003-26675-3-git-send-email-sidgup@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 04:36:39PM -0700, Siddharth Gupta wrote:
> Add notification for other stages of remoteproc boot and shutdown. This
> includes adding callback functions for the prepare and unprepare events,
> and fleshing out the callback function for start.
> 
> Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>

Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> ---
>  drivers/remoteproc/qcom_sysmon.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_sysmon.c b/drivers/remoteproc/qcom_sysmon.c
> index 1366050..851664e 100644
> --- a/drivers/remoteproc/qcom_sysmon.c
> +++ b/drivers/remoteproc/qcom_sysmon.c
> @@ -439,8 +439,31 @@ static const struct qmi_ops ssctl_ops = {
>  	.del_server = ssctl_del_server,
>  };
>  
> +static int sysmon_prepare(struct rproc_subdev *subdev)
> +{
> +	struct qcom_sysmon *sysmon = container_of(subdev, struct qcom_sysmon,
> +						  subdev);
> +	struct sysmon_event event = {
> +		.subsys_name = sysmon->name,
> +		.ssr_event = SSCTL_SSR_EVENT_BEFORE_POWERUP
> +	};
> +
> +	blocking_notifier_call_chain(&sysmon_notifiers, 0, (void *)&event);
> +
> +	return 0;
> +}
> +
>  static int sysmon_start(struct rproc_subdev *subdev)
>  {
> +	struct qcom_sysmon *sysmon = container_of(subdev, struct qcom_sysmon,
> +						  subdev);
> +	struct sysmon_event event = {
> +		.subsys_name = sysmon->name,
> +		.ssr_event = SSCTL_SSR_EVENT_AFTER_POWERUP
> +	};
> +
> +	blocking_notifier_call_chain(&sysmon_notifiers, 0, (void *)&event);
> +
>  	return 0;
>  }
>  
> @@ -464,6 +487,18 @@ static void sysmon_stop(struct rproc_subdev *subdev, bool crashed)
>  		sysmon_request_shutdown(sysmon);
>  }
>  
> +static void sysmon_unprepare(struct rproc_subdev *subdev)
> +{
> +	struct qcom_sysmon *sysmon = container_of(subdev, struct qcom_sysmon,
> +						  subdev);
> +	struct sysmon_event event = {
> +		.subsys_name = sysmon->name,
> +		.ssr_event = SSCTL_SSR_EVENT_AFTER_SHUTDOWN
> +	};
> +
> +	blocking_notifier_call_chain(&sysmon_notifiers, 0, (void *)&event);
> +}
> +
>  /**
>   * sysmon_notify() - notify sysmon target of another's SSR
>   * @nb:		notifier_block associated with sysmon instance
> @@ -563,8 +598,10 @@ struct qcom_sysmon *qcom_add_sysmon_subdev(struct rproc *rproc,
>  
>  	qmi_add_lookup(&sysmon->qmi, 43, 0, 0);
>  
> +	sysmon->subdev.prepare = sysmon_prepare;
>  	sysmon->subdev.start = sysmon_start;
>  	sysmon->subdev.stop = sysmon_stop;
> +	sysmon->subdev.unprepare = sysmon_unprepare;
>  
>  	rproc_add_subdev(rproc, &sysmon->subdev);
>  
> -- 
> Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
