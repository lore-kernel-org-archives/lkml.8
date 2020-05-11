Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE4EC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C28D620722
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LWKWl4hJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbgEKQqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 12:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgEKQqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 12:46:50 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D48FC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 09:46:50 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f6so4813703pgm.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 09:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jzFl153wKEGiW6thuE8cqwaVsp6YPUfR1GodlHQ+GfQ=;
        b=LWKWl4hJ/KeNQWI2yPjgG/p82FYw92ZmKSo6jRP99e8Pr0YN2m956c6tPnU/2qa0hh
         fIgeSNjibDcP+mCbfqimxcgq9XPJv3IuwDhWzMaGzLp/OtrfMcxs5SIj/o6UuzkczJbn
         Ic/GlIy7azb65C7ZKUbqpzfwYIwRrTI2gfi1uejtnksutrbG4zIRYwjbSMvJoUuTtK3F
         Uyeb7mKuJC1L3qy/7LgapTP7F2PRAtCcRk7rpkNDSaLwG6q32QJeSreFlgAt5JeNWtcW
         Q454WjF6vxajisP6dFsYEUqEWpdARz3tr0XTWtKML5Js45/QI+394RULlFYonfsF2rVK
         H0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jzFl153wKEGiW6thuE8cqwaVsp6YPUfR1GodlHQ+GfQ=;
        b=siqaZuU69c7Q3aVvfoX1/FG6bUT5ONuC0ACnFgC0kOP0biJHGrOYe6E7XAOtEcEgnR
         b2MTvSOy3hq7UdKaJN3Qi7zrZ99xwB23PrdLuHjUj8oC6naBw713asVPcYAWl3CQ1JuI
         BGwhE7r/kFRPXFM+q5vJqjGER6AtnZ1rTmMiOe0fhXbKOXxNBzoLt9tLBtjJSi3UFlVk
         9hvqdf3U1+pCckahdL/Eh4mMLwjkUJmRhb5RSTSceN48i4kc4yYHv9Z9YoJU4E7SHvt2
         Cs1PBCQj2sLqkaObimEWibhAPF3FselVoXUoNTR2XjHsKE3pclVWz0w+oGmUj8sUMxCc
         MYLg==
X-Gm-Message-State: AGi0PuZjGfULsKYgHQMrzok6psIzJOhy3xLjAF4JWtB8IWN2pflzOc7i
        Y7vvuQWylpaO4LCIQwkpXtabh6Nxc+Q=
X-Google-Smtp-Source: APiQypKvls9a7p/jOLFrW4kvUprsP8vRtSo5EZqIM4JrTwpFR+XkcaG0Xvs1xzsYgRLaFcuJIwM9vA==
X-Received: by 2002:a63:f958:: with SMTP id q24mr15161215pgk.338.1589215609812;
        Mon, 11 May 2020 09:46:49 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id n16sm9604203pfq.61.2020.05.11.09.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 09:46:49 -0700 (PDT)
Date:   Mon, 11 May 2020 10:46:47 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH] coresight: tmc: mark coresight_tmc_groups with static
Message-ID: <20200511164647.GA13202@xps15>
References: <20200508091340.11711-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508091340.11711-1-zhang.lyra@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chunyan,

On Fri, May 08, 2020 at 05:13:40PM +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> Sparse reports a warning like:
> drivers/hwtracing/coresight/coresight-tmc.c:364:30: warning: symbol
> 'coresight_tmc_groups' was not declared. Should it be static? [sparse]
> 
> coresight_tmc_groups is used in the local file only, so it should be
> marked with static.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  drivers/hwtracing/coresight/coresight-tmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
> index 1cf82fa..39fba1d 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
> @@ -361,7 +361,7 @@ static ssize_t buffer_size_store(struct device *dev,
>  	.name = "mgmt",
>  };
>  
> -const struct attribute_group *coresight_tmc_groups[] = {
> +static const struct attribute_group *coresight_tmc_groups[] = {

This has already been addressed by Stephen [1] earlier in this cycle.  It is
currently in linux-next and will be submitted for inclusion in the next cycle.

Thanks,
Mathieu

[1]. https://www.spinics.net/lists/arm-kernel/msg801714.html

>  	&coresight_tmc_group,
>  	&coresight_tmc_mgmt_group,
>  	NULL,
> -- 
> 1.9.1
> 
