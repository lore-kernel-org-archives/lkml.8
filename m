Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2E0C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 07:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4577206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 07:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595662198;
	bh=hB6uVkjwCMK34TmzSaMhWlBKz+LwQTzt38V7rDwEM+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B6hG0r7hO+06/GhjOO0y/fG19sozmavd/sznu1K6acttNxvhwi1qqC8hKcTFFQfEi
	 KTZhj8191JCdFyamAl+luLm3QqWpEKKgNeN2o6Mbq/OsrWOCUo0YSWu9dt95e92OH6
	 QfwGtoMvxDoEJs2G+IdRFlieLkLEkEgHklLQUxeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGYH3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 03:29:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43789 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgGYH3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 03:29:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id f5so12160684ljj.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 00:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NFKiTLk4YQj4CQlqKNPWANcICm1Rabpmzh+rUQVs7dg=;
        b=nEEo4uaxJi655H9db3UXmorToxufcurQcrOvCzWNwDlNNs2hYk5YuFpB64D9ziKQxU
         v//qVfTi46CkbxuDCMYdqCsd2MJoY1+FdwPOhYheI72CD3Y3JaQWa9eIFTBgCXggrhNR
         49jgHYm7KqGRlfWWXhDojwcdVZftP961urzbwEeVY5VTiul4x7Q/0L4AYjg7X8YrXKZD
         qTdFOQDvhZvVhDcXfneNFVPfhb0GH0CUuuR1gLepIoWE+5qTYDmX14tNH1mitlgsSzn8
         /i5N2xQRqIMySYiLADMg7Pz1euRxuJD04JczveNmEajL7/6knQ4m/0+947xK+g0oJvAe
         s+7A==
X-Gm-Message-State: AOAM533mrjyQuynpZcFJ7xk6E0xyh4Cq7FPfeGQp4wPfYyrXGhRcP8C+
        Jby2Q7h7vNVe6LOo9luX894=
X-Google-Smtp-Source: ABdhPJzpoD92jn7emirtBlyhivTUkCCnZY+Bbfmlt2Mn/k6pRPDuIo0iv/HdUCEAwLL8BnvDkPy2LA==
X-Received: by 2002:a2e:864b:: with SMTP id i11mr5746421ljj.64.1595662185716;
        Sat, 25 Jul 2020 00:29:45 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id n29sm1158278lfi.9.2020.07.25.00.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 00:29:44 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jzEci-0008MI-7r; Sat, 25 Jul 2020 09:29:36 +0200
Date:   Sat, 25 Jul 2020 09:29:36 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Li Heng <liheng40@huawei.com>
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        viresh.kumar@linaro.org, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] svc: add missed destroy_workqueue when gb_svc_create
 fails
Message-ID: <20200725072936.GQ3634@localhost>
References: <1595646397-53868-1-git-send-email-liheng40@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595646397-53868-1-git-send-email-liheng40@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 11:06:37AM +0800, Li Heng wrote:
> destroy_workqueue() should be called to destroy svc->wq
> when gb_svc_create() init resources fails.
> 
> Fixes: 8465def499c7 ("staging: greybus: move the greybus core to drivers/greybus")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Li Heng <liheng40@huawei.com>
> ---
>  drivers/greybus/svc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/greybus/svc.c b/drivers/greybus/svc.c
> index ce7740e..38f858f 100644
> --- a/drivers/greybus/svc.c
> +++ b/drivers/greybus/svc.c
> @@ -1340,6 +1340,7 @@ struct gb_svc *gb_svc_create(struct gb_host_device *hd)
>  
>  err_put_device:
>  	put_device(&svc->dev);
> +	destroy_workqueue(svc->wq);

Your bot is broken; the workqueue is released in gb_svc_release(). 

And please fix your internal review process so that you catch things
like this before posting.

>  	return NULL;
>  }

Johan
