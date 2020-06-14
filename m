Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0622EC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 08:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5F83206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 08:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="MySZLFLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgFNIvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 04:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgFNIvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 04:51:31 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAB7C03E96F
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 01:51:29 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id a26so3316146lfj.13
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 01:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OHFcccCITD963Tsu3GgXPinLU/7uAM5t6Q2kJ5JaR4k=;
        b=MySZLFLrZl58fEbYrERZ9j4T9iIuFuZDJuGjEkdqug8BNSBVAYFSDHe2mN6Cko0y1k
         XkRTHkTS8pl1IzFPbl3qOk1ze/OiUew3oB6uzcHb0QGoi47Ejbmur3RXHRM57a/M9Xfu
         qCQxeoeF0cVdU2bRJsC2c2x+dIAznkpEXGjq53FWmpTBBmUro06ucoRdMPvNFTRHRO1E
         fPXZ1pDhrXTyXEQzpeAhV1JaLBFTlE1DfXYo/+Mhi9ktcCrP03h7XdVu7UCh3DstlniY
         W7CPqDi5EI/SYxv+ibaJikZ7lKJ9JZWvfx7b90wrrd5cWrKDWQMUcnfX2wKAxqMs3zVO
         OMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OHFcccCITD963Tsu3GgXPinLU/7uAM5t6Q2kJ5JaR4k=;
        b=e0Zbwr6KphcXZ59yAQOq8GIKYNCnh074+beXYyR2iG6Lpc8OaENTmhJ+djZhGWJN3z
         3fh7q5d3ZKl/yy3xjeKWJAyUq+XOw/84ZGv5Pmu0BEnZe6xHpTU2udiRc5RSYaFynmQz
         itT7PB5KJfumXUJAVjdkjb4XtY4HhMbvGW2wo8wb4s6Yj87bDiywWUUNoprU7RPj18B3
         qRsuGkg/AXFtN3TW4xYWWg7M99p0Y9EdGGhtPWLxuFsvifsaHaAbGTKCfUhsqxQ58E6E
         wykoVahivf7+05XTUBhBjjv605VMQAvVqw6qxLQp3B7J2HP6PnK69rtSjOa2jyVG9cBO
         kcZQ==
X-Gm-Message-State: AOAM532ITrlo5aGlGxcbHa5xzuEl5GcSmvMXDwGwlgyVR5qvDAXRvLOE
        pZSBgAaLAzBHKsETVQdf7AiGis5qkTRagA==
X-Google-Smtp-Source: ABdhPJyzDhO5IVobvDH5thC1gjdWtjjpYsAZKehWItV4+/Xut0BpI44AcMamSpebtINScuaZ17XZmA==
X-Received: by 2002:ac2:59c3:: with SMTP id x3mr11073755lfn.117.1592124688107;
        Sun, 14 Jun 2020 01:51:28 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:42e0:5405:a560:8954:33ef:54e2? ([2a00:1fa0:42e0:5405:a560:8954:33ef:54e2])
        by smtp.gmail.com with ESMTPSA id 193sm3157011ljj.48.2020.06.14.01.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2020 01:51:27 -0700 (PDT)
Subject: Re: [PATCH] usb: musb: fix reference count leak in musb_irq_work
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, wu000273@umn.edu, Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200614032704.129010-1-pakki001@umn.edu>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <40e47a62-5359-4396-7f52-fb1a3cfa9d76@cogentembedded.com>
Date:   Sun, 14 Jun 2020 11:51:23 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200614032704.129010-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.06.2020 6:27, Aditya Pakki wrote:

> musb_irq_work() calls pm_runtime_get_sync() that increments
> the reference counter. In case of failure, decrement the reference
> count and return the error.

    Again, *void* function, so no error returned.

> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>   drivers/usb/musb/musb_core.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 384a8039a7fd..fd36a026bef0 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -2070,6 +2070,7 @@ static void musb_irq_work(struct work_struct *data)
>   	error = pm_runtime_get_sync(musb->controller);
>   	if (error < 0) {
>   		dev_err(musb->controller, "Could not enable: %i\n", error);
> +		pm_runtime_put_autosuspend(musb->controller);
>   
>   		return;
>   	}

MBR, Sergei
