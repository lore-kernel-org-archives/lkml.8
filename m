Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16086C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E91EC20731
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fhx/J80D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387528AbgDMR7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387519AbgDMR7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 13:59:18 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3D6C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 10:59:18 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id v23so4857669pfm.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 10:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RzcS9dRjplQeBWpxQLCXEXIw7gitZm1gAW9ZRZ00JbM=;
        b=Fhx/J80DpVsmu+cLUqjdPvmyDwYoktkYfDZhsVCejMCrmvXSQYuN7q8RGV+/7FJTSe
         gxwHjIBkE523cnzRzXNRG+vlC7YTx94UEN92lZ5uGaiq79mzJZZ4OWqoIRA5528eEicC
         Oy4mfHD1Lyl/ve65vY9KultzKvFwUwGqw7Ugka5chw485gmoZY0NpkwljOGbiMuYq6C+
         wEUGe0U0SMjku1d1aPq7Mx9xoguMM96PnmkiERyOC4UVkG58aFCw9wW93fhJaxS0Ko7y
         Ssl2SHPS90PVKzLedehqy0QS53VnlbU1dQKNJCkZt9i3l/znPWvXcjWQPqy7Lx36yrGl
         K4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RzcS9dRjplQeBWpxQLCXEXIw7gitZm1gAW9ZRZ00JbM=;
        b=VCp00XIX+D4R6z5jvGmh+1XhvqedHgf+vTSSoawhHwVK0NZY5UXfjiV+vnnWKLFrCq
         SjDTON728KB8cC+27uR2xoWeAWxPO15HJbniONa9pKUQCu8iMv5GyZLizb3bdJ/ucjyM
         Do/ugd6bdSWh0jb026y9GQ04GP94eObOsNFwDxoRdjefMPoTic033o+eNjprTt/oQZwo
         pkVtAT5sZnI/qdR5+glD1Rlri7W7xDKSoTwTYp2eiUWwL/7eLfIfDn6x1a7UvFpP3jhM
         XCmSHM1nQRD+6K3HProf0EVbW1qheLCZfx7OYQtRfwh6C/lOlxDi9sDS060oBrL3tv7D
         AC7g==
X-Gm-Message-State: AGi0PubYbxFGjN/wfMXrJ8NPrzZ0RgQle5Mxa5ikgOIYEJCsfzdV7nBv
        9nxk4jm9Tn+RSe7X+l1Y+yADXA==
X-Google-Smtp-Source: APiQypJqwg/RDqB4fxKPMLKyDOESIeZ68eCl9+qIGJMwBOEmADpmfodFX3xhci9FLB6X0hLQj/YpGw==
X-Received: by 2002:a62:1552:: with SMTP id 79mr18771642pfv.215.1586800757596;
        Mon, 13 Apr 2020 10:59:17 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id s22sm9544676pfh.18.2020.04.13.10.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 10:59:17 -0700 (PDT)
Date:   Mon, 13 Apr 2020 11:59:15 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     suzuki.poulose@arm.com, mike.leach@linaro.org,
        alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] coresight: etb10: make coresight_etb_groups static
Message-ID: <20200413175915.GF28804@xps15>
References: <20200413082237.23177-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413082237.23177-1-yanaijie@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 04:22:37PM +0800, Jason Yan wrote:
> Fix the following sparse warning:
> 
> drivers/hwtracing/coresight/coresight-etb10.c:720:30: warning: symbol
> 'coresight_etb_groups' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/hwtracing/coresight/coresight-etb10.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index 3810290e6d07..03e3f2590191 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -717,7 +717,7 @@ static const struct attribute_group coresight_etb_mgmt_group = {
>  	.name = "mgmt",
>  };
>  
> -const struct attribute_group *coresight_etb_groups[] = {
> +static const struct attribute_group *coresight_etb_groups[] = {
>  	&coresight_etb_group,
>  	&coresight_etb_mgmt_group,
>  	NULL,

Applied - thanks,
Mathieu

> -- 
> 2.21.1
> 
