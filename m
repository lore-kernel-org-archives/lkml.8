Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E70C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 21:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD39720784
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 21:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VWGmm5C1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbgDOVZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 17:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439054AbgDOVZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 17:25:08 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B9FC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 14:25:08 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id e4so4887095ils.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 14:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SQ9AyzhFiYqvvtESDF6F0EzOVpt9hS6Ddce9Gb2LBPc=;
        b=VWGmm5C1q0JZmldchVRjXfBs0T2i4oes8ZJ2qXN9/QihPNKnyERLQ6A7P8Ps0bYzM9
         TYoS137EQkI2pfP58Z0qfi7cNYvB5RowHgv7gNl/7nUKkqcDvJgwtFlYChNGM8QS0dzc
         aFCHbFMVJwYla1yAV8uvop+sXtBt1Vd8unMPBNSqGMkVPBhy/jdhoJLg0rLQq9LyjBTt
         C7uHh1P7HXh4bkTffZ+ItqN/q7MEAdQ+qfC6O8o7u00UHc1lDGOMTFm+bkeHaCly4yrs
         vgsiQTNeAHStd4YbhozxvpRVzZWebQYOUMz3ENiflkUns6GjbVEkdwGJbyCmt3tXNvZV
         ju7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SQ9AyzhFiYqvvtESDF6F0EzOVpt9hS6Ddce9Gb2LBPc=;
        b=cjbXKGcWKi+Ma8CU1g+eceBwYfDFEYtTjTRaP3VtaOAxy9Hk8/L64FQwOuxacmcuXx
         qI9+sPKryPCvWO6lByUcYgbGHk6Y1sIT+9ZXIxMqpJqTV253Kdl8w5BS2mXFFRLpm/PF
         R41nX3lkMLBILbErEAudYuVqW7NkdVCotHPgvVaa5+i9xwy4Axk2/31cZuhOx4jfiEJF
         LlCS8ShMlnzGU+DUi9AP/XLW2MvZ3XjIyWz1XXmx9JUMcP8Q6PSi22WEUyp6XycIpPaT
         toKUKkE6co7LHubxrTi9j2PjvGzfxdVDiYN8yhqNgCcx4Dddcaea1sc5m4oTus3ISlP/
         acmw==
X-Gm-Message-State: AGi0PuYDvWqHMGIlEhPgic0P5RYqG0AeverBlJvKaE4T5Ysfd1Layv5p
        VomYHhDwuelE4JqAKzlmYBjNMZML2WrUIQ==
X-Google-Smtp-Source: APiQypLwj6gyCdVoaGqwdR39OULfPjL2iRRe79O5/LDeaZGX4lqgvGHBCUFGzw8RkhzMCPZ5ei8Maw==
X-Received: by 2002:a05:6e02:c25:: with SMTP id q5mr6883454ilg.97.1586985907521;
        Wed, 15 Apr 2020 14:25:07 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id m14sm6579426ilr.16.2020.04.15.14.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 14:25:06 -0700 (PDT)
Subject: Re: [PATCH v2 4/7] remoteproc: Use kstrdup_const() rather than
 kstrup()
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     s-anna@ti.com, Markus.Elfring@web.de,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200415204858.2448-1-mathieu.poirier@linaro.org>
 <20200415204858.2448-5-mathieu.poirier@linaro.org>
From:   Alex Elder <elder@linaro.org>
Message-ID: <14b12ca8-823b-8115-bafa-281180e92c70@linaro.org>
Date:   Wed, 15 Apr 2020 16:25:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200415204858.2448-5-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/20 3:48 PM, Mathieu Poirier wrote:
> For cases where @firmware is declared "const char *", use function
> kstrdup_const() to avoid needlessly creating another copy on the
> heap.
> 
> Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  drivers/remoteproc/remoteproc_core.c | 4 ++--
>  include/linux/remoteproc.h           | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 9899467fa1cf..ebaff496ef81 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1982,7 +1982,7 @@ static const struct device_type rproc_type = {
>  static int rproc_alloc_firmware(struct rproc *rproc,
>  				const char *name, const char *firmware)
>  {
> -	char *p;
> +	const char *p;
>  
>  	if (!firmware)
>  		/*
> @@ -1991,7 +1991,7 @@ static int rproc_alloc_firmware(struct rproc *rproc,
>  		 */
>  		p = kasprintf(GFP_KERNEL, "rproc-%s-fw", name);
>  	else
> -		p = kstrdup(firmware, GFP_KERNEL);
> +		p = kstrdup_const(firmware, GFP_KERNEL);
>  
>  	if (!p)
>  		return -ENOMEM;
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 9c07d7958c53..38607107b7cb 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -489,7 +489,7 @@ struct rproc {
>  	struct list_head node;
>  	struct iommu_domain *domain;
>  	const char *name;
> -	char *firmware;
> +	const char *firmware;
>  	void *priv;
>  	struct rproc_ops *ops;
>  	struct device dev;
> 

