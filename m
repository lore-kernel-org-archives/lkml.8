Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D4CC18E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8022073E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZIVMvQHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbgCYId5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:33:57 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46706 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgCYId5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:33:57 -0400
Received: by mail-ot1-f66.google.com with SMTP id 111so1135512oth.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 01:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FJHGef/EtWaLVVnexBqS74xlLLuhu+RMGQ/OYQ44duc=;
        b=ZIVMvQHZp99+uoK7d0Yrzn17aHwV6NxDZb+iYTATVwKWxDA5yAwJT88cp1cL3iX/Qa
         8XTG1ENI+AOcD8u/CLP64CGmgx9O4b2XEatQLIv5dejkD/1FdZlG9rrYj8smRXvH4sqS
         W+l4GeZqVew7FN7xichaimos8sawJFAu089MSEm92s2dl7H67gE3qJujxC2IFzDLp3js
         wMo+Hylrv+3KwaMxf0uBfRtOAUSbthJZltu5jZSJD+GLMKhoEuL3juAe3LgRubJfv8o7
         OhFPjQMwqZbpD2dbgq9qTYrfJ7FKykJeHJ9K7ejTCrEr272elgxoYFgCW8C99LcmTHzI
         Km0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FJHGef/EtWaLVVnexBqS74xlLLuhu+RMGQ/OYQ44duc=;
        b=BzPiBuLCy+B1SkvmMikPQSsbhXv9stCxkhu3ZbJNVAQIkxtdma+siyzrjll9ZdieSL
         fktP9VBVuCuP6fSXIoaDQ9+Zq/jt3w7iLZWN72pWlFBH4FceEuPgflfoDdEANx2YYXK3
         Eql/RJmdttBYnoIQTsXdpdHkS3HSWhOtlhyRT2tUOFnW1IPhtFbnKyAIg5xn5XZy1LsU
         xWpO1/pIF2yN5AIA4/UIRzBXoBJlRGsZqJt03+JzxjL9Yrqy6S8COhECg2ymc8js2eec
         acHU8n3jxlK8ApKeXxkd28mpxIqCV6KMN5Hqp0RaPRkdHziwU75E8Op9oQGIhX4NJWUk
         2Z/g==
X-Gm-Message-State: ANhLgQ36gEcLoOrWJ32+/eS6pDpVdMRCKVWN+2zfN1Q36nk53SILIVQQ
        Aavjyypa+bVw2QwLZvJJQo1/J57mvERw1yP2z37wQw==
X-Google-Smtp-Source: ADFU+vsyet6PJwmelZB0kHEg09F8xbMLitmgUquIPYDgBQdp5+jzN/ZP9IYr0DU5P2Q+gOGVZ08bxzsAMym9vqLXfV0=
X-Received: by 2002:a9d:6945:: with SMTP id p5mr1669394oto.268.1585125236058;
 Wed, 25 Mar 2020 01:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <1584965910-19068-1-git-send-email-sumit.garg@linaro.org> <1584965910-19068-3-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1584965910-19068-3-git-send-email-sumit.garg@linaro.org>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 25 Mar 2020 09:33:45 +0100
Message-ID: <CAHUa44Fd3ujQY8ev9sZOMya7wrTmHnvda_05XhQA7X3knB3auA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] tee: add private login method for kernel clients
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

On Mon, Mar 23, 2020 at 1:19 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> There are use-cases where user-space shouldn't be allowed to communicate
> directly with a TEE device which is dedicated to provide a specific
> service for a kernel client. So add a private login method for kernel
> clients and disallow user-space to open-session using GP implementation
> defined login method range: (0x80000000 - 0xFFFFFFFF).
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/tee/tee_core.c   | 6 ++++++
>  include/uapi/linux/tee.h | 8 ++++++++
>  2 files changed, 14 insertions(+)

Looks good.

Thanks,
Jens

>
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 37d22e3..533e7a8 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -334,6 +334,12 @@ static int tee_ioctl_open_session(struct tee_context *ctx,
>                         goto out;
>         }
>
> +       if (arg.clnt_login & TEE_IOCTL_LOGIN_MASK) {
> +               pr_debug("login method not allowed for user-space client\n");
> +               rc = -EPERM;
> +               goto out;
> +       }
> +
>         rc = ctx->teedev->desc->ops->open_session(ctx, &arg, params);
>         if (rc)
>                 goto out;
> diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
> index 6596f3a..19172a2 100644
> --- a/include/uapi/linux/tee.h
> +++ b/include/uapi/linux/tee.h
> @@ -173,6 +173,14 @@ struct tee_ioctl_buf_data {
>  #define TEE_IOCTL_LOGIN_APPLICATION            4
>  #define TEE_IOCTL_LOGIN_USER_APPLICATION       5
>  #define TEE_IOCTL_LOGIN_GROUP_APPLICATION      6
> +/*
> + * Disallow user-space to use GP implementation specific login
> + * method range (0x80000000 - 0xFFFFFFFF). This range is rather
> + * being reserved for REE kernel clients or TEE implementation.
> + */
> +#define TEE_IOCTL_LOGIN_MASK                   0x80000000
> +/* Private login method for REE kernel clients */
> +#define TEE_IOCTL_LOGIN_REE_KERNEL             0x80000000
>
>  /**
>   * struct tee_ioctl_param - parameter
> --
> 2.7.4
>
