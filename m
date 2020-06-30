Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4095C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9409D20672
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HI3FesMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733132AbgF3Lts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 07:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbgF3Lts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 07:49:48 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8225BC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 04:49:47 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id c21so11159189lfb.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 04:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VZpC6nbCXO1ra5ZAKfh1V8WJx3LQcUpeUjtWqZrQTJY=;
        b=HI3FesMzEP60A9KVz8X/nPnliCALDY1JHdf59Gquh7CVGP2Ii7zIbED9BmFeq1ObBM
         ZB/m4iTW490rxXg9JCoV/Nsv+cxNtjDbJWMoDDkWoRHgn29MADbHnzI5/BH9JO54QMc7
         OUwqC2YqW3003h/1ZO4mBWpXxiIjUxNdZ006uhpaiGnFNRtizsRTWWKIHnxglS3eHPV9
         Pq+vjnnrDvS9hByU14gnk7zQRcPFVMGUKCncjqb0nYy7KGLgBOM5BCU1keP0HGNkf0Jb
         2J70SU/6+/zBte9xeMpTY2fX2OBCXZbQ3Usm+E9O0uhSEj1sJpzaBPMNsXXq3gDWJlGN
         uCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VZpC6nbCXO1ra5ZAKfh1V8WJx3LQcUpeUjtWqZrQTJY=;
        b=EqwMIXM/LGkvVraBWOR/Z72TZF/lUQHtd4WpJMNimuq36fIaYhr/P2pUaiDKfRZ3CD
         Bbr/Hq7Q/1reBlphUztOWvW98Mja7CUw7YEA9ORbLBeVDb3Jd9RFNZ5YQY66w8rbuKKV
         sQS5yrho7/Pb4VTZwnlBkZiY92S8bWFbEegOyaIXe/fFeeMeUViEg3fDOaz2sKqXRSPx
         nSUFN1FHYk30fiA4VGzX9P0wyhMPC1toPIT5d6V/vPvzZVJ1PuozRXuGcGYhUnHi37B8
         OdP8rYj6C4qKRvXJKnCQpPt9FobsD9T4svNpK8qsk+fQQiZhebExCTwXE/aQt9l+WzP4
         lDZw==
X-Gm-Message-State: AOAM530SMofXGgM8CpobggabNvby9vysW1nrfVk5TZeEndnJ6Y5KXDpQ
        nIwCHnmu5VT5DPuHcKelyOB02uEwAnOjcMchF98MwQ==
X-Google-Smtp-Source: ABdhPJwM+lLh1l3lmcTjmuAkpKyb+545AYj/kmEGUX4kPwuJ0rdfb5p5+283QX+WGyIzIn0ltzInKc6541dEsZr9COA=
X-Received: by 2002:ac2:43aa:: with SMTP id t10mr11851203lfl.114.1593517785919;
 Tue, 30 Jun 2020 04:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200625144509.17918-1-daniel.lezcano@linaro.org> <20200625144509.17918-5-daniel.lezcano@linaro.org>
In-Reply-To: <20200625144509.17918-5-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 30 Jun 2020 17:19:34 +0530
Message-ID: <CAP245DVDMNisH1BavQuKwmxOefgG=Pw_RFBhyiecQ44g1gLZig@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] thermal: core: Add notifications call in the framework
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 8:15 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The generic netlink protocol is implemented but the different
> notification functions are not yet connected to the core code.
>
> These changes add the notification calls in the different
> corresponding places.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/thermal_core.c    | 21 +++++++++++++++++++++
>  drivers/thermal/thermal_helpers.c | 11 +++++++++--
>  drivers/thermal/thermal_sysfs.c   | 15 ++++++++++++++-
>  3 files changed, 44 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 58c95aeafb7f..1388c03d1190 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -215,6 +215,8 @@ int thermal_zone_device_set_policy(struct thermal_zone_device *tz,
>         mutex_unlock(&tz->lock);
>         mutex_unlock(&thermal_governor_lock);
>
> +       thermal_notify_tz_gov_change(tz->id, policy);
> +
>         return ret;
>  }
>
> @@ -406,12 +408,25 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
>  static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
>  {
>         enum thermal_trip_type type;
> +       int trip_temp, hyst = 0;
>
>         /* Ignore disabled trip points */
>         if (test_bit(trip, &tz->trips_disabled))
>                 return;
>
> +       tz->ops->get_trip_temp(tz, trip, &trip_temp);
>         tz->ops->get_trip_type(tz, trip, &type);
> +       if (tz->ops->get_trip_hyst)
> +               tz->ops->get_trip_hyst(tz, trip, &hyst);
> +
> +       if (tz->last_temperature != THERMAL_TEMP_INVALID) {
> +               if (tz->last_temperature < trip_temp &&
> +                   tz->temperature >= trip_temp)
> +                       thermal_notify_tz_trip_up(tz->id, trip);
> +               if (tz->last_temperature >= trip_temp &&
> +                   tz->temperature < (trip_temp - hyst))
> +                       thermal_notify_tz_trip_down(tz->id, trip);
> +       }
>
>         if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
>                 handle_critical_trips(tz, trip, type);
> @@ -443,6 +458,8 @@ static void update_temperature(struct thermal_zone_device *tz)
>         mutex_unlock(&tz->lock);
>
>         trace_thermal_temperature(tz);
> +
> +       thermal_genl_sampling_temp(tz->id, temp);

Does this need any rate limiting? How many times is update_temperature
called on a platform with a dozen sensors?

>  }
>
>  static void thermal_zone_device_init(struct thermal_zone_device *tz)
> @@ -1398,6 +1415,8 @@ thermal_zone_device_register(const char *type, int trips, int mask,
>         if (atomic_cmpxchg(&tz->need_update, 1, 0))
>                 thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>
> +       thermal_notify_tz_create(tz->id, tz->type);
> +
>         return tz;
>
>  unregister:
> @@ -1469,6 +1488,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>         ida_destroy(&tz->ida);
>         mutex_destroy(&tz->lock);
>         device_unregister(&tz->device);
> +
> +       thermal_notify_tz_delete(tz->id);
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
>
> diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
> index 6ed24b4e23d3..7893ace1d90f 100644
> --- a/drivers/thermal/thermal_helpers.c
> +++ b/drivers/thermal/thermal_helpers.c
> @@ -175,6 +175,14 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
>         mutex_unlock(&tz->lock);
>  }
>
> +void thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev, int target)
> +{
> +       if (cdev->ops->set_cur_state(cdev, target))
> +               return;
> +       thermal_notify_cdev_update(cdev->id, target);
> +       thermal_cooling_device_stats_update(cdev, target);
> +}
> +
>  void thermal_cdev_update(struct thermal_cooling_device *cdev)
>  {
>         struct thermal_instance *instance;
> @@ -192,8 +200,7 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
>                         target = instance->target;
>         }
>
> -       if (!cdev->ops->set_cur_state(cdev, target))
> -               thermal_cooling_device_stats_update(cdev, target);
> +       thermal_cdev_set_cur_state(cdev, target);
>
>         mutex_unlock(&cdev->lock);
>         trace_cdev_update(cdev, target);
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index aa99edb4dff7..ff449943f757 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -124,7 +124,8 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
>  {
>         struct thermal_zone_device *tz = to_thermal_zone(dev);
>         int trip, ret;
> -       int temperature;
> +       int temperature, hyst = 0;
> +       enum thermal_trip_type type;
>
>         if (!tz->ops->set_trip_temp)
>                 return -EPERM;
> @@ -139,6 +140,18 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
>         if (ret)
>                 return ret;
>
> +       if (tz->ops->get_trip_hyst) {
> +               ret = tz->ops->get_trip_hyst(tz, trip, &hyst);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       ret = tz->ops->get_trip_type(tz, trip, &type);
> +       if (ret)
> +               return ret;
> +
> +       thermal_notify_tz_trip_change(tz->id, trip, type, temperature, hyst);
> +
>         thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>
>         return count;
> --
> 2.17.1
>
