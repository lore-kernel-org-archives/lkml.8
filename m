Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9B7C3F2C0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE942469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="da4qGju1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbgB0V7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:59:46 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39405 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729773AbgB0V7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 16:59:45 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so355939plp.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 13:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fTXwSB4VEwuhKImP00VDYWj8Af4ja5hCUGthoXkzd7w=;
        b=da4qGju1+eZ2u8i58+SFACyeBx7k8na1SwRT59gr6pARxKA7OBl7JlfyCR7xI1I3Kf
         /V/VJ1QOH11rKWuOKFg6KOIQSn+Jf7ZnhVidCNFdPdLe5622MrW8OtaZUl+w8nDRJzjC
         iU0mCfwyleneSgcMGPjzjbS919tBWgh52msMkbxy2L20TrjcgDaEEE4U+t6Xx4ARA6EY
         Pd7KbZc4mLkKkKvANfjruzXD6s8EcFm28mA+EXMt6QkUik1OE0lYSQ+hOAKbF+NE85Tg
         D0yvxM69y5mK8RJgJVo1EUow5kIadB0W6kCJP3apUHPOEgrj7i7YFk3BPvb13ic6uso0
         TA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fTXwSB4VEwuhKImP00VDYWj8Af4ja5hCUGthoXkzd7w=;
        b=MWxVTnm9T2SPnoZG94SwOrGKO01HObP/Aiu833HAtoFOPTt3Q3q+v1+r4jGefpFa9z
         /g76M5IoN4xB8Qme3a9dhmPR+dThosgRkwvviUcwJL2kVK9O41tD4A9D/UBFkO3wlwS2
         nNWz32DxCDk/Vo8j5+dzr5jifj/aMU+8Uc1kFVyll5ZrmTWEfobXdgR+7pIpdrxhzXk5
         b0wHkgL3aO5qtgp/weQur275nRTXNkryNzHQZ3sabwU7IxIg8l+ZQT3ScweFLq1UhK+7
         nMaNqCm5EuvNErPZsxeqPmblcede2ZZE1Unpvl5F5A06csH17Ty0uKeq0DyM9KKhiKwM
         XgvA==
X-Gm-Message-State: APjAAAVIJo5R+nnhRvW8ORw+9GwsBymWtaLlxG14SK/GjfzjEJDyNzyb
        7jk6f14cI2QjLLpoht00CdyZpw==
X-Google-Smtp-Source: APXvYqyJbAO6h6eSnb87jvQLhMjQwDPCpkhG8rjKyddMg705cLOaRbLZ4Ipmh0A78bB2EbWpjwj77A==
X-Received: by 2002:a17:902:c113:: with SMTP id 19mr899784pli.138.1582840783021;
        Thu, 27 Feb 2020 13:59:43 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id p21sm8081275pfn.103.2020.02.27.13.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 13:59:42 -0800 (PST)
Date:   Thu, 27 Feb 2020 14:59:40 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Siddharth Gupta <sidgup@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, ohad@wizery.com,
        tsoni@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rishabhb@codeaurora.org, psodagud@codeaurora.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/6] remoteproc: qcom: Add notification types to SSR
Message-ID: <20200227215940.GC20116@xps15>
References: <1582167465-2549-1-git-send-email-sidgup@codeaurora.org>
 <1582167465-2549-7-git-send-email-sidgup@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582167465-2549-7-git-send-email-sidgup@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 06:57:45PM -0800, Siddharth Gupta wrote:
> The SSR subdevice only adds callback for the unprepare event. Add callbacks
> for unprepare, start and prepare events. The client driver for a particular
> remoteproc might be interested in knowing the status of the remoteproc
> while undergoing SSR, not just when the remoteproc has finished shutting
> down.
> 
> Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
> ---
>  drivers/remoteproc/qcom_common.c | 39 +++++++++++++++++++++++++++++++++++----
>  include/linux/remoteproc.h       | 15 +++++++++++++++
>  2 files changed, 50 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
> index 6714f27..6f04a5b 100644
> --- a/drivers/remoteproc/qcom_common.c
> +++ b/drivers/remoteproc/qcom_common.c
> @@ -183,9 +183,9 @@ EXPORT_SYMBOL_GPL(qcom_remove_smd_subdev);
>   *
>   * Returns pointer to srcu notifier head on success, ERR_PTR on failure.
>   *
> - * This registers the @notify function as handler for restart notifications. As
> - * remote processors are stopped this function will be called, with the rproc
> - * pointer passed as a parameter.
> + * This registers the @notify function as handler for powerup/shutdown
> + * notifications. This function will be invoked inside the callbacks registered
> + * for the ssr subdevice, with the rproc pointer passed as a parameter.
>   */
>  void *qcom_register_ssr_notifier(struct rproc *rproc, struct notifier_block *nb)
>  {
> @@ -227,11 +227,39 @@ int qcom_unregister_ssr_notifier(void *notify, struct notifier_block *nb)
>  }
>  EXPORT_SYMBOL_GPL(qcom_unregister_ssr_notifier);
>  
> +static int ssr_notify_prepare(struct rproc_subdev *subdev)
> +{
> +	struct qcom_rproc_ssr *ssr = to_ssr_subdev(subdev);
> +
> +	srcu_notifier_call_chain(ssr->rproc_notif_list,
> +				 RPROC_BEFORE_POWERUP, (void *)ssr->name);
> +	return 0;
> +}
> +
> +static int ssr_notify_start(struct rproc_subdev *subdev)
> +{
> +	struct qcom_rproc_ssr *ssr = to_ssr_subdev(subdev);
> +
> +	srcu_notifier_call_chain(ssr->rproc_notif_list,
> +				 RPROC_AFTER_POWERUP, (void *)ssr->name);
> +	return 0;
> +}
> +
> +static void ssr_notify_stop(struct rproc_subdev *subdev, bool crashed)
> +{
> +	struct qcom_rproc_ssr *ssr = to_ssr_subdev(subdev);
> +
> +	srcu_notifier_call_chain(ssr->rproc_notif_list,
> +				 RPROC_BEFORE_SHUTDOWN, (void *)ssr->name);
> +}
> +
> +
>  static void ssr_notify_unprepare(struct rproc_subdev *subdev)
>  {
>  	struct qcom_rproc_ssr *ssr = to_ssr_subdev(subdev);
>  
> -	srcu_notifier_call_chain(ssr->rproc_notif_list, 0, (void *)ssr->name);
> +	srcu_notifier_call_chain(ssr->rproc_notif_list,
> +				 RPROC_AFTER_SHUTDOWN, (void *)ssr->name);
>  }
>  
>  /**
> @@ -248,6 +276,9 @@ void qcom_add_ssr_subdev(struct rproc *rproc, struct qcom_rproc_ssr *ssr,
>  {
>  	ssr->name = ssr_name;
>  	ssr->subdev.name = kstrdup("ssr_notifs", GFP_KERNEL);
> +	ssr->subdev.prepare = ssr_notify_prepare;
> +	ssr->subdev.start = ssr_notify_start;
> +	ssr->subdev.stop = ssr_notify_stop;

Now that I have a better understanding of what this patchset is doing, I realise
my comments in patch 04 won't work.  To differentiate the subdevs of an rproc I
suggest to wrap them in a generic structure with a type and an enum.  That way
you can differenciate between subdevices without having to add to the core.

That being said, I don't understand what patches 5 and 6 are doing...
Registering with the global ssr_notifiers allowed to gracefully shutdown all the
MCUs in the system when one of them would go down.  But now that we are using
the notifier on a per MCU, I really don't see why each subdev couldn't implement
the right prepare/start/stop functions.

Am I missing something here?
 

>  	ssr->subdev.unprepare = ssr_notify_unprepare;
>  	ssr->rproc_notif_list = kzalloc(sizeof(struct srcu_notifier_head),
>  								GFP_KERNEL);
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index e2f60cc..4be4478 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -449,6 +449,21 @@ struct rproc_dump_segment {
>  };
>  
>  /**
> + * enum rproc_notif_type - Different stages of remoteproc notifications
> + * @RPROC_BEFORE_SHUTDOWN:	unprepare stage of  remoteproc
> + * @RPROC_AFTER_SHUTDOWN:	stop stage of  remoteproc
> + * @RPROC_BEFORE_POWERUP:	prepare stage of  remoteproc
> + * @RPROC_AFTER_POWERUP:	start stage of  remoteproc
> + */
> +enum rproc_notif_type {
> +	RPROC_BEFORE_SHUTDOWN,
> +	RPROC_AFTER_SHUTDOWN,
> +	RPROC_BEFORE_POWERUP,
> +	RPROC_AFTER_POWERUP,
> +	RPROC_MAX
> +};
> +
> +/**
>   * struct rproc - represents a physical remote processor device
>   * @node: list node of this rproc object
>   * @domain: iommu domain
> -- 
> Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
