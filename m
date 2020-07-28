Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C01DC433F2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 21:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D88FE20768
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 21:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Au1vYSzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbgG1Vho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 17:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729372AbgG1Vh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 17:37:29 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881C4C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 14:37:29 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id z17so2446396ill.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 14:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v3rg3y6YkACiXEIoKh+CleYC9RV1B8woYIuu28KMC5U=;
        b=Au1vYSzjCeHwJX24VbMmrV6FjIv1BFAOR507vujs2WCywQIeFksgxcyy0RGK8PxQrO
         Dn6c5YRpP8ZPZbSqc0XGjSaUkXxZPTIS6DLELa/60Vs33uYWgWeTTB6dWa6mEikqUI1U
         9utOWGiUO65V4gy3fX0lsDDYogHc+D7wg7k5I/89LtredY4xtoVqip6kv3lQOtd0PIJ0
         scyEt1q0UrmwqVjWkRIzhHrFWt39bnxI7hDrPkJd/uvp/UN7/kNmJXHD12yVxcI6buqc
         VYpIphXovb9bPdhp9X/ju7CIn5XXFhuh84sLJSTHRe66tjqsTVaOVUZAnDU3X4GMMIcA
         pCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v3rg3y6YkACiXEIoKh+CleYC9RV1B8woYIuu28KMC5U=;
        b=YVeHYEdbLnMdHXDO+tfS0LZ2q3ysvcnhRAYWjY5mG57NqzQ4RPiQk3XbypRe9bYux0
         OIXfTEk0uwKBf5h+VjnvOKxdObJnMa7m3kRWYiujS4peZZpFpMv6Sk1+tPVeAMHRypWw
         vpX3kpYyOLeJo9JKWy46mE3a9gP5ysshOGurNiuxti4YCNe6ljuNJNlvbNNTzwGrXye9
         11zQBtiXhBO9MCblR9nSslddjaFlKeu1knkfeGxQuRusSkxm8RgMKB1/NO1Qo6AgBdfs
         x3EMQRnA0ss0RAW81i5MS6Dm+X+l+VyVAM4D97h7XR3/ZqhMPFHQYVZO/wy/0ceZOE94
         BnlA==
X-Gm-Message-State: AOAM531wMmtwFCOWgMDzYurf650fF7Wma+J4FO9zg3IwO9jCn85Ukyng
        FgzYzX2JYq3k91UUVsdIWIGceMA1pYCOmSCg1F/JzA==
X-Google-Smtp-Source: ABdhPJxWWdwC/AXVB7Mk2kEB2dtyvEtibgv4DmaY8Kj2O+d++IoXXh/hLyf1BS97mgq+ai+1IHViL6YLTyHk4mFZ1M4=
X-Received: by 2002:a92:cb07:: with SMTP id s7mr13858295ilo.58.1595972248866;
 Tue, 28 Jul 2020 14:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200727015054.8351-1-vulab@iscas.ac.cn>
In-Reply-To: <20200727015054.8351-1-vulab@iscas.ac.cn>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 28 Jul 2020 15:37:18 -0600
Message-ID: <CANLsYkzT0b-zntPm=3Q4dL91oiqfojtaYL+aFNc1Rv__fzkNZQ@mail.gmail.com>
Subject: Re: [PATCH] coresight: Use devm_kcalloc() in coresight_alloc_conns()
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jul 2020 at 19:51, Xu Wang <vulab@iscas.ac.cn> wrote:
>
> A multiplication for the size determination of a memory allocation
> indicated that an array data structure should be processed.
> Thus use the corresponding function "devm_kcalloc".
>
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---
>  drivers/hwtracing/coresight/coresight-platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index e4912abda3aa..d1460b6e4e07 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -27,7 +27,7 @@ static int coresight_alloc_conns(struct device *dev,
>                                  struct coresight_platform_data *pdata)
>  {
>         if (pdata->nr_outport) {
> -               pdata->conns = devm_kzalloc(dev, pdata->nr_outport *
> +               pdata->conns = devm_kcalloc(dev, pdata->nr_outport,

https://lkml.org/lkml/2020/5/27/1098

>                                             sizeof(*pdata->conns),
>                                             GFP_KERNEL);
>                 if (!pdata->conns)
> --
> 2.17.1
>
