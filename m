Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D098C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 22:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC3B62070B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 22:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Duthh2st"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgGXWCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 18:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgGXWCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 18:02:38 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F994C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 15:02:38 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id q15so5667596vso.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 15:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DGzC+sVdjHSu3GhMjbQg0qh4uA4cJT945O2o3Z2Av+I=;
        b=Duthh2stsQSdK8VnX81qLigVLWKcai2/zxrcazQ226LqX4/Hf1SEtz0LOwfBg+u72L
         Id1NqmpRjVHC60o3JRr1yd2uuOC2SFgUAJjvb30Qb94tGZ5wnHxmtuV2ETMbKrCrx9FQ
         EegBSyKwEMTpwVTCJt15UDY1/63ElhyJ26QC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DGzC+sVdjHSu3GhMjbQg0qh4uA4cJT945O2o3Z2Av+I=;
        b=m0I4Y0CjDv3mZ0MUlDeXtwcevirc/8j2l6zUOm8agxHI/yxgjFqauWnAIV9iOB1K7S
         Z2/bbwD7O128p8QEfvkqw2JvjN6Xw+1nENQDLdI4PXGiAg3kO7EAaTmNNDhGGb0/3cIi
         ExM6hQs+lwdY67KNwGhiROT4b1BZnYj8GepUL3wvte1/xzBfjZC5R4zP74MKsRjxyYV7
         +5ejfMWvCcIssKteJo91xl7VezTY8S2RO3PCl4kZusajEni2IXZISdIda44aUiESOV4i
         WtblPsHtTM+qjJzdp1LYGbG4s4Lm228zD+nU9HJY8Zayyyvg+p06bGE/g5pDKTp7+AFM
         86iA==
X-Gm-Message-State: AOAM5314xpWKApl6LfFnGR1S92WgKPx3/IrwLD4DCS4gNA0XJNPd4jaY
        ZMHlp4ZD7ReYwZJKTuuZFBoWpzCu8G4=
X-Google-Smtp-Source: ABdhPJwVjwbLKBKWRNrfaYITVWilblImv6AbnId9dVBIO4ZWg4kMRftuTxkhoLVhiOozMqJS+gpSbA==
X-Received: by 2002:a67:f654:: with SMTP id u20mr9775003vso.203.1595628156740;
        Fri, 24 Jul 2020 15:02:36 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id b201sm279281vke.54.2020.07.24.15.02.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 15:02:35 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id r63so3415198uar.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 15:02:35 -0700 (PDT)
X-Received: by 2002:ab0:44e5:: with SMTP id n92mr9883887uan.121.1595628155128;
 Fri, 24 Jul 2020 15:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200724213329.899216-1-swboyd@chromium.org> <20200724213329.899216-6-swboyd@chromium.org>
In-Reply-To: <20200724213329.899216-6-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Jul 2020 15:02:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WKTsCB=7rDSgjqE5w00SsayBd5OT9O65sjkiM9crS5aQ@mail.gmail.com>
Message-ID: <CAD=FV=WKTsCB=7rDSgjqE5w00SsayBd5OT9O65sjkiM9crS5aQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] iio: sx9310: Enable vdd and svdd regulators at probe
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 24, 2020 at 2:33 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Enable the main power supply (vdd) and digital IO power supply (svdd)
> during probe so that the i2c communication and device works properly on
> boards that aggressively power gate these supplies.
>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Daniel Campello <campello@chromium.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/iio/proximity/sx9310.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index 1e1f6bba50f6..ad6ed100c7a6 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -19,6 +19,7 @@
>  #include <linux/of.h>
>  #include <linux/pm.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>
>  #include <linux/iio/buffer.h>
> @@ -899,12 +900,21 @@ static int sx9310_set_indio_dev_name(struct device *dev,
>         return 0;
>  }
>
> +static void sx9310_regulator_disable(void *supplies)
> +{
> +       regulator_bulk_disable(2, supplies);
> +}
> +
>  static int sx9310_probe(struct i2c_client *client,
>                         const struct i2c_device_id *id)
>  {
>         int ret;
>         struct iio_dev *indio_dev;
>         struct sx9310_data *data;
> +       struct regulator_bulk_data supplies[] = {
> +               { .supply = "vdd" },
> +               { .supply = "svdd" },
> +       };
>
>         indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>         if (indio_dev == NULL)
> @@ -919,6 +929,23 @@ static int sx9310_probe(struct i2c_client *client,
>         if (IS_ERR(data->regmap))
>                 return PTR_ERR(data->regmap);
>
> +       ret = devm_regulator_bulk_get(&client->dev, ARRAY_SIZE(supplies), supplies);
> +       if (ret)
> +               return ret;
> +
> +       ret = regulator_bulk_enable(ARRAY_SIZE(supplies), supplies);
> +       if (ret)
> +               return ret;
> +       /* Must wait for Tpor time after initial power up */
> +       usleep_range(1000, 1100);
> +
> +       /* Update sx9310_regulator_disable() size if this bug is hit */
> +       BUILD_BUG_ON(ARRAY_SIZE(supplies) != 2);
> +       ret = devm_add_action_or_reset(&client->dev, sx9310_regulator_disable,
> +                                      supplies);

...but, but...  Aren't you storing a pointer to stack memory?  How
does that work?  I think you either need to store the "struct
regulator_bulk_data" in your private data or just make two normal
regulator calls.

-Doug
