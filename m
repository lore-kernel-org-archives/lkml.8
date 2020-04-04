Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF19DC2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 07:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51FF20709
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 07:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="k15y9aRJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgDDHao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 03:30:44 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33135 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgDDHao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 03:30:44 -0400
Received: by mail-vs1-f67.google.com with SMTP id y138so6505027vsy.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Apr 2020 00:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ugNVzQrfk7qCiHJC1N99XeNL9SBKdGiwiAoVFIrY3Yc=;
        b=k15y9aRJTJjDPr7xotBcgQatNpRvSmJQ8Uj5UI4hKEF0QaT8VoZmQVLj76v99g+lpu
         ePTHjPqnR/BXsO3z5aXz+VptCAQsjeExZKehxzX+8R5skZrYWoqmJOvPNJu8J3CwEWoz
         fi9dc/gM3JFg952P2ORRx3bKsF6fYAKm+aLh76BFdJa4YvhnnEwlcclZd7/le8TFVDYu
         +3ikxhmDFCLjxL5z4eQXxTgn3WlYf3UWYPwUJQX6RH5euSpFbAVsQy5OfBtPhZ3j2zjN
         lKv9o32dpM8tJuTVJarTVUztakFY+fJLaZMM4F6Ggo239E8vuBFpiVWswZbJExr4669e
         4X9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ugNVzQrfk7qCiHJC1N99XeNL9SBKdGiwiAoVFIrY3Yc=;
        b=CF6POysAmAxwBBES9X3s8v4gJMke4u7UMqkIUtMN8+zBRcVcZ07uEpp+Jz2+rTcg5r
         s9/RwyiBKtfsuxmgF9UzACQM47525UYE0tTPWVqNgrh6xQsCCKWGa5WcwDkzAyP/Lsyp
         K5yIhNRMiI1fm01G2AF3ViJlK+gbGzwCjv2G0aE0bU6bgOeSVR0mtatHtqozKjwNLupZ
         x/xt9LLzGso0nkYjAUPM4Dx7dTjN52oyuPSQm1ymEL3BFv/shIH+BISkKrqgfOK0cExN
         jh/pYR6yppUwKphQacPbyqHA6/ilbGIhLhZpeJsqdI4WSX4QiMee4Crt3u3DCSnRnx6q
         cKIg==
X-Gm-Message-State: AGi0PuZiW5+BkmrsCnGjm0MCuITyjegU15VBlX6TbKMM09zxNdtYhl7L
        SKekHwHmJSk0teaecnI6/GHhVPjVmmVs9bFrxXUWKw==
X-Google-Smtp-Source: APiQypJCP8LV0V83BxW/3jECfc4R8SBSmWpX3AJc5TznhrI977tcu93SFxMAOBCvDZjPYykYDSYAFdr2oCY7+PzKyWk=
X-Received: by 2002:a67:870f:: with SMTP id j15mr8906449vsd.95.1585985443047;
 Sat, 04 Apr 2020 00:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200402142747.8307-1-daniel.lezcano@linaro.org> <20200402142747.8307-4-daniel.lezcano@linaro.org>
In-Reply-To: <20200402142747.8307-4-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Sat, 4 Apr 2020 13:00:00 +0530
Message-ID: <CAHLCerPBT0mVqJpw9P+HSkdcKfq=prFDwWfaTy+2dPs3p+E3=Q@mail.gmail.com>
Subject: Re: [PATCH V2 4/9] thermal: Move trip point structure definition to
 private header
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 7:58 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The struct thermal_trip is only used by the thermal internals, it is
> pointless to export the definition in the global header.
>
> Move the structure to the thermal_core.h internal header.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/thermal_core.h | 13 +++++++++++++
>  include/linux/thermal.h        | 15 ---------------
>  2 files changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index f99551ce9838..d37de708c28a 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -58,6 +58,19 @@ int power_actor_get_min_power(struct thermal_cooling_device *cdev,
>                               struct thermal_zone_device *tz, u32 *min_power);
>  int power_actor_set_power(struct thermal_cooling_device *cdev,
>                           struct thermal_instance *ti, u32 power);
> +/**
> + * struct thermal_trip - representation of a point in temperature domain
> + * @np: pointer to struct device_node that this trip point was created from
> + * @temperature: temperature value in miliCelsius
> + * @hysteresis: relative hysteresis in miliCelsius
> + * @type: trip point type
> + */
> +struct thermal_trip {
> +       struct device_node *np;
> +       int temperature;
> +       int hysteresis;
> +       enum thermal_trip_type type;
> +};
>
>  /*
>   * This structure is used to describe the behavior of
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index e0279f7b43f4..7adbfe092281 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -332,21 +332,6 @@ struct thermal_zone_of_device_ops {
>         int (*set_trip_temp)(void *, int, int);
>  };
>
> -/**
> - * struct thermal_trip - representation of a point in temperature domain
> - * @np: pointer to struct device_node that this trip point was created from
> - * @temperature: temperature value in miliCelsius
> - * @hysteresis: relative hysteresis in miliCelsius
> - * @type: trip point type
> - */
> -
> -struct thermal_trip {
> -       struct device_node *np;
> -       int temperature;
> -       int hysteresis;
> -       enum thermal_trip_type type;
> -};
> -
>  /* Function declarations */
>  #ifdef CONFIG_THERMAL_OF
>  int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
> --
> 2.17.1
>
