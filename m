Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B3CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A7ED20702
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="azIpapjS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733097AbgF3Lqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 07:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731944AbgF3Lqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 07:46:32 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9938C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 04:46:31 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q7so8832187ljm.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 04:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sFhX7QV1ZJHlGJSXvrR+TtCCSjWX8gXgJM2sQ/0NzMQ=;
        b=azIpapjSNCTUdv0mtHkly/y2XXN947eAPmIZuK8SfeXM1VHpZP9cHWZ5oGzUX0rlST
         sajoLuEIiLdBKscbgH5D7Sy15AY04RIhKOi6OJ+OBVk8ys2xViLzu0+KrkuoxzuYCPtb
         nQst/6BNoaMcf39ngth3XHDQmjUjU8CxZeO8Jc59KpXOmP6gaLejwMUajk+l8igKNirA
         GWXcX4L3LELlT8PWPYoOKAC7GIgnFJHi+LOBSG7a0ByQQgHA7ENhjrtbEYM+Mk/RD73S
         MslyP0qTOcy9o+M6bbj9ruF301TueNMmSihmEgvd+Phm+4VLaukfFXuqGjcxaX7DGrO3
         UHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sFhX7QV1ZJHlGJSXvrR+TtCCSjWX8gXgJM2sQ/0NzMQ=;
        b=ZGHz3D8PAY02HQvcZ+Jmqo5r/acbnMMOk9OqKv+7Exf1ZHSrBd6RA0wqAkS58eEI+y
         fMxR1E4x5FA1a/2F9T11moBgFWx26Cr0Z1a1JV8oU+oNitqY1q9hXq7EnETgQulcRYJ4
         4X8qRPlh/CXsSgdBAo4v7c5MmulEv60Pzn1IMGHiu3Ol7ghL0X5jRssa3Kg1pz+HNPir
         sEbZ+BKpwOUlcXvdTM0tP+Pm9RGMHGUgoLYUtNCLrAPsiwmcAsW2phxEsqV7mKweg+9c
         JT7aS51OaTrGWddEdOr4//l2DXRqZ8JExXV9mWPM2PsFPv8iZIueGZBHfYmpqJOgXkhD
         RpQA==
X-Gm-Message-State: AOAM533MV179aZ5g1XbtdxQfN5HzJ7GpImw+2/NdV4IRpOP8Jnr8ugZH
        AtNti36HIk7kgGH1FOgxrU8Y6e9yINPDF1m4+dnqCA==
X-Google-Smtp-Source: ABdhPJwznset+KDtI0yZGVRi0+xkPKFKcnVg5Ufvb7fhILr2kGyutkQzLR/OehI81NBp/Jz5b+IrlDSmHjljk0cyy0E=
X-Received: by 2002:a2e:8855:: with SMTP id z21mr5660314ljj.325.1593517590395;
 Tue, 30 Jun 2020 04:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200625144509.17918-1-daniel.lezcano@linaro.org>
In-Reply-To: <20200625144509.17918-1-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 30 Jun 2020 17:16:19 +0530
Message-ID: <CAP245DVy+Z9D+6=-cX4TaGFoK-e2N+mWwOvNYOe_E9Fh=7vnaA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] thermal: core: Add helpers to browse the cdev, tz
 and governor list
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
> The cdev, tz and governor list, as well as their respective locks are
> statically defined in the thermal_core.c file.
>
> In order to give a sane access to these list, like browsing all the
> thermal zones or all the cooling devices, let's define a set of
> helpers where we pass a callback as a parameter to be called for each
> thermal entity.
>
> We keep the self-encapsulation and ensure the locks are correctly
> taken when looking at the list.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/thermal_core.c | 51 ++++++++++++++++++++++++++++++++++

Is the idea to not use thermal_helpers.c from now on? It fits
perfectly with a patch I have to merge all its contents to
thermal_core.c :-)


>  drivers/thermal/thermal_core.h |  9 ++++++
>  2 files changed, 60 insertions(+)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 2a3f83265d8b..e2f8d2550ecd 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -611,6 +611,57 @@ void thermal_zone_device_rebind_exception(struct thermal_zone_device *tz,
>         mutex_unlock(&thermal_list_lock);
>  }
>
> +int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
> +                             void *data)


> +{
> +       struct thermal_governor *gov;
> +       int ret = 0;
> +
> +       mutex_lock(&thermal_governor_lock);
> +       list_for_each_entry(gov, &thermal_governor_list, governor_list) {
> +               ret = cb(gov, data);
> +               if (ret)
> +                       break;
> +       }
> +       mutex_unlock(&thermal_governor_lock);
> +
> +       return ret;
> +}
> +
> +int for_each_thermal_cooling_device(int (*cb)(struct thermal_cooling_device *,
> +                                             void *), void *data)
> +{
> +       struct thermal_cooling_device *cdev;
> +       int ret = 0;
> +
> +       mutex_lock(&thermal_list_lock);
> +       list_for_each_entry(cdev, &thermal_cdev_list, node) {
> +               ret = cb(cdev, data);
> +               if (ret)
> +                       break;
> +       }
> +       mutex_unlock(&thermal_list_lock);
> +
> +       return ret;
> +}
> +
> +int for_each_thermal_zone(int (*cb)(struct thermal_zone_device *, void *),
> +                         void *data)
> +{
> +       struct thermal_zone_device *tz;
> +       int ret = 0;
> +
> +       mutex_lock(&thermal_list_lock);
> +       list_for_each_entry(tz, &thermal_tz_list, node) {
> +               ret = cb(tz, data);
> +               if (ret)
> +                       break;
> +       }
> +       mutex_unlock(&thermal_list_lock);
> +
> +       return ret;
> +}
> +
>  void thermal_zone_device_unbind_exception(struct thermal_zone_device *tz,
>                                           const char *cdev_type, size_t size)
>  {
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index 4e271016b7a9..bb8f8aee79eb 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -41,6 +41,15 @@ extern struct thermal_governor *__governor_thermal_table_end[];
>              __governor < __governor_thermal_table_end; \
>              __governor++)
>
> +int for_each_thermal_zone(int (*cb)(struct thermal_zone_device *, void *),
> +                         void *);
> +
> +int for_each_thermal_cooling_device(int (*cb)(struct thermal_cooling_device *,
> +                                             void *), void *);
> +
> +int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
> +                             void *thermal_governor);
> +
>  struct thermal_attr {
>         struct device_attribute attr;
>         char name[THERMAL_NAME_LENGTH];
> --
> 2.17.1
>
