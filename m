Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D624BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFF9E20702
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l9MCLQ8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733164AbgF3Lyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 07:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbgF3Lyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 07:54:44 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2461C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 04:54:43 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id n23so22133116ljh.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 04:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Sw9nk0pUqlamMtDF/A1y1W0bhwmtGZsbc1p0vQcgjs=;
        b=l9MCLQ8/EyoUtHQcTzgha4HMSEo4rl5gnFrYir8oXjdQ1UOcZ7P/SkODxs7I2Zm84h
         24IEnFGrGm9FW2htI690colRruwLQlBdrmyQgWSqBUVsvleTMTohZ6u5Y8OxjjwT3gOk
         kFFPiVDYExmK26jY38bGZ99Mnps9Ry/VZV5yi6XzMp0zEXcoX5x91jf/WPJZCFRk7/xZ
         arXk3GuawDZwHGWQ0e1Pi47/fVHME7zlotgUt6G6CTzPoRIBkcr1pbXaOUVFmmRjA8hD
         dSTQtJyjS8UA8vZNgKF1yrC0Qx/l7wuXmrDFFlH6TSD2guGJHE0TQKH1yQlQA4P/QUYi
         ufIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Sw9nk0pUqlamMtDF/A1y1W0bhwmtGZsbc1p0vQcgjs=;
        b=H/fQgSmaNa9rkb+VBVXDfgP2e7QAgqGzNyGF8j8qxyHg2frME1TxUcy5sG41SZkOU6
         WfQNyO2v1p5UX5qzwqMGlu12ubcTfJbmVm5aGNSdJtHKQao5Yi0Z4n8euue7LbKAkCgM
         anp30t62i9QCMI6olIPfUReuAWGYC+I/qZJYpSJ11ytu1yXA+bdP2EKeBEvMT8jR8wQu
         OD+nCuvsVuD99R5GQu6zyklv9a96VX8SU9IXP6zspX8bQ/eMmF9g5ZspgiQrzKYeRthd
         O1Z8GKOIuhmaL7sIDIT+/Y/oJHPdNTwgQyojtkiDgYWUF0HjeeG+U83HH8etCLkotSK2
         85dg==
X-Gm-Message-State: AOAM532/vw0t5baPNkHya+ctTL5jZWLJRd6VbcBOVBbQ9K8pPhXzdVVE
        59tJv08jS4Cg7F1PQPeYjGrEALA52itMbufg/02QmdFr
X-Google-Smtp-Source: ABdhPJwTs4mvWBJ+e9mnmPdnvJPbF/6QaOOfkYPrrlhQ2cf8kvdH37euzAHpH6AHEF2WRxfLeTv6lnB6AtK+DCk5m30=
X-Received: by 2002:a2e:9d10:: with SMTP id t16mr10362739lji.46.1593518082232;
 Tue, 30 Jun 2020 04:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200625144509.17918-1-daniel.lezcano@linaro.org> <20200625144509.17918-2-daniel.lezcano@linaro.org>
In-Reply-To: <20200625144509.17918-2-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 30 Jun 2020 17:24:31 +0530
Message-ID: <CAP245DVMJ59nBSwpsW5CTm5hiCNBrtUSxE0qwg9=B9TYv9c26Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] thermal: core: Get thermal zone by id
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
> The next patch will introduce the generic netlink protocol to handle
> events, sampling and command from the thermal framework. In order to
> deal with the thermal zone, it uses its unique identifier to
> characterize it in the message. Passing an integer is more efficient
> than passing an entire string.
>
> This change provides a function returning back a thermal zone pointer
> corresponding to the identifier passed as parameter.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/thermal_core.c | 14 ++++++++++++++
>  drivers/thermal/thermal_core.h |  2 ++
>  2 files changed, 16 insertions(+)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index e2f8d2550ecd..58c95aeafb7f 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -662,6 +662,20 @@ int for_each_thermal_zone(int (*cb)(struct thermal_zone_device *, void *),
>         return ret;
>  }
>
> +struct thermal_zone_device *thermal_zone_get_by_id(int id)
> +{
> +       struct thermal_zone_device *tz = NULL;
> +
> +       mutex_lock(&thermal_list_lock);
> +       list_for_each_entry(tz, &thermal_tz_list, node) {
> +               if (tz->id == id)
> +                       break;
> +       }
> +       mutex_unlock(&thermal_list_lock);
> +
> +       return tz;
> +}
> +
>  void thermal_zone_device_unbind_exception(struct thermal_zone_device *tz,
>                                           const char *cdev_type, size_t size)
>  {
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index bb8f8aee79eb..7e8f45db6bbf 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -50,6 +50,8 @@ int for_each_thermal_cooling_device(int (*cb)(struct thermal_cooling_device *,
>  int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
>                               void *thermal_governor);
>
> +struct thermal_zone_device *thermal_zone_get_by_id(int id);
> +
>  struct thermal_attr {
>         struct device_attribute attr;
>         char name[THERMAL_NAME_LENGTH];
> --
> 2.17.1
>
