Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F3BC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50EE2077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sSrlMl4a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbgDAKQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:16:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52553 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgDAKQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:16:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id t8so2563127wmi.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 03:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b9ohpIeggQmJPpjoz9Sh0/yq4Y/ugE9//x5YLp0N6aY=;
        b=sSrlMl4aHEfPclgAbp0hw+YGa0B3dxwTI0V/Yeh+mIefUyRXFVJhEqzB+R7e3oI99+
         aOiFK3uJohxgGG8GEApUx7IdPtSJ2iCBT3UOK3uCrFa3Ca5IyzXcOcP1fQTuoV4f4VKw
         KOJU8nLgsaVg4VmziET0fe//h1tk5bdF38O9bFNDJu5RHDrgkId3rXYN5ilmpBk0f1El
         RDSS7tvogu/1qm23tlhcfpVAEJ6lLyp3LExvhdMHSw6POg2jBp0E8+R5SMrrUxDH56Mw
         SrWz78qOP2HfJ8IXOB/4HFhJVedz+tQCxIpwIeNvI0ZoGTLenmS9OKuSInIODd/H5osn
         SKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b9ohpIeggQmJPpjoz9Sh0/yq4Y/ugE9//x5YLp0N6aY=;
        b=bmHg4hUCZ3jPtqSHDOCrVK5VYoXIYQWfqed4Opm0+DQyrl0t3+4aj9btIx+6UCzwWI
         WDz0SQpv3FtYEyJN+HoFcTcoOGp/07dr0yf/+heRVwe6L5kyQwVyk8KYA1vSwrxUEDyS
         wPkP/47iKmiMldLpm8fRpYKeBx+E0vc8swVNxBXq9EE0KV63OIV566hSIdxMkE6RcR4k
         CX0IT/AilX5tBfoFOJijRoqBNdX8DlEp+MvdRRifWpgQ1ayL26Zj/vimjoMmOXw7XJt/
         MFTjN28osU2h+l+1Z7CXNwOn6cF5cExk1uBhqneKf8DeIVQf4IiHJfgvys3OfKnfSkvs
         tiFw==
X-Gm-Message-State: AGi0PuYMBVX38B+vA18Sj6BSYYs0nHy2WZPJzou7wM586Boam12zxfwg
        ppNI3axv2slDzoh+PfEI2yQ=
X-Google-Smtp-Source: APiQypLqvtaoPl6tWHtIyOhb76eFNQRYHnS71OLLlpIsY4OF8fxN7Ii+oG7jvnwZVuFM6QInSpsKpA==
X-Received: by 2002:a7b:c002:: with SMTP id c2mr3490813wmb.123.1585736185732;
        Wed, 01 Apr 2020 03:16:25 -0700 (PDT)
Received: from arch-thunder.localdomain (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id h2sm2004921wmb.16.2020.04.01.03.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 03:16:25 -0700 (PDT)
Date:   Wed, 1 Apr 2020 11:16:22 +0100
From:   Rui Miguel Silva <rmfrfs@gmail.com>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] staging: greybus: fix a missing-check bug in
 gb_lights_light_config()
Message-ID: <20200401101622.tj2bhnacetwt5rce@arch-thunder.localdomain>
References: <20200401030017.100274-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401030017.100274-1-chenzhou10@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen Zhou,
Thanks for the patch.

On Wed, Apr 01, 2020 at 11:00:17AM +0800, Chen Zhou wrote:
> In gb_lights_light_config(), 'light->name' is allocated by kstrndup().
> It returns NULL when fails, add check for it.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>

Acked-by: Rui Miguel Silva <rmfrfs@gmail.com>

------
Cheers,
     Rui

> ---
>  drivers/staging/greybus/light.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
> index d6ba25f..d2672b6 100644
> --- a/drivers/staging/greybus/light.c
> +++ b/drivers/staging/greybus/light.c
> @@ -1026,7 +1026,8 @@ static int gb_lights_light_config(struct gb_lights *glights, u8 id)
>  
>  	light->channels_count = conf.channel_count;
>  	light->name = kstrndup(conf.name, NAMES_MAX, GFP_KERNEL);
> -
> +	if (!light->name)
> +		return -ENOMEM;
>  	light->channels = kcalloc(light->channels_count,
>  				  sizeof(struct gb_channel), GFP_KERNEL);
>  	if (!light->channels)
> -- 
> 2.7.4
> 
