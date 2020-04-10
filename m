Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AF6C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 09:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D242084D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 09:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="lgJpULrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgDJJhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 05:37:01 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38642 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgDJJhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 05:37:01 -0400
Received: by mail-lf1-f65.google.com with SMTP id l11so962445lfc.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 02:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=exkqUjBnwAnJKQjQDn5TTL2pNxP0x0Ucz4ZEQEg/hEg=;
        b=lgJpULrKJ6u0MBT6ETzC4LiBEhCZXXocwkaDpsNGyo+5DkK/1JJ3+dBXaGC75FVsov
         bH+k6fpG+BLwP0tcO0pyfY3vH+sGMIfLvBCbC9OD2r5O+oN8hKfshtHylLi4mpnOwi6C
         hJ66MH7utQ1iIsSbMh6ILLq0zOCC0+d4WSktropS7gTaBzyOI6QTTw1x0zpq7rEzneCW
         IPmNcigCV9clxXSwgQ7cexhTSUl2yyjReBPfsstRpBt9BN5y9SgAKdGgrmcrsnatkiMP
         7qLFkYb2K2u3Vr6hY7CFZi+dHAFgfnd8RpHAtF/paP9L52ILXLLHY09AS5+Zo5e37lxW
         ePUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=exkqUjBnwAnJKQjQDn5TTL2pNxP0x0Ucz4ZEQEg/hEg=;
        b=hg8f8+FdpA2J+zrTDh/XWnqpXLPPKZyqiOiJsF1KmhgQRhyj2BoQy2PeVYuj4NJ9mh
         kqkXWTYvUgNd4FoskhG+g58fjoTBBah8eTFqWFMob1ghvjVVmJwvRUFvdd5M/kmgqtvV
         1K6duEZ1fjkIANIy9+9n2cc9WcpXDO4Qb4r/5SKZMjZm6sucyCQS4zqzGVr5Pzre6NDS
         M2WjtR+ghAiTzUU7QdtmOyf+MWH8+PpiFWrh6eoAJ8FJfWVcGuj9LHetG1sfBWo0Difs
         mDluV8orf2sbJnyiidShRkAFZYhhFfWqI6wHKMFI9TkHynupQPtUkwzHdi/DcecS03jd
         xnPQ==
X-Gm-Message-State: AGi0PuZ8uCCUh2QMxwWP2POOr9gmLjSaVLvi4+hr6EVgblx2iXmX0CJP
        8+h5DCcZ1U9jdIKlq6WbZ1GH5w==
X-Google-Smtp-Source: APiQypIMcfl4zC6vz1w5b1PCJyqjTtBx2aRTNE1jqnlOUglSVyui2mwUKgIsqdT82ZXwaL+19jwFPw==
X-Received: by 2002:ac2:4a9d:: with SMTP id l29mr2065861lfp.4.1586511419309;
        Fri, 10 Apr 2020 02:36:59 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:449c:a024:b8e5:a34a:c38e:b427? ([2a00:1fa0:449c:a024:b8e5:a34a:c38e:b427])
        by smtp.gmail.com with ESMTPSA id r23sm963123lfi.33.2020.04.10.02.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 02:36:58 -0700 (PDT)
Subject: Re: [PATCH] usb: gadget: fsl: Fix a wrong judgment in fsl_udc_probe()
To:     Tang Bin <tangbin@cmss.chinamobile.com>, leoyang.li@nxp.com,
        balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Markus.Elfring@web.de,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
References: <20200410015832.8012-1-tangbin@cmss.chinamobile.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <0ee67579-8c65-bde1-e458-50344d3100b9@cogentembedded.com>
Date:   Fri, 10 Apr 2020 12:36:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200410015832.8012-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 10.04.2020 4:58, Tang Bin wrote:

> If the function "platform_get_irq()" failed, the negative value
> returned will not be detected here, including "-EPROBE_DEFER", which
> causes the application to fail to get the correct error message.
> Thus it must be fixed.
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
> ---
>   drivers/usb/gadget/udc/fsl_udc_core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
> index ec6eda426..60853ad10 100644
> --- a/drivers/usb/gadget/udc/fsl_udc_core.c
> +++ b/drivers/usb/gadget/udc/fsl_udc_core.c
> @@ -2441,8 +2441,8 @@ static int fsl_udc_probe(struct platform_device *pdev)
>   	udc_controller->max_ep = (dccparams & DCCPARAMS_DEN_MASK) * 2;
>   
>   	udc_controller->irq = platform_get_irq(pdev, 0);
> -	if (!udc_controller->irq) {

    This check has always been wrong, doesn't account for real errors and
probe deferral...

> -		ret = -ENODEV;
> +	if (udc_controller->irq <= 0) {

    Note that platfrom_get_irq() no longer returns 0 on error.

> +		ret = udc_controller->irq ? : -ENODEV;
>   		goto err_iounmap;
>   	}

MBR, Sergei
