Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23444C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F345B2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgGTJyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:54:19 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42742 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728308AbgGTJyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:54:19 -0400
Received: by mail-lf1-f67.google.com with SMTP id h8so1145194lfp.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 02:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8TgvaC7/oHKGtUBrzwRuyP7O62U/sEWXhQcMJb1TPmA=;
        b=W+mwoqrM8I+Caxi7ssXWVk9Q+Y3kdjBi0OoyWiCu+P5qjGUvLGhT9UA1bJfoNTg6sk
         3vL2fMy7q+WGUTKLHX9vx9CKLVskf8gQBX/dbAme8W0BoB5nymkjzAceVTRuvpogS/B5
         xXlTsUT0Dkh+Ns8wdEdb4L7a16KC34/zv5CNHvQUaDqsylX88x/q50KXNkn/kc3ByexF
         ChoUsm1vYPKLbTnQygFQq5coRY4d3ZYW5IQb8MQIs9aDsM6afw8rAkZQHvusNR+n8T1C
         fjBsC0830QbvtGa59x5my0kYpY9/HWi43LytnpIwEPs8j9Pn1u6siJBCsZgwsKEDp7vp
         yaiQ==
X-Gm-Message-State: AOAM532SBLQfx2XRHe7aHDZCIipZzodfAzGYbMSC/qmT5CMJnW1uW9Mx
        OGaGP2VOExXFOkrihNKlQffI1X8jbjM=
X-Google-Smtp-Source: ABdhPJx9ANsNyliwsM+8WVE2ASKm2wRH+OAu3ZKJ64cwbW8C4P1Ur+UBwdmjPSAZ8JbUjAhgLq7IXQ==
X-Received: by 2002:ac2:5984:: with SMTP id w4mr10543815lfn.28.1595238856442;
        Mon, 20 Jul 2020 02:54:16 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id r25sm3709761ljg.9.2020.07.20.02.54.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 02:54:16 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id r19so19463217ljn.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 02:54:16 -0700 (PDT)
X-Received: by 2002:a2e:3a14:: with SMTP id h20mr9503033lja.331.1595238855983;
 Mon, 20 Jul 2020 02:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200720094449.32282-1-wens@kernel.org>
In-Reply-To: <20200720094449.32282-1-wens@kernel.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 20 Jul 2020 17:54:04 +0800
X-Gmail-Original-Message-ID: <CAGb2v65RDqrHxGPOkrNvjd2v8=bLmBaK61rvQ-dN1bbvSs1MQg@mail.gmail.com>
Message-ID: <CAGb2v65RDqrHxGPOkrNvjd2v8=bLmBaK61rvQ-dN1bbvSs1MQg@mail.gmail.com>
Subject: Re: [PATCH] reuglator: gpio: Honor regulator-boot-on property
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please ignore this one. I'll send v2 shortly.

On Mon, Jul 20, 2020 at 5:44 PM Chen-Yu Tsai <wens@kernel.org> wrote:
>
> From: Chen-Yu Tsai <wens@csie.org>
>
> When requesting the enable GPIO, the driver tries to do so with the
> correct output level matching the current state. This is done by
> checking the boot_on constraint, which is derived from the
> regulator-boot-on property in the device tree. This is especially
> important if the regulator is a critical one, such as a supply for
> the boot CPU.
>
> Honor the regulator-boot-on property by checking the boot_on
> constraint setting. This is the same as what is done in the fixed
> regulator driver.
>
> Also drop support for the undocumented enable-at-boot property. This
> property was not documented in the original commit introducing DT
> support, nor is it now, and there are no in-tree device trees that use
> this property.

I'll rework the commit log so it makes more sense. (and fix the typo ...)

ChenYu

> Fixes: 006694d099e8 ("regulator: gpio-regulator: Allow use of GPIO controlled regulators though DT")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/regulator/gpio-regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
> index 110ee6fe76c4..5646b7a26288 100644
> --- a/drivers/regulator/gpio-regulator.c
> +++ b/drivers/regulator/gpio-regulator.c
> @@ -148,7 +148,7 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np,
>
>         config->supply_name = config->init_data->constraints.name;
>
> -       if (of_property_read_bool(np, "enable-at-boot"))
> +       if (config->init_data->constraints.boot_on)
>                 config->enabled_at_boot = true;
>
>         of_property_read_u32(np, "startup-delay-us", &config->startup_delay);
> --
> 2.27.0
>
