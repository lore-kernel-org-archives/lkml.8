Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A5DC38A29
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 19:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D512E20715
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 19:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wOOCNhaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbgDPTX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 15:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727819AbgDPTXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 15:23:53 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58041C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 12:23:53 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id o1so1782439pjs.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 12:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aKFYVYQ9OYxfkj6UtWE/c0zee6GGkl7hN2RiXbrSsVQ=;
        b=wOOCNhaQsoosxHRpdTHfDHxWt+3yGUwtdVHwF/2+AdpJ85PsC8MarhgRu+8jev/fUw
         guZPcEBfiQibYkIVoTbLyaM6Sn0VMko49d/uKZC4KFoRxdN0drDm372VeGsWO4MMzNbH
         IBIx/jZz+pr/4Cwst1GDcrnoY+ozXV3t+DzKHxanKWTIp51IsQSu4wvgiLJJlokx4nQH
         0Acdma8hyGFfKiB55qOrNPYc42ho6XiVtd+wmAkwGZp0UA9JevcXfDYt2Qi4c1jRtYnG
         MONrmuHqYbLHEaHlcRMW9p065LGFFAkDU/brduXXVkgSUPt9l1yml2c5mpbucPCRPhtU
         CuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aKFYVYQ9OYxfkj6UtWE/c0zee6GGkl7hN2RiXbrSsVQ=;
        b=PmBHtfrW5SKFX5lo/uuqWrHZZnyMtUwbho9JbW9v/G9UWBrpHc2XXV2ROyeqN386lH
         b/rGXXbJlxQimp166S7QevaE0aNHj6nddhrNao9NkBzU97NbLer3yas0Z6biKgQUwGKr
         8vEwvNtJrGu/v1Nr2rQ5+sED0qxp6Yqvwh6SwbkGkXxmBcRX3hwcG//ChBgNQ9YeSq5q
         n3y1uN/L6NqOZPejnImPX6yTBVp52rGihoS7Dh0T7/Zhkb1W7baATewMPxrbEqohohpo
         4aNuLmvy0X+qRerEWdoIpWhrUENX/pQTVq66h9UuFolDPoAMDiuZiS+oDCPFwN6jySnC
         rwNg==
X-Gm-Message-State: AGi0PuYGB21QWmmZ8Md1AUE7B6Xl4sWLLqickZSXN+vG8181NhyNeZgO
        xciUWl6SrFWjlOH4KxM8Hc47tA==
X-Google-Smtp-Source: APiQypK0eaYot0thKROCDeMzMTdcPgMIkES3AeLNRv813IJwsbnRKl5Rw9PycXGl/pCuoTqlxZH3aw==
X-Received: by 2002:a17:90b:3691:: with SMTP id mj17mr6924777pjb.114.1587065032831;
        Thu, 16 Apr 2020 12:23:52 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id p8sm3465938pjd.10.2020.04.16.12.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 12:23:52 -0700 (PDT)
Date:   Thu, 16 Apr 2020 13:23:50 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Siddharth Gupta <sidgup@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, rishabhb@codeaurora.org
Subject: Re: [PATCH v2 1/2] remoteproc: core: Add an API for changing
 firmware name
Message-ID: <20200416192350.GA29577@xps15>
References: <1586384305-7825-1-git-send-email-sidgup@codeaurora.org>
 <1586384305-7825-2-git-send-email-sidgup@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586384305-7825-2-git-send-email-sidgup@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Siddharth,

On Wed, Apr 08, 2020 at 03:18:24PM -0700, Siddharth Gupta wrote:
> Add an API which allows to change the name of the firmware to be booted on
> the specified rproc. This change gives us the flixibility to change the
> firmware at run-time depending on the usecase. Some remoteprocs might use
> a different firmware for testing, production and development purposes,
> which may be selected based on the fuse settings during bootup.
> 
> Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
> ---
>  drivers/remoteproc/remoteproc_core.c | 43 ++++++++++++++++++++++++++++++++++++
>  include/linux/remoteproc.h           |  1 +
>  2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index fb9c813..9f99fe2 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1796,6 +1796,49 @@ int rproc_boot(struct rproc *rproc)
>  EXPORT_SYMBOL(rproc_boot);
>  
>  /**
> + * rproc_set_firmware_name() - change the firmware name for specified remoteproc
> + * @rproc: handle of a remote processor
> + * @firmware: name of the firmware to boot with
> + *
> + * Change the name of the firmware to be loaded to @firmware in the rproc
> + * structure. We should ensure that the remoteproc is not running.
> + *
> + * Returns 0 on success, and an appropriate error value otherwise.
> + */
> +int rproc_set_firmware_name(struct rproc *rproc, const char *firmware)
> +{
> +	int len, ret = 0;
> +	char *p;
> +
> +	if (!rproc || !firmware)
> +		return -EINVAL;
> +
> +	len = strcspn(firmware, "\n");
> +	if (!len)
> +		return -EINVAL;
> +
> +	mutex_lock(&rproc->lock);
> +
> +	if (rproc->state != RPROC_OFFLINE) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	p = kstrndup(firmware, len, GFP_KERNEL);
> +	if (!p) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	kfree(rproc->firmware);
> +	rproc->firmware = p;
> +out:
> +	mutex_unlock(&rproc->lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL(rproc_set_firmware_name);
> +

This is much better, thanks for cleaning things up. Keep in mind that when you
do resend this rproc->firmware will likely have become a "const char *",
requiring the use of kstrndup_const()...  But that is for a later time.  

Mathieu

> +/**
>   * rproc_shutdown() - power off the remote processor
>   * @rproc: the remote processor
>   *
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 9c07d79..c5d36e6 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -613,6 +613,7 @@ rproc_of_resm_mem_entry_init(struct device *dev, u32 of_resm_idx, size_t len,
>  			     u32 da, const char *name, ...);
>  
>  int rproc_boot(struct rproc *rproc);
> +int rproc_set_firmware_name(struct rproc *rproc, const char *firmware);
>  void rproc_shutdown(struct rproc *rproc);
>  void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type);
>  int rproc_coredump_add_segment(struct rproc *rproc, dma_addr_t da, size_t size);
> -- 
> Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
