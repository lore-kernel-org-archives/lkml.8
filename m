Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F480C33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F3D2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D2nocuW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgAJV2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 16:28:11 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:56177 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgAJV2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 16:28:10 -0500
Received: by mail-pj1-f66.google.com with SMTP id d5so1465074pjz.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 13:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=viPNXtvEyDoCmVBCyRALorFNqUyS0KGVGSGNa6vRkAo=;
        b=D2nocuW33MlbdJco1hV0XxUMMz2fsz8BeZNWWmVMjaNj5Rp+hEnyuWtQDy5Ra1LUCL
         K+3CJC7/G2wUykWX1TUg0I3cWIZnAXKAORwPudXX4oO16LJEQnEd7PiJrBlCiAt2EPc6
         htDgLEr38DCUiI6XOBrOnKCgZilQYV6WffG9gw5rJHP6bdkq5spK+HHslOoVzShuyfeR
         bcQoag3NVWugOPleXCmOMWo8MLvhNttQfJ3AZc5Xj4ujt2XBJfvOdvyoeQYUASXhEo/b
         Tq4RZKCDi8/Iv+gvIqoiATCwGTYFOA23e2+3FBN7uKLt+9sOnecSrNEuwaFMc9V9WjAJ
         9XQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=viPNXtvEyDoCmVBCyRALorFNqUyS0KGVGSGNa6vRkAo=;
        b=tmC/1yElSR+2UWAKqihHcP1gD0DjXDCMinEGHLDoTGbQ6NRJsInNhwxXqM4he2ndo/
         0js8V0A7PATcojiuhjD8p1kdgDbE4ximMkQ+nOkYZ5echGVH0epiG4T8VTsZMZ6s1Q8i
         uk+KCHAEqaCJoylqTXJLhOu6dnd8UyCUHmBEz7yEkNuZuNVZY9QwW4D5VzyFj0G5uOm1
         u0XLJv2PLhkYnFUbGD63PG33YAHASqdQgSvVV0v/hGwjKYEZEAYi0XVt2JuLx2P+PpJ9
         nDOY/RNwEov7XtsKaukBza4OQjV8ApLOSkWnNkpJXU6+mwZWQgEopTFuq3Ef2rw3/4JR
         FYYg==
X-Gm-Message-State: APjAAAXXdIy4pcqTi0C1WcBYyRez7YV2iaUxtTtlTmo9OC73HgOuG/O2
        78znYArfs3M8oAFZ8qE7gWEbnw==
X-Google-Smtp-Source: APXvYqzYj/spulZNJS+gjeNidZhhw9Hpm7o2a1Vcck4PUefPZJe/oOIPG4pzu6BMDxg2a/abPqg9vw==
X-Received: by 2002:a17:90a:b009:: with SMTP id x9mr7430144pjq.124.1578691689492;
        Fri, 10 Jan 2020 13:28:09 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id w11sm3685158pgs.60.2020.01.10.13.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 13:28:08 -0800 (PST)
Date:   Fri, 10 Jan 2020 14:28:06 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: Re: [PATCH v2 7/8] remoteproc: qcom: q6v5: Add common panic handler
Message-ID: <20200110212806.GD11555@xps15>
References: <20191227053215.423811-1-bjorn.andersson@linaro.org>
 <20191227053215.423811-8-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191227053215.423811-8-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2019 at 09:32:14PM -0800, Bjorn Andersson wrote:
> Add a common panic handler that invokes a stop request and sleep enough
> to let the remoteproc flush it's caches etc in order to aid post mortem
> debugging.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - None
> 
>  drivers/remoteproc/qcom_q6v5.c | 19 +++++++++++++++++++
>  drivers/remoteproc/qcom_q6v5.h |  1 +
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
> index cb0f4a0be032..17167c980e02 100644
> --- a/drivers/remoteproc/qcom_q6v5.c
> +++ b/drivers/remoteproc/qcom_q6v5.c
> @@ -6,6 +6,7 @@
>   * Copyright (C) 2014 Sony Mobile Communications AB
>   * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
>   */
> +#include <linux/delay.h>
>  #include <linux/kernel.h>
>  #include <linux/platform_device.h>
>  #include <linux/interrupt.h>
> @@ -15,6 +16,8 @@
>  #include <linux/remoteproc.h>
>  #include "qcom_q6v5.h"
>  
> +#define Q6V5_PANIC_DELAY_MS	200
> +
>  /**
>   * qcom_q6v5_prepare() - reinitialize the qcom_q6v5 context before start
>   * @q6v5:	reference to qcom_q6v5 context to be reinitialized
> @@ -162,6 +165,22 @@ int qcom_q6v5_request_stop(struct qcom_q6v5 *q6v5)
>  }
>  EXPORT_SYMBOL_GPL(qcom_q6v5_request_stop);
>  
> +/**
> + * qcom_q6v5_panic() - panic handler to invoke a stop on the remote
> + * @q6v5:	reference to qcom_q6v5 context
> + *
> + * Set the stop bit and sleep in order to allow the remote processor to flush
> + * its caches etc for post mortem debugging.
> + */
> +void qcom_q6v5_panic(struct qcom_q6v5 *q6v5)
> +{
> +	qcom_smem_state_update_bits(q6v5->state,
> +				    BIT(q6v5->stop_bit), BIT(q6v5->stop_bit));
> +
> +	mdelay(Q6V5_PANIC_DELAY_MS);

I really wonder if the delay should be part of the remoteproc core and
configurable via device tree.  Wanting the remote processor to flush its caches
is likely something other vendors will want when dealing with a kernel panic.
It would be nice to see if other people have an opinion on this topic.  If not
then we can keep the delay here and move it to the core if need be.

Thanks,
Mathieu

> +}
> +EXPORT_SYMBOL_GPL(qcom_q6v5_panic);
> +
>  /**
>   * qcom_q6v5_init() - initializer of the q6v5 common struct
>   * @q6v5:	handle to be initialized
> diff --git a/drivers/remoteproc/qcom_q6v5.h b/drivers/remoteproc/qcom_q6v5.h
> index 7ac92c1e0f49..c37e6fd063e4 100644
> --- a/drivers/remoteproc/qcom_q6v5.h
> +++ b/drivers/remoteproc/qcom_q6v5.h
> @@ -42,5 +42,6 @@ int qcom_q6v5_prepare(struct qcom_q6v5 *q6v5);
>  int qcom_q6v5_unprepare(struct qcom_q6v5 *q6v5);
>  int qcom_q6v5_request_stop(struct qcom_q6v5 *q6v5);
>  int qcom_q6v5_wait_for_start(struct qcom_q6v5 *q6v5, int timeout);
> +void qcom_q6v5_panic(struct qcom_q6v5 *q6v5);
>  
>  #endif
> -- 
> 2.24.0
> 
