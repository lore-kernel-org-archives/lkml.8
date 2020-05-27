Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1318C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8824B208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ue2h3jU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389014AbgE0P6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbgE0P6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:58:16 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2054CC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 08:58:16 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id q8so25123805iow.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 08:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2KPqlFHIaFhXtFQPvI4kGCnPDvEbmm2Nd6KaCmQEOqI=;
        b=Ue2h3jU4f/LBJYIl5gzQnW6cFNCOrZdqN7G+mrLx2xOGYGPx/CgSI78VNT8fRU9xq0
         lkqDwqHymn6uTiXkL2sB3Jv/jYk+VIahOCjFbKqx8Se6imQdjZZUsQFWoJWcIDQeqDk5
         /GnqOXT52GNJbnAJAVHjKsaA7r+TEhvfYyGLNjgh/ZMUanZ2wJ1iKUHTICzXVF7Kg0X3
         gq28gtfdxSplbXNONiMr/re5nk3r/bGumjn/tgmz48H8r/lbMOrYi+fNZKL7nbkrscRw
         ee3POVIFcVhS0M75LB0rtu5A2OAsHWylRbguOty3S23SpgXlSpQ6t0xRaprA1Kp3ZIS7
         GMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2KPqlFHIaFhXtFQPvI4kGCnPDvEbmm2Nd6KaCmQEOqI=;
        b=GOR09HM0acRGsbuuJdCpbJjN7UFuql6/+ypV4OTQl4ox9z1LTO1B4XNR2ckmOuDRxd
         AhNPtXd11gUQZoAHP0Er/iunqc6Tt4vvBJm/kVXyRrur1kQtQPqUHsXhGYZDUEpHWVsy
         D894sxwInPr0VfJWZG3vy2NFEHKcY58qZkdxEx+bfvKZi7/H4/G2EFPrlhwqItk3QyD6
         gZZ9qWKJh6A8yjoj/jh0vGiy2RFlB80JkKkILCaJPL/N+TK1Jdyzih+ni068Uv9EKvFH
         tcBTXdOYupuxka+sRkyLhxUf3PkWJu9ZoZJXJTEhvbe0XBF2LcPpxhUa3T9LkzKSUJay
         0l7Q==
X-Gm-Message-State: AOAM5323gQT1+sXhZwVBD+JyBH4E/FNK42qGfxirTQkQXY5raksQrgm+
        njqSmdvxI5O8Qy7cxVgA44dwMJaWq6MTW/zfcEAL8w==
X-Google-Smtp-Source: ABdhPJwEacnpf6hd8M9CKQVk2EmgBvTRIgmuQRIOr4WGHoTCA7OXr3+tw4e5T7AV1FeZN+6cRErbAP2GfUUpHfxEDg0=
X-Received: by 2002:a05:6602:2e96:: with SMTP id m22mr21995431iow.165.1590595095340;
 Wed, 27 May 2020 08:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200526055241.2671-1-vulab@iscas.ac.cn>
In-Reply-To: <20200526055241.2671-1-vulab@iscas.ac.cn>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 27 May 2020 09:58:04 -0600
Message-ID: <CANLsYkxU-Srbu+-GT13cVfUqjE4GOGhtkxZgKfxGz+P=n1BB7A@mail.gmail.com>
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

On Mon, 25 May 2020 at 23:53, Xu Wang <vulab@iscas.ac.cn> wrote:
>
> A multiplication for the size determination of a memory allocation
> indicated that an array data structure should be processed.
> Thus use the corresponding function "devm_kcalloc".
>
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---
>  drivers/hwtracing/coresight/coresight-platform.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 43418a2126ff..6720049409f3 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -27,9 +27,8 @@ static int coresight_alloc_conns(struct device *dev,
>                                  struct coresight_platform_data *pdata)
>  {
>         if (pdata->nr_outport) {
> -               pdata->conns = devm_kzalloc(dev, pdata->nr_outport *
> -                                           sizeof(*pdata->conns),
> -                                           GFP_KERNEL);
> +               pdata->conns = devm_kcalloc(dev, pdata->nr_outport,
> +                                           sizeof(*pdata->conns), GFP_KERNEL);

I have applied your patch.

Thanks,
Mathieu

>                 if (!pdata->conns)
>                         return -ENOMEM;
>         }
> --
> 2.17.1
>
