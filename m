Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89E5C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DBE120857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaIksjbg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbgDQNkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 09:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730601AbgDQNkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 09:40:17 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7F0C061A0C;
        Fri, 17 Apr 2020 06:40:16 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id o1so1094636pjs.4;
        Fri, 17 Apr 2020 06:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wnlk2ZwK1m5N6yYB/PflID5LFnGTDiqO4ngZNzCKLy4=;
        b=HaIksjbgyBcP4ZgUnLvuTWtaVVACcilXyiILinmvayrM3j4LbjIWdn2GuEsDXSivVJ
         ZJ0fXZdz9Jqi5HI5HEvPmyPCKaC+K7dWVupV/HD+tSpHqeVlRrjs2/0yr4mdyl/fwg5q
         SMUvI0NMxChzwchVIUup9YIiS6DytWRauaTn3aZ8b5CrKkAHG/1LwSE1dnUpqzzG+24Y
         NIUmPimX498mFrACuJuGKiR1P5DNUA0+IpmbgcwHhaXVVuVHGfj+YVB6Ww4LmM3l5sR9
         KB1XLlJxeeOeVo/sYCbOtJvlbu1067qid5wxdDRsnRCsYJWlTybFfQc6kFRzJPWU3Svc
         ecoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wnlk2ZwK1m5N6yYB/PflID5LFnGTDiqO4ngZNzCKLy4=;
        b=Bcm6w73J+KAFepxgM0mNKlvYl9ATrMEm/SJA7YvjA62zcaE0GgeP6qhpQIB9R2vPP3
         EYUKbyz976faKuq9HOsof28LS7ZiVFxyPLCkCo0mY3TlV4vNYezNCox0mxpz6s4lW1hZ
         W+CQROvAefilP7vzanFsaXoK116AW85g5+aJ6SbdW+Vu6e/MKGJXu95TWNAgAGmTMXrx
         hY7DtlxHnzqfsjvWt0LYacYgnJbMEUr0JzN19FDvAilMfBwGICYsxnLiSxMY2zt05+Yi
         4uLenld9WTr6fnnJAoe9/v29h6LRU1+Mk2StR4joqqG02jQ6b8+qUvqRLK49KT+WUxkh
         V0QQ==
X-Gm-Message-State: AGi0Pubtn8/8SECqNHlZQ4cc8DEGNOoPATPGxAcGREKh4unJNQ0Bg5VR
        2oPHsf3fhD7NJbtHWm2rD0bcDjA9/xjM8+/mRMQ=
X-Google-Smtp-Source: APiQypL1cWbGdA5aYdvvQoq31WjSsRum39QJ9sVNwv1wGmLChKLWxCd7wGhgEM6H+K111qcpO3GjnnNnup5CevLMvag=
X-Received: by 2002:a17:90a:224b:: with SMTP id c69mr4622780pje.8.1587130816361;
 Fri, 17 Apr 2020 06:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200402071549.3304-1-yuehaibing@huawei.com>
In-Reply-To: <20200402071549.3304-1-yuehaibing@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Apr 2020 16:40:09 +0300
Message-ID: <CAHp75Vdh7O6PjogbJzTU317mhXV6yfzSGtM1F==WxnTxDccSQQ@mail.gmail.com>
Subject: Re: [PATCH -next] platform/x86: wmi: Make two functions static
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mattias Jacobsson <2pi@mok.nu>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 10:16 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fix sparse warnings:
>
> drivers/platform/x86/xiaomi-wmi.c:26:5: warning: symbol 'xiaomi_wmi_probe' was not declared. Should it be static?
> drivers/platform/x86/xiaomi-wmi.c:51:6: warning: symbol 'xiaomi_wmi_notify' was not declared. Should it be static?
>

Pushed to my review and testing queue, thanks!

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/platform/x86/xiaomi-wmi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/xiaomi-wmi.c b/drivers/platform/x86/xiaomi-wmi.c
> index 601cbb282f54..54a2546bb93b 100644
> --- a/drivers/platform/x86/xiaomi-wmi.c
> +++ b/drivers/platform/x86/xiaomi-wmi.c
> @@ -23,7 +23,7 @@ struct xiaomi_wmi {
>         unsigned int key_code;
>  };
>
> -int xiaomi_wmi_probe(struct wmi_device *wdev, const void *context)
> +static int xiaomi_wmi_probe(struct wmi_device *wdev, const void *context)
>  {
>         struct xiaomi_wmi *data;
>
> @@ -48,7 +48,7 @@ int xiaomi_wmi_probe(struct wmi_device *wdev, const void *context)
>         return input_register_device(data->input_dev);
>  }
>
> -void xiaomi_wmi_notify(struct wmi_device *wdev, union acpi_object *dummy)
> +static void xiaomi_wmi_notify(struct wmi_device *wdev, union acpi_object *dummy)
>  {
>         struct xiaomi_wmi *data;
>
> --
> 2.17.1
>
>


-- 
With Best Regards,
Andy Shevchenko
