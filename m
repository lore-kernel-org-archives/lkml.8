Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF5AC18E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C4A20409
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HO/ehg7m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgCYIaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:30:01 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34563 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgCYIaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:30:01 -0400
Received: by mail-oi1-f194.google.com with SMTP id e9so1373370oii.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 01:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/JBGauGWYFvkK7q5OmebJs2hWQAW6CIeFHaswGKD4/w=;
        b=HO/ehg7mYsypcz7OGBQEKHNsFOpTWMwUPrGXUNAvT+c5vk3AMTWPVfl4nDaG7cVTZJ
         QMUDF5oaw79dgJ85aVNDKIq3eWy1EMTm/zflg3CvyvRPpqfGCc0z6YWVfkh2t5Earz3L
         7+MFXZyF5UQxEX+2Xw29YSL4OkKdqmlI9NfLReCO6ivwtq1C60ZH2kowSsx1Sf0JmZkk
         WiGyXQTjZugPiDYLpJE7o8m/pem8O5x5y1uNq+1UtyOv3P3bZcFGkk+YgfxGuZvgm4s4
         /AbKITZIlObckZzFd+XSIQWZ3Y0deccg9LUcP8b2YQtcywFwT1/PiuNHXyNEiewKjVZy
         7Y3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/JBGauGWYFvkK7q5OmebJs2hWQAW6CIeFHaswGKD4/w=;
        b=CAw7RAMN1AYsSdF1ajzbJSuHnoMovW8YnRz8z/6bBV8fW7ZTzseVx+yuBJiEWq7SIu
         /BAZdtSv2O94+s1NRtO7FO0Sx2mrlGAZQv63yHWGwC6GCdwD24cb4umwgDGQc+2U2YwU
         sTqy+PLBOK7J+jTcEJk96EMh7IELzsXu3lm9PeKFVJuZpERw+gfXrNIddjek5bADicbq
         Hr2U+8FOgkA/GhNzUYTx0XgOEDXc2GS4YTQ7PjG08wGsKzJrNsnA3T2rkG//JvUqKPXz
         A7L0Z7s6jXV/5aGrNcfEdkRBKnOyE7HiUXBZroSI9/KRtC8IW2LAc+6QLeZb05/Lq6Pp
         vRuQ==
X-Gm-Message-State: ANhLgQ0n6UNUsGmR7nM4aAJungcc87Uo/IyNA4WSrmd7n03JmDT0yqWX
        Tr40BSnUrTSBdcdVuQOpQ/0cOEIPRI232L3KFFGR2ntXcWc=
X-Google-Smtp-Source: ADFU+vvH1zDd/bZWc2cDCtV3hemiN7ZRhuZJ3TE0FoMAMQc0nLsbFOWhV2wn6aEJpHFGJ53mciqpZbZdLgzxpsXfTYk=
X-Received: by 2002:aca:d489:: with SMTP id l131mr1710135oig.5.1585125000342;
 Wed, 25 Mar 2020 01:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <1584965910-19068-1-git-send-email-sumit.garg@linaro.org> <1584965910-19068-2-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1584965910-19068-2-git-send-email-sumit.garg@linaro.org>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 25 Mar 2020 09:29:49 +0100
Message-ID: <CAHUa44H_r=ttJphjOJRyAtSkzA8j3ZE7jG5a7G3FKCHqr8Tvjw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] tee: enable support to register kernel memory
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stuart Yoder <stuart.yoder@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,

On Mon, Mar 23, 2020 at 1:19 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Enable support to register kernel memory reference with TEE. This change
> will allow TEE bus drivers to register memory references.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/tee/tee_shm.c   | 26 ++++++++++++++++++++++++--
>  include/linux/tee_drv.h |  1 +
>  2 files changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 937ac5a..b88274c 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -9,6 +9,7 @@
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/tee_drv.h>
> +#include <linux/uio.h>
>  #include "tee_private.h"
>
>  static void tee_shm_release(struct tee_shm *shm)
> @@ -218,13 +219,14 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
>  {
>         struct tee_device *teedev = ctx->teedev;
>         const u32 req_flags = TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED;
> +       const u32 req_ker_flags = TEE_SHM_DMA_BUF | TEE_SHM_KERNEL_MAPPED;

I'd prefer naming these two "req_user_flags" and "req_kernel_flags".

Thanks,
Jens

>         struct tee_shm *shm;
>         void *ret;
>         int rc;
>         int num_pages;
>         unsigned long start;
>
> -       if (flags != req_flags)
> +       if (flags != req_flags && flags != req_ker_flags)
>                 return ERR_PTR(-ENOTSUPP);
>
>         if (!tee_device_get(teedev))
> @@ -259,7 +261,27 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
>                 goto err;
>         }
>
> -       rc = get_user_pages_fast(start, num_pages, FOLL_WRITE, shm->pages);
> +       if (flags & TEE_SHM_USER_MAPPED) {
> +               rc = get_user_pages_fast(start, num_pages, FOLL_WRITE,
> +                                        shm->pages);
> +       } else {
> +               struct kvec *kiov;
> +               int i;
> +
> +               kiov = kcalloc(num_pages, sizeof(*kiov), GFP_KERNEL);
> +               if (!kiov) {
> +                       ret = ERR_PTR(-ENOMEM);
> +                       goto err;
> +               }
> +
> +               for (i = 0; i < num_pages; i++) {
> +                       kiov[i].iov_base = (void *)(start + i * PAGE_SIZE);
> +                       kiov[i].iov_len = PAGE_SIZE;
> +               }
> +
> +               rc = get_kernel_pages(kiov, num_pages, 0, shm->pages);
> +               kfree(kiov);
> +       }
>         if (rc > 0)
>                 shm->num_pages = rc;
>         if (rc != num_pages) {
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 7a03f68..dedf8fa 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -26,6 +26,7 @@
>  #define TEE_SHM_REGISTER       BIT(3)  /* Memory registered in secure world */
>  #define TEE_SHM_USER_MAPPED    BIT(4)  /* Memory mapped in user space */
>  #define TEE_SHM_POOL           BIT(5)  /* Memory allocated from pool */
> +#define TEE_SHM_KERNEL_MAPPED  BIT(6)  /* Memory mapped in kernel space */
>
>  struct device;
>  struct tee_device;
> --
> 2.7.4
>
