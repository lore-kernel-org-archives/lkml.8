Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD65C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C0A5215A4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589381630;
	bh=Y+15Wb1ADlkDykUOMk8PX66JnRMcrjLokRUoR5c4j8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QXgDnca8CEwneis0vLJPPovfr2Qr7ttMqCb7DueJ7HyPeZSBI0V27hMh76csSfl0p
	 og1gW6kT4wix99KA0FsPV3mnvGlZml8Xixc/t1U9xxsbAEM78w1uAdZnzRqfwI51vD
	 ssgVVDWgip7CSplroWeLoPUmXPCMYlWIn8ZNLmS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389066AbgEMOxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 10:53:49 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43789 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388806AbgEMOxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 10:53:49 -0400
Received: by mail-lf1-f65.google.com with SMTP id 188so13859487lfa.10;
        Wed, 13 May 2020 07:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dMfZtgSmJt2YeZH8HP+NYczXoMyMD+NpZTNn0Kwfj9M=;
        b=duXayi+ajaLOcWtdBQ9lT98L/HZAt9I0dwTmcCqNT8FBrGkXSeg22kfzI+kmAsWx1Q
         0x9lM9MdWfZWHT3HIjxlg7ZaP0IWAvuEGgzwxDrkQwAkhZDcAdAIYnRELOZJy8Xsp71F
         lVA1+D6fRC5LDPJsIz3p9IpZl61Q06tnOQ8JJAWG3n4g6SGyfcN6hjxLYKdDbkTycx8u
         ozCQmsJyJNb3MPNbHYdL4ScCnrgd7Oa3D20dA38csyX9eNJJojyjCkfwb0JmAS1ZM1DY
         hG+E/SN+pJVQ8R7SR7I0xS3CWpF8bMdpPtxZwjUT0CXezQQGU4wu4bzzja775z19bUhf
         z2/g==
X-Gm-Message-State: AOAM531xR0qyVQVX9aJSjtHFQSiNJ/bnFfmsczUjVKaTQW/6IW6WPz1e
        H2TooDuIJ+GAxqsiZB7UR/Q=
X-Google-Smtp-Source: ABdhPJzLV4IdUL3+WTqLFvq/5fTkyBAl7VAlYYB9kNzGqjzzImQNNj5w/VBFFsEZf6kOUF2pIK16xA==
X-Received: by 2002:ac2:5290:: with SMTP id q16mr18122420lfm.108.1589381626330;
        Wed, 13 May 2020 07:53:46 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id k24sm1673815ljg.92.2020.05.13.07.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 07:53:45 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1jYslX-0001q6-H5; Wed, 13 May 2020 16:53:47 +0200
Date:   Wed, 13 May 2020 16:53:47 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] gnss: sirf: fix error return code in sirf_probe()
Message-ID: <20200513145347.GX25962@localhost>
References: <20200507094252.13914-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507094252.13914-1-weiyongjun1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 09:42:52AM +0000, Wei Yongjun wrote:
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Fixes: d2efbbd18b1e ("gnss: add driver for sirfstar-based receivers")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/gnss/sirf.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
> index effed3a8d398..2ecb1d3e8eeb 100644
> --- a/drivers/gnss/sirf.c
> +++ b/drivers/gnss/sirf.c
> @@ -439,14 +439,18 @@ static int sirf_probe(struct serdev_device *serdev)
>  
>  	data->on_off = devm_gpiod_get_optional(dev, "sirf,onoff",
>  			GPIOD_OUT_LOW);
> -	if (IS_ERR(data->on_off))
> +	if (IS_ERR(data->on_off)) {
> +		ret = PTR_ERR(data->on_off);
>  		goto err_put_device;
> +	}
>  
>  	if (data->on_off) {
>  		data->wakeup = devm_gpiod_get_optional(dev, "sirf,wakeup",
>  				GPIOD_IN);
> -		if (IS_ERR(data->wakeup))
> +		if (IS_ERR(data->wakeup)) {
> +			ret = PTR_ERR(data->wakeup);
>  			goto err_put_device;
> +		}
>  
>  		ret = regulator_enable(data->vcc);
>  		if (ret)

Good catch! Now applied with a stable tag as this would lead to a
use-after-free on driver unbind.

Johan
