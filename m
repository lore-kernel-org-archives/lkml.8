Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79049C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 501082074F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNPvc9kL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbgDTPKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgDTPKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:10:39 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A55C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 08:10:39 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id l25so3502798vso.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 08:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dNzKdVNw/y2yDQaVrRieyT4KFZArRiYw0+stJCrhWMM=;
        b=JNPvc9kLgjs5c9Uy8hyHPgxiH8+0negQy6zmpAHp2KR6Ir9JpMb7vP75WjtW3y0ml3
         duKpnVNLX7bu1KKmfoNSSZTd2XfqLNgfybcp7NcogR/KjElgrEgPekEydh+OYoHy7WX1
         5Q35lOKzjXK6z+M81TfHZLXOyDX4SrnLSb7JlKtPgsA8BYznUlwbOMver8L5++NGeUty
         CyPJtO3+WaFWoxFV0kx1ALlDuCBjDedXYhzrQnL6PClY6VeGZOrfR4hOo01pSmF7BAI+
         To9EM+eupvrq1bDopsdFZXw5gapsU0Uu45aXg1/+jrS7mbxs7w5xBq8kQIfLGZkcn/9B
         s+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNzKdVNw/y2yDQaVrRieyT4KFZArRiYw0+stJCrhWMM=;
        b=AgL1D78PbAPH2WJ0NK1qPHSTTk+loUIRxb5faSa2rxhH4AfdHrTLwmP3QyJsN+7rgU
         t52G63RIWXyvc1O4QyLEwiWXxdy5uC9ylNOQcc5c7moM1FQIPeRgVKKH8l8uM0m7nGLJ
         MxmTz/FkwXG+zLDXzurmYr3Tyt8/7DTsIzFBhOG/g5398hPjJAnMJoO5YRoL47B4weLJ
         Nt8cV1lXUoXhpSmoxnHXlRiJ74IUmdjwZE1G1xqNHTXf0IiLd8vaEPeDvs/Sy5RY1ZVX
         oUVx/zSD2yl3Tk0V7wA2zEM9lbjPIB+p/Zc+ESniO1DYeaAXsqA9tBK2ZPwjH839vB7K
         w5Jg==
X-Gm-Message-State: AGi0PubXDfHZIQfM4QH3xytjdi5AY0zD+d7wr+Sf2Q7f6rB1cbyyJXDO
        gaHf+tPuMQRuoskYEm8b4sd/SaveplUg5zc003inHSgd
X-Google-Smtp-Source: APiQypL2QQKbpGTWOQ+R3+RLwT9Wlq4zMNhd6n1JfD0GCVkNSx+1rXyQG12GB7grmz3Zt9kxXQTBLbme8f5g5qTDxc0=
X-Received: by 2002:a67:7d83:: with SMTP id y125mr10557611vsc.96.1587395438822;
 Mon, 20 Apr 2020 08:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200418100248.4552-1-tangbin@cmss.chinamobile.com>
In-Reply-To: <20200418100248.4552-1-tangbin@cmss.chinamobile.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Mon, 20 Apr 2020 17:10:27 +0200
Message-ID: <CAH9NwWck5KwOGNcYWOAsfKa5CQjJHqMr2j8FW9SmWUYiyu1ebA@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: Omit superfluous error message in etnaviv_gpu_platform_probe()
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sa., 18. Apr. 2020 um 12:01 Uhr schrieb Tang Bin
<tangbin@cmss.chinamobile.com>:
>
> In the function etnaviv_gpu_platform_probe(), when get irq failed,
> the function platform_get_irq() logs an error message, so remove
> redundant message here.
>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>

> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index a31eeff2b..6dbe0c45b 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -1770,10 +1770,8 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
>
>         /* Get Interrupt: */
>         gpu->irq = platform_get_irq(pdev, 0);
> -       if (gpu->irq < 0) {
> -               dev_err(dev, "failed to get irq: %d\n", gpu->irq);
> +       if (gpu->irq < 0)
>                 return gpu->irq;
> -       }
>
>         err = devm_request_irq(&pdev->dev, gpu->irq, irq_handler, 0,
>                                dev_name(gpu->dev), gpu);
> --
> 2.20.1.windows.1
>
>
>


-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
