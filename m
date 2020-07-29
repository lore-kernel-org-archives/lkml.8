Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CECC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 18:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A63C62082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 18:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kDK1A5vL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgG2SBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 14:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgG2SBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 14:01:31 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5754EC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 11:01:31 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id l2so6998853pff.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 11:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7Fg1vKJS3H5jh+wjn/xw49NxzhVUYnMnmlb+Oe4mf7Y=;
        b=kDK1A5vLlmS/z3Vg+YPyBmjuDb1ZO3FOFMg+2+2fXoCjZQNGiVWRf0YhABHnklf2wx
         e0MAT7jjJzJrSjKXWeyvG/5FHi0PHQPx+QcOe+8xykcQt21VBj+10iL0WtrVZ4z0VCad
         +/96WCno2ti/G7dhnRdIbraC0+r+kNs7Ykh4MvJ/KfSdgPIrSb9X2Mj5ngYDht4tOouO
         qL/jJ9lLmTpmt0I73Hp7NzjS0jVCEOkr7xQl0snLWbtSsK55P+SOeSK86DQydWe+6uc0
         kMGuD66PBX1y38OcF9bc2tqR7v+uxerJUOVAf9U3lvKO2R7ZPipfXNtzS2Uv86foZYau
         0nkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7Fg1vKJS3H5jh+wjn/xw49NxzhVUYnMnmlb+Oe4mf7Y=;
        b=nOt7LOl1rpJTedCo4KYGJkUflf//Oeuybn8EMDoWW7+q3o5gFSD4nZ8PQmydOfgNye
         JMSv+isu3m7jFprRAvC0+uPFHQWDIqOfIp5xUXt5701foQQNvk5sFLBL3EGfr1QFhCVm
         jZowBXIdKJJaVsDdMu5mtJz6DP4Jgx1hW8rs/xBsLg9w+XjoG5AUWeCKct7Ygx/48eG1
         ZsIKCdTjGa3hP6B5ftqNwIv8EjazGgPVJgUl0mhe4/Vz+G44qZVSTFMS4XBGC0eQ7MOV
         SvwzBuZvP+QSIL9T7q6t5Y/G/Ul4zxltLUf2swqcxDMekZs7OZv78ILV4UDbSC5y27Vd
         zQmw==
X-Gm-Message-State: AOAM531PLUPBHhlfee1RoakQn+9iZ8ouQxM54x12ZSDS1HCrT3+VLrIU
        rdv6jaO2rYaaBYAJo4CR5jfMIWIzLbQ=
X-Google-Smtp-Source: ABdhPJwD94zX5NtBLr5Jy/12mGTDvoDdqfTFGPhbmi5x+c3Ax7A49aYeRtseyww/3+YK6FMpN1jK3w==
X-Received: by 2002:a63:1a0c:: with SMTP id a12mr29769031pga.24.1596045690787;
        Wed, 29 Jul 2020 11:01:30 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id n15sm2931735pgs.25.2020.07.29.11.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 11:01:30 -0700 (PDT)
Date:   Wed, 29 Jul 2020 12:01:28 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, coresight@lists.linaro.org
Subject: Re: [RFC PATCH 01/14] coresight: etm4x: Skip save/restore before
 device registration
Message-ID: <20200729180128.GA3073178@xps15>
References: <20200722172040.1299289-1-suzuki.poulose@arm.com>
 <20200722172040.1299289-2-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722172040.1299289-2-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

I have starte to review this - comments will be scattered over a few days.

On Wed, Jul 22, 2020 at 06:20:27PM +0100, Suzuki K Poulose wrote:
> Skip cpu save/restore before the coresight device is registered.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 6d7d2169bfb2..cb83fb77ded6 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -1135,7 +1135,13 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
>  {
>  	int i, ret = 0;
>  	struct etmv4_save_state *state;
> -	struct device *etm_dev = &drvdata->csdev->dev;
> +	struct coresight_device *csdev = drvdata->csdev;
> +	struct device *etm_dev;
> +
> +	if (WARN_ON(!csdev))
> +		return -ENODEV;
> +
> +	etm_dev = &csdev->dev;
>  
>  	/*
>  	 * As recommended by 3.4.1 ("The procedure when powering down the PE")
> @@ -1261,6 +1267,10 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
>  {
>  	int i;
>  	struct etmv4_save_state *state = drvdata->save_state;
> +	struct coresight_device *csdev = drvdata->csdev;
> +
> +	if (WARN_ON(!csdev))
> +		return;

Restore and save operations are only called from etm4_cpu_pm_notify() where the
check for a valid drvdata->csdev is already done.

>  
>  	CS_UNLOCK(drvdata->base);
>  
> @@ -1368,6 +1378,10 @@ static int etm4_cpu_pm_notify(struct notifier_block *nb, unsigned long cmd,
>  
>  	drvdata = etmdrvdata[cpu];
>  
> +	/* If we have not registered the device there is nothing to do */
> +	if (!drvdata->csdev)
> +		return NOTIFY_OK;

Can you describe the scenario you've seen this happening in?  Probably best to
add it to the changelog. 

> +
>  	if (!drvdata->save_state)
>  		return NOTIFY_OK;
>  
> -- 
> 2.24.1
> 
