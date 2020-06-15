Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDE6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E0A7204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BauVPoy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgFOIIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728782AbgFOIIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:08:24 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B030C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 01:08:24 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q8so14871974qkm.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 01:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VdhQIqsA76M/Q33FgsDVqlY0C8ahxL1l23f83ZhasWY=;
        b=BauVPoy18r5Ja+XGXEFsim5pmCPUyMhnejZLHUj0k3XMJEuNoeusyhSt4/yuE9zccG
         /bbwwKWRd5U9e7DFvXo94AmRf4ZT/Sy8wxIa0WqUfRIdtM8+3PxPIGgGZDZ7Vh3SYYbK
         K79hViEWQKSjAGTZ/Ra4lE4BEsK8uBrS9GI3U9a0dfPnICySLMuH3S5BDWKBR46JkaJk
         VP0TeeKtBrZBcj/NldzPmSJzP/jTu494o9ZUJD7RrE7c9+8B0VhY8elkze24uPHTjMTp
         mWDlHzyBYiTOY0Wx6vjSKjHBpUXURgi5a3Xra9YUnsmbCV5RRyd9E23zy6DQT/H2czPt
         G4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VdhQIqsA76M/Q33FgsDVqlY0C8ahxL1l23f83ZhasWY=;
        b=c/RbvO2G1iG68QRbzU21R8MgfXWjCPAGNDMbx8rj7tkQ3oRNwWs0xlKqflpDuu7h4S
         kLe0EMApHtwVqEDjr4PhEmBSXLUPIgpm+jQu5qYrX3ldoFqzevSJHT02mzRIFPGUGb+E
         COkStMZwWP9BiRlHhinFQWAHDjY70+S4T7N6oO8cM4j1pSykJ8M/TKi+ANC9kIQhlEAd
         LIJf95iAeqmp8mA9LhZVMCf/jcQCBmGMox1MTSjv9mPo6TEGqzDwB6/nbmlogb1syKog
         hLnZxmmKsTEo+s5UjJyUa3T0kUGrLGIPQ8KunF/53RSVt549/+aE1RLiot7fm8bWn6SI
         G3gA==
X-Gm-Message-State: AOAM530+ftZoHuxlU+2fWWH+5xAPTkjJGdAMoSyywZfk+ajISKoMGULR
        CcA4CfJa1gqGo4mG3prsy5Ueuq2M8uvaZ9qG6IfXjeLF
X-Google-Smtp-Source: ABdhPJyLaWl+p30tdGKH+xZMF+rsvnwvp/cxVLk6ifiZV+32iNbZddkugVBi585j6FMBjy19240oFpE00d8m/HcEsps=
X-Received: by 2002:a37:a643:: with SMTP id p64mr13171662qke.21.1592208503807;
 Mon, 15 Jun 2020 01:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <1591949145-17098-1-git-send-email-wangqing@vivo.com>
In-Reply-To: <1591949145-17098-1-git-send-email-wangqing@vivo.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 15 Jun 2020 10:08:13 +0200
Message-ID: <CAMpxmJVBKnRinJuh7scvUCV4gci3A_7p=LW9n5yhc+RC6aipbQ@mail.gmail.com>
Subject: Re: [PATCH] drivers\gpio: use kobj_to_dev
To:     Wang Qing <wangqing@vivo.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 12 cze 2020 o 10:05 Wang Qing <wangqing@vivo.com> napisa=C5=82(a):
>
> Use kobj_to_dev() API instead of container_of().
>
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  drivers/gpio/gpiolib-sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  mode change 100644 =3D> 100755 drivers/gpio/gpiolib-sysfs.c
>
> diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
> index 23e3d33..82371fe
> --- a/drivers/gpio/gpiolib-sysfs.c
> +++ b/drivers/gpio/gpiolib-sysfs.c
> @@ -365,7 +365,7 @@ static DEVICE_ATTR_RW(active_low);
>  static umode_t gpio_is_visible(struct kobject *kobj, struct attribute *a=
ttr,
>                                int n)
>  {
> -       struct device *dev =3D container_of(kobj, struct device, kobj);
> +       struct device *dev =3D kobj_to_dev(kobj);
>         struct gpiod_data *data =3D dev_get_drvdata(dev);
>         struct gpio_desc *desc =3D data->desc;
>         umode_t mode =3D attr->mode;
> --
> 2.7.4
>

Patch applied, thanks!

Bartosz
