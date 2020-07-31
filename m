Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D25C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE8E622B3F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvmAMOvF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387911AbgGaSi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 14:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387676AbgGaSi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 14:38:58 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C59C061574;
        Fri, 31 Jul 2020 11:38:57 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id 6so23726776qtt.0;
        Fri, 31 Jul 2020 11:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hmlynqxkKJT+AklZpDdQn6RJdhmkaFRFUyQ1+UUwwKU=;
        b=KvmAMOvF4+8tqzp2+qH7sQBYhUmlWMMHQYRQEAyX3ufuczq/2ENbC41E24FHBlYMOQ
         QRx1CQ7hH2UgONKJE+0vjN4gt7zUPCgaAGdpgINwANeZhNLhBqwJTj2KtiiSSCa/n7E2
         kibXk4mLLih6bIxNNRuzVqE2Y9ttW7RGnMSUjYYgMt27H6Q7g4YI2lKDaifOSoSFC3z+
         pbtu/kbAIyS3q0LQgCnWY3+CqLOuAqqzvXZfdVQjwm9UePpzq8ipLBUvKbuVyEKyBGBP
         cLi5Hf9J9QrJq0mq2XzaMGmiwq9ryko8PRbHfPVS1dKmronXw12z88vP6y8oqDFQS9Cj
         lh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hmlynqxkKJT+AklZpDdQn6RJdhmkaFRFUyQ1+UUwwKU=;
        b=ir8wsYNSgmkZMMbXj/AOAsZ5eytMXTKHbotIZ0SVG+AaWqqIfVa39BucL/rF/nNUQT
         KdSsSw9+Fj6Uj0tR7VsVunUgM2uBJQ+2bhMJXgxmsZ2qK7LY135FQf58qjxVNpfGtk2P
         LkU8fv6l6wwJOsCa2Jc9FAba0F2oZh2F8e8rFKwudhFPNhgMP3OwapdEwZ8tCaywMX8i
         jBkb1oOOCxjNyqCtySmw/W4J23RUa4AOXEejivhNW1iebpBkajFqmLBCM0doMpGTgKXk
         mX2Rs6q4XK46lQtSKO/o9uSEhgfEh151zvuCgyQ6OyJLPjK75lV6taavdGejCVlWOvdz
         hn4w==
X-Gm-Message-State: AOAM530l2b17E6weygqAJs7WwX3Kiq7GL7wAd30G1MtfBKNGajWddeYI
        C6uAhznVu6PJDjxnehdHKmk=
X-Google-Smtp-Source: ABdhPJy4SC1/P8V4XXUJOKNekIdadtMw2vA2d1nIgiOXTL1o9u+42phUs021Nj3hsi3+kyOjtGWBLA==
X-Received: by 2002:ac8:5416:: with SMTP id b22mr5004515qtq.45.1596220737104;
        Fri, 31 Jul 2020 11:38:57 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id l1sm9492144qtp.96.2020.07.31.11.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 11:38:56 -0700 (PDT)
Date:   Fri, 31 Jul 2020 11:38:54 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: s3c: Remove unused 'udc' variable
Message-ID: <20200731183854.GA2279514@ubuntu-n2-xlarge-x86>
References: <20200731074122.6484-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731074122.6484-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 09:41:22AM +0200, Krzysztof Kozlowski wrote:
> Remove unused 'udc' variable to fix compile warnings:
> 
>     drivers/usb/gadget/udc/s3c2410_udc.c: In function 's3c2410_udc_dequeue':
>     drivers/usb/gadget/udc/s3c2410_udc.c:1268:22: warning: variable 'udc' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Weird, looks like it has been unused since the introduction of the
driver.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  drivers/usb/gadget/udc/s3c2410_udc.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/s3c2410_udc.c b/drivers/usb/gadget/udc/s3c2410_udc.c
> index bc2e8eb737c3..e875a0b967c0 100644
> --- a/drivers/usb/gadget/udc/s3c2410_udc.c
> +++ b/drivers/usb/gadget/udc/s3c2410_udc.c
> @@ -1270,7 +1270,6 @@ static int s3c2410_udc_queue(struct usb_ep *_ep, struct usb_request *_req,
>  static int s3c2410_udc_dequeue(struct usb_ep *_ep, struct usb_request *_req)
>  {
>  	struct s3c2410_ep	*ep = to_s3c2410_ep(_ep);
> -	struct s3c2410_udc	*udc;
>  	int			retval = -EINVAL;
>  	unsigned long		flags;
>  	struct s3c2410_request	*req = NULL;
> @@ -1283,8 +1282,6 @@ static int s3c2410_udc_dequeue(struct usb_ep *_ep, struct usb_request *_req)
>  	if (!_ep || !_req)
>  		return retval;
>  
> -	udc = to_s3c2410_udc(ep->gadget);
> -
>  	local_irq_save(flags);
>  
>  	list_for_each_entry(req, &ep->queue, queue) {
> -- 
> 2.17.1
> 
