Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852EDC47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D26A208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wjhas/C5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbgEFRFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 13:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729414AbgEFRFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 13:05:35 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E52CC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 10:05:34 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s20so751886plp.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 10:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DMnyBszh3UeqCW7qnMo/FE+1JsfaybooXYVovwSgOU0=;
        b=wjhas/C5XrWq/GRzJ4L46JpN7TUl0HXRUyZEsSzcWYeqGm9ZWRwPt0cEIEw0dCoSdb
         Iw0vL4CDm9Epsb/REyfTG9hBsoSsTZKoEQyF69k4zEFXVBGhIid6m/jF5dgZYRAAWSI/
         C5R39aUHUdZIbMP33F9OlS6WodCxw1qsn2vPWDvmDY8FIwxBqRUuIZpYMrUzS3W9oON4
         qM8qoDs5UKsVV4xib4qu8XVUgue+qyZFoBKZV0WTvxnACEMi+AxAaZfN36t2ZXjiN7R7
         iGqwNP0ZfXeq/S52cO2caUXfiPCWnuisC0/nydPMT6OHOufwNh4qUVvnyeC8+3wyt1Vl
         HR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DMnyBszh3UeqCW7qnMo/FE+1JsfaybooXYVovwSgOU0=;
        b=MEockjP5Jo3/w9/GP+r+K6J6+2yngJYNhMQhWBLjsKm1DrbgGoERMO0T+o6eC0gyIs
         Rm/nM7E36ljb6i1a4aZXtdRjQUCRuVNxbuX31bSxDZH16YwFQTU8Ka8IpiYg8wHKB+Yn
         zs22kQYp5IXwwpNh8+D4OaGNpUiCRVsm/OTY731sbOnJcfmAY2kWGAclGcC2zgDFyvLp
         rUtOVfAMc2XMkCSxOBnaMk8vJGo2AaVOVMP0Ev8WggG2oTuu06IY7lDp7NDwLq3JUK+i
         7emeWZRhzDSdsp/p0d98br7kUGQsZBEb35ZD/NKjaYo9iOJZm818KB7UvvgJ5iBfLlDP
         j2pw==
X-Gm-Message-State: AGi0PuamtbRv2C+lO1LPvx2Y9+Puley+VEC7NExln3L+WHSiO6zdEjfD
        OxqE1sIgES12fFVq38TkyZFa9A==
X-Google-Smtp-Source: APiQypLaGLS3vKtId9+ilSozvR3yu0yraasLg/PIEDtyzoGmdghVp91NdTtLccqpn1wRpqWJCOhiPg==
X-Received: by 2002:a17:902:23:: with SMTP id 32mr9150743pla.40.1588784733779;
        Wed, 06 May 2020 10:05:33 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b16sm2312057pfp.89.2020.05.06.10.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 10:05:33 -0700 (PDT)
Date:   Wed, 6 May 2020 11:05:31 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Calvin Johnson <calvin.johnson@oss.nxp.com>
Cc:     Mike Leach <mike.leach@linaro.org>, linux.cj@gmail.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coresight: cti: remove incorrect NULL return check
Message-ID: <20200506170531.GA29826@xps15>
References: <20200505134020.11148-1-calvin.johnson@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505134020.11148-1-calvin.johnson@oss.nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 07:10:20PM +0530, Calvin Johnson wrote:
> fwnode_find_reference() doesn't return NULL and hence that check
> should be avoided.
> 
> Signed-off-by: Calvin Johnson <calvin.johnson@oss.nxp.com>
> ---
> 
>  drivers/hwtracing/coresight/coresight-cti-platform.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-cti-platform.c b/drivers/hwtracing/coresight/coresight-cti-platform.c
> index b44d83142b62..2fdaeec80ee5 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-platform.c
> @@ -120,7 +120,7 @@ static int cti_plat_create_v8_etm_connection(struct device *dev,
>  
>  	/* Can optionally have an etm node - return if not  */
>  	cs_fwnode = fwnode_find_reference(root_fwnode, CTI_DT_CSDEV_ASSOC, 0);
> -	if (IS_ERR_OR_NULL(cs_fwnode))
> +	if (IS_ERR(cs_fwnode))
>  		return 0;
>  
>  	/* allocate memory */
> @@ -393,7 +393,7 @@ static int cti_plat_create_connection(struct device *dev,
>  		/* associated device ? */
>  		cs_fwnode = fwnode_find_reference(fwnode,
>  						  CTI_DT_CSDEV_ASSOC, 0);
> -		if (!IS_ERR_OR_NULL(cs_fwnode)) {
> +		if (!IS_ERR(cs_fwnode)) {
>  			assoc_name = cti_plat_get_csdev_or_node_name(cs_fwnode,
>  								     &csdev);

You are correct.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Greg, can you pick this up as a fix for 5.7?

Thanks,
Mathieu

>  			fwnode_handle_put(cs_fwnode);
> -- 
> 2.17.1
> 
