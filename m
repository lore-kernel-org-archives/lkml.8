Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D01C11D24
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 04:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4F5207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 04:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIEoFngw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbgBUE5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 23:57:44 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45016 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729546AbgBUE5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 23:57:44 -0500
Received: by mail-ot1-f66.google.com with SMTP id h9so909734otj.11;
        Thu, 20 Feb 2020 20:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ogn/J4giaQGLC3qcPsRUe3cWuadkZCD6KASZ61C4ThA=;
        b=kIEoFngwEB2uizuWztZrPisyrMtzekpWhy+TjV93VsYmFrHQ3Pcp6fut+K4lBdL3F7
         hYa9mFpXC8zQIhW+jAeRG5kaQQ+o4UqewiTjbLWESn0auaUWUuJCV7O3C5kgofVNKFJG
         /iTmwExGNd2RaaHRUpPWxtVOUGPLGCGIcJRFw44gQvapOxF7tsIUE0jheKYMr7+4XeqD
         8DEljxOi3rTum3dIVxr0d2sdcNUtqLpO6g2dZyI4vJz7razV1oKmftSI1k4IlqJ03ImG
         9dPEMiZpxF4xZnlBOtWVsIhwXKgBlg1I2790KQFCu/Ph2crRExpSPfFPiGOkQy7gct72
         8Edw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ogn/J4giaQGLC3qcPsRUe3cWuadkZCD6KASZ61C4ThA=;
        b=BdoM0MtoFyQ2qRuFt99O8pPyag7SA/6IRCXQADMcwk6IUR7pdcNQ9kLUcvu9slIrBn
         BblqrSGLoFjXeCJ+Raxk518cOrJbtnz7S+JPfgMcdb3iv0lu7dOnv09LDBQ4+UmSgN4l
         afeHhxhAeUkuD41wcICcdeMVzcO4SEZphBQzos5SRHNI1LyrtrBfIlytUmM8IRdIVgjL
         QQvlhqh3IKcI+HB1kwt8FeCOPAX68HjpnnaCZ2zjaDw5riJgcc3jm+R87DS3ifKroDCP
         XVIg8yrpSt/qODXUxWOj28k1Qv14s0w2Nt75QJOwvMTJ6YQwH25OvuZfCsE5t1acCOi+
         00Ag==
X-Gm-Message-State: APjAAAU0p8UjJFAmj64QneNnFz1RUJUzdfizvc91S3ZmVK45Xh5j8hLX
        8xGs+ptz95Oz+lQkkz9sIfE=
X-Google-Smtp-Source: APXvYqzTqMZvH/9ZgI3+G8aJjVo4IcNpjr++SOjdjDD/PR19TdNUf9R7rgpYCw/rQP3r0Sv9FTMfWA==
X-Received: by 2002:a9d:6e98:: with SMTP id a24mr25542147otr.53.1582261062265;
        Thu, 20 Feb 2020 20:57:42 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id y25sm660670oto.27.2020.02.20.20.57.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Feb 2020 20:57:41 -0800 (PST)
Date:   Thu, 20 Feb 2020 21:57:40 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Ashwini Pahuja <ashwini.linux@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] usb: gadget: udc: bdc: Remove unnecessary NULL checks in
 bdc_req_complete
Message-ID: <20200221045740.GA43417@ubuntu-m2-xlarge-x86>
References: <20191023002014.22571-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023002014.22571-1-natechancellor@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I know it has been a while but ping?

On Tue, Oct 22, 2019 at 05:20:15PM -0700, Nathan Chancellor wrote:
> When building with Clang + -Wtautological-pointer-compare:
> 
> drivers/usb/gadget/udc/bdc/bdc_ep.c:543:28: warning: comparison of
> address of 'req->queue' equal to a null pointer is always false
> [-Wtautological-pointer-compare]
>         if (req == NULL  || &req->queue == NULL || &req->usb_req == NULL)
>                              ~~~~~^~~~~    ~~~~
> drivers/usb/gadget/udc/bdc/bdc_ep.c:543:51: warning: comparison of
> address of 'req->usb_req' equal to a null pointer is always false
> [-Wtautological-pointer-compare]
>         if (req == NULL  || &req->queue == NULL || &req->usb_req == NULL)
>                                                     ~~~~~^~~~~~~    ~~~~
> 2 warnings generated.
> 
> As it notes, these statements will always evaluate to false so remove
> them.
> 
> Fixes: efed421a94e6 ("usb: gadget: Add UDC driver for Broadcom USB3.0 device controller IP BDC")
> Link: https://github.com/ClangBuiltLinux/linux/issues/749
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> Note: I am not sure if these checks were intended to check if the
> contents of these arrays were NULL or if there should be some other
> checks in lieu of these; I am not familiar with the USB subsystem to
> answer this but I will happily respin the patch if this is not correct.
> 
>  drivers/usb/gadget/udc/bdc/bdc_ep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/bdc/bdc_ep.c b/drivers/usb/gadget/udc/bdc/bdc_ep.c
> index a4d9b5e1e50e..d49c6dc1082d 100644
> --- a/drivers/usb/gadget/udc/bdc/bdc_ep.c
> +++ b/drivers/usb/gadget/udc/bdc/bdc_ep.c
> @@ -540,7 +540,7 @@ static void bdc_req_complete(struct bdc_ep *ep, struct bdc_req *req,
>  {
>  	struct bdc *bdc = ep->bdc;
>  
> -	if (req == NULL  || &req->queue == NULL || &req->usb_req == NULL)
> +	if (req == NULL)
>  		return;
>  
>  	dev_dbg(bdc->dev, "%s ep:%s status:%d\n", __func__, ep->name, status);
> -- 
> 2.23.0
> 
