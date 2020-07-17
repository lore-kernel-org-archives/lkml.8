Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED683C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 05:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB9C12070A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 05:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JxLXtCib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgGQFvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 01:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgGQFvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 01:51:05 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCF1C08C5DC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 22:51:05 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o13so6174484pgf.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 22:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1PFs+emTCjBmpzEcvwWiAu9ISkdboKsamgKoarfvfso=;
        b=JxLXtCib/kxCaAeC1ZCQXAhXzOploS0tTxAWwsZf63bgYIK+5LqwpXU3j8CSOekg3e
         iCR3BCpMsCeq/XKL5vd2wM0XXAdpHPzwsCvMYvADBL3SYQrmVwNBJAViMncCUbbe6ek1
         hvtAM4MQEPxvnV02mDJ2w4JQx7OT0cFqSIubN1O+2odmatkGQAFuUxVyXUX/1okipHku
         dxKHU9PUSX1xZbJd/1IevMDV8zkpfNR0diEep+/+cXAWY/ndIvJ3rRg7+c9SbGh1TT/g
         4Zy14qehCwoAFillT5CkI1+ujy8KisWJ8HfOt2YO0k2r6RrFjIvpo3JUd/elfrwZfip/
         Mlpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1PFs+emTCjBmpzEcvwWiAu9ISkdboKsamgKoarfvfso=;
        b=hrGa5TG01t5ccKX7G2InuqI++TVIILefQ6/6g4Gp0vKoqQANe6IKxu5+veGHHisOXd
         5kNBpYLdGKn1HEckK+z6Xvz3xFNaqeEf5f2Mc6/ywkx7ak/q8ybxvuXF5Hvx3dO+ScRc
         3fPRRkHa5WjAQmiCdp6lRPK02H8G67E6ey25ANwD9tAk+slBV7WvUe24zGdKcAZfPFo2
         Tf+Fr3oai7lNPA8QTushU+ib1WWhxXOZ4Adbi6vg/NoiCdbwBy3pkidFCjJJ5+GV1/TJ
         vFNBJ0+a/N7l/8V5b5zZENE4f5vpL0Sdh7k/TF3skJ4UQqBkFRThya6LnY10RHGnVTNP
         /t7A==
X-Gm-Message-State: AOAM530JeO/SAsV6E/xIGh7C7tJ4x76eC0x05p3nA7xLhlENDUopRxww
        9KyQpLnRi7XtZ76bmYbWx28utQ==
X-Google-Smtp-Source: ABdhPJyg+5P3lnqItgVBbtEe0CH0gQWoQmMy9NmahOYi/S+3X7KKcvFRiGQwqRWQDPAbhkr54NZ3Aw==
X-Received: by 2002:a63:a558:: with SMTP id r24mr7568200pgu.70.1594965064988;
        Thu, 16 Jul 2020 22:51:04 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b128sm6443836pfg.114.2020.07.16.22.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 22:51:04 -0700 (PDT)
Date:   Thu, 16 Jul 2020 22:49:02 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Siddharth Gupta <sidgup@codeaurora.org>
Cc:     agross@kernel.org, ohad@wizery.com, corbet@lwn.net,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, rishabhb@codeaurora.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 2/2] remoteproc: core: Register the character device
 interface
Message-ID: <20200717054902.GJ2922385@builder.lan>
References: <1594148870-27276-1-git-send-email-sidgup@codeaurora.org>
 <1594148870-27276-3-git-send-email-sidgup@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594148870-27276-3-git-send-email-sidgup@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07 Jul 12:07 PDT 2020, Siddharth Gupta wrote:

> Add the character device during rproc_add. This would create
> a character device node at /dev/remoteproc<index>. Userspace
> applications can interact with the remote processor using this
> interface.
> 
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
> ---
>  drivers/remoteproc/remoteproc_core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 0f95e02..ec7fb49 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1966,6 +1966,13 @@ int rproc_add(struct rproc *rproc)
>  	struct device *dev = &rproc->dev;
>  	int ret;
>  
> +	/* add char device for this remoteproc */
> +	ret = rproc_char_device_add(rproc);
> +	if (ret) {
> +		dev_err(dev, "Failed to add char dev for %s\n", rproc->name);

Please move this error message into rproc_char_device_add(), to make it
consistent with the other error handling in this function not printing.

Apart from that it looks good.

Regards,
Bjorn

> +		return ret;
> +	}
> +
>  	ret = device_add(dev);
>  	if (ret < 0)
>  		return ret;
> @@ -2241,6 +2248,7 @@ int rproc_del(struct rproc *rproc)
>  	mutex_unlock(&rproc->lock);
>  
>  	rproc_delete_debug_dir(rproc);
> +	rproc_char_device_remove(rproc);
>  
>  	/* the rproc is downref'ed as soon as it's removed from the klist */
>  	mutex_lock(&rproc_list_mutex);
> @@ -2409,6 +2417,7 @@ static int __init remoteproc_init(void)
>  {
>  	rproc_init_sysfs();
>  	rproc_init_debugfs();
> +	rproc_init_cdev();
>  	rproc_init_panic();
>  
>  	return 0;
> @@ -2420,6 +2429,7 @@ static void __exit remoteproc_exit(void)
>  	ida_destroy(&rproc_dev_index);
>  
>  	rproc_exit_panic();
> +	rproc_exit_cdev();
>  	rproc_exit_debugfs();
>  	rproc_exit_sysfs();
>  }
> -- 
> Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
