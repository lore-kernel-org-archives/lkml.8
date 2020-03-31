Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBBFC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE0B2078B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9eW+kYr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbgCaOuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 10:50:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40009 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730528AbgCaOuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 10:50:14 -0400
Received: by mail-wr1-f65.google.com with SMTP id u10so26345160wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 07:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=LThkFwSkZqTw2d4yYtrBRfrpjqvh2S44Ii+brKsEaNw=;
        b=j9eW+kYrODFdfrvu7dy3d7qBefcQklepGBvj9jeR8ukot9h5lwypuGf5uufqC6HRgI
         kOxYY0Gl1d+rsvs3jI2joeQ/K9fw0zLrpKP2ZfW17KXY4+WUk/JSZ8KAUVAnIoYijiSG
         72xe3HjDiRAGweyGBeu0koQ6R6h53GPsoakP+UZ63E0oG2b3gbice2QixK1CP37bWFvF
         nFymoKBWxsY3etNsmAtN0CcDfZOj9AnypWpwdsYX9DdcJZicqd8a+AG3qJ4Xlh7CtbZV
         wpoAEOJD53gMflO5aGS6pi7iX1qHirLV9b3hK64AZ+M80o5vpoCHeuC7oIDhoy097U7j
         YpTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LThkFwSkZqTw2d4yYtrBRfrpjqvh2S44Ii+brKsEaNw=;
        b=mykSTOPSQkzzhEoxKWr9vscXt+fDl6f5C1UND2hLsVGojIMTCqmIbTZmAUTcM4jste
         PNLXiETeU1POrTzGKNZd56mxysB9tVry/GhdNg0vqFVPQPPWolJ9jeRxQ2guY+6vYXWr
         Xb5BTZ03sNWNlx2Rfh1rZHramN9zzIOOLBpBjneM7bJ3pDQMnEfYc9yCmAegb/DrLqVo
         gc8CTwVcy4IZOlF6ERXQEkHN1+dU3DbvfCh1GqQmMXw1cmzwkyHQ5vU8obv9zi+OPhsk
         sDzwF9AheSkekZchCElwhiQh4YWCKGmNB9rNevcpyjbkMVjw0MdRX0J/yX05HrpgvNpC
         7MWg==
X-Gm-Message-State: ANhLgQ1CCpcqlyWXrpmNj6Rw497mTcoLjmxX3HOaYm5qjoDzYAmopjoi
        dRpoLcm+QBOuSyeaIzuHz/c=
X-Google-Smtp-Source: ADFU+vsr3d8+VMK/1DccKZdQKSpk3+U3Tn2Yv0QuaeVmGVHxKuIWc8675z3Jx+k42MOjeg8U4DKKKQ==
X-Received: by 2002:adf:ecc3:: with SMTP id s3mr20158772wro.32.1585666212208;
        Tue, 31 Mar 2020 07:50:12 -0700 (PDT)
Received: from [192.168.10.4] ([185.199.97.5])
        by smtp.gmail.com with ESMTPSA id d6sm26595939wrw.10.2020.03.31.07.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 07:50:11 -0700 (PDT)
Subject: Re: [Xen-devel] [PATCH] drm/xen: fix passing zero to 'PTR_ERR'
 warning
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>,
        oleksandr_andrushchenko@epam.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <1585562347-30214-1-git-send-email-dingxiang@cmss.chinamobile.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <b4d43b05-8b30-749c-0b60-87b4cdd7b1dd@gmail.com>
Date:   Tue, 31 Mar 2020 17:50:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1585562347-30214-1-git-send-email-dingxiang@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/20 12:59, Ding Xiang wrote:
> Fix a static code checker warning:
>      drivers/gpu/drm/xen/xen_drm_front.c:404 xen_drm_drv_dumb_create()
>      warn: passing zero to 'PTR_ERR'
>
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>   drivers/gpu/drm/xen/xen_drm_front.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_drm_front.c
> index 4be49c1..3741420 100644
> --- a/drivers/gpu/drm/xen/xen_drm_front.c
> +++ b/drivers/gpu/drm/xen/xen_drm_front.c
> @@ -401,7 +401,7 @@ static int xen_drm_drv_dumb_create(struct drm_file *filp,
>   
>   	obj = xen_drm_front_gem_create(dev, args->size);
>   	if (IS_ERR_OR_NULL(obj)) {
> -		ret = PTR_ERR(obj);
> +		ret = PTR_ERR_OR_ZERO(obj);
>   		goto fail;
>   	}
>   
