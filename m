Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A4DC433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 13:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1682E207DA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 13:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598707377;
	bh=JrW3phSyO7/tjND730C4AAWV/GZaE1G6sgDn0C6AGm0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=T7sHiNTRIAGW3tjulbbyzJnU9+eYOT1h+E6eNgGKTb1OzTIf4YtMqBBihFh2efalP
	 37SkO4FgnckuC/rUdGdWzLdSLUSeVhGkwxC6i4MJ4aoWphASAre/r+ACWJnjjPBTNc
	 E7EsLrPWe6OWNMxrEQVDFwdGHWGgNf7/LUmv8xQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgH2NWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 09:22:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbgH2NKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 09:10:34 -0400
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B8D5204FD
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 13:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598706632;
        bh=JrW3phSyO7/tjND730C4AAWV/GZaE1G6sgDn0C6AGm0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bZcf9hlXfjYogWKjUCIkT90Qz3fzpTOhcPETkI3diI2WYFVVQAr8bqva4D+sxztPe
         Pus1Xgxinv+kqBPWZDJPLFSG930DlP9EsZ9HVVAAfj3qXPZJzihbnxWAiFZjV0UUtg
         NMnShvXo+3eU27PPvCcr1SjBxAuNG8GpcoqzEUVk=
Received: by mail-lj1-f178.google.com with SMTP id v12so1811866ljc.10
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 06:10:32 -0700 (PDT)
X-Gm-Message-State: AOAM5311sZDpo/JgtTkAWyxWYQOOc5KgP7mIJBU0Zbu0zkwPlHirke+u
        51txKPM6F59fRVFfTJ7ibUZX6j6WUmVjP9KCnQ8=
X-Google-Smtp-Source: ABdhPJz9uM5iJYg87lYZYURENN1qfhTQU4jEwvASwAKwiHb3/utbt/2g3WL9li2GUDKPk+xijfSWCc+hxZNqSsJceEk=
X-Received: by 2002:a2e:320c:: with SMTP id y12mr1460478ljy.399.1598706630590;
 Sat, 29 Aug 2020 06:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200828151337.6748-1-krzk@kernel.org>
In-Reply-To: <20200828151337.6748-1-krzk@kernel.org>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Sat, 29 Aug 2020 22:09:53 +0900
X-Gmail-Original-Message-ID: <CAGTfZH0zaB6N8Ck_q8RPt_JMtWXWxGzTNHq+W6Dv15b7nCixEA@mail.gmail.com>
Message-ID: <CAGTfZH0zaB6N8Ck_q8RPt_JMtWXWxGzTNHq+W6Dv15b7nCixEA@mail.gmail.com>
Subject: Re: [PATCH] extcon: palmas: Simplify with dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 12:15 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and the error value gets printed.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/extcon/extcon-palmas.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-palmas.c
> index e8e9eebe6b1d..a2852bcc5f0d 100644
> --- a/drivers/extcon/extcon-palmas.c
> +++ b/drivers/extcon/extcon-palmas.c
> @@ -205,21 +205,15 @@ static int palmas_usb_probe(struct platform_device *pdev)
>
>         palmas_usb->id_gpiod = devm_gpiod_get_optional(&pdev->dev, "id",
>                                                         GPIOD_IN);
> -       if (PTR_ERR(palmas_usb->id_gpiod) == -EPROBE_DEFER) {
> -               return -EPROBE_DEFER;
> -       } else if (IS_ERR(palmas_usb->id_gpiod)) {
> -               dev_err(&pdev->dev, "failed to get id gpio\n");
> -               return PTR_ERR(palmas_usb->id_gpiod);
> -       }
> +       if (IS_ERR(palmas_usb->id_gpiod))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(palmas_usb->id_gpiod),
> +                                    "failed to get id gpio\n");
>
>         palmas_usb->vbus_gpiod = devm_gpiod_get_optional(&pdev->dev, "vbus",
>                                                         GPIOD_IN);
> -       if (PTR_ERR(palmas_usb->vbus_gpiod) == -EPROBE_DEFER) {
> -               return -EPROBE_DEFER;
> -       } else if (IS_ERR(palmas_usb->vbus_gpiod)) {
> -               dev_err(&pdev->dev, "failed to get vbus gpio\n");
> -               return PTR_ERR(palmas_usb->vbus_gpiod);
> -       }
> +       if (IS_ERR(palmas_usb->vbus_gpiod))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(palmas_usb->vbus_gpiod),
> +                                    "failed to get id gpio\n");
>
>         if (palmas_usb->enable_id_detection && palmas_usb->id_gpiod) {
>                 palmas_usb->enable_id_detection = false;
> --
> 2.17.1
>

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
