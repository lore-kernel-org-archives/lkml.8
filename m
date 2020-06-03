Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B73EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07E32206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591199565;
	bh=Drdk2sd8JFbAOSZWh/sR7A/84L9suUYd/Vah3hOLXlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cqdA9Ndhfll7NYYCsbmW8PVH4kO1imu8ioLcrO3IPhG4jObO7Ve8I7hthtA0HEGIs
	 c4u5z27lqQ02foHqSAbzAEFDZDg8RLfZxjKJ7oyI85fos3CAn3Iv9CQHVx+gZTtvVH
	 aHeNFFhcob7tRt5yYpUnw4SAtoouPh3vL3KSRVZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgFCPwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 11:52:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50774 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgFCPwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 11:52:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so2434406wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 08:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GshwwJK66k7h/1UU+52GCjHZuAKqpljzNfx76xeZPt4=;
        b=nl8dhKS4SaVRa9vcLq60bqwiJW9eB+axX36Jal7vfYHKsBeD/1+HLbKF45OzCUUvHl
         kLkpkg8ZGydHkFcSiHSIjUzQD2w2Upk4IDAudN4G3Ljozz56tRxVVAgrtatQCGqfIo93
         r+8+7+LRr23KjG5j1MraDoVAyinYcz3J0T9QXmSFoGP20wn7mTyIfIYqYJo0BHJDbiS2
         V9NBJai5my2gc1Yv8oULXfHcZNqq4/pAzTjAw7E9r7rBiEpqoiVE8mhzCFF8I2Ue8Hel
         j3K2maFbL4xjOMX+kMZ4a3KYlPZ90hfvQUhV8ZVsql4qhsaP6TrgooHUu03/c/gSca+q
         OowQ==
X-Gm-Message-State: AOAM533/k/leKWgv6t5uK8H0MFq2LRYPL61wS3oBz/oyG8awGzmK4ztj
        AZbfhAU08Lb1sL8O7GQOpV0=
X-Google-Smtp-Source: ABdhPJy45eTUcvKlAMQ1mw383qBdgAbYNBqftkPcf5LN6qB0nnXU+RkkQ6r2u0ExFdKJmaCb6WDfng==
X-Received: by 2002:a7b:cd10:: with SMTP id f16mr9537000wmj.149.1591199531131;
        Wed, 03 Jun 2020 08:52:11 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id q4sm3439264wma.47.2020.06.03.08.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 08:52:10 -0700 (PDT)
Date:   Wed, 3 Jun 2020 15:52:08 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Paul Durrant <paul@xen.org>, Wei Liu <wei.liu@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xen-netback: use kstrdup() in connect_data_rings()
Message-ID: <20200603155208.qmko4nd5on76k7c4@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
References: <20200603152643.18215-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603152643.18215-1-efremov@linux.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 06:26:43PM +0300, Denis Efremov wrote:
> Use kstrdup() instead of opencoded alloc and copy. kzalloc() is
> excessive here.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>

Acked-by: Wei Liu <wei.liu@kernel.org>

> ---
>  drivers/net/xen-netback/xenbus.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/xen-netback/xenbus.c b/drivers/net/xen-netback/xenbus.c
> index 286054b60d47..69352154a51b 100644
> --- a/drivers/net/xen-netback/xenbus.c
> +++ b/drivers/net/xen-netback/xenbus.c
> @@ -839,13 +839,12 @@ static int connect_data_rings(struct backend_info *be,
>  	 * queue-N.
>  	 */
>  	if (num_queues == 1) {
> -		xspath = kzalloc(strlen(dev->otherend) + 1, GFP_KERNEL);
> +		xspath = kstrdup(dev->otherend, GFP_KERNEL);
>  		if (!xspath) {
>  			xenbus_dev_fatal(dev, -ENOMEM,
>  					 "reading ring references");
>  			return -ENOMEM;
>  		}
> -		strcpy(xspath, dev->otherend);
>  	} else {
>  		xspathsize = strlen(dev->otherend) + xenstore_path_ext_size;
>  		xspath = kzalloc(xspathsize, GFP_KERNEL);
> -- 
> 2.26.2
> 
