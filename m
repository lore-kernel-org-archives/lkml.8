Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE92C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE92920663
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KgTIBTlE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgD0Qet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725852AbgD0Qet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:34:49 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4161DC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:34:49 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 18so9244409pfx.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dH5N2+Bi4maNV3TmI71q19uFU+pmI9F59AU5vH4JkGo=;
        b=KgTIBTlEkl4brC9BVI6m48Hr6lFrINQSdl/vtD1d1TG9HjjiP1rV9LlZkFEY97lryv
         FpdoVukZ0PTdSO0bT9R9ppDktjJ5bKAWrFSrIIeL62AZWdBl+tPJotIxlbFf/nhoEys/
         8MtPXxtQTh65nhszKqT1ldyWDzOCPXbR7uhwZiTbXlrB7HPMinpQQ+S8wXSzrGwC5a0u
         fT8tY1Ge0/Qi4xNL+YQXJuPPaQfTTBSv233LH2/1H2OStjLWj+fxMvowEBMKEZ3VHrkV
         1a93tU0BtHcgapnwu37dHt4/sPW49DAFDhwMTYtEswJNG+jqyj6lzwMJcURIr0TXA7U3
         qp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dH5N2+Bi4maNV3TmI71q19uFU+pmI9F59AU5vH4JkGo=;
        b=CFTEcP7Fi/i4iI+260jK0b6lq677RgFJcn0fXs0Ah8sYGQ7sGLCsVjVhKiGWsXP6AR
         AWUcn/G3HiY/k6cItdVsBhPkhLUMiB3bm4/3fmr4ezVxH5ID/gsl0irYc+MnTQIvtpd2
         Zm19w7ifoSiBFtskN5tHrPUCpKvz4JgZXGPI2EDrj5CCkDHEsYzSF6OhtXpjqlHOzU3d
         KSaWd5QGcdX5h1LhXWSLgOSRghP9yv3Nn4gd99h8aV/ZMyNhjIUEki3pGDkip5uGWXAJ
         qIZWTMvM+x/pkUS7nhTvoz7vKmYAU8TwOmks/7dgE7mlW9mCr5TQWuy62FlBzEi+Wjt7
         7lWA==
X-Gm-Message-State: AGi0Pua7UDg0qIhHmBaALICgDksiyLcG8qldtvzllzDLQNHDJmyJyYPY
        DlnfbbdQbpDqRlVYIjc93/dkZg==
X-Google-Smtp-Source: APiQypLQHB4CFaWth/CqHFeb7GtkoQ9f+Z/YV/uWim5iFdQkxhpFtCKNB5qi1Wi4AJ6tYvRUkvgWmA==
X-Received: by 2002:a63:1845:: with SMTP id 5mr19348310pgy.69.1588005288806;
        Mon, 27 Apr 2020 09:34:48 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id fy21sm11457036pjb.25.2020.04.27.09.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 09:34:48 -0700 (PDT)
Date:   Mon, 27 Apr 2020 10:34:46 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Douglas Anderson <dianders@chromium.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH 1/5] coresight: Include required headers in C files
Message-ID: <20200427163446.GB10601@xps15>
References: <20200426185805.14923-1-swboyd@chromium.org>
 <20200426185805.14923-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200426185805.14923-2-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 11:58:01AM -0700, Stephen Boyd wrote:
> We should include headers that C files use in the C files that use them
> and avoid relying on implicit includes as much as possible. This helps
> avoid compiler errors in the future about missing declarations when
> header files change includes in the future.
> 
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/hwtracing/coresight/coresight-cti-platform.c |  8 +++++++-
>  drivers/hwtracing/coresight/coresight-cti-sysfs.c    |  7 +++++++
>  drivers/hwtracing/coresight/coresight-cti.h          | 10 +++++++++-
>  3 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-cti-platform.c b/drivers/hwtracing/coresight/coresight-cti-platform.c
> index b44d83142b62..245f16c61af8 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-platform.c
> @@ -2,11 +2,17 @@
>  /*
>   * Copyright (c) 2019, The Linaro Limited. All rights reserved.
>   */
> +#include <linux/coresight.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/property.h>
> +#include <linux/slab.h>
>  
>  #include <dt-bindings/arm/coresight-cti-dt.h>
> -#include <linux/of.h>
>  
>  #include "coresight-cti.h"
> +#include "coresight-priv.h"
>  
>  /* Number of CTI signals in the v8 architecturally defined connection */
>  #define NR_V8PE_IN_SIGS		2
> diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> index 1f8fb7c15e80..bed460541f15 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> @@ -4,7 +4,14 @@
>   * Author: Mike Leach <mike.leach@linaro.org>
>   */
>  
> +#include <linux/atomic.h>
>  #include <linux/coresight.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/sysfs.h>
>  
>  #include "coresight-cti.h"
>  
> diff --git a/drivers/hwtracing/coresight/coresight-cti.h b/drivers/hwtracing/coresight/coresight-cti.h
> index 004df3ab9dd0..d80123b905a8 100644
> --- a/drivers/hwtracing/coresight/coresight-cti.h
> +++ b/drivers/hwtracing/coresight/coresight-cti.h
> @@ -7,8 +7,10 @@
>  #ifndef _CORESIGHT_CORESIGHT_CTI_H
>  #define _CORESIGHT_CORESIGHT_CTI_H
>  
> -#include <asm/local.h>
> +#include <linux/list.h>
>  #include <linux/spinlock.h>
> +#include <linux/types.h>
> +
>  #include "coresight-priv.h"
>  
>  /*
> @@ -52,6 +54,12 @@
>   */
>  #define CTIINOUTEN_MAX		32
>  
> +struct attribute;
> +struct attribute_group;
> +struct coresight_device;
> +struct device;
> +struct fwnode_handle;
> +

I would prefer adding the headers rather than forward declarations, it scales
better.

Thanks,
Mathieu

>  /**
>   * Group of related trigger signals
>   *
> -- 
> Sent by a computer, using git, on the internet
> 
