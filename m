Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0E4C47255
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 01:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF14E2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 01:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HHqbvgKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgELBTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 21:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgELBTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 21:19:45 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B18AC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 18:19:45 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y25so5572904pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 18:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J+bCb9UGvHNvD7qEIMwRcVNw6vMBwgY6JkQ/mVSuXPM=;
        b=HHqbvgKE9OIBcQWiFwjmooBzTRVr5rJdSlqi/dH/f6DdlO22lNY75Z2r10ThMDJhs9
         Jrd6InioiHaAREuFIPzLrxqjpUelM8+57DYjKYHjxrjgw2olirDNQxwblbxCjgOhTnLX
         gRLJ0UZ4FH1OnQ1W8KcqNLXVWwz5VdhnE7MG4HjnvOXqHTgHpGsXuwhJ0Ooj4NM1Gmxy
         M/9cfOXLm5rimArXEMhTz/7f89FAc4WlVY1770AEBjyHsjCLA4rYbhUh3d2Pw+Jn/kSl
         uvPAV7EA6trOUARRVMtS6oraOJP57txdOOJTRW7Wyz/MONex3wKL1oFT811xK7jRL7Cu
         pEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J+bCb9UGvHNvD7qEIMwRcVNw6vMBwgY6JkQ/mVSuXPM=;
        b=NV3KvLXaVod5H7jr4BEnPa9AYPw+KYaneEBuoXVi9q7rpRp+W3s5NGpcveSmbT949d
         lQZyjwp4iUPeQ+LRMjUA5kkpuweYJGMlV11CXuKFgAztaHL9oX0PQbhyiV/jbBv4zRGr
         AEtQwI5SBKFW2hWfFIgZGh9efKtuWCp/Q3vdn0c2MwycoKRgsIztsthmkdhD0jbSzmGu
         Wv528/WruDJchTuM2PuW1IhFelbpzeuAJuB3FffktB8dRZgObD1QgCfzkVhz/wmfzagJ
         KCXShlKrWGNF3XHT4nmJWR2+aSCHS+qeNQ1pqXidbjcJFx2uVYanxgUUfu2Y3IN2kCL4
         /5Ag==
X-Gm-Message-State: AGi0PuaAUwpVgJw02RBZ/aAd9HszcgLG7uC4h9NEMSj9uDjvAn2mSgWw
        w2iHlpSbVpKxSQg0cCe4GCGRQRjeE24=
X-Google-Smtp-Source: APiQypI6vF9W57VGlLu6vZbyvBXckZs7IElIfyCYJHoEnb/eefz7Izvsiz/uSm30JBD7JaJnH/Faqg==
X-Received: by 2002:a63:5955:: with SMTP id j21mr17671913pgm.70.1589246384684;
        Mon, 11 May 2020 18:19:44 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p24sm10207951pff.92.2020.05.11.18.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 18:19:44 -0700 (PDT)
Date:   Mon, 11 May 2020 18:18:10 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] misc: fastrpc: fix potential fastrpc_invoke_ctx leak
Message-ID: <20200512011810.GB57962@builder.lan>
References: <20200511162927.2843-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511162927.2843-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11 May 09:29 PDT 2020, Srinivas Kandagatla wrote:

> fastrpc_invoke_ctx can have refcount of 2 in error path where
> rpmsg_send() fails to send invoke message. decrement the refcount
> properly in the error path to fix this leak.
> 
> This also fixes below static checker warning:
> 
> drivers/misc/fastrpc.c:990 fastrpc_internal_invoke()
> warn: 'ctx->refcount.refcount.ref.counter' not decremented on lines: 990.
> 
> Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/misc/fastrpc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 9065d3e71ff7..07065728e39f 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -949,8 +949,10 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
>  	dma_wmb();
>  	/* Send invoke buffer to remote dsp */
>  	err = fastrpc_invoke_send(fl->sctx, ctx, kernel, handle);
> -	if (err)
> +	if (err) {
> +		fastrpc_context_put(ctx);

So we refcount ctx once for the invoke function and once between send
and callback. And this fastrpc_context_put() would counter the fact that
rpmsg_send() failed, so we will not get the "remote's" put().

I think that if you moved this call inside fastrpc_invoke_send() it's
relationship to the failing rpmsg_send() would be obvious.

Regards,
Bjorn

>  		goto bail;
> +	}
>  
>  	if (kernel) {
>  		if (!wait_for_completion_timeout(&ctx->work, 10 * HZ))
> -- 
> 2.21.0
> 
