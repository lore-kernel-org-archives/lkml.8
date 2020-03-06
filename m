Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFF2C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569D02084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s6yA/sFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgCFJDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:03:23 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42020 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgCFJDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 04:03:22 -0500
Received: by mail-ed1-f66.google.com with SMTP id n18so1586775edw.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 01:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EVfExVbvc4MvxivvhE8Zwkes3mQk8IuR0W5sHBoUt4M=;
        b=s6yA/sFVQfnkWOhzov76JC4v4Q6UutyZ2L2Ug8rveGNIABq+bmHeuErO/xR9kP+ZVq
         ABqMmyGsSidJfn9cZZy9F4syEURpDOjA53So+NYB0qFB97h6pM7kmZEqyBOE4czQsPfc
         qd6GHhD1w9RQSXdmT2bh5zN2TRQTXdFVY5j9roa1grZia95KM82NTrW1lnUZB2STrZqK
         liAupLupNj+py9BYsqUoCR3Obedn1WXJPcp5DVYdUOKo0Vi3Vtscc+jUMUcTclpjNhGH
         W456CdZ7bAQ33fJHtT4gZNcEhQoVWOqjhhCx6M4va25gzkqcbZtDVd2VzL4FBhObFQrV
         lefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EVfExVbvc4MvxivvhE8Zwkes3mQk8IuR0W5sHBoUt4M=;
        b=CQ54Njw9zZW/m1CLDE0mFnrw2UAF/CnX3XGP2RZ01vgnz5jAizo+LxBIQVUNItxu6P
         ciofncpO3K2W3K/KpHSEq7RK2NunAWRCBTH/0UPLle3bluTSNGxHu+9Y1Znhy08BCSuz
         L12UG8+AQ/JzD4XmLvb/Hg1hx7oe0keZSpT5Y9b5jKHJ+Fio83A3F6tgxIYujfDh53sH
         LzPC9inSeSpkQA1YPNDfGwbZ1UlEA5QFGx+AW9chLglvgTS+17B/vUBYPJTy6WncWwtZ
         lTIQPdDVV4GqBfcWcPWc1CBkPxXkdIRDKGDeQxP1/M/960qDnlHywyu+xdDxgwmmpoAS
         Vcyw==
X-Gm-Message-State: ANhLgQ3QYKewxg5oojA4fpsk+gfd95e8rrxjxYVywy1UbvYFOgFbCMWx
        czJiC8B6j8y3LdGxOujj4Qly4yzEuoI=
X-Google-Smtp-Source: ADFU+vtCgRacFQClx889CnjgxaGXzrkgaoyqx59KC3gGmUbS+9oMGQ7CB5b7VUWkaDXtpfGM1f47kQ==
X-Received: by 2002:a05:6402:b81:: with SMTP id cf1mr2021814edb.131.1583485399147;
        Fri, 06 Mar 2020 01:03:19 -0800 (PST)
Received: from [192.168.27.209] ([94.155.124.210])
        by smtp.googlemail.com with ESMTPSA id x6sm1505497edr.86.2020.03.06.01.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 01:03:18 -0800 (PST)
Subject: Re: [PATCH] media: venus: fix use after free for registeredbufs
To:     Jeffrey Kardatzke <jkardatzke@google.com>,
        linux-media@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200306002321.3344-1-jkardatzke@google.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <892a0548-df6d-a4db-921f-7f4cfd69dc06@linaro.org>
Date:   Fri, 6 Mar 2020 11:03:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200306002321.3344-1-jkardatzke@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

Thanks for the patch!

On 3/6/20 2:23 AM, Jeffrey Kardatzke wrote:
> In dynamic bufmode we do not manage the buffers in the registeredbufs
> list, so do not add them there when they are initialized. Adding them
> there was causing a use after free of the list_head struct in the buffer
> when new buffers were allocated after existing buffers were freed.

Is this fixing a real issue? How you come to it?

> 
> Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
> ---
>  drivers/media/platform/qcom/venus/helpers.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index bcc603804041..688a3593b49b 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -1054,8 +1054,10 @@ int venus_helper_vb2_buf_init(struct vb2_buffer *vb)
>  	buf->size = vb2_plane_size(vb, 0);
>  	buf->dma_addr = sg_dma_address(sgt->sgl);
>  
> -	if (vb->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
> +	if (vb->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE &&
> +	    !is_dynamic_bufmode(inst)) {

If you add !is_dynamic_bufmode here, we will loose the reference frames
mechanism (see venus_helper_release_buf_ref()) which is not good.

Thus, I wonder (depending on when you observe the use-after-free issue)
does this is the correct resolution of the problem.

>  		list_add_tail(&buf->reg_list, &inst->registeredbufs);
> +	}
>  
>  	return 0;
>  }
> 

-- 
regards,
Stan
