Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E9FC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FF2F20656
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jC6MN7SM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505110AbgDNTmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504949AbgDNTl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:41:57 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580C9C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:41:57 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id z17so947359oto.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v7lYaeOwaRqbFs5URm39Evj8odcvFYk7byk2mljb3n8=;
        b=jC6MN7SM0gbB8C6igXZxmy6YlyG0XZnCiDkfi2LGCG7dBKUpE5RuDtCbIWQmNZRi7t
         TB24fwPuLxY/DRx/QGbKHTkZKH3g2OS9XV076Aw8qWQiZu6BSf0Ol/8gFV0nGye9aHln
         D4MhJtbEHC5nMdc4+qqeqrrq91fiUoNet6Ugih5692RKERrseObjhfHKpxuKQUQMNY27
         nkbfybKw5cY7bxGM6EZ68pPy/LfKhp3nCZU3CsqVQPrTlD8NnLuoot6qnP5U5Rg/8Rip
         YkS6VjG0cTZ/dASX8VHRmrkvH/HQZgPh3PsFaaT4gaGTpiQAPuuBwDw5WuL5875+Jmo4
         XB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=v7lYaeOwaRqbFs5URm39Evj8odcvFYk7byk2mljb3n8=;
        b=VKGxCxrkyBkYrVAXffnRhJgXXQhb8RwklAfRgWpWgsy/3tNS2NZPKWYXDdTfzMYcqk
         rojHindHZ/3dymlf5aIIOBDBstKkC6abdZgXzylGLQ9ZJ4nRkbDWBRdXlUram8DDVFYU
         8Yr7glFx8CRBnJnDxgd+mUvBx825IWTRMY/p4acb4ulbVh+f1cbW3kx+lSrGV7BeaXiV
         N+43Aa+8crUYW+ht1KHHcscEStjZcEQsE9UGVXrbOmv9jTQp488NQ0K65S+3JT4yKIN1
         +9CAzr9RY5y41pOI7dULA3lZSACuSlDuL/ux076jcYP2yHbyn5A67nuwqzADLBjC6CXe
         8IRQ==
X-Gm-Message-State: AGi0PuYTgiEkvLPw4ZzmT/+DmaB7u6V7023UprWjDauPabz073biw2GL
        6eGqcvlEsagrGGcza5TPyjHl+Pw+5w==
X-Google-Smtp-Source: APiQypIbgA6RA1suVxKHDWo9E+TrEXDK/YUzdLWPyxfpHgwm7FSg23LhKy6aqdEMgLFevEM+n2kq2A==
X-Received: by 2002:a9d:470b:: with SMTP id a11mr9680927otf.44.1586893316477;
        Tue, 14 Apr 2020 12:41:56 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id z11sm5701093oto.23.2020.04.14.12.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 12:41:55 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:8b39:c3f3:f502:5c4e])
        by serve.minyard.net (Postfix) with ESMTPSA id 8C6A8181888;
        Tue, 14 Apr 2020 19:41:54 +0000 (UTC)
Date:   Tue, 14 Apr 2020 14:41:53 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH] ipmi:bt-bmc: Fix some format issue of the code
Message-ID: <20200414194153.GG3587@minyard.net>
Reply-To: minyard@acm.org
References: <20200414141814.19048-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414141814.19048-1-tangbin@cmss.chinamobile.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 10:18:14PM +0800, Tang Bin wrote:
> Fix some format issue of the code in bt-bmc.c

Applied, thanks.

-corey

> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
> ---
>  drivers/char/ipmi/bt-bmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
> index 890ad55aa..cd0349bff 100644
> --- a/drivers/char/ipmi/bt-bmc.c
> +++ b/drivers/char/ipmi/bt-bmc.c
> @@ -463,9 +463,9 @@ static int bt_bmc_probe(struct platform_device *pdev)
>  	init_waitqueue_head(&bt_bmc->queue);
>  
>  	bt_bmc->miscdev.minor	= MISC_DYNAMIC_MINOR,
> -		bt_bmc->miscdev.name	= DEVICE_NAME,
> -		bt_bmc->miscdev.fops	= &bt_bmc_fops,
> -		bt_bmc->miscdev.parent = dev;
> +	bt_bmc->miscdev.name	= DEVICE_NAME,
> +	bt_bmc->miscdev.fops	= &bt_bmc_fops,
> +	bt_bmc->miscdev.parent = dev;
>  	rc = misc_register(&bt_bmc->miscdev);
>  	if (rc) {
>  		dev_err(dev, "Unable to register misc device\n");
> -- 
> 2.20.1.windows.1
> 
> 
> 
