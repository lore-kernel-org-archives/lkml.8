Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAB8C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 21:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 143272076C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 21:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cXYrbCKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439059AbgDOV2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 17:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728816AbgDOV2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 17:28:38 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD53C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 14:28:38 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id d2so4934411ilc.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 14:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UwVYsw+/9wntwnNkO43D5rE9zcVpCs0V20drhRDxvm8=;
        b=cXYrbCKT6CTfVB78O7/jcpSyvLQiIcrHw1AFgDhjnYF+wFR6QWKtb/nJwlAZdaUgJ/
         b7uzlleFP76zI1QuhUH+xnVFkdZhW6Xckgi5PmdmSqkspGxlwrarPM6e68CMaQzekJ/r
         sLURFKVsWJ8/qe0S83hrUUVLKyZwvfho9pWhYma+isi9MbzthcWkLVIFsKC9wCbUGQSf
         pGh1TChEEbcOnjS4WFDDLJs0qKX0dFA5VdWpDx7Wk51AbsWRthwUfGGFgQZRPezWVxcp
         yn+rYKeb3XZu1oZjzUVUYbQpHGGbdA0WT/ws8ChyAMfUKLJmsfFFKlx7ygOA4NujTI8r
         V5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UwVYsw+/9wntwnNkO43D5rE9zcVpCs0V20drhRDxvm8=;
        b=qjII+9Vsdz6Wk2RLdkB7yuJ/c2U/NchITOS6CDzcfo0rhVyNsHIJiVsYy8mpDOmZG1
         PMYnoiGOeVx/R6NWtw62HnQDFZJPKznAreEuQcNJwwvAw0H95egetJ+CPXOystvSaKET
         pyoNUUFN0r4hbPvAr4pCCo9YJywzMC743OXsZ9QWs1O1lkX/9DP0X1k+xNYftHmnDUrP
         ayex3W2OX/779Xexp6N+yV2fWmE8tITulhoAUoUyvsJtMYaabS9QOx9xaXJTvgBXCL3T
         rzwW//oNbHgTlwDPGOgRAuGtfqdoikRjHJIhV6EYhKjyZ7269P8k5s+a4W61IozD4Vm7
         T8fA==
X-Gm-Message-State: AGi0PuYg+yTNvSS8JzpGoy73g5Kgu6QUyCidHyh+PBejqJba2NT83a7k
        UPy0z7bIBLdETj6VmoBtv5r+dWoDYoH1ew==
X-Google-Smtp-Source: APiQypIK444+4daNnIVCjstCJp/GiSJFNM0TGZtDDsoGvkJwDsl4V1+F4MPJvnbelBQx8RkcbSRWZw==
X-Received: by 2002:a92:ba99:: with SMTP id t25mr7762637ill.84.1586986117682;
        Wed, 15 Apr 2020 14:28:37 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id b12sm5683137ioj.50.2020.04.15.14.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 14:28:37 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] remoteproc: Split firmware name allocation from
 rproc_alloc()
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     s-anna@ti.com, Markus.Elfring@web.de,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200415204858.2448-1-mathieu.poirier@linaro.org>
 <20200415204858.2448-3-mathieu.poirier@linaro.org>
From:   Alex Elder <elder@linaro.org>
Message-ID: <4d4d1a0c-abf2-8c2c-60fd-6f7072cd3d91@linaro.org>
Date:   Wed, 15 Apr 2020 16:28:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200415204858.2448-3-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/20 3:48 PM, Mathieu Poirier wrote:
> Make the firmware name allocation a function on its own in an
> effort to cleanup function rproc_alloc().
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  drivers/remoteproc/remoteproc_core.c | 66 ++++++++++++++++------------
>  1 file changed, 39 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 80056513ae71..4dee63f319ba 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1979,6 +1979,33 @@ static const struct device_type rproc_type = {
>  	.release	= rproc_type_release,
>  };
>  
> +static int rproc_alloc_firmware(struct rproc *rproc,
> +				const char *name, const char *firmware)
> +{
> +	char *p, *template = "rproc-%s-fw";
> +	int name_len;
> +
> +	if (!firmware) {
> +		/*
> +		 * If the caller didn't pass in a firmware name then
> +		 * construct a default name.
> +		 */
> +		name_len = strlen(name) + strlen(template) - 2 + 1;
> +		p = kmalloc(name_len, GFP_KERNEL);
> +		if (!p)
> +			return -ENOMEM;
> +		snprintf(p, name_len, template, name);
> +	} else {
> +		p = kstrdup(firmware, GFP_KERNEL);
> +		if (!p)
> +			return -ENOMEM;
> +	}
> +
> +	rproc->firmware = p;
> +
> +	return 0;
> +}
> +
>  /**
>   * rproc_alloc() - allocate a remote processor handle
>   * @dev: the underlying device
> @@ -2007,42 +2034,21 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>  			  const char *firmware, int len)
>  {
>  	struct rproc *rproc;
> -	char *p, *template = "rproc-%s-fw";
> -	int name_len;
>  
>  	if (!dev || !name || !ops)
>  		return NULL;
>  
> -	if (!firmware) {
> -		/*
> -		 * If the caller didn't pass in a firmware name then
> -		 * construct a default name.
> -		 */
> -		name_len = strlen(name) + strlen(template) - 2 + 1;
> -		p = kmalloc(name_len, GFP_KERNEL);
> -		if (!p)
> -			return NULL;
> -		snprintf(p, name_len, template, name);
> -	} else {
> -		p = kstrdup(firmware, GFP_KERNEL);
> -		if (!p)
> -			return NULL;
> -	}
> -
>  	rproc = kzalloc(sizeof(struct rproc) + len, GFP_KERNEL);
> -	if (!rproc) {
> -		kfree(p);
> +	if (!rproc)
>  		return NULL;
> -	}
> +
> +	if (rproc_alloc_firmware(rproc, name, firmware))
> +		goto free_rproc;
>  
>  	rproc->ops = kmemdup(ops, sizeof(*ops), GFP_KERNEL);
> -	if (!rproc->ops) {
> -		kfree(p);
> -		kfree(rproc);
> -		return NULL;
> -	}
> +	if (!rproc->ops)
> +		goto free_firmware;
>  
> -	rproc->firmware = p;
>  	rproc->name = name;
>  	rproc->priv = &rproc[1];
>  	rproc->auto_boot = true;
> @@ -2091,6 +2097,12 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>  	rproc->state = RPROC_OFFLINE;
>  
>  	return rproc;
> +
> +free_firmware:
> +	kfree(rproc->firmware);
> +free_rproc:
> +	kfree(rproc);
> +	return NULL;
>  }
>  EXPORT_SYMBOL(rproc_alloc);
>  
> 

