Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B2DC433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 10:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 709B520767
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 10:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIftqY/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgICKJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 06:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgICKJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 06:09:16 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A80C061244;
        Thu,  3 Sep 2020 03:09:15 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k15so2519479wrn.10;
        Thu, 03 Sep 2020 03:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7ns1zVlmF+pwrGH9GOZCksJLi0dT9SO4rihgWhgyS68=;
        b=ZIftqY/cOwubsKafsp3NW2i/rOoNtGD2RFfTOSEM8SHZyTef5VCKOJOUZaczY0oV9q
         nqgYFXGgPwTXZvKjpzcWB4bdH3gFOj1gMkJoMF5uIXnot13uQH3e4nZWv9tvSRNOh83h
         6OJizdH/oW72cYRucpa5jxu6ysQiMn2rq7ApdMnMcQTFARhyQxrjt6VdZn4TuhZDttfY
         WGJyoITTTu0ILEjsItIEzEjAzMtwUr2kQEWxLM8uUyQ22Q55UReKnfM30ZBfElZBVNYr
         2Jowy0eiRgZSDLBEutYJa2c+sEL4g5+qFYuBI5xIhteHzq1/J6Nf56H+Ib4NsUhDhoXk
         MHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7ns1zVlmF+pwrGH9GOZCksJLi0dT9SO4rihgWhgyS68=;
        b=i5F8sce92/LtgiSaYx4pPwX5Jt0xDWazQ1uyvz4sXQUmq27xYE6G1H333rtXpsg1Tf
         5FTvFkee5scJvghAh1P7tYSU82KczkwGXgeZAZWLr8wqGP1Sa3L3fZR+w2LC5wj99vvw
         k541Htf6Bag88Nt98ALwxA4H4ip2HcjUcLO+o8A9W6j7bJ0zseaAAmHP8sP9w//N/5G8
         l4uQ4xxYFswblzrDwwV1pmeNeDNyj1wxpN/XXd7bHL6CGGjy5iDn3sU2qqDr13gaANZ+
         EFoCQN7OQpYmChWosc4sPxrahWZ9E9uwaJ2N0ecBptlGZqKucZ0l/hnaOV9tMX7jv2+7
         v3/Q==
X-Gm-Message-State: AOAM530bukb0mQYc8fo3Chr1+hVu2fB20gFXjSfUgsV0jRZ58T0HYma4
        ZxY4xIvEdMwg8aC3O6Jxu4A=
X-Google-Smtp-Source: ABdhPJz3K6K7Mh0RG8NoX33E1Z7xGzqMyQLSI0aRwAKMj2ItiAA+GRzRJtUu7nyxcAZQTy56yoJWEw==
X-Received: by 2002:adf:f042:: with SMTP id t2mr1529695wro.385.1599127754478;
        Thu, 03 Sep 2020 03:09:14 -0700 (PDT)
Received: from medion (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id v3sm3541805wmh.6.2020.09.03.03.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 03:09:14 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
X-Google-Original-From: Alex Dewar <alex.dewar@gmx.co.uk>
Date:   Thu, 3 Sep 2020 11:09:12 +0100
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: core: Free rvdev on error path
Message-ID: <20200903100912.6op2fs6olrtlckr2@medion>
References: <20200903100142.57117-1-alex.dewar90@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903100142.57117-1-alex.dewar90@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 11:01:42AM +0100, Alex Dewar wrote:
> In rpoc_handle_vdev(), rvdev is not freed properly on the error path and
> one of the labels is misnamed. Fix this up.

Actually, don't apply this. I didn't realise that device_unregister
already frees memory. Sorry for the noise!

> 
> Fixes: 086d08725d34 ("remoteproc: create vdev subdevice with specific dma memory pool")
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index d4bd71f87b03..84dea43d196e 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -531,7 +531,7 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
>  	rvdev->dev.parent = &rproc->dev;
>  	ret = dma_copy_dma_range_map(&rvdev->dev, rproc->dev.parent);
>  	if (ret)
> -		return ret;
> +		goto free_rvdev;
>  	rvdev->dev.release = rproc_rvdev_release;
>  	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);
>  	dev_set_drvdata(&rvdev->dev, rvdev);
> @@ -539,7 +539,7 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
>  	ret = device_register(&rvdev->dev);
>  	if (ret) {
>  		put_device(&rvdev->dev);
> -		return ret;
> +		goto free_rvdev;
>  	}
>  	/* Make device dma capable by inheriting from parent's capabilities */
>  	set_dma_ops(&rvdev->dev, get_dma_ops(rproc->dev.parent));
> @@ -556,7 +556,7 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
>  	for (i = 0; i < rsc->num_of_vrings; i++) {
>  		ret = rproc_parse_vring(rvdev, rsc, i);
>  		if (ret)
> -			goto free_rvdev;
> +			goto unregister_dev;
>  	}
>  
>  	/* remember the resource offset*/
> @@ -581,8 +581,10 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
>  unwind_vring_allocations:
>  	for (i--; i >= 0; i--)
>  		rproc_free_vring(&rvdev->vring[i]);
> -free_rvdev:
> +unregister_dev:
>  	device_unregister(&rvdev->dev);
> +free_rvdev:
> +	kfree(rvdev);
>  	return ret;
>  }
>  
> -- 
> 2.28.0
> 
