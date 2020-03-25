Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073CAC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 04:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1C120714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 04:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TPqXq3uH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgCYEXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 00:23:01 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33406 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgCYEXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 00:23:01 -0400
Received: by mail-pf1-f193.google.com with SMTP id j1so443475pfe.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 21:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QPnMD9tlQfz+kYNVjKX+0BbvWV7yF+fxot/1nuirqCc=;
        b=TPqXq3uHr1WbFxIUHYMgl0ESfVkxf0unJLqC/SSONUpKLvbUMrenvUqx6gpV/52ZAa
         LcidMqP1UQEfE5YjI4FueaNbmcGRGdtKrV/yw18z1SYN0+wLQ8fiXRSZKq36+hLmj/p+
         LA3PHiJ+3PVOXVivFkvlEi4K4VvTpMJ1r/HPeAQXQNJF44eTxQ8bgH7pmtjPrgNd8tkt
         /eglxIj1FrmE/HfKAPGFfFEAS2HBtrX+fIimo/HU5l9n0Ayppiihk5YqoI50h4Nsp3Pl
         w+C+W0qUuI0WaZWLyuP10ECvC+58jkOY58W3JnlHULr4wdZmUIy+wEquAcCCU7+0Rpus
         3G9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QPnMD9tlQfz+kYNVjKX+0BbvWV7yF+fxot/1nuirqCc=;
        b=lii63TSW0sUVGqtg9qoBXhL/stbtUTmac9D6btuZUT/rOhru0TtwAd3h3qYREJnumX
         jLKPqiwL4bJ+LeuHG6jfzg3b9Zti7OaVHS5VctjDZWqDWs+cwHKKuBnhBv4lChifAomO
         kpcXKeefNiXhZg1s0IyQoYyQjN5FLIWhW11UePD7WITvtuj8XH56iU+DCFPqvccsblXD
         jOeSdlejj/75ArBDT2HEBgMv2J6cz6aMzQEbJ4SFlFSaMEqVf/j4Kqbmo627zZaygPgn
         IO7xX0ks36htD0OngHw6db5cqTSeRi4GluPh4Zaco/HQHxWVN5BGLeun3kKgCNbiNlHg
         AEgA==
X-Gm-Message-State: ANhLgQ3yEn7Ha/N/fVNJIPYTU+Pkw8Lb0hoNpaduCUCJjqUzfU7piN/q
        6A/Pw+ioGpeYrKy0Du/WCDBgIa6Yn/s=
X-Google-Smtp-Source: ADFU+vtBC6QHzRhi+QfdP6bG4wS8yA3XH3xkImuWvEfTUDp0JMlzuV67YTsbrPh6XnruvKmdL3RG/A==
X-Received: by 2002:aa7:850f:: with SMTP id v15mr1276859pfn.119.1585110180316;
        Tue, 24 Mar 2020 21:23:00 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i197sm17689386pfe.137.2020.03.24.21.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 21:22:59 -0700 (PDT)
Date:   Tue, 24 Mar 2020 21:22:57 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-remoteproc-owner@vger.kernel.org,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        psodagud@codeaurora.org, tsoni@codeaurora.org,
        sidgup@codeaurora.org
Subject: Re: [PATCH 2/2] remoteproc: core: Register the character device
 interface
Message-ID: <20200325042257.GF522435@yoga>
References: <1584747377-14824-1-git-send-email-rishabhb@codeaurora.org>
 <1584747377-14824-3-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584747377-14824-3-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 20 Mar 16:36 PDT 2020, Rishabh Bhatnagar wrote:

> Add the character device during rproc_add. This would create
> a character device node at /dev/subsys_<rproc_name>. Userspace
> applications can interact with the remote processor using this
> interface rather than using sysfs node. To distinguish between
> different remote processor nodes the device name has been changed
> to include the rproc name appended to "subsys_" string.
> 
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  drivers/remoteproc/remoteproc_core.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 097f33e..48a3932 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1907,6 +1907,12 @@ int rproc_add(struct rproc *rproc)
>  	struct device *dev = &rproc->dev;
>  	int ret;
>  
> +	ret = rproc_char_device_add(rproc);
> +	if (ret) {
> +		pr_err("error while adding character device\n");
> +		return ret;
> +	}
> +
>  	ret = device_add(dev);
>  	if (ret < 0)
>  		return ret;
> @@ -2044,7 +2050,7 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>  		return NULL;
>  	}
>  
> -	dev_set_name(&rproc->dev, "remoteproc%d", rproc->index);
> +	dev_set_name(&rproc->dev, "subsys_%s", rproc->name);

Afaict there's no guarantee that rproc->name is unique and I wonder if
this will break any userspace expectations. Please repost this to
remoteproc@ so we can get further input on this.

And if we can do this, I would like it to be "rproc-%s".

Regards,
Bjorn

>  
>  	atomic_set(&rproc->power, 0);
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
