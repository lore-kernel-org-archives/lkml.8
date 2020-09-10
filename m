Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A57AC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E7BC221E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kOa4mmT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbgIJW2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 18:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgIJW2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 18:28:44 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0544AC061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 15:28:44 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gf14so722373pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 15:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sjZrQF14jN6lVtAygMc1G3kRh/GmmF+g8hLxXnRGB5k=;
        b=kOa4mmT5s/8aZx6h/nMct4BHUmLMcDmq1W6RyOC08Y+trS6yfhaxBJi3R+8jWQOh0p
         gTZkgDV7rAWZvvEs57BKWNiNIdXawQJ4/+sXxQ+dNbY6sxUIwb1pn7UPQW8hr0CLG41b
         3JG99XOKZBFiYcAIfMLpSZTxBnnBKVJ9vBj8NwMtBuNEQqKCck2d3Z1XIzXY8bZpcKm6
         ZDku5qSx6uXz4z9RpfXciNQkVmv0m2b5oZT5LRjxpq147tPD10yiVj3De7K/QZiBYQZm
         rI6foXNA+vDLu79PMK1H0FGNdQRv38SJwkwC/BbkQ5bZrw5ZgL9VAUqQCl8PwC9Que4i
         67Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sjZrQF14jN6lVtAygMc1G3kRh/GmmF+g8hLxXnRGB5k=;
        b=CNYCUFN9oJMw/ex5zi+WsskX9p5NEJoXQ71/oGfIHHL5cqa18wWcHMzbvR28W4A6Ka
         fteJvMhDTiqejK/8E5M7YUA353b2HtKxWBSX1lOw2X7rC7BeSU5QxfMrDv2HxW7S3nKq
         k8QdYVg3rsvjmv6998fEQlTsMAN2mLIL5f5xXZkIO8q65teW0ytpU8hmBLR8sgjtrzxJ
         mza58zFvYrzRaJmExXXYLrmMGkedQpcsCWSHCyXQtI8nijtwHALiYeHeh3hteCAvy9/P
         dkXeLQ0DKzmvPOf2UTou3dPe1MlvQnS70ZRRZdU8yKa5AwlR5P65IOE8wQcfia9itfGF
         92oA==
X-Gm-Message-State: AOAM5304F4o306CkowSTI3ou4ZEr9ZDpLx9PsNJ+NDJiK4qc5gm92FQo
        rYDNxh19JNx4Wa+bmCETc/lP9g==
X-Google-Smtp-Source: ABdhPJwICBh5L9HYL8B6Sbe0iS5NWzvsNYCpNE36MXPC3CApO7xAYK1tcl944hI2Y+9o4JpjIYD2tw==
X-Received: by 2002:a17:90a:ad8b:: with SMTP id s11mr1991878pjq.40.1599776923456;
        Thu, 10 Sep 2020 15:28:43 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id w6sm21305pgf.72.2020.09.10.15.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 15:28:42 -0700 (PDT)
Date:   Thu, 10 Sep 2020 16:28:40 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tingwei Zhang <tingwei@codeaurora.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leo Yan <leo.yan@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Kim Phillips <kim.phillips@arm.com>,
        Mian Yousaf Kaukab <ykaukab@suse.de>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 08/24] coresight: etm: perf: Fix warning caused by
 etm_setup_aux failure
Message-ID: <20200910222840.GB590446@xps15>
References: <20200821034445.967-1-tingwei@codeaurora.org>
 <20200821034445.967-9-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821034445.967-9-tingwei@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 11:44:29AM +0800, Tingwei Zhang wrote:
> When coresight_build_path() fails on all the cpus, etm_setup_aux
> calls etm_free_aux() to free allocated event_data.
> WARN_ON(cpumask_empty(mask) will be triggered since cpu mask is empty.
> Check event_data->snk_config is not NULL first to avoid this
> warning.
> 
> Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> Reviewed-by: Mike Leach <mike.leach@linaro.org>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

What happend to the Fixed tag that was in V8?  This is casting doubts on the
reset of this set.  

> ---
>  drivers/hwtracing/coresight/coresight-etm-perf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index dcb0592418ae..3728c44e5763 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -126,10 +126,10 @@ static void free_sink_buffer(struct etm_event_data *event_data)
>  	cpumask_t *mask = &event_data->mask;
>  	struct coresight_device *sink;
>  
> -	if (WARN_ON(cpumask_empty(mask)))
> +	if (!event_data->snk_config)
>  		return;
>  
> -	if (!event_data->snk_config)
> +	if (WARN_ON(cpumask_empty(mask)))
>  		return;
>  
>  	cpu = cpumask_first(mask);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
