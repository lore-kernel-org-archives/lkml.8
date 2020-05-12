Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41C8C2D0F7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91D03206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fCfpVlps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgELRaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 13:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgELRav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 13:30:51 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917FFC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 10:30:51 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m7so5658103plt.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 10:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uwHdadffELF6O3Ox9C2J9UrmgnS3D4KFbraj16AD0PI=;
        b=fCfpVlpsGcefVpnK833KEICYAiK6PPdm+7Hgo6P4xiIs1AthyUaTes1RRoyWsfR9i5
         H/6RCPsfT3DzDeNiBbY6Y5M9mgBVDL22QcZ2U1CmFm2KueiDUE3vI1FmZH3Q0wlqzrTH
         KrteQlpjsS14+Hx6q5m7GiiE3Y/+TfnARNv+9Oi1R6sCLHD5GtNe3VeJafdqLF/N8ZMX
         wJW3S//w/5fkW/G7lZDeZRXG869TUAMDA97RGg+l3kU9olTViqTFXG//p/uyJdU3qv3T
         ev7rHopoKPWCHVsVEg2TeavP9Ezgo4y8vNDKUTGu007zd733XFthSI9JYj8hX0V01wPv
         mJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uwHdadffELF6O3Ox9C2J9UrmgnS3D4KFbraj16AD0PI=;
        b=maWl+sDjKDzwBEXNNdOpz4tudyhNNyIEbuSnbdjFIG1rtNAlE6RbDl29UZnIunEyVG
         L4XiEaGXSfP+OEOxfqm73bX6DalSMqZiN1Tdhr1zmd46+lZhXgOj/3+m/xlaUUg4fjgf
         BdSa8mtvaSDBUziwfFmD9V/c6FlaUlHfcuho8bl/Xq9HoKbynyCT+Yz7fF4SDjq8Uw38
         dVJtsNn0xFsXqTbLK3oUxFfFeK9VXaIHBZoEz1kT3ZHQUW98VxqYzVqBx0tDOiphHwS8
         QlBzT4cnKyHoWC82ojWrmgGJ4PSSONrlgD4zdk+E++xSN9aMKUyfHL5hRhVPyMMQzsy6
         Oq5g==
X-Gm-Message-State: AGi0PubR2o85J6oZypaDWl3qVR2nBfczD1zMUYb9sD2Lr5hY83UNmwNK
        nLJLqVJnbID1+9REMkTU9S56Sw==
X-Google-Smtp-Source: APiQypJ1naeDJnJozrJ4B9Xp2/Gjh1uEfEb/1H/CK20riED1XpH9FpOX7zFR/K2HUX3er/fBTJ2MNw==
X-Received: by 2002:a17:90a:5b:: with SMTP id 27mr31396022pjb.190.1589304651035;
        Tue, 12 May 2020 10:30:51 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l15sm13636543pjk.56.2020.05.12.10.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 10:30:50 -0700 (PDT)
Date:   Tue, 12 May 2020 10:29:17 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] misc: fastrpc: fix potential fastrpc_invoke_ctx leak
Message-ID: <20200512172917.GG57962@builder.lan>
References: <20200512110930.2550-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512110930.2550-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12 May 04:09 PDT 2020, Srinivas Kandagatla wrote:

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

Thanks, that looks better.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> Changes since v1:
> 	moved fastrpc_context_put to fastrpc_invoke_send()
> 
>  drivers/misc/fastrpc.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 9065d3e71ff7..7939c55daceb 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -904,6 +904,7 @@ static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
>  	struct fastrpc_channel_ctx *cctx;
>  	struct fastrpc_user *fl = ctx->fl;
>  	struct fastrpc_msg *msg = &ctx->msg;
> +	int ret;
>  
>  	cctx = fl->cctx;
>  	msg->pid = fl->tgid;
> @@ -919,7 +920,13 @@ static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
>  	msg->size = roundup(ctx->msg_sz, PAGE_SIZE);
>  	fastrpc_context_get(ctx);
>  
> -	return rpmsg_send(cctx->rpdev->ept, (void *)msg, sizeof(*msg));
> +	ret = rpmsg_send(cctx->rpdev->ept, (void *)msg, sizeof(*msg));
> +
> +	if (ret)
> +		fastrpc_context_put(ctx);
> +
> +	return ret;
> +
>  }
>  
>  static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
> -- 
> 2.21.0
> 
