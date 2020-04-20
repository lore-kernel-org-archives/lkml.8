Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADEDC54FCC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 05:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81E62206B9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 05:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X9uJC3U0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgDTFIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 01:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgDTFIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 01:08:44 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F266C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 22:08:43 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 145so2124753pfw.13
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 22:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4gUGv+ZCjCcrhjTvHG5ziQUYSTyPzACEckQT7aiUK7k=;
        b=X9uJC3U03LE/E8rmZE0XuCdwZJbnRytUlAx9FrQwwlGkChycAzJN8WqWG4z1YnXDON
         HMR3olsD+KObwpvL3Ri4BeyPU+8+Va86Mh1IzL2BHOqQuHQ+ox/oD9EGct5J8okJHgXF
         Yk9IT6N7kp928eOfHBBRUYpCpF/y5XHqFzbOC4wYfklxvTs9uwJYDL5eIRl+31PgajXy
         bc3++07cJfyi8Hjvvkt9P9DH6uzJl+5azC6v9AsQToYrR1if8eslrf1IpUJZTOTzJ95n
         gXj9RiQ2mF83M5KDsr35ColP9WA5AQ1wcfboNiGNrD9Fv+Y0elgqq6JP79q5HpSHQ27g
         rYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4gUGv+ZCjCcrhjTvHG5ziQUYSTyPzACEckQT7aiUK7k=;
        b=QbH6KVDmhw35TALXx8IzD72KMoSaiYNIXn67zzi1zih/TsBduysVgd4s4R/1ccEqbj
         qVNcPB1T61PucTbkWVWUJZ9QfB9KI30yl4il41r4LWvsq+SgifChaVEI32muFm4W5kgk
         GYufs2mGjdFeW5ck6J/DUbbvxbzbb0zlZD/RIOdtSIJpqRjSyCiu0VhR/RjqI6c2H9zo
         0BfJZFpmBp/CQjglwunwNrGfQY9GKUs09i6dLlXM8f4ferf2WFFIHnkSSWP+17Zz5AJv
         FF66MZ0SarKUn3TMoQ3otJJBb++/Zh7XkDgD0TzSfNhcGh5OQCsT63TEqkHlKoIMcu2T
         9DHw==
X-Gm-Message-State: AGi0PubJuFiu1YfoZE8+bNTsnnxlz9QUTMl9xrqQZeNevD09TZgyVt3M
        F5K4l1xfWza/lhk5WqEBMuDYDg==
X-Google-Smtp-Source: APiQypLPG0FHjWMYWRILI1qc5uGuQ35TQc1UpGIeiqyVPUSa4LSrYFXt0NcBUUD3hgN4J6zA911MnA==
X-Received: by 2002:a65:57c3:: with SMTP id q3mr15658034pgr.106.1587359322426;
        Sun, 19 Apr 2020 22:08:42 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w125sm8752316pgw.22.2020.04.19.22.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 22:08:41 -0700 (PDT)
Date:   Sun, 19 Apr 2020 22:09:04 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     ohad@wizery.com, s-anna@ti.com, elder@linaro.org,
        Markus.Elfring@web.de, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] remoteproc: Split firmware name allocation from
 rproc_alloc()
Message-ID: <20200420050904.GC1516868@builder.lan>
References: <20200415204858.2448-1-mathieu.poirier@linaro.org>
 <20200415204858.2448-3-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415204858.2448-3-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15 Apr 13:48 PDT 2020, Mathieu Poirier wrote:

> Make the firmware name allocation a function on its own in an
> effort to cleanup function rproc_alloc().
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

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
> -- 
> 2.20.1
> 
