Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B2DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 04:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 313F0207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 04:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="ieZw2mYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgETEug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 00:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgETEug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 00:50:36 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BDCC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 21:50:35 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id e10so1055642vsp.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 21:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0tbXb80+Yh7B9nFEtfOBNTUNTV7zrMR7BziU+1EVuks=;
        b=ieZw2mYVxPGUlbMGmsKSDyXIuetO2Ee3KwdBkVCfJdW0WhP8FZb1ISRNsDfGSJPf4H
         cLI/9TyJktZdy21zfRpAJDZIAHqTkpg2Pl+yRFtsG6i7k+1ylzyb8cpXoyxzAFMOdr67
         bk9C5ntEWwCmqf5Q8Yjm30aenkNW5+iBSrOQ/ncL7T0dppuNhI8Igk+qtts3nR815zwb
         bpjJ/T0IiQ77tOaHpSYsgFZskxYM5iKzqi5M6aJn9Szm+lEycFQT/YmYytUSSSr1i0o1
         rk8X8puwnJxGbDHL6t0T+BiJJm3j3cKX10Y1NddXgGpJjjrQ/nCj0pU8CAzSmqaNiWhd
         qgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0tbXb80+Yh7B9nFEtfOBNTUNTV7zrMR7BziU+1EVuks=;
        b=ajKuqQ52pcqTUSLGGnbuPtklW0pPho5h9ZLmFGIAheefecwhItbOod3srRuAj0R0/v
         4caG9NHctGKF1L98DkTp9JQqBapCbjkNflWHT7pzqlEFrvflQ+1NoeXLOufaXhybNbhK
         KUYC0dPngzVR2DMuLUt5cb9BKzaBEQ+yCmzWoBhF3NFE48yUk2g4J3M08490ECSLBGtM
         kn+tITnQBmGpZNP9t++8kcyGg1wabMsOVtBDMkYAMcQe9FqoKyMqHeC1c8iM/TkXMBDK
         FD+V6YS6vr1BvKv9IROCakYsgyGGhSaWeohezGyLf9WyETs5Ocf8ob02cN8pJ45/Y1Qf
         SiuQ==
X-Gm-Message-State: AOAM532rMJGmD6VohIUcXjtOV3HV0UH42HOFylxmHJMluVZ/sD7HCfC+
        fq5EcdN6KyTecSxCDl0odqi81CAdymQnA5yAsBBFdA==
X-Google-Smtp-Source: ABdhPJwheLQGbQZyi1vcJVRylkuX2iWXhDKV8oHh618SQR2OfCNSrC7LEYrmInHyZKW6ZI0YvvywcgI5RKWxpElGx08=
X-Received: by 2002:a67:b42:: with SMTP id 63mr1965745vsl.182.1589950234641;
 Tue, 19 May 2020 21:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200504181616.175477-1-srinivas.pandruvada@linux.intel.com> <20200504181616.175477-6-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20200504181616.175477-6-srinivas.pandruvada@linux.intel.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 20 May 2020 10:19:52 +0530
Message-ID: <CAHLCerOvQYbgQDFkA9-pfx-VTZB7KckXeJeFH3sodTgohpMq0g@mail.gmail.com>
Subject: Re: [RFC][PATCH 5/5] thermal: int340x: Use new device interface
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 4, 2020 at 11:47 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Use the new framework to send notifications for:
> - Setting temperature threshold for notification to avoid polling
> - Send THERMAL_TRIP_REACHED event on reaching threshold
> - Send THERMAL_TRIP_UPDATE when firmware change the the existing trip
> temperature

I am a little confused here. I would've expected the thermal core to
send the THERMAL_TRIP_* notifications, not platform drivers. Why
shouldn't this be done in thermal core?

>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  .../intel/int340x_thermal/int3403_thermal.c   |  3 ++
>  .../int340x_thermal/int340x_thermal_zone.c    | 29 +++++++++++++++++++
>  .../int340x_thermal/int340x_thermal_zone.h    |  7 +++++
>  .../processor_thermal_device.c                |  1 +
>  4 files changed, 40 insertions(+)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> index f86cbb125e2f..77c014a113a4 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> @@ -63,15 +63,18 @@ static void int3403_notify(acpi_handle handle,
>
>         switch (event) {
>         case INT3403_PERF_CHANGED_EVENT:
> +               int340x_thermal_send_user_event(obj->int340x_zone, THERMAL_PERF_CHANGED, 0);
>                 break;
>         case INT3403_THERMAL_EVENT:
>                 int340x_thermal_zone_device_update(obj->int340x_zone,
>                                                    THERMAL_TRIP_VIOLATED);
> +               int340x_thermal_send_user_event(obj->int340x_zone, THERMAL_TRIP_REACHED, 0);
>                 break;
>         case INT3403_PERF_TRIP_POINT_CHANGED:
>                 int340x_thermal_read_trips(obj->int340x_zone);
>                 int340x_thermal_zone_device_update(obj->int340x_zone,
>                                                    THERMAL_TRIP_CHANGED);
> +               int340x_thermal_send_user_event(obj->int340x_zone, THERMAL_TRIP_UPDATE, 0);
>                 break;
>         default:
>                 dev_err(&priv->pdev->dev, "Unsupported event [0x%x]\n", event);
> diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> index 432213272f1e..9568a2db7afd 100644
> --- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> +++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> @@ -146,12 +146,41 @@ static int int340x_thermal_get_trip_hyst(struct thermal_zone_device *zone,
>         return 0;
>  }
>
> +static int int340x_thermal_get_thres_low(struct thermal_zone_device *zone, int *temp)
> +{
> +       struct int34x_thermal_zone *d = zone->devdata;
> +
> +       *temp = d->aux_trips[0];
> +
> +       return 0;
> +}
> +
> +static int int340x_thermal_set_thres_low(struct thermal_zone_device *zone, int temp)
> +{
> +       struct int34x_thermal_zone *d = zone->devdata;
> +       acpi_status status;
> +
> +       if (d->override_ops && d->override_ops->set_trip_temp)
> +               return d->override_ops->set_trip_temp(zone, 0, temp);
> +
> +       status = acpi_execute_simple_method(d->adev->handle, "PAT0",
> +                       millicelsius_to_deci_kelvin(temp));
> +       if (ACPI_FAILURE(status))
> +               return -EIO;
> +
> +       d->aux_trips[0] = temp;
> +
> +       return 0;
> +}
> +
>  static struct thermal_zone_device_ops int340x_thermal_zone_ops = {
>         .get_temp       = int340x_thermal_get_zone_temp,
>         .get_trip_temp  = int340x_thermal_get_trip_temp,
>         .get_trip_type  = int340x_thermal_get_trip_type,
>         .set_trip_temp  = int340x_thermal_set_trip_temp,
>         .get_trip_hyst =  int340x_thermal_get_trip_hyst,
> +       .set_temp_thres_low = int340x_thermal_set_thres_low,
> +       .get_temp_thres_low = int340x_thermal_get_thres_low,
>  };
>
>  static int int340x_thermal_get_trip_config(acpi_handle handle, char *name,
> diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
> index 3b4971df1b33..142027e4955f 100644
> --- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
> +++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
> @@ -58,4 +58,11 @@ static inline void int340x_thermal_zone_device_update(
>         thermal_zone_device_update(tzone->zone, event);
>  }
>
> +static inline void int340x_thermal_send_user_event(
> +                                       struct int34x_thermal_zone *tzone,
> +                                       enum thermal_device_events event,
> +                                       u64 data)
> +{
> +       thermal_dev_send_event(tzone->zone->id, event, data);
> +}
>  #endif
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> index 297db1d2d960..e25f01948d33 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> @@ -340,6 +340,7 @@ static void proc_thermal_notify(acpi_handle handle, u32 event, void *data)
>                 proc_thermal_read_ppcc(proc_priv);
>                 int340x_thermal_zone_device_update(proc_priv->int340x_zone,
>                                 THERMAL_DEVICE_POWER_CAPABILITY_CHANGED);
> +               int340x_thermal_send_user_event(proc_priv->int340x_zone, THERMAL_PERF_CHANGED, 0);
>                 break;
>         default:
>                 dev_dbg(proc_priv->dev, "Unsupported event [0x%x]\n", event);
> --
> 2.25.4
>
