Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0FFC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C077B24692
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f6IaWn5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgB0Lq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 06:46:29 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33676 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgB0Lq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 06:46:29 -0500
Received: by mail-wr1-f68.google.com with SMTP id x7so442410wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 03:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cTBJSroA9RJ+8lBEwYkKnNGeXoVHBYBbqwTPMLg2F9o=;
        b=f6IaWn5/yo6zdY5X0ONlrcO/16bC0jHGTfMt38t7p56Jk/StSR2GrXddKXOery9A+q
         bsjgvdrg9L2Y5X/z9mPZ40VcKxSzvjl/BcWiURUpE3UAHihkGE+aNwqW/hQHYlzJgTgZ
         dfkiTG5kuvTJCd5dwZrlgZojGkh2FdtDn/Motiqg1mztRnu9q46TLh5KM8w8xNboLfWi
         8CDE32ktJ+g+I1TZDeJIVMR3WVojdFKmDI2+8Me3bjD1iR73YZ3bq3EhQ9l8C/B8ULlL
         F/KJj4448hTB1c4I+t6S2FwLOa1EMsR98TeyclEAn/s0Obty8TAwe9cBsru+gLOVAy96
         nLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cTBJSroA9RJ+8lBEwYkKnNGeXoVHBYBbqwTPMLg2F9o=;
        b=N1dcW6BKLAvbhK/uZmit4scajpMqAFl6Y5SM5DwlYneGe3ARTAG+8RMQpPXqYL1ETe
         /Z2P1Gx/P14DhxZLDHLc/ELtE7meBNGwokGqCrdhQtMD+/tUdqA4Qfr8ba8vtFnrkzVx
         bQMQkfLv2co0s7PPdVU3e1eZcuGeoyXBGCzCS+1+hSfmDPwdRYsN/vdM4D+L3ZM3ENGK
         2JBMTDEF+bH7Iy1BSObVyxauqG3i495Wkd6qCcwy+txycSGvN8bBGOyoTikNK8xmLV2J
         0O1E222ZFUKMvLKvuaaDAd4tMWnnvaDaIV0GLbO9AUz5uzElHH4hJ10fueVEmO6Opjlx
         vXTg==
X-Gm-Message-State: APjAAAX2MzhGNwu8CRkuAQVFEeZhCr0F3iFzx+a/i+o1253n/PNuWmjr
        HhY5xPWeOnJjKstVZaW//VpbUg==
X-Google-Smtp-Source: APXvYqz1InEhOPcHB1heYSDPHQuazWq7emWdftcDiZpOvuTUa9UVkpntp5/WkSSXkFxYObe7pXC9kQ==
X-Received: by 2002:adf:efc4:: with SMTP id i4mr4509410wrp.225.1582803986345;
        Thu, 27 Feb 2020 03:46:26 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id 133sm7667950wme.32.2020.02.27.03.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 03:46:25 -0800 (PST)
Date:   Thu, 27 Feb 2020 11:46:23 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Gyungoh Yoo <jack.yoo@skyworksinc.com>,
        Bryan Wu <cooloney@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] backlight: sky81452: insure while loop does not
 allow negative array indexing
Message-ID: <20200227114623.vaevrdwiduxa2mqs@holly.lan>
References: <20200226195826.6567-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226195826.6567-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 07:58:26PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the unlikely event that num_entry is zero, the while loop
> pre-decrements num_entry to cause negative array indexing into the
> array sources. Fix this by iterating only if num_entry >= 0.
> 
> Addresses-Coverity: ("Out-of-bounds read")
> Fixes: f705806c9f35 ("backlight: Add support Skyworks SKY81452 backlight driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> 
> V2: fix typo in commit subject line

Isn't the correct spelling "ensure"?


> ---
>  drivers/video/backlight/sky81452-backlight.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/sky81452-backlight.c b/drivers/video/backlight/sky81452-backlight.c
> index 2355f00f5773..f456930ce78e 100644
> --- a/drivers/video/backlight/sky81452-backlight.c
> +++ b/drivers/video/backlight/sky81452-backlight.c
> @@ -200,7 +200,7 @@ static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
>  		}
>  
>  		pdata->enable = 0;
> -		while (--num_entry)
> +		while (--num_entry >= 0)
>  			pdata->enable |= (1 << sources[num_entry]);

This look still looks buggy to me (so I'd second Walter's request to
change it to a for loop). If the code genuinely does not contain a
bug then it probably needs a prominent comment explaining why it is
correct not to honour sources[0]!


Daniel.
