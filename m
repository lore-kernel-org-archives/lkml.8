Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4921C2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F862137B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jcKrGM7e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgC0M1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 08:27:53 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:38266 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbgC0M1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 08:27:51 -0400
Received: by mail-vk1-f193.google.com with SMTP id n128so2612276vke.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 05:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=In6AkM11gvqmdb/KispfzpmD2iRwwXtrg0CmmoI1bFo=;
        b=jcKrGM7exGuQiO1LjlslrdOoUNSre0tVMGa8X1rUwAJMoElMCXNRubZF5PwRCB95d6
         aNcuWamXRntJBVslsOEVoKLAKW80FJyIIcBeL2f8cJ7R68fekIllxvdDUoAqQFvJymCx
         XdCelLEQAo310iLDkU60a8lsWlVz2So8fqiQ9pqXZtANOavod0KBr5/IWIpeG7zlbFYv
         zZNIGA51vu8GtL2Vkj0OwFJZD9VZR3UtFspqf32K3AE8zb7NWhQZWlYNwoK59k4R6ZDr
         r82rokEhVSpUVN9wgvJdiPFRIUvHfjTd6XHGXxlAWbhBDiDpWOoZmKoWqdr8f14rRSk0
         3HoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=In6AkM11gvqmdb/KispfzpmD2iRwwXtrg0CmmoI1bFo=;
        b=buVFThmy+m3ZuI28Nyuxtw4P1CBeuWQA63793ikdphP89dc1/RJ7c3jD2FwWOpeVTZ
         /vm5bBfJegNTwrGh9DieKPP8zghb/bbSoKDnlkHmkEhaj84AGeLWgoszfv96HiTtoyfJ
         mHj9Ri+R3fRebpoTnJIf9PyiX1wb6DIxk9JbU3xsPLcgfS83voNoUVDKjDpbKGeMDw2U
         joGbjhxU9bjiVPb0aHk9UEzepVpxuL89IIw67TuiqcGdTK4XmzSBNriwfrc92aabfKGF
         duI1dHCSGYD9hSuJ6jjTkjD4ZIUvCVw5Rpjgc5NLLlsHwLbIeZvQyzrXKqzIZRFIPD2Y
         YfXQ==
X-Gm-Message-State: ANhLgQ1Em0+9dAZ+6QaKWMlHGBeb13yNjUH0a8+hUFDfp/LD4QTGg/qK
        9sKJlYEfAoArYdGyv6Cf6E9DNf6A9aLaNUJGRz7cyULi
X-Google-Smtp-Source: ADFU+vsj3gMKz6JTZIh07Yw64OuO/tMYwReAjM54epn6GbmNlPQc0JWJA4fDl48NwW284gLnlQsKXcRQ9cQhHYiWP+Q=
X-Received: by 2002:a1f:d084:: with SMTP id h126mr10768426vkg.25.1585312070406;
 Fri, 27 Mar 2020 05:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200327043639.6564-1-tangbin@cmss.chinamobile.com>
In-Reply-To: <20200327043639.6564-1-tangbin@cmss.chinamobile.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 27 Mar 2020 13:27:14 +0100
Message-ID: <CAPDyKFpwJq5j0CwDN152bZkdPj4_xrL1p6raMPkHuBwWTXTTwQ@mail.gmail.com>
Subject: Re: [PATCH] mmc:cavium-octeon: remove nonsense variable coercion
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     rrichter@marvell.com,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Mar 2020 at 05:36, Tang Bin <tangbin@cmss.chinamobile.com> wrote:
>
> In this function, the variable 'base' is already 'void __iomem *base',
> and the return function 'devm_platform_ioremap_resource()' also returns
> this type, so the mandatory definition here is redundant.
>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cavium-octeon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-octeon.c
> index 916746c6c..e299cdd1e 100644
> --- a/drivers/mmc/host/cavium-octeon.c
> +++ b/drivers/mmc/host/cavium-octeon.c
> @@ -207,13 +207,13 @@ static int octeon_mmc_probe(struct platform_device *pdev)
>         base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(base))
>                 return PTR_ERR(base);
> -       host->base = (void __iomem *)base;
> +       host->base = base;
>         host->reg_off = 0;
>
>         base = devm_platform_ioremap_resource(pdev, 1);
>         if (IS_ERR(base))
>                 return PTR_ERR(base);
> -       host->dma_base = (void __iomem *)base;
> +       host->dma_base = base;
>         /*
>          * To keep the register addresses shared we intentionaly use
>          * a negative offset here, first register used on Octeon therefore
> --
> 2.20.1.windows.1
>
>
>
