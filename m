Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA18C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A1E32070B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XRSTbN39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgGXUZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbgGXUZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:25:15 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5A0C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:25:15 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id m18so2484707vkk.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xw0VogwRVAWx0Lb43RAqoeDJMMc+QTpBoKmnYilS2RQ=;
        b=XRSTbN397Lv5HHeBf0PTYdl5iZd1rOmSedSKhkZaHsHrh0GxxjtX6b4nTdhpWg0BFI
         QnTIUOT/ZAHwdv0qgtmzjoLu3kZPzEGgUctp+z9cRRhiKuJ9a9r8bbHcEzwxH7zko8Xj
         ie414LEULBOk/M6drV0y6T8EIUXoAB62lbyLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xw0VogwRVAWx0Lb43RAqoeDJMMc+QTpBoKmnYilS2RQ=;
        b=MnAEnFUlfzk9BsQn79AEfnUAQkPxItBwiqS1fqysqCoBPfCNkDM4MnvTS6MikCd1JQ
         2Pe9R8VNb05K3JESxvLFVNIPZZcbfWK4ae1SSrHCvtZX96auwPcto8Pq0q4b+6cpGk8X
         czvWTqkXVPzPmOk5Qn1Fnfg0tUf29NkfKHqyHlqsd/UYdeQQbKY/k+ZdRzNqsU5XUzXc
         U+0CdFXWwImp2jtq/5uDLPuESzOrAS5x2f5vhbw/dSU6AowUm7sokedlt1EfoTqhVRq1
         YswdwOPUMawmvK4plAtQS0QkwovAZN/NDxD0i0sBwpJpCnLFRi8+yaFF21qPrs4tD5jk
         74Ag==
X-Gm-Message-State: AOAM533Tgn9KZf26B8f/7/8iDr6IC11giMVRiVapCHlXVIcWzjFSi0d5
        MI5Z5RgZrU9mniCv7TI8Shg4AaISwG0=
X-Google-Smtp-Source: ABdhPJxzTL3IdFbbm6+0TTaDr7oPLF4vLTqSptszdew1gDT9LWxvyTybpypP4QAxKpHovRZbfSw0YQ==
X-Received: by 2002:a1f:16c3:: with SMTP id 186mr9559195vkw.16.1595622313925;
        Fri, 24 Jul 2020 13:25:13 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id t17sm214409vsp.0.2020.07.24.13.25.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 13:25:13 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id m18so2484681vkk.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:25:12 -0700 (PDT)
X-Received: by 2002:a1f:61c2:: with SMTP id v185mr9671569vkb.42.1595622312356;
 Fri, 24 Jul 2020 13:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200723230344.1422750-1-swboyd@chromium.org> <20200723230344.1422750-4-swboyd@chromium.org>
In-Reply-To: <20200723230344.1422750-4-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Jul 2020 13:25:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VsBkaMWSNFGimx3jFk==xsK+_NL-i1M0Dr_X9sc4EL9Q@mail.gmail.com>
Message-ID: <CAD=FV=VsBkaMWSNFGimx3jFk==xsK+_NL-i1M0Dr_X9sc4EL9Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: sx9310: Enable regulator for svdd supply
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

On Thu, Jul 23, 2020 at 4:03 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Enable the digital IO power supply (svdd) during probe so that the i2c
> communication works properly on boards that aggressively power gate this
> supply.
>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Daniel Campello <campello@chromium.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/iio/proximity/sx9310.c | 49 ++++++++++++++++++++++++++++------
>  1 file changed, 41 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index 84c3c9ae80dc..d21c17a4d541 100644
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
> @@ -131,6 +132,7 @@ struct sx9310_data {
>         struct i2c_client *client;
>         struct iio_trigger *trig;
>         struct regmap *regmap;
> +       struct regulator *supply;

Done need to store if you use devm.  See below.


>         /*
>          * Last reading of the proximity status for each channel.
>          * We only send an event to user space when this changes.
> @@ -914,21 +916,31 @@ static int sx9310_probe(struct i2c_client *client,
>         mutex_init(&data->mutex);
>         init_completion(&data->completion);
>
> +       data->supply = devm_regulator_get(&client->dev, "svdd");
> +       if (IS_ERR(data->supply))
> +               return PTR_ERR(data->supply);
> +
>         data->regmap = devm_regmap_init_i2c(client, &sx9310_regmap_config);
>         if (IS_ERR(data->regmap))
>                 return PTR_ERR(data->regmap);
>
> +       ret = regulator_enable(data->supply);
> +       if (ret)
> +               return ret;
> +       /* Must wait for Tpor time after initial power up */
> +       usleep_range(1000, 1100);

ret = devm_add_action_or_reset(&client->dev, sx9310_regulator_disable, supply);
if (ret)
  return ret;

static void sx9310_regulator_disable(void *regulator) {
  regulator_disable(regulator);
}

Then drop all changes below this line.


Seems like you could add support for the other regulator listed in the
bindings, too?


-Doug
